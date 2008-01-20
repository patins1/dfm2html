unit Unit1;

interface

{$DEFINE FINALV}

{$R DFM2HTML.dkl_const.res}

uses

  SysUtils, Classes, TypInfo, {$IFNDEF VER130} types, {schnelles IntersectRect} {$ENDIF}
{$IFDEF CLX}
  QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls, QComCtrls,  QStdCtrls, GIFImage, QTntStdCtrls,
  QImgList, QMenus, QClipbrd, QStyle,
{$ELSE}
  {uMutex,}Controls, Forms, Windows, Messages, Graphics, Dialogs, ExtCtrls, clipbrd, Buttons, GIFImage, JPeg,
  ComCtrls, CommCtrl, StdCtrls, ShellAPI, RTLConsts,  Menus,
  {Mask, }ToolWin, ImgList,   AppEvnts, {IECache,} URLDropTarget, XPMan, TntStdCtrls,TntSysUtils,TntSystem, TntMenus, TntComCtrls,//XPdesign,
{$ENDIF}
  Unit2, dhDirectHTML,
  MySpeedButton, dhPanel, htmlrout, {$IFDEF MSWINDOWS}HttpProt,{$ELSE}{IcsUrl,}{$ENDIF}
  funcutils, dhHTMLForm,  dhPageControl,  dhStyleSheet,
  dhMenu, dhLabel, dhEdit, MySpinEdit,
  UseFastStrings, crc, math,
  MySiz, Unit3, uConversion,
  dhRadioButton, dhMemo, dhFileField,  MyToolButton,
  dhColorPicker,IniFiles,gr32, uOptions, menuhelper,
  pngimage, Contnrs,hEdit,hComboBox,hMemo, UIConstants,DKLang;

//const WM_PUSHUP=WM_USER+33;

const LANGID_GERMAN=1031;  

type TActionArea=(aaAll,aaGroup,aaOne);

type
  TdhMainForm = class(TForm)
    OpenDialog1: TOpenDialog;
    ImageList1: TImageList;
    ToolBar1: TTntToolBar;
    compPageControl: TTntToolButton;
    compText: TTntToolButton;
    compPanel: TTntToolButton;
    compImg: TTntToolButton;
    compStyleSheet: TTntToolButton;
    SaveDialog1: TSaveDialog;
    compDirectHTML: TTntToolButton;
    compForm: TMyToolButton;
    compPage: TTntToolButton;
    MainMenu1: TTntMainMenu;
    mFile: TTntMenuItem;
    mSave: TTntMenuItem;
    mSaveAll: TTntMenuItem;
    mSaveAs: TTntMenuItem;
    mEdit: TTntMenuItem;
    mCopy: TTntMenuItem;
    mPaste: TTntMenuItem;
    mDelete: TTntMenuItem;
    mCut: TTntMenuItem;
    mUndo: TTntMenuItem;
    mRedo: TTntMenuItem;
    mExit: TTntMenuItem;
    mNew: TTntMenuItem;
    mOpen: TTntMenuItem;
    N1: TTntMenuItem;
    N2: TTntMenuItem;
    N3: TTntMenuItem;
    compMenu: TTntToolButton;
    N4: TTntMenuItem;
    mGenerateHTML: TTntMenuItem;
    PopupMenu1: TTntPopupMenu;
    IGNORE_FormEles: TTntMenuItem;
    mForm: TTntMenuItem;
    mCheckbox: TTntMenuItem;
    mRadiobutton: TTntMenuItem;
    mEditfield: TTntMenuItem;
    mTextarea: TTntMenuItem;
    mCombobox: TTntMenuItem;
    mListbox: TTntMenuItem;
    mFileField: TTntMenuItem;
    compAnchor: TTntToolButton;
    mClose: TTntMenuItem;
    mTools: TTntMenuItem;
    mOptions: TTntMenuItem;
    mAbout: TTntMenuItem;
    mWindow: TTntMenuItem;
    mArrangeIcons: TTntMenuItem;
    mTile: TTntMenuItem;
    mCascade: TTntMenuItem;
    DEBUG_GeneratePASfile1: TTntMenuItem;
    mReopen: TTntMenuItem;
    LRUitem: TTntMenuItem;
    DEBUG_Debug1: TTntMenuItem;
    mResetButton: TTntMenuItem;
    mSubmitButton: TTntMenuItem;
    mOpenOutputDirectory: TTntMenuItem;
    DEBUG_mDebug: TTntMenuItem;
    mSelectAll: TTntMenuItem;
    N5: TTntMenuItem;
    mSelectAllBelow: TTntMenuItem;
    mSelectAllAbove: TTntMenuItem;
    mTutorial: TTntMenuItem;
    mHomepage: TTntMenuItem;
    N6: TTntMenuItem;
    bBack: TTntToolButton;
    bForward: TTntToolButton;
    SpeedButton1: TMySpeedButton;
    PopupMenu2: TTntPopupMenu;
    CLXFormcontainer1: TTntMenuItem;
    CLXMenuItem3: TTntMenuItem;
    CLXMenuItem4: TTntMenuItem;
    CLXMenuItem5: TTntMenuItem;
    CLXMenuItem6: TTntMenuItem;
    CLXMenuItem7: TTntMenuItem;
    CLXMenuItem8: TTntMenuItem;
    CLXMenuItem9: TTntMenuItem;
    CLXMenuItem10: TTntMenuItem;
    CLXMenuItem11: TTntMenuItem;
    dhPanel1: TdhPanel;
    compOle: TTntToolButton;
    mHiddenField: TTntMenuItem;
    mPublish: TTntMenuItem;
    mPublishMenu: TTntMenuItem;
    mPageProperties: TTntMenuItem;
    N9: TTntMenuItem;
    mViewOnline: TTntMenuItem;
    mNewFromTemplate: TTntMenuItem;
    CLXHiddenfield2: TTntMenuItem;
    Panel1: TPanel;
    cbName: ThComboBox;
    mFullCopy: TTntMenuItem;
    StatusBar: TStatusBar;
    mSaveAsTemplate: TTntMenuItem;
    N10: TTntMenuItem;
    mPresets: TTntMenuItem;
    mCloseAll: TTntMenuItem;
    N11: TTntMenuItem;
    DEBUG_ConverttoPNG1: TTntMenuItem;
    dhPanel2: TdhPanel;
    STYLE_dhStyleSheet1: TdhStyleSheet;
    stateNormal: TdhLink;
    stateTest: TdhLink;
    stateOver: TdhLink;
    stateDown: TdhLink;
    stateOverDown: TdhLink;
    STYLE_Link1: TdhLink;
    DEBUG_CopyWithMeta1: TTntMenuItem;
    STYLE_dhStyleSheet2: TdhStyleSheet;
    STYLE_dhLink8: TdhLink;
    STYLE_Link2: TdhLink;
    STYLE_dhLabel10: TdhLabel;
    STYLE_Link14: TdhLink;
    STYLE_Label28: TdhLabel;
    mTechnicalSupport: TTntMenuItem;
    mRegister: TTntMenuItem;
    mVisitForum: TTntMenuItem;
    N7: TTntMenuItem;
    DEBUG_mUnregister: TTntMenuItem;
    DEBUG_OpenIE1: TTntMenuItem;
    N12: TTntMenuItem;
    mFind: TTntMenuItem;
    mSearchAgain: TTntMenuItem;
    mReplace: TTntMenuItem;
    DEBUG_ANSIUNICODE1: TTntMenuItem;
    m5minGuide: TTntMenuItem;
    mGuide: TTntMenuItem;
    mBasicExample: TTntMenuItem;
    N16: TTntMenuItem;
    mBasicExamplewithFooter: TTntMenuItem;
    mBasicExamplewithStylesheet: TTntMenuItem;
    mBasicExamplewithFramesLayout: TTntMenuItem;
    N13: TTntMenuItem;
    DEBUG_OnLoad1: TTntMenuItem;
    DEBUG_Dokumentende1: TTntMenuItem;
    compFile: TTntToolButton;
    N14: TTntMenuItem;
    mLanguage: TTntMenuItem;
    mLanguageTemplate: TTntMenuItem;
    DKLanguageController1: TDKLanguageController;
    DEBUG_UpdateCodePage: TTntMenuItem;
    GenerateTimer: TTimer;
    N8: TTntMenuItem;
    DEBUG_PosIE1: TTntMenuItem;
    DEBUG_PosFF1: TTntMenuItem;
    MenuTutorial1: TTntMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure csEndSize(Sender: TObject);
    procedure shMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Openproject1Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure mCopyClick(Sender: TObject);
    procedure mPasteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
{$IFNDEF CLX}
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
{$ENDIF}
    procedure mDeleteClick(Sender: TObject);
    procedure mCutClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure compImgClick(Sender: TObject);
    procedure compPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mSaveClick(Sender: TObject);
    procedure mSaveAllClick(Sender: TObject);
    procedure mSaveAsClick(Sender: TObject);
    procedure mUndoClick(Sender: TObject);
    procedure mRedoClick(Sender: TObject);
    procedure ext1Click(Sender: TObject);
    procedure ViewHTML1Click(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure compFormClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure mFormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure stateDownClick(Sender: TObject);
    procedure stateOverClick(Sender: TObject);
    procedure stateOverDownClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure stateNormalClick(Sender: TObject);
    procedure cbNameChange(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure mCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mAboutClick(Sender: TObject);
    procedure mOptionsClick(Sender: TObject);
    procedure mCascadeClick(Sender: TObject);
    procedure mTileClick(Sender: TObject);
    procedure mArrangeIconsClick(Sender: TObject);
    procedure DEBUG_GeneratePASfile1Click(Sender: TObject);
    procedure mReopenClick(Sender: TObject);
    procedure LRUitemClick(Sender: TObject);
    procedure DEBUG_Debug1Click(Sender: TObject);
    procedure mOpenOutputDirectoryClick(Sender: TObject);
    procedure mSelectAllClick(Sender: TObject);
    procedure mTutorialClick(Sender: TObject);
    procedure mHomepageClick(Sender: TObject);
    procedure bBackClick(Sender: TObject);
    procedure bForwardClick(Sender: TObject);
    procedure SpeedButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mPublishClick(Sender: TObject);
    procedure mPagePropertiesClick(Sender: TObject);
    procedure mViewOnlineClick(Sender: TObject);
    procedure mNewFromTemplateClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure mFullCopyClick(Sender: TObject);
    procedure mSaveAsTemplateClick(Sender: TObject);
    procedure mPresetsClick(Sender: TObject);
    procedure mCloseAllClick(Sender: TObject);
    procedure mNewClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DEBUG_ConverttoPNG1Click(Sender: TObject);
    procedure PropsPCLoadfromHTTPaddress1Click(Sender: TObject);
    procedure DEBUG_CopyWithMeta1Click(Sender: TObject);
    procedure mTechnicalSupportClick(Sender: TObject);
    procedure mRegisterClick(Sender: TObject);
    procedure mVisitForumClick(Sender: TObject);
    procedure DEBUG_mUnregisterClick(Sender: TObject);
    procedure DEBUG_OpenIE1Click(Sender: TObject);
    procedure mFindClick(Sender: TObject);
    procedure mSearchAgainClick(Sender: TObject);
    procedure DEBUG_ANSIUNICODE1Click(Sender: TObject);
    procedure m5minGuideClick(Sender: TObject);
    procedure mBasicExampleClick(Sender: TObject);
    procedure mBasicExamplewithFooterClick(Sender: TObject);
    procedure mBasicExamplewithStylesheetClick(Sender: TObject);
    procedure mBasicExamplewithFramesLayoutClick(Sender: TObject);
    procedure DEBUG_OnLoad1Click(Sender: TObject);
    procedure DEBUG_Dokumentende1Click(Sender: TObject);
    procedure mLanguageTemplateClick(Sender: TObject);
    procedure DEBUG_UpdateCodePageClick(Sender: TObject);
    procedure GenerateTimerTimer(Sender: TObject);
    procedure DEBUG_PosIE1Click(Sender: TObject);
    procedure DEBUG_PosFF1Click(Sender: TObject);
    procedure MenuTutorial1Click(Sender: TObject);
  private
    LastFile:string;
    FAct:TPageContainer;
    AlreadyCalled:boolean;
    RegString:string;

{$IFNDEF CLX}
    HttpCli1: THttpCli;
    procedure HttpCli1RequestDone(Sender  : TObject; RqType  : THttpRequest; ErrCode : Word);
{$ENDIF}
    procedure UpdateLanguage;
    procedure UpdateOtherConstants;
    procedure UpdateStatusBar;
    procedure WriteSmartPublishingCRCs;
    procedure ReadSmartPublishingCRCs;
    procedure MyBeforeDrawItemEvent(Sender: TObject; Canvas: TCanvas; const Rect: TRect; Flags: Integer;
      Enabled: Boolean; Bitmap: TBitmap; const Text: WideString; Length: Integer; Color: TColor;
    var DefaultDraw: Boolean);
    procedure MyDrawTabEvent(Sender, Source: TObject; Canvas: TCanvas; Index, HorizonalPadding,
      VerticalPadding, Overlap: Integer; Selected: Boolean);
    procedure URLDropTarget1DragOver(Sender: TObject; var Accept: HRESULT);
    procedure URLDropTarget1Drop(Sender: TObject);
    function ProcessDragDrop(Sender: TObject; Drop:boolean):boolean;
    procedure ReadConfig;
    procedure WriteConfig;
    procedure SetDesignStyle(ds: TState; runtime: boolean);
    procedure SetSaveDir;
    procedure LoadFormElement(men: TMenuItem);
    procedure LoadDragURL;
    procedure DoStartUp;
    function UpdateRegistrationStatus(const RegString: String): boolean;
    procedure InvalAll;
//    Procedure WMPUSHUP(Var Msg: TMessage); message WM_PUSHUP;
    { Private declarations }
  protected
    function CloseQuery: Boolean; override;
    procedure Loaded; override;
    //procedure CreateParams(var Params: TCreateParams); override;
    procedure UpdateStateClearing;     
    function GetTopLevelDomain:String;
  public
    { Public declarations }
    destructor Destroy; override;
    property Act:TPageContainer read FAct write FAct;
    procedure UpdateNames(find:TControl);
    procedure ImageFromURL(URL:string; c:TControl);
    function Open(FileName: string; SetUntitled:boolean; Unvisible:boolean=false):TPageContainer;
    procedure UpdateHistory;

{$IFNDEF CLX}
    function IsShortCut(var Message: TWMKey): Boolean; override;
{$ENDIF}
    procedure UpdateCommands(SelChange,SiteChange:boolean);
    //function Act:TPageContainer;
    procedure Paint; override;
    procedure ApplyNewSettings(FontToCurrent:boolean; FontToAll:boolean);
  end;

var
  dhMainForm: TdhMainForm;
var FuncSettings:TFuncSettings;
    LockLock:boolean=false;
//    ActForm:TForm=nil;

type TFakeWinControl=class(TWinControl);

var
  CF_COMPONENTS: Word;
const sCF_COMPONENTS={'Delphi Components'}'application/delphi.component';

const
 StatusBar_Mode=0;
 StatusBar_Modified=1;
 StatusBar_ObjName=2;
 StatusBar_ObjPos=3;


implementation

uses uWarnings, uPublishLog, uPublishFTP, uTemplates, uPresets, uStartUp,
  uColorPicker, uPageWizard;

{$R *.dfm}

var _LANGID:LANGID;

var RasteringSaveDir:string;

var CrcList:TObjectList;



type PFontStyles=^TFontStyles;

const
      configFile='Config.ini';
      crcFile='SmartPublishingCRCs.txt';

var BaseDir:string;
//    PureFileName:string;

function RootDir(const s:string): string;
begin
 result:=ExtractFilePath(Application.Exename)+s;
end;


const sPropsAlign:array[TAlign] of string=('Horizontal', 'Top', 'Bottom', 'Left', 'Right', 'Vertical','x');

function EncodePsw(const s:String):string;
var i:integer;
begin
 result:=lowercase(s);
 for i:=1 to length(s) do
 if result[i] in ['a'..'z'] then
 begin
  inc(result[i],13);
  if result[i]>'z' then
   dec(result[i],ord('z')-ord('a')+1);
 end;
end;

function DecodePsw(const s:String):string;
var i:integer;
begin
 result:=lowercase(s);
 for i:=1 to length(s) do
 if result[i] in ['a'..'z'] then
 begin
  dec(result[i],13);
  if result[i]<'a' then
   inc(result[i],ord('z')-ord('a')+1);
 end;
end;
var LngFile:TMemIniFile;

procedure ReadLanguage;
begin
 LngFile:=TMemIniFile.Create(RootDir(configFile));
end;


procedure TdhMainForm.ReadConfig;
var
    IniFile:TMemIniFile;
    firststarted:boolean;
    DefaultFontStyle:integer;
    i:integer;
    s:String;
    iPropsAlign:TAlign;
begin
  firststarted:=true;
 try
 IniFile:=TMemIniFile.Create(RootDir(configFile));

 with IniFile do
 try

  firststarted:=ReadString('Program','V',EmptyStr)=EmptyStr;

  UpdateRegistrationStatus(DecodePsw(ReadString('Program','R',EmptyStr)));

  LastFile:=ReadString('Program','Last File',EmptyStr);

  with FuncSettings do
  begin
  FGridX:=ReadInteger('Grid','GridX',8);
  FGridY:=ReadInteger('Grid','GridY',8);
  FGridDisplay:=TGridDisplay(ReadInteger('Grid','Display',0));
  FViewer:=ReadString('General','Viewer',EmptyStr);
  FSmartPublishing:=ReadBool('General','Smart Publishing',true);
  FPassiveFTP:=ReadBool('General','Passive FTP',true);
  end;

  FuncSettings.Compress:=ReadBool('General','Compress',false);

  FuncSettings.DefaultFont.Name:=ReadString('General','Default Font Name','Arial');
  FuncSettings.DefaultFont.Size:=ReadInteger('General','Default Font Size',12);
  DefaultFontStyle:=ReadInteger('General','Default Font Style',0);
  FuncSettings.DefaultFont.Style:=PFontStyles(@DefaultFontStyle)^;

  
  _LANGID:=ReadInteger('General','LANGID',{$IFDEF CLX}LangManager.LanguageIDs[0]{$ELSE}GetSystemDefaultLangID{$ENDIF});

  //FuncSettings.DefaultFont.Charset:=ReadInteger('General','Default Font Charset',DEFAULT_CHARSET);

  for i:=0 to ReadInteger('LRU','Count',0)-1 do
  begin
   s:=ReadString('LRU','File'+inttostr(i),EmptyStr);
   if s<>EmptyStr then
    FuncSettings.LRUfiles.Add(s);
  end;


  s:=ReadString('General','PropsAlign',EmptyStr);
  for iPropsAlign:=Low(TAlign) to High(PropsAlign) do
  if sPropsAlign[iPropsAlign]=s then
   PropsAlign:=iPropsAlign;

      {
  if s='Horizontal' then
   PropsAlign:=alNone else
  if s='Vertical' then
   PropsAlign:=alClient else
  if s='Bottom' then
   PropsAlign:=alBottom else
  if s='Left' then
   PropsAlign:=alLeft else
  if s='Top' then
   PropsAlign:=alTop else
  if s='Right' then
   PropsAlign:=alRight;   }

  {if firststarted then
  begin
   FuncSettings.LRUfiles.Add(ExtractFileDir(Application.ExeName)+'\'+'Tutorial.dfm');
   LastFile:=ExtractFileDir(Application.ExeName)+'\'+'Tutorial.dfm';
  end;   }
 finally
  Free;
 end;

 except
 on e:Exception do
  showmessage('Cannot read '+RootDir(configFile)+endl+
              'System error message:'+endl+
              e.Message);
 end;
         {
 if firststarted then
 begin
  WriteConfig;
 end;    }

end;

procedure TdhMainForm.ReadSmartPublishingCRCs;
var sl:TStringList;
    i,p:integer;
    s:string;
begin

 sl:=TStringList.Create;
 try
 try
  if FSmartPublishing then
   sl.LoadFromFile(RootDir(crcFile));
  for i:=0 to sl.Count-1 do
  begin
   s:=sl[i];
   if (s<>EmptyStr) and (s[length(s)]='/') then
   begin
    SetLength(Uploaded,Length(Uploaded)+1);
    Uploaded[High(Uploaded)].FTP:=s;
   end else
   begin
    p:=Pos('=',s);
    if p<>0 then
    with Uploaded[High(Uploaded)] do
    begin
     SetLength(Files,Length(Files)+1);
     Files[High(Files)].FileName:=Copy(s,1,p-1);
     Files[High(Files)].CRC:=StrToInt('$'+Copy(s,p+1,maxint));
    end;
   end;
  end;
 finally
  sl.Free;
 end;
 except
 end;
end;


procedure TdhMainForm.WriteSmartPublishingCRCs;
var sl:TStringList;
    i,w:integer;
begin
 sl:=TStringList.Create;
 try
 for i:=Low(Uploaded) to High(Uploaded) do
 with Uploaded[i] do
 begin
  sl.Add(FTP);
  for w:=Low(Files) to High(Files) do
  with Files[w] do
  begin
   sl.Add(FileName+'='+inttohex(CRC,8));
  end;
 end;
 sl.SaveToFile(RootDir(crcFile));
 finally
  sl.Free;
 end;
end;


procedure TdhMainForm.WriteConfig;
var IniFile:TMemIniFile;
    DefaultFontStyle:integer;
    i:integer;
    s:string;
begin
 try
 IniFile:=TMemIniFile.Create(RootDir(configFile));

 with IniFile do
 begin
  Clear;
  WriteString('Program','V','1.2');
  //WriteString('Program','R',EncodePsw(RegString));

  if Act<>nil then
   WriteString('Program','Last File', Act.FileName);


  with FuncSettings do
  begin
  WriteInteger('Grid','GridX',FGridX);
  WriteInteger('Grid','GridY',FGridY);
  WriteInteger('Grid','Display',Integer(FGridDisplay));
  WriteString('General','Viewer',FViewer);
  WriteBool('General','Smart Publishing',FSmartPublishing);
  WriteBool('General','Passive FTP',FPassiveFTP);
  end;

  WriteBool('General','Compress',FuncSettings.Compress);

  WriteString('General','Default Font Name',FuncSettings.DefaultFont.Name);
  WriteInteger('General','Default Font Size',FuncSettings.DefaultFont.Size);
  PFontStyles(@DefaultFontStyle)^:=FuncSettings.DefaultFont.Style;
  WriteInteger('General','Default Font Style',DefaultFontStyle);
  //WriteInteger('General','Default Font Charset',FuncSettings.DefaultFont.Charset);

  WriteInteger('LRU','Count',FuncSettings.LRUfiles.Count);
  for i:=0 to FuncSettings.LRUfiles.Count-1 do
   WriteString('LRU','File'+inttostr(i),FuncSettings.LRUfiles[i]);

  WriteString('General','PropsAlign',sPropsAlign[PropsAlign]);

  WriteInteger('General','LANGID',_LANGID);

  UpdateFile;
  Free;
 end;

 except
 on e:Exception do
  showmessage(DKFormat(SAVETOERROR,RootDir(configFile))+endl+
              DKFormat(SYSTEMERROR)+':'+endl+
              e.Message);
 end;

end;



procedure TdhMainForm.Exit1Click(Sender: TObject);
begin
 Application.Terminate;
end;

type TFakeToolButton=class(TToolButton);
procedure TdhMainForm.Button1Click(Sender: TObject);
var p:TdhStyleSheet;
 l:TdhPanel;

var sdc,ScreenDC:hdc;
var
  R: TRect;
begin
{  R := StyleSheet1.BoundsRect;
  InflateRect(R, 1, 1);
  InvalidateRect(StyleSheet1.Parent.Handle, @R, false);
  InvalTrans(StyleSheet1,InvRect);
     }


// compForm.Down:=not compForm.Down;
// TFakeToolButton(toolbutton5).BeginUpdate;
// toolbutton5.Width:=50;
// TFakeToolButton(toolbutton5).EndUpdate;
 //dhstylesheet1.free;

         {
 act.MySiz.BringToFront;
 act.MySiz.SetFocus;  }
  {
  ScreenDC := GetDC(0);
  Canvas.Handle:=ScreenDC;
  sdc:=Canvas.Handle;
                       Canvas.Brush.Style:=bsSolid;
 Canvas.Brush.Color:=clBlack;
    Canvas.FillRect(Rect(120,120,300,300));
  Canvas.Handle:=sdc;
  ReleaseDC(0, ScreenDC);  }

{ (dhAnchor2.Style.BackgroundImage.Graphic as tpngobject).TransparentColor:=clBlue;
 dhAnchor2.Style.BackgroundImage.Graphic.LoadFromFile('C:\HBuilder\acheck2.png');
 (dhAnchor2.Style.BackgroundImage.Graphic as tpngobject).TransparentColor:=clBlue;
 }
// dhAnchor2.Style.BackgroundImage.Graphic.LoadFromFile('C:\HBuilder\acheck.gif');
{ dhAnchor2.Style.BackgroundImage.Graphic.Transparent:=false;
 dhAnchor2.Style.BackgroundImage.Graphic.LoadFromFile('C:\HBuilder\acheck2.png');
 dhAnchor2.Style.BackgroundImage.Graphic.Transparent:=false;
 }    {
 l:=TdhPanel.Create(Self);
 l.Parent:=self;
 l.Color:=clRed;
 l.Width:=100;
 l.Height:=100;  }

 {
 p:=TdhStyleSheet.Create(self);
 p.Visible:=true;
 p.parent:=self;
 p.top:=100;
 p.left:=100;
 p.Width:=100;
 p.Height:=100;
 p.AddStyle(false)   }

end;

function ListName(match,ori:TControl):boolean;
begin
 result:=EditableControl(match,true);
end;
        
{$IFDEF CLX}
function HasComponentFormat:boolean;
begin
 result:=Clipboard.Provides(sCF_COMPONENTS);
end;
{$ELSE}
function HasComponentFormat:boolean;
begin
 result:=Clipboard.HasFormat(CF_COMPONENTS);
end;
{$ENDIF}

procedure TdhMainForm.UpdateNames(find:TControl);
begin
 if _RuntimeMode then
  cbName.Clear else
  GetRefs_(cbName,TControl,Act,find,ListName,false)
end;



procedure TdhMainForm.UpdateCommands(SelChange,SiteChange:boolean);
var i:integer;
    lLock:boolean;
const sMode:array[TState] of string=('Edit','Edit Over','Edit Down','Edit Over/Down');
begin
 //ActForm:=Act;
 if (csDestroying in ComponentState) then exit;
 glLockWindowUpdate(true,lLock);
 try
 mSave.Enabled:=(Act<>nil);
 mSaveAs.Enabled:=(Act<>nil);
 mSaveAsTemplate.Enabled:=(Act<>nil);
 mSaveAll.Enabled:=false;
 mGenerateHTML.Enabled:=(Act<>nil);
 mOpenOutputDirectory.Enabled:=(Act<>nil);
 mPublish.Enabled:=(Act<>nil) and (Act.MySiz.FindBody<>nil);
 mViewOnline.Enabled:=mPublish.Enabled;
 mPageProperties.Enabled:=(Act<>nil) and (Act.MySiz.FindBody<>nil) and not _RuntimeMode;
 mClose.Enabled:=(Act<>nil);
 mCloseAll.Enabled:=(Act<>nil);
 for i:=0 to MDIChildCount-1 do
 if not (csDestroying in MDIChildren[i].ComponentState) and (MDIChildren[i] as TPageContainer).IsModified then
 begin
  mSaveAll.Enabled:=true;
  break;
 end;
 UpdateHistory;
 mCut.Enabled:=(Act<>nil) and Act.HasSelectedComponents and not _RuntimeMode;
 mCopy.Enabled:=mCut.Enabled;
 mFullCopy.Enabled:=mCopy.Enabled;
 mPaste.Enabled:=mCut.Enabled{ and HasComponentFormat};
 mDelete.Enabled:=mCut.Enabled;

 tabs.mCut.Enabled:=mCut.Enabled;
 tabs.mCopy.Enabled:=mCopy.Enabled;
 tabs.mPaste.Enabled:=mPaste.Enabled;
 tabs.mDelete.Enabled:=mDelete.Enabled;
 tabs.mFullCopy.Enabled:=mFullCopy.Enabled;

 mSelectAll.Enabled:=mCut.Enabled;
 mSelectAllAbove.Enabled:=mCut.Enabled;
 mSelectAllBelow.Enabled:=mCut.Enabled;

 mUndo.Enabled:=(Act<>nil) and Act.IsModified and not _RuntimeMode;
{$IFNDEF FINALV}
 if mUndo.Enabled then
  mUndo.Caption:='Undo "'+Act.UndoAction+'"' else
  mUndo.Caption:='Undo';
{$ENDIF}

 mRedo.Enabled:=(Act<>nil) and Act.CanRedo and not _RuntimeMode;
{$IFNDEF FINALV}
 if mRedo.Enabled then
  mRedo.Caption:='Redo "'+Act.RedoAction+'"' else
  mRedo.Caption:='Redo';
{$ENDIF}

 mFind.Enabled:=(Act<>nil) and not _RuntimeMode;
 mSearchAgain.Enabled:=mFind.Enabled;
 mReplace.Enabled:=mFind.Enabled;

 if SiteChange then
  UpdateNames(nil);
 if SelChange or SiteChange then
  Tabs.UpdateSel;

 UpdateStatusBar;

{ if _RuntimeMode then
  StatusBar.Panels[StatusBar_Mode].Text:='Test' else
  StatusBar.Panels[StatusBar_Mode].Text:=sMode[DesignStyle];
  }

 UpdateStateClearing;

 finally
  glLockWindowUpdate(false,lLock);
 end;
end;

procedure TdhMainForm.UpdateHistory;
begin
 bBack.Enabled:=(Act<>nil) and Act.CanGoBack;
 bForward.Enabled:=(Act<>nil) and Act.CanGoForward;
end;


function IsDesignerSelected(Control:TControl):boolean;
var i:integer;
my:TMySiz;

begin
 if dhMainForm<>nil then
 for i:=0 to dhMainForm.MDIChildCount-1 do
 if (dhMainForm.MDIChildren[i] as TPageContainer).MySiz.IsSelected(Control) then
 begin
  result:=true;
  exit;
 end;
 result:=false;
end;


{$IFNDEF CLX}
procedure ShowMDIClientEdge(ClientHandle: THandle; ShowEdge: Boolean);
var
  Style: Longint;
begin
  if ClientHandle <> 0 then
  begin
    Style := GetWindowLong(ClientHandle, GWL_EXSTYLE);
    if ShowEdge then
      if Style and WS_EX_CLIENTEDGE = 0 then
        Style := Style or WS_EX_CLIENTEDGE
      else
        Exit
    else if Style and WS_EX_CLIENTEDGE <> 0 then
      Style := Style and not WS_EX_CLIENTEDGE
    else
      Exit;
    SetWindowLong(ClientHandle, GWL_EXSTYLE, Style);
    SetWindowPos(ClientHandle, 0, 0,0,0,0, SWP_FRAMECHANGED or
SWP_NOACTIVATE or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
  end;
end;
{$ENDIF}

procedure TdhMainForm.MyBeforeDrawItemEvent(Sender: TObject; Canvas: TCanvas; const Rect: TRect; Flags: Integer;
    Enabled: Boolean; Bitmap: TBitmap; const Text: WideString; Length: Integer; Color: TColor;
    var DefaultDraw: Boolean);
begin
{ Canvas.Font.Style:=Canvas.Font.Style+[fsUnderline];
 DefaultDraw:=false;  }
end;

procedure TdhMainForm.MyDrawTabEvent(Sender, Source: TObject; Canvas: TCanvas; Index, HorizonalPadding,
    VerticalPadding, Overlap: Integer; Selected: Boolean);
begin

end;



procedure TdhMainForm.FormCreate(Sender: TObject);
var iLanguage:integer;
var lsl:TStringList;
begin
  //LateCreateForm(TPropsPC,Tabs);

//DKLanguageController1.IgnoreList.Delete(5);
//UpdateLangSourceFile('c:\HBuilder\mylanguage.lng2',DKLanguageController1,[]);
//DKLanguageController1.UpdateComponents(true);


//SetExStyle(WS_EX_CLIENTEDGE,0);

{ ToolBar1.Images.get
 ImageList1.ImageType
 }
 _RuntimeMode:=false;

 ToolBar1.Flat:=true; //default is "false" in Delphi7 and "true" in Delphi2006, so set it explicitely to true!

{$IFDEF FINALV}
 DEBUG_mDebug.Visible:=false;
 SpeedButton1.Transparent:=false;
 //mNewFromTemplate.Visible:=false;
 //mSaveAsTemplate.Visible:=false;
{$ENDIF}

 ImageList1.Masked:=False;
{
 ImageList1.BkColor:=clGreen;
 ImageList1.drawingstyle:=dsNormal;
 }

{$IFNDEF CLX}
 ToolBar1.Transparent:=False;
 Panel1.ParentBackground:=false;
 WindowMenu:=mWindow;
 with TApplicationEvents.Create(Owner) do
 begin
  OnMessage := ApplicationEvents1Message;
 end;  
 with TURLDropTarget.Create(Self) do
 begin
  OnDragOver:=URLDropTarget1DragOver;
  OnDrop:=URLDropTarget1Drop;
 end;
{$ELSE}
 SpeedButton1.GroupIndex:=0;
{$IFDEF WINDOWS}
 Application.Style.DefaultStyle := dsQtSGI;
 Application.Style.DefaultStyle := dsPlatinum;
{$ENDIF}
// Application.Style.BeforeDrawItem := MyBeforeDrawItemEvent;
// Application.Style.DrawTab := MyDrawTabEvent;
 mDelete.ShortCut:=4103;
 mGenerateHTML.ShortCut:=4148;
 mUndo.ShortCut:=16474;
 mRedo.ShortCut:=24666;
{$ENDIF}
 //ToolBar1.DoubleBuffered:=true;
 _RuntimeMode:=false;
 LoadFormElement(mForm);
// Tabs.cDownIfMenu.Visible:=CompMenu.Visible;
 ReadConfig;
 ReadSmartPublishingCRCs;



 //Caption:=Caption+' BETA';
// Tabs.PageControl1.Color:=clYellow;


     // Scan for language files in the app directory and register them in the LangManager object
    LangManager.ScanForLangFiles(ExtractFileDir(ParamStr(0))+'/Language', '*.lng', False);
     // Fill cbLanguage with available languages
    lsl:=TStringList.Create;
    for iLanguage := 0 to LangManager.LanguageCount-1 do lsl.Add(LangManager.LanguageNames[iLanguage]);
    AddStringsTo(mLanguage,mLanguageTemplateClick,false,lsl,false,true,false);

    for iLanguage := 0 to LangManager.LanguageCount-1 do
    begin
     mLanguage[iLanguage].RadioItem:=true;
     if LangManager.LanguageIDs[iLanguage]=_LANGID then
     begin
      mLanguage[iLanguage].Checked:=true;
     end;
    end;

     // Index=0 always means the default language

    //cbLanguage.ItemIndex := 0;
    LangManager.LanguageID := _LANGID;//LangManager.LanguageIDs[{LangManager.LanguageCount-}1];
    UpdateOtherConstants;
// OuterControl:=Form1;
// DoubleBuffered:=true;
end;
                             {

procedure TForm1.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
begin
  if not DoubleBuffered or (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Perform(WM_ERASEBKGND, MemDC, MemDC);
      Message.DC := MemDC;
      WMPaint(Message);


  Canvas.Lock;
  try
    Canvas.Handle := MemDC;
    try
 Canvas.Brush.Style:=bsSolid;
 Canvas.Brush.Color:=clBlack;    
    Canvas.FillRect(Rect(120,120,500,500));   
    finally
      Canvas.Handle := 0;
    end;
  finally
    Canvas.Unlock;
  end;
      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;      }

procedure TdhMainForm.csEndSize(Sender: TObject);
begin             
 Sender:=Sender
// cs.Control.Visible:=true;
end;

procedure TdhMainForm.shMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 sender:=sender
end;


{function StringFromFile(const FileName:string):string;
begin
 with TFileStream.create(FileName,fmOpenRead) do
 begin
  SetLength(result,Size);
  if Size<>0 then
   ReadBuffer(result[1],Size);
  Free;
 end;
end;
 }




procedure TdhMainForm.Openproject1Click(Sender: TObject);
var i:integer;
begin  {
 s:=StringFromFile('C:\DFM2HTML_bei18\onebyone.gif');
 for i:=1 to length(s) do
  ss:=ss+inttohex(ord(s[i]),2);
 Clipboard.AsText:=ss;   }

 if OpenDialog1.Execute then
 for i:=0 to OpenDialog1.Files.Count-1 do
 begin
  //stringtofile('c:\t.txt',OpenDialog1.Files[i]);
  Open(OpenDialog1.Files[i],false);
 end;
end;

function TdhMainForm.Open(FileName:string; SetUntitled:boolean; Unvisible:boolean=false):TPageContainer;
var lLock:boolean;
begin
 glLockWindowUpdate(true,lLock);
 try
 if Unvisible then
 begin
  result:=TPageContainer.Create(nil);
  result.Open(FileName,true,false);
 end else
 if not SetUntitled and TPageContainer.HasOpened(FileName,result) then
 begin
  result.Show;
 end else
 begin
  result:=TPageContainer.Create(Self);
  result.Open(FileName, SetUntitled, true);
 end;
 finally
  glLockWindowUpdate(false,lLock);
 end;
end;


procedure TdhMainForm.Edit2Click(Sender: TObject);
begin
// Tabs.Show;
end;


procedure TdhMainForm.mCopyClick(Sender: TObject);
begin
 Act.MySiz.CopyComponents(false);
end;

procedure TdhMainForm.mPasteClick(Sender: TObject);
begin    
 Act.PasteComponents(nil);
end;


procedure TdhMainForm.FormDestroy(Sender: TObject);
begin
 OuterControl:=nil; 
 {$IFNDEF CLX}
{    if HttpCli1<>nil then
    begin
     HttpCli1.RcvdStream.Free;
     FreeAndNil(HttpCli1);
    end;}
 {$ENDIF}
end;


{$IFNDEF CLX}
procedure TdhMainForm.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var c:TControl;
    Message:TMessage;
var WMMouse:TWMNCHitMessage;
  cw: TWinControl;
begin
  if (msg.message=$3F) and (msg.hwnd=ClientHandle) then
  begin
   Handled:=true;
   exit;
  end;     
  exit;
  {if (msg.message=WM_NCLBUTTONUP) or (msg.message=wm_lbuttonup) then
  begin
   ReleaseCapture;
  end; }
      {
  if msg.message=WM_NCHITTEST then
  begin
   c:=FindControl(msg.hwnd);
   if c is TMySiz then
   begin
    msg.lParam:=0;
    msg.wParam:=0;
    Handled:=true;
    exit;
   end;
  end;  }
  {
  if (msg.message=wm_lbuttonup) or (msg.message=WM_KEYUP) and ((msg.wParam=VK_UP) or (msg.wParam=VK_DOWN) or (msg.wParam=VK_LEFT) or (msg.wParam=VK_RIGHT)) then
  if Act<>nil then
   Act.ContinuumBroken;   }

  (*
  if (msg.message=wm_lbuttondown) or (msg.message=WM_LBUTTONDBLCLK) { or (msg.message=wm_mousemove)} then
  begin
   c:=MyFindControl(msg.hwnd,true);
   while c<>nil do
   begin
   if (c is TdhScrollingWinControl) then
   begin
    //setcapture(TdhStyleSheet(c).handle);
    WMMouse.XCursor:=Mouse.CursorPos.X;
    WMMouse.YCursor:=Mouse.CursorPos.Y;
    WMMouse.HitTest:=SendMessage(TWinControl(c).handle,WM_NCHITTEST,0,TMessage(WMMouse).lParam);
    if (WMMouse.HitTest=HTVSCROLL) or (WMMouse.HitTest=HTHSCROLL) then
    begin

    if (msg.message=WM_LBUTTONDBLCLK) then
     Message.Msg:=WM_NCLBUTTONDBLCLK   else
    if (msg.message=wm_lbuttondown) then
     Message.Msg:=WM_NCLBUTTONDOWN else
    if (msg.message=wm_lbuttonup) then
     Message.Msg:=WM_NCLBUTTONUP else
    if (msg.message=wm_mousemove) then
     Message.Msg:=WM_NCMOUSEMOVE;

    WMMouse.XCursor:=Mouse.CursorPos.X;
    WMMouse.YCursor:=Mouse.CursorPos.Y;
    if SendMessage(TWinControl(c).handle,Message.Msg,TMessage(WMMouse).wParam,TMessage(WMMouse).lParam)=0 then
    begin
     //RedrawWindow(TWinControl(c).Handle,nil,0,RDW_FRAME or RDW_INVALIDATE);
     //SetCapture(TWinControl(c).handle);
     Handled:=true;
     exit;
    end;

{    WMMouse.Keys:=0;
    WMMouse.XPos:=Mouse.CursorPos.X-c.ClientOrigin.X;
    WMMouse.YPos:=Mouse.CursorPos.Y-c.ClientOrigin.Y;
    PostMessage(TWinControl(c).handle,msg.message,TMessage(WMMouse).wParam,TMessage(WMMouse).lParam);
}
    {Message.Msg:=Msg.message;
    Message.WParam:=Msg.wParam;
    Message.LParam:=Msg.lParam;
    TWinControl(c).DefaultHandler(Message); }
    //Handled:=true;
    end;
   end;
   c:=c.Parent;
   end;
  end;
  *)
   (*
  if {not RuntimeMode and }(msg.message>=WM_MOUSEMOVE) and (msg.message<=WM_MBUTTONDBLCLK) and (Windows.GetCapture=0) then
  begin
   c:=FindControl(msg.hwnd);
   if  not ((GetCapture<>0) {or ((msg.message=WM_LBUTTONDOWN) or (msg.message=WM_LBUTTONDBLCLK) ) and (c is TdhCustomPanel) and TdhCustomPanel(c).CanUseMouseClick}) then
   if (c<>nil) and (GetParentForm(c) is TPageContainer) then
   begin
    Handled:=true;
    c:=TPageContainer(GetParentForm(c));
    TPageContainer(c).MySiz.Perform(msg.message,msg.wParam,msg.lParam);
    exit;
   end;
  end;*)

  if (msg.message>=WM_MOUSEMOVE) and (msg.message<=WM_MBUTTONDBLCLK) and (Windows.GetCapture=0) then
  begin
   c:=FindControl(msg.hwnd);
   if (c<>nil) and (GetParentForm(c) is TPageContainer) then
   begin
    Handled:=true;
    c:=TPageContainer(GetParentForm(c));
    TPageContainer(c).MySiz.Perform(msg.message,msg.wParam,msg.lParam);
    exit;
   end;
  end;

          {
  if (msg.message=wm_paint) or (msg.message=WM_ERASEBKGND)  then
  begin
   c:=FindControl(msg.hwnd);
   if c<>nil then
    c:=GetParentForm(c);
   if (c is TPageContainer) and (TPageContainer(c).Handle<>msg.hwnd) then
    TPageContainer(c).MySiz.NeedPaint;

  end; }
       {
    if Act<>nil then
    begin
    act.MySiz.BringToFront;
    end;     }

  (* If {((msg.message > CN_BASE) and (msg.message < CN_BASE + 500)) or }
    {(msg.message = WM_PAINT) or }
    (msg.message = WM_SIZE) Or (msg.message = WM_MOVE) or (msg.message = WM_WINDOWPOSCHANGING) or
    (msg.message = CN_DELETEITEM)
    Then
  Begin
    cw := MyFindControl(msg.hwnd,true) as TWinControl;
    if (cw<>nil) and (cw.Owner is TPageContainer) then
    begin
     TPageContainer(cw.Owner).MySiz.CheckBlacks(cw);
    end;
  End;*)
end;         
{$ENDIF}


{function TdhMainForm.Act:TPageContainer;
begin
 if ActiveMDIChild is TPageContainer then
  result:=ActiveMDIChild as TPageContainer else
  result:=nil;
end;
 }
procedure TdhMainForm.mDeleteClick(Sender: TObject);
begin
 Act.MySiz.DeleteComponents;
end;

procedure TdhMainForm.mCutClick(Sender: TObject);
{var png:TPNGObject;
    bt:TBitmap32;
    i:integer;
    x,y:integer;
    gif:TGifImage;  }
begin

//cbName.Clear;
 {
cbName.AddItem('asdf',nil);
exit;             }
{
 bt:=TBitmap32.create;
 bt.width:=300;;
 bt.height:=300;
 for x:=0 to bt.width-1 do
 for y:=0 to bt.height-1 do
  bt.Canvas.Pixels[x,y]:=clRed;
 for x:=0 to bt.width-1 do
  bt.Canvas.Pixels[x,x]:=clBlue;
 bt.SaveToFile('c:\test.bmp');
 bt.Transparent:=true;
 bt.SaveToFile('c:\test2.bmp');
 bt.TransparentColor:=clBlue;
 bt.SaveToFile('c:\test3.bmp');
           }
// bt.Canvas.Draw(0,0,image1.Picture.Bitmap);
{ gif:=TGifImage.Create;
 gif.Assign(bt);
 gif.SaveToFile('c:\test.gif');
 exit;     }
 {png:=TPNGObject.Create;
 png.Assign(bt);
 png.CreateAlpha;}
 //png.Header.PrepareImageData;
{ for i:=0 to bt.width-2 do
  pRGBLine(png.Scanline[i])^[i].rgbtRed:=50;
}
{ for x:=0 to bt.width-1 do
 for y:=0 to bt.height-1 do
  png.AlphaScanline[y]^[x]:=(x*y) and 255;
 Image1.Picture.Assign(png);
 image1.Repaint;
 }
// png.CreateAlpha;
// png.Header.Height:=png.Header.Height;
// png.Filters

 mCopyClick(Sender);
 mDeleteClick(Sender);
end;

procedure TdhMainForm.Button3Click(Sender: TObject);
//var WMMouse:TWMNCHitMessage;
begin
{
    WMMouse.HitTest:=7;
    WMMouse.XCursor:=Mouse.CursorPos.X;
    WMMouse.YCursor:=Mouse.CursorPos.Y;
    SendMessage(ScrollBox1.handle,WM_NCLBUTTONDOWN,TMessage(WMMouse).wParam,TMessage(WMMouse).lParam);
    }
//    ScrollBox1.VertScrollBar.Position:=100;
end;

procedure TdhMainForm.compImgClick(Sender: TObject);
begin

{ if ActDown<>nil then
  (ActDown as TToolButton).Down:=false;}
 if (Sender as TToolButton).Down then
 begin
  if (gActDown<>nil) and (gActDown<>Sender) then
   (gActDown as TToolButton).Down:=False;
  gActDown:=TControl(Sender);
 end else
  gActDown:=nil;

   {
 if gActDown<>nil then
  gActDown.Down:=true;  }
end;

procedure TdhMainForm.compPanelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbLeft then
                (*
 if (Sender as TToolButton).Down then
 begin           {
  (Sender as TToolButton).Down:=false;
  (Sender as TToolButton).Marked:=false; }
  gActDown:=nil;
 end else       
  (Sender as TToolButton).Down:=true;    *)
end;

procedure TdhMainForm.mSaveClick(Sender: TObject);
begin
 Act.Save;
end;

procedure TdhMainForm.mSaveAllClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to MDIChildCount-1 do
  (MDIChildren[i] as TPageContainer).Save;
end;

procedure TdhMainForm.ApplyNewSettings(FontToCurrent:boolean; FontToAll:boolean);
var i:integer;
    DChild:TPageContainer;
begin
 for i:=0 to MDIChildCount-1 do
 begin
  DChild:=MDIChildren[i] as TPageContainer;
  DChild.InvalGrid;
  InvalTrans(DChild,InvRect);
 end;

 if FontToCurrent then
 if (Act<>nil) then
 begin
  Tabs.CommitChanges;
  Act.Font.Assign(FuncSettings.DefaultFont);
  Tabs.Changed('default font');
 end;
end;





procedure TdhMainForm.mSaveAsClick(Sender: TObject);
begin
 Act.SaveAs;
end;

procedure TdhMainForm.mUndoClick(Sender: TObject);
begin
 Act.Undo;
end;

procedure TdhMainForm.mRedoClick(Sender: TObject);
begin
 Act.Redo;
end;

procedure TdhMainForm.ext1Click(Sender: TObject);
{
var c1,c2:tlargeinteger;
    i:integer;
}begin
{ WithMeta:=true;
 QueryPerformanceCounter(c1);
 for i:=0 to 10 do
  Act.GetDFMStr(false);
 QueryPerformanceCounter(c2);
 WithMeta:=false;
 showmessage(' - time of comparison: '+inttostr((c2-c1) div 100));}
end;
          
function isAbsolute(s:String):boolean;
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

Function GetTMPDir: String;
var
   SysDir: array[0..MAX_PATH] Of Char;
begin
     if (GetTempPath(MAX_PATH, SysDir) > 0)
     then Result:= StrPas(SysDir)
     else Result:= '';
End;

procedure TdhMainForm.SetSaveDir;
begin
 Tabs.CommitChanges;
 BaseDir:=GetTMPDir;
 if BaseDir='' then
 if Act.IsUntitled then
   BaseDir:=ExtractFilePath(Application.ExeName) else
   BaseDir:=ExtractFilePath(Act.FileName);
 RasteringSaveDir:=BaseDir+'DFM2HTML_'+Act.Name+PathDelim;
 if Act.MySiz.FindBody<>nil then
 begin
  if isAbsolute(Act.MySiz.FindBody.OutputDirectory) then
   RasteringSaveDir:=Act.MySiz.FindBody.OutputDirectory else
   RasteringSaveDir:=BaseDir+Act.MySiz.FindBody.OutputDirectory;
 end;
 ForceDirectories(RasteringSaveDir);
end;


procedure StringToFile(FileName:string; const s:string);
var NeedSave:boolean;
begin
 glSaveBin(calc_crc32_String(s),FileName,false,EmptyStr,NeedSave,true);
 if NeedSave then
 with TFileStream.create(FileName,fmCreate) do
 begin
  if s<>EmptyStr then
   WriteBuffer(s[1],length(s));
  Free;
  glAfterSaveBin;
 end;
end;


type TSaveBinItem=class
      id_crc:DWORD;
      data_crc:DWORD;
      FileAge:integer;
      FileName:string;
     end;

var AfterSaveBinI:TSaveBinItem;

function FindIdCrc(const id_crc:DWORD):TSaveBinItem;
var i:integer;
begin
  for i:=0 to CrcList.Count-1 do
  if TSaveBinItem(CrcList[i]).id_crc=id_crc then
  begin
   result:=TSaveBinItem(CrcList[i]);
   exit;
  end;
  result:=nil;
end;

function FindFilename(const Filename:string):TSaveBinItem;
var i:integer;
begin
  for i:=0 to CrcList.Count-1 do
  if SameText(TSaveBinItem(CrcList[i]).Filename,Filename) then
  begin
   result:=TSaveBinItem(CrcList[i]);
   exit;
  end;
  result:=nil;
end;


function SaveBin(_crc:DWORD; var RasteringFile:string; CheckBaseRasteringFile:boolean; BaseRasteringFile:string; var NeedSave:boolean; NeedSameFileName:boolean):boolean;
var gif_pre:TBitmap32;
    graph:TGraphic;
    id_crc:DWORD;
    server_crc:DWORD;
    sb:TSaveBinItem;
begin
  NeedSave:=false;
  server_crc:=_crc;//calc_crc32_String(RasteringFile,_crc);
  RasteringFile:=RasteringSaveDir+RasteringFile;
  if NeedSameFileName then
   id_crc:=calc_crc32_String(lowercase(RasteringFile),_crc) else
   id_crc:=calc_crc32_String(lowercase(RasteringSaveDir),_crc);

  sb:=FindIdCrc(id_crc);
  if sb<>nil then
  if (sb.FileAge<>FileAge(sb.FileName)) or (sb.FileName<>RasteringFile) and (GeneratedFiles.IndexOf(sb.FileName)=-1) { or not SameText(RasteringSaveDir,ExtractFileDir(CrcList[i])+PathDelim)} then
  begin
   CrcList.Remove(sb);
  end else
  begin
   RasteringFile:=sb.FileName;
   if CheckBaseRasteringFile and (BaseRasteringFile=RasteringFile) then
   begin
    result:=false;
    exit;
   end else
   begin
    if (GeneratedFiles.IndexOf(sb.FileName)=-1) then GeneratedFiles.AddObject(RasteringFile,Pointer(server_crc));
    result:=true;
    exit;
   end;
  end;

  if (GeneratedFiles.IndexOf(RasteringFile)=-1) then GeneratedFiles.AddObject(RasteringFile,Pointer(server_crc));

  AfterSaveBinI:=FindFilename(RasteringFile);
  if AfterSaveBinI<>nil then
   {CrcList.Objects[AfterSaveBinI]:=Pointer(_crc)} else
   begin
   AfterSaveBinI:=TSaveBinItem.Create;
   CrcList.Add(AfterSaveBinI);
   end;
  AfterSaveBinI.id_crc:=id_crc;
  AfterSaveBinI.data_crc:=_crc;
  AfterSaveBinI.FileName:=RasteringFile;
  {if dhMainForm.Act<>nil then
   AfterSaveBinI.DocName:=dhMainForm.Act.FileName; }


  NeedSave:=true;
  result:=true;
end;

procedure TdhMainForm.ViewHTML1Click(Sender: TObject);
var pa,content,PureFileName:string;
    sStatus:string;
begin
 FreeAndNil(GeneratedFiles);
 GeneratedFiles:=TStringList.Create;
 try
 SetSaveDir;
 men:=Tabs.IGNORE_dhDirectHTML1.InnerHTML;

                             
 sStatus:=StatusBar.Panels[StatusBar_Mode].Text;
 GenerateTimer.Tag:=0;
 //GenerateTimer.Enabled:=true;
 try
 glSaveBin:=SaveBin;
 try
 Content:=Act.GetDFMStr(false,true);
 StartConverting(BaseDir,FuncSettings.Compress,nil);
 DoConvertContent(PureFileName,content);
 if Sender<>nil then
 if Warnings.Count<>0 then
 begin
  LateCreateForm(TFormWarnings,FormWarnings);
  FormWarnings.Memo1.Lines.Assign(Warnings);
  FormWarnings.Show;
 end;
 EndConverting;
 finally
  glSaveBin:=nil;
 end;
 finally
  GenerateTimer.Enabled:=false;
  StatusBar.Panels[StatusBar_Mode].Text:=sStatus;
 end;
 pa:=RasteringSaveDir+PureFileName;
 if Sender<>nil then
  Browse(pa,FViewer,true);
 except
 on A:Exception do
  showmessage(A.Message);
 end;
end;

procedure TdhMainForm.Paint;
begin
  inherited;
{ Canvas.Brush.Color:=clBlack;
    Canvas.FillRect(Rect(20,20,1300,1300));
 }
end;


procedure TdhMainForm.mExitClick(Sender: TObject);
begin
 Close;
end;

procedure TdhMainForm.compFormClick(Sender: TObject);
begin
(*
 if gActDown=compForm then
 begin
  gActDown:=nil;
  compForm.Down:=false
 end else
 begin
  if gActDown<>nil then
   (gActDown as TToolButton).Down:=False;
  compForm.Down:=true;
  gActDown:=compForm;
 end;


{$IFNDEF CLX}
 Windows.SetFocus(0);
 Windows.SetFocus(Handle);
{$ENDIF}
*)
end;

procedure TdhMainForm.Button2Click(Sender: TObject);
begin
// compForm.Down:=not compForm.Down
//tabsheet3.TabVisible:=false;
end;

procedure TdhMainForm.mFormClick(Sender: TObject);
begin
 LoadFormElement(Sender as TMenuItem);
 if not compForm.Down then
 begin
  compForm.Down:=true;
// compForm.Click;
  compImgClick(compForm);
 end;
 {compForm.Down:=true;
 gActDown:=compForm;
 SetCaptureControl(nil) }
end;

var glMen:TMenuItem;
procedure TdhMainForm.LoadFormElement(men:TMenuItem);
begin
 compForm.ImageIndex:=men.ImageIndex;
 compForm.Hint:=AnsiSubstText('&',EmptyStr,men.Caption);
 glMen:=men;
end;


procedure glNotifyDebug(s:string);
begin
// dhMainForm.Tabs.Memo1.Lines.Add(s);
end;

procedure TdhMainForm.FormShow(Sender: TObject);
begin
{$IFNDEF CLX}
 ShowMDIClientEdge(ClientHandle,false);
{$ENDIF}
 NotifyDebug:=glNotifyDebug;
 Tabs.Adjusting:=false;
end;

procedure TdhMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WriteConfig;
 WriteSmartPublishingCRCs;
end;

procedure TdhMainForm.UpdateStateClearing;
begin
 SetUnderlineState(stateNormal  ,not(stateNormal.Visible   and (Tabs.ActSel is TdhCustomPanel) and Tabs.ActPn.StyleArr[hsNormal].IsStyleStored));
 SetUnderlineState(stateDown    ,not(stateDown.Visible     and (Tabs.ActSel is TdhCustomPanel) and Tabs.ActPn.StyleArr[hsDown].IsStyleStored));
 SetUnderlineState(stateOver    ,not(stateOver.Visible     and (Tabs.ActSel is TdhCustomPanel) and Tabs.ActPn.StyleArr[hsOver].IsStyleStored));
 SetUnderlineState(stateOverDown,not(stateOverDown.Visible and (Tabs.ActSel is TdhCustomPanel) and Tabs.ActPn.StyleArr[hsOverDown].IsStyleStored));
end;


procedure TdhMainForm.SetDesignStyle(ds:TState; runtime:boolean);
var i:integer;
    lLock:boolean;
begin
 Tabs.CommitChanges;
 glLockWindowUpdate(true,lLock);
 try
 _RuntimeMode:=runtime;
 if _RuntimeMode then
  Screen.Cursor:=crDefault;
 DesignStyle:=ds;

 stateOverDown.Down:=not _RuntimeMode and (ds=hsOverDown);
 stateDown.Down:=not _RuntimeMode and (ds=hsDown);
 stateOver.Down:=not _RuntimeMode and (ds=hsOver);
 stateNormal.Down:=not _RuntimeMode and (ds=hsNormal);
 stateTest.Down:=_RuntimeMode;

 for i:=0 to MDIChildCount-1 do
  (MDIChildren[i] as TPageContainer).SetDesigning(not _RuntimeMode,false);//MySiz.SelCheckDesignState;

 UpdateCommands(true,true);
 finally
  glLockWindowUpdate(false,lLock);
 end;

end;


procedure TdhMainForm.stateDownClick(Sender: TObject);
begin
 SetDesignStyle(hsDown,false);
end;

procedure TdhMainForm.stateOverClick(Sender: TObject);
begin
 SetDesignStyle(hsOver,false);
end;

procedure TdhMainForm.stateOverDownClick(Sender: TObject);
begin 
 SetDesignStyle(hsOverDown,false);
end;

procedure TdhMainForm.stateNormalClick(Sender: TObject);
begin
 SetDesignStyle(hsNormal,false);
end;

procedure TdhMainForm.ToolButton1Click(Sender: TObject);
begin
 SetDesignStyle(DesignStyle,true);
end;


procedure TdhMainForm.cbNameChange(Sender: TObject);
var sl:TStringList;
begin
 //if (cbName.ItemIndex<>-1) and (cbName.Items[cbName.ItemIndex]<>cbName.Text) then exit;
 if cbName.DroppedDown or (Act=nil) or _RuntimeMode then exit;
 sl:=TStringList.Create;
 sl.Add(cbName.Text);
 Act.MySiz.AddSelectionByIDs(sl);
 sl.Free;
end;

procedure TdhMainForm.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin

// AllowChange:=false;
end;

procedure TdhMainForm.mCloseClick(Sender: TObject);
begin
 Act.Close;
end;

procedure TdhMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
// Act.FormKeyDown(Sender,Key,Shift);
end;


procedure TdhMainForm.mAboutClick(Sender: TObject);
begin
 ShowMessage(DFM2HTML_VERSION+#13#10+'Freeware'+#13#10+'Copyright 2003-2007'+#13#10+'Jörg Kiegeland'{+#13#10+#13#10+_if(Registered,'Registered version','Unregistered version')});
// showmessage(FindControl(GetFocus).classname);
end;

procedure TdhMainForm.mOptionsClick(Sender: TObject);
begin
 LateCreateForm(TOptions,Options);
 Options.LoadSettings(FuncSettings);
 Options.ShowModal;
end;

procedure TdhMainForm.mCascadeClick(Sender: TObject);
begin
 Cascade;
end;

procedure TdhMainForm.mTileClick(Sender: TObject);
begin
 Tile;
end;

procedure TdhMainForm.mArrangeIconsClick(Sender: TObject);
begin      

{$IFNDEF CLX}
 ArrangeIcons;
{$ENDIF}
end;

procedure TdhMainForm.DEBUG_GeneratePASfile1Click(Sender: TObject);
begin
 Act.GeneratePAS;
end;

procedure TdhMainForm.mReopenClick(Sender: TObject);
var lsl:TStringList;
    i:integer;
begin
 lsl:=TStringList.Create;
 for i:=0 to FuncSettings.LRUfiles.Count-1 do
  lsl.Add(inttohex(i+1,1)+' '+FuncSettings.LRUfiles[i]);
 AddStringsTo(mReopen,LRUitemClick,false,lsl,false,true,false);
end;

procedure TdhMainForm.LRUitemClick(Sender: TObject);
begin
 if FuncSettings.LRUfiles.Count<>0{für *EMPTY*} then
  Open(FuncSettings.LRUfiles[mReopen.IndexOf(TMenuItem(Sender))],false);
end;

function TdhMainForm.CloseQuery: Boolean;
var i,c:integer;
begin
 //FuncSettings.LRUfiles.Insert(0,'XYZ');
 WhereToInsert:=0;
 result:=Inherited CloseQuery;
 WhereToInsert:=-1;
 {
 c:=FuncSettings.LRUfiles.IndexOf('XYZ');
 FuncSettings.LRUfiles.Delete(c);
 for i:=0 to c div 2-1 do
  FuncSettings.LRUfiles.Exchange(i,c-1-i);  }
end;

procedure TdhMainForm.DEBUG_Debug1Click(Sender: TObject);
var i:integer;
    s:string;
begin
{ propspc.PageControl1.Update;
 propspc.PageControl1.DisableAlign;
 propspc.PageControl1.EnableAlign;
 propspc.PageControl1.Realign;
 propspc.PageControl1.Invalidate;
 propspc.PageControl1.EnableAlign;
                              }

 funcutils.StringToFile(RootDir('tryx.txt'),'blabla');

// MessageDlg('X', mtWarning,[mbAbort, mbRetry, mbIgnore], 0);
// (Act.MySiz.FindBody as TdhPage).FCommon.IsScrollArea:=not (Act.MySiz.FindBody as TdhPage).FCommon.IsScrollArea;
 //act.ScrollBy(0,30);
 //(Act.MySiz.FindBody as TdhPage).FCommon.NCScrollbars:=not (Act.MySiz.FindBody as TdhPage).FCommon.NCScrollbars;
 //(Act.MySiz.FindBody as TdhPage).Realign;
 {TdhCustomPanel(Tabs.Selection[0]).Style.MinWidth:=40;
 TdhCustomPanel(Tabs.Selection[0]).Style.MinHeight:=40;  }
 //TdhCustomPanel(Tabs.Selection[0]).Style.MarginRight:='-50';
 {twincontrol(presets).Realign;
 Presets.Height:=Presets.Height-1;
 twincontrol(presets).Realign;
 Presets.Height:=Presets.Height-1;
 twincontrol(presets.dhPanel1.controls[1]).Realign;
 Presets.Height:=Presets.Height-1;
 twincontrol(presets.dhPanel1.controls[1]).Realign;
 Presets.Height:=Presets.Height-1;
 Presets.Height:=Presets.Height-1;
 Presets.Height:=Presets.Height-1;
 _runtimemode:=not _runtimemode;
 _runtimemode:=not _runtimemode;}
 //TdhPage(Tabs.Selection[0]).PageControl:=nil;
 //TdhCustomPanel(Tabs.Selection[0]).Parent:=TdhCustomPanel(Tabs.Selection[0]).Parent.Parent;
 //LangManager.
end;

procedure TdhMainForm.mOpenOutputDirectoryClick(Sender: TObject);
begin
 SetSaveDir;
 Browse(RasteringSaveDir,EmptyStr,true);
end;


{$IFNDEF CLX}
function TdhMainForm.IsShortCut(var Message: TWMKey): Boolean;
var c:TControl;
//    h:HWND;
//    s:string[255];
begin
 if (Message.CharCode=VK_DELETE) or (Message.CharCode=ord('C')) or (Message.CharCode=ord('X')) or (Message.CharCode=ord('V')) then
 begin
{h:= GetFocus;
GetClassName  (h,@s[1],200);
GetClassName  (h,@s[1],200);
}
 c:=ExtractActiveControl;
 //if (Tabs.ActiveEditControl<>nil) and not (Screen.ActiveForm is TPageContainer) then
 if ((c is TMySpinEdit) or (c is ThEdit) or (c is ThComboBox) or (c is ThMemo)) and not (c.Owner is TPageContainer) then
 begin
  Result:=False;
  exit;
 end;
 end;

(* if {(ActiveControl is TCustomEdit) or (ActiveControl is TCustomComboBox) or }(Screen.ActiveForm<>Self) and not (Screen.ActiveForm is TPageContainer) then
 begin
  Result:=False;
  exit;
 end;                                  *)

 Result:=inherited IsShortCut(Message);
end;                 
{$ENDIF}

procedure TdhMainForm.mSelectAllClick(Sender: TObject);
begin
 Act.MySiz.Select(Sender=mSelectAll,Sender=mSelectAllBelow);
end;

procedure TdhMainForm.mTutorialClick(Sender: TObject);
begin
 if _LANGID=LANGID_GERMAN then
  Open(ExtractFilePath(Application.Exename)+'TutorialGerman.dfm',false) else
  Open(ExtractFilePath(Application.Exename)+'Tutorial.dfm',false);
end;

function TdhMainForm.GetTopLevelDomain:String;
begin                                     
 if _LANGID=LANGID_GERMAN then
  result:='de' else
  result:='com'
end;

procedure TdhMainForm.mHomepageClick(Sender: TObject);
begin
  Browse('http://www.dfm2html.'+GetTopLevelDomain+'/launch/',{'iexplore'}FViewer,false);
end;

procedure OnHistory(Sender:TControl){(Page:TdhPage; Anchor:TControl)};
begin
 if Sender.Owner=dhMainForm.Act then
  dhMainForm.Act.History{(Page,Anchor)};
end;

procedure OnAfterNavigate(Sender:TdhPage);
begin
 if Sender.Owner=dhMainForm.Act then
  dhMainForm.Act.AfterNavigate(Sender);
end;

procedure PreAddCompo(parent:TdhCustomPanel);
begin
 if csDesigning in parent.ComponentState then
  Tabs.CommitChanges;
end;

procedure PostAddCompo(pn:TdhCustomPanel);
begin
 if csDesigning in pn.ComponentState then
 (dhMainForm.Act as TPageContainer).MySiz.ObjectAdded(pn);
 //dhMainForm.UpdateCommands(true,true);
end;

procedure TdhMainForm.bBackClick(Sender: TObject);
begin
 Act.GoBack;
end;

procedure TdhMainForm.bForwardClick(Sender: TObject);
begin
 Act.GoForward;
end;

procedure TdhMainForm.SpeedButton1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var P:TPoint;
begin
//SpeedButton1.PopupMenu
// MouseCapture:=true;
 //ReleaseCapture;
 //SetCapture(PopupMenu2.Handle);


 //PopupMenu2.Popup();
{$IFNDEF CLX}
 SpeedButton1.Down:=true;
 compForm.MenuItem:=IGNORE_FormEles;
 LoadFormElement(glMen);
 compImgClick(compForm);
 compForm.CheckMenuDropdown;
 //compForm.Down:=true;
 compForm.MenuItem:=nil;
 SpeedButton1.Down:=false;
{$ELSE}
{$ENDIF}


 //ToolBar1.CheckMenuDropdown(      

// SpeedButton1.Down:=True;
// SetCapture(Handle);
 //compForm.CheckMenuDropdown;
// SpeedButton1.Down:=false;
 //SpeedButton1.Down:=false;
// SpeedButton1.Down:=False;

// SendMessage(SpeedButton1
// SpeedButton1.Repaint;
 {PostMessage(Handle,WM_PUSHUP,0,0);
 SpeedButton1.Invalidate;      }
 {SetCapture(PopupMenu2.Handle);
 ReleaseCapture;
                    }
end;


type TFakeToolBar=class(TToolBar);
(*
procedure TdhMainForm.WMPUSHUP(var Msg: TMessage);
begin
 //compForm.CheckMenuDropdown;
 ToolBar1.Perform(TB_SETHOTITEM, -1, 0);
// Application.ProcessMessages;
 CancelDrag;
             TFakeToolBar(ToolBar1).CancelMenu;
// compForm.CheckMenuDropdown;  //tbsDropDown
// SpeedButton1.Down:=false;
end;
*)
  {
procedure TdhMainForm.CreateParams(var Params: TCreateParams);
begin
 inherited;
 Params.Style := Params.Style and not
    //WS_POPUP xor
    WS_BORDER;
  /Params.ExStyle := Params.ExStyle or WS_EX_STATICEDGE;

end;}

procedure TdhMainForm.mPublishClick(Sender: TObject);
var URL:string;
begin
 Tabs.CommitChanges;
 LateCreateForm(TPublishLog,PublishLog);
 if PublishLog.Busy then
 begin
  //showmessage('You can only have one upload running');
  PublishLog.Show;
  exit;
 end;

 if Act.MySiz.FindBody=nil then exit;

 if Act.MySiz.FindBody.FTPURL=EmptyStr then
 begin
  LateCreateForm(TPublishFTP,PublishFTP);
  URL:=EmptyStr;
  if PublishFTP.GetURL(URL) then
  begin
   Act.MySiz.FindBody.FTPURL:=URL;
  end else
   exit;
 end;
 PublishLog.DoUpload(Act.MySiz.FindBody.FTPURL);
end;

procedure AfterSaveBin;
begin
 AfterSaveBinI.FileAge:=FileAge(AfterSaveBinI.FileName);
end;





procedure TdhMainForm.mPagePropertiesClick(Sender: TObject);
var ls:TList;
begin
 ls:=TList.Create;
 try
  ls.Add(Act.MySiz.FindBody);
  Tabs.EditPageProperties(ls);
 finally
  ls.Free;
 end;
end;

procedure TdhMainForm.mViewOnlineClick(Sender: TObject);
var ls:TList;
begin
 if Act.MySiz.FindBody.HTTPURL=EmptyStr then
 begin
 if not Tabs.CommitChanges then exit;
 LateCreateForm(TPageWizard,PageWizard);
 PageWizard.ActiveControl:=PageWizard.eHTTPURL;
 //showmessage('You have to specify a HTTP URL');
 ls:=TList.Create;
 try
  ls.Add(Act.MySiz.FindBody);
  Tabs.EditPageProperties(ls);
 finally
  ls.Free;
 end;
 end;
 if Act.MySiz.FindBody.HTTPURL<>EmptyStr then
 begin
  Browse(Act.MySiz.FindBody.HTTPURL,FViewer,true);
 end;
end;

procedure TdhMainForm.mNewFromTemplateClick(Sender: TObject);
var Filename:string;
begin
 LateCreateForm(TTemplatesWizard,TemplatesWizard);
 if TemplatesWizard.Prepare(Filename) then
  Open(Filename,true);
end;


function TdhMainForm.ProcessDragDrop(Sender: TObject; Drop:boolean):boolean;
var c:TControl;
    URL_ext,Bitmap_ext,URL,Bitmap:string;
begin
 result:=false;
{$IFNDEF CLX}
 URL:=(Sender as TURLDropTarget).URL;
 Bitmap:=(Sender as TURLDropTarget).Bitmap;
 URL_ext:=LowerCase(ExtractFileExt(URL));
 Bitmap_ext:=LowerCase(ExtractFileExt(Bitmap));
 if URL_ext='.dfm' then
 begin
  if Drop then
  begin
   ImageFromURL(URL,nil);
  end;
  result:=true;
  exit;
 end;
 if (Bitmap_ext='.gif') or (Bitmap_ext='.jpg') or (Bitmap_ext='.png') or (Bitmap_ext='.bmp') then
 begin
  c:=MyFindDragTarget(Mouse.CursorPos,false);
  if (c=Tabs.dhPanel1) or (c is TdhCustomPanel) and (csDesigning in c.ComponentState) then
  begin
   if Drop then
   begin
    if (c=Tabs.dhPanel1) then
     c:=nil;
    {if SubSame('http://',Bitmap) or SubSame('https://',Bitmap) then
    with TIECache.Create(nil) do
    begin
     if GetEntryInfo(Bitmap)=S_OK then
      Bitmap:=EntryInfo.LocalFileName;
     Free;
    end; }
    ImageFromURL(Bitmap,c);
   end;
   result:=true;
  end;
 end;
{$ENDIF}

end;

procedure TdhMainForm.URLDropTarget1DragOver(Sender: TObject;
  var Accept: HRESULT);
begin
 Accept:=S_FALSE;
 if ProcessDragDrop(Sender,false) then
  Accept:=S_OK;
end;

const AllowedOcted=['0'..'9','a'..'z','A'..'Z'];

function URLDecodeOctets(const URL:string):string;
var i:integer;
begin
 result:=URL;
 for i:=length(result) downto 1 do
 case result[i] of
 '%':
 if (i+2<=length(result)) and (result[i+1] in AllowedOcted) and (result[i+2] in AllowedOcted) then
  begin result[i]:=chr(gethex(result[i+1])*16+gethex(result[i+2])); delete(result,i+1,2); end;
 end;
end;

var lookup_url_char:array[char] of integer;

function ExtractUrlAimedFilenameToWindowsFilename(const URL: string): string;
var
  I,CopyLess,r,r2: Integer;
begin
 result:=URL;
 while bAdvPos(r,'"',result) and bAdvPos(r2,'"',result,r+1) do
  AbsDelete(result,r,r2+1);
 CopyLess:=0;
 for i:=length(result) downto 1 do
 case lookup_url_char[result[i]] of
 0:;
 1:
 begin delete(result,1,i); break; end;
// else
 2:
 {'%':}
 if (i+2<=length(result)) and (result[i+1] in AllowedOcted) and (result[i+2] in AllowedOcted) then
      if (result[i+1]='2') and (result[i+2] in ['f','F']) then
       begin delete(result,1,i+2); break; end else
       begin result[i]:=chr(gethex(result[i+1])*16+gethex(result[i+2]));
       if result[i] in noValidFilenameChars then
        delete(result,i,3) else
        delete(result,i+1,2); end;
 3:CopyLess:=length(result)-i+1;
 end;
 if result=EmptyStr then result:=DefaultFile;
 delete(result,length(result)-CopyLess+1,CopyLess);
end;


var cDragTarget,DragURL:string;

procedure TdhMainForm.URLDropTarget1Drop(Sender: TObject);
begin
 ProcessDragDrop(Sender,true);
end;

procedure TdhMainForm.ImageFromURL(URL:string; c:TControl);
begin
   DragURL:=URL;
   if (c={Tabs.dhPanel1}nil) then
    cDragTarget:=EmptyStr else
    cDragTarget:=c.Name;

{$IFNDEF CLX}
   if SubSame('http://',DragURL) then
   begin
    if HttpCli1<>nil then
    begin
     HttpCli1.RcvdStream.Free;
     HttpCli1.RcvdStream:=nil;
     FreeAndNil(HttpCli1);
    end;
    HttpCli1:=THttpCli.Create(nil);
    HttpCli1.OnRequestDone:=HttpCli1RequestDone;
    HttpCli1.RcvdStream:=TStringStream.Create(EmptyStr);
    HttpCli1.URL:=DragURL;
    DragURL:=ExtractFilePath(Application.ExeName)+ExtractUrlAimedFilenameToWindowsFilename(DragURL);
    HttpCli1.GetASync;
    exit;
   end;
{$ENDIF}
   DragURL:=AdjustURLPure(URLDecodeOctets(DragURL));
   LoadDragURL;
end;


procedure TdhMainForm.LoadDragURL;
begin
   If LowerCase(ExtractFileExt(DragURL))='.dfm' then
    Open(DragURL,true) else
   if (cDragTarget=EmptyStr) then
    Tabs.LoadImage(DragURL) else
   if (Act<>nil) and (Act.FindComponent(cDragTarget) is TdhCustomPanel) then
    Tabs.LoadImageExt(DragURL,Act.FindComponent(cDragTarget) as TdhCustomPanel);
end;


procedure TdhMainForm.SpeedButton1Click(Sender: TObject);
var P:TPoint;
begin
//SpeedButton1.PopupMenu
// MouseCapture:=true;
{$IFDEF CLX}
 P:=compForm.ClientToScreen(Point(0,compForm.Height));
 PopupMenu2.Popup(P.X,P.Y);
{$ENDIF} 
end;

procedure TdhMainForm.mFullCopyClick(Sender: TObject);
begin
 Act.MySiz.CopyComponents(true);
end;

procedure TdhMainForm.mSaveAsTemplateClick(Sender: TObject);
begin    
 Act.SaveAsTemplate;
end;

procedure TdhMainForm.mPresetsClick(Sender: TObject);
begin
 LateCreateForm(TPresets,Presets);
 Presets.Prepare;
end;

procedure TdhMainForm.mCloseAllClick(Sender: TObject);
var
  i: integer;
begin    
 if CloseQuery then
  for i := MDIChildCount - 1 downto 0 do
    MDIChildren[i].Release;
end;

{$IFNDEF CLX}
procedure TdhMainForm.HttpCli1RequestDone(Sender: TObject;
  RqType: THttpRequest; ErrCode: Word);
begin
 if ErrCode=0 then
 begin
  funcutils.StringToFile(DragURL,(HttpCli1.RcvdStream as TStringStream).DataString);
  LoadDragURL;
  DeleteFile(PChar(DragURL));
 end;
  {  if HttpCli1<>nil then
    begin
     HttpCli1.RcvdStream.Free;
     HttpCli1.RcvdStream:=nil;
     FreeAndNil(HttpCli1);
    end; }
end;
{$ENDIF}


var ch:char;

procedure TdhMainForm.mNewClick(Sender: TObject);
var lLock:boolean;
    dchild:TPageContainer;
begin
 glLockWindowUpdate(true,lLock);
 try
  dchild:=TPageContainer.Create(Self);
  dchild.CreateBody;
  dhMainForm.UpdateCommands(true,true);
  dchild.MySiz.SetControlTo(dchild.MySiz.FindBody,true);
 finally
  glLockWindowUpdate(false,lLock);
 end;
end;

procedure TdhMainForm.DoStartUp;
var su:TStartUpAction;
var lLock:boolean;
begin
 if (ParamCount>=1) and (LowerCase(ExtractFileExt(ParamStr(1)))='.dfm') then
 begin
  if Open(ParamStr(1),false)<>nil then
   exit;
 end;

 su:=suLastPage;
{$IFDEF FINALV}
 //Show;
 //LateCreateForm(TStartUp,StartUp);
 StartUp:=TStartUp.Create(Self);
{$IFDEF FINALV}
 //StartUp.cTemplate.Visible:=false;
{$ENDIF}
 su:=StartUp.FirstAction;
 FreeAndNil(StartUp);
{$ENDIF}
 glLockWindowUpdate(true,lLock);
 try
 case su of
 suNothing:;
 suNewPage: mNewClick(nil);
 suLastPage:
     //if LastFile<>EmptyStr then  TPageContainer.Create(Self).Open(LastFile,false);
     if FuncSettings.LRUfiles.Count<>0 then  TPageContainer.Create(Self).Open(FuncSettings.LRUfiles[0],false);
 suTutorial: mTutorialClick(nil);
 su5minGuide: m5minGuideClick(nil);
 suTemplates: mNewFromTemplateClick(nil);
 end;
 finally
  glLockWindowUpdate(false,lLock);
 end;
end;


procedure TdhMainForm.FormActivate(Sender: TObject);
begin
 if AlreadyCalled then exit;
 AlreadyCalled:=true;
 WindowState := wsMaximized; // late setting of WindowState to work with Delphi2006
 DoStartUp;
end;

procedure TdhMainForm.Loaded;
begin                   
 //WindowState:=wsMaximized;
 inherited; 
end;

procedure TdhMainForm.DEBUG_ConverttoPNG1Click(Sender: TObject);
begin                   
{$IFNDEF CLX}
{ LateCreateForm(TConvertGraphicsFormat,ConvertGraphicsFormat);
 ConvertGraphicsFormat.Prepare(Act);
 }   
{$ENDIF}
end;

procedure TdhMainForm.PropsPCLoadfromHTTPaddress1Click(Sender: TObject);
begin
  Tabs.mLoadfromHTTPaddressClick(Sender);

end;

procedure TdhMainForm.DEBUG_CopyWithMeta1Click(Sender: TObject);
begin    
 Act.MySiz.CopyComponents(false,true);

end;

procedure TdhMainForm.mTechnicalSupportClick(Sender: TObject);
begin     
 Browse('mailto:support@dfm2html.com',{'iexplore'}EmptyStr,false);
end;

procedure TdhMainForm.mRegisterClick(Sender: TObject);
begin
 //Browse('http://www.dfm2html.com/launch/register.html',FViewer,false);
 {LateCreateForm(TRegister,Register);
 if Register.ShowModal=mrOk then
 begin
  if UpdateRegistrationStatus(Register.Edit1.Text) then
  begin
   showmessage('Thank you for registering DFM2HTML');
   WriteConfig;
  end else
  begin              
   showmessage('Wrong password');
  end;
 end;  }
end;

function TdhMainForm.UpdateRegistrationStatus(const RegString:String):boolean;
begin
 //Registered:=LowerCase(RegString)='registered';
 Registered:=true;
 if Registered then
 begin
   Self.RegString:=RegString;
 end;
 mRegister.Visible:=not Registered;
 result:=Registered;
end;




procedure TdhMainForm.mVisitForumClick(Sender: TObject);
begin
 Browse('http://www.dfm2html.com/launch/forum.html',FViewer,false);
end;

procedure TdhMainForm.DEBUG_mUnregisterClick(Sender: TObject);
begin
 Registered:=false;
 UpdateRegistrationStatus(EmptyStr);
end;

procedure TdhMainForm.DEBUG_OpenIE1Click(Sender: TObject);
begin
 while Act<>nil do
 begin
 ViewHTML1Click(Sender);
 Act.Close;
 Application.ProcessMessages;
 sleep(100);
 Application.ProcessMessages;
 sleep(100);
 Application.ProcessMessages;
 sleep(100);
 Application.ProcessMessages;
 sleep(100);
 end;
end;

procedure TdhMainForm.mFindClick(Sender: TObject);
begin
 Act.MySiz.Find(false);
end;

procedure TdhMainForm.mSearchAgainClick(Sender: TObject);
begin
 Act.MySiz.Find(true);
end;

procedure TdhMainForm.InvalAll;
var i,w:integer;
begin
 for i:=0 to MDIChildCount-1 do
 with (MDIChildren[i] as TPageContainer)do
 for w:=0 to ComponentCount-1 do
 begin
 if Components[w] is TdhCustomPanel then
 begin
  TdhCustomPanel(Components[w]).NotifyCSSChanged(AllChanged);
 end;
 end;
end;


procedure TdhMainForm.DEBUG_ANSIUNICODE1Click(Sender: TObject);
var i,c,w:integer;
    l:TdhLabel;
    ws:WideString;
    s,ex:string;
begin
  {
 c:=0;
 if Act=nil then exit;
 for i:=0 to Act.ComponentCount-1 do
 begin
  if (Act.Components[i] is TdhLabel) then
  begin
   l:=TdhLabel(Act.Components[i]);
   ws:=l.Text;
   setlength(s,length(ws));
   for w:=1 to length(ws) do
    s[w]:=char(ws[w]);
   ws:=CodePageToWideString(s);
   if l.Text<>ws then
   begin
    l.Text:=ws;
    ex:=l.Name;
    inc(c);            
   end;
  end;
 end;
 if c<>0 then
 begin
  Tabs.Changed('Change encoding');
  showmessage('Changed '+inttostr(c)+' string(s), e.g. of object '+ex+'.'+endl_main+'You can undo/redo this change in the Edit main menu.');
 end else
  showmessage('Changed '+inttostr(c)+' string(s).');
}
end;

procedure TdhMainForm.m5minGuideClick(Sender: TObject);
begin                     
 if _LANGID=LANGID_GERMAN then
  Open(ExtractFilePath(Application.Exename)+'GuideGerman.dfm',false) else
  Open(ExtractFilePath(Application.Exename)+'Guide.dfm',false);
end;

procedure TdhMainForm.mBasicExampleClick(Sender: TObject);
begin
 Open(ExtractFilePath(Application.Exename)+'GuideExample.dfm',false);
end;

procedure TdhMainForm.mBasicExamplewithFooterClick(Sender: TObject);
begin
 Open(ExtractFilePath(Application.Exename)+'GuideExampleWithFooter.dfm',false);
end;

procedure TdhMainForm.mBasicExamplewithStylesheetClick(Sender: TObject);
begin
 Open(ExtractFilePath(Application.Exename)+'GuideExampleWithStylesheet.dfm',false);
end;

procedure TdhMainForm.mBasicExamplewithFramesLayoutClick(Sender: TObject);
begin
 Open(ExtractFilePath(Application.Exename)+'GuideExampleWithFramesLayout.dfm',false);
end;

procedure TdhMainForm.DEBUG_OnLoad1Click(Sender: TObject);
begin
 OnLoad:=true;
 DEBUG_OnLoad1.Checked:=true;
 DEBUG_Dokumentende1.Checked:=false;
end;

procedure TdhMainForm.DEBUG_Dokumentende1Click(Sender: TObject);
begin
 OnLoad:=false;
 DEBUG_OnLoad1.Checked:=false;
 DEBUG_Dokumentende1.Checked:=true;
end;

procedure TdhMainForm.mLanguageTemplateClick(Sender: TObject);
begin
 TMenuItem(Sender).Checked:=true;
 _LANGID:=LangManager.LanguageIDs[mLanguage.IndexOf(TMenuItem(Sender))];
 UpdateLanguage;
end;

procedure TdhMainForm.UpdateLanguage;
begin
 LangManager.LanguageID:=_LANGID;
 UpdateAlign;
 Tabs.UpdateSel;
 LoadFormElement(glMen);
 Tabs.UpdateTabImages;
 UpdateStatusBar;
 UpdateOtherConstants;
end;

procedure TdhMainForm.UpdateOtherConstants;
begin
 QUOTEINVALIDVALUE_STR:=DKLangConstW(QUOTEINVALIDVALUE);
 REFOBJECT_STR:=DKLangConstW(REFOBJECT);
 INVALIDMENUNESTING_STR:=DKLangConstW(INVALIDMENUNESTING);
end;

procedure TdhMainForm.UpdateStatusBar;
begin
 if (Act<>nil) and Act.IsModified then
  StatusBar.Panels[StatusBar_Modified].Text:=DKFormat(MODIFIEDSTATE) else
  StatusBar.Panels[StatusBar_Modified].Text:=EmptyStr;
 if Act=nil then
  StatusBar.Panels[StatusBar_Mode].Text:=EmptyStr else
 if stateTest.State in [hsDown,hsOverDown] then
  StatusBar.Panels[StatusBar_Mode].Text:=stateTest.RenderedText else
 if stateNormal.State in [hsDown,hsOverDown] then
  StatusBar.Panels[StatusBar_Mode].Text:=stateNormal.RenderedText else
 if stateOver.State in [hsDown,hsOverDown] then
  StatusBar.Panels[StatusBar_Mode].Text:=stateOver.RenderedText else
 if stateOverDown.State in [hsDown,hsOverDown] then
  StatusBar.Panels[StatusBar_Mode].Text:=WideStringReplace(stateOverDown.RenderedText,#$A,'/',[rfIgnoreCase]) else
 if stateDown.State in [hsDown,hsOverDown] then
  StatusBar.Panels[StatusBar_Mode].Text:=stateDown.RenderedText;
end;



procedure TdhMainForm.DEBUG_UpdateCodePageClick(Sender: TObject);
begin
 LangManager.LanguageID:=LangManager.LanguageIDs[0];
 UpdateLanguage;
end;


destructor TdhMainForm.Destroy;
begin
  inherited;
end;


procedure TdhMainForm.GenerateTimerTimer(Sender: TObject);
const WorkIndicator:array[0..2] of string=('.','..','...');
begin
 StatusBar.Panels[StatusBar_Mode].Text:=WorkIndicator[GenerateTimer.Tag mod 3];
 GenerateTimer.Tag:=GenerateTimer.Tag+1;
 StatusBar.Update;
end;

procedure TdhMainForm.DEBUG_PosIE1Click(Sender: TObject);
begin
 TdhCustomPanel(Tabs.Selection[0]).Top:=TdhCustomPanel(Tabs.Selection[0]).Top+95;
 TdhCustomPanel(Tabs.Selection[0]).Left:=TdhCustomPanel(Tabs.Selection[0]).Left+2;
end;

procedure TdhMainForm.DEBUG_PosFF1Click(Sender: TObject);
begin
 TdhCustomPanel(Tabs.Selection[0]).Top:=TdhCustomPanel(Tabs.Selection[0]).Top+98;
 TdhCustomPanel(Tabs.Selection[0]).Left:=TdhCustomPanel(Tabs.Selection[0]).Left+0;

end;

procedure TdhMainForm.MenuTutorial1Click(Sender: TObject);
begin
  Open(ExtractFilePath(Application.Exename)+'TutorialMenus.dfm',false);
end;

initialization

 for ch:=chr(0) to chr(255) do
 if ch in noValidFilenameChars then
  lookup_url_char[ch]:=1;
 lookup_url_char['%']:=2;
 lookup_url_char['?']:=3;


 CrcList:=TObjectList.Create;


 glIsDesignerSelected:=IsDesignerSelected;
 glOnHistory:=OnHistory;
 glOnAfterNavigate:=OnAfterNavigate;
 glPreAddCompo:=PreAddCompo;
 glPostAddCompo:=PostAddCompo;
 glAfterSaveBin:=AfterSaveBin;
 glStringToFile:=StringToFile;

//    WHook := SetWindowsHookEx(WH_CALLWNDPROCRET	 , @CallWndProcHook, 0, GetCurrentThreadId);

 CF_COMPONENTS := {QClipbrd.}{$IFDEF CLX}Clipboard.{$ENDIF}RegisterClipboardFormat(sCF_COMPONENTS);

finalization

 FreeAndNil(CrcList);

 FreeAndNil(GeneratedFiles);

//    UnHookWindowsHookEx(WHook);

end.


