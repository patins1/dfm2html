unit uPageWizard;

interface

uses
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,QTntStdCtrls,
  QMask, Qt,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, Dialogs,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, Spin, FileCtrl, UnicodeCtrls,
{$ENDIF}
  SysUtils, Classes, htmlrout, MySpinEdit,
  dhPageControl, dhPanel, dhLabel, FuncUtils,UseFastStrings, MyPageControl, DKLang, MyForm,
  MyGroupBox, dhStrUtils, uMetaWriter, SynMemo, SynEdit, SynEditHighlighter,
  SynHighlighterPHP, SynHighlighterHtml;

type
  TPageWizard = class(TMyForm)
    PageControl1: TMyPageControl;
    TabSheet1: TTntTabSheet;
    TabSheet2: TTntTabSheet;
    Label1: TdhLabel;
    eAuthor: TTntEdit;
    Label2: TdhLabel;
    eKeywords: TTntEdit;
    Label3: TdhLabel;
    eDescription: TTntEdit;
    TabSheet3: TTntTabSheet;
    Label6: TdhLabel;
    eTitle: TTntEdit;
    Button1: TTntButton;
    CancelButton: TTntButton;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    Panel1: TPanel;
    Label7: TdhLabel;
    Label8: TdhLabel;
    Label9: TdhLabel;
    Label12: TdhLabel;
    eOutputDirectory: TTntEdit;
    eRemote: TTntEdit;
    Button2: TTntButton;
    Button32: TTntButton;
    Label15: TdhLabel;
    Label16: TdhLabel;
    eHTTPURL: TTntEdit;
    DKLanguageController1: TDKLanguageController;
    GroupBox1: TMyGroupBox;
    Label11: TdhLabel;
    Label10: TdhLabel;
    eForwardingDelay: TMySpinEdit;
    eForwardingURL: TTntEdit;
    PageControlHTML: TTntPageControl;
    TabSheetHTML1: TTntTabSheet;
    TabSheetHTML2: TTntTabSheet;
    TabSheetHTML3: TTntTabSheet;
    eHead: TSynMemo;
    eBody: TSynMemo;
    eTop: TSynMemo;
    TabSheet4: TTntTabSheet;
    dhLabel1: TdhLabel;
    eImageFolder: TTntEdit;
    dhLabel2: TdhLabel;
    eJavaScriptFile: TTntEdit;
    dhLabel3: TdhLabel;
    dhLabel4: TdhLabel;
    dhLabel5: TdhLabel;
    dhLabel6: TdhLabel;
    eCSSFile: TTntEdit;
    dhLabel7: TdhLabel;
    TabSheet5: TTabSheet;
    eBodyClose: TSynMemo;
    SynHTMLSyn1: TSynHTMLSyn;
    procedure eCSSFileChange(Sender: TObject);
    procedure eImageFolderChange(Sender: TObject);
    procedure eJavaScriptFileChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eBackgroundSoundForeverClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button32Click(Sender: TObject);
  private
    { Private declarations }
    FPublishURL: TPathName;
    page:TdhPage;
    procedure SetPublishURL(const Value: TPathName);
    property PublishURL:TPathName read FPublishURL write SetPublishURL;
  public
    { Public declarations }
    function Prepare(pages:TList):boolean;
    procedure FetchResult(page:TdhPage);
  end;

var
  PageWizard: TPageWizard;

implementation

uses uPublishFTP, Unit1;

{$R *.dfm}

{ TPageWizard }

function TPageWizard.Prepare(pages:TList):boolean;
var i:integer;
begin
 page:=TObject(pages[0]) as TdhPage;
 eTitle.Text:=page.Title;
 if page.IsTopScrollable then
 begin
  eOutputDirectory.Text:=page.OutputDirectory;        
  PublishURL:=page.FTPURL;
  eHTTPURL.Text:=page.HTTPURL;
 end;
 eAuthor.Text:=page.MetaAuthor;
 eDescription.Text:=page.MetaDescription;
 eKeywords.Text:=page.MetaKeywords;
 eHead.Text:=page.HTMLHead;
 eBody.Text:=page.HTMLBody;
 eBodyClose.Text:=page.HTMLBodyClose;
 eTop.Text:=page.HTMLTop;
 eForwardingDelay.Value:=page.ForwardingDelay;
 eForwardingURL.Text:=page.ForwardingURL;
 eImageFolder.Text:=page.GeneratedImageFolder;
 eJavaScriptFile.Text:=page.GeneratedJavaScriptFile;
 eCSSFile.Text:=page.GeneratedCSSFile;
 eJavaScriptFileChange(nil);
 eImageFolderChange(nil);
 eCSSFileChange(nil);

 {
 eBackgroundSoundURL.Text:=page.BackgroundSoundURL;
 eBackgroundSoundForever.Checked:=page.BackgroundSoundForever;
 eBackgroundSoundLoop.Value:=page.BackgroundSoundLoop;
  }

 Panel1.Visible:=page.IsTopScrollable;

 if ShowModal=mrOk then
 begin
  for i:=0 to pages.Count-1 do
   PageWizard.FetchResult(TObject(pages[i]) as TdhPage);
  result:=true;   
 end else
  result:=false;
end;

procedure TPageWizard.FetchResult(page:TdhPage);
begin
 page.Title:=eTitle.Text;
 if page.IsTopScrollable then
 begin
  page.OutputDirectory:=eOutputDirectory.Text;
  page.FTPURL:=PublishURL;
  page.HTTPURL:=eHTTPURL.Text;
 end;
 page.MetaAuthor:=eAuthor.Text;
 page.MetaDescription:=eDescription.Text;
 page.MetaKeywords:=eKeywords.Text;
 page.HTMLHead:=eHead.Text;
 page.HTMLBody:=eBody.Text;
 page.HTMLBodyClose:=eBodyClose.Text;
 page.HTMLTop:=eTop.Text;
 page.ForwardingDelay:=eForwardingDelay.Value;
 page.ForwardingURL:=eForwardingURL.Text;

 page.GeneratedImageFolder:=eImageFolder.Text;
 page.GeneratedJavaScriptFile:=eJavaScriptFile.Text;
 page.GeneratedCSSFile:=eCSSFile.Text;
 {
 page.BackgroundSoundURL:=eBackgroundSoundURL.Text;
 page.BackgroundSoundForever:=eBackgroundSoundForever.Checked;
 page.BackgroundSoundLoop:=eBackgroundSoundLoop.Value;
 }
end;

procedure TPageWizard.FormCreate(Sender: TObject);
begin
 PageControl1.ActivePageIndex:=0;  
end;

procedure TPageWizard.eBackgroundSoundForeverClick(Sender: TObject);
begin
 //eBackgroundSoundLoop.Enabled:=not eBackgroundSoundForever.Checked;
end;

procedure TPageWizard.eCSSFileChange(Sender: TObject);
begin
 dhLabel7.Text:='=> '+FinalGeneratedCSSFile(eCSSFile.Text);
end;

procedure TPageWizard.eImageFolderChange(Sender: TObject);
begin
 dhLabel4.Text:='=> '+FinalGeneratedImageFolder(FinalImageFolder(page.Parent)+CutCurrentDir(FinalGeneratedImageFolder(eImageFolder.Text)));
end;

procedure TPageWizard.eJavaScriptFileChange(Sender: TObject);
begin
 dhLabel5.Text:='=> '+FinalGeneratedJavaScriptFile(eJavaScriptFile.Text);
end;

procedure TPageWizard.Button3Click(Sender: TObject);
begin
 {
 if OpenDialog1.Execute then
 begin
  eBackgroundSoundURL.Text:=OpenDialog1.FileName;
 end;
 }
end;

procedure TPageWizard.Button2Click(Sender: TObject);
var URL:TPathName;
begin
 LateCreateForm(TPublishFTP,PublishFTP);
 URL:=PublishURL;
 if PublishFTP.GetURL(URL) then
 begin
  PublishURL:=URL;
 end;        
end;

{$IFDEF CLX}
const VK_ESCAPE=Key_Escape;
{$ENDIF}

procedure TPageWizard.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=Char(VK_ESCAPE) then
 begin
  ModalResult:=mrCancel;
  Key:=#0;
 end;
end;

procedure TPageWizard.SetPublishURL(const Value: TPathName);
var r:integer;
begin
  FPublishURL := Value;
  if SubSame('ftp://',FPublishURL) and bAdvPos(r,'@',FPublishURL) then
   eRemote.Text:='ftp://'+copy(FPublishURL,r+1,maxint) else
   eRemote.Text:=FPublishURL;
end;

procedure TPageWizard.Button32Click(Sender: TObject);
var Directory:{$IFDEF CLX}widestring{$ELSE}string{$ENDIF};
begin
 Directory:=ResolveRelativeURL(ExtractFilePath(Application.ExeName),eOutputDirectory.Text);
// if SelectDirectory(Directory,[sdAllowCreate],0) then
 if SelectDirectory('','',Directory) then
   eOutputDirectory.Text:=GoodLocalPath(Directory);
end;

                                                       
end.
