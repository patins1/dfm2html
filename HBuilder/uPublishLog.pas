unit uPublishLog;

interface

uses
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,QButtons,
  QMask, Qt, types, QTntStdCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, Dialogs,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, Spin, Buttons, UnicodeCtrls,
{$ENDIF}
  UseFastStrings,SysUtils, Classes, {$IFDEF MSWINDOWS}OverbyteIcsFtpCli,OverbyteIcsUrl,{$ELSE}{IcsUrl,}{$ENDIF} dhPageControl,
  DKLang, UIConstants, MyForm,dhStrUtils, uOptions, uMetaWriter;

type
  TPublishLog = class(TMyForm)
    RichEdit1: TTntMemo;
    bStopTransfer: TTntSpeedButton;
    DKLanguageController1: TDKLanguageController;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bStopTransferClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ToUpload:TStringList;
    FBusy: boolean;
    RootHostDirName,RasteringSaveDir:TPathName;
{$IFNDEF CLX}
    FtpClient1: TFtpClient;
    procedure FtpClient1RequestDone(Sender: TObject; RqType: TFtpRequest;
      Error: Word);
    procedure FtpClient1OnDisplay(Sender: TObject; var Msg: String);
{$ENDIF}
    procedure Log(Const Msg: WideString; Color: TColor=clBlack);
    procedure SetBusy(const Value: boolean);     
    function ExtractHostDirName(const path:TPathName):TPathName;
  public
    { Public declarations }
    procedure DoUpload(const URL: TPathName);
    property Busy:boolean read FBusy write SetBusy;
  end;

var
  PublishLog: TPublishLog;

var GeneratedFiles:TStringList;
function GetFTPShortcut(page:TdhPage):TPathName;
function Find(FTP,FileName:TPathName; CRC:DWORD; AddOrReplace:boolean):boolean;
var Uploaded:array of record FTP:TPathName; Files:array of record FileName:TPathName; CRC:DWORD; end; end;

implementation

uses Unit1;

{$R *.dfm}

{ TPublishLog }

function DefaultS(const s,default:TPathName):TPathName;
begin
 if s<>EmptyStr then
  result:=s else
  result:=default;
end;

function ExtractWebFilePath(const FileName: TPathName): TPathName;
var
  I: Integer;
begin
  I := LastDelimiter('/', FileName);
  Result := Copy(FileName, 1, I);
end;

function TPublishLog.ExtractHostDirName(const path:TPathName):TPathName;
begin
 result:=RootHostDirName+Copy(path,Length(RasteringSaveDir)+1,MaxInt);
 result:=GoodWebPathDelimiters(result);
 result:=ExtractWebFilePath(result);
end;


function GetFTPShortcut(page:TdhPage):TPathName;
var Proto, Username, Password, Host, Port, Path : String;
begin
{$IFNDEF CLX}
 ParseURL(page.FTPURL,Proto, Username, Password, Host, Port, Path);
{$ENDIF}
 result:=Lowercase(Host)+Path;
end;

function Find(FTP,FileName:TPathName; CRC:DWORD; AddOrReplace:boolean):boolean;
var
    i,w:integer;
begin
 result:=false;
 for i:=Low(Uploaded) to High(Uploaded) do
 if Uploaded[i].FTP=FTP then
 with Uploaded[i] do
 begin
  for w:=Low(Files) to High(Files) do
  if Files[w].FileName=FileName then
  begin
   if AddOrReplace then
   begin
    Files[w].CRC:=CRC;
    exit;
   end else
   begin
    result:=Files[w].CRC=CRC;
    exit;
   end;
  end;
  if AddOrReplace then
  begin
   if FileName='*' then
   begin
    SetLength(Files,0);
   end else
   begin
    SetLength(Files,Length(Files)+1);
    Files[High(Files)].FileName:=FileName;
    Files[High(Files)].CRC:=CRC;
   end;
   exit;
  end else
  begin
   result:=(FileName='*') and (Length(Files)<>0);
   exit;
  end;
 end;
 if AddOrReplace then
 begin
  SetLength(Uploaded,Length(Uploaded)+1);
  Uploaded[High(Uploaded)].FTP:=FTP;
  with Uploaded[High(Uploaded)] do
  begin
   SetLength(Files,Length(Files)+1);
   Files[High(Files)].FileName:=FileName;
   Files[High(Files)].CRC:=CRC;
  end;
  exit;
 end else
 begin
  result:=false;
  exit;
 end;
end;

procedure TPublishLog.DoUpload(const URL: TPathName);
var Proto, Username, Password, Host, Port, Path : String;
    i:integer;
begin
 if RichEdit1.Lines.Count<>0 then
  RichEdit1.Lines.Add(EmptyStr);

 Show;

 if not dhMainForm.Act.IsUntitled then
  Log(DKFormat(FPTLOG_GENERATEFOR,ExtractFileName(dhMainForm.Act.FileName))) else
  Log(DKFormat(FPTLOG_GENERATE));

 Update;
 RasteringSaveDir:=dhMainForm.GeneratedHTML(False);
 Log(DKFormat(FTPLOG_GENERATED),clGreen);

 if GeneratedFiles.Count=0 then
 begin
  Log(DKFormat(FTPLOG_EMPTYUPLOAD));
  exit;
 end;

 ToUpload.Clear;
 for i:=0 to GeneratedFiles.Count-1 do
 if not FuncSettings.FSmartPublishing or not Find(GetFTPShortcut(dhMainForm.Act.MySiz.FindBody),ExtractFileName(GeneratedFiles[i]),DWORD(GeneratedFiles.Objects[i]),false) then
   ToUpload.AddObject(GeneratedFiles[i],GeneratedFiles.Objects[i]);

 if GeneratedFiles.Count>ToUpload.Count then
 begin 
  Log(DKFormat(FTPLOG_SAVING,[IntToStr(GeneratedFiles.Count-ToUpload.Count),IntToStr(GeneratedFiles.Count)]));
 end;
 if ToUpload.Count=0 then
 begin                                 
  Log(DKFormat(FTPLOG_EMPTYSMARTUPLOAD));
  exit;
 end;

 Busy:=true;
 bStopTransfer.Visible:=True;
 //Self.ToUpload.Assign(GeneratedFiles);

{$IFDEF CLX}
 Log('FTP not available in Linux version yet, sorry.');
 bStopTransfer.Click;
{$ELSE}
 ParseURL(URL,Proto, Username, Password, Host, Port, Path);
 FtpClient1.Passive:=FuncSettings.FPassiveFTP;
 FtpClient1.HostName:=Host;
 FtpClient1.Port:=DefaultS(Port,'21');
 FtpClient1.Username:=DefaultS(Username,'anonymous');
 FtpClient1.Password:=DefaultS(Password,'non@email.com');
 RootHostDirName:=Copy(Path,2,MaxInt);
 FtpClient1.HostDirName:=EmptyStr;
 FtpClient1.HostFileName:=EmptyStr;
 FtpClient1.ConnectAsync;
 Log(DKFormat(FTPLOG_CONNECTINGTO,Host));
{$ENDIF}
end;


procedure TPublishLog.Log(Const Msg: WideString; Color:TColor);
begin
{ RichEdit1.SelStart:=maxint;
 RichEdit1.SelAttributes.Color:=Color;
 RichEdit1.SelText:=Msg+#13#10;
 RichEdit1.Perform(EM_ScrollCaret, 0, 0);}
 RichEdit1.Lines.Add(Msg);
end;


procedure TPublishLog.FormCreate(Sender: TObject);
begin
 ToUpload:=TStringList.Create;
 RichEdit1.Anchors:=[akLeft,akTop,akRight,akBottom];
 bStopTransfer.Anchors:=[akRight,akBottom];
{$IFNDEF CLX}
 FtpClient1:= TFtpClient.Create(Self);
 FtpClient1.OnRequestDone := FtpClient1RequestDone;
 FtpClient1.OnDisplay := FtpClient1OnDisplay;
{$ENDIF}
end;

procedure TPublishLog.FormDestroy(Sender: TObject);
begin
 FreeAndNil(ToUpload);
end;

{$IFNDEF CLX}

procedure TPublishLog.FtpClient1OnDisplay(Sender: TObject; var Msg: String);
begin
  Log('        '+Msg,clRed);
end;

procedure TPublishLog.FtpClient1RequestDone(Sender: TObject;
  RqType: TFtpRequest; Error: Word);
var i:integer;
    HostDirName:TPathName;
begin
 if (Error<>0) and (RqType<>ftpMkdAsync) then
 begin
  if (RqType=ftpCwdAsync) and not (Copy(FtpClient1.HostDirName,1,3)='../') then
  begin
   FtpClient1.HostFileName:=Copy(FtpClient1.HostDirName,1,AdvPos('/',FtpClient1.HostDirName,2)-1);
   if FtpClient1.HostFileName<>'' then
   begin
    FtpClient1.MkdAsync;
    Exit;
   end;
  end;
  Log(FtpClient1.ErrorMessage,clRed);
  bStopTransfer.Click;
  Exit;
 end;

 case RqType of
 ftpConnectAsync:
 begin
  Log(DKFormat(FTPLOG_LOGGEDIN),clGreen);
 end;
 ftpMkdAsync:
 begin
  if Error=0 then
   Log(DKFormat(FTPLOG_CREATEDDIR,FtpClient1.HostFileName));
  i:=AdvPos('/',FtpClient1.HostDirName,Length(FtpClient1.HostFileName)+2);
  if i<>0 then
  begin
   FtpClient1.HostFileName:=Copy(FtpClient1.HostDirName,1,i-1);
   FtpClient1.MkdAsync;
   Exit;
  end;
  if Error<>0 then
  begin
   Log(FtpClient1.ErrorMessage,clRed);
   bStopTransfer.Click;
   Exit;
  end;
  FtpClient1.CwdAsync;
  Exit;
 end;
 ftpPutAsync:
 begin
  if FuncSettings.FSmartPublishing and (dhMainForm.Act<>nil) then
   Find(GetFTPShortcut(dhMainForm.Act.MySiz.FindBody),ExtractFileName(ToUpload[0]),DWORD(ToUpload.Objects[0]),true);
  ToUpload.Delete(0);
 end;
 end;

  if ToUpload.Count<>0 then
  begin
   HostDirName:=ExtractHostDirName(ToUpload[0]);
   if Copy(FtpClient1.HostDirName,1,3)='../' then
    FtpClient1.HostDirName:='';
   if FtpClient1.HostDirName<>HostDirName then
   begin
    if FtpClient1.Binary then
    begin
     FtpClient1.TypeAsciiAsync;
     Exit;
    end;
    if FtpClient1.HostDirName<>'' then
    begin
     HostDirName:='';
     for i := 1 to Length(FtpClient1.HostDirName) do
      if FtpClient1.HostDirName[i]='/' then
       HostDirName:=HostDirName+'../';
    end;
    FtpClient1.HostDirName:=HostDirName;
    FtpClient1.CwdAsync;
    Exit;
   end;
   if not FtpClient1.Binary then
   begin
    FtpClient1.TypeBinaryAsync;
    Exit;
   end;
   FtpClient1.HostFileName:=ExtractFileName(ToUpload[0]);
   FtpClient1.LocalFileName:=ToUpload[0];
   Log(DKFormat(FTPLOG_UPLOAD,HostDirName+FtpClient1.HostFileName));
   FtpClient1.PutAsync;
   Exit;
  end;

  Log(DKFormat(FTPLOG_SUCCESS),clGreen);
  bStopTransfer.Click;

end;
{$ENDIF}

procedure TPublishLog.bStopTransferClick(Sender: TObject);
begin
 if FBusy then
 begin        
{$IFNDEF CLX}
  FtpClient1.AbortAsync;
{$ENDIF}
  Busy:=false;
 end else
 begin
  //Busy:=true;
 end;
end;

procedure TPublishLog.SetBusy(const Value: boolean);
begin
  FBusy := Value;
  bStopTransfer.Visible:=FBusy;
  {if FBusy then
   bStopTransfer.Caption:='Stop!' else
   bStopTransfer.Caption:='Publish';}
end;

{$IFDEF CLX}
const VK_ESCAPE=Key_Escape;
{$ENDIF}


procedure TPublishLog.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=Char(VK_ESCAPE) then
 begin
  Close;
  Key:=#0;
 end;
end;

end.


