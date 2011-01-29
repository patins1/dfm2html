unit dhEdit;

interface

uses
   Types, SysUtils, Classes, dhPanel, dhLabel, dhStrUtils, dhStyles;

type
  TdhCustomEdit = class(TdhCustomLabel)
  private
    FReadOnly: boolean;
  protected
    FInitialValue:HypeString;
    procedure NearestMod(m,frame:integer; var n,times:integer);
    procedure Loaded; override;
    procedure GetModifiedText(var pre,s,suc:HypeString); override;
    function NeedPadding(HasRastering:TRasterType): boolean; override;
    function EffectsAllowed: boolean; override;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    procedure GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows, Cols: Integer); virtual;
  public
    property ReadOnly:boolean read FReadOnly write FReadOnly default False;
    procedure Reset;
    procedure Memorize;
  published
    property HTMLAttributes;
    property ImageType;
    property ImageFormat;
    property Style;
    property Use;
    property Transparent;
    property AutoSizeXY;
    property Color;
    property Font;
    property Visible;
    property Align;
    property Anchors;
    property Constraints;
    property Enabled;
    property ParentShowHint;
    property ShowHint;
    property Right;
    property Bottom;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

  TdhEdit = class(TdhCustomEdit)
  private
    FPassword: boolean;
    procedure SetPassword(const Value: boolean);
  protected
    function GetFinal:ICon; override;
    procedure SetHTMLText(const Value:HypeString); override;
    procedure GetModifiedText(var pre, s, suc: HypeString); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ReadOnly;
    property Password:boolean read FPassword write SetPassword default false;
    property Text:HypeString read FHTMLText write SetHTMLText;
  end;

procedure Register;

implementation

uses BasicHTMLElements;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhEdit]);
end;

procedure TdhCustomEdit.NearestMod(m,frame:integer; var n,times:integer);
begin
 times:=((n-frame)+m div 2) div m;
 n:=times * m + frame;
end;

procedure TdhCustomEdit.GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows,Cols: Integer);
begin
  Rows:=0;
  Cols:=0;
  with AllEdgesPure do
  begin
   if AllowModifyY then
    NewHeight:=TextExtent('Wg').cy+Bottom+Top;
   if AllowModifyX then
    NearestMod(TextExtent('X').cx,Left+Right,NewWidth,Cols);
  end;
end;

procedure TdhCustomEdit.GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
var dummyRows,dummyCols:integer;
begin
 if GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth,NewHeight) then exit;
 GetRowsCols(AllowModifyX,AllowModifyY,NewWidth, NewHeight, dummyRows,dummyCols);
end;

constructor TdhEdit.Create(AOwner: TComponent);
begin
  inherited;
  IsScrollArea:=true;
  FVertScrollbarNeverVisible:=true;
  FHorzScrollbarNeverVisible:=true;
  Width:=121;
end;

function TdhEdit.GetFinal: ICon;
begin
  result:=nil;
  if AssertTags2 then
   result:=dhStrEditDlg.edit;
end;

function TdhCustomEdit.EffectsAllowed: boolean;
begin
 result:=false;
end;

procedure TdhCustomEdit.GetModifiedText(var pre, s, suc: HypeString);
begin
  s:=ConvertWideStringToUnicode(s,true)+#10;
end;

procedure TdhCustomEdit.Loaded;
begin
  inherited;
  Memorize;
end;

procedure TdhCustomEdit.Memorize;
begin                  
  FInitialValue:=FHTMLText;
end;

function TdhCustomEdit.NeedPadding(HasRastering:TRasterType): boolean;
begin
 result:=HasRastering<>rsNo;
end;

procedure TdhCustomEdit.Reset;
begin
 SetHTMLText(FInitialValue);
end;

procedure TdhEdit.SetHTMLText(const Value: HypeString);
begin
  inherited SetHTMLText(HypeSubstText(#13,' ',Value));
end;

procedure TdhEdit.SetPassword(const Value: boolean);
begin
 if FPassword<>Value then
 begin
  FPassword := Value;
  NotifyCSSChanged([wcText,wcNoOwnCSS]);
 end;
end;

procedure TdhEdit.GetModifiedText(var pre, s, suc: HypeString);
begin
 if FPassword then
  s:=StringOfChar('*',length(s));
 inherited;
end;

end.
