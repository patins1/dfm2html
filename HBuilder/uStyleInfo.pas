unit uStyleInfo;

interface

uses             
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls, QTntStdCtrls,
  QMask, Qt,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, Dialogs,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, Spin, UnicodeCtrls,//FileCtrl,
{$ENDIF}
  SysUtils, Classes, dhPanel, DKLang;

type
  TStyleInfo = class(TTntForm)
    Memo: TTntMemo;
    DKLanguageController1: TDKLanguageController;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StyleInfo: TStyleInfo;

implementation

{$R *.dfm}

procedure TStyleInfo.FormKeyPress(Sender: TObject; var Key: Char);
begin     
 if Key=Char(VK_ESCAPE) then
 begin
  Close;//ModalResult:=mrCancel;
  Key:=#0;
 end;
end;

end.
