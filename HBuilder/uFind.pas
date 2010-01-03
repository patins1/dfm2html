unit uFind;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QMask, QForms, QButtons, QTntStdCtrls, QExtCtrls,
  {$ELSE}
  Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Mask, Forms, Buttons, Spin, ExtCtrls, UnicodeCtrls,
  {$ENDIF}
  SysUtils, Classes, DKLang, dhPanel, dhLabel;

type
  TFindText = class(TTntForm)
    Label1: TdhLabel;
    gKind: TTntRadioGroup;
    Button1: TTntButton;
    Button2: TTntButton;
    eFind: TTntComboBox;
    gOrigin: TTntRadioGroup;
    gDirection: TTntRadioGroup;
    GroupBox1: TTntGroupBox;
    cCaseSensitive: TTntCheckBox;
    cHidden: TTntCheckBox;
    DKLanguageController1: TDKLanguageController;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FindText: TFindText;

implementation

{$R *.dfm}

procedure TFindText.FormCreate(Sender: TObject);
begin   
 FixDialogBorderStyle(Self);
end;

procedure TFindText.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=Char(VK_ESCAPE) then
 begin
  ModalResult:=mrCancel;
  Key:=#0;
 end;

end;

end.
