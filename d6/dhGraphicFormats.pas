unit dhGraphicFormats;

interface

{$I GR32.inc}

uses
  SysUtils, Classes, TypInfo,
  pngimage, {$IFDEF MSWINDOWS}ShellAPI,jpeg,{$ELSE}libc,{$ENDIF}
{$IFDEF CLX}
  GIFImage,QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls,
  QComCtrls, QStdCtrls, QTypes,
{$ELSE}
 {$IFDEF VER210}GIFImg{$ELSE}GIFImage{$ENDIF},Controls, Forms, Windows, Messages, Graphics, Dialogs, ExtCtrls, appevnts{Application.OnIdle:= überschreiben mit eigenem code},
  ComCtrls, CommCtrl, StdCtrls, clipbrd,
{$ENDIF}
  math{$IFDEF DEB},funcutils,jclDebug{$ENDIF},
  GR32,GR32_Transforms,gauss,GR32_Blend,GR32_LowLevel,BinList,dhBitmap32,dhStrUtils,WideStrUtils;

{$IFDEF VER210}
type TPatchedGIFRenderer=class(TGIFRenderer)
  public
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
end;
type TGIFRenderer32=class(TPatchedGIFRenderer)
  public
    constructor Create(AImage: TGIFImage); override;
    procedure StartAnimation; override;
end;
type TPatchedGifImage=class(TGifImage)
  strict protected
    function CreateRenderer: TCustomGIFRenderer; override;
end;
{$ENDIF}

function GetAs32(Graphic:TGraphic):TdhBitmap32;
procedure SaveGraphic(g:TGraphic; const FileName: TPathName);
function GetGifImageFromBitmap32(Transparent:TBitmap32; Opaque:TBitmap32):TGifImage;
{$IFNDEF CLX}
function GetPNGObjectPTFromGif(gif:TGIFImage):TPngImage;
function GetPNGObjectPTFromGifAndBitmap32(Transparent:TdhBitmap32; gif:TGIFImage):TPngImage;
function GetJPEGImageFromBitmap32(Src:TdhBitmap32):TJPEGImage;
{$ENDIF}
function GetPNGObjectFromBitmap32(Src:TBitmap32):TGraphic;
function GetBitmap32FromPNGObject(png:TPngImage):TdhBitmap32;
function GetNewGif:TGifImage;
procedure CloseGif(GIF:TGifImage);
function AddGIFSubImageFromBitmap32(Transparent:TBitmap32; Opaque:TBitmap32; GIF:TGIFImage; Loop:boolean=false; CopyFrom:TGIFFrame=nil; PrevSubImage:TGIFFrame=nil):TGIFFrame;
procedure SaveBmp32(Transparent,Opaque:TdhBitmap32; const FileName: TPathName);
function GetGraphicExtension(Graphic:TGraphic):TPathName;
function HasSemiTransparence(graphic: TGraphic):boolean;

{set by the HTML generator}
var
    ForcedGIFRenderer:TGIFRenderer32=nil; {if assigned, then this GIF renderer shall be used for the corresponding GIF image}

implementation

function GetGraphicExtension(Graphic:TGraphic):TPathName;
begin
 result:=EmptyStr;
 if Graphic is TPngImage then
 begin
  result:='.png';
 end else
 if Graphic is TGifImage then
 begin
  result:='.gif';
 end else
{$IFNDEF CLX}
 if Graphic is TJPEGImage then
 begin
  result:='.jpg';
 end else
 if Graphic is TBitmap then
 begin
  result:='.bmp';
 end else
 if Graphic is TIcon then
 begin
  result:='.ico';
 end;
{$ENDIF}
end;

procedure SaveBmp32(Transparent,Opaque:TdhBitmap32; const FileName: TPathName);
var ext:TPathName;
    g:TGraphic;
begin
 g:=nil;
 try
 ext:=lowercase(ExtractFileExt(Filename));
 if ext='.png' then
  g:=GetPNGObjectFromBitmap32(Transparent) else
 if ext='.gif' then
  g:=GetGifImageFromBitmap32(Transparent,Opaque) else
{$IFNDEF CLX}
 if (ext='.jpg') or (ext='.jpeg') then
  g:=GetJPEGImageFromBitmap32(Opaque) else
{$ENDIF}
 begin
  g:=TBitmap.Create;
  g.Assign(Opaque);
 end;
 ForceDirectories(ExtractFilePath(FileName));
 g.SaveToFile(FileName);
 finally
  FreeAndNil(g);
 end;
end;

procedure SaveGraphic(g:TGraphic; const FileName: TPathName);
var ext:TPathName;
    bmp:TdhBitmap32;
begin
 ext:=lowercase(ExtractFileExt(Filename));
 if GetGraphicExtension(g)=ext then
  g.SaveToFile(FileName) else
 begin
  bmp:=GetAs32(g);
  try
   SaveBmp32(bmp,bmp,FileName);
  finally
   bmp.Free;
  end;
 end;
end;

function GetGifImageFromBitmap32(Transparent:TBitmap32; Opaque:TBitmap32):TGifImage;
begin
  result:=GetNewGif;
  AddGIFSubImageFromBitmap32(Transparent,Opaque,result);
  CloseGif(result);
end;

type TFakeChunkPLTE=class(TChunkPLTE);

procedure SetPaletteColorCount(png:TPngImage; Count:integer);
var j:integer;
begin
  FOR j := 0 TO png.Chunks.Count - 1 DO
  if png.Chunks.Item[j] is TChunkPLTE then
  begin
   TFakeChunkPLTE(png.Chunks.Item[j]).fCount:=Count;
  end;
end;

{$IFNDEF CLX}

function GetPNGObjectPTFromGifAndBitmap32(Transparent:TdhBitmap32; gif:TGIFImage):TPngImage;
var bt:TBitmap;
var P: PColor32;
    x,y:integer;
begin
 result:=TPngImage.Create;
 result.CompressionLevel:=9;
 bt:=TBitmap.Create;
 bt.Assign(Transparent);
 bt.Width:=gif.Width;
 bt.Height:=gif.Height;
 bt.Assign(gif);
 if gif.Images[0].Transparent then
 begin
  result.AssignHandle(bt.Handle,true, gif.Images[0].GraphicControlExtension.TransparentColor);
  SetPaletteColorCount(result,gif.GlobalColorMap.Count);
  result.TransparentColor:=gif.Images[0].GraphicControlExtension.TransparentColor;
  begin
   P:=Transparent.PixelPtr[0,0];
   for Y:=0 to result.Height-1 do
   begin
    for X:=0 to result.Width-1 do
    begin
     if Transparent.Pixel[x,y] shr 24=$00 then
      result.Pixels[x,y]:=result.transparentcolor;
     inc(P);
    end;
   end;
  end;
 end else
 begin
  result.AssignHandle(bt.Handle,false,0);
  SetPaletteColorCount(result,gif.GlobalColorMap.Count-1);
 end;
 bt.Free;
end;

function GetPNGObjectPTFromBitmap32(Transparent:TdhBitmap32; Opaque:TdhBitmap32):TPngImage;
var gif:TGifImage;
begin
 gif:=GetGifImageFromBitmap32(Transparent,Opaque);
 try
  result:=GetPNGObjectPTFromGifAndBitmap32(Transparent,gif);
 finally
  gif.Free;
 end;
end;

function GetPNGObjectPTFromGif(gif:TGIFImage):TPngImage;
var Transparent:TdhBitmap32;
begin
 Transparent:=GetAs32(gif);
 try
  result:=GetPNGObjectPTFromGifAndBitmap32(Transparent,gif);
 finally
  Transparent.Free;
 end;
end;
{$ENDIF}

{$IFNDEF CLX}
function GetJPEGImageFromBitmap32(Src:TdhBitmap32):TJPEGImage;
var bt:TBitmap;
begin
  bt:=TBitmap.Create;
  bt.Assign(Src);
  result:=TJPegImage.Create;
  result.Assign(bt);
  bt.Free;
end;
{$ENDIF}

function GetFromBitmap32(Transparent:TdhBitmap32):TGraphic;
begin
 result:=TBitmap.Create;
 result.Assign(Transparent);
end;

function GetGifTransparent(Opaque:TdhBitmap32; Transparent:TdhBitmap32):TdhBitmap32;
var J:integer;
var P,P2: PColor32;
begin
 result:=TdhBitmap32.Create;
 result.Assign(Opaque);
 P:=Transparent.PixelPtr[0,0];
 P2:=result.PixelPtr[0,0];
 for j:=0 to Transparent.Width*Transparent.Height-1 do
 begin
  if P^ shr 24=$00 then
   P2^:=0;
  inc(P);
  inc(P2);
 end;
end;

function GetNewGif:TGifImage;
begin
  result:=TGifImage.Create;
  result.ColorReduction:=rmQuantize;
  result.DitherMode := dmFloydSteinberg;
end;

function ReduceColorsWithTransparentColorReservation(GIFImage:TGIFImage; Bitmap:TBitmap):TBitmap;
var Bitmaps:TList;
    Palette:hPalette;
begin
  Bitmaps:=TList.Create;
  try
    Bitmaps.Add(Bitmap);
    Palette:=CreateOptimizedPaletteFromManyBitmaps(Bitmaps,1 SHL GIFImage.ReductionBits-1, 6, false);
    try
      Result:=ReduceColors(Bitmap,rmPalette,GIFImage.DitherMode,GIFImage.ReductionBits,Palette);
      Bitmap.Free;
    finally
      if (Palette <> 0) then
        DeleteObject(Palette);
   end;
  finally
   Bitmaps.Free;
  end;
end;

function AddGIFSubImageFromBitmap32(Transparent:TBitmap32; Opaque:TBitmap32; GIF:TGIFImage; Loop:boolean=false; CopyFrom:TGIFFrame=nil; PrevSubImage:TGIFFrame=nil):TGIFFrame;
var y,x,i:integer;
var P: PColor32;
    bt:TBitmap;
    PP : PColor32;
    Ext : TGIFGraphicControlExtension;
    LoopExt: TGIFAppExtNSLoop;
    TransparentIndex	: integer;
    TransparentIndex2	: integer;
    WasTransparent:boolean;
    GIFSubImage:TGIFFrame;
    ba,ba2:PByteArray;
    DelayMS:Word;
begin

  if (CopyFrom<>nil) and (CopyFrom.GraphicControlExtension<>nil) then
   DelayMS:=CopyFrom.GraphicControlExtension.Delay else
   DelayMS:=0;

  bt:=TBitmap.Create;
  bt.PixelFormat:=pf32bit;
  bt.Width:=Opaque.Width;
  bt.Height:=Opaque.Height;
  bt.Canvas.CopyRect(Opaque.BoundsRect,Opaque.Canvas,Opaque.BoundsRect);

  WasTransparent:=false;
  if Transparent<>nil then
  begin
   P:=Transparent.PixelPtr[0,0];
   for y:=0 to Transparent.Height-1 do
   begin
    pp:=bt.ScanLine[y];
    for x:=0 to Transparent.Width-1 do
    begin
     if P^ shr 24=$00 then
     begin
      WasTransparent:=true;
      pp^:=$0;
     end;
     inc(P);
     inc(pp);
    end;
   end;
  end;

  if WasTransparent then
   bt:=ReduceColorsWithTransparentColorReservation(gif,bt);

{$IFDEF VER210}
  GIFSubImage:=GIF.Add(bt);
{$ELSE}
  GIFSubImage:=GIF.Images[GIF.Add(bt)];
{$ENDIF}
  bt.Free;

  result:=GIFSubImage;

  if Loop and (GIFSubImage=GIF.Images[0]) then
  begin
    LoopExt := TGIFAppExtNSLoop.Create(GIFSubImage);
    LoopExt.Loops := 0;
    for i := 0 to CopyFrom.Extensions.Count-1 do
    if (CopyFrom.Extensions[i] is TGIFAppExtNSLoop) then
     LoopExt.Loops:=TGIFAppExtNSLoop(CopyFrom.Extensions[i]).Loops;
    GIFSubImage.Extensions.Add(LoopExt);
  end;

  Ext:=nil;
  if WasTransparent then
  begin
    GIFSubImage.ColorMap.Optimize;
    // Can't make transparent if no color or colormap full
    if not((GIFSubImage.ColorMap.Count = 0) or (GIFSubImage.ColorMap.Count = 256)) then
    begin
      // Add the transparent color to the color map
      TransparentIndex := GIFSubImage.ColorMap.Add(TColor($0));

      Ext:=TGIFGraphicControlExtension.Create(GIFSubImage);
      Ext.Transparent := True;
      Ext.TransparentColorIndex := TransparentIndex;
      Ext.Delay := DelayMS;
      GIFSubImage.Extensions.Add(Ext);

      Assert(TransparentIndex=GIFSubImage.GraphicControlExtension.TransparentColorIndex);

       P:=Transparent.PixelPtr[0,0];
       for y:=0 to Transparent.Height-1 do
       begin
        ba:=GIFSubImage.ScanLine[y];
        for x:=0 to Transparent.Width-1 do
        begin
         if P^ shr 24=$00 then
          ba[x]:=TransparentIndex;
         inc(P);
        end;
       end;
    end;
  end;

  if (Ext=nil) and (DelayMS<>0) then
  begin
      Ext:=TGIFGraphicControlExtension.Create(GIFSubImage);
      Ext.Delay := DelayMS;
      GIFSubImage.Extensions.Add(Ext);
  end;

  if (PrevSubImage<>nil) and (PrevSubImage.Height=GIFSubImage.Height)  and (PrevSubImage.Width=GIFSubImage.Width) and GIFSubImage.Transparent and (PrevSubImage.GraphicControlExtension<>nil) then
  begin
       TransparentIndex:=GIFSubImage.GraphicControlExtension.TransparentColorIndex;
       if PrevSubImage.GraphicControlExtension<>nil then
        TransparentIndex2:=PrevSubImage.GraphicControlExtension.TransparentColorIndex else
        TransparentIndex2:=-1;
       for y:=0 to GIFSubImage.Height-1 do
       begin
        ba:=GIFSubImage.ScanLine[y];
        ba2:=PrevSubImage.ScanLine[y];
        for x:=0 to Transparent.Width-1 do
        begin
         if (ba[x]=TransparentIndex) and (ba2[x]<>TransparentIndex2) then
         begin
          PrevSubImage.GraphicControlExtension.Disposal:=dmBackground;
          exit;
         end;
        end;
       end;
  end;

end;

procedure CloseGif(GIF:TGifImage);
begin
 GIF.Optimize([{ooCrop, Opera cannot deal with cropping: treats as if cropped edges not exist}ooMerge,ooCleanup,ooColorMap],GIF.ColorReduction,GIF.DitherMode,GIF.ReductionBits);
end;

function GetBitmap32FromPNGObject(png:TPngImage):TdhBitmap32;
var P: PColor32;
    bp:pngimage.pByteArray;
    x,y:integer;
    TransparentColor:TColor;
    sl:pRGBLine;
begin
  result:=TdhBitmap32.Create;
  case png.TransparencyMode of
  ptmPartial:
  begin
   result.SetSize(png.Width,png.Height);
   P:=result.PixelPtr[0,0];
   for Y:=0 to png.Height-1 do
   begin
    bp:=png.AlphaScanline[Y];
    sl:=pRGBLine(png.Scanline[Y]);
    for X:=0 to png.Width-1 do
    begin
     with sl[X] do
      P^:=Color32(rgbtRed,rgbtGreen,rgbtBlue,bp^[X]);
     inc(P);
    end;
   end;
   result.DrawMode:=dmBlend;
  end;
  ptmBit:
  begin
   result.SetSize(png.Width,png.Height);
   TransparentColor:=png.TransparentColor;
   P:=result.PixelPtr[0,0];
   for Y:=0 to png.Height-1 do
   begin
    for X:=0 to png.Width-1 do
    begin
     if png.Pixels[X,Y]=TransparentColor then
      P^:=0 else
      P^:=Color32(png.Pixels[X,Y]);
     inc(P);
    end;
   end;
   result.DrawMode:=dmBlend;
  end;
  ptmNone:
  begin
   result.SetSize(png.Width,png.Height);
   P:=result.PixelPtr[0,0];
   for Y:=0 to png.Height-1 do
   begin
    for X:=0 to png.Width-1 do
    begin
     P^:=Color32(png.Pixels[X,Y]);
     inc(P);
    end;
   end;
  end;
  end;
end;

function GetPNGObjectFromBitmap32(Src:TBitmap32):TGraphic;
var y,x:integer;
var P: PColor32;
    bp:pngimage.pByteArray;
    png:TPngImage;
begin
  png:=TPngImage.Create;
  result:=png;
  png.CompressionLevel:=9;
  png.AssignHandle(Src.BitmapHandle,false,0);

{$IFDEF CLX}
   P:=Src.PixelPtr[0,0];
   for Y:=0 to png.Height-1 do
   begin
    for X:=0 to png.Width-1 do
    begin
     png.Pixels[X,Y]:=WinColor(P^);
     inc(P);
    end;
   end;
{$ENDIF}

  if Src.DrawMode<>dmOpaque then
  begin
   png.CreateAlpha;
   for Y:=0 to result.Height-1 do
   begin
    bp:=png.AlphaScanline[Y];
    P:=Src.PixelPtr[0,Y];
    for X:=0 to result.Width-1 do
    begin
     bp^[X]:=P^ shr 24;
     inc(P);
    end;
   end;
  end;
end;

type TFakeGIFImage=class(TGIFImage);
type TGraphicAccess = class(TGraphic);

function GetBitmap32FromGifImage(gif:TGIFImage):TdhBitmap32;
var P: PColor32;
    x:integer;
    Source:TGraphic;
    Canvas: TCanvas;
begin

  result:=TdhBitmap32.Create;

  Source:=gif;
  begin //see result.Assign(TGraphic);
      result.SetSize(TGraphic(Source).Width, TGraphic(Source).Height);
      result.Clear($AA000000);
      if result.Empty then Exit;
        Canvas:=result.Canvas;
        if (ForcedGIFRenderer<>nil) and (ForcedGIFRenderer.Image=gif) then
         ForcedGIFRenderer.Draw(Canvas, MakeRect(0, 0, result.Width, result.Height)) else
         TGraphicAccess(Source).Draw(Canvas, MakeRect(0, 0, result.Width, result.Height));
  end;

  //{can be false negative}if gif.Transparent then
  begin
   P:=result.PixelPtr[0,0];
   for x:=0 to result.Width*result.Height-1 do
   begin
     //when TGIFImage set an pixel, Alpha=0; else it is not changed
     if p^<>$AA000000 then
      P^:=P^ or $FF000000 else
      P^:=0;
     inc(P);
   end;
  end;
  result.DrawMode:=dmBlend;
end;

function GetBitmap32FromGraphic(bt:TGraphic):TdhBitmap32;
var P: PColor32;
    y:integer;
    TransparentColor:TColor32;
begin
  result:=TdhBitmap32.Create;
  result.Assign(bt);
  if bt.Transparent and ((result.Width<>0) or (result.Height<>0)) then
  begin
   TransparentColor:=result.Pixel[0,result.Height-1];
   P:=result.PixelPtr[0,0];
   for Y:=0 to result.Height*result.Width-1 do
   begin
     if P^=TransparentColor then
      P^:=0;
     inc(P);
   end;
   result.DrawMode:=dmBlend;
  end else
   result.ResetAlpha;
end;

function GetAs32(Graphic:TGraphic):TdhBitmap32;
begin
 if Graphic is TPngImage then
 begin
  result:=GetBitmap32FromPNGObject(TPngImage(Graphic));
 end else
 if Graphic is TGifImage then
 begin
  result:=GetBitmap32FromGifImage(TGifImage(Graphic));
 end else
 if Graphic<>nil then
 begin
  result:=GetBitmap32FromGraphic(Graphic);
 end else
 begin
  result:=nil;
 end;
end;

function HasSemiTransparence(graphic: TGraphic):boolean;
var X,Y:integer;
    bp:pngimage.pByteArray;
    png:TPngImage;
begin
  if graphic is TPngImage  then
  begin
   png:=TPngImage(graphic);
   if png.TransparencyMode=ptmPartial then
   for Y:=0 to png.Height-1 do
   begin
    bp:=png.AlphaScanline[Y];
    for X:=0 to png.Width-1 do
    if bp^[X] in [1..254] then
    begin
     result:=true;
     exit;
    end;
   end;
  end;
  result:=false;
end;

procedure TPatchedGIFRenderer.Draw(ACanvas: TCanvas; const Rect: TRect);
type PCanvas=^TCanvas;
begin
  PCanvas(@TargetCanvas)^:=ACanvas;
  inherited Draw(ACanvas, Rect);
  PCanvas(@TargetCanvas)^:=nil;
end;

function TPatchedGIFImage.CreateRenderer: TCustomGIFRenderer;
begin
  Result := TPatchedGIFRenderer.Create(Self);
  Result.Speed := AnimationSpeed;
  Result.Transparent := Transparent;
  Result.BackgroundColor := EffectiveBackgroundColor;
  Result.Animate := Animate;
end;

constructor TGIFRenderer32.Create(AImage: TGIFImage);
begin
     inherited Create(AImage);
     if AImage.Transparent then
      Transparent:=true;
     Animate:=True;
end;

procedure TGIFRenderer32.StartAnimation;
begin
  // do nothing
end;

type
  TPNGObject = class(TPngImage);

initialization

 TPicture.RegisterFileFormat('', '', TPNGObject);

{$IFDEF CLX}
 Exclude(GIFImageDefaultDrawOptions,goAnimate); //gif-animations has problems at CLX
{$ENDIF}

end.
