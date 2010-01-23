unit uMetaWriter;

interface

uses
  SysUtils, Classes, types, typinfo,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QClipbrd, Qt,
  QMask, QComCtrls, QTntStdCtrls,
{$ELSE}
  {$IFDEF VER210}GIFImg{$ELSE}GIFImage{$ENDIF},Controls,  Messages, Graphics, Forms, Dialogs,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, ComCtrls,  DKLang, UnicodeCtrls,
{$ENDIF}

  dhHTMLForm,MySiz, dhPanel,dhPageControl, funcutils, UseFastStrings, math, Contnrs, MySpinEdit, MyTrackBar,
  hEdit,hComboBox,hMemo,dhMenu,dhStyleSheet,MySpeedButton,BinTree,uTemplates,
  dhLabel, dhCheckBox, dhRadioButton, dhEdit, dhFile, dhFileField, dhSelect, UIConstants, MyForm,
  dhStrUtils, MyBitmap32, crc, gr32;

type TMyWriter=class(TWriter)
    FIntegerValue:Integer;
    FStringValue:String;
    procedure OnDefineProperties(Sender: TObject);
    procedure DefineBooleanProperty(const Name: string; Value: Boolean); overload;
    procedure DefineStringProperty(const Name: string; Value: string; DefaultValue: string); overload;
    procedure DefineStringProperty(const Name: string; Value: string; HasData: boolean); overload;
    procedure DefineStringProperty(const Name: string; Value: string); overload;
    procedure DefineIntegerProperty(const Name: string; Value: Integer; DefaultValue: Integer); overload;
    procedure DefineIntegerProperty(const Name: string; Value: Integer; HasData: boolean); overload;
    procedure DefineIntegerProperty(const Name: string; Value: Integer); overload;
    procedure WriteTrue(Writer: TWriter);
    procedure WriteIntegerValue(Writer: TWriter);
    procedure WriteStringValue(Writer: TWriter);
end;

function AdjustAlternativeRastering(const TopPC,ID:TComponentName; var Rastering:TPathName):boolean;
function FindPage(c:TControl; var res:TWinControl; RealActivePage:boolean):boolean;

function FinalGeneratedJavaScriptFile(const GeneratedJavaScriptFile:TPathName):TPathName;
function FinalGeneratedCSSFile(const GeneratedCSSFile:TPathName):TPathName;
function FinalImageFolder(c:TControl):TPathName;
function FinalGeneratedImageFolder(const GeneratedImageFolder:TPathName):TPathName;
function FinalID(c:TControl):TComponentName;
function GoodWebPathDelimiters(const path:TPathName):TPathName;
function IsAbsolute(s:TPathName):boolean;
function CutCurrentDir(const path:TPathName):TPathName;
function ProposedBackgroundFilename(Self:TStyle): TPathName;
function ProposedFileName(Self:TdhFile):TPathName;

function ContainsPHPTag(const s:HypeString):boolean;
function LE127(const s:WideString):AnsiString;
function CharRef(i:integer):AnsiString;
function CharRefDecimal(i:integer):AnsiString;
function hh(i:integer):AString;

var glSaveBin:function(_crc:DWORD; var RasteringFile,AbsoluteRasteringFile:TPathName; CheckBaseRasteringFile:boolean; BaseRasteringFile:TPathName; var NeedSave:boolean; NeedSameFileName:boolean):boolean;
var glAfterSaveBin:procedure;

const sst:array[TState] of TPathName=('_nm','_ov','_dn','_od');

implementation

type TFakeStyle=class(TStyle);
type TdhFakeCustomPanel=class(TdhCustomPanel);
type TdhFakeCustomEdit=class(TdhCustomEdit);
type TdhFakeFile=class(TdhFile);
type TdhFakeDynLabel=class(TdhDynLabel);
type TdhFakeLink=class(TdhLink);
type TdhFakeMenu=class(TdhMenu);
type TdhFakePage=class(TdhPage);

procedure TrimBottom(b:TMyBitmap32; var w,h:integer);
var x,y:integer;
begin
   for y:=h-1 downto 0 do
   for x:=0 to w-1 do
   if b.Pixel[x,y] and $FF000000<>0 then
   begin
    h:=y+1;
    exit;
   end;
end;

procedure TrimRight(b:TMyBitmap32; var w,h:integer);
var x,y:integer;
begin
   for x:=w-1 downto 0 do
   for y:=0 to h-1 do
   if b.Pixel[x,y] and $FF000000<>0 then
   begin
    w:=x+1;
    exit;
   end;
end;

procedure TrimRightBottom(b:TMyBitmap32; var w,h:integer);
begin
   w:=b.Width;
   h:=b.Height;
   TrimBottom(b,w,h);
   TrimRight(b,w,h);
   if (w=0) or (h=0) then
   begin
    w:=0;
    h:=0;
   end;
end;

function HasSemiTransparence(Transparent:TMyBitmap32):boolean;
var P: PColor32;
    i:integer;
begin
   P:=Transparent.PixelPtr[0,0];
   for i:=0 to Transparent.Width*Transparent.Height-1 do
   begin
     if ((P^ shr 24)<>$00) and ((P^ shr 24)<>$FF) then
     begin
       result:=true;
       exit;
     end;
     Inc(P);
   end;
   result:=false;
end;

procedure NormalizeSemiTransparence(Transparent:TMyBitmap32);
var P: PColor32;
    i:integer;
begin
   P:=Transparent.PixelPtr[0,0];
   for i:=0 to Transparent.Width*Transparent.Height-1 do
   begin
     if P^ shr 24=$00 then
      P^:=$0; //if fully transparent, then take this one color
     Inc(P);
   end;
end;

procedure NormalizeBitTransparence(Transparent:TMyBitmap32; Opaque:TMyBitmap32);
var P,P2: PColor32;
    i:integer;
begin
   assert((Transparent.Width=Opaque.Width) and (Transparent.Height=Opaque.Height));
   P:=Transparent.PixelPtr[0,0];
   P2:=Opaque.PixelPtr[0,0];
   for i:=0 to Transparent.Width*Transparent.Height-1 do
   begin
     if P^ shr 24=$00 then
      P2^:=$0 else //if fully transparent, then take this one color
      P2^:=P2^ or $FF000000; //otherwise set full opacity
     Inc(P);
     Inc(P2);
   end;
end;

function GetEqArea(bmp:TMyBitmap32;TryX,TryY:integer):TRect;
var x,y,w,h:integer;
    bbase,base,compareTo:PColor32;
    Eq:boolean;
begin
 result.Left:=Between(TryX,0,bmp.Width-1);
 result.Top:=Between(TryY,0,bmp.Height-1);
 result.Right:=result.Left;
 result.Bottom:=result.Top;

 //compare horizontal lines
 bbase:=bmp.PixelPtr[0,result.Top];
 compareTo:=bmp.PixelPtr[0,result.Bottom+1];
 w:=bmp.Width;
 h:=bmp.Height;

 for y:=result.Bottom+1 to h-1 do
 begin
  base:=bbase;
  Eq:=true;
  for x:=0 to w-1 do
  begin
   if base^<>compareTo^ then
   begin
    Eq:=false;
    break;
   end;
   inc(base);
   inc(compareTo);
  end;
  if Eq then
  begin
   inc(result.Bottom);
  end;
 end;

 for y:=result.Top-1 downto 0 do
 begin
  compareTo:=bmp.PixelPtr[0,result.Top-1];
  base:=bbase;
  Eq:=true;
  for x:=0 to w-1 do
  begin
   if base^<>compareTo^ then
   begin
    Eq:=false;
    break;
   end;
   inc(base);
   inc(compareTo);
  end;
  if Eq then
  begin
   dec(result.Top);
  end;
 end;


 //compare vertical lines
 bbase:=bmp.PixelPtr[result.Left,0];
 compareTo:=bmp.PixelPtr[result.Right+1,0];

 for x:=result.Right+1 to w-1 do
 begin
  compareTo:=bmp.PixelPtr[result.Right+1,0];
  base:=bbase;
  Eq:=true;
  for y:=0 to h-1 do
  begin
   if base^<>compareTo^ then
   begin
    Eq:=false;
    break;
   end;
   inc(base,w);
   inc(compareTo,w);
  end;
  if Eq then
  begin
   inc(result.Right);
  end;
 end;

 for x:=result.Left-1 downto 0 do
 begin
  compareTo:=bmp.PixelPtr[result.Left-1,0];
  base:=bbase;
  Eq:=true;
  for y:=0 to h-1 do
  begin
   if base^<>compareTo^ then
   begin
    Eq:=false;
    break;
   end;
   inc(base,w);
   inc(compareTo,w);
  end;
  if Eq then
  begin
   dec(result.Left);
  end;
 end;

 inc(result.Right);
 inc(result.Bottom);

end;

function GetCRCFromBitmap32(b:TMyBitmap32; w,h:integer; ResumeCrc:DWORD=0):DWORD; overload;
var y:integer;
begin
   result:=w;
   result:=calc_crc32(sizeof(result),@result,ResumeCrc);
   if w<>0 then
   for y:=0 to h-1 do
    result:=calc_crc32(w*sizeof(TColor32),PByte(b.PixelPtr[0,y]),result);
end;

function GetCRCFromBitmap32(Transparent,Opaque:TMyBitmap32; w,h:integer; ResumeCrc:DWORD=0):DWORD; overload;
var Opaque2:TMyBitmap32;
begin
 Opaque2:=TMyBitmap32.Create;
 Opaque2.Assign(Opaque);
 NormalizeBitTransparence(Transparent,Opaque2);
 result:=GetCRCFromBitmap32(Opaque2,w,h,ResumeCrc);
 Opaque2.Free;
end;

function GetImageDir(Self:TdhPage):TPathName;
begin
 result:=FinalGeneratedImageFolder(Self.GeneratedImageFolder);
end;

function FinalImageFolder(c:TControl):TPathName;
begin
 result:='';
 while (c<>nil) do
 begin
  if c is TdhPage then
  begin
    result:=CutCurrentDir(GetImageDir(TdhPage(c)))+result;
  end;
  c:=c.Parent;
 end;
end;

function FinalGeneratedImageFolder(const GeneratedImageFolder:TPathName):TPathName;
begin
 result:=GeneratedImageFolder;
 if (result='') or IsAbsolute(GoodWebPathDelimiters(GeneratedImageFolder)) then
  result:='.';
 result:=GoodLocalPath(result);
 result:=GoodWebPathDelimiters(result);
end;

function FinalImageID(c:TControl):TPathName;
begin
 result:=FinalImageFolder(c)+FinalID(c);
end;

function FinalID(c:TControl):TComponentName;
var O:TComponent;
begin
 result:=c.Name;
 O:=c.Owner;
 while (O<>nil) and (O.Owner<>nil) and not (O is TForm) do
 begin
  result:=O.Name+result;
  O:=O.Owner;
 end;
end;

function GoodWebPathDelimiters(const path:TPathName):TPathName;
begin
 result:=StringReplace(path,'\','/',[rfReplaceAll]);
end;

function CutCurrentDir(const path:TPathName):TPathName;
begin
  result:=path;
  while Copy(result,1,Length('./'))='./' do
   result:=Copy(result,Length('./')+1,MaxInt);
end;

function ProposedBackgroundFilename(Self:TStyle): TPathName;
begin
 result:=FinalImageID(Self.Owner.GetControl)+sst[Self.RepresentingState]+Self.BackgroundImage.GraphicExtension
end;

function IsAbsolute(s:TPathName):boolean;
begin
 if (length(s)>=2) and (s[2]=DriveDelim) then
 begin
  result:=true;
  exit;
 end;
 if (length(s)>=1) and (s[1]=PathDelim) then
 begin
  result:=true;
  exit;
 end;
 result:=false;
end;

function getPhysicalImageFormat(requested:TPhysicalImageFormat;TransparentTop:TMyBitmap32):TPhysicalImageFormat;
begin
  result:=requested;
  if (result=pifSaveAsJPEG) and ((TransparentTop.Height<=1) or (TransparentTop.Width<=1)) then
  begin
   //jpeg implementation requires at least height>1 when saving
   result:=pifSaveAsGIF;
  end;
end;

function PrepareBGImage(Self:TFakeStyle):boolean;
var NeedSave:boolean;
    AbsoluteBGImageFile:TPathName;
    StringContent:TFileContents;
begin
 result:=false;
 if not Self.IsPictureStored then
  exit;

 StringContent:='';
 if Self.FBackgroundImage.HasPath then
 try
  StringContent:=StringFromFile(Self.FBackgroundImage.GetAbsolutePath);
 except
  // let the dummy image be load next
 end;
 if StringContent='' then
  StringContent:=AsString(Self.FBackgroundImage.RequestGraphic);

 Self.BGImageFile:=ProposedBackgroundFilename(Self);
 result:=glSaveBin(calc_crc32_String(StringContent),Self.BGImageFile,AbsoluteBGImageFile,false,EmptyStr,NeedSave,false);

 if NeedSave then
 try
  StringToFile(AbsoluteBGImageFile,StringContent);
  glAfterSaveBin;
 except
 end;
 result:=true;
end;



function SaveImg(Opaque:TMyBitmap32; Transparent:TMyBitmap32; var RasteringFile:TPathName; CheckBaseRasteringFile:boolean; BaseRasteringFile:TPathName; PhysicalImageFormat:TPhysicalImageFormat; AllowCutWhiteSpace:boolean):boolean;
var gif_pre:TMyBitmap32;
    i,w,h:integer;
    _crc:DWORD;
    graph:TGraphic;
    NeedSave:boolean;
    AbsoluteRasteringFile:TPathName;
const ext:array[TPhysicalImageFormat] of AnsiString=('.gif','.png','.jpg');
begin

   RasteringFile:=RasteringFile+ext[PhysicalImageFormat];
   _crc:=calc_crc32_String(ext[PhysicalImageFormat]);
   if AllowCutWhiteSpace then
   begin
    TrimRightBottom(Transparent,w,h);
   end else
   begin
    w:=Transparent.Width;
    h:=Transparent.Height;
   end;
   if PhysicalImageFormat=pifSaveAsGIF then
   begin
    _crc:=GetCRCFromBitmap32(Transparent,Opaque,w,h,_crc);
   end else
   if PhysicalImageFormat=pifSaveAsPNG then
   begin
    _crc:=GetCRCFromBitmap32(Transparent,w,h,_crc);
   end else
   begin
    _crc:=GetCRCFromBitmap32(Opaque,w,h,_crc);
   end;

   result:=glSaveBin(_crc,RasteringFile,AbsoluteRasteringFile,CheckBaseRasteringFile,BaseRasteringFile,NeedSave,false);

  if NeedSave then
  try
  if PhysicalImageFormat=pifSaveAsGIF then
   graph:=GetGifImageFromBitmap32(Transparent,Opaque) else
  if PhysicalImageFormat=pifSaveAsJPEG then
   graph:=GetJPEGImageFromBitmap32(Opaque) else
   graph:=GetPNGObjectFromBitmap32(Transparent);
   graph.SaveToFile(AbsoluteRasteringFile);
   graph.Free;
   glAfterSaveBin;
  except
  end;
end;

function BaseRasteringFile(Self:TFakeStyle):TPathName;
var PreferDown:boolean;
    Owner:TdhFakeCustomPanel;
begin
 Owner:=TdhFakeCustomPanel(Self.Owner.GetControl);
 case Self.OwnState of
  hsNormal: result:=EmptyStr;
  hsOver,hsDown: result:=Owner.StyleArr[hsNormal].RasteringFile;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    result:=Owner.StyleArr[NextStyle[PreferDown]].RasteringFile;
    if result=Owner.StyleArr[hsNormal].RasteringFile then
     result:=Owner.StyleArr[NextStyle[not PreferDown]].RasteringFile;
   end;
  end;
 //result:=Owner.StyleArr[NextStyle[Owner.DownOverlayOver,OwnState]].RasteringFile;
end;


function PrepareRastering(Self:TFakeStyle; addheight:integer; const PostFix:TPathName):boolean;
var pn:TdhFakeCustomPanel;
    graph:TGraphic;
    OldFrameIndex,NewFrameIndex,w,h:integer;
    _crc:DWORD;
    NeedSave:boolean;
    bt:TBitmap;

    fingif,Sub:TGIFImage;
    GCE:TGIFGraphicControlExtension;
    PrevSubImage:TGIFFrame;
    pnTopGraph,pnTransparentTop,GraphToSplit:TMyBitmap32;
    EqArea:TRect;
    EqX,EqY:integer;
    EqSize:TRect;
    RasteringFiles:TPathName;
    AbsoluteRasteringFile:TPathName;
    NeedOpaqueImage:boolean;
    PhysicalImageFormat:TPhysicalImageFormat;
    ImageFormat:TImageFormat;
var EqSizing:array[0..2,0..2] of TRect;
const EqNaming:array[0..2,0..2] of TPathName=(('_topleft','_topmiddle','_topright'),('_middleleft','_middle','_middleright'),('_bottomleft','_bottommiddle','_bottomright'));
begin

  pn:=TdhFakeCustomPanel(Self.Owner.GetControl);

  {TODO: SpeedupGeneration if RasteringFile<>'' then
  begin
    result:=true;
    exit;
  end;}

  ImageFormat:=pn.GetImageFormat;
  if (ImageFormat in [ifInherit,ifSimple]) and pn.HasBackgroundImage(graph) and (graph is TGIFImage) and (TGIFImage(graph).Images.Count>=2) then
  begin
   _crc:=calc_crc32_String('.gif');
   Assert(not PreventGraphicOnChange);
   PreventGraphicOnChange:=true;
   try
    ForcedGIFRenderer:=TGIFRenderer32.Create(TGIFImage(graph));
    try
    repeat
     pn.TopIsValid:=false;
     pn.TransparentTopIsValid:=false;
     pn.AssertTop(addheight,true);
     if not pn.TransparentTop.Empty then
     begin
      TrimRightBottom(pn.TransparentTop,w,h);
      _crc:=GetCRCFromBitmap32(pn.TransparentTop,pn.TopGraph,w,h,_crc);
     end;
     OldFrameIndex:=TGIFImage(graph).Images.IndexOf(ForcedGIFRenderer.Frame);
     ForcedGIFRenderer.NextFrame;
     NewFrameIndex:=TGIFImage(graph).Images.IndexOf(ForcedGIFRenderer.Frame);
    until not (NewFrameIndex>OldFrameIndex);
    finally
      FreeAndNil(ForcedGIFRenderer);
    end;

    Self.RasteringFile:=FinalImageID(pn)+PostFix+sst[Self.OwnState];
    Self.RasteringFile:=Self.RasteringFile+'.gif';
    result:=glSaveBin(_crc,Self.RasteringFile,AbsoluteRasteringFile,Self.OwnState<>hsNormal,BaseRasteringFile(Self),NeedSave,false);

    if NeedSave then
    begin
     ForcedGIFRenderer:=TGIFRenderer32.Create(TGIFImage(graph));
     fingif:=GetNewGif;
     try
     try
      PrevSubImage:=nil;
      repeat
       pn.TopIsValid:=false;
       pn.TransparentTopIsValid:=false;
       pn.AssertTop(addheight,true);
       if not pn.TransparentTop.Empty then
       begin
        PrevSubImage:=AddGIFSubImageFromBitmap32(pn.TransparentTop,pn.TopGraph,fingif,true,ForcedGIFRenderer.Frame,PrevSubImage);
       end;
       OldFrameIndex:=TGIFImage(graph).Images.IndexOf(ForcedGIFRenderer.Frame);
       ForcedGIFRenderer.NextFrame;
       NewFrameIndex:=TGIFImage(graph).Images.IndexOf(ForcedGIFRenderer.Frame);
      until not (NewFrameIndex>OldFrameIndex);
      CloseGif(fingif);
      //fingif.OptimizeColorMap; //saves many kb at many frames
      fingif.SaveToFile(AbsoluteRasteringFile);
      glAfterSaveBin;
     except
     end;
     finally
      FreeAndNil(ForcedGIFRenderer);
      fingif.Free;
     end;
    end;
   finally
    PreventGraphicOnChange:=false;
   end;
  end else
  begin
   NeedOpaqueImage:=ImageFormat<>ifSemiTransparent;
   pn.AssertTop(addheight,true,NeedOpaqueImage);
   if NeedOpaqueImage and (ImageFormat=ifInherit) and HasSemiTransparence(pn.TransparentTop) then
     NeedOpaqueImage:=false;
   if not NeedOpaqueImage then
    PhysicalImageFormat:=pifSaveAsPNG else
   if ImageFormat=ifJPEG then
    PhysicalImageFormat:=pifSaveAsJPEG else
    PhysicalImageFormat:=pifSaveAsGIF;
   if not pn.TransparentTop.Empty then
   begin
    if (csAcceptsControls in pn.ControlStyle) and (pn.EqArea.Left<>InvalidEqArea) then
    begin
     if NeedOpaqueImage then pn.TopGraph.ResetAlpha else NormalizeSemiTransparence(pn.TransparentTop); //normalize so that GetEqArea works correctly
     if NeedOpaqueImage then GraphToSplit:=pn.TopGraph else GraphToSplit:=pn.TransparentTop;
     EqArea:=GetEqArea(GraphToSplit,(pn.EqArea.Left+pn.EqArea.Right) div 2,(pn.EqArea.Top+pn.EqArea.Bottom) div 2);
     if not pn.VariableHeightSize and (EqArea.Bottom-EqArea.Top<pn.TransparentTop.Height div _if(pn.VariableHeightSize,4,2)) then
     begin
      //EqArea.Top:=pn.EqArea.Top; //then, alternative pages with different heights can reuse the same top three graphics
      EqArea.Top:=0;
      EqArea.Bottom:=EqArea.Top;
     end;
     if not pn.VariableWidthSize and (EqArea.Right-EqArea.Left<pn.TransparentTop.Width div _if(pn.VariableWidthSize,4,2)) then
     begin
      EqArea.Left:=0;
      EqArea.Right:=EqArea.Left;
     end;
     if (EqArea.Right<>EqArea.Left) and (EqArea.Bottom<>EqArea.Top) or (pn.VariableWidthSize and (EqArea.Right<>EqArea.Left)) or (pn.VariableHeightSize and (EqArea.Top<>EqArea.Bottom)){ or (EqArea.Right-EqArea.Left>=1) and (EqArea.Bottom-EqArea.Top>=1) and pn.VariableSize} then
     begin
      if NeedOpaqueImage then
       pnTopGraph:=TMyBitmap32.Create else
       pnTopGraph:=nil;
      pnTransparentTop:=TMyBitmap32.Create;
      pnTransparentTop.DrawMode:=pn.TransparentTop.DrawMode;
      pn.TransparentTop.DrawMode:=dmOpaque;
      try

       EqSizing[0,0]:=Rect(0,0,EqArea.Left,EqArea.Top);
       EqSizing[1,0]:=Rect(EqArea.Left,0,Min(EqArea.Left+1,EqArea.Right),EqArea.Top);
       EqSizing[2,0]:=Rect(EqArea.Right,0,pn.TransparentTop.Width,EqArea.Top);

       EqSizing[0,1]:=Rect(0,EqArea.Top,EqArea.Left,Min(EqArea.Top+1,EqArea.Bottom));
       EqSizing[1,1]:=Rect(EqArea.Left,EqArea.Top,Min(EqArea.Left+1,EqArea.Right),Min(EqArea.Top+1,EqArea.Bottom));
       EqSizing[2,1]:=Rect(EqArea.Right,EqArea.Top,pn.TransparentTop.Width,Min(EqArea.Top+1,EqArea.Bottom));

       EqSizing[0,2]:=Rect(0,EqArea.Bottom,EqArea.Left,pn.TransparentTop.Height);
       EqSizing[1,2]:=Rect(EqArea.Left,EqArea.Bottom,Min(EqArea.Left+1,EqArea.Right),pn.TransparentTop.Height);
       EqSizing[2,2]:=Rect(EqArea.Right,EqArea.Bottom,pn.TransparentTop.Width,pn.TransparentTop.Height);

       RasteringFiles:=EmptyStr;
       for EqY:=0 to 2 do
       for EqX:=0 to 2 do
       begin
        EqSize:=EqSizing[EqX,EqY];
        if (EqSize.Left=EqSize.Right) or (EqSize.Bottom=EqSize.Top) then
        begin
         Self.RasteringFile:=EmptyStr;
        end else
        begin
         if NeedOpaqueImage then pnTopGraph.SetSize(EqSize.Right-EqSize.Left,EqSize.Bottom-EqSize.Top);
         pnTransparentTop.SetSize(EqSize.Right-EqSize.Left,EqSize.Bottom-EqSize.Top);
         if NeedOpaqueImage then pn.TopGraph.DrawTo(pnTopGraph,pnTopGraph.BoundsRect,EqSize);
         pn.TransparentTop.DrawTo(pnTransparentTop,pnTransparentTop.BoundsRect,EqSize);
         Self.RasteringFile:=FinalImageID(pn)+PostFix+EqNaming[EqY,EqX];
         result:=SaveImg(pnTopGraph,pnTransparentTop,Self.RasteringFile,Self.OwnState<>hsNormal,BaseRasteringFile(Self),getPhysicalImageFormat(PhysicalImageFormat,pnTransparentTop),false);
        end;
        RasteringFiles:=RasteringFiles+Self.RasteringFile+'|';
       end;
       RasteringFiles:=RasteringFiles+inttostr(EqArea.Top)+'|'+inttostr(pn.TransparentTop.Height-EqArea.Bottom)+'|'+inttostr(EqArea.Left)+'|'+inttostr(pn.TransparentTop.Width-EqArea.Right)+'|';
       Self.RasteringFile:=RasteringFiles;
      finally
       pn.TransparentTop.DrawMode:=pnTransparentTop.DrawMode;
       if NeedOpaqueImage then pnTopGraph.Free;
       pnTransparentTop.Free;
      end;
      result:=true;
      exit;
     end;
    end;
    Self.RasteringFile:=FinalImageID(pn)+PostFix+sst[Self.OwnState];
    result:=SaveImg(pn.TopGraph,pn.TransparentTop,Self.RasteringFile,Self.OwnState<>hsNormal,BaseRasteringFile(Self),getPhysicalImageFormat(PhysicalImageFormat,pn.TransparentTop),true);
   end else
    result:=false;
  end;
end;



function CharRef(i:integer):AnsiString;
begin
 result:='&#x'+AnsiString(Format('%x', [i]))+';';
end;

function CharRefDecimal(i:integer):AnsiString;
begin
 result:='&#'+AnsiString(Format('%d', [i]))+';';
end;

function hh(i:integer):AString;
begin
 result:=inttohex(i,8);
end;

           {
function XMLconformant(const s:AnsiString):AnsiString;
var i,o:Integer;
    ch:WideChar;
begin
 result:='';
 for i:=1 to length(s) do
 if (s[i]='&') and not(FindUniClose(s,i+1,o) and getUnicodeChar(abscopy(s,i+1,o-1),ch)) then
 begin
  result:=result+'&amp;';
 end else
  result:=result+s[i];
 //todo: check for < and >
end;     }

function LE127(const s:WideString):AnsiString;
var i:Integer;
begin
 result:='';
 for i:=1 to length(s) do
 if (ord(s[i])>127) then
  result:=result+CharRef(ord(s[i])) else
  result:=result+AnsiChar(s[i]);
end;

function ContainsPHPTag(const s:HypeString):boolean;
const PHP_TAG_PREFIX:HypeString='<?';
begin
 result:=Pos(PHP_TAG_PREFIX,s)<>0;
end;

function IsPHP(Self:TdhPage):boolean;

function FindPHP(p:TWinControl; ori:TdhPage):boolean;
var i:integer;
    page:TdhPage;
begin
 if p is TdhCustomPanel then
 begin
  if ContainsPHPTag(TdhCustomPanel(p).AllHTMLCode) then
  begin
   result:=true;
   exit;
  end;
 end;
 for i:=0 to p.ControlCount-1 do
 begin
 if (p.Controls[i] is TdhPage) then
 begin
  page:=TdhPage(p.Controls[i]);
  if page.IsHTMLBody then
    continue;
  if page.PageControl<>nil then
  if page.PageControl.IsVirtualParentOf(ori) then
  begin
   if not page.IsVirtualParentOf(ori) then
    continue;
  end else
  if not page.IsLaterSelected then
    continue;
 end;
 if (p.Controls[i] is TWinControl) and FindPHP(TWinControl(p.Controls[i]),ori) then
 begin
  result:=true;
  exit;
 end;
 end;
 result:=false;
end;

var p:TControl;
begin
 p:=self;
 while (p<>nil) do
 begin
  if (p is TdhPage) and TdhPage(p).IsHTMLBody then
  begin
   result:=FindPHP(TdhPage(p),self);
   exit;
  end;
  p:=p.Parent;
 end;
 result:=false;
end;


function FinalGeneratedJavaScriptFile(const GeneratedJavaScriptFile:TPathName):TPathName;
begin
 if (GeneratedJavaScriptFile='') or IsAbsolute(GoodWebPathDelimiters(GeneratedJavaScriptFile)) then
  result:='dfm2html.js' else
  begin
   result:=GeneratedJavaScriptFile;
   if System.Pos('.js',LowerCase(result))=0 then
    result:=result+'.js';
  end;
 result:=GoodWebPathDelimiters(result);
end;

function FinalGeneratedCSSFile(const GeneratedCSSFile:TPathName):TPathName;
begin
 if (GeneratedCSSFile='') or IsAbsolute(GoodWebPathDelimiters(GeneratedCSSFile)) then
  result:='' else
  begin
   result:=GeneratedCSSFile;
   if System.Pos('.css',LowerCase(result))=0 then
    result:=result+'.css';
  end;
 result:=GoodWebPathDelimiters(result);
end;

function AllAlignedTop(Self:TWinControl):boolean;
var i:integer;
begin
 for i:=0 to Self.ControlCount-1 do
 if (Self.Controls[i].Align<>alTop) and (Self.Controls[i].Owner<>Self) and (Self.Controls[i].Owner=Self.Owner) then
 begin
  result:=false;
  exit;
 end;
 result:=Self.ControlCount<>0; //wenn keine Kindelemente, dann nicht autosize!
end;

function AutoSizeX(Self:TControl):boolean;
begin
 result:={Self.AutoSize and not}((self is TdhCustomPanel) and {not} (TdhCustomPanel(self).FAutoSize in [asX,asXY]));
 if result and (csAcceptsControls in Self.ControlStyle) and (Self is TWinControl) then
  result:=AllAlignedTop(TWinControl(Self));
end;

function AutoSizeY(Self:TControl):boolean;
begin
 result:={Self.AutoSize and not}((self is TdhCustomPanel) and {not} (TdhCustomPanel(self).FAutoSize in [asY,asXY])) and not (Self.Align in [alLeft,alRight]);
 if result and (csAcceptsControls in Self.ControlStyle) and (Self is TWinControl) then
  result:=AllAlignedTop(TWinControl(Self));
 if result and (Self is TdhCustomPanel) then
  result:=TdhFakeCustomPanel(Self).AllowAutoSizeY;
end;


function CanAutoSizeX(Self:TControl):boolean;
begin
 if Self.Align=alBottom then
 begin
  result:=false;
  exit;
 end;
 if (Self.Align=alTop) and (Self.Parent is TdhCustomPanel) and TdhCustomPanel(Self.Parent).IsScrollArea then
 begin
  result:=false;//because a width must be provided when applying the IE selection bugfix
  exit;
 end;
 if (Self is TdhCustomPanel) and TdhCustomPanel(Self).HorizontalCenter then
 begin
  result:=false;
  exit;
 end;
 if AutoSizeX(Self) then
 begin
  result:=true;
  exit;
 end;
 if Self.Align<>alTop then
 begin
  result:=false;
  exit;
 end;
 if AutoSizeY(Self) then
 begin
  result:=true;
  exit;
 end;
 Self:=Self.Parent;
 if Self is TTabSheet then
  Self:=Self.Parent;
 while (Self<>nil) do
 begin
  if Self.Parent=nil then
  begin
   result:=true;
   exit;
  end;
  if not AutoSizeX(Self) then
  begin
   result:=true;
   exit;
  end;
  if (Self.Align<>alTop) then
  begin
   result:=false;
   exit;
  end;
  Self:=Self.Parent;
  if Self is TTabSheet then
   Self:=Self.Parent;
 end;
 result:=true;
end;

function RealAutoSizeXY(Self:TControl):TASXY;
begin
 result:=asar[CanAutoSizeX(Self),AutoSizeY(Self)];
end;

function FindPage(c:TControl; var res:TWinControl; RealActivePage:boolean):boolean;
var i:integer;
    r:TdhPage;
begin
 if (c is TdhPageControl) then
 begin
  if RealActivePage then
   r:=TdhPageControl(c).RealActivePage else
   r:=TdhPageControl(c).ActivePage;
  if r<>nil then
  begin
   res:=r;
   result:=true;
   exit;
  end;
 end;
 if c is TWinControl then
 with TWinControl(c) do
 for i:=0 to ControlCount-1 do
 if not((Controls[i] is TdhPage) and (TdhPage(Controls[i]).PageControl<>nil)) then
 if FindPage(Controls[i],res,RealActivePage) then
 begin
  result:=True;
  exit;
 end;
 result:=false;
end;

function GetPageID(LinkPage:TWinControl; FindFile:boolean=False):TControl ;
var apage:TWinControl;
const BottomUp=false;
begin
  apage:=LinkPage;
  if BottomUp then
   while FindPage(apage,apage,true) do
   else
   while (apage is TdhPage) and (TdhPage(apage).PageControl<>nil) do
    apage:=GetParentPage(apage);
  result:=apage;
end;

var AlternativeRasterings:array of record TopPC,ID:TComponentName;Rastering:TPathName; end;

function AdjustAlternativeRastering(const TopPC,ID:TComponentName; var Rastering:TPathName):boolean;
var i:integer;
begin
 result:=true;
 for i := 0 to High(AlternativeRasterings) do
 if (AlternativeRasterings[i].TopPC=TopPC) and (AlternativeRasterings[i].ID=ID) then
 begin
  Rastering:=AlternativeRasterings[i].Rastering;
  exit;
 end;
end;

function GetInitialProps(Self:TdhPage):AString;
var PropChoose:TPropChoose;
    s:AString;
begin
 s:='';
 for PropChoose:=low(TPropChoose) to high(TPropChoose) do
 begin
 if not (Self.GetVal(PropChoose) and not Self.IsInUseList(ValStyle)) then
  continue;
 if not((PropChoose=pcColor) and (Cascaded.Color=clBlackCSS) or (PropChoose=pcBackgroundColor) or (PropChoose=pcFontStyle) and (Cascaded.FontStyle=cfsNormal) or (PropChoose=pcFontWeight) and (Cascaded.FontWeight=cfwNormal)) then
  s:=s+GetCSSPropName(PropChoose)+':'+GetCSSPropValue(PropChoose)+';';
 end;
 result:=s;
end;

function HasSubTS(p:TdhCustomPanel):boolean;
var i:integer;
begin
 if not p.IsScrollArea then
 for i:=0 to p.ControlCount-1 do
 if (p.Controls[i] is TdhCustomPanel) and (TdhFakeCustomPanel(p.Controls[i]).CanBeTopPC or HasSubTS(TdhCustomPanel(p.Controls[i]))) then
 begin
  result:=true;
  exit;
 end;
 result:=false;
end;

function DecPoint(const a:TPoint; const b:TPoint):TPoint;
begin
 result.X:=a.X-b.X;
 result.Y:=a.Y-b.Y;
end;

function GetTotalPos(Self:TdhFakeMenu):TPoint;
var p:TWinControl;
    pn:TdhCustomPanel;
begin
 assert(Self.IsVirtual);

 Result:=AddPoint(Self.GetRelativePos,Self.ComputedMenuPos);
 p:=Self.VirtualParent.Parent;
 while p<>nil do
 begin
  if (p is TdhCustomPanel) and TdhCustomPanel(p).IsAbsolutePositioned then
  begin
   pn:=TdhCustomPanel(p);
   if pn.IsRastered(false)=rsNo then
    Result:=AddPoint(Result,pn.BorderPure.TopLeft);
  end;
  p:=p.Parent;
 end;

 p:=Self.VirtualParent as TWinControl;
 if (p is TdhCustomPanel) then
 begin
  pn:=TdhCustomPanel(p);
  if pn.IsRastered(false)=rsNo then
   Result:=DecPoint(Result,pn.MarginPure.TopLeft);
 end;

end;

function ProposedFileName(Self:TdhFile):TPathName;
begin
 result:=FinalID(Self)+ExtractFileExt(TdhFakeFile(Self).FFileName);
end;


function PrepareHTMLFile(Self:TdhFakeFile):TPathName;
var NeedSave:boolean;
    FileData:TFileContents;
    AbsoluteHTMLFileName:TPathName;
    b:boolean;
begin
 result:='';
 if not Assigned(glSaveBin) or not Self.GetData(FileData) then
  exit;
 result:=ProposedFileName(Self);
 b:=glSaveBin(calc_crc32_String(FileData),result,AbsoluteHTMLFileName,false,'',NeedSave,false);
 if NeedSave then
 try
  StringToFile(AbsoluteHTMLFileName,FileData);
  glAfterSaveBin;
 except
  b:=false;
 end;
 if not b then
  result:='';
end;

function UndefFilter(Self:TStyle; IsRastered:boolean):boolean;
var _FPictureID:TPictureID;
    _FPath:TPathName;
    FPicture:TLocationImage;
    Owner:TdhFakeCustomPanel;
begin
  Owner:=TdhFakeCustomPanel(Self.Owner.GetControl);
  if Self.BackgroundImage.HasPicture or IsRastered then
  begin
   _FPictureID:=Self.BackgroundImage.FPictureID;
   _FPath:=Self.BackgroundImage.FPath;
   try
    Self.BackgroundImage.FPictureID:=nil;
    Self.BackgroundImage.FPath:='';
    result:=Owner.HasBackgroundImage(FPicture) and FPicture.ImgIsT1X1;
   finally
    Self.BackgroundImage.FPictureID:=_FPictureID;
    Self.BackgroundImage.FPath:=_FPath;
   end;
  end else
   result:=false;
end;

function BaseBorderColors(Self:TFakeStyle):TColorName;
var PreferDown:boolean;
    Owner:TdhFakeCustomPanel;
begin
  Owner:=TdhFakeCustomPanel(Self.Owner.GetControl);
{ if OwnState=hsNormal then
  result:=EmptyStr else
  result:=Owner.StyleArr[NextStyleOld[Owner.DownOverlayOver,OwnState]].FBorderColors;
} case Self.OwnState of
  hsNormal: result:=EmptyStr;
  hsOver,hsDown: result:=TFakeStyle(Owner.StyleArr[hsNormal]).FBorderColors;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    result:=TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]]).FBorderColors;
    if result=EmptyStr then
     result:=TFakeStyle(Owner.StyleArr[NextStyle[not PreferDown]]).FBorderColors;
    if result=EmptyStr then
     result:=TFakeStyle(Owner.StyleArr[hsNormal]).FBorderColors;
   end;
  end;
end;


function BaseWH(Self:TFakeStyle):TPoint;
var PreferDown:boolean;
    Owner:TdhFakeCustomPanel;
begin
  Owner:=TdhFakeCustomPanel(Self.Owner.GetControl);
{
 if OwnState=hsNormal then
  result:=Point(Owner.Control.Width,Owner.Control.Height) else
  result:=Owner.StyleArr[NextStyleOld[Owner.DownOverlayOver,OwnState]]._ContentWidthHeight; }
 case Self.OwnState of
  hsNormal: result:=Point(Owner.Width,Owner.Height);
  hsOver,hsDown: result:=TFakeStyle(Owner.StyleArr[hsNormal])._ContentWidthHeight;
  hsOverDown:
  begin
   PreferDown:=Owner.GetPreferDownStyles;
   if TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]]).IsWidthStored then
    result.X:=TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]])._ContentWidthHeight.X else
    result.X:=TFakeStyle(Owner.StyleArr[NextStyle[not PreferDown]])._ContentWidthHeight.X;
   if TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]]).IsHeightStored then
    result.Y:=TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]])._ContentWidthHeight.Y else
    result.Y:=TFakeStyle(Owner.StyleArr[NextStyle[not PreferDown]])._ContentWidthHeight.Y;
  end;
 end;
end;


function BasePadding(Self:TFakeStyle; IgnoreCSS:TRasterType):TRect;
var PreferDown:boolean;
var sStyleArr:TStyleArray;
    Owner:TdhFakeCustomPanel;
begin
  Owner:=TdhFakeCustomPanel(Self.Owner.GetControl);
 {if OwnState=hsNormal then
  result:=Owner.PaddingPure else
  result:=Owner.StyleArr[NextStyle[Owner.DownOverlayOver,OwnState]]._BasePadding;   }
 case Self.OwnState of
  hsNormal: ;
  hsOver,hsDown:
  if TFakeStyle(Owner.StyleArr[hsNormal]).IsNewPaddingStored then
  begin
   result:=TFakeStyle(Owner.StyleArr[hsNormal])._BasePadding;
   exit;
  end;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    if TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]]).IsNewPaddingStored then
    begin
     result:=TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]])._BasePadding;
     exit;
    end else
    if TFakeStyle(Owner.StyleArr[NextStyle[not PreferDown]]).IsNewPaddingStored then
    begin
     result:=TFakeStyle(Owner.StyleArr[NextStyle[not PreferDown]])._BasePadding;
     exit;
    end else
    if TFakeStyle(Owner.StyleArr[hsNormal]).IsNewPaddingStored then
    begin
     result:=TFakeStyle(Owner.StyleArr[hsNormal])._BasePadding;
     exit;
    end;
   end;
  end;

  if EnableIgnoreCSS and (IgnoreCSS=rsFull) then
  begin
   Owner.LockDefinedCSS(sStyleArr);
   result:=Owner.PaddingPure;
   Owner.UnlockDefinedCSS(sStyleArr);
  end else
   result:=Owner.PaddingPure
end;

function BaseMargin(Self:TFakeStyle; IgnoreCSS:TRasterType):TRect;
var PreferDown:boolean;
var sStyleArr:TStyleArray;
    Owner:TdhFakeCustomPanel;
begin
  Owner:=TdhFakeCustomPanel(Self.Owner.GetControl);
 {if OwnState=hsNormal then
  result:=Owner.MarginPure else
  result:=Owner.StyleArr[NextStyle[Owner.DownOverlayOver,OwnState]]._BaseMargin;   }
 case Self.OwnState of
  hsNormal: ;
  hsOver,hsDown:
  if TFakeStyle(Owner.StyleArr[hsNormal]).IsNewMarginStored then
  begin
   result:=TFakeStyle(Owner.StyleArr[hsNormal])._BaseMargin;
   exit;
  end;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    if TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]]).IsNewMarginStored then
    begin
     result:=TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]])._BaseMargin;
     exit;
    end else
    if TFakeStyle(Owner.StyleArr[NextStyle[not PreferDown]]).IsNewMarginStored then
    begin
     result:=TFakeStyle(Owner.StyleArr[NextStyle[not PreferDown]])._BaseMargin;
     exit;
    end else
    if TFakeStyle(Owner.StyleArr[hsNormal]).IsNewMarginStored then
    begin
     result:=TFakeStyle(Owner.StyleArr[hsNormal])._BaseMargin;
     exit;
    end;
   end;
  end;

  if EnableIgnoreCSS and (IgnoreCSS=rsFull) then
  begin
   Owner.LockDefinedCSS(sStyleArr);
   result:=Owner.MarginPure;
   Owner.UnlockDefinedCSS(sStyleArr);
  end else
   result:=Owner.MarginPure;
end;

function BaseBorder(Self:TFakeStyle; IgnoreCSS:TRasterType):TRect;
var PreferDown:boolean;
var sStyleArr:TStyleArray;
    Owner:TdhFakeCustomPanel;
begin
  Owner:=TdhFakeCustomPanel(Self.Owner.GetControl);
 {if OwnState=hsNormal then
  result:=Owner.BorderPure else
  result:=Owner.StyleArr[NextStyle[Owner.DownOverlayOver,OwnState]]._BaseBorder;   }
 case Self.OwnState of
  hsNormal: ;
  hsOver,hsDown:
  if TFakeStyle(Owner.StyleArr[hsNormal]).IsNewBorderStored then
  begin
   result:=TFakeStyle(Owner.StyleArr[hsNormal])._BaseBorder;
   exit;
  end;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    if TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]]).IsNewBorderStored then
    begin
     result:=TFakeStyle(Owner.StyleArr[NextStyle[PreferDown]])._BaseBorder;
     exit;
    end else
    if TFakeStyle(Owner.StyleArr[NextStyle[not PreferDown]]).IsNewBorderStored then
    begin
     result:=TFakeStyle(Owner.StyleArr[NextStyle[not PreferDown]])._BaseBorder;
     exit;
    end else
    if TFakeStyle(Owner.StyleArr[hsNormal]).IsNewBorderStored then
    begin
     result:=TFakeStyle(Owner.StyleArr[hsNormal])._BaseBorder;
     exit;
    end;
   end;
  end;

  if EnableIgnoreCSS and (IgnoreCSS=rsFull) then
  begin
   Owner.LockDefinedCSS(sStyleArr);
   result:=Owner.BorderPure;
   Owner.UnlockDefinedCSS(sStyleArr);
  end else
   result:=Owner.BorderPure;
end;

function CalculateBorderColors(Self:TFakeStyle):TColorName;
var Align:TEdgeAlign;
    NeedCompact,NeedColor:boolean;
    BorderColors:array[TEdgeAlign] of TColorName;
    Owner:TdhFakeCustomPanel;
begin
  Owner:=TdhFakeCustomPanel(Self.Owner.GetControl);
 NeedColor:=false;
 for Align:=ealTop to ealRight do
 if not NeedColor and not Owner.HasVal(pcBorderColor,Align) then
 if Owner.GetSpecialBorderType in [sbtEdit,sbtButton] then
  NeedColor:=not (Owner.BorderStyle(Align) in [cbsGroove,cbsRidge,cbsInset,cbsOutSet]) else
  {NeedColor:=Color32(Owner.FontColor)<>clBlack32};

 if NeedColor then
 for Align:=ealTop to ealRight do
 begin
  BorderColors[Align]:=dhPanel.ColorToIntString(Owner.BorderColor(Align));
 end;
 Self.FBorderColors:=GetShorter(BorderColors[ealTop],BorderColors[ealRight],BorderColors[ealBottom],BorderColors[ealLeft]);
 if (Self.FBorderColors<>EmptyStr) and (Self.FBorderColors=BaseBorderColors(Self)) then
  Self.FBorderColors:=EmptyStr;
 result:=Self.FBorderColors;
end;





procedure DoDefineProperties(Filer: TMyWriter; Self:TdhFakePage); overload;
var P:TControl;
    pn:TdhCustomPanel;
    addheight:integer;
begin
  if (Self.PageControl<>nil) and (Self.PageControl.ActivePage<>nil) then
   Filer.DefineIntegerProperty('HeightDiff', Self.Height-Self.PageControl.ActivePage.Height,0);
  Filer.DefineBooleanProperty('Selected', Self.IsLaterSelected);
  if Self.IsHTMLBody then Filer.DefineStringProperty('InitialProps', GetInitialProps(Self));
  Filer.DefineBooleanProperty('IsPHP', IsPHP(Self));

  if Self.IsTopScrollable then
  begin
    SetLength(AlternativeRasterings,0);
  end;
  if not Self.CanBeTopPC or HasSubTS(Self) then exit;
  addheight:=0;
  P:=Self;
  while P is TdhCustomPanel do
  begin
   pn:=TdhCustomPanel(P);
   if pn.IsScrollArea then break;
   if pn<>self then
   if (pn.IsRastered(false)<>rsNo) and Assigned(glSaveBin) and PrepareRastering(TFakeStyle(pn.Style),addheight,'_'+Self.Name) then
   begin
    SetLength(AlternativeRasterings,Length(AlternativeRasterings)+1);
    with AlternativeRasterings[High(AlternativeRasterings)] do
    begin
     TopPC:=Self.Name;
     ID:=pn.Name;
     Rastering:=pn.Style.RasteringFile;
    end;
   end;
   inc(addheight,pn.HeightDiff);
   p:=p.Parent;
  end;

end;


procedure DoDefineProperties(Filer: TMyWriter; Self:TdhFakeMenu); overload;
begin
  if not Self.IsInlineMenu and Self.IsVirtual then
   Filer.DefineIntegerProperty('RealMenuLeft', GetTotalPos(Self).X);
  if not Self.IsInlineMenu and Self.IsVirtual then
   Filer.DefineIntegerProperty('RealMenuTop', GetTotalPos(Self).Y);
  if {(moStatic in ComputedMenu.FMenuOptions) and }Self.IsInlineMenu and (Self.FParentMenuItem<>nil) and (Self.FParentMenuItem.LinkPage<>nil) and not Self.FParentMenuItem.LinkPage.DynamicNavigation then
   Filer.DefineStringProperty('OnlyIf', FinalID(Self.FParentMenuItem.LinkPage));
  if moSlide in Self.ComputedMenu.MenuOptions then with GetAddRect(Self.PaddingPure,Self.BorderPure) do
   Filer.DefineIntegerProperty('padw', Left+Right);
  if (Self.FParentMenuItem<>nil) and Self.IsInlineMenu and (Self.Align=alTop) then
   Filer.DefineIntegerProperty('AlPos', Self.FParentMenuItem.Top+1);
end;

procedure DoDefineProperties(Filer: TMyWriter; Self:TdhFakeLink); overload;
var NotSelfTargeted:boolean;
begin
  NotSelfTargeted:=(Self.FLinkPage<>nil) and (GetPageID(GetParentPage(Self),True)<>GetPageID(Self.FLinkPage,True));
  Filer.DefineBooleanProperty('NeedJS', Self.NeedJS);
  Filer.DefineBooleanProperty('NeedID', Self.NeedID);
  Filer.DefineBooleanProperty('Linked', (Self.FLinkPage<>nil) and Self.FLinkPage.IsLaterSelected and (Self.GetLastPage=nil) and (NotSelfTargeted or Self.FLinkPage.DynamicNavigation));
  if (Self.GetLastPage<>nil) and Self.FLinkPage.DynamicNavigation and not NotSelfTargeted then
   Filer.DefineStringProperty('RealLastPage', FinalID(Self.RealLastPage),'');
  if (Self.FLinkPage<>nil) and Self.FLinkPage.DynamicNavigation and not NotSelfTargeted then
   Filer.DefineStringProperty('RealLinkPage', FinalID(Self.RealLinkPage));
  Filer.DefineBooleanProperty('NotIfUrl', (Self.FLinkPage<>nil) and not (loDownIfUrl in Self.ComputedOptions) and (NotSelfTargeted or Self.FLinkPage.DynamicNavigation));
end;


procedure DoDefineProperties(Filer: TMyWriter; Self:TdhFakeDynLabel); overload;
const sLinkType:array[TLinkType] of string=('ltAuto','ltText','ltLink','ltButton');
begin
 Filer.DefineStringProperty('ComputedLayout', sLinkType[Self.ComputedLayout], sLinkType[Self.GetDefaultLayout]);
end;


procedure DoDefineProperties(Filer: TMyWriter; Self:TdhSelect); overload;

function GetHTMLOptions:HypeString;
var i:integer;
    s:HypeString;
begin
 s:='';
 for i:=0 to Self.Count-1 do
 begin
  s:=s+'<option';
  if Self.Items[i].Value<>'' then
   s:=s+' value="'+ConvertWideStringToUnicode(Self.Items[i].Value,true)+'"';
  if Self.Items[i].Selected then
   s:=s+' selected="selected"';
  s:=s+'>'+ConvertWideStringToUnicode(Self.Items[i].Text,true)+'</option>';
 end;
 result:=s;
end;

begin
 Filer.DefineStringProperty('HTMLOptions', GetHTMLOptions, '');
end;

procedure DoDefineProperties(Filer: TMyWriter; Self:TdhHTMLForm); overload;

function HasFileUpload(p:TWinControl):boolean;
var i:integer;
begin
 if p is TdhFileField then
 begin
  result:=true;
  exit;
 end;
 for i:=0 to p.ControlCount-1 do
 if (p.Controls[i] is TWinControl) and HasFileUpload(TWinControl(p.Controls[i])) then
 begin
  result:=true;
  exit;
 end;
 result:=false;
end;

begin
 Filer.DefineBooleanProperty('FileUpload', HasFileUpload(self));
end;


procedure DoDefineProperties(Filer: TMyWriter; Self:TdhFakeFile); overload;
var InvalidFile:boolean;
    HTMLFileName:TPathName;
begin
  HTMLFileName:=PrepareHTMLFile(Self);
  InvalidFile:=false;
  if Assigned(glSaveBin) and (HTMLFileName='') and Self.HasFile then
  begin
   HTMLFileName:=ProposedFileName(Self);
   InvalidFile:=true;
  end;
  Filer.DefineStringProperty('HTMLFileName', HTMLFileName, '');
  Filer.DefineBooleanProperty('InvalidFile', InvalidFile);
end;


procedure DoDefineProperties(Filer:TMyWriter; Self:TdhFakeCustomEdit); overload;
var NewWidth, NewHeight, Rows, Cols:integer;
begin
 NewWidth:=Self.Width;
 NewHeight:=Self.Height;
 Self.GetRowsCols(Self.CanAutoX, Self.CanAutoY, NewWidth, NewHeight, Rows, Cols);
 Filer.DefineIntegerProperty('Rows', Rows, 0);
 Filer.DefineIntegerProperty('Columns', Cols, 0);
end;

procedure DoDefineProperties(Filer:TMyWriter; Self:TdhFakeCustomPanel); overload;
var NeedClientArea,NeedMargin:boolean;
    HasRastering:TRasterType;
    StyleSheet:TdhStyleSheet;
const sASXY:array[TASXY] of String=('asNone','asX','asY','asXY');
begin

 HasRastering:=Self.IsRastered(false);

 Filer.DefineBooleanProperty('TheoreticRastering', (HasRastering<>rsNo) and (HasRastering=rsFull));
 Filer.DefineBooleanProperty('TheoreticRasteringBG', (HasRastering<>rsNo) and (HasRastering<>rsFull));
 Filer.DefineBooleanProperty('img', Self.GetImageType=bitImage);

 if InStylesheet(Self,StyleSheet) then exit;

 if Self.HorizontalCenter then
 with Self.CenterMargins do
 begin
  Filer.DefineIntegerProperty('CenterLeft', X, 0);
  Filer.DefineIntegerProperty('CenterRight',Y, 0);
 end;
 Filer.DefineStringProperty('RealAutoSizeXY', sASXY[RealAutoSizeXY(Self)], sASXY[self.FAutoSize]);
 Filer.DefineBooleanProperty('NeedBlock', Self.GetVal(pcDisplay) and (Cascaded.Display=cdsInline));

 NeedClientArea:=Self.ChildHasAnchor([akLeft, akTop, akRight, akBottom]) and (HasRastering=rsNo);
 if NeedClientArea then
 with Self.GetClientAdjusting do
 begin
  Filer.DefineIntegerProperty('ClientLeft', Left, 0);
  Filer.DefineIntegerProperty('ClientTop', Top, 0);
  Filer.DefineIntegerProperty('ClientBottom', Bottom, 0);
  Filer.DefineIntegerProperty('ClientRight', Right, 0);
 end;

 NeedMargin:= not (csLoading in Self.ComponentState) and (HasRastering=rsNo) and not (Self.IsScrollArea and Self.EdgesInScrolledArea);
 if NeedMargin then
 with self.MarginPure do
 begin
  if Self.Anchors*[akLeft,akRight]=[akRight] then
   Filer.DefineIntegerProperty('MarginHorz', Left+Right, 0);
  if Self.Anchors*[akTop,akBottom]=[akBottom] then
   Filer.DefineIntegerProperty('MarginVert', Top+Bottom, 0);
 end;

 Filer.DefineBooleanProperty('VariableSize', Self.VariableSize );
end;


procedure DoDefineProperties(Filer:TMyWriter; Self:TFakeStyle); overload;
var HasRastering:TRasterType;


var
     R,R2:TRect;
var
    ReallyRastering,ReallyBGImage:boolean;
    _NeedNewPadding,_NeedNewMargin:boolean;
    StyleSheet:TdhStyleSheet;
    Owner:TdhFakeCustomPanel;


procedure ShrinkWH(PutAllToPadding:boolean);
var IE6:TRect;
begin
  PreventAdjustMargin:=true;
  try
   if Owner.IncludeBorderAndPadding then
   begin
    if PutAllToPadding then
    begin
     IE6:=Rect(0,0,0,0);
    end else
    begin
     IE6:=Owner.MarginPure;
    end;
   end else
   begin
    if PutAllToPadding then
    begin
     IE6:=Owner.AllEdgesPure;
    end else
    begin
     IE6:=Owner.AllEdgesPure;
    end;
   end;
  finally
   PreventAdjustMargin:=false;
  end;

   with IE6 do
   begin
   if Self._ContentWidthHeight.X<>NoWH then
    Dec( Self._ContentWidthHeight.X,Left+Right);
   if Self._ContentWidthHeight.Y<>NoWH then
    Dec( Self._ContentWidthHeight.Y,Top+Bottom);
   end;
end;

var ALeft,ATop:integer;

var prev,next:TdhCustomPanel;

procedure GetTopIndexes(pn:TdhCustomPanel; var prev,next:TdhCustomPanel);
var i:integer;
    p:TWinControl;
    c:TControl;
    best_prev,best_next:integer;
    pnTop:integer;
begin
 pnTop:=pn.BoundTop;
 best_prev:=-maxint;
 best_next:=maxint;
 prev:=nil;
 next:=nil;
 p:=pn.Parent;
 for i:=0 to p.ControlCount-1 do
 begin
  c:=p.Controls[i];
  if (c.Align=alTop) and (c is TdhCustomPanel) then
  if (c.Top<pnTop) and (c.Top>best_prev) then
  begin
   best_prev:=c.Top;
   prev:=TdhCustomPanel(c);
  end else
  if (c.Top>pnTop) and (c.Top<best_next) then
  begin
   best_next:=c.Top;
   next:=TdhCustomPanel(c);
  end;
 end;
 if prev is TdhCustomPanel then
 begin
  if (TdhCustomPanel(prev).BoundNextSibling<>pn) and (TdhCustomPanel(prev).BoundNextSibling<>nil) then
   prev:=TdhCustomPanel(prev).BoundNextSibling;
 end;
 if pn.BoundNextSibling<>nil then
  next:=pn.BoundNextSibling;

end;


begin
  Owner:=TdhFakeCustomPanel(Self.Owner.GetControl);

  HasRastering:=Owner.IsRastered(false);
  glPaintOnlyBg:=not (HasRastering in [rsNo{needed for TdhLabel.FocusPreferStyle},rsFull]);

  Owner.SetPreferStyle(Self,false,true);
  try
  Filer.DefineBooleanProperty('T1X1', (HasRastering=rsNo) and Self.BackgroundImage.ImgIsT1X1);
  if (HasRastering<>rsNo) and InStylesheet(Owner,StyleSheet) then
   HasRastering:=rsNo;
  _NeedNewPadding:=Owner.NeedPadding(HasRastering);
  _NeedNewMargin:=(HasRastering<>rsNo) and (Owner.Align=alTop);
  Filer.DefineBooleanProperty('UndefFilter', UndefFilter(Self,HasRastering<>rsNo));

  Filer.DefineStringProperty('BorderColors', CalculateBorderColors(Self),EmptyStr);

  if HasRastering<>rsNo then
  with Owner do
  begin
   InitSelfCBound(Self._ContentWidthHeight);
   if _NeedNewPadding then
   begin
    ShrinkWH(true);
   end;
  end else
  if Owner.HasImage then
  with Owner do
  begin
   Self._ContentWidthHeight:=GetWantedSize;
    ShrinkWH(false);
  end else
  begin
   if {(Self=Owner.FStyle) or }RealAutoSizeXY(Owner)=asXY then
   begin
     Self._ContentWidthHeight:=Point(NoWH,NoWH);
   end else
   begin
    //pn.CalcStrongToWeak(ALeft,ATop,_ContentWidthHeight.X,_ContentWidthHeight.Y);
     Self._ContentWidthHeight:=Point(Owner.Width,Owner.Height);
   end;
   ShrinkWH(false);
  end;

  ReallyRastering:=false;
  if HasRastering<>rsNo then
  if HasSubTS(Owner) then
  begin
   Self.RasteringFile:='x';
   ReallyRastering:=true;
  end else
   ReallyRastering:=Assigned(glSaveBin) and PrepareRastering(Self,0,EmptyStr);
  Filer.DefineStringProperty('Rastering', Self.RasteringFile, ReallyRastering and not glPaintOnlyBg);
  Filer.DefineStringProperty('BGRastering', Self.RasteringFile, ReallyRastering and glPaintOnlyBg);

  ReallyBGImage:=not ReallyRastering and Assigned(glSaveBin) and PrepareBGImage(Self);
  Filer.DefineStringProperty('BackgroundImageUrl', Self.BGImageFile, ReallyBGImage);


  if Owner.IsScrollArea and Owner.EdgesInScrolledArea then
  begin
   Self._ContentWidthHeight:=Point(NoWH,NoWH);
  end;


  Self.IsWidthStored:=(Self._ContentWidthHeight.X<>NoWH) and (Self._ContentWidthHeight.X<>BaseWH(Self).X);
  Self.IsHeightStored:=(Self._ContentWidthHeight.Y<>NoWH) and (Self._ContentWidthHeight.Y<>BaseWH(Self).Y);

  Filer.DefineIntegerProperty('Width', Self._ContentWidthHeight.X, Self.IsWidthStored);
  Filer.DefineIntegerProperty('Height', Self._ContentWidthHeight.Y, Self.IsHeightStored);

  if (Owner.Anchors*[akBottom,akRight]<>[]) then
  begin
   Self._GetWantedSize:=Owner.GetWantedSize;
   Filer.DefineBooleanProperty('NeedRight', Self._GetWantedSize.X<>TFakeStyle(Owner.StyleArr[hsNormal])._GetWantedSize.X);
   Filer.DefineBooleanProperty('NeedBottom',Self._GetWantedSize.Y<>TFakeStyle(Owner.StyleArr[hsNormal])._GetWantedSize.Y);
  end;


  Self.IsNewPaddingStored:=false;
  if _NeedNewPadding then
  begin
   PreventAdjustMargin:=true;
   try
    Self._BasePadding:=Owner.AllEdgesPure;
   finally
    PreventAdjustMargin:=false;
   end;
   Self.IsNewPaddingStored:=true;
  end else
  if (HasRastering<>rsNo) and (Self.OwnState=hsNormal) then
  begin
   Self._BasePadding:=Rect(0,0,0,0);
   Self.IsNewPaddingStored:=true;
  end;
  Self.IsNewPaddingStored:=Self.IsNewPaddingStored and not EqualRect(Self._BasePadding,BasePadding(Self,HasRastering));
  Filer.DefineProperty('NewPadding', nil, Self.WriteNewPadding, Self.IsNewPaddingStored);

  Self.IsNewMarginStored:=false;
  if _NeedNewMargin then
  begin
   Self._BaseMargin:=Rect(0,0,0,0);
   GetTopIndexes(Owner,prev,next);
   if prev<>nil then
   begin
     Self._BaseMargin.Top:={min(}-min(prev.MarginWidthNormalStyle(ealBottom),Owner.MarginWidth(ealTop)){,prev.StyleArr[hsNormal]._BaseMargin.Bottom)};
   end;
   if next<>nil then
   begin
     Self._BaseMargin.Bottom:={min(}-min(next.MarginWidthNormalStyle(ealTop),Owner.MarginWidth(ealBottom)){,next.StyleArr[hsNormal]._BaseMargin.Top)};
   end;
   Self.IsNewMarginStored:=true;
  end else
  if ((HasRastering<>rsNo) or Self.IsNewPaddingStored) then
  begin
   Self._BaseMargin:=Rect(0,0,0,0);
   Self.IsNewMarginStored:=true;
  end;
  Self.IsNewMarginStored:=Self.IsNewMarginStored and not EqualRect(Self._BaseMargin,BaseMargin(Self,HasRastering));
  Filer.DefineProperty('NewMargin', nil, Self.WriteNewMargin, Self.IsNewMarginStored);

  Self.IsNewBorderStored:=false;
  if ((HasRastering<>rsNo) or Self.IsNewPaddingStored) then
  begin
   Self._BaseBorder:=Rect(0,0,0,0);
   Self.IsNewBorderStored:=true;
  end;
  Self.IsNewBorderStored:=Self.IsNewBorderStored and not EqualRect(Self._BaseBorder,BaseBorder(Self,HasRastering));
  Filer.DefineStringProperty('NewBorder', '0px', Self.IsNewBorderStored);
  finally
   Owner.SetPreferStyle(nil,false,true);
   glPaintOnlyBg:=false;
  end;
end;

procedure TMyWriter.DefineBooleanProperty(const Name: string; Value: Boolean);
begin
 if Value then
  DefineProperty(Name,nil,WriteTrue,True);
end;

procedure TMyWriter.DefineIntegerProperty(const Name: string; Value: Integer; DefaultValue: Integer);
begin
 if Value<>DefaultValue then
 begin
  FIntegerValue:=Value;
  DefineProperty(Name,nil,WriteIntegerValue,True);
 end;
end;

procedure TMyWriter.DefineIntegerProperty(const Name: string; Value: Integer; HasData: boolean);
begin
 if HasData then
 begin
  FIntegerValue:=Value;
  DefineProperty(Name,nil,WriteIntegerValue,True);
 end;
end;

procedure TMyWriter.DefineIntegerProperty(const Name: string; Value: Integer);
begin
  FIntegerValue:=Value;
  DefineProperty(Name,nil,WriteIntegerValue,True);
end;

procedure TMyWriter.DefineStringProperty(const Name: string; Value: string; DefaultValue: string);
begin
 if Value<>DefaultValue then
 begin
  FStringValue:=Value;
  DefineProperty(Name,nil,WriteStringValue,True);
 end;
end;

procedure TMyWriter.DefineStringProperty(const Name: string; Value: string; HasData: boolean);
begin
 if HasData then
 begin
  FStringValue:=Value;
  DefineProperty(Name,nil,WriteStringValue,True);
 end;
end;

procedure TMyWriter.DefineStringProperty(const Name: string; Value: string);
begin
  FStringValue:=Value;
  DefineProperty(Name,nil,WriteStringValue,True);
end;

procedure TMyWriter.WriteTrue(Writer: TWriter);
begin
 Writer.WriteBoolean(true);
end;

procedure TMyWriter.WriteIntegerValue(Writer: TWriter);
begin
 Writer.WriteInteger(FIntegerValue);
end;

procedure TMyWriter.WriteStringValue(Writer: TWriter);
begin
 Writer.WriteString(FStringValue);
end;

procedure TMyWriter.OnDefineProperties(Sender: TObject);
begin
 if not WithMeta then exit;
 if Sender is TStyle then
  DoDefineProperties(Self,TFakeStyle(Sender));
 if Sender is TdhCustomPanel then
  DoDefineProperties(Self,TdhFakeCustomPanel(Sender));
 if Sender is TdhCustomEdit then
  DoDefineProperties(Self,TdhFakeCustomEdit(Sender));
 if Sender is TdhFile then
  DoDefineProperties(Self,TdhFakeFile(Sender));
 if Sender is TdhHTMLForm then
  DoDefineProperties(Self,TdhHTMLForm(Sender));
 if Sender is TdhSelect then
  DoDefineProperties(Self,TdhSelect(Sender));
 if Sender is TdhDynLabel then
  DoDefineProperties(Self,TdhFakeDynLabel(Sender));
 if Sender is TdhLink then
  DoDefineProperties(Self,TdhFakeLink(Sender));
 if Sender is TdhMenu then
  DoDefineProperties(Self,TdhFakeMenu(Sender));
 if Sender is TdhPage then
  DoDefineProperties(Self,TdhFakePage(Sender));
// if Sender is TdhOleContainer then
//  DoDefineProperties(Self,TdhOleContainer(Sender));
end;

initialization

 hh(0);

end.
