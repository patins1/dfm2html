unit uShowInfo;

interface

uses
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls, Qt,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, Dialogs,
  ShellAPI, StdCtrls,
{$ENDIF}
  SysUtils, Classes, dhPanel;

type
  TShowInfo = class(TForm)
    Memo: TMemo;
    CancelButton: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CancelButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    pn:TdhCustomPanel;
  public
    { Public declarations }
    procedure LoadInfo(pn:TdhCustomPanel);
  end;

var
  ShowInfo: TShowInfo;

implementation

{$R *.dfm}

procedure TShowInfo.LoadInfo(pn:TdhCustomPanel);
begin
 Self.pn:=pn;
 Memo.Text:=pn.ActStyle.GetInfo;
// ActiveControl:=CancelButton;
end;


procedure TShowInfo.Button1Click(Sender: TObject);
var State:TState;
begin
 if pn.Use=nil then
 begin
  showmessage('The Use property is not assigned');
  exit;
 end;
 pn.TransferStylesToUse;
 {
 for State:=low(TState) to high(TState) do
 if (pn.StyleArr[State]<>nil) and (pn.Use.GetCommon.StyleArr[State]<>nil) then
 begin
  pn.Use.GetCommon.StyleArr[State].Assign(pn.StyleArr[State]);
  pn.StyleArr[State].Clear;
 end;
 pn.TransformUse(pn.Use); }
 LoadInfo(pn);
 showmessage('Operation successful!');
end;

           
procedure TShowInfo.Button3Click(Sender: TObject);
begin
 pn.ClearAllStyles(true);
 LoadInfo(pn);
 showmessage('Operation successful!');
end;

procedure TShowInfo.Button2Click(Sender: TObject);
var c:TStyle;
begin
 if (pn.StyleArr[hsDown]=nil) or (pn.StyleArr[hsOver]=nil) then exit;
 c:=TStyle.Create(nil,hsNormal);
 c.Assign(pn.StyleArr[hsDown]);
 pn.StyleArr[hsDown].Assign(pn.StyleArr[hsOver]);
 pn.StyleArr[hsOver].Assign(c);
 c.Free;
 LoadInfo(pn);       
 showmessage('Operation successful!');
end;

procedure TShowInfo.CancelButtonKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then CancelButton.Click;
end;

procedure TShowInfo.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin 
  if Key = VK_ESCAPE then CancelButton.Click;
end;

procedure TShowInfo.FormCreate(Sender: TObject);
begin
 FixDialogBorderStyle(Self);
end;

end.
