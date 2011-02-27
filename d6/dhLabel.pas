unit dhLabel;

interface

{$IFDEF VER160}
{$UNSAFECODE ON}
{$ENDIF}

uses
  {$IFDEF CLX}
  QControls, Qt, QGraphics, QForms,
  {$ELSE}
  Controls, Windows, Messages, Graphics, Forms,
  {$ENDIF}
  SysUtils, Classes, dhPanel, math, types,Generics.Defaults,Generics.Collections, GR32_Transforms,gr32,gr32_Blend,dhStrUtils,StrUtils,WideStrUtils,dhBitmap32,dhStyles,dhColorUtils;


{$IFDEF VER160}
{$UNSAFECODE ON}
{$ENDIF}

function inttoalpha(i:integer):HypeString;

type
  TFormButtonType=(fbNone,fbSubmit,fbReset);

type
 TdhCustomLabel=class;
 TStyleTree=class(TList)
  private
    starttag,endtag:integer;
    IsWholeStyle:boolean;
    TagName:HypeString;
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
    HasBorder:boolean;

    procedure Clear; override;
    function GetBottomLeading: integer;
    function HasVerticalAlign: boolean;
    property BottomLeading:integer read GetBottomLeading;
 end;

 TLineInfo=record RealOffsX,y:integer; offs:TRect; OffsX,lineavail,lmin,maxHeight,LineWidth,vn,bs:integer; AllTrees:TList; InlineBreak:boolean; endat:integer; end;
 PLineInfo=^TLineInfo;

  TOneTrackChar=record vn,bs:integer; end;
  TTrackChar=array of TOneTrackChar;

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
    TrackChar:TTrackChar;
    SelStart:Integer;
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
{$IFNDEF CLX}
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
{$ENDIF}
    procedure PC_Cursor(F: TColor32; var B: TColor32; M: TColor32);
  protected
    FOldHTMLText:HypeString;
    FHTMLText:HypeString;
    function PreventFull(Cause:TTransformations):boolean; override;
    function AllowAutoSizeY:boolean; override;
    function TextExtent(const Text: AString): TSize;
    function GetOverChar:integer;
    function MyGetControlExtents(OnlyForScrollbars:boolean): TPoint; override;
    function DoGetVal(PropChoose:TPropChoose; const Align:TEdgeAlign; var DoExit:boolean):boolean; override;
    function GetComputedFontSize:single; override;
    function Referer:TdhCustomPanel; override;
    function WrapAlways: boolean; virtual;
    procedure GetModifiedText(var pre,s,suc:HypeString); virtual;
    function InterpreteDirectly:Boolean; virtual;
    function DelegateClick:boolean;
    procedure DoStateTransition(OldState:TState); override;
    function EmptyContent:boolean;
    procedure DoTopPainting; override;
{$IFNDEF CLX}
    procedure WndProc(var Message:TMessage); override;
{$ENDIF}
    procedure Loaded; override;
    procedure WriteTrue(Writer: TWriter);
    procedure ControlsListChanged(Control: TControl; Inserting: Boolean); override;
    function GetActCursor:TCursor;
{$IFNDEF CLX}
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
{$ENDIF}
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DoCSSToWinControl(WhatChanged:TWhatChanged); override;
    procedure UpdateNames(InlineUse,NewInlineUse:ICon; PropagateChange:boolean); override;
    function GetAutoRectPoint(AllowModifyX,AllowModifyY:boolean; NewWidth, NewHeight: Integer):TPoint;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    procedure GetInnerAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
    procedure FocusPreferStyle(IsMain,RealChange:boolean); override;
    function GetHTMLState:TState; override;
    procedure ReadCaption(Reader: TReader);
    procedure PaintCaption;
    procedure DoDrawText(var ConstraintsRect: TRect; CalcRect:boolean); virtual;
    procedure SetHTMLText(const Value:HypeString); virtual;
    function AddP(vn, bs: integer): integer;
    procedure BuildLines;
    procedure FreeLines;
    function FocContainer(ActLine:PLineInfo; ti:integer; var rct,brct:TRect; AvailY:integer):boolean; //{$IFDEF VER160}unsafe;{$ENDIF}
    function FindChildContent(ActLine:PLineInfo; _StyleTree:TStyleTree):TPoint;
    function TextTransform:TCSSTextTransform;
    function WhiteSpace:TCSSWhiteSpace;
    function ListStyleType:TCSSListStyleType;
    function TextAlign:TCSSTextAlign;
    function TextIndent:integer;
    function LetterSpacing: Integer;
    function WordSpacing: Integer;
    function AntiAliasing:boolean;
    function TextOnly:boolean; override;
    function TextExclude:boolean; override;
    function CustomSizesForEffects:boolean; override;
    function CenterVertical:boolean; virtual;
    function ForceJustify:boolean; virtual;
    function SomethingIsScrolled: boolean; override;
    procedure ProcessMouseMove(StateChanged:boolean); override;
    function NeedPadding(HasRastering:TRasterType): boolean; override;
    procedure KeyPress(var Key: AChar); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function CharToCoord(pos:Integer):TPoint;
    function CharOfLine(line:Integer):Integer;
    function AfterLastCharOfLine(line:Integer):Integer;
    function CoordToChar(const Coord:TPoint):Integer;
    procedure OnSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure OnKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    function GetFinal: ICon; override;
  public
    procedure NameChanged; override;
    procedure StartOrContinueEditingAtMousePosition;
    procedure StopEditing;
    procedure SetSelStart(value:integer);
    function CharPosToTrackChar(const pos:integer):TOneTrackChar;
    procedure TryBrokenReferences(sl:TStringList); override;
    procedure CopyDependencies(CopyList:TList); override;
    function RenderedText:WideString;
    function FinalShowing:boolean; override;
    function CharPos:integer;
    function ClientAnchor:TdhCustomPanel;
    function ClientStyleTree:TStyleTree;
    procedure Click; override;
    procedure ParseHTML;
    procedure RenameNames;
    procedure AssureRenamingAware(HasChanges:boolean);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    end;

  TdhLabel=class(TdhCustomLabel)
  protected
    procedure SetName(const Value: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    function AllHTMLCode:HypeString; override;
  published
    property NoSiblingsBackground;
    property Text:HypeString read FHTMLText write SetHTMLText;
    property OnStateTransition;
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

function getTag2(const s:HypeString; var vn,itag,itagbs:integer; var tag:HypeString; var text:HypeString; var Closing,EmptyEle:boolean):boolean;
function WithoutComments(const s:HypeString; repl:HypeChar):HypeString;
function ConvertWideStringToUnicode(const s:WideString; NoTrivial:boolean):WideString; overload;
function ConvertUnicodeToWideString_(const s:WideString):WideString;
function HypeSubstText(const Substr,durch, S: HypeString): HypeString;
function HasUnicodeName(i:integer; var CharacterName:AString):boolean;
function AssertTags2:boolean;

var RenamedNames:TStringList;
var HTMLTags:TStringList;

procedure Register;

implementation

uses dhStyleSheet,BasicHTMLElements;


var _Unicode:TStringList;
    UnicodeByNumbersList:TDictionary<Integer,String>;

{$IFDEF CLX}
const IsCLX=true;
{$ELSE}
const IsCLX=false;
{$ENDIF}

const AAA=true and not IsCLX;
      AALevel=2;

var what_uni:array[AnsiChar] of integer;
    Win32PlatformIsUnicode:boolean=false;

type
  THtmlEntity = record
    Name: HypeString;
    Code: WideChar;
  end;

{$IFDEF VER160}
type PInteger=^Integer;
{$ENDIF}


const HtmlEntities: array [0..252] of THtmlEntity = (
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
  (Name: 'zeta'; Code: #$03B6));


const endl_main=#10;
      endl_space=#13;
      markupBreak=endl_main;
      markupEmptyEle=#2;


procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhLabel]);
end;


function HasUnicodeName(i:integer; var CharacterName:AString):boolean;
begin
    Result:=UnicodeByNumbersList.TryGetValue(i,CharacterName);
end;

function WithoutComments(const s:HypeString; repl:HypeChar):HypeString;
var i,i2:integer;
begin
 result:=s;
 i:=PosEx('<!--',result,1);
 while i<>0 do
 begin
  i2:=PosEx('-->',result,i);
  if i2=0 then
   i2:=length(result)-(length('-->')-1);
  for i:=i to i2+length('-->')-1 do
   result[i]:=repl;
  i:=PosEx('<!--',result,i2+length('-->'));
 end;
end;

function IsPHPTag(const s:HypeString; var i:integer):boolean;
var i2:integer;
begin
 if not((i=0) or (i+2>length(s))) and (s[i+1]='?') then
 begin
  i2:=PosEx('?>',s,i+2);
  if i2<>0 then
  begin
   i:=i2+length('?>');
   result:=true;
   exit;
  end;
 end;
 result:=false;
end;

function getTag2(const s:HypeString; var vn,itag,itagbs:integer; var tag:HypeString; var text:HypeString; var Closing,EmptyEle:boolean):boolean;
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
 Tag:=LowerCase(AbsCopy(s,itag,itagbs)) ;
 vn:=i2+1;
 result:=true;
 exit;
 end;
 end;
 itag:=0;
 tag:='';

  result:=false;
end;

procedure TStyleTree.Clear;
var i:integer;
begin
 if IsWholeStyle and (StyleElement<>nil) then
  StyleElement.GetCommon.InlineUsedByList.Remove(Owner);
 for i:=0 to Count-1 do
  TStyleTree(Items[i]).Free;
 inherited;
end;

constructor TdhCustomLabel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csAcceptsControls];
  AutoSizeXY:=asY;
  Width:=100;
end;

procedure TdhCustomLabel.DoCSSToWinControl(WhatChanged:TWhatChanged);
begin
 if ([wcText,wcText2]*WhatChanged<>[]) and not (csLoading in ComponentState) then
  FreeLines;
 if (wcText in WhatChanged) and not (csLoading in ComponentState) then
  InvalInline;
 if wcName in WhatChanged then
  UpdateNames(nil,nil,false);
 Inherited;
 ParseHTML; // to react on renaming
end;

procedure TdhCustomLabel.ControlsListChanged(Control: TControl; Inserting: Boolean);
begin
  inherited;
  if not (csReading in ComponentState) then
    if Inserting and (Control.Owner=Owner) then
    begin
     Control.Parent:=Parent;
     Control.BoundsRect:=Bounds(Control.Left+Left,Control.Top+Top,Control.Width,Control.Height);
    end;
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

function Replace(var s:HypeString; vn,bs:integer; const Subst:HypeString):boolean;
begin
 result:=AbsCopy(s,vn,bs)<>Subst;
 if result then
  s:=AbsCopy(s,1,vn)+Subst+AbsCopy(s,bs,maxint);
end;

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
  IsUpperCase:=CharInSet(_Unicode[i][1],['A'..'Z']);
  SecCase:=WideChar(_Unicode.Objects[i-1]);
 end else
 if (i<>-1) and (i+1<=_Unicode.Count-1) and (lowercase(_Unicode[i+1])=lowercase(_Unicode[i])) then
 begin
  IsUpperCase:=CharInSet(_Unicode[i][1],['A'..'Z']);
  SecCase:=WideChar(_Unicode.Objects[i+1]);
 end else
  result:=false;
 end;
end;


function getUnicodeChar(ts:HypeString; var ch:WideChar):boolean;
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
  except //catch strtoint exception
   result:=false;
  end;
end;

function ConvertWideStringToUnicode(const s:WideString; NoTrivial:boolean):WideString;
var i:Integer;
begin
 result:='';
 for i:=1 to length(s) do
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
  result:=result+s[i];
end;

function ConvertUnicodeToWideStringExt(const s:HypeString; var TrackChar:TTrackChar; offs:integer; mislegit:HypeChar; InterpreteDirectly:Boolean):WideString;
var i,o,old_i,ri,ti:integer;
    ch:WideChar;
begin
 i:=1;
 ri:=1;
 ti:=length(TrackChar);
 setlength(result,length(s));
 setlength(TrackChar,length(TrackChar)+length(s));
 if InterpreteDirectly then
 begin
 while i<=length(s) do
 begin
  old_i:=i;
  result[ri]:=s[i];
  inc(ri);
  inc(i);
  TrackChar[ti].vn:=offs+old_i;
  TrackChar[ti].bs:=offs+i;
  inc(ti);
 end;
 end else
 begin
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
   result[ri]:=s[i];
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
 end;
 setlength(TrackChar,ti);
 setlength(result,ri-1);
end;


function ConvertUnicodeToWideString_(const s:WideString):WideString;
var TrackChar:TTrackChar;
begin
 result:=ConvertUnicodeToWideStringExt(s,TrackChar,0,#0,false);
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
 dhStrEditDlg:=TBasicHTMLElements.Create(nil);

 HTMLTags:=TStringList.Create;

 if dhStrEditDlg.dhStyleSheet1<>nil then
 for i:=0 to dhStrEditDlg.dhStyleSheet1.ControlCount-1 do
 if (dhStrEditDlg.dhStyleSheet1.Controls[i] is TdhCustomLabel) and (Copy(dhStrEditDlg.dhStyleSheet1.Controls[i].Name,1,length('dhLabel'))<>'dhLabel') then
 begin
  (dhStrEditDlg.dhStyleSheet1.Controls[i] as TdhCustomLabel).IsDlg:=true;
  HTMLTags.AddObject(dhStrEditDlg.dhStyleSheet1.Controls[i].Name,dhStrEditDlg.dhStyleSheet1.Controls[i]);
 end;

 HTMLTags.Sorted:=true;
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
var i,i2,c:integer;
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
 if StyleTree.IsImg then text:='';
 s:=text;
 s:=HypeSubstText(markupEmptyEle,'',s);
 UseStyleTree:=StyleTree;
 try
  if NoneStyle<>nil then
  begin
   wtext:='';
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
    s[1]:=#1;
   ss:=HypeSubstText(#1,'',s);
   SkipNextSpace:=(ss='') and SkipNextSpace or (ss<>'') and (ss[length(ss)]=' ') or IsBreak;
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
  end;
  wtext:=ConvertUnicodeToWideStringExt(s,TrackChar,vn-1-length(spre),#1,InterpreteDirectly);
  end;

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
  cttUppercase: wtext:=WideUpperCase(wtext);
  cttLowercase: wtext:=WideLowerCase(wtext);
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
    tag:HypeString;
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

procedure AdjustForEditing;
var i:integer;
begin
 for i := 1 to length(gltext) do
 case gltext[i]of
 markupBreak:
 begin
  // set TTrackChar.bs not only after <br/> but also after following superfluous whitespaces
  TrackChar[i-1].bs:=CharPosToTrackChar(i+1).vn;
 end;
 markupEmptyEle:
 begin
   // enclose starting and ending tag
   TrackChar[i-1].vn:=Ptree[i].starttag-1;
   TrackChar[i-1].bs:=Ptree[i].endtag+length(Ptree[i].TagName)+1;
 end;
 end;
end;

var TagIndex,itagbs:integer;
begin
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
 s:=WithoutComments(s,markupEmptyEle);

 gltext:='';

 TopStyleTree:=TStyleTree.Create;
 StyleTree:=TopStyleTree;
 StyleTree.IsWholeStyle:=false;
 StyleTree.vn:=1;
 StyleTree.Blocking:=true;
 StyleTree.TagName:='#notag';

 SetLength(self.TrackChar,0);
 SetLength(Ptree,1);

 NoneStyle:=nil;
 PutNew(false);

 vn:=1;
 vn_old:=vn;
 if not InterpreteDirectly then
 while getTag2(s,vn,itag,itagbs,tag,text,Closing,EmptyEle) and (StyleTree<>nil) do
 begin
  PushText(vn_old);
  if tag='br' then
  begin
   text:='';
   if Closing then
    vn_old:=itag-2 else
    vn_old:=itag-1;
   PushText(vn_old,true);
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
    if AssertTags2 then
    if HTMLTags.Find(tag,TagIndex) then
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

 UseStyleTree:=nil;
 AdjustForEditing;
end;


procedure TdhCustomLabel.InvalInline;
begin
 FreeLines;
 FreeAndNil(TopStyleTree);
end;


procedure TdhCustomLabel.RenameNames;
var i:integer;
    NewName:TComponentName;
    RenamedName:TComponentName;
begin
 if (RenamedNames<>nil) then
 begin
  // we must use "downto" order since otherwise for renamings 'a'->'b' and 'b'->'c',
  // all 'a' get replaced to 'c' and not to 'b'
  for i:=RenamedNames.Count-1 downto 0 do
  begin
  RenamedName:=RenamedNames[i];
  if Pos(RenamedName,FHTMLText)<>0 then
  begin
   InvalInline;
  //if RenamedNames[i]<>RenamedNames[
   NewName:=TComponent(RenamedNames.Objects[i]).Name;
   FHTMLText:=HypeSubstText('<'+RenamedName+'>','<'+NewName+'>',FHTMLText);
   FHTMLText:=HypeSubstText('</'+RenamedName+'>','</'+NewName+'>',FHTMLText);
   FHTMLText:=HypeSubstText('<'+RenamedName+'/>','<'+NewName+'/>',FHTMLText);
  end;
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
  IsDown:=(csLButtonDown in ControlState);
  if IsDown then
  if (Result=hsOver) then
   Result:=hsOverDown else
   Result:=hsDown;
end;

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
   InlinePn.LastActStyle:=InlinePn.GetInlineHTMLState((LastActStyle in [hsOver,hsOverDown]) and ContainsStyleTree(OuterLink(ClientStyleTree),StyleTree),(csLButtonDown in ControlState)) else
   InlinePn.LastActStyle:=LastActStyle;
  if InlinePn.GetVal(PropChoose,Align,false) then
  begin
   result:=true;
   exit;
  end;
  finally
   InlinePn.LastActStyle:=_LastActStyle;
  end;
  Cascaded.IsFromParent:=true;
  if (PropChoose in [pcFontSize{only the computed value is inherited }]) or  not (PropChoose in AutoInherit) and not (PropChoose in [pcWhiteSpace,pcAntiAliasing]) then
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
 DoExit:=false;
end;

procedure TdhCustomLabel.DoTopPainting;
begin
 PaintCaption;
 DrawFrame;
end;

procedure TdhCustomLabel.PaintCaption;
var R: TRect;
begin
    if IsDlg and FIsOver then
    with GetCanvas do
    begin
     Brush.Color:=clBtnShadow;
     Pen.Style := psSolid;
     Pen.Color := 126+106*256+218*256*256;
     Brush.Style := bsSolid;
     Brush.Color:= 198+190*256+239*256*256;
     Rectangle(ShrinkRect(TotalRect,Rect(2,2,2,2)));
    end;
    R:=ActTopGraph.BoundsRect;
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
var Avail,Req:TPoint;
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
 if (X<>0) and (Y<>0) then
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
  Transformations:TTransformations;
  T: TdhAffineTransformation;
  HorzRotated,VertRotated:boolean;
begin
    if (csLoading in ComponentState) then exit;
    assert( not (csLoading in ComponentState) );

    if GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth,NewHeight) then exit;

    Rect.TopLeft:=Point(0,0);
    Rect.Right:=NewWidth;
    Rect.Bottom:=maxint;

    T:=nil;
    if not EasyBounds(Transformations,T,Rect.Right,Rect.Bottom,HorzRotated,VertRotated) then
     Rect.Right:=maxint else
    if AllowModifyX then
     Rect.Right:=maxint;
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

     NewWidth:=Rect.Right-Rect.Left;
     NewHeight:=Rect.Bottom-Rect.Top;
end;


function TdhCustomLabel.EmptyContent:boolean;
begin
 result:=gltext=markupEmptyEle;
end;

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
    if CenterVertical then
     inc(ActLineY,(AvailY-TotalHeight) div 2);

    if (ti=0) then
     UseStyleTree.ry:=-ActLine.lmin+ActLineY else
    if UseStyleTree.VerticalAlign=atTop then
     UseStyleTree.ry:=0+ActLineY else
    if (UseStyleTree.VerticalAlign=atBottom) then
     UseStyleTree.ry:=ActLine.maxHeight-UseStyleTree.LineHeight+ActLineY else
    if UseStyleTree.RefStyleTree<>nil then
     UseStyleTree.ry:=UseStyleTree.VerticalAlign+UseStyleTree.RefStyleTree.ry else
     UseStyleTree.ry:=0; //should not occur

    ActLineY:=ActLine.y;
    if CenterVertical and (StyleTree<>TopStyleTree) then
     inc(ActLineY,(AvailY-TotalHeight) div 2);

    if StyleTree.Blocking and (UseStyleTree.vn=ActLine.vn) then
    begin
     startx:=StyleTree.offs.Left;
     endx:=Avail-StyleTree.offs.Right;
     EndAt:=Lines[UseStyleTree.LastBlockLine].EndAt;
     if UseStyleTree.img_width<>0 then
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

function TdhCustomLabel.LetterSpacing: Integer;
begin
   if not GetVal(pcLetterSpacing) then
    Cascaded.LetterSpacing:='normal';
   LetterSpacing:=GetLetterSpacing(Cascaded.LetterSpacing,GetComputedFontSize);
end;

function TdhCustomLabel.WordSpacing: Integer;
begin
   if not GetVal(pcWordSpacing) then
    Cascaded.WordSpacing:='normal';
   WordSpacing:=GetWordSpacing(Cascaded.WordSpacing,GetComputedFontSize);
end;


//Calcs width for character gltext[i]:
//Ppre[i]+P[i]+Psuc[i]=Pall[i]
//if StyleTree starts with character i: StyleTree.toleft part of Ppre[i]; StyleTree.toright occordingly
procedure TdhCustomLabel.CalcCharWidths;
var bs,vn,ii,toleft,toright,Fit:integer;
    StyleTree:TStyleTree;
    teil:AnsiString;
    Sz:TSize;
    Canvas:TCanvas;
    _LetterSpacing,_WordSpacing:Integer;
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

   _LetterSpacing:=LetterSpacing;
   _WordSpacing:=WordSpacing;

   if (gltext[vn]<>markupEmptyEle) then
   begin
    sz.cx:=-20;
{$IFDEF CLX}
    FontMetrics:=QFontMetrics_create(Canvas.Font.Handle);
    try
    for ii:=vn to bs-1 do
     P[ii]:=QFontMetrics_width(FontMetrics,@gltext[ii]);
    finally
     QFontMetrics_destroy(FontMetrics);
    end;
{$ELSE}
{$IFDEF VER160}
    pi:=@P[vn];
    GetTextExtentExPointW(Canvas.Handle, copy(gltext,vn,bs-vn),bs-vn, high(integer), Fit, pi^{P[vn]}, Sz);
{$ELSE}
    GetTextExtentExPointW(Canvas.Handle, PWideChar(@gltext[vn]),bs-vn, high(integer), @Fit, PInteger(@P[vn]), Sz);
    if sz.cx=-20 then
    begin
     teil:=AnsiString(_WStr(PWideChar(@gltext[vn]),bs-vn));
     GetTextExtentExPointA(Canvas.Handle, PAnsiChar(teil),length(teil), high(smallint), @Fit, PInteger(@P[vn]), Sz);
    end;
{$ENDIF}
   for ii:=bs-1 downto vn+1 do
    P[ii]:=P[ii]-P[ii-1];
{$ENDIF}
   for ii:=vn to bs-1 do
    P[ii]:=P[ii]+_LetterSpacing;
   for ii:=vn to bs-1 do
   if gltext[ii]=' ' then
    P[ii]:=P[ii]+_WordSpacing;
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

{$IFDEF CLX}
   FontMetrics:=QFontMetrics_create(Canvas.Font.Handle);
   try
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
    delta,bs:integer;

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
    StyleTree:=nil;

   while StyleTree<>nil do
   begin
    if StyleTree.Blocking then
    if (StartChar<>BisChar) and (StyleTree.vn=BisChar) then
    begin
     ForceBreak:=true;
     BreakByBlock:=true;
     break;
    end;
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
     _WrapAlways and not((gltext[i2-1]=' ') and (gltext[i2]<>' ')) or
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
     delta:=round(UseStyleTree.ContentHeight{set in CalcCharHeights}/4.65);
     if delta<>0 then
     begin
      inc(Psuc[bs-1],delta);
      inc(Pall[bs-1],delta);
     end;
    end;
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
var lmin,lmax,w:integer;
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

 VPercent:=ComputedFontSize; //should use line-height (StyleTree.LineHeight) to conforming to css spec, similar does firefox, however better do it as IE

 if StyleTree.IsImg then
 begin
  StyleTree.LineHeight:=StyleTree.ContentHeight;
 end else
 if StyleTree.IsBut then
 begin
  VPercent:=StyleTree.LineHeight; //as firefox
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
 if (Ptree[vn]=StyleTree) and not((gltext[vn]=markupEmptyEle) and not Ptree[vn].IsImg) then
 begin
  result:=true;
  exit;
 end;
 result:=(StyleTree.HasBorder or not IsNullRect(StyleTree.AllEdgesPure)) and not StyleTree.Blocking;
end;





procedure TdhCustomLabel.CalcMinMax;
var line:integer;
    ActLine:PLineInfo;
    ti:integer;
    StyleTree:TStyleTree;
begin

 TotalHeight:=0;
 for line:=0 to high(Lines) do
 begin
  ActLine:=@Lines[line];

  ActLine.maxHeight:=0;
  ActLine.lmin:=0;

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
     begin
      ActLine.maxHeight:=StyleTree.lmax-StyleTree.lmin;
      ActLine.lmin:=StyleTree.lmin;
     end;
    end else
    begin
     StyleTree.ParentStyle.lmin:=min(StyleTree.ParentStyle.lmin,StyleTree.lmin);
     StyleTree.ParentStyle.lmax:=max(StyleTree.ParentStyle.lmax,StyleTree.lmax);
    end;
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
     UseStyleTree:=nil;
     break;
    end;
   end;
   inc(y,ActLine.offs.Top);
   ActLine.y:=y;
   ActLine.RealOffsX:=0;
   if ActLine.lineavail=maxint then
    kuchen:=ActLine.lineavail else
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
 StyleTree.HasBorder:=not IsNullRect(BorderPure);
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


function inttoroman(i:integer):HypeString;
const b10:  array[0..9] of HypeString=('','I','II','III','IV','V','VI','VII','VIII','IX');
const b100: array[0..9] of HypeString=('','X','XX','XXX','XL','L','LX','LXX','LXXX','XC');
const b1000:array[0..9] of HypeString=('','C','CC','CCC','CD','D','DC','DCC','DCCC','CM');
begin
 result:=b1000[(i div 100) mod 10]+b100[(i div 10) mod 10]+b10[i mod 10];
end;

function inttoalpha(i:integer):HypeString;
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

begin
 //dont use .endtag since not set within ParseHTML, but .starttag is already set
 if (TopStyleTree<>nil) and (length(ClientStyleTree_starttag)>=1) then
 begin
  act_pos:=0;
  result:=FindStartTag(TopStyleTree);
  exit;
 end;
 result:=nil;
end;


procedure TdhCustomLabel.FreeLines;
var l:integer;
begin
  for l:=0 to high(Lines) do
   Lines[l].AllTrees.Free;
  SetLength(Lines,0);
end;

procedure TdhCustomLabel.FocusPreferStyle(IsMain,RealChange:boolean);
begin
 inherited FocusPreferStyle(IsMain,RealChange or glPaintOnlyBg);
end;

function TdhCustomLabel.GetComputedFontSize:single;
begin
 if UseStyleTree=nil then
 begin
  result:=inherited GetComputedFontSize;
  exit;
 end;
 result:=UseStyleTree.FontSize;
end;

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
  P^:=Cardinal(min(($FF-GreenComponent(P^))*5 div 4,$FF)) shl 24 or Color;
  inc(P);
 end;
 end;
 Bt.DrawMode:=dmBlend;
end;


procedure TdhCustomLabel.PaintListItem;
var StyleTree:TStyleTree;
    ListItemPosition,ListX,ListY:integer;
    ListItemRct:TRect;
    sListItemPosition:HypeString;
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
      QPainter_drawText(Canvas.Handle, ListX-Canvas.TextWidth(sListItemPositionWide)-10, ListY, PWideString(@sListItemPosition), length(sListItemPositionWide));
{$ELSE}
      ExtTextOutW(Canvas.Handle, ListX-Canvas.TextWidth(sListItemPosition)-10, ListY, 0, nil, PWideChar(sListItemPosition), length(sListItemPosition), nil);
{$ENDIF}
     end;
end;


procedure TdhCustomLabel.DoDrawText(var ConstraintsRect: TRect; CalcRect:boolean); //{$IFDEF VER160}unsafe;{$ENDIF}
var line,ti,x,y,vn,bs:integer;
    ActLine:PLineInfo;
    rct,brct,rct2,rct3,TextRct:TRect;
    StyleTree:TStyleTree;
    TextSizes:TPoint;
    StyleElement:ICon;
    ClpRct:TRect;
    _AntiAliasing:boolean;
{$IFNDEF CLX}
  LogFont: TLogFont;
  fh:HFont;
{$ENDIF}
  Canvas:TCanvas;
  OldClipRect:TRect;
  level:Integer;
  Coord:TPoint;
begin
 ParseHTML;
 if TopStyleTree<>nil then
 begin
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
  ClpRct:=ConstraintsRect;
  if Focused then
   Coord:=CharToCoord(SelStart) else
   Coord.Y:=-1;
  for line:=0 to high(Lines) do
  begin
   ActLine:=@Lines[line];

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
   end else
   if Visibility then
   begin
    OffsetRect(brct,-HPos,-VPos);
    OffsetRect(rct,-HPos,-VPos);
    if Display=cdsListItem then
     PaintListItem(Canvas,brct);
    IntersectRect(rct2,rct,ClpRct);
    if not IsRectEmpty(rct2) then
     SpecialPaintBorder(rct,brct);
    rct:=rct2;
    rct3:=brct;
    IntersectRect(brct,brct,ClpRct);
    SpecialBg(rct3,rct3,ActTopGraph,brct,false);
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
    Canvas.FillRect(Bounds(TextRct.Left, TextRct.Top, TextRct.Right-TextRct.Left, 1));
   end;

    Canvas.Brush.Color:=clRed; //seems to be necessary, otherwise TextOut is not transparent
    Canvas.Brush.Style:=bsClear;

    if not _AntiAliasing and IsOpaqueColor(FontColor) then
    begin
{$IFDEF CLX}
     Canvas.TextRect(ClpRct, TextRct.Left, TextRct.Top, copy(gltext,vn, bs-vn));
{$ELSE}
     ExtTextOutW(Canvas.Handle, TextRct.Left, TextRct.Top, ETO_CLIPPED, @ClpRct, PWideChar(@gltext[vn]), bs-vn, PInteger(@Pall[vn]));
{$ENDIF}
    end else
{$IFNDEF CLX}
    if not AAA then
    begin

    GetObject(Canvas.Font.Handle,
            SizeOf(LogFont),
            @LogFont);
    LogFont.lfQuality := ANTIALIASED_QUALITY;

    fh:=CreateFontIndirect(LogFont);
    Canvas.Font.Handle := fh;

    if HelpB=nil then
    begin
     HelpB:=TBitmap32.Create;
     HelpB.Canvas.Brush.Style:=bsClear;
    end;
    TextSizes:=Point(AddP(vn,bs)+AddP(bs-1,bs){at italics font the last char},UseStyleTree.ContentHeight);
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
    if _AntiAliasing then
     level:=AALevel else
     level:=0;
    ActTopGraph.RenderTextExtended(TextRct.Left, TextRct.Top, copy(gltext,vn,bs-vn), level,CSSColorToColor32(FontColor),Point(TextRct.Right-TextRct.Left,TextRct.Bottom-TextRct.Top),AddP(bs-1,bs),LetterSpacing,WordSpacing);
    ActTopGraph.ClipRect:=OldClipRect;
   end;


    end;

    finally
     inc(Pall[vn],Ppre[vn]);
     inc(Pall[bs-1],Psuc[bs-1]);
    end;
    end;
    inc(x,AddP(vn,bs));
   end;
    if Coord.Y=line then
    begin
     x:=ConstraintsRect.Left+ActLine.offs.Left-HPos;
     vn:=ActLine.vn+Coord.X;
     if vn<ActLine.bs then inc(x,Ppre[vn]);
     UseStyleTree:=Ptree[Min(vn,High(Ptree))];
     TextRct:=Bounds(ActLine.RealOffsX+x+AddP(ActLine.vn,vn), UseStyleTree.ry+y, 0, UseStyleTree.LineHeight);
     BoxToContent(StyleTree,TextRct);
     try
      UseStyleTree:=TStyleTree.Create;
      UseStyleTree.StyleElement:=dhStrEditDlg.cursor;
      brct:=TextRct;
      rct:=InflRect(brct,BorderPure);
      SpecialPaintBorder(rct,brct,PC_Cursor);
      rct3:=brct;
      IntersectRect(brct,brct,ClpRct);
      SpecialBg(rct3,rct3,ActTopGraph,brct,false);
     finally
       FreeAndNil(UseStyleTree);
     end; 
    end;
  end;
  end;

  UseStyleTree:=nil;
 end;
end;

procedure TdhCustomLabel.ReadCaption(Reader: TReader);
begin
 SetHTMLText(Reader.ReadString);
end;

function TdhCustomLabel.Referer:TdhCustomPanel;
begin
 if (UseStyleTree<>nil) and (UseStyleTree.StyleElement<>nil) then
  result:=UseStyleTree.StyleElement.GetCommon else
  result:=Self;
end;

function TdhCustomLabel.TextTransform:TCSSTextTransform;
begin
 if GetVal(pcTextTransform) then
  result:=Cascaded.TextTransform else
  result:=cttNone;
end;

function TdhCustomLabel.AntiAliasing:boolean;
begin
 if GetVal(pcAntiAliasing) then
  result:=Cascaded.AntiAliasing else
  result:=false;
end;

function TdhCustomLabel.WhiteSpace:TCSSWhiteSpace;
begin
 if GetVal(pcWhiteSpace) then
  result:=Cascaded.WhiteSpace else
  result:=cwsNormal;
end;


function TdhCustomLabel.ListStyleType:TCSSListStyleType;
begin
 Cascaded.ListStyleType:=clsDisk;
 GetVal(pcListStyleType);
 result:=Cascaded.ListStyleType;
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
begin
 if GetVal(pcTextIndent) then
  result:=GetTextIndentPixels(Cascaded.TextIndent,ComputedFontSize) else
  result:=0;
end;

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
 if (Message.Msg=WM_LBUTTONDOWN) or (Message.Msg=WM_LBUTTONUP) then
 begin
 if TransitionInvalidates then
 if (TopStyleTree<>nil) and (TopStyleTree.Count>=1) then //for speed, when there is no inline-element, but e.g. only an image
  NotifyCSSChanged(ActStyleChanged{[wcSize,wcNoOwnCSS]}); //for the case the inline-element is in down-state
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


function TdhCustomLabel.FinalShowing:boolean;
begin
 result:=Showing or (Parent<>nil) and Parent.Showing and FinalVisible(Self);
end;

function TdhCustomLabel.RenderedText:WideString;
begin
 AssureRenamingAware(false);
 result:=gltext;
end;

procedure TdhCustomLabel.WriteTrue(Writer: TWriter);
begin
 Writer.WriteBoolean(true);
end;


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

 P:=Mouse.CursorPos;
 DecPt(P,GetCBound(Self).TopLeft);
 IncPt(P,Point(HPos,VPos));
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
 end else
 begin
  SetLength(ClientStyleTree_starttag,0);
 end;

  if ((OldClientStyleTree<>ClientStyleTree) or StateChanged) and (Transi(OldClientStyleTree) or Transi(ClientStyleTree))   then
  begin
    NotifyCSSChanged(ActStyleChanged);
  end;
end;


function TdhCustomLabel.CharPos:integer;
var
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
   if not (p.y>=ActLine.y) then continue;
   x:=ActLine.RealOffsX+ActLine.offs.Left;
   for w:=ActLine.vn to ActLine.bs-1 do
   begin
    inc(x,Pall[w]);
    if p.x<x then
    begin
     result:=w;
     exit;
    end;
   end;
   result:=AfterLastCharOfLine(l)+1;
   exit;
  end;
  result:=0;
end;

begin
 P:=Mouse.CursorPos;
 DecPt(P,GetCBound(Self).TopLeft);
 IncPt(P,Point(HPos,VPos));
 R:=Rect(0,0,Width,Height);
 result:=GetSelChar;
end;

procedure TdhCustomLabel.GetModifiedText(var pre,s,suc: HypeString);
begin
 if (s='') and IsAbsolutePositioned then
  s:=' ';
end;

function TdhCustomLabel.InterpreteDirectly:Boolean;
begin
  result:=false;
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


function TdhCustomLabel.TextExtent(const Text: AString): TSize;
var Canvas:TCanvas;
    DC: HDC;
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
    Result:=Canvas.TextExtent(Text);
  finally
    FreeAndNil(Canvas);
    ReleaseDC(0, DC);
  end;
{$ENDIF}
end;


function TdhCustomLabel.WrapAlways: boolean;
begin
 result:=false;
end;

procedure BuildUnicode; //{$IFDEF VER160}unsafe;{$ENDIF}
var i:integer;
begin
 _Unicode:=TStringList.Create;

 for i:=0 to high (HtmlEntities) do
 begin
{$IFDEF VER160}
  _Unicode.AddObject(HtmlEntities[i].Name,HtmlEntities[i].Code);
{$ELSE}
  _Unicode.AddObject(HtmlEntities[i].Name,Pointer(HtmlEntities[i].Code));
{$ENDIF}
 end;

 _Unicode.Sorted:=true;

 UnicodeByNumbersList:=TDictionary<Integer,String>.Create(_Unicode.Count);
 for i:=0 to _Unicode.Count-1 do
 begin
  UnicodeByNumbersList.Add(Integer(_Unicode.Objects[i]),_Unicode[i]);
 end;

 for i:=0 to _Unicode.Count-1 do
 if Ord(WideChar(_Unicode.Objects[i]))<=255 then
  what_uni[AnsiChar(_Unicode.Objects[i])]:=i;

end;

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
  ChangeText :=
    not (csLoading in ComponentState) and (Name = FHTMLText) and
    ((Owner = nil) or not (Owner is TControl) or
    not (csLoading in TControl(Owner).ComponentState));
  inherited SetName(Value);
  if ChangeText then SetHTMLText(Value);
end;


function TdhCustomLabel.MyGetControlExtents(OnlyForScrollbars:boolean): TPoint;
begin
  if IsScrollArea and FVertScrollbarAlwaysVisible then
   Result.X:=Width-VertScrollBar else
   Result.X:=Width;
  Result.Y:=0;
  GetInnerAutoRect(false,true,result.X,result.Y);
end;

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


function TdhCustomLabel.CharToCoord(pos:Integer):TPoint;
var l,vn:Integer;
    ActLine:PLineInfo;
begin
  if pos>High(TrackChar) then
  begin
    Result.Y:=High(Lines);
    Result.X:=AfterLastCharOfLine(Result.Y)-CharOfLine(Result.Y);
    exit;
  end;
  vn:=pos+1;
  for l:=high(Lines) downto 0 do
  begin
   ActLine:=@Lines[l];
   if (vn>=ActLine.vn) then
   begin
    result.Y:=l;
    result.X:=pos-CharOfLine(l);
    exit;
   end;
  end;
  result.Y:=-1;
end;

function TdhCustomLabel.CharOfLine(line:Integer):Integer;
begin
  result:=Lines[line].vn-1;
end;

function TdhCustomLabel.AfterLastCharOfLine(line:Integer):Integer;
var ActLine:PLineInfo;
    bs:integer;
begin
    ActLine:=@Lines[line];
    bs:=ActLine.bs;
    while (bs>Actline.vn) and (gltext[bs-1]=markupBreak) do
     dec(bs);
    result:=bs-1;
end;

function TdhCustomLabel.CoordToChar(const Coord:TPoint):Integer;
var i:Integer;
begin
  Result:=Min(CharOfLine(Coord.Y)+Coord.X,AfterLastCharOfLine(Coord.Y));
end;

procedure TdhCustomLabel.KeyDown(var Key: Word; Shift: TShiftState);
var StartRow,StartRow2,StartRow3:Integer;
    Coord:TPoint;
begin
 inherited;
 case (Key) of
 VK_UP:
 begin
  Coord:=CharToCoord(SelStart);
  if (Coord.Y=-1) or (Coord.Y=0) then
   exit;
  Dec(Coord.Y);
  SetSelStart(CoordToChar(Coord));
 end;
 VK_DOWN:
 begin
  Coord:=CharToCoord(SelStart);
  if (Coord.Y=-1) or (Coord.Y=High(Lines)) then
   exit;
  Inc(Coord.Y);
  SetSelStart(CoordToChar(Coord));
 end;
 VK_HOME:
 begin
  Coord:=CharToCoord(SelStart);
  if Coord.Y=-1 then
   exit;
  Coord.X:=0;
  SetSelStart(CoordToChar(Coord));
 end;
 VK_END:
 begin
  Coord:=CharToCoord(SelStart);
  if Coord.Y=-1 then
   exit;
  Coord.X:=High(TrackChar)+1;
  SetSelStart(CoordToChar(Coord));
 end;
 VK_RIGHT:
 begin
  if SelStart+1<=High(TrackChar)+1 then
   SetSelStart(SelStart+1);
 end;
 VK_LEFT:
 begin
  if SelStart-1>=Low(TrackChar) then
   SetSelStart(SelStart-1);
 end;
 VK_DELETE:
 if (SelStart>=Low(TrackChar)) and (SelStart<=High(TrackChar)) then
 with TrackChar[SelStart] do
 begin
   SetHTMLText(Copy(FHTMLText,1,vn-1)+Copy(FHTMLText,bs,MaxInt));
   if Assigned(glChangedContent) then glChangedContent(Self,false);
 end;
 end;
end;

function TdhCustomLabel.CharPosToTrackChar(const pos:integer):TOneTrackChar;
begin
 if (pos-1>=Low(TrackChar)) and (pos-1<=High(TrackChar)) then
  result:=TrackChar[pos-1] else
  begin
  result.vn:=Length(FHTMLText)+1;
  result.bs:=Length(FHTMLText)+1;
  end;
end;

procedure TdhCustomLabel.KeyPress(var Key: AChar);
var vn:Integer;
    ToInsert:HypeString;
    StyleTree:TStyleTree;

function GetCodeForChar(SelStart:Integer):HypeString;
begin
  if (SelStart>=Low(TrackChar)) and (SelStart<=High(TrackChar)) and (gltext[SelStart+1]<>markupBreak) then
  with TrackChar[SelStart] do
    Result:=Copy(FHTMLText,vn,bs-vn) else
    Result:=' ';
end;

begin
 inherited;
 if Char(VK_BACK)=Key then
 begin
   if (SelStart-1>=Low(TrackChar)) and (SelStart-1<=High(TrackChar)) then
   with TrackChar[SelStart-1] do
   begin
    SetHTMLText(Copy(FHTMLText,1,vn-1)+Copy(FHTMLText,bs,MaxInt));
    Dec(SelStart);
   end else
    exit;
 end else
 begin
 vn:=CharPosToTrackChar(SelStart+1).vn;
 StyleTree:=Ptree[Min(SelStart+1,High(Ptree))];
 if (Char(VK_SPACE)=Key) or (Char(VK_TAB)=Key) then
 begin
  ToInsert:=' ';
  if (StyleTree.WhiteSpace<>cwsPre) and not InterpreteDirectly then
  if (GetCodeForChar(SelStart-1)=' ') or (GetCodeForChar(SelStart-1)='&nbsp;') or (GetCodeForChar(SelStart)=' ') or (GetCodeForChar(SelStart)='&nbsp;')  then
   ToInsert:='&nbsp;';
 end else
 if Char(VK_RETURN)=Key then
 begin
   if (StyleTree.WhiteSpace=cwsPre) or InterpreteDirectly then
    ToInsert:=#10 else
    ToInsert:='<br/>';
 end else
 if Char(VK_ESCAPE)=Key then
 begin
   StopEditing;
   Exit;
 end else
 if Char(0)=Key then exit else
 if InterpreteDirectly then
  ToInsert:=Key else
  ToInsert:=ConvertWideStringToUnicode(Key,false);
 SetHTMLText(Copy(FHTMLText,1,vn-1)+ToInsert+Copy(FHTMLText,vn,MaxInt));
 inc(SelStart);
 end;
 if Assigned(glChangedContent) then glChangedContent(Self,false);
end;

procedure TdhCustomLabel.StartOrContinueEditingAtMousePosition;
begin
  SetSelStart(Max(0,CharPos-1));
  Windows.SetFocus(Handle);
end;

procedure TdhCustomLabel.StopEditing;
begin
 if Windows.GetFocus=Handle then
  Windows.SetFocus(0);
end;

{$IFNDEF CLX}
procedure TdhCustomLabel.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result:=DLGC_WANTARROWS;
end;
{$ENDIF}

procedure TdhCustomLabel.PC_Cursor(F: TColor32; var B: TColor32; M: TColor32);
begin
  if IsOpaqueColor(Color32ToCSSColor(F)) then
    B := B xor (F and $00FFFFFF);
end;

procedure TdhCustomLabel.SetSelStart(value:integer);
begin
  if SelStart<>value then
  begin
    SelStart:=value;
    NotifyCSSChanged([wcNoOwnCSS]);
  end;
end;

procedure TdhCustomlabel.OnSetFocus(var Msg: TWMSetFocus);
begin
    Inherited;
    FOldHTMLText:=FHTMLText;
    NotifyCSSChanged([wcNoOwnCSS]);
end;

procedure TdhCustomlabel.OnKillFocus(var Msg: TWMKillFocus);
begin
    Inherited;
    if (FOldHTMLText<>FHTMLText) and Assigned(glChangedContent) then
     glChangedContent(Self,true);
    NotifyCSSChanged([wcNoOwnCSS]);
end;

function TdhCustomLabel.GetFinal: ICon;
var TagIndex:Integer;
begin
 if AssertTags2 then
 if not IsDlg and HTMLTags.Find(Name,TagIndex) then
   result:=TdhCustomPanel(HTMLTags.Objects[TagIndex]) else
   result:=nil;
end;

procedure TdhCustomLabel.NameChanged;
begin
  inherited;
  NotifyCSSChanged(AllChanged); // see TdhCustomLabel.GetFinal
end;

initialization
 BuildUnicode;
{$IFNDEF CLX}
 Win32PlatformIsUnicode := (Win32Platform = VER_PLATFORM_WIN32_NT);
{$ENDIF}
 AssertTags2;

finalization
 if dhStrEditDlg<>nil then
 if not (csDestroying in dhStrEditDlg.ComponentState) then
  FreeAndNil(dhStrEditDlg);
 FreeAndNil(HTMLTags);
 FreeAndNil(_Unicode);
 FreeAndNil(UnicodeByNumbersList);
 FreeAndNil(HelpB);
end.
