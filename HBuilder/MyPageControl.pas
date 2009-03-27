unit MyPageControl;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QComCtrls, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls, ComCtrls, TntComCtrls, Graphics,
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

    procedure DrawTab(TabIndex: Integer; const Rect: TRect; Active: Boolean); override;
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



procedure TMyPageControl.DrawTab(TabIndex: Integer; const Rect: TRect;
  Active: Boolean);
var
  imageindex: Integer;
  r: TRect;
  S: String;
begin
  If Assigned( OnDrawTab ) Then
    inherited
  Else Begin
    R:= Rect;
//    canvas.Brush.Color:=clWhite;
    Canvas.Fillrect( r );
    imageindex := GetImageIndex( tabindex );
    If (imageindex >=0) and Assigned( Images ) Then Begin
      //SaveDC( canvas.handle );
      R:=Rect;
      inc(R.Top,3);
      if Active then
       inc(R.Left,4);
      images.Draw( Canvas, R.Left, R.Top, imageindex, {Pages[TabIndex].enabled}true );
      // images.draw fouls the canvas colors if it draws
      // the image disabled, thus the SaveDC/RestoreDC
      //RestoreDC( canvas.handle, -1 );
      R:= Rect;
      R.Left := R.Left + images.Width + 4;
    End;
    S:= Tabs[ TabIndex ];
    InflateRect( r, -4, -3 );
    inc(r.Bottom,4);
    if Active then
     inc(r.Left,4);
    DrawText( Canvas.handle,
              PChar(S),
              Length(S),
              r,
              DT_SINGLELINE or DT_LEFT or DT_TOP );
  End;
end;



end.
