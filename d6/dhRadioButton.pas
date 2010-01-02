unit dhRadioButton;

interface

uses
  SysUtils, Classes, dhPanel, dhLabel,dhCheckBox, dhStrUtils;

type
  TdhRadioButton = class(TdhCheckBox)
  private
  protected
    { Protected declarations }
    procedure SetChecked(const Value: boolean); override;
    procedure GetModifiedText(var pre,s,suc:HypeString); override;
  public
    { Public declarations }
    procedure Click; override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhRadioButton]);
end;

{ TdhRadioButton }

procedure TdhRadioButton.Click;
begin
  Checked:=true;
end;

procedure TdhRadioButton.GetModifiedText(var pre,s,suc: HypeString);
begin
  if Alignment=taRightJustify then
  if Checked then
   pre:='<radiobuttondown/>' else
   pre:='<radiobuttonnormal/>' else
  if Checked then
   suc:='<radiobuttondown/>' else
   suc:='<radiobuttonnormal/>';
end;

procedure TdhRadioButton.SetChecked(const Value: boolean);
var i:integer;
begin
  inherited;
  if csLoading in ComponentState then exit;

  if Checked then
  for i:=0 to Parent.ControlCount-1 do
  if (Parent.Controls[i] is TdhRadioButton) and TdhRadioButton(Parent.Controls[i]).Checked and (Parent.Controls[i]<>Self) then
   TdhRadioButton(Parent.Controls[i]).Checked:=False;
end;

end.
