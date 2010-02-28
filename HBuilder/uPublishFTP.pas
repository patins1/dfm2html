
unit uPublishFTP;

interface

uses
  SysUtils, Classes,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls,
  QMask, Qt, QTntStdCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, Dialogs,
  ShellAPI, Mask, ExtCtrls, StdCtrls, UnicodeCtrls,
{$ENDIF}
  {$IFDEF MSWINDOWS}OverbyteIcsUrl,{$ELSE}{IcsUrl,}{$ENDIF}unit3, dhPanel,MyMaskEdit,
  DKLang, dhLabel, MyPanel, dhStrUtils, MyForm;

type
  TPublishFTP = class(TTntForm)
    Button1: TTntButton;
    Button2: TTntButton;
    Panel1: TMyPanel;
    Label1: TdhLabel;
    Label2: TdhLabel;
    Label3: TdhLabel;
    eUser: TTntEdit;
    Label4: TdhLabel;
    eDir: TTntEdit;
    Label5: TdhLabel;
    ePort: TTntEdit;
    ePsw: TMyMaskEdit;
    Button3: TTntButton;
    eHost: TTntComboBox;
    Button4: TTntButton;
    bReset: TTntButton;
    DKLanguageController1: TDKLanguageController;
    Label8: TdhLabel;
    dhLabel1: TdhLabel;
    dhLabel3: TdhLabel;
    dhLabel2: TdhLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure eHostChange(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eUserChange(Sender: TObject);
  private
    { Private declarations }
    procedure Prepare(URL:TPathName);
    function URL_OK: boolean;
    function GetURL2(maskPassword:Boolean=false): TPathName;
    procedure UpdateAssembledURL;
  public
    { Public declarations }
    function GetURL(var URL:TPathName):boolean;
  end;

var
  PublishFTP: TPublishFTP;

implementation

uses Unit1;

{$R *.dfm}
               
{$IFDEF CLX}
const VK_ESCAPE=Key_Escape;
{$ENDIF}

procedure TPublishFTP.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=Char(VK_ESCAPE) then
 begin
  ModalResult:=mrCancel;
  Key:=#0;
 end;
end;

function PreS(pre:TPathName; s:TPathName):TPathName;
begin
 if s<>'' then
  result:=pre+s else
  result:='';
end;

function PostS(s:TPathName; post:TPathName):TPathName;
begin
 if s<>'' then
  result:=s+post else
  result:='';
end;

function ExtractHost(URL:TPathName):TPathName;
var Proto, Username, Password, Host, Port, Path : String;
begin
{$IFNDEF CLX}
 ParseURL(URL,Proto, Username, Password, Host, Port, Path);
{$ENDIF}
 Result:=Host;
end;

function GoodPath(URL:TPathName):TPathName;
begin
 result:=Trim(URL);
 while (result<>'') and (result[1]='/') do
  delete(result,1,1);
 while (result<>'') and (result[length(result)]='/') do
  delete(result,length(result),1);
 if result<>'' then
  result:=result+'/';
end;


function TPublishFTP.GetURL(var URL:TPathName): boolean;
var Host:TPathName;
    i:integer;
begin
 eHost.Clear;
 for i:=0 to dhMainForm.MDIChildCount-1 do
 with (dhMainForm.MDIChildren[i] as TPageContainer).MySiz do
 if (FindBody<>nil) and (FindBody.FTPURL<>'') then
 begin
  Host:=ExtractHost(FindBody.FTPURL);
  if eHost.Items.IndexOf(Host)=-1 then
   eHost.Items.AddObject(Host,Pointer(i));
 end;
 
 Prepare(URL);

 if ShowModal=mrOk then
 begin
  URL:=GetURL2;
  result:=true;
 end else
  result:=false;
end;




procedure TPublishFTP.Prepare(URL: TPathName);
var Proto, Username, Password, Host, Port, Path : String;
begin
{$IFNDEF CLX}
 ParseURL(URL,Proto, Username, Password, Host, Port, Path);
 eHost.Text:=Host;
 ePort.Text:=Port;
 eDir.Text:=GoodPath(Path);
 ePsw.Text:=Password;
 eUser.Text:=Username;
 UpdateAssembledURL;
{$ENDIF}
end;

procedure TPublishFTP.Button3Click(Sender: TObject);
var Value:string;
begin
 if (Sender=bReset) or InputQuery(Button3.Caption,'URL:',Value) then
 begin
  Prepare(Value);
 end;
end;

function CheckInt(const s:string):boolean;
begin
 try
  strtoint(s);
  result:=true;
 except
  result:=false;
 end;
end;


procedure TPublishFTP.Button1Click(Sender: TObject);
begin
 if URL_OK then
  ModalResult:=mrOk;
end;

function TPublishFTP.URL_OK:boolean;
begin
 if eHost.Text='' then
 begin
  {showmessage('"Host" must not be empty');
  result:=false;    }
  result:=true;
 end else
 if (ePort.Text<>'') and not CheckInt(ePort.Text) then
 begin
  showmessage('"Port" must be emtpy (the default port 21 will be used) or must be a port number between 0 and 65535');
  result:=false;
 end else
  result:=true;
end;

procedure TPublishFTP.eHostChange(Sender: TObject);
begin
 if eHost.ItemIndex<>-1 then
 begin
  with (dhMainForm.MDIChildren[Integer(eHost.Items.Objects[eHost.ItemIndex])] as TPageContainer).MySiz do
   Prepare(FindBody.FTPURL);
 end else
 begin
  UpdateAssembledURL;
 end;
end;

procedure TPublishFTP.UpdateAssembledURL;
begin
 if eHost.Text='' then
  dhLabel2.Text:='[host name required]' else
   if (ePort.Text<>'') and not CheckInt(ePort.Text) then
  dhLabel2.Text:='[invalid port number]' else
  dhLabel2.Text:='=> '+GetURL2(true);
end;

function maskPsw(const Psw:String; maskPassword:Boolean):String;
begin
 if maskPassword then
   Result:=StringOfChar('*',Length(Psw)) else
   Result:=Psw;
end;

function TPublishFTP.GetURL2(maskPassword:Boolean=false):TPathName;
begin
 if eHost.Text='' then
  result:='' else
  result:='ftp://'+PostS(eUser.Text+PreS(':',maskPsw(ePsw.Text,maskPassword)),'@')+eHost.Text+PreS(':',ePort.Text)+'/'+GoodPath(eDir.Text);
end;


procedure TPublishFTP.Button4Click(Sender: TObject);
begin
 if URL_OK then
  Browse(GetURL2,'',true);
end;

procedure TPublishFTP.FormCreate(Sender: TObject);
begin
 FixDialogBorderStyle(Self);
end;

procedure TPublishFTP.eUserChange(Sender: TObject);
begin
 UpdateAssembledURL;
end;

end.
