unit dhGraphicsAlgorithms;

interface

uses
  SysUtils, Classes, TypInfo,
{$IFDEF CLX}
  Qt, QGraphics,
{$ELSE}
  Windows, Messages, Graphics,
{$ENDIF}
  math,
  GR32,GR32_Transforms,gauss,GR32_Blend,GR32_LowLevel,dhBitmap32, dhStyles, dhColorUtils;

type TPixelCombineMode=(pcNormal,pcMult,pcNegMult);
type TTransFromProc=procedure (bmp:TdhBitmap32) of object;

procedure DoBlur(Src:TdhBitmap32; _Src:TdhBitmap32; Blur:TBlurEffect; inv:boolean);
procedure DoBlurPure(Src:TdhBitmap32; _Src:TdhBitmap32; Blur:TBlur; shift:integer; inv:boolean=false);

procedure NotTooBig(var L,R,L2,R2:integer; avail:integer; LDouble,RDouble:boolean);
procedure NotTooBig2(var Corner:TPoint; AvailX,AvailY:integer; IsDouble:boolean);

procedure RoundCorner(const OuterRect:TRect; Src,Dst:TdhBitmap32; HorzOuterRadius,VertOuterRadius,HorzBorderWidth,VertBorderWidth:integer; Align:TCornerAlign);
procedure LineSpec(Canvas:TCanvas; P1,P2:TPoint; Width,Length,Gap:Integer; ClosedInterval,Rectangular:boolean);

procedure MixAlpha(Src:TdhBitmap32);
procedure ExtractAlphaBitmap(P,P2:PColor32; Size:integer);
function TransFromBlackWhite(callback:TTransFromProc; w,h:integer):TdhBitmap32;

function Multiply32(Strech32:TdhBitmap32; NewWidth,NewHeight:integer):TdhBitmap32;
procedure GetRepeatings(var BPos:TPoint; var num_across,num_down:integer; W,H:integer; const brct:TRect; RepeatX,RepeatY:boolean);

implementation

function DoIntersectStrong(R1,R2:TRect):boolean;
begin
 IntersectRect(R1,R1,R2);
 Result:=not IsRectEmpty(R1);
end;

procedure Exch(var a,b:TPoint); overload;
var c:TPoint;
begin
 c:=a;
 a:=b;
 b:=c;
end;

procedure ExtractAlphaBitmap(P,P2:PColor32; Size:integer);
var i:integer;
begin
  for i := 0 to Size - 1 do
  begin
   P^:=ExtractAlphaColor(P^,P2^);
   Inc(P);
   Inc(P2);
  end;
end;

function TransFromBlackWhite(callback:TTransFromProc; w,h:integer):TdhBitmap32;
var Src2:TdhBitmap32;
begin
  result:=TdhBitmap32.Create;
  result.Width:=w;
  result.Height:=h;
  if not result.Empty then
  begin
  Src2:=TdhBitmap32.Create;
  Src2.SetSize(result.Width,result.Height);
  Src2.Clear(clWhite32);
  callback(Src2);
  result.Clear(clBlack32);
  callback(result);
  ExtractAlphaBitmap(result.PixelPtr[0, 0],Src2.PixelPtr[0, 0],result.Height*result.Width);
  Src2.Free;
  end;
  result.DrawMode:=dmBlend;
end;

procedure MixColor(Src:TdhBitmap32; Color:TColor32);
var P:PColor32;
    i:integer;
begin
 P:=Src.PixelPtr[0,0];
 for i := 0 to Src.Width*Src.Height - 1 do
 begin
  P^:=GetBlendMemEx(P^,Color,255);
  Inc(P);
 end;
end;

procedure ExtractTransparencyInverse(P,P2:PColor32; Size:integer);
var i:integer;
begin
 for i:=0 to Size-1 do
 begin
  P2^:=$FF - P^ shr 24;
  inc(P);
  inc(P2);
 end;
end;

procedure ExtractTransparency(P,P2:PColor32; Size:integer);
var i:integer;
begin
 for i:=0 to Size-1 do
 begin
  P2^:=P^ shr 24;
  inc(P);
  inc(P2);
 end;
end;

procedure MixAlpha(Src:TdhBitmap32);
var P:PColor32;
    i:integer;
    alpha,alpha_shifted:DWORD;
begin
 P:=Src.PixelPtr[0,0];
 alpha:=Src.MasterAlpha;
 alpha_shifted:=alpha*256*256*256 div 255+1;
 if alpha<>255 then
 for i := 0 to Src.Width*Src.Height - 1 do
 begin
  { P^:=(P^ and $00FFFFFF) or (P^ shr 24 * alpha div 255 shl 24);  //original version }
  P^:=(P^ and $00FFFFFF) or (P^ shr 24 * alpha_shifted and $FF000000); //speed-optimized version, but no division, so faster
  Inc(P);
 end;
 Src.MasterAlpha:=255;
end;

procedure DoBlurPure(Src:TdhBitmap32; _Src:TdhBitmap32; Blur:TBlur; shift:integer; inv:boolean=false);
var P,P2: PColor32;
    j,count:integer;
begin
 count:=Src.Width*Src.Height;

 P:=Src.PixelPtr[0, 0];
 P2:=_Src.PixelPtr[0, 0];
 for j := 0 to _Src.Height*_Src.Width - 1 do
 begin
  P2^:=(P^ shr shift) and $FF;
  inc(P2);
  inc(P);
 end;

 gauss.Blur(PDWORD(_Src.PixelPtr[0, 0]),_Src.Width,_Src.Height,Blur.GetDoubleRadius,Blur.Flood/100,inv);

 P:=Src.PixelPtr[0, 0];
 P2:=_Src.PixelPtr[0, 0];
 for j := 0 to _Src.Height*_Src.Width - 1 do
 begin
  P^:=(P^ and not ($FF shl shift)) or (P2^ shl shift);
  inc(P2);
  inc(P);
 end;
end;

procedure DoBlur(Src:TdhBitmap32; _Src:TdhBitmap32; Blur:TBlurEffect; inv:boolean);
var P,P2: PColor32;
    j,OffsX,OffsY{,Offs},count:integer;
    Alpha:double;
    a:DWORD;
    col:DWORD;
    y,dx,dy:integer;
    R1,R2:TRect;
begin
 Alpha := Blur.Degree * 3.14159265358979 / 180;
 offsX:=-Round(Cos(Alpha)*Blur.Distance);
 offsY:=--Round(Sin(Alpha)*Blur.Distance);

 count:=Src.Width*Src.Height;
 P:=Src.PixelPtr[0, 0];
 P2:=_Src.PixelPtr[0, 0];
 FillLongword(_Src.PixelPtr[0,0]^,count,0);

 R1:=Src.BoundsRect;
 R2:=R1;
 OffsetRect(R2,offsX,offsY);
 IntersectRect(R2,R1,R2);
 dx:=R2.Right-R2.Left;
 dy:=R2.Bottom-R2.Top;
 if (dx>0) and (dy>0) then
 begin
 p2:=_Src.PixelPtr[R2.Left,R2.Top];
 p:=Src.PixelPtr[Src.Width-R2.Right,Src.Height-R2.Bottom];
 for y:=0 to dy-1 do
 begin
  if inv then
   ExtractTransparencyInverse(p,p2,dx) else
   ExtractTransparency(p,p2,dx);
  inc(p,Src.Width);
  inc(p2,Src.Width);
 end;
 end;

 gauss.Blur(PDWORD(_Src.PixelPtr[0, 0]),_Src.Width,_Src.Height,Blur.GetDoubleRadius,Blur.Flood/100,inv);

 P:=Src.PixelPtr[0, 0];
 P2:=_Src.PixelPtr[0, 0];
 a:=(Blur.Alpha*(CSSColorToColor32(Blur.Color) shr 24)) div 255;
 col:=CSSColorToColor32(Blur.Color) and $FFFFFF;

 for j := 0 to _Src.Height*_Src.Width - 1 do
 begin
  P2^:=P2^ shl 24 or col;
  inc(P2);
  inc(P);
 end;
 _Src.MasterAlpha:=a;
 MixAlpha(_Src);

end;

function GetAngle(FX,FY:double):double;
begin
 result:=sqrt(sqr(FX)+sqr(FY));
 if result>0 then
  result:=arccos(FX/result);
end;

function GetEllipseParameterizedAngle(a,b,x,y:double):double;
begin
 result:=arccos(x/a);
end;

procedure GetNormal(alpha,a,b:double; var rx,ry:double);
var f_derived,g_derived,Sqrt_fg:double;
begin
 f_derived:=-a*sin(alpha);
 g_derived:= b*cos(alpha);
 Sqrt_fg:=Sqrt(Sqr(f_derived)+Sqr(g_derived));
 rx:=g_derived/Sqrt_fg;
 ry:=-f_derived/Sqrt_fg;
end;

procedure EllipsePoint(x,y:double; a,b:double; var rx,ry,ralpha:double);
var T:double;
    D,Sqr_a_b,ax,by,COS_t,SIN_t:double;
    i:integer;
begin

 if a=b then
 begin
  ralpha:=GetAngle(x,y);
  rx:=cos(ralpha)*a;
  ry:=sin(ralpha)*a;
  exit;
 end;

 if a=b then
  t:=2*pi/8 else
 if a<b then
  t:=1*pi/8 else
  t:=3*pi/8;

 Sqr_a_b:=(Sqr(a) - Sqr(b));
 ax:=a*x;
 by:=b*y;

 //Newton approximation
 for i:=1 to 20 do
 begin
 COS_t:=COS(t);
 SIN_t:=SIN(t);
 D:=
 (COS_t*(Sqr_a_b*SIN_t + by) - ax*SIN_t)/
 (2*Sqr_a_b*Sqr(COS_t) - ax*COS_t - by*SIN_t - Sqr_a_b);
 T:=T-d;
 if abs(D)<0.000001 then break;
 end;

 while t>2*pi do
  t:=t-2*pi;
 while t<0 do
  t:=t+2*pi;

  rx := a * cos ( t );
  ry := b * sin ( t );
  ralpha:=T;

end;

function arc_function(Sqr_a,Sqr_b,t:double):double ;
var Sqr_Sin:double;
begin
 Sqr_Sin:=Sqr(Sin(t));
 result:= Sqrt(Sqr_a*Sqr_Sin + Sqr_b*(1-Sqr_Sin));
end;

var old_t1,old_t1_x:double;
    old_result,old_result_x:double;
    first_arc_x:boolean;


function arclength(t1:double; a,b:integer; n:integer=0):double;
var j:integer;
    t0,ttt,re,Sqr_a,Sqr_b:double;
    UseOldVal:boolean;
begin
 if a=b then
 begin
  result:=t1*a;
  exit;
 end;
 if b=0 then
 begin
  result:=a - a * cos ( t1 );
  exit;
 end;
 if a=0 then
 begin
  result:=b * sin ( t1 );
  exit;
 end;

 //old_t1:=0;  //if no optimization
 UseOldVal:=false;
 if t1<old_t1 then
 begin
  //t0:=old_t1;
  t0:=t1;
  t1:=old_t1;
  UseOldVal:=true;
 end else
 if t1=old_t1 then
 begin
  result:=old_result;
  exit;
 end else
 begin
  t0:=0;
  ttt:=pi/2;
 end;

 if n=0 then
  n:=Round((a+b)*abs(t1-t0)/(pi/2)+0.5);
 Sqr_a:=Sqr(a);
 Sqr_b:=Sqr(b);
 result := 0;
 For j := 0 To n-1 do
 begin
    re:=arc_function(Sqr_a, Sqr_b, t0 + (t1 - t0)*(j/n));
    result := result + re;
 end;
 result := result * ((t1 - t0) / n);
 if UseOldVal then
 begin
  result:=-result+old_result;
  t1:=t0;
 end;
 old_t1:=t1;
 old_result:=result;
end;

function ScaledCol(Src:TdhBitmap32; X,Y,ScaleX,ScaleY:Double; const BorderClip:TRect):TColor32;
{$DEFINE ScaleColDouble}
var vonX,vonY,bisX,bisY:Double;
    iX,iY:integer;
    Col:TColor32;
var r1,g1,b1,a1,r,g,b,alpha:{$IFDEF ScaleColDouble}double{$ELSE}integer{$ENDIF};
    PixelPower:double;
    B2:TColor32;
    ivonX,ivonY,ibisX,ibisY:integer;
    begPartX,begPartY,endPartX,endPartY,actPartX,actPartY:double;
begin
 vonX:=X-ScaleX/2;
 bisX:=X+ScaleX/2;
 vonY:=Y-ScaleY/2;
 bisY:=Y+ScaleY/2;
 ivonX:=Floor(vonX);
 ivonY:=Floor(vonY);
 ibisX:=Floor(bisX);
 ibisY:=Floor(bisY);
 if not DoIntersectStrong(BorderClip,Rect(ivonX,ivonY,ibisX+1,ibisY+1)) then
 begin
  result:=0;
  exit;
 end;
 r:=0;
 g:=0;
 b:=0;
 alpha:=0;
 PixelPower:=256/(ScaleX*ScaleY);
 if ivonY=ibisY then
 begin
  begPartY:=bisY-vonY;
  endPartY:=0;
 end else
 begin
  begPartY:=(ivonY+1)-vonY;
  endPartY:=bisY-ibisY;
 end;
 if ivonX=ibisX then
 begin
  begPartX:=bisX-vonX;
  endPartX:=0;
 end else
 begin
  begPartX:=(ivonX+1)-vonX;
  endPartX:=bisX-ibisX;
 end;
 assert(begPartX<=1);
 assert(begPartY<=1);
 assert(endPartX<=1);
 assert(endPartY<=1);
 assert(begPartX>=0);
 assert(begPartY>=0);
 assert(endPartX>=0);
 assert(endPartY>=0);

 actPartY:=begPartY;
 for iY:=ivonY to ibisY do
 begin
 actPartX:=begPartX;
 for iX:=ivonX to ibisX do
 begin
 if PtInRect(BorderClip,Point(iX,iY)) then
  Col:=Src.PixelS[iX,iY] else
  Col:=0;

 a1:={$IFNDEF ScaleColDouble}Round{$ENDIF}((Col shr 24)*actPartX*actPartY*PixelPower);
 r1:=Col shr 16 and $FF;
 g1:=Col shr 8 and $FF;
 b1:=Col and $FF;

 r:=r+r1*a1;
 g:=g+g1*a1;
 b:=b+b1*a1;
 alpha:=alpha+a1;

 if iX<>ibisX-1 then
  actPartX:=1 else
  actPartX:=endPartX;
 end;
 if iY<>ibisY-1 then
  actPartY:=1 else
  actPartY:=endPartY;
 end;

{$IFDEF ScaleColDouble}
 if alpha=0 then
 begin
  result:=0;
  exit;
 end;
 r:=r/alpha;
 g:=g/alpha;
 b:=b/alpha;
 alpha:=alpha/(256*255);
 result:=round(r) shl 16 or round(g) shl 8 or round(b) or round(alpha*255) shl 24;

{$ELSE}

 r:=r shr 16;
 b:=b shr 16;
 g:=g shr 16;
 assert(r<=255);
 assert(g<=255);
 assert(b<=255);
 alpha:=min(alpha,256*256-1);
 assert(alpha<=256*256-1);
 B2:=r shl 16 or g shl 8 or b;
 Result:=GetOriginalRGB2(B2,alpha);
{$ENDIF}

end;

procedure Get_X_EQ_CY_PLUS_D(x,y,m,n:double; var c,d:double);
begin
 //x=cy+d and m=cn+d
 c:=(m-x)/(n-y);
 d:=x-c*y;
end;

procedure Line_Intersects_Ellipse(c,d,a,b:double; var rx,ry:double);
var p_halbe,q,nenner:double;
begin
 nenner:=Sqr(a/b)+Sqr(c);
 p_halbe:=c*d/nenner;
 q:=(Sqr(d)-Sqr(a))/nenner;
 ry:=-p_halbe+Sqrt(Sqr(p_halbe)-q); //pq-Formel
 rx:=c*ry+d;
end;

function Distance(a,b,x,y:double):double;
begin
 result:=Sqrt(Sqr(a-x)+Sqr(b-y));
end;

procedure RoundCorner(const OuterRect:TRect; Src,Dst:TdhBitmap32; HorzOuterRadius,VertOuterRadius,HorzBorderWidth,VertBorderWidth:integer; Align:TCornerAlign);
var HorzInnerRadius,VertInnerRadius,x,y:integer;
    alpha,betta,_alpha,alphaO,alphaI,perimeter,act_arc,beta,
    NormalX,NormalY,DistRound,DistOuter,DistInner,projX,projY,RoundOuterX,RoundOuterY,RoundInnerX,RoundInnerY,OuterX,OuterY,InnerX,InnerY,pct,pct2:double;
    P,RP,FinalPixel:TPoint;
    multPX,multPY:integer;
    NewCol,OldCol,NewCol2:TColor32;
    AlphaX,AlphaY,NewAlpha:integer;
    FirstQuarter:boolean;
    fx,fy,assimilate,ScaleX,ScaleY,einheit,assimilate1,assimilate2,_C,_D,w1,w2,w:double;
const AntiAliaseCorner=not false;

function Proj(x,y:integer):TPoint;
begin
 result:=Point(P.X+multPX*X,P.Y+multPY*Y);
end;

function RectFromPoints(P1,P2:TPoint):TRect;
begin
 result.Left:=min(P1.X,P2.X);
 result.Right:=max(P1.X,P2.X);
 result.Top:=min(P1.Y,P2.Y);
 result.Bottom:=max(P1.Y,P2.Y);
end;

var FirstQuarterClip,NonFirstQuarterClip,BorderClip,TryR:TRect;
    FirstQuarterRange,NonFirstQuarterRange:Double;
begin
 if (HorzOuterRadius=0) or (VertOuterRadius=0) then exit;

 case Align of
 calTopLeft:    P:=Point(OuterRect.Left+HorzOuterRadius-1,OuterRect.Top+VertOuterRadius-1);
 calTopRight:  P:=Point(OuterRect.Right-HorzOuterRadius ,OuterRect.Top+VertOuterRadius-1);
 calBottomRight: P:=Point(OuterRect.Right-HorzOuterRadius ,OuterRect.Bottom-VertOuterRadius);
 calBottomLeft:   P:=Point(OuterRect.Left+HorzOuterRadius-1,OuterRect.Bottom-VertOuterRadius);
 end;
 multPX:=1;
 multPY:=1;
 if Align in [calTopLeft,calBottomLeft] then multPX:=-1;
 if Align in [calTopLeft,calTopRight] then multPY:=-1;
 HorzInnerRadius:=HorzOuterRadius-VertBorderWidth;
 VertInnerRadius:=VertOuterRadius-HorzBorderWidth;
 HorzInnerRadius:=max(1,HorzInnerRadius);
 VertInnerRadius:=max(1,VertInnerRadius);
 FirstQuarterClip:=RectFromPoints(Proj(HorzInnerRadius,-1),Proj(HorzOuterRadius-1,VertOuterRadius-1));
 Inc(FirstQuarterClip.Bottom);{Bottom is exclusive, Top is inclusive}
 Inc(FirstQuarterClip.Right);{Right is exclusive, Left is inclusive}
 NonFirstQuarterClip:=RectFromPoints(Proj(-1,VertInnerRadius),Proj(HorzOuterRadius-1,VertOuterRadius-1));
 Inc(NonFirstQuarterClip.Bottom);
 Inc(NonFirstQuarterClip.Right);
 HorzBorderWidth:=VertOuterRadius-VertInnerRadius;
 VertBorderWidth:=HorzOuterRadius-HorzInnerRadius;

 old_t1:=0; old_result:=0;
 perimeter:=arclength(pi/2,HorzInnerRadius,VertInnerRadius);
 old_t1_x:=old_t1; old_result_x:=old_result;


  FirstQuarterRange:=VertInnerRadius-0.5;
  NonFirstQuarterRange:=HorzInnerRadius-0.5;
  if AntiAliaseCorner then
  if (VertBorderWidth<>0) and (HorzBorderWidth<>0) then
  begin

  ScaleY:=HorzBorderWidth/VertBorderWidth;
  ScaleX:=1;
  for x:=0 to VertBorderWidth-1 do
  begin
   projX:=HorzInnerRadius-ScaleX/2;
   projY:=VertInnerRadius+x*ScaleY+ScaleY/2;
   NewCol:=ScaledCol(Src,P.X+multPX*(projX-0.5)+0.5,P.Y+multPY*(projY-0.5)+0.5,ScaleX,ScaleY,NonFirstQuarterClip);
   Src.PixelS[P.X+multPX*(HorzInnerRadius+x),P.Y+multPY*(VertInnerRadius)]:=NewCol;
  end;
  FirstQuarterRange:=VertInnerRadius-0.5+1;//perimeter/(HorzInnerRadius+VertInnerRadius);

  end;

  if (HorzBorderWidth=0) and (VertBorderWidth<>0) then
   beta:=1 else
  if (VertBorderWidth=0) and (HorzBorderWidth<>0) then
   beta:=0 else
   beta:=(FirstQuarterRange/(NonFirstQuarterRange+FirstQuarterRange));

 alphaO:=0;
 alphaI:=0;

 y:=VertOuterRadius-1;
 while y>={-2}0 do
 begin
  RP.Y:=P.Y+multPY*Y;
  FY:=y+0.5;
  Dec(y);
  x:=0;
  //decrease VertInnerRadius/HorzInnerRadius by one to include semi-transparent pixels
  if VertInnerRadius-1>FY then
  begin
   FX:=Sqrt(Sqr(HorzInnerRadius-1)-Sqr(FY)*Sqr(HorzInnerRadius-1)/Sqr(VertInnerRadius-1));//Get X for given Y
   x:=Max(0,Trunc(FX-0.5));
  end;
  old_t1:=old_t1_x; old_result:=old_result_x; first_arc_x:=true;
 while x<=HorzOuterRadius-1 do
 begin
  RP.X:=P.X+multPX*X;
  FX:=x+0.5;
  Inc(x);

  EllipsePoint(FX,FY,HorzInnerRadius,VertInnerRadius,RoundInnerX,RoundInnerY,alphaI);

  Get_X_EQ_CY_PLUS_D(FX,FY,RoundInnerX,RoundInnerY,_C,_D);
  Line_Intersects_Ellipse(_C,_D,HorzOuterRadius,VertOuterRadius,RoundOuterX,RoundOuterY);
  alphaO:=GetEllipseParameterizedAngle(HorzOuterRadius,VertOuterRadius,RoundOuterX,RoundOuterY);

  act_arc:=arclength(alphaI,HorzInnerRadius,VertInnerRadius);

  if first_arc_x then
  begin
   old_t1_x:=old_t1; old_result_x:=old_result; first_arc_x:=false;
  end;
  alpha:=act_arc/perimeter;

  FirstQuarter:=alpha<beta;

  DistOuter:=Distance(RoundOuterX,RoundOuterY,FX,FY);
  DistInner:=Distance(RoundInnerX,RoundInnerY,FX,FY);
  DistRound:=Distance(RoundOuterX,RoundOuterY,RoundInnerX,RoundInnerY);


  if (DistRound=0) or FirstQuarter and (HorzInnerRadius=HorzOuterRadius) or not FirstQuarter and (VertInnerRadius=VertOuterRadius) then
  begin
   if (FX>RoundOuterX) or (FY>RoundOuterY) then
    DistOuter:=-DistOuter;
   pct:=0;
   pct2:=0;
   DistRound:=0;
   w:=1;
  end else
  begin
   pct:=  DistOuter/DistRound;
   pct2:= DistInner/DistRound;
   if (pct2>=1) and (pct2>=pct) then
   begin
    pct:=-pct;
   end else
   if (pct>1) and (pct>=pct2) then
   begin
    pct2:=-pct2;
   end;

   betta:=GetEllipseParameterizedAngle(HorzInnerRadius,VertInnerRadius, RoundInnerX,RoundInnerY);
   GetNormal(betta,HorzInnerRadius,VertInnerRadius,NormalX,NormalY);
   w1:=GetAngle(NormalX,NormalY);

   betta:=GetEllipseParameterizedAngle(HorzOuterRadius,VertOuterRadius, RoundOuterX,RoundOuterY);
   GetNormal(betta,HorzOuterRadius,VertOuterRadius,NormalX,NormalY);
   w2:=GetAngle(NormalX,NormalY);

   w:=(w1-w2);
   w:=DistRound/(DistRound*cos(w));
  end;

  if FirstQuarter then
  begin
   _alpha:=alpha/beta;
   OuterX:=HorzOuterRadius;
   InnerX:=HorzInnerRadius;
   InnerY:=FirstQuarterRange*_alpha;
   OuterY:=InnerY;
  end else
  begin
   _alpha:=(1-alpha)/(1-beta);
   OuterY:=VertOuterRadius;
   InnerY:=VertInnerRadius;
   InnerX:=NonFirstQuarterRange*_alpha;
   OuterX:=InnerX;
  end;
   ScaleX:=1;
   ScaleY:=1;
   if DistRound=0  then
   begin
    if FirstQuarter then
    begin
     projX:=OuterX-DistOuter;
     projY:=OuterY;
    end else
    begin
     projY:=OuterY-DistOuter;
     projX:=OuterX;
    end;
   end else
   begin
    projX:=OuterX+(InnerX-OuterX)*pct;
    projY:=OuterY+(InnerY-OuterY)*pct;

    if FirstQuarter then
    begin
     if VertBorderWidth<>0 then
      ScaleX:=(VertBorderWidth*w)/DistRound;
    end else
    begin
     if HorzBorderWidth<>0 then
      ScaleY:=HorzBorderWidth*w/DistRound;
    end;
   end;

 if DistRound=0 then
  NewCol:=0 else
 begin
 if FirstQuarter then
  BorderClip:=FirstQuarterClip else
  BorderClip:=NonFirstQuarterClip;
 if AntiAliaseCorner then
 begin
   NewCol:=ScaledCol(Src,P.X+multPX*(projX-0.5)+0.5,P.Y+multPY*(projY-0.5)+0.5,ScaleX,ScaleY,BorderClip);
 end else
 begin
  FinalPixel:=Point(Round(P.X+multPX*(projX-0.5)),Round(P.Y+multPY*(projY-0.5)));
  if PtInRect(BorderClip,FinalPixel) then
   NewCol:=Src.PixelS[FinalPixel.X,FinalPixel.Y] else
   NewCol:=0;
 end;
 end;
  if AntiAliaseCorner then
  begin
   if FirstQuarter and (projX<HorzInnerRadius-ScaleX/2) or not FirstQuarter and (projY<VertInnerRadius-ScaleY/2) then
   begin
    assert(NewCol shr 24=0);
    continue;
   end;
  end else
  begin
   if FirstQuarter and (projX<HorzInnerRadius) or not FirstQuarter and (projY<VertInnerRadius) then
   begin
    assert(NewCol shr 24=0);
    continue;
   end;
  end;

  if FirstQuarter and (projX>HorzOuterRadius+ScaleX/2) or not FirstQuarter and (projY>VertOuterRadius+ScaleY/2) then
  begin
   assert(NewCol shr 24=0);
   for x:=x-1 to HorzOuterRadius-1 do
   begin
    Dst.PixelS[RP.X,RP.Y]:=0;
    Inc(RP.X,multPX);
   end;
   break;
  end;

 if AntiAliaseCorner  then
 if FirstQuarter and (projX<HorzInnerRadius+ScaleX/2) or not FirstQuarter and (projY<VertInnerRadius+ScaleY/2) then
 begin
   NewCol2:=NewCol;
   OldCol:=Dst.PixelS[RP.X,RP.Y];
   if FirstQuarter then
    NewAlpha:=max(min(round(((HorzInnerRadius-projX)/ScaleX+0.5)*255),255),0) else
    NewAlpha:=max(min(round(((VertInnerRadius-projY)/ScaleY+0.5)*255),255),0);
   if NewAlpha=255 then
    NewCol:=OldCol else
    NewCol:=CombineReg(NewCol and $FFFFFF or min(round((NewCol shr 24)/((255-NewAlpha)/255)),255) shl 24,OldCol,255-NewAlpha);
 end;
 Dst.PixelS[RP.X,RP.Y]:=NewCol;
 end;
 end;

end;

procedure NotTooBig(var L,R,L2,R2:integer; avail:integer; LDouble,RDouble:boolean);
var sL,sR:integer;
    done:boolean;
begin
 if L+R>avail then
 begin
  sL:=L;
  sR:=R;
  done:=false;
  if L>R then
  begin
   L:=avail-R;
   if L>=R then done:=true;
  end else
  begin
   R:=avail-L;
   if R>=L then done:=true;
  end;
  if not done then
  begin
   L:=avail div 2;
   R:=avail-L;
  end;
  if not LDouble then
   Inc(L2,L-sL);
  if not RDouble then
   Inc(R2,R-sR);
 end;
end;

procedure NotTooBig2(var Corner:TPoint; AvailX,AvailY:integer; IsDouble:boolean);
begin
 if Corner.X>AvailX then
 begin
  if not IsDouble then
   Corner.Y:=max(0,Corner.Y-(Corner.X-AvailX));
  Corner.X:=AvailX;
 end;
 if Corner.Y>AvailY then
 begin
  if not IsDouble then
   Corner.X:=max(0,Corner.X-(Corner.Y-AvailY));
  Corner.Y:=AvailY;
 end;
end;

function ExchP(a:TPoint):TPoint; overload;
begin
 result.X:=a.Y;
 result.Y:=a.X;
end;

procedure LineSpec(Canvas:TCanvas; P1,P2:TPoint; Width,Length,Gap:Integer; ClosedInterval,Rectangular:boolean);
var i,Dist,Count,Incr:integer;
    Rct:TRect;
    Vertical:boolean;
begin
 Vertical:=P1.X=P2.X;
 if Vertical then
 begin
  P1:=ExchP(P1);
  P2:=ExchP(P2);
 end;
 Dist:=Round(Sqrt(Sqr(P1.X-P2.X)+Sqr(P1.Y-P2.Y)));
 Count:=(Dist-(Length)) div (Length+Gap);
 if (P1.X>P2.X) then
  Exch(P1,P2);
 if Count<>0 then
 for i:=0 to Count do
 if (i<>0) and (i<>Count) or ClosedInterval then
 begin
  if i=0 then //handles case Count=0 in particular
   Incr:=0 else
   Incr:=(Dist-Length)*i div Count;
  Rct:=Rect(P1.X+Incr,P1.Y-Width div 2,P1.X+Incr+Length+1,P1.Y-Width div 2+Width+1);
  if Vertical then
  begin
   Rct.TopLeft:=ExchP(Rct.TopLeft);
   Rct.BottomRight:=ExchP(Rct.BottomRight);
  end;
  if Rectangular then
   Canvas.Rectangle(Rct) else
   Canvas.Ellipse  (Rct);
 end;
end;

function integral(rel_pos,abs_pos,W:integer): integer;
begin
 if rel_pos>abs_pos then
  result:=rel_pos-((rel_pos-abs_pos+W-1) div W) * W else
  result:=rel_pos-((rel_pos-abs_pos    ) div W) * W;
end;

procedure GetRepeatings(var BPos:TPoint; var num_across,num_down:integer; W,H:integer; const brct:TRect; RepeatX,RepeatY:boolean);
begin
 if RepeatX then
 begin
  BPos.X:=integral(BPos.X,brct.Left,W);
  num_across := ((brct.Right-BPos.X-1) div W) + 1;
 end else
  num_across:=1;
 if RepeatY then
 begin
  BPos.Y:=integral(BPos.Y,brct.Top,H);
  num_down := ((brct.Bottom-BPos.Y) div H) + 1;
 end else
  num_down:=1;
end;

function Multiply32(Strech32:TdhBitmap32; NewWidth,NewHeight:integer):TdhBitmap32;
var w,h,x,y:integer;
    OldDrawMode:TDrawMode;
begin
 OldDrawMode:=Strech32.DrawMode;
 Strech32.DrawMode:=dmOpaque;
 w:=Strech32.Width;
 h:=Strech32.Height;
 Result:=TdhBitmap32.Create;
 Result.DrawMode:=dmOpaque;
 Result.Width:=NewWidth;
 Result.Height:=NewHeight;
 Strech32.DrawTo(Result);
 x:=w;
 y:=h;
 h:=min(h,Result.Height);
 w:=Result.Width;
 while x<Result.Width do
 begin
  Result.DrawTo(Result,Rect(x,0,2*x,h),Rect(0,0,x,h));
  x:=x*2;
 end;
 while y<Result.Height do
 begin
  Result.DrawTo(Result,Rect(0,y,w,2*y),Rect(0,0,w,y));
  y:=y*2;
 end;
 Strech32.DrawMode:=OldDrawMode;
 Result.DrawMode:=OldDrawMode;
end;


end.
