unit MyToolButton;

interface

uses     
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QMask, Qt, QComCtrls, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Mask, ComCtrls, TntComCtrls,
  {$ENDIF}
  SysUtils, Classes;

type
  TMyToolButton = class(TTntToolButton)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    { Public declarations }
    procedure Click; override;
    function CheckMenuDropDown: Boolean; override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Additional', [TMyToolButton]);
end;

{ TMyToolButton }

function TMyToolButton.CheckMenuDropDown: Boolean;
begin      {
 Result := not (csDesigning in ComponentState) and ((DropdownMenu <> nil) and
    DropdownMenu.AutoPopup or (MenuItem <> nil)) and (FToolBar <> nil) and
    FToolBar.CheckMenuDropdown(Self);  }
 //result:=false;
 result:=Inherited CheckMenuDropDown;
end;

procedure TMyToolButton.click;
begin
 inherited;
// Down:=IsDown;

end;

procedure TMyToolButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

end;

procedure TMyToolButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var IsDown:boolean;
begin
// IsDown:=Down;
 inherited;
// Down:=IsDown;
end;

procedure TMyToolButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var IsDown:boolean;
begin
// IsDown:=Down;
 inherited;
// Down:=IsDown;

end;

end.
