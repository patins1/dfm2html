unit MySpinEdit;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QComCtrls,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls, Spin,
  {$ENDIF}
  SysUtils, Classes,hComboBox,MyTrackBar,uWException, dhPanel,dhStrUtils;

type
  TMySpinEdit = class(TSpinEdit,IhCommitable)
  private
    { Private declarations }  
    FAlignment: TAlignment;
    FOnChange: TNotifyEvent;
    FStoredValue:Integer;
    FStoredCleared:boolean;
    Updating,InEvent,FModified:boolean;
    FTrackBar: TMyTrackBar;
    FValueChange: TMyValueChange;
    FChangeReason: String;
    procedure SetAlignment(const Value: TAlignment);
    function Select(LogChange:TLogChange):boolean;
    procedure SetStoredValue(const Value: Integer);
    procedure SetTrackBar(const Value: TMyTrackBar);
    function InvalidValue:boolean;
    function GetValue2: LongInt;
  protected
    { Protected declarations }
{$IFNDEF CLX}
    procedure CreateParams(var Params:TCreateParams); override;
{$ENDIF}
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadMin(Reader: TReader);
    procedure ReadMax(Reader: TReader);
    procedure Change{$IFDEF CLX}(AValue: Integer){$ENDIF}; override;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
    procedure UpdateTrackBar;
  public
    { Public declarations }
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    function Commit:boolean;
    procedure Abort;
    property StoredValue:Integer read FStoredValue write SetStoredValue;
    procedure SetDetailedStoredValue(IsCleared:boolean; DisplayValue: Integer);
  published
    { Published declarations }
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
{$IFDEF CLX}
    //property Min:LongInt read GetMin write SetMin;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;

    //property MinValue:boolean write SetMinValue nodefault;
    //property MaxValue:LongInt read GetMaxValue;
   {
    property Min:LongInt read GetMin write SetMin;
    property Max:LongInt read GetMax write SetMax;   }
{$ENDIF}
    property ValueChange:TMyValueChange read FValueChange write FValueChange;
    property TrackBar:TMyTrackBar read FTrackBar write SetTrackBar;
    property ChangeReason:String read FChangeReason write FChangeReason;
    property Value read GetValue2;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMySpinEdit]);
end;

{ TMySpinEdit }

function TMySpinEdit.GetValue2: LongInt;
begin
 Result := StrToInt (Text); //dont catch exception
end;


procedure TMySpinEdit.SetAlignment(const Value: TAlignment);
begin
  if FAlignment<>Value then
  begin
    FAlignment:=Value;
{$IFNDEF CLX}
    RecreateWnd;         
{$ENDIF}
  end;
end;

{$IFNDEF CLX}
procedure TMySpinEdit.CreateParams(var Params:TCreateParams);
const
  Alignments: array[TAlignment] of Word= (ES_LEFT, ES_RIGHT, ES_CENTER);
begin          
  inherited;
  Params.Style:=Params.Style or ES_MULTILINE or Alignments[FAlignment];
end;
{$ENDIF}


constructor TMySpinEdit.Create(AOwner: TComponent);
begin
  inherited;
  FAlignment := taRightJustify;
end;

procedure TMySpinEdit.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('MinValue', ReadMin, nil, false);
  Filer.DefineProperty('MaxValue', ReadMax, nil, false);
  Filer.DefineProperty('Min', ReadMin, nil, false);
  Filer.DefineProperty('Max', ReadMax, nil, false);
end;

procedure TMySpinEdit.ReadMin(Reader: TReader);
begin
{$IFDEF CLX}
 Min:=Reader.ReadInteger;
{$ELSE}
 MinValue:=Reader.ReadInteger;
{$ENDIF}
end;

procedure TMySpinEdit.ReadMax(Reader: TReader);
begin        
{$IFDEF CLX}
 Max:=Reader.ReadInteger;
{$ELSE}
 MaxValue:=Reader.ReadInteger;
{$ENDIF}
end;

function TMySpinEdit.InvalidValue:boolean;
var val:integer;
begin
 result:=not TryStrToInt(Text,val);
end;



procedure TMySpinEdit.Change{$IFDEF CLX}(AValue: Integer){$ENDIF};
begin
 inherited;
 if (Parent=nil) or (csLoading in ComponentState) or (csLoading in Parent.ComponentState{for CLX}) or not Visible then exit;
{$IFDEF CLX}
// if Showing then
 if Assigned(FOnChange) then FOnChange(Self);
{$ENDIF}
 if InvalidValue then exit;
 UpdateTrackBar;
 if Updating then exit;
 FModified:=true;
 Select(lcLive);
end;

procedure TMySpinEdit.UpdateTrackBar;
begin
  if (TrackBar<>nil) and not TrackBar.Updating then
 begin
  TrackBar.Updating:=true;
  TrackBar.Value:=Value;
  TrackBar.Updating:=false;
 end;
end;

function TMySpinEdit.Commit:boolean;
begin
  result:=true;
  if InEvent then exit;
  if {((Value<>FStoredValue) or FStoredCleared and FModified)}FModified or InvalidValue then
  begin

   result:=Select(lcCommit);
   if result then
   begin
    FStoredValue := Value;
    FStoredCleared := False;
    FModified := False;
   end else
    Abort;

   {Select(lcCommit);
   FStoredValue := Value;
   FStoredCleared := False;
   FModified := False; }
  end{ else
   if Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,lcAbort)};
end;

function TMySpinEdit.Select(LogChange:TLogChange):boolean;
begin
{  assert(not InEvent);
  InEvent:=True;
  if Assigned(ValueChange) then ValueChange(Self,(LogChange=lcAbort) and FStoredCleared);
  if Assigned(ValueChange) and Supports(Owner,IhLogReceiver) then (Owner as IhLogReceiver).LogChange(Self,LogChange);
  InEvent:=False;  }

  assert(not InEvent);
  InEvent:=LogChange<>lcCommit;//at a Commit we want to update the Text at any case
  try
   try
    if Assigned(ValueChange) then ValueChange(Self,(LogChange=lcAbort) and FStoredCleared);
    InEvent:=true;
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

procedure TMySpinEdit.DoExit;
begin
  inherited;
  if (TrackBar<>nil) and TrackBar.Focused then exit;
  Commit;
end;

procedure TMySpinEdit.SetStoredValue(const Value:Integer);
begin
 SetDetailedStoredValue(false,Value);
end;

procedure TMySpinEdit.SetDetailedStoredValue(IsCleared:boolean; DisplayValue: Integer);
begin
  if InEvent then exit; //do not change currently edited text
  if not InEvent then
  begin
   FStoredValue := DisplayValue;
   FStoredCleared:=IsCleared;
   FModified:=false;
  end;
  Updating:=true;
  Value:=DisplayValue;
  UpdateTrackBar;
  Updating:=false;
end;


{$IFDEF CLX}
const
  VK_RETURN = 13;
  VK_ESCAPE = 27;
{$ENDIF}

procedure TMySpinEdit.KeyPress(var Key: Char);
begin      
 if Ord(Key)=VK_RETURN then
 begin
  Key:=#0;
  FModified:=true;
  if not Select(lcLive) then
   Abort;
  //Select(lcLive);
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

procedure TMySpinEdit.SetTrackBar(const Value: TMyTrackBar);
begin
  if FTrackBar<>nil then
   FTrackBar.SpinEdit:=nil;
  FTrackBar := Value;
  if FTrackBar<>nil then
   FTrackBar.SpinEdit:=Self;
end;

destructor TMySpinEdit.Destroy;
begin
  TrackBar:=nil;
  inherited;
end;

procedure TMySpinEdit.Abort;
begin
 if not FModified and InvalidValue then
 begin
  SetDetailedStoredValue(FStoredCleared,FStoredValue); //just restore Text to originally valid value 
  exit;
 end;
 if not FModified then exit;
 SetDetailedStoredValue(FStoredCleared,FStoredValue);
 Select(lcAbort);
end;

end.
