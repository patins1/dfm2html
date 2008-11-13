unit dhFile;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls, QGraphics,
  {$ELSE}
  Controls, Windows, Messages, forms, Graphics,

  {$ENDIF}
   SysUtils, Classes,  dhPanel,GR32,dhLabel,crc,math;


type

  TFileUsage=(fuPure,fuFlash,fuMusic,fuJavascript);

  TdhFile = class(TdhPanel)
  private
    FData:String;
    FFileName:String;
    HTMLFileName:String;
    FUsage: TFileUsage;
    FLoop: boolean;
    FLinked: boolean;
    procedure WriteData(Stream: TStream);
    procedure ReadData(Stream: TStream);
    function PrepareHTMLFile: boolean;
    procedure WriteHTMLFileName(Writer: TWriter);
    procedure SetUsage(const Value: TFileUsage);
    function IsLoopStored: Boolean;
    procedure SetLinked(const Value: boolean);
  protected
    //procedure CreateParams(var Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetData(var FileData:String):boolean;
  public
    function ProposedFileName: String;
    function HasFile:Boolean;
    function FileSize:integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure LoadFromFile(const FileName:String; Linked:boolean);
    //procedure SaveToFile(const FileName:String);
    procedure DoTopPainting; override;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    function EffectsAllowed: boolean; override;

    procedure SetPath(const Path:String);
    function GetRelativePath:String;
    function GetAbsolutePath:String;
  published
    property FileName:String read GetRelativePath write SetPath;
    property Usage:TFileUsage read FUsage write SetUsage default fuPure;
    property Loop:boolean read FLoop write FLoop stored IsLoopStored;
    property Linked:boolean read FLinked write SetLinked;

    //property Center;

    property HTMLAttributes;
    property ImageType;
    property ImageFormat;

    property Style;
    property Use;
    property Transparent;
    property AutoSizeXY;

    property Color;
    property Font;
    property Visible;

    {not interpreted:}
    //property AutoSize;
    property Align;
    property Anchors;
    property Constraints;
    property Cursor;
{    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
}
    property Enabled;
//    property FullRepaint;
//    property Locked;
//    property ParentBiDiMode;
//    property ParentColor;
//    property ParentCtl3D;
//    property ParentFont;
    property ParentShowHint;
//    property PopupMenu;
    property ShowHint;
//    property TabStop;


    {property OnCanResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock; }

    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;

  end;

procedure Register;

implementation

var PageControlBitmap:TBitmap=nil;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhFile]);
end;



constructor TdhFile.Create(AOwner: TComponent);
begin
  inherited;
  //FTransparentColor:=colInherit;
  ControlStyle:=ControlStyle-[csAcceptsControls];
  AutoSizeXY:=asXY;
  Width:=226;
end;




procedure TdhFile.DefineProperties(Filer: TFiler);
var ReallyFile,InvalidFile:boolean;
begin
  inherited;
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, HasFile and not Linked);
  if not WithMeta and (Filer is TWriter) then exit;
  ReallyFile:=not (csLoading in ComponentState) and Assigned(glSaveBin) and PrepareHTMLFile;
  InvalidFile:=false;
  if not (csLoading in ComponentState) and Assigned(glSaveBin) and not ReallyFile and HasFile then
  begin
   HTMLFileName:=ProposedFileName;
   ReallyFile:=true;     
   InvalidFile:=true;
  end;
  Filer.DefineProperty('HTMLFileName', SkipValue, WriteHTMLFileName, ReallyFile);
  Filer.DefineProperty('InvalidFile', SkipValue, WriteTrue, InvalidFile);
end;

destructor TdhFile.Destroy;
begin
  inherited;
end;

procedure TdhFile.Invalidate;
begin
  inherited;
end;

procedure TdhFile.WriteData(Stream: TStream);
var DataSize:integer;
begin
  DataSize:=Length(FData);
  Stream.WriteBuffer(DataSize, SizeOf(DataSize));
  if DataSize<>0 then
   Stream.WriteBuffer(FData[1], DataSize);
end;


procedure TdhFile.ReadData(Stream: TStream);
var DataSize:integer;
begin
  Stream.ReadBuffer(DataSize, SizeOf(DataSize));
  SetLength(FData,DataSize);
  if DataSize<>0 then
   Stream.ReadBuffer(FData[1], DataSize);
end;


function StringFromFile(const FileName:string):string;
begin
 with TFileStream.create(FileName,fmOpenRead) do
 try
  SetLength(Result,Size);
  if Size<>0 then
   ReadBuffer(Result[1],Size);
 finally
  Free;
 end;
end;

procedure TdhFile.LoadFromFile(const FileName:String; Linked:boolean);
begin
 if not Linked then
 begin
  FData:=StringFromFile(FileName);
 end else
 begin
  StringFromFile(FileName);
  FData:='';
 end;
 FFileName:=FileName;
 FLinked:=Linked;
end;

procedure StringToFile(const FileName,s:string);
begin
 with TFileStream.create(FileName,fmCreate) do
 begin
  if s<>'' then
   WriteBuffer(s[1],length(s));
  Free;
 end;
end;


                               {
procedure TdhFile.SaveToFile(const FileName:String);
begin
 StringToFile(FileName,GetData);
// Writer.WriteString(ole.SourceDoc);
end;                            }

procedure TdhFile.DoTopPainting;
var rct:TRect;
begin
 if (csDesigning in ComponentState) then
 begin
   if (PageControlBitmap=nil) then
   begin
    PageControlBitmap := TBitmap.Create;
    PageControlBitmap.LoadFromResourceName(HInstance, 'TDHFILEPURE');
    PageControlBitmap.Transparent:=true;
    PageControlBitmap.TransparentColor:=clYellow;
   end;

  if (PageControlBitmap<>nil) then
  if not IsRasterized and not HasBackgroundImage then
  //with self.FCommon.AllEdgesPure do GetCanvas.Draw(Top,Left,TempBitmap);
  //GetCanvas.Draw(Max(0,(Width-TempBitmap.Width) div 2),Max(0,(Height-TempBitmap.Height) div 2),TempBitmap);
  with Self.AllEdgesPure do
   GetCanvas.Draw(max(0,-3+Left),max(0,-3+Top),PageControlBitmap);
 end;

 begin
  PaintOuterBorder;
  PaintOuterBg;
  DrawFrame;
 end;
 // inherited;
// PaintOuterBg;
// FCommon.SpecialPaintBorder(FCommon.MarginClientRect,FCommon.BorderClientRect);
end;


function TdhFile.EffectsAllowed: boolean;
begin
 result:=false;
end;



procedure TdhFile.GetAutoRect(AllowModifyX, AllowModifyY: boolean;
  var NewWidth, NewHeight: Integer);
// NewWidth:=27;
// NewHeight:=22;
var PicWidth,PicHeight,W,H:integer;
begin
 PicWidth:=21;
 PicHeight:=16;
  with AllEdgesPure do
  begin
   W:=PicWidth+Left+Right;
   H:=PicHeight+Top+Bottom;
  end;
  W:=max(W,27);
  H:=max(H,22);
  if not TextOnly then
   AdjustLittle(W,H,false);

 if AllowModifyX then
  NewWidth:=W;
 if AllowModifyY then
  NewHeight:=H;

 GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth,NewHeight);
end;


function TdhFile.HasFile: Boolean;
begin
 result:=FFileName<>'';
end;

procedure TdhFile.WriteHTMLFileName(Writer: TWriter);
begin
 Writer.WriteString(HTMLFileName);
end;

function TdhFile.ProposedFileName:String;
begin
 result:=FinalID(Self)+ExtractFileExt(FFileName);
end;


function TdhFile.PrepareHTMLFile:boolean;
var NeedSave:boolean;
    FileData:String;
    AbsoluteHTMLFileName:String;
begin
 result:=false;
 if not GetData(FileData) then
  exit;
 HTMLFileName:=ProposedFileName;
 result:=glSaveBin(calc_crc32_String(FileData),HTMLFileName,AbsoluteHTMLFileName,false,'',NeedSave,false);
 if NeedSave then
 try
  StringToFile(AbsoluteHTMLFileName,FileData);
  glAfterSaveBin;
 except
  result:=false;
 end;
end;



procedure TdhFile.SetUsage(const Value: TFileUsage);
begin
  FUsage := Value;
end;

function TdhFile.FileSize: Integer;
var f: file of Byte;
begin
 if not Linked then
 begin
  Result:=Length(FData);
  exit;
 end;
 try
    AssignFile(f, GetAbsolutePath);
    Reset(f);
    try
      Result := System.FileSize(f);
    finally
      CloseFile(f);
    end;
 except
   result:=-1;
 end;
end;

function TdhFile.IsLoopStored: Boolean;
begin
 result:=FUsage in [fuFlash,fuMusic];
end;

procedure TdhFile.SetLinked(const Value: boolean);
begin
 if FLinked <> Value then
 begin
  if not (csLoading in ComponentState) and HasFile then
  begin
   LoadFromFile(GetAbsolutePath,Value);
  end else
   FLinked := Value;
 end;
end;

function TdhFile.GetData(var FileData:String): boolean;
begin
 if Linked then
 begin
  try
   FileData:=StringFromFile(GetAbsolutePath);
  except
   Result:=false;
   exit;
  end;
 end else
 begin
  FileData:=FData;
 end;
 result:=true;
end;

procedure TdhFile.SetPath(const Path:String);
var RelativePathProvider:IRelativePathProvider;
begin
  RelativePathProvider:=findIRelativePathProvider(self);
  if RelativePathProvider<>nil then
  begin
   FFileName:=RelativePathProvider.GetAbsolutePath(Path);
   Exit;
  end;
  FFileName:=Path;
end;

function TdhFile.GetRelativePath:String;
var RelativePathProvider:IRelativePathProvider;
begin
  RelativePathProvider:=findIRelativePathProvider(self);
  if RelativePathProvider<>nil then
  begin
   Result:=RelativePathProvider.GetRelativePath(FFileName);
   Exit;
  end;
  Result:=FFileName;
end;

function TdhFile.GetAbsolutePath:String;
var RelativePathProvider:IRelativePathProvider;
begin
  RelativePathProvider:=findIRelativePathProvider(self);
  if RelativePathProvider<>nil then
  begin
   Result:=RelativePathProvider.GetAbsolutePath(FFileName);
   Exit;
  end;
  Result:=FFileName;
end;

initialization

finalization

 FreeAndNil(PageControlBitmap);

end.
