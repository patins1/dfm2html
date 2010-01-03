unit uWarnings;

interface

uses
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QClipbrd, Qt, QTntStdCtrls,
  QMask, QComCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, Dialogs,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, ComCtrls, UnicodeCtrls,
{$ENDIF}

  SysUtils, Classes, dhPanel, DKLang, MyForm;

type
  TFormWarnings = class(TMyForm)
    Memo1: TTntMemo;
    Button1: TTntButton;
    DKLanguageController1: TDKLanguageController;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    { Public declarations }
  end;

var
  FormWarnings: TFormWarnings;

implementation

{$R *.dfm}

procedure TFormWarnings.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TFormWarnings.Button2Click(Sender: TObject);
begin
 Clipboard.AsText:=Memo1.Text;
end;


{$IFDEF CLX}
const VK_ESCAPE=Key_Escape;
{$ENDIF}


procedure TFormWarnings.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=VK_ESCAPE then
  Close;
end;

procedure TFormWarnings.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Memo1.Lines.Clear;
end;          


end.
