{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is DFM2HTML

The Initial Developer of the Original Code is Joerg Kiegeland

You may retrieve the latest version of this file at the DFM2HTML home page,
located at http://www.dfm2html.com

-------------------------------------------------------------------------------}

unit dhRadioButton;

interface

uses
  SysUtils, Classes, dhPanel, dhLabel,dhCheckBox, dhStrUtils;

type
  TdhRadioButton = class(TdhCheckBox)
  private
  protected
    procedure SetChecked(const Value: boolean); override;
    procedure GetModifiedText(var pre,s,suc:HypeString); override;
  public
    procedure Click; override;
  published
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhRadioButton]);
end;

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
