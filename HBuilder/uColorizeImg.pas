unit uColorizeImg;

interface

uses
  SysUtils, Classes, types,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QStdCtrls, QExtCtrls, QComCtrls,
  QMask, QTntStdCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, UnicodeCtrls,
{$ENDIF}
  GR32, GR32_Image, math, {$IFDEF VER210}GIFImg{$ELSE}GIFImage{$ENDIF}, hComboBox, unit3, dhPanel, MyTrackBar, dhLabel, DKLang,
  MyPanel,dhGraphicFormats;

//const WM_DelayDraw = WM_USER + 3;
type
  TColorizeImg = class(TTntForm)
    cImg: TComboBox;
    Button1: TTntButton;
    Button2: TTntButton;
    lStats: TdhLabel;
    Button3: TTntButton;
    Panel1: TMyPanel;
    Label1: TdhLabel;
    Label2: TdhLabel;
    DEGREE_Label3: TdhLabel;
    DEGREE_Label4: TdhLabel;
    Label5: TdhLabel;
    DEGREE_Label6: TdhLabel;
    DEGREE_Label7: TdhLabel;
    DEGREE_Label8: TdhLabel;
    Label9: TdhLabel;
    DEGREE_Label10: TdhLabel;
    DEGREE_Label11: TdhLabel;
    slSaturation: TMyTrackBar;
    slLightness: TMyTrackBar;
    slHoe: TMyTrackBar;
    DKLanguageController1: TDKLanguageController;
    lAverageSaturation: TdhLabel;
    lAverageLightness: TdhLabel;
    procedure slSaturationChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cImgDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cImgDrawItemCLX(Sender: TObject; Index: Integer;
    Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
    procedure cImgChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cImgClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cImgMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
  private
    { Private declarations }
    bmp32:TBitmap32;
    bgcolor:TColor;
    adj:boolean;
    Graphic:TGraphic;
    bmp32Height:integer;
    function GetImg(deg:single; DoStats:boolean): TBitmap32;
//    Procedure WMDelayDraw(Var Msg: TMessage); message WM_DelayDraw;
  public
    { Public declarations }
    function Prepare(Graphic:TGraphic; bgcol:TColor):boolean;
    procedure GetBG(pic: TPersistent);
  end;

var
  ColorizeImg: TColorizeImg;

implementation

{$R *.dfm}

{ TColorizeImg }

function TColorizeImg.Prepare(Graphic:TGraphic; bgcol:TColor): boolean;
begin
 FreeAndNil(bmp32);
 bmp32:=GetAs32(Graphic);
 if bmp32=nil then
 begin
  result:=false;
  exit;
 end;
 Self.Graphic:=Graphic;
 Self.bgcolor:=bgcol;
 slSaturationChange(nil);
 cImg.Width:=bmp32.Width+2*3+16;
 bmp32Height:=bmp32.Height;
 cImg.ItemHeight:=bmp32.Height;

{$IFDEF CLX}
 cImg.DropDownCount:=Max((ClientHeight-(cImg.Top+cImg.Height)) div bmp32.Height,1);
{$ELSE}
 cImg.DropDownCount:=Max(Screen.Height div bmp32.Height,1);
{$ENDIF}
 //cImg.Color:=(bgcolor);
 Result:=ShowModal=mrOk;
end;

procedure TColorizeImg.slSaturationChange(Sender: TObject);  
var i:integer;
    lLock:boolean;
begin
 if adj then exit;
//  PostMessage(Handle,WM_DelayDraw,0,slSaturation.Value+1000*slLightness.Value+1000*1000*slHoe.Value);
 //cImgDrawItem(nil,-1,Rect(3,3,cImg.Width-3-16,cImg.Height-3),[odComboBoxEdit]);
 cImg.Invalidate;
end;

function TColorizeImg.GetImg(deg:single; DoStats:boolean):TBitmap32;
var i,pixels:integer;
var P: PColor32;
    Color:TColor32;
    H,S,L,Saturation,Lightness,AllSaturation,AllLightness:Single;
begin
 Saturation:=slSaturation.Value/100;
 Lightness:=slLightness.Value/100;
 Result:=TBitmap32.Create;
 Result.Assign(bmp32);
 Result.DrawMode:=dmBlend;
 P:=Result.PixelPtr[0,0];
 AllSaturation:=0;
 AllLightness:=0;
 pixels:=0;
 for i:=0 to Result.Width*Result.Height-1 do
 begin
  Color:=P^;
  RGBtoHSL(Color,H,S,L);
  H:=H+deg;
  {if H>=1 then
   H:=H-1;}
  S:=S*Saturation;
  if S>1 then
   S:=1;
  L:=L*Lightness;
  if L>1 then
   L:=1;
  if DoStats then
  begin
   AllSaturation:=AllSaturation+S*(Color shr 24);
   AllLightness:=AllLightness+L*(Color shr 24);
   inc(pixels,(Color shr 24));
  end;
  P^:=(HSLtoRGB(H,S,L) and $FFFFFF) or (Color and $FF000000);
  inc(P);
 end;
 if DoStats then
 begin
  if pixels<>0 then
  lStats.Text
  :=lAverageSaturation.Text+' = '+IntToStr(round(AllSaturation/pixels*100))+'% '+lAverageLightness.Text+' = '+IntToStr(round(AllLightness/pixels*100))+'%' else
  lStats.Text:='';
 end;
end;


{function TColorizeImg.GetImg(Red1,Red2,Red3,Green1,Green2,Green3,Blue1,Blue2,Blue3:integer):TBitmap32;

var i:integer;
var P: PColor32;
    Color:TColor32;
    H,S,L:single;

function Get(R,G,B:integer):integer;
begin
 result:=(R*RedComponent(Color)+G*GreenComponent(Color)+B*BlueComponent(Color)) div 100;
 if result>255 then
  result:=255;
end;

begin
 Result:=TBitmap32.Create;
 Result.Assign(bmp32);
 Result.DrawMode:=dmBlend;
 P:=Result.PixelPtr[0,0];
 for i:=0 to Result.Width*Result.Height-1 do
 begin
  Color:=P^;
  P^:=Color32(Get(Red1,Red2,Red3),
              Get(Green1,Green2,Green3),
              Get(Blue1,Blue2,Blue3),AlphaComponent(Color));
  inc(P);
 end;
end;
}

procedure TColorizeImg.FormKeyPress(Sender: TObject; var Key: Char);
begin     
 if Key=Char(VK_ESCAPE) then
 begin
  ModalResult:=mrCancel;
  Key:=#0;
 end;
end;

const c=50;

const perm:array[0..11,0..8] of byte=(
             (2,0,0,
              0,2,0,
              0,0,2),
             (2,0,0,
              0,0,2,
              0,2,0),
             (0,2,0,
              2,0,0,
              0,0,2),
             (0,2,0,
              0,0,2,
              2,0,0),
             (0,0,2,
              2,0,0,
              0,2,0),
             (0,0,2,
              0,2,0,
              2,0,0),    

             (0,1,1,
              1,0,1,
              1,1,0),
             (0,1,1,
              1,1,0,
              1,0,1),
             (1,0,1,
              0,1,1,
              1,1,0),
             (1,0,1,
              1,1,0,
              0,1,1),
             (1,1,0,
              0,1,1,
              1,0,1),
             (1,1,0,
              1,0,1,
              0,1,1));

procedure TColorizeImg.cImgDrawItemCLX(Sender: TObject; Index: Integer;
    Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
begin
 cImgDrawItem(nil,Index,Rect,State);
 Handled:=true;
end;

procedure TColorizeImg.cImgDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var b,b2:TBitmap32;
begin
 if odComboBoxEdit in State then
 begin
 b:=GetImg(slHoe.Value*DegToGrad(1)/400,true{,slRed1.Value,slRed2.Value,slRed3.Value,
           slGreen1.Value,slGreen2.Value,slGreen3.Value,
           slBlue1.Value,slBlue2.Value,slBlue3.Value});
 end else
 begin
 b:=GetImg(Index*DegToGrad(30)/400,false{,perm[Index][0]*c,perm[Index][1]*c,perm[Index][2]*c,
           perm[Index][3]*c,perm[Index][4]*c,perm[Index][5]*c,
           perm[Index][6]*c,perm[Index][7]*c,perm[Index][8]*c});
 end;
 b2:=TBitmap32.Create;
 try
 b2.Width:=Rect.Right-Rect.Left;
 b2.Height:=Rect.Bottom-Rect.Top;
 b2.Clear(Color32(bgcolor));
 b.DrawTo(b2);
 if not b2.Empty then
 cImg.Canvas.CopyRect(Bounds(Rect.Left,Rect.Top,b2.Width,b2.Height),b2.Canvas,b2.BoundsRect);
 //b.DrawTo(ComboBox1.Canvas.handle,Rect.Left,Rect.Top);
 finally;
  b.Free;
  b2.Free;
 end;
end;

procedure TColorizeImg.cImgChange(Sender: TObject);
var Index:integer;
     H,S,L:single;
begin
{ RGBtoHSL(Color32(255,0,0),H,S,L);
 RGBtoHSL(Color32(0,255,0),H,S,L);
 RGBtoHSL(Color32(0,0,255),H,S,L);
 RGBtoHSL(Color32(0,0,0),H,S,L);
 RGBtoHSL(Color32(255,255,255),H,S,L);
 RGBtoHSL(Color32(255,255,0),H,S,L);
 RGBtoHSL(Color32(255,0,255),H,S,L);
 RGBtoHSL(Color32(0,255,255),H,S,L);}
 {adj:=true;
 Index:=ComboBox1.ItemIndex;
 slRed1.Value:=perm[Index][0]*c;
 slRed2.Value:=perm[Index][1]*c;
 slRed3.Value:=perm[Index][2]*c;
 slGreen1.Value:=perm[Index][3]*c;
 slGreen2.Value:=perm[Index][4]*c;
 slGreen3.Value:=perm[Index][5]*c;
 slBlue1.Value:=perm[Index][6]*c;
 slBlue2.Value:=perm[Index][7]*c;
 slBlue3.Value:=perm[Index][8]*c;
 adj:=false;   }
end;

procedure TColorizeImg.FormCreate(Sender: TObject);
begin
 //self.DoubleBuffered:=true;

 //slSaturation.DoubleBuffered:=true;
{$IFNDEF CLX}
 cImg.DoubleBuffered:=true;
{$ELSE}
 cImg.OnDrawItem:=cImgDrawItemCLX;
 slSaturation.Position:=100; //at CLX set to 10
 slLightness.Position:=100;
{$ENDIF}
end;

procedure TColorizeImg.GetBG(pic: TPersistent);
var
    Bitmap:TBitmap32;
    src:TPersistent;
begin
 Bitmap:=GetImg(slHoe.Value*DegToGrad(1)/400,false);
 try           
  if Graphic is TGifImage then
   src:=GetGifImageFromBitmap32(Bitmap,Bitmap) else
   src:=GetPNGObjectFromBitmap32(Bitmap{,true});
  try
   pic.Assign(src);
  finally;
   src.Free;
  end;
 finally;
  Bitmap.Free;
 end;
end;

procedure TColorizeImg.FormDestroy(Sender: TObject);
begin
 FreeAndNil(bmp32);
end;

procedure TColorizeImg.cImgClick(Sender: TObject);
begin       
 slHoe.Value:=cImg.ItemIndex*30;
end;

{procedure TColorizeImg.WMDelayDraw(var Msg: TMessage);
begin
 if Msg.LParam<>slSaturation.Value+1000*slLightness.Value+1000*1000*slHoe.Value then exit;
 cImgDrawItem(nil,-1,Rect(3,3,cImg.Width-3-16,cImg.Height-3),[odComboBoxEdit]);
//sleep(10);
end;}

procedure TColorizeImg.Button3Click(Sender: TObject);
begin
 slSaturation.Value:=100;
 slLightness.Value:=100;
 slHoe.Value:=0;
end;

procedure TColorizeImg.cImgMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin

 //cImg.Width:=bmp32.Width+2*3+16;
 if bmp32Height<>0 then
  Height:=bmp32Height;
end;

end.
