unit dhDirectHTML;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics,
  {$ELSE}
  Controls, Windows, Messages, Graphics,
  {$ENDIF}
   SysUtils, Classes,
  dhPanel,math,dhStrUtils;

type
  TdhDirectHTML = class(TdhPanel)
  private
    FHTML:HypeString;
    FGenerateContainer:boolean;
  protected
    procedure DoTopPainting; override;
    function NeedPadding(HasRastering:TRasterType): boolean; override;
    procedure SetASXY(const Value: TASXY); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    function AllHTMLCode:HypeString; override;
  published
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

procedure TdhDirectHTML.SetASXY(const Value: TASXY);
begin
 Inherited;
 NotifyCSSChanged([wcNoOwnCSS,wcNoComputedCSS]);
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

procedure TdhDirectHTML.DoTopPainting;
begin
 if (csDesigning in ComponentState) then
 begin
   if (TempBitmap=nil) then
   begin
    TempBitmap := TBitmap.Create;
    TempBitmap.LoadFromResourceName(HInstance, 'TDHDIRECTHTMLPURE');
    TempBitmap.Transparent:=true;
    TempBitmap.TransparentColor:=clYellow;
   end;
  if (TempBitmap<>nil) then
  if not IsRasterized and not HasBackgroundImage then
  with Self.AllEdgesPure do
   GetCanvas.Draw(max(-2,-4+Left),max(-2,-4+Top),TempBitmap);
 end;
 if FAutoSize<>asXY then PaintBorder else PaintOuterBorder;
 PaintOuterBg;
 DrawFrame;
end;

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

finalization
 FreeAndNil(TempBitmap);
end.
