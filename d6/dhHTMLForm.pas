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
  dhMemo,dhEdit,dhCheckBox,dhRadioButton,dhMenu,dhLabel,BasicHTMLElements,dhHiddenField,dhFileField,dhStrUtils;

type            {
  IHTMLFormReset=interface
    procedure Reset;
  end;
                 }

  TFormMethod=(fmtGet,fmtPost);
  //TFormButtonLayout=(flButton,flText);
  TdhHTMLForm = class(TdhPanel)
  private
    FTarget: TPathName;
    procedure SetTarget(const Value: TPathName);
    { Private declarations }
  protected
    { Protected declarations }
    FAction:TPathName;
    FMethod:TFormMethod;
    //ar:array of record but:TButton; ev:TNotifyEvent end;
    //procedure OnButtonSubmit(Sender: TObject);
    procedure DefineProperties(Filer: TFiler); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
    procedure Submit(link:TdhLink);
    procedure Reset;
    function AllHTMLCode:HypeString; override;
  published
    { Published declarations }
    property Action:TPathName read FAction write FAction;
    property Method:TFormMethod read FMethod write FMethod default fmtGet;
    property Target:TPathName read FTarget write SetTarget;
  end;

  TdhFormButton = class(TdhDynLabel)
  private
    { Private declarations }
    FFormButtonType:TFormButtonType;
  protected
    { Protected declarations }
    function GetDefaultLayout:TLinkType; override;
  public
    { Public declarations }
    procedure DoClickAction(Initiator:TdhCustomPanel); override;
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property FormButtonType:TFormButtonType read FFormButtonType write FFormButtonType default fbSubmit;
  end;

procedure Register;

procedure ResetFields(c:TWinControl);
procedure MemorizeFields(c:TWinControl);

implementation


procedure Register;
begin
 RegisterComponents('DFM2HTML', [TdhHTMLForm]);
 RegisterComponents('DFM2HTML', [TdhFormButton]);
end;

constructor TdhHTMLForm.Create(AOwner: TComponent);
begin
 inherited;
end;

function TdhFormButton.GetDefaultLayout: TLinkType;
begin
 result:=ltButton;
end;

procedure TdhHTMLForm.Loaded;
begin
 inherited;
end;

function GoodForm(const s:WideString):WideString;
var i:integer;
begin
 result:='';
 for i:=1 to length(s) do
 if (result[i] in ['"','<','>','%','\','^','[',']','`','+','$',','   ,';','/','?',':','@','=','&','#']) or (ord(result[i])<=31) or (ord(result[i])>=127) then
  result:=result+'%'+inttohex(ord(result[i]),2) else
  result:=result+s[i];
end;

procedure ResetFields(c:TWinControl);
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
{ if c is TdhListBox then
  TdhListBox(c).Reset else
 if c is TdhComboBox then
  TdhComboBox(c).Reset else}
 if c is TdhFileField then
  TdhFileField(c).Reset else
 if c is TdhSelect then
  TdhSelect(c).Reset else
 ;
 for i:=0 to c.ControlCount-1 do
 if (c.Controls[i] is TWinControl) and not (c.Controls[i] is TdhStyleSheet) then
  ResetFields(TWinControl(c.Controls[i]));

end;

procedure MemorizeFields(c:TWinControl);
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
{ if c is TdhListBox then
  TdhListBox(c).Memorize else
 if c is TdhComboBox then
  TdhComboBox(c).Memorize else}
 if c is TdhFileField then
  TdhFileField(c).Memorize else
 if c is TdhSelect then
  TdhSelect(c).Memorize else
 ;
 for i:=0 to c.ControlCount-1 do
 if (c.Controls[i] is TWinControl) and not (c.Controls[i] is TdhStyleSheet) then
  MemorizeFields(TWinControl(c.Controls[i]));

end;


procedure TdhHTMLForm.DefineProperties(Filer: TFiler);

function HasFileUpload(p:TWinControl):boolean;
var i:integer;
begin
 if p is TdhFileField then
 begin
  result:=true;
  exit;
 end;  
 for i:=0 to p.ControlCount-1 do
 if (p.Controls[i] is TWinControl) and HasFileUpload(TWinControl(p.Controls[i])) then
 begin           
  result:=true;
  exit;
 end;
 result:=false;
end;

begin
 inherited;
 if not WithMeta and (Filer is TWriter) then exit;
 Filer.DefineProperty('FileUpload', SkipValue, WriteTrue, HasFileUpload(self));
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

var s,dummy:AnsiString;
begin
{ if (c is TdhCustomBox) and (TdhCustomBox(c).ItemIndex>=0) then
  AddField(TdhCustomBox(c).Value) else}
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
  AddField(TComboBox(c).Text) else
 ;
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



//http://www.blooberry.com/indexdot/html/topics/urlencoding.htm?state=none&origval=asdf%F6fdsa%3Cfdsafd%E4&enc=on
{ TdhFormButton }

{procedure TdhFormButton.Click;
begin
 if DelegateClick then exit;
 inherited Click;
 DoClickAction(Self);
end;
 }
procedure TdhFormButton.DoClickAction(Initiator:TdhCustomPanel);
var p:TControl;
begin
  p:=Initiator;
  while (p<>nil) do
  begin
   if p is TdhHTMLForm then
   begin
    if FFormButtonType=fbSubmit then
     TdhHTMLForm(p).Submit(nil) else
     TdhHTMLForm(p).Reset;
    break;
   end;
   p:=p.Parent;
  end;
end;

constructor TdhFormButton.Create(AOwner: TComponent);
begin
 inherited;
 FormButtonType:=fbSubmit;
end;


end.
