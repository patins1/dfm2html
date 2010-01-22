unit uOptions;

interface

uses       
  SysUtils, Classes, types,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QMask,QComCtrls,QTntStdCtrls, 
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, Dialogs, StdCtrls, ComCtrls,
  ShellAPI, Mask, ExtCtrls,  clipbrd, Spin, UnicodeCtrls,
{$ENDIF}
  dhPanel, dhLabel, dhPageControl, MySpinEdit, MyPageControl, dhStyleSheet, DKLang, dhStrUtils;

            
type TLaunchAction=(suaChoice,suaLast,suaNone);
type TFuncSettings=object
     DefaultFont:TFont;
     LRUfiles:TStringList;
     Compress:boolean;
     LaunchAction:TLaunchAction;
     FViewer:TPathName;
     FSmartPublishing:boolean;
     FPassiveFTP:boolean;
     FAutoUpdate:boolean;
end;

type
  TOptions = class(TTntForm)
    PageControl11: TMyPageControl;
    TabSheet1: TTntTabSheet;
    TabSheet2: TTntTabSheet;
    Button1: TTntButton;
    spGridX: TMySpinEdit;
    Label1: TdhLabel;
    Label2: TdhLabel;
    spGridY: TMySpinEdit;
    cbGridDisplay: TTntComboBox;
    Label3: TdhLabel;
    Button2: TTntButton;
    FontDialog1: TFontDialog;
    TabSheet3: TTntTabSheet;
    cCompress: TTntCheckBox;
    Label4: TdhLabel;
    Label5: TdhLabel;
    Label6: TdhLabel;
    Label7: TdhLabel;
    Button3: TTntButton;
    OpenDialog1: TOpenDialog;
    bApplyFont: TTntButton;
    TabSheet4: TTntTabSheet;
    cSmartPublishing: TTntCheckBox;
    Label8: TdhLabel;
    cPassiveFTP: TTntCheckBox;
    Label9: TdhLabel;
    TabSheet5: TTntTabSheet;
    RadioGroup1: TTntRadioGroup;
    eViewer: TTntComboBox;
    cClearCache: TTntButton;
    bClearFocusedCache: TTntButton;
    dhLabel1: TdhLabel;
    dhStyleSheet1: TdhStyleSheet;
    STYLE_Label10: TdhLabel;
    dhLabel2: TdhLabel;
    DKLanguageController1: TDKLanguageController;
    lDirectoryCache: TdhLabel;
    TabSheet6: TTntTabSheet;
    cAutoUpdate: TTntCheckBox;
    gStartUpAction: TTntRadioGroup;
    cCSS3: TTntCheckBox;
    lCSS3Warning: TdhLabel;
    procedure cCSS3Click(Sender: TObject);
    procedure spGridXChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure bApplyFontClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure spGridXValueChange(Sender: TObject; Clear: Boolean);
    procedure eViewerChange(Sender: TObject);
    procedure cSmartPublishingClick(Sender: TObject);
    procedure cClearCacheClick(Sender: TObject);
    procedure bClearFocusedCacheClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadSettings(var FuncSettings:TFuncSettings);
    procedure SaveSettings(var FuncSettings:TFuncSettings);
    constructor Create(Aowner:TComponent); override;
  end;

var
  Options: TOptions;

implementation

uses Unit1, Unit2, uPublishLog;

{$R *.dfm}

var Adjusting:boolean=true;

constructor TOptions.Create(Aowner: TComponent);
begin
  inherited;
  PageControl11.ActivePageIndex:=0;
end;

procedure TOptions.LoadSettings(var FuncSettings: TFuncSettings);
begin
 Adjusting:=true;
 With FuncSettings do with GridDefinition do
 begin
  spGridX.StoredValue:=GridX;
  spGridY.StoredValue:=GridY;
  cbGridDisplay.ItemIndex:=Integer(GridDisplay);
  cCompress.Checked:=Compress;
  cCSS3.Checked:=UseCSS3;
  eViewer.Text:=FViewer;
  cSmartPublishing.Checked:=FSmartPublishing;
  cPassiveFTP.Checked:=FPassiveFTP;
  case PropsAlign of
  alTop: RadioGroup1.ItemIndex:=0;
  alBottom: RadioGroup1.ItemIndex:=1;
  alLeft: RadioGroup1.ItemIndex:=2;
  alRight: RadioGroup1.ItemIndex:=3;
  alNone: RadioGroup1.ItemIndex:=4;
  alClient: RadioGroup1.ItemIndex:=5;
  end;
  case LaunchAction of
  suaChoice: gStartUpAction.ItemIndex:=0;
  suaLast: gStartUpAction.ItemIndex:=1;
  suaNone: gStartUpAction.ItemIndex:=2;
  end;
  bApplyFont.Enabled:=dhMainForm.Act<>nil;
  cClearCache.Enabled:=Length(Uploaded)<>0;
  bClearFocusedCache.Enabled:=false;
  if (dhMainForm.Act<>nil) and (dhMainForm.Act.MySiz.FindBody<>nil) then
  begin
   lDirectoryCache.Text:=GetFTPShortcut(dhMainForm.Act.MySiz.FindBody);
   bClearFocusedCache.Enabled:=Find(GetFTPShortcut(dhMainForm.Act.MySiz.FindBody),'*',0,false);
  end else
   lDirectoryCache.Text:='';
  cAutoUpdate.Checked:=FAutoUpdate;
 end;
 Adjusting:=false;
end;

procedure TOptions.SaveSettings(var FuncSettings: TFuncSettings);
begin
 With FuncSettings do with GridDefinition do
 begin
  GridX:=spGridX.Value;
  GridY:=spGridY.Value;
  GridDisplay:=TGridDisplay(cbGridDisplay.ItemIndex);
  Compress:=cCompress.Checked;
  UseCSS3:=cCSS3.Checked;
  FViewer:=eViewer.Text;
  FSmartPublishing:=cSmartPublishing.Checked;
  FPassiveFTP:=cPassiveFTP.Checked;
  case RadioGroup1.ItemIndex of
  0: PropsAlign:=alTop;
  1: PropsAlign:=alBottom;
  2: PropsAlign:=alLeft;
  3: PropsAlign:=alRight;
  4: PropsAlign:=alNone;
  5: PropsAlign:=alClient;
  end;
  case gStartUpAction.ItemIndex of
  0: LaunchAction:=suaChoice;
  1: LaunchAction:=suaLast;
  2: LaunchAction:=suaNone;
  end;
  if not FSmartPublishing then
   SetLength(Uploaded,0);
  FAutoUpdate:=cAutoUpdate.Checked;
 end;

end;

procedure TOptions.spGridXChange(Sender: TObject);
begin
 if Adjusting then exit;
 SaveSettings(FuncSettings);
 dhMainForm.ApplyNewSettings(false,false);
end;

procedure TOptions.Button2Click(Sender: TObject);
begin
 FontDialog1.Font.Assign(FuncSettings.DefaultFont);
 FontDialog1.Font.Color:=clBlack;
 if FontDialog1.Execute then
 begin
  FuncSettings.DefaultFont.Size:=FontDialog1.Font.Size;
  FuncSettings.DefaultFont.Name:=FontDialog1.Font.Name;
  FuncSettings.DefaultFont.Charset:=FontDialog1.Font.Charset;
  //FuncSettings.DefaultFont.Style:=FontDialog1.Font.Style;
  eViewerChange(nil);
 end;
end;

procedure TOptions.Button3Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
  eViewer.Text:=OpenDialog1.FileName;
end;

procedure TOptions.bApplyFontClick(Sender: TObject);
begin
 dhMainForm.ApplyNewSettings(true,false);
end;

procedure TOptions.FormKeyPress(Sender: TObject; var Key: Char);
begin         
 if Key=Char(VK_ESCAPE) then
 begin
  ModalResult:=mrCancel;
  Key:=#0;
 end;
end;

procedure TOptions.FormCreate(Sender: TObject);
begin
{$IFNDEF CLX}
 FontDialog1.Options:=[fdTrueTypeOnly];
{$ENDIF}
 FixDialogBorderStyle(Self);
end;

procedure TOptions.RadioGroup1Click(Sender: TObject);
begin
 if Adjusting then exit;
 SaveSettings(FuncSettings);
 UpdateAlign;
end;

procedure TOptions.spGridXValueChange(Sender: TObject; Clear: Boolean);
begin
 spGridXChange(nil);
end;

procedure TOptions.eViewerChange(Sender: TObject);
begin
 if Adjusting then exit;
 SaveSettings(FuncSettings);
 //dont need dhMainForm.ApplyNewSettings
end;

procedure TOptions.cSmartPublishingClick(Sender: TObject);
begin
 if Adjusting then exit;
 SaveSettings(FuncSettings);
 LoadSettings(FuncSettings);
end;

procedure TOptions.cClearCacheClick(Sender: TObject);
begin
 SetLength(Uploaded,0);
 cSmartPublishingClick(nil);
end;

procedure TOptions.cCSS3Click(Sender: TObject);
begin
  eViewerChange(Sender);
  lCSS3Warning.Visible:=UseCSS3;
end;

procedure TOptions.bClearFocusedCacheClick(Sender: TObject);
begin
 Find(GetFTPShortcut(dhMainForm.Act.MySiz.FindBody),'*',0,true);
 cSmartPublishingClick(nil);
end;

initialization

 FuncSettings.DefaultFont:=TFont.Create;
{$IFDEF CLX}
 FuncSettings.DefaultFont.Weight:=fwNormal; //damit TForm.Font.IsWeightStored immer false liefert
{$ENDIF}
 FuncSettings.DefaultFont.Color:=clBlack;
 FuncSettings.LRUfiles:=TStringList.Create;
 FuncSettings.LRUfiles.Duplicates:=dupIgnore;

finalization

 FreeAndNil(FuncSettings.DefaultFont);
 FreeAndNil(FuncSettings.LRUfiles);

end.
