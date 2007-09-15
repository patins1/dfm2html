unit uPublishLog;

interface

uses
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,QButtons,
  QMask, Qt, types, QTntStdCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, Dialogs,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, gifimage,Spin, Buttons, TntForms, TntStdCtrls, TntButtons,
{$ENDIF}
  UseFastStrings,SysUtils, Classes, {$IFDEF MSWINDOWS}FtpCli,HttpProt,{$ELSE}{IcsUrl,}{$ENDIF} dhPageControl,
  DKLang, UIConstants, MyForm;

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
{$IFNDEF CLX}
    FtpClient1: TFtpClient;
    procedure FtpClient1RequestDone(Sender: TObject; RqType: TFtpRequest;
      Error: Word);
{$ENDIF}
    procedure Log(Const Msg: WideString; Color: TColor=clBlack);
    procedure SetBusy(const Value: boolean);
  public
    { Public declarations }
    procedure DoUpload(URL:string);
    property Busy:boolean read FBusy write SetBusy;
  end;

var
  PublishLog: TPublishLog;

var GeneratedFiles:TStringList;

implementation

uses Unit1;

{$R *.dfm}

{ TPublishLog }

function DefaultS(const s,default:string):string;
begin
 if s<>EmptyStr then
  result:=s else
  result:=default;
end;



procedure TPublishLog.DoUpload(URL: string);
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
 dhMainForm.ViewHTML1Click(nil);
 Log(DKFormat(FTPLOG_GENERATED),clGreen);

 if GeneratedFiles.Count=0 then
 begin
  Log(DKFormat(FTPLOG_EMPTYUPLOAD));
  exit;
 end;

 ToUpload.Clear;
 for i:=0 to GeneratedFiles.Count-1 do
 if not FSmartPublishing or not dhMainForm.Act.MySiz.FindBody.Find(ExtractFileName(GeneratedFiles[i]),DWORD(GeneratedFiles.Objects[i]),false) then
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
 FtpClient1.Passive:=FPassiveFTP;
 FtpClient1.HostName:=Host;
 FtpClient1.Port:=DefaultS(Port,'21');
 FtpClient1.Username:=DefaultS(Username,'anonymous');
 FtpClient1.Password:=DefaultS(Password,'non@email.com');
 FtpClient1.HostDirName:=copy(Path,2,maxint);
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
{$ENDIF}
end;

procedure TPublishLog.FormDestroy(Sender: TObject);
begin
 FreeAndNil(ToUpload);
end;

{$IFNDEF CLX}
procedure TPublishLog.FtpClient1RequestDone(Sender: TObject;
  RqType: TFtpRequest; Error: Word);
var i:integer;
begin
 if (Error<>0) and (RqType<>ftpMkdAsync) then
 begin
  if (RqType=ftpCwdAsync) and (FtpClient1.HostFileName=EmptyStr) then
  begin
   FtpClient1.HostFileName:=Copy(FtpClient1.HostDirName,1,Pos('/',FtpClient1.HostDirName)-1);
   FtpClient1.MkdAsync;
   exit;
  end;      
  Log(FtpClient1.ErrorMessage,clRed);
  bStopTransfer.Click;
  exit;
 end;
 case RqType of
 ftpConnectAsync:
 begin
  Log(DKFormat(FTPLOG_LOGGEDIN),clGreen);
  if FtpClient1.HostDirName<>EmptyStr then
   FtpClient1.CwdAsync else
   FtpClient1.TypeBinaryAsync;
 end;
 ftpCwdAsync:
 begin
  FtpClient1.TypeBinaryAsync;
 end;
 ftpMkdAsync:
 begin
  i:=AdvPos('/',FtpClient1.HostDirName,Length(FtpClient1.HostFileName)+2);
  if i<>0 then
  begin
   FtpClient1.HostFileName:=Copy(FtpClient1.HostDirName,1,i-1);
   FtpClient1.MkdAsync;
   exit;
  end;
  Log(DKFormat(FTPLOG_CREATEDDIR,FtpClient1.HostFileName));
  FtpClient1.CwdAsync;
 end;
 else//ftpCwdAsync:
 begin
  if RqType=ftpPutAsync then
  begin
   if FSmartPublishing and (dhMainForm.Act<>nil) then
    dhMainForm.Act.MySiz.FindBody.Find(ExtractFileName(ToUpload[0]),DWORD(ToUpload.Objects[0]),true);
   ToUpload.Delete(0);
  end;

  if ToUpload.Count<>0 then
  begin
   Log(DKFormat(FTPLOG_UPLOAD,ExtractFileName(ToUpload[0])));
   FtpClient1.HostFileName:=ExtractFileName(ToUpload[0]);
   FtpClient1.LocalFileName:=ToUpload[0];
   FtpClient1.PutAsync;
  end else
  begin
   Log(DKFormat(FTPLOG_SUCCESS),clGreen);
   bStopTransfer.Click;
  end;
 end;
 end;
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


