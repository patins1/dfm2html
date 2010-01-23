unit hComboBox;

interface

uses        
  {$IFDEF CLX}
  QForms, QControls, QGraphics, QStdCtrls, QMask, Qt, QDialogs, QTntStdCtrls,
  {$ELSE}
  Forms, Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Mask, Dialogs, UnicodeCtrls,
  {$ENDIF}
  SysUtils, Classes,UIConstants,uWException,dhPanel,dhStrUtils;

type IhCommitable=interface
 ['{12C954E2-1883-46E2-A923-67DE1CC22DC8}']
 function Commit:boolean;
 procedure Abort;
end;

type
  TLogChange=(lcAbort,lcLive,lcCommit);
  TMyValueChange=procedure (Sender:TObject; Clear:Boolean) of Object;
  TMyLogChange=procedure (Sender:TObject; LogChange:TLogChange) of Object;


type IhLogReceiver=interface
 ['{787D3E1B-3690-4CC8-A804-D5AA3A836501}']
  procedure LogChange(Sender:TObject; LogChange:TLogChange);
end;

type
  ThComboBox = class(TTntComboBox,IhCommitable)
  private
    FStoredTextChange: TNotifyEvent;
    FLiveTextChange: TNotifyEvent;
    FChangeReason: String;
    FValueChange: TMyValueChange;
    InEvent,FModified:boolean;
    FStoredCleared:boolean;
    FStoredValue:WideString;
    Updating:boolean; //needed for CLX only
    { Private declarations }
//    procedure WMUserAgent(var Msg:TMsg); message WM_REVISE_UA;
    procedure SetStoredText(const Value: WideString);
    procedure SetStoredItemIndex(const Value: integer);
  protected
    { Protected declarations }
    procedure Change; override;
    procedure Select; override;
    function DoSelect(LogChange:TLogChange):boolean;
    procedure KeyPress(var Key: Char); override;
    procedure DoExit; override;

  public
    { Public declarations }
    procedure SetDetailedStoredItemIndex(IsCleared:boolean; const Value: integer);
    procedure SetDetailedStoredValue(IsCleared:boolean; DisplayValue: WideString);
    constructor Create(AOwner: TComponent); override;
    property StoredText:WideString write SetStoredText;
    property StoredItemIndex:integer write SetStoredItemIndex;
    function Commit:boolean;
    procedure Abort;
  published
    { Published declarations }
    property ValueChange:TMyValueChange read FValueChange write FValueChange;
    property ChangeReason:String read FChangeReason write FChangeReason;
  end;



function GoodValue(const s:WideString):WideString;
procedure ShowInputError(const Message:WideString);

//const sClearValue='*CLEAR VALUE*';

procedure Register;


implementation

procedure Register;
begin
  RegisterComponents('Additional', [ThComboBox]);
end;




function GoodValue(const s:WideString):WideString;
begin
 if s='*CLEAR VALUE*' then
  result:='' else
  result:=s;
end;


{ ThComboBox }

constructor ThComboBox.Create(AOwner: TComponent);
begin
  inherited;
end;


procedure ThComboBox.Change;
begin
  inherited;
  if Updating then exit;
  FModified:=true;
  if Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,lcLive);
  //PostMessage(handle,WM_REVISE_UA,0,0);
end;

{procedure ThComboBox.WMUserAgent(var Msg: TMsg);
begin
 if Text='*CLEAR VALUE*' then
  Text:='';
end;}



procedure ThComboBox.SetDetailedStoredValue(IsCleared:boolean; DisplayValue: WideString);
var DisplayIndex:integer;

function GetNearByIndex:boolean;
var act,i,iact:integer;
begin
 result:=false;
 {if (DisplayIndex=-1) and TryStrToInt(DisplayValue,act) then
 begin        
  DisplayIndex:=-1;
  for i:=0 to Items.Count-1 do
  if not TryStrToInt(Items[i],iact) then
   exit else
  if iact<=act then
   DisplayIndex:=i;
  result:=true;
 end;   }
end;


begin
  if not InEvent then
  begin
   FStoredValue := DisplayValue;
   FStoredCleared:=IsCleared;
   FModified:=false;
  end;
  Updating:=true;
  DisplayIndex:=Items.IndexOf(DisplayValue);
  //Note: setting ItemIndex to the same value has no effect, but text may be something different still
  if (Style<>csDropDown) or
     (DisplayIndex<>-1{needed at csDropDown and user just selected from list and list was repopulated (at GetRefs())}) or
     GetNearByIndex then
  begin
   ItemIndex:=DisplayIndex;
   if (Style=csDropDown) then
    Text:=DisplayValue;
  end else
  begin
   Text:=DisplayValue;
  end;
  Updating:=false;
end;

procedure ThComboBox.SetStoredText(const Value: WideString);
begin
  SetDetailedStoredValue(false,Value);
end;

procedure ShowInputError(const Message:WideString);
var form:TCustomForm;
begin
   form:=Screen.ActiveForm;
   MessageDlg(Message,mtError,[mbOK],0);
   if (form<>Screen.ActiveForm) and (form.ActiveControl<>nil) then
    form.ActiveControl.SetFocus; //prevent TPageContainer getting focused
end;


function ThComboBox.DoSelect(LogChange:TLogChange):boolean;
begin
  assert(not InEvent);
  InEvent:=true;
  try
   try
    if Assigned(ValueChange) then ValueChange(Self,(LogChange=lcAbort) and FStoredCleared);
    if Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,LogChange);
    Result:=true;
   except
    on E:WException do
    begin
     ShowInputError(E.Message);
     Result:=false;
    end;
    on E:Exception do
    begin
     ShowInputError(E.Message);
     Result:=false;
    end;
   end;
  finally
   InEvent:=false;
  end;
end;


{$IFDEF CLX}
const
  VK_RETURN = 13;
  VK_ESCAPE = 27;
{$ENDIF}

procedure ThComboBox.KeyPress(var Key: Char);
begin
 if Ord(Key)=VK_RETURN then
 begin
  Key:=#0;
  FModified:=true;
  if not DoSelect(lcLive) then
   Abort;
  exit;
 end;
 if Ord(Key)=VK_ESCAPE then
 begin
  Key:=#0;
  Abort;
  exit;
 end;
 if CharInSet(Key,['0','1','2','3','4','5','6','7','8','9','-']) then exit;
 inherited;
end;

procedure ThComboBox.DoExit;
begin
  inherited;
  Commit;
end;

function ThComboBox.Commit:boolean;
begin
  result:=true;
  if not InEvent then        
  if {((GoodValue(Text)<>FStoredValue) or FStoredCleared and FModified)}FModified then
  begin
   result:=DoSelect(lcCommit);
   if result then
   begin
    FStoredValue := GoodValue(Text);
    FStoredCleared := False;
    FModified:=False;
   end else
    Abort;
  end{ else
   if Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,lcAbort)};
end;

procedure ThComboBox.Abort;
begin            
 if not FModified then exit;
 SetDetailedStoredValue(FStoredCleared,FStoredValue);
 DoSelect(lcAbort);
end;

procedure ThComboBox.Select;
begin
  inherited;
  if not DoSelect(lcLive) then
   Abort;
end;

procedure ThComboBox.SetStoredItemIndex(const Value: integer);
begin
  SetDetailedStoredItemIndex(false,Value);
end;


procedure ThComboBox.SetDetailedStoredItemIndex(IsCleared: boolean;
  const Value: integer);
begin
 if Value<>-1 then
  SetDetailedStoredValue(IsCleared,Items[Value]) else //Items[-1] not allowed in CLX
  SetDetailedStoredValue(IsCleared,'');
end;

end.
