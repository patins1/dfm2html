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

unit dhHTMLForm;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QMask,
  {$ELSE}
  Controls, Windows, Messages, Graphics, StdCtrls, Mask,
  {$ENDIF}
  SysUtils, Classes, dhPanel, dhStyleSheet,dhSelect,
  dhMemo,dhEdit,dhCheckBox,dhRadioButton,dhMenu,dhLabel,dhHiddenField,dhFileField,dhStrUtils;

type
  TFormMethod=(fmtGet,fmtPost);
  TdhHTMLForm = class(TdhPanel)
  private
    FTarget: TPathName;
    procedure SetTarget(const Value: TPathName);
  protected
    FAction:TPathName;
    FMethod:TFormMethod;
  public
    procedure Submit(link:TdhLink);
    procedure Reset;
    function AllHTMLCode:HypeString; override;
    class procedure ResetFields(c:TWinControl);
    class procedure MemorizeFields(c:TWinControl);
  published
    property Action:TPathName read FAction write FAction;
    property Method:TFormMethod read FMethod write FMethod default fmtGet;
    property Target:TPathName read FTarget write SetTarget;
  end;

implementation

uses BasicHTMLElements;

function GoodForm(const s:WideString):WideString;
var i:integer;
begin
 result:='';
 for i:=1 to length(s) do
 if (s[i] in ['"','<','>','%','\','^','[',']','`','+','$',','   ,';','/','?',':','@','=','&','#']) or (ord(s[i])<=31) or (ord(s[i])>=127) then
  result:=result+'%'+inttohex(ord(s[i]),2) else
  result:=result+s[i];
end;

class procedure TdhHTMLForm.ResetFields(c:TWinControl);
var i:integer;
begin
 if c is TdhMemo then
  TdhMemo(c).Reset else
 if c is TdhEdit then
  TdhEdit(c).Reset else
 if c is TdhCheckBox then
  TdhCheckBox(c).Reset else
 if c is TdhRadioButton then
  TdhRadioButton(c).Reset else
 if c is TdhFileField then
  TdhFileField(c).Reset else
 if c is TdhSelect then
  TdhSelect(c).Reset;
 for i:=0 to c.ControlCount-1 do
 if (c.Controls[i] is TWinControl) and not (c.Controls[i] is TdhStyleSheet) then
  ResetFields(TWinControl(c.Controls[i]));
end;

class procedure TdhHTMLForm.MemorizeFields(c:TWinControl);
var i:integer;
begin
 if c is TdhMemo then
  TdhMemo(c).Memorize else
 if c is TdhEdit then
  TdhEdit(c).Memorize else
 if c is TdhCheckBox then
  TdhCheckBox(c).Memorize else
 if c is TdhRadioButton then
  TdhRadioButton(c).Memorize else
 if c is TdhFileField then
  TdhFileField(c).Memorize else
 if c is TdhSelect then
  TdhSelect(c).Memorize;
 for i:=0 to c.ControlCount-1 do
 if (c.Controls[i] is TWinControl) and not (c.Controls[i] is TdhStyleSheet) then
  MemorizeFields(TWinControl(c.Controls[i]));
end;

procedure TdhHTMLForm.Reset;
begin
 ResetFields(Self);
end;

function TdhHTMLForm.AllHTMLCode:HypeString;
begin
 result:=FAction;
end;

procedure TdhHTMLForm.SetTarget(const Value: TPathName);
begin
  FTarget := Value;
end;

procedure TdhHTMLForm.Submit(link:TdhLink);
var get:TPathName;

procedure CollectFields(c:TWinControl; var res:TPathName);
var i:integer;

procedure AddField(const Val:WideString);
begin
 res:=res+GoodForm(c.Name)+'='+GoodForm(Val)+'&';
end;

begin
 if (c is TdhEdit) then
  AddField(TdhEdit(c).Text) else
 if (c is TdhHiddenField) then
  AddField(TdhHiddenField(c).Value) else
 if (c is TdhMemo) then
  AddField(copy(TdhMemo(c).Text,1,length(TdhMemo(c).Text)-2)) else
 if (c is TdhRadioButton) and TdhRadioButton(c).Checked then
  res:=res+GoodForm(c.Parent.Name)+'='+GoodForm(c.Name)+'&' else
 if (c is TdhCheckBox) and TdhCheckBox(c).Checked then
  AddField('true') else
 if (c is TdhSelect) then
  AddField(TdhSelect(c).Value) else
 if (c is TEdit) then
  AddField(TEdit(c).Text) else
 if (c is TMaskEdit) then
  AddField(TMaskEdit(c).Text) else
 if (c is TCheckBox) and TCheckBox(c).Checked then
  AddField('true') else
 if (c is TRadioButton) and TRadioButton(c).Checked then
  res:=res+GoodForm(c.Parent.Name)+'='+GoodForm(c.Name)+'&' else
 if (c is TMemo) then
  AddField(copy(TMemo(c).Text,1,length(TMemo(c).Text)-2)) else
 if (c is TListBox) and (TListBox(c).ItemIndex>=0) then
  AddField(TListBox(c).Items[TListBox(c).ItemIndex]) else
 if (c is TComboBox) then
  AddField(TComboBox(c).Text);
 for i:=0 to c.ControlCount-1 do
 if (c.Controls[i] is TWinControl) and not (c.Controls[i] is TdhStyleSheet) then
  CollectFields(TWinControl(c.Controls[i]),res);
end;

var _action:TPathName;
begin
  if link<>nil then
   _action:=link.Link;
  if _action='' then
   _action:=FAction;
  if SubEqual('javascript:',lowercase(_action)) then exit;
  CollectFields(Self,get);
  get:=_action+'?'+copy(get,1,length(get)-1);
  Browse(get,'',false);
end;

end.
