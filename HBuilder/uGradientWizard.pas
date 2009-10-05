unit uGradientWizard;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QMask, QForms, QButtons, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Mask, Forms, Buttons, Spin, TntForms, TntStdCtrls, TntButtons, TntExtCtrls,
  {$ENDIF}
  SysUtils, Classes,
  dhLabel, dhMenu, dhPanel, dhColorPicker, gr32, DKLang, MySpinEdit, Math;

type
  TGradientWizard = class(TTntForm)
    SampleGradient: TdhPanel;
    rgDirection: TTntRadioGroup;
    Button1: TTntButton;
    FirstColor: TdhColorPicker;
    SecondColor: TdhColorPicker;
    spMasterAlpha: TMySpinEdit;
    lWidth: TdhLabel;
    dhLink1: TdhLink;
    DKLanguageController1: TDKLanguageController;
    lHeight: TdhLabel;
    procedure cVertClick(Sender: TObject);
    procedure cHorzClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FirstColorColorChanged(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dhLink1Click(Sender: TObject);
    procedure spMasterAlphaValueChange(Sender: TObject; Clear: Boolean);
    procedure rgDirectionClick(Sender: TObject);
  private
    { Private declarations }
    procedure BGChanged;
    procedure AdjSize;
  public
    { Public declarations }
    sw,sh:integer;
    LivePreview:TList;
    procedure GetBG(pic: TPersistent; w, h: integer);
    procedure Prepare(pn:TdhCustomPanel; w,h:integer);
  end;

var
  GradientWizard: TGradientWizard;

implementation

uses Unit1;

{$R *.dfm}

procedure TGradientWizard.cVertClick(Sender: TObject);
begin
 SampleGradient.Style.BackgroundRepeat:=cbrRepeatX;
 AdjSize;
 BGChanged;
end;

procedure TGradientWizard.cHorzClick(Sender: TObject);
begin
 SampleGradient.Style.BackgroundRepeat:=cbrRepeatY;
 AdjSize;
 BGChanged;
end;

procedure TGradientWizard.AdjSize;
begin
 if rgDirection.ItemIndex=0 then
 begin
  spMasterAlpha.StoredValue:=sh;
  lWidth.Visible:=false;
  lHeight.Visible:=true;
 end else
 begin
  spMasterAlpha.StoredValue:=sw;
  lWidth.Visible:=true;
  lHeight.Visible:=false;
 end;
end;


function MischCol(c1,c2:TColor32; f1,f2:extended):TColor32;
begin
 result:=Color32(Round(f1*RedComponent(c1)+f2*RedComponent(c2)),Round(f1*GreenComponent(c1)+f2*GreenComponent(c2)),Round(f1*BlueComponent(c1)+f2*BlueComponent(c2)));
end;


procedure TGradientWizard.GetBG(pic:TPersistent; w,h:integer);
var zw:TColor;
    //JPEG:TJPEGImage;
    Bitmap:TBitmap32;
    i,c:integer;
    Col,LastCol:TColor32;
    skip:boolean;
    l:integer;     
    src:TPersistent;
    
function Pixel(i:integer):TColor32;
begin
  if rgDirection.ItemIndex=0 then
   result:=Bitmap.Pixels[0,i] else
   result:=Bitmap.Pixels[i,0];
end;

procedure SetPixel(i:integer; Col:TColor32);
begin
  if rgDirection.ItemIndex=0 then
   Bitmap.Pixels[0,i]:=Col else
   Bitmap.Pixels[i,0]:=Col;
end;

begin
 Bitmap:=TBitmap32.Create;

 //Bitmap.PixelFormat:=pf32bit;
 if rgDirection.ItemIndex=0 then
 begin
  Bitmap.Width:=1;
  Bitmap.Height:=h;
  c:=h-1;
 end else
 begin
  Bitmap.Height:=1;
  Bitmap.Width:=w;
  c:=w-1;
 end;
 for i:=0 to c do
 begin
  if c<=0 then
   Col:=FirstColor.Color else
   Col:=MischCol(Color32(FirstColor.Color),Color32(SecondColor.Color),(c-i)/c,i/c);
  SetPixel(i,Col);
 end;
 (*P1:=Point(0,0);
 P2:=Point(Bitmap.Width-1,Bitmap.Height-1);
  if cVert.Checked then
   L := Bitmap.Height else
   L := Bitmap.Width;
  Bitmap.SetStipple([FirstColor, SecondColor]);
  Bitmap.StippleStep := 1 / L; {2 = 3 - 1 = Number of colors in a pattern - 1}
  Bitmap.StippleCounter := 0;
  Bitmap.LineFSP(P1.X, P1.Y, P2.X, P2.Y);   *)

 {for i:=c-2 downto 2 do
 if not skip then
 begin
  Col:=Pixel(i);
  LastCol:=Pixel(i-1);
  if (Pixel(i+1)=Col) and (Pixel(i-2)=LastCol) then
  begin
   SetPixel(i,LastCol);
   SetPixel(i-1,Col);
   skip:=true;
  end;

 end else
  skip:=false; }
   {
 JPEG := TJPEGImage.Create;
 JPEG.Assign(Bitmap);
 Bitmap.Free;
 //jpeg.SaveToFile('c:\asdf.jpeg');
 pic.Assign(JPEG);
 JPEG.Free;   }                          
 src:=GetPNGObjectFromBitmap32(Bitmap{,false});
 pic.Assign(src);
 Bitmap.Free;
 src.Free;
end;


procedure TGradientWizard.BGChanged;
var I:integer;
    ActStyle:TStyle;
begin
 GetBG(SampleGradient.Style.BackgroundImage,SampleGradient.Width,SampleGradient.Height);
 SampleGradient.DesignPaintingChanged;
 if LivePreview<>nil then
 for I := 0 to LivePreview.Count - 1 do
 begin
  ActStyle:=TStyle(LivePreview[i]);
  ActStyle.Owner.ImageType:=bitTile;
  GetBG(ActStyle.BackgroundImage,sw,sh);
  ActStyle.BackgroundRepeat:=SampleGradient.Style.BackgroundRepeat;
  ActStyle.BackgroundPosition:=SampleGradient.Style.BackgroundPosition;
 end;
end;

procedure TGradientWizard.FormCreate(Sender: TObject);
begin
 FirstColor.Color:=clWhite;
 SecondColor.Color:=clYellow;
 BGChanged;
 FixDialogBorderStyle(Self);
end;

procedure TGradientWizard.Prepare(pn:TdhCustomPanel; w,h:integer);
var FPicture:TGraphic;
    Bitmap:TBitmap32;
begin
 sw:=w;
 sh:=h;
 if pn.BackgroundRepeat=cbrRepeatX then
  rgDirection.ItemIndex:=0 else
  rgDirection.ItemIndex:=1;

 AdjSize;
 if pn.HasBackgroundImage(FPicture) and ((FPicture.Width=1) and (FPicture.Height>=1) or (FPicture.Height=1) and (FPicture.Width>=1)) then
 begin
  //if cVert.Checked then
  Bitmap:=GetAs32(FPicture);
  try
  FirstColor.Color:=WinColor(Bitmap.Pixels[0,0]);
  if rgDirection.ItemIndex=0 then
   SecondColor.Color:=WinColor(Bitmap.Pixels[0,Bitmap.Height-1]) else
   SecondColor.Color:=WinColor(Bitmap.Pixels[Bitmap.Width-1,0]);
  finally
   Bitmap.Free;
  end;
  {Bitmap:=TBitmap.Create;
  Bitmap.PixelFormat:=pf32bit;
  Bitmap.Assign(FPicture.Graphic);
  FirstColor.Color:=Bitmap.Canvas.Pixels[0,0];
  if cVert.Checked then
   SecondColor.Color:=Bitmap.Canvas.Pixels[0,Bitmap.Height-1] else
   SecondColor.Color:=Bitmap.Canvas.Pixels[Bitmap.Width-1,0];
  Bitmap.Free; }
 end;      
 BGChanged;
end;


procedure TGradientWizard.FirstColorColorChanged(Sender: TObject);
begin
 BGChanged;
end;

procedure TGradientWizard.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin            
 if Key=VK_ESCAPE then
  ModalResult:=mrCancel;
end;

procedure TGradientWizard.dhLink1Click(Sender: TObject);
var c:TColor;
begin
 c:=FirstColor.Color;
 FirstColor.Color:=SecondColor.Color;
 SecondColor.Color:=c;
 BGChanged;
end;

procedure TGradientWizard.spMasterAlphaValueChange(Sender: TObject;
  Clear: Boolean);
begin
 if rgDirection.ItemIndex=0 then
 begin
  sh:=max(1,spMasterAlpha.Value);
 end else
 begin
  sw:=max(1,spMasterAlpha.Value);
 end;                   
 BGChanged;
end;

procedure TGradientWizard.rgDirectionClick(Sender: TObject);
begin
 if rgDirection.ItemIndex=0 then
  SampleGradient.Style.BackgroundRepeat:=cbrRepeatX else
  SampleGradient.Style.BackgroundRepeat:=cbrRepeatY;
 AdjSize;
 BGChanged;
end;

end.
