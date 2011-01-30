unit Unit1;

interface

{$R DFM2HTML.dkl_const.res}

uses

  SysUtils, Classes, TypInfo,
{$IFDEF CLX}
  QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls, QComCtrls,  QStdCtrls, QTntStdCtrls,
  QImgList, QMenus, QClipbrd, QStyle,
{$ELSE}
  {uMutex,}Controls, Forms, Windows, Messages, Graphics, Dialogs, ExtCtrls, clipbrd, Buttons, JPeg,
  ComCtrls, CommCtrl, StdCtrls, ShellAPI, RTLConsts,  Menus, FileCtrl,
  {Mask, }ToolWin, ImgList,   AppEvnts, {IECache,} URLDropTarget, XPMan, UnicodeCtrls,  //XPdesign,
{$ENDIF}
  Unit2, dhDirectHTML,
  MySpeedButton, dhPanel, htmlrout, {$IFDEF MSWINDOWS}OverbyteIcsHttpProt,{$ELSE}{IcsUrl,}{$ENDIF}
  funcutils, dhHTMLForm,  dhPageControl,  dhStyleSheet,
  dhMenu, dhLabel, dhEdit, MySpinEdit,
  UseFastStrings, crc, math,
  MySiz, Unit3, uConversion,
  dhRadioButton, dhMemo, dhFileField,  MyToolButton,
  dhColorPicker,IniFiles,gr32, uOptions, menuhelper,
  pngimage, Contnrs,hEdit,hComboBox,hMemo,hSynMemo,SynMemo, UIConstants,DKLang, OpenSave,AColorPickerAX_TLB,dhStrUtils,WideStrUtils,uMetaWriter,dhStyles,dhGraphicFormats,dhColorUtils,shlobj;

//const WM_PUSHUP=WM_USER+33;

const LANGID_GERMAN=1031;
const LANGID_ITALIAN=1040;

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
    N15: TTntMenuItem;
    mExternalizeImages: TTntMenuItem;
    IGNORE_SaveDraggedPictureDialog: TMySavePictureDialog;
    mCheckForUpdate: TTntMenuItem;
    mObjectExplorer: TTntMenuItem;
    ColorPreviewTimer: TTimer;
    mResourceExplorer: TTntMenuItem;
    mDonate: TMenuItem;
    mGetWebHost: TMenuItem;
    mEditorPopupMenu: TPopupMenu;
    IGNORE_mEditorCut: TMenuItem;
    IGNORE_mEditorCopy: TMenuItem;
    IGNORE_mEditorPaste: TMenuItem;
    IGNORE_mEditorDelete: TMenuItem;
    IGNORE_mEditorSelectAll: TMenuItem;
    N17: TMenuItem;
    IGNORE_mEditorUndo: TMenuItem;
    N18: TMenuItem;
    procedure mResourceExplorerClick(Sender: TObject);
    procedure ColorPreviewTimerTimer(Sender: TObject);
    procedure mObjectExplorerClick(Sender: TObject);
    procedure mCheckForUpdateClick(Sender: TObject);
    procedure mExternalizeImagesClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure csEndSize(Sender: TObject);
    procedure shMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mOpenClick(Sender: TObject);
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
    procedure mDonateClick(Sender: TObject);
    procedure mGetWebHostClick(Sender: TObject);
    procedure IGNORE_mEditorUndoClick(Sender: TObject);
    procedure IGNORE_mEditorCutClick(Sender: TObject);
    procedure IGNORE_mEditorCopyClick(Sender: TObject);
    procedure IGNORE_mEditorPasteClick(Sender: TObject);
    procedure IGNORE_mEditorDeleteClick(Sender: TObject);
    procedure IGNORE_mEditorSelectAllClick(Sender: TObject);
  private
    LastFile:TPathName;
    FAct:TPageContainer;
    AlreadyCalled,SilentUpdateCheck:boolean;
    RegString:string;
    LastUpdateCheck:TDateTime;

{$IFNDEF CLX}
    HttpCli1: THttpCli;
    HttpUpdateCli: THttpCli;
    procedure HttpCli1RequestDone(Sender  : TObject; RqType  : THttpRequest; ErrCode : Word);
    procedure HttpUpdateCliRequestDone(Sender  : TObject; RqType  : THttpRequest; ErrCode : Word);
{$ENDIF}
    procedure UpdateLanguage;
    procedure UpdateOtherConstants;
    procedure UpdateStatusBar;
    procedure WriteSmartPublishingCRCs;
    procedure ReadSmartPublishingCRCs;
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
    procedure LoadDragURL(LoadAsTitled:boolean);
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
    function GetTopLevelDomain:TPathName;
  public
    { Public declarations }
    destructor Destroy; override;
    property Act:TPageContainer read FAct write FAct;
    procedure UpdateNames(find:TControl);
    procedure ImageFromURL(URL:TPathName; c:TControl);
    function Open(FileName: TPathName; SetUntitled:boolean; Unvisible:boolean=false):TPageContainer;
    procedure UpdateHistory;

{$IFNDEF CLX}
    function IsShortCut(var Message: TWMKey): Boolean; override;
{$ENDIF}
    procedure UpdateCommands(SelChange,SiteChange:boolean);
    //function Act:TPageContainer;
    procedure ApplyNewSettings(FontToCurrent:boolean; FontToAll:boolean);
    function GeneratedHTML(View:Boolean):TPathName;
  end;

var
  dhMainForm: TdhMainForm;
var FuncSettings:TFuncSettings;
    LockLock:boolean=false;
//    ActForm:TForm=nil;

type TFakeWinControl=class(TWinControl);


function ExtractUrlAimedFilenameToWindowsFilename(const URL: TPathName): TPathName;
function GetLanguageDFM(const prefix:TPathName):TPathName;
function RootDir(const s:TPathName): TPathName;
function UserDir(const s:TPathName): TPathName;
function UserOrRootDir(const s:TPathName): TPathName;
var
  CF_COMPONENTS: Word;
const sCF_COMPONENTS={'Delphi Components'}'application/delphi.component';

const
 StatusBar_Mode=0;
 StatusBar_Modified=1;
 StatusBar_ObjName=2;
 StatusBar_ObjPos=3;

var _LANGID:LANGID;

implementation

uses uWarnings, uPublishLog, uPublishFTP, uTemplates, uPresets, uStartUp,
  uColorPicker, uPageWizard, uObjectExplorer, OleCtrls, uResourceExplorer;

{$R *.dfm}


var RasteringSaveDir:TPathName;

var CrcList:TObjectList;



type PFontStyles=^TFontStyles;

const
      configFile='Config.ini';
      crcFile='SmartPublishingCRCs.txt';
      UpdateCheckInterval=30;
      NeverCheckedForUpdate=0;

var BaseDir:TPathName;

function RootDir(const s:TPathName): TPathName;
begin
 result:=ExtractFilePath(Application.Exename)+s;
end;

function UserDir(const s:TPathName): TPathName;
var
   r: Bool;
   path: array[0..Max_Path] of Char;
begin
   r := ShGetSpecialFolderPath(0, path, CSIDL_Personal, False) ;
   if not r then raise Exception.Create('Could not find MyDocuments folder location.') ;
   Result := GoodLocalPath(Path)+'DFM2HTML';
   Result := Result+PathDelim+s;
   ForceDirectories(ExtractFilePath(Result));
end;

function UserOrRootDir(const s:TPathName): TPathName;
begin
  Result:=UserDir(s);
  if FileExists(Result) then exit;
  Result:=RootDir(s);
end;


const sPropsAlign:array[TAlign] of string=('Horizontal', 'Top', 'Bottom', 'Left', 'Right', 'Vertical','x');

const sLaunchAction:array[TLaunchAction] of string=('Choice', 'Last', 'None');

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

function GetFormatSettings:TFormatSettings;
begin
   Result.ShortDateFormat:='YYYY-MM-DD';
   Result.LongDateFormat:='YYYY-MM-DD';
   Result.DateSeparator:='-';
end;

function GetLanguageDFM(const prefix:TPathName):TPathName;
var StartsWith:TPathName;
begin
 StartsWith:=RootDir(prefix);
 Result:=StartsWith+IntToStr(_LANGID)+'.dfm';
 if FileExists(Result) then
  Exit;
 Result:=StartsWith+'.dfm';
end;

function ActiveEditControl: IhCommitable;
var c:TControl;
begin
 c:=ExtractActiveControl;
 //if (Tabs.ActiveEditControl<>nil) and not (Screen.ActiveForm is TPageContainer) then
 if ((c is TMySpinEdit) or (c is ThEdit) or (c is ThComboBox) or (c is ThMemo) or (c is ThSynMemo)) and not (c.Owner is TPageContainer) then
 if Supports(c,IhCommitable) then
 begin
  Result:=(TControl(c) as IhCommitable);
  exit;
 end;
 Result:=nil;
end;

procedure TdhMainForm.ReadConfig;
var
    IniFile:TMemIniFile;
    firststarted:boolean;
    DefaultFontStyle:integer;
    i:integer;
    s:String;
    iPropsAlign:TAlign;
    iLaunchAction:TLaunchAction;
    sLastUpdateCheck:String;
    ColorChar:Char;
    CustomColorName,CustomColorValue:String;
    dir:TPathName;
begin
  firststarted:=true;
  LastUpdateCheck:=NeverCheckedForUpdate;
 dir:=UserOrRootDir(configFile);
 try
 IniFile:=TMemIniFile.Create(dir);

 with IniFile do
 try

  firststarted:=ReadString('Program','V',EmptyStr)=EmptyStr;

  UpdateRegistrationStatus(DecodePsw(ReadString('Program','R',EmptyStr)));

  LastFile:=ReadString('Program','Last File',EmptyStr);

  sLastUpdateCheck:=ReadString('Program','Last Update Check','');
  try
   if sLastUpdateCheck<>'' then
    LastUpdateCheck:=StrToDate(sLastUpdateCheck,GetFormatSettings);
  except
  end;
  FuncSettings.FAutoUpdate:=ReadBool('Program','Monthly Check For Update',true);

  with FuncSettings do with GridDefinition do
  begin
  GridX:=ReadInteger('Grid','GridX',8);
  GridY:=ReadInteger('Grid','GridY',8);
  GridDisplay:=TGridDisplay(ReadInteger('Grid','Display',0));
  FViewer:=ReadString('General','Viewer',EmptyStr);
  FSmartPublishing:=ReadBool('General','Smart Publishing',true);
  FPassiveFTP:=ReadBool('General','Passive FTP',true);
  end;

  FuncSettings.Compress:=ReadBool('General','Compress',false);
  UseCSS3:=ReadBool('General','CSS3',false);

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
   
  s:=ReadString('General','StartUpAction',EmptyStr);
  for iLaunchAction:=Low(TLaunchAction) to High(TLaunchAction) do
  if sLaunchAction[iLaunchAction]=s then
   FuncSettings.LaunchAction:=iLaunchAction;

  for ColorChar:='A' to 'P' do
  begin
   CustomColorName:='Color'+ColorChar;
   CustomColorValue:=ReadString('Custom Colors',CustomColorName,'');
   if CustomColorValue<>'' then
    FCustomColors.add(CustomColorName+'='+CustomColorValue);
  end;

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
  showmessage('Cannot read '+dir+endl+
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
  if FuncSettings.FSmartPublishing then
   sl.LoadFromFile(UserOrRootDir(crcFile));
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
     Files[High(Files)].CRC:=StrToInt64('$'+Copy(s,p+1,maxint));
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
 sl.SaveToFile(UserDir(crcFile));
 finally
  sl.Free;
 end;
end;


procedure TdhMainForm.WriteConfig;
var IniFile:TMemIniFile;
    DefaultFontStyle:integer;
    i,index:integer;
    s,CustomColor,CustomColorName,CustomColorValue:string;
    dir:TPathName;
begin
 dir:=UserDir(configFile);
 try
 IniFile:=TMemIniFile.Create(dir);

 with IniFile do
 try
  Clear;
  WriteString('Program','V',DFM2HTML_VERSION);
  //WriteString('Program','R',EncodePsw(RegString));

  if Act<>nil then
   WriteString('Program','Last File', Act.FileName);


  if LastUpdateCheck<>NeverCheckedForUpdate then
   WriteString('Program','Last Update Check',DateToStr(LastUpdateCheck,GetFormatSettings));
  WriteBool('Program','Monthly Check For Update',FuncSettings.FAutoUpdate);



  with FuncSettings do with GridDefinition do
  begin
  WriteInteger('Grid','GridX',GridX);
  WriteInteger('Grid','GridY',GridY);
  WriteInteger('Grid','Display',Integer(GridDisplay));
  WriteString('General','Viewer',FViewer);
  WriteBool('General','Smart Publishing',FSmartPublishing);
  WriteBool('General','Passive FTP',FPassiveFTP);
  end;

  WriteBool('General','Compress',FuncSettings.Compress);
  WriteBool('General','CSS3',UseCSS3);

  WriteString('General','Default Font Name',FuncSettings.DefaultFont.Name);
  WriteInteger('General','Default Font Size',FuncSettings.DefaultFont.Size);
  PFontStyles(@DefaultFontStyle)^:=FuncSettings.DefaultFont.Style;
  WriteInteger('General','Default Font Style',DefaultFontStyle);
  //WriteInteger('General','Default Font Charset',FuncSettings.DefaultFont.Charset);

  WriteInteger('LRU','Count',FuncSettings.LRUfiles.Count);
  for i:=0 to FuncSettings.LRUfiles.Count-1 do
   WriteString('LRU','File'+inttostr(i),FuncSettings.LRUfiles[i]);

  WriteString('General','PropsAlign',sPropsAlign[PropsAlign]);
  WriteString('General','StartUpAction',sLaunchAction[FuncSettings.LaunchAction]);

  WriteInteger('General','LANGID',_LANGID);

  if ColorDialog is TColorDialog then
  begin
   FCustomColors.Clear;
   FCustomColors.AddStrings(TColorDialog(ColorDialog).CustomColors);
   FCustomColors.Sort;
  end;
  for i:=0 to FCustomColors.Count-1 do
  begin
   CustomColor:=FCustomColors[i];
   index:=Pos('=',CustomColor);
   if index<>0 then
   begin
    CustomColorName:=Copy(CustomColor,1,index-1);
    CustomColorValue:=Copy(CustomColor,index+1,MaxInt);
    if CustomColorValue<>'FFFFFFFF' then
     WriteString('Custom Colors',CustomColorName,CustomColorValue);
   end;
  end;
  

  UpdateFile;
 finally 
  Free;
 end;

 except
 on e:Exception do
  showmessage(DKFormat(SAVETOERROR,dir)+endl+
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
 begin
  cbName.Clear;   
  if ObjectExplorer<>nil then
   ObjectExplorer.Clear;
 end else
 begin
  GetRefs_(cbName,TControl,Act,find,ListName,false);
  if ObjectExplorer<>nil then
   ObjectExplorer.UpdateRootAndSelection;
 end;
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
 mRedo.Enabled:=(Act<>nil) and Act.CanRedo and not _RuntimeMode;

 mFind.Enabled:=(Act<>nil) and not _RuntimeMode;
 mSearchAgain.Enabled:=mFind.Enabled;
 mReplace.Enabled:=mFind.Enabled;
 
 mExternalizeImages.Enabled:=(Act<>nil);
 mResourceExplorer.Enabled:=(Act<>nil);

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

procedure ChangedContent(Control:TControl; commit:boolean);
begin
 if _RuntimeMode then exit;
 if commit then
 begin
  if Control.Owner is TPageContainer then
    TPageContainer(Control.Owner).SetModified('Typing');
 end else
  Tabs.ActContentChanged;
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


procedure TdhMainForm.MyDrawTabEvent(Sender, Source: TObject; Canvas: TCanvas; Index, HorizonalPadding,
    VerticalPadding, Overlap: Integer; Selected: Boolean);
begin

end;



procedure TdhMainForm.FormCreate(Sender: TObject);
var iLanguage:integer;
var lsl:TStringList;
begin
 dhPanel2.Style.BackgroundColor:=ColorToCSSColor(ToolBar1.Color);
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

 DEBUG_mDebug.Visible:=false;
 SpeedButton1.Transparent:=false;

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



procedure TdhMainForm.mOpenClick(Sender: TObject);
var i:integer;
begin  {
 s:=StringFromFile('C:\DFM2HTML_bei18\onebyone.gif');
 for i:=1 to length(s) do
  ss:=ss+inttohex(ord(s[i]),2);
 Clipboard.AsText:=ss;   }

 if OpenDialog1.Execute then
 for i:=0 to OpenDialog1.Files.Count-1 do
 begin
  Open(OpenDialog1.Files[i],false);
 end;
end;

function TdhMainForm.Open(FileName:TPathName; SetUntitled:boolean; Unvisible:boolean=false):TPageContainer;
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
var c:IhCommitable;
begin
 c:=ActiveEditControl;
 if c<>nil then
  c.Copy else
  Act.MySiz.CopyComponents(false);
end;

procedure TdhMainForm.mPasteClick(Sender: TObject);
var c:IhCommitable;
begin
 c:=ActiveEditControl;
 if c<>nil then
  c.Paste else
  Act.PasteComponents(nil);
end;


procedure TdhMainForm.FormDestroy(Sender: TObject);
begin
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
var c:IhCommitable;
begin
 c:=ActiveEditControl;
 if c<>nil then
  c.Delete else
  Act.MySiz.DeleteComponents;
end;

procedure TdhMainForm.mDonateClick(Sender: TObject);
begin
  Browse('http://www.dfm2html.com/launch/donate.html?langid='+inttostr(_LANGID),{'iexplore'}FuncSettings.FViewer,false);
end;

procedure TdhMainForm.IGNORE_mEditorCopyClick(Sender: TObject);
begin
 with mEditorPopupMenu.PopupComponent as TSynMemo do
 Clipboard.AsText:=SelText;
end;

procedure TdhMainForm.IGNORE_mEditorCutClick(Sender: TObject);
begin
 IGNORE_mEditorCopyClick(Sender);
 IGNORE_mEditorDeleteClick(Sender);
end;

procedure TdhMainForm.IGNORE_mEditorDeleteClick(Sender: TObject);
begin
 with mEditorPopupMenu.PopupComponent as TSynMemo do
 SelText:='';
end;

procedure TdhMainForm.IGNORE_mEditorPasteClick(Sender: TObject);
begin
 with mEditorPopupMenu.PopupComponent as TSynMemo do
 SelText:=Clipboard.AsText;
end;

procedure TdhMainForm.IGNORE_mEditorSelectAllClick(Sender: TObject);
begin
 with mEditorPopupMenu.PopupComponent as TSynMemo do
 SelectAll;
end;

procedure TdhMainForm.IGNORE_mEditorUndoClick(Sender: TObject);
begin
 with mEditorPopupMenu.PopupComponent as TSynMemo do
 Undo;
end;

procedure TdhMainForm.mCutClick(Sender: TObject);
{var png:TPNGObject;
    bt:TBitmap32;
    i:integer;
    x,y:integer;
    gif:TGifImage;  }
var c:IhCommitable;
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
 c:=ActiveEditControl;
 if c<>nil then
 begin
  c.Copy;
  c.Delete;
 end else
 begin
  mCopyClick(Sender);
  mDeleteClick(Sender);
 end;
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
  InvalTrans(DChild);
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
var c:IhCommitable;
begin
 c:=ActiveEditControl;
 if c<>nil then
  c.Undo else
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

Function GetTMPDir: TPathName;
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


procedure CleverStringToFile(FileName:TPathName; const s:TFileContents);
var NeedSave:boolean;
    AbsoluteFileName:TPathName;
begin
 glSaveBin(calc_crc32_String(s),FileName,AbsoluteFileName,false,EmptyStr,NeedSave,true);
 if NeedSave then
 begin
  StringToFile(AbsoluteFileName,s);
  glAfterSaveBin;
 end;
end;


type TSaveBinItem=class
      id_crc:DWORD;
      data_crc:DWORD;
      FileAge:TDateTime;
      FileName:TPathName;
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

function FindFilename(const Filename:TPathName):TSaveBinItem;
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


function SaveBin(_crc:DWORD; var RasteringFile,AbsoluteRasteringFile:TPathName; CheckBaseRasteringFile:boolean; BaseRasteringFile:TPathName; var NeedSave:boolean; NeedSameFileName:boolean):boolean;
var id_crc:DWORD;
    server_crc:DWORD;
    sb:TSaveBinItem;
    AbsoluteBaseRasteringFile:TPathName;
    age:TDateTime;
begin
  if (PublishLog<>nil) and PublishLog.Busy then
  begin
   PublishLog.Log('        '+RasteringFile);
  end;
  NeedSave:=false;
  server_crc:=_crc;//calc_crc32_String(RasteringFile,_crc);
  RasteringFile:=CutCurrentDir(GoodWebPathDelimiters(RasteringFile));
  AbsoluteRasteringFile:=RasteringSaveDir+GoodPathDelimiters(RasteringFile);
  AbsoluteBaseRasteringFile:=RasteringSaveDir+GoodPathDelimiters(BaseRasteringFile);
  ForceDirectories(ExtractFilePath(AbsoluteRasteringFile));

  if NeedSameFileName then
   id_crc:=calc_crc32_String(AnsiString(lowercase(AbsoluteRasteringFile)),_crc) else
   id_crc:=calc_crc32_String(AnsiString(lowercase(RasteringSaveDir)),_crc);

  sb:=FindIdCrc(id_crc);
  if sb<>nil then
  if not FileAge(sb.FileName,age) or (sb.FileAge<>age) or (sb.FileName<>AbsoluteRasteringFile) and (GeneratedFiles.IndexOf(sb.FileName)=-1) { or not SameText(RasteringSaveDir,ExtractFileDir(CrcList[i])+PathDelim)} then
  begin
   CrcList.Remove(sb);
  end else
  begin
   AbsoluteRasteringFile:=sb.FileName;
   RasteringFile:=GoodWebPathDelimiters(Copy(AbsoluteRasteringFile, Length(RasteringSaveDir)+1, MaxInt));
   if CheckBaseRasteringFile and (AbsoluteBaseRasteringFile=AbsoluteRasteringFile) then
   begin
    result:=false;
    exit;
   end else
   begin
    if (GeneratedFiles.IndexOf(sb.FileName)=-1) then GeneratedFiles.AddObject(AbsoluteRasteringFile,Pointer(server_crc));
    result:=true;
    exit;
   end;
  end;

  if (GeneratedFiles.IndexOf(AbsoluteRasteringFile)=-1) then GeneratedFiles.AddObject(AbsoluteRasteringFile,Pointer(server_crc));

  AfterSaveBinI:=FindFilename(AbsoluteRasteringFile);
  if AfterSaveBinI<>nil then
   {CrcList.Objects[AfterSaveBinI]:=Pointer(_crc)} else
   begin
   AfterSaveBinI:=TSaveBinItem.Create;
   CrcList.Add(AfterSaveBinI);
   end;
  AfterSaveBinI.id_crc:=id_crc;
  AfterSaveBinI.data_crc:=_crc;
  AfterSaveBinI.FileName:=AbsoluteRasteringFile;
  {if dhMainForm.Act<>nil then
   AfterSaveBinI.DocName:=dhMainForm.Act.FileName; }


  NeedSave:=true;
  result:=true;
end;

procedure TdhMainForm.ViewHTML1Click(Sender: TObject);
begin
 GeneratedHTML(True);
end;

function TdhMainForm.GeneratedHTML(View:Boolean):TPathName;
var content:TFileContents;
    pa,PureFileName:TPathName;
    sStatus:string;
begin
 FreeAndNil(GeneratedFiles);
 GeneratedFiles:=TStringList.Create;
 SetSaveDir;
 men:=Tabs.IGNORE_dhDirectHTML1.InnerHTML;

                             
 sStatus:=StatusBar.Panels[StatusBar_Mode].Text;
 GenerateTimer.Tag:=0;
 //GenerateTimer.Enabled:=true;
 try
  glSaveBin:=SaveBin;
  glStringToFile:=CleverStringToFile;
  try
   Content:=Act.GetDFMStr(false,true);
   if (PublishLog<>nil) and not PublishLog.Busy then exit;
   StartConverting(BaseDir,FuncSettings.Compress,nil);
   try
    DoConvertContent(PureFileName,content);
    if View then
    if Warnings.Count<>0 then
    begin
     LateCreateForm(TFormWarnings,FormWarnings);
     FormWarnings.Memo1.Lines.Assign(Warnings);
     FormWarnings.Show;
    end;
   finally
    EndConverting;
   end;
  finally
   glSaveBin:=nil;
   glStringToFile:=nil;
  end;
 finally
  GenerateTimer.Enabled:=false;
  StatusBar.Panels[StatusBar_Mode].Text:=sStatus;
 end;
 pa:=RasteringSaveDir+PureFileName;
 if View then
  Browse(pa,FuncSettings.FViewer,true);
 Result:=RasteringSaveDir;
end;

procedure TdhMainForm.mExitClick(Sender: TObject);
begin
 Close;
end;

function PureFileName(const FileName:TPathName):TPathName;
begin
 Result:=ExtractFileName(GoodPathDelimiters(FileName));
end;

procedure TdhMainForm.mExternalizeImagesClick(Sender: TObject);
var Directory:{$IFDEF CLX}widestring{$ELSE}string{$ENDIF};
    sw:string;
    I: Integer;
    pn:TdhCustomPanel;
    State:TState;
    FileName:TPathName;
    anyFilesToWrite:Boolean;
    anyFilesToShift:Boolean;
    Warnings:TStringList;

procedure AddWarning(const id,s:string);
var ss:string;
begin
 ss:=id+' '+s;
 if Warnings.IndexOf(ss)=-1 then
  Warnings.Add(ss);
end;

begin
 anyFilesToWrite:=false;
 anyFilesToShift:=false;
 for I := 0 to Act.ComponentCount - 1 do
 begin
   if Act.Components[i] is TdhCustomPanel then
   begin
     pn:=TdhCustomPanel(Act.Components[i]);
     for state:=low(TState) to high(TState) do
     if pn.StyleArr[state]<>nil then with pn.StyleArr[state] do
     if BackgroundImage.HasPicture then
     if not BackgroundImage.HasPath then
     begin
      anyFilesToWrite:=true;
     end else
     begin
      anyFilesToShift:=true;
     end;
   end;
 end;
 if not anyFilesToWrite and not anyFilesToShift then
 begin
  ShowMessage(DKFormat(NOIMAGETOEXTERNALIZE));
  exit;
 end;
 Directory:=ExtractFilePath(Act.FileName);
 if SelectDirectory('','',Directory) then
 begin
   sw:=GoodLocalPath(Directory);
   anyFilesToShift:=false;
   for I := 0 to Act.ComponentCount - 1 do
   begin
     if Act.Components[i] is TdhCustomPanel then
     begin
       pn:=TdhCustomPanel(Act.Components[i]);
       for state:=low(TState) to high(TState) do
       if pn.StyleArr[state]<>nil then with pn.StyleArr[state] do
       if BackgroundImage.HasPicture then
       begin
        FileName:=sw+PureFileName(ProposedBackgroundFilename(pn.StyleArr[state]));
        if BackgroundImage.HasPath and (LowerCase(BackgroundImage.GetAbsolutePath)<>LowerCase(FileName)) then
        begin
         anyFilesToShift:=true;
         break;
        end;
       end;
     end;
   end;  
   if anyFilesToShift then
   begin
    anyFilesToShift:=MessageDlg(DKFormat(COPYEXISTINGFILES,FileName),mtConfirmation,[mbYes, mbNo], 0)=mrYes;
   end;
   if not anyFilesToWrite and not anyFilesToShift then
   begin
    ShowMessage(DKFormat(NOIMAGETOEXTERNALIZE));
    exit;
   end;
   Warnings:=TStringList.Create;
   try
   for I := 0 to Act.ComponentCount - 1 do
   begin
     if Act.Components[i] is TdhCustomPanel then
     begin
       pn:=TdhCustomPanel(Act.Components[i]);
       for state:=low(TState) to high(TState) do
       if pn.StyleArr[state]<>nil then with pn.StyleArr[state] do
       if BackgroundImage.HasPicture then
       begin
        FileName:=sw+PureFileName(ProposedBackgroundFilename(pn.StyleArr[state]));
        if not BackgroundImage.HasPath and FileExists(FileName) and (StringFromFile(FileName)<>AsString(BackgroundImage.RequestGraphic)) or anyFilesToShift and BackgroundImage.HasPath and (LowerCase(BackgroundImage.GetAbsolutePath)<>LowerCase(FileName)) and FileExists(FileName) and (StringFromFile(FileName)<>StringFromFile(BackgroundImage.GetAbsolutePath)) then
        try
          if MessageDlg(DKFormat(EXTERNALIZEDIMAGEALREADYEXISTS,FileName),mtConfirmation,[mbYes, mbNo], 0)<>mrYes then exit;
        except
        end;
       end;
     end;
   end;
   Tabs.CommitChanges;
   for I := 0 to Act.ComponentCount - 1 do
   begin
     if Act.Components[i] is TdhCustomPanel then
     begin
       pn:=TdhCustomPanel(Act.Components[i]);
       for state:=low(TState) to high(TState) do
       if pn.StyleArr[state]<>nil then with pn.StyleArr[state] do
       if BackgroundImage.HasPicture then
       try
        FileName:=sw+PureFileName(ProposedBackgroundFilename(pn.StyleArr[state]));
        if not BackgroundImage.HasPath then
        begin
         SaveGraphic(BackgroundImage.RequestGraphic,FileName);
         LoadImage(FileName);
        end else
        if anyFilesToShift and (LowerCase(BackgroundImage.GetAbsolutePath)<>LowerCase(FileName)) then
        begin
         StringToFile(FileName,StringFromFile(BackgroundImage.GetAbsolutePath));
         LoadImage(FileName);
        end;
       except
       on e:Exception do
         AddWarning(pn.Name,': '+e.Message);
       end;
     end;
   end;
   Tabs.Changed('Externalize Images');
   if Warnings.Count<>0 then
   begin
    LateCreateForm(TFormWarnings,FormWarnings);
    FormWarnings.Memo1.Lines.Assign(Warnings);
    FormWarnings.Show;
   end;
   finally
    FreeAndNil(Warnings);
   end;
 end;
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

procedure TdhMainForm.ColorPreviewTimerTimer(Sender: TObject);
begin
 if ActivePicker<>nil then
 begin
  ActivePicker.DoPreviewColorChange;
 end;
end;

procedure TdhMainForm.ToolButton1Click(Sender: TObject);
begin
 SetDesignStyle(DesignStyle,true);
end;


procedure TdhMainForm.cbNameChange(Sender: TObject);
begin
 //if (cbName.ItemIndex<>-1) and (cbName.Items[cbName.ItemIndex]<>cbName.Text) then exit;
 if cbName.DroppedDown or (Act=nil) or _RuntimeMode then exit;
 Act.MySiz.AddSelectionByID(cbName.Text);
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
 ShowMessage(DFM2HTML_VERSION+#13#10+'Freeware'+#13#10+'Copyright 2003-2010'+#13#10+'Jörg Kiegeland'{+#13#10+#13#10+_if(Registered,'Registered version','Unregistered version')});
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

{$IFDEF MSWINDOWS}
function FileCreateAge(const FileName: TPathName; out FileDateTime: TDateTime): Boolean;
var
  Handle: THandle;
  FindData: TWin32FindData;
  LSystemTime: TSystemTime;
  LocalFileTime: TFileTime;
begin
  Result := False;
  Handle := FindFirstFile(PChar(FileName), FindData);
  if Handle <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(Handle);
    //{!!}if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      Result := True;
      FileTimeToLocalFileTime(FindData.ftCreationTime{!!}, LocalFileTime);
      FileTimeToSystemTime(LocalFileTime, LSystemTime);
      with LSystemTime do
        FileDateTime := EncodeDate(wYear, wMonth, wDay) +
          EncodeTime(wHour, wMinute, wSecond, wMilliSeconds);
    end;
  end;
end;
{$ENDIF}


procedure TdhMainForm.mCheckForUpdateClick(Sender: TObject);
var FileDateTime: TDateTime;
    Root:TPathName;
begin
{$IFNDEF CLX}
    SilentUpdateCheck:=Sender=nil;
    if HttpUpdateCli<>nil then
    begin
     HttpUpdateCli.RcvdStream.Free;
     HttpUpdateCli.RcvdStream:=nil;
     FreeAndNil(HttpUpdateCli);
    end;
    HttpUpdateCli:=THttpCli.Create(nil);
    HttpUpdateCli.OnRequestDone:=HttpUpdateCliRequestDone;
    HttpUpdateCli.RcvdStream:=TStringStream.Create;
    if not FileAge(UserOrRootDir(configFile),FileDateTime) then
    begin
     WriteConfig;
    end;
    if SilentUpdateCheck then
     Root:='/autoupd' else
     Root:='/upd';
    if FileCreateAge(Copy(RootDir(''),1,Length(RootDir(''))-1),FileDateTime) then
    begin
     HttpUpdateCli.URL:='http://www.dfm2html.com'+Root+'/'+DateToStr(FileDateTime,GetFormatSettings);
    end else
    begin
     HttpUpdateCli.URL:='http://www.dfm2html.com'+Root+'/unknown';
    end;
    HttpUpdateCli.URL:=HttpUpdateCli.URL+'/'+WideStringReplace(DFM2HTML_VERSION,' ','_',[]);
    if LastUpdateCheck<>NeverCheckedForUpdate then
     HttpUpdateCli.URL:=HttpUpdateCli.URL+'/'+IntToStr(Round(Now-LastUpdateCheck-UpdateCheckInterval)) else
     HttpUpdateCli.URL:=HttpUpdateCli.URL+'/-1';
    if SilentUpdateCheck then
    begin
     LastUpdateCheck:=Now;
    end;
    HttpUpdateCli.GetASync;
    exit;
{$ENDIF}
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

procedure TdhMainForm.mResourceExplorerClick(Sender: TObject);
begin
 LateCreateForm(TResourceExplorer,ResourceExplorer);
 ResourceExplorer.UpdateListing;
 ResourceExplorer.Show;
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
begin
{ propspc.PageControl1.Update;
 propspc.PageControl1.DisableAlign;
 propspc.PageControl1.EnableAlign;
 propspc.PageControl1.Realign;
 propspc.PageControl1.Invalidate;
 propspc.PageControl1.EnableAlign;
                              }

 //StringToFile(UserOrRootDir('tryx.txt'),'blabla');

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

procedure TdhMainForm.mObjectExplorerClick(Sender: TObject);
begin
 LateCreateForm(TObjectExplorer,ObjectExplorer);
 ObjectExplorer.UpdateRootAndSelection;
 if not ObjectExplorer.Visible then
 begin
  ObjectExplorer.Top:=dhMainForm.Top+90;
  ObjectExplorer.Left:=dhMainForm.Width-ObjectExplorer.Width-20;
 end;
 ObjectExplorer.Show;
end;

procedure TdhMainForm.mOpenOutputDirectoryClick(Sender: TObject);
begin
 SetSaveDir;
 Browse(RasteringSaveDir,EmptyStr,true);
end;


{$IFNDEF CLX}
function TdhMainForm.IsShortCut(var Message: TWMKey): Boolean;
var c:TControl;
begin
 if (Message.CharCode=VK_DELETE) or (Message.CharCode=ord('C')) or (Message.CharCode=ord('X')) or (Message.CharCode=ord('V')) then
 begin
 if (ExtractActiveControl is TdhCustomLabel) or (ActiveEditControl<>nil) or (Screen.ActiveForm is TPublishLog) or _RuntimeMode then
 begin
  Result:=False;
  exit;
 end;
 end;
 Result:=inherited IsShortCut(Message);
end;
{$ENDIF}

procedure TdhMainForm.mSelectAllClick(Sender: TObject);
var c:IhCommitable;
begin
 c:=ActiveEditControl;
 if c<>nil then
  c.SelectAll else
  Act.MySiz.Select(Sender=mSelectAll,Sender=mSelectAllBelow);
end;

procedure TdhMainForm.mTutorialClick(Sender: TObject);
begin
 Open(GetLanguageDFM('Tutorial'+PathDelim+'Tutorial'),false);
end;

function TdhMainForm.GetTopLevelDomain:TPathName;
begin                                     
 if _LANGID=LANGID_GERMAN then
  result:='de' else
  result:='com'
end;

procedure TdhMainForm.mHomepageClick(Sender: TObject);
begin
  Browse('http://www.dfm2html.'+GetTopLevelDomain+'/launch/index.html?langid='+inttostr(_LANGID),{'iexplore'}FuncSettings.FViewer,false);
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
 if dhMainForm.Act<>nil then
  dhMainForm.Act.MySiz.ObjectAdded(pn);
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
var URL:TPathName;
begin
 Tabs.CommitChanges;
 if (PublishLog<>nil) and PublishLog.Busy then
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
  PublishFTP.RequireURL:=true;
  try
  if PublishFTP.GetURL(URL) then
  begin
   Act.MySiz.FindBody.FTPURL:=URL;
  end else
   exit;
  finally
   PublishFTP.RequireURL:=false;
  end;
 end;
 LateCreateForm(TPublishLog,PublishLog);
 PublishLog.DoUpload(Act.MySiz.FindBody.FTPURL);
end;

procedure AfterSaveBin;
var age:TDateTime;
begin
 if FileAge(AfterSaveBinI.FileName,age) then
  AfterSaveBinI.FileAge:=age else
  AfterSaveBinI.FileAge:=-1;
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
 PageWizard.PageControl1.ActivePage:=PageWizard.TabSheet1;
 PageWizard.Panel1.Visible:=true; // required for the next line
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
  Browse(Act.MySiz.FindBody.HTTPURL,FuncSettings.FViewer,true);
 end;
end;

procedure TdhMainForm.mNewFromTemplateClick(Sender: TObject);
var Filename:TPathName;
begin
 LateCreateForm(TTemplatesWizard,TemplatesWizard);
 if TemplatesWizard.Prepare(Filename) then
  Open(Filename,true);
end;


function TdhMainForm.ProcessDragDrop(Sender: TObject; Drop:boolean):boolean;
var c:TControl;
    URL_ext,Bitmap_ext,URL,Bitmap:TPathName;
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
    if Bitmap<>URL then
    begin
     IGNORE_SaveDraggedPictureDialog.FileName:= ExtractUrlAimedFilenameToWindowsFilename(Bitmap);
     if IGNORE_SaveDraggedPictureDialog.Execute then
     begin
      StringToFile(IGNORE_SaveDraggedPictureDialog.FileName,StringFromFile(Bitmap));
      Bitmap:=IGNORE_SaveDraggedPictureDialog.FileName;
     end else
      exit;
    end;
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

function URLDecodeOctets(const URL:TPathName):TPathName;
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

function ExtractUrlAimedFilenameToWindowsFilename(const URL: TPathName): TPathName;
var
  I,CopyLess,r,r2: Integer;
begin
 result:=URL;
 while bAdvPos(r,'"',result) and bAdvPos(r2,'"',result,r+1) do
  result:=CopyWithout(result,r,r2+1);
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


var cDragTarget:TComponentName;
    DragURL:TPathName;

procedure TdhMainForm.URLDropTarget1Drop(Sender: TObject);
begin
 ProcessDragDrop(Sender,true);
end;

procedure TdhMainForm.ImageFromURL(URL:TPathName; c:TControl);
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
    HttpCli1.RcvdStream:=TMemoryStream.Create;
    HttpCli1.URL:=DragURL;
    IGNORE_SaveDraggedPictureDialog.FileName:= ExtractUrlAimedFilenameToWindowsFilename(DragURL);
    if IGNORE_SaveDraggedPictureDialog.Execute then
    begin
     DragURL:=IGNORE_SaveDraggedPictureDialog.FileName;
    end else
     exit;
    HttpCli1.GetASync;
    exit;
   end;
{$ENDIF}
   DragURL:=AdjustURLPure(URLDecodeOctets(DragURL));
   LoadDragURL(false);
end;


procedure TdhMainForm.LoadDragURL(LoadAsTitled:boolean);
begin
   If LowerCase(ExtractFileExt(DragURL))='.dfm' then
    Open(DragURL,LoadAsTitled) else
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
var c:IhCommitable;
begin
 c:=ActiveEditControl;
 if c<>nil then
  c.Copy else
  Act.MySiz.CopyComponents(true);
end;

procedure TdhMainForm.mGetWebHostClick(Sender: TObject);
begin
   Browse('http://www.dfm2html.com/launch/host.html?langid='+inttostr(_LANGID),FuncSettings.FViewer,false);
end;

procedure TdhMainForm.mSaveAsTemplateClick(Sender: TObject);
begin    
 Act.SaveAsTemplate;
end;

procedure TdhMainForm.mPresetsClick(Sender: TObject);
begin
 LateCreateForm(TPresets,Presets);
 Presets.Prepare(True);
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
  StringToFile(DragURL,AsString(HttpCli1.RcvdStream as TMemoryStream));
  LoadDragURL(true);
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

{$IFNDEF CLX}
procedure TdhMainForm.HttpUpdateCliRequestDone(Sender: TObject;
  RqType: THttpRequest; ErrCode: Word);
var VerList: TStringList;
    NewVersion:String;
begin
 if ErrCode<>0 then
 begin
  if not SilentUpdateCheck then
   MessageDlg(WideStringReplace(mCheckForUpdate.Caption,'&','',[])+':'+endl+HttpUpdateCli.ReasonPhrase,mtError,[mbOK], 0);
  Exit;
 end;
 VerList := TStringList.Create;
 VerList.Text:=(HttpUpdateCli.RcvdStream as TStringStream).DataString;
 NewVersion := VerList.Values['version'];
 if NewVersion = '' then
 begin
  if not SilentUpdateCheck then
   MessageDlg(WideStringReplace(mCheckForUpdate.Caption,'&','',[])+':'+endl+HttpUpdateCli.ReasonPhrase,mtError,[mbOK], 0);
  Exit;
 end;
 if NewVersion <> DFM2HTML_VERSION then
 begin
  if MessageDlg(DKFormat(NEWVERSIONAVAILABLE),mtConfirmation,[mbYes, mbNo], 0)=mrYes then
  begin
   Browse('http://www.dfm2html.'+GetTopLevelDomain+'/update.html',{'iexplore'}FuncSettings.FViewer,false);
  end;
 end else
 begin
  if not SilentUpdateCheck then
   MessageDlg(DKFormat(STILLUPTODATE),mtInformation,[mbOK], 0);
 end;
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
 if FuncSettings.LaunchAction=suaChoice then
 begin
 //Show;
 //LateCreateForm(TStartUp,StartUp);
 StartUp:=TStartUp.Create(Self);
 try
  su:=StartUp.FirstAction;
 finally
  FreeAndNil(StartUp);
 end;
 end else
 if FuncSettings.LaunchAction=suaLast then
  su:=suLastPage else
  su:=suNothing;

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
 suOpen: mOpenClick(nil);
 end;
 finally
  glLockWindowUpdate(false,lLock);
 end;

 if FuncSettings.FAutoUpdate and ((LastUpdateCheck=NeverCheckedForUpdate) or (Now-LastUpdateCheck-UpdateCheckInterval>=0)) then
 begin
  mCheckForUpdateClick(nil);
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
 Browse('http://www.dfm2html.com/launch/forum.html?langid='+inttostr(_LANGID),FuncSettings.FViewer,false);
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
 Open(GetLanguageDFM('Guide'+PathDelim+'Guide'),false);
end;

procedure TdhMainForm.mBasicExampleClick(Sender: TObject);
begin
 Open(RootDir('GuideExamples'+PathDelim+'GuideExample.dfm'),false);
end;

procedure TdhMainForm.mBasicExamplewithFooterClick(Sender: TObject);
begin
 Open(RootDir('GuideExamples'+PathDelim+'GuideExampleWithFooter.dfm'),false);
end;

procedure TdhMainForm.mBasicExamplewithStylesheetClick(Sender: TObject);
begin
 Open(RootDir('GuideExamples'+PathDelim+'GuideExampleWithStylesheet.dfm'),false);
end;

procedure TdhMainForm.mBasicExamplewithFramesLayoutClick(Sender: TObject);
begin
 Open(RootDir('GuideExamples'+PathDelim+'GuideExampleWithFramesLayout.dfm'),false);
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
 if Presets<>nil then
 begin
  Presets.Prepare(False);
  Presets.UpdateLanguage;
 end;
end;

procedure TdhMainForm.UpdateOtherConstants;
begin
 QUOTEINVALIDVALUE_STR:=DKLangConstW(QUOTEINVALIDVALUE);
 REFOBJECT_STR:=DKLangConstW(REFOBJECT);
 INVALIDMENUNESTING_STR:=DKLangConstW(INVALIDMENUNESTING);
 IGNORE_mEditorUndo.Caption:=mUndo.Caption;
 IGNORE_mEditorCut.Caption:=mCut.Caption;
 IGNORE_mEditorCopy.Caption:=mCopy.Caption;
 IGNORE_mEditorPaste.Caption:=mPaste.Caption;
 IGNORE_mEditorDelete.Caption:=mDelete.Caption;
 IGNORE_mEditorSelectAll.Caption:=mSelectAll.Caption;
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
 Open(GetLanguageDFM('TutorialMenus'+PathDelim+'TutorialMenus'),false);
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
 glChangedContent:=ChangedContent;

//    WHook := SetWindowsHookEx(WH_CALLWNDPROCRET	 , @CallWndProcHook, 0, GetCurrentThreadId);

 CF_COMPONENTS := {QClipbrd.}{$IFDEF CLX}Clipboard.{$ENDIF}RegisterClipboardFormat(sCF_COMPONENTS);
 
finalization

 FreeAndNil(CrcList);

 FreeAndNil(GeneratedFiles);

//    UnHookWindowsHookEx(WHook);

end.


