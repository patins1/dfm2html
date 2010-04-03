unit UIConstants;

interface
uses
  {$IFDEF CLX}
  QForms, QDialogs, Qt,
  {$ELSE}
  Dialogs,Windows,Forms,
  {$ENDIF}
  SysUtils,DKLang,dhLabel,dhPanel,dhStrUtils;

const CONFIRMDELETE='CONFIRMDELETE';
const COPYEXISTINGFILES='COPYEXISTINGFILES';
const DELETEINHERITEDERROR='DELETEINHERITEDERROR';
const DLG_CONFIRMATION='DLG_CONFIRMATION';
const DLG_ERROR='DLG_ERROR';
const DLG_INFORMATION='DLG_INFORMATION';
const DLG_WARNING='DLG_WARNING';
const DUPLICATEEFFECTS='DUPLICATEEFFECTS';
const EMPTYCLIPBOARD='EMPTYCLIPBOARD';
const EXTERNALIZEDIMAGEALREADYEXISTS='EXTERNALIZEDIMAGEALREADYEXISTS';
const FILEINFO_FILENAME='FILEINFO_FILENAME';
const FILEINFO_FILESIZE='FILEINFO_FILESIZE';
const FILEINFO_FLASH='FILEINFO_FLASH';
const FILEINFO_HOWTOLINK='FILEINFO_HOWTOLINK';
const FILEINFO_JAVASCRIPT='FILEINFO_JAVASCRIPT';
const FILEINFO_MUSIC='FILEINFO_MUSIC';
const FTPLOG_ABORTEDBYUSER='FTPLOG_ABORTEDBYUSER';
const FTPLOG_CONNECTINGTO='FTPLOG_CONNECTINGTO';
const FTPLOG_CREATEDDIR='FTPLOG_CREATEDDIR';
const FTPLOG_EMPTYSMARTUPLOAD='FTPLOG_EMPTYSMARTUPLOAD';
const FTPLOG_EMPTYUPLOAD='FTPLOG_EMPTYUPLOAD';
const FPTLOG_GENERATE='FPTLOG_GENERATE';
const FTPLOG_GENERATED='FTPLOG_GENERATED';
const FPTLOG_GENERATEFOR='FPTLOG_GENERATEFOR';
const FTPLOG_LOGGEDIN='FTPLOG_LOGGEDIN';
const FTPLOG_PSWDIALOG_PROMPT='FTPLOG_PSWDIALOG_PROMPT';
const FTPLOG_PSWDIALOG_TITLE='FTPLOG_PSWDIALOG_TITLE';
const FTPLOG_SAVING='FTPLOG_SAVING';
const FTPLOG_SUCCESS='FTPLOG_SUCCESS';
const FTPLOG_UPLOAD='FTPLOG_UPLOAD';
const INPUTHTTPURL='INPUTHTTPURL';                
const INVALIDMENUNESTING='INVALIDMENUNESTING';
const INVALIDPROPERTYVALUE='INVALIDPROPERTYVALUE';
const INVALIDVALUE='INVALIDVALUE';
const MODIFIEDSTATE='MODIFIEDSTATE';
const NEWVERSIONAVAILABLE='NEWVERSIONAVAILABLE';
const NONCRITICALERROR='NONCRITICALERROR'; //ungetestet
const NOIMAGETOEXTERNALIZE='NOIMAGETOEXTERNALIZE';
const PASTEERRORCOUNT='PASTEERRORCOUNT';
const QUOTEINVALIDVALUE='QUOTEINVALIDVALUE';
const READERRORCOUNT='READERRORCOUNT';
const READFROMERROR='READFROMERROR';
const REFOBJECT='REFOBJECT';
const RESOURCEEXPLORER_IMAGES='RESOURCEEXPLORER_IMAGES';
const RESOURCEEXPLORER_FILES='RESOURCEEXPLORER_FILES';
const RESOURCEEXPLORER_FONTS='RESOURCEEXPLORER_FONTS';
const SAVEASOPENED='SAVEASOPENED';
const SAVETO='SAVETO';
const SAVETOERROR='SAVETOERROR';
const SAVEUNTITLED='SAVEUNTITLED';        
const SEARCHFAILED='SEARCHFAILED';
const STILLUPTODATE='STILLUPTODATE';
const SYSTEMERROR='SYSTEMERROR';
const TEMPLATESAVEASCAPTION='TEMPLATESAVEASCAPTION';
const TEMPLATESAVEASPROMPT='TEMPLATESAVEASPROMPT';
const UNKNOWNOBJECT='UNKNOWNOBJECT';
const UNSUPPORTEDSTYLE='UNSUPPORTEDSTYLE';
const UNTITLED='UNTITLED';

function DKFormat(const c:string; const Args: array of const):WideString; overload;
function DKFormat(const c:string; const s:string):WideString; overload;
function DKFormat(const c:string):WideString; overload;
procedure ShowMessage(const Msg: WideString);

{$IFNDEF CLX}
function MessageDlg(const Msg: WideString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;   
{$ENDIF}

implementation

function DKFormat(const c:string; const Args: array of const):WideString; overload;
var cc:WideString;
begin
 result:=WFormat(DKLangConstW(c),Args);
end;

function DKFormat(const c:string; const s:string):WideString; overload;
begin
 result:=DKFormat(c,[s])
end;

function DKFormat(const c:string):WideString; overload;
begin
 result:=DKFormat(c,[])
end;

{$IFNDEF CLX}

function MessageDlg(const Msg: WideString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;
var Caption:WideString;
    uType: UINT;
begin
 uType:=0;

 case DlgType of
 mtConfirmation:
 begin
  Caption:=DKFormat(DLG_CONFIRMATION);
  uType:=MB_ICONQUESTION;
 end;
 mtInformation:
 begin
  Caption:=DKFormat(DLG_INFORMATION);
  uType:=MB_ICONINFORMATION;
 end;
 mtWarning:
 begin
  Caption:=DKFormat(DLG_WARNING);
  uType:=MB_ICONWARNING;
 end;
 mtError:
 begin
  Caption:=DKFormat(DLG_ERROR);
  uType:=MB_ICONERROR;
 end;
 else
 begin
  Caption:='DFM2HTML';
  uType:=0;
 end;
 end;

 if Buttons=[mbOk] then
  uType:=uType or MB_OK else
 if Buttons=[mbOk,mbCancel] then
  uType:=uType or MB_OKCANCEL else
 if Buttons=[mbAbort, mbRetry, mbIgnore] then
  uType:=uType or MB_ABORTRETRYIGNORE else
 if Buttons=[mbYes,mbNo,mbCancel] then
  uType:=uType or MB_YESNOCANCEL else
 if (Buttons=[mbYes,mbNo]) or (Buttons=[mbYes,mbCancel]) then
  uType:=uType or MB_YESNO else
 if Buttons=[mbRetry,mbCancel] then
  uType:=uType or MB_RETRYCANCEL;

 result:=MessageBoxW(Application.Handle,PWideChar(Msg),PWideChar(Caption),uType);
end;

{$ENDIF}
        
procedure ShowMessage(const Msg: WideString);
begin
  MessageDlg(Msg, mtCustom, [mbOk], 0);
end;

end.


