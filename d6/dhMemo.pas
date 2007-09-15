unit dhMemo;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls, QGraphics, QDialogs, QForms,
  {$ELSE}
  Controls, Windows, Messages, Graphics,
  {$ENDIF}
  SysUtils, Classes, dhPanel, dhLabel, dhEdit;

type
  TdhMemo = class(TdhCustomEdit)
  private
    { Private declarations }
    //FItems: TStrings;
    FWrap: boolean;
    procedure SetItems(const Value: TStrings);
    //procedure ItemsChanged(Sender: TObject);
    //procedure RecreateText;
    procedure SetWrap(const Value: boolean);
  protected
    { Protected declarations }
    procedure GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows, Cols: Integer); override;
    function GetFinal:ICon; override;
    function WrapAlways: boolean; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    { Public declarations }
    procedure SetMemoText(const Value:HypeString);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property ReadOnly;
    //property Lines: TStrings read FItems write SetItems;
    property Text:HypeString read FHTMLText write SetHTMLText;
    property Wrap:boolean read FWrap write SetWrap default true;
  end;

procedure Register;

implementation

uses BasicHTMLElements;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhMemo]);
end;

{ TdhMemo }

constructor TdhMemo.Create(AOwner: TComponent);
begin
  inherited;
  FWrap:=true;
  {FItems := TStringList.Create;
  TStringList(FItems).OnChange:=ItemsChanged;}

  IsScrollArea:=true;
  FVertScrollbarNeverVisible:=false;
  FHorzScrollbarNeverVisible:=true;
  FVertScrollbarAlwaysVisible:=true;
  FHorzScrollbarAlwaysVisible:=false;

  AutoSizeXY:=asNone;
  SetBounds(0,0,185,89);
  //FMultilineEnabled:=true;
end;


destructor TdhMemo.Destroy;
begin
  //FreeAndNil(FItems);
  inherited;
end;

function TdhMemo.GetFinal: ICon;
begin        
  result:=nil;
  if AssertTags2 then
   result:=dhStrEditDlg.memo;
end;

procedure TdhMemo.GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows,Cols: Integer);
var Rect,scrolls:TRect;
begin
  Rows:=0;
  Cols:=0;
  scrolls:=ScrollEdgesPure;
  with AllEdgesPure do
  begin
   if AllowModifyY then
    NearestMod(TextExtent('Wg').cy,Bottom+Top+{HorzScrollbar}scrolls.Bottom+scrolls.Top,NewHeight,Rows);
   if AllowModifyX then
    NearestMod(TextExtent('X').cx,Left+Right+{VertScrollbar}+scrolls.Left+scrolls.Right,NewWidth,Cols);
  end;
end;

{procedure TdhMemo.ItemsChanged(Sender: TObject);
begin
  RecreateText;
end;}

{procedure TdhMemo.RecreateText;
begin
 SetHTMLText(Lines.Text);
end;
}
procedure TdhMemo.SetItems(const Value: TStrings);
begin
 if Value<>nil then
  Text:=Value.Text;
{  if Assigned(FItems) then
    FItems.Assign(Value)
  else
    FItems := Value;}
end;

procedure TdhMemo.SetWrap(const Value: boolean);
begin
 if FWrap<>Value then
 begin
  FWrap := Value;
  FHorzScrollbarAlwaysVisible:=not FWrap;
  FHorzScrollbarNeverVisible:=FWrap;
  NotifyCSSChanged([wcSize,wcText2,wcNoOwnCSS]);  
 end;
end;

function TdhMemo.WrapAlways:boolean;
begin
 Result:=Wrap;
end;

procedure TdhMemo.DefineProperties(Filer: TFiler);
begin
 inherited;
 //Filer.DefineProperty('Lines.Items',  SetItems, nil,false);
end;


procedure TdhMemo.SetMemoText(const Value: HypeString);
begin
 Text:=Value;
end;

end.
