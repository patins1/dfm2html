unit hCheckBox;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QMask, Qt, QDialogs, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Dialogs, Mask, UnicodeCtrls,
  {$ENDIF}
  SysUtils, Classes, hComboBox, dhPanel, dhStrUtils;

type
  ThCheckBox = class(TTntCheckBox,IhCommitable)
  private
    Updating,InEvent:boolean;   
    FStoredValue: boolean;
    FValueChange: TMyValueChange;
    FChangeReason: String;
    FModified,FStoredCleared:boolean;
    procedure Abort;
    procedure Click; override;
    function Commit: boolean;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
    function Select(LogChange: TLogChange): boolean;
    procedure SetStoredValue(const Value: boolean);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure SetDetailedStoredValue(IsCleared:boolean; const Value: boolean);
    property StoredValue:boolean write SetStoredValue;
    procedure Copy;
    procedure Delete;
    procedure Paste;
    procedure SelectAll;
    procedure Undo;
  published
    { Published declarations }
    property ValueChange:TMyValueChange read FValueChange write FValueChange;
    property ChangeReason:String read FChangeReason write FChangeReason;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [ThCheckBox]);
end;
             

function ThCheckBox.Select(LogChange:TLogChange):boolean;
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

procedure ThCheckBox.KeyPress(var Key: Char);
begin
 if Ord(Key)=VK_ESCAPE then
 begin
  Key:=#0;
  Abort;
  exit;
 end;
 inherited;
end;

procedure ThCheckBox.DoExit;
begin
  inherited;
  Commit;
end;

function ThCheckBox.Commit:boolean;
begin
  result:=true;
  if not InEvent then
  if {((Checked<>FStoredValue) or FStoredCleared and FModified)}FModified then
  begin
   result:=Select(lcCommit);
   if result then
   begin
    FStoredValue:=Checked;
    FStoredCleared := False;
    FModified:=False;
   end else
    Abort;
  end{ else
   if Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,lcAbort)};
end;

procedure ThCheckBox.SetStoredValue(const Value: boolean);
begin
 SetDetailedStoredValue(false,Value);
end;

procedure ThCheckBox.Click;
begin
  inherited;
  if Updating then exit;         
  FModified:=true;
  Select(lcLive);
end;

procedure ThCheckBox.Abort;
begin
 if not FModified then exit;
 SetDetailedStoredValue(FStoredCleared,FStoredValue);
 Select(lcAbort);
end;

procedure ThCheckBox.SetDetailedStoredValue(IsCleared: boolean;
  const Value: boolean);
begin
  if not InEvent then
  begin
   FStoredValue := Value;
   FStoredCleared:=IsCleared;
   FModified:=false;
  end;
  Updating:=true;
  Checked:=Value;
  Updating:=false;
end;

procedure ThCheckBox.Copy;
begin
end;

procedure ThCheckBox.Delete;
begin
end;

procedure ThCheckBox.Paste;
begin
end;

procedure ThCheckBox.SelectAll;
begin
end;

procedure ThCheckBox.Undo;
begin
end;

end.
