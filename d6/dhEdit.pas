unit dhEdit;

interface

uses
   Types, SysUtils, Classes, dhPanel, dhLabel, dhStrUtils;

type
  TdhCustomEdit = class(TdhCustomLabel)
  private
    FReadOnly: boolean;
    procedure WriteCols(Writer: TWriter);
    procedure WriteRows(Writer: TWriter);
    { Private declarations }
  protected
    { Protected declarations }
    FInitialValue:HypeString;
    //FMultilineEnabled:boolean;
    procedure Loaded; override;
    procedure GetModifiedText(var pre,s,suc:HypeString); override;
    function NeedPadding(HasRastering:TRasterType): boolean; override;
    function EffectsAllowed: boolean; override;
    //function InheritProp(PropChoose:TPropChoose):boolean; override;
    procedure DefineProperties(Filer: TFiler); override;
//    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    procedure GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows, Cols: Integer); virtual;
  public
    { Public declarations }
    //property MultilineEnabled:boolean read FMultilineEnabled;
    property ReadOnly:boolean read FReadOnly write FReadOnly default False;
    procedure Reset;
    procedure Memorize;
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }

    //property Center;
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

    {not interpreted:}
    property Align;
    property Anchors;
    property Constraints;
    property Enabled;
    property ParentShowHint;
    property ShowHint;
                             
    property Right;
    property Bottom;
    
    {property OnCanResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock; }

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

procedure NearestMod(m,frame:integer; var n,times:integer);

implementation

uses BasicHTMLElements;


procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhEdit]);
end;

                      {
function TdhCustomEdit.InheritProp(PropChoose:TPropChoose):boolean;
begin
 result:=PropChoose in (AutoInherit - [pcColor]);
end;
                       }




procedure NearestMod(m,frame:integer; var n,times:integer);
begin
 times:=((n-frame)+m div 2) div m;
 n:=times * m + frame;
end;


procedure TdhCustomEdit.GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows,Cols: Integer);
var Rect:TRect;
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

              (*
function TdhCustomEdit.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var dummyRows,dummyCols:integer;
begin
 if not (csLoading in ComponentState){ and HasParent} then
 begin
   GetRowsCols(NewWidth, NewHeight, dummyRows,dummyCols);
 end;
 result:=true;
end;            *)


{procedure TdhCustomBox.GetAutoRect(AllowModifyX, AllowModifyY: boolean;
  var NewWidth, NewHeight: Integer);
begin
 inherited;
 GetRowsCols(NewWidth, NewHeight, dummyRows,dummyCols);
end;
 }

constructor TdhEdit.Create(AOwner: TComponent);
begin
  inherited;
  IsScrollArea:=true;
  FVertScrollbarNeverVisible:=true;
  FHorzScrollbarNeverVisible:=true;
  //EdgesInScrolledArea:=true;
  Width:=121;
end;

function TdhEdit.GetFinal: ICon;
begin
  result:=nil;
  if AssertTags2 then
   result:=dhStrEditDlg.edit;
 {if FCommon.PreferStyle<>nil then
  result:=nil else }
end;

function TdhCustomEdit.EffectsAllowed: boolean;
begin
 result:=false;
end;

procedure TdhCustomEdit.GetModifiedText(var pre, s, suc: HypeString);
begin
  if (s='') then
   s:=' ';
  s:=ConvertWideStringToUnicode(s,true);
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

procedure TdhCustomEdit.DefineProperties(Filer: TFiler);
var NewWidth, NewHeight, Rows, Cols:integer;
begin
 inherited;                         
 if (csLoading in ComponentState) or not WithMeta and (Filer is TWriter) then exit;

 NewWidth:=Width;
 NewHeight:=Height;
 GetRowsCols(CanAutoX, CanAutoY, NewWidth, NewHeight, Rows, Cols);
 Filer.DefineProperty('Rows', nil, WriteRows, Rows>0);
 Filer.DefineProperty('Columns', nil, WriteCols, Cols>0);
end;

procedure TdhCustomEdit.WriteRows(Writer: TWriter);
var NewWidth, NewHeight, Rows, Cols:integer;
begin
 NewWidth:=Width;
 NewHeight:=Height;
 GetRowsCols(false, true, NewWidth, NewHeight, Rows, Cols);
 Writer.WriteInteger(Rows);
end;


procedure TdhCustomEdit.WriteCols(Writer: TWriter);
var NewWidth, NewHeight, Rows, Cols:integer;
begin
 NewWidth:=Width;
 NewHeight:=Height;
 GetRowsCols(true, false, NewWidth, NewHeight, Rows, Cols);
 Writer.WriteInteger(Cols);
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



constructor TdhCustomEdit.Create(AOwner: TComponent);
begin
  inherited;
end;

end.
