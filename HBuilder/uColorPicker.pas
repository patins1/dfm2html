unit uColorPicker;

interface

uses
  {$IFDEF CLX}
  QForms, QControls, QGraphics, QStdCtrls, Qt, QButtons, QDialogs, QClipbrd, QExtCtrls, QMenus, QTntStdCtrls,
  {$ELSE}
  Forms, Controls, Windows, Messages, Graphics, StdCtrls, Buttons, ExtCtrls, Menus, clipbrd, Dialogs, UnicodeCtrls,
  {$ENDIF}
  SysUtils, Classes, types, dhPanel, dhLabel, uSearchStr, DKLang, Gr32, MyForm{$IFDEF LINUX},libc{$ENDIF}, dhStrUtils;

type
  TColorPicker = class(TMyForm)
    Panel1: TdhPanel;
    Label1: TdhLabel;
    Label2: TdhLabel;
    Panel2: TdhPanel;
    Button2: TTntButton;
    Button3: TTntButton;
    PopupMenu1: TPopupMenu;
    ColorPicker1: TMenuItem;
    N1: TMenuItem;
    CopyColortoClipboard1: TMenuItem;
    GetColorfromClipboard1: TMenuItem;
    Timer1: TTimer;
    DKLanguageController1: TDKLanguageController;
    procedure ColorPicker1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure CopyColortoClipboard1Click(Sender: TObject);
    procedure GetColorfromClipboard1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
{$IFNDEF CLX}
    ScreenDC:HDC;
{$ENDIF}
    ScreenCanvas:TCanvas;
  public
    { Public declarations }
  end;

var
  ColorPicker: TColorPicker;

implementation

{$R *.dfm}

uses dhColorPicker;




function GetShiftState: TShiftState;   
{$IFDEF LINUX}
{var
  Root: Window;
  Child: Window;
  RootX, RootY, WinX, WinY: Longint;
  Mask: Cardinal;  }   
{$ENDIF}
begin
  Result := [];
{$IFNDEF CLX}
  if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
  if GetKeyState(VK_MENU) < 0 then Include(Result, ssAlt);
  if GetKeyState(VK_RBUTTON) and $8000 <> 0 then Include(Result, ssRight);
  if GetKeyState(VK_LBUTTON) and $8000 <> 0 then Include(Result, ssLeft);
{$ELSE}
{$IFDEF LINUX}
 {XQueryPointer(Application.Display, XRootWindow(Application.Display,
   XDefaultScreen(Application.Display)), @Root, @Child, @RootX, @RootY, @WinX, @WinY, @Mask);

  Result := [];
  if Mask and Button1Mask <> 0 then Include(Result, ssLeft);
  if Mask and Button2Mask <> 0 then Include(Result, ssMiddle);
  if Mask and Button3Mask <> 0 then Include(Result, ssRight);

  if Mask and ShiftMask <> 0 then Include(Result, ssShift);
  if Mask and ControlMask <> 0 then Include(Result, ssCtrl);
  if Mask and Mod1Mask <> 0 then Include(Result, ssAlt);     }     
  Result := Application.KeyState;
{$ELSE}
  Result := Application.KeyState;
{$ENDIF}
{$ENDIF}
end;

procedure TColorPicker.ColorPicker1Click(Sender: TObject);
begin
 ScreenCanvas:=TCanvas.Create;
{$IFNDEF CLX}
 ScreenCanvas.Handle:=GetDC(0);
 //ScreenDC:=GetDC(0);
{$ELSE}
 //ScreenCanvas.Handle:=QPainter_create(QWidget_to_QPaintDevice(QApplication_desktop));
{$ENDIF}

 Timer1.Enabled:=true;
 try
  if ShowModal=mrOk then
   (PopupMenu1.PopupComponent as TdhColorPicker).DoColorChange(Panel2.Style.BackgroundColor);
 finally
  Timer1.Enabled:=false;
  ScreenCanvas.Free;
 end;
end;
                       
{$IFDEF CLX}
function GrabCursorPixel: TColor;
var
  aWinHandle: QWidgetH;
  aWinId: Cardinal;
  aBitmap: TBitmap;
begin
 aBitmap:=TBitmap.Create;
 try
  aWinHandle:= QApplication_desktop;
  aWinId:= QWidget_winId(aWinHandle);
  with Mouse.CursorPos do
   QPixmap_grabWindow(aBitmap.Handle, aWinId, x, y, 1, 1);
  Result:=aBitmap.Canvas.Pixels[0,0];
 finally
  aBitmap.Free;
 end;
end;
{$ENDIF}

procedure TColorPicker.Timer1Timer(Sender: TObject);
var col:TColor;
begin
{$IFNDEF CLX}
 with Mouse.CursorPos do
  col:=ScreenCanvas.Pixels[X,Y];//GetPixel(GetDC(0), X, Y);
{$ELSE}
 col:=GrabCursorPixel;
{$ENDIF}
 Panel1.Style.BackgroundColor:=col;
 if [ssCtrl]*GetShiftState<>[] then
  Panel2.Style.BackgroundColor:=col;
end;

procedure TColorPicker.FormShow(Sender: TObject);
begin                 
{$IFNDEF CLX}
 SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
{$ENDIF}
end;

procedure TColorPicker.PopupMenu1Popup(Sender: TObject);
begin
 (PopupMenu1.PopupComponent as TControl).Parent.SetFocus; //CommitChanges purpose
end;

procedure TColorPicker.CopyColortoClipboard1Click(Sender: TObject);
var col:TColor;
    picker:TdhColorPicker;
begin
 picker:=PopupMenu1.PopupComponent as TdhColorPicker;
 Clipboard.AsText:=dhPanel.ColorToString(picker.CSSColor);
end;

procedure TColorPicker.GetColorfromClipboard1Click(Sender: TObject);
var icol:Longint;
    s,sred,sblue,sgreen,salpha:string;
    g:tg;
    SaveSeparator:Char;
begin
 s:=LowerCase(Trim(Clipboard.AsText));
 if not dhPanel.IdentToColor(s,icol) then
 if (s<>'') and (s[1]='#') and TryStrToInt('$'+Copy(s,2,maxint),icol) then
 begin
  icol:=Longint(Color32ToCSSColor(TColor32(icol) or $FF000000));
 end else
 if g.init(s) and g.Over('rgba(') and g.SaveOverPos(',',sred) and g.SaveOverPos(',',sgreen) and g.SaveOverPos(',',sblue) and g.SaveOverPos(')',salpha) then
 begin
   SaveSeparator := DecimalSeparator;
   DecimalSeparator := '.';
   try
    icol:=Longint(Color32ToCSSColor(Color32(StrToInt(Trim(sred)),StrToInt(Trim(sgreen)),StrToInt(Trim(sblue)),Round(255*StrToFloat(Trim(salpha))))));
   finally
    DecimalSeparator := SaveSeparator;
   end;
 end else
 if not TryStrToInt(s,icol) then
 begin
  ShowMessage('Found no HTML color format in clipboard. The format must be #RRGGBB, rgba(0 - 255,0 - 255,0 - 255,0.0 - 1.0) or a valid color name.');
  exit;
 end;
 (PopupMenu1.PopupComponent as TdhColorPicker).DoColorChange(TCSSColor(icol));
end;



procedure TColorPicker.FormCreate(Sender: TObject);
begin     
 FixDialogBorderStyle(Self);
end;

end.
