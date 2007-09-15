unit dhDirectHTML;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics,
  {$ELSE}
  Controls, Windows, Messages, Graphics,
  {$ENDIF}
   SysUtils, Classes,
  dhPanel,math;

type
  //TInsertLocation=(ilCurrent,ilHead,ilBody);
  TdhDirectHTML = class(TdhPanel)
  private
    { Private declarations }
    FHTML:HypeString;
    FGenerateContainer:boolean;
  protected
    { Protected declarations }
    procedure DoTopPainting; override;
    function NeedPadding(HasRastering:TRasterType): boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    function AllHTMLCode:HypeString; override;
  published
    { Published declarations }
    property InnerHTML: HypeString read FHTML write FHTML;
    property GenerateContainer:boolean read FGenerateContainer write FGenerateContainer default true;
  end;

{$R 'dhDirectHTML.dcr'}

procedure Register;

implementation

var TempBitmap:TBitmap;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhDirectHTML]);
end;


function TdhDirectHTML.AllHTMLCode:HypeString;
begin
 result:=FHTML;
end;

procedure TdhDirectHTML.GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
var PicWidth,PicHeight,W,H:integer;
begin
 PicWidth:=16;
 PicHeight:=15;
  with AllEdgesPure do
  begin
   W:=PicWidth+Left+Right;
   H:=PicHeight+Top+Bottom;
  end;
  W:=max(W,20);
  H:=max(H,19);
  if not TextOnly then
   AdjustLittle(W,H,false);

 if AllowModifyX then
  NewWidth:=W;
 if AllowModifyY then
  NewHeight:=H;


 GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth,NewHeight);
end;

{constructor TdhPureHTML.Create(AOwner: TComponent);
begin
  inherited;
  //bit:=LoadBitmap(HInstance, 'TDHPUREHTML');
  //if bit<>0 then
  begin
   //TempBitmap.Handle := bit;
  end;
  FInsertText:=TStringList.Create;
  FHTML:=TStringList.Create;
  //showmessage('HBITMAP:'+inttostr(bit));
end;    }



procedure TdhDirectHTML.DoTopPainting;
var FPicture:TGraphic;
begin

 if (csDesigning in ComponentState) then
 begin
   if (TempBitmap=nil) then
   begin
    TempBitmap := TBitmap.Create;
    TempBitmap.LoadFromResourceName(HInstance, 'TDHDIRECTHTMLPURE');  
    TempBitmap.Transparent:=true;
    TempBitmap.TransparentColor:=clYellow;
    //PageControlBitmap.Transparent:=true;
    //PageControlBitmap.TransparentColor:=clYellow;
   end;

  if (TempBitmap<>nil) then
  if not IsRasterized and not HasBackgroundImage(FPicture) then
  //with self.FCommon.AllEdgesPure do GetCanvas.Draw(Top,Left,TempBitmap);
  //GetCanvas.Draw(Max(0,(Width-TempBitmap.Width) div 2),Max(0,(Height-TempBitmap.Height) div 2),TempBitmap);
  with Self.AllEdgesPure do
   GetCanvas.Draw(max(-2,-4+Left),max(-2,-4+Top),TempBitmap);
 end;


 begin
  PaintOuterBorder;
  PaintOuterBg;
  DrawFrame;
 end;
end;

{procedure TdhDirectHTML.Paint;
begin
 if (csDesigning in ComponentState) and (TempBitmap=nil) then
 begin
   TempBitmap := TBitmap.Create;
   TempBitmap.LoadFromResourceName(HInstance, 'TdhDirectHTML');
 end;
 if (TempBitmap<>nil) then
 begin
  Canvas.Draw(0, 0, TempBitmap);
 end;
end;}



constructor TdhDirectHTML.Create(AOwner: TComponent);
begin
 inherited;
 self.AutoSizeXY:=asXY;
 FGenerateContainer:=true;
 ControlStyle := ControlStyle - [csAcceptsControls];
end;

function TdhDirectHTML.NeedPadding(HasRastering:TRasterType): boolean;
begin
 result:=HasRastering<>rsNo;
end;

initialization
// RegisterClasses([TdhPage]);

finalization

 FreeAndNil(TempBitmap);


end.
