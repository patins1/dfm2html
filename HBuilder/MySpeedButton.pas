unit MySpeedButton;

interface

uses             
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QButtons,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls, Buttons,
  {$ENDIF}
  SysUtils, Classes;

type
  TMySpeedButton = class(TSpeedButton)
  private
    { Private declarations }
  protected
    { Protected declarations }    
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Additional', [TMySpeedButton]);
end;

{ TMySpeedButton }

procedure TMySpeedButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
{$IFNDEF CLX}
  if Assigned(OnMouseDown) then OnMouseDown(Self, Button, Shift, X, Y);
{$ELSE}
  inherited;
{$ENDIF}  
end;

end.
