unit MyBitmap32;

interface

{$I GR32.inc}

uses
{$IFDEF CLX}
  Qt, Types,
  {$IFDEF LINUX}Libc,{$ENDIF}
  {$IFDEF MSWINDOWS}Windows,{$ENDIF}
{$ELSE}
  Windows,
{$ENDIF}
  Classes, SysUtils,
{$IFDEF CLX}
  QControls, QGraphics, QConsts
{$ELSE}
  Messages, Controls, Graphics
{$ENDIF},
 Gr32, Gr32_Transforms{$IFDEF COMPILER2009}, GR32_Resamplers{$ENDIF};


type
  TMyAffineTransformation = class(TAffineTransformation)
  protected
{$IFDEF COMPILER2009}
    procedure PrepareTransform; override;
{$ENDIF}
  public
    function GetTransformedBoundsF: TFloatRect; overload;
    function GetTransformedBoundsF(const ASrcRect: TFloatRect): TFloatRect; overload;
  end;

  TMyBitmap32 = class (TBitmap32)
  protected
    procedure TextBlueToAlpha(const B: TBitmap32; const Color: TColor32); {$IFDEF USEINLINING} inline; {$ENDIF}

    function  GET_FDS256(X, Y: Integer): TColor32; //better variant to GET_TS256
    function  GetPixelFDS(X, Y: Double): TColor32;

    procedure TextScaleDownExtended(const B, B2: TBitmap32;
      const Color: TColor32; AlignTo:integer=0); {$IFDEF USEINLINING} inline; {$ENDIF}

  public

{$IFDEF CLX}
    procedure Changed; override;
    property BitmapHandle: HBITMAP read FHandle;
{$ENDIF}

    property  PixelFDS[X, Y: Double]: TColor32 read GetPixelFDS;

    procedure TextoutW(X, Y: Integer; const Text: Widestring; LetterSpacing:Integer; WordSpacing:Integer); overload;
    procedure RenderTextExtended(X, Y: Integer; const Text: Widestring; AALevel: Integer; Color: TColor32; const SzOri:TPoint; XPadding:integer); overload;
    procedure RenderTextExtended(X, Y: Integer; const Text: Widestring; AALevel: Integer; Color: TColor32; const SzOri:TPoint; XPadding:integer; LetterSpacing:Integer; WordSpacing:Integer); overload;


  end;


procedure SetRealDst(const ref:TRect); {$IFDEF USEINLINING} inline; {$ENDIF}

implementation

uses
  GR32_Blend, GR32_LowLevel, GR32_Filters, Math, TypInfo,
  GR32_System,
{$IFDEF CLX}
  QClipbrd,
{$ELSE}
  Clipbrd,
{$ENDIF}
  GR32_DrawingEx;
  
var
  StockBitmap: TBitmap;

procedure TMyBitmap32.RenderTextExtended(X, Y: Integer; const Text: Widestring; AALevel: Integer; Color: TColor32; const SzOri:TPoint; XPadding:integer; LetterSpacing:Integer; WordSpacing:Integer);
var
  B, B2: TMyBitmap32;
  Sz: TSize;
  Alpha: TColor32;
  StockCanvas: TCanvas;
  PaddedText: Widestring;
  I:Integer;
{  tm_big:Textmetric;
  }
begin
  if Empty then Exit;

  Alpha := Color shr 24;
  Color := Color and $00FFFFFF;
  AALevel := Constrain(AALevel, 0, 4);
  PaddedText := Text{ + ' '};

  { TODO : Optimize Clipping here }
  B := TMyBitmap32.Create;
  try
    if AALevel = 0 then
    begin
      B.SetSize(SzOri.x+XPadding, SzOri.y);
      B.Font := Font;
      B.Clear(0);
      B.Font.Color := clWhite;
      B.TextoutW(0, 0, Text, LetterSpacing, WordSpacing);
      TextBlueToAlpha(B, Color);
    end
    else
    begin
      StockCanvas := StockBitmap.Canvas;
      StockCanvas.Lock;
      try
        StockCanvas.Font := Font;
        StockCanvas.Font.Size := Font.Size shl AALevel;
        WordSpacing:=WordSpacing shl AALevel;
        LetterSpacing:=LetterSpacing shl AALevel;
{$IFDEF CLX}
        Sz := StockCanvas.TextExtent(PaddedText);
{$ELSE}
        Windows.GetTextExtentPoint32W(StockCanvas.Handle, PWideChar(PaddedText),
          Length(PaddedText), Sz);
        Inc(Sz.cx,LetterSpacing*Length(PaddedText));
        if WordSpacing<>0 then
        for I := 1 to Length(PaddedText) do
        if PaddedText[I]=' ' then
         Inc(Sz.cx,WordSpacing);
{$ENDIF}
        if SzOri.X<>0 then
         inc(Sz.cx,Round(XPadding*(Sz.cx/SzOri.X)));
        //GetTextMetrics(StockCanvas.Handle,tm_big);
        B2 := TMyBitmap32.Create;
        try
          B2.SetSize(Sz.Cx, Sz.Cy);
          B2.Clear(0);
          B2.Font := StockCanvas.Font;
          B2.Font.Color := clWhite;
          B2.TextoutW(0, 0, Text, LetterSpacing, WordSpacing);
          B2.StretchFilter := sfLinear;
          B.SetSize(SzOri.x+XPadding, SzOri.y);
          TextScaleDownExtended(B, B2, Color{, tm_big.tmAscent});
        finally
          B2.Free;
        end;
      finally
        StockCanvas.Unlock;
      end;
    end;

    B.DrawMode := dmBlend;
    B.MasterAlpha := Alpha;
    B.CombineMode := CombineMode;

    B.DrawTo(Self, X, Y);
  finally
    B.Free;
  end;
end;

procedure TMyBitmap32.RenderTextExtended(X, Y: Integer; const Text: Widestring; AALevel: Integer; Color: TColor32; const SzOri:TPoint; XPadding:Integer);
begin
 RenderTextExtended(X,Y,Text,AALevel,Color,SzOri,XPadding,0,0);
end;

procedure TMyBitmap32.TextScaleDownExtended(const B, B2: TBitmap32;
  const Color: TColor32; AlignTo:integer);

(*
To describe this procedure, we call the area of B2 given by Bounds(prevX,prevY,X,Y)
to one pixel of B given by Point(I,J) a "cell".
This cell has exact sizes (B2.Width/B.Width) X (B2.Height/B.Height),
included by the integer rectangle Bounds(prevX,prevY,X,Y).
The difficulty is to slit the hull pixels of a cell to the adjacent cells.
In TextScaleDown, it was easy because there was nothing to split, a cell
had an exact integer width and height, with an exact integer offset within B2.
A cell has following form (note that in TextScaleDown only the C area would exist):

AAAAAAAAAA
BCCCCCCCCD
BCCCCCCCCD
BCCCCCCCCD
BCCCCCCCCD
EFFFFFFFFG


The areas are calculated as following:
A=_HorzSum[I]
B=VertSum
D=VertSumNew
E+F+G=HorzSumNew
E=VertHorzSum
G=VertHorzSumNew
A+B+C+D+E+F+G=S

Note that VertSumNew will be used to calculate the cell below the current cell, but
because we go from top to bottom only in the outer for-loop,
we have to save this value in an array in the mean time (this is sad but better as to recalculate it)

This procedure seems to be 10% slower than original TextScaleDown
*)


var
  I, J, X, Y, P, PP, Q: Integer;
  Src: PColor32;
  Dst: PColor32;
  ScaleX,ScaleY:Double;
  prevY,prevX,B2Width,ForRangeX:Integer;
  NX,NNX,NY,NNY,DeltaY,DeltaX,Rarefaction,S,S1,S2:DWORD;
  HorzSumNew,HorzSum,VertSumNew,VertSum,VertHorzSumNew,VertHorzSum,VertHorzSumHelper:DWORD;
  AlignToOri:double;
var _HorzSum:array of integer;

const Denominator=(1 shl 16); //to avoid floating point operations, we model
                              //the "scaling difference" (the ratio) between e.g. B2.Width and B.Width
                              //as a natural number devided by this constant
      DeltaRange=(1 shl 8); //this constant is the accuracy by which
                            //one pixel of B2 can be distributed to adjacent cells
                            //Log2(DeltaRange)>=3 yields good results, but better if >=8.
                            //if >=9 results in better results i dont know.
                            //all values seem to take the same CPU speed
      DenominatorToDelta=Denominator div DeltaRange;
begin
  //Assert(Denominator>=DeltaRange);

  SetLength(_HorzSum,B.Width);
  Dst := B.PixelPtr[0, 0];
  ScaleX:=B2.Width/B.Width;
  ScaleY:=B2.Height/B.Height;
  AlignToOri:=AlignTo/ScaleY;

  //ScaleY:=ScaleY*AlignToOri/Floor(AlignToOri);

  NX:=Round(ScaleX*Denominator);
  NY:=Round(ScaleY*Denominator);
  Rarefaction:=Ceil(ScaleX*ScaleY*DeltaRange);
  B2Width:=B2.Width;

  NNY:=0;
  prevY:=-1;
  //HorzSum[]:=0;

//  NNY:=Round((Frac(AlignToOri))*NY);

  for J := 0 to B.Height - 1 do
  begin

    Inc(NNY,NY);
    Y := NNY div Denominator; //Note that these are no real division, they are optimized in shift operations (even if "Optimization" is no checked in the options)
    DeltaY:=NNY div DenominatorToDelta mod DeltaRange;
    if J=B.Height-1 then
    begin
     //following two lines adjust the integer approximation inaccuracy for the last bottom horizontal line
     Y:=B2.Height;
     DeltaY:=0;
    end;


    NNX:=0;
    prevX:=-1;
    VertSum:=0;
    VertHorzSum:=0;
    VertHorzSumHelper:=0;

    for I := 0 to B.Width - 1 do
    begin

      Inc(NNX,NX);
      X := NNX div Denominator;
      DeltaX:=NNX div DenominatorToDelta mod DeltaRange;
      if I=B.Width-1 then
      begin
       //following two lines adjust the integer approximation inaccuracy for the right vertical line
       X:=B2Width;
       DeltaX:=0;
      end;

      S1 := 0;
      S2 := 0;
      ForRangeX:=(X-1)-(prevX+1)+1;
      Src := B2.PixelPtr[prevX+1, prevY+1];
      for Q := prevY+1 to Y-1 do
      begin
        //Note that Src = B2.PixelPtr[prevX+1, Q] holds
        for P := 1 to ForRangeX {prevX+1 to X-1} do
        begin
          Inc(S1,DWORD(Src^ and $000000FF));
          Inc(Src);
        end;
        if X<B2Width then //we could cancel this line, but the following read pixel could be B2.Pixels[B2.Width,B2.Height-1] which is an access violation
         S2 := S2 + DWORD(Src^ and $000000FF);
        Inc(Src,B2Width-ForRangeX);
      end;
      S1:=S1;
      VertSumNew:=S2*DeltaX;
      S := VertSum+S1*DeltaRange+VertSumNew;
      VertSum:=S2*DeltaRange-VertSumNew;;


      if Y<B2.Height then
      begin
        S1:=0;
        S2:=0;

        //Note that Src = B2.PixelPtr[prevX+1, Y] holds
        for P := 1 to ForRangeX {prevX+1 to X-1} do
        begin
          S1 := S1 + DWORD(Src^ and $000000FF);
          Inc(Src);
        end;
        if X<B2Width then //we could cancel this line, no access violation would be caused because we are not in the bottom line
         S2 := DWORD(Src^ and $000000FF);

        VertHorzSumNew:=((DeltaX*DeltaY) div DeltaRange)*S2; //again, this "div" is just a shift operation
        HorzSumNew:=VertHorzSum+S1*DeltaY+VertHorzSumNew;
        Inc(S,HorzSumNew);
        if J>0 then
         Inc(S,_HorzSum[I]);
        _HorzSum[I]:=(VertHorzSumHelper+S1*DeltaRange+S2*DeltaX)-HorzSumNew;
        VertHorzSum:=S2*DeltaY-VertHorzSumNew;
        VertHorzSumHelper:=S2*(DeltaRange-DeltaX);
      end;

      S:=S div Rarefaction; //this is the only real division!
      if S>255 then //should be possible only if Log2(DeltaRange)<8
       S := 255;
      //S:=GAMMA_TABLE[S];
      Dst^ := TColor32(S shl 24) or Color;
      Inc(Dst);
      prevX:=X;
    end;
    prevY:=Y;
  end;
end;

function TMyBitmap32.GetPixelFDS(X, Y: Double): TColor32;
begin
  Result := GET_FDS256(Round(X * 256), Round(Y * 256));
  EMMS;
end;

procedure TMyBitmap32.TextoutW(X, Y: Integer; const Text: Widestring; LetterSpacing:Integer; WordSpacing:Integer);
{$IFDEF CLX}
var
  R: TRect;
{$ENDIF}
var
  Fit: Integer;
  Sz:TSize;
  P: array of integer;
  I:Integer;
begin
  UpdateFont;
{$IFDEF CLX}
  TextoutW(X,Y,Text); // not supported for CLX
{$ELSE}

  if (Text<>'') and ((LetterSpacing<>0) or (WordSpacing<>0)) then
  begin
    SetLength(P,length(Text));
    GetTextExtentExPointW(Handle, PWideChar(Text),Length(Text), High(SmallInt), @Fit, PInteger(P), Sz);
    for I:=Length(Text)-1 downto 1 do
     P[I]:=P[I]-P[I-1];
    for I:=0 to Length(Text)-1 do
    begin
     P[I]:=P[I]+LetterSpacing;
     if Text[I+1]=' ' then
      P[I]:=P[I]+WordSpacing;
    end;
  end;

  If Clipping then
    ExtTextoutW(Handle, X, Y, ETO_CLIPPED, @ClipRect, PWideChar(Text), Length(Text), PInteger(P))
  else
    ExtTextoutW(Handle, X, Y, 0, nil, PWideChar(Text), Length(Text), PInteger(P));
{$ENDIF}
  Changed;
end;


{$IFDEF CLX}
procedure TMyBitmap32.Changed;
begin
 if not FPixmapChanged then //not called by CanvasChanged, e.g. bei a Canvas operation
  FPixmapActive:=False;
 Inherited;
end;
{$ENDIF}

procedure TMyBitmap32.TextBlueToAlpha(const B: TBitmap32; const Color: TColor32);
var
  I: Integer;
  P: PColor32;
  C: TColor32;
begin
  // convert blue channel to alpha and fill the color
  P := @B.Bits[0];
  for I := 0 to B.Width * B.Height - 1 do
  begin
    C := P^;
    if C <> 0 then
    begin
      C := P^ shl 24; // transfer blue channel to alpha
      C := C + Color;
      P^ := C;
    end;
    Inc(P);
  end;
end;

function TMyBitmap32.GET_FDS256(X, Y: Integer): TColor32;
var
    flrx, flry, celx, cely: Longword;
    C1, C2, C3, C4: TColor32;
begin
  if (X > 0) and (Y > 0) and (X < (Width - 1) shl 8) and (Y < (Height - 1) shl 8) then
    Result := GET_T256(X,Y)
  else
    //Result := FOuterColor;
    begin//°!°
      celx := X and $FF xor 255;
      cely := Y and $FF xor 255;
      X:=SAR_8(X);
      Y:=SAR_8(Y);

      // handle edge in fail-safe mode...
      C1 := PixelS[X, Y];
      C2 := PixelS[X + 1, Y];
      C3 := PixelS[X, Y + 1];
      C4 := PixelS[X + 1, Y + 1];

      Result := CombineReg(CombineReg(C1, C2, celx), CombineReg(C3, C4, celx), cely);
    end;
end;


function TMyAffineTransformation.GetTransformedBoundsF: TFloatRect;
begin
  Result := GetTransformedBoundsF(SrcRect);
end;

function TMyAffineTransformation.GetTransformedBoundsF(const ASrcRect: TFloatRect): TFloatRect;
var
  V1, V2, V3, V4: TVector3f;
begin
{$IFDEF COMPILER2009}
  Result := GetTransformedBounds(ASrcRect);
{$ELSE}
  V1[0] := ASrcRect.Left;  V1[1] := ASrcRect.Top;    V1[2] := 1;
  V2[0] := ASrcRect.Right; V2[1] := V1[1];           V2[2] := 1;
  V3[0] := V1[0];          V3[1] := ASrcRect.Bottom; V3[2] := 1;
  V4[0] := V2[0];          V4[1] := V3[1];           V4[2] := 1;
  V1 := VectorTransform(Matrix, V1);
  V2 := VectorTransform(Matrix, V2);
  V3 := VectorTransform(Matrix, V3);
  V4 := VectorTransform(Matrix, V4);
  Result.Left   := Min(Min(V1[0], V2[0]), Min(V3[0], V4[0]));
  Result.Right  := Max(Max(V1[0], V2[0]), Max(V3[0], V4[0]));
  Result.Top    := Min(Min(V1[1], V2[1]), Min(V3[1], V4[1]));
  Result.Bottom := Max(Max(V1[1], V2[1]), Max(V3[1], V4[1]));
{$ENDIF}
end;


{$IFDEF COMPILER2009}
procedure TMyAffineTransformation.PrepareTransform;
begin
  FInverseMatrix := Matrix;
  GR32_Transforms.Invert(FInverseMatrix);

  FInverseMatrix[2,0] := FInverseMatrix[2,0] + (FInverseMatrix[0,0] + FInverseMatrix[1,0])/2 - 0.5;
  FInverseMatrix[2,1] := FInverseMatrix[2,1] + (FInverseMatrix[0,1] + FInverseMatrix[1,1])/2 - 0.5;

  // calculate a fixed point (65536) factors
  FInverseFixedMatrix := FixedMatrix(FInverseMatrix);
  FFixedMatrix := FixedMatrix(Matrix);

  TransformValid := True;
end;
{$ENDIF}

procedure SetRealDst(const ref:TRect); {$IFDEF USEINLINING} inline; {$ENDIF}
begin
  RealDst:=ref;
end;

initialization
  StockBitmap := TBitmap.Create;
  StockBitmap.Width := 8;
  StockBitmap.Height := 8;

finalization
  StockBitmap.Free;

end.