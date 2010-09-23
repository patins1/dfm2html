unit hEdit;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QMask, Qt, QDialogs, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Dialogs, Mask, UnicodeCtrls,dhStrUtils,clipbrd,
  {$ENDIF}
  SysUtils, Classes, hComboBox,dhPanel;

type
  ThEdit = class(TTntEdit,IhCommitable)
  private
    FStoredValue: WideString;
    FValueChange: TMyValueChange;
    FLateChange: boolean;
    FChangeReason: String;
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
    property ValueChange:TMyValueChange read FValueChange write FValueChange;
    property LateChange:boolean read FLateChange write FLateChange default false;
    property ChangeReason:String read FChangeReason write FChangeReason;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Additional', [ThEdit]);
end;


function ThEdit.Select(LogChange:TLogChange):boolean;
begin                    
  assert(not InEvent);
  InEvent:=true;
  try
   try
    if Assigned(ValueChange) then ValueChange(Self,false);
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

procedure ThEdit.KeyPress(var Key: Char);
begin
 if Ord(Key)=VK_RETURN then
 begin
  Key:=#0;
  FModified:=true;
  if not Select(lcLive) then
   Abort;
  exit;
 end;
 if Ord(Key)=VK_ESCAPE then
 begin
  Key:=#0;
  Abort;
  exit;
 end;
 inherited;
end;

procedure ThEdit.DoExit;
begin
  inherited;
  Commit;
end;

function ThEdit.Commit:boolean;
begin
  result:=true;
  if not InEvent then
  if {Text<>FStoredValue}FModified then
  begin
   result:=Select(lcCommit);
   if result then
   begin
    FStoredValue:=Text;
    FModified:=false;
   end else
    Abort;
  end{ else
   if Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,lcAbort)};
end;

procedure ThEdit.SetStoredText(const Value: WideString);
begin    
  if not InEvent then
  begin
   FStoredValue := Value;   
   FModified:=false;
  end;
  Updating:=true;
  Text:=Value;
  Updating:=false;
end;

procedure ThEdit.Change;
begin
  inherited;
  if Updating then exit; 
  FModified:=true;
  if not LateChange then
  begin
   if not Select(lcLive) then
    Abort;
  end else
   if Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,lcLive);
end;

procedure ThEdit.Abort;
begin                  
 if not FModified then exit;
 SetStoredText(FStoredValue);
 Select(lcAbort);
end;

procedure ThEdit.Copy;
begin
 Clipboard.AsText:=SelText;
end;

procedure ThEdit.Delete;
begin
 SelText:='';
end;

procedure ThEdit.Paste;
begin
 SelText:=Clipboard.AsText;
end;

end.
