unit dhColorPicker;

interface

uses
  {$IFDEF CLX}
  QForms, QControls, QGraphics, QStdCtrls, QMask, Qt, QButtons, QDialogs, QTntStdCtrls,
  {$ELSE}
  Forms, Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Mask, dialogs,Buttons, UnicodeCtrls,
  {$ENDIF}
  SysUtils, Classes, types, uColorPicker, funcutils,AColorPickerAX_TLB, dhPanel, gr32;

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
    procedure DoPreviewColorChange;
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

var ColorDialog:TComponent;
var FCustomColors : TStringList;
var ActivePicker:TdhColorPicker;

implementation

uses OleCtrls;

procedure Register;
begin
  RegisterComponents('Additional', [TdhColorPicker]);
end;

function GetCSSColorFromDialog:TCSSColor;
begin            
 if ColorDialog is TAColorDialog then
  result:=Color32ToCSSColor(Color32(TAColorDialog(ColorDialog).RGB_R,TAColorDialog(ColorDialog).RGB_G,TAColorDialog(ColorDialog).RGB_B,TAColorDialog(ColorDialog).Alpha)) else
  result:=ColorToCSSColor(TColorDialog(ColorDialog).Color);
end;

const MyLicenseKey=('HP25W0-D98KR4-DQCM31-9ZQXQR-04PMG4-C6PMA7-CC47EE-EDF383-FAE388-769053-44D5E4-528106');

type TMyAColorDialog=class(TAColorDialog)
  protected
    procedure InitControlData; override;
  end;
  TFakeWinControl=class(TWinControl);

procedure TMyAColorDialog.InitControlData;
begin
  inherited;
  ControlData.LicenseKey:=PChar(MyLicenseKey);
end;


{ TdhColorPicker }

procedure TdhColorPicker.Click;
var Executed:Boolean;   
    backup:TList;
    backupCSSColor:TCSSColor;
    AColorDialog:TAColorDialog;
    NormalColorDialog:TColorDialog;
begin
  inherited;
  if ColorDialog=nil then
  try
   AColorDialog:= TMyAColorDialog.Create(nil);
   AColorDialog.UseAlpha:=true;
   AColorDialog.Caption:='';
   ColorDialog:=AColorDialog;
  except
   NormalColorDialog:=TColorDialog.Create(nil);
   NormalColorDialog.CustomColors.AddStrings(FCustomColors);
   ColorDialog:=NormalColorDialog;
  end;

  backupCSSColor:=CSSColor;
  if CSSColor<>colTransparent then
  if ColorDialog is TAColorDialog then
   TAColorDialog(ColorDialog).RGBA:=Integer(CSSColor xor CSSAlphaInverter) else
   TColorDialog(ColorDialog).Color:=CSSColorToColor(CSSColor);

  Parent.SetFocus; //CommitChanges purpose
  if csDesigning in ComponentState then exit;

  backup:=TList.Create;
  try
   DoBackup(backup,false);
   ActivePicker:=Self;
   try
    if ColorDialog is TAColorDialog then
     Executed:=TAColorDialog(ColorDialog).Execute else
     Executed:=TColorDialog(ColorDialog).Execute;
   finally
    ActivePicker:=nil;
   end;
   if Executed then
   begin
    DoColorChange(GetCSSColorFromDialog);
   end else
   begin
    CSSColor:=backupCSSColor;
    DoBackup(backup,true);
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


procedure TdhColorPicker.DoPreviewColorChange;
begin
   TAColorDialog(ColorDialog).RGB_R:=TAColorDialog(ColorDialog).RGB_R; //update TAColorDialog.Alpha
   Self.CSSColor:=GetCSSColorFromDialog;
   if Assigned(FOnPreviewColorChanged) then
    FOnPreviewColorChanged(Self);
end;

procedure TdhColorPicker.DoBackup(backup:TList; restore:Boolean);
begin
   if Assigned(FOnBackup) then
    FOnBackup(Self,backup,restore) else
   if restore then
   if Assigned(FOnPreviewColorChanged) then
    FOnPreviewColorChanged(Self);
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
