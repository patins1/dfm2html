unit dhColorUtils;

interface

uses
  SysUtils, Classes,
{$IFDEF CLX}
  QGraphics,
{$ELSE}
  Graphics,
{$ENDIF}
  math,
  GR32,GR32_Blend,GR32_LowLevel,dhStrUtils,dhStyles;

function IdentToColor(const Ident: TColorName; var Color: Longint): Boolean;
function ColorToIntString(Color: TCSSColor): TColorName;
function ColorToString(Color: TCSSColor): TColorName; overload;
function ColorToString(Color: Longint): TColorName; overload;
function CSSColorToColor(const Color:TCSSColor):TColor;
function ColorToCSSColor(const Color:TColor):TCSSColor;
function CSSColorToColor32(const Color:TCSSColor):TColor32;
function Color32ToCSSColor(const Color:TColor32):TCSSColor;
function IsOpaqueColor(Color:TCSSColor): boolean;
Function ApplyDark(Color:TColor; HowMuch:Byte):TColor;
Function AddRGB(Color:TColor32; HowMuch:integer):TColor32;
procedure ListColorValues(Proc: TGetStrProc);

function GetPixelCombineNormal(F: TColor32; B: TColor32; M: TColor32=255):TColor32;
function GetOriginalRGB(Black:TColor32; alpha:Cardinal):TColor32;
function ColorNegMult(C1, C2: TColor32; M:TColor32=255): TColor32;
function ColorMult(C1, C2: TColor32; M:TColor32=255): TColor32;
function GetBlendMemEx(F: TColor32; B: TColor32; M: TColor32):TColor32;
function ExtractAlphaColor(Black,White:TColor32):TColor32;

implementation

const
  cl3DFace = clBtnFace;
  cl3DHighlight=clBtnHighlight;
  cl3DShadow=clBtnShadow;

var
  TrueColors: array[0..17] of TIdentMapEntry = (
    (Value: Integer(colInherit); Name: scolInherit),
    (Value: Integer(colTransparent); Name: scolTransparent),
    (Value: clBlack; Name: 'Black'),
    (Value: clMaroon; Name: 'Maroon'),
    (Value: clGreen; Name: 'Green'),
    (Value: clOlive; Name: 'Olive'),
    (Value: clNavy; Name: 'Navy'),
    (Value: clPurple; Name: 'Purple'),
    (Value: clTeal; Name: 'Teal'),
    (Value: clGray; Name: 'Gray'),
    (Value: clSilver ; Name: 'Silver'),
    (Value: clRed; Name: 'Red'),
    (Value: clLime; Name: 'Lime'),
    (Value: clYellow; Name: 'Yellow'),
    (Value: clBlue; Name: 'Blue'),
    (Value: clFuchsia; Name: 'Fuchsia'),
    (Value: clAqua; Name: 'Aqua'),
    (Value: clWhite; Name: 'White'));

  Colors: array[0..43] of TIdentMapEntry = (
    (Value: Integer(colInherit); Name: scolInherit),
    (Value: Integer(colTransparent); Name: scolTransparent),
    (Value: clBlack; Name: 'Black'),
    (Value: clMaroon; Name: 'Maroon'),
    (Value: clGreen; Name: 'Green'),
    (Value: clOlive; Name: 'Olive'),
    (Value: clNavy; Name: 'Navy'),
    (Value: clPurple; Name: 'Purple'),
    (Value: clTeal; Name: 'Teal'),
    (Value: clGray; Name: 'Gray'),
    (Value: clSilver; Name: 'Silver'),
    (Value: clRed; Name: 'Red'),
    (Value: clLime; Name: 'Lime'),
    (Value: clYellow; Name: 'Yellow'),
    (Value: clBlue; Name: 'Blue'),
    (Value: clFuchsia; Name: 'Fuchsia'),
    (Value: clAqua; Name: 'Aqua'),
    (Value: clWhite; Name: 'White'),

    (Value: clActiveBorder; Name: 'ActiveBorder'),
    (Value: clActiveCaption; Name: 'ActiveCaption'),
    (Value: clAppWorkSpace; Name: 'AppWorkSpace'),
    (Value: clBackground; Name: 'Background'),
    (Value: clBtnFace; Name: 'ButtonFace'),
    (Value: clBtnHighlight; Name: 'ButtonHighlight'),
//    (Value: clBtnShadow; Name: 'ButtonShadow'),    {}
    (Value: clBtnText; Name: 'ButtonText'),
    (Value: clCaptionText; Name: 'CaptionText'),
    (Value: clGrayText; Name: 'GrayText'),
    (Value: clHighlight; Name: 'Highlight'),
    (Value: clHighlightText; Name: 'HighlightText'),
    (Value: clInactiveBorder; Name: 'InactiveBorder'),
    (Value: clInactiveCaption; Name: 'InactiveCaption'),
//    (Value: clInactiveCaptionText; Name: 'InactiveCaptionText'),     {}
    (Value: clInfoBk; Name: 'InfoBackground'),
    (Value: clInfoText; Name: 'InfoText'),
    (Value: clMenu; Name: 'Menu'),
    (Value: clMenuText; Name: 'MenuText'),

    (Value: clScrollBar; Name: 'ScrollBar'),
    (Value: cl3DDkShadow; Name: 'ThreeDDarkShadow'),
    (Value: cl3DFace; Name: 'ThreeDFace'),
    (Value: cl3DHighlight; Name: 'ThreeDHighlight'),
    (Value: cl3DLight; Name: 'ThreeDLightShadow'),   {}
    (Value: cl3DShadow; Name: 'ThreeDShadow'),

    (Value: clWindow; Name: 'Window'),
    (Value: clWindowFrame; Name: 'WindowFrame'),
    (Value: clWindowText; Name: 'WindowText')
    {,
    (Value: clNone; Name: 'inherit')});

function ColorToIdent(Color: Longint; var Ident: TColorName): Boolean;
begin
  Result := IntToIdent(Color, Ident, TrueColors);
end;

function IdentToColor(const Ident: TColorName; var Color: Longint): Boolean;
begin
  Result := IdentToInt(Ident, Color, Colors);
end;

function ColorToIntString(Color: TCSSColor): TColorName;
var Col:TColor32;
    salpha:TColorName;
    SaveSeparator:AChar;
begin
  Col:=CSSColorToColor32(Color);
  if IsOpaqueColor(Color) then
   Result:='#'+inttohex(RedComponent(Col),2)+inttohex(GreenComponent(Col),2)+inttohex(BlueComponent(Col),2) else
  {$IFDEF VER240}with FormatSettings do{$ENDIF}
  begin
   SaveSeparator := DecimalSeparator;
   DecimalSeparator := '.';
   try
    salpha:=FloatToStrF(AlphaComponent(Col)/255,ffFixed,10,3);
   finally
    DecimalSeparator := SaveSeparator;
   end;
   Result:='rgba('+inttostr(RedComponent(Col))+','+inttostr(GreenComponent(Col))+','+inttostr(BlueComponent(Col))+','+salpha+')';
  end;
end;

function ColorToString(Color: TCSSColor): TColorName;
begin
  if not dhColorUtils.ColorToIdent(Longint(Color), Result) then
   Result:=ColorToIntString(Color);
end;

function ColorToString(Color: Longint): TColorName;
begin
  if not dhColorUtils.ColorToIdent(Color, Result) then
   Result:=ColorToIntString(TColor32(Color));
end;

function ColorToColor32(Color:TColor):TColor32;
begin
 result:=ColorSwap(ColorToRGB(Color)) or $FF000000;
end;

function ColorToCSSColor(const Color:TColor):TCSSColor;
begin
 result:=ColorToRGB(Color) or ($FF000000 xor CSSAlphaInverter);
end;

function CSSColorToColor(const Color:TCSSColor):TColor;
begin
 result:=Color and $FFFFFF;
end;

function CSSColorToColor32(const Color:TCSSColor):TColor32;
begin
 result:=(ColorSwap(Color and $FFFFFF) and $FFFFFF) or ((Color xor CSSAlphaInverter) and $FF000000);
end;

function Color32ToCSSColor(const Color:TColor32):TCSSColor;
begin
 result:=(ColorSwap(Color and $FFFFFF) and $FFFFFF) or ((Color xor CSSAlphaInverter) and $FF000000);
end;

function IsOpaqueColor(Color:TCSSColor): boolean;
begin
 Result:=(Color xor CSSAlphaInverter) and $FF000000 = $FF000000;
end;

function GetPixelCombineNormal(F: TColor32; B: TColor32; M: TColor32=255):TColor32;
begin
  result:=CombineReg(F or $FF000000,B,F shr 24 * (M+1) shr 8);
end;

Function ApplyDark(Color:TColor; HowMuch:Byte):TColor;
Var r,g,b:Byte;

function GetRValue(rgb: Cardinal): Byte;
begin
  Result := Byte(rgb);
end;

function GetGValue(rgb: Cardinal): Byte;
begin
  Result := Byte(rgb shr 8);
end;

function GetBValue(rgb: Cardinal): Byte;
begin
  Result := Byte(rgb shr 16);
end;

function RGB(r, g, b: Byte): Cardinal;
begin
  Result := (r or (g shl 8) or (b shl 16));
end;

Begin
	Color:=ColorToRGB(Color);
	r:=GetRValue(Color);
	g:=GetGValue(Color);
	b:=GetBValue(Color);
	if r>HowMuch then r:=r-HowMuch else r:=0;
	if g>HowMuch then g:=g-HowMuch else g:=0;
	if b>HowMuch then b:=b-HowMuch else b:=0;
	result:=RGB(r,g,b);
End;

procedure ListColorValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Low(dhColorUtils.Colors)+1 to High(dhColorUtils.Colors) do Proc(dhColorUtils.Colors[I].Name);
end;

function In255(i:integer):integer;
begin
 if i>255 then
  result:=255 else
 if i<0 then
  result:=0 else
  result:=i;
end;

Function AddRGB(Color:TColor32; HowMuch:integer):TColor32;
Begin
	result:=Color32(In255(RedComponent(Color)+HowMuch),In255(GreenComponent(Color)+HowMuch),In255(BlueComponent(Color)+HowMuch));
End;

function GetBlendMemEx(F: TColor32; B: TColor32; M: TColor32):TColor32;
begin
 BlendMemEx(F,B,M);
 result:=B;
end;

function ColorNegMult(C1, C2: TColor32; M:TColor32=255): TColor32;
var
  r1, g1, b1: Cardinal;
  r2, g2, b2, r,g,b: Cardinal;
begin
  M := M * (C1 shr 24);

  r1 := C1 and $00FF0000 shr 16;
  g1 := C1 and $0000FF00 shr 8;
  b1 := C1 and $000000FF;

  r2 := C2 and $00FF0000 shr 16;
  g2 := C2 and $0000FF00 shr 8;
  b2 := C2 and $000000FF;

  r:=M * r1 * (255 - r2) shr 24 + r2;
  g:=M * g1 * (255 - g2) shr 24 + g2;
  b:=M * b1 * (255 - b2) shr 24 + b2;

  Result := r shl 16 + g shl 8 + b;
end;

function ColorMult(C1, C2: TColor32; M:TColor32=255): TColor32;
var
  r1, g1, b1: Cardinal;
  r2, g2, b2, r,g,b: Cardinal;
begin
  M := M * (C1 shr 24);

  r1 := C1 and $00FF0000 shr 16;
  g1 := C1 and $0000FF00 shr 8;
  b1 := C1 and $000000FF;

  r2 := C2 and $00FF0000 shr 16;
  g2 := C2 and $0000FF00 shr 8;
  b2 := C2 and $000000FF;

  r:=M * (r1 * r2 - r2 shl 8) shr 24 + r2;
  g:=M * (g1 * g2 - g2 shl 8) shr 24 + g2;
  b:=M * (b1 * b2 - b2 shl 8) shr 24 + b2;

  Result := r shl 16 + g shl 8 + b;
end;

//Note that the real alpha value is "alpha/255/255", but this is no integer
//"alpha/255/255/255" would be the value between 0 and 1
function GetOriginalRGB(Black:TColor32; alpha:Cardinal):TColor32;
var r,g,b,ai:Cardinal;
const augm=255;
begin
      if alpha=0 then //is color completely transparent?
      begin
       result:=0; //if yes, we dont need (and cant) calc rgb values
      end else
      begin
       //otherwise reconstruct rgb values
       ai:=((augm+1) shl 16) div alpha;
       r:=Cardinal((Black and $FF)*ai) shr 8;
       g:=Cardinal((Black shr 8 and $FF)*ai) shr 8;
       b:=Cardinal((Black shr 16 and $FF)*ai) shr 8;
       result:=(r and $0000FF) or (g shl 8 and $00FF00) or (b shl 16 and $FF0000) or ((alpha{ div augm} shr 8) shl 24  and $FF000000);
      end;
end;

function ExtractAlphaColor(Black,White:TColor32):TColor32;
var alpha:Cardinal;
    red_alpha,green_alpha,blue_alpha:integer;
    r,g,b:Cardinal;
begin
       red_alpha:=$FF + (Black and $FF) - (White and $FF);
       green_alpha:=$FF + (Black shr 8 and $FF) - (White shr 8 and $FF);
       blue_alpha:=$FF + (Black shr 16 and $FF) - (White shr 16 and $FF);
       if not(red_alpha<=255) or not(green_alpha<=255) or not(blue_alpha<=255) then
       begin
        result:=White;
        exit;
       end;
       if (red_alpha=0) or (green_alpha=0) or (blue_alpha=0) then
       begin
        result:=0;
       end else
       begin
        alpha:=(red_alpha+green_alpha+blue_alpha) div 3;
        r:=(Black and $FF)*255 div Cardinal(red_alpha);
        g:=(Black shr 8 and $FF)*255 div Cardinal(green_alpha);
        b:=(Black shr 16 and $FF)*255 div Cardinal(blue_alpha);
        result:=r or (g shl 8) or (b shl 16) or (alpha shl 24);
       end;
end;

function _CombineReg(X, Y, W: TColor32): TColor32;
var r1,r2,g1,g2,b1,b2,a1,a2,r,g,b,alpha:integer;
begin
 if W=0 then
 begin
  result:=Y;
  exit;
 end;
 if W=$FF then
 begin
  result:=X;
  exit;
 end;
 if X=Y then
 begin
  result:=Y;
  exit;
 end;

 a1:=X shr 24*(W+1);
 a2:=Y shr 24*(255-W+1);
 r1:=X shr 16 and $FF;
 r2:=Y shr 16 and $FF;
 g1:=X shr 8 and $FF;
 g2:=Y shr 8 and $FF;
 b1:=X and $FF;
 b2:=Y and $FF;

 r:=(r1*a1+r2*a2) shr 16;
 g:=(g1*a1+g2*a2) shr 16;
 b:=(b1*a1+b2*a2) shr 16;
 alpha:=(a1+a2);
 assert(r<=255);
 assert(g<=255);
 assert(b<=255);
 assert(alpha<=256*256-1);
 B2:=r shl 16 or g shl 8 or b;
 Result:=GetOriginalRGB(B2,alpha);
end;

var iColor:Integer;
initialization

 CombineReg:=_CombineReg;

 for iColor := 2 to High(Colors) do Colors[iColor].Value:=Integer(ColorToCSSColor(Colors[iColor].Value));
 for iColor := 2 to High(TrueColors) do TrueColors[iColor].Value:=Integer(ColorToCSSColor(TrueColors[iColor].Value));
 RegisterIntegerConsts(TypeInfo(TCSSColor), dhColorUtils.IdentToColor, dhColorUtils.ColorToIdent);

finalization

end.
