unit dhColorPicker;

interface

uses
  {$IFDEF CLX}
  QForms, QControls, QGraphics, QStdCtrls, QMask, Qt, QButtons, QDialogs, QTntStdCtrls,
  {$ELSE}
  Forms, Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Mask, dialogs,Buttons, TntButtons,
  {$ENDIF}
  SysUtils, Classes, types, uColorPicker, funcutils,AColorPickerAX_TLB, dhPanel;

type
  //TNotifyEvent = procedure(Sender: TObject; Color:TColor) of object;
  
  TColorBackupEvent = procedure(Sender: TObject; backup:TList; restore:Boolean) of object;
  TdhColorPicker = class(TTntSpeedButton)
  private
    { Private declarations }
    FOnColorChanged: TNotifyEvent;
    FOnPreviewColorChanged: TNotifyEvent;
    FOnBackup: TColorBackupEvent;
    FCSSColor: TCSSColor;
    procedure SetCSSColor(const Value:TCSSColor);
  protected
    { Protected declarations }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer); override;
  public
    { Public declarations }
    procedure Click; Override;
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
    procedure DoColorChange(Color:TCSSColor);
    procedure DoPreviewColorChange(Color:TCSSColor);
    procedure DoBackup(backup:TList; restore:Boolean);
    //property TransparentColor:boolean read GetTransparentColor write SetTransparentColor;
    function GetTransparentColor: boolean;
    property CSSColor:TCSSColor read FCSSColor write SetCSSColor;
  published
    { Published declarations }
    property OnColorChanged:TNotifyEvent read FOnColorChanged write FOnColorChanged;
    property OnPreviewColorChanged:TNotifyEvent read FOnPreviewColorChanged write FOnPreviewColorChanged;
    property OnBackup:TColorBackupEvent read FOnBackup write FOnBackup;
    property Flat default false;
    property Color stored false;
  end;

procedure Register;

var ColorDialog:TAColorDialog;
var FCustomColors : TStringList;
var ActivePicker:TdhColorPicker;

implementation


procedure Register;
begin
  RegisterComponents('Additional', [TdhColorPicker]);
end;

{ TdhColorPicker }

procedure TdhColorPicker.Click;
var Executed:Boolean;   
    backup:TList;
    backupCSSColor:TCSSColor;
begin
  inherited;
  if ColorDialog=nil then
  begin
   ColorDialog:= TAColorDialog.Create(nil);
//   ColorDialog.CustomColors.AddStrings(FCustomColors);;
   ColorDialog.UseAlpha:=true;
   ColorDialog.ShowCaption:=true;
  end;

  backupCSSColor:=CSSColor;
  if CSSColor<>colTransparent then
   ColorDialog.RGBA:=Integer(CSSColor xor CSSAlphaInverter);

  Parent.SetFocus; //CommitChanges purpose
  if csDesigning in ComponentState then exit;

  backup:=TList.Create;
  try
   DoBackup(backup,false);
   ActivePicker:=Self;
   try
     Executed:=ColorDialog.Execute;
   finally
    ActivePicker:=nil;
   end;
   if Executed then
   begin
    DoColorChange(TCSSColor(ColorDialog.RGBA xor CSSAlphaInverter));
   end else
   begin
    DoBackup(backup,true);
    CSSColor:=backupCSSColor;
   end;
  finally
   backup.Free;
  end;
end;

procedure TdhColorPicker.DoColorChange(Color:TCSSColor);
begin
   Self.CSSColor:=Color;
   if Assigned(FOnColorChanged) then
    FOnColorChanged(Self);
end;


procedure TdhColorPicker.DoPreviewColorChange(Color:TCSSColor);
begin
   Self.CSSColor:=Color;
   if Assigned(FOnPreviewColorChanged) then
    FOnPreviewColorChanged(Self);
end;

procedure TdhColorPicker.DoBackup(backup:TList; restore:Boolean);
begin      
   if Assigned(FOnBackup) then
    FOnBackup(Self,backup,restore);
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
 result:=CSSColor=colTransparent;
end;

procedure TdhColorPicker.SetCSSColor(const Value:TCSSColor);
begin
 FCSSColor:=Value;
 if GetTransparentColor then
  Color:=clNone else
  Color:=CSSColorToColor(FCSSColor);
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
