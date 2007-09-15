unit uConvertGraphicsFormat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dhPanel, GR32,GIFImage,jpeg,pngimage,unit3, ExtCtrls;

type
  TConvertGraphicsFormat = class(TForm)
    Label1: TLabel;
    bSaving: TButton;
    bConvert: TButton;
    Panel1: TPanel;
    cSingleGIF: TCheckBox;
    cAnimatedGIF: TCheckBox;
    cBitmap: TCheckBox;
    cJPEG: TCheckBox;
    cNoIncrease: TCheckBox;
    Label2: TLabel;
    Panel2: TPanel;
    cToGIF: TRadioButton;
    cToPNG: TRadioButton;
    cPNG: TCheckBox;
    Button1: TButton;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bConvertClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    page:TPageContainer;
  public
    { Public declarations }
    procedure Prepare(page:TPageContainer);
  end;

var
  ConvertGraphicsFormat: TConvertGraphicsFormat;

implementation

{$R *.dfm}

procedure TConvertGraphicsFormat.Prepare(page: TPageContainer);
begin
 self.page:=page;
 bConvertClick(nil);
 ShowModal;
end;

procedure TConvertGraphicsFormat.FormCreate(Sender: TObject);
begin
 FixDialogBorderStyle(Self);
end;

function StreamSize(s:TGraphic):integer;
var stream:TMemoryStream;
begin
 stream:=TMemoryStream.Create();
 try
  s.SaveToStream(stream);
  result:=stream.Size;
 finally
  stream.Free;
 end;
end;


procedure TConvertGraphicsFormat.bConvertClick(Sender: TObject);
var i:integer;
    pn:TdhCustomPanel;
    state:TState;
    bmp:TBitmap32;
    Graphic:TGraphic;
    png:TGraphic;
    size_ori,size_converted,count,increase_ori,increase_converted:integer;
    ratio:string;
begin
 size_ori:=0;
 size_converted:=0;
 count:=0;
 cAnimatedGIF.Enabled:=false;
 cSingleGIF.Enabled:=false;
 cBitmap.Enabled:=false;
 cJPEG.Enabled:=false;
 cPNG.Enabled:=false;
 for i:=0 to page.ComponentCount-1 do
 if (page.Components[i] is TdhCustomPanel) then
 begin
  pn:=TdhCustomPanel(page.Components[i]);
  for state:=low(TState) to high(TState) do
  if (pn.StyleArr[state]<>nil) then
  begin
   Graphic:=pn.StyleArr[state].BackgroundImage.Graphic;
   if graphic=nil then continue;
   //if Graphic is TPNGObject then continue;
{.$IFNDEF CLX}
   if Graphic is TGifImage then
   if TGifImage(Graphic).Images.Count>1 then
   begin                   
    cAnimatedGIF.Enabled:=true;
    if not cAnimatedGIF.Checked then continue;
   end else
   begin
    cSingleGIF.Enabled:=true;
    if not cSingleGIF.Checked then continue;
   end;
   if (Graphic is TBitmap) then
   begin
    cBitmap.Enabled:=true;
    if not cBitmap.Checked then continue;
   end;
   if (Graphic is TJPEGImage) then
   begin
    cJPEG.Enabled:=true;
    if not cJPEG.Checked then continue;
   end;
{.$ENDIF}
   if (Graphic is TPNGObject) then
   begin
    cPNG.Enabled:=true;
    if not cPNG.Checked then continue;
   end;
   if Sender=nil then continue;

   GetAs32(Graphic,bmp);
   try
    png:=nil;
    if cToPNG.Checked then
    begin
  {.$IFNDEF CLX}
     if Graphic is TGifImage then
     png:=GetPNGObjectPTFromGifAndBitmap32(bmp,TGifImage(Graphic)) else 
 {.$ENDIF}
     png:=GetPNGObjectFromBitmap32(bmp) as TPNGObject;
    end;
    if cToGIF.Checked then
    begin             
     png:=GetGIFImageFromBitmap32(bmp,bmp);
    end;
    try
     if Sender=bSaving then
     begin
      increase_ori:=StreamSize(Graphic);
      increase_converted:=StreamSize(png);
      if (increase_ori<=increase_converted) and cNoIncrease.Checked then continue;
      Inc(size_ori,increase_ori);
      Inc(size_converted,increase_converted);
      Inc(count);
     end;     
     if Sender=bConvert then
     begin
      if cNoIncrease.Checked then
      begin    
       increase_ori:=StreamSize(Graphic);
       increase_converted:=StreamSize(png);
       if (increase_ori<=increase_converted) and cNoIncrease.Checked then continue;
      end;
      pn.StyleArr[state].BackgroundImage.Assign(png);  
      Inc(count);
     end;
    finally
     png.Free;
    end;
   finally
    bmp.Free;
   end;
  end;
 end;
 if Sender=bSaving then
 begin
  if Count<>0 then
   ratio:=FloatToStrF(size_converted/size_ori*100,ffFixed,7,2)+'%' else
   ratio:='100%';
  ShowMessage('Count of target images: '+inttostr(count)+#13#10+
              'Old total size in bytes: '+inttostr(size_ori)+#13#10+
              'New total size in bytes: '+inttostr(size_converted)+#13#10+
              'Ratio: '+ratio+#13#10+
              'Total saving in bytes: '+inttostr(size_ori-size_converted)+#13#10
              );
 end;
 if Sender=bConvert then
 begin
  if Count<>0 then
  begin
   ShowMessage('Done!');
   page.SetModified('Graphic Conversion');
  end else
   ShowMessage('Nothing to do!');
 end;
end;

procedure TConvertGraphicsFormat.FormKeyPress(Sender: TObject;
  var Key: Char);
begin        
 if Key=Char(VK_ESCAPE) then
 begin
  ModalResult:=mrCancel;
  Key:=#0;
 end;
end;

end.
