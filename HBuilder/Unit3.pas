unit Unit3;

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
  Controls,  Messages, Graphics, Forms, Dialogs,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, ComCtrls,  DKLang, UnicodeCtrls,
{$ENDIF}

  dhHTMLForm,MySiz, dhPanel,dhPageControl, funcutils, UseFastStrings, math, Contnrs, MySpinEdit, MyTrackBar,
  hEdit,hComboBox,hMemo,dhMenu,dhStyleSheet,MySpeedButton,BinTree,uTemplates,
  dhLabel, dhCheckBox, dhRadioButton,UIConstants, MyForm, dhStrUtils, uMetaWriter, dhStyles;


type
  TReason=string;
  TModifyStep=class
    Reason:TReason;
    left_ok,right_ok:integer;
    repl_block:TFileContents;
  private
  public
    procedure SetRepl(const OldDFM: TFileContents);
    function GetOriginal(const NewDFM: TFileContents): TFileContents;
  end;
  THistoryStep=class
    page,selection:TComponentName;
    scrollpos:TPoint;
  end;

  TRelativePathProvider = class (TMyForm,IRelativePathProvider)
    protected
      function RootPath:TPathName; virtual; abstract;
    public
      function GetRelativePath(const Path:TPathName):TPathName;
      function GetAbsolutePath(const Path:TPathName):TPathName;
  end;


  TPageContainer = class(TRelativePathProvider,IDesignerHook)
  private
    { Private declarations }
    FFileName:TPathName;
    FUndo,FRedo,FBackHistory,FForwardHistory:TObjectList;
    NewDFM,PreDFM:TFileContents;
    procedure ComponentRead(Component: TComponent);
    procedure ComponentReadAdjustPos(Component: TComponent);
    procedure SetFileName(const Value: TPathName);
    function GetIsModified: boolean;
    procedure ReadDFM(Content: TFileContents);
    procedure ActDFM;
                        
    procedure DoDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure DoDragDrop(Sender, Source: TObject; X, Y: Integer);

    function GetHistoryStep: THistoryStep;
    procedure GotoHistoryStep(step: THistoryStep);
    function ForPreview:boolean;    
    //function DisplayEasy: boolean;
  protected

    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Activate; override;
    procedure Deactivate; override;
    procedure Resize; override;
    function CloseQuery: Boolean; override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    procedure SetName(const NewName: TComponentName); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure SkipValue(Reader: TReader);
    procedure WriteTrue(Writer: TWriter);
    function PhysicalSave(FileName:TPathName; DeleteHistory:boolean):boolean;
    procedure UpdateActiveMDI(Deactivate:boolean=false);
    procedure SetControlDesigning(c:TComponent; Designing,Transient:boolean);
{$IFDEF CLX}
    function GetClientRect:TRect; override;
{$ENDIF}
    function RootPath:TPathName; override;
  public
    { Public declarations }
    LiveReason:TReason;
    MySiz: TMySiz;
    procedure ValidateRename(AComponent: TComponent;
      const CurName, NewName: string); override;
    procedure SetDesigning(Designing,Transient:boolean);
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    function CanGoForward: boolean;
    function CanGoBack: boolean;
    procedure GoBack;
    procedure GoForward;
    procedure History{(Page: TdhPage; Anchor: TControl)};
    procedure AfterNavigate(Sender:TdhPage);
    procedure GeneratePAS;
    procedure InvalGrid;
    function IsUntitled: boolean;
    property FileName:TPathName read FFileName write SetFileName;
    function GetDFMStr(AsText:boolean; _WithMeta:boolean): TFileContents;
    class function HasOpened(FileName: TPathName; var wh: TPageContainer): boolean;
    procedure PasteComponents(S:TStream);
    procedure CreateBody;
    procedure Open(const AFileName: TPathName; SetUntitled:boolean; BeVisible:boolean=true);
    procedure InitializeRedoUndo;
    function Save: boolean;
    function SaveAs: boolean;
    function SaveAsTemplate: boolean;     
    procedure SaveAsImage(pngfilename:TPathName);
    procedure SetModified(const Reason: TReason; LogChange:TLogChange=lcCommit);
    property IsModified:boolean read GetIsModified;
    function IsLiveModified:boolean;
    procedure UpdateContent;
    procedure Undo;
    function UndoAction: TReason;
    procedure Redo;
    function RedoAction: TReason;
    function CanRedo:boolean;
    function HasSelectedComponents: boolean;
                                 
    function GetRoot: TComponent;
    function GetCustomForm: TCustomForm;
{$IFDEF CLX}
    function IsDesignEvent(Sender: TWidgetControl; SenderHandle: QObjectH; Event: QEventH): Boolean;
{$ELSE}
    function IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean;
{$ENDIF}
    procedure ControlPaintRequest(Control: TControl);
    procedure PaintGrid;
    procedure PaintMenu;
    procedure ValidateRename2(AComponent: TComponent; const CurName, NewName: string);
    procedure IDesignerHook.ValidateRename=ValidateRename2;
    function UniqueName(const BaseName: string): string;
    //property Form: TCustomForm read GetCustomForm;
    //property Root: TComponent read GetRoot;
    procedure Modified;
    procedure Notification2(AnObject: TPersistent; Operation: TOperation);
    procedure IDesignerHook.Notification=Notification2;
    procedure SetCustomForm(Value: TCustomForm);
    function GetIsControl: Boolean;
    procedure SetIsControl(Value: Boolean);
{$IFDEF CLX}
    procedure MouseLeave(AControl: TControl); override;
{$ELSE}
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
{$ENDIF}

    //property IsControl: Boolean read GetIsControl write SetIsControl;
    //property Form: TCustomForm read GetCustomForm write SetCustomForm;
    published
    property FormStyle stored false;
    property Color stored false;
  end;

var WhereToInsert:integer=-1;

procedure GeneralPasteComponents(AOwner:TComponent; AParent:TWinControl; {OnSetName: TSetNameEvent; OnReferenceName: TReferenceNameEvent; }Proc: TReadComponentsProc);
procedure GeneralPasteComponentsString(AOwner:TComponent; AParent:TWinControl; Proc: TReadComponentsProc; Content:TFileContents);
procedure GeneralPasteComponentsStream(AOwner:TComponent; AParent:TWinControl; Proc: TReadComponentsProc; S:TStream);

procedure glLockWindowUpdate(Lock:boolean; var lLock:boolean);
procedure InternalReadDFM(Content:TFileContents; Instance:TComponent);

var IsCopying:Boolean=False;

implementation

uses Unit1, Unit2, uOptions, uWarnings, uPresets;



const DefaultFileName=EmptyStr;
      MarkContentBegin='MarkContentBegin';

var TurnOffNameValidation:boolean=false;

{$R *.dfm}
                
procedure TPageContainer.DoDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin         
 Accept:=(Source is TControl) and (TControl(Source).Owner=Presets);
end;
                      
procedure TPageContainer.DoDragDrop(Sender, Source: TObject; X, Y: Integer);     
var lLock:boolean;
begin                                        
 glLockWindowUpdate(true,lLock);
 try
  MySiz.SetControlTo(Sender as TdhCustomPanel,true,true);
  glPreferMousePosition:=true;
  try
   Presets.InsertCompo(Source);
  finally
   glPreferMousePosition:=false;
  end;
 finally
  glLockWindowUpdate(false,lLock);
 end;
end;

procedure TPageContainer.SetControlDesigning(c:TComponent; Designing,Transient:boolean);
var i:integer;
    OldComponentState:TComponentState;
begin
 if (c.Owner<>Self) then exit;
 OldComponentState:=c.ComponentState;
 if Designing then
  PComponentState(@c.ComponentState)^:=c.ComponentState+[csDesigning] else
  PComponentState(@c.ComponentState)^:=c.ComponentState-[csDesigning];


 if c is TdhCustomPanel and (OldComponentState<>c.ComponentState) then
 begin
 if (OldComponentState<>c.ComponentState) then
  TdhCustomPanel(c).DesignPaintingChanged;
 //pc:=c.Owner as TPageContainer;//GetParentForm(c) can be still nil if c is just created
 if Designing then
  TdhCustomPanel(c).OnDragOver:=DoDragOver else
  TdhCustomPanel(c).OnDragOver:=nil;
 if Designing then
  TdhCustomPanel(c).OnDragDrop:=DoDragDrop else
  TdhCustomPanel(c).OnDragDrop:=nil;
 end;

 if c is TWinControl then
 begin                           
 if not Transient and (OldComponentState<>c.ComponentState) then
  TWinControl(c).UpdateControlState;
 with TWinControl(c) do
 for i:=0 to ControlCount-1 do
 if (c.Owner is TCustomForm) or (Controls[i].Owner=c.Owner) then
  SetControlDesigning(Controls[i],Designing,Transient);
 end;
end;

procedure TPageContainer.ValidateRename(AComponent: TComponent; const CurName, NewName: String);
begin
 if TurnOffNameValidation then exit;
 inherited;
end;

procedure TPageContainer.SetDesigning(Designing,Transient:boolean);
var i:integer;
begin
 if not Transient then
 begin
  MySiz.Visible:=Designing;
  if Designing then
   TdhHTMLForm.ResetFields(Self) else
   TdhHTMLForm.MemorizeFields(Self);
 end;
 for i:=0 to ControlCount-1 do
 if not(Controls[i] is TMySiz) and not(Controls[i] is TForm) then
  SetControlDesigning(Controls[i],Designing,Transient);
 if not Transient then
  MySiz.SelCheckDesignState;
end;


type TMyReader=class(TReader)
 FrameClassName:string;
 AlreadyReadNames:TStringList;
 procedure ReaderSetName(Reader: TReader; Component: TComponent; var Name: string);
 procedure ReaderReferenceName(Reader: TReader; var Name: string);
 constructor Create(Stream: TStream; BufSize: Integer);
 destructor Destroy; override;
 procedure FindComponentClass(Reader: TReader; const ClassName: string;
    var ComponentClass: TComponentClass);
 procedure CreateComponentEvent(Reader: TReader;
    ComponentClass: TComponentClass; var Component: TComponent);
 procedure SetName(Component: TComponent; var Name: string); override;
 procedure MyFindComponentClass(Reader: TReader; const ClassName: string;
    var ComponentClass: TComponentClass);
 procedure MyOnError(Reader: TReader; const Message: string;
      var Handled: Boolean);
  private
    procedure FixEnumerationProps(Comp:TComponent; Instance: TPersistent);
end;

function _ObjectTextToResource(f:TStringStream):TStringStream;
begin
    result:=TStringStream.Create(EmptyStr);
    ObjectTextToResource(f,result);
    result.Seek(0,soFromBeginning);
    f.Free;
end;

function _ObjectTextToBinary(f:TStringStream):TStringStream; 
var V: TValueType;
begin
    result:=TStringStream.Create(EmptyStr);
    ObjectTextToBinary(f,result);
    V := vaNull;
    result.Write(V, SizeOf(V));
    result.Seek(0,soFromBeginning);
    f.Free;
end;

function PossibleStream(const S: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(S) - 6 do
  begin
    if ((S[I] in ['O','o']) and (CompareText(Copy(S, I, 6), 'OBJECT') = 0)) or
       ((S[I] in ['I','i']) and (CompareText(Copy(S, I, 6), 'INLINE') = 0)) then
      Exit;
    if not (S[I] in [' ',#9, #13, #10]) then Break;
  end;
  Result := False;
end;

      
{$IFDEF CLX}
{
function GetClipboardStream: TMemoryStream;
begin
 result:=TMemoryStream.Create;
 if not Clipboard.GetFormat(sCF_COMPONENTS,result) then
  FreeAndNil(result) else
  result.Position:=0;
end;}

//ClxEditors.pas
function GetClipboardStream: TMemoryStream;
var
  S, T: TMemoryStream;
  Format: string;
  V: TValueType;

  function AnotherObject(S: TStream): Boolean;
  var
    Buffer: array[0..255] of AnsiChar;
    Position: Integer;
  begin
    Position := S.Position;
    Buffer[S.Read(Buffer, SizeOf(Buffer)-1{!!})] := #0;
    S.Position := Position;
    Result := PossibleStream(Buffer);
  end;

begin
  Result := TMemoryStream.Create;
  try
    {if Clipboard.Provides(SDelphiComponent) then
      Format := SDelphiComponent else}
      Format := 'text/plain';
    Clipboard.GetFormat(Format, Result);
    Result.Position := 0;
    if Result.Memory <> nil then
      Result.Size := StrLen(Result.Memory)
    else
      Result.Size := 0;  
    {if Format <> SDelphiComponent then
    begin}
      S := TMemoryStream.Create;
      try
        while AnotherObject(Result) do ObjectTextToBinary(Result, S);
        V := vaNull;
        S.Write(V, SizeOf(V));
        T := Result;
        Result := nil;
        T.Free;
      except
        S.Free;
        raise;
      end;
      Result := S;
      Result.Position := 0;
    {end;}
  except
    Result.Free;
    raise;
  end;
end;

{$ELSE}
//VCLEditors.pas
function GetClipboardStream: TMemoryStream;
var
  S, T: TMemoryStream;
  Handle: THandle;
  Mem: Pointer;
  Format: Word;
  V: TValueType;

  function AnotherObject(S: TStream): Boolean;
  var
    Buffer: array[0..255] of AnsiChar;
    Position: Integer;
  begin
    Position := S.Position;
    Buffer[S.Read(Buffer, SizeOf(Buffer))-1] := #0;
    S.Position := Position;
    Result := PossibleStream(string(Buffer));
  end;

begin
  Result := TMemoryStream.Create;
  try
    if Clipboard.HasFormat(CF_COMPONENTS) then
      Format := CF_COMPONENTS else
      Format := CF_TEXT;
    Clipboard.Open;
    try
      Handle := Clipboard.GetAsHandle(Format);
      Mem := GlobalLock(Handle);
      try
        Result.Write(Mem^, GlobalSize(Handle));
      finally
        GlobalUnlock(Handle);
      end;
    finally
      Clipboard.Close;
    end;
    Result.Position := 0;
    if Format = CF_TEXT then
    begin
      S := TMemoryStream.Create;
      try
        while AnotherObject(Result) do ObjectTextToBinary(Result, S);
        V := vaNull;
        S.Write(V, SizeOf(V));
        T := Result;
        Result := nil;
        T.Free;
      except
        S.Free;
        raise;
      end;
      Result := S;
      Result.Position := 0;
    end;
  except
    Result.Free;
    raise;
  end;
end;
{$ENDIF}



function GetUniqueName(Component:TComponent): TComponentName;
begin
 if Component is TdhCustomPanel then
  result:=TdhCustomPanel._GetUniqueName(Component,Copy(Component.ClassName,4,maxint)) else
  result:=TdhCustomPanel._GetUniqueName(Component,Copy(Component.ClassName,2,maxint));
end;

procedure TPageContainer.CreateBody;
var body:TdhPage;
begin
 Name:=TdhCustomPanel._GetUniqueName(Self,'PageContainer');
 Caption:=DKFormat(UNTITLED);
 FormStyle := fsMDIChild;
 WindowState:=wsMaximized;
 body:=TdhPage.Create(Self);
 {body.Width:=600;
 body.Height:=300;   }
 body.Name:='index';
 body.Align:=alClient;
 body.Visible:=true;
 body.GeneratedCSSFile:='dfm2html.css';
 body.Parent:=Self;
 //body.Font.Assign(FuncSettings.DefaultFont);
 Self.Font.Assign(FuncSettings.DefaultFont);  
 SetDesigning(not _RuntimeMode,false);
 //SetControlDesigning(body,true,false);
 MySiz.BringToFront;
 Visible:=true;

 InitializeRedoUndo;
 ActDFM;
end;

procedure TMyReader.ReaderSetName(Reader: TReader; Component: TComponent; var Name: string);
begin
 if TurnOffNameValidation then
 begin
  if AlreadyReadNames.IndexOf(Name)<>-1 then
  begin
   TurnOffNameValidation:=False;
  end else
  begin
   AlreadyReadNames.Add(Name);
   Exit;
  end;
 end;
 if (Reader.Root <> nil) and (Reader.Root.FindComponent(Name) <> nil) then
 begin
    RenamedNames.AddObject(Name,Component);
    Name := GetUniqueName(Component);
 end;
end;

procedure TMyReader.ReaderReferenceName(Reader: TReader; var Name: string);
var i:integer;
begin
 i:=RenamedNames.IndexOf(Name);
 if i<>-1 then
  Name:=TComponent(RenamedNames.Objects[i]).Name;
end;


(*
procedure TPageContainer.ReaderSetName(Reader: TReader; Component: TComponent; var Name: string);
begin
 //SetDesignMode(Component); by TPageContainer.Notification
 if (Reader.Root = Self) and (Self.FindComponent(Name) <> nil) then
 begin
    RenamedNames.AddObject(Name,Component);
    Name := GetUniqueName(Component);
 end;
end;

procedure TPageContainer.ReaderReferenceName(Reader: TReader; var Name: string);
var i:integer;
begin
 i:=RenamedNames.IndexOf(Name);
 if i<>-1 then
  Name:=TComponent(RenamedNames.Objects[i]).Name;
end;
*)

procedure TPageContainer.ComponentRead(Component: TComponent);
begin
 if Component is TControl then
 begin
  //SetDesignMode(TControl(Component));
  MySiz.SetControlTo(TControl(Component),true); 
  //TMyReader(Reader).FixEnumerationProps(Component,Component);
 end;
end;

procedure TPageContainer.ComponentReadAdjustPos(Component: TComponent);

procedure adj(pn:TControl);
begin
  if pn.Anchors=[akTop] then
   pn.Anchors:=[akLeft,akTop];
  //pn.Center:=False;
  with _GetNotClipped(pn.Parent) do
  begin
   pn.Top:=Top+16;
   pn.Left:=Left+16;
  end;
  if pn.Parent is TdhStyleSheet then
  begin
   pn.Top:=maxint;
   pn.Align:=alTop;
  end;                                    
  ComponentRead(pn);
end;

var i:integer;
begin
 if Component is TControl then
  adj(TControl(Component));
 if (Component is TdhPageControl) then
 for i:=0 to TdhPageControl(Component).PageCount-1 do
  adj(TdhPageControl(Component).Pages[i]);
end;



function StringOfStream(S: TStream):TFileContents;
var
  T: TMemoryStream;
begin
    S.Position := 0;
    T := TMemoryStream.Create;
    try
      S.ReadResHeader;
      ObjectBinaryToText(S, T);
      Result:=AsString(T);
    finally
      T.Free;
    end;
end;


function TPageContainer.SaveAs:boolean;
var wh:TPageContainer;
    sFileName:TPathName;
begin
 result:=false;
 if not Tabs.CommitChanges then exit;
 if not IsUntitled then
  dhMainForm.SaveDialog1.FileName:=FileName;
 if dhMainForm.SaveDialog1.Execute then
 if HasOpened(dhMainForm.SaveDialog1.FileName,wh) then
  showmessage(DKFormat(SAVEASOPENED)) else
  begin
   sFileName:=FileName;
   FileName:=dhMainForm.SaveDialog1.FileName;
   result:=Save;
   if not result then
    FileName:=sFileName;
  end;
end;

function TPageContainer.SaveAsTemplate:boolean;
var wh:TPageContainer;
    Value:string;
begin
 result:=false;
 if not Tabs.CommitChanges then exit;
 Value:=EmptyStr;
 Result:=InputQuery(DKFormat(TEMPLATESAVEASCAPTION),DKFormat(TEMPLATESAVEASPROMPT),Value);
 if Result and (MySiz.FindBody<>nil) then
 begin
  //MySiz.SaveAsImage(GetRootTemplatesDir+MyTemplatesDir+PathDelim+Value+'.png',true);

  SaveAsImage(GetRootTemplatesDir+MyTemplatesDir+PathDelim+Value+'.png');

  PhysicalSave(GetRootTemplatesDir+MyTemplatesDir+PathDelim+Value+'.dfm',false);
 end;
end;


procedure DoCreateHandles(w:TWinControl);
var i:integer;
begin
 for i:=0 to w.ControlCount-1 do
 if w.Controls[i] is TWinControl then
  DoCreateHandles(TWinControl(w.Controls[i]));
 w.Handle;
end;

procedure TPageContainer.SaveAsImage(pngfilename:TPathName);
var pn:TdhCustomPanel;
    body:TdhPage;
begin
  body:=MySiz.FindBody;
  if body=nil then exit;
  SetDesigning(false,true);
  pn:=TdhPanel.Create(nil);
  try
   DoCreateHandles(self); //need handle to pass AlignControl(..)
   with body.GetInnerClientArea do
    pn.SetBounds(Left,Top,Right-Left,Bottom-Top);
   pn.Style.ZIndex:=10000;
   pn.Parent:=body;
   pn.SaveAsImage(pngfilename,true);
  finally
   pn.Free;
   SetDesigning(not _RuntimeMode,true);
  end;

end;


type TFakeMemoryStream=class(TMemoryStream);


procedure TStream_WriteDescendent(Self:TStream; Instance, Ancestor: TComponent);
var
  Writer: TWriter;
begin
  if WithMeta then
  begin
   Writer := TMyWriter.Create(Self, 4096);
   glOnDefineProperties:=TMyWriter(Writer).OnDefineProperties;
  end else
  begin
   Writer := TWriter.Create(Self, 4096);
  end;
  try
    Writer.WriteDescendent(Instance, Ancestor);
  finally
    glOnDefineProperties:=nil;
    Writer.Free;
  end;
end;


procedure TStream_WriteDescendentRes(Self:TStream; const ResName: string; Instance,
  Ancestor: TComponent);
var
  FixupInfo: Integer;
begin
  Self.WriteResourceHeader(ResName, FixupInfo);
  TStream_WriteDescendent(Self,Instance, Ancestor);
  Self.FixupResourceHeader(FixupInfo);
end;


function TPageContainer.GetDFMStr(AsText:boolean; _WithMeta:boolean):TFileContents;
var S : TMemoryStream;
    i:integer;
    comp:TComponent;
    pn:TdhCustomPanel;
begin
  Tabs.CommitChanges;

   {Assert(not PreventGraphicOnChange);
   PreventGraphicOnChange:=true;
   try }

  assert(not WithMeta);
  WithMeta:=_WithMeta; //must be set after CommitChanges
  S := TMemoryStream.Create;
  TFakeMemoryStream(S).Capacity:=length(NewDFM)+2000;
  try
    //self.IsControl:=OnlyNess;
    if WithMeta then
    begin
     SetDesigning(false,true);
     for i:=0 to ComponentCount-1 do   
     if (Components[i] is TdhCustomPanel) then
     begin
      pn:=TdhCustomPanel(Components[i]);
      with AdjustedClientRect(pn.Parent) do
      begin
       if pn.Align in [alTop,alBottom,alClient] then
        pn.Width:=Right-Left;
       if pn.Align in [alLeft,alRight,alClient] then
        pn.Height:=Bottom-Top;
      end;
      pn.MyRealign;
     end;
     for i:=0 to ControlCount-1 do
      if Controls[i] is TdhCustomPanel then
       TdhCustomPanel(Controls[i]).CalcVariableSizes(true);
     for i:=0 to ControlCount-1 do
      if Controls[i] is TdhCustomPanel then
       TdhCustomPanel(Controls[i]).CalcVariableSizes(false);
    end;
    try
     TStream_WriteDescendentRes(s,Self.ClassName,Self,nil);
    finally;
     if WithMeta then
      SetDesigning(not _RuntimeMode,true);
    end;
    if AsText then
    begin
     Result:=StringOfStream(S);    
     i:=AdvPosAnsi('TPageContainer',Result);
     if i>=1 then
      Result:=Copy(Result,1,i-1)+'T'+AnsiString(Name)+Copy(Result,i+length('TPageContainer'),MaxInt);
     //Result:=SubstText(': TPageContainer',': T'+Name,Result);
     //Result:=SubstText('FormStyle = fsMDIChild',EmptyStr,Result);
    end else
    begin
     Result:=AsString(S);
    end;
  finally
    S.Free;
    WithMeta:=false;
  end;
  {finally
  PreventGraphicOnChange:=false;
  end;  }
  
end;

function TPageContainer.IsUntitled:boolean;
begin
 result:=FileName = DefaultFileName;
end;



function TPageContainer.Save:boolean;
begin
 if IsUntitled then
 begin
  result:=SaveAs;
  exit;
 end;
 result:=false;
 if not Tabs.CommitChanges then exit;
  result:=PhysicalSave(FileName,true);
 dhMainForm.UpdateCommands(false,false);
end;

function TPageContainer.PhysicalSave(FileName:TPathName; DeleteHistory:boolean):boolean;
begin
 result:=false;
 try
  StringToFile(FileName,GetDFMStr(true,false));
  if DeleteHistory then
   InitializeRedoUndo;
  result:=true;
 except
  on E:Exception do
   MessageDlg(DKFormat(SAVETOERROR,FileName)+':'+#13#10+E.Message,mtError,[mbOk],0);
 end;
end;


procedure TPageContainer.InitializeRedoUndo;
begin
  FRedo.Clear;
  FUndo.Clear;
  NewDFM:=EmptyStr;
  SetModified('INITIALIZATION');
end;

function CorrectOldFormats(Content:TFileContents):TFileContents;

procedure subst(const a,b:TFileContents);
var i:integer;
begin
 i:=0;
 while bAdvPosAnsi(i,a,Content,i+1) do
 if (i-1>=1) and (Content[i-1] in [' ','.',#13,#10,'[',',']) and
    (i+1<=Length(Content)) and (Content[i+length(a)] in [' ','.',#13,#10,']',',']){ and
    not( (i-length('object ')<=Length(Content)) and SubEqual('object ',Content,i-length('object ')))} then
 begin
  Content:=TFileContents(CopyInsert(Content,i,i+length(a),b));
 end;
end;

begin
                      
 subst('Color = -1','Color = Black');

 {subst('TFrame','TdhPage');
 subst('TdhRule','TdhLink');
 subst('TdhAnchor','TdhLink');
 subst('Transformations','Effects');
 subst('RotationDegree','Rotation');
 subst('MasterAlpha','Alpha');
 subst('TdhTabSheet','TdhPage');
 subst('AnchorOptions','Options');
 subst('LinkType = ltNone','Layout = ltText');
 subst('LinkType','Layout');
 subst('FormButtonLayout','Layout');
 subst('StyleHover','StyleOver');
 subst('StyleHoverDown','StyleOverDown');
 subst('flButton','ltButton');
 subst('flText','ltText');
 subst('aoDownIfHover','aoDownIfOver');
 subst('DownOverlayHover','DownOverlayOver');
 subst('LinkTab','LinkPage');  }

 result:=Content;
end;



procedure GeneralPasteComponents(AOwner:TComponent; AParent:TWinControl; {OnSetName: TSetNameEvent; OnReferenceName: TReferenceNameEvent;} Proc: TReadComponentsProc);
begin
  GeneralPasteComponentsStream(AOwner,AParent,Proc,GetClipboardStream);
end;

procedure GeneralPasteComponentsString(AOwner:TComponent; AParent:TWinControl; Proc: TReadComponentsProc; Content:TFileContents);
begin
  GeneralPasteComponentsStream(AOwner,AParent,Proc,_ObjectTextToBinary(TStringStream.Create(CorrectOldFormats(Content))));
end;

procedure GeneralPasteComponentsStream(AOwner:TComponent; AParent:TWinControl; Proc: TReadComponentsProc; S:TStream);
var
  R: TReader;
begin
  try
    R := TMyReader.Create(S, {1024}256);
    try
      R.ReadComponents(AOwner, AParent, Proc);
    finally
      R.Free;
    end;
  finally
    S.Free;
  end;
end;

procedure TPageContainer.PasteComponents(S:TStream);
var
  AParent:TWinControl;
  i,sComponentCount:integer;
  WarningsCount:integer;
begin
 if not Tabs.CommitChanges then exit;

 UndoRedoLoad:=true;
 try
  MySiz.DoInval(true);
  AParent:=MySiz.GetPasteParent;
  if AParent=nil then
   AParent:=Self;
  MySiz.ClearSelection;
  sComponentCount:=ComponentCount;


  LateCreateForm(TFormWarnings,FormWarnings);
  WarningsCount:=FormWarnings.Memo1.Lines.Count;
  if S<>nil then
   GeneralPasteComponentsStream(Self,AParent,{ReaderSetName,ReaderReferenceName,}ComponentReadAdjustPos,S) else
   GeneralPasteComponents(Self,AParent,{ReaderSetName,ReaderReferenceName,}ComponentRead);
  if FormWarnings.Memo1.Lines.Count<>WarningsCount then
  begin
   FormWarnings.Memo1.Lines.Insert(WarningsCount,DKFormat(PASTEERRORCOUNT,inttostr(FormWarnings.Memo1.Lines.Count-WarningsCount)));
   FormWarnings.Memo1.Lines.Add(EmptyStr);
   FormWarnings.Show;
  end;

  //SetDesignMode(Self);
  for i:=0 to ComponentCount-1 do
  if Components[i] is TdhCustomPanel then
   TdhCustomPanel(Components[i]).TryBrokenReferences(nil);

  if sComponentCount=ComponentCount then
  begin                                       
   MySiz.SetControlTo(AParent,true);
   showmessage(DKFormat(EMPTYCLIPBOARD));
  end else
  begin
   MySiz.ShiftIntoView;
   SetModified('Paste');
  end;
  MySiz.DoInval(false);
  dhMainForm.UpdateCommands(false,true);       
 finally
  UndoRedoLoad:=false;
 end;
end;

constructor TMyReader.Create(Stream: TStream; BufSize: Integer);
begin
 Inherited;
 AlreadyReadNames:=TStringList.Create;
 AlreadyReadNames.Sorted:=True;
 AlreadyReadNames.CaseSensitive:=False;
 OnFindComponentClass:=FindComponentClass;
 OnCreateComponent:=CreateComponentEvent;
 OnReferenceName:=ReaderReferenceName;
 OnSetName:=ReaderSetName;
 RenamedNames:=TStringList.Create;
 OnFindComponentClass:=MyFindComponentClass;
 OnError:=MyOnError;
end;

procedure TMyReader.MyOnError(Reader: TReader; const Message: string; var Handled: Boolean);
begin
 //not override Error function, since only this event can called in dhPanel.TProxyReader.MyReadData
 if FormWarnings<>nil then
  FormWarnings.Memo1.Lines.Add(Message);
 Handled := true;
end;


procedure TMyReader.MyFindComponentClass(Reader: TReader; const ClassName: string;
    var ComponentClass: TComponentClass);
begin
 if ComponentClass=nil then
 begin
  ComponentClass:=TdhPanel;
  if FormWarnings<>nil then
   FormWarnings.Memo1.Lines.Add(DKFormat(UNKNOWNOBJECT,ClassName));
 end;
end;


destructor TMyReader.Destroy;
begin
 FreeAndNil(AlreadyReadNames);
 FreeAndNil(RenamedNames);
 Inherited;
end;

procedure TMyReader.SetName(Component: TComponent; var Name: string);
begin
 inherited;
{ SetDesignMode(Component);
 if Assigned(OnSetName) then OnSetName(Self, Component, Name);
 if Component.Owner.FindComponent(Name)<>nil then
  Name:=Name+'1';
 Component.Name := Name;}
end;






procedure TMyReader.CreateComponentEvent(Reader: TReader;
    ComponentClass: TComponentClass; var Component: TComponent);
begin
 if ComponentClass<>TFrame then exit;
// assert(FrameClassName<>EmptyStr);
                    {
 if GetFrameDFM(FrameClassName,FrameFile) then
 begin

 Component:=ReadCompo(FrameFile,TFrame);

        begin
          PComponentState(@Component.ComponentState)^:=Component.ComponentState+[csLoading];
          PComponentState(@Component.ComponentState)^:=Component.ComponentState+[csInline];
        end;
 end;          }

 FrameClassName:=EmptyStr;
end;

procedure TMyReader.FindComponentClass(Reader: TReader; const ClassName: string;
    var ComponentClass: TComponentClass);
begin
 if ComponentClass<>nil then exit;
 if Pos('Frame',ClassName)=0 then exit;
 ComponentClass:=TFrame;
 FrameClassName:=ClassName;
end;



function TStream_ReadComponent(Self:TStream; Instance: TComponent): TComponent;
var
  Reader: TMyReader;
begin
  Reader := TMyReader.Create(Self, 4096);
  try
    Result := Reader.ReadRootComponent(Instance);
  finally
    Reader.Free;
  end;
end;

function TStream_ReadComponentRes(Self:TStream; Instance: TComponent): TComponent;
begin
  Self.ReadResHeader;
  Result := TStream_ReadComponent(Self,Instance);
end;


procedure glLockWindowUpdate(Lock:boolean; var lLock:boolean);
begin
 if Lock then
 begin
  if LockLock then
  begin
   lLock:=false;
  end else
  begin
   lLock:=true;
   LockLock:=true;
{$IFNDEF CLX}
   LockWindowUpdate(dhMainForm.Handle);
{$ELSE}
   //QWidget_setUpdatesEnabled(dhMainForm.Handle,  False);
{$ENDIF}
  end;
 end else
 if lLock then
 begin
  //dhMainForm.Update;
  LockLock:=false;
{$IFNDEF CLX}
  LockWindowUpdate(0);
{$ELSE}
   //QWidget_setUpdatesEnabled(dhMainForm.Handle,  True);
{$ENDIF}
 end;
end;



procedure InternalReadDFM(Content:TFileContents; Instance:TComponent);

var f:TStringStream;
begin
 f:=TStringStream.Create(CorrectOldFormats(Content));
 try
  if TestStreamFormat(f)=sofText then //we need not Text but Resource format
  begin
   f:=_ObjectTextToResource(f);
  end;
 {f.ReadResHeader;
 TStream_ReadComponent(f,Self);}
  TStream_ReadComponentRes(f,Instance);
 finally
  f.Free;
 end;
end;



procedure TPageContainer.ReadDFM(Content:TFileContents);
var
    i:integer;
    sl:TStringList;
    LastAct:TTabSheet;
    lLock:boolean;

begin
 glLockWindowUpdate(true,lLock);
 TurnOffNameValidation:=True;//for speed
 try
 LastAct:=Tabs.PageControl1.ActivePage;
 sl:=MySiz.GetSelectionIDs;
 try
  MySiz.ClearSelection;
  for i:=ControlCount-1 downto 0 do
  if not (Controls[i] is TMySiz) then
  with Controls[i] do
  begin
   self.RemoveControl(Controls[i]);
   Free;
  end;
 //  Controls[i].RemoveComponent;

  InternalReadDFM(Content,Self);

  BorderStyle:={$IFDEF CLX}fbsSizeable{$ELSE}bsSizeable{$ENDIF};
  if not ForPreview then
   FormStyle:=fsMDIChild;
  ActiveControl:=nil;
  SetDesigning(not _RuntimeMode,false);
  UpdateControlState;
  MySiz.BringToFront;
  MySiz.AddSelectionByIDs(sl);
 finally
 sl.Free;
 end;
 dhMainForm.UpdateCommands(true,true);
 if (LastAct<>nil) and LastAct.TabVisible then
  Tabs.PageControl1.ActivePage:=LastAct;

 finally
  TurnOffNameValidation:=False;
  glLockWindowUpdate(false,lLock);
 end;
end;




procedure TPageContainer.Open(const AFileName: TPathName; SetUntitled:boolean; BeVisible:boolean=true);
var c1,c2:int64;
    WarningsCount:integer;
    lLock:boolean;
begin
// QueryPerformanceCounter(c1);

      Include(FFormState, fsCreating);
      try
 {glLockWindowUpdate(true,lLock);
 try}
// if SubSameEnd('.pas',FrameFile) then FrameFile:=Copy(FrameFile,1,Length(FrameFile)-Length('.pas'))+'.dfm';
 try
 LateCreateForm(TFormWarnings,FormWarnings);
 WarningsCount:=FormWarnings.Memo1.Lines.Count;
 FFileName := AFileName; // in order that readdfm works!
 ReadDFM(StringFromFile(AFileName));
 if not SetUntitled then
  FileName := AFileName else
  FileName := DefaultFileName;
// dhMainForm.Realign;
 Application.ProcessMessages; //damit width sich anpaﬂt
 //Self.Font.Assign(FuncSettings.DefaultFont);
 InitializeRedoUndo;

 if FormWarnings.Memo1.Lines.Count<>WarningsCount then
 begin
  FormWarnings.Memo1.Lines.Insert(WarningsCount,DKFormat(READERRORCOUNT,[inttostr(FormWarnings.Memo1.Lines.Count-WarningsCount),AFileName]));
  FormWarnings.Memo1.Lines.Add(' '{space, for CLX });
  FormWarnings.Show;
 end;


 if {not _RuntimeMode and }BeVisible then
  MySiz.SetControlTo(MySiz.FindBody,true);
 //self.SetFocusedControl(self.MySiz.FindBody);
 except
 on A:Exception do
 begin
  MessageDlg(DKFormat(READFROMERROR,AFileName)+#13#10+DKFormat(SYSTEMERROR)+': '+A.Message,mtError,[mbOk],0);
  //Release;
  Close;
 end;
 end;

 if FuncSettings.LRUfiles.IndexOf(FileName)<>-1 then
  FuncSettings.LRUfiles.Delete(FuncSettings.LRUfiles.IndexOf(FileName));

{finally
  glLockWindowUpdate(false,lLock);
 end;}
      finally
        Exclude(FFormState, fsCreating);
      end;
 Visible:=BeVisible;

 if Visible then
  UpdateActiveMDI;//Activate; not called if visible set to false in constructor

// QueryPerformanceCounter(c2);
 //showmessage(inttostr((c2-c1) div 1000));

end;

class function TPageContainer.HasOpened(FileName:TPathName; var wh:TPageContainer):boolean;
var i:integer;
begin
 for i:=0 to dhMainForm.MDIChildCount-1 do
 begin
  wh:=(dhMainForm.MDIChildren[i] as TPageContainer);
  if wh.FileName=FileName then
  begin
   result:=true;
   exit;
  end;
 end;
 result:=false;
end;


procedure TPageContainer.SetFileName(const Value: TPathName);
begin
 FFileName := Value;
 if IsUntitled then
  Caption:=DKFormat(UNTITLED) else
  Caption := ExtractFileName(FileName);
end;

procedure TPageContainer.ActDFM();
var r:integer;
begin
 try
 NewDFM:=GetDFMStr(false,false);
 //StringToFile('c:\lastact.txt',GetDFMStr(true));
 if bAdvPosAnsi(r,MarkContentBegin,NewDFM) then
 begin
  PreDFM:=AbsCopy(NewDFM,1,r);
  Delete(NewDFM,1,r-1);
 end;
 finally
 end;
end;

procedure TPageContainer.SetModified(const Reason:TReason; LogChange:TLogChange);
var OldDFM:TFileContents;
    NewStep:TModifyStep;
    left_ok,right_ok:integer;
begin
 assert(Reason<>EmptyStr);
 if IsLiveModified then
 begin
 if LiveReason<>Reason then
 begin
  showmessage(DKFormat(NONCRITICALERROR,LiveReason+' not equals '+Reason));
  LiveReason:=EmptyStr;
 end;
 end;
 if LogChange=lcLive then
 begin
  LiveReason:=Reason;
 end else
 if LogChange=lcAbort then
 begin
  assert(LiveReason<>EmptyStr);
  LiveReason:=EmptyStr;
  if not MySiz.HasOneSelectedComponent then
   UpdateContent;
 end else
 begin

 LiveReason:=EmptyStr;

 OldDFM:=NewDFM;

 ActDFM;
 if OldDFM=NewDFM then
 begin
  exit;
 end;

 FRedo.Clear;
 NewStep:=TModifyStep.Create;
 NewStep.Reason:=Reason;
 NewStep.left_ok:=min(length(NewDFM),length(OldDFM));
 for left_ok:=0 to NewStep.left_ok-1 do
 if NewDFM[1+left_ok]<>OldDFM[1+left_ok] then
 begin
  NewStep.left_ok:=left_ok;
  break;
 end;
 NewStep.right_ok:=min(length(NewDFM)-NewStep.left_ok,length(OldDFM)-NewStep.left_ok);
 for right_ok:=0 to NewStep.right_ok-1 do
 if NewDFM[length(NewDFM)-right_ok]<>OldDFM[length(OldDFM)-right_ok] then
 begin
  NewStep.right_ok:=right_ok;
  break;
 end;
 NewStep.SetRepl(OldDFM);
 FUndo.Add(NewStep);
 end;
 dhMainForm.UpdateCommands(false,false);
end;

procedure TModifyStep.SetRepl(const OldDFM:TFileContents);
begin
 repl_block:=AbsCopy(OldDFM,1+left_ok,length(OldDFM)+1-right_ok);
end;

function TPageContainer.HasSelectedComponents:boolean;
begin
 result:=MySiz.HasSelectedComponents;
end;


function TModifyStep.GetOriginal(const NewDFM:TFileContents):TFileContents;
begin
 result:=Copy(NewDFM,1,left_ok)+repl_block+Copy(NewDFM,length(NewDFM)+1-right_ok,right_ok)
end;


procedure TPageContainer.Undo;
var OldDFM:TFileContents;
    NewStep:TModifyStep;
begin
 if IsLiveModified then
 begin
  Tabs.AbortChanges;
  {LiveReason:=EmptyStr;
  dhMainForm.UpdateCommands(true,true);}
  exit;
 end;
 NewStep:=FUndo.Last as TModifyStep;
 OldDFM:=NewStep.GetOriginal(NewDFM);
 NewStep.SetRepl(NewDFM);
 NewDFM:=OldDFM;
 FUndo.Extract(NewStep);
 FRedo.Add(NewStep);
 UpdateContent;
end;

procedure TPageContainer.UpdateContent;
begin
 UndoRedoLoad:=true;  
 try
   ReadDFM(PreDFM+NewDFM);
   UpdateActiveMDI; //can get deactivate in the mean time
 finally
  UndoRedoLoad:=false;
 end;
end;



procedure TPageContainer.Redo;
var OldDFM:TFileContents;
    NewStep:TModifyStep;
begin
 NewStep:=FRedo.Last as TModifyStep;
 OldDFM:=NewStep.GetOriginal(NewDFM);
 NewStep.SetRepl(NewDFM);
 NewDFM:=OldDFM;
 FRedo.Extract(NewStep);
 FUndo.Add(NewStep);
 UpdateContent;
end;

function TPageContainer.UndoAction:TReason;
var NewStep:TModifyStep;
begin
 if IsLiveModified then
 begin
  result:=LiveReason;
  exit;
 end;
 NewStep:=FUndo.Last as TModifyStep;
 result:=NewStep.Reason;
end;

function TPageContainer.RedoAction:TReason;
var NewStep:TModifyStep;
begin
 NewStep:=FRedo.Last as TModifyStep;
 result:=NewStep.Reason;
end;


function TPageContainer.GetIsModified: boolean;
begin
 result:=(FUndo.Count>=2) or IsLiveModified;
end;

function TPageContainer.IsLiveModified:boolean;
begin
 result:=LiveReason<>EmptyStr;
end;




function TPageContainer.CanRedo: boolean;
begin
 result:=FRedo.Count<>0;
end;


procedure InvalAll(c:TControl);
var i:integer;
begin
 if c is TdhCustomPanel then
  TdhCustomPanel(c).DesignPaintingChanged else
  c.Invalidate;
 if c is TWinControl then
 with TWinControl(c) do
 for i:=0 to ControlCount-1 do
  InvalAll(Controls[i]);
end;


procedure TPageContainer.InvalGrid;
begin
// Invalidate;
 //InvalTrans(Self,InvRect,false);
 InvalAll(Self);
end;

{function TPageContainer.DisplayEasy:boolean;
begin
 result:=(FuncSettings.FGridDisplay=gdNone) or (ControlCount<>0) and not (csDesigning in Controls[0].ComponentState);
end;
 }





procedure TPageContainer.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation=opInsert then
  if not(AComponent is TMySiz) then
  if not(AComponent is TCustomForm) then
   SetControlDesigning(AComponent,true,false);
                                        {
  //if GetParentForm(AComponent)=Self the
  if not (csLoading in ComponentState) then
  if AComponent is TControl then
  if dhMainForm.Act=Self then
  if Operation=opInsert then
   GetRefs(dhMainForm.cbName,TControl,TControl(AComponent),TControl(AComponent)) else
   GetRefs(dhMainForm.cbName,TControl,self,self);  }
end;

destructor TPageContainer.Destroy;
var NeedUpdate:boolean;
begin
  //FreeAndNil(bt);
  {NeedUpdate:=(ActForm=Self);
  if NeedUpdate then
   ActForm:=nil;  }
                   
  UpdateActiveMDI(true);
  FreeAndNil(FUndo);
  FreeAndNil(FRedo);
  FreeAndNil(FBackHistory);
  FreeAndNil(FForwardHistory);
  inherited;
  {if NeedUpdate and not (csDestroying in dhMainForm.ComponentState) then
   dhMainForm.UpdateCommands(true,true);  }
end;

procedure TPageContainer.SkipValue(Reader: TReader);
begin
 Reader.SkipValue;
end;


procedure TPageContainer.WriteTrue(Writer: TWriter);
begin
 Writer.WriteBoolean(true);
end;

procedure TPageContainer.DefineProperties(Filer: TFiler);
begin
 inherited;
 Filer.DefineProperty(MarkContentBegin, SkipValue, WriteTrue, false);
{ Filer.DefineProperty('OnActivate', SkipValue, WriteTrue, false);
 Filer.DefineProperty('OnClose', SkipValue, WriteTrue, false);
 Filer.DefineProperty('OnCloseQuery', SkipValue, WriteTrue, false);
 Filer.DefineProperty('OnCreate', SkipValue, WriteTrue, false);
 Filer.DefineProperty('OnDestroy', SkipValue, WriteTrue, false);
 Filer.DefineProperty('OnDeactivate', SkipValue, WriteTrue, false);
 Filer.DefineProperty('OnKeyDown', SkipValue, WriteTrue, false);
 Filer.DefineProperty('OnKeyUp', SkipValue, WriteTrue, false);
 Filer.DefineProperty('OnResize', SkipValue, WriteTrue, false);}
end;

procedure TPageContainer.GeneratePAS;
var s:TFileContents;
    PureFileName:TPathName;
begin
  PureFileName:=ExtractFileName(FileName);
  Delete(PureFileName,Pos('.',PureFileName),maxint);

  s:=TFileContents('Unit '+PureFileName+';'+#13#10+
     #13#10+
     'interface'+#13#10+
     #13#10+
     'uses Forms;'+#13#10+
     #13#10+
     'type'+#13#10+
     '  '+'T'+Name+' = class(TForm)'+#13#10+
     '  end;'+#13#10+
     #13#10+
     'var '+#13#10+
     '  '+Name+': T'+Name+';'+#13#10+
     #13#10+
     'implementation'+#13#10+
     #13#10+
     '{$R *.dfm}'+#13#10+
     #13#10+
     'end.');
  StringToFile(ExtractFileDir(Filename)+PathDelim+PureFileName+'.pas',s);
 { for i:=0 to ControlCount-1 do
  begin

  end;   }
end;

function TPageContainer.GetHistoryStep:THistoryStep;
var apage:TWinControl;
    sl:TStringList;
    step:THistoryStep;
begin
 result:=nil;
 apage:=mysiz.FindBody;
 while FindPage(apage,apage,false) do;
 if not(apage is TdhPage) then exit;
 step:=THistoryStep.Create;
 step.page:=apage.Name;
 step.scrollpos:=Point(mysiz.FindBody.HorzPosition,mysiz.FindBody.VertPosition);
 sl:=mysiz.GetSelectionIDs;
 try
  if sl.Count<>0 then
   step.selection:=sl[sl.Count-1];
 finally
  sl.Free;
 end;
 result:=step;
end;



procedure TPageContainer.History{(Page:TdhPage; Anchor:TControl)};
var step:THistoryStep;
begin
 step:=GetHistoryStep;
 if step=nil then exit;
 FBackHistory.Add(step);
 FForwardHistory.Clear;
 dhMainForm.UpdateHistory;
end;


procedure TPageContainer.AfterNavigate(Sender:TdhPage);
begin
 mysiz.SetControlTo(Sender,true,true);
end;

function TPageContainer.CanGoBack:boolean;
begin
 result:=(FBackHistory.Count<>0);
end;

function TPageContainer.CanGoForward:boolean;
begin
 result:=(FForwardHistory.Count<>0);
end;



procedure TPageContainer.GoBack;
var histPage:TdhPage;
    histAnchor:TControl;
    lLock:boolean;
    step:THistoryStep;
begin
 glLockWindowUpdate(true,lLock);
 try
 assert(CanGoBack);
 FForwardHistory.Add(GetHistoryStep);
 step:=FBackHistory.Last as THistoryStep;
 GotoHistoryStep(step);
 FBackHistory.Delete(FBackHistory.Count-1);
 dhMainForm.UpdateHistory;
 finally
  glLockWindowUpdate(false,lLock);
 end;
end;

procedure TPageContainer.GotoHistoryStep(step:THistoryStep);
begin
 //if not _RuntimeMode then
  mysiz.SetControlTo(FindComponent(step.selection) as TControl,true,true);
 TdhLink.NavigateLocation(FindComponent(step.page) as TdhPage,nil,nil);
 mysiz.FindBody.VertPosition:=step.scrollpos.Y;
 mysiz.FindBody.HorzPosition:=step.scrollpos.X;
end;


procedure TPageContainer.GoForward;
var histPage:TdhPage;
    histAnchor:TControl;
    lLock:boolean;
    step:THistoryStep;
begin
 glLockWindowUpdate(true,lLock);
 try
 assert(CanGoForward);
 FBackHistory.Add(GetHistoryStep);
 step:=FForwardHistory.Last as THistoryStep;
 GotoHistoryStep(step);
 FForwardHistory.Delete(FForwardHistory.Count-1);
 dhMainForm.UpdateHistory;
 finally
  glLockWindowUpdate(false,lLock);
 end;
end;

//Undo, TryBrokenReferences

       (*
type
  PWindowPlacement = ^TWindowPlacement;
  tagWINDOWPLACEMENT = packed record
    length: UINT;
    flags: UINT;
    showCmd: UINT;
    ptMinPosition: TPoint;
    ptMaxPosition: TPoint;
    rcNormalPosition: TRect;
  end;
  TWindowPlacement = tagWINDOWPLACEMENT;

const
  SW_HIDE = 0;
  SW_SHOWNORMAL = 1;
  SW_NORMAL = 1;
  SW_SHOWMINIMIZED = 2;
  SW_SHOWMAXIMIZED = 3; 
  SW_MAXIMIZE = 3;
  SW_SHOWNOACTIVATE = 4;
  SW_SHOW = 5;
  SW_MINIMIZE = 6;
  SW_SHOWMINNOACTIVE = 7;

//aus JvClxUtils.pas
procedure SetWindowPlacement(Handle : QWidgetH; W: PWindowPlacement);
begin
  with W.rcNormalPosition do
    QWidget_setGeometry(Handle, Left, Top, Right - Left, Bottom - Top);
  {case W.ShowCmd of
    SW_MINIMIZE, SW_SHOWMINIMIZED, SW_SHOWMINNOACTIVE:
      QWidget_showMinimized(Handle);
    SW_MAXIMIZE:
      QWidget_showMaximized(Handle);
    SW_HIDE:
      QWidget_hide(Handle);
  else
    QWidget_showNormal(Handle);
  end;   }
end;
      
function GetWindowPlacement(Handle: QWidgetH; W: PWindowPlacement):boolean;
var
  R : TRect;
begin
  QWidget_geometry(Handle, @R);
  W.rcNormalPosition.Left := R.Left;
  W.rcNormalPosition.Top := R.Top;
  W.rcNormalPosition.Right := R.Right;
  W.rcNormalPosition.Bottom := R.Bottom;
  if QWidget_isMinimized(Handle) then
    W.showCmd := SW_SHOWMINIMIZED
  else
  if QWidget_isMaximized(Handle) then
    W.showCmd := SW_SHOWMAXIMIZED
  else
  if not QWidget_isVisible(Handle) then
    W.showCmd := SW_HIDE
  else
    W.showCmd := SW_SHOWNORMAL;
  result:=true;
end;
          *)


function TPageContainer.GetCustomForm: TCustomForm;
begin
 result:=self;
end;

function TPageContainer.GetIsControl: Boolean;
begin
 result:=true;
end;

function TPageContainer.GetRoot: TComponent;
begin
 result:=self;

end;

procedure HandleDoubleClickOnLink(link:TdhLink);
begin
 if link.Link='' then
  link.Click else
 if link.SubMenu<>nil then
  link.SubMenu.Visible:=true;
end;



{$IFDEF CLX}
type TFakeWidgetControl=class(TWidgetControl);
function TPageContainer.IsDesignEvent(Sender: TWidgetControl; SenderHandle: QObjectH; Event: QEventH): Boolean;
var c:TControl;

function ButtonStateToMouseButton(Button: QT.ButtonState):TMouseButton;
begin
    if Integer(ButtonState_MidButton) and Integer(Button) <> 0 then
      Result := mbMiddle
    else if Integer(ButtonState_RightButton) and Integer(Button) <> 0 then
      Result := mbRight
    else
      Result := mbLeft;
end;

begin
 result:=false;
   if (Event<>nil) and (QEvent_type(Event) in [QEventType_MouseButtonDblClick]) and (Sender is TWinControl) then
   begin
    c := MyFindControl(TWinControl(Sender).Handle);
    if c is TdhLink then
    begin
     HandleDoubleClickOnLink(TdhLink(c));
     result:=true;
     exit;
    end;
   end;
 if (Event<>nil) and (QEvent_type(Event) in [QEventType_MouseButtonPress,QEventType_MouseButtonRelease,QEventType_MouseButtonDblClick,QEventType_MouseMove]) then
 begin
   if TFakeWidgetControl(Sender).DesignEventQuery(SenderHandle,Event) then
   begin
       result:=false;
   end else
   begin
       case QEvent_type(Event) of
       QEventType_MouseMove: MySiz.DesignMouseMove;
       QEventType_MouseButtonPress: MySiz.DesignMouseDown(ButtonStateToMouseButton(QMouseEvent_button(QMouseEventH(Event))),ButtonStateToShiftState(QMouseEvent_state(QMouseEventH(Event))));
       QEventType_MouseButtonRelease: MySiz.DesignMouseUp(ButtonStateToMouseButton(QMouseEvent_button(QMouseEventH(Event))));
       end;
       result:=true;
   end;
 end;;
end;
{$ELSE}
function TPageContainer.IsDesignMsg(Sender: TControl;
  var Message: TMessage): Boolean;
var c:TControl;
begin
{ result:=((Message.Msg = WM_RBUTTONDOWN) or
    (Message.Msg = WM_RBUTTONUP) or (Message.Msg = WM_MOUSEMOVE) or
    (Message.Msg = WM_RBUTTONDBLCLK));}
// Message.
   result:=false;
   if (message.msg=WM_LBUTTONDBLCLK) and (Sender is TWinControl) then
   begin
    c := MyFindControl(TWinControl(Sender).Handle);
    if c is TdhLink then
    begin
     HandleDoubleClickOnLink(TdhLink(c));
     result:=true;
     exit;
    end;
   end;
   if (Message.Msg>=WM_MOUSEFIRST) and (Message.Msg<=WM_MOUSELAST) then
   begin
   if {(message.msg=WM_MOUSEWHEEL) or (message.msg<>WM_RBUTTONDOWN) and (message.msg<>WM_RBUTTONUP) and }
     (Sender.Perform(CM_DesignHitTest,Message.wParam,Message.lParam)<>0) then
   begin
       //Sender.Perform(Message.Msg,Message.wParam,Message.lParam);
       //result:=false;
   end else
   begin
       case Message.Msg of
       WM_MOUSEMOVE: MySiz.DesignMouseMove;
       WM_LBUTTONDOWN: MySiz.DesignMouseDown(mbLeft,GetShiftState);
       WM_RBUTTONDOWN: MySiz.DesignMouseDown(mbRight,GetShiftState);
       WM_MBUTTONDOWN: MySiz.DesignMouseDown(mbMiddle,GetShiftState);
       WM_LBUTTONUP: MySiz.DesignMouseUp(mbLeft);
       WM_RBUTTONUP: MySiz.DesignMouseUp(mbRight);
       WM_MBUTTONUP: MySiz.DesignMouseUp(mbMiddle);
       end;
       result:=true;
   end;
   end;
end;
{$ENDIF}

procedure TPageContainer.PaintGrid;
begin

end;

procedure TPageContainer.PaintMenu;
begin

end;

procedure TPageContainer.ValidateRename2(AComponent: TComponent;
      const CurName, NewName: string);
begin

end;

procedure TPageContainer.SetCustomForm(Value: TCustomForm);
begin

end;

procedure TPageContainer.SetIsControl(Value: Boolean);
begin

end;

function TPageContainer.UniqueName(const BaseName: string): string;
begin

end;

procedure TPageContainer.Modified;
begin

end;

procedure TPageContainer.Notification2(AnObject: TPersistent;
  Operation: TOperation);
begin

end;

constructor TPageContainer.Create(AOwner: TComponent);   
begin
  //inherited;//exit;

  CreateNew(AOwner); //dont use TPageContainer-dfm


      Include(FFormState, fsCreating);
      try

  //if Owner<>nil then
  //FormStyle := fsMDIChild;
  KeyPreview := True;
  Visible:=false;
  //Name:='PageContainer';//_GetUniqueName(Self,'PageContainer');//'PageContainer_1';

  FUndo:=TObjectList.Create;
  FRedo:=TObjectList.Create;
  FBackHistory:=TObjectList.Create;
  FForwardHistory:=TObjectList.Create;

  MySiz:=TMySiz.Create(Self);
  MySiz.Parent:=Self;
{$IFDEF CLX}
  DesignerHook:=Self;
  Font.Weight:=fwNormal;
{$ELSE}
  Designer:=Self;
{$ENDIF}
 Scaled:=False;

      finally
        Exclude(FFormState, fsCreating);
      end;

end;

procedure TPageContainer.ControlPaintRequest(Control: TControl);
begin

end;

procedure TPageContainer.Resize;
{$IFNDEF CLX}
var
  Placement : TWindowPlacement;
  crect,interRect:TRect;
  w,h,i:integer;
  c:tcontrol;
{$ENDIF}
begin
 inherited;
{$IFNDEF CLX}
  if csLoading in ComponentState then exit;

  if self.WindowState=wsNormal then exit;
  exit; //sonst probleme mit Templates-Snapshots
//  if not (QWidget_isMaximized(Self.Handle) or QWidget_isMinimized(Self.Handle)) then exit;
  Placement.length :=SizeOf(TWindowPlacement);

  {for i:=1 to ControlCount-1 do
  begin
   c:=Controls[i];
   crect:=c.BoundsRect;

   //   not IsRectEmpty(crect) then
   if crect.Bottom>342 then
    crect:=crect;
  end;  }
  if GetWindowPlacement(Handle, @Placement) then
  begin
   (*if {EqualRect(Placement.rcNormalPosition,dhMainForm.ClientRect)}Placement.rcNormalPosition.Right-Placement.rcNormalPosition.Left=800 then
    Placement.showCmd := SW_SHOWMAXIMIZED;
   if ((Placement.showCmd=SW_SHOWMINIMIZED) or (Placement.showCmd=SW_SHOWMAXIMIZED)) then exit;
   *)
   crect:=dhMainForm.ClientRect;
   dec(crect.Bottom,dhMainForm.dhPanel1.Height);
   if PropsAlign in [alLeft,alRight] then
    dec(crect.Right,Tabs.Width) else
    dec(crect.Bottom,Tabs.Height);
   if not IntersectRect(interRect,crect,Placement.rcNormalPosition) or
      not EqualRect(interRect,Placement.rcNormalPosition) then
   begin
    w:=crect.Right-crect.Left;
    h:=crect.Bottom-crect.Top;
    w:=min(w,h);
    h:=w;
    Placement.rcNormalPosition.Top:=crect.Top+h div 6;
    Placement.rcNormalPosition.Left:=crect.Left+w div 6;
    Placement.rcNormalPosition.Bottom:=crect.Bottom-h div 6;
    Placement.rcNormalPosition.Right:=crect.Right-w div 6;
    SetWindowPlacement(Handle, @Placement);
   end;
    // make use of Placement.rcNormalposition.Left, .Top, .Right, etc.
  end;
{$ENDIF}
end;

{$IFDEF CLX}
procedure AdjustMDIChildFrameWidth(Widget: QWidgetH; var AWidth: Integer; Reset: Boolean);
const
  FrameSize = 2;
begin
  if Reset then
    AWidth := AWidth - FrameSize * 2
  else
    AWidth := AWidth + FrameSize * 2;
end;

procedure AdjustMDIChildFrameHeight(Widget: QWidgetH; var AHeight: Integer; Reset: Boolean);
const
  FrameSize = 2;
var
  TitleHeight: Integer;
  win: QWidgetH;
begin
  win := QWidget_parentWidget(Widget);
  { Test for MDI Child widget }
  if (win = nil) or (QObject_className(win) <> 'QWorkspaceChild') then
    Exit;

  if not QWidget_testWFlags(win, Integer(WidgetFlags_WStyle_Tool)) then
  begin
{$IFDEF MSWINDOWS}
    TitleHeight := GetSystemMetrics(SM_CYCAPTION);
    if TitleHeight = 0 then
{$ENDIF}
      TitleHeight := 18; // from QWorkspace.cpp
  end
  else
  begin
{$IFDEF MSWINDOWS}
    TitleHeight := GetSystemMetrics(SM_CYSMCAPTION);
    if TitleHeight = 0 then
{$ENDIF}
      TitleHeight := 16; // from QWorkspace.cpp
  end;

  if Reset then
    AHeight := AHeight - (TitleHeight + FrameSize * 2 + 1)
  else
    AHeight := AHeight + (TitleHeight + FrameSize * 2 + 1);
end;


function TPageContainer.GetClientRect: TRect;
begin
(*  result:=Inherited GetClientRect;
  if not (csDesigning in ComponentState) and (FormStyle = fsMDIChild) and
    not{!!}(WindowState <> wsMaximized) then
  begin
    AdjustMDIChildFrameWidth(Handle, Result.Right, True);
    AdjustMDIChildFrameHeight(Handle, Result.Bottom, True);
  end;*)
  Result:=Bounds(0,0,Width,Height);
{$IFDEF MSWINDOWS}
  if not (csDesigning in ComponentState) and (FormStyle = fsMDIChild) then
  begin
    AdjustMDIChildFrameWidth(Handle, Result.Right, True);
    AdjustMDIChildFrameHeight(Handle, Result.Bottom, True);
  end;
{$ENDIF}
end;
{$ENDIF}


//see TWriter.WriteProperties
procedure TMyReader.FixEnumerationProps(Comp:TComponent; Instance: TPersistent);
var
  I, Count: Integer;
  PropInfo: PPropInfo;
  PropList: PPropList;
  Value: TObject;
  PropType: PTypeInfo;
  Handled:Boolean;
begin 
  Count := GetTypeData(Instance.ClassInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      GetPropInfos(Instance.ClassInfo, PropList);
      for I := 0 to Count - 1 do
      begin
        PropInfo := PropList^[I];
        if PropInfo = nil then
          Break;
        PropType := PropInfo^.PropType^;

        case PropType^.Kind of
        tkEnumeration:
        if GetOrdProp(Instance, PropInfo)=255 then
        begin
         SetOrdProp(Instance, PropInfo, 0);
         MyOnError(Self,DKFormat(INVALIDPROPERTYVALUE,Comp.Name+'/'+PropInfo.Name),Handled);
        end;
        tkClass:
        begin

         Value := TObject(GetOrdProp(Instance, PropInfo));
         if Value is TPersistent then
         if Value is TComponent then else
          FixEnumerationProps(Comp,TPersistent(Value));
          //WriteObjectProp;
        end;

        end;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;

procedure TPageContainer.Loaded;
begin

  inherited;
{$IFNDEF CLX}
  Font.Height:=-Abs(Font.Height); //CLX saves always positiv Font.Height (and Font.Size),
                                  //which is equivalent to a negative VCL Font.Height value
{$ENDIF}
  Font.Color:=clBlack;
  if MySiz.FindBody<>nil then
   MySiz.FindBody.Align:=alClient;
end;

procedure TPageContainer.ReadState(Reader: TReader);
var i:integer;
begin
 Inherited;
 if Reader is TMyReader then
 begin
  TMyReader(Reader).FixEnumerationProps(Self,Self);
  for i:=0 to ComponentCount-1 do
   TMyReader(Reader).FixEnumerationProps(Components[i],Components[i]);
 end;
end;


procedure TPageContainer.Activate;
begin
 inherited;
 if not (csDestroying in ComponentState) then //possible at CLX
  UpdateActiveMDI;
end;

procedure TPageContainer.UpdateActiveMDI(Deactivate:boolean=false);
var Eq:boolean;
begin
 Eq:=dhMainForm.Act=Self;
 if not Deactivate and not Eq or Deactivate and Eq then
 begin                       
  if not Deactivate and not Eq then
   Tabs.CommitChanges;
  if Deactivate then
   dhMainForm.Act:=nil else
   dhMainForm.Act:=Self;
  //if not (not Deactivate and Eq) then
   dhMainForm.UpdateCommands(true,true);
 end;
end;


procedure TPageContainer.Deactivate;
begin
  inherited;
  MySiz.StopPositioning;
{ if dhMainForm.Act<>Self then
  dhMainForm.cbName.Clear;
  }
end;


function TPageContainer.CloseQuery: Boolean;
var s:WideString;
begin
  Result:=Tabs.CommitChanges and inherited CloseQuery;
  if not Result then exit;
  if IsModified then
  begin                           
    if IsUntitled then
     s:=DKFormat(SAVEUNTITLED) else
     s:=DKFormat(SAVETO,FileName);
    case MessageDlg(s, mtConfirmation,[mbYes, mbNo, mbCancel], 0) of
      {idYes}mrYes: if not Save then Result := False;
      {idCancel}mrCancel: Result := False;
    end;
  end;
  if Result and not IsUntitled then
  begin
   if FuncSettings.LRUfiles.IndexOf(FileName)=-1 then
   if WhereToInsert>=0 then
   begin
    FuncSettings.LRUfiles.Insert(WhereToInsert,FileName);
    inc(WhereToInsert);
   end else
    FuncSettings.LRUfiles.Insert(0,FileName);
   if FuncSettings.LRUfiles.Count>=16 then
   begin
    FuncSettings.LRUfiles.Delete(FuncSettings.LRUfiles.Count-1);
    dec(WhereToInsert);
   end;
  end;
end;

procedure TPageContainer.DoClose(var Action: TCloseAction);
begin
  Action:=caFree;
  inherited;
end;

procedure TPageContainer.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;   
// if not dhMainForm.Menu.IsShortCut() then
  MySiz.DoKeyDown(Key,Shift);
end;

procedure TPageContainer.KeyUp(var Key: Word; Shift: TShiftState);
begin
 inherited;
 MySiz.DoKeyUp(Key,Shift);
end;

function TPageContainer.ForPreview:boolean;
begin
 result:=Owner=nil;
end;


procedure TPageContainer.SetName(const NewName: TComponentName);
var i,n:integer;
begin
 if {SubEqual('PageContainer',Name) and }not ForPreview and SubEqual('PageContainer',NewName) then
 begin
  i:=Pos('_',NewName);
  if (i<>-1) and TryStrToInt(Copy(NewName,i+1,maxint),n) then
  begin
   inherited SetName(TdhCustomPanel._GetUniqueName(Self,'PageContainer'));
   exit;
  end;
 end;
 inherited;
end;


procedure TPageContainer.AlignControls(AControl: TControl; var Rect: TRect);
begin
 Inherited;
 Tabs.ActBoundsChanged;
end;
                                 
{$IFDEF CLX}
procedure TPageContainer.MouseLeave(AControl: TControl);
{$ELSE}
procedure TPageContainer.CMMouseLeave(var Message: TMessage);
{$ENDIF}
begin
 inherited;
 MySiz.DesignMouseMove; //clear name and pos statusbar fields
end;

function TPageContainer.RootPath:TPathName;
begin
 if IsUntitled then
  Result:='' else
  Result:=GoodLocalPath(ExtractFileDir(Filename));
end;

function TRelativePathProvider.GetRelativePath(const Path:TPathName):TPathName;
begin
 if isAbsolute(Path) and isAbsolute(RootPath) and not IsCopying then
 begin
  if SubEqual(GoodPathDelimiters(LowerCase(RootPath)),GoodPathDelimiters(LowerCase(Path))) then
  begin
   Result:=Copy(Path,Length(RootPath)+1,MaxInt);
   Exit;
  end;
 end;
 Result:=Path;
end;

function TRelativePathProvider.GetAbsolutePath(const Path:TPathName):TPathName;
begin
 if not isAbsolute(Path) and isAbsolute(RootPath) then
 begin
  Result:=RootPath+Path;
  Exit;
 end;
 Result:=Path;
end;

end.


