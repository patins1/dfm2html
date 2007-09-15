unit MyToolBar;

interface

uses
  SysUtils, Classes, Controls, ToolWin, ComCtrls,Messages,windows,graphics;

type
  TMyToolBar = class(TToolBar)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd);// message WM_ERASEBKGND;

  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMyToolBar]);
end;

{ TMyToolBar }


{ TMyToolBar }


procedure TMyToolBar.WMPaint(var Message: TWMPaint);
begin
//transparent:=false;
{color:=clred;
    Brush.Color:=clRed;
      //if not FDoubleBuffered or
      //   (TMessage(Message).wParam = TMessage(Message).lParam) then
        FillRect(Message.DC, ClientRect, Brush.Handle);
}
  inherited;
end;

procedure TMyToolBar.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
    Brush.Color:=clRed;
      //if not FDoubleBuffered or
      //   (TMessage(Message).wParam = TMessage(Message).lParam) then
        FillRect(Message.DC, ClientRect, Brush.Handle);
end;
end.
