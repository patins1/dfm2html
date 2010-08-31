unit hSynMemo;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, Qt,
  {$ELSE}
  Controls, Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, hComboBox, SynMemo, SynEdit;

type
  ThSynMemo = class(TSynMemo,IhCommitable)
  private
    FStoredValue: WideString;
    FChangeReason: String;
    FValueChange: TMyValueChange;
    function Select(LogChange:TLogChange):boolean;
    procedure SetStoredText(const Value: WideString);
    { Private declarations }
  protected
    { Protected declarations }
    Updating,InEvent,FModified:boolean;
    procedure KeyPress(var Key: Char); override;
    procedure DoExit; override;
    procedure DoChange; override;
  public
    { Public declarations }
    property StoredText:WideString read FStoredValue write SetStoredText;
    function Commit:boolean;
    procedure Abort;
  published
    { Published declarations }
    property ChangeReason:String read FChangeReason write FChangeReason;
    property ValueChange:TMyValueChange read FValueChange write FValueChange;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Additional', [ThSynMemo]);
end;



function ThSynMemo.Select(LogChange:TLogChange):boolean;
begin
    InEvent:=true;
    if Assigned(ValueChange) then ValueChange(Self,false);
    if Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,LogChange);
    InEvent:=false;
    result:=true;
end;

{$IFDEF CLX}
const
  VK_RETURN = 13;
  VK_ESCAPE = 27;
{$ENDIF}

procedure ThSynMemo.KeyPress(var Key: Char);
begin
 if Ord(Key)=VK_ESCAPE then
 begin
  Key:=#0;
  Abort;
  exit;
 end;
 inherited;
end;

procedure ThSynMemo.DoExit;
begin
  inherited;
  Commit;
end;

function ThSynMemo.Commit:boolean;
begin
  result:=true;
  if not InEvent then
  if {Lines.Text<>FStoredValue}FModified then
  begin
   Select(lcCommit);
   FModified:=false;
   FStoredValue:=Lines.Text;
  end{ else
   if Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,lcAbort)};
end;

procedure ThSynMemo.SetStoredText(const Value: WideString);
begin
  if not InEvent then
  begin
   FStoredValue := Value;
   FModified:=false;
  end;
  Updating:=true;
  Lines.Text:=Value;
  Updating:=false;
end;

procedure ThSynMemo.DoChange;
begin
  inherited;
  if Updating then exit;
  FModified:=true;
  Select(lcLive);
end;


procedure ThSynMemo.Abort;
begin
 if not FModified then exit;
 SetStoredText(FStoredValue);
 Select(lcAbort);
end;

end.
