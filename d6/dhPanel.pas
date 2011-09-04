{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
unit dhPanel;

interface

{$IFDEF VER160}
{$UNSAFECODE ON}
{$ENDIF}

{.$DEFINE Q}
{.$IFNDEF CLX}
{.$DEFINE SYNC_PROP}
{.$ENDIF}

uses
  SysUtils, Classes, TypInfo,
  {$IFDEF MSWINDOWS}ShellAPI,jpeg,{$ELSE}libc,{$ENDIF}
{$IFDEF CLX}
  QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls,
  QComCtrls, QStdCtrls, QTypes,
{$ELSE}
  Controls, Forms, Windows, Messages, Graphics, Dialogs, ExtCtrls, appevnts{Application.OnIdle:= überschreiben mit eigenem code},
  ComCtrls, CommCtrl, StdCtrls, clipbrd,
{$ENDIF}
  math,
  GR32,GR32_Transforms,gauss,GR32_Blend,GR32_LowLevel,Generics.Defaults,Generics.Collections,dhBitmap32,dhStrUtils,WideStrUtils, dhStyles, dhGraphicFormats, dhColorUtils, dhGraphicsAlgorithms;

type TASXY=(asNone,asX,asY,asXY);

type TFrameEventType=(feMouseUp,feMouseDown,feMouseMove);
type
  TDesignedFor=(dfAnything,dfMenu,dfMenuItem,dfMenuItemWithMenu,dfSeparatorBar);
  TUpdateOver=procedure(Self:TControl; IsOver:boolean; Clicked:boolean);
  TActMode=(amNone,VertButton1,VertButton2,VertBar,VertChecked1,VertChecked2,
                   HorzButton1,HorzButton2,HorzBar,HorzChecked1,HorzChecked2,
  amAddDown,amCloseDown,amOpenDown,amAddLinkDown,VertOneButton);

const InvalidCSSPos=maxint;
      InvalidEqArea=maxint;



{$IFDEF CLX}
const VK_ESCAPE=Key_Escape;
type HWND=QWidgetH;
{$ENDIF}

type
  TStyleArray=array[TState] of TStyle;
  TRasterType=(rsNo,rsFull,rsRounded,rsRGBA,rsSemi,rsStretch,rsSplit,rsFullWithoutText);

  TdhCustomPanel=class;
  TOnStateTransition=procedure(Sender: TdhCustomPanel; OldState:TState) of object;

  TSpecialBorderType=(sbtNormal,sbtButton,sbtEdit);

  ICon=interface
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
    function DoGetVal(PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign; var DoExit:boolean):boolean;
    procedure UpdateNames(InlineUse,NewInlineUse:ICon; PropagateChange:boolean);
    function ChildHasAnchor(a:TAnchors):boolean;
    procedure DoCSSToWinControl(WhatChanged:TWhatChanged=[]);
    function GetCommon:TdhCustomPanel;
    function GetName:TComponentName;
    function ShallBeAnchor:boolean;
    procedure AddOwnInfo(sl:TStrings);
    function GetHTMLState:TState;
    function GetCanvas:TCanvas;
    function SuitableKind:TDesignedFor;
    function DownIfDown:boolean;
    function GetComputedFontSize:single;
    function GetFinal:ICon;
    function GetInlineHTMLState(Over,Down:boolean):TState;
    function IncludeBorderAndPadding:boolean;
    procedure FocusPreferStyle(IsMain,RealChange:boolean);
    function RequiresRastering:boolean;
  end;

  TdhScrollInfo = record
    nMax: Integer;
    nPage: Integer;
  end;

{$IFDEF CLX}
  TdhCustomPanel = class(TCustomControl,IStyleOwner,ICon)
{$ELSE}
  TdhCustomPanel = class(TWinControl,IStyleOwner,ICon)
{$ENDIF}
  protected
    FNoSiblingsBackground:boolean;
    FIsScrollArea: boolean;
    FDownOverlayOver: boolean;
    Fetching,FIsDlg:boolean;
    procedure CopyFrom(Use:ICon; sub:boolean);
    procedure AddInfo(sl: TStringList);
    function CenterMargins:TPoint;
    procedure CSSToWinControl(WhatChanged:TWhatChanged=[]);
    procedure InvalTop(IncludeChildren,IncludeSelf:boolean);
    procedure InvalBack; overload;
    procedure InvalBack(const R2:TRect); overload;
    function GetAffine: TdhAffineTransformation;
    function GetBold: boolean;
    procedure SetBold(const Value: boolean);
    function GetItalic: boolean;
    procedure SetItalic(const Value: boolean);
    function GetFontColor:TCSSColor;
    procedure SetFontColor(Value:TCSSColor);
    function TextDecoration: TCSSTextDecorations;
    function GetUnderline: boolean;
    procedure SetUnderline(const Value: boolean);
    function GetLineThrough: boolean;
    procedure SetLineThrough(const Value: boolean);
    function GetOverline: boolean;
    procedure SetOverline(const Value: boolean);
    function GetBlink: boolean;
    procedure SetBlink(const Value: boolean);
    function GetNearestFontFamily: TCSSFontFamily;
    function GetWidestFontFamily: TCSSFontFamily;
    procedure SetFontFamily(const Value: TCSSFontFamily);
    procedure SetFontSize(const Value: TCSSFontSize);
    function GetFontSize: TCSSFontSize;
    procedure SetIsScrollArea(const Value: boolean);
    function IsDefinedOuter(ob: TObject): boolean;
    procedure SetIsDlg(Value:Boolean);
    function GetSpecialBorderType:TSpecialBorderType;
    procedure LockDefinedCSS(var sStyleArr:TStyleArray);
    procedure UnlockDefinedCSS(var sStyleArr:TStyleArray);
    function HasImage(var FPicture: TGraphic): boolean; overload;
  protected
    function HasBackgroundImage:boolean; overload;
    function HasImage: boolean; overload;
    function HasImage(var PicWidth, PicHeight: integer): boolean; overload;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
  public
    function HasBackgroundImage(var FPicture: TGraphic): boolean; overload;
    function HasBackgroundImage(var FPicture:TLocationImage):boolean; overload;
    procedure _SetUniqueName(const s:TComponentName);
    class function _GetUniqueName(_Self:TComponent; const s:TComponentName):TComponentName;
  public
    IsVertScrollBarVisible,IsHorzScrollBarVisible:boolean;
    FVertScrollbarAlwaysVisible,FHorzScrollbarAlwaysVisible:boolean;
    FVertScrollbarNeverVisible,FHorzScrollbarNeverVisible:boolean;
    NCScrollbars:boolean;
    FOneButton:boolean;
    ActTopGraph:TdhBitmap32;
    InlineUsedByList:TList;
    StyleArr:array[TState] of TStyle;
    InCSSToWinControl:boolean;
    CollectChanges:TWhatChanged;
    InCollectChanges:boolean;
    InNotifyCSSChanged:boolean;
    FUse: ICon;
    UsedByList:TList;
    PreferStyle:TStyle;
    LastActStyle:TState;
    FAutoSize:TASXY;
    FIsOver:boolean;
    procedure AssignComputed(Border:TCSSBorder; Align:TEdgeAlign);
    procedure AssignComputedEdge(Align:TEdgeAlign; Style: TStyle);
    procedure GetFontDifferences(FontStyle:TFontStyles; FontColor:TCSSColor; FontName:TFontName; FontHeight:Integer);
    procedure CopyStyles(fromState,toState:TState);
    function BoundNextSibling:TdhCustomPanel; virtual;
    function BoundTop:Integer; virtual;
    property NoSiblingsBackground:boolean read FNoSiblingsBackground write FNoSiblingsBackground default false;
    function AllHTMLCode:HypeString; virtual;
    procedure SkipValue(Reader: TReader);
    procedure SetPreferStyle(Value: TStyle; OnlyForRetrieval,IsMain:boolean);
    procedure ScrollingParametersChanged;
    function ComputedFontSize:integer;
    property IsDlg: boolean read FIsDlg write SetIsDlg;
    function RuntimeMode:boolean;
    function ScrollEdgesPure: TRect;
    function IsRastered(RespectStyleSheet:boolean): TRasterType;
    function IsInUseList(ob: TObject): boolean;
    property IsScrollArea:boolean read FIsScrollArea write SetIsScrollArea;
    function SetTextDecoration(WantUnderline,WantLineThrough,WantOverline,WantBlink:boolean):boolean;
    property Overline:boolean read GetOverline write SetOverline;
    property Underline:boolean read GetUnderline write SetUnderline;
    property LineThrough:boolean read GetLineThrough write SetLineThrough;
    property Blink:boolean read GetBlink write SetBlink;
    property Bold:boolean read GetBold write SetBold;
    property Italic:boolean read GetItalic write SetItalic;
    property FontColor:TCSSColor read GetFontColor write SetFontColor;
    property NearestFontFamily:TCSSFontFamily read GetNearestFontFamily write SetFontFamily;
    property WidestFontFamily:TCSSFontFamily read GetWidestFontFamily write SetFontFamily;
    property FontSize:TCSSFontSize read GetFontSize write SetFontSize;
    function Direction:TCSSDirection;
    procedure ClearAllStyles(ClearUse:boolean);
    procedure TransferStylesToUse;
    procedure TransferStylesToElement(Use:ICon);
    procedure ExchangeDownOverStyles;
    procedure GetStylesFromUse;
    procedure GetStylesFromElement(Use:ICon);
    function HasTransformations(var tt: TTransformations): boolean;
    procedure ReleaseResources;
    procedure CheckDesignState;
    procedure CSSToFont(Font:TFont=nil);
    function GetCharset:TFontCharset;
    procedure CSSToColor;
    procedure CSSToCursor;
    procedure FontHasChanged;
    procedure ColorHasChanged;
    procedure CursorHasChanged;
    procedure ParentFontHasChanged;
    procedure ParentColorHasChanged;
    procedure NameChanged; virtual;
    function FontWeight: TCSSFontWeight;
    function FontVariant: TCSSFontVariant;
    function FontStyle: TCSSFontStyle;
    function BackgroundColor:TCSSColor;
    function BackgroundRepeat: TCSSBackgroundRepeat;
    function BackgroundAttachment: TCSSBackgroundAttachment;
    function GetCursor:TCSSCursor;
    procedure NotifyCSSChanged(WhatChanged:TWhatChanged);
    procedure NotifyUsedByList(WhatChanged:TWhatChanged);
    procedure NotifyInlineUsedByList(WhatChanged:TWhatChanged);
    procedure SetUse(Value: ICon);
    function MarginWidth(const Align:TEdgeAlign):integer;
    function MarginWidthNormalStyle(const Align:TEdgeAlign):integer;
    function BorderWidth(const Align:TEdgeAlign):integer;
    function DisplayBorderWidth(const Align:TEdgeAlign):integer;
    function TransparencyOfBorderWidth(const Align:TEdgeAlign):integer;
    function SemiTransparencyOfBorderWidth(const Align:TEdgeAlign):integer;
    function PaddingWidth(const Align:TEdgeAlign):integer;
    function BorderStyle(const Align:TEdgeAlign):TCSSBorderStyle;
    function BorderColor(const Align:TEdgeAlign):TCSSColor;
    function MarginTotalRect:TRect;
    function PaddingPure:TRect;
    function MarginPure:TRect;
    function BorderPure:TRect;
    function BorderPureWithHidden:TRect;
    function AllEdgesPure:TRect;
    function GetBorderRadii(var TopLeft,TopRight,BottomLeft,BottomRight:TPoint; var TopLeftDouble,TopRightDouble,BottomLeftDouble,BottomRightDouble:boolean):boolean;
    function HasBorderRadii:boolean;
    function GetBorderRadius(CornerAlign:TCornerAlign):TPoint;
    function IsBorderRadiusTwoValued(CornerAlign:TCornerAlign):boolean;
    function IsRasterized:boolean;
    function ClientEdgesPure: TRect;
    function ZIndex:TCSSInteger;
    function MinWidth:TCSSCardinal;
    function MinHeight:TCSSCardinal;
    function Display:TCSSDisplay;
    function Visibility:boolean;
    function GetVal(PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign=ealNone; CanInherit:boolean=true):boolean;
    function HasVal(PropChoose:TPropChoose; const Align:TEdgeAlign=ealNone):boolean;
    function GetUsed:boolean;
    function UsePn:TdhCustomPanel;
    procedure TransformUse(P:ICon; DoSUse:boolean);
    destructor Destroy; override;
    property Use:ICon read FUse write SetUse;
    function ItGetVal(state:TState; PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign=ealNone):boolean;
    procedure InvDesigner;
    function ActStyle:TStyle;
    procedure Frame3D(Border:TEdgeAlign; Points: array of TPoint; PixelCombineEvent:TPixelCombineEvent);
    procedure SpecialBg(const ref_scrolled,ref_fixed:TRect; Src:TdhBitmap32; const brct: TRect; IsFixed:boolean);
    procedure SpecialPaintBorder(const rct,brct: TRect; PixelCombineEvent:TPixelCombineEvent=nil);
    function IsAbsolutePositioned:boolean;
    function GetStyleByName(const name:TPropertyName; var r:TStyle):boolean;
    procedure SetIsOver(Value:boolean);
    procedure UpdateMouse(MouseEnter:boolean);
    procedure UpdateMousePressed(Down:boolean; DownIfDown:boolean);
    function IsVirtualParentOf(pn:TControl):boolean;
    function GetLev:integer;
  protected
    FTooltip:HypeString;
    EqArea:TRect;
    FPreciseClick:boolean;
    FComputedFontSize:single;
    FOnStateTransition:TOnStateTransition;
    FImageType:TImageType;
    FImageFormat:TImageFormat;
    DragHPos, DragVPos: Integer;
    FDragOffset:TPoint;
    BackGraph:TdhBitmap32; // opaque bitmap of the background - however if (BackGraph=TopGraph), the visual content may overlay it
    TopGraph:TdhBitmap32; // opaque bitmap of the visual content
    TransparentTop:TdhBitmap32; // transparent bitmap of the visual content without background information (by using semi-transparency)
    BackIsValid:boolean; // whether BackGraph and TopGraph are up-to-date with the background
    TopIsValid:boolean; // whether TopGraph is up-to-date with the visual content - the background information may be invalid
    TransparentTopIsValid:boolean; // whether TransparentTop is up-to-date with the visual content
    _SelfCBound:TRect;
    VertScrollInfo: TdhScrollInfo;
    HorzScrollInfo: TdhScrollInfo;
    FScrollingInEdges: boolean;
    FEdgesInScrolledArea: boolean;
    FHTMLAttributes: HypeString;
    FCenter: boolean;
    _AutoResizing:boolean;
    CSSRight,CSSBottom:integer;
    LightBoundsChanging:boolean;
{$IFDEF CLX}
    NC:TRect;
    DefDelta:boolean;
{$ENDIF}
    procedure ChildrenAdjustStrong(DeltaX,DeltaY:Integer);
    procedure InvalDeepestBack;
    procedure AssertTop(addheight:integer; NeedTransparentImage:boolean=false; NeedOpaqueImage:boolean=true);
    procedure PaintHidden;
    procedure BeginPainting(bmp:TdhBitmap32);
    procedure EndPainting;
    procedure PixelCombineNormal(F: TColor32; var B: TColor32; M: TColor32);
    procedure PixelCombineMultiply(F: TColor32; var B: TColor32; M: TColor32);
    procedure PixelCombineNegativeMultiply(F: TColor32; var B: TColor32; M: TColor32);
    function TransPainting(nWidth:integer=-1; nHeight:integer=-1): TdhBitmap32;
    procedure SetImageType(const Value: TImageType);
    procedure WriteSUse(Writer: TWriter);
    procedure ReadSUse(Reader: TReader);
    procedure SetRight(const Value:integer);
    procedure SetBottom(const Value:integer);
    function IsRightStored:boolean;
    function IsLeftStored:boolean;
    function IsBottomStored:boolean;
    function IsTopStored:boolean;
    function IsHeightStored:boolean;
    function IsWidthStored:boolean;
    function RealAnchors:TAnchors;
    procedure StrongToWeak;
    function HasActiveStrong(TestAnchors:TAnchors):boolean;
    procedure CalcStrongToWeak(var ALeft,ATop,AWidth,AHeight:integer);
    procedure WeakToStrong(IncludeActiveStrong:boolean); overload;
    procedure SetVHPos(H,V:integer);
    function GetVertButton1: TRect;
    function GetVertButton2: TRect;
    function GetVertChecked: TRect;
    function GetVertBar: TRect;
    function VertBarVisible: boolean;
    function GetHorzBar: TRect;
    function GetHorzButton1: TRect;
    function GetHorzButton2: TRect;
    function GetHorzChecked: TRect;
    function GetHorzWhole: TRect;
    function GetVertWhole: TRect;
    function HorzBarVisible: boolean;
    procedure ScrollPaintChanged(SameScrollbars:boolean=true);
    function ScrollAreaWithScrollbars: TRect;
    procedure InvalScrollbars;
    procedure OnMouseTimer(Sender: TObject);
    procedure SetEdgesInScrolledArea(const Value: boolean);
    function GetAnchors: TAnchors;
    function IsAnchorsStored: Boolean;
    procedure PixelCombineUnderpaint(F: TColor32; var B: TColor32; M: TColor32);
    procedure PixelCombineInner(F: TColor32; var B: TColor32; M: TColor32);
    procedure PreventFlicker;
    procedure TransFromBlackWhite_BG(bmp: TdhBitmap32);
    procedure TransFromBlackWhite_TP(bmp:TdhBitmap32);
    procedure DoAutoSize(var PreferedWidth,PreferedHeight:integer);
  protected
    SimplifiedAnchors:TAnchors;
    ActDown:TActMode;
    HPos, VPos: Integer;
    procedure SetASXY(const Value: TASXY); virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function PreventFull(Cause:TTransformations):boolean; virtual;
    function CanBeTopPC:boolean; virtual;
    function AlwaysVisibleVisibility:boolean; virtual;
    procedure InitSelfCBound(var _ContentWidthHeight:TPoint);
    procedure CopyObjectStylesFrom(src:TdhCustomPanel; sub:boolean; test:TdhCustomPanel); virtual;
    procedure ClearObjectStyles; virtual;
    procedure AdjustSize; override;
    procedure RequestAlign; override;
    procedure MyAlignControl(AControl: TControl);
    procedure BorderChanged;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure AdjustBackgroundColor(var Col: TCSSColor); virtual;
    function TextOnly: boolean; virtual;
    function TextExclude: boolean; virtual;
    function CustomSizesForEffects:boolean; virtual;
    function EasyBounds(var Transformations: TTransformations; var T: TdhAffineTransformation; var W,H:Integer; var HorzRotated, VertRotated: boolean): boolean;
    procedure ProcessMouseMove(StateChanged:boolean); virtual;
    function AdjustZIndex(ChildPos,ParentControlCount:integer):integer; virtual;
    procedure AdjustScrolling(var R: TRect);
    function Opaque:boolean;
    function TransparentEdges:TRect;
    function SemiTransparentEdges:TRect;
    procedure PaintWhiteBackground(ref_brct: TRect; Src: TdhBitmap32; const brct: TRect); virtual;
    function SomethingIsFixed: boolean; //virtual;
    function SomethingIsScrolled: boolean; virtual;
    function ValidChildrenInvalidParent:boolean;
    procedure AdjustMarginWidth(var i: integer; const Align: TEdgeAlign); virtual;
    procedure PaintOuterBg;
    procedure UpdateScrollBars(OnlyCalculateVisibility:boolean);
    procedure SetBoundedHPos(p: Integer);
    procedure SetBoundedVPos(p: Integer);
    procedure SetVPos(Value: Integer);
    procedure SetHPos(Value: integer);
    procedure DoInvalFrame; virtual;
    procedure DoDrawFrame(Canvas: TCanvas; _ActDown: TActMode); virtual;
    function GetActDown: TActMode; virtual;
    property EdgesInScrolledArea:boolean read FEdgesInScrolledArea write SetEdgesInScrolledArea;
    function MyGetControlExtents(OnlyForScrollbars:boolean): TPoint; virtual;
    function NeedPadding(HasRastering:TRasterType): boolean; virtual;
    procedure NotifyUseChanged(OldValue: ICon); virtual;
    procedure AdjustLittle(var W,H:integer; infl: boolean; adj:boolean=true);
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; {$IFDEF CLX}const {$ENDIF}MousePos: TPoint): Boolean; override;
    function GetNotClipped(OnlyOneParent:boolean):TRect;
    function GetNotClippedOne(DeltaX,DeltaY:integer):TRect;
    function TotalRect:TRect;
    function DynamicTotalRect:TRect;
{$IFNDEF CLX}
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CMRelease(var Message: TMessage); message CM_RELEASE;
    function DesignWndProc(var Message: TMessage): Boolean; override;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
{$ELSE}
    function ViewportRect: TRect; override;
    procedure CheckNC(DeltaX:integer=0; DeltaY: Integer=0);
    procedure CheckChildrenNC(DeltaX:integer=0; DeltaY: Integer=0);
    function WidgetFlags: Integer; override;
    procedure InitWidget; override;
    procedure ScrollBy(DeltaX, DeltaY: Integer); override;
{$ENDIF}
    procedure ControlsListChanged(Control: TControl; Inserting: Boolean); {$IFDEF CLX}override;{$ELSE}virtual;{$ENDIF}
{$IFNDEF CLX}
{$IFDEF VER160}
    procedure ControlChange(Inserting: Boolean; Child: TControl); override;
{$ELSE}
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
{$ENDIF}
{$ENDIF}
{$IFDEF CLX}
    procedure ShowingChanged; override;
{$ELSE}
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
{$ENDIF}
{$IFDEF CLX}
    function DesignEventQuery(Sender: QObjectH; Event: QEventH): Boolean; override;
{$ELSE}
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
{$ENDIF}
{$IFDEF CLX}
    function HitTest(X, Y: Integer): Boolean; override;
    procedure DrawMask(Canvas: TCanvas); override;
{$ELSE}
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
{$ENDIF}
{$IFNDEF CLX}
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
{$ENDIF}
    procedure VisibleChanged; {$IFDEF CLX}override;{$ELSE}virtual;{$ENDIF}
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
{$IFDEF CLX}
    procedure MouseEnter(AControl: TControl); override;
{$ELSE}
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
{$ENDIF}
{$IFDEF CLX}
    procedure MouseLeave(AControl: TControl); override;
{$ELSE}
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
{$ENDIF}
{$IFDEF CLX}
    procedure SetParent(const AParent: TWidgetControl); override;
{$ELSE}
    procedure SetParent(AParent: TWinControl); override;
{$ENDIF}
{$IFDEF CLX}
    procedure Paint; override;
{$ELSE}
    procedure PaintWindow(DC: HDC); override;
{$ENDIF}
{$IFDEF CLX}
    procedure ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
{$ELSE}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
{$ENDIF}
    procedure Release;
    function AcceptClick(P:TPoint):boolean; virtual;
    function GetSmallestNonTransparentRect:TRect;
    procedure DoTopPainting; virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure ProcessFrameEvent(FrameEventType: TFrameEventType); virtual;
{$IFDEF CLX}
    procedure FontChanged; override;
{$ELSE}
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
{$ENDIF}
{$IFDEF SYNC_PROP}
{$IFDEF CLX}
    procedure ParentFontChanged; override;
{$ELSE}
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
{$ENDIF}
{$IFDEF CLX}
    procedure ColorChanged; override;
{$ELSE}
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
{$ENDIF}
{$IFDEF CLX}
    procedure CursorChanged; override;
{$ELSE}
    procedure CMCursorChanged(var Message: TMessage); message CM_CURSORCHANGED;
{$ENDIF}
{$IFDEF CLX}
    procedure ParentColorChanged; override;
{$ELSE}
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
{$ENDIF}
{$ENDIF}
    procedure SetName(const Value: TComponentName); override;
    procedure Loaded; override;
    function GetTransparent:boolean;
    function SemiTransparent:boolean;
    procedure SetTransparent(Value: boolean);
    procedure ReadAutoSizeVerticalOnly(Reader:TReader);
    procedure ReadAutoSize(Reader:TReader);
    function GetStyle(Index:TState):TStyle;
    procedure SetStyle(Index:TState; Value:TStyle);
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure PaintBorder;
    function GetClientRect:TRect; override;
    function LeaveY:boolean; virtual;
    procedure PrepareAlign; virtual;
    procedure AlignDone; virtual;
    procedure SetZOrder(TopMost: Boolean); override;
    function ChildHasAnchor(a:TAnchors):boolean;
    procedure DoCSSToWinControl(WhatChanged:TWhatChanged); virtual;
    function DoGetVal(PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign; var DoExit:boolean):boolean; virtual;
    function GetCommon:TdhCustomPanel;
    procedure AddOwnInfo(sl:TStrings); virtual;
    function GetHTMLState:TState; virtual;
    function GetCanvas:TCanvas;
    function GetName:TComponentName;
    function GetElementName:TComponentName;
    procedure UpdateNames(InlineUse,NewInlineUse:ICon; PropagateChange:boolean); virtual;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); virtual;
    function GetSuperiorAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer):boolean;
    function AlignedTo:TAlign;
    function AllowAutoSizeY:boolean; virtual;
    function CanAutoX:boolean;
    function CanAutoY:boolean;
    procedure ChildrenAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
    procedure AddScrollbarPlace(var IsHorzScrollBarVisible,IsVertScrollBarVisible:boolean; AllowModifyX,AllowModifyY:boolean; var Avail,Req:TPoint);
    function DownIfDown:boolean; virtual;
    function GetComputedFontSize:single; virtual;
    function GetFinal:ICon; virtual;
    function IncludeBorderAndPadding:boolean; virtual;
    procedure InvalidateFontSize;
    function RequiresRastering:boolean; virtual;
    property OnStateTransition:TOnStateTransition read FOnStateTransition write FOnStateTransition;
    function GetPreferDownStyles:boolean; virtual;
  public
    VariableHeight:boolean;
    SUse:TComponentName;
    DragEnabled:boolean;
    class function IsValidIdent(const Ident: TComponentName): Boolean;
    procedure MyRealign;
    function GetWantedSize:TPoint;
    function ShallBeAnchor:boolean; virtual;
    function GetInlineHTMLState(Over,Down:boolean):TState; virtual;
    function HeightDiff: integer; virtual;
    procedure PreferStyleChange;
    procedure FocusPreferStyle(IsMain,RealChange:boolean); virtual;
    function State:TState;
    property PreciseClick:boolean read FPreciseClick write FPreciseClick;
    property OnClick;
    property OnMouseUp;
    procedure DoClickAction(Initiator:TdhCustomPanel); virtual;
    function GetInnerClientArea: TRect;
    function DesignHitTest:boolean;
    function FinalShowing:boolean; virtual;
    function GetVirtualBGColor: TCSSColor;
    function ScrollArea: TRect;
    function ClientBound:TRect;
    function PhysicalClientBound:TRect;
    function PhysicalClientEdgesWithScrollbars:TRect;
    function ScrollAreaWithScrollbars_Edges:TRect;
    function ScrollArea_Edges:TRect;
    function GetOpaquePainting(var TopGraph: TdhBitmap32): boolean;
    function HorizontalCenter:boolean;
    function VerticalCenter:boolean;
    procedure SetBoundedVHPos(H, V: integer);
    property HTMLAttributes:HypeString read FHTMLAttributes write FHTMLAttributes;
    procedure CopyDependencies(CopyList:TList); virtual;
    procedure TryBrokenReferences(sl:TStringList); virtual;
    procedure ScrollInView(AControl: TControl; ForceTop:boolean);
    procedure DoStateTransition(OldState:TState); virtual;
    function TransitionInvalidates: boolean; virtual;
    function GetImageType: TImageType; //virtual;
    function GetImageFormat: TImageFormat;
    function IsDesigning:boolean;
    function RecursiveShowing:Boolean;
    function GetInfo:AString;
    function GetControl:TControl;
    function GetRelativePathProvider:IRelativePathProvider;
    function TotalInlineBox: boolean; virtual;
    function Referer:TdhCustomPanel; virtual;
    function GetClientAdjusting:TRect;
    procedure DesignPaintingChanged;
    procedure CalcVariableSizes(FirstPass:boolean); virtual;
    function VariableSize:boolean;
    function VariableHeightSize:boolean;
    function VariableWidthSize:boolean;
    procedure DrawFrame;
    procedure PaintOuterBorder;
    function CanUseMouseClick: boolean;
    function EffectsAllowed: boolean; virtual;
    function BetterNotToDelete(DeletionList: TList; var Reason: WideString): boolean; virtual;
    function SuitableKind:TDesignedFor; virtual;
    procedure SaveAsImage(const FileName:TPathName; WithBackground:boolean=false);
    function VirtualParent:TControl; virtual;
    constructor Create(AOwner: TComponent); override;
    procedure ConstrainedResize(var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer); override;
    procedure WeakToStrong(IncludeActiveStrong:boolean; ALeft, ATop, AWidth, AHeight:Integer); overload;
    property Style:TStyle index hsNormal read GetStyle write SetStyle;
    property Transparent : boolean read GetTransparent write SetTransparent stored false;
    property Color stored false;
    property Font stored false;
    property Cursor stored false;
    property AutoSizeXY:TASXY read FAutoSize write SetASXY;
    property ImageType:TImageType read FImageType write SetImageType default bitInherit;
    property ImageFormat:TImageFormat read FImageFormat write FImageFormat default ifInherit;
    property VertPosition:integer read VPos write SetVPos default 0;
    property HorzPosition:integer read HPos write SetHPos default 0;
    property OnDragOver;
    property OnDragDrop;
    property Right:Integer read CSSRight write SetRight stored IsRightStored default InvalidCSSPos;
    property Bottom:Integer read CSSBottom write SetBottom stored IsBottomStored default InvalidCSSPos;
  published
    property Left stored IsLeftStored;
    property Top stored IsTopStored;
    property Width stored IsWidthStored;
    property Height stored IsHeightStored;
    property Tooltip:HypeString read FTooltip write FTooltip;
  end;

  TdhPanel = class(TdhCustomPanel)
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

  TPreAddCompo=procedure(parent:TdhCustomPanel);

  TPostAddCompo=procedure(Page:TdhCustomPanel);

function CursorToString(Cursor: TCSSCursor): TEnumName;
function GetCursorBack(Cursor:TCursor):TCSSCursor;

function GetHyphens(const s:TEnumName; from:integer=4):TEnumName;
function GetCSSPropName(PropChoose:TPropChoose):TEnumName;
function GetCSSPropValue(PropChoose:TPropChoose):TEnumName;
function WithPX(const s:AString):AString;
function GetNearestFont(const s:TFontName):TFontName;
function GetFontList(const s:TFontName):TStringList;
function GetBorderRadiusString(al:TEdgeAlign):TEnumName;
function GetBorderRadiusStringSafari(al:TEdgeAlign):TEnumName;
function GetBorderRadiusStringMoz(al:TEdgeAlign):TEnumName;

procedure AddRect(var Rect:TRect; a:TRect);
function GetAddRect(Rect:TRect; a:TRect):TRect;
function ShrinkRect(const a,b:TRect):TRect;
function InflRect(const a,b:TRect):TRect;
function EqualPoint(const P1, P2: TPoint): Boolean;
procedure DecPt(var pt:TPoint; const decr:TPoint);
procedure IncPt(var pt:TPoint; const decr:TPoint);
function Between(i,_min,_max:integer):integer; inline;
function AddPoint(const a:TPoint; const b:TPoint):TPoint;
function rGetOffsetRect(R:TRect; P:TPoint):TRect;
procedure rOffsetRect(var Rect: TRect; D:TPoint);
function DoIntersectStrong(R1,R2:TRect):boolean;
function IsNullRect(const R:TRect):boolean;

function GetVirtualParent(C:TControl):TControl;
function GetTopForm(P:TControl):TScrollingWinControl;
function NameWithForm(c:TControl):TComponentName;
function GetBaseZOrder(Child:TControl; ChildPos:integer):integer;
procedure UpdateZIndex(Self:TWinControl);
function GetChildPosition(Child:TControl):integer;
function iControlAtPos(c:TWinControl; const pt: TPoint):TControl;
function MyFindControl(Handle: HWnd): TControl; overload;
function MyFindControl(c:TControl): TControl; overload;
function MyFindDragTarget(const Pos: TPoint; AllowDisabled: Boolean): TControl;
function FinalVisible(c:TControl):boolean;

function GetCBound(c:TControl):TRect;
function GetPhysicalScreenClientBound(c:TControl):TRect;
function AdjustedClientRect(c:TWinControl):TRect;
function GetBoundsFor(c:TControl; DeltaLeft,DeltaTop,DeltaWidth,DeltaHeight:integer):TRect;
function _GetNotClipped(Self: TControl; OnlyOneParent:boolean=False):TRect;

procedure DoCalcStrongToWeak(var ALeft,ATop,AWidth,AHeight:integer; const ClientBound:TRect; Anchors:TAnchors; const CSSRight,CSSBottom:integer);
function GetSimplifiedAnchors(Anchors:TAnchors; ParentAnchors:TAnchors; StopSimplifyingRight,StopSimplifyingBottom:boolean):TAnchors;
function _RealAnchors(Anchors:TAnchors; img:boolean):TAnchors;

procedure Browse(URL:TPathName; Viewer:TPathName; maxi:boolean; browse:boolean=false);
function ConsumeMouseWheel(c:TControl; WheelDelta: Integer):boolean;
procedure InvalTrans(C:TControl); overload;

procedure Register;

const NoWH=-1;
const NextStyle:array[boolean] of TState=(hsOver,hsDown);
const NextStyleOld:array[boolean,TState] of TState=((hsNormal,hsNormal,hsNormal,hsOver),(hsNormal,hsNormal,hsNormal,hsDown));
const VertScrollbar=16;
      HorzScrollbar=16;
      VertScrollbarButtonHeight=16;
      HorzScrollbarButtonWidth=16;
const EnableIgnoreCSS=True;
const asar:array[boolean,boolean] of TASXY=((asNone,asY),(asX,asXY));
const CSSCursorMap:array[TCSSCursor] of TCursor=
  (crDefault,crDefault,crCross,crArrow,crHandPoint,crSizeAll,
   crSizeWE,crSizeNESW,crSizeNWSE,crSizeNS,           crSizeNWSE,crSizeNESW,crSizeNS,crSizeWE,
   crIBeam,crHourGlass,crHelp);
const default_borderwidth=1;

{set by designer}
var
    glPreAddCompo:TPreAddCompo;
    glPostAddCompo:TPostAddCompo;
    glIsDesignerSelected:function (Control:TControl):boolean;
    glChangedContent:procedure (Control:TControl; commit:boolean);
    _RuntimeMode:boolean=false;
    DesignStyle:TState=hsNormal;
    NotifyDebug:procedure(s:AString);

{set by the HTML generator}
var
    UseCSS3:boolean=false; {whether CSS3 constructs may be used}
    PreventAdjustMargin:boolean=false; {prevents calling AdjustMarginWidth to get the unmodified margin width}

{message strings which may be localized}
var
    REFOBJECT_STR:WideString= '% is referenced by %';

{misc}
var
    glPaintOnlyBg:boolean;
    glSelCompo,glEventObj:TControl;
    CancelInvDesigner:boolean;
    glUpdateOver:TUpdateOver;


implementation

const GetItalicFontStyle:array[boolean] of TCSSFontStyle=(cfsNormal,cfsItalic);
const GetBoldFontWeight:array[boolean] of TCSSFontWeight=(cfwNormal,cfwBold);

const rasterReason:array[TRasterType] of AString=(EmptyStr,'enabled Effects','rounded corners','RGBA colors','a semi-transparent image','the image type "Stretch"','the image type "Split"','enabled Effects (not applying to textual content)');

var PreventAlignControls:boolean=false;

const MyDragThreshold=5;
var MyDragStartPos:TPoint;

procedure Browse(URL:TPathName; Viewer:TPathName; maxi:boolean; browse:boolean=false);
var i:integer;
    success:boolean;
{$IFDEF MSWINDOWS}
    res:HINST;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
 if (URL<>EmptyStr) and (browse or CharInSet(URL[length(URL)],['\','/'])) and not SubEqual('http:',URL) then
 begin
  URL:='/e,/n,/select,"'+URL+'"';
  Viewer:='explorer.exe';
 end else
  URL:='"'+URL+'"';
 if maxi then
  i:=3{SW_MAXIMIZE} else
  i:=5{SW_SHOW};
 if Viewer<>EmptyStr then
  res:=ShellExecute(0,nil,PChar(Viewer),PChar(URL),nil,i) else
  res:=ShellExecute(0,nil,PChar(URL),nil,nil,i);
 success:=res>32;
 if not success then
  showmessage('Failed to open browser window.'+#10+#10+'Command was:'+#10+Viewer+' '+URL+#10+#10+'Please choose a different browser application in the Options dialog.'+#10+#10+'Error message was:'+#10+SysErrorMessage(GetLastError));
{$ELSE}
 if Viewer=EmptyStr then
  Viewer:='kfmclient exec';
 if libc.system(PChar(Viewer+' '+URL))<>0 then
  showmessage('Failed to execute'+#10+Viewer+' '+URL+#10+'Please choose a different browser application in the Options dialog');
{$ENDIF}
end;

procedure DecPt(var pt:TPoint; const decr:TPoint);
begin
 dec(pt.X,decr.X);
 dec(pt.Y,decr.Y);
end;

procedure IncPt(var pt:TPoint; const decr:TPoint); overload;
begin
 inc(pt.X,decr.X);
 inc(pt.Y,decr.Y);
end;

procedure IncPt(var pt:TPoint; const decrX,decrY:integer); overload;
begin
 inc(pt.X,decrX);
 inc(pt.Y,decrY);
end;

function GetVirtualParent(C:TControl):TControl;
begin
 if C is TdhCustomPanel then
  result:=TdhCustomPanel(C).VirtualParent else
  result:=C.Parent;
end;

var NoRotating:boolean=false;

var FMouseControl:TControl;

type _TFakeWinControl=class(TWinControl)
public
{$IFNDEF CLX}
    property BevelKind;
    property BorderWidth;
    property BevelInner;
    property BevelOuter;
    property BevelEdges;
    property BevelWidth;
    property Ctl3D;
{$ENDIF}    
end;

type _TFakeControl=class(TControl)
  public
    property Color;
    property ParentFont;
end;

function NameWithForm(c:TControl):TComponentName;
begin
 result:=GetTopForm(c).Name+'.'+c.Name;
end;

function InUseList(P,LookUp:ICon):boolean;
begin
  while P<>nil do
  if P=LookUp then
  begin
   result:=true;
   exit;
  end else
   P:=P.GetCommon.FUse;
  result:=false;
end;

function GetTopForm(P:TControl):TScrollingWinControl;
begin
 while (P<>nil) and (P.Parent<>nil) do
  P:=P.Parent;
 if P is TScrollingWinControl then
  result:=TScrollingWinControl(P) else
  result:=nil;
end;

function EqualPoint(const P1, P2: TPoint): Boolean;
begin
  Result := (P1.X = P2.X) and (P1.Y = P2.Y);
end;

function AddPoint(const a:TPoint; const b:TPoint):TPoint;
begin
 result.X:=a.X+b.X;
 result.Y:=a.Y+b.Y;
end;

function TdhCustomPanel.GetStyleByName(const name:TPropertyName; var r:TStyle):boolean;
var State:TState;
begin
 for State:=low(TState) to high(TState) do
 if sStyle[State]=name then
 begin
  r:=StyleArr[State];
  result:=true;
  exit;
 end;
 result:=false;
end;

procedure RectAddSub(var Rect:TRect; a,b:TRect); //Rect:=Rect+a-b
begin
  inc(Rect.Top,a.Top-b.Top);
  inc(Rect.Left,a.Left-b.Left);
  inc(Rect.Right,a.Right-b.Right);
  inc(Rect.Bottom,a.Bottom-b.Bottom);
end;

procedure AddRect(var Rect:TRect; a:TRect);
begin
  inc(Rect.Top,a.Top);
  inc(Rect.Left,a.Left);
  inc(Rect.Right,a.Right);
  inc(Rect.Bottom,a.Bottom);
end;

function GetAddRect(Rect:TRect; a:TRect):TRect;
begin
  inc(Rect.Top,a.Top);
  inc(Rect.Left,a.Left);
  inc(Rect.Right,a.Right);
  inc(Rect.Bottom,a.Bottom);
  result:=Rect;
end;

function ShrinkRect(const a,b:TRect):TRect;
begin
 result:=a;
 inc(result.Top,b.Top);
 inc(result.Left,b.Left);
 dec(result.Right,b.Right);
 dec(result.Bottom,b.Bottom);
end;

function InflRect(const a,b:TRect):TRect;
begin
 result:=a;
 dec(result.Top,b.Top);
 dec(result.Left,b.Left);
 inc(result.Right,b.Right);
 inc(result.Bottom,b.Bottom);
end;

function TdhCustomPanel.GetClientRect:TRect;
begin
 result:=TotalRect; //esp. required by CLX
end;

const IgnoreBottomScrollbar=false;

procedure TdhCustomPanel.AdjustScrolling(var R: TRect);
begin
 if IgnoreBottomScrollbar and not (FAutoSize in [asY,asXY]) then
  with ScrollEdgesPure do R:=ShrinkRect(R,Rect(Left,Top,Right,0)) else  //since lower scroll bar belongs to client area, exclude only right scroll bar
  R:=ShrinkRect(R,ScrollEdgesPure);
 OffsetRect(R,-HPos, -VPos);
end;

procedure TdhCustomPanel.AdjustClientRect(var Rect: TRect);
begin
  if IsScrollArea then
  begin
   AdjustScrolling(Rect);
  end;
  Rect:=ShrinkRect(Rect,AllEdgesPure);
  with PhysicalClientBound do OffsetRect(Rect,-Left,-Top);
end;

function TFakeControl(c:TControl):_TFakeControl; {$IFDEF VER160}unsafe;{$ENDIF}
type PFakeControl=^_TFakeControl;
begin
 result:=PFakeControl(@c)^;
end;

function TFakeWinControl(c:TWinControl):_TFakeWinControl; {$IFDEF VER160}unsafe;{$ENDIF}
type PWinFakeControl=^_TFakeWinControl;
begin
 result:=PWinFakeControl(@c)^;
end;

procedure TdhCustomPanel.CSSToColor;
begin
 if Transparent then
  Color:=CSSColorToColor(GetVirtualBGColor) else
  Color:=CSSColorToColor(BackgroundColor);
end;

function AdjustedClientRect(c:TWinControl):TRect;
begin
 result:=c.ClientRect;
 TFakeWinControl(c).AdjustClientRect(result);
end;

procedure TdhCustomPanel.CSSToCursor;
begin
 Cursor:=CSSCursorMap[GetCursor];
end;

function TdhCustomPanel.DoGetVal(PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign; var DoExit:boolean):boolean;
begin
 DoExit:=false;
 result:=false;
end;

function GetBaseZOrder(Child:TControl; ChildPos:integer):integer;
begin
 if (Child.Align<>alTop) and (Child.Parent<>nil) then
  result:=ChildPos+1*Child.Parent.ControlCount else
  result:=ChildPos;
end;

var BehindAllOthers:TControl;

function GetZOrder(Child:TControl; ChildPos:integer):integer; overload;
begin
  if Child=BehindAllOthers then
   result:=-maxint else
  if Child is TdhCustomPanel then
   result:=TdhCustomPanel(Child).AdjustZIndex(ChildPos,Child.Parent.ControlCount) else
   result:=GetBaseZOrder(Child,ChildPos);
end;

function TdhCustomPanel.AdjustZIndex(ChildPos,ParentControlCount:integer):integer;
begin
 result:=GetBaseZOrder(Self,ChildPos)+ZIndex*ParentControlCount*8;
end;

function GetChildPosition(Child:TControl):integer;
begin
 with Child.Parent do
 for result:=0 to ControlCount-1 do
 if Controls[result]=Child then
  exit;
 result:=-1;
end;

function GetZOrder(Child:TControl):integer; overload;
begin
 result:=GetZOrder(Child,GetChildPosition(Child));
end;

procedure TdhCustomPanel.InvalDeepestBack;
begin
 BehindAllOthers:=Self;
 try
  InvalBack;
 finally
  BehindAllOthers:=nil;
 end;
end;

procedure UpdateZIndex(Self:TWinControl);
var i,p,sp,bestp,besti:integer;
    Pos: HWND;
begin
 with Self do
 begin
 if not HandleAllocated then exit;
 if Parent=nil then exit;
 if Self is TdhCustomPanel then
 TdhCustomPanel(Self).InvalDeepestBack;
 sp:=GetZOrder(Self);
 besti:=0;
 besti:=-1;
 bestp:=maxint;
 for i:=0 to Parent.ControlCount-1 do
 if (Parent.Controls[i] is TWinControl) and (Parent.Controls[i]<>Self) and TWinControl(Parent.Controls[i]).HandleAllocated then
 begin
  p:=GetZOrder(Parent.Controls[i],i);
  if sp<p then
  if (besti=-1)or (p<bestp) then
  begin
   besti:=i;
   bestp:=p;
  end;
 end;
{$IFNDEF CLX}
 if besti=-1 then
  Pos:=HWND_TOP else
  Pos:=(Parent.Controls[besti] as TWinControl).Handle;
 SetWindowPos(Handle, Pos, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOACTIVATE);
{$ELSE}
 if besti=-1 then
  QWidget_raise(Handle) else
 if besti=0 then
  QWidget_lower(Handle) else
  QWidget_stackUnder(Handle, (Parent.Controls[besti] as TWinControl).Handle);
{$ENDIF}
 end;
end;

procedure TdhCustomPanel.ReadAutoSizeVerticalOnly(Reader:TReader);
begin
 Reader.ReadBoolean;
 AutoSizeXY:=asY;
end;

procedure TdhCustomPanel.ReadAutoSize(Reader:TReader);
begin
 if Reader.ReadBoolean then
 begin
   AutoSizeXY:=asXY;
 end else
 begin
  AutoSizeXY:=asNone;
 end;
end;

procedure TdhCustomPanel.DoCSSToWinControl(WhatChanged:TWhatChanged);
begin
 if wcFont in WhatChanged then
  InvalidateFontSize;
 if (wcSize in WhatChanged) and not (csLoading in ComponentState) then
 begin
  BorderChanged;
  AdjustSize;
  MyRealign;
  RequestAlign;   //image->scale wechsel
 end;
end;

function TdhCustomPanel.GetCommon:TdhCustomPanel;
begin
 result:=self;
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.CreateHandle;
begin
 inherited;
// if not InCSSToWinControl then //can happen in TdhMenu.UpdateMenu due to a shared value
//  CSSToWinControl(ActStyleChanged);
end;
{$ENDIF}

{$IFDEF CLX}
procedure TdhCustomPanel.ShowingChanged;
{$ELSE}
procedure TdhCustomPanel.CMShowingChanged(var Message: TMessage);
{$ENDIF}
begin
 inherited;
 if Showing then
 begin
  NotifyCSSChanged(ActStyleChanged);
 end;
end;

procedure TdhCustomPanel.CSSToWinControl(WhatChanged:TWhatChanged=[]);
var _State:TState;
begin
 if Fetching then exit;
 if InCSSToWinControl then
 begin
  showmessage('Already executing CSSToWinControl!');
  exit;
 end;
 //if WindowHandle=0 then exit;

// if not Control.HasParent or (csDestroying in Control.Parent.ComponentState) then exit;
 if csLoading in ComponentState then exit;
 if csDestroying in ComponentState then exit;
 InCSSToWinControl:=true;
 try

 //if (Control is TWinControl) and not TWinControl(Control).HandleAllocated then exit;
 if not FinalShowing then
 begin
  WhatChanged:=WhatChanged*ReqInvals;
 end;


 if wcState in WhatChanged then
 begin
  if InCollectChanges then
  assert(not InCollectChanges);
  CollectChanges:=[];
  InCollectChanges:=true;
  try
   CheckDesignState;
   WhatChanged:=WhatChanged+CollectChanges;
   DoCSSToWinControl(WhatChanged);
   WhatChanged:=WhatChanged+CollectChanges;
  finally
   InCollectChanges:=false;
  end;
 end else
  DoCSSToWinControl(WhatChanged);

 if wcZIndex in WhatChanged then
  UpdateZIndex(self);

{$IFDEF SYNC_PROP}
 if wcFont in WhatChanged then
  CSSToFont;
 if wcColor in WhatChanged then
  CSSToColor;
 if wcCursor in WhatChanged then
  CSSToCursor;
{$ENDIF}

 if wcParent in WhatChanged then
  InvalBack else
  InvalTop(true,true);

 for _State:=low(TState) to high(TState) do
 if StyleArr[_State]<>nil then
  StyleArr[_State].RasteringFile:='';
 finally
  InCSSToWinControl:=false;
 end;
end;


function TdhCustomPanel.FontWeight:TCSSFontWeight;
begin
 if GetVal(pcFontWeight) then
  result:=Cascaded.FontWeight else
  result:=cfwNormal;
end;

function TdhCustomPanel.FontVariant:TCSSFontVariant;
begin
 if GetVal(pcFontVariant) then
  result:=Cascaded.FontVariant else
  result:=cfvNormal;
end;

function TdhCustomPanel.FontStyle:TCSSFontStyle;
begin
 if GetVal(pcFontStyle) then
  result:=Cascaded.FontStyle else
  result:=cfsNormal;
end;

function TdhCustomPanel.GetFontColor:TCSSColor;
begin
 if GetVal(pcColor) then
  result:=Cascaded.Color else
  result:=clBlackCSS;
end;

function TdhCustomPanel.ComputedFontSize:integer;
begin
 result:=Round(GetComputedFontSize);
end;

function TdhCustomPanel.AllHTMLCode:HypeString;
begin
 result:=EmptyStr;
end;

function TdhCustomPanel.GetCharset:TFontCharset;
var c:TControl;
begin
 c:=self;
 while c<>nil do
 if (c is TCustomForm) then
 begin
  result:=TCustomForm(c).Font.Charset;
  exit;
 end else
  c:=c.Parent;
 result:=DEFAULT_CHARSET;
end;

procedure TdhCustomPanel.CSSToFont(Font:TFont=nil);
var OldOnChange:TNotifyEvent;
    _FontStyle:TFontStyles;
begin
 if Font=nil then
  Font:=Self.Font;

 OldOnChange:=Font.OnChange;
 Font.OnChange:=nil;
 Font.Name:=NearestFontFamily;
 Font.Height:=-ComputedFontSize;
 Font.Color:=CSSColorToColor(FontColor);
 _FontStyle:=[];
 if Bold then
  include(_FontStyle,fsBold);
 if Italic then
  include(_FontStyle,fsItalic);
 if Underline then
  include(_FontStyle,fsUnderline);
 if LineThrough then
  include(_FontStyle,fsStrikeOut);
 Font.Style:=_FontStyle;

 if Assigned(OldOnChange) then
  OldOnChange(Font); //refer1
 Font.OnChange:=OldOnChange;
end;

procedure TdhCustomPanel.FontHasChanged;
begin
 if not InCSSToWinControl then
 begin
  with Font do
   GetFontDifferences(Style,ColorToCSSColor(Color),Name,Height);
  NotifyCSSChanged([wcFont]);
 end;
end;

procedure TdhCustomPanel.ColorHasChanged;
begin
 if not InCSSToWinControl then
 begin
  if BackgroundColor<>ColorToCSSColor(Color) then
   ActStyle.BackgroundColor:=ColorToCSSColor(Color);
  NotifyCSSChanged([wcColor]);
 end;
end;

procedure TdhCustomPanel.CursorHasChanged;
begin
 if not InCSSToWinControl then
 begin
  if GetCursor<>GetCursorBack(Cursor) then
   ActStyle.Cursor:=GetCursorBack(Cursor);
  NotifyCSSChanged([wcCursor]);
 end;
end;

procedure TdhCustomPanel.ParentFontHasChanged;
begin
 if not InNotifyCSSChanged and not InCSSToWinControl then
  NotifyCSSChanged([wcFont,wcNoOwnCSS]);
end;

procedure TdhCustomPanel.ParentColorHasChanged;
begin
 if not InNotifyCSSChanged and not InCSSToWinControl then
  NotifyCSSChanged([wcColor,wcParent,wcNoOwnCSS])
end;

procedure NotifyChilds(P:TWinControl; WhatChanged:TWhatChanged);
var i:integer;
    c:TControl;
begin
 for i:=0 to P.ControlCount-1 do
 begin
  c:=P.Controls[i];
  if not (csDestroying in c.ComponentState) then
  begin
   if c is TdhCustomPanel then
    TdhCustomPanel(c).CSSToWinControl(WhatChanged);
   if c is TWinControl then
    NotifyChilds(TWinControl(c),WhatChanged);
  end;
 end;
end;

procedure TdhCustomPanel.SkipValue(Reader: TReader);
begin
 Reader.SkipValue;
end;

function TdhCustomPanel.BetterNotToDelete(DeletionList:TList; var Reason:WideString):boolean;
var i:integer;
    UsedBy:TdhCustomPanel;
begin
  for i:=0 to UsedByList.Count-1 do
  begin
   UsedBy:=TdhCustomPanel(UsedByList[i]);
   if DeletionList.IndexOf(UsedBy)=-1 then
   begin
    Reason:=WFormat(REFOBJECT_STR,[Name,UsedBy.Name]); //is used by
    result:=true;
    exit;
   end;
  end;
  for i:=0 to InlineUsedByList.Count-1 do
  begin
   UsedBy:=TdhCustomPanel(InlineUsedByList[i]);
   if DeletionList.IndexOf(UsedBy)=-1 then
   begin                                  
    Reason:=WFormat(REFOBJECT_STR,[Name,UsedBy.Name]); //is used in the text of
    result:=true;
    exit;
   end;
  end;
  result:=false;
end;

function TdhCustomPanel.AllowAutoSizeY:boolean;
begin
 result:=true;
end;

function TdhCustomPanel.AlignedTo:TAlign;
var i:integer;
begin
 result:=alNone;
 for i:=0 to ControlCount-1 do
 if FinalVisible(Controls[i]) then
 if result=alNone then
 begin
  result:=Controls[i].Align;
  if result=alNone then
   exit;
 end else
 if Controls[i].Align<>result then
 begin
  result:=alNone;
  exit;
 end else
  result:=Controls[i].Align;
end;

function TdhCustomPanel.CenterMargins:TPoint;
var P:TdhCustomPanel;
begin
 if (Parent is TdhCustomPanel) then
 begin
  P:=TdhCustomPanel(Parent);
  if P.IsScrollArea then
  with p.AllEdgesPure do
  begin
   Result.X:=Left;
   Result.Y:=Right;
  end else
  with p.PaddingPure do
  begin
   Result.X:=Left;
   Result.Y:=Right;
  end;
 end;
 if IsRastered(true)=rsNo then
 with MarginPure do
 begin
  Inc(Result.X,Left);
  Inc(Result.Y,Right);
 end;
end;
          
function InStyleSheet(p:TControl):boolean;
begin
 p:=GetVirtualParent(p);
 while p<>nil do
 if p.ClassName='TdhStyleSheet' then
 begin
  result:=true;
  exit;
 end else
  p:=GetVirtualParent(p);
 result:=false;
end;

function TdhCustomPanel.PreventFull(Cause:TTransformations):boolean;
var i:integer;
begin
   if (InlineUsedByList.Count<>0) or (ControlCount<>0) then
   begin
    result:=true;
    exit;
   end;
   for i:=0 to UsedByList.Count-1 do
   if TdhCustomPanel(UsedByList[i]).PreventFull(Cause) then
   begin
    result:=true;
    exit;
   end;
   result:=false;
end;

procedure TdhCustomPanel.ReleaseResources;
var State:TState;
begin
 for state:=low(TState) to high(TState) do
  if StyleArr[state]<>nil then
   StyleArr[state].BackgroundImage.ReleaseResources;
end;

function TdhCustomPanel.VariableSize:boolean;
begin
 result:=VariableHeightSize or VariableWidthSize;
end;

function TdhCustomPanel.VariableHeightSize:boolean;
begin
 result:=VariableHeight or (SimplifiedAnchors*[akTop,akBottom]=[akTop,akBottom]);
end;

function TdhCustomPanel.VariableWidthSize:boolean;
begin
 result:=(SimplifiedAnchors*[akLeft,akRight]=[akLeft,akRight]);
end;

function TdhCustomPanel.NeedPadding(HasRastering:TRasterType):boolean;
begin
 result:=(HasRastering<>rsNo) and ChildHasAnchor([akTop]);
end;

function GetBoundsFor(c:TControl; DeltaLeft,DeltaTop,DeltaWidth,DeltaHeight:integer):TRect;
begin
    if (akRight in c.Anchors) and not (akLeft in c.Anchors) then
    begin
     Dec(DeltaLeft,DeltaWidth);
    end;
    if (akBottom in c.Anchors) and not (akTop in c.Anchors) then
    begin
     Dec(DeltaTop,DeltaHeight);
    end;
    result:=Bounds(c.Left+DeltaLeft,c.Top+DeltaTop,c.Width+DeltaWidth,c.Height+DeltaHeight);
end;

function TdhCustomPanel.ChildHasAnchor(a:TAnchors):boolean;
var i:integer;
begin
 for i:=0 to ControlCount-1 do
 if Controls[i].Anchors*a<>[] then
 begin
  result:=true;
  exit;
 end;
 result:=false;
end;

procedure TdhCustomPanel.FocusPreferStyle(IsMain,RealChange:boolean);
begin
 if RealChange then
  PreferStyleChange;
end;

procedure TdhCustomPanel.PreferStyleChange;
begin
 CSSToWinControl(ActStyleChanged*ReqInvals);
 if (wcZIndex in ActStyleChanged) and not (wcZIndex in ReqInvals) then
  InvalDeepestBack;
end;

procedure TdhCustomPanel.SetPreferStyle;
var PreferState:TState;
begin
 if not((PreferStyle=nil)<>(Value=nil)) then
 assert((PreferStyle=nil)<>(Value=nil));
 if PreferStyle<>Value then
 begin
  if PreferStyle<>nil then
   PreferState:=PreferStyle.OwnState else
   PreferState:=Value.OwnState;
  PreferStyle:=Value;
  if not OnlyForRetrieval then
   FocusPreferStyle(IsMain,(PreferState<>LastActStyle) and TransitionInvalidates);
 end;
end;

//require HandleAllocated
procedure TdhCustomPanel.InitSelfCBound(var _ContentWidthHeight:TPoint);
begin
   _ContentWidthHeight:=GetWantedSize;
   _SelfCBound:=GetBoundsFor(self,0,0,_ContentWidthHeight.X-Width,_ContentWidthHeight.Y-Height);
   with GetCBound(self).TopLeft do
    OffsetRect(_SelfCBound,X-Left,Y-Top);
end;

function TdhCustomPanel.BoundNextSibling:TdhCustomPanel;
begin
 Result:=nil;
end;

function TdhCustomPanel.BoundTop:Integer;
begin
 Result:=Top;
end;

function TdhCustomPanel.UsePn:TdhCustomPanel;
begin
  if Use=nil then
   result:=nil else
   result:=Use.GetCommon;
end;

function TdhCustomPanel.IsRastered(RespectStyleSheet:boolean):TRasterType;
var pn:TdhCustomPanel;
    state:TState;
    FPicture:TLocationImage;
    foundFullWithoutText:boolean;
begin
 result:=rsNo;
 if FIsScrollArea or RespectStyleSheet and InStyleSheet(Self) then
 begin
  result:=rsNo;
  exit;
 end;
 if RequiresRastering then
 begin
   result:=rsFull;
   exit;
 end;

 foundFullWithoutText:=false;
 if EffectsAllowed then
 for state:=low(TState) to high(TState) do
 begin
  pn:=Self;
  while (pn<>nil) do
  begin
   if (pn.StyleArr[state]<>nil) and pn.StyleArr[state].Effects.Enabled then
   begin
    if PreventFull(pn.StyleArr[state].Effects) then
    begin
     foundFullWithoutText:=true;
    end else
    begin
     result:=rsFull;
     exit;
    end;
    break;
   end;
   pn:=pn.UsePn;
  end;
 end;

 if foundFullWithoutText then
 begin
  result:=rsFullWithoutText;
  exit;
 end;

  for state:=low(TState) to high(TState) do
  if StyleArr[state]<>nil then
  begin
   SetPreferStyle(StyleArr[state],true,true);
   try

   if not UseCSS3 and HasBorderRadii then
   begin
    result:=rsRounded;
    exit;
   end;
   
   if not UseCSS3 and (not IsNullRect(SemiTransparentEdges) or SemiTransparent and not Transparent or not IsOpaqueColor(FontColor)) then
   begin
    result:=rsRGBA;
    exit;
   end;

   if HasBackgroundImage(FPicture) then
   case GetImageType of
   bitStretch:
   begin
    result:=rsStretch;
    exit;
   end;
   bitSplit:
   begin
    result:=rsSplit;
    exit;
   end;
   else
   if FPicture.ImgNeedBeRastered then
   begin
    result:=rsSemi;
    exit;
   end;
   end;

   finally
    SetPreferStyle(nil,true,true);
   end;
  end;
end;

procedure TdhCustomPanel.NotifyUsedByList(WhatChanged:TWhatChanged);
var i:integer;
begin
 NotifyInlineUsedByList(WhatChanged);
 for i:=UsedByList.Count-1 downto 0 do
 with TdhCustomPanel(UsedByList[i]) do
 begin
  CSSToWinControl(WhatChanged);
  NotifyUsedByList(WhatChanged);
 end;
end;

procedure TdhCustomPanel.NotifyInlineUsedByList(WhatChanged:TWhatChanged);
var i:integer;
    _InlineUsedByList:TList;
begin
 if [wcText,wcName]*WhatChanged<>[] then
 begin
  //originales InlineUsedByList kann durch InvalInline verändert werden
  _InlineUsedByList:=TList.Create;
  try
  _InlineUsedByList.Capacity:=InlineUsedByList.Capacity;
  for i:=0 to InlineUsedByList.Count-1 do
   _InlineUsedByList.Add(InlineUsedByList[i]);
  //_InlineUsedByList.Assign(InlineUsedByList);
  for i:=_InlineUsedByList.Count-1 downto 0 do
   TdhCustomPanel(_InlineUsedByList[i]).CSSToWinControl(WhatChanged);
  finally
   _InlineUsedByList.Free;
  end;
 end else
 for i:=InlineUsedByList.Count-1 downto 0 do
  TdhCustomPanel(InlineUsedByList[i]).CSSToWinControl(WhatChanged);
end;

procedure TdhCustomPanel.NotifyCSSChanged(WhatChanged:TWhatChanged);
begin
 if InCollectChanges then
 begin
  CollectChanges:=CollectChanges+WhatChanged;
  exit;
 end;
 if Fetching then exit;
 if InNotifyCSSChanged then
  showmessage('NotifyCSSChanged:'+Name+' ');
 if csLoading in ComponentState then exit;
 if InNotifyCSSChanged then exit;
 InNotifyCSSChanged:=true;
 try
 CSSToWinControl(WhatChanged);
 if not (wcNoOwnCSS in WhatChanged) then
  NotifyUsedByList(WhatChanged);
 if wcChild in WhatChanged then
  NotifyChilds(Self,WhatChanged*InheritableChanges+[wcNoOwnCSS]);
 finally
  InNotifyCSSChanged:=false;
 end;
end;

procedure TdhCustomPanel.GetFontDifferences(FontStyle:TFontStyles; FontColor:TCSSColor; FontName:TFontName; FontHeight:Integer );
begin
 Self.Bold:=fsBold in FontStyle;
 Self.Italic:=fsItalic in FontStyle;
 Self.Underline:=fsUnderline in FontStyle;
 Self.LineThrough:=fsStrikeOut in FontStyle;
 Self.FontColor:=FontColor;
 Self.NearestFontFamily:=FontName;
 Self.FontSize:=IntToStr(Abs(FontHeight));
end;

procedure TdhCustomPanel.InvDesigner;
var pf:TCustomForm;
begin
    if csDesigning in ComponentState then
    begin
     pf:=GetParentForm(Self);
     if not CancelInvDesigner then
{$IFNDEF CLX}
     if (pf<>nil)and (pf.Designer<>nil)  then
      pf.Designer.Modified;
{$ELSE}
     if (pf<>nil)and (pf.DesignerHook<>nil)  then
      pf.DesignerHook.ControlPaintRequest(Self);
{$ENDIF}
    end;
end;

function CustomIsDesignerSelected(Control:TControl):boolean;
begin
 result:=glSelCompo=Control;
end;

function TdhCustomPanel.RuntimeMode:boolean;
begin
 result:=_RuntimeMode or not (csDesigning in ComponentState);
end;

procedure TdhCustomPanel.CheckDesignState;
var OldState:TState;
begin
 OldState:=LastActStyle;
 if RuntimeMode or not glIsDesignerSelected(Self) then
  LastActStyle:=GetHTMLState else
  LastActStyle:=DesignStyle;
 if OldState<>LastActStyle then
 begin
  if not (csDestroying in ComponentState) and not (csLoading in  ComponentState) then
  begin
    InvDesigner;
    DoStateTransition(OldState);
  end;
 end;
end;

procedure TdhCustomPanel.DoStateTransition(OldState:TState);
begin
 if Assigned(FOnStateTransition) then
  FOnStateTransition(Self,OldState);
end;

function TdhCustomPanel.TransitionInvalidates:boolean;
begin
 result:=false;
end;

function TdhCustomPanel.ActStyle:TStyle;
begin
 CheckDesignState; // state should normally not change by this call
 result:=StyleArr[LastActStyle];
 if result=nil then
  result:=StyleArr[hsNormal];
end;

function TdhCustomPanel.State:TState;
begin
 result:=LastActStyle;
end;

function TdhCustomPanel.GetHTMLState:TState;
begin
  if (Self=glSelCompo) then
   Result:=hsOver else
   Result:=hsNormal;
end;

function TdhCustomPanel.GetCanvas:TCanvas;
begin
 result:=ActTopGraph.Canvas;
end;

function TdhCustomPanel.GetName:TComponentName;
begin
 result:=Name;
end;

function TdhCustomPanel.GetElementName:TComponentName;
begin
 result:=Name;
end;

const InvalidFontSize=-1;

function TdhCustomPanel.GetComputedFontSize:single;
begin
 if FComputedFontSize=InvalidFontSize then
 if Parent is TdhCustomPanel then
  FComputedFontSize:=GetFontSizePixels(FontSize,TdhCustomPanel(Parent).GetComputedFontSize) else
 if Parent<>nil then
  FComputedFontSize:=GetFontSizePixels(FontSize,-TFakeControl(Parent).Font.Height) else
  FComputedFontSize:=13;
 result:=FComputedFontSize;
end;

function TdhCustomPanel.DownIfDown:boolean;
begin
 result:=true;
end;

function ManageEventBubbling(Self:TControl):boolean;
begin
 result:=not ((Self<>glEventObj) and (Self is TWinControl) and TWinControl(Self).ContainsControl(glEventObj));
 glEventObj:=Self;
end;

procedure TdhCustomPanel.UpdateMousePressed(Down:boolean; DownIfDown:boolean);
begin
// if not ManageEventBubbling(Control) then exit;
 if DownIfDown then
 begin
  if not Visible and (csNoDesignVisible in ControlStyle) then //funzt net
   exit;
  glUpdateOver(Self,{Control=FindDragTarget(Mouse.CursorPos, True)}FIsOver,Down);
 end else
  glUpdateOver(Self,FIsOver,false);
end;

function TdhCustomPanel.GetUsed:boolean;
begin
 Result:=UsedByList.Count<>0;
end;

type PComponentState=^TComponentState;

function TdhCustomPanel.CanAutoX :boolean;
begin
  result:=not(Align in [alTop,alBottom,alClient]) and (FAutoSize in [asX,asXY]);
end;

function TdhCustomPanel.CanAutoY:boolean;
begin
  result:=not(Align in [alLeft,alRight,alClient]) and (FAutoSize in [asY,asXY]);
end;

//@require HandleAllocated
function TdhCustomPanel.GetWantedSize:TPoint;
begin

 //Should be done for all parents.
 //The csAlignmentNeeded condition is only possible if MyAlignControl is called
 if (Parent is TdhCustomPanel) and (csAlignmentNeeded in Parent.ControlState) then
  TdhCustomPanel(Parent).MyRealign;
 if (csAlignmentNeeded in ControlState) then
  Self.MyRealign;

 Result.X:=Width;
 Result.Y:=Height;
 DoAutoSize(Result.X,Result.Y);
end;

procedure TdhCustomPanel.DoAutoSize(var PreferedWidth,PreferedHeight:integer);
begin
 GetAutoRect(CanAutoX,CanAutoY,PreferedWidth,PreferedHeight);
end;

procedure TdhCustomPanel.ConstrainedResize(var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer);
begin
 //inherited; for speed we uncomment it (since ConstrainedResize calls itself recursively); GetSuperiorAutoRect does this job
end;

procedure TdhCustomPanel.PreventFlicker;
begin
 Invalidate;//damit Windows Hintergrundkopie nicht an einer neuer Position zeichnet ohne uns zu fragen, sonst ruckelts
            //gilt auch für CLX unter Windows
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
{$ELSE}
procedure TdhCustomPanel.ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer);
{$ENDIF}
var R,R2,R3:TRect;
begin

 if FinalShowing and not (csReading in ComponentState) then
 begin
 DoAutoSize(AWidth,AHeight);  //wird schon von AdjustSize erledigt später //gibt probleme

 R:=GetCBound(Self);

 if not EqualRect(R,Rect(ALeft,ATop,ALeft+AWidth,ATop+AHeight)) then
 begin
  PreventFlicker;
 end;

 if LightBoundsChanging then
  Inherited else
 begin
  LightBoundsChanging:=true;
  Inherited;
  LightBoundsChanging:=false;
 end;

 R2:=GetCBound(Self);
 if not EqualRect(R,R2) then
 begin
  UnionRect(R3,R,R2);
  InvalBack(R3);
  BorderChanged;
 end;

 end else
  inherited;

 WeakToStrong(false);
end;

function TdhCustomPanel.FinalShowing:boolean;
begin
 result:=Showing or WithMeta;
end;

procedure TdhCustomPanel.AdjustSize;
var R,R2,R3,nb:TRect;
    WantedSize:TPoint;
begin
 if not (csLoading in ComponentState) and FinalShowing then
 begin
  R:=GetCBound(Self);

  if (Align in [alTop,alBottom,alLeft,alRight]) and (Parent is TdhCustomPanel) then
{$IFNDEF CLX}
  if Parent.AlignDisabled then
   exit else
{$ENDIF}
  begin
   TdhCustomPanel(Parent).AdjustSize;
  end;

  WantedSize:=GetWantedSize;
  nb:=GetBoundsFor(Self,0,0,WantedSize.X-Width,WantedSize.Y-Height);
  if not EqualRect(nb,BoundsRect) then
  with nb do
   SetBounds(Left,Top,Right-Left,Bottom-Top);

  R2:=GetCBound(Self);
  if not EqualRect(R,R2) then
  begin
   UnionRect(R3,R,R2);
   InvalBack(R3);
  end;
   
 end else
  inherited;
end;

procedure TdhCustomPanel.BorderChanged;
begin
{$IFNDEF CLX}
  if IsScrollArea and NCScrollbars then
  if not (csLoading in ComponentState) and HandleAllocated then
  begin
    PreventFlicker;
    SetWindowPos(Handle, 0, 0, 0, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or
      SWP_NOZORDER or SWP_FRAMECHANGED{ or SWP_DRAWFRAME });
  end;
{$ELSE}
  CheckNC;
  CheckChildrenNC;
{$ENDIF}
end;

procedure rOffsetRect(var Rect: TRect; D:TPoint);
begin
 OffsetRect(Rect,D.X,D.Y);
end;

function GetOffsetRect(const Rect: TRect; DX,DY:integer):TRect;
begin
 result:=Rect;;
 OffsetRect(result,DX,DY);
end;

{$IFDEF CLX}
procedure TdhCustomPanel.CheckNC;
var _NC: TRect;
begin
  _NC:=GetNotClippedOne(DeltaX,DeltaY);
  if not EqualRect(NC,_NC) then
  begin
   NC:=_NC;
   DefDelta:=true;
   UpdateMask;
   DefDelta:=false;
  end;
end;

procedure TdhCustomPanel.CheckChildrenNC;
var i:integer;
begin
  if IsScrollArea and NCScrollbars then
  for i:=0 to ControlCount-1 do
  if Controls[i] is TdhCustomPanel then
   TdhCustomPanel(Controls[i]).CheckNC(DeltaX, DeltaY);
end;
{$ENDIF}

function TdhCustomPanel.IsDesigning:boolean;
begin
 result:=csDesigning in ComponentState;
end;

function TdhCustomPanel.GetControl:TControl;
begin
  result:=Self;
end;

function TdhCustomPanel.RecursiveShowing:Boolean;
var pn:TdhCustomPanel;
    i:integer;

function ParentsVisible(control:TWinControl):boolean;
begin
 while (control<>nil) do
 begin
   if not control.Visible then
   begin
     result:=false;
     exit;
   end;
   control:=control.Parent;
 end;
 result:=true;
end;

begin
 if ParentsVisible(Self) then
 begin
  result:=true;
  exit;
 end;
 for i:=Self.UsedByList.Count-1 downto 0 do
 begin
  pn:=TdhCustomPanel(Self.UsedByList[i]);
  if pn.RecursiveShowing then
  begin
   result:=true;
   exit;
  end;
 end;
 for i:=Self.InlineUsedByList.Count-1 downto 0 do
 begin
  pn:=TdhCustomPanel(Self.InlineUsedByList[i]);
  if ParentsVisible(pn) then
  begin
   result:=true;
   exit;
  end;
 end;
 result:=false;
end;

function findIRelativePathProvider(C:TControl):IRelativePathProvider;
begin
 while C<>nil do
 begin
  if C.GetInterface(IRelativePathProvider, Result) then
   Exit;
  C:=C.Parent;
 end;
 Result:=nil;
end;

function TdhCustomPanel.GetRelativePathProvider:IRelativePathProvider;
begin
 result:=findIRelativePathProvider(Self);
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params.WindowClass do
    style := style and not (CS_HREDRAW or CS_VREDRAW);
end;
{$ENDIF}

function verrechne(i1,i2:integer):integer;
begin
   if (i1>=0) and (i2>=0) then
    result:=min(i1,i2) else
   if (i1<=0) and (i2<=0) then
    result:=-min(i1,i2) else
    result:=-i1-i2;
end;

procedure TdhCustomPanel.ChildrenAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
var
  I,rNewHeight,rNewWidth,NewHeight2,NewWidth2,MaxWidth,MaxHeight: Integer;
  all:TAlign;
  c:TControl;
  RandX,RandY,AccWidth,AccHeight:integer;
  ClientAllowModifyX,ClientAllowModifyY:boolean;
  IsHorzScrollBarVisible,IsVertScrollBarVisible:boolean;
  PreNewWidth,PreNewHeight:integer;
  Avail,Req:TPoint;
var pn:TdhCustomPanel;
    mar:TRect;
    margintop:integer;
begin
   if not AllowModifyX and not AllowModifyY then exit; //for speed

   with AllEdgesPure do
   begin
    RandX:=Left+Right;
    RandY:=Top+Bottom;
   end;

  MaxWidth:=max(NewWidth-RandX,0);
  MaxHeight:=max(NewHeight-RandY,0);
  rNewHeight:=-1;
  rNewWidth:=-1;
  AccWidth:=0;
  AccHeight:=0;     
  margintop:=0;
  all:=AlignedTo;
  if all<>alNone then
  for I := 0 to ControlCount - 1 do
  begin
    c:=Controls[I];
    if (c.Align=all) and FinalVisible(c) then
    begin
       if c is TdhCustomPanel then
       begin
        pn:=TdhCustomPanel(c);
        mar:=pn.MarginPure;
        if (all in [alTop,alBottom,alClient]) then
         ClientAllowModifyX:=AllowModifyX else
         ClientAllowModifyX:=pn.FAutoSize in [asX,asXY];
        if (all in [alLeft,alRight,alClient]) then
         ClientAllowModifyY:=AllowModifyY else
         ClientAllowModifyY:=pn.FAutoSize in [asY,asXY];
        if (all in [alTop,alBottom,alClient]) then
         NewWidth2:=MaxWidth else
         NewWidth2:=c.Width;
        if (all in [alLeft,alRight,alClient]) then
         NewHeight2:=MaxHeight else
         NewHeight2:=c.Height;
        pn.GetAutoRect(ClientAllowModifyX,ClientAllowModifyY,NewWidth2,NewHeight2);
       end else
       begin
        mar:=Rect(0,0,0,0);
        NewWidth2:=c.Width;
        NewHeight2:=c.Height;
        if (all in [alTop,alBottom,alClient]) then
         NewWidth2:=0 else
         NewWidth2:=c.Width;
        if (all in [alLeft,alRight,alClient]) then
         NewHeight2:=0 else
         NewHeight2:=c.Height;
       end;

       if (all in [alLeft,alRight,alClient]) then
        rNewHeight:=max(rNewHeight,NewHeight2) else
       begin
        inc(AccHeight,NewHeight2);
        dec(AccHeight,verrechne(mar.Top,marginTop));
        marginTop:=mar.Bottom;
       end;

       if (all in [alTop,alBottom,alClient]) then
        rNewWidth:=max(rNewWidth,NewWidth2) else
       begin
        inc(AccWidth,NewWidth2);
        dec(AccWidth,verrechne(mar.Left,marginTop));
        marginTop:=mar.Right;
       end;

      end;
  end;

    PreNewWidth:=NewWidth;
    PreNewHeight:=NewHeight;

    if (all in [alTop,alBottom,alClient]) then
    begin
     if (rNewWidth<>-1) then
      PreNewWidth:=rNewWidth+RandX;
    end else
    if (all in [alLeft,alRight,alClient]) then
    begin
     PreNewWidth:=AccWidth+RandX;
    end;

    if (all in [alLeft,alRight,alClient]) then
    begin
     if (rNewHeight<>-1) then
     begin
      PreNewHeight:=rNewHeight+RandY;
     end;
    end else
    if (all in [alTop,alBottom,alClient]) then
    begin
     PreNewHeight:=AccHeight+RandY;
    end;

    Avail:=Point(NewWidth,NewHeight);
    Req:=Point(PreNewWidth,PreNewHeight);
    AddScrollbarPlace(IsHorzScrollBarVisible,IsVertScrollBarVisible,AllowModifyX,AllowModifyY,Avail,Req);
    NewWidth:=Avail.X;
    NewHeight:=Avail.Y;
end;

function TdhCustomPanel.GetSuperiorAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer):boolean;
var
  PicHeight,PicWidth,W,H:integer;
  R:TRect;
begin
 if HasImage(PicWidth,PicHeight) then
 begin
  with ClientEdgesPure do
  begin
   W:=PicWidth+Left+Right;
   H:=PicHeight+Top+Bottom;
  end;
  if not TextOnly then
   AdjustLittle(W,H,false);
  NewWidth:=W;
  NewHeight:=H;
  result:=true;
 end else
 begin
  R:=Rect(0,0,0,0);
  AdjustClientRect(R);
  W:=R.Left-R.Right+MinWidth;
  H:=R.Top-R.Bottom+MinHeight;
  if not TextOnly and not TextExclude then
   AdjustLittle(W,H,false);
  NewWidth:=max(W,NewWidth);
  NewHeight:=max(H,NewHeight);
  result:=false;
 end;
end;

//NewWidth may be only read if AllowModifyX=false
//NewWidth may be only written if AllowModifyX=true, except if Image
//NewHeight accordingly
procedure TdhCustomPanel.GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
begin
  if GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth, NewHeight) then exit;
  if _AutoResizing then
   showmessage('_AutoResizing already active!');
 _AutoResizing:=true;
  try
   ChildrenAutoRect(AllowModifyX,AllowModifyY, NewWidth, NewHeight);
  finally
   _AutoResizing:=false;
  end;
end;

function FinalVisible(c:TControl):boolean;
begin
 result:=c.Visible or (csDesigning in c.ComponentState) and not (csNoDesignVisible in c.ControlStyle);
end;

function TdhCustomPanel.Display:TCSSDisplay;
begin
 if GetVal(pcDisplay) then
  result:=Cascaded.Display else
  result:=cdsInline;
end;

function TdhCustomPanel.Visibility:boolean;
begin
 if GetVal(pcVisibility) then
  result:=Cascaded.Visibility=cviVisible else
  result:=true;
end;

function TdhCustomPanel.GetActDown: TActMode;
var P:TPoint;
begin
 result:=amNone;
 if not FIsScrollArea then exit;
 P:=Mouse.CursorPos;
 with GetCBound(Self).TopLeft do P:=Point(P.X-X,P.Y-Y);
 if IsVertScrollBarVisible and PtInRect(GetVertWhole,P) then
 begin
  if FOneButton then
   result:=VertOneButton else
  if PtInRect(self.GetVertBar,P) then
   result:=VertBar else
  if PtInRect(self.GetVertButton1,P) then
   result:=VertButton1 else
  if PtInRect(self.GetVertButton2,P) then
   result:=VertButton2 else
  if self.GetVertBar.Top>P.Y then
   result:=VertChecked1 else
   result:=VertChecked2;
 end else
 if IsHorzScrollBarVisible and PtInRect(GetHorzWhole,P) then
 begin
  if PtInRect(self.GetHorzBar,P) then
   result:=HorzBar else
  if PtInRect(self.GetHorzButton1,P) then
   result:=HorzButton1 else
  if PtInRect(self.GetHorzButton2,P) then
   result:=HorzButton2 else
  if self.GetHorzBar.Left>P.X then
   result:=HorzChecked1 else
   result:=HorzChecked2;
 end;
end;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhPanel]);
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;
{$ENDIF}

procedure TdhCustomPanel.Loaded;
begin
 Inherited;
 TryBrokenReferences(nil);
 CSSToWinControl(ActStyleLoaded);
end;

procedure TdhCustomPanel.NameChanged;
begin
   NotifyInlineUsedByList([wcName]);
end;

procedure TdhCustomPanel.UpdateMouse(MouseEnter:boolean);
begin
 if ManageEventBubbling(Self) then
 if not (csDesigning in ComponentState) then
  SetIsOver(MouseEnter);
end;

function TdhCustomPanel.SuitableKind:TDesignedFor;
begin
 result:=dfAnything;
end;

function TdhCustomPanel.VirtualParent:TControl;
begin
 result:=Parent;
end;

function TdhCustomPanel.GetLev:integer;
var pn:TControl;
begin
 result:=0;
 pn:=Self;
 while pn<>nil do
 if (pn is TdhCustomPanel) and (TdhCustomPanel(pn).VirtualParent<>pn.Parent) then
 begin
  pn:=TdhCustomPanel(pn).VirtualParent;
  inc(result);
 end else
  pn:=pn.Parent;
end;

function TdhCustomPanel.IsVirtualParentOf(pn:TControl):boolean;
begin
 while (pn<>nil) and (pn<>Self) do
 if pn is TdhCustomPanel then
  pn:=TdhCustomPanel(pn).VirtualParent else
  pn:=pn.Parent;
 result:=pn=Self;
end;

function TdhCustomPanel.LeaveY:boolean;
begin
 result:=false;
end;

function DoIntersectStrong(R1,R2:TRect):boolean;
begin
 IntersectRect(R1,R1,R2);
 Result:=not IsRectEmpty(R1);
end;

procedure TdhCustomPanel.SetVHPos(H,V:integer);
var OldPos,P:TPoint;
begin
 OldPos:=Point(HPos,VPos);
 if VertScrollInfo.nMax<>0 then
  V:=min(V,VertScrollInfo.nMax-VertScrollInfo.nPage);
 if HorzScrollInfo.nMax<>0 then
  H:=min(H,HorzScrollInfo.nMax-HorzScrollInfo.nPage);
 P:=Point(H,V);
 P:=Point(max(P.X,0),max(P.Y,0));
 if EqualPoint(P,OldPos) then exit;
 HPos:=P.X;
 VPos:=P.Y;
 ScrollPaintChanged;
 InvalTop(SomethingIsFixed,SomethingIsScrolled);
 assert(not PreventAlignControls);
 PreventAlignControls:=true;
 ScrollBy(OldPos.X-HPos,OldPos.Y-VPos);
 ChildrenAdjustStrong(HPos-OldPos.X,VPos-OldPos.Y);
 PreventAlignControls:=false;
{$IFNDEF CLX}
 (Owner as TControl).Update;
{$ENDIF}
end;

function TdhCustomPanel.ValidChildrenInvalidParent:boolean;
begin
 result:=IsScrollArea and not SomethingIsFixed;
end;

function TdhCustomPanel.SomethingIsFixed:boolean;
begin
 result:=IsScrollArea and (not NCScrollbars or not Opaque or (BackgroundAttachment=cbaFixed) and HasBackgroundImage);
end;

function TdhCustomPanel.SomethingIsScrolled:boolean;
begin
 result:=(BackgroundAttachment=cbaScroll) and HasBackgroundImage;
end;

function TdhCustomPanel.GetInnerClientArea:TRect;
begin
  with self.ScrollArea do
  result:=Bounds(Left-HPos,Top-VPos,max(HorzScrollInfo.nMax,Right-Left),max(VertScrollInfo.nMax,Bottom-Top));
end;

//if AllowModifyX is enabled, the place for a vert. scrollbar is taken by increasing available width (=Avail.X)
//if AllowModifyX is not enabled, the place for vert. scrollbar is added to the requested width (=Req.X) to keep the ratio to the available width
//if AllowModifyX is not enabled, Req.X may be MaxInt to signal that the vert. scrollbar should be visible if possible
//note that if AllowModifyX is enabled, never a horz. scrollbar is added
//AllowModifyY accordingly..
procedure TdhCustomPanel.AddScrollbarPlace(var IsHorzScrollBarVisible,IsVertScrollBarVisible:boolean; AllowModifyX,AllowModifyY:boolean; var Avail,Req:TPoint);
begin
  if AllowModifyX then
   Avail.X:=Req.X;
  if AllowModifyY then
   Avail.Y:=Req.Y;
  if not IsScrollArea then exit;

  IsVertScrollBarVisible:=FVertScrollbarAlwaysVisible and not FVertScrollbarNeverVisible;
  IsHorzScrollBarVisible:=FHorzScrollbarAlwaysVisible and not FHorzScrollbarNeverVisible;

  if IsHorzScrollBarVisible then
   if AllowModifyY then Inc(Avail.Y,HorzScrollbar) else if Req.Y<>MaxInt then Inc(Req.Y,HorzScrollbar);
  if IsVertScrollBarVisible then
   if AllowModifyX then Inc(Avail.X,VertScrollbar) else if Req.X<>MaxInt then Inc(Req.X,VertScrollbar);
  if not IsHorzScrollBarVisible and not FHorzScrollbarNeverVisible and (Req.X>Avail.X) then
  begin
   IsHorzScrollBarVisible:=true;
   if AllowModifyY then Inc(Avail.Y,HorzScrollbar) else if Req.Y<>MaxInt then Inc(Req.Y,HorzScrollbar);
  end;
  if not IsVertScrollBarVisible and not FVertScrollbarNeverVisible and (Req.Y>Avail.Y) then
  begin
   IsVertScrollBarVisible:=true;
   if AllowModifyX then Inc(Avail.X,VertScrollbar) else if Req.X<>MaxInt then Inc(Req.X,VertScrollbar);
   if not IsHorzScrollBarVisible and not FHorzScrollbarNeverVisible and (Req.X>Avail.X) then
   begin
    IsHorzScrollBarVisible:=true;
    if AllowModifyY then Inc(Avail.Y,HorzScrollbar) else if Req.Y<>MaxInt then Inc(Req.Y,HorzScrollbar);
   end;
  end;
end;

procedure TdhCustomPanel.UpdateScrollBars(OnlyCalculateVisibility:boolean);
var
  RC:TPoint;
  OldIsHorzScrollBarVisible,OldIsVertScrollBarVisible:boolean;
  OldVertMax,OldHorzMax:integer;
  MeasureArea:TPoint;
begin
  if csDestroying in ComponentState then exit;
  OldVertMax:=VertScrollInfo.nMax;
  OldHorzMax:=HorzScrollInfo.nMax;
  if not OnlyCalculateVisibility then
  begin
   VertScrollInfo.nMax:=0;
   HorzScrollInfo.nMax:=0;
  end;
  if not IsScrollArea then exit;
  OldIsVertScrollBarVisible:=IsVertScrollBarVisible;
  OldIsHorzScrollBarVisible:=IsHorzScrollBarVisible;
  RC:=MyGetControlExtents(OnlyCalculateVisibility);
  MeasureArea:=Point(Width,Height);
  AddScrollbarPlace(IsHorzScrollBarVisible,IsVertScrollBarVisible,false,false,MeasureArea,RC);
  if OnlyCalculateVisibility then exit;
  with ScrollArea do
  begin
    VertScrollInfo.nPage := max(Bottom-Top,0);
    HorzScrollInfo.nPage := max(Right-Left,0);
    VertScrollInfo.nMax := VertScrollInfo.nPage+RC.Y-MeasureArea.Y;
    HorzScrollInfo.nMax := HorzScrollInfo.nPage+RC.X-MeasureArea.X;
  end;
  SetBoundedVHPos(HPos,VPos);
  ScrollPaintChanged((OldIsVertScrollBarVisible=IsVertScrollBarVisible) and (OldIsHorzScrollBarVisible=IsHorzScrollBarVisible)and
                     (OldVertMax=VertScrollInfo.nMax) and (OldHorzMax=HorzScrollInfo.nMax));
end;

procedure TdhCustomPanel.InvalScrollbars;
begin
{$IFNDEF CLX}
 if HandleAllocated then
 if IsScrollArea and NCScrollbars then
 begin
  RedrawWindow(Handle,nil,0,RDW_FRAME or RDW_INVALIDATE);
 end else
 begin
  DoInvalFrame;
 end;
{$ENDIF}
end;

procedure TdhCustomPanel.DoInvalFrame;
var R:TRect;
begin
{$IFNDEF CLX}
  R:=GetVertWhole;
  if not IsRectEmpty(R) then
   InvalidateRect(Handle,@R,false);
  R:=GetHorzWhole;
  if not IsRectEmpty(R) then
   InvalidateRect(Handle,@R,false);
{$ENDIF}
end;

procedure TdhCustomPanel.ScrollPaintChanged(SameScrollbars:boolean=true);
var AlreadyUpdated:boolean;
begin
  if not FIsScrollArea then exit;
  if SameScrollbars and TopIsValid and (TopGraph.Width=Width) and (TopGraph.Height=Height) then
  begin
   AlreadyUpdated:=false;
   if TopIsValid and (TopGraph<>nil) and not TopGraph.Empty then
   begin
    BeginPainting(TopGraph);
    try
     DrawFrame;
    finally
     EndPainting;
    end;
    AlreadyUpdated:=true;
   end;
   InvalScrollbars;
   InvalTop(not NCScrollbars,not AlreadyUpdated);
  end else
  begin
   InvalTop(true,true);
  end;
  if not SameScrollbars then
   BorderChanged;
end;

{$IFNDEF VER160}
procedure TdhCustomPanel_AlignControls2(const nname:TComponentName; Self:TdhCustomPanel; AControl: TControl; var Rect: TRect{;  FOriginalParentSize:TPoint});
var
  AlignList: TList;
  marginTop:integer;
  SRect:TRect;

  function InsertBefore(C1, C2: TControl; AAlign: TAlign): Boolean;
  begin
    Result := False;
    case AAlign of
      alTop: Result := C1.Top < C2.Top;
      alBottom: Result := (C1.Top + C1.Height) >= (C2.Top + C2.Height);
      alLeft: Result := C1.Left < C2.Left;
      alRight: Result := (C1.Left + C1.Width) >= (C2.Left + C2.Width);
      alCustom: Result := Self.CustomAlignInsertBefore(C1, C2);
    end;
  end;

  procedure DoPosition(Control: TControl; AAlign: TAlign; AlignInfo: TAlignInfo);
  var
    NewLeft, NewTop, NewWidth, NewHeight: Integer;
    ParentSize: TPoint;
    mar:TRect;
    sLightBoundsChanging:boolean;
  begin        
      if (AAlign = alNone) then
      begin
       if Control is TdhCustomPanel then
       begin
        TdhCustomPanel(Control).StrongToWeak;
        sLightBoundsChanging:=TdhCustomPanel(Control).LightBoundsChanging;
        TdhCustomPanel(Control).LightBoundsChanging:=true;
        if TdhCustomPanel(Control).HorizontalCenter then
        begin
         NewLeft:=SRect.Left+max(0,{SRect.Left + }((SRect.Right - SRect.Left)-Control.Width) div 2);
         NewWidth:=Control.Width;
         Control.SetBounds(NewLeft, Control.Top, NewWidth, Control.Height);
        end;
        if TdhCustomPanel(Control).VerticalCenter then
        begin
         NewTop:=SRect.Top+max(0,((SRect.Bottom - SRect.Top)-Control.Height) div 2);
         NewHeight:=Control.Height;
         Control.SetBounds(Control.Left, NewTop, Control.Width, NewHeight);
        end;
        TdhCustomPanel(Control).LightBoundsChanging:=sLightBoundsChanging;
       end;
       exit;
      end;
    with Rect do
    begin
      NewWidth := Right - Left;
      if (NewWidth < 0) or (AAlign in [alLeft, alRight, alCustom]) then
        NewWidth := Control.Width;
      NewHeight := Bottom - Top;
      if (NewHeight < 0) or (AAlign in [alTop, alBottom, alCustom]) then
        NewHeight := Control.Height;

      if Control is TdhCustomPanel then
      begin
        mar:=TdhCustomPanel(Control).MarginPure;
        case AAlign of
        alTop:
        begin
          dec(Top,verrechne(mar.Top,marginTop));
          marginTop:=mar.Bottom;
        end;
        alBottom:
        begin
          inc(Bottom,verrechne(mar.Bottom,marginTop));
           marginTop:=mar.Top;
        end;
        alLeft:
        begin
          dec(Left,verrechne(mar.Left,marginTop));
          marginTop:=mar.Right;
        end;
        alRight:
        begin
          inc(Right,verrechne(mar.Right,marginTop));
          marginTop:=mar.Left;
        end;
        end;
      end else
        margintop:=0;

      NewLeft := Left;
      NewTop := Top;
      case AAlign of
        alTop:
          Inc(Top, NewHeight);
        alBottom:
          begin
            Dec(Bottom, NewHeight);
            NewTop := Bottom;
          end;
        alLeft:
          Inc(Left, NewWidth);
        alRight:
          begin
            Dec(Right, NewWidth);
            NewLeft := Right;
          end;
        alCustom:
          begin
            NewLeft := Control.Left;
            NewTop := Control.Top;
            Self.CustomAlignPosition(Control, NewLeft, NewTop, NewWidth, NewHeight, Rect, AlignInfo);
          end;
      end;
    end;
    Control.SetBounds(NewLeft, NewTop, NewWidth, NewHeight);
    { Adjust client rect if control did not resize as we expected }
    if (Control.Width <> NewWidth) or (Control.Height <> NewHeight) then
      with Rect do
        case AAlign of
          alTop: Dec(Top, NewHeight - Control.Height);
          alBottom: Inc(Bottom, NewHeight - Control.Height);
          alLeft: Dec(Left, NewWidth - Control.Width);
          alRight: Inc(Right, NewWidth - Control.Width);
          alClient:
            begin
              Inc(Right, NewWidth - Control.Width);
              Inc(Bottom, NewHeight - Control.Height);
            end;
        end;
  end;

  function Anchored(Align: TAlign; Anchors: TAnchors): Boolean;
  begin
    case Align of
      alLeft: Result := akLeft in Anchors;
      alTop: Result := akTop in Anchors;
      alRight: Result := akRight in Anchors;
      alBottom: Result := akBottom in Anchors;
      alClient: Result := Anchors = [akLeft, akTop, akRight, akBottom];
    else
      Result := False;
    end;
  end;

  procedure DoAlign(AAlign: TAlign);
  var
    I, J: Integer;
    Control: TControl;
    AlignInfo: TAlignInfo;
  begin
    marginTop:=0;
    AlignList.Clear;
    if (AControl <> nil) and ((AAlign = alNone) or AControl.Visible or
      (csDesigning in AControl.ComponentState) and
      not (csNoDesignVisible in AControl.ControlStyle)) and
      (AControl.Align = AAlign) then
      AlignList.Add(AControl);
    with Self do
    for I := 0 to ControlCount - 1 do
    begin
      Control := Controls[I];
      if (Control.Align = AAlign) and ((AAlign = alNone) or (Control.Visible{or
        (Control.ControlStyle * [csAcceptsControls, csNoDesignVisible] =
          [csAcceptsControls, csNoDesignVisible])}) or
        (csDesigning in Control.ComponentState) and
        not (csNoDesignVisible in Control.ControlStyle){ or (Control is TdhPanel) and TdhPanel(Control).FinalShowing}) then
      begin
        if Control = AControl then Continue;
        J := 0;
        while (J < AlignList.Count) and not InsertBefore(Control,
          TControl(AlignList[J]), AAlign) do Inc(J);
        AlignList.Insert(J, Control);
      end;
    end;
    for I := 0 to AlignList.Count - 1 do
    begin
      AlignInfo.AlignList := AlignList;
      AlignInfo.ControlIndex := I;
      AlignInfo.Align := AAlign;
      Control:=TControl(AlignList[I]);
      DoPosition(Control, AAlign, AlignInfo);
      if AAlign=alTop then
      begin
       if GetChildPosition(Control)<>I then
        TFakeWinControl(Self).SetChildOrder(Control,I);
      end;
    end;
  end;

  function AlignWork: Boolean;
  var
    I: Integer;
  begin
    Result := True;
    with Self do
    for I := ControlCount - 1 downto 0 do
      if (Controls[I].Align <> alNone) or
        (Controls[I].Anchors <> [akLeft, akTop]) then Exit;
    Result := False;
  end;

begin
  with TFakeWinControl(Self) do
  begin            
{$IFNDEF CLX}
  if DockSite and UseDockManager and (DockManager <> nil) then
    DockManager.ResetBounds(False); 
{$ENDIF}
  { D5 VCL Change (ME): Aligned controls that are not dock clients now
    get realigned.  Previously the code below was "else if AlignWork". }

  //if AlignWork then    for calling StrongToWeak, which has desired side effects even if not changing position
  begin
    AdjustClientRect(Rect);
    SRect:=Rect;
    AlignList := TList.Create;
    try
      DoAlign(alTop);
      DoAlign(alBottom);
      DoAlign(alLeft);
      DoAlign(alRight);
      DoAlign(alClient);
      DoAlign(alCustom);
      DoAlign(alNone);// Move anchored controls
      ControlsAligned;
    finally
      AlignList.Free;
    end;
  end;
  { Apply any constraints }
  //if Showing then AdjustSize;
  end;
end;

{$ENDIF}

procedure TdhCustomPanel.ChildrenAdjustStrong(DeltaX,DeltaY:Integer);
var
  I: Integer;
begin
  for I := ControlCount - 1 downto 0 do
  if Controls[I] is TdhCustomPanel then
  with TdhCustomPanel(Controls[I]) do
  begin
   if CSSRight<>InvalidCSSPos then
    inc(CSSRight,DeltaX);
   if CSSBottom<>InvalidCSSPos then
    inc(CSSBottom,DeltaY);
  end;
end;

//child.Align in [alTop,alLeft] können eine 2te berechnung notwendig machen
procedure TdhCustomPanel.AlignControls(AControl: TControl; var Rect: TRect);
var //R,OldScrollEdgesPure,NewScrollEdgesPure:TRect;
    i:integer;
    OldIsVertScrollBarVisible,OldIsHorzScrollBarVisible:boolean;
    OldIsVertScrollBarVisible2,OldIsHorzScrollBarVisible2:boolean;
    SRect:TRect;
begin
   if PreventAlignControls then exit;
   if FinalShowing then
   begin
    AdjustSize;
    Rect:=GetClientRect;
   end;
   if ControlCount=0 then
   begin
    UpdateScrollBars(false);
    exit;
   end;
   OldIsVertScrollBarVisible:=IsVertScrollBarVisible;
   OldIsHorzScrollBarVisible:=IsHorzScrollBarVisible;
   UpdateScrollBars(true);
   for i:=0 to ControlCount-1 do
   if Controls[i] is TdhCustomPanel then
    TdhCustomPanel(Controls[i]).PrepareAlign;
   SRect:=Rect;
   TdhCustomPanel_AlignControls2(Self.Name,Self,AControl,Rect);

   OldIsVertScrollBarVisible2:=IsVertScrollBarVisible;
   OldIsHorzScrollBarVisible2:=IsHorzScrollBarVisible;
   IsVertScrollBarVisible:=OldIsVertScrollBarVisible;
   IsHorzScrollBarVisible:=OldIsHorzScrollBarVisible;
   UpdateScrollBars(false);
   if (IsVertScrollBarVisible<>OldIsVertScrollBarVisible2) or
      (IsHorzScrollBarVisible<>OldIsHorzScrollBarVisible2) then
   begin
     Rect:=SRect;
     TdhCustomPanel_AlignControls2(Self.Name,Self,AControl,Rect);
     UpdateScrollBars(false);
   end;

   for i:=0 to ControlCount-1 do
   if Controls[i] is TdhCustomPanel then
    TdhCustomPanel(Controls[i]).AlignDone;
 
//  if not Showing then AdjustSize; //since AdjustSize is called in 'inherited' only if 'Showing'
end;

procedure TdhCustomPanel.PrepareAlign;
begin
end;

procedure TdhCustomPanel.AlignDone;
begin
end;

function GetCBound(c:TControl):TRect;
begin
 if c.Parent<>nil then
 begin
  if (c is TWinControl) and TWinControl(c).HandleAllocated then
  begin
{$IFDEF CLX}
  result:=c.ClientRect;
  rOffsetRect(result,c.ClientOrigin);
{$ELSE}
   GetWindowRect(TWinControl(c).Handle,Result); //genauer falls Top und Left noch alte Werte haben, beim scrollen zum beispiel
{$ENDIF}
  end else
  begin
   result:=c.BoundsRect;
   rOffsetRect(result,GetCBound(c.Parent).TopLeft);
  end;
 end else
 begin                
  if (c is TWinControl) and TWinControl(c).HandleAllocated{ClientOrigin wirft sonst eien Exception, da Handle benötigt wird} then
  begin
   result:=c.ClientRect;
   rOffsetRect(result,c.ClientOrigin);
  end else
  begin
   result:=Rect(0,0,0,0); //gebe ansonsten leeren Bereich zurück
  end;
 end;
end;     

function GetScreenClientBound(c:TControl):TRect;
begin
 if c is TdhCustomPanel then
 begin
  result:=TdhCustomPanel(c).ClientBound;
  with GetCBound(c) do OffsetRect(result,Left,Top);
 end else
 if (c is TWinControl) and TWinControl(c).HandleAllocated then
  result:=rGetOffsetRect(c.ClientRect,c.ClientOrigin) else
  result:=GetCBound(c);
end;

function GetLocalClientBound(c:TControl):TRect;
begin
 if c is TdhCustomPanel then
 begin
  result:=TdhCustomPanel(c).ClientBound;
 end else
  result:=c.ClientRect;
end;

function GetPhysicalScreenClientBound(c:TControl):TRect;
begin
 if c is TdhCustomPanel then
 begin
  result:=TdhCustomPanel(c).PhysicalClientBound;
  with GetCBound(c) do OffsetRect(result,Left,Top);
 end else
 if (c is TWinControl) and TWinControl(c).HandleAllocated then
  result:=rGetOffsetRect(c.ClientRect,c.ClientOrigin) else
  result:=GetCBound(c);
end;

procedure InvalTrans(C:TControl; const R2:TRect; IncludeChildren:boolean=true); overload;

procedure InvalChildren(_Parent:TWinControl);
var i:integer;
    pn:TdhCustomPanel;
begin
 for i:=0 to _Parent.ControlCount-1 do
 if _Parent.Controls[I] is TdhCustomPanel then
 begin
     pn:=TdhCustomPanel(_Parent.Controls[I]);
     if (csDestroying in pn.ComponentState) or not pn.BackIsValid or not FinalVisible(pn) then continue;
     pn.BackIsValid:=false;
     pn.Invalidate;
     InvalChildren(pn);
 end else
 if _Parent.Controls[I] is TWinControl then
  InvalChildren(TWinControl(_Parent.Controls[I]));
end;

procedure InvalSiblings(Self:TControl; _Parent:TWinControl);
var R:TRect;
    i,SelfZOrder:integer;
    pn:TdhCustomPanel;
begin
    if (csDestroying in _Parent.ComponentState) or (_Parent is TdhCustomPanel) and not TdhCustomPanel(_Parent).TopIsValid and not TdhCustomPanel(_Parent).ValidChildrenInvalidParent then exit;
    SelfZOrder:=0;
    if Self<>nil then
     SelfZOrder:=GetZOrder(Self);
    for I := 0 to _Parent.ControlCount - 1 do
    if (_Parent.Controls[I] is TdhCustomPanel) then
    begin
     pn:=TdhCustomPanel(_Parent.Controls[I]);
     if (csDestroying in pn.ComponentState) or not pn.BackIsValid or not FinalVisible(pn) or (Self<>nil) and (GetZOrder(pn,i)<=SelfZOrder) then continue;
     R:=GetCBound(pn);
     IntersectRect(R,R,R2);
     if not IsRectEmpty(R) then
     begin
      pn.BackIsValid:=false;
      pn.Invalidate;
      InvalSiblings(nil,pn);
     end;
    end;
end;

begin
    if (c=nil) or (c.Owner=nil) or (c.Parent=nil) then exit;
    if csLoading in c.ComponentState then exit;
    if IncludeChildren and (c is TWinControl) and not (csDestroying in c.ComponentState) then
     InvalChildren(TWinControl(C));
    while (c.Parent<>nil) do
    begin
     InvalSiblings(C,C.Parent);
     c:=c.Parent;
    end;
end;

procedure InvalTrans(C:TControl);
begin
    InvalTrans(C,GetCBound(C));
end;

procedure TdhCustomPanel.InvalTop(IncludeChildren,IncludeSelf:boolean);
begin
   if IncludeSelf then
   begin
    TransparentTopIsValid:=false;
   end;
   if not TopIsValid then exit;
   if IncludeSelf then
   begin
    TopIsValid:=false;
   end;
   Invalidate;
   InvalTrans(Self,GetCBound(Self),IncludeChildren);
end;

procedure TdhCustomPanel.InvalBack;
begin
 InvalBack(GetCBound(Self));
end;

procedure TdhCustomPanel.InvalBack(const R2:TRect);
begin
 BackIsValid:=false;
 if not (csDestroying in ComponentState) then
  Invalidate;
 InvalTrans(Self,R2);
end;

procedure TdhCustomPanel.DesignPaintingChanged;           
var State:TState;
begin
 BackIsValid:=false;
 TopIsValid:=false;
 TransparentTopIsValid:=false;
 if HandleAllocated then
  Invalidate;
 for State:=low(TState) to high(TState) do
 if StyleArr[State]<>nil then
  StyleArr[State].BackgroundImage.UpdateAnimationState;
end;

function GetSimplifiedAnchors(Anchors:TAnchors; ParentAnchors:TAnchors; StopSimplifyingRight,StopSimplifyingBottom:boolean):TAnchors;
begin
 if (akBottom in Anchors) then
 if not((akBottom in ParentAnchors) and (akTop in ParentAnchors)) and not StopSimplifyingBottom then
 begin
  exclude(Anchors,akBottom);
  include(Anchors,akTop);
 end;
 if (akRight in Anchors) then
 if not((akLeft in ParentAnchors) and (akRight in ParentAnchors)) and not StopSimplifyingRight then
 begin
  exclude(Anchors,akRight);
  include(Anchors,akLeft);
 end;
 result:=Anchors;
end;

procedure TdhCustomPanel.CalcVariableSizes(FirstPass:boolean);
var i:integer;
begin
 if FirstPass then
 begin
  VariableHeight:=false;
 end else
 if (Parent is TdhCustomPanel) then
  SimplifiedAnchors:=GetSimplifiedAnchors(Anchors,TdhCustomPanel(Parent).SimplifiedAnchors,false,TdhCustomPanel(Parent).VariableHeight) else
  SimplifiedAnchors:=Anchors;
 for i:=0 to ControlCount-1 do
 if Controls[i] is TdhCustomPanel then
  TdhCustomPanel(Controls[i]).CalcVariableSizes(FirstPass);
end;

procedure TdhCustomPanel.SetIsOver(Value:boolean);
begin
 if FIsOver<>Value then
 begin
  FIsOver:=Value;
  if RuntimeMode then
  if not (not FIsOver and (glSelCompo<>Self)) then //required since Delphi2010: when other control is already selected before this control gets the MouseLeave event, do nothing
   glUpdateOver(Self,Value,false) else
  if IsDlg then
  begin
   InvalTop(true,true);
  end;
 end;
end;

constructor TdhCustomPanel.Create(AOwner: TComponent);
begin
  inherited;
  CSSBottom:=InvalidCSSPos;
  CSSRight:=InvalidCSSPos;
  InvalidateFontSize;
  ControlStyle := ControlStyle - [csOpaque,csSetCaption] + [csAcceptsControls, csReplicatable];
{$IFNDEF CLX}
  BevelOuter:=bvNone;
{$ENDIF}
  UsedByList:=TList.Create;
  InlineUsedByList:=TList.Create;
  StyleArr[hsNormal]:=TStyle.Create(Self,hsNormal);
  FDownOverlayOver:=true;
  ParentFont:=false; //for speed
  ParentColor:=false; //for speed
  SetBounds(0,0,100,100);
end;

procedure TdhCustomPanel.UpdateNames(InlineUse,NewInlineUse:ICon; PropagateChange:boolean);
begin
end;

procedure TdhCustomPanel.TransferStylesToUse;
begin
 if Use=nil then exit;
 TransferStylesToElement(Use);
 TransformUse(Use,false);
 ClearAllStyles(false);
end;

procedure TdhCustomPanel.ExchangeDownOverStyles;
var sStyle:TStyle;
begin
 if (StyleArr[hsOver]<>nil) and (StyleArr[hsDown]<>nil) then
 begin
  sStyle:=StyleArr[hsOver];
  StyleArr[hsOver]:=StyleArr[hsDown];
  StyleArr[hsDown]:=sStyle;
  StyleArr[hsOver].OwnState:=hsOver;
  StyleArr[hsDown].OwnState:=hsDown;
  NotifyCSSChanged(AllChanged);
 end;
end;

//sub=true: get styles from Use
//sub=false: push styles to use
procedure TdhCustomPanel.CopyFrom(Use:ICon; sub:boolean);
var UsePn,Pn:TdhCustomPanel;
    State:TState;
begin
 if Use=nil then exit;

 UsePn:=Use.GetCommon;
 Pn:=Self;
 if sub then
  Pn.CopyObjectStylesFrom(UsePn,true,Pn) else
  UsePn.CopyObjectStylesFrom(Pn,false,Pn);

 for State:=low(TState) to high(TState) do
 if (StyleArr[State]<>nil) and (Use.GetCommon.StyleArr[State]<>nil) then
 if sub then
  StyleArr[State].CopyFrom(Use.GetCommon.StyleArr[State],true) else
  Use.GetCommon.StyleArr[State].CopyFrom(StyleArr[State],false);

 if sub then
  NotifyCSSChanged(AllChanged) else
  Use.GetCommon.NotifyCSSChanged(AllChanged);
end;

procedure TdhCustomPanel.CopyStyles(fromState,toState:TState);
begin
 if (StyleArr[fromState]<>nil) and (StyleArr[toState]<>nil) then
 begin                                   
  StyleArr[toState].Clear;
  StyleArr[toState].CopyFrom(StyleArr[fromState],true);
  NotifyCSSChanged(AllChanged);
 end;
end;

procedure TdhCustomPanel.CopyObjectStylesFrom(src:TdhCustomPanel; sub:boolean; test:TdhCustomPanel);
begin
 if (test.FImageType<>bitInherit) xor sub then
  FImageType:=src.FImageType;
end;

procedure TdhCustomPanel.ClearObjectStyles;
begin
 FImageType:=bitInherit;
end;

procedure TdhCustomPanel.TransferStylesToElement(Use:ICon);
begin
 CopyFrom(Use,false);
end;

procedure TdhCustomPanel.GetStylesFromElement(Use:ICon);
begin
 CopyFrom(Use,true);
end;

procedure TdhCustomPanel.GetStylesFromUse;
begin
 if Use=nil then exit;
 GetStylesFromElement(Use);
 Use:=Use.GetCommon.Use;
end;

procedure TdhCustomPanel.ClearAllStyles;
var State:TState;
begin
 for State:=low(TState) to high(TState) do
 if StyleArr[State]<>nil then
  StyleArr[State].Clear;
 ClearObjectStyles;
 if ClearUse then
  Use:=nil;
 NotifyCSSChanged(AllChanged);
end;

procedure TdhCustomPanel.TransformUse(P:ICon; DoSUse:boolean);
var i:integer;
    pn:TdhCustomPanel;
begin
 for i:=UsedByList.Count-1 downto 0 do
 begin
  pn:=TdhCustomPanel(UsedByList[i]);
  pn.Use:=P;
  if DoSUse then
   pn.SUse:=Name
 end;
 for i:=InlineUsedByList.Count-1 downto 0 do
 begin
  pn:=TdhCustomPanel(InlineUsedByList[i]);
  pn.UpdateNames(Self,P,true);
 end;
end;

function GetFontList(const s:TFontName):TStringList;
var vn,vn2:integer;
    ss:TFontName;
begin
 result:=TStringList.Create;
 vn:=1;
 repeat
  vn2:=CharPos(s,',',vn);
  if vn2=0 then
   vn2:=length(s)+1;
  ss:=Trim(AbsCopy(s,vn,vn2));
  if ss<>EmptyStr then
   result.Add(ss);
  vn:=vn2+1;
 until vn>length(s);
end;

function GetNearestFont(const s:TFontName):TFontName;
var sl:TStringList;
    i:integer;
begin
 result:=EmptyStr;
 sl:=GetFontList(s);
 for i:=0 to sl.Count-1 do
 begin
  result:=sl[i];
  if result='serif' then
   result:='Times New Roman';
  if result='sans-serif' then
   result:={'Verdana'}'Arial'{für IE; für Firefox wäre es Times New Roman};
  if result='monospace' then
   result:='Courier New';
  if result='cursive' then
   result:='Comic Sans MS';
  if result='fantasy' then
   result:='Times New Roman';
  if Screen.Fonts.IndexOf(result)<>-1 then
   break;
 end;
 sl.Free;
end;

destructor TdhCustomPanel.Destroy;
var State:TState;
begin
 InvalBack;
 TransformUse(nil,true);
 Use:=nil;
 if FMouseControl=Self then FMouseControl:=nil;
 if glSelCompo=Self then glSelCompo:=nil;
 if glEventObj=Self then glEventObj:=nil;
 for State:=low(TState) to high(TState) do
  StyleArr[State].Free;
 UsedByList.Free;
 UsedByList:=nil;
 FreeAndNil(InlineUsedByList);
 if BackGraph=TopGraph then
  TopGraph:=nil;
 FreeAndNil(BackGraph);
 FreeAndNil(TopGraph);
 FreeAndNil(TransparentTop);
 inherited;
end;

procedure TdhCustomPanel.SetTransparent(Value: boolean);
begin
 if Transparent<>Value then
 begin
  ActStyle.BackgroundColor:=colInherit;
  if not Value then
  begin
   if Transparent then
    ActStyle.BackgroundColor:=GetVirtualBGColor;
  end else
  begin
   if not Transparent then
    ActStyle.BackgroundColor:=colTransparent;
  end;
  if Transparent<>Value then
   ActStyle.BackgroundColor:=colInherit;
 end;
end;

procedure Exch(var a,b:Integer); overload;
var c:Integer;
begin
 c:=a;
 a:=b;
 b:=c;
end;

procedure Exch(var a,b:TPoint); overload;
var c:TPoint;
begin
 c:=a;
 a:=b;
 b:=c;
end;

procedure TdhCustomPanel.LockDefinedCSS(var sStyleArr:TStyleArray);
var st:TState;
begin
   for st:=low(TState) to high(TState) do
   begin
    sStyleArr[st]:=StyleArr[st];
    StyleArr[st]:=nil;
   end;
end;

procedure TdhCustomPanel.UnlockDefinedCSS(var sStyleArr:TStyleArray);
var st:TState;
begin
   for st:=low(TState) to high(TState) do
   begin
    StyleArr[st]:=sStyleArr[st];
   end;
end;

function TdhCustomPanel.GetClientAdjusting:TRect;
begin
 result:=ScrollArea_Edges;
end;

function CursorToString(Cursor: TCSSCursor): TEnumName;
begin
  Result:=GetEnumName( TypeInfo( TCSSCursor ), Integer(Cursor));
end;

function GetHyphens(const s:TEnumName; from:integer):TEnumName;
var i:integer;
begin
 result:=copy(s,from,maxint);
 for i:=length(result) downto 1 do
 if CharInSet(result[i],['A'..'Z']) then
 begin
  result[i]:=chr(ord(result[i])+ord('a')-ord('A'));
  if i<>1 then
   insert('-',result,i);
 end;
end;

function GetCSSPropName(PropChoose:TPropChoose):TEnumName;
begin
 result:=GetHyphens(GetEnumName( TypeInfo(TPropChoose), Integer(PropChoose)),3)
end;

function WithPX(const s:AString):AString;
begin
 if (s<>EmptyStr) and CharInSet(s[length(s)],['0'..'9']) then
  result:=s+'px' else
  result:=s;
end;

function GetCSSPropValue(PropChoose:TPropChoose):AString;

function GetCSSName(TypeInfo: PTypeInfo; var Value): TEnumName;
begin
 result:=GetHyphens(GetEnumName( TypeInfo, Byte(Value)));
end;

function GetCSSSetProp(TypeInfo: PTypeInfo; var S): TEnumName;
var
  I: Integer;
begin
  result:=EmptyStr;
  TypeInfo:=GetTypeData(TypeInfo).CompType{$IFNDEF VER160}^{$ENDIF};
  for I := 0 to SizeOf(Byte) * 8 - 1 do
    if (1 shl I) and Byte(S)<> 0 then
    begin
      if Length(Result) <> 1 then Result := Result + ' ';
      Result := Result + GetHyphens(GetEnumName(TypeInfo, I),4);
    end;
end;

begin
 case PropChoose of
 pcAntiAliasing:
  result:='(yes)';
 pcEffects:
  result:='(defined)';
 pcBackgroundImage:
 if Cascaded.Picture.HasPath then
  result:='('+Cascaded.Picture.GetAbsolutePath+')' else
  result:='('+UpperCase(Copy(Cascaded.Picture.GraphicExtension,2,maxint))+' image)';
 pcBorderColor,pcBackgroundColor,pcColor:
  result:=dhColorUtils.ColorToIntString(Cascaded.Color);
 pcOther:
  result:=Cascaded.Other;
 pcContentBefore:
  result:=Cascaded.Before;
 pcContentAfter:
  result:=Cascaded.After;
 pcFontFamily:
  result:=Cascaded.FontFamily;
 pcBackgroundPosition:
  result:=Cascaded.BackgroundPosition;
 pcVerticalAlign:
  result:=WithPX(Cascaded.VerticalAlign);
 pcLetterSpacing:
  result:=WithPX(Cascaded.LetterSpacing);
 pcWordSpacing:
  result:=WithPX(Cascaded.WordSpacing);
 pcLineHeight:
  result:=WithPX(Cascaded.LineHeight);
 pcTextIndent:
  result:=Cascaded.TextIndent;
 pcFontSize:
  result:=WithPX(Cascaded.FontSize);
 pcMargin:
  result:=Cascaded.Margin;
 pcBorderRadius:
  result:=Cascaded.BorderRadius;
 pcTextDecoration:
  result:=GetCSSSetProp(TypeInfo(TCSSTextDecorations),Cascaded.TextDecoration);
 pcBorderStyle:
  result:=GetCSSName(TypeInfo(TCSSBorderStyle),Cascaded.BorderStyle);
 pcBackgroundRepeat:
  result:=GetCSSName(TypeInfo(TCSSBackgroundRepeat),Cascaded.BackgroundRepeat);
 pcBackgroundAttachment:
  result:=GetCSSName(TypeInfo(TCSSBackgroundAttachment),Cascaded.BackgroundAttachment);
 pcDisplay:
  result:=GetCSSName(TypeInfo(TCSSDisplay),Cascaded.Display);
 pcVisibility:
  result:=GetCSSName(TypeInfo(TCSSVisibility),Cascaded.Visibility);
 pcTextAlign:
  result:=WithPX(GetCSSName(TypeInfo(TCSSTextAlign),Cascaded.TextAlign));
 pcWhiteSpace:
  result:=GetCSSName(TypeInfo(TCSSWhiteSpace),Cascaded.WhiteSpace);
 pcDirection:
  result:=GetCSSName(TypeInfo(TCSSDirection),Cascaded.Direction);
 pcTextTransform:
  result:=GetCSSName(TypeInfo(TCSSTextTransform),Cascaded.TextTransform);
 pcFontStyle:
  result:=GetCSSName(TypeInfo(TCSSFontStyle),Cascaded.FontStyle);
 pcFontWeight:
  result:=GetCSSName(TypeInfo(TCSSFontWeight),Cascaded.FontWeight);
 pcFontVariant:
  result:=GetCSSName(TypeInfo(TCSSFontVariant),Cascaded.FontVariant);
 pcCursor:
  result:=GetCSSName(TypeInfo(TCSSCursor),Cascaded.Cursor);
 pcListStyleType:
  result:=GetCSSName(TypeInfo(TCSSListStyleType),Cascaded.ListStyleType);
 pcZIndex:
  result:=inttostr(Cascaded.CSSInteger);
 else
  result:=inttostr(Cascaded.Width)+'px';
 end;
end;

function FilledTo(const s:AString; x:integer):AString;
begin
 result:=s+StringOfChar(' ',x-length(s));
end;

function TdhCustomPanel.IsInUseList(ob:TObject):boolean;
begin
 if ob is TStyle then
  ob:=TStyle(ob).Owner.GetControl;
 result:=(ob is TdhCustomPanel) and InUseList(Self,ob as TdhCustomPanel);
end;

function TdhCustomPanel.IsDefinedOuter(ob:TObject):boolean;
begin
 result:=(ob is TStyle) and (GetParentForm(TStyle(ob).Owner.GetControl)<>GetParentForm(Self));
end;

function GetBorderRadiusString(al:TEdgeAlign):TEnumName;
const sBorderCorner:array[TEdgeAlign] of TEnumName=(EmptyStr,'-top-left','-bottom-right','-bottom-left','-top-right');
begin
 result:='border'+sBorderCorner[al]+'-radius';
end;

function GetBorderRadiusStringSafari(al:TEdgeAlign):TEnumName;
begin
 result:='-webkit-'+GetBorderRadiusString(al);
end;

function GetBorderRadiusStringMoz(al:TEdgeAlign):TEnumName;
const sBorderCorner:array[TEdgeAlign] of TEnumName=(EmptyStr,'-topleft','-bottomright','-bottomleft','-topright');
begin
 result:='-moz-border-radius'+sBorderCorner[al];
end;

function TdhCustomPanel.GetInfo:AString;
var PropChoose:TPropChoose;
    al:TEdgeAlign;
    s:AString;
    sl:TStringList;
    ob:TObject;
    i:integer;
 sl_byself:TStringList;
 sl_byselfuse:TStringList;
 sl_byparent:TStringList;
 sl_byouter:TStringList;

begin
 sl:=TStringList.Create;
 Self.SetPreferStyle(ActStyle,true,true);
 try
 for PropChoose:=Low(TPropChoose) to High(TPropChoose) do
 for al:=Low(TEdgeAlign) to High(TEdgeAlign) do
 if (PropChoose in [pcBorderColor,pcBorderWidth,pcBorderStyle,pcMargin,pcPadding,pcBorderRadius])=(al<>ealNone) then
 if Self.GetVal(PropChoose,al) or (Cascaded.ValStyle<>nil) then
 begin
  s:=GetCSSPropName(PropChoose);
  if al<>ealNone then
  if PropChoose=pcBorderRadius then
   s:=GetBorderRadiusString(al) else
   s:=s+'-'+lowercase(copy(GetEnumName( TypeInfo(TAlign), Integer(al)),3,maxint));
  s:=s+':'+GetCSSPropValue(PropChoose);
  if Cascaded.ValStyle<>nil then
  if Cascaded.ValStyle is TStyle then
   s:=FilledTo(s,30)+'  (by '+TStyle(Cascaded.ValStyle).Owner.GetElementName+'.'+TStyle(Cascaded.ValStyle).GetNameByStyle+')' else
  if (PropChoose=pcCursor) and (Cascaded.Cursor=ccuInherit) then
   continue else
  if (Cascaded.ValStyle is TControl) and (TControl(Cascaded.ValStyle).Parent=nil) then
   s:=FilledTo(s,30)+'  (by default)' else
   s:=FilledTo(s,30)+'  (by '+Cascaded.ValStyle.GetNamePath+')';
  sl.AddObject(s,Cascaded.ValStyle);
 if PropChoose in [pcBorderColor,pcBorderWidth,pcBorderStyle,pcMargin,pcPadding] then
 begin

 end;
 end;
 finally
  Self.SetPreferStyle(nil,true,true);
 end;

 sl_byself:=TStringList.Create;
 sl_byselfuse:=TStringList.Create;
 sl_byparent:=TStringList.Create;
 sl_byouter:=TStringList.Create;

 for i:=0 to sl.Count-1 do
 begin
  ob:=sl.Objects[i];
  if (ob is TStyle) and (TStyle(ob).Owner.GetControl=Self) then
   sl_byself.Add(sl[i]) else
  if Self.IsInUseList(ob) then
   sl_byselfuse.Add(sl[i]) else
  if Self.IsDefinedOuter(ob) then
   sl_byouter.Add(sl[i]) else
   sl_byparent.Add(sl[i]);
 end;

 sl.Clear;
 sl.Add('Defined styles:');
 sl.AddStrings(sl_byself);
 if sl_byself.Count=0 then
  sl.Add('no self defined styles');
 sl.Add(EmptyStr); 
 if sl_byselfuse.Count<>0 then
 begin
 sl.Add('Inherited styles by "Use" element:');
 sl.AddStrings(sl_byselfuse);
 sl.Add(EmptyStr);
 end;
 if sl_byparent.Count<>0 then
 begin
 sl.Add('Inherited styles by parent elements:');
 sl.AddStrings(sl_byparent);
 sl.Add(EmptyStr);
 end;
 if sl_byouter.Count<>0 then
 begin
 sl.Add('Styles defined by element type:');
 sl.AddStrings(sl_byouter);
 sl.Add(EmptyStr);
 end;
 if ActStyle.RasteringFile<>'' then
 begin
 sl.Add('Generated image: '+ActStyle.RasteringFile);
 sl.Add(EmptyStr);
 end;
 Self.AddOwnInfo(sl);
 Self.AddInfo(sl);
 result:=sl.Text;
 sl.Free;
 sl_byself.Free;
 sl_byselfuse.Free;
 sl_byparent.Free;
 sl_byouter.Free;
end;

procedure TdhCustomPanel.AddInfo(sl:TStringList);
var i:integer;
    pn:TdhCustomPanel;
var HasRastering:TRasterType;
begin
 sl.Add('Uses:');
 if Use<>nil then
  sl.Add(Use.GetName);
 sl.Add(EmptyStr);
 sl.Add('Used by:');
 for i:=0 to UsedByList.Count-1 do
 begin
  pn:=TdhCustomPanel(UsedByList[i]);
  sl.Add(pn.Name);
 end;
 sl.Add(EmptyStr);
 sl.Add('Inline used by:');
 for i:=0 to InlineUsedByList.Count-1 do
 begin
  pn:=TdhCustomPanel(InlineUsedByList[i]);
  sl.Add(pn.Name);
 end;
 sl.Add(EmptyStr);
 HasRastering:=IsRastered(false);
 if HasRastering<>rsNo then
 begin
 sl.Add('Object is rastered because of '+rasterReason[HasRastering]);
 sl.Add(EmptyStr);
 end;  
end;

procedure TdhCustomPanel.AddOwnInfo(sl:TStrings);
begin
end;

procedure TdhCustomPanel.AssignComputed(Border:TCSSBorder; Align:TEdgeAlign);
begin
    Border.Width:=BorderWidth(Align);
    Border.Color:=BorderColor(Align);
    Border.Style:=BorderStyle(Align);
end;

function TdhCustomPanel.ItGetVal(state:TState; PropChoose:TPropChoose; const Align:TEdgeAlign):boolean;
begin
 if (StyleArr[state]=nil) then
 begin
  result:=false;
  exit;
 end;
 Result:=StyleArr[state].GetStyleVal(PropChoose,Align);
 if not Result and (FUse<>nil) then
  Result:=FUse.GetCommon.ItGetVal(state,PropChoose,Align);
end;

function GetCursorBack(Cursor:TCursor):TCSSCursor;
begin
 for Result:=low(TCSSCursor) to high(TCSSCursor) do
 if CSSCursorMap[Result]=Cursor then
  Exit;
 Result:=ccuAuto;
end;

function TdhCustomPanel.ShallBeAnchor:boolean;
begin
 result:=false;
end;

function TdhCustomPanel.HasVal(PropChoose:TPropChoose; const Align:TEdgeAlign=ealNone):boolean;
begin
 result:=GetVal(PropChoose,Align);
end;

function TdhCustomPanel.GetFinal:ICon;
begin
 result:=nil;
end;

function TdhCustomPanel.GetInlineHTMLState(Over,Down:boolean):TState;
begin
 result:=hsNormal;
end;

function TdhCustomPanel.GetVal(PropChoose:TPropChoose; const Align:TEdgeAlign=ealNone; CanInherit:boolean=true):boolean;
var P:TWinControl;
    AStyle:TStyle;
    _ActStyle:TState;
    DoExit:boolean;
    _TextDecoration:TCSSTextDecorations;


function _ItGetVal(state:TState):boolean;
begin
 result:=ItGetVal(state,PropChoose,Align);
end;

function _ItGetVal2(state:TState):boolean;
begin
 result:=GetFinal.GetCommon.ItGetVal(state,PropChoose,Align);
end;

begin
 try
 result:=false;
 if (csDestroying in ComponentState) then exit;
 if not Cascaded.IsFromParent then
  Cascaded.ValStyle:=nil;
 result:=DoGetVal(PropChoose,Align,DoExit);
 Cascaded.SelfHit:=false;
 if DoExit then exit;

 if PreferStyle<>nil then
   _ActStyle:=PreferStyle.OwnState else
   _ActStyle:=LastActStyle;

 if not IsDlg then
 case _ActStyle of
 hsDown:      result:=_ItGetVal(hsDown);
 hsOver:     result:=_ItGetVal(hsOver);
 hsOverDown:
 if GetPreferDownStyles then
  result:=_ItGetVal(hsOverDown) or _ItGetVal(hsDown) or _ItGetVal(hsOver) else
  result:=_ItGetVal(hsOverDown) or _ItGetVal(hsOver) or _ItGetVal(hsDown);
 end;
 if not result then
  result:=_ItGetVal(hsNormal);

 if not result then
 if GetFinal<>nil then
 begin
 if not IsDlg then
 case _ActStyle of
 hsDown:      result:=_ItGetVal2(hsDown);
 hsOver:     result:=_ItGetVal2(hsOver);
 hsOverDown: 
 if GetPreferDownStyles then
  result:=_ItGetVal2(hsOverDown) or _ItGetVal2(hsDown) or _ItGetVal2(hsOver) else
  result:=_ItGetVal2(hsOverDown) or _ItGetVal2(hsOver) or _ItGetVal2(hsDown);
 end;
 if not result then
  result:=_ItGetVal2(hsNormal);
 if not result then
  result:=_ItGetVal2(hsNormal);
 end;

 P:=Parent;
 if CanInherit and (PropChoose in AutoInherit) then
 while not Result and (P<>nil) and not (csDestroying in P.ComponentState) do
 begin
 Cascaded.IsFromParent:=true;
 if P is TdhCustomPanel then
 begin
  Result:=TdhCustomPanel(P).GetVal(PropChoose,Align);
  exit;
 end else
 case PropChoose of
 pcFontSize,pcFontFamily,pcColor,pcFontStyle,pcFontWeight,pcTextDecoration:
 if not TFakeControl(P).ParentFont{eigentlich unnötig, doch wir wollen die Quelle wissen} or (P.Parent=nil) then
 begin
  AStyle:=TStyle.Create(nil,hsNormal);
  try

  case PropChoose of
  pcFontSize: AStyle.FontSize:=inttostr(Abs(TFakeControl(P).Font.Height));
  pcFontFamily: AStyle.FontFamily:=TFakeControl(P).Font.Name;
  pcColor: AStyle.Color:=ColorToCSSColor(TFakeControl(P).Font.Color);
  pcFontStyle: AStyle.FontStyle:=GetItalicFontStyle[fsItalic in TFakeControl(P).Font.Style];
  pcFontWeight: AStyle.FontWeight:=GetBoldFontWeight[fsBold in TFakeControl(P).Font.Style];
  pcTextDecoration:
  begin
   _TextDecoration:=[];
   if fsUnderline in TFakeControl(P).Font.Style then
    Include(_TextDecoration,ctdUnderline);
   if fsStrikeOut in TFakeControl(P).Font.Style then
    Include(_TextDecoration,ctdLineThrough);
   AStyle.TextDecoration:=_TextDecoration;
  end;
  end;
  //AStyle.GetFontDifferences(TFakeControl(P).Font);

  Result:=AStyle.GetStyleVal(PropChoose,Align);
  if Result then Cascaded.ValStyle:=P;
  finally
   FreeAndNil(AStyle);
  end;

 end;
 pcCursor:
 begin
  Cascaded.Cursor:=GetCursorBack(P.Cursor);
  Cascaded.ValStyle:=P;
  Result:=Cascaded.Cursor<>ccuInherit;
 end;
 end;
{ if (P is TdhScrollingWinControl) and TdhScrollingWinControl(P).CutParent then
  break;}
 P:=P.Parent;
 end;
 finally
  Cascaded.IsFromParent:=false;
 end;
end;

function TdhCustomPanel.PaddingWidth(const Align:TEdgeAlign):integer;
begin
 if GetVal(pcPadding,Align) then
  result:=Cascaded.Width else
  result:=0;
end;

function TdhCustomPanel.HasBorderRadii:boolean;
var TopLeft,TopRight,BottomLeft,BottomRight:TPoint;
    dummy:boolean;
begin
 result:=GetBorderRadii(TopLeft,TopRight,BottomLeft,BottomRight,dummy,dummy,dummy,dummy);
end;

function TdhCustomPanel.GetBorderRadii(var TopLeft,TopRight,BottomLeft,BottomRight:TPoint; var TopLeftDouble,TopRightDouble,BottomLeftDouble,BottomRightDouble:boolean):boolean;
begin
 result:=false;
 TopLeft:=Point(0,0);
 TopRight:=Point(0,0);
 BottomLeft:=Point(0,0);
 BottomRight:=Point(0,0);
 if GetVal(pcBorderRadius,calTopLeft) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,TopLeft,TopLeftDouble);
 if GetVal(pcBorderRadius,calTopRight) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,TopRight,TopRightDouble);
 if GetVal(pcBorderRadius,calBottomLeft) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,BottomLeft,BottomLeftDouble);
 if GetVal(pcBorderRadius,calBottomRight) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,BottomRight,BottomRightDouble);
 result:=(TopLeft.X<>0) or (TopLeft.Y<>0) or (TopRight.X<>0) or (TopRight.Y<>0) or (BottomLeft.X<>0) or (BottomLeft.Y<>0) or (BottomRight.X<>0) or (BottomRight.Y<>0);
end;

function TdhCustomPanel.GetBorderRadius(CornerAlign:TCornerAlign):TPoint;
begin
 result:=Point(0,0);
 if GetVal(pcBorderRadius,CornerAlign) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,result);
end;

function TdhCustomPanel.IsBorderRadiusTwoValued(CornerAlign:TCornerAlign):boolean;
begin
 result:=GetVal(pcBorderRadius,CornerAlign) and (Pos(' ',trim(Cascaded.BorderRadius))<>0);
end;

function TdhCustomPanel.GetTransparent:boolean;
begin
 result:=BackgroundColor=colTransparent;
end;

function TdhCustomPanel.SemiTransparent:boolean;
begin
 result:=not IsOpaqueColor(BackgroundColor);
end;

function IsNullRect(const R:TRect):boolean;
begin
 result:=(R.Left=0) and (R.Right=0) and (R.Bottom=0) and (R.Top=0);     
end;

function TdhCustomPanel.TransparentEdges:TRect;
begin
 if IsScrollArea and EdgesInScrolledArea then
 begin
  result:=Rect(0,0,0,0);
  exit;
 end;  
 result:=MarginPure;
 if not IsNullRect(result) then exit;
 result.Left:=TransparencyOfBorderWidth(ealLeft);
 result.Top:=TransparencyOfBorderWidth(ealTop);
 result.Bottom:=TransparencyOfBorderWidth(ealBottom);
 result.Right:=TransparencyOfBorderWidth(ealRight);
end;

function TdhCustomPanel.SemiTransparentEdges:TRect;
begin
 if IsScrollArea and EdgesInScrolledArea then
 begin
  result:=Rect(0,0,0,0);
  exit;
 end;
 result.Left:=SemiTransparencyOfBorderWidth(ealLeft);
 result.Top:=SemiTransparencyOfBorderWidth(ealTop);
 result.Bottom:=SemiTransparencyOfBorderWidth(ealBottom);
 result.Right:=SemiTransparencyOfBorderWidth(ealRight);
end;

function TdhCustomPanel.IsRasterized:boolean;
var tt:TTransformations;
begin
 result:=HasTransformations(tt) or HasBorderRadii;
end;

function TdhCustomPanel.Opaque:boolean;
begin
 result:=not SemiTransparent and IsNullRect(TransparentEdges) and not IsRasterized and Visibility;
end;

function TdhCustomPanel.BorderWidth(const Align:TEdgeAlign):integer;
begin
 if GetVal(pcBorderWidth,Align) then
  result:=Cascaded.Width else
  result:=default_borderwidth{=medium};
end;

function TdhCustomPanel.GetCursor:TCSSCursor;
begin
 if GetVal(pcCursor) then
  result:=Cascaded.Cursor else
  result:=ccuAuto;
end;

function TdhCustomPanel.DisplayBorderWidth(const Align:TEdgeAlign):integer;
begin
 if BorderStyle(Align) in [cbsNone,cbsHidden] then
  result:=0 else
  result:=BorderWidth(Align);
end;

function TdhCustomPanel.TransparencyOfBorderWidth(const Align:TEdgeAlign):integer;
var Style:TCSSBorderStyle;
begin
 Style:=BorderStyle(Align);
 if (Style in [cbsNone,cbsHidden]) or (Style in [cbsSolid,cbsGroove,cbsRidge,cbsInset,cbsOutset]) and IsOpaqueColor(BorderColor(Align)) then
  result:=0 else
  result:=BorderWidth(Align);
end;

function TdhCustomPanel.SemiTransparencyOfBorderWidth(const Align:TEdgeAlign):integer;
var Style:TCSSBorderStyle;
begin
 Style:=BorderStyle(Align);
 if (Style in [cbsNone,cbsHidden]) or IsOpaqueColor(BorderColor(Align)) then
  result:=0 else
  result:=BorderWidth(Align);
end;

function TdhCustomPanel.BorderStyle(const Align:TEdgeAlign):TCSSBorderStyle;
begin
 if GetVal(pcBorderStyle,Align) then
  result:=Cascaded.BorderStyle else
  result:=cbsNone;
end;

function TdhCustomPanel.BorderColor(const Align:TEdgeAlign):TCSSColor;
begin
 if GetVal(pcBorderColor,Align) then
  result:=Cascaded.Color else
  result:=clBlackCSS;
end;

function TdhCustomPanel.ZIndex:TCSSInteger;
begin
 if GetVal(pcZIndex) then
  result:=Cascaded.CSSInteger else
  result:=0;
end;

function TdhCustomPanel.MinWidth:TCSSCardinal;
begin
 if GetVal(pcMinWidth) then
  result:=Cascaded.Width else
  result:=0;
end;

function TdhCustomPanel.MinHeight:TCSSCardinal;
begin
 if GetVal(pcMinHeight) then
  result:=Cascaded.Width else
  result:=0;
end;

function TdhCustomPanel.MarginWidthNormalStyle(const Align:TEdgeAlign):integer;
begin      
 if ItGetVal(hsNormal,pcMargin,Align) then
  result:=GetMarginPixels(Cascaded.Margin,ComputedFontSize) else
  result:=0;
end;

function TdhCustomPanel.MarginWidth(const Align:TEdgeAlign):integer;
var p:TControl;
begin
 if GetVal(pcMargin,Align) then
  result:=GetMarginPixels(Cascaded.Margin,ComputedFontSize) else
  result:=0;
 p:=Self;
 if result<>0 then
 if (p.Name='ul') or (p.Name='ol') or (p.Name='menu') or (p.Name='dir') then
 begin
  p:=p.Parent;
  while p<>nil do
  if (p.Name='ul') or (p.Name='ol') or (p.Name='menu') or (p.Name='dir') then
  begin
   result:=0;
   break;
  end else
   p:=p.Parent;
 end;
 if IsDlg then
  inc(Result,3);
 if not PreventAdjustMargin then
  AdjustMarginWidth(result,Align);
end;

procedure TdhCustomPanel.AdjustMarginWidth(var i:integer; const Align:TEdgeAlign);
begin
end;

function TdhCustomPanel.BackgroundColor:TCSSColor;
begin
 if GetVal(pcBackgroundColor) then
  result:=Cascaded.Color else
  result:=colTransparent;
 AdjustBackgroundColor(result);
end;

procedure TdhCustomPanel.AdjustBackgroundColor(var Col:TCSSColor);
begin
end;

function TdhCustomPanel.GetVirtualBGColor:TCSSColor;
var p:TControl;
begin
 p:=Self;
 while (p is TdhCustomPanel) do
 if not TdhCustomPanel(p).Transparent then
 begin
  result:=TdhCustomPanel(p).BackgroundColor;
  exit;
 end else
  p:=p.Parent;
 if p is TControl then
  result:=ColorToCSSColor(TFakeControl(p).Color) else
  result:=clWhiteCSS;
end;

procedure TdhCustomPanel.Frame3D(Border:TEdgeAlign; Points: array of TPoint; PixelCombineEvent:TPixelCombineEvent);
var BottomRight:boolean;
    bs:TCSSBorderStyle;
    bc:TColor;
    L,bw:integer;
    AdjDivX,AdjDivY:integer;
    Color1,Color2,Col:TColor;
var ColorDefined:boolean;
const hell:array[0..3] of TColor=($FFFFFF,$C8D0D4,$404040,$808080);

Function ApplyDark2(HowMany:Byte):TColor;
begin
 if not ColorDefined and (GetSpecialBorderType in [sbtEdit,sbtButton]) then
  result:=hell[HowMany] else
  result:=ApplyDark(bc,HowMany*60);
end;

procedure ConvexPoint(var P1,P2:TPoint; m:integer=0);
begin
   P1.X:=(P1.X+P2.X*(m+1)+AdjDivX) div (m+2);
   P1.Y:=(P1.Y+P2.Y*(m+1)+AdjDivY) div (m+2);
end;

function GetConvexPoint(var P1,P2:TPoint; m:integer=0):TPoint;
begin
 Result.X:=(P1.X+P2.X*(m+1)+AdjDivX) div (m+2);
 Result.Y:=(P1.Y+P2.Y*(m+1)+AdjDivY) div (m+2);
end;

procedure DrawToCanvas(const Canvas:TCanvas);
begin

  bs:=BorderStyle(Border);
  bc:=CSSColorToColor(BorderColor(Border));
  ColorDefined:=HasVal(pcBorderColor,Border);

  if Border in [ealLeft,ealRight] then
   AdjDivX:=0 else
   AdjDivX:=0;
  if Border in [ealTop,ealBottom] then
   AdjDivY:=0 else
   AdjDivY:=0;

  BottomRight:=Border in [ealRight,ealBottom];
  if Border in [ealRight,ealBottom] then
  case bs of
  {cbsInset: bs:=cbsOutset;
  cbsOutset:bs:=cbsInset;
   }
  cbsGroove,cbsRidge:
  begin
   Exch(Points[0],Points[2]);
   Exch(Points[1],Points[3]);
  end;
  end;


  Canvas.Brush.Style:=bsSolid;
  Canvas.Brush.Color:=bc;
  Canvas.Pen.Color:=bc;
  Canvas.Pen.Style:=psClear;
  Color1:=bc;
  case bs of
  cbsGroove:
   Color1:=clBlack;
  cbsRidge:
   Color1:=ApplyDark2(1);
  cbsInset:
   if BottomRight then
    Color1:=ApplyDark2(0) else
    Color1:=ApplyDark2(3);
  cbsOutSet:
   if BottomRight then
    Color1:=ApplyDark2(2) else
    Color1:=ApplyDark2(1);
  cbsDotted,cbsDashed:
  begin
   if not(Border in [ealTop,ealBottom]) then
   begin
    Points[0].X:=(Points[0].X+Points[3].X) div 2;
    Points[1].X:=(Points[1].X+Points[2].X) div 2;
   end else
   begin
    Points[0].Y:=(Points[0].Y+Points[3].Y) div 2;
    Points[1].Y:=(Points[1].Y+Points[2].Y) div 2;
   end;
   bw:=BorderWidth(Border);
   if bs=cbsDashed then
   begin
    if bw=1 then
    begin
     LineSpec(Canvas,Points[0],Points[1],1,3,3,true,bs=cbsDashed);
     exit;
    end else
     L:=2*bw;
   end else
    L:=bw;
   if (bs=cbsDotted) and (bw=2) then
    bs:=cbsDashed; //width=2 für ellipse zeichnet nix!
   LineSpec(Canvas,Points[0],Points[1],bw,L,bw,true,bs=cbsDashed);
   exit;
  end;
  cbsDouble:
  begin
   Canvas.Polygon([GetConvexPoint(Points[0],Points[3],1),GetConvexPoint(Points[1],Points[2],1),Points[2],Points[3]]);
   Canvas.Polygon([Points[0],Points[1],GetConvexPoint(Points[2],Points[1],1),GetConvexPoint(Points[3],Points[0],1)]);
   exit;
  end;
  end;

   case bs of
   cbsGroove:
    Color2:=bc;
   cbsInset:
    if BottomRight then
     Color2:=ApplyDark2(1) else
     Color2:=ApplyDark2(2);
   cbsOutset:
    if BottomRight then
     Color2:=ApplyDark2(3) else
     Color2:=ApplyDark2(0);
   else
    Color2:=ApplyDark2(2);
   end;

  if (bs in [cbsOutset,cbsInset]) and (Border in [ealTop,ealLeft]) and (GetSpecialBorderType in [sbtButton]) then
  begin
   Col:=Color1;
   Color1:=Color2;
   Color2:=Col;
  end;

  Canvas.Brush.Color:=Color1;
  Canvas.Polygon(Points);

  if Border=ealTop then
  begin
   inc(Points[0].Y);
   inc(Points[1].Y);
   inc(Points[0].X);
  end;
  if Border=ealLeft then
  begin
   inc(Points[0].X);
   inc(Points[1].X);
  end;
  if (bs in [cbsRidge,cbsGroove,cbsInset,cbsOutset]) and (BorderWidth(Border)>1) then
  begin
   Canvas.Brush.Color:=Color2;
   Canvas.Polygon([GetConvexPoint(Points[0],Points[3]),GetConvexPoint(Points[1],Points[2]),Points[2],Points[3]]);
  end;
end;

var
  I: Integer;
  P: PColor32;
  C,Alpha32: TColor32;
  bitmap:TBitmap32;
begin

 if (Points[0].X=Points[1].X) and (Points[1].X=Points[2].X) and (Points[2].X=Points[3].X) or
    (Points[0].Y=Points[1].Y) and (Points[1].Y=Points[2].Y) and (Points[2].Y=Points[3].Y) then exit;


 if DisplayBorderWidth(Border)=0 then exit;

 if not IsOpaqueColor(BorderColor(Border)) or Assigned(PixelCombineEvent) then
 begin
  bitmap:=TBitmap32.Create;
  try
    bitmap.SetSize(ActTopGraph.Width,ActTopGraph.Height);
    bitmap.Clear($FF000000);

    DrawToCanvas(bitmap.Canvas);

    Alpha32:=CSSColorToColor32(BorderColor(Border)) and $FF000000;
    P := @bitmap.Bits[0];
    for I := 0 to bitmap.Width * bitmap.Height - 1 do
    begin
      C := P^;
      if C and $FF000000 = $FF000000 then
      begin
        P^ := 0;
      end else
      begin
        P^:=C or Alpha32;
      end;
      Inc(P);
    end;

    bitmap.DrawMode := dmBlend;
    if Assigned(PixelCombineEvent) then
    begin
     bitmap.DrawMode := dmCustom;
     bitmap.OnPixelCombine := PixelCombineEvent;
    end;
    bitmap.DrawTo(ActTopGraph, 0, 0);
  finally
   bitmap.Free;
  end;
 end else
 begin
  DrawToCanvas(GetCanvas);
 end;
end;

function TdhCustomPanel.HeightDiff:integer;
begin
 result:=0;
end;

function IncHeight(R:TRect; addheight:integer):TRect;
begin
 result:=R;
 inc(result.bottom,addheight);
end;

function RectInRect(const Rect: TRect; const R: TRect): Boolean;
begin
 result:=PtInRect(Rect,R.TopLeft) and PtInRect(Rect,R.BottomRight);
end;

{$IFNDEF CLX}

procedure MyPaintTo(Self:TdhCustomPanel; _Parent:TWinControl; CutR,SelfCBound:TRect; addheight:integer);
var
  DC: HDC;
  EdgeFlags, BorderFlags: Integer;
  SaveIndex:integer;
  R:TRect;           
  cCutR:TRect;
  p1,p2,p3:TPoint;
begin
  p1:=SelfCBound.TopLeft;
  p2:=_parent.ClientOrigin;
  p3:=GetCBound(_parent).TopLeft;
  with _Parent do
  begin
  Self.BackGraph.Canvas.Lock;
  try
  DC:=Self.BackGraph.Canvas.Handle;
  _Parent.ControlState:=_Parent.ControlState+[csPaintCopy];
  SaveIndex := SaveDC(DC);
  R:=IncHeight(GetCBound(_Parent),addheight);
  cCutR:=CutR;
  OffsetRect(cCutR,-R.Left,-R.Top);
  if not (_Parent is TCustomForm) then
  begin
  BorderFlags := 0;
  EdgeFlags := 0;
  if GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> 0 then
  begin
    EdgeFlags := EDGE_SUNKEN;
    BorderFlags := BF_RECT or BF_ADJUST
  end else
  if GetWindowLong(Handle, GWL_STYLE) and WS_BORDER <> 0 then
  begin
    EdgeFlags := BDR_OUTER;
    BorderFlags := BF_RECT or BF_ADJUST or BF_MONO;
  end;
  if BorderFlags <> 0 then
  begin
    SetWindowOrgEx(DC,(p1.X-p3.x),(p1.y-p3.y), nil); // more detailed, e.g. at TPageControl
    IntersectClipRect(DC, cCutR.Left, cCutR.Top, cCutR.Right, cCutR.Bottom);
    SetRect(R, 0, 0, Width, Height);
    DrawEdge(DC, R, EdgeFlags, BorderFlags);
  end;
  end;
  SetWindowOrgEx(DC,(p1.X-p2.x),(p1.y-p2.y), nil); //! genauer, z.b. bei TPageControl
  OffsetRect(cCutR,-(p2.x-p3.x),-(p2.y-p3.y));
  IntersectClipRect(DC, cCutR.Left, cCutR.Top, cCutR.Right, cCutR.Bottom);
  Perform(WM_ERASEBKGND, WPARAM(DC), 0);
  Perform(WM_PAINT, WPARAM(DC), 0);
  RestoreDC(DC, SaveIndex);
  _Parent.ControlState:=_Parent.ControlState-[csPaintCopy];
  finally
   Self.BackGraph.Canvas.Unlock;
  end;
  end;
end;

{$ENDIF}


procedure PaintParentBGs(Self:TdhCustomPanel; ppn:TdhCustomPanel; CutR:TRect; const SelfCBound:TRect);
var ref_fixed,ref_scrolled,R:TRect;
    p:TdhCustomPanel;
begin
   if (ppn.Parent is TdhCustomPanel) then
   begin
     p:=TdhCustomPanel(ppn.Parent);
     PaintParentBGs(Self, p, CutR,SelfCBound);
   end;
   R:=GetCBound(ppn);
   ref_fixed:=GetOffsetRect(ppn.ScrollArea,R.Left-CutR.Left,R.Top-CutR.Top);
   ref_scrolled:=GetOffsetRect(ppn.GetInnerClientArea,R.Left-CutR.Left,R.Top-CutR.Top);
   ppn.SpecialBg(ref_scrolled,ref_fixed,Self.BackGraph,GetOffsetRect(CutR,-SelfCBound.Left,-SelfCBound.Top),ppn.BackgroundAttachment=cbaFixed);
end;

function GetItemAreas(const mainRect,itemRect:TRect): TAnchors;
begin
 Result:=[];
 if itemRect.Top<=(mainRect.Top+mainRect.Bottom) div 2 then
 begin
   Result:=Result+[akTop];
 end;
 if itemRect.Bottom>=(mainRect.Top+mainRect.Bottom) div 2 then
 begin
   Result:=Result+[akBottom];
 end;
 if itemRect.Left<=(mainRect.Left+mainRect.Right) div 2 then
 begin
   Result:=Result+[akLeft];
 end;
 if itemRect.Right>=(mainRect.Left+mainRect.Right) div 2 then
 begin
   Result:=Result+[akRight];
 end;
end;

procedure ParentPaintTo(Self:TdhCustomPanel; _Parent:TWinControl; IsTop:boolean; CutR:TRect; const SelfCBound:TRect; addheight:integer; SelfZOrder:integer{=-5555});

procedure CopyTop(src:TWinControl; dst:TdhCustomPanel; srcTopGraph:TdhBitmap32; rr:TRect);
var s,d:TRect;
begin
 s:=rr;
 d:=rr;
 with GetCBound(src).TopLeft do OffsetRect(s,-x,-y);
 with SelfCBound.TopLeft do OffsetRect(d,-x,-y);
 if not srcTopGraph.Empty then
 begin
  dst.BackGraph.Canvas.CopyRect(d,srcTopGraph.Canvas,s);
 end;
end;

var i:integer;
    R:TRect;
    AllWins:boolean;
    ppn:TdhCustomPanel;
    ref_fixed,ref_scrolled,OriCutR:TRect;
    cZOrder:integer;
    c:TControl;
    ObjHolder:TList<TControl>;
    glBinList:TDictionary<TControl,Integer>;
    FilledByChildren:boolean;
    cCutR:TRect;
    scrolledInParent,DoCopyTop:boolean;
    ActiveAnchors:TAnchors;
begin

 if IsRectEmpty(CutR) then exit;

 if (Self.Parent=_Parent) then
 begin
  inc(addheight,Self.HeightDiff);
 end else
 begin
  addheight:=0;
 end;

 AllWins:=not((_Parent.ControlCount<>0) and not (_Parent.Controls[0] is TWinControl));

 FilledByChildren:=false;
 if not ((_Parent is TdhCustomPanel) and  TdhCustomPanel(_Parent).IsScrollArea{ and TdhCustomPanel(_Parent).NCScrollbars}) then
 for i:=0 to _Parent.ControlCount-1 do
 begin
  c:=_Parent.Controls[i];
  R:=GetCBound(c);
  if (R.Left<=CutR.Left) and (R.Top<=CutR.Top) and (R.Right>=CutR.Right) and (R.Bottom>=CutR.Bottom) then
  if FinalVisible(c) and (not (c is TdhCustomPanel) or TdhCustomPanel(c).Opaque) then
  begin
   FilledByChildren:=true;
   break;
  end;
 end;

 if not FilledByChildren then
 if (_Parent is TdhCustomPanel) and AllWins then
 begin
  ppn:=TdhCustomPanel(_Parent);
  if ppn.IsScrollArea then
   addheight:=0;
  R:=GetCBound(ppn);
  scrolledInParent:=ppn.IsScrollArea and ppn.ContainsControl(Self);
  if scrolledInParent and not ppn.SomethingIsFixed (* and (not RectInRect(GetScreenClientBound(ppn),CutR){for Speed: e.g. JPeg drawing extremely slow})*) then
  begin
    //important for HTML generation
   ref_fixed:=GetOffsetRect(ppn.ScrollArea,R.Left-CutR.Left,R.Top-CutR.Top);
   ref_scrolled:=GetOffsetRect(ppn.GetInnerClientArea,R.Left-CutR.Left,R.Top-CutR.Top);
   ppn.SpecialBg(ref_scrolled,ref_fixed,Self.BackGraph,GetOffsetRect(CutR,-SelfCBound.Left,-SelfCBound.Top),ppn.BackgroundAttachment=cbaFixed);
  end else
  begin
   R:=IncHeight(R,addheight);
   ppn.AssertTop(addheight);
   OriCutR:=CutR;
   IntersectRect(CutR,CutR,R);
   DoCopyTop:=True;
   if WithMeta and (Self.Parent=_Parent) then
   begin
     ActiveAnchors:=[];
     if ppn.VariableHeightSize then
     begin
      ActiveAnchors:=ActiveAnchors+[akTop,akBottom];
     end;
     if ppn.VariableWidthSize then
     begin
      ActiveAnchors:=ActiveAnchors+[akLeft,akRight];
     end;
     if Self.SimplifiedAnchors*GetItemAreas(R,CutR)*ActiveAnchors<>Self.SimplifiedAnchors*ActiveAnchors then
     begin
      DoCopyTop:=False;
     end;
   end;
   if (not DoCopyTop or not EqualRect(CutR,OriCutR)) and (Self.Parent=_Parent) then
   begin
    //important for HTML generation
    PaintParentBGs(Self, ppn, OriCutR, SelfCBound);
   end;
   if DoCopyTop then
    CopyTop(ppn,Self,ppn.TopGraph,CutR);
   IntersectRect(CutR,CutR,GetScreenClientBound(_parent));
  end;
 end else
 begin

    R:=SelfCBound;
    cCutR:=CutR;
    OffsetRect(cCutR,-R.Left,-R.Top);
    Self.BackGraph.Canvas.Brush.Style:=bsSolid;
    Self.BackGraph.Canvas.Brush.Color:=TFakeWinControl(_Parent).Color;
    Self.BackGraph.Canvas.FillRect(cCutR);

{$IFNDEF CLX}
  MyPaintTo(Self,_Parent,CutR,SelfCBound,addheight);
{$ENDIF}

  if not((_parent is TScrollingWinControl) and _parent.ContainsControl(Self)) then
   IntersectRect(CutR,CutR,GetScreenClientBound(_parent));
 end;

    if Self.NoSiblingsBackground then exit;

    glBinList:=TDictionary<TControl,Integer>.Create(_Parent.ControlCount);
    ObjHolder:=TList<TControl>.Create;
    ObjHolder.Capacity:=_Parent.ControlCount;
    with _Parent do
    for I := 0 to ControlCount - 1 do
    begin
     c:=Controls[I];
     if not ((c is TWinControl) and FinalVisible(c) and not (csDestroying in c.ComponentState)) or (_Parent=Self.Parent) and (Self.Align in [alTop,alLeft,alBottom,alRight]) and (Self.Align=c.Align) then continue;
     cZOrder:=GetZOrder(c,i);
     if ({(Controls[I].Parent=Self.Parent)}(SelfZOrder<>-5555) and (cZOrder>=SelfZOrder)) then continue;
     glBinList.Add(c,cZOrder);
     ObjHolder.Add(c);
    end;
    ObjHolder.Sort(TComparer<TControl>.Construct(
       function (const c1,c2:TControl):Integer
       var Item1,Item2:Integer;
       begin
        Item1:=glBinList.Items[c1];
        Item2:=glBinList.Items[c2];
        if Item1>Item2 then
         result:=1 else
        if Item1=Item2 then
        result:=0 else
        result:=-1;
       end
    ));
    for i:=0 to ObjHolder.Count-1 do
    begin
     c:=ObjHolder[i];
     R:=GetCBound(TWinControl(c));
     IntersectRect(R,R,CutR);
     if not IsRectEmpty(R) then
      ParentPaintTo(Self, TWinControl(c), false, R,SelfCBound,addheight,-5555);
    end;
    ObjHolder.Free;
    glBinList.Free;

end;

function TdhCustomPanel.HasBackgroundImage(var FPicture:TGraphic):boolean;
begin
 result:=GetVal(pcBackgroundImage);
 if result then
  FPicture:=Cascaded.Picture.RequestGraphic;
end;

function TdhCustomPanel.HasBackgroundImage(var FPicture:TLocationImage):boolean;
begin
 result:=GetVal(pcBackgroundImage);
 if result then
  FPicture:=Cascaded.Picture;
end;

function TdhCustomPanel.HasBackgroundImage:boolean;
begin
 result:=GetVal(pcBackgroundImage);
end;

function TdhCustomPanel.HasTransformations(var tt:TTransformations):boolean;
begin
 result:=EffectsAllowed and GetVal(pcEffects);
 if result then
  tt:=Cascaded.Transformations;
end;

function TdhCustomPanel.GetImageType:TImageType;
var Con:ICon;
begin
 if FIsScrollArea then
 begin
  result:=bitTile;
  exit;
 end;
 result:=FImageType;
 Con:=Self;
 while (result=bitInherit) and (Con.GetCommon.Use<>nil) do
 begin
  Con:=Con.GetCommon.Use;
  result:=Con.GetCommon.FImageType;
 end;
end;

function TdhCustomPanel.GetImageFormat:TImageFormat;
var Con:ICon;
begin
 result:=FImageFormat;
 Con:=Self;
 while (result=ifInherit) and (Con.GetCommon.Use<>nil) do
 begin
  Con:=Con.GetCommon.Use;
  result:=Con.GetCommon.FImageFormat;
 end;
end;

function TdhCustomPanel.TotalInlineBox: boolean;
begin
 result:=false;
end;

function TdhCustomPanel.Referer:TdhCustomPanel;
begin
 result:=Self;
end;

function TdhCustomPanel.HasImage(var FPicture:TGraphic):boolean;
begin
 result:=Referer.GetImageType=bitImage;
 if result then
 if HasBackgroundImage(FPicture) then
 begin
 end else
 begin
  FPicture:=nil;
 end;
end;

function TdhCustomPanel.HasImage(var PicWidth,PicHeight:integer):boolean;
var FPicture:TLocationImage;
begin
 result:=Referer.GetImageType=bitImage;
 if result then
 if HasBackgroundImage(FPicture) then
 begin
  FPicture.RequestCalculations;
  PicWidth:=FPicture.Width;
  PicHeight:=FPicture.Height;
 end else
 begin
  PicWidth:=24;
  PicHeight:=24;
  FPicture:=nil;
 end;
end;

function TdhCustomPanel.HasImage:boolean;
var PicWidth,PicHeight:integer;
begin
 result:=HasImage(PicWidth,PicHeight);
end;

procedure TdhCustomPanel.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited;
  if Child is TdhCustomPanel then
    TdhCustomPanel(Child).NotifyCSSChanged([wcZIndex,wcNoOwnCSS]);
end;

function TdhCustomPanel.BackgroundRepeat:TCSSBackgroundRepeat;
begin
 if GetVal(pcBackgroundRepeat) then
  result:=Cascaded.BackgroundRepeat else
  result:=cbrRepeat;
end;

function TdhCustomPanel.BackgroundAttachment:TCSSBackgroundAttachment;
begin
 if GetVal(pcBackgroundAttachment) then
  result:=Cascaded.BackgroundAttachment else
  result:=cbaScroll;
end;

function TdhCustomPanel.GetAffine:TdhAffineTransformation;
begin
 with Cascaded do
 begin
  glAT:=TdhAffineTransformation.Create;
  glATAlpha:=1;
  glATShiftX:=0;
  glATShiftY:=0;
  GetVal(pcTransformationsMatrix);
  result:=glAT;
  glAT:=nil;
 end;
end;

procedure TdhCustomPanel.AdjustLittle(var W,H:integer; infl:boolean; adj:boolean=true);
var
  SrcR: Integer;
  SrcB: Integer;
  T: TdhAffineTransformation;
  Scale, ScaleX,ScaleY: Single;
  Transformations:TTransformations;
begin

 if NoRotating then exit;

 if HasTransformations(Transformations) then
 begin

    SrcR := W-1;
    SrcB := H-1;
    T:=GetAffine;
    T.SrcRect:=FloatRect(0, 0, SrcR + 1, SrcB + 1);
    with T.GetTransformedBoundsf do T.Translate(-Left,-Top);
    with T.GetTransformedBoundsf do
    begin
    ScaleX:=0;
    ScaleY:=0;
    if W<>0 then
     ScaleX:=(Right-Left)/W;
    if H<>0 then
     ScaleY:=(Bottom-Top)/H;
    Scale:=max(ScaleX,ScaleY);
    end;

 if infl then
 begin
    if not adj then
     scale:=1;
    if not adj then
    begin
    W := Round(T.GetTransformedBoundsf.Right);
    H := Round(T.GetTransformedBoundsf.Bottom);
    end else
    with T.GetTransformedBoundsf do
    begin
    W := Round(W/Scale);
    H := Round(H/Scale);
    end;
 end else
 begin
    with T.GetTransformedBoundsf do
    begin        
    W := Round(T.GetTransformedBoundsf.Right);
    H := Round(T.GetTransformedBoundsf.Bottom);
    W := Round(T.GetTransformedBoundsf.Right);
    H := Round(T.GetTransformedBoundsf.Bottom);
    end;
 end;
 T.Free;
 end;
end;

procedure TdhCustomPanel.PaintWhiteBackground(ref_brct:TRect; Src:TdhBitmap32; const brct: TRect);
begin
end;

procedure TdhCustomPanel.SpecialBg(const ref_scrolled,ref_fixed:TRect; Src:TdhBitmap32; const brct: TRect; IsFixed:boolean);
var
  num_across, num_down,
  y, x : integer;
  FPicture:TGraphic;
  FBackgroundRepeat:TCSSBackgroundRepeat;
  BPos:TPoint;
  x1,x2,y1,y2:integer;
  Strech32,Strech32Mult:TdhBitmap32;
  R,R2,ref:TRect;
  Col:TColor32;
  P:PColor32;

procedure cp(const R1,R2:TRect);
begin
   Strech32.DrawTo(Src,R1,R2);
end;

procedure StretchDrawEx(Graphic:TGraphic);
var Strech32:TdhBitmap32;
begin
  Strech32:=GetAs32(Graphic);
  try
  Strech32.ApplyGoodStrechFilter;
  Strech32.DrawTo(Src,ref,brct,Strech32.BoundsRect);
  finally
   Strech32.Free;
  end;
end;

procedure StretchDraw;
var sOnChange:TNotifyEvent;
begin
  sOnChange:=FPicture.OnChange;
  FPicture.OnChange:=nil;
  StretchDrawEx(FPicture);
  FPicture.OnChange:=sOnChange;
end;

var OldPreventGraphicOnChange:boolean;

begin

 if IsRectEmpty(brct) then exit;

 OldPreventGraphicOnChange:=PreventGraphicOnChange;
 PreventGraphicOnChange:=true;
 try
 if not Transparent then
 begin
  if IsOpaqueColor(BackgroundColor) then
  begin
   Src.FillRectS(brct,CSSColorToColor32(BackgroundColor))
  end else
  begin
   Col:=CSSColorToColor32(BackgroundColor);
   for Y:= brct.Top to brct.Bottom-1 do
   begin
    P:=Src.PixelPtr[brct.Left,Y];
    for X:= brct.Left to brct.Right-1 do
    begin
      P^:=GetPixelCombineNormal(Col,P^);
      Inc(P);
    end;
   end;
  end;
 end;
 if IsFixed then
  ref:=ref_fixed else
  ref:=ref_scrolled;

 if HasImage(FPicture) or (Referer.GetImageType=bitStretch) and HasBackgroundImage(FPicture) then
 begin
  if FPicture<>nil then
   StretchDraw;
  if FPicture=nil then
  begin
   if (GetImageBitmap<>nil) then
   begin
    StretchDrawEx(GetImageBitmap);
   end;
  end;

 end else
 if HasBackgroundImage(FPicture) then

 if (Referer.GetImageType=bitSplit) then
 begin

   Strech32:=GetAs32(FPicture);
   try

   x1:=FPicture.Width div 2;
   x2:=FPicture.Width-x1;
   y1:=FPicture.Height div 2;
   y2:=FPicture.Height-y1;

   {top-left}
   cp(Bounds(brct.Left,brct.Top,x1,y1),Bounds(0,0,x1,y1));
   {top-right}
   cp(Bounds(brct.Right-x2,brct.Top,x2,y1),Bounds(x1,0,x2,y1));
   {bottom-left}
   cp(Bounds(brct.Left,brct.Bottom-y2,x1,y2),Bounds(0,y1,x1,y2));
   {bottom-right}
   cp(Bounds(brct.Right-x2,brct.Bottom-y2,x2,y2),Bounds(x1,y1,x2,y2));

   {top}
   cp(Rect(brct.Left+x1,brct.Top,brct.Right-x2,brct.Top+y1),Rect(x1,0,x1+1,y1));
   {right}
   cp(Rect(brct.Right-x2,brct.Top+y1,brct.Right,brct.Bottom-y2),Rect(x1,y1,x1+x2,y1+1));
   {left}
   cp(Rect(brct.Left,brct.Top+y1,brct.Left+x1,brct.Bottom-y2),Rect(0,y1,x1,y1+1));
   {bottom}
   cp(Rect(brct.Left+x1,brct.Bottom-y2,brct.Right-x2,brct.Bottom),Rect(x1,y1,x1+1,y1+y2));

   {midth}
   cp(Rect(brct.Left+x1,brct.Top+y1,brct.Right-x2,brct.Bottom-y2),Rect(x1,y1,x1+1,y1+1));
   finally
    FreeAndNil(Strech32);
   end;


 end else
 begin

 FBackgroundRepeat:=BackgroundRepeat;
 BPos:=ref.TopLeft;
 if GetVal(pcBackgroundPosition) then
  GetBackgroundPixels(Cascaded.BackgroundPosition,ref,FPicture.Width,FPicture.Height,BPos);

 Strech32:=GetAs32(FPicture);
 try
  GetRepeatings(BPos,num_across,num_down,Strech32.Width,Strech32.Height,brct,FBackgroundRepeat in [cbrRepeat,cbrRepeatX],FBackgroundRepeat in [cbrRepeat,cbrRepeatY]);
  R:=Bounds(BPos.X,BPos.Y,Strech32.Width*num_across,Strech32.Height*num_down);
  R2:=R;
  IntersectRect(R,R,brct);
  if not IsRectEmpty(R) then
  begin
  R2:=GetOffsetRect(R,-R2.Left,-R2.Top);
  Strech32Mult:=Multiply32(Strech32,R2.Right,R2.Bottom);
  try
   Strech32Mult.DrawTo(Src,R,R2);
  finally
   FreeAndNil(Strech32Mult);
  end;
  end;
 finally
  FreeAndNil(Strech32);
 end;
 end;

 PaintWhiteBackground(ref_scrolled,Src,brct);

 finally
  PreventGraphicOnChange:=OldPreventGraphicOnChange;
 end;
end;

function TdhCustomPanel.MarginTotalRect:TRect;
begin
 result:=TotalRect;
 result:=ShrinkRect(result,MarginPure);
end;

function TdhCustomPanel.BorderPure:TRect;
begin
 result.Left:=DisplayBorderWidth(ealLeft);
 result.Top:=DisplayBorderWidth(ealTop);
 result.Bottom:=DisplayBorderWidth(ealBottom);
 result.Right:=DisplayBorderWidth(ealRight);
end;

function TdhCustomPanel.BorderPureWithHidden:TRect;

function DisplayBorderWidth(const Align:TEdgeAlign):integer;
begin
 if BorderStyle(Align) in [cbsNone] then
  result:=0 else
  result:=BorderWidth(Align);
end;

begin
 result.Left:=DisplayBorderWidth(ealLeft);
 result.Top:=DisplayBorderWidth(ealTop);
 result.Bottom:=DisplayBorderWidth(ealBottom);
 result.Right:=DisplayBorderWidth(ealRight);
end;

function TdhCustomPanel.AllEdgesPure:TRect;
begin
 result:=GetAddRect(GetAddRect(MarginPure,BorderPure),PaddingPure);
end;

function TdhCustomPanel.ClientEdgesPure:TRect;
begin
 result:=MarginPure;
 AddRect(result,BorderPure);
end;

function TdhCustomPanel.IncludeBorderAndPadding:boolean;
begin
 result:=false;
end;

function TdhCustomPanel.PaddingPure:TRect;
begin
 result.Left:=PaddingWidth(ealLeft);
 result.Top:=PaddingWidth(ealTop);
 result.Bottom:=PaddingWidth(ealBottom);
 result.Right:=PaddingWidth(ealRight);
end;

function TdhCustomPanel.MarginPure:TRect;
begin
 result.Left:=MarginWidth(ealLeft);
 result.Top:=MarginWidth(ealTop);
 result.Bottom:=MarginWidth(ealBottom);
 result.Right:=MarginWidth(ealRight);
end;

procedure TdhCustomPanel.SpecialPaintBorder(const rct,brct: TRect; PixelCombineEvent:TPixelCombineEvent);
begin
  if BorderStyle(ealLeft)<cbsSolid then
   Frame3D(ealLeft,[Point(rct.Left,rct.Bottom),rct.TopLeft,brct.TopLeft,Point(brct.Left,brct.Bottom)],PixelCombineEvent);
  if BorderStyle(ealRight)<cbsSolid then
   Frame3D(ealRight,[Point(rct.Right, rct.Top),rct.BottomRight,brct.BottomRight,Point(brct.Right,brct.Top)],PixelCombineEvent);
  if BorderStyle(ealBottom)<cbsSolid then
   Frame3D(ealBottom,[rct.BottomRight,Point(rct.Left,rct.Bottom),Point(brct.Left,brct.Bottom),brct.BottomRight],PixelCombineEvent);
  if BorderStyle(ealTop)<cbsSolid then
   Frame3D(ealTop,[rct.TopLeft,Point(rct.Right,rct.Top),Point(brct.Right,brct.Top), Point(brct.Left,brct.Top)],PixelCombineEvent);
  if BorderStyle(ealLeft)>=cbsSolid then
   Frame3D(ealLeft,[Point(rct.Left,rct.Bottom),rct.TopLeft,brct.TopLeft,Point(brct.Left,brct.Bottom)],PixelCombineEvent);
  if BorderStyle(ealRight)>=cbsSolid then
   Frame3D(ealRight,[Point(rct.Right, rct.Top),rct.BottomRight,brct.BottomRight,Point(brct.Right,brct.Top)],PixelCombineEvent);
  if BorderStyle(ealBottom)>=cbsSolid then
   Frame3D(ealBottom,[rct.BottomRight,Point(rct.Left,rct.Bottom),Point(brct.Left,brct.Bottom),brct.BottomRight],PixelCombineEvent);
  if BorderStyle(ealTop)>=cbsSolid then
   Frame3D(ealTop,[rct.TopLeft,Point(rct.Right,rct.Top),Point(brct.Right,brct.Top), Point(brct.Left,brct.Top)],PixelCombineEvent);
end;

procedure TdhCustomPanel.PaintBorder;
begin
  if not RuntimeMode and (csDesigning in ComponentState) and IsNullRect(BorderPure) and not Opaque then
  if not IsRasterized then
  with GetCanvas do
  begin
   Brush.Style := bsClear;
   Pen.Style := psDash;
   Pen.Color := clBlack;
   Rectangle(TotalRect);
   exit;
  end;
  PaintOuterBorder;
end;

function Between(i,_min,_max:integer):integer; inline;
begin
 result:=min(max(i,_min),_max);
end;

procedure TdhCustomPanel.PaintOuterBorder;
var rct,brct: TRect;
begin
  brct:=self.ScrollAreaWithScrollbars;
  rct:=InflRect(brct,BorderPure);
  SpecialPaintBorder(rct,brct);
end;

procedure TdhCustomPanel.PaintOuterBg;
begin
  SpecialBg(GetInnerClientArea,ScrollArea,ActTopGraph,ScrollArea,BackgroundAttachment=cbaFixed);
end;

function TdhCustomPanel.IsAbsolutePositioned:boolean;
begin
 result:=Align<>alTop;
end;

procedure TdhCustomPanel.PixelCombineUnderpaint(F: TColor32; var B: TColor32; M: TColor32);
begin
 B:=GetPixelCombineNormal(B,F,$FF);
end;

procedure TdhCustomPanel.PixelCombineInner(F: TColor32; var B: TColor32; M: TColor32);
begin
 B:=GetPixelCombineNormal(F and $FFFFFF or max(0,round((F shr 24 - ($FF-B shr 24)*eigen))) shl 24,B or $FF000000,$FF) and $FFFFFF or (B and $FF000000);
end;

procedure TdhCustomPanel.PixelCombineNormal(F: TColor32; var B: TColor32; M: TColor32);
begin
 B:=GetPixelCombineNormal(F,B,M);
end;

procedure TdhCustomPanel.PixelCombineNegativeMultiply(F: TColor32; var B: TColor32; M: TColor32);
var B2:TColor32;
    alpha:Cardinal;
begin
 B2:=ColorNegMult(F,GetBlendMemEx(B,$FF000000,$FF),M);
 alpha:=M*(((F shr 24)*(255 - (B shr 24))) + (B shr 24)*255);
 B:=GetOriginalRGB(B2,alpha);
end;

procedure TdhCustomPanel.PixelCombineMultiply(F: TColor32; var B: TColor32; M: TColor32);
begin
 B:=ExtractAlphaColor(ColorMult(F,GetBlendMemEx(B,$FF000000,$FF),M),ColorMult(F,GetBlendMemEx(B,$FFFFFFFF,$FF),M));
end;

procedure Exch(var a,b:TdhBitmap32); overload;
var c:TdhBitmap32;
begin
 c:=a;
 a:=b;
 b:=c;
end;

function NearNull(a:double):boolean;
begin
 result:=abs(a)<0.001;
end;

function NearOne(a:double):boolean;
begin
 result:=abs(a-1)<0.001;
end;

function NearSameMatrix(const a,b:TFloatMatrix):boolean;
var i,j:integer;
begin
 for i:=0 to 2 do
 for j:=0 to 2 do
 if not NearNull(a[i,j]-b[i,j]) then
 begin
  result:=false;
  exit;
 end;
 result:=true;
end;

function IsRegular(Det:Single):boolean;
begin
 result:=not (Abs(Det) < 1E-5);
end;


function TdhCustomPanel.EasyBounds(var Transformations:TTransformations;var T: TdhAffineTransformation; var W,H:Integer; var HorzRotated,VertRotated:boolean): boolean;
begin
  result:=true;
  if not HasTransformations(Transformations) then
   Transformations:=nil;

  T:=GetAffine;

  HorzRotated:=NearNull(T.Matrix[1,0]) and NearNull(T.Matrix[0,1]) and not NearNull(T.Matrix[0,0]) and not NearNull(T.Matrix[1,1])        {and NearNull(abs(T.Matrix[0,0])-1) and NearNull(abs(T.Matrix[1,1])-1)};
  VertRotated:=NearNull(T.Matrix[0,0]) and NearNull(T.Matrix[1,1]) and not NearNull(T.Matrix[0,1]) and not NearNull(T.Matrix[1,0])        {and NearNull(abs(T.Matrix[0,1])-1) and NearNull(abs(T.Matrix[1,0])-1)};

  if not EffectsAllowed then exit;

  if HorzRotated and not CustomSizesForEffects and (not NearOne(T.Matrix[0,0]) or not NearOne(T.Matrix[1,1])) then
   HorzRotated:=false;
  if VertRotated and not CustomSizesForEffects and (not NearOne(T.Matrix[0,1]) or not NearOne(T.Matrix[1,0])) then
   VertRotated:=false;

  if (Transformations=nil) or Transformations.FullIfEasy and HorzRotated then
  begin
   if W<>maxint then
    W:=round(W/abs(T.Matrix[0,0]));
   if H<>maxint then
    H:=round(H/abs(T.Matrix[1,1]));
  end else
  if (Transformations<>nil) and Transformations.FullIfEasy and VertRotated then
  begin
   Exch(W,H);
   if W<>maxint then
    W:=round(W/abs(T.Matrix[0,1]));
   if H<>maxint then
    H:=round(H/abs(T.Matrix[1,0]));
  end else
   result:=false;
end;

procedure TdhCustomPanel.TransFromBlackWhite_BG(bmp:TdhBitmap32);
begin
  BeginPainting(bmp);
  try
   PaintOuterBorder;
   PaintOuterBg;
  finally
   EndPainting;
  end;
end;

procedure TdhCustomPanel.TransFromBlackWhite_TP(bmp:TdhBitmap32);
begin
  BeginPainting(bmp);
  try
   DoTopPainting;
  finally
   EndPainting;
  end;
end;

function TdhCustomPanel.TransPainting(nWidth:integer=-1; nHeight:integer=-1):TdhBitmap32;
var Src:TdhBitmap32;
var T: TdhAffineTransformation;
    Transformations:TTransformations;
    bWidth,bHeight:integer;
    cr:TRect;

procedure PaintBlur(_Src,SrcFinal:TdhBitmap32; pc:TPixelCombineMode; inv:boolean);
begin
 _Src.DrawMode:=dmCustom;
 if not inv then
  _Src.OnPixelCombine:= PixelCombineUnderpaint else
  _Src.OnPixelCombine:= PixelCombineInner;
 _Src.DrawTo(SrcFinal);
end;

var HorzRotated,VertRotated,IsEasy:boolean;

procedure DoBlurEffects;
var Src2,SrcFinal:TdhBitmap32;
    MaxJitter:integer;
begin
  if (Transformations<>nil) then
  with Transformations do
  if InnerGlow.Enabled or InnerShadow.Enabled or OuterGlow.Enabled or OuterShadow.Enabled or Blur.Enabled then
  begin

   MaxJitter:=0;
   MaxJitter:=Max(MaxJitter,Transformations.InnerGlow.MaxJitter);
   MaxJitter:=Max(MaxJitter,Transformations.InnerShadow.MaxJitter);
   MaxJitter:=Max(MaxJitter,Transformations.OuterGlow.MaxJitter);
   MaxJitter:=Max(MaxJitter,Transformations.OuterShadow.MaxJitter);
   MaxJitter:=Max(MaxJitter,Transformations.Blur.MaxJitter);
   EqArea:=ShrinkRect(EqArea,Rect(MaxJitter,MaxJitter,MaxJitter,MaxJitter));
   EqArea.Bottom:=max(EqArea.Bottom,EqArea.Top);
   EqArea.Right:=max(EqArea.Right,EqArea.Left);

   Src2:=TdhBitmap32.Create;
   Src2.SetSize(Src.Width,Src.Height);
   SrcFinal:=TdhBitmap32.Create;
   SrcFinal.Assign(Src);
   try
   if Transformations.InnerGlow.Enabled then
   begin
    DoBlur(Src,Src2,Transformations.InnerGlow,true);
    PaintBlur(Src2,SrcFinal,pcNegMult,true);
   end;
   if Transformations.InnerShadow.Enabled then
   begin
    DoBlur(Src,Src2,Transformations.InnerShadow,true);
    PaintBlur(Src2,SrcFinal,pcMult,true);
   end;
   if Transformations.OuterGlow.Enabled then
   begin
    DoBlur(Src,Src2,Transformations.OuterGlow,false);
    PaintBlur(Src2,SrcFinal,pcNegMult,false);
   end;
   if Transformations.OuterShadow.Enabled then
   begin
    DoBlur(Src,Src2,Transformations.OuterShadow,false);
    PaintBlur(Src2,SrcFinal,pcMult,false);
   end;

   if Transformations.Blur.Enabled then
   begin
    Src.Clear(clWhite32);
    SrcFinal.DrawTo(Src);
    DoBlurPure(Src,Src2,Transformations.Blur,0,true);
    DoBlurPure(Src,Src2,Transformations.Blur,8,true);
    DoBlurPure(Src,Src2,Transformations.Blur,16,true);
    Exch(Src2,Src);
    Src.Clear(clBlack32);
    SrcFinal.DrawTo(Src);
    Exch(Src2,SrcFinal);
    DoBlurPure(Src,Src2,Transformations.Blur,0);
    DoBlurPure(Src,Src2,Transformations.Blur,8);
    DoBlurPure(Src,Src2,Transformations.Blur,16);
    ExtractAlphaBitmap(Src.PixelPtr[0, 0],SrcFinal.PixelPtr[0, 0],Src.Height*Src.Width);
   end else
    Exch(Src,SrcFinal);

   finally
    FreeAndNil(SrcFinal);
    FreeAndNil(Src2);
   end;
   Src.DrawMode:=dmBlend;
  end;
end;

procedure AllOrTextOnly;
var Src2:TdhBitmap32;
begin
  if TextExclude then
  begin
   Src2:=TransFromBlackWhite(TransFromBlackWhite_TP,Src.Width,Src.Height);
   Src2.OnPixelCombine:= PixelCombineNormal;
   Src2.DrawMode:=dmCustom;
   Src2.DrawTo(Src);
   FreeAndNil(Src2);
  end;
  if TextOnly then
  begin
   Src2:=TransFromBlackWhite(TransFromBlackWhite_BG,Src.Width,Src.Height);
   Src.OnPixelCombine:= PixelCombineNormal;
   Src.DrawMode:=dmCustom;
   Src.DrawTo(Src2);
   FreeAndNil(Src);
   Src:=Src2;
  end;
end;

procedure DoTransform;
var Src2:TdhBitmap32;
    EqAreaF:TFloatRect;
begin

  assert(bWidth=Src.Width); 

  Dec(nWidth,cr.Left+cr.Right);
  Dec(nHeight,cr.Top+cr.Bottom);
  Dec(bWidth,cr.Left+cr.Right);
  Dec(bHeight,cr.Top+cr.Bottom);

  T.SrcRect:=FloatRect(cr.Left,cr.Top,bWidth+cr.Left,bHeight+cr.Top);
  with T.GetTransformedBoundsf do
  if not IsEasy and HorzRotated then
   T.Translate(-Left+(nWidth/2)-((bWidth+nWidth) mod 2 / 2)-(Right-Left)/2,-Top+(nHeight/2)-((bHeight+nHeight) mod 2 / 2)-(Bottom-Top)/2) else
  if not IsEasy and VertRotated then
   T.Translate(-Left+(nWidth/2)-((bHeight+nWidth) mod 2 / 2)-(Right-Left)/2,-Top+(nHeight/2)-((bWidth+nHeight) mod 2 / 2)-(Bottom-Top)/2) else
   T.Translate(-Left+Round((nWidth/2)-(Right-Left)/2),-Top+Round((nHeight/2)-(Bottom-Top)/2));

  Inc(nWidth,cr.Left+cr.Right);
  Inc(nHeight,cr.Top+cr.Bottom);
  Inc(bWidth,cr.Left+cr.Right);
  Inc(bHeight,cr.Top+cr.Bottom);

  T.Translate(cr.Left,cr.Top);

  T.Translate(Cascaded.glATShiftX, Cascaded.glATShiftY);

  T.SrcRect:=FloatRect(0,0,Src.Width,Src.Height);
  if not NearSameMatrix(T.Matrix,IdentityMatrix) then
  begin

  Src.ApplyGoodStrechFilter;
  Src.DrawMode:=dmBlend;
  Src.OnPixelCombine:= PixelCombineNormal;
  Src.DrawMode:=dmCustom;
  Src2:=TdhBitmap32.Create;
  Src2.SetSize(nWidth,nHeight);
  Src2.Clear(0);

    if IsRegular(Determinant(t.Matrix)) then
    begin
     Transform(Src2, Src, T);
    end;
    FreeAndNil(Src);
    Src:=Src2;
    Src.DrawMode:=dmBlend;
  end;

    if IsEasy then
    begin
     with EqArea do
      T.SrcRect:=FloatRect(Left,Top,Right,Bottom);
     EqAreaF:=T.GetTransformedBoundsF;
     EqArea.Left:=Between(Round(EqAreaF.Left),0,Src.Width);
     EqArea.Right:=Between(Round(EqAreaF.Right),0,Src.Width);
     EqArea.Top:=Between(Round(EqAreaF.Top),0,Src.Height);
     EqArea.Bottom:=Between(Round(EqAreaF.Bottom),0,Src.Height);
    end else
     EqArea.Left:=InvalidEqArea;

end;

procedure DoRoundCorners;
var SrcFinal:TdhBitmap32;
    bo,OuterRect,InnerRect:TRect;
    brTopLeft,brTopRight,brBottomLeft,brBottomRight:TPoint;
    AvailX,AvailY:integer;
var TopLeftDouble,TopRightDouble,BottomLeftDouble,BottomRightDouble:boolean;
begin

  if GetBorderRadii(brTopLeft,brTopRight,brBottomLeft,brBottomRight,TopLeftDouble,TopRightDouble,BottomLeftDouble,BottomRightDouble) then
  begin

   SrcFinal:=TdhBitmap32.Create;
   SrcFinal.Assign(Src);
   bo:=BorderPureWithHidden;
   OuterRect:=ShrinkRect(Src.BoundsRect,MarginPure);
   InnerRect:=ShrinkRect(OuterRect,bo);

   AvailX:=OuterRect.Right-OuterRect.Left;
   AvailY:=OuterRect.Bottom-OuterRect.Top;
   NotTooBig(brTopLeft.X,brTopRight.X,brTopLeft.Y,brTopRight.Y,AvailX,TopLeftDouble,TopRightDouble);
   NotTooBig(brBottomLeft.X,brBottomRight.X,brBottomLeft.Y,brBottomRight.Y,AvailX,BottomLeftDouble,BottomRightDouble);
   NotTooBig(brTopLeft.Y,brBottomLeft.Y,brTopLeft.X,brBottomLeft.X,AvailY,TopLeftDouble,BottomLeftDouble);
   NotTooBig(brTopRight.Y,brBottomRight.Y,brTopRight.X,brBottomRight.X,AvailY,TopRightDouble,BottomRightDouble);
   NotTooBig2(brTopLeft,AvailX-bo.Right,AvailY-bo.Bottom,TopLeftDouble);
   NotTooBig2(brBottomLeft,AvailX-bo.Right,AvailY-bo.Top,BottomLeftDouble);
   NotTooBig2(brTopRight,AvailX-bo.Left,AvailY-bo.Bottom,TopRightDouble);
   NotTooBig2(brBottomRight,AvailX-bo.Left,AvailY-bo.Top,BottomRightDouble);

   EqArea.Left:=Max(InnerRect.Left,Max(OuterRect.Left+brTopLeft.X,OuterRect.Left+brBottomLeft.X));
   EqArea.Right:=Min(InnerRect.Right,Min(OuterRect.Right-brTopRight.X,OuterRect.Right-brBottomRight.X));
   EqArea.Top:=Max(InnerRect.Top,Max(OuterRect.Top+brTopLeft.Y,OuterRect.Top+brTopRight.Y));
   EqArea.Bottom:=Min(InnerRect.Bottom,Min(OuterRect.Bottom-brBottomLeft.Y,OuterRect.Bottom-brBottomRight.Y));

   RoundCorner(OuterRect,SrcFinal,Src,brTopLeft.X,brTopLeft.Y,bo.Top,bo.Left,calTopLeft);
   RoundCorner(OuterRect,SrcFinal,Src,brBottomLeft.X,brBottomLeft.Y,bo.Bottom,bo.Left,calBottomLeft);
   RoundCorner(OuterRect,SrcFinal,Src,brTopRight.X,brTopRight.Y,bo.Top,bo.Right,calTopRight);
   RoundCorner(OuterRect,SrcFinal,Src,brBottomRight.X,brBottomRight.Y,bo.Bottom,bo.Right,calBottomRight);

   FreeAndNil(SrcFinal);
  end;
end;

begin

  if TextOnly then
   cr:=AllEdgesPure else
   cr:=Rect(0,0,0,0);

  bWidth:=nWidth;
  bHeight:=nHeight;
  Dec(bWidth,cr.Left+cr.Right);
  Dec(bHeight,cr.Top+cr.Bottom);
  IsEasy:=EasyBounds(Transformations,T,bWidth,bHeight,HorzRotated,VertRotated);
  Inc(bWidth,cr.Left+cr.Right);
  Inc(bHeight,cr.Top+cr.Bottom);
  if EffectsAllowed and not IsEasy then
  begin
   NoRotating:=true;
   GetAutoRect(CustomSizesForEffects,CustomSizesForEffects,bWidth,bHeight);
   NoRotating:=false;
  end;

  NoRotating:=true;
  try
   if TextExclude then
    Src:=TransFromBlackWhite(TransFromBlackWhite_BG,bWidth,bHeight) else
    Src:=TransFromBlackWhite(TransFromBlackWhite_TP,bWidth,bHeight);
  finally
   NoRotating:=false;
  end;

  EqArea:=ShrinkRect(ShrinkRect(Src.BoundsRect,MarginPure),BorderPure);

  if EffectsAllowed then
  begin
   if not TextOnly then
    DoRoundCorners;
   DoBlurEffects;
   DoTransform;

   Src.MasterAlpha:=Round(Cascaded.glATAlpha*255);
   MixAlpha(Src);
  end;

  AllOrTextOnly;
  if TextOnly then
  begin
   EqArea:=ShrinkRect(ShrinkRect(Src.BoundsRect,MarginPure),BorderPure);
   DoRoundCorners;
  end;

  Result:=Src;
  T.Free;
end;

function TdhCustomPanel.TextOnly:boolean;
begin
 result:=false;
end;

function TdhCustomPanel.TextExclude:boolean;
begin
 result:=false;
end;

function TdhCustomPanel.CustomSizesForEffects:boolean;
begin
 result:=false;
end;

procedure TdhCustomPanel.DrawFrame;
var _ActDown:TActMode;
begin
 if not IsScrollArea then exit;

    if (ActDown<>amNone) and (ActDown=GetActDown{(Mouse.CursorPos)}) then
     _ActDown:=ActDown else
     _ActDown:=amNone;

 DoDrawFrame(GetCanvas,_ActDown);
end;

procedure TdhCustomPanel.DoDrawFrame(Canvas:TCanvas; _ActDown:TActMode);

//for frame
var Scrollbar3dlightColor,ScrollbarDarkshadowColor:TColor32;
    ScrollbarHighlightColor,ScrollbarShadowColor:TColor32;
    ScrollbarFaceColor,ScrollbarArrowColor,ScrollbarBaseColor:TColor32;
                                                                       
var Src:TdhBitmap32;

const uparrow:array[0..6,0..6] of integer=(
(0,0,0,0,0,0,0),
(0,0,0,1,0,0,0),
(0,0,1,1,1,0,0),
(0,1,1,1,1,1,0),
(1,1,1,1,1,1,1),
(0,0,0,0,0,0,0),
(0,0,0,0,0,0,0));

procedure DrawButton(Rct:TRect; Down:boolean);
procedure DrawOnePixLine(Rct:TRect; Scrollbar3dlightColor,ScrollbarDarkshadowColor:TColor32);
begin
 if IsRectEmpty(Rct) then exit;
 Src.Line(Rct.Left,Rct.Top,Rct.Right-1,Rct.Top,Scrollbar3dlightcolor);
 Src.Line(Rct.Left,Rct.Top,Rct.Left,Rct.Bottom-1,Scrollbar3dlightcolor);
 Src.Line(Rct.Left,Rct.Bottom-1,Rct.Right,Rct.Bottom-1,ScrollbarDarkshadowColor);
 Src.Line(Rct.Right-1,Rct.Top,Rct.Right-1,Rct.Bottom,ScrollbarDarkshadowColor);
end;
begin
 with Rct do Src.FillRect(Left,Top,Right,Bottom,ScrollbarFaceColor);
 if Down then
  DrawOnePixLine(Rct,ScrollbarShadowColor,ScrollbarShadowColor) else
 begin
  DrawOnePixLine(Rct,Scrollbar3dlightColor,ScrollbarDarkshadowColor);
  DrawOnePixLine(Rect(Rct.Left+1,Rct.Top+1,Rct.Right-1,Rct.Bottom-1),ScrollbarHighlightColor,ScrollbarShadowColor);
 end;
end;

procedure DrawChecked(Rct:TRect);
var x,y:integer;
begin             
 if IsRectEmpty(Rct) then exit;
 with Rct do Src.FillRectS(Left,Top,Right,Bottom,ScrollbarFaceColor);
 for x:=Rct.Left to Rct.Right-1 do
 for y:=Rct.Top to Rct.Bottom-1 do
 if (x+y-Rct.Left-Rct.Top) and 1<>0 then
  Src.Pixel[x,y]:=ScrollbarHighlightColor;
end;

procedure DrawArrow(const ClpRct:TRect; P:TPoint; Vert,Mirror:boolean; ScrollbarArrowColor:TColor32);
var x,y:integer;
begin
 for x:=0 to 6 do
 for y:=0 to 6 do
 if PtInRect(ClpRct,Point(P.X+x,P.Y+y)) then
 if     Vert and (not Mirror and (uparrow[y,x]<>0) or Mirror and (uparrow[6-y,x]<>0)) or
    not Vert and (not Mirror and (uparrow[x,y]<>0) or Mirror and (uparrow[6-x,y]<>0)) then
  Src.Pixel[P.X+x,P.Y+y]:=ScrollbarArrowColor;
end;

procedure DrawArrow2(const ClpRct:TRect; P:TPoint; Vert,Mirror,Down:boolean; Disabled:boolean);
begin
 if Disabled then
  Down:=False;
 if Down then
  P:=Point(P.X+1,P.Y+1);
 if not Disabled then
  DrawArrow(ClpRct,P,Vert,Mirror,ScrollbarArrowColor) else
  begin
  DrawArrow(ClpRct,Point(P.x+1,P.y+1),Vert,Mirror,ScrollbarHighlightColor);
  DrawArrow(ClpRct,P,Vert,Mirror,ScrollbarShadowColor);
  end;
end;

const IncLight=35;
      MulLight=0.5;
const IncLight2=0;
      MulLight2=0.4;

begin
                            
 Src:=ActTopGraph;
 
 ScrollbarBaseColor:=clRed32;
 ScrollbarBaseColor:=Color32(clBtnFace);
 ScrollbarArrowColor:=clBlack32;
 ScrollbarFaceColor:=ScrollbarBaseColor;

 Scrollbar3dlightColor:=ScrollbarBaseColor;
 ScrollbarDarkshadowColor:=clBlack32;

 ScrollbarHighlightColor:=AddRGB(ScrollbarBaseColor,IncLight);
 ScrollbarHighlightColor:=ScrollbarHighlightColor+Color32(Round((255-RedComponent(ScrollbarHighlightColor))*MulLight),
                                                          Round((255-GreenComponent(ScrollbarHighlightColor))*MulLight),
                                                          Round((255-BlueComponent(ScrollbarHighlightColor))*MulLight)) and $FFFFFF;
 ScrollbarShadowColor:=AddRGB(ScrollbarBaseColor,-IncLight2);
 ScrollbarShadowColor:=ScrollbarShadowColor -     Color32(Round((RedComponent(ScrollbarShadowColor))*MulLight2),
                                                          Round((GreenComponent(ScrollbarShadowColor))*MulLight2),
                                                          Round((BlueComponent(ScrollbarShadowColor))*MulLight2)) and $FFFFFF;

 if IsVertScrollBarVisible then
 if FOneButton then
 begin          
 DrawButton(GetVertWhole,(_ActDown=VertOneButton){ and VertBarVisible});
 with GetVertWhole do
  DrawArrow2(Rect(Left+1,Top+1,Right-1,Bottom-1),Point(Left+(Right-Left-7) div 2,Top+(Bottom-Top-7) div 2),true,true,_ActDown=VertOneButton,{not VertBarVisible}false);
 end else
 begin
 DrawChecked(GetVertChecked);
 DrawButton(GetVertButton1,(_ActDown=VertButton1) and VertBarVisible);
 DrawButton(GetVertButton2,(_ActDown=VertButton2) and VertBarVisible);
 DrawButton(GetVertBar,false);
 with GetVertButton1 do
  DrawArrow2(Rect(Left+1,Top+1,Right-1,Bottom-1),Point(Left+(Right-Left-7) div 2,Top+(Bottom-Top-7+1) div 2),true,false,_ActDown=VertButton1,not VertBarVisible);
 with GetVertButton2 do
  DrawArrow2(Rect(Left+1,Top+1,Right-1,Bottom-1),Point(Left+(Right-Left-7) div 2,Top+(Bottom-Top-7) div 2),true,true,_ActDown=VertButton2,not VertBarVisible);
 end;

 if IsHorzScrollBarVisible then
 begin
 try
 DrawChecked(GetHorzChecked);
 except
 DrawChecked(GetHorzChecked);
 end;
 DrawButton(GetHorzButton1,(_ActDown=HorzButton1) and HorzBarVisible);
 DrawButton(GetHorzButton2,(_ActDown=HorzButton2) and HorzBarVisible);
 DrawButton(GetHorzBar,false);
 with GetHorzButton1 do
  DrawArrow2(Rect(Left+1,Top+1,Right-1,Bottom-1),Point(Left+(Right-Left-7) div 2,Top+(Bottom-Top-7) div 2),false,false,_ActDown=HorzButton1,not HorzBarVisible);
 with GetHorzButton2 do
  DrawArrow2(Rect(Left+1,Top+1,Right-1,Bottom-1),Point(Left+(Right-Left-7) div 2,Top+(Bottom-Top-7) div 2),false,true,_ActDown=HorzButton2,not HorzBarVisible);
 end;

 if IsVertScrollBarVisible and IsHorzScrollBarVisible then
 with GetVertWhole do Src.FillRect(Left,Bottom,Right,GetHorzWhole.Bottom,ScrollbarFaceColor);

end;


function TdhCustomPanel.GetHorzWhole:TRect;
begin
 with ScrollArea do
  result:=Rect(Left,Bottom,Right,Bottom+HorzScrollbar);
end;

function TdhCustomPanel.GetHorzButton1:TRect;
begin
 with GetHorzWhole do result:=Rect(Left,Top,GetHorzChecked.Left,Bottom);
end;

function TdhCustomPanel.GetHorzButton2:TRect;
begin
 with GetHorzWhole do result:=Rect(GetHorzChecked.Right,Top,Right,Bottom);
end;

function TdhCustomPanel.GetHorzChecked: TRect;
begin
 with GetHorzWhole do
 begin
  result:=Rect(Left+HorzScrollbarButtonWidth,Top,Right-HorzScrollbarButtonWidth,Bottom);
  if result.Right<result.Left then
  begin
   result.Right:=(Left+Right) div 2;
   result.Left:=result.Right;
  end;
 end;
end;

function TdhCustomPanel.HorzBarVisible:boolean;
begin
 result:=not((HorzScrollInfo.nMax=0) or (HorzScrollInfo.nPage>=HorzScrollInfo.nMax));
end;

procedure GetSlack(const ScrollInfo: TdhScrollInfo; Range,Pos:integer; var h,position:integer; inverse:boolean);
const min_h=11;
begin
 h:=Trunc(ScrollInfo.nPage/ScrollInfo.nMax*Range);
 if h<min_h then
 begin
  if min_h<Range then
   h:=min_h else
   h:=0;
 end;
 if not inverse then
  position:=Round(Pos/(ScrollInfo.nMax-ScrollInfo.nPage)*(Range-h)) else //(ScrollInfo.nMax-ScrollInfo.nPage)<>0 since ScrollInfo.nMax>ScrollInfo.nPage
  position:=Round(Pos*(ScrollInfo.nMax-ScrollInfo.nPage)/(Range-h));  //(Range-h)<>0 since h<Range since ScrollInfo.nPage<ScrollInfo.nMax
end;

function TdhCustomPanel.GetHorzBar:TRect;
var h,position:integer;
begin
 if not HorzBarVisible then
  Result:=Rect(0,0,0,0) else
 with GetHorzChecked do
 begin
 GetSlack(HorzScrollInfo,Right-Left,HPos,h,position,false);
 result:=Rect(Left+position,Top,Left+position+h,Bottom);
 IntersectRect(result,result,Rect(Left,Top,Right,Bottom));
 end;
end;

function TdhCustomPanel.ScrollEdgesPure:TRect;
begin
 result:=Rect(0,0,0,0);
 if IsVertScrollBarVisible then
 if Direction=cdiLTR then
  inc(result.Right,VertScrollbar) else
  inc(result.Left,VertScrollbar);
 if IsHorzScrollBarVisible then
  inc(result.Bottom,HorzScrollbar);
end;

function TdhCustomPanel.GetVertWhole:TRect;
begin
 with ScrollArea do
 if Direction=cdiLTR then
  result:=Rect(Right,Top,Right+VertScrollbar,Bottom) else
  result:=Rect(Left-VertScrollbar,Top,Left,Bottom);
end;

function TdhCustomPanel.GetVertButton1:TRect;
begin
 with GetVertWhole do result:=Rect(Left,Top,Right,GetVertChecked.Top);
end;

function TdhCustomPanel.GetVertButton2:TRect;
begin
 with GetVertChecked do result:=Rect(Left,Bottom,Right,GetVertWhole.Bottom);
end;

function TdhCustomPanel.GetVertChecked: TRect;
begin
 with GetVertWhole do
 begin
  result:=Rect(Left,Top+VertScrollbarButtonHeight,Right,Bottom-VertScrollbarButtonHeight);
  if result.Bottom<result.Top then
  begin
   result.Bottom:=(Top+Bottom) div 2;
   result.Top:=result.Bottom;
  end;
 end;
end;

function TdhCustomPanel.VertBarVisible:boolean;
begin
 result:=not((VertScrollInfo.nMax=0) or (VertScrollInfo.nPage>=VertScrollInfo.nMax));
end;

function TdhCustomPanel.GetVertBar:TRect;
var h,position:integer;
begin
 if not VertBarVisible then
  Result:=Rect(0,0,0,0) else
 with GetVertChecked do
 begin
 GetSlack(VertScrollInfo,Bottom-Top,VPos,h,position,false);
 result:=Rect(Left,Top+position,Right,Top+position+h);
 IntersectRect(result,result,Rect(Left,Top,Right,Bottom));
 end;
end;

procedure TdhCustomPanel.PaintHidden;
begin
   if not TopGraph.Empty then
   begin
    BeginPainting(TopGraph);
    try
     with GetCanvas do
     begin
      Font.Name:='Arial';
      Font.Size:=7;
      Font.Color:=clBlack;
      Font.Style:=[];
      Brush.Style:=bsClear;
      TextOut(0,0,'[hidden]');
     end;
    finally
     EndPainting;
    end;
   end;
end;

function TdhCustomPanel.AlwaysVisibleVisibility:boolean;
begin
 result:=false;
end;

function TdhCustomPanel.CanBeTopPC:boolean;
begin
 result:=false;
end;

{if NeedTransparentImage is true, then TransparentTopIsValid will be true after this method returns, thus TransparentTop will contain the current visual contents;
 if NeedOpaqueImage is true, then TopGraph will contain the current visual contents painted over a valid background
}
procedure TdhCustomPanel.AssertTop;
var SelfCBound:TRect;
    nWidth,nHeight:integer;
    PaintOnlyBg:boolean;
begin

 if PreferStyle<>nil then
  SelfCBound:=_SelfCBound else
  SelfCBound:=IncHeight(GetCBound(Self),addheight);
 nHeight:=SelfCBound.Bottom-SelfCBound.Top;
 nWidth:=SelfCBound.Right-SelfCBound.Left;
 if BackIsValid and ((BackGraph.Height<>nHeight) or (BackGraph.Width<>nWidth)) then
  BackIsValid:=false;
 if TopIsValid  and ((TopGraph.Height<>nHeight) or (TopGraph.Width<>nWidth)) then
  TopIsValid:=false;
 if TransparentTopIsValid and ((TransparentTop.Height<>nHeight) or (TransparentTop.Width<>nWidth)) then
  TransparentTopIsValid:=false;
 if BackIsValid and not TopIsValid and (BackGraph=TopGraph) then
  BackIsValid:=False;

 if NeedOpaqueImage and not BackIsValid and not Opaque then
 begin
   if BackGraph=nil then
    BackGraph:=TdhBitmap32.Create;
   BackGraph.SetSize(nWidth,nHeight);
   PaintOnlyBg:=glPaintOnlyBg;
   glPaintOnlyBg:=false;
   try
    ParentPaintTo(Self,Parent,true,SelfCBound,SelfCBound,addheight,GetZOrder(Self));
   finally
    glPaintOnlyBg:=PaintOnlyBg;
   end;
   BackIsValid:=true;

   if TopIsValid then
   if not TransparentTopIsValid then
   begin
    TopIsValid:=false;
   end else
   begin
    if BackIsValid and (BackGraph<>TopGraph) then
     BackGraph.DrawTo(TopGraph);
    TransparentTop.DrawTo(TopGraph);
   end;
 end;


 if NeedOpaqueImage and not TopIsValid then
 begin
  if TopGraph=nil then
  if BackGraph<>nil then
   TopGraph:=BackGraph else
   TopGraph:=TdhBitmap32.Create;

  TopGraph.SetSize(nWidth,nHeight);
  if BackIsValid and (BackGraph<>TopGraph) then
   BackGraph.DrawTo(TopGraph);
 end;

 if not TransparentTopIsValid then
   FreeAndNil(TransparentTop);

  if not Visibility and (not AlwaysVisibleVisibility or ((Parent is TdhCustomPanel) and not TdhCustomPanel(Parent).Visibility)) then
  begin
   if NeedOpaqueImage and not TopIsValid then
   begin
    if ((csDesigning in ComponentState) or IsDlg) and not ((Parent is TdhCustomPanel) and not TdhCustomPanel(Parent).Visibility) then
     PaintHidden;
    TopIsValid:=true;
   end;
   if NeedTransparentImage and not TransparentTopIsValid then
   begin
    TransparentTop:=TdhBitmap32.Create;
    TransparentTop.SetSize(nWidth,nHeight);
    TransparentTopIsValid:=true;
   end;
  end else
  if NeedTransparentImage and not TransparentTopIsValid or NeedOpaqueImage and not TopIsValid and IsRasterized then
  begin
   if not TransparentTopIsValid then
   begin
    TransparentTop:=TransPainting(nWidth,nHeight);
    TransparentTopIsValid:=true;
   end;
   if NeedOpaqueImage and not TopIsValid then
   begin
    TransparentTop.DrawTo(TopGraph);
    TopIsValid:=true;
   end;
  end else
 if NeedOpaqueImage and not TopIsValid then
 begin
  if not TopGraph.Empty then
  begin
   BeginPainting(TopGraph);
   try
    DoTopPainting;
   finally
    EndPainting;
   end;
  end;
  TopIsValid:=true;
 end;
end;

procedure TdhCustomPanel.BeginPainting(bmp:TdhBitmap32);
begin
   assert(ActTopGraph=nil);
   assert(not bmp.Empty);
   ActTopGraph:=bmp;
end;

procedure TdhCustomPanel.EndPainting;
begin
   assert(ActTopGraph<>nil);
   ActTopGraph:=nil;
end;

procedure TdhCustomPanel.DoTopPainting;
begin
 PaintBorder;
 PaintOuterBg;
 DrawFrame;
end;

{$IFNDEF CLX}
procedure CopyRect2(FHandle:HDC; const Dest: TRect; Canvas: TCanvas;
  const Source: TRect; CopyMode:TCopyMode=cmSrcCopy);
begin
   BitBlt(FHandle, Dest.Left, Dest.Top, Dest.Right - Dest.Left,
    Dest.Bottom - Dest.Top, Canvas.Handle, Source.Left, Source.Top,
    CopyMode);
end;
{$ENDIF}


function TdhCustomPanel.GetNotClipped(OnlyOneParent:boolean):TRect;
begin
    result:=_GetNotClipped(Self,OnlyOneParent);
end;

function _GetNotClipped(Self: TControl; OnlyOneParent:boolean):TRect;
var P:TWinControl;
begin
    Result:=GetCBound(Self);
    P:=Self.Parent;
    if OnlyOneParent then
    begin
     if P<>nil then
      IntersectRect(Result,Result,GetScreenClientBound(P));
    end else
    while P<>nil do
    begin
     IntersectRect(Result,Result,GetScreenClientBound(P));
     P:=P.Parent;
    end;
    with GetCBound(Self) do OffsetRect(Result,-Left,-Top);
end;

function TdhCustomPanel.GetNotClippedOne(DeltaX,DeltaY:integer):TRect;
begin
    Result:=TotalRect;
    if (Parent is TdhCustomPanel) then
    if TdhCustomPanel(Parent).IsScrollArea and TdhCustomPanel(Parent).NCScrollbars then
     IntersectRect(Result,Result,GetOffsetRect(TdhCustomPanel(Parent).ScrollArea,-Left-DeltaX,-Top-DeltaY));
end;

{$IFDEF CLX}

procedure TdhCustomPanel.Paint;
var R:TRect;
begin
 if Parent=nil then exit;
 AssertTop(0);
 if not TopGraph.Empty then
 begin
    TopGraph.DrawTo(Canvas.Handle,0,0);
 end;
end;

{$ELSE}

procedure TdhCustomPanel.PaintWindow(DC: HDC);
begin
 AssertTop(0);
 if not TopGraph.Empty then
 begin
  with ClientBound do CopyRect2(DC,Rect(0,0,Right-Left,Bottom-Top),TopGraph.Canvas,Rect(Left,Top,Right,Bottom));
 end;
end;

{$ENDIF}

function TdhCustomPanel.ClientBound:TRect;
begin
  if IsScrollArea and NCScrollbars then
   result:=ScrollArea else
   result:=TotalRect;
end;

function TdhCustomPanel.PhysicalClientBound:TRect;
begin
{$IFNDEF CLX}
  if IsScrollArea and NCScrollbars then
   result:=ScrollArea else
{$ENDIF}
   result:=TotalRect;
end;

function TdhCustomPanel.ScrollAreaWithScrollbars_Edges:TRect;
begin
 if IsScrollArea and EdgesInScrolledArea then
  result:=Rect(0,0,0,0) else
  result:=ClientEdgesPure;
end;

function TdhCustomPanel.PhysicalClientEdgesWithScrollbars:TRect;
begin
{$IFNDEF CLX}
  if IsScrollArea and NCScrollbars then
   result:=ScrollAreaWithScrollbars_Edges else
{$ENDIF}
   result:=Rect(0,0,0,0);
end;

function TdhCustomPanel.ScrollArea_Edges:TRect;
begin
 result:=GetAddRect(ScrollAreaWithScrollbars_Edges,ScrollEdgesPure);
end;
              
function TdhCustomPanel.DynamicTotalRect:TRect;
begin
 result:=TotalRect; 
 if ActTopGraph<>nil then
 begin
  dec(result.Right,Width-ActTopGraph.Width);
  dec(result.Bottom,Height-ActTopGraph.Height);
 end;
end;

function TdhCustomPanel.ScrollAreaWithScrollbars:TRect;
begin
 result:=ShrinkRect(DynamicTotalRect,ScrollAreaWithScrollbars_Edges);
end;

function TdhCustomPanel.ScrollArea:TRect;
begin
 result:=ShrinkRect(DynamicTotalRect,ScrollArea_Edges);
end;

{$IFDEF CLX}
procedure TdhCustomPanel.MouseEnter(AControl: TControl);
{$ELSE}
procedure TdhCustomPanel.CMMouseEnter(var Message: TMessage);
{$ENDIF}
begin
 UpdateMouse(true);
 inherited;
end;

{$IFDEF CLX}
procedure TdhCustomPanel.MouseLeave(AControl: TControl);
{$ELSE}
procedure TdhCustomPanel.CMMouseLeave(var Message: TMessage);
{$ENDIF}
begin
 UpdateMouse(false);
 inherited;
end;

{$IFDEF CLX}
procedure TdhCustomPanel.FontChanged;
{$ELSE}
procedure TdhCustomPanel.CMFontChanged(var Message: TMessage);
{$ENDIF}
begin            
{$IFNDEF SYNC_PROP}
 showmessage('FontChanged called');
{$ENDIF}
 FontHasChanged;
 inherited;
end;


{$IFDEF SYNC_PROP}

{$IFDEF CLX}
procedure TdhCustomPanel.ParentFontChanged;
{$ELSE}
procedure TdhCustomPanel.CMParentFontChanged(var Message: TMessage);
{$ENDIF}
begin
 ParentFontHasChanged;
end;

{$IFDEF CLX}
procedure TdhCustomPanel.ColorChanged;
{$ELSE}
procedure TdhCustomPanel.CMColorChanged(var Message: TMessage);
{$ENDIF}
begin
 if ParentColor then exit; //Delphi7 CLX: ColorChanged called in Loaded
 ColorHasChanged;
 Inherited;
end;

{$IFDEF CLX}
procedure TdhCustomPanel.CursorChanged;
{$ELSE}
procedure TdhCustomPanel.CMCursorChanged(var Message: TMessage);
{$ENDIF}
begin
 CursorHasChanged;
 Inherited;
end;


{$IFDEF CLX}
procedure TdhCustomPanel.ParentColorChanged;
{$ELSE}
procedure TdhCustomPanel.CMParentColorChanged(var Message: TMessage);
{$ENDIF}
begin
 ParentColorHasChanged;
end;

{$ENDIF}

class function TdhCustomPanel.IsValidIdent(const Ident: TComponentName): Boolean;
const
  Alpha = ['A'..'Z', 'a'..'z', '_'];
  AlphaNumeric = Alpha + ['0'..'9'];
var
  I: Integer;
begin
  Result := False;
  if (Length(Ident) = 0) or not CharInSet(Ident[1],['A'..'Z', 'a'..'z']) then Exit;
  for I := 2 to Length(Ident) do if not CharInSet(Ident[I],AlphaNumeric) then Exit;
  Result := True;
end;

procedure TdhCustomPanel.SetName(const Value: TComponentName);
begin
 if Name<>Value then
 begin
  if not (csDestroying in ComponentState) and (not IsValidIdent(Value)) then
   raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
  Inherited;
  if not (csDestroying in ComponentState) and not (csLoading in ComponentState) then
   NameChanged;
 end;
end;          

procedure TdhCustomPanel.TryBrokenReferences(sl:TStringList);
var AComponent:TComponent;
begin
 if (SUse<>EmptyStr) then
 if sl<>nil then
  sl.Add(SUse) else
 begin
  AComponent:=Owner.FindComponent(SUse);
  if AComponent is TdhCustomPanel then
   Use:=TdhCustomPanel(AComponent);
 end;
end;

procedure TdhCustomPanel.CopyDependencies(CopyList:TList);
begin
 if (Use<>nil) and (CopyList.IndexOf(Use.GetCommon)=-1) then
  CopyList.Add(Use.GetCommon);
end;
                          
{$IFDEF CLX}

function TdhCustomPanel.WidgetFlags: Integer;
begin
  Result := inherited WidgetFlags or Integer(WidgetFlags_WRepaintNoErase);
end;

procedure TdhCustomPanel.InitWidget;
const
  FocusPolicy: array[Boolean] of QWidgetFocusPolicy = (QWidgetFocusPolicy_ClickFocus, QWidgetFocusPolicy_NoFocus);
begin
 inherited;
 QWidget_setBackgroundMode(Handle, QWidgetBackgroundMode_NoBackground);
 QWidget_setFocusPolicy(Handle, QWidgetFocusPolicy_WheelFocus);
 Masked:=True;
end;

procedure TdhCustomPanel.DrawMask(Canvas: TCanvas);
var
  R,_NC: TRect;
  I,X,Y: Integer;
begin
  { Drawing with clDontMask will cause those areas to "show through", while
    clMask will cause them to be transparent. }

  Canvas.Brush.Style := bsSolid;
  if not DefDelta then
   NC:=GetNotClippedOne(0,0);
  _NC:=NC;

  IntersectRect(_NC,_NC,GetSmallestNonTransparentRect);

  if not EqualRect(_NC,TotalRect) then
  if not IsRectEmpty(TotalRect) then
  begin
   Canvas.Brush.Color := clMask;
   Canvas.FillRect(TotalRect);
  end;
  if IsRectEmpty(_NC) then exit;
  Canvas.Brush.Color := clDontMask;
  Canvas.FillRect(_NC);
  Canvas.Brush.Color := clDontMask;
  for I := 0 to ControlCount - 1 do
  begin
    R := TControl(Controls[I]).BoundsRect;
    IntersectRect(R,R,NC);
    Canvas.FillRect(R);
  end;
end;
                    
{$ENDIF}

procedure TdhCustomPanel.RequestAlign;
begin
  if Parent is TdhCustomPanel then TdhCustomPanel(Parent).MyRealign else
  if Parent <> nil then Parent.Realign;
end;

procedure TdhCustomPanel.MyRealign;
begin
  MyAlignControl(nil);
end;

procedure TdhCustomPanel.MyAlignControl(AControl: TControl);
var
  Rect: TRect;
begin
  //If we would check on HandleAllocated, not visible containers would not align there children! Thats the only reason for MyAlignControl.
  if {not HandleAllocated or }(csDestroying in ComponentState) then Exit;
{$IFNDEF CLX}
  if AlignDisabled then
    ControlState := ControlState + [csAlignmentNeeded]
  else
{$ENDIF}
  begin
    DisableAlign;
    try
      Rect := GetClientRect;
      AlignControls(AControl, Rect);
    finally
      ControlState := ControlState - [csAlignmentNeeded];
      EnableAlign;
    end;
  end;
end;

procedure TdhCustomPanel.WriteSUse(Writer: TWriter);
begin
 Writer.WriteString(SUse);
end;

procedure TdhCustomPanel.ReadSUse(Reader: TReader);
begin
 SUse:=Reader.ReadString;
end;

procedure DoCalcStrongToWeak(var ALeft,ATop,AWidth,AHeight:integer; const ClientBound:TRect; Anchors:TAnchors; const CSSRight,CSSBottom:integer);
var ParentWH:TPoint;
begin
 with ClientBound do
  ParentWH:=Point(Right-Left,Bottom-Top);

 if akBottom in Anchors then
 if [akTop,akBottom]*Anchors=[akTop,akBottom] then
  AHeight:=ParentWH.Y-(CSSBottom+ATop) else
  ATop:=ParentWH.Y-(CSSBottom+AHeight);

 if akRight in Anchors then
 if [akLeft,akRight]*Anchors=[akLeft,akRight] then
  AWidth:=ParentWH.X-(CSSRight+ALeft) else
  ALeft:=ParentWH.X-(CSSRight+AWidth);
end;

procedure TdhCustomPanel.CalcStrongToWeak(var ALeft,ATop,AWidth,AHeight:integer);
var i:integer;
begin
 AHeight:=Height;
 ATop:=Top;
 AWidth:=Width;
 ALeft:=Left;
 if CSSBottom=InvalidCSSPos then
 begin
  i:=CSSRight;
  WeakToStrong(true);
  CSSRight:=i;
 end;
 if CSSRight=InvalidCSSPos then
 begin
  i:=CSSBottom;
  WeakToStrong(true);
  CSSBottom:=i;
 end;
 DoCalcStrongToWeak(ALeft,ATop,AWidth,AHeight,GetLocalClientBound(Parent),Anchors,CSSRight,CSSBottom);
end;

procedure TdhCustomPanel.StrongToWeak; //equates UpdateAnchorRules
var ALeft,ATop,AWidth,AHeight:integer;
begin
 if LightBoundsChanging then exit;
 CalcStrongToWeak(ALeft,ATop,AWidth,AHeight);
 LightBoundsChanging:=true;
 SetBounds(ALeft,ATop,AWidth,AHeight);
 LightBoundsChanging:=false;
end;

function TdhCustomPanel.HasActiveStrong(TestAnchors:TAnchors):boolean;
begin
  result:=((Align=alNone) and (TestAnchors*Anchors<>[]));
end;

//assumes that that the normal BoundsRect has more current data than CSSRight or CSSBottom
procedure TdhCustomPanel.WeakToStrong(IncludeActiveStrong:boolean; ALeft, ATop, AWidth, AHeight:Integer);
var ParentWH:TPoint;
begin
 if LightBoundsChanging or (csReading in ComponentState) or (Parent=nil){ or not ((Align=alNone) and ([akBottom,akRight]*Anchors<>[]))} then exit;

 with GetLocalClientBound(Parent) do
  ParentWH:=Point(Right-Left,Bottom-Top);

 if IncludeActiveStrong or not (HasActiveStrong([akRight]){wichtig da z.b. Left nicht persistent war (-> =0), in StrongToWeak auch nicht geändert wurde (wegen HasActiveStrong dort) und nun Left mit undefiniertem Wert gelesen wird}) then
  CSSRight:=ParentWH.X-(ALeft+AWidth);

 if IncludeActiveStrong or not HasActiveStrong([akBottom]) then
  CSSBottom:=ParentWH.Y-(ATop+AHeight);
end;

procedure TdhCustomPanel.WeakToStrong(IncludeActiveStrong:boolean);
begin
  WeakToStrong(IncludeActiveStrong, Left, Top, Width, Height);
end;

procedure TdhCustomPanel.SetRight(const Value:integer);
begin         
 CSSRight:=Value;
 StrongToWeak;
end;

procedure TdhCustomPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Control: TControl;
begin
  for I := 0 to ControlCount - 1 do
  begin
    Control := Controls[I];
    if (Control.Owner = Root) and (GetVirtualParent(Control) = Self) then Proc(Control);
  end;
end;

function TdhCustomPanel.IsRightStored:boolean;
begin
 result:=akRight in RealAnchors;
end;

function TdhCustomPanel.IsLeftStored:boolean;
begin
 result:=akLeft in RealAnchors;
end;

procedure TdhCustomPanel.SetBottom(const Value:integer);
begin
 CSSBottom:=Value;
 StrongToWeak;
end;

function TdhCustomPanel.IsBottomStored:boolean;
begin
 result:=akBottom in RealAnchors;
end;

function TdhCustomPanel.IsTopStored:boolean;
begin
 result:=akTop in RealAnchors;
end;


function TdhCustomPanel.IsWidthStored:boolean;
begin
 result:=[akLeft,akRight]*RealAnchors<>[akLeft,akRight];
end;


function TdhCustomPanel.IsHeightStored:boolean;
begin
 result:=[akTop,akBottom]*RealAnchors<>[akTop,akBottom];
end;


function _RealAnchors(Anchors:TAnchors; img:boolean):TAnchors;
begin
 result:=Anchors;
 if img then
 begin
  if [akTop,akBottom]*result=[akTop,akBottom] then
   Exclude(result,akBottom);
  if [akLeft,akRight]*result=[akLeft,akRight] then
   Exclude(result,akRight);
 end;
end;

function TdhCustomPanel.RealAnchors:TAnchors;
begin
 result:=_RealAnchors(Anchors,GetImageType=bitImage);
end;

procedure TdhCustomPanel.DefineProperties(Filer: TFiler);
begin
 //inherited;           to not write ExlicitLeft etc. any longer
 Filer.DefineProperty('AutoSizeVerticalOnly', ReadAutoSizeVerticalOnly,nil, false);
 Filer.DefineProperty('AutoSize', ReadAutoSize,nil, false);
 Filer.DefineProperty('Center', SkipValue,nil, false);
 Filer.DefineProperty('SUse', ReadSUse, WriteSUse, SUse<>EmptyStr);
 Filer.DefineProperty('DesignSize', SkipValue, nil, false);
 Filer.DefineProperty('ExplicitLeft', SkipValue, nil, false);
 Filer.DefineProperty('ExplicitTop', SkipValue, nil, false);
 Filer.DefineProperty('ExplicitWidth', SkipValue, nil, false);
 Filer.DefineProperty('ExplicitHeight', SkipValue, nil, false);
 if Assigned(glOnDefineProperties) then
   glOnDefineProperties(Self);
end;

function TdhCustomPanel.GetStyle(Index:TState):TStyle;
begin
 result:=StyleArr[Index];
end;

procedure TdhCustomPanel.SetStyle(Index:TState; Value:TStyle);
begin
 StyleArr[Index]:=Value;
end;

procedure TdhCustomPanel.SetUse(Value:ICon);
var OldValue:ICon;
begin
  SUse:=EmptyStr;
  if FUse=Value then exit;
  if (Value<>nil) and (Self=Value.GetCommon) then
  begin
   ShowMessage('"'+Value.GetName+'" is not a valid value due to causing a circular reference');
   exit;
  end;
  if InUseList(Value,Self) then
  begin
   ShowMessage('"'+Value.GetName+'" is not a valid value due to causing a circular reference');
   exit;
  end;
  if FUse<>nil then
   FUse.GetCommon.UsedByList.Remove(Self);
  if Value<>nil then
   Value.GetCommon.UsedByList.Add(Self);
  OldValue:=FUse;
  FUse := Value;
  NotifyUseChanged(OldValue);
  NotifyCSSChanged(AllChanged);
end;

procedure TdhCustomPanel.NotifyUseChanged(OldValue:ICon);
begin
end;

{$IFNDEF CLX}
function TdhCustomPanel.DesignWndProc(var Message: TMessage): Boolean;
begin
 result:=false;
end;
{$ENDIF}

function TdhCustomPanel.DesignHitTest:boolean;
begin
 result:=RuntimeMode or (ActDown<>amNone) or CanUseMouseClick {and (Message.Msg >= WM_MOUSEMOVE) and (Message.Msg <= WM_MOUSEWHEEL){and ((Message.Msg = WM_LBUTTONUP) or (Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK) or (Message.Msg = WM_MOUSEMOVE))};
end;

{$IFDEF CLX}
function TdhCustomPanel.DesignEventQuery(Sender: QObjectH; Event: QEventH): Boolean;
begin
 result:=DesignHitTest;
end;
{$ELSE}
procedure TdhCustomPanel.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  Message.Result:=0;
  if RuntimeMode or (ActDown<>amNone) or CanUseMouseClick then
   Message.Result:=1;
end;
{$ENDIF}


function TdhCustomPanel.AcceptClick(P:TPoint):boolean;
begin
 if IsDlg then
 begin
  result:=true;
 end else
 if PreciseClick then
 begin
 if not Opaque then
 begin
  AssertTop(0,true,false);
  if AlphaComponent(TransparentTop.PixelS[P.X,P.Y]) = 0 then
  begin
   result:=false;
   exit;
  end;
 end;
 result:=true;
 end else
  result:=PtInRect(GetSmallestNonTransparentRect,P);
end;

function TdhCustomPanel.GetSmallestNonTransparentRect:TRect;
var tt:TTransformations;
begin
 if HasTransformations(tt) or IsScrollArea and EdgesInScrolledArea then
  result:=TotalRect else
  result:=MarginTotalRect;
end;

{$IFNDEF CLX}

procedure TdhCustomPanel.WMNCHitTest(var Message: TWMNCHitTest);
var P:TPoint;
begin
 P:=Point(Message.XPos,Message.YPos);
 DecPt(P,GetCBound(Self).TopLeft);
 if not ((P.X >= 0) and (P.Y >= 0) and (P.X < Width) and (P.Y < Height)) then
 begin // this case never happend by now!
  Message.Result := Windows.HTNOWHERE;
  exit;
 end;
 if (csDesigning in ComponentState) and (Parent <> nil) and not RuntimeMode then
 begin
  Message.Result := HTCLIENT;
  exit;
 end;
 if not AcceptClick(P) then
 begin
    Message.Result := Windows.HTTRANSPARENT;
    exit;
 end;
 Message.Result:=HTCLIENT;
end;

{$ELSE}

function TdhCustomPanel.HitTest(X, Y: Integer): Boolean;
begin
  Result := Inherited HitTest(X,Y) and AcceptClick(Point(X,Y));
end;

{$ENDIF}

function iControlAtPos(c:TWinControl; const pt: TPoint):TControl;
var i,ri:integer;
    cc:TControl;
    rct:TRect;
begin
 result:=nil;
 ri:=0;
 if (c is TForm) and (TForm(c).MDIChildCount<>0{needed by CLX}) then
 begin
 cc:=TForm(c).ActiveMDIChild;
 if (cc<>nil) and
    PtInRect(GetCBound(cc),pt) and FinalVisible(cc) and (cc.ClassName<>'TMySiz') and not ((csDesigning in c.ComponentState) and (c.Owner<>cc.Owner) and not (csAncestor in cc.ComponentState)) then
 begin
   result:=cc;
   ri:=-1;
 end else
 for i:=0 to TForm(c).MDIChildCount-1 do
 begin
 cc:=TForm(c).MDIChildren[i];
 rct:=GetCBound(cc);
 if PtInRect(rct,pt) and FinalVisible(cc) and (cc.ClassName<>'TMySiz') and not ((csDesigning in c.ComponentState) and (c.Owner<>cc.Owner) and not (csAncestor in cc.ComponentState)) then
 begin
   result:=cc;
   ri:=i-TForm(c).MDIChildCount;
   break;
 end;
 end;
 end;

 for i:=0 to c.ControlCount-1 do
 begin
 cc:=c.Controls[i];
 rct:=GetCBound(cc);
 if PtInRect(rct,pt) and FinalVisible(cc) and (cc.ClassName<>'TMySiz') and not ((csDesigning in c.ComponentState) and (c.Owner<>cc.Owner) and not (csAncestor in cc.ComponentState)) then
 if not((result<>nil) and (GetZOrder(result,ri)>GetZOrder(cc,i))) then
 begin
   result:=cc;
   ri:=i;
 end;
 end;

 if (result is TWinControl) and PtInRect(GetScreenClientBound(result),pt) then
  result:=iControlAtPos(TWinControl(result),pt{Point(pt.X-result.Left,pt.Y-result.Top)}) else
 if result=nil then
  result:=c;
end;

function rGetOffsetRect(R:TRect; P:TPoint):TRect;
begin
 result:=R;
 rOffsetRect(Result,P);
end;

function MyFindDragTarget(const Pos: TPoint; AllowDisabled: Boolean): TControl;
begin
 result:=FindDragTarget(Pos,AllowDisabled);
 if (result<>nil) and (result.ClassName='TMySiz') then
  result:=iControlAtPos(result.Parent,Pos);
end;

function GetVeryTop(c:TControl):TWinControl;
begin
 if c is TWinControl then
  result:=TWinControl(c) else
  result:=c.Parent;
 while result.Owner is TWinControl do
  result:=TWinControl(result.Owner);
end;

function MyFindControl(c:TControl): TControl;
begin
 result:=c;
 if result is TWinControl then
 if result.Owner is TWinControl then
  result:=iControlAtPos(GetVeryTop(result),Mouse.CursorPos) else
  result:=iControlAtPos(TWinControl(result),Mouse.CursorPos);
end;

function MyFindControl(Handle: HWnd): TControl;
begin
 result:=MyFindControl(FindControl(Handle));
end;

{$IFNDEF VER160}

function ConsumeMouseWheel(c:TControl; WheelDelta: Integer):boolean;
var fin,sm:integer;
    pc:TControl;

begin
   if not ((GetParentForm(c)<>nil) and (GetParentForm(c).ActiveControl is TComboBox){TComboBox(c).DroppedDown} {popup von ner ComboBox geht über BoundsRect hinaus}) then
   begin
   pc:=c;
   c := MyFindControl(c);
   if not((pc is TWinControl) and TWinControl(pc).ContainsControl(c)) then
   begin
    result:=false;
    exit;
   end;

  while c<>nil do
  begin
    if (c<>nil){ and (c.Parent=nil) }and (c is TScrollingWinControl) then
    begin
     sm:=-WheelDelta;
     fin:=min(max(0,TScrollingWinControl(c).VertScrollBar.Position+sm),TScrollingWinControl(c).VertScrollBar.Range);
     if TScrollingWinControl(c).VertScrollBar.Position<>fin then
     begin
      if c is TScrollingWinControl then
      begin
       (c as TScrollingWinControl).VertScrollBar.Position:=fin;
       c.Repaint;
      end;
      result:=true;
      exit;
     end;
    end;
    if (c<>nil) and (c is TdhCustomPanel) and TdhCustomPanel(c).IsVertScrollBarVisible then
    begin
     sm:=-WheelDelta;
     fin:=TdhCustomPanel(c).VertPosition;
     TdhCustomPanel(c).SetBoundedVPos(fin+sm);
     if TdhCustomPanel(c).VertPosition<>fin then
     begin
      result:=true;
      exit;
     end;
    end;
    c:=c.Parent;
   end;
  end;
  result:=false;
end;

function TdhCustomPanel.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; {$IFDEF CLX}const {$ENDIF}MousePos: TPoint): Boolean;
begin
 result:=ConsumeMouseWheel(Self,WheelDelta);
end;

function RectWidth(const R:TRect):Integer;
begin
 result:=R.Right-R.Left;
end;

procedure TdhCustomPanel.ScrollInView(AControl: TControl; ForceTop:boolean);
var
  Rect: TRect;
  ClientWidth,ClientHeight:integer;
begin
  if not IsScrollArea then exit;
  if AControl = nil then Exit;
  with ScrollArea do
  begin
   ClientWidth:=Right-Left;
   ClientHeight:=Bottom-Top;
  end;

  Rect := MakeRect(0,0,AControl.Width,AControl.Height);//AControl.ClientRect would be wrong
  Rect.TopLeft := ScreenToClient(AControl.ClientToScreen(Rect.TopLeft));
  Rect.BottomRight := ScreenToClient(AControl.ClientToScreen(Rect.BottomRight));
  if Rect.Left < 0 then
    HorzPosition := HorzPosition + Rect.Left
  else if Rect.Right > ClientWidth then
  begin
    if Rect.Right - Rect.Left > ClientWidth then
      Rect.Right := Rect.Left + ClientWidth;
    HorzPosition := HorzPosition + Rect.Right - ClientWidth;
  end;
  if ForceTop or (Rect.Top < 0) then
    VertPosition := VertPosition + Rect.Top
  else if Rect.Bottom > ClientHeight then
  begin
    if Rect.Bottom - Rect.Top > ClientHeight then
      Rect.Bottom := Rect.Top + ClientHeight;
    VertPosition := VertPosition + Rect.Bottom - ClientHeight;
  end;
end;

{$ENDIF}

procedure TdhCustomPanel.DoClickAction(Initiator:TdhCustomPanel);
begin
 //do nothing
end;

type TObjIdleProc=class
    procedure DoMouseIdle(Sender: TObject; var Done: Boolean);
end;

var OldOnIdle:TIdleEvent;
    ObjIdleProc:TObjIdleProc;

procedure TObjIdleProc.DoMouseIdle(Sender: TObject; var Done: Boolean);
var
  CaptureControl: TControl;
  P: TPoint;
  Result:TControl;
begin
  if Assigned(OldOnIdle) then OldOnIdle(Sender, Done);
  GetCursorPos(P);
  Result := MyFindDragTarget(P, True);
  CaptureControl := GetCaptureControl;
  if FMouseControl <> Result then
  begin
    if (Result<>nil) and not (csDesigning in Result.ComponentState) then exit;

    if ((FMouseControl <> nil) and (CaptureControl = nil)) or
      ((CaptureControl <> nil) and (FMouseControl = CaptureControl)) then
      if (FMouseControl is TdhCustomPanel) then TdhCustomPanel(FMouseControl).SetIsOver(false);
    if not (Result is TdhCustomPanel) then Result:=nil;

    FMouseControl := Result;
    if ((FMouseControl <> nil) and (CaptureControl = nil)) or
      ((CaptureControl <> nil) and (FMouseControl = CaptureControl)) then
      if (FMouseControl is TdhCustomPanel) then TdhCustomPanel(FMouseControl).SetIsOver(true);
  end;
end;

procedure TdhCustomPanel.AssignComputedEdge(Align:TEdgeAlign; Style: TStyle);
begin
  Style.SetMargin(Align,inttostr(MarginWidth(Align)));
  Style.SetPadding(Align,PaddingWidth(Align));
  AssignComputed(Style.Borders[Align],Align);
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.SetParent(AParent: TWinControl);
{$ELSE}
procedure TdhCustomPanel.SetParent(const AParent: TWidgetControl);
{$ENDIF}
begin
 if Parent <> AParent then
 begin
  inherited;
  if AParent<>nil then
  begin
   NotifyCSSChanged(InheritableChanges + [wcNoOwnCSS]);
  end;
 end;
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.CMRelease(var Message: TMessage);
begin
 Free;
end;
{$ENDIF}

procedure TdhCustomPanel.Release;
begin
{$IFDEF CLX}
  QApplication_postEvent(Application.Handle, QCustomEvent_create(QEventType_CMRelease, Self));
{$ELSE}
  PostMessage(Handle, CM_RELEASE, 0, 0);
{$ENDIF}
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.CMVisibleChanged(var Message: TMessage);
begin
 Inherited;
 VisibleChanged;
end;
{$ENDIF}

procedure TdhCustomPanel.VisibleChanged;
begin
 Inherited;
 if HandleAllocated then
  InvalBack;
end;

procedure TdhCustomPanel.ControlsListChanged(Control: TControl; Inserting: Boolean);
begin
 //nothing
end;

{$IFNDEF CLX}
{$IFDEF VER160}
procedure TdhCustomPanel.ControlChange(Inserting: Boolean; Child: TControl);
begin
  inherited;
  ControlsListChanged(Child,Inserting);
end;
{$ELSE}
procedure TdhCustomPanel.CMControlChange(var Message: TCMControlChange);
begin
  inherited;      
  ControlsListChanged(Message.Control,Message.Inserting);
end;
{$ENDIF}
{$ENDIF}

procedure TdhCustomPanel.SetASXY(const Value: TASXY);
begin
  FAutoSize := Value;
  AdjustSize;
end;

procedure TdhCustomPanel.SetImageType(const Value:TImageType);
begin
 if FImageType<>Value then
 begin
  FImageType:=Value;
  NotifyCSSChanged([wcSize,wcText]);
 end;
end;

procedure TdhCustomPanel.InvalidateFontSize;
begin
 FComputedFontSize:=InvalidFontSize;
end;

procedure TdhCustomPanel.SetZOrder(TopMost: Boolean);
begin
  inherited;
  NotifyCSSChanged([wcZIndex,wcNoOwnCSS]);
end;

procedure TdhCustomPanel.SaveAsImage(const FileName: TPathName; WithBackground:boolean);
begin
 AssertTop(0,not WithBackground);
 if WithBackground then
  SaveBmp32(TopGraph,TopGraph,FileName) else
  SaveBmp32(TransparentTop,TopGraph,FileName);
end;

function TdhCustomPanel.GetBold: boolean;
begin
 result:=GetVal(pcFontWeight) and (Cascaded.FontWeight in [cfwBold,cfwBolder,cfw600,cfw700,cfw800,cfw900]);
end;

procedure TdhCustomPanel.SetBold(const Value: boolean);
begin
 if Bold<>Value then
 begin
  ActStyle.FontWeight:=cfwInherit;
  if Bold<>Value then
   ActStyle.FontWeight:=GetBoldFontWeight[Value];
 end;
end;

function TdhCustomPanel.GetItalic: boolean;
begin
 result:=GetVal(pcFontStyle) and (Cascaded.FontStyle in [cfsItalic,cfsOblique]);
end;

procedure TdhCustomPanel.SetItalic(const Value: boolean);
begin
 if Italic<>Value then
 begin
  ActStyle.FontStyle:=cfsInherit;
  if Italic<>Value then
   ActStyle.FontStyle:=GetItalicFontStyle[Value];
 end;
end;

function TdhCustomPanel.TextDecoration:TCSSTextDecorations;
begin
 Cascaded.TopTextDecoration:=[];
 Cascaded.TextDecoration:=[ctdUnderline,ctdOverline,ctdLineThrough,ctdBlink];//need not be initialized..
 GetVal(pcTextDecoration);
 result:=Cascaded.TextDecoration;
end;

function TdhCustomPanel.SetTextDecoration(WantUnderline,WantLineThrough,WantOverline,WantBlink:boolean):boolean;
var OriTextDecoration,NewTextDecoration:TCSSTextDecorations;

procedure DoInclude;
begin
 if WantUnderline>Underline then
  include(ActStyle.FTextDecoration,ctdUnderline);
 if WantOverline>Overline then
  include(ActStyle.FTextDecoration,ctdOverline);
 if WantLineThrough>LineThrough then
  include(ActStyle.FTextDecoration,ctdLineThrough);
 if WantBlink>Blink then
  include(ActStyle.FTextDecoration,ctdBlink);
end;

begin
 OriTextDecoration:=ActStyle.FTextDecoration;
 try

 ActStyle.FTextDecoration:=[];
 DoInclude;
 if ActStyle.FTextDecoration<>[] then //if not empty, some former inherited flags must be included
  DoInclude;

 result:=(WantUnderline=Underline) and (WantOverline=Overline) and (WantLineThrough=LineThrough) and (WantBlink=Blink);

 if result then exit;

 if ActStyle.FTextDecoration<>[] then exit; //wanted styles cannot be deleted

 //now, we want to delete some styles, which were inherited;
 ActStyle.FTextDecoration:=[ctdNone];

 DoInclude;

 if ActStyle.FTextDecoration<>[ctdNone] then
  ActStyle.FTextDecoration:=ActStyle.FTextDecoration-[ctdNone];

 result:=(WantUnderline=Underline) and (WantOverline=Overline) and (WantLineThrough=LineThrough) and (WantBlink=Blink);

 finally
  if ActStyle.FTextDecoration<>OriTextDecoration then
  begin
   NewTextDecoration:=ActStyle.FTextDecoration;
   ActStyle.FTextDecoration:=OriTextDecoration;
   ActStyle.TextDecoration:=NewTextDecoration;
  end;
 end;
end;


function TdhCustomPanel.GetUnderline: boolean;
begin
 result:=ctdUnderline in TextDecoration;
end;

procedure TdhCustomPanel.SetUnderline(const Value: boolean);
begin
 if Underline<>Value then
  SetTextDecoration(Value,LineThrough,Overline,Blink);
end;

function TdhCustomPanel.GetLineThrough: boolean;
begin
 result:=ctdLineThrough in TextDecoration;
end;

procedure TdhCustomPanel.SetLineThrough(const Value: boolean);
begin  
 if LineThrough<>Value then
  SetTextDecoration(Underline,Value,Overline,Blink);
end;

function TdhCustomPanel.GetOverline: boolean;
begin
 result:=ctdOverline in TextDecoration;
end;

procedure TdhCustomPanel.SetOverline(const Value: boolean);
begin
 if Overline<>Value then
  SetTextDecoration(Underline,LineThrough,Value,Blink);
end;

function TdhCustomPanel.GetBlink: boolean;
begin
 result:=ctdBlink in TextDecoration;
end;

procedure TdhCustomPanel.SetBlink(const Value: boolean);
begin
 if Blink<>Value then
  SetTextDecoration(Underline,LineThrough,Overline,Value);
end;           

procedure TdhCustomPanel.SetFontColor(Value: TCSSColor);
begin
 if FontColor<>Value then
 begin
  ActStyle.Color:=colInherit;
  if FontColor<>Value then
   ActStyle.Color:=Value;
 end;
end;

function TdhCustomPanel.GetNearestFontFamily: TCSSFontFamily;
begin
 if GetVal(pcFontFamily) then
  result:=GetNearestFont(Cascaded.FontFamily) else
  result:=EmptyStr;
end;

function TdhCustomPanel.GetWidestFontFamily: TCSSFontFamily;
begin
 if GetVal(pcFontFamily) then
  result:=Cascaded.FontFamily else
  result:=EmptyStr;
end;

procedure TdhCustomPanel.SetFontFamily(const Value: TCSSFontFamily);
begin
 if NearestFontFamily<>GetNearestFont(Value) then
 begin
  ActStyle.FontFamily:=EmptyStr;
  if NearestFontFamily<>GetNearestFont(Value) then
   ActStyle.FontFamily:=Value;
 end;
end;

procedure TdhCustomPanel.SetFontSize(const Value: TCSSFontSize);
begin
 if FontSize<>Value then
 begin
  ActStyle.FontSize:=EmptyStr;
  if FontSize<>Value then
   ActStyle.FontSize:=Value;
 end;
end;

function TdhCustomPanel.GetFontSize: TCSSFontSize;
begin
 if GetVal(pcFontSize) then
  result:=Cascaded.FontSize else
  result:=DefaultNoncomputedFontSize;
end;

function TdhCustomPanel.EffectsAllowed: boolean;
begin
 result:=true;
end;

function TdhCustomPanel.MyGetControlExtents(OnlyForScrollbars:boolean): TPoint;
var
  I,_Right,_Bottom: Integer;
  IncrPt:TPoint;
  c:TControl;
begin

 Result:=Point(0,0);

 IncPt(Result,HPos,VPos);

 IncPt(Result,PhysicalClientEdgesWithScrollbars.TopLeft);
 with ScrollAreaWithScrollbars_Edges do
  IncPt(Result,Right,Bottom);

 IncrPt:=Result;

  for I := 0 to ControlCount - 1 do
  begin
  c:=Controls[I];
  if FinalVisible(c) then
  if OnlyForScrollbars then
  begin
      if not (c.Align in [alBottom,alRight,alClient]) then
      begin

        if c.Align<>alTop then
        if (akRight in c.Anchors) and (TdhCustomPanel(c).CSSRight<>InvalidCSSPos) then
        begin
         if (c is TdhCustomPanel) and (TdhCustomPanel(c).CSSRight-HPos<0) then
          Result.X:=MaxInt;
        end else
        begin
         _Right:=c.Left + c.Width + IncrPt.X;
         if _Right > Result.X then Result.X := _Right;
        end;

        if c.Align<>alLeft then
        if (akBottom in c.Anchors) and (TdhCustomPanel(c).CSSBottom<>InvalidCSSPos) then
        begin
         if (c is TdhCustomPanel) and (TdhCustomPanel(c).CSSBottom-VPos<0) then
          Result.Y:=MaxInt;
        end else
        begin
         _Bottom:=c.Top + c.Height + IncrPt.Y;
         if _Bottom > Result.Y then Result.Y := _Bottom;
        end;

      end;
  end else
  begin
   _Right:=c.Left + c.Width + IncrPt.X;
   _Bottom:=c.Top + c.Height + IncrPt.Y;
   if _Right > Result.X then Result.X := _Right;
   if _Bottom > Result.Y then Result.Y := _Bottom;
  end;
  end;
end;

procedure TdhCustomPanel.SetIsScrollArea(const Value: boolean);
begin
 if FIsScrollArea<>Value then
 begin
  FIsScrollArea := Value;
  ScrollingParametersChanged;
 end;
end;

procedure TdhCustomPanel.ScrollingParametersChanged;
begin
  if not FIsScrollArea then
  begin
   IsVertScrollBarVisible:=False;
   IsHorzScrollBarVisible:=False;
   SetVHPos(0,0);
  end;
  NotifyCSSChanged([wcSize,wcText2,wcNoOwnCSS]);
end;

procedure TdhCustomPanel.SetVPos(Value: Integer);
begin
 SetVHPos(HPos,Value);
end;

procedure TdhCustomPanel.SetHPos(Value: Integer);
begin
 SetVHPos(Value,VPos);
end;
        
procedure TdhCustomPanel.SetBoundedVHPos(H,V:integer);
begin
  SetVHPos(H,V);
end;

procedure TdhCustomPanel.SetBoundedVPos(p: Integer);
begin
 SetVHPos(HPos,p);
end;

procedure TdhCustomPanel.SetBoundedHPos(p: Integer);
begin
 SetVHPos(p,VPos);
end;

procedure TdhCustomPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 inherited;
 ProcessFrameEvent(feMouseMove);

 if DragEnabled and (csLButtonDown in ControlState) then
 with Mouse.CursorPos do
 if (Abs(MyDragStartPos.X - X) >= MyDragThreshold) or
    (Abs(MyDragStartPos.Y - Y) >= MyDragThreshold) then
 begin
  ControlState:=ControlState-[csClicked];
  BeginDrag(true);
 end;
end;

var MouseTimer:TTimer;

procedure TdhCustomPanel.ProcessFrameEvent(FrameEventType:TFrameEventType);
var NeedPaint:boolean;
var h,position:integer;
begin
 NeedPaint:=ActDown<>amNone;
 case FrameEventType of
 feMouseDown:
 begin
   if ActDown=amNone then
   begin
    ActDown:=GetActDown;
    if ActDown<>amNone then
    begin
     self.MouseCapture:=true;
     FDragOffset:=Mouse.CursorPos;
     DragVPos:=VPos;
     DragHPos:=HPos;
     MouseTimer:=TTimer.Create(Self{Application.MainForm});
     MouseTimer.OnTimer:=OnMouseTimer;
     MouseTimer.Interval:=200;
    end;
   end;
   if ActDown=GetActDown then
   case ActDown of
   VertButton1: SetBoundedVPos(VPos - VertScrollInfo.nPage div 10);
   VertButton2: SetBoundedVPos(VPos + VertScrollInfo.nPage div 10);
   VertChecked1: if not IsRectEmpty(GetVertBar) then SetBoundedVPos(VPos- VertScrollInfo.nPage);
   VertChecked2: if not IsRectEmpty(GetVertBar) then SetBoundedVPos(VPos+ VertScrollInfo.nPage);
   HorzButton1: SetBoundedHPos(HPos - HorzScrollInfo.nPage div 10);
   HorzButton2: SetBoundedHPos(HPos + HorzScrollInfo.nPage div 10);
   HorzChecked1: if not IsRectEmpty(GetHorzBar) then SetBoundedHPos(HPos- HorzScrollInfo.nPage);
   HorzChecked2: if not IsRectEmpty(GetHorzBar) then SetBoundedHPos(HPos+ HorzScrollInfo.nPage);
   end;
 end;
 feMouseMove:
 begin
   if (ActDown<>amNone) then
   if not Self.MouseCapture then
    ProcessFrameEvent(feMouseUp);
   case ActDown of
   VertBar:
   if VertBarVisible then
   begin
    with GetVertChecked do GetSlack(VertScrollInfo,Bottom-Top,Mouse.CursorPos.Y-FDragOffset.Y,h,position,true);
    SetBoundedVPos(DragVPos + position);
   end;
   HorzBar:
   if HorzBarVisible then
   begin
    with GetHorzChecked do GetSlack(HorzScrollInfo,Right-Left,Mouse.CursorPos.X-FDragOffset.X,h,position,true);
    SetBoundedHPos(DragHPos + position);
   end;
   end;
 end;
 feMouseUp:
 if ActDown<>amNone then
 begin
  Self.MouseCapture:=false;
  ActDown:=amNone;
  FreeAndNil(MouseTimer);
 end;
 end;
 if NeedPaint or (ActDown<>amNone) then
  ScrollPaintChanged
end;

procedure TdhCustomPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin               
  inherited;
  if Button=mbLeft then
  begin
   UpdateMousePressed(false,DownIfDown);
   ProcessFrameEvent(feMouseUp);
  end;
end;

procedure TdhCustomPanel._SetUniqueName(const s:TComponentName);
begin
 Self.Name:=_GetUniqueName(Self,s);
end;

class function TdhCustomPanel._GetUniqueName(_Self:TComponent; const s:TComponentName):TComponentName;
var i:integer;
    NewName:TComponentName;
    sl:TStringList;
begin
 sl:=TStringList.Create;
 try
 with _Self.Owner do
 for i:=0 to ComponentCount-1 do
 if Components[i] is TdhCustomPanel then
  TdhCustomPanel(Components[i]).TryBrokenReferences(sl);
 sl.CaseSensitive:=false;
 with _Self do
 For i := 1 to High(Integer) do
 begin
  NewName:=s+inttostr(i);
  if (Owner.FindComponent(NewName)=nil) and (sl.IndexOf(NewName)=-1) then
  begin
   result:=NewName;
   exit;
  end;
 end;
 finally
  sl.Free;
 end;
end;

procedure TdhCustomPanel.OnMouseTimer(Sender:TObject);
begin
 MouseTimer.Interval:=30;
 ProcessFrameEvent(feMouseDown);
end;

procedure TdhCustomPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 inherited;
 if Button=mbLeft then
 begin
  UpdateMousePressed(true,DownIfDown);
  ProcessFrameEvent(feMouseDown);
 end;
 if DragEnabled then
  MyDragStartPos:=Mouse.CursorPos;
end;

function TdhCustomPanel.CanUseMouseClick:boolean;
begin
 result:=(GetActDown<>amNone);
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.WMNCCalcSize(var Message: TWMNCCalcSize);
var R:TRect;
begin
  inherited;
  if IsScrollArea and NCScrollbars then
  begin
   R:=ScrollArea;
   RectAddSub(Message.CalcSize_Params.rgrc[0],R,TotalRect);
  end;
end;
{$ENDIF}

{$IFDEF CLX}
function TdhCustomPanel.ViewportRect: TRect;
begin
  if IsScrollArea and NCScrollbars then
   result:=ScrollArea else
   result:=Bounds(0,0,Width,Height);
end;
{$ENDIF}
                         
function TdhCustomPanel.GetOpaquePainting(var TopGraph:TdhBitmap32):boolean;
begin
  AssertTop(0);
  result:=not Self.TopGraph.Empty;
  if result then
   TopGraph:=Self.TopGraph;
end;

function TdhCustomPanel.TotalRect:TRect;
begin
 result:=Rect(0,0,Width,Height);
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.WMNCPaint(var Message: TMessage);
var DC: HDC;
    RC:TRect;
begin
 if IsScrollArea and NCScrollbars then
 begin
  DC := GetWindowDC(Handle);
  RC:=ScrollArea;
  ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
  AssertTop(0);
  if not TopGraph.Empty then
  begin
   CopyRect2(DC,TotalRect,TopGraph.Canvas,TotalRect);
  end;
  ReleaseDC(Handle, DC);
 end;
end;
{$ENDIF}

procedure TdhCustomPanel.SetEdgesInScrolledArea(const Value: boolean);
begin
  FEdgesInScrolledArea := Value;
  BorderChanged;
end;

function TdhCustomPanel.GetAnchors: TAnchors;
begin
 result:=inherited Anchors;
end;

function TdhCustomPanel.IsAnchorsStored: Boolean;
begin
  Result := Anchors <> AnchorAlign[Align];
end;

function TdhCustomPanel.GetPreferDownStyles:boolean;
begin
 result:=false; // prevent compiler warning
end;

function TdhCustomPanel.Direction: TCSSDirection;
begin
 if GetVal(pcDirection) then
  result:=Cascaded.Direction else
  result:=cdiLTR;
end;

procedure TdhCustomPanel.ProcessMouseMove(StateChanged:boolean);
begin
end;

function TdhCustomPanel.GetSpecialBorderType:TSpecialBorderType;
var Con:ICon;
    s:TComponentName;
begin
 result:=sbtNormal;
 Con:=Referer.GetFinal;
 if Con=nil then exit;
 s:=Con.GetName;
 if (s='button') or (s='filebutton')  then
  result:=sbtButton else
 if (s='edit') or (s='memo') or (s='listbox')  then
  result:=sbtEdit;
end;

function TdhCustomPanel.HorizontalCenter:boolean;
begin
  result:=Anchors*[akLeft,akRight]=[];
end;

function TdhCustomPanel.VerticalCenter:boolean;
begin
  result:=Anchors*[akTop,akBottom]=[];
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.WMPaint(var Message: TWMPaint);
begin
  ControlState:=ControlState+[csCustomPaint];
  inherited;
  ControlState:=ControlState-[csCustomPaint];
end;
{$ENDIF}

function TdhCustomPanel.RequiresRastering: boolean;
begin
 result:=false;
end;

procedure TdhCustomPanel.SetIsDlg(Value:Boolean);
begin
 FIsDlg:=Value;
end;

{$IFDEF CLX}
procedure TdhCustomPanel.ScrollBy(DeltaX, DeltaY: Integer);
var
  IsVisible: Boolean;
begin
  CheckChildrenNC(DeltaX, DeltaY);
  IsVisible := Visible and HandleAllocated;
  if IsVisible then
    QWidget_scroll(Handle, DeltaX, DeltaY);
  ScrollControls(DeltaX, DeltaY, IsVisible);
end;

{$ENDIF}

initialization

 glIsDesignerSelected:=CustomIsDesignerSelected;
 if Application<>nil then
 begin
 OldOnIdle:=Application.OnIdle;
 ObjIdleProc:=TObjIdleProc.Create;
 Application.OnIdle:=ObjIdleProc.DoMouseIdle;
 end;

// inttohex((GetBlendMemEx(i+{ $FF0000FF}$80008A84,$FFFFFFFF,{255 shl 16 div 255 + 1}255)),8);

finalization
 if ObjIdleProc<>nil then
 begin
 Application.OnIdle:=OldOnIdle;
 ObjIdleProc.Free;
 end;

{$IFDEF CLX }
 Screen.Fonts.Free;  // MemProof shows that it is not freed
{$ENDIF}
end.
