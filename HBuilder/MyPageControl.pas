unit MyPageControl;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QComCtrls, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls, ComCtrls, TntComCtrls,
  {$ENDIF}
  SysUtils, Classes,types;

type
  TMyPageControl = class(TTntPageControl)
  private
    { Private declarations }
  protected
    { Protected declarations }
{$IFDEF CLX}
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      const MousePos: TPoint): Boolean; override;
{$ENDIF}

  public
    { Public declarations }
  published
    { Published declarations }  
    property OnDrawTab;
    property TabIndex stored false;
    property Color;
    property ParentColor;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMyPageControl]);
end;

{ TMyPageControl }

{procedure TMyPageControl.DoShow;
begin
 if not Showing then exit;
 inherited;
end;
 }
{ TMyPageControl }

{$IFDEF CLX}
function TMyPageControl.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; const MousePos: TPoint): Boolean;
begin
 //vehindert tab-wechsel durch mouse-wheel in CLX
 result:=true;
end;
{$ENDIF}

end.
