unit dhLabel;

interface

{$IFDEF VER160}
{$UNSAFECODE ON}
{$ENDIF}

uses
  {TNTWideStrUtils,}UseFastStrings,
  {$IFDEF CLX}
  QControls, Qt, QGraphics, QForms,
  {$ELSE}
  Controls, Windows, Messages, Graphics, Forms,
  {$ENDIF}
  SysUtils, Classes, dhPanel, math, {$IFNDEF VER130}types,  {$ENDIF} BinList,GR32_Transforms,gr32,StrUtils;


{$IFDEF VER160}
{$UNSAFECODE ON}
{$ENDIF}
               
{$IFDEF VER130}
type TIntegerDynArray=array of integer;
{$ENDIF}

function inttoalpha(i:integer):string;

type
  TFormButtonType=(fbNone,fbSubmit,fbReset);

type
 TdhCustomLabel=class;
 TStyleTree=class(TList)
  private
    starttag,endtag:integer;
    IsWholeStyle:boolean;
    TagName:String;
    ParentStyle:TStyleTree;
    StyleElement:ICon;
    vn,bs,toleft,toright,lmin,lmax,ry,LastBlockLine:integer;
    ContentHeight,Baseline,TopLeading,LineHeight,VerticalAlign:integer;
    RefStyleTree:TStyleTree;
    Owner:TdhCustomLabel;
    offs:TRect;

    //Prefetch:
    WhiteSpace:TCSSWhiteSpace; {PutNew}
    IsImg:boolean; {PutNew}
    AllEdgesPure:TRect;
    PaddingRect:TRect;
    FontSize:single;
    Blocking:boolean;
    IsBut:boolean;
    img_width:integer;

    procedure Clear; override;
    destructor Destroy; override;             
    function GetBottomLeading: integer;
    function HasVerticalAlign: boolean;
    property BottomLeading:integer read GetBottomLeading;
 end;
// TInlineElement=record {LsTree:array of TTreeItem; }StyleTree:TStyleTree; vn,bs:integer; {Breaking,HasStart,HasEnd:boolean;} end;
// PInlineElement=^TInlineElement;
// TStyleList=array of TInlineElement;
// PStyleList=^TStyleList;
 TLineInfo=record RealOffsX,y:integer; offs:TRect; OffsX,lineavail,lmin,maxHeight,LineWidth,vn,bs:integer; {StyleList:TStyleList;} AllTrees{,lmin,lmax}:TList; InlineBreak:boolean; endat:integer; end;
 PLineInfo=^TLineInfo;

{.$DEFINE GC,k}
//define GC to derive TdhLabel from TGraphicControl
//Problems: ZIndex not works, mouse-cursor problems, flicker


//  TdhLabel = class(TGraphicControl,ICon)
  TTrackChar=array of record vn,bs:integer; end;

  TdhCustomLabel = class(TdhCustomPanel,ICon)
  private
    Lines:array of TLineInfo;
    TopStyleTree:TStyleTree;
    UseStyleTree,sUseStyleTree:TStyleTree;
    Ptree:array of TStyleTree;
    gltext:WideString;

    P,Pall,Ppre,Psuc:TIntegerDynArray;
    avail,availY,TotalHeight,MaxWidth:integer;
    ClientStyleTree_starttag:array of integer;
    //ClientChar:integer;
    procedure ReadOldCaption(Reader: TReader);
    procedure InvalInline;
    procedure CalcCharWidths;
    procedure CalcLineBreaks;
    function CalcVertOffset(StyleTree:TStyleTree):TPoint;
    procedure Prefetch(StyleTree:TStyleTree);
    procedure CalcMinMax;
    procedure DistributeWidth;
    procedure FillAllTrees;
    function OneFormattedChar(StyleTree: TStyleTree; ActLine:PLineInfo): boolean;
    procedure PaintListItem(Canvas:TCanvas; const brct:TRect);
    procedure CalcCharHeights(StyleTree:TStyleTree; Canvas:TCanvas);
    procedure CalcVertOffsetAccumulate(StyleTree, RefStyleTree: TStyleTree);

  protected
    FHTMLText:HypeString;
    //IsAdjustBounds,MeasureOverflow:boolean;

    function PreventFull(Cause:TTransformations):boolean; override;

    function AllowAutoSizeY:boolean; override;

    function TextExtent(const Text: string): TSize;

    function GetOverChar:integer;

    function MyGetControlExtents(OnlyForScrollbars:boolean): TPoint; override;

    //tocopy

    function DoGetVal(PropChoose:TPropChoose; const Align:TEdgeAlign; var DoExit:boolean):boolean; override;
    function GetComputedFontSize:single; override;
    function Referer:TdhCustomPanel; override;
    //function TotalInlineBox: boolean; override;
    //function GetSpecialBorderType:TSpecialBorderType; override;
    //function GetImageType:TImageType; override;

    function WrapAlways: boolean; virtual;
    procedure GetModifiedText(var pre,s,suc:HypeString); virtual;
    function DelegateClick:boolean;
    procedure DoStateTransition(OldState:TState); override;
//    function TransitionInvalidates: boolean; override;
    function EmptyContent:boolean;
    procedure DoTopPainting; override;
{$IFNDEF CLX}
    procedure WndProc(var Message:TMessage); override;
{$ENDIF}

    procedure Loaded; override;
//    procedure ReadString(Reader: TReader);
//    procedure ReadBool(Reader: TReader);
//    procedure ReadInt(Reader: TReader);
    procedure WriteFalse(Writer: TWriter);
    procedure WriteTrue(Writer: TWriter);

    procedure ControlsListChanged(Control: TControl; Inserting: Boolean); override;

    (*
{$IFDEF CLX}
    procedure TextChanged; override;
{$ELSE}
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
{$ENDIF}*)

    function GetActCursor:TCursor;

{$IFNDEF CLX}
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
{$ENDIF}
    //procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;


    //function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;

    procedure WriteState(Writer: TWriter); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;


    //ICon
    procedure DoCSSToWinControl(WhatChanged:TWhatChanged); override;
    procedure UpdateNames(InlineUse,NewInlineUse:ICon; PropagateChange:boolean); override;
    function GetAutoRectPoint(AllowModifyX,AllowModifyY:boolean; NewWidth, NewHeight: Integer):TPoint;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    procedure GetInnerAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
    //procedure PreferStyleChange; override;
    procedure FocusPreferStyle(IsMain,RealChange:boolean); override;
    function GetHTMLState:TState; override;


    //procedure SetMyAutoSize(Value: Boolean); // override;
    procedure ReadCaption(Reader: TReader);
    procedure PaintCaption;
    procedure DoDrawText(var ConstraintsRect: TRect; CalcRect:boolean); virtual;
    procedure SetHTMLText(const Value:HypeString); virtual;
    function AddP(vn, bs: integer): integer;
    procedure BuildLines;
    procedure FreeLines;
    //function ClientSelControl: TControl;

    function FocContainer(ActLine:PLineInfo; ti:integer; var rct,brct:TRect; AvailY:integer):boolean; //{$IFDEF VER160}unsafe;{$ENDIF}
    function FindChildContent(ActLine:PLineInfo; _StyleTree:TStyleTree):TPoint;

    function TextTransform:TCSSTextTransform;
    function WhiteSpace:TCSSWhiteSpace;
    function ListStyleType:TCSSListStyleType;
    function TextAlign:TCSSTextAlign;
    function TextIndent:integer;
    function AntiAliasing:boolean;
    function TextOnly:boolean; override;
    function TextExclude:boolean; override;
    function CustomSizesForEffects:boolean; override;
    function CenterVertical:boolean; virtual;
    function ForceJustify:boolean; virtual;

    function SomethingIsScrolled: boolean; override;

    procedure ProcessMouseMove(StateChanged:boolean); override;
    function NeedPadding(HasRastering:TRasterType): boolean; override;


{$IFNDEF CLX}
    procedure CreateHandle; override;
{$ENDIF}


  public
    TrackChar:TTrackChar;

    //property Caption:boolean read FCaptionBoolean write FCaptionBoolean;
    procedure TryBrokenReferences(sl:TStringList); override;
    procedure CopyDependencies(CopyList:TList); override;

    function RenderedText:WideString;

    function FinalShowing:boolean; override;

    function CharPos:integer;
    function ClientAnchor:TdhCustomPanel;
    function ClientStyleTree:TStyleTree;
    //function IsOverflow:boolean;
    procedure Click; override;
    procedure ParseHTML;
    procedure RenameNames;
    procedure AssureRenamingAware(HasChanges:boolean);
    //procedure Paint;// override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //property Canvas;
    end;

  TdhLabel=class(TdhCustomLabel)
  protected
    procedure SetName(const Value: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    function AllHTMLCode:HypeString; override;
  published

      //property AutoSize write SetMyAutoSize nodefault;//default true;
    //property Caption:TCaption write SetHTMLText stored false;
    //property Center;
    property NoSiblingsBackground;
    property Text:HypeString read FHTMLText write SetHTMLText;
    property OnStateTransition;
//    property TabOrder stored false;



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
    property Cursor;
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
{
  TdhRule=class(TdhCustomLabel)
  protected
    FSuitableFor:TDesignedFor;
    FSuitableForLevel:cardinal;
    FOverBasedOnDown,FSharingEnabled:boolean;

    //ICon
    function GetOverBasedOnDown:boolean; override;
    procedure SetOverBasedOnDown(Value:boolean);
    function GetSharingEnabled: boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OverBasedOnDown:boolean read GetOverBasedOnDown write SetOverBasedOnDown default false;
    property DesignedFor:TDesignedFor read FSuitableFor write FSuitableFor default dfAnything;
    property DesignedForLevel:cardinal read FSuitableForLevel write FSuitableForLevel default 0;
//    property BaseDownOnOverDown;
    property SharingEnabled:boolean read GetSharingEnabled write FSharingEnabled default false;
    property StyleDown:TStyle index hsDown read GetStyle write SetStyle;
    property StyleOver:TStyle index hsOver read GetStyle write SetStyle;
    property StyleOverDown:TStyle index hsOverDown read GetStyle write SetStyle;
  end;

}
function getTag2(const s:HypeString; var vn,itag,itagbs:integer; var tag:String; var text:HypeString; var Closing,EmptyEle:boolean):boolean;
function WithoutComments(const s:HypeString; repl:HypeChar):HypeString;



function ConvertWideStringToUnicode(const s:WideString; NoTrivial:boolean):WideString; overload;
function ConvertUnicodeToWideString_(const s:WideString):WideString;
//function ConvertWideStringToUnicode_(const w:WideString):String; overload;
function LE127(const s:WideString):string;
function XMLconformant(const s:String):string;
function HypeSubstText(const Substr,durch, S: HypeString): HypeString;
function CharRef(i:integer):string;
function CharRefDecimal(i:integer):string;


function HasUnicodeName(i:integer; var CharacterName:String):boolean;
function AssertTags2:boolean;

//function CodePageToWideString(A: AnsiString; CodePage: Word=CP_ACP): WideString;


function ContainsPHPTag(const s:HypeString):boolean;
{function IsPHPTag(const s:HypeString; var i:integer):boolean; overload
function IsPHPTag(const s:HypeString):boolean; overload;
 }
var RenamedNames:TStringList;



procedure Register;

implementation

uses dhStyleSheet,BasicHTMLElements;


var _Unicode,UnicodeByNumbers:TStringList;
    UnicodeByNumbersList:TBinList;
    
var HTMLTags:TStringList;
//var InvalidElement:integer;

{$IFDEF CLX}
const IsCLX=true;
{$ELSE}
const IsCLX=false;
{$ENDIF}

const AAA=true and not IsCLX;
      AALevel=2;

type PBoolean=^Boolean;


var what_uni:array[char] of integer;
    Win32PlatformIsUnicode:boolean=false;

type
  THtmlEntity = record
    Name: string;
    Code: WideChar;
  end;
const
HtmlLat1: array [0..252] of THtmlEntity = (
  (Name: 'AElig'; Code: #$00C6),
  (Name: 'Aacute'; Code: #$00C1),
  (Name: 'Acirc'; Code: #$00C2),
  (Name: 'Agrave'; Code: #$00C0),
  (Name: 'Aring'; Code: #$00C5),
  (Name: 'Atilde'; Code: #$00C3),
  (Name: 'Auml'; Code: #$00C4),
  (Name: 'Ccedil'; Code: #$00C7),
  (Name: 'ETH'; Code: #$00D0),
  (Name: 'Eacute'; Code: #$00C9),
  (Name: 'Ecirc'; Code: #$00CA),
  (Name: 'Egrave'; Code: #$00C8),
  (Name: 'Euml'; Code: #$00CB),
  (Name: 'Iacute'; Code: #$00CD),
  (Name: 'Icirc'; Code: #$00CE),
  (Name: 'Igrave'; Code: #$00CC),
  (Name: 'Iuml'; Code: #$00CF),
  (Name: 'Ntilde'; Code: #$00D1),
  (Name: 'Oacute'; Code: #$00D3),
  (Name: 'Ocirc'; Code: #$00D4),
  (Name: 'Ograve'; Code: #$00D2),
  (Name: 'Oslash'; Code: #$00D8),
  (Name: 'Otilde'; Code: #$00D5),
  (Name: 'Ouml'; Code: #$00D6),
  (Name: 'THORN'; Code: #$00DE),
  (Name: 'Uacute'; Code: #$00DA),
  (Name: 'Ucirc'; Code: #$00DB),
  (Name: 'Ugrave'; Code: #$00D9),
  (Name: 'Uuml'; Code: #$00DC),
  (Name: 'Yacute'; Code: #$00DD),
  (Name: 'aacute'; Code: #$00E1),
  (Name: 'acirc'; Code: #$00E2),
  (Name: 'acute'; Code: #$00B4),
  (Name: 'aelig'; Code: #$00E6),
  (Name: 'agrave'; Code: #$00E0),
  (Name: 'aring'; Code: #$00E5),
  (Name: 'atilde'; Code: #$00E3),
  (Name: 'auml'; Code: #$00E4),
  (Name: 'brvbar'; Code: #$00A6),
  (Name: 'ccedil'; Code: #$00E7),
  (Name: 'cedil'; Code: #$00B8),
  (Name: 'cent'; Code: #$00A2),
  (Name: 'copy'; Code: #$00A9),
  (Name: 'curren'; Code: #$00A4),
  (Name: 'deg'; Code: #$00B0),
  (Name: 'divide'; Code: #$00F7),
  (Name: 'eacute'; Code: #$00E9),
  (Name: 'ecirc'; Code: #$00EA),
  (Name: 'egrave'; Code: #$00E8),
  (Name: 'eth'; Code: #$00F0),
  (Name: 'euml'; Code: #$00EB),
  (Name: 'frac12'; Code: #$00BD),
  (Name: 'frac14'; Code: #$00BC),
  (Name: 'frac34'; Code: #$00BE),
  (Name: 'iacute'; Code: #$00ED),
  (Name: 'icirc'; Code: #$00EE),
  (Name: 'iexcl'; Code: #$00A1),
  (Name: 'igrave'; Code: #$00EC),
  (Name: 'iquest'; Code: #$00BF),
  (Name: 'iuml'; Code: #$00EF),
  (Name: 'laquo'; Code: #$00AB),
  (Name: 'macr'; Code: #$00AF),
  (Name: 'micro'; Code: #$00B5),
  (Name: 'middot'; Code: #$00B7),
  (Name: 'nbsp'; Code: #$00A0),
  (Name: 'not'; Code: #$00AC),
  (Name: 'ntilde'; Code: #$00F1),
  (Name: 'oacute'; Code: #$00F3),
  (Name: 'ocirc'; Code: #$00F4),
  (Name: 'ograve'; Code: #$00F2),
  (Name: 'ordf'; Code: #$00AA),
  (Name: 'ordm'; Code: #$00BA),
  (Name: 'oslash'; Code: #$00F8),
  (Name: 'otilde'; Code: #$00F5),
  (Name: 'ouml'; Code: #$00F6),
  (Name: 'para'; Code: #$00B6),
  (Name: 'plusmn'; Code: #$00B1),
  (Name: 'pound'; Code: #$00A3),
  (Name: 'raquo'; Code: #$00BB),
  (Name: 'reg'; Code: #$00AE),
  (Name: 'sect'; Code: #$00A7),
  (Name: 'shy'; Code: #$00AD),
  (Name: 'sup1'; Code: #$00B9),
  (Name: 'sup2'; Code: #$00B2),
  (Name: 'sup3'; Code: #$00B3),
  (Name: 'szlig'; Code: #$00DF),
  (Name: 'thorn'; Code: #$00FE),
  (Name: 'times'; Code: #$00D7),
  (Name: 'uacute'; Code: #$00FA),
  (Name: 'ucirc'; Code: #$00FB),
  (Name: 'ugrave'; Code: #$00F9),
  (Name: 'uml'; Code: #$00A8),
  (Name: 'uuml'; Code: #$00FC),
  (Name: 'yacute'; Code: #$00FD),
  (Name: 'yen'; Code: #$00A5),
  (Name: 'yuml'; Code: #$00FF),
//  );

//HtmlSpecial: array [0..32] of THtmlEntity = (
  (Name: 'Dagger'; Code: #$2021),
  (Name: 'OElig'; Code: #$0152),
  (Name: 'Scaron'; Code: #$0160),
  (Name: 'Yuml'; Code: #$0178),
  (Name: 'amp'; Code: #$0026),
  (Name: 'apos'; Code: #$0027),
  (Name: 'bdquo'; Code: #$201E),
  (Name: 'circ'; Code: #$02C6),
  (Name: 'dagger'; Code: #$2020),
  (Name: 'emsp'; Code: #$2003),
  (Name: 'ensp'; Code: #$2002),
  (Name: 'euro'; Code: #$20AC),
  (Name: 'gt'; Code: #$003E),
  (Name: 'ldquo'; Code: #$201C),
  (Name: 'lrm'; Code: #$200E),
  (Name: 'lsaquo'; Code: #$2039),
  (Name: 'lsquo'; Code: #$2018),
  (Name: 'lt'; Code: #$003C),
  (Name: 'mdash'; Code: #$2014),
  (Name: 'ndash'; Code: #$2013),
  (Name: 'oelig'; Code: #$0153),
  (Name: 'permil'; Code: #$2030),
  (Name: 'quot'; Code: #$0022),
  (Name: 'rdquo'; Code: #$201D),
  (Name: 'rlm'; Code: #$200F),
  (Name: 'rsaquo'; Code: #$203A),
  (Name: 'rsquo'; Code: #$2019),
  (Name: 'sbquo'; Code: #$201A),
  (Name: 'scaron'; Code: #$0161),
  (Name: 'thinsp'; Code: #$2009),
  (Name: 'tilde'; Code: #$02DC),
  (Name: 'zwj'; Code: #$200D),
  (Name: 'zwnj'; Code: #$200C),
//  );

//HtmlSymbol: array [0..123] of THtmlEntity = (
  (Name: 'Alpha'; Code: #$0391),
  (Name: 'Beta'; Code: #$0392),
  (Name: 'Chi'; Code: #$03A7),
  (Name: 'Delta'; Code: #$0394),
  (Name: 'Epsilon'; Code: #$0395),
  (Name: 'Eta'; Code: #$0397),
  (Name: 'Gamma'; Code: #$0393),
  (Name: 'Iota'; Code: #$0399),
  (Name: 'Kappa'; Code: #$039A),
  (Name: 'Lambda'; Code: #$039B),
  (Name: 'Mu'; Code: #$039C),
  (Name: 'Nu'; Code: #$039D),
  (Name: 'Omega'; Code: #$03A9),
  (Name: 'Omicron'; Code: #$039F),
  (Name: 'Phi'; Code: #$03A6),
  (Name: 'Pi'; Code: #$03A0),
  (Name: 'Prime'; Code: #$2033),
  (Name: 'Psi'; Code: #$03A8),
  (Name: 'Rho'; Code: #$03A1),
  (Name: 'Sigma'; Code: #$03A3),
  (Name: 'Tau'; Code: #$03A4),
  (Name: 'Theta'; Code: #$0398),
  (Name: 'Upsilon'; Code: #$03A5),
  (Name: 'Xi'; Code: #$039E),
  (Name: 'Zeta'; Code: #$0396),
  (Name: 'alefsym'; Code: #$2135),
  (Name: 'alpha'; Code: #$03B1),
  (Name: 'and'; Code: #$2227),
  (Name: 'ang'; Code: #$2220),
  (Name: 'asymp'; Code: #$2248),
  (Name: 'beta'; Code: #$03B2),
  (Name: 'bull'; Code: #$2022),
  (Name: 'cap'; Code: #$2229),
  (Name: 'chi'; Code: #$03C7),
  (Name: 'clubs'; Code: #$2663),
  (Name: 'cong'; Code: #$2245),
  (Name: 'crarr'; Code: #$21B5),
  (Name: 'cup'; Code: #$222A),
  (Name: 'dArr'; Code: #$21D3),
  (Name: 'darr'; Code: #$2193),
  (Name: 'delta'; Code: #$03B4),
  (Name: 'diams'; Code: #$2666),
  (Name: 'empty'; Code: #$2205),
  (Name: 'epsilon'; Code: #$03B5),
  (Name: 'equiv'; Code: #$2261),
  (Name: 'eta'; Code: #$03B7),
  (Name: 'exist'; Code: #$2203),
  (Name: 'fnof'; Code: #$0192),
  (Name: 'forall'; Code: #$2200),
  (Name: 'frasl'; Code: #$2044),
  (Name: 'gamma'; Code: #$03B3),
  (Name: 'ge'; Code: #$2265),
  (Name: 'hArr'; Code: #$21D4),
  (Name: 'harr'; Code: #$2194),
  (Name: 'hearts'; Code: #$2665),
  (Name: 'hellip'; Code: #$2026),
  (Name: 'image'; Code: #$2111),
  (Name: 'infin'; Code: #$221E),
  (Name: 'int'; Code: #$222B),
  (Name: 'iota'; Code: #$03B9),
  (Name: 'isin'; Code: #$2208),
  (Name: 'kappa'; Code: #$03BA),
  (Name: 'lArr'; Code: #$21D0),
  (Name: 'lambda'; Code: #$03BB),
  (Name: 'lang'; Code: #$2329),
  (Name: 'larr'; Code: #$2190),
  (Name: 'lceil'; Code: #$2308),
  (Name: 'le'; Code: #$2264),
  (Name: 'lfloor'; Code: #$230A),
  (Name: 'lowast'; Code: #$2217),
  (Name: 'loz'; Code: #$25CA),
  (Name: 'minus'; Code: #$2212),
  (Name: 'mu'; Code: #$03BC),
  (Name: 'nabla'; Code: #$2207),
  (Name: 'ne'; Code: #$2260),
  (Name: 'ni'; Code: #$220B),
  (Name: 'notin'; Code: #$2209),
  (Name: 'nsub'; Code: #$2284),
  (Name: 'nu'; Code: #$03BD),
  (Name: 'oline'; Code: #$203E),
  (Name: 'omega'; Code: #$03C9),
  (Name: 'omicron'; Code: #$03BF),
  (Name: 'oplus'; Code: #$2295),
  (Name: 'or'; Code: #$2228),
  (Name: 'otimes'; Code: #$2297),
  (Name: 'part'; Code: #$2202),
  (Name: 'perp'; Code: #$22A5),
  (Name: 'phi'; Code: #$03C6),
  (Name: 'pi'; Code: #$03C0),
  (Name: 'piv'; Code: #$03D6),
  (Name: 'prime'; Code: #$2032),
  (Name: 'prod'; Code: #$220F),
  (Name: 'prop'; Code: #$221D),
  (Name: 'psi'; Code: #$03C8),
  (Name: 'rArr'; Code: #$21D2),
  (Name: 'radic'; Code: #$221A),
  (Name: 'rang'; Code: #$232A),
  (Name: 'rarr'; Code: #$2192),
  (Name: 'rceil'; Code: #$2309),
  (Name: 'real'; Code: #$211C),
  (Name: 'rfloor'; Code: #$230B),
  (Name: 'rho'; Code: #$03C1),
  (Name: 'sdot'; Code: #$22C5),
  (Name: 'sigma'; Code: #$03C3),
  (Name: 'sigmaf'; Code: #$03C2),
  (Name: 'sim'; Code: #$223C),
  (Name: 'spades'; Code: #$2660),
  (Name: 'sub'; Code: #$2282),
  (Name: 'sube'; Code: #$2286),
  (Name: 'sum'; Code: #$2211),
  (Name: 'sup'; Code: #$2283),
  (Name: 'supe'; Code: #$2287),
  (Name: 'tau'; Code: #$03C4),
  (Name: 'there4'; Code: #$2234),
  (Name: 'theta'; Code: #$03B8),
  (Name: 'thetasym'; Code: #$03D1),
  (Name: 'trade'; Code: #$2122),
  (Name: 'uArr'; Code: #$21D1),
  (Name: 'uarr'; Code: #$2191),
  (Name: 'upsih'; Code: #$03D2),
  (Name: 'upsilon'; Code: #$03C5),
  (Name: 'weierp'; Code: #$2118),
  (Name: 'xi'; Code: #$03BE),
  (Name: 'zeta'; Code: #$03B6)
  );

  
const
      markupBreak=endl_main;
      markupEmptyEle=#2;




procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhLabel]);
  //RegisterClasses([TdhRule]);
end;


function HasUnicodeName(i:integer; var CharacterName:String):boolean;
var i2:integer;
begin
    i2:=UnicodeByNumbersList.SortedIndexOf(PointerCompare,Pointer(i));
    if i2<>-1 then
    begin
     CharacterName:=UnicodeByNumbers[i2];
     result:=true;
    end else
     result:=false;
end;



function StrPos(const S: HypeString; const Substr: HypeString; Index: Integer): Integer;
begin
 if Substr<>'' then
 for Result:=Index to length(s) do
 if (S[Result]=Substr[1]) and (Copy(S,Result,Length(Substr))=Substr) then
  exit;
 result:=0;
end;



function WithoutComments(const s:HypeString; repl:HypeChar):HypeString;
var i,i2:integer;
begin
 result:=s;
 i:=StrPos(result,'<!--',1);
 while i<>0 do
 begin
  i2:=StrPos(result,'-->',i);
  if i2=0 then
   i2:=length(result)-(length('-->')-1);
  for i:=i to i2+length('-->')-1 do
   result[i]:=repl;
  i:=StrPos(result,'<!--',i2+length('-->'));
 end;
end;

function ContainsPHPTag(const s:HypeString):boolean;
begin
 result:=Pos('<?',s)<>0;
end;

{function IsPHPTag(const s:HypeString):boolean;
var i:integer;
begin
 i:=1;
 result:=(s<>'') and (s[1]='<') and isPHPTag(s,i);
end;
 }
function IsPHPTag(const s:HypeString; var i:integer):boolean;
var i2:integer;
begin
 if not((i=0) or (i+2>length(s))) and (s[i+1]='?') then
 begin
  i2:=StrPos(s,'?>',i+2);
  if i2<>0 then
  begin
   i:=i2+length('?>');
   result:=true;
   exit;
  end;
 end;
 result:=false;
end;


function getTag2(const s:HypeString; var vn,itag,itagbs:integer; var tag:String; var text:HypeString; var Closing,EmptyEle:boolean):boolean;
var i,i2:integer;
begin
 i:=CharPos(s,'<',vn);

 while IsPHPTag(s,i) do
  i:=CharPos(s,'<',i);

 if not((i=0) or (i+2>length(s))) then
 begin
 text:=AbsCopy(s,vn,i);
 i2:=CharPos(s,'>',i+1);
 if i2<>0 then
 begin
 Closing:=s[i+1]='/';
 if Closing then
  inc(i);
 EmptyEle:=(s[i2-1]='/') and not Closing;
 if EmptyEle then
  itagbs:=i2-1 else
  itagbs:=i2;
 itag:=i+1;
 Tag:=LowerCase(AbsCopy(s,itag,itagbs));
 vn:=i2+1;
 result:=true;
 exit;
 end;
 end;
 itag:=0;
 tag:='';  {
 if vn<=length(s) then
 begin
  text:=AbsCopy(s,vn,maxint);
  vn:=length(s)+1;
  Closing:=true;
  result:=true;
 end else   }
  result:=false;
end;

function Replace(var s:HypeString; vn,bs:integer; const Subst:HypeString):boolean;
begin
 result:=AbsCopy(s,vn,bs)<>Subst;
 if result then
  s:=AbsCopy(s,1,vn)+Subst+AbsCopy(s,bs,maxint);
  //StuffString(s,vn,bs-vn,Subst);
end;

{$IFDEF VER160}
type PInteger=^Integer;
{$ENDIF}



procedure TStyleTree.Clear;
var i:integer;
begin
 if IsWholeStyle and (StyleElement<>nil) then
  StyleElement.GetCommon.InlineUsedByList.Remove(Owner);
 for i:=0 to Count-1 do
  TStyleTree(Items[i]).Free;
 inherited;
end;

destructor TStyleTree.Destroy;
begin
 inherited;
end;




constructor TdhCustomLabel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle{ + [csReplicatable]} - [csAcceptsControls];
  //ControlStyle := ControlStyle + [{csAcceptsControls,} csSetCaption];
  AutoSizeXY:=asY;
  Width:=100;
end;



procedure TdhCustomLabel.DoCSSToWinControl(WhatChanged:TWhatChanged);
begin
 if ([wcText,wcText2]*WhatChanged<>[]) and not (csLoading in ComponentState) then
  FreeLines;
// if not (FCommon.LastActStyle in [hsOver,hsOverDown]) then
//  ProcessMouseMove;//ClientStyleTree_starttag:=0;
 if (wcText in {,wcSize wegen AllEdgesPure, Blocking} WhatChanged) and not (csLoading in ComponentState) then
  InvalInline;
 if wcName in WhatChanged then
  UpdateNames(nil,nil,false);
 Inherited;
 //if ([wcClientArea,wcFont,wcText]*WhatChanged<>[]) and not (csLoading in ComponentState) then
 // AdjustSize;
 ParseHTML; //müssen wir machen, da wir auf Namen-Änderungen reagieren müssen
end;


(*

function TdhCustomLabel.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var Rect:TRect;
begin
 if not (csLoading in ComponentState){ and HasParent} then
 begin
   IsAdjustBounds:=true;
   Rect:=GetAutoRect(NewWidth,NewHeight);
   IsAdjustBounds:=false;
   if FCommon.ASXY in [asY,asXY] then
    NewHeight:=Rect.Bottom-Rect.Top;
   if FCommon.ASXY in [asX,asXY] then
    NewWidth:=Rect.Right-Rect.Left;
 end;
 result:=true;
end;*)


procedure TdhCustomLabel.ControlsListChanged(Control: TControl; Inserting: Boolean);
begin
  inherited;
  if not (csReading in ComponentState) then
    if Inserting and (Control.Owner=Owner) then
    begin
{     if Message.Control<>nil then
      ShowMessage('Inserting:'+Name+'+'+Message.Control.Name) else
      ShowMessage('Inserting:'+Name+' nil');
}
       //Result:=1;
     Control.Parent:=Parent;
     Control.BoundsRect:=Bounds(Control.Left+Left,Control.Top+Top,Control.Width,Control.Height);
    end;
end;


procedure TdhCustomLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
{ if not (csLoading in ComponentState) and (Operation=opInsert) and (AComponent.Name<>'') and (Pos('<'+AComponent.Name,FHTMLText)<>0) then
  AssureRenamingAware;
  Problem is that AComponent.Name is always '', it is not yet loaded
  }
 Inherited;
end;

procedure TdhCustomLabel.WriteState(Writer: TWriter);
begin
 Inherited;
end;



procedure TdhCustomLabel.TryBrokenReferences(sl:TStringList);
var invcon:ICon;

procedure ItUpdateNames(StyleTree:TStyleTree);
var w:integer;
begin
 if StyleTree.StyleElement=invcon then
 if sl<>nil then
  sl.Add(StyleTree.TagName) else
  InvalInline;
 for w:=StyleTree.Count-1 downto 0 do
 if TopStyleTree<>nil then
  ItUpdateNames(TStyleTree(StyleTree[w]));
end;

begin
 inherited;
 if (TopStyleTree<>nil) and AssertTags2 then
 begin
  invcon:=nil;
  {if (InvalidElement<>-1) and HasCommon(TComponent(HTMLTags.Objects[InvalidElement]),Common) then
   invcon:=Common.Con;  }
  if AssertTags2 then
   invcon:=dhStrEditDlg.unknown_element;
  ItUpdateNames(TopStyleTree);
  AssureRenamingAware(true);
 end;
end;


procedure TdhCustomLabel.CopyDependencies(CopyList:TList);

procedure ItUpdateNames(StyleTree:TStyleTree);
var w:integer;
    c:TControl;
begin
 if (StyleTree.StyleElement<>nil) then
 begin
  c:=StyleTree.StyleElement.GetCommon;
  if (c.Owner=Owner) and (CopyList.IndexOf(c)=-1) then
   CopyList.Add(c);
 end;
 for w:=StyleTree.Count-1 downto 0 do
  ItUpdateNames(TStyleTree(StyleTree[w]));
end;

begin
 inherited;
 if TopStyleTree<>nil then
  ItUpdateNames(TopStyleTree);
end;


procedure TdhCustomLabel.UpdateNames(InlineUse,NewInlineUse:ICon; PropagateChange:boolean);
var Changed:boolean;

procedure ItUpdateNames(StyleTree:TStyleTree);
var w:integer;
begin
 if (InlineUse<>nil) and (StyleTree.StyleElement=InlineUse) then
 begin
  StyleTree.StyleElement:=NewInlineUse;
  Changed:=true;
 end;
 if (StyleTree.StyleElement<>nil) and StyleTree.IsWholeStyle and (StyleTree.endtag>0) then
  if Replace(FHTMLText,StyleTree.endtag,StyleTree.endtag+length(StyleTree.TagName),StyleTree.StyleElement.GetName) then
   Changed:=true;
 for w:=StyleTree.Count-1 downto 0 do
  ItUpdateNames(TStyleTree(StyleTree[w]));
 if (StyleTree.StyleElement<>nil) and StyleTree.IsWholeStyle and (StyleTree.starttag>0) then
  if Replace(FHTMLText,StyleTree.starttag,StyleTree.starttag+length(StyleTree.TagName),StyleTree.StyleElement.GetName) then
   Changed:=true;
end;

begin
 if TopStyleTree=nil then exit;
 if csDestroying in ComponentState then
 begin
  InvalInline;
  exit;
 end;
 Changed:=false;
 ItUpdateNames(TopStyleTree);
 if Changed then
 begin
  InvalInline;
  AssureRenamingAware(PropagateChange);
 end;
end;


const unicode_opening='&';
      unicode_closing=';';
      MaxUnicodeLength=10;

function FindUniClose(const s:HypeString; i:integer; var ir:integer): boolean;
var si:integer;
begin
 si:=i;
 result:=false;
 while (i<=length(s)) and (s[i]<>unicode_closing) do
 if (s[i]=unicode_opening)  or (i-si>MaxUnicodeLength)  then
  exit else
  inc(i);
 result:=i<=length(s);
 if result then
  ir:=i+1;
end;

function IsNumber(ch:WideChar):boolean;
begin
 result:=(Integer(ch)>=ord('0')) and (Integer(ch)<=ord('9'));
end;


function HasSecCase(ch:WideChar; var SecCase:WideChar; var IsUpperCase:boolean):boolean;
var i:integer;
begin
 result:=true;
 if (Integer(ch)>=ord('a')) and (Integer(ch)<=ord('z')) then
 begin
  IsUpperCase:=false;
  SecCase:=WideChar(Integer(ch)+ord('A')-ord('a'));
 end else
 if (Integer(ch)>=ord('A')) and (Integer(ch)<=ord('Z')) then
 begin
  IsUpperCase:=true;
  SecCase:=WideChar(Integer(ch)+ord('a')-ord('A'));
 end else
 begin
 i:=_Unicode.IndexOfObject(TObject(ch));
 if (i<>-1) and (i-1>=0) and (lowercase(_Unicode[i-1])=lowercase(_Unicode[i])) then
 begin
  IsUpperCase:=_Unicode[i][1] in ['A'..'Z'];
  SecCase:=WideChar(_Unicode.Objects[i-1]);
 end else
 if (i<>-1) and (i+1<=_Unicode.Count-1) and (lowercase(_Unicode[i+1])=lowercase(_Unicode[i])) then
 begin
  IsUpperCase:=_Unicode[i][1] in ['A'..'Z'];
  SecCase:=WideChar(_Unicode.Objects[i+1]);
 end else
  result:=false;
 end;
end;


function getUnicodeChar(ts:string; var ch:WideChar):boolean;
var ic,i:Integer;
begin
 if _Unicode=nil then
 begin
  result:=false;
  exit;
 end;
 result:=true;
 try
   if (ts<>'') and (ts[1]='#') then
   begin
    delete(ts,1,1);
    if (ts<>'') and (lowercase(ts[1])='x') then
     ts[1]:='$';
    ic:=strtoint(ts);
    ch:=WideChar(ic);
   end else
   begin
   i:=_Unicode.IndexOf(ts);
   if i=-1 then
    result:=false else
   if _Unicode[i]=ts then
    ch:=WideChar(_Unicode.Objects[i]) else
   if (i-1>=0) and (_Unicode[i-1]=ts) then
    ch:=WideChar(_Unicode.Objects[i-1]) else
   if (i+1<=_Unicode.Count-1) and (_Unicode[i+1]=ts) then
    ch:=WideChar(_Unicode.Objects[i+1]) else
    result:=false;
   end;
  except //strtoint exception abfangen
   result:=false;
  end;


end;


function CharRef(i:integer):string;
begin
 result:='&#x'+Format('%x', [i])+';';
end;

function CharRefDecimal(i:integer):string;
begin
 result:='&#'+Format('%d', [i])+';';
end;

function ConvertWideStringToUnicode(const s:WideString; NoTrivial:boolean):WideString;
var i:Integer;
begin
 result:='';
 //if _Unicode<>nil then
 for i:=1 to length(s) do
 {if (ord(s[i])<=255) and (what_uni[Char(s[i])]<>0) and (s[i]<>' ') and (not NoTrivial or (s[i]<>'''')) then
  result:=result+'&'+_Unicode[what_uni[Char(s[i])]]+';' else}
 if s[i]='&' then
  result:=result+'&amp;' else
 if s[i]='"' then
  result:=result+'&quot;' else
 if (s[i]='''') and not NoTrivial then
  result:=result+'&apos;' else
 if s[i]='<' then
  result:=result+'&lt;' else
 if s[i]='>' then
  result:=result+'&gt;' else
 {if (ord(s[i])>127) then
  result:=result+CharRef(ord(s[i])) else}
  result:=result+s[i];
end;


//http://groups.google.de/group/borland.public.delphi.internationalization/browse_thread/thread/c516b2850a3e25b7/b071086e4ef68cc7?lnk=st&q=CodePageToWideString+group%3A*delphi*&rnum=2&hl=de#b071086e4ef68cc7
{function UTF8ToUCS2(const UTF8String: AnsiString): WideString;
var
  l: integer;
begin
  SetLength(Result, Length(UTF8String) * 2);
  l := MultiByteToWideChar(CP_ACP, 0, Pointer(UTF8String),
                           -1, Pointer(Result), Length(Result));
  if l = 0 then
    raise Exception.Create('Error converting UTF8 to UCS2');
  SetLength(Result, Pred(l));
end;  }


(*function CodePageToWideString(A: AnsiString; CodePage: Word=CP_ACP): WideString;
begin
  SetLength(Result, Length(A));
  MultiByteToWideChar(CodePage, 0, PChar(A), Length(A), PWideChar(Result), Length(A));
end;*)


function LE127(const s:WideString):string;
var i:Integer;
begin
 result:='';
 for i:=1 to length(s) do
 if (ord(s[i])>127) then
  result:=result+CharRef(ord(s[i]{CodePageToWideString(s[i])[1]})) else
  result:=result+s[i];
end;


{function ConvertWideStringToUnicode_(const w:WideString):String;
var i:Integer;
begin
 for i:=1 to length(w) do
 if _Unicode.IndexOfObject(TObject(w[i]))<>-1 then
  result:=result+'&'+_Unicode[_Unicode.IndexOfObject(TObject(w[i]))]+';' else
 if (Integer(w[i])<=255) and (what_uni[Char(w[i])]=0) then
  result:=result+Char(w[i]) else
  result:=result+CharRef(Integer(w[i]));
end;
 }
function XMLconformant(const s:String):string;
var i,o:Integer;
    ch:WideChar;
begin
 result:='';
 for i:=1 to length(s) do
 if (s[i]='&') and not(FindUniClose(s,i+1,o) and getUnicodeChar(abscopy(s,i+1,o-1),ch)) then
 begin
  result:=result+'&amp;';
 end else
  result:=result+s[i];
 //< und > checken fehlt
end;




function ConvertUnicodeToWideStringExt(const s:HypeString; var TrackChar:TTrackChar; offs:integer; mislegit:HypeChar):WideString;
var i,o,old_i,ri,ti:integer;
    ch:WideChar;

begin
 i:=1;
 ri:=1;
 ti:=length(TrackChar);
 setlength(result,length(s));
 setlength(TrackChar,length(TrackChar)+length(s));
 while (i<=length(s)) and (s[i]=mislegit) do
  inc(i);
 while i<=length(s) do
 begin
  old_i:=i;
  if (s[i]='&') and FindUniClose(s,i+1,o) and getUnicodeChar(abscopy(s,i+1,o-1),ch) then
  begin
   result[ri]:=ch;
   inc(ri);
   i:=o;
  end else
  if (s[i]='<') and IsPHPTag(s,i) then
  begin
   result[ri]:='?';
   inc(ri);
  end else
  if s[i]<>mislegit then
  begin
   result[ri]:=s[i];//{WideChar}CodePageToWideString(s[i])[1];
   inc(ri);
   inc(i);
  end else
  begin
   inc(i);
   if ti-1>=0 then
    TrackChar[ti-1].bs:=offs+i;
   continue;
  end;
  TrackChar[ti].vn:=offs+old_i;
  TrackChar[ti].bs:=offs+i;
  inc(ti);
 end;
 setlength(TrackChar,ti);
 setlength(result,ri-1);
end;


function ConvertUnicodeToWideString_(const s:WideString):WideString;
var TrackChar:TTrackChar;
begin
 result:=ConvertUnicodeToWideStringExt(s,TrackChar,0,#0);
end;


var IsInStart:boolean=false;

function AssertTags2:boolean;
var i:integer;
begin
 if dhStrEditDlg<>nil then
 begin
  result:=true;
  exit;
 end;
 if IsInStart then
 begin
  result:=false;
  exit;
 end;

 IsInStart:=true;
// showmessage('hi');
 dhStrEditDlg:=TBasicHTMLElements.Create(nil);

 HTMLTags:=TStringList.Create;


// showmessage('hia');

 if dhStrEditDlg.dhStyleSheet1<>nil then
 for i:=0 to dhStrEditDlg.dhStyleSheet1.ControlCount-1 do
 if (dhStrEditDlg.dhStyleSheet1.Controls[i] is TdhCustomLabel) and (Copy(dhStrEditDlg.dhStyleSheet1.Controls[i].Name,1,length('dhLabel'))<>'dhLabel') then
 begin
  (dhStrEditDlg.dhStyleSheet1.Controls[i] as TdhCustomLabel).IsDlg:=true;
  HTMLTags.AddObject(dhStrEditDlg.dhStyleSheet1.Controls[i].Name,dhStrEditDlg.dhStyleSheet1.Controls[i]);
 end;

// showmessage('hi2');
 HTMLTags.Sorted:=true;

     {
 if not HTMLTags.Find('unknown_element',InvalidElement) then
  InvalidElement:=-1;  }

 IsInStart:=false;
 result:=true;

end;

procedure seccase(var wtext:WideString; ToUpper:boolean);
var i:integer;
    IsUpper:boolean;
    sec:WideChar;
begin
 for i:=1 to length(wtext) do
 if HasSecCase(wtext[i],sec,IsUpper) and (IsUpper<>ToUpper) then
  wtext[i]:=sec;
end;


function HypeSubstText(const Substr,durch, S: HypeString): HypeString;
begin
  result:=WideStringReplace(S,Substr,durch,[rfReplaceAll]);
end;


procedure TdhCustomLabel.ParseHTML; //{$IFDEF VER160}unsafe;{$ENDIF}

var StyleTree,NoneStyle:TStyleTree;
    SkipNextSpace,Closing:boolean;
    spre:HypeString;
    text:HypeString;

procedure PushText(vn:integer; IsBreak:boolean=false);
var i,i2,c,fwcapsIndex:integer;
    s,ss:HypeString;
    wtext:WideString;
    sec,sec2:WideChar;
    IsUpper:boolean;      
var StyleTree2:TStyleTree;


procedure SetStyleTree(vn,bs:integer; StyleTree:TStyleTree);
var i:integer;
begin
 for i:=vn to bs-1 do
  Ptree[i]:=StyleTree;
end;

function WhiteSpaceAtBlockBeginning(StyleTree:TStyleTree):boolean;
begin
 result:=false;
 repeat
  if (StyleTree.vn<>length(gltext)+1) then
   exit else
  if StyleTree.Blocking then
  begin
   result:=true;
   exit;
  end;
  StyleTree:=StyleTree.ParentStyle;
 until StyleTree=nil;
end;




begin
 //SetLength(StyleList,Length(StyleList)+1);
 if StyleTree.IsImg then text:='';
 s:=text;
 s:=HypeSubstText(markupEmptyEle,'',s);
 UseStyleTree:=StyleTree;
 try
  if NoneStyle<>nil then
  begin
   //s:='';
   //ss:=s;
   wtext:='';//markupEmptyEle;
   //SkipNextSpace:=true;
  end else
  begin
  if StyleTree.WhiteSpace<>cwsPre then
  begin
   s:=HypeSubstText(#9,' ',s);
   s:=HypeSubstText(endl_main,' ',s);
   for i:=length(s) downto 2 do
   if (s[i]=' ') and (s[i-1]=' ') then
    s[i]:=#1;
   if (s<>'') and (s[1]=' ') and (SkipNextSpace or WhiteSpaceAtBlockBeginning(StyleTree)) then
      //((gltext<>'') and (gltext[length(gltext)]=' ') and (Ptree[length(gltext)].WhiteSpace<>cwsPre) or (StyleTree.vn=length(gltext)+1) and StyleTree.Blocking) then
    s[1]:=#1;

   ss:=HypeSubstText(#1,'',s);
   SkipNextSpace:=(ss='') and SkipNextSpace or (ss<>'') and (ss[length(ss)]=' ');
   //s:=ss;
//   SkipNextSpace:=True;
  end else
  begin
   ss:=s;
   SkipNextSpace:=false;
  end;
  if IsBreak and (NoneStyle=nil) then
  begin
   s:=markupBreak;
  end else
  if Closing and (ss='') and (StyleTree.vn=length(gltext)+1) then
  begin
   s:=markupEmptyEle;
   //SkipNextSpace:=false;
  end;
  wtext:=ConvertUnicodeToWideStringExt(s,TrackChar,vn-1-length(spre),#1);
  end;
 {for i:=length(wtext) downto 1 do
 if wtext[i]=WideChar(#1) then
  delete(wtext,i,1); }
 //s:=StringReplace(s,#1,'',[rfReplaceAll, rfIgnoreCase]);


 c:=length(Ptree);
 setlength(Ptree,c+length(wtext));
 SetStyleTree(c,length(Ptree),StyleTree);

  if FontVariant=cfvSmallCaps then
  begin
   i:=0;
   repeat
    inc(i);
    i2:=i;
    while (i<=length(wtext)) and HasSecCase(wtext[i],sec,IsUpper) and not IsUpper do
     inc(i);
    if i<>i2 then
    if AssertTags2 then
    begin
     StyleTree2:=TStyleTree.Create;
     StyleTree2.Owner:=Self;
     StyleTree2.ParentStyle:=StyleTree;
     StyleTree2.vn:=length(gltext)+i2;
     StyleTree2.bs:=length(gltext)+i;
     SetStyleTree(StyleTree2.vn,StyleTree2.bs,StyleTree2);

     StyleTree.Add(StyleTree2);
     StyleTree2.IsWholeStyle:=false;

     if AssertTags2 then
      StyleTree2.StyleElement:=dhStrEditDlg.for_small_caps;

     UseStyleTree:=StyleTree2;
     StyleTree2.FontSize:=GetFontSizePixels(FontSize,StyleTree.FontSize);
     StyleTree2.WhiteSpace:=StyleTree.WhiteSpace;
     UseStyleTree:=StyleTree;
    end;
   until i>length(wtext);
   seccase(wtext,true);
  end else

  case TextTransform of
  cttCapitalize:
  for i:=1 to length(wtext) do
  if HasSecCase(wtext[i],sec,IsUpper) and not IsUpper and not ((i-1>=1) and (HasSecCase(wtext[i-1],sec2,IsUpper)  or IsNumber(wtext[i-1]))) then
   wtext[i]:=sec;
  cttUppercase: wtext:=WideUpperCase(wtext);//seccase(wtext,true);
  cttLowercase: wtext:=WideLowerCase(wtext);//seccase(wtext,false);
  end;

 gltext:=gltext+wtext;
 finally
  UseStyleTree:=nil;
 end;
end;

var
    vn,itag:integer;
    vn_old:integer;
    EmptyEle:boolean;
    s,ssuc:HypeString;
    StyleTree2:TStyleTree;
    tag:String;
    content_vn,content_bs:integer;


var c:TComponent;

procedure CloseTag(endtag:integer);
begin
 StyleTree.bs:=length(gltext)+1;
 if (endtag<content_vn) or (endtag>=content_bs) then
  StyleTree.endtag:=0 else
  StyleTree.endtag:=endtag-length(spre);
  if NoneStyle=StyleTree then
   NoneStyle:=nil;
 StyleTree:=StyleTree.ParentStyle;
end;

procedure PutNew(AllowImg:boolean=true);
begin
 StyleTree.WhiteSpace:=WhiteSpace;
 StyleTree.IsImg:=AllowImg and HasImage;
end;


//  ActPart:PInlineElement;
var TagIndex,itagbs:integer;
begin
// if (csDesigning in ComponentState) then exit;
 if (TopStyleTree<>nil) then exit;
 if (csLoading in ComponentState) then exit;
 s:=FHTMLText;
 GetModifiedText(spre,s,ssuc);
 if self.GetVal(pcContentBefore) then
  spre:=Cascaded.Before+spre;
 if self.GetVal(pcContentAfter) then
  ssuc:=ssuc+Cascaded.After;

 s:=spre+s+ssuc;
 content_bs:=length(s)+1-length(ssuc);
 content_vn:=1+length(spre);
 //s:=StringReplace(s,#13,' ',[rfReplaceAll, rfIgnoreCase]);
 s:=WithoutComments(s,markupEmptyEle);

 gltext:='';

 TopStyleTree:=TStyleTree.Create;
 StyleTree:=TopStyleTree;
 StyleTree.IsWholeStyle:=false;
 StyleTree.vn:=1;
 StyleTree.Blocking:=true;
 StyleTree.TagName:='#notag';

 Setlength(self.TrackChar,0);
 //SetLength(StyleList,0);
 SetLength(Ptree,1);
                   
 NoneStyle:=nil;
 PutNew(false);

 vn:=1;
 vn_old:=vn;
 //if not StyleTree.IsImg then
 while getTag2(s,vn,itag,itagbs,tag,text,Closing,EmptyEle) and (StyleTree<>nil) do
 begin
  PushText(vn_old);
  if tag='br' then
  begin
   text:='';
   //StyleList[High(StyleList)].Breaking:=true;
   //StyleList[High(StyleList)].HasEnd:=true;
   {gltext:=gltext+markupBreak;
   SetLength(Ptree,length(Ptree)+1);
   Ptree[high(Ptree)]:=StyleTree;   }
   PushText(vn_old,true);
   {with TrackChar[high(TrackChar)] do
   begin
    vn:=itag;
    bs:=itagbs;
   end; }
  end else
  if Closing then
  begin
  if (StyleTree<>nil) and (StyleTree.TagName=Tag) then
  begin
   CloseTag(itag);
  end;
  end else
  begin
   StyleTree2:=TStyleTree.Create;
   StyleTree2.Owner:=Self;
   StyleTree2.ParentStyle:=StyleTree;
   StyleTree.Add(StyleTree2);
   StyleTree:=StyleTree2;
   StyleTree.TagName:=Tag;
   if Owner<>nil then
    c:=Owner.FindComponent(Tag) else
    c:=nil;
   if (c is TdhCustomPanel) and not (csDestroying in c.ComponentState) then
   begin
    StyleTree.IsWholeStyle:=true;
    StyleTree.StyleElement:=TdhCustomPanel(c);
    if TdhCustomPanel(c).InlineUsedByList.IndexOf(Self)=-1 then
     TdhCustomPanel(c).InlineUsedByList.Add(Self);
   end else
   begin
    StyleTree.IsWholeStyle:=false;
    {if AssertTags2 and not HTMLTags.Find(tag,TagIndex) then
     TagIndex:=InvalidElement; }
    if AssertTags2 then
    if {TagIndex<>-1}HTMLTags.Find(tag,TagIndex) then
    begin
     StyleTree.StyleElement:=TComponent(HTMLTags.Objects[TagIndex]) as TdhCustomPanel;
    end else
     StyleTree.StyleElement:=dhStrEditDlg.unknown_element;
   end;
    if (itag<content_vn) or (itag>=content_bs) then
     StyleTree.starttag:=0 else
     StyleTree.starttag:=itag-length(spre);

   StyleTree.vn:=length(gltext)+1;
   UseStyleTree:=StyleTree;
   try
    StyleTree.Blocking:=Display in [cdsBlock,cdsListItem];
    if (NoneStyle=nil) and (Display=cdsNone) then
      NoneStyle:=StyleTree;
    PutNew;
   finally
    UseStyleTree:=nil;
   end;

   if EmptyEle or StyleTree.IsImg then
   begin
    Closing:=true;
    text:='';
    PushText(itag-1);
    if StyleTree.IsImg then
     SkipNextSpace:=false;
    CloseTag(0);
   end;

  end;
  vn_old:=vn;
 end;
 text:=Copy(s,vn,maxint);
 Closing:=true;
 PushText(vn);
 vn:=Length(s)+1;
 text:=Copy(s,vn,maxint){=''};
 while StyleTree<>nil do
 begin
  if (gltext='') and (StyleTree=TopStyleTree) then
   PushText(vn);//generate at least one markupEmptyEle (may be only needed when using not-closed cdsNone-formatted tags)
  CloseTag(0);
 end;
{ gltext:=gltext+markupBreak;
 SetLength(Ptree,length(Ptree)+1);
 Ptree[high(Ptree)]:=TopStyleTree;  }
// TopStyleTree.bs:=length(gltext)+1;
 UseStyleTree:=nil;
end;


procedure TdhCustomLabel.InvalInline;
begin
 FreeLines;
 FreeAndNil(TopStyleTree);
// ClientStyleTree_starttag:=0;
end;


procedure TdhCustomLabel.RenameNames;
var i:integer;
    NewName:string;
begin
 if (RenamedNames<>nil) then
 begin
  // we must use "downto" order since otherwise for renamings 'a'->'b' and 'b'->'c',
  // all 'a' get replaced to 'c' and not to 'b'
  for i:=RenamedNames.Count-1 downto 0 do
  if AdvPos(RenamedNames[i],FHTMLText)<>0 then
  begin
   InvalInline;
  //if RenamedNames[i]<>RenamedNames[
   NewName:=TComponent(RenamedNames.Objects[i]).Name;
   FHTMLText:=HypeSubstText('<'+RenamedNames[i]+'>','<'+NewName+'>',FHTMLText);
   FHTMLText:=HypeSubstText('</'+RenamedNames[i]+'>','</'+NewName+'>',FHTMLText);
   FHTMLText:=HypeSubstText('<'+RenamedNames[i]+'/>','<'+NewName+'/>',FHTMLText);
  end;
  AssureRenamingAware(false);
 end;
end;

procedure TdhCustomLabel.AssureRenamingAware(HasChanges:boolean);
begin
 if TopStyleTree=nil then
 begin
  if not InCSSToWinControl then
  if HasChanges then
   NotifyCSSChanged([wcText,wcSize,wcNoOwnCSS]) else
   NotifyCSSChanged([wcNoOwnCSS]); //to call ParseHTML
 end;
end;




procedure TdhCustomLabel.SetHTMLText(const Value:HypeString);
var s:WideString;
begin
 s:=HypeSubstText(endl_space,'',Value);
 if FHTMLText<>s then
 begin
  FHTMLText:=s;
  if (csLoading in ComponentState) then exit;
  InvalInline;
  AssureRenamingAware(true);
 end;

 {FCommon.InvalTop;
 AdjustBounds;  }
end;



destructor TdhCustomLabel.Destroy;
begin
 InvalInline;
 Inherited;
end;



function TdhCustomLabel.GetHTMLState:TState;
var IsDown:boolean;
begin
  Result:=hsNormal;
  if (Self=glSelCompo) then
   Result:=hsOver;
  IsDown:=(csLButtonDown in ControlState){(Self=FClickedControl)};
  if IsDown then
  if (Result=hsOver) then
   Result:=hsOverDown else
   Result:=hsDown;
end;


{
function TdhCustomLabel.GetSpecialBorderType:TSpecialBorderType;
begin
  if (UseStyleTree<>nil) and (UseStyleTree.StyleElement<>nil) then
   result:=UseStyleTree.StyleElement.GetSpecialBorderType else
   result:=inherited GetSpecialBorderType;
end;
}

function ContainsStyleTree(Parent,Child:TStyleTree):boolean;
begin
 if Parent<>nil then
 while Child<>nil do
 if Child=Parent then
 begin
  result:=true;
  exit;
 end else
  Child:=Child.ParentStyle;
 result:=false;
end;


function TdhCustomLabel.DoGetVal(PropChoose:TPropChoose; const Align:TEdgeAlign; var DoExit:boolean):boolean; //{$IFDEF VER160}unsafe;{$ENDIF}
var StyleTree:TStyleTree;
    _LastActStyle:TState;
    InlinePn:TdhCustomPanel;

function GetStyleElement(StyleTree:TStyleTree):ICon;
begin
 result:=StyleTree.StyleElement;
 if result=nil then
  result:=self;
end;

function OuterLink(StyleTree:TStyleTree):TStyleTree;
begin
 result:=nil;
 while StyleTree<>nil do
 begin
  if GetStyleElement(StyleTree).GetCommon.ShallBeAnchor then
   result:=StyleTree;
  StyleTree:=StyleTree.ParentStyle;
 end;
end;

//var Cascaded_Display:TCSSDisplay;

begin
 result:=false;
 DoExit:=true;
 if UseStyleTree<>nil then
 begin
  StyleTree:=UseStyleTree;
  {if (StyleTree.StyleElement<>nil) and (StyleTree.StyleElement.GetCommon.Control is TdhLabel) and (TdhLabel(StyleTree.StyleElement.GetCommon.Control).UseStyleTree<>nil) then
   StyleTree:=UseStyleTree;}
  sUseStyleTree:=UseStyleTree;
  UseStyleTree:=nil; //prevent recursive call
  try
  while (StyleTree<>nil) and (StyleTree.StyleElement<>nil) do
  begin
  InlinePn:=StyleTree.StyleElement.GetCommon;
  _LastActStyle:=InlinePn.LastActStyle;
  try
  if RuntimeMode and not ShallBeAnchor then
   InlinePn.LastActStyle:=InlinePn.GetInlineHTMLState((LastActStyle in [hsOver,hsOverDown]) and ContainsStyleTree(OuterLink(ClientStyleTree),StyleTree),{Self=FClickedControl}(csLButtonDown in ControlState)) else
   InlinePn.LastActStyle:=LastActStyle;
  {if (ClientStyleTree=StyleTree) and not (InlineCommon.Control is TdhRule) then
   InlineCommon.LastActStyle:=FCommon.LastActStyle else
   InlineCommon.LastActStyle:=hsNormal;}
  if {(InlineCommon.Control<>self) and} (InlinePn.GetVal(PropChoose,Align,false)) then
  {if (PropChoose=pcDisplay) and (Cascaded.Display<>cdsNone) and not IsFromParent then
  begin
   Cascaded_Display:=Cascaded.Display;
  end else
  if not ((PropChoose=pcDisplay) and (StyleTree=TopStyleTree)) then      }
  begin
   result:=true;
   exit;
  end;
  finally
   InlinePn.LastActStyle:=_LastActStyle;
  end;
  IsFromParent:=true;
  if (PropChoose in [pcFontSize{only the computed value is inherited }]) or  not ({StyleTree.StyleElement.InheritProp(PropChoose)}PropChoose in AutoInherit) and not (PropChoose in [pcWhiteSpace,pcAntiAliasing]) then
  begin
   result:=false;
   exit;
  end;
  StyleTree:=StyleTree.ParentStyle;
  end;
  finally
   UseStyleTree:=sUseStyleTree;
  end;
 end;         
 {if (PropChoose=pcDisplay) and (Cascaded_Display<>cdsInherit) then
 begin
  Cascaded.Display:=Cascaded_Display;
  result:=true;
  exit;
 end;}
 DoExit:=false;
end;



{procedure TdhCustomLabel.PaintBorder;
begin
  brct:=BorderClientRect;
  rct:=MarginClientRect;
  SpecialPaintBorder(rct,brct);
end;}

procedure TdhCustomLabel.DoTopPainting;
begin
 PaintCaption;
 DrawFrame;
end;

procedure TdhCustomLabel.PaintCaption;
var R: TRect;
begin
    if IsDlg then
//    if FCommon.LastActStyle=hsOver then
    //if FMouseControl=self then
//    if Self=MyFindDragTarget(Mouse.CursorPos, True) then
    if self.FIsOver then
//     R:=ShrinkRect(GetClientRect,Rect(2,2,2,2));

    with GetCanvas do
    begin
     Brush.Color:=clBtnShadow;
     Pen.Style := psSolid;
//     Pen.Mode := pmNotXor;
     Pen.Color := 126+106*256+218*256*256;
     Brush.Style := bsSolid;
     Brush.Color:= 198+190*256+239*256*256;
     Rectangle(ShrinkRect(TotalRect,Rect(2,2,2,2)));
    end;    
    {//R:=GetAutoRect(Width,Height);
    OffsetRect(R,-R.Left,-R.Top);  }

    //R:=GetCanvas.ClipRect;
    R:=ActTopGraph.BoundsRect;

//    AdjustLittle(R,true,false);
//    OffsetRect(R,HPos,VPos); //Undo AdjustScrolling

    R:=ShrinkRect(R,ScrollEdgesPure);
                      
    if not TextOnly and not TextExclude then
    begin
     PaintOuterBg;
    end;
    if not glPaintOnlyBg then
     DoDrawText(R, false);
    if not TextOnly and not TextExclude then
    begin
     PaintOuterBorder;
    end;
end;

                       {
procedure TdhCustomLabel.AdjustLittle(var R:TRect; infl:boolean);
begin
 if infl then
 begin
  AdjustClientRect(R);
  R:=InflRect(R,FCommon.AllEdgesPure);
 end else
 begin
  NegRect(R);
  AdjustClientRect(R);
  R:=InflRect(R,FCommon.AllEdgesPure);
  NegRect(R);
 end;
end;
                         }

         
function TdhCustomLabel.TextOnly:boolean;
var tt:TTransformations;
begin
 result:=HasTransformations(tt) and tt.TextOnly;
end;

function TdhCustomLabel.TextExclude:boolean;
var tt:TTransformations;
begin
 result:=HasTransformations(tt) and tt.TextExclude;
end;

function TdhCustomLabel.CustomSizesForEffects:boolean;
begin
 result:=not TextExclude;
end;

function TdhCustomLabel.GetAutoRectPoint(AllowModifyX,AllowModifyY:boolean; NewWidth, NewHeight: Integer):TPoint;
var NewWidth2, NewHeight2: Integer;
    Avail,Req:TPoint;
    IsHorzScrollBarVisible,IsVertScrollBarVisible:boolean;
begin
 Req:=Point(NewWidth,NewHeight);
 GetInnerAutoRect(AllowModifyX,AllowModifyY,Req.X,Req.Y);
 Avail:=Point(NewWidth,NewHeight);
 AddScrollbarPlace(IsHorzScrollBarVisible,IsVertScrollBarVisible,AllowModifyX,AllowModifyY,Avail,Req);
 Result:=Avail;
end;


procedure TdhCustomLabel.GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
begin
 if GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth,NewHeight) then exit;
 with GetAutoRectPoint(AllowModifyX,AllowModifyY,NewWidth,NewHeight) do
 begin
  NewWidth:=X;
  NewHeight:=Y;
 end;
end;
                         
//NewWidth may be only read if AllowModifyX=false
//NewWidth always written
//NewHeight accordingly
procedure TdhCustomLabel.GetInnerAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
var
  Rect: TRect;
  FPicture: TPicture;
  PicHeight,PicWidth:integer;
  Transformations:TTransformations;
  T: TAffineTransformation;
  HorzRotated,VertRotated:boolean;
begin
    if (csLoading in ComponentState) then exit;
    assert( not (csLoading in ComponentState) );

    if GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth,NewHeight) then exit;


    Rect.TopLeft:=Point(0,0);

    Rect.Right:=NewWidth{-r.Left-r.Right};
    //Rect.Bottom:=Rect.Top;//max(Rect.Top,Rect.Bottom);
    Rect.Bottom:=maxint;

    T:=nil;
    if not EasyBounds(Transformations,T,Rect.Right,Rect.Bottom,HorzRotated,VertRotated) then
     Rect.Right:=maxint else
    //if not MeasureOverflow then
    //if not IsAdjustBounds or not(Align in [alClient,alTop,alBottom]) and (FCommon.ASXY in [asX,asXY]) then
    if AllowModifyX then
     Rect.Right:=maxint{not maxint, for Win98};
    FreeAndNil(T);

    DoDrawText(Rect,true);
    assert(Rect.Left=0);
    assert(Rect.Top=0);

    with AllEdgesPure do
    if TextOnly then
    begin
     Dec(Rect.Right,Left+Right);
     Dec(Rect.Bottom,Top+Bottom);
     Rect.Right:=Max(Rect.Right,MinWidth);
     Rect.Bottom:=Max(Rect.Bottom,MinHeight);
     AdjustLittle(Rect.Right,Rect.Bottom,false);
     Inc(Rect.Right,Left+Right);
     Inc(Rect.Bottom,Top+Bottom);
    end else
    begin
     Rect.Right:=Max(Rect.Right,MinWidth+(Left+Right));
     Rect.Bottom:=Max(Rect.Bottom,MinHeight+(Top+Bottom));
     if not TextExclude then
      AdjustLittle(Rect.Right,Rect.Bottom,false);
    end;
    (*
    if (Rect.Right=high(smallint){as csLoading}) {or EmptyContent} {or (Caption='') }then //case Caption=''
    begin
     Rect.Right:=Rect.Left;
     {if FCommon.IsAbsolutePositioned then
      //Rect.Bottom:=Rect.Top+(-Font.Height);
      inc(Rect.Bottom,-Font.Height);}
    end;*)

    //if AllowModifyX then
     NewWidth:=Rect.Right-Rect.Left;
    //if AllowModifyY then
     NewHeight:=Rect.Bottom-Rect.Top;

end;


function TdhCustomLabel.EmptyContent:boolean;
begin
 result:=gltext=markupEmptyEle;
end;

(*procedure TdhCustomLabel.AdjustBounds;
begin
  if not (csLoading in ComponentState) then
  begin
  if AutoSize{and (Parent<>nil)}{für WindowHandle}{ and (WindowHandle<>0)} then
  begin
    {Rect := GetAutoRect;

    if IsAdjustBounds then showmessage('IsAdjustBounds');
    IsAdjustBounds:=true;
    SetBounds(Left, Top, Rect.Right, Rect.Bottom);
    IsAdjustBounds:=false;}
//    AdjustSize;
{   Rect:=GetAutoRect(Width,Height);
   if AutoSizeVerticalOnly then
    Rect.Right:=Rect.Left+Width;
   SetBounds(Left, Top, Rect.Right-Rect.Left, Rect.Bottom-Rect.Top);
 } AdjustSize;

   //SetBounds(Left, Top, Width, Height);
  end;
//  UpdateScrollBars(false);
  end;
end; *)


{$IFNDEF VER160}

function _WStr(lpString: PWideChar; cchCount: Integer): WideString; //{$IFDEF VER160}unsafe;{$ENDIF}
begin
  if cchCount = -1 then
    Result := lpString
  else
    Result := Copy(WideString(lpString), 1, cchCount);
end;

{$ENDIF}

function TdhCustomLabel.CenterVertical:boolean;
begin
 result:=false;
end;

procedure BoxToContent(StyleTree:TStyleTree; var R:TRect);
begin
 inc(R.Top,StyleTree.TopLeading);
 dec(R.Bottom,StyleTree.BottomLeading);
end;

procedure AdjustBorder(StyleTree:TStyleTree; var R:TRect);
begin
 if StyleTree.IsBut or StyleTree.IsImg then
 begin
  inc(R.Top,StyleTree.AllEdgesPure.Top);
  dec(R.Bottom,StyleTree.AllEdgesPure.Bottom);
 end else
  BoxToContent(StyleTree,R);
end;


function TdhCustomLabel.FocContainer(ActLine:PLineInfo; ti:integer; var rct,brct:TRect; AvailY:integer):boolean; //{$IFDEF VER160}unsafe;{$ENDIF}
var StyleTree:TStyleTree;
    startx,endx,EndAt,ActLineY:integer;
begin
    StyleTree:=TStyleTree(ActLine.AllTrees[ti]);

    UseStyleTree:=StyleTree;
    try

    ActLineY:=ActLine.y;
    if CenterVertical{ and (StyleTree<>TopStyleTree)}{and (StyleTree.StyleElement<>nil)} then
     inc(ActLineY,(AvailY-TotalHeight) div 2);

    if (ti=0) then
     UseStyleTree.ry:=-ActLine.lmin+ActLineY else
    if (UseStyleTree.VerticalAlign=atTop) then
     UseStyleTree.ry:=0+ActLineY else
    if (UseStyleTree.VerticalAlign=atBottom) then
     UseStyleTree.ry:=ActLine.maxHeight-UseStyleTree.LineHeight+ActLineY else
    if UseStyleTree.RefStyleTree<>nil then
     UseStyleTree.ry:=UseStyleTree.VerticalAlign+UseStyleTree.RefStyleTree.ry else
     UseStyleTree.ry:=0; //sollte net eintreten
                        
    ActLineY:=ActLine.y;
    if CenterVertical and (StyleTree<>TopStyleTree) then
     inc(ActLineY,(AvailY-TotalHeight) div 2);

    if StyleTree.Blocking and (UseStyleTree.vn=ActLine.vn) then
    begin
     startx:=StyleTree.offs.Left;
     endx:=Avail-StyleTree.offs.Right;
     EndAt:=Lines[UseStyleTree.LastBlockLine].EndAt;
     if (UseStyleTree.img_width<>0){ and (StyleTree=TopStyleTree)}{ and CanAutoSizeX(Self)} then
      endx:=startx+UseStyleTree.img_width;
     if StyleTree=TopStyleTree then
      EndAt:=AvailY;
     UseStyleTree.PaddingRect:=Rect(startx,ActLineY-ActLine.offs.Top+UseStyleTree.offs.Top,endx,EndAt-Lines[UseStyleTree.LastBlockLine].offs.Bottom+UseStyleTree.offs.Bottom);
    end else
    begin
     if UseStyleTree.vn<ActLine.vn then
      startx:=0 else
      startx:=AddP(ActLine.vn,UseStyleTree.vn)+Ppre[UseStyleTree.vn]-UseStyleTree.toleft;
     if UseStyleTree.bs>ActLine.bs then
      endx:=ActLine.LineWidth else
      endx:=(AddP(ActLine.vn,UseStyleTree.bs-1)+Ppre[UseStyleTree.bs-1]+P[UseStyleTree.bs-1]+Psuc[UseStyleTree.bs-1])-Psuc[UseStyleTree.bs-1]+UseStyleTree.toright;
     inc(startx,ActLine.offs.Left);
     inc(endx,ActLine.offs.Left);
     UseStyleTree.PaddingRect:=Bounds(ActLine.RealOffsX+startx,{ActLineY+}UseStyleTree.ry,endx-startx,UseStyleTree.LineHeight);
     AdjustBorder(UseStyleTree,UseStyleTree.PaddingRect);
     if UseStyleTree.HasVerticalAlign and not OneFormattedChar(UseStyleTree,ActLine) then
     begin
      with FindChildContent(ActLine,UseStyleTree) do
      begin
       if X<>maxint then
       begin
       UseStyleTree.PaddingRect.Top:=X+UseStyleTree.RefStyleTree.ry;
       UseStyleTree.PaddingRect.Bottom:=Y+UseStyleTree.RefStyleTree.ry;
       end else
       begin
       UseStyleTree.PaddingRect.Top:=X; //maxint: empty rect
       UseStyleTree.PaddingRect.Bottom:=Y;
       end;
      end;
     end;
    end;
    //if UseStyleTree.ParentStyle=nil then continue;

    if StyleTree.Blocking and (UseStyleTree.vn<>ActLine.vn) then
    begin
     result:=false;
     exit;
    end;


    brct:=InflRect(UseStyleTree.PaddingRect,PaddingPure);
    rct:=BorderPure;
    if not StyleTree.Blocking then
    begin
    if UseStyleTree.vn<ActLine.vn then
     rct.Left:=0;
    if UseStyleTree.bs>ActLine.bs then
     rct.Right:=0;
    end;
    rct:=InflRect(brct,rct);
    result:=true;
    finally
     UseStyleTree:=nil;
    end;
end;


procedure TdhCustomLabel.DoStateTransition(OldState:TState);
begin
 ProcessMouseMove(true);
 Inherited;
end;

function TdhCustomLabel.AddP(vn,bs:integer):integer;
begin
 result:=0;
 for vn:=vn to bs-1 do
  inc(result,Pall[vn]);
end;


//Calcs width for character gltext[i]:
//Ppre[i]+P[i]+Psuc[i]=Pall[i]
//if StyleTree starts with character i: StyleTree.toleft part of Ppre[i]; StyleTree.toright occordingly
procedure TdhCustomLabel.CalcCharWidths;
var bs,vn,ii,toleft,toright,Fit:integer;
    StyleTree:TStyleTree;
    teil:string;
    Sz:TSize;
    Canvas:TCanvas;
    pi:^Integer;
{$IFNDEF CLX}
    DC: HDC;
{$ENDIF}   
{$IFDEF CLX}
    FontMetrics:QFontMetricsH;
{$ENDIF}
begin                
 //_AntiAliasing:=AntiAliasing;
 setlength(P,length(gltext)+1);
 setlength(Ppre,length(gltext)+1);
 setlength(Psuc,length(gltext)+1);
 setlength(Pall,length(gltext)+1);
 for ii:=0 to high(P) do
 begin
  P[ii]:=0;
  Psuc[ii]:=0;
  Ppre[ii]:=0;
 end;

 Canvas:=TCanvas.Create;
{$IFNDEF CLX}
  DC:=GetDC(0);
  Canvas.Handle:=DC;
{$ENDIF}
 try

  bs:=1;
  while bs<=high(Ptree) do
  begin
   StyleTree:=Ptree[bs];
   vn:=bs;
   inc(bs);
   while (bs<=high(Ptree)) and (StyleTree=Ptree[bs]) do
    inc(bs);

   UseStyleTree:=StyleTree;
   CSSToFont(Canvas.Font);

   if (gltext[vn]<>markupEmptyEle) then
   begin
{    if AAA and _AntiAliasing then
     Canvas.Font.Size:=Canvas.Font.Size * (1 shl AALevel);}
    sz.cx:=-20;
{$IFDEF CLX}
    FontMetrics:=QFontMetrics_create(Canvas.Font.Handle);
    try
//    QPainter_fontMetrics(Canvas.Handle,FontMetrics);
    for ii:=vn to bs-1 do
     P[ii]:=QFontMetrics_width(FontMetrics,@gltext[ii]);
    finally
     QFontMetrics_destroy(FontMetrics);
    end;
{$ELSE}
{$IFDEF VER160}
    pi:=@P[vn];
    GetTextExtentExPointW(Canvas.Handle, copy(gltext,vn,bs-vn),bs-vn, high(smallint), Fit, pi^{P[vn]}, Sz);
{$ELSE}
    GetTextExtentExPointW(Canvas.Handle, PWideChar(@gltext[vn]),bs-vn, high(smallint), @Fit, PInteger(@P[vn]), Sz);
    if sz.cx=-20 then
    begin
     teil:=AnsiString(_WStr(PWideChar(@gltext[vn]),bs-vn));
     GetTextExtentExPointA(Canvas.Handle, PChar(teil),length(teil), high(smallint), @Fit, PInteger(@P[vn]), Sz);
    end;
{$ENDIF}
   for ii:=bs-1 downto vn+1 do
    P[ii]:=P[ii]-P[ii-1];
{$ENDIF}
   end else
    P[vn]:=0;

   for ii:=vn to bs-1 do
   begin
    if gltext[ii]=markupBreak then
     P[ii]:=0;
   end;
   
   if StyleTree.IsImg then
    P[vn]:=StyleTree.img_width;

   toleft:=0;
   toright:=0;
   while StyleTree<>nil do
   begin
    if not StyleTree.Blocking then
    begin
     if StyleTree.vn=vn then
     begin
      StyleTree.toleft:=toleft;
      inc(toleft,StyleTree.AllEdgesPure.Left);
     end;
     if StyleTree.bs=bs then
     begin
      StyleTree.toright:=toright;
      inc(toright,StyleTree.AllEdgesPure.Right);
     end;
    end;
    StyleTree:=StyleTree.ParentStyle;
   end;
   Ppre[vn]:=toleft;
   Psuc[bs-1]:=toright;
  end;

  for ii:=1 to high(P) do
   Pall[ii]:=Ppre[ii]+P[ii]+Psuc[ii];

  CalcCharHeights(TopStyleTree,Canvas);

 finally
  FreeAndNil(Canvas);
{$IFNDEF CLX}
  ReleaseDC(0, DC);
{$ENDIF}
 end;


end;

procedure TdhCustomLabel.CalcCharHeights(StyleTree:TStyleTree; Canvas:TCanvas);
var
    w,tm_tmHeight,tm_tmAscent:integer;
{$IFNDEF CLX}
    tm:Textmetric;
{$ELSE}
    FontMetrics:QFontMetricsH;
{$ENDIF}
begin  
   UseStyleTree:=StyleTree;
   CSSToFont(Canvas.Font);
   StyleTree.FontSize:=Abs(Canvas.Font.Height);
                
{   if AAA and _AntiAliasing then
   begin
    for ii:=bs-1 downto vn do
     P[ii]:=(P[ii] + (1 shl AALevel - 1)) shr AALevel;
    tm_tmHeight:=(tm_tmHeight + (1 shl AALevel - 1)) shr AALevel;
    tm_tmAscent:=(tm_tmAscent + (1 shl AALevel - 1)) shr AALevel;
   end;}

{$IFDEF CLX}
   FontMetrics:=QFontMetrics_create(Canvas.Font.Handle);
   try
    //QPainter_fontMetrics(Canvas.Handle,FontMetrics);
    tm_tmAscent:=QFontMetrics_ascent(FontMetrics);
    tm_tmHeight:=QFontMetrics_height(FontMetrics);
   finally
    QFontMetrics_destroy(FontMetrics);
   end;
{$ELSE}
   GetTextMetrics(Canvas.Handle,tm);
   tm_tmHeight:=tm.tmHeight;
   tm_tmAscent:=tm.tmAscent;
{$ENDIF}


   StyleTree.LineHeight:=tm_tmHeight;

   if not StyleTree.IsImg then
   begin
    StyleTree.ContentHeight:=tm_tmHeight;
    StyleTree.Baseline:=tm_tmAscent;
   end;

   for w:=0 to StyleTree.Count-1 do
    CalcCharHeights(TStyleTree(StyleTree[w]),Canvas);

end;


procedure TdhCustomLabel.CalcLineBreaks;
var ActLine:PLineInfo;
    StartChar,BisChar:integer;
    margintop:integer;

procedure CreateNewLine(BlockStart:boolean); //{$IFDEF VER160}unsafe;{$ENDIF}
var ti:integer;
    StyleTree:TStyleTree;
    marginleft,marginright:integer;
    _margin,_border:TRect;
begin
    setlength(Lines,length(Lines)+1);
    ActLine:=@Lines[high(Lines)];
    marginleft:=0;
    marginright:=0;
    ActLine.offs:=Rect(0,0,0,0);
    ActLine.AllTrees:=TList.Create;
    StyleTree:=Ptree[BisChar];
    while StyleTree<>nil do
    begin
     ActLine.AllTrees.Insert(0,StyleTree);
     StyleTree:=StyleTree.ParentStyle;
    end;
    for ti:=0 to ActLine.AllTrees.Count-1 do
    begin
     StyleTree:=TStyleTree(ActLine.AllTrees[ti]);
     if not StyleTree.Blocking then continue;
     UseStyleTree:=StyleTree;
     if StyleTree.vn<BisChar then
     begin
      ActLine.offs.Left:=StyleTree.offs.Left;
      ActLine.offs.Right:=StyleTree.offs.Right;
     end else
     begin
     _margin:=MarginPure;
     _border:=BorderPure;
     AddRect(_border,PaddingPure);
     _border.Bottom:=0;

     if _margin.Top>marginTop then
     begin
      inc(ActLine.offs.Top,_margin.Top-marginTop);
      marginTop:=_margin.Top;
     end;
     if _border.Top<>0 then
       marginTop:=0;

     if _margin.Left>marginLeft then
     begin
      inc(ActLine.offs.Left,_margin.Left-marginLeft);
      marginLeft:=_margin.Left;
     end;
     if _border.Left<>0 then
       marginLeft:=0;

     if _margin.Right>marginRight then
     begin
      inc(ActLine.offs.Right,_margin.Right-marginRight);
      marginRight:=_margin.Right;
     end;
     if _border.Right<>0 then
       marginRight:=0;

     AddRect(ActLine.offs,_border);
     StyleTree.offs:=ActLine.offs;

     end;
    end;
    if BlockStart then
     ActLine.OffsX:=TextIndent;
    if avail=maxint then
     ActLine.lineavail:=avail else
     ActLine.lineavail:=avail-ActLine.OffsX-ActLine.offs.Right-ActLine.offs.Left;
end;

var
    take,i2,ii,ti:integer;
    _marginBottom,_borderBottom:integer;
    ForceBreak,BreakByBlock:boolean;
    StyleTree:TStyleTree;
    _WrapAlways:boolean;
    cx,delta,bs:integer;



begin                      
  UseStyleTree:=nil;
  _WrapAlways:=WrapAlways;

  setlength(Lines,0);
  StartChar:=1;
  BisChar:=1;
  take:=0;
  ActLine:=nil;
  MaxWidth:=0;
  margintop:=0;
  CreateNewLine(true);
  while BisChar<=length(gltext)+1 do
  begin
   ForceBreak:=false;
   BreakByBlock:=false;
   if not ForceBreak then
   begin
   if BisChar<=length(gltext) then
   begin
   take:=take+Pall[BisChar];
   StyleTree:=Ptree[BisChar];
   end else
    StyleTree:=nil{Ptree[BisChar-1]};

   //if not (take>ActLine.lineavail) then
   //if (BisChar=1) or (StyleTree<>Ptree[BisChar-1]) or (BisChar=length(gltext)) or (StyleTree<>Ptree[BisChar+1]) then
   while StyleTree<>nil do
   begin
    if StyleTree.Blocking then
    if (StartChar<>BisChar) and (StyleTree.vn=BisChar) then
    begin
     ForceBreak:=true;
     BreakByBlock:=true;
     break;
    end(* else
    if (StyleTree.bs=BisChar{+1}) then
    begin
     //inc(BisChar);
     ForceBreak:=true;
     BreakByBlock:=true;
     break;
    end*);
    StyleTree:=StyleTree.ParentStyle;
   end;

   if not ForceBreak and (BisChar-1>=1) then
   begin
   StyleTree:=Ptree[BisChar-1];
   while StyleTree<>nil do
   begin
    if StyleTree.Blocking then
    if (StartChar<>BisChar) and (StyleTree.bs=BisChar) then
    begin
     ForceBreak:=true;
     BreakByBlock:=true;
     break;
    end;
    StyleTree:=StyleTree.ParentStyle;
   end;
   end;


   end;
    if not ForceBreak and (gltext[BisChar]=markupBreak) then
   begin
    ForceBreak:=true;
    inc(BisChar);
   end;
   if ForceBreak or (take>ActLine.lineavail) then
   begin
    i2:=BisChar;

    if not ForceBreak then
    while (i2>StartChar) and (
     _WrapAlways and not((gltext[i2-1]=' ') and ({(gltext[i2-1]<>' ') or} {(i2+1<=high(Ptree)) and }(gltext[i2]<>' '))) or
     not _WrapAlways and
     not ((Ptree[i2].IsImg or (gltext[i2]=' ') and (Ptree[i2].WhiteSpace<>cwsPre)) and
         ((Ptree[i2-1].WhiteSpace=cwsNormal) or (Ptree[i2].WhiteSpace=cwsNormal) or (i2+1<=high(Ptree)) and (Ptree[i2+1].WhiteSpace=cwsNormal)))) do
      dec(i2);


    ii:=i2;
    while (ii>StartChar) and (gltext[ii-1]=' ') and (Ptree[ii-1].WhiteSpace<>cwsPre) do
     dec(ii);

    if not ForceBreak and (ii<=StartChar) then
    if _WrapAlways and (BisChar>StartChar) then
    begin
     i2:=BisChar;
     ii:=i2;
    end else
    begin
     inc(BisChar);
     continue;
    end;


    BisChar:=i2;
    while (BisChar<length(gltext)) and (gltext[BisChar]=' ') and (Ptree[BisChar].WhiteSpace<>cwsPre) do
     inc(BisChar);

   if not ((gltext[StartChar]=markupEmptyEle) and not Ptree[StartChar].IsImg) then
//    if gltext[StartChar]<>markupEmptyEle then
     margintop:=0;

    ActLine.offs.Bottom:=0;
    for ti:=ActLine.AllTrees.Count-1 downto 0 do
    begin
     StyleTree:=TStyleTree(ActLine.AllTrees[ti]);
     if not StyleTree.Blocking then continue;
     UseStyleTree:=StyleTree;
     StyleTree.LastBlockLine:=high(Lines);
     if StyleTree.bs>BisChar then
     begin
     end else
     begin
     _marginBottom:=MarginPure.Bottom;
     _borderBottom:=BorderPure.Bottom;
     inc(_borderBottom,PaddingPure.Bottom);

     StyleTree.offs.Bottom:=ActLine.offs.Bottom;
     inc(ActLine.offs.Bottom,_borderBottom);

     if _borderBottom<>0 then
       marginTop:=0;
     if _marginBottom>marginTop then
     begin
      inc(ActLine.offs.Bottom,_marginBottom-marginTop);
      marginTop:=_marginBottom;
     end;

     end;
    end;

    ActLine.InlineBreak:=not ForceBreak;
    ActLine.vn:=StartChar;
    ActLine.bs:=ii;

    
    bs:=Actline.bs;
    while (bs>Actline.vn) and (gltext[bs-1]=markupBreak) do
     dec(bs);
    if (bs>Actline.vn) and (gltext[bs-1]<>markupEmptyEle) then
    begin
    UseStyleTree:=Ptree[bs-1];
    if Italic then
    begin
     {cx:=TextExtent(gltext[bs-1]).cx;
     delta:=cx-P[bs-1];}
     //delta:=P[bs-1] div 3;
     delta:=round({TextExtent(gltext[bs-1]).cy}UseStyleTree.ContentHeight{set in CalcCharHeights}/4.65);
     if delta<>0 then
     begin
      inc(Psuc[bs-1],delta);
      inc(Pall[bs-1],delta);
     end;
    end;
    //inc(Pall[bs-1],Psuc[bs-1]);
    UseStyleTree:=nil;
    end;

    ActLine.LineWidth:=AddP(ActLine.vn,ActLine.bs);
    MaxWidth:=max(MaxWidth,ActLine.OffsX+ActLine.LineWidth+ActLine.offs.Left+ActLine.offs.Right);
    take:=0*take;
    StartChar:=BisChar;
    if BisChar<=length(gltext) then
     CreateNewLine(BreakByBlock) else
     break;
   end else
    inc(BisChar);
  end;

end;


function TdhCustomLabel.FindChildContent(ActLine:PLineInfo; _StyleTree:TStyleTree):TPoint;
var lmin,lmax,w,i:integer;
    StyleTree:TStyleTree;
begin
 lmin:=maxint;
 lmax:=-maxint;

 for w:=0 to _StyleTree.Count-1 do
 begin

 StyleTree:=TStyleTree(_StyleTree[w]);
 if StyleTree.HasVerticalAlign then
 begin
  if OneFormattedChar(StyleTree,ActLine) then
  begin
   lmin:=min(lmin,StyleTree.VerticalAlign);
   lmax:=max(lmax,StyleTree.VerticalAlign+StyleTree.LineHeight);
  end;
  with FindChildContent(ActLine,StyleTree) do
  begin
   lmin:=min(lmin,x);
   lmax:=max(lmax,y);
  end;
 end;

 end;
 result.X:=lmin;
 result.Y:=lmax;
end;

//calculates offset of box's base line to parent box's base line
//a button's line-height is expanded to include all inline boxes (top and bottom box edge)
function TdhCustomLabel.CalcVertOffset(StyleTree:TStyleTree):TPoint;
var w,VPercent,lmin,lmax:integer;
begin

 lmin:=-StyleTree.Baseline;
 lmax:=StyleTree.ContentHeight-StyleTree.Baseline;

 for w:=0 to StyleTree.Count-1 do
 with CalcVertOffset(TStyleTree(StyleTree[w])) do
 begin
  lmin:=min(lmin,x);
  lmax:=max(lmax,y);
 end;


 UseStyleTree:=StyleTree;

 if not GetVal(pcLineHeight) then
  Cascaded.LineHeight:='normal';
 StyleTree.LineHeight:=GetLineHeight(Cascaded.LineHeight,StyleTree.LineHeight,ComputedFontSize);


 //VPercent:=StyleTree.LineHeight; //für image oder button muß alte line-height bei GetVerticalAlignPixels verwendet werden (bei anderen bleibt line-height unverändert)
 VPercent:=ComputedFontSize; //eigentlich line-height (nach css spec, firefox macht ähnliches), doch lieber wie IE machen

 if StyleTree.IsImg then
 begin
  StyleTree.LineHeight:=StyleTree.ContentHeight;
 end else
 if StyleTree.IsBut then
 begin
  VPercent:=StyleTree.LineHeight; //wie firefox
  dec(lmin,StyleTree.AllEdgesPure.Top);
  inc(lmax,StyleTree.AllEdgesPure.Bottom);
  StyleTree.LineHeight:=lmax-lmin;
  StyleTree.TopLeading:=((-lmin)-StyleTree.Baseline);
 end else
 begin
  StyleTree.TopLeading:=(StyleTree.LineHeight-StyleTree.ContentHeight) div 2;
  dec(lmin,StyleTree.TopLeading);
  inc(lmax,StyleTree.BottomLeading);
 end;

 StyleTree.VerticalAlign:=atBottom;
 if (StyleTree.ParentStyle<>nil) then
 begin
  if not GetVal(pcVerticalAlign) then
   Cascaded.VerticalAlign:='baseline';
  StyleTree.VerticalAlign:=GetVerticalAlignPixels(Cascaded.VerticalAlign,StyleTree.ParentStyle.Baseline,StyleTree.ParentStyle.ContentHeight,StyleTree.TopLeading+StyleTree.Baseline,StyleTree.LineHeight,VPercent);
 end;

 if (StyleTree.VerticalAlign<>atBottom) and (StyleTree.VerticalAlign<>atTop) then
 begin
  result.X:=lmin+StyleTree.VerticalAlign;
  result.Y:=lmax+StyleTree.VerticalAlign;
 end else
 begin
  result.X:=maxint;
  result.Y:=-maxint;
 end;
end;

function TStyleTree.HasVerticalAlign:boolean;
begin
 result:=(VerticalAlign<>atBottom) and (VerticalAlign<>atTop);
end;



//calculates vert. offset of box's(StyleTree) top edge to the first ascendant's(RefStyleTree) box edge with vertical-align<>none
procedure TdhCustomLabel.CalcVertOffsetAccumulate(StyleTree,RefStyleTree:TStyleTree);
var w:integer;
begin
 StyleTree.RefStyleTree:=RefStyleTree;
 if StyleTree.HasVerticalAlign then
 begin
  StyleTree.VerticalAlign:=StyleTree.ParentStyle.TopLeading+StyleTree.ParentStyle.Baseline-(StyleTree.TopLeading+StyleTree.BaseLine)+StyleTree.VerticalAlign;
  if StyleTree.ParentStyle.HasVerticalAlign then
   StyleTree.VerticalAlign:=StyleTree.ParentStyle.VerticalAlign+StyleTree.VerticalAlign;
 end else
  RefStyleTree:=StyleTree;
 for w:=0 to StyleTree.Count-1 do
  CalcVertOffsetAccumulate(TStyleTree(StyleTree[w]),RefStyleTree);
end;


procedure TdhCustomLabel.FillAllTrees;
var line,w,le:integer;
    ActLine:PLineInfo;
    StyleTree:TStyleTree;
    PStyleTree:TStyleTree;
begin
 for line:=0 to high(Lines) do
 begin
  ActLine:=@Lines[line];   
  StyleTree:=nil;
  for w:=ActLine.vn to ActLine.bs-1 do
  if StyleTree<>Ptree[w] then //speed
  begin
   StyleTree:=Ptree[w];
   le:=ActLine.AllTrees.Count;
   PStyleTree:=StyleTree;
   while PStyleTree<>nil do
   begin
    if ActLine.AllTrees.IndexOf(PStyleTree)<>-1 then
     break;
    ActLine.AllTrees.Insert(le,PStyleTree);
    PStyleTree:=PStyleTree.ParentStyle;
   end;
  end;
 end;
end;


function TdhCustomLabel.OneFormattedChar(StyleTree:TStyleTree; ActLine:PLineInfo):boolean;
var vn:integer;
begin
 for vn:=max(StyleTree.vn,ActLine.vn) to min(StyleTree.bs,ActLine.bs)-1 do
 if (Ptree[vn]=StyleTree){ and (gltext[vn]<>markupBreak)} and not((gltext[vn]=markupEmptyEle) and not Ptree[vn].IsImg) then
 begin
  result:=true;
  exit;
 end;
 result:=not IsNullRect(StyleTree.AllEdgesPure) and not StyleTree.Blocking;
end;





procedure TdhCustomLabel.CalcMinMax;
var line:integer;
    ActLine:PLineInfo;
    ti,vn:integer;
    StyleTree:TStyleTree;
begin

 TotalHeight:=0;
 for line:=0 to high(Lines) do
 begin
  ActLine:=@Lines[line];
  {if l+1<=high(Lines) then
   ActLine.bs:=Lines[l+1].vn else
   ActLine.bs:=length(gltext)+1;  }

  ActLine.maxHeight:=0;
  ActLine.lmin:=0;
  //if not ((ActLine.vn+1=ActLine.bs) and (gltext[ActLine.vn]=markupEmptyEle) and not Ptree[ActLine.vn].IsImg {or (ActLine.vn=ActLine.bs) }) then
  begin
  { for ti:=0 to ActLine.AllTrees.Count-1 do
   begin
    StyleTree:=TStyleTree(ActLine.AllTrees[ti]);
    StyleTree.lmin:=maxint;
    StyleTree.lmax:=-maxint;
   end;   }
   {for vn:=ActLine.vn to ActLine.bs-1 do
   if (Ptree[vn].lmin=maxint) and (gltext[vn]<>markupBreak) and not((gltext[vn]=markupEmptyEle) and not Ptree[vn].IsImg) then
   begin
    StyleTree:=Ptree[vn];
    if StyleTree.attach<>atNone then
    begin
     StyleTree.lmin:=0;
     StyleTree.lmax:=StyleTree.tmHeight;
    end else
    begin
     StyleTree.lmin:=StyleTree.Top;
     StyleTree.lmax:=StyleTree.Top+StyleTree.tmHeight;
    end;
   end;    }


   for ti:=ActLine.AllTrees.Count-1 downto 0 do
   begin
    StyleTree:=TStyleTree(ActLine.AllTrees[ti]);
    if not OneFormattedChar(StyleTree,ActLine) then
    begin
     StyleTree.lmin:=maxint;
     StyleTree.lmax:=-maxint;
    end else
    if StyleTree.HasVerticalAlign then
    begin
     StyleTree.lmin:=StyleTree.VerticalAlign;
     StyleTree.lmax:=StyleTree.VerticalAlign+StyleTree.LineHeight;
    end else
    begin
     StyleTree.lmin:=0;
     StyleTree.lmax:=StyleTree.LineHeight;
    end;
   end;


   for ti:=ActLine.AllTrees.Count-1 downto 0 do
   begin
    StyleTree:=TStyleTree(ActLine.AllTrees[ti]);
    if not StyleTree.HasVerticalAlign then
    begin
     if StyleTree.lmin<>maxint then
     //if StyleTree.ParentStyle=nil then //not-outermost bottom/top valigned boxes shall not determine height, =firefox, <>IE
     //if StyleTree.lmax-StyleTree.lmin>ActLine.maxHeight then
     begin
      ActLine.maxHeight:=StyleTree.lmax-StyleTree.lmin;
      ActLine.lmin:=StyleTree.lmin;
     end;
    end else
    begin
     StyleTree.ParentStyle.lmin:=min(StyleTree.ParentStyle.lmin,StyleTree.lmin);
     StyleTree.ParentStyle.lmax:=max(StyleTree.ParentStyle.lmax,StyleTree.lmax);
    end;
    {if StyleTree.lmin<>maxint then
    if not OneFormattedChar(StyleTree,ActLine) then
    begin
     StyleTree.LineHeight:=StyleTree.lmax-StyleTree.VerticalAlign;
     StyleTree.ContentHeight:=StyleTree.lmax-StyleTree.VerticalAlign;
     StyleTree.VerticalAlign:=StyleTree.lmin;
    end; }
   end;

   (*StyleTree:=TStyleTree(ActLine.AllTrees[0]);
   if StyleTree.lmin=maxint then
   begin
    StyleTree.lmin:=StyleTree.Top;
    ActLine.maxHeight:=max(ActLine.maxHeight,StyleTree.tmHeight);
      //StyleTree.lmax:=StyleTree.Top+StyleTree.tmHeight;
   end;
   //ActLine.maxHeight:={glmax-glmin}StyleTree.lmax-StyleTree.lmin;
   ActLine.lmin:=StyleTree.lmin;*)
  end;

  inc(TotalHeight,ActLine.maxHeight+ActLine.offs.Top+ActLine.offs.Bottom);
  ActLine.endat:=TotalHeight;
 end;

end;

procedure TdhCustomLabel.DistributeWidth;
var ActLine:PLineInfo;
    i,y,l,kuchen,ti:integer;
    _TextAlign:TCSSTextAlign;
    prev,prev2,spaces,actspace:integer;
    StyleTree:TStyleTree;
begin

  _TextAlign:=ctaCenter;//Set value only to compile without warnings. Value should never be used.
  y:=0;
  for l:=0 to high(Lines) do
  begin
   ActLine:=@Lines[l];
   for ti:=ActLine.AllTrees.Count-1 downto 0 do
   begin
    StyleTree:=TStyleTree(ActLine.AllTrees[ti]);
    if StyleTree.Blocking then
    begin
     UseStyleTree:=StyleTree;
     _TextAlign:=TextAlign;
     if (_TextAlign=ctaJustify) and CanAutoSizeX(Self) then
      _TextAlign:=ctaLeft;
     UseStyleTree:=nil;
     break;
    end;
   end;
   inc(y,ActLine.offs.Top);
   ActLine.y:=y;
   ActLine.RealOffsX:=0;
   kuchen:=ActLine.lineavail-ActLine.LineWidth;
   if _TextAlign=ctaRight then
    ActLine.RealOffsX:=max(kuchen,0) else
   if _TextAlign=ctaCenter then
    ActLine.RealOffsX:=max(kuchen div 2,0) else
   if (_TextAlign=ctaJustify) and (ActLine.InlineBreak or ForceJustify) then
   begin
    ActLine.LineWidth:=ActLine.lineavail;
    spaces:=0;
    for i:=ActLine.vn to ActLine.bs-1 do
    if gltext[i]=' ' then
      inc(spaces);
    prev:=0;
    actspace:=0;
    for i:=ActLine.vn to ActLine.bs-1-1 do
    if gltext[i]=' ' then
    begin
     inc(actspace);
     prev2:=round(kuchen*actspace/spaces);
     inc(Pall[i],prev2-prev);
     prev:=prev2;
    end;
   end;
   inc(ActLine.RealOffsX,ActLine.OffsX);
   inc(y,ActLine.maxHeight+ActLine.offs.Bottom);
  end;
end;




procedure TdhCustomLabel.Prefetch(StyleTree:TStyleTree);
var w:integer;
begin
 if UseStyleTree=nil then
  StyleTree.FontSize:=GetComputedFontSize else
  StyleTree.FontSize:=GetFontSizePixels(FontSize,StyleTree.ParentStyle.FontSize);
 StyleTree.AllEdgesPure:=AllEdgesPure;
 StyleTree.IsBut:=Referer.TotalInlineBox and (StyleTree.ParentStyle<>nil);
 if StyleTree.IsImg and HasImage(StyleTree.img_width,StyleTree.ContentHeight) then
 begin
  with PaddingPure do
  begin
   dec(StyleTree.img_width,Left+Right);
   dec(StyleTree.ContentHeight,Top+Bottom);
  end;
  StyleTree.ContentHeight:=StyleTree.ContentHeight+StyleTree.AllEdgesPure.Top+StyleTree.AllEdgesPure.Bottom;
  StyleTree.Baseline:=StyleTree.ContentHeight;
 end;
 for w:=0 to StyleTree.Count-1 do
 begin
  UseStyleTree:=TStyleTree(StyleTree[w]);
  Prefetch(UseStyleTree);
  UseStyleTree:=nil;
 end;
end;




procedure TdhCustomLabel.BuildLines;
begin
 try
  Prefetch(TopStyleTree);
  CalcCharWidths;
  CalcLineBreaks;
  FillAllTrees;
  CalcVertOffset(TopStyleTree);
  CalcVertOffsetAccumulate(TopStyleTree,nil);
  CalcMinMax;
  DistributeWidth;
 finally
  UseStyleTree:=nil;
 end;
end;


function inttoroman(i:integer):string;
const b10:  array[0..9] of string=('','I','II','III','IV','V','VI','VII','VIII','IX');
const b100: array[0..9] of string=('','X','XX','XXX','XL','L','LX','LXX','LXXX','XC');
const b1000:array[0..9] of string=('','C','CC','CCC','CD','D','DC','DCC','DCCC','CM');
begin
 result:=b1000[(i div 100) mod 10]+b100[(i div 10) mod 10]+b10[i mod 10];
end;

function inttoalpha(i:integer):string;
begin
 result:='';
 inc(i);
 while i>0 do
 begin
  dec(i);
  result:=chr(ord('A')+(i mod 26))+result;
  i:=i div 26 ;
 end;
end;



function TdhCustomLabel.ClientStyleTree:TStyleTree;
var act_pos:integer;


function FindStartTag(StyleTree:TStyleTree):TStyleTree;
var c:TStyleTree;
    i:integer;
begin
   for i:=StyleTree.Count-1 downto 0 do
   begin
    c:=TStyleTree(StyleTree[i]);
    if c.starttag>ClientStyleTree_starttag[act_pos] then
    begin
     continue;
    end;
    if c.starttag=ClientStyleTree_starttag[act_pos] then
    begin
     result:=c;
     exit;
    end;
    c:=FindStartTag(c);
    if c<>nil then
    begin
     result:=c;
     exit;
    end;
   end;
   while (act_pos<high(ClientStyleTree_starttag)) and (StyleTree.starttag<ClientStyleTree_starttag[act_pos]) do
    inc(act_pos);
   if StyleTree.starttag=ClientStyleTree_starttag[act_pos] then
   begin
    result:=StyleTree;
    exit;
   end;
   result:=nil;
end;
                {
var StyleTree,c:TStyleTree;
    i:integer;
    resume:boolean;      }
begin
 //nicht .endtag benutzen da innerhalb von ParseHTML noch nicht gesetzt, aber .starttag schon gesetzt
 if (TopStyleTree<>nil) and (length(ClientStyleTree_starttag)>=1)(*(ClientStyleTree_starttag>=1) and (ClientStyleTree_starttag<=length(FHTMLText)){ and (ClientStyleTree_starttag<=high(Ptree))}*) then
 begin
  act_pos:=0;
  result:=FindStartTag(TopStyleTree);
  exit;
   {
  StyleTree:=TopStyleTree;
  repeat
   resume:=false;
   for i:=0 to StyleTree.Count-1 do
   begin
    c:=TStyleTree(StyleTree[i]);
    if c.starttag=ClientStyleTree_starttag then
    begin
     result:=c;
     exit;
    end else
    if (ClientStyleTree_starttag>=c.starttag) and (ClientStyleTree_starttag<=c.endtag) then
    begin
     StyleTree:=c;
     resume:=true;
     break;
    end;
   end;
  until not resume;}
 end;
 result:=nil;
end;




procedure TdhCustomLabel.FreeLines;
var l:integer;
begin
  //ClientStyleTree:=nil;
  //ClientAnchor:=nil;
  for l:=0 to high(Lines) do
   Lines[l].AllTrees.Free;
  SetLength(Lines,0);
end;



procedure TdhCustomLabel.FocusPreferStyle(IsMain,RealChange:boolean);
begin
 inherited FocusPreferStyle(IsMain,RealChange or glPaintOnlyBg);
end;

{procedure TdhCustomLabel.PreferStyleChange;
begin
 Inherited;
 InvalInline;
 ParseHTML; //müssen wir machen, da wir auf Namen-Änderungen reagieren müssen
end;
 }
function TdhCustomLabel.GetComputedFontSize:single;
begin
 if (UseStyleTree=nil){ or (UseStyleTree.ParentStyle=nil)} then
 begin
  {result:=HasParent;
  if result then
   res:=-TFakeControl(Parent).Font.Height;}
  result:=inherited GetComputedFontSize;
  exit;
 end;
 result:=UseStyleTree.FontSize;  {
 _UseStyleTree:=UseStyleTree;
 try
  if ReferParent then
   UseStyleTree:=UseStyleTree.ParentStyle;
  //result:=FCommon.GetFontSize(res);
  res:=FCommon.FontSizePx;
  result:=true;
 finally
 UseStyleTree:=_UseStyleTree;
 end;         }
end;


var toba:boolean;

var HelpB:TBitmap32;


{$R-}
procedure BlackWhiteReplace(Bt:TBitmap32; w,h:integer; Color:TColor32);
var P: PColor32;
    x,y:integer;
begin
 Color:=Color and $FFFFFF;
 for y:=0 to H-1 do
 begin
 P:=Bt.PixelPtr[0,y];
 for x:=0 to w-1 do
 begin
//  if integer(p) div 10 mod 2=1 then
  P^:=dword(min(($FF-GreenComponent(P^))*5 div 4,$FF)) shl 24 or Color;
  inc(P);
 end;
 end;
 Bt.DrawMode:=dmBlend;
end;


procedure TdhCustomLabel.PaintListItem;
var StyleTree:TStyleTree;
    ListItemPosition,ListX,ListY:integer;      
    ListItemRct:TRect;
    sListItemPosition:string;
    sListItemPositionWide:string;
begin
     StyleTree:=UseStyleTree;
     ListX:=brct.Left-BorderPure.Left;
     ListY:=StyleTree.PaddingRect.Top;
     CSSToFont(Canvas.Font);
     Canvas.Brush.Style:=bsClear;
     if ListStyleType in [clsDisk,clsCircle,clsSquare] then
     begin
     if ListStyleType in [clsDisk,clsSquare] then
      Canvas.Brush.Color:=Canvas.Font.Color;
     Canvas.Pen.Color:=Canvas.Font.Color;
     Canvas.Pen.Style:=psSolid;
     Canvas.Pen.Width:=1;
     ListItemRct:=Bounds(ListX-12,ListY+StyleTree.Baseline-6,5,5);
     case ListStyleType of
      clsDisk: Canvas.Ellipse(ListItemRct);
      clsCircle: Canvas.Ellipse(ListItemRct);
      clsSquare: Canvas.FillRect(ListItemRct);
      clsNone:;
     end;
     end else
     if ListStyleType<>clsNone then
     begin
      if StyleTree.ParentStyle=nil then
       ListItemPosition:=0 else
       ListItemPosition:=StyleTree.ParentStyle.IndexOf(StyleTree);
      case ListStyleType of
       clsDecimal: sListItemPosition:=inttostr(ListItemPosition+1);
       clsLowerRoman,clsUpperRoman: sListItemPosition:=inttoroman(ListItemPosition+1);
       clsLowerAlpha,clsUpperAlpha: sListItemPosition:=inttoalpha(ListItemPosition+1);
      end;
      if ListStyleType in [clsLowerRoman,clsLowerAlpha] then
       sListItemPosition:=LowerCase(sListItemPosition);
      sListItemPosition:=sListItemPosition+'.';
{$IFDEF CLX}
      sListItemPositionWide:=sListItemPosition;
      QPainter_drawText(Canvas.Handle, ListX-Canvas.TextWidth(sListItemPositionWide)-10, ListY, PWideString(@sListItemPositionWide), length(sListItemPositionWide));
{$ELSE}
      ExtTextOut(Canvas.Handle, ListX-Canvas.TextWidth(sListItemPosition)-10, ListY, 0, nil, shell_pchar(sListItemPosition), length(sListItemPosition), nil);
{$ENDIF}
     end;
end;


procedure TdhCustomLabel.DoDrawText(var ConstraintsRect: TRect; CalcRect:boolean); //{$IFDEF VER160}unsafe;{$ENDIF}
var line,ti,x,y,vn,bs:integer;
    ActLine:PLineInfo;
    rct,brct,rct2,rct3,TextRct:TRect;
    StyleTree:TStyleTree;
    TextSizes:TPoint;
//    dyn:TIntegerDynArray;
    StyleElement:ICon;
    SaveIndex: Integer;
    ClpRct:TRect;
    _AntiAliasing:boolean;
                            
var c1,c2:int64;

var        
{$IFNDEF CLX}     
  LogFont: TLogFont;        
  fh:HFont;
{$ENDIF}
  Canvas:TCanvas;
  OldClipRect:TRect;
begin
// if (csLoading in ComponentState) then exit;

 ParseHTML;
 if TopStyleTree<>nil then
 begin
  //FreeLines;

  if (length(Lines)=0) or (avail<>ConstraintsRect.Right-ConstraintsRect.Left) then
  begin
   FreeLines;
   avail:=ConstraintsRect.Right-ConstraintsRect.Left;
   BuildLines;
  end else
   avail:=ConstraintsRect.Right-ConstraintsRect.Left;


  if CalcRect then
  begin
   ConstraintsRect.Right:=MaxWidth;
   ConstraintsRect.Bottom:=TotalHeight;
  end else
  begin
  _AntiAliasing:=AntiAliasing;
  Canvas:=GetCanvas;
  SaveIndex:=0;
  ClpRct:=ConstraintsRect;
  {rct:=FCommon.MarginClientRect;
  brct:=FCommon.BorderClientRect;
  FCommon.SpecialBg(rct,brct);
  FCommon.SpecialPaintBorder(rct,brct); }
{$IFNDEF CLX}
  QueryPerformanceCounter(c1);
{$ENDIF}
  for line:=0 to high(Lines) do
  begin

   ActLine:=@Lines[line];
  { try
   for ti:=0 to ActLine.AllTrees.Count-1 do;
   except
   end;    }

   for ti:=0 to ActLine.AllTrees.Count-1 do
   if FocContainer(ActLine,ti,rct,brct,ConstraintsRect.Bottom-ConstraintsRect.Top) then
   begin
   OffsetRect(rct,ConstraintsRect.Left,ConstraintsRect.Top);
   OffsetRect(brct,ConstraintsRect.Left,ConstraintsRect.Top);
   StyleTree:=TStyleTree(ActLine.AllTrees[ti]);
   UseStyleTree:=StyleTree;
   if StyleTree=TopStyleTree then
   begin
    ClpRct:=brct;
{$IFNDEF CLX}
{    if SaveIndex=0 then //only needed for SpecialPaintBorder
    begin
     SaveIndex := SaveDC(Canvas.Handle);
     IntersectClipRect(Canvas.Handle, brct.Left,brct.Top,brct.Right,brct.Bottom);
    end; }
{$ENDIF}
   end else
   //if ti<>0 then //=0 wird am Anfang schon gezeichnet (TopStyleTree)
   if Visibility{ and not ((Display=cdsNone) and (TopStyleTree<>StyleTree))} then
   begin
    OffsetRect(brct,-HPos,-VPos);
    OffsetRect(rct,-HPos,-VPos);
    if Display=cdsListItem then
     PaintListItem(Canvas,brct);

        {
    if SaveIndex=0 then
    begin
     rct.Top:=0;
    end;      }
    //if OneFormattedChar(UseStyleTree,ActLine) then         Würde Hintergrundfarbe nicht zeichnen
    //if not OneFormattedChar(UseStyleTree,ActLine) then
    // FocContainer(ActLine,ti,rct,brct,ConstraintsRect.Bottom-ConstraintsRect.Top);
    begin
     IntersectRect(rct2,rct,ClpRct);
     if not IsRectEmpty(rct2) then
      SpecialPaintBorder(rct,brct);
     rct:=rct2;
     rct3:=brct;
     IntersectRect(brct,brct,ClpRct);
     //if UseStyleTree<>TopStyleTree then
     SpecialBg(rct3,rct3,ActTopGraph,brct,false{,Point(0,0)});
    end;
   end;
   end;

   x:=ConstraintsRect.Left+ActLine.offs.Left-HPos;
   y:=ConstraintsRect.Top-VPos;
   UseStyleTree:=nil;
   bs:=ActLine.vn;
   while bs<ActLine.bs do
   begin
    vn:=bs;
    inc(bs);
    if gltext[vn]<>markupEmptyEle then
    begin
    StyleTree:=Ptree[vn];
    while (bs<ActLine.bs) and (StyleTree=Ptree[bs]) and (gltext[bs]<>markupBreak) do
     inc(bs);

    UseStyleTree:=StyleTree;
    CSSToFont(Canvas.Font);

    dec(Pall[vn],Ppre[vn]);
    dec(Pall[bs-1],Psuc[bs-1]);
    try

   TextRct:=Bounds(ActLine.RealOffsX+x+Ppre[vn], UseStyleTree.ry+y, AddP(vn,bs), UseStyleTree.LineHeight);
   BoxToContent(StyleTree,TextRct);

   if DoIntersectStrong(TextRct,ClpRct) and Visibility{ and not ((Display=cdsNone) and (TopStyleTree<>StyleTree))} then
   begin
   if Overline then
   begin
    Canvas.Brush.Style:=bsSolid;
    Canvas.Brush.Color:=Canvas.Font.Color;
    //Canvas.Pen.Style:=psClear;
    Canvas.FillRect(Bounds(TextRct.Left, TextRct.Top, TextRct.Right-TextRct.Left, 1));
    //Canvas.Pen.Style:=psSolid;
   end;

    Canvas.Brush.Color:=clRed; //seems to be necessary, otherwise TextOut is not transparent
    Canvas.Brush.Style:=bsClear;

    toba:=not toba;

    if not _AntiAliasing then
    begin
{$IFDEF CLX}
     Canvas.TextRect(ClpRct, TextRct.Left, TextRct.Top, copy(gltext,vn, bs-vn));
{$ELSE}
//     Canvas.TextRect(ClpRct, TextRect.Left, TextRect.Top,  copy(gltext,vn, bs-vn));
     ExtTextOutW(Canvas.Handle, TextRct.Left, TextRct.Top, ETO_CLIPPED, @ClpRct, PWideChar(@gltext[vn]), bs-vn, PInteger(@Pall[vn]));
{$ENDIF}
    end else
{$IFNDEF CLX}
    if not AAA then
    begin

    GetObject(Canvas.Font.Handle,
            SizeOf(LogFont),
            @LogFont);
    LogFont.lfQuality := {PROOF_QUALITY}ANTIALIASED_QUALITY{NONANTIALIASED_QUALITY };
{            if toba and false then
   LogFont.lfQuality := ANTIALIASED_QUALITY else
   LogFont.lfQuality:=0;}

//   LogFont.lfOutPrecision:=7;
//   LogFont.lfEscapement:=-900;

    fh:=CreateFontIndirect(LogFont);
    Canvas.Font.Handle := fh;

     {GetFontUnicodeRanges
         GetTextCharsetInfo  }
//  SelectObject(Canvas.Handle, Canvas.Font.Handle);

{.$IFDEF VER160}
    //dyn:=copy(Pall,vn,bs-vn);
//    ExtTextOutW(Canvas.Handle, ActLine.RealOffsX+x+Ppre[vn], UseStyleTree.ry+y, 0, Rect(0,0,maxint,maxint), copy(gltext,vn,bs-vn), bs-vn, copy(Pall,vn,bs-vn));
{.$ELSE}
//    Canvas.TextOut(ActLine.RealOffsX+x+Ppre[vn], UseStyleTree.ry, copy(gltext,vn,bs-vn));

    if HelpB=nil then
    begin
     HelpB:=TBitmap32.Create;
     HelpB.Canvas.Brush.Style:=bsClear;
    end;
    TextSizes:=Point(AddP(vn,bs)+AddP(bs-1,bs){bei kursiver Schrift letzer buchstabe},UseStyleTree.ContentHeight);
    HelpB.Width:=max(HelpB.Width,TextSizes.X);
    HelpB.Height:=max(HelpB.Height,TextSizes.Y);
    HelpB.FillRect(0,0,TextSizes.X,TextSizes.Y,$FFFFFFFF);
    HelpB.Canvas.Font.Assign(Canvas.Font);
    HelpB.Canvas.Font.Color:=$3F3f3f;
    HelpB.Canvas.Font.Color:=$0;
    ExtTextOutW(HelpB.Canvas.Handle, 0,0, ETO_CLIPPED, nil, PWideChar(@gltext[vn]), bs-vn, PInteger(@Pall[vn]));
    BlackWhiteReplace(HelpB,TextSizes.X,TextSizes.Y,Color32(Canvas.Font.Color));
    ActTopGraph.Draw(Bounds(TextRct.Left, TextRct.Top, TextSizes.X, TextSizes.Y),Rect(0,0,TextSizes.X,TextSizes.Y),HelpB);
    if fh<>0 then
    begin
     Canvas.Font.Handle := {Font.Handle}0;
     DeleteObject(fh);
     fh:=0;
    end;
   end else
{$ENDIF}
   begin
    ActTopGraph.Font.Assign(Canvas.Font);
    OldClipRect:=ActTopGraph.ClipRect;
    ActTopGraph.ClipRect:=ClpRct;
    ActTopGraph.RenderTextExtended(TextRct.Left, TextRct.Top, copy(gltext,vn,bs-vn), AALevel,{ $FF000000 or }Color32(Canvas.Font.Color),Point(TextRct.Right-TextRct.Left,TextRct.Bottom-TextRct.Top),AddP(bs-1,bs));
    ActTopGraph.ClipRect:=OldClipRect;
   end;

    {
   if FCommon.Overline then
   begin
    Canvas.Brush.Style:=bsSolid;
    Canvas.Brush.Color:=Canvas.Font.Color;
    //Canvas.Pen.Style:=psClear;
    Canvas.FillRect(Bounds(ActLine.RealOffsX+x+Ppre[vn], UseStyleTree.ry+y,AddP(vn,bs),1));
    //Canvas.Pen.Style:=psSolid;
   end;   }

{.$ENDIF}

    end;
    {teil:=AnsiString(_WStr(PWideChar(@gltext[vn]),bs-vn));
    ExtTextOutA(Canvas.Handle, OffsX+x+Ppre[vn], UseStyleTree.PaddingRect.Top, 0, nil, PChar(teil), length(teil), PInteger(@Pall[vn]));
    }
    finally
     inc(Pall[vn],Ppre[vn]);
     inc(Pall[bs-1],Psuc[bs-1]);
    end;
    end;
    inc(x,AddP(vn,bs));
   end;
  end;
{$IFNDEF CLX}
  if SaveIndex<>0 then
   RestoreDC(Canvas.Handle, SaveIndex);
{$ENDIF}

{$IFNDEF CLX}
  QueryPerformanceCounter(c2);
{$ENDIF}  
{  if csDesigning in ComponentState then
   Application.MainForm.Caption:=inttostr((c2-c1) div 1000)+' '+name;//inttostr(maxit);
 }
  end;

  //FreeLines;

  UseStyleTree:=nil;
 end;
end;

{procedure TdhCustomLabel.BeforeTextOut(Font:TFont);
begin

end;}

{
function TdhRule.GetSharingEnabled:boolean;
begin
 result:=FSharingEnabled;
end;
 }
                 {
function TdhCustomLabel.IsOverflow:boolean;
var NewWidth, NewHeight: Integer;
    r:TRect;
begin
 result:=false;
 if RealAutoSizeXY(Self)<>asXY then
 begin
  MeasureOverflow:=true;
  r:=GetAutoRect(Width,0);
  MeasureOverflow:=false;
  result:=(r.Right-r.Left>Width) or (r.Bottom-r.Top>Height);
 end;
end;              }


procedure TdhCustomLabel.ReadOldCaption(Reader: TReader);
begin
 SetHTMLText(Reader.ReadString);
end;

procedure TdhCustomLabel.DefineProperties(Filer: TFiler);
begin
 inherited;
 Filer.DefineProperty('Caption', ReadOldCaption, nil, false);
 if not WithMeta and (Filer is TWriter) then exit;
 Filer.DefineProperty('HTMLText', SkipValue, nil, false);
// Filer.DefineProperty('Overflow', SkipValue, WriteTrue, false and IsOverflow);
// if (Filer is TReader) and NotReadBefore
end;


procedure TdhCustomLabel.ReadCaption(Reader: TReader);
begin
 SetHTMLText(Reader.ReadString);
end;


                                     {
function TdhCustomLabel.GetImageType:TImageType;
begin
 if (UseStyleTree<>nil) and (UseStyleTree.StyleElement<>nil) then
  result:=(UseStyleTree.StyleElement.GetCommon.Control as TdhCustomPanel).GetImageType else
  result:=Inherited GetImageType;
end;                                  }

                 {
function TdhCustomLabel.TotalInlineBox: boolean;
begin
 if (UseStyleTree<>nil) and (UseStyleTree.StyleElement<>nil) then
  result:=(UseStyleTree.StyleElement.GetCommon.Control as TdhCustomPanel).TotalInlineBox else
  result:=Inherited TotalInlineBox;
end;                   }

function TdhCustomLabel.Referer:TdhCustomPanel;
begin
 if (UseStyleTree<>nil) and (UseStyleTree.StyleElement<>nil) then
  result:=UseStyleTree.StyleElement.GetCommon else
  result:=Self;
end;







(*
function Tnt_ExtTextOutW(DC: HDC; X, Y: Integer; Options: Longint;
  Rect: PRect; Str: PWideChar; Count: Longint; Dx: PInteger): BOOL;
begin
  if Win32PlatformIsUnicode then
    Result := ExtTextOutW(DC, X, Y, Options, Rect, Str, Count, Dx)
  else
    Result := ExtTextOutA{TNT-ALLOW ExtTextOutA}(DC, X, Y, Options, Rect,
      PAnsiChar(AnsiString(_WStr(Str, Count))), Count, Dx);
end;

*)
{
function TdhRule.GetOverBasedOnDown:boolean;
begin
 result:=FOverBasedOnDown;
end;

procedure TdhRule.SetOverBasedOnDown(Value: boolean);
begin
 Value:=false;
 FOverBasedOnDown:=Value;
 if not (csLoading in ComponentState) then
  FCommon.NotifyCSSChanged(AllChanged);
end;
}

function TdhCustomLabel.TextTransform:TCSSTextTransform;
begin
 if GetVal(pcTextTransform) then
  result:=Cascaded.TextTransform else
  result:=cttNone;
end;

function TdhCustomLabel.AntiAliasing:boolean{TCSSAntiAliasing};
begin
 if GetVal(pcAntiAliasing) then
  result:=Cascaded.AntiAliasing else
  result:=false;
   {
 if FCommon.GetVal(pcAntiAliasing,Value) then
  result:=Value.AntiAliasing else
  result:=caaNone;   }
end;



function TdhCustomLabel.WhiteSpace:TCSSWhiteSpace;
begin
 if GetVal(pcWhiteSpace) then
  result:=Cascaded.WhiteSpace else
  result:=cwsNormal;
end;


function TdhCustomLabel.ListStyleType:TCSSListStyleType;
var StyleTree:TStyleTree;
    lists:integer;
begin
 Cascaded.ListStyleType:=clsDisk;
 GetVal(pcListStyleType);
 result:=Cascaded.ListStyleType;


{ if FCommon.GetVal(pcListStyleType,Value) then
  result:=Value.ListStyleType else
 begin
 lists:=0;
 StyleTree:=UseStyleTree;
 while StyleTree<>nil do
 begin
  if (StyleTree.TagName='ul') or (StyleTree.TagName='ol') or (StyleTree.TagName='dir') or (StyleTree.TagName='menu') then
   inc(lists);
  StyleTree:=StyleTree.ParentStyle;
 end;
 case lists of
 0,1:result:=clsDisk;
 2: result:=clsCircle;
 else result:=clsCircle;
 end;
 end;}
end;

function TdhCustomLabel.TextAlign:TCSSTextAlign;
begin
 if GetVal(pcTextAlign) then
  result:=Cascaded.TextAlign else
 if Direction=cdiLTR then
  result:=ctaLeft else
  result:=ctaRight;
end;

function TdhCustomLabel.TextIndent:integer;
var res:integer;
begin
 if GetVal(pcTextIndent) then
  result:=GetTextIndentPixels(Cascaded.TextIndent,ComputedFontSize) else
  result:=0;
end;

{
constructor TdhRule.Create(AOwner: TComponent);
begin
 inherited;
 FCommon.StyleArr[hsOver]:=TStyle.Create(FCommon,hsOver);
 FCommon.StyleArr[hsDown]:=TStyle.Create(FCommon,hsDown);
 FCommon.StyleArr[hsOverDown]:=TStyle.Create(FCommon,hsOverDown);
end;
}
procedure TdhCustomLabel.Click;
begin
 if DelegateClick then exit;
 Inherited;
end;

function TdhCustomLabel.DelegateClick:boolean;
begin              
 if (LastActStyle in [hsOver,hsOverDown]) and (ClientAnchor<>nil) and (ClientAnchor<>Self) then
 begin
  ClientAnchor.DoClickAction(Self);
  result:=true;
 end else
  result:=false;
end;


   

{$IFNDEF CLX}
procedure TdhCustomLabel.WndProc(var Message:TMessage);
begin

                                         {
 if (Message.Msg=CM_MOUSEENTER) or (Message.Msg=CM_MOUSELEAVE) then
  FCommon.UpdateMouse(Message.Msg=CM_MOUSEENTER);}
 if (Message.Msg=WM_LBUTTONDOWN) or (Message.Msg=WM_LBUTTONUP) then
 begin
//  FCommon.CheckDesignState;
//  PostMessage(Handle, CM_INVALIDATE, 0, 0);
 if TransitionInvalidates then
 if (TopStyleTree<>nil) and (TopStyleTree.Count>=1) then //for speed, wenn kein Inline-Element vorhanden, sondern z.b. nur ein Image ist  
  NotifyCSSChanged(ActStyleChanged{[wcSize,wcNoOwnCSS]}); //falls Inline-Element in Down-Zustand ist
   //csLButtonDown may have changed
//  if RuntimeMode and (csDesigning in ComponentState) and HasParentMenu(P) and (FSubMenu=nil) then
//   PostMessage(Handle,WM_LBUTTONDBLCLK,0,0);
 end;
 inherited;

end;
{$ENDIF}

function TdhCustomLabel.SomethingIsScrolled:boolean;
begin
 result:=true; //text is scrolled!
end;



procedure TdhCustomLabel.Loaded;
begin
 Inherited;
 RenameNames;
end;

procedure TdhCustomLabel.WriteFalse(Writer: TWriter);
begin
 Writer.WriteBoolean(false);
end;


function TdhCustomLabel.FinalShowing:boolean;
begin
 result:=Showing or (Parent<>nil) and Parent.Showing and FinalVisible(Self);
end;

function TdhCustomLabel.RenderedText:WideString;
begin
 AssureRenamingAware(false);
 result:=gltext;
end;

             
{$IFNDEF CLX}
procedure TdhCustomLabel.CreateHandle;
begin
// if (Owner<>nil) and (Owner.ClassName='TDChild') and (csDesigning in ComponentState) and (ClassName<>'TMySiz') then exit;
 inherited;
end;     
{$ENDIF}

procedure TdhCustomLabel.WriteTrue(Writer: TWriter);
begin
 Writer.WriteBoolean(true);
end;


//procedure TdhCustomLabel.WMMouseMove(var Message: TWMMouseMove);
procedure TdhCustomLabel.MouseMove(Shift: TShiftState; X, Y: Integer);
//{$IFDEF VER160}unsafe;{$ENDIF}
begin
{$IFDEF CLX}
 QWidget_setCursor(Handle, Screen.Cursors[GetActCursor]); 
{$ENDIF}
 ProcessMouseMove(false);
 inherited;
end;


function TdhCustomLabel.ClientAnchor:TdhCustomPanel;
var NewClientStyleTree:TStyleTree;
begin
    result:=nil;
    if Lines=nil then exit;
    NewClientStyleTree:=ClientStyleTree;
    while NewClientStyleTree<>nil do
    if (NewClientStyleTree.StyleElement<>nil) and NewClientStyleTree.StyleElement.GetCommon.ShallBeAnchor then
    begin
     result:=NewClientStyleTree.StyleElement.GetCommon as TdhCustomPanel;
     exit;
    end else
     NewClientStyleTree:=NewClientStyleTree.ParentStyle;
end;

procedure TdhCustomLabel.ProcessMouseMove(StateChanged:boolean);
var
    NewClientStyleTree,OldClientStyleTree,pStyleTree:TStyleTree;
    P:TPoint;
    R:TRect;

function GetSelTree(var ClientStyleTree:TStyleTree):boolean;
var ActLine:PLineInfo;
    ti:integer;
    l:integer;
    best_ti:integer;
    rct,brct:TRect;
begin
  best_ti:=-1;
  for l:=high(Lines) downto 0 do
  begin
   ActLine:=@Lines[l];
   for ti:=0 to ActLine.AllTrees.Count-1 do
   if FocContainer(ActLine,ti,rct,brct,height) then
   if PtInRect(rct,P) then
    best_ti:=ti;
   if best_ti>=1 then
   begin
    ClientStyleTree:=TStyleTree(Lines[l].AllTrees[best_ti]);
    result:=true;
    exit;
   end;
  end;
  result:=false;
end;

function Transi(StyleTree:TStyleTree):boolean;
begin
 while (StyleTree<>nil) and (StyleTree.StyleElement<>nil) do
 if StyleTree.StyleElement.GetCommon.TransitionInvalidates then
 begin
  result:=true;
  exit;
 end else
  StyleTree:=StyleTree.ParentStyle;
 result:=false;
end;



begin
 inherited;
 if TransitionInvalidates then exit;

{ if (csDesigning in ComponentState) and  not RuntimeMode then
  exit;}
 P:=Mouse.CursorPos;
 DecPt(P,GetCBound(Self).TopLeft);
 IncPt(P,Point(HPos,VPos));
// DecPt(P,FCommon.ScrollEdgesPure.TopLeft);
 R:=Rect(0,0,Width,Height);
 DoDrawText(R,true);
 OldClientStyleTree:=ClientStyleTree;
 if GetSelTree(NewClientStyleTree) then
 begin
  SetLength(ClientStyleTree_starttag,0);
  pStyleTree:=NewClientStyleTree;
  while (pStyleTree<>nil) and (pStyleTree.ParentStyle<>nil) do
  begin
   if pStyleTree.starttag<>0 then
   begin
    setlength(ClientStyleTree_starttag,length(ClientStyleTree_starttag)+1);
    ClientStyleTree_starttag[high(ClientStyleTree_starttag)]:=pStyleTree.starttag;
   end;
   pStyleTree:=pStyleTree.ParentStyle;
  end;
  //ClientStyleTree_starttag:=NewClientStyleTree.starttag;
 end else
 begin
  SetLength(ClientStyleTree_starttag,0);
  //ClientStyleTree_starttag:=0;
 end;

  if ((OldClientStyleTree<>ClientStyleTree) or StateChanged) and (Transi(OldClientStyleTree) or Transi(ClientStyleTree))   then
  begin
    NotifyCSSChanged(ActStyleChanged);
    //InvalInline;
    //FCommon.NotifyCSSChanged([{wcClientArea,}{wcCursor,}wcNoOwnCSS]);
  end;
end;


function TdhCustomLabel.CharPos:integer;
var
    NewClientStyleTree,OldClientStyleTree:TStyleTree;
    P:TPoint;
    R:TRect;

function GetSelChar:integer;
var ActLine:PLineInfo;
    x,w,l:integer;
begin
  DoDrawText(R,true);
  for l:=high(Lines) downto 0 do
  begin
   ActLine:=@Lines[l];
   if not ((p.y>=ActLine.y) and (p.y<=ActLine.y+ActLine.maxheight)) then continue;
   x:=ActLine.RealOffsX+ActLine.offs.Left;
   for w:=ActLine.vn to ActLine.bs-1 do
   if (p.x>=x) and (p.x<x+Pall[w]) then
   begin
    result:=w;
    exit;
   end else
    inc(x,Pall[w]);
  end;
  result:=0;
end;


begin
 inherited;
 P:=Mouse.CursorPos;
 DecPt(P,GetCBound(Self).TopLeft);
 IncPt(P,Point(HPos,VPos));
 R:=Rect(0,0,Width,Height);
 result:=GetSelChar;
end;


                 {
function TdhCustomLabel.ClientSelControl:TControl;
begin
 result:=nil;
 if (ClientStyleTree<>nil) and IsWholeStyle(ClientStyleTree) then
  result:=ClientStyleTree.StyleElement.GetCommon.Control;
end;              }





procedure TdhCustomLabel.GetModifiedText(var pre,s,suc: HypeString);
begin
 if (s='') and IsAbsolutePositioned then
  s:=' ';
end;

function TdhCustomLabel.GetActCursor:TCursor;
begin
            Result := Screen.Cursor;
            if Result = crDefault then
            begin
              UseStyleTree:=ClientStyleTree;
              if Result = crDefault then
                if (csDesigning in ComponentState) and not RuntimeMode then
                  Result := crArrow
                else
                  Result := CSSCursorMap[GetCursor];
              UseStyleTree:=nil;
            end;
end;
                        

{$IFNDEF CLX}

procedure TdhCustomLabel.WMSetCursor(var Message: TWMSetCursor);
var
  Cursor: TCursor;
  Control: TControl;
  P: TPoint;
begin
  if TControl(Self) is TWinControl then
  if IsDlg then
   Windows.SetCursor(Screen.Cursors[crArrow]) else
  with Message do
    if CursorWnd = TWinControl(Self).Handle then
      case Smallint(HitTest) of
        HTCLIENT:
          begin
            Cursor := GetActCursor;
            if Cursor <> crDefault then
            begin
              Windows.SetCursor(Screen.Cursors[Cursor]);
              Result := 1;
              Exit;
            end;
          end;
      end;
  inherited;
end;
{$ENDIF}

function TdhCustomLabel.ForceJustify:boolean;
begin
 result:=false;
end;

function TdhCustomLabel.NeedPadding(HasRastering:TRasterType): boolean;
begin
 result:=not (HasRastering in [rsNo,rsFull]);
end;


function TdhCustomLabel.AllowAutoSizeY:boolean;
begin
 result:=not EmptyContent;
end;

function TdhCustomLabel.PreventFull(Cause:TTransformations):boolean;
begin
 result:=Cause.TextExclude and not Cause.AntiAliasing or inherited PreventFull(Cause);
end;


function TdhCustomLabel.TextExtent(const Text: string): TSize;
var Canvas:TCanvas;
    DC: HDC;
    {Rect:TRect;
    Metric: TOutlineTextmetric;}
begin
{$IFDEF CLX}
    with TBitmap.Create do
    try
      Width := 5;
      Height := 5;
      CSSToFont(Canvas.Font);
      Result := Canvas.TextExtent(Text);
    finally
      Free;
    end;
{$ELSE}
  Canvas:=TCanvas.Create;
  DC := GetDC(0);
  Canvas.Handle:=DC;
  try
    CSSToFont(Canvas.Font);
    {DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, DT_CALCRECT);
    result.cx:=Rect.Right-Rect.Left;
    result.cy:=Rect.Bottom-Rect.Top;}
    Result:=Canvas.TextExtent(Text);
    {if GetOutlineTextMetrics(DC, SizeOf(Metric), @Metric) <> 0 then
    begin
     inc(Result.cx, Metric.otmItalicAngle);
    end;  }
  finally
    FreeAndNil(Canvas);
    ReleaseDC(0, DC);
  end;
{$ENDIF}
end;


(*
function TdhCustomLabel.TextExtent(const Text: string): TSize;
var Canvas:TCanvas;
var
  DC: HDC;
begin
  result.cx:=0;
  result.cy:=0;
    try
{$IFDEF CLX}
  Canvas:=TCanvas.Create;
  Canvas.Handle:=QPainter_create;
{$ELSE}
  Canvas:=TCanvas.Create;
  Canvas.Handle := GetDC(0);
{$ENDIF}
    FCommon.CSSToFont(Canvas.Font);
    Result:=Canvas.TextExtent(Text);
   finally
{$IFDEF CLX}
    FreeAndNil(Canvas);
{$ELSE}
    DC:=Canvas.Handle;
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    FreeAndNil(Canvas);
{$ENDIF}
   end;
end;
*)


function TdhCustomLabel.WrapAlways: boolean;
begin
 result:=false;
end;

function SortUnicodeByNumbers(List: TStringList; Index1, Index2: Integer): Integer;
begin
 result:=Integer(List.Objects[Index1])-Integer(List.Objects[Index2]);
end;

function PointerCompare(Item1, Item2: Pointer): Integer;
begin
 result:=Integer(Item1)-Integer(Item2);
end;




procedure BuildUnicode; //{$IFDEF VER160}unsafe;{$ENDIF}
var i:integer;
    s:string;
begin
 _Unicode:=TStringList.Create;

 for i:=0 to high (HtmlLat1) do
 begin
{$IFDEF VER160}
  _Unicode.AddObject(HtmlLat1[i].Name,HtmlLat1[i].Code);
{$ELSE}
  _Unicode.AddObject(HtmlLat1[i].Name,Pointer(HtmlLat1[i].Code));
{$ENDIF}
 end;

 //_Unicode.CaseSensitive:=true;
 _Unicode.Sorted:=true;

 UnicodeByNumbers:=TStringList.Create;
 UnicodeByNumbers.Assign(_Unicode);
 UnicodeByNumbers.CustomSort(SortUnicodeByNumbers);
 UnicodeByNumbersList:=TBinList.Create;
 for i:=0 to UnicodeByNumbers.Count-1 do
 begin
  UnicodeByNumbersList.Add(UnicodeByNumbers.Objects[i]);
{  UnicodeByNumbers[i]:=inttostr(Integer(UnicodeByNumbers.Objects[i]));
  UnicodeByNumbers.Objects[i]:=}
 end;

 for i:=0 to _Unicode.Count-1 do
 if Ord(WideChar(_Unicode.Objects[i]))<=255 then
  what_uni[char(_Unicode.Objects[i])]:=i;
           {
 for i:=128 to 255 do
 if what_uni[chr(i)]=0 then
  what_uni[chr(i)]:=ord(i);
                      }
end;


{function TdhCustomLabel.TransitionInvalidates: boolean;
begin
 result:=Pos('<',FHTMLText)<>0;
end;
}

{ TdhLabel }

constructor TdhLabel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle:=ControlStyle-[csSetCaption];
end;

function TdhLabel.AllHTMLCode:HypeString;
begin
 result:=FHTMLText;
end;


procedure TdhLabel.SetName(const Value: TComponentName);
var
  ChangeText: Boolean;
begin
  ChangeText := {(csSetCaption in ControlStyle) and }
    not (csLoading in ComponentState) and (Name = FHTMLText) and
    ((Owner = nil) or not (Owner is TControl) or
    not (csLoading in TControl(Owner).ComponentState));
  inherited SetName(Value);
  if ChangeText then SetHTMLText(Value);
end;


function TdhCustomLabel.MyGetControlExtents(OnlyForScrollbars:boolean): TPoint;
begin
  //MeasureOverflow:=true;

  if IsScrollArea and FVertScrollbarAlwaysVisible then
   Result.X:=Width-VertScrollBar else
   Result.X:=Width;
  Result.Y:=0;
  GetInnerAutoRect(false,true,result.X,result.Y); //breitestes wort


  //MeasureOverflow:=false;

 //OffsetRect(Rct,-Left,-Top);
 //OffsetRect(Rct,-HPos,-VPos);
 //DecPt(rct.BottomRight,FCommon.ClientEdgesPure.BottomRight);


 // result:=ShrinkRect(Rct,FCommon.AllEdgesPure);
 //result:=Rct;
end;

(*
{$IFDEF CLX}
procedure TdhCustomLabel.TextChanged;
{$ELSE}
procedure TdhCustomLabel.CMTextChanged(var Message: TMessage);
{$ENDIF}
begin
 SetHTMLText(inherited Caption);
end;
*)


function TStyleTree.GetBottomLeading: integer;
begin
 result:=LineHeight-TopLeading-ContentHeight;
end;


function TdhCustomLabel.GetOverChar:integer;
begin
 if length(ClientStyleTree_starttag)<>0 then
  result:=ClientStyleTree_starttag[0] else
  result:=0;
end;

initialization

 BuildUnicode;


{$IFNDEF CLX}
 Win32PlatformIsUnicode := (Win32Platform = VER_PLATFORM_WIN32_NT);
{$ENDIF}


 //RegisterClasses([TdhStyleSheet,TdhRule,TdhCustomLabel,TdhPanel]);

                
 AssertTags2;

finalization

 if dhStrEditDlg<>nil then
 if not (csDestroying in dhStrEditDlg.ComponentState) then
  //dhStrEditDlg.Release;
  FreeAndNil(dhStrEditDlg);

 FreeAndNil(HTMLTags);

 FreeAndNil(_Unicode);
 FreeAndNil(UnicodeByNumbers);
 FreeAndNil(UnicodeByNumbersList);
 FreeAndNil(HelpB);



end.
