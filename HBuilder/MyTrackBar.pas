unit MyTrackBar;

interface

uses      
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QMask, Qt, QComCtrls,
  {$ELSE}
  Controls, Windows, Messages, Graphics, StdCtrls, ComCtrls, CommCtrl,Spin,
  {$ENDIF}
  SysUtils, Classes;

type
  TMyTrackBar = class(TTrackBar)
  private
    function GetValue: integer;
    procedure SetValue(const Value: integer);
    { Private declarations }
  protected
    { Protected declarations }
{$IFNDEF CLX}
    procedure CreateParams(var Params: TCreateParams); override;
{$ELSE}
    procedure InitWidget; override;
{$ENDIF}
    procedure DoEnter; override;
    procedure Changed; override;
  public
    { Public declarations }
    SpinEdit:TSpinEdit;
    Updating:boolean;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    property Value:integer read GetValue write SetValue;
    function CanFocus: Boolean; override;
    procedure Loaded; override;
  published
    { Published declarations }
    property TickMarks default tmBoth;
    property TickStyle default tsNone; 
{$IFNDEF CLX}
    property SelStart stored false;
    property SelEnd stored false;
    property ThumbLength stored false;
{$ENDIF}
{$IFDEF CLX}
    //property Max;
    property Position;
{$ENDIF}
  end;

procedure Register;

implementation

uses MySpinEdit;

procedure Register;
begin
  RegisterComponents('Samples', [TMyTrackBar]);
end;

{ TMyTrackBar }

function TMyTrackBar.CanFocus: Boolean;
begin
 result:=false;
end;

constructor TMyTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  TickMarks := tmBoth;
  TickStyle := tsNone;
end;

{$IFNDEF CLX}
procedure TMyTrackBar.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style and not TBS_ENABLESELRANGE;
end;
{$ELSE}
procedure TMyTrackBar.InitWidget;
begin
  inherited;
  QWidget_setFocusPolicy(FHandle, QWidgetFocusPolicy_NoFocus);
end;
{$ENDIF}

procedure TMyTrackBar.DoEnter;
begin
  inherited;
  if SpinEdit<>nil then
   SpinEdit.SetFocus;
end;

function TMyTrackBar.GetValue: integer;
begin
 result:=Position;
end;



procedure TMyTrackBar.SetValue(const Value: integer);
begin
 Position:=Value;
end;


procedure TMyTrackBar.Loaded;
begin
  inherited;
{$IFDEF CLX}
  SetBounds(Left+5,Top+2,WIdth-10,Height-4);
{$ENDIF}
end;

procedure TMyTrackBar.Changed;
begin
 inherited;
 if (SpinEdit<>nil) and not Updating then
 begin
  if not SpinEdit.Focused then SpinEdit.SetFocus;//need for CLX
  Updating:=true;
  SpinEdit.Value:=Value;
  SpinEdit.Update;
  Updating:=false;
 end;
end;

destructor TMyTrackBar.Destroy;
begin
  if SpinEdit is TMySpinEdit then
   TMySpinEdit(SpinEdit).TrackBar:=nil;
  inherited;
end;

end.
