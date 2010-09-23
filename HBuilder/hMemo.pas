unit hMemo;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls,UnicodeCtrls,clipbrd,
  {$ENDIF}
  SysUtils, Classes, hComboBox;

type
  ThMemo = class(TTntMemo,IhCommitable)
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
    procedure Change; override;
  public
    { Public declarations }
    property StoredText:WideString read FStoredValue write SetStoredText;
    function Commit:boolean;
    procedure Abort;
    procedure Copy;
    procedure Delete;
    procedure Paste;
  published
    { Published declarations }
    property ChangeReason:String read FChangeReason write FChangeReason;
    property ValueChange:TMyValueChange read FValueChange write FValueChange;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Additional', [ThMemo]);
end;

            

function ThMemo.Select(LogChange:TLogChange):boolean;
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

procedure ThMemo.KeyPress(var Key: Char);
begin
 if Ord(Key)=VK_ESCAPE then
 begin
  Key:=#0;
  Abort;
  exit;
 end;
 inherited;
end;

procedure ThMemo.DoExit;
begin
  inherited;
  Commit;
end;

function ThMemo.Commit:boolean;
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

procedure ThMemo.SetStoredText(const Value: WideString);
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

procedure ThMemo.Change;
begin
  inherited;
  if Updating then exit;
  FModified:=true;
  Select(lcLive);
end;


procedure ThMemo.Abort;
begin
 if not FModified then exit;
 SetStoredText(FStoredValue);
 Select(lcAbort);
end;

procedure ThMemo.Copy;
begin
 Clipboard.AsText:=SelText;
end;

procedure ThMemo.Delete;
begin
 SelText:='';
end;

procedure ThMemo.Paste;
begin
 SelText:=Clipboard.AsText;
end;

end.
