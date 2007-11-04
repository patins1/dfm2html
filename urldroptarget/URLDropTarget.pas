///////////////////////////////////////////////////////
//    Component: TURLDropTarget;
//       Author: Eugene "Jek" Efimochkin from SteamworkS Computer Lab;
//  Description: This component turns its parent form into an URL
//               Drop taget - in runtime you can drag and drop
//               URLs from IE Address bar or even links from the
//               page. As they are dropped, OnDrop event is processed
//               and URL string then appears in URL property;
//   Native VCL: Yes;
//    Copyright: 2002 SteamworkS Computer Lab Of MAEMAE;;
//      License: GNU GPL, see license.txt
//               (or http://www.gnu.org/licenses/gpl.txt);
// Known Issues: Parent form accepts ALL shell links, files and other objects
//               being dropped on it, and local file paths from IE Address bar
//               too? but only web URLs appear then in URL property.

unit URLDropTarget;

interface

uses             
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QMenus,
  QMask,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, Dialogs, Menus,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, Buttons, ActiveX, ShlObj,
{$ENDIF}
  SysUtils, Classes;

const HR_OK=S_OK;
type
  TDragAcceptEvent= procedure (Sender: TObject; var Accept: HRESULT) of object;

  TURLDropTarget = class (TComponent{$IFNDEF CLX}, IDropTarget{$ENDIF})
   protected
{$IFNDEF CLX}
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
     pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function DragOver(grfKeyState: Longint; pt: TPoint;
     var dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
     var dwEffect: Longint): HResult; stdcall;
    function GetURL(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
     var dwEffect: Longint; var FURL:String; _Format:TClipFormat): HResult;
{$ENDIF}
   private
    FURL,FBitmap: string;
    FonDragEnter: TDragAcceptEvent;
    FOnDragLeave: TDragAcceptEvent;
    FOnDragOver: TDragAcceptEvent;
    FonBeforeDrop: TnotifyEvent;
    FonDrop: TNotifyEvent;
   public           
{$IFNDEF CLX}
    constructor Create(AOwner: TComponent);  override;
    procedure BeforeDestruction; override;
{$ENDIF}
    property URL:string read FURL;
    property Bitmap:string read FBitmap;
   published
    property OnDragEnter: TDragAcceptEvent read FOnDragEnter write FOnDragEnter;
    property OnDragOver: TDragAcceptEvent read FOnDragOver write FOnDragOver;
    property OnDragLeave: TDragAcceptEvent read FOnDragLeave write FOnDragLeave;
    property OnBeforeDrop: TnotifyEvent read FonBeforeDrop write FonBeforeDrop;
    property OnDrop: TNotifyEvent read FonDrop write fOnDrop;
 end;


procedure Register;

implementation

{$R *.dcr}
procedure Register;
begin
  RegisterComponents('SteamworkS', [TURLDropTarget]);
end;



{$IFNDEF CLX}

function TURLDropTarget.DragEnter(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult;
begin
 GetURL(dataObj,grfKeyState,pt,dwEffect,FURL,CF_TEXT);
 GetURL(dataObj,grfKeyState,pt,dwEffect,FBitmap,CF_BITMAP);
 If Assigned(FOnDragEnter) Then FOnDragEnter(self,Result) else
 Result := S_OK;
end;

function TURLDropTarget.DragOver(grfKeyState: Longint; pt: TPoint;
 var dwEffect: Longint): HResult;
begin
 If Assigned(FOnDragOver) Then FOnDragOver(self,Result) else
 Result := S_OK;
end;

function TURLDropTarget.DragLeave: HResult;
begin
 If Assigned(FOnDragLeave) Then FOnDragLeave(self,Result) else
 Result := S_OK;
end;

function ReadFilesFromZeroList(Data: pointer; Size: integer;
  Wide: boolean; Files: TStrings): boolean;
var
  StringSize		: integer;
begin
  Result := False;
  if (Data <> nil) then
    while (Size > 0) and (PChar(Data)^ <> #0) do
    begin
      if (Wide) then
      begin
        Files.Add(PWideChar(Data));
        StringSize := (Length(PWideChar(Data)) + 1) * 2;
      end else
      begin
        Files.Add(PChar(Data));
        StringSize := Length(PChar(Data)) + 1;
      end;
      inc(PChar(Data), StringSize);
      dec(Size, StringSize);
      Result := True;
    end;
end;

function ReadFilesFromData(Data: pointer; Size: integer; Files: TStrings): boolean;
var
  Wide			: boolean;
begin
  Files.Clear;
  if (Data <> nil) then
  begin
    Wide := PDropFiles(Data)^.fWide;
    dec(Size, PDropFiles(Data)^.pFiles);
    inc(PChar(Data), PDropFiles(Data)^.pFiles);
    ReadFilesFromZeroList(Data, Size, Wide, Files);
  end;   
  Result := (Files.Count > 0);
end;



function TURLDropTarget.Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
 var dwEffect: Longint): HResult;
var rText,rBitmap:HRESULT;
begin
 If Assigned(FOnBeforeDrop) Then FonBeforeDrop(self);
 rText:=GetURL(dataObj,grfKeyState,pt,dwEffect,FURL,CF_TEXT);
 rBitmap:=GetURL(dataObj,grfKeyState,pt,dwEffect,FBitmap,CF_BITMAP);
 if (rText=S_OK) or (rBitmap=S_OK) then
 begin
  If Assigned(FOnDrop) Then FonDrop(self);
  Result:=S_OK;
 end else
  Result:=rText;
end;




function TURLDropTarget.GetURL(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
 var dwEffect: Longint; var FURL:String; _Format:TClipFormat): HResult;
var
 Format: TFORMATETC;
 Data: TSTGMEDIUM;
 Buffer: PChar;
 Files: TStrings;
 DropFiles:PDropFiles;

begin
 FURL:='';

 with Format do
 begin
   cfFormat := _Format;//CF_TEXT;
{   if NeedGraphic then
    cfFormat := CF_BITMAP;}
   dwAspect := DVASPECT_CONTENT;
   ptd := nil;
   lindex := -1;
   tymed := -1;
 end;
 Result := dataObj.GetData(Format, Data);
 if (Result = S_OK) and (Data.tymed = TYMED_HGLOBAL) then
 begin
   Buffer := GlobalLock(Data.hGlobal);
   FURL := Buffer;
   GlobalFree(Data.hGlobal);
 end else
 begin
   Format.cfFormat := CF_HDROP;
 Result := dataObj.GetData(Format, Data);

 if (Result = S_OK) and (Data.tymed = TYMED_HGLOBAL) then
 begin
   Files:=TStringList.Create;

   DropFiles := PDropFiles(GlobalLock(Data.hGlobal));
   if ReadFilesFromData(DropFiles, GlobalSize(Data.hGlobal), Files) then
   //ReadFilesFromData(@Buffer[4],40,Files);
   //FURL := Buffer;
    FURL:=Files.Text else
    Result:=S_FALSE;
   Files.Free;
   GlobalFree(Data.hGlobal);
 end;
 end;

 while (FURL<>'') and (FURL[Length(FURL)] in [' ',#13,#10]) do Delete(FURL,Length(FURL),1);
end;



procedure TURLDropTarget.BeforeDestruction;
begin
  inherited;
  OleUninitialize;
end;

constructor TURLDropTarget.Create(AOwner: Tcomponent);
begin
  inherited;
  if Succeeded(OleInitialize(nil))  then
//°!°   if OleInitialize(nil) = S_OK  then <- verträgt sich nicht mit VirtualTreeView
     RegisterDragDrop((AOwner as TForm).Handle, Self);
end;

{$ENDIF}


end.
 