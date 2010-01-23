unit dhOleContainer;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls,
  {$ELSE}
  Controls, Windows, Messages, OleCtnrs, ActiveX, forms, Graphics,
CommCtrl, OleDlg, ComObj,

  {$ENDIF}
   SysUtils, Classes,  dhPanel,GR32,dhLabel,dhStrUtils,dhStyles;

type

  TOleUsage=(ouDisplay,ouReference,ouGraphic);

{$IFNDEF CLX}
  TStructureBox=class(TOleContainer)
  private
    FOldState:TObjectState;
    procedure CheckState;
  protected
    procedure Changed; override;
    function CanFocus:boolean; override; //sonst verschlingt MouseWheel
  public
    procedure Paint;override;
    procedure Invalidate; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure MySaveToFile(const FileName:TPathName);
  end;

  TdhOleContainer = class(TdhCustomLabel)
  private
    //OleImageFile:TPathName;
    //FTransparentColor: TCSSColor;
    FTransparentWhite:boolean;
    FUsage:TOleUsage;
    procedure OnOleDeactivate(Sender: TObject);
    procedure OnOleActivate(Sender: TObject);
    procedure OnOleExit(Sender: TObject);
    procedure SetTransparentWhite(const Value: boolean);
    procedure SetUsage(Value:TOleUsage);
    //procedure PaintOle;
    //procedure SetTransparentColor(const Value: TCSSColor);
  protected
    //procedure CreateParams(var Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    //procedure DoTopPainting; override;
    procedure DoDrawText(var ConstraintsRect: TRect; CalcRect: boolean); override;
    procedure WriteLink(Writer: TWriter);
  public
    ole:TStructureBox;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EditInPlace;
    procedure ObjectPropertiesDialog;
    function InsertObjectDialog(NotIfAlready:boolean):boolean;
    procedure Invalidate; override;
    function RequiresRastering:boolean; override;
  published
    property TransparentWhite:boolean read FTransparentWhite write SetTransparentWhite default true;
    property Usage:TOleUsage read FUsage write SetUsage;
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
    property Cursor;
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
{$ELSE}
  TdhOleContainer = class(TdhCustomLabel);
{$ENDIF}

procedure Register;

implementation


var
  PixPerInch: TPoint;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhOleContainer]);
end;
               
{$IFNDEF CLX}


{ Shade rectangle }

procedure ShadeRect(DC: HDC; const Rect: TRect);
const
  HatchBits: array[0..7] of Word = ($11, $22, $44, $88, $11, $22, $44, $88);
var
  Bitmap: HBitmap;
  SaveBrush: HBrush;
  SaveTextColor, SaveBkColor: TColorRef;
begin
  Bitmap := CreateBitmap(8, 8, 1, 1, @HatchBits);
  SaveBrush := SelectObject(DC, CreatePatternBrush(Bitmap));
  SaveTextColor := SetTextColor(DC, clWhite);
  SaveBkColor := SetBkColor(DC, clBlack);
  with Rect do PatBlt(DC, Left, Top, Right - Left, Bottom - Top, $00A000C9);
  SetBkColor(DC, SaveBkColor);
  SetTextColor(DC, SaveTextColor);
  DeleteObject(SelectObject(DC, SaveBrush));
  DeleteObject(Bitmap);
end;

{ Convert point from himetric to pixels }

function HimetricToPixels(const P: TPoint): TPoint;
begin
  Result.X := MulDiv(P.X, PixPerInch.X, 2540);
  Result.Y := MulDiv(P.Y, PixPerInch.Y, 2540);
end;


procedure TStructureBox.Changed;
begin
  inherited;
  (Parent as TdhCustomPanel).NotifyCSSChanged([wcNoOwnCSS]);
end;

procedure TStructureBox.Invalidate;
begin
  inherited;
  CheckState;
end;

procedure TStructureBox.CheckState;
begin
    if FOldState<>State then
    begin
     FOldState:=State;
     (Parent as TdhCustomPanel).NotifyCSSChanged([wcNoOwnCSS]);
     //self.Changed;
     //UpdateObject;
    end;
end;

Procedure TStructureBox.Paint;
  Function DrawAspect: Longint;
    Begin
      If Iconic Then
        result := DVASPECT_ICON
      Else
        result := DVASPECT_CONTENT
    End; { DrawAspect }

  Function DocObj: boolean;
    Var
      wnd: HWND;
    Begin
      (Self As IOleInPlaceSite).GetWindow( wnd );
      result := wnd = Handle;
    End; { DocObj }

  Function UIActive: Boolean;
    Begin
      result := state = osUIActive;
    End; { UIActive }

  Function ObjectOpen: Boolean;
    Begin
      result := state = osOpen;
    End; { ObjectOpen }

  Function Viewsize: TPoint;
    Var
      ViewObject2: IViewObject2;
    Begin
      If Succeeded( OleObjectInterface.QueryInterface(
                      IViewObject2, ViewObject2))
      Then
        ViewObject2.GetExtent(DrawAspect, -1, nil, Result)
      Else
        Result := Point(0,0);
    End; { Viewsize }

  Var
    W, H: Integer;
    S: TPoint;
    R, CR: TRect;
    Flags: Integer;
    TopGraph:TBitmap32;
  Begin { Paint }
    If DocObj and UIActive Then Exit;
    CR := Rect(0,0,Width,Height);
    If BorderStyle = bsSingle Then
    Begin
      If NewStyleControls and Ctl3D Then
        Flags := BF_ADJUST or BF_RECT
      Else
        Flags := BF_ADJUST or BF_RECT or BF_MONO;
    End
    Else
      Flags := BF_FLAT;

    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := Color;
    { Main modification are the following two lines }
    DrawEdge(Canvas.Handle, CR, EDGE_SUNKEN, Flags);
    (*if (Parent is TdhOleContainer) and TdhOleContainer(Parent).GetPainting(TopGraph) then
    begin
     //TdhOleContainer(Parent).ass
     with TdhOleContainer(Parent).ScrollArea do
      Canvas.CopyRect(CR,TopGraph.Canvas,Bounds(Left,Top,Self.Width,Self.Height));

    end else*)
    // Canvas.FillRect( CR );

    If OleObjectInterface <> nil Then
    Begin
      W := CR.Right - CR.Left;
      H := CR.Bottom - CR.Top;
      S := HimetricToPixels(ViewSize);
      If (DrawAspect = DVASPECT_CONTENT) and (SizeMode = smScale) Then
        If W * S.Y > H * S.X Then
        Begin
          S.X := S.X * H div S.Y;
          S.Y := H;
        End Else
        Begin
          S.Y := S.Y * W div S.X;
          S.X := W;
        End;
      If (DrawAspect = DVASPECT_ICON) or (SizeMode = smCenter) or
        (SizeMode = smScale) Then
      Begin
        R.Left := (W - S.X) div 2;
        R.Top := (H - S.Y) div 2;
        R.Right := R.Left + S.X;
        R.Bottom := R.Top + S.Y;
      End
      Else If SizeMode = smClip Then
      Begin
        SetRect(R, CR.Left, CR.Top, S.X, S.Y);
        IntersectClipRect(Canvas.Handle, CR.Left, CR.Top, CR.Right, 
CR.Bottom);
      End
      Else
        SetRect(R, CR.Left, CR.Top, W, H);
      OleDraw(OleObjectInterface, DrawAspect, Canvas.Handle, R);
      If ObjectOpen Then ShadeRect(Canvas.Handle, CR);
    End;
    If Focused Then Canvas.DrawFocusRect(CR);
    if FOldState<>state then
    begin
     //if FOldState in [osOpen, osInPlaceActive] then

     //UpdateObject;//AdjustBounds;
     //(self as IOleInPlaceSite).OnPosRectChange(self.BoundsRect);
     //Changed;

     //(Parent as TdhCustomPanel).FCommon.NotifyCSSChanged([wcNoOwnCSS,wcClientArea]);
     //InvalTrans(Parent,InvRect,true);
    end;
    FOldState:=state;
  End; { TStructureBox.Paint }

{ TdhOleContainer }

constructor TdhOleContainer.Create(AOwner: TComponent);
begin
  inherited;
  //FTransparentColor:=colInherit;
  FTransparentWhite:=true;
  ControlStyle:=ControlStyle-[csSetCaption,csAcceptsControls];
  AutoSizeXY:=asNone;
  Width:=226;
  ole:=TStructureBox.Create(nil);
  ole.Parent:=Self;
  //ole.Visible:=false;
  //ole.Align:=alClient;
  ole.SizeMode:=smAutoSize;
  //ole.SizeMode:=smClip;
  {ole.Width:=20;
  ole.Height:=20; }
  ole.ParentColor:=True;
  ole.DoubleBuffered:=True;
  ole.BorderStyle:=bsNone;
  //ole.Enabled:=false;
  ole.OnDeactivate:=OnOleDeactivate;
  ole.OnActivate:=OnOleActivate;
  ole.OnExit:=OnOleExit;

  ole.AllowInPlace:=false;

  {FCommon.IsScrollArea:=true;
  FCommon.NCScrollbars:=true; }
  //EdgesInScrolledArea:=true;
end;

                    {
procedure TdhOleContainer.DoTopPainting;
begin
 PaintOle;
 DrawFrame;
end;


procedure TdhOleContainer.PaintOle;  
var R: TRect;
begin
    R:=GetCanvas.ClipRect;
    R:=ShrinkRect(R,FCommon.ScrollEdgesPure);
    if not TextOnly then
    begin
     PaintOuterBorder;
     PaintOuterBg;
    end;
    if not glPaintOnlyBg then
     DoDrawOle(R, false);
end;
                 }
procedure ColFF(bmp:TBitmap32);
var i:integer;
var P: PColor32;
begin
   P:=bmp.PixelPtr[0,0];
   for i := 0 to bmp.Width*bmp.Height do
   begin
    P^:=P^ or $FF000000;
    inc(P);
   end;
end;

procedure ReplaceCol(bmp:TBitmap32; findCol,substCol:TColor32);
var i:integer;           
var P: PColor32;
begin
   P:=bmp.PixelPtr[0,0];
   for i := 0 to bmp.Width*bmp.Height do
   begin
    if P^=findCol then
     P^:=substCol;
    inc(P);
   end;
end;



procedure TdhOleContainer.DoDrawText(var ConstraintsRect: TRect; CalcRect:boolean);
var bmp:TBitmap32;
begin                  
 if CalcRect then
 with AllEdgesPure do
 begin
  ConstraintsRect.Right:=Left+Right+ole.Width;
  ConstraintsRect.Bottom:=Top+Bottom++ole.Height;
  exit;
 end;

 //FTransparentColor:=clWhite;
 //FTransparentColor:=colInherit;
 //if FTransparentColor<>colInherit then
 if FTransparentWhite then
 begin
 bmp:=TBitmap32.Create;
 try
  bmp.Width:=ole.Width;
  bmp.Height:=ole.Height;
  bmp.Clear(clWhite32);
  ole.PaintTo(bmp.Canvas,0,0);
  ColFF(bmp);
  ReplaceCol(bmp,clWhite32,0);
  bmp.DrawMode:=dmBlend;
  with AllEdgesPure do
   bmp.DrawTo(ActTopGraph,Left,Top{ConstraintsRect.Left,ConstraintsRect.Top});
 finally
  FreeAndNil(bmp);
 end;
 end else           
 with AllEdgesPure do
  ole.PaintTo(self.GetCanvas,Left,Top);
end;


procedure TdhOleContainer.OnOleDeactivate(Sender: TObject);
begin
 ole.Enabled:=false;
 ole.Enabled:=true;
// InvalTrans(Self,InvRect,true);

// FCommon.NotifyCSSChanged([wcNoOwnCSS,wcClientArea]);
end;

procedure TdhOleContainer.OnOleActivate(Sender: TObject);
begin
// InvalTrans(Self,InvRect,true);
end;
     {
procedure TdhOleContainer.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
      Style := Style or WS_CLIPCHILDREN; //prevent flicker of button
      ExStyle := ExStyle or WS_EX_CONTROLPARENT;
  end;
end;     }

type TFakeControl=class(TControl);

procedure TdhOleContainer.DefineProperties(Filer: TFiler);
begin
  inherited;
  TFakeControl(ole).DefineProperties(Filer);
  Filer.DefineProperty('Link', SkipValue, WriteLink, ole.Linked);
end;

destructor TdhOleContainer.Destroy;
begin
  FreeAndNil(ole);
  inherited;
end;

procedure TdhOleContainer.EditInPlace;
begin
 with ole do DoVerb(PrimaryVerb);
// FCommon.NotifyCSSChanged([wcNoOwnCSS,wcClientArea]);
end;

procedure TdhOleContainer.ObjectPropertiesDialog;
begin
 ole.ObjectPropertiesDialog;
end;

function TdhOleContainer.InsertObjectDialog(NotIfAlready:boolean):boolean;
begin
 if (ole.State=osEmpty) or not NotIfAlready then
  ole.InsertObjectDialog;
 //ole.CreateLinkToFile('D:\aa\Business_website_template_by_FnatiK\DFM2HTML_index\1.swf', True);
 result:=ole.State<>osEmpty;
end;
          
procedure TdhOleContainer.OnOleExit(Sender: TObject);
begin
// InvalTrans(Self,InvRect,true);
end;


var
  DC: HDC;
procedure TdhOleContainer.Invalidate;
begin
  inherited;
  //ole.Invalidate;
end;

procedure TStructureBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  ATop:=-AHeight;
  inherited;
  {if OleObjectInterface<>nil then
   OleObjectInterface.SetExtent(DVASPECT_DOCPRINT,Point(Width,Height));    }
end;
   {
procedure TdhOleContainer.SetTransparentColor(const Value: TCSSColor);
begin
  FTransparentColor := Value;
end;    }


procedure TdhOleContainer.SetUsage(Value:TOleUsage);
begin
  if FUsage <> Value then
  begin
   FUsage := Value;
   //InvalTrans(Self,InvRect,true);
   //FCommon.InvalTop(true,true);
   NotifyCSSChanged([wcNoOwnCSS]);
  end;
end;

procedure TdhOleContainer.SetTransparentWhite(const Value: boolean);
begin
  if FTransparentWhite <> Value then
  begin
   FTransparentWhite := Value;
   //InvalTrans(Self,InvRect,true);
   //FCommon.InvalTop(true,true);
   NotifyCSSChanged([wcNoOwnCSS]);
  end;
end;

function TdhOleContainer.RequiresRastering: boolean;
begin
 result:=self.Usage=ouGraphic;
end;

function TStructureBox.CanFocus:boolean;
begin
 result:=false;
end;

procedure TdhOleContainer.WriteLink(Writer: TWriter);
begin
 Writer.WriteString(ole.SourceDoc);
end;

procedure TStructureBox.MySaveToFile(const FileName: TPathName);
var
  TempStorage: IStorage;
  PersistFile: IPersistFile;
  ws:WideString;
begin
{  ws:=FileName;
  OleObjectInterface.QueryInterface(IPersistFile, PersistFile);
  if PersistFile<>nil then
   PersistFile.Save(@ws,false);  }   
end;

begin
  DC := GetDC(0);
  PixPerInch.X := GetDeviceCaps(DC, LOGPIXELSX);
  PixPerInch.Y := GetDeviceCaps(DC, LOGPIXELSY);
  ReleaseDC(0, DC);
{$ENDIF}
end.
