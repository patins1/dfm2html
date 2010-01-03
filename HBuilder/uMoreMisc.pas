unit uMoreMisc;

interface

uses
  SysUtils, Classes, types,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QStdCtrls, QExtCtrls, QComCtrls, QTntStdCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, ExtCtrls, StdCtrls, UnicodeCtrls,
{$ENDIF}
  dhPanel, dhLabel, dhMenu, dhStyleSheet, hComboBox, hEdit, DKLang;

type
  TMoreMisc = class(TTntForm,IhLogReceiver)
    Label16: TdhLabel;
    CODE_cbLineHeight: ThComboBox;
    Button1: TTntButton;
    Label33: TdhLabel;
    eBefore: ThEdit;
    Label28: TdhLabel;
    eAfter: ThEdit;
    Label32: TdhLabel;
    eOther: ThEdit;
    Label1: TdhLabel;
    cbVisibility: ThComboBox;
    bClearMore: TTntButton;
    Label2: TdhLabel;
    CODE_eHTMLAttributes: ThComboBox;
    DKLanguageController1: TDKLanguageController;
    cbDisplay: ThComboBox;
    dhLabel1: TdhLabel;
    dhLabel2: TdhLabel;
    CODE_cbLetterSpacing: ThComboBox;
    CODE_cbWordSpacing: ThComboBox;
    dhLabel3: TdhLabel;
    procedure CODE_cbWordSpacingValueChange(Sender: TObject; Clear: Boolean);
    procedure CODE_cbLetterSpacingValueChange(Sender: TObject; Clear: Boolean);
    procedure CODE_cbLineHeightValueChange(Sender: TObject; Clear: Boolean);
    procedure eBeforeValueChange(Sender: TObject; Clear: Boolean);
    procedure eAfterValueChange(Sender: TObject; Clear: Boolean);
    procedure eOtherValueChange(Sender: TObject; Clear: Boolean);
    procedure cbVisibilityValueChange(Sender: TObject; Clear: Boolean);
    procedure bClearMoreClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure CODE_eHTMLAttributesValueChange(Sender: TObject; Clear: Boolean);
    procedure cbDisplayValueChange(Sender: TObject; Clear: Boolean);
  private
    { Private declarations }
    procedure UpdateMoreDisplay;
    procedure LogChange(Sender:TObject; LogChange:TLogChange); 
    procedure SkipValue(Reader: TReader);      
  protected
    { Protected declarations }              
    procedure DefineProperties(Filer: TFiler); override;
  public
    { Public declarations }
    procedure Prepare;
  end;

var
  MoreMisc: TMoreMisc;

implementation

uses Unit1,Unit2;

{$R *.dfm}

procedure TMoreMisc.CODE_cbLetterSpacingValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 for i:=0 to Tabs.Selection.Count-1 do
  (TObject(Tabs.Selection[i]) as TdhCustomPanel).ActStyle.LetterSpacing:=WithoutPx(GoodValue(CODE_cbLetterSpacing.Text));
 UpdateMoreDisplay;
end;

procedure TMoreMisc.CODE_cbLineHeightValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 for i:=0 to Tabs.Selection.Count-1 do
  (TObject(Tabs.Selection[i]) as TdhCustomPanel).ActStyle.LineHeight:=WithoutPx(GoodValue(CODE_cbLineHeight.Text));
 UpdateMoreDisplay;
end;

procedure TMoreMisc.CODE_cbWordSpacingValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 for i:=0 to Tabs.Selection.Count-1 do
  (TObject(Tabs.Selection[i]) as TdhCustomPanel).ActStyle.WordSpacing:=WithoutPx(GoodValue(CODE_cbWordSpacing.Text));
 UpdateMoreDisplay;
end;

procedure TMoreMisc.UpdateMoreDisplay;
begin
 CODE_cbLetterSpacing.StoredText:=Tabs.ActStyle.LetterSpacing;   
 CODE_cbWordSpacing.StoredText:=Tabs.ActStyle.WordSpacing;
 CODE_cbLineHeight.StoredText:=Tabs.ActStyle.LineHeight;
 eBefore.StoredText:=Tabs.ActStyle.ContentBefore;
 eAfter.StoredText:=Tabs.ActStyle.ContentAfter;
 eOther.StoredText:=Tabs.ActStyle.Other;
 CODE_eHTMLAttributes.StoredText:=Tabs.ActPn.HTMLAttributes;
 cbVisibility.StoredItemIndex:=GoodIndex(Integer(Tabs.ActStyle.Visibility));
 cbDisplay.StoredItemIndex:=GoodIndex(Integer(Tabs.ActStyle.Display));
 Tabs.SetClearState(bClearMore,Tabs.IsMoreExtCleared);
 SetUnderlineState(Tabs.bMoreMisc,Tabs.IsMoreExtCleared);
end;

procedure TMoreMisc.Prepare;
begin
 UpdateMoreDisplay;
 Visible:=false;
end;

procedure TMoreMisc.LogChange(Sender: TObject; LogChange: TLogChange);
begin     
 Tabs.LogChange(Sender,LogChange);
end;

procedure TMoreMisc.eBeforeValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 for i:=0 to Tabs.Selection.Count-1 do
  (TObject(Tabs.Selection[i]) as TdhCustomPanel).ActStyle.ContentBefore:=eBefore.Text;
 UpdateMoreDisplay;
end;

procedure TMoreMisc.eAfterValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 for i:=0 to Tabs.Selection.Count-1 do
  (TObject(Tabs.Selection[i]) as TdhCustomPanel).ActStyle.ContentAfter:=eAfter.Text;
 UpdateMoreDisplay;
end;

procedure TMoreMisc.eOtherValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 for i:=0 to Tabs.Selection.Count-1 do
  (TObject(Tabs.Selection[i]) as TdhCustomPanel).ActStyle.Other:=eOther.Text;
 UpdateMoreDisplay;
end;

procedure TMoreMisc.cbVisibilityValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 cbVisibility.ItemIndex:=GoodIndex(cbVisibility.ItemIndex);
 for i:=0 to Tabs.Selection.Count-1 do
  (TObject(Tabs.Selection[i]) as TdhCustomPanel).ActStyle.Visibility:=TCSSVisibility(GoodIndexBack(cbVisibility.ItemIndex));
 UpdateMoreDisplay;
end;



procedure TMoreMisc.bClearMoreClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Tabs.Selection.Count-1 do
 with (TObject(Tabs.Selection[i]) as TdhCustomPanel) do
 with ActStyle do
 begin
  LetterSpacing:='';
  WordSpacing:='';
  LineHeight:='';
  Visibility:=Low(TCSSVisibility);
  Display:=Low(TCSSDisplay);
  ContentBefore:='';
  ContentAfter:='';
  Other:='';
  HTMLAttributes:='';
 end;
 Tabs.Changed('Reset Misc');
 UpdateMoreDisplay;
end;

procedure TMoreMisc.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose:=Tabs.CommitChanges;
end;

procedure TMoreMisc.FormCreate(Sender: TObject);
begin                 
 FixDialogBorderStyle(Self);
end;

procedure TMoreMisc.CODE_eHTMLAttributesValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 for i:=0 to Tabs.Selection.Count-1 do
  (TObject(Tabs.Selection[i]) as TdhCustomPanel).HTMLAttributes:=CODE_eHTMLAttributes.Text;
 UpdateMoreDisplay;
end;

procedure TMoreMisc.cbDisplayValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 cbDisplay.ItemIndex:=GoodIndex(cbDisplay.ItemIndex);
 for i:=0 to Tabs.Selection.Count-1 do
  (TObject(Tabs.Selection[i]) as TdhCustomPanel).ActStyle.Display:=TCSSDisplay(GoodIndexBack(cbDisplay.ItemIndex));
 UpdateMoreDisplay;
end;

procedure TMoreMisc.DefineProperties(Filer: TFiler);
begin
 inherited;
 Filer.DefineProperty('DesignSize', SkipValue, nil, false);
end;                 

procedure TMoreMisc.SkipValue(Reader: TReader);
begin
 _SkipValue(Reader);
end;


end.
