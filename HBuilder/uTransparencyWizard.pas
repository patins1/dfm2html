unit uTransparencyWizard;

interface

uses           
  SysUtils, types,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QStdCtrls, QExtCtrls, QMenus, QTntStdCtrls,
  QMask,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, Menus,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, Buttons,ComCtrls,Spin,TntForms, TntStdCtrls,
  TntButtons,
{$ENDIF}
  dhLabel, dhMenu, dhPanel, Classes,
  dhColorPicker,gr32,  MySpinEdit,  MyTrackBar, DKLang;

type
  TTransparencyWizard = class(TTntForm)
    SampleGradient: TdhPanel;
    FirstColor: TdhColorPicker;
    Button1: TTntButton; 
    Label5: TdhLabel;
    spMasterAlpha: TMySpinEdit;
    Label17: TLabel;
    slMasterAlpha: TMyTrackBar;
    DKLanguageController1: TDKLanguageController;
    procedure FirstColorColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spMasterAlphaValueChange(Sender: TObject; Clear: Boolean);
  private
    procedure BGChanged;
    { Private declarations }
  public
    { Public declarations }    
    procedure GetBG(pic: TPersistent; w, h: integer);
    procedure Prepare(Pn: TdhCustomPanel);

  end;

var
  TransparencyWizard: TTransparencyWizard;

implementation
uses unit2;

{$R *.dfm}

{ TForm5 }

procedure TTransparencyWizard.GetBG(pic: TPersistent; w, h: integer);
var zw:TColor;
//    JPEG:TJPEGImage;
    Bitmap:TBitmap32;
    i:integer;
    Col,LastCol:TColor32;
    skip:boolean;
    l:integer;
    src:TPersistent;

begin
 Bitmap:=TBitmap32.Create;
 Bitmap.DrawMode:=dmBlend;

 Bitmap.Width:=1;
 Bitmap.Height:=1;
 Bitmap.Pixels[0,0]:=(Color32(FirstColor.Color) and $FFFFFF)  or (Adj100to255(spMasterAlpha.Value) shl 24);

 src:=GetPNGObjectFromBitmap32(Bitmap{,true});
 pic.Assign(src);
 Bitmap.Free;
 src.Free;


end;

procedure TTransparencyWizard.Prepare(Pn: TdhCustomPanel);
var FPicture:TGraphic;
    Bitmap:TBitmap32;
begin
 SampleGradient.Style.BackgroundRepeat:=cbrRepeat;
 SampleGradient.Style.BackgroundPosition:='';
 if Pn.HasBackgroundImage(FPicture) then
 begin
  //if cVert.Checked then
  Bitmap:=GetAs32(FPicture);
  FirstColor.Color:=WinColor(Bitmap.Pixels[0,Bitmap.Height-1]);
  spMasterAlpha.Value:=Adj255to100(Bitmap.Pixels[0,Bitmap.Height-1] shr 24 and $FF);
 end;
 BGChanged;
end;
             
procedure TTransparencyWizard.BGChanged;
begin
 GetBG(SampleGradient.Style.BackgroundImage,SampleGradient.Width,SampleGradient.Height);
 SampleGradient.DesignPaintingChanged;
end;

procedure TTransparencyWizard.FirstColorColorChanged(Sender: TObject);
begin
 BGChanged;
end;

procedure TTransparencyWizard.FormCreate(Sender: TObject);
begin
 spMasterAlpha.StoredValue:=100;  
 FixDialogBorderStyle(Self);
end;

procedure TTransparencyWizard.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=VK_ESCAPE then
  ModalResult:=mrCancel;
end;

procedure TTransparencyWizard.spMasterAlphaValueChange(Sender: TObject;
  Clear: Boolean);
begin
 BGChanged;
end;

end.
