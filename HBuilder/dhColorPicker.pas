unit dhColorPicker;

interface

uses
  {$IFDEF CLX}
  QForms, QControls, QGraphics, QStdCtrls, QMask, Qt, QButtons, QDialogs, QTntStdCtrls,
  {$ELSE}
  Forms, Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Mask, dialogs,Buttons, TntButtons,
  {$ENDIF}
  SysUtils, Classes, types, uColorPicker, funcutils;

type                                   
  //TNotifyEvent = procedure(Sender: TObject; Color:TColor) of object;
  TdhColorPicker = class(TTntSpeedButton)
  private
    { Private declarations }
    FOnColorChanged: TNotifyEvent;
    function GetTransparentColor: boolean;
    procedure SetTransparentColor(const Value: boolean);
  protected
    { Protected declarations }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer); override;
  public
    { Public declarations }
    procedure Click; Override;
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
    procedure DoColorChange(Color:TColor);
    property TransparentColor:boolean read GetTransparentColor write SetTransparentColor;

  published
    { Published declarations }
    property OnColorChanged:TNotifyEvent read FOnColorChanged write FOnColorChanged;
    property Flat default false;
    property Color stored true;
  end;

procedure Register;

var ColorDialog:TColorDialog; 
var FCustomColors : TStringList;

implementation


procedure Register;
begin
  RegisterComponents('Additional', [TdhColorPicker]);
end;

{ TdhColorPicker }

procedure TdhColorPicker.Click;
begin
  inherited;
  if ColorDialog=nil then
  begin
   ColorDialog:=TColorDialog.Create(nil);
   ColorDialog.CustomColors.AddStrings(FCustomColors);;
  end;

  ColorDialog.Color:=Color;

  Parent.SetFocus; //CommitChanges purpose
  if not (csDesigning in ComponentState) then
  if ColorDialog.Execute then
   DoColorChange(ColorDialog.Color);
end;

procedure TdhColorPicker.DoColorChange(Color:TColor);
begin
   Self.Color:=Color;
   if Assigned(FOnColorChanged) then
    FOnColorChanged(Self);
end;


constructor TdhColorPicker.Create(AOwner: TComponent);
begin
  inherited;
end;



procedure TdhColorPicker.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  LateCreateForm(TColorPicker,ColorPicker);
  PopupMenu:=ColorPicker.PopupMenu1;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TdhColorPicker.Paint;
{const
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
}var
  PaintRect: TRect;
  DrawFlags: Integer;
  Offset: TPoint;
begin
 flat:=false;
 transparent:=true;  
 Canvas.Brush.Style := bsSolid;
 Canvas.Brush.Color := clBtnFace; 
 Canvas.FillRect(ClientRect);
 inherited;

 if Color=clNone then exit;
 PaintRect := Rect(Width-24, 4, Width-4, Height-4);
 if (FState in [bsDown]) then
  OffsetRect(PaintRect,1,1);
 Canvas.Brush.Style := bsSolid;
 Canvas.Brush.Color := Color;
 Canvas.FillRect(PaintRect);

  {
  if FState = bsDisabled then
    if Down and (GroupIndex <> 0) then
      FState := bsExclusive
    else
      FState := bsUp;
  Canvas.Font := Self.Font;
  PaintRect := Rect(0, 0, Width, Height);
  flat:=true;
  if not Flat then
  begin
    DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
    if FState in [bsDown, bsExclusive] then
      DrawFlags := DrawFlags or DFCS_PUSHED;
    DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
  end
  else
  begin
    if (FState in [bsDown, bsExclusive]) or
      (MouseInControl and (FState <> bsDisabled)) or
      (csDesigning in ComponentState) then
      DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [bsDown, bsExclusive]],
        FillStyles[Transparent] or BF_RECT)
    else if not Transparent then
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(PaintRect);
    end;
    InflateRect(PaintRect, -1, -1);
  end;
  if FState in [bsDown, bsExclusive] then
  begin
    if (FState = bsExclusive) and (not Flat or not MouseInControl) then
    begin
      Canvas.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
      Canvas.FillRect(PaintRect);
    end;
    Offset.X := 1;
    Offset.Y := 1;
  end
  else
  begin
    Offset.X := 0;
    Offset.Y := 0;
  end;
  TButtonGlyph(FGlyph).Draw(Canvas, PaintRect, Offset, Caption, FLayout, FMargin,
    FSpacing, FState, Transparent, DrawTextBiDiModeFlags(0)); }
end;

function TdhColorPicker.GetTransparentColor: boolean;
begin
 result:=Color=clNone;
end;

procedure TdhColorPicker.SetTransparentColor(const Value: boolean);
begin
 Color:=clNone;
end;

initialization
  //LateCreateForm(TColorPicker,ColorPicker);
  //ColorPicker:= TColorPicker.Create(nil); 
 FCustomColors:=TStringList.Create;

finalization

  //FreeAndNil(ColorPicker);

 FreeAndNil(ColorDialog);

 FreeAndNil(FCustomColors);

end.
