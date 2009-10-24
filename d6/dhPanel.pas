{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
unit dhPanel;

interface


{$R 'imagebitmap.res'}

{$IFDEF VER160}
{$UNSAFECODE ON}
{$ENDIF}

{.$DEFINE DEB}
{.$DEFINE Q}
{.$IFNDEF CLX}
{.$DEFINE SYNC_PROP}
{.$ENDIF}

uses
  SysUtils, Classes, TypInfo, {$IFNDEF VER130} types, {schnelles IntersectRect} {$ENDIF}
  pngimage, {$IFDEF MSWINDOWS}ShellAPI,jpeg,{$ELSE}libc,{$ENDIF}
{$IFDEF CLX}
  GIFImage,QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls,
  QComCtrls, QStdCtrls, QTypes,
{$ELSE}
  GIFImage,Controls, Forms, Windows, Messages, Graphics, Dialogs, ExtCtrls, appevnts{Application.OnIdle:= überschreiben mit eigenem code},
  ComCtrls, CommCtrl, StdCtrls, clipbrd,
{$ENDIF}
  math{$IFNDEF VER130}{, variants}{$ENDIF}{$IFDEF DEB},funcutils,jclDebug{$ENDIF},
  GR32,GR32_Transforms,gauss,GR32_Blend,GR32_LowLevel,crc,BinList,BinTree,MyBitmap32;

const EmptyStr='';

var QUOTEINVALIDVALUE_STR:WideString='"%" is not a valid value';
var REFOBJECT_STR:WideString= '% is referenced by %';


//type TSaveBin= ;
type HypeString=WideString;
     HypeChar=WideChar;

var glSaveBin:function(_crc:DWORD; var RasteringFile,AbsoluteRasteringFile:string; CheckBaseRasteringFile:boolean; BaseRasteringFile:string; var NeedSave:boolean; NeedSameFileName:boolean):boolean;
var glAfterSaveBin:procedure;
//NeedSameFileName
{$IFDEF VER160}
type shell_pchar=string;
{$ELSE}
type shell_pchar=pchar;
{$ENDIF}

type TASXY=(asNone,asX,asY,asXY);

const asar:array[boolean,boolean] of TASXY=((asNone,asY),(asX,asXY));

const default_borderwidth=1;

var WithMeta:boolean=false;
{$IFDEF CLX}
type HWND=QWidgetH;
{$ENDIF}
                               {
type TBoundsChanging=procedure (hwnd:HWND);
var glBoundsChanging:TBoundsChanging;  }

type TFrameEventType=(feMouseUp,feMouseDown,feMouseMove);
type
  TDesignedFor=(dfAnything,dfMenu,dfMenuItem,dfMenuItemWithMenu,dfSeparatorBar);
  TUpdateOver=procedure(Self:TControl; IsOver:boolean; Clicked:boolean);
  TActMode=(amNone,VertButton1,VertButton2,VertBar,VertChecked1,VertChecked2,
                   HorzButton1,HorzButton2,HorzBar,HorzChecked1,HorzChecked2,
  amAddDown,amCloseDown,amOpenDown,amAddLinkDown,VertOneButton);

const atTop=-maxint;
      atBottom=maxint;

//var AddHA:TStringList;
                 

{$IFDEF CLX}
const VK_ESCAPE=Key_Escape;
{$ENDIF}


var glUpdateOver:TUpdateOver;

type TEdgeAlign= (ealNone, ealTop, ealBottom, ealLeft, ealRight);
type TCornerAlign=TEdgeAlign;
const calNone=ealNone;
      calTopLeft=ealTop;
      calBottomRight=ealBottom;
      calBottomLeft=ealLeft;
      calTopRight=ealRight;
//type TCornerAlign= (calNone, calTopLeft, calBottomRight, calBottomLeft, calTopRight);


type
  TOneChanged=(
  wcChild, //propagates changes to childs
  wcParent, //InvalTop is not needed
  wcFont, //update Win Font
  wcColor, //update Win Color
  wcCursor, //update Win Cursor
  wcZIndex, //update Win Z-Order
  wcSize, //update Width/Height, including realign
  wcNoOwnCSS, //no CSS was changed
  wcNoComputedCSS, //no computed CSS was changed
  wcText, //invalidate TdhLabel.ParseHTML
  wcText2, //invalidate TdhLabel.BuildLines
  wcTemplate, //deprecated
  wcName, //TComponent.Name changed -> update InlineUsedByList
  wcState //State may have changed
  );
  TWhatChanged=set of TOneChanged;

  //wcText implies wcText2, wcNoComputedCSS implies wcNoOwnCSS, all other changes are independent

const
  AllChanged=        [wcFont,wcColor,wcCursor,wcText,wcText2,wcSize,wcChild,wcZIndex,wcState];
  InheritableChanges=[wcFont,wcColor,wcCursor,wcText,wcText2,wcSize,wcChild,wcNoOwnCSS,wcNoComputedCSS];
  ActStyleChanged=   [wcFont,wcColor,wcCursor,wcText,wcText2,wcSize,wcChild,wcZIndex,wcState,wcNoOwnCSS];
  ActStyleLoaded=    [wcFont,wcColor,wcCursor,wcText,wcText2,wcSize,wcChild,wcZIndex,wcState,wcNoOwnCSS,wcNoComputedCSS];
  ReqInvals=         [wcFont,wcText,wcText2,wcName,wcState,wcNoOwnCSS];
  //VisualChanges=[wcFont,wcColor,wcText,wcSize];

  MarginDefault=EmptyStr;

(*
Const
  WM_ALIGNPARENT = WM_USER + 4;
*)
//WM_CHECKDESIGNSTATE

const
  CSSAlphaInverter=$FF000000;
  clBlackCSS=clBlack32 xor CSSAlphaInverter;
  clWhiteCSS=clWhite32 xor CSSAlphaInverter;
  srInherit=EmptyStr;
  vsrInherit=MaxInt;
  scolInherit=EmptyStr;
  colInherit=$12345678 xor CSSAlphaInverter;
  colGlowDefault=$FFBEFFFF xor CSSAlphaInverter;
  colShadowDefault=clBlackCSS;
  scolTransparent='Transparent';
  colTransparent=$00456789 xor CSSAlphaInverter;
type
  TCSSCursor=(ccuInherit,ccuAuto,ccuCrosshair, ccuDefault, ccuPointer, ccuMove,
    ccuEResize, ccuNeResize, ccuNwResize, ccuNResize, ccuSeResize, ccuSwResize, ccuSResize, ccuWResize,
//    ccuEResize, ccuNEResize, ccuNWResize, ccuNResize, ccuSEResize, ccuSWResize, ccuSResize, ccuWResize,
    ccuText, ccuWait, ccuHelp);
const CSSCursorMap:array[TCSSCursor] of TCursor=
  (crDefault,crDefault,crCross,crArrow,crHandPoint,crSizeAll,
   crSizeWE,crSizeNESW,crSizeNWSE,crSizeNS,           crSizeNWSE,crSizeNESW,crSizeNS,crSizeWE,
   crIBeam,crHourGlass,crHelp);


type TRasterType=(rsNo,rsFull,rsRounded,rsRGBA,rsSemi,rsStretch,rsSplit,rsFullWithoutText);
const rasterReason:array[TRasterType] of string=(EmptyStr,'enabled Effects','rounded corners','RGBA colors','a semi-transparent image','the image type "Stretch"','the image type "Split"','enabled Effects (not applying to textual content)');

const EnableIgnoreCSS=True;

type
  TCSSTextDecoration=(ctdNone,ctdUnderline,ctdOverline,ctdLineThrough,ctdBlink);
  TCSSTextDecorations=set of TCSSTextDecoration;
  TState=(   hsNormal,hsOver,hsDown,hsOverDown);

  TStates=set of TState;
  TCSSBackgroundPosition=type string;
  TCSSVerticalAlign=type string;
  TCSSLetterSpacing=type string;
  TCSSWordSpacing=type string;
  TCSSLineHeight=type string;
  TCSSFontFamily=type string;
  TSlidePixel=1..9999;
  TReactionTime=0..9999;
  TCSSColor=type TColor32;
  TCSSInteger=type Integer;
  TCSSCardinal=0..MaxInt;
  TCSSBackgroundAttachment=(cbaInherit,cbaScroll,cbaFixed);
  TCSSBackgroundRepeat=(cbrInherit,cbrRepeat,cbrRepeatX,cbrRepeatY,cbrNoRepeat);
  TCSSBorderStyle=(cbsInherit,cbsNone,cbsHidden,cbsDotted,cbsDashed,cbsSolid,cbsDouble,cbsGroove,cbsRidge,cbsInset,cbsOutset);
  TCSSTextTransform=(cttInherit,cttCapitalize,cttUppercase,cttLowercase,cttNone);
  TCSSTextAlign=(ctaInherit,ctaLeft,ctaRight,ctaCenter,ctaJustify);
  TCSSWhiteSpace=(cwsInherit,cwsNormal,cwsPre,cwsNowrap);
  TCSSDirection=(cdiInherit,cdiLtr,cdiRtl);
  TCSSFontStyle=(cfsInherit,cfsNormal,cfsItalic,cfsOblique);
  TCSSFontWeight=(cfwInherit,cfwNormal,cfwBold,cfwBolder,cfwLighter,cfw100,cfw200,cfw300,cfw400,cfw500,cfw600,cfw700,cfw800,cfw900);
  TCSSDisplay=(cdsInherit,cdsInline,cdsBlock,cdsListItem,cdsNone);
  TCSSVisibility=(cviInherit,cviHidden,cviVisible);
  TCSSListStyleType=(clsInherit,clsDisk,clsCircle,clsSquare,clsNone,clsDecimal,clsLowerRoman,clsUpperRoman,clsLowerAlpha,clsUpperAlpha);
  TCSSTextIndent=type string;
  TCSSFontSize=type string;//variant;
  TCSSMargin=type string;//variant;
  TCSSFontVariant=(cfvInherit,cfvNormal,cfvSmallCaps);
  //TCSSAntiAliasing=(caaInherit,caaNone,caaKind1,caaKind2);

  TImageType=(bitInherit,bitTile,{bitLayered,}bitStretch,bitImage,bitSplit);
  TImageFormat=(ifInherit,ifSimple,ifSemiTransparent,ifJPEG);
  TPhysicalImageFormat=(pifSaveAsGIF,pifSaveAsPNG,pifSaveAsJPEG);

  TEffectsOnText=(etInclude,etExclude,etOnly);

const sStyle:array[TState] of string=('Style','StyleOver','StyleDown','StyleOverDown');


const InvalidCSSPos=maxint;
      InvalidEqArea=maxint;


type  TPropChoose=(pcAntiAliasing,pcBackgroundAttachment,pcBackgroundColor,pcBackgroundImage,pcBackgroundPosition,pcBackgroundRepeat,pcBorderColor,pcBorderRadius, pcBorderWidth,pcBorderStyle,pcColor,pcContentAfter,pcContentBefore,pcCursor,pcDirection,pcDisplay,pcEffects,pcFontFamily,pcFontSize,pcFontStyle,pcFontVariant,pcFontWeight,pcLetterSpacing,pcLineHeight,pcListStyleType,
                   pcMargin,pcMinHeight,pcMinWidth,pcPadding,pcTextAlign,pcTextDecoration,pcTextIndent,pcTextTransform,pcTransformationsMatrix,pcVerticalAlign,pcVisibility,pcWhiteSpace,pcWordSpacing,pcZIndex,pcOther);
var pcChanges:array[TPropChoose] of TWhatChanged=({pcAntiAliasing}[{empty}],{pcBackgroundAttachment}[],{pcBackgroundColor}[wcColor],{pcBackgroundImage}[wcSize,wcText],{pcBackgroundPosition}[],{pcBackgroundRepeat}[],{pcBorderColor}[],{pcBorderRadius}[],{pcBorderWidth}[wcSize,wcText2],{pcBorderStyle}[wcSize,wcText2],{pcColor}[wcFont],{pcContentAfter}[wcText,wcSize],{pcContentBefore}[wcText,wcSize],{pcCursor}[wcCursor],{pcDirection}[wcText2,wcSize],{pcDisplay}[wcText,wcSize],{pcEffects}[wcSize],{pcFontFamily}[wcFont,wcText2,wcSize],{pcFontSize}[wcFont,wcText2,wcSize],{pcFontStyle}[wcSize,wcFont,wcText2],{pcFontVariant}[wcText,wcSize],{pcFontWeight}[wcFont,wcText2,wcSize],{pcLetterSpacing}[wcText2,wcSize],{pcLineHeight}[wcText2,wcSize],{pcListStyleType}[],
                   {pcMargin}[wcSize,wcText2],{pcMinHeight}[wcSize],{pcMinWidth}[wcSize],{pcPadding}[wcSize,wcText2],{pcTextAlign}[wcText2],{pcTextDecoration}[wcFont],{pcTextIndent}[wcText2,wcSize],{pcTextTransform}[wcText,wcSize],{pcTransformationsMatrix}[{empty}],{pcVerticalAlign}[wcText2,wcSize],{pcVisibility}[],{pcWhiteSpace}[wcText,wcSize],{pcWordSpacing}[wcText2,wcSize],{pcZIndex}[wcZIndex],{pcOther}[]);


type



  TdhCustomPanel=class;
  TOnStateTransition=procedure(Sender: TdhCustomPanel; OldState:TState) of object;
  TStyle=class;
  TStyleArray=array[TState] of TStyle;
  TTransformations=class;

  TBlurEffect=class(TPersistent)
  private
    FDegree: integer;
    FDistance: integer;
    FAlpha: byte;
    FDeciRadius: integer;
    FColor: TCSSColor;
    FFlood: integer;
    FEnabled: boolean;
    Owner:TTransformations;
    procedure SetAlpha(const Value: byte);
    procedure SetColor(const Value: TCSSColor);
    procedure SetDegree(const Value: integer);
    procedure SetDistance(const Value: integer);
    procedure SetFlood(const Value: integer);
    procedure SetRadius(const Value: integer);
    procedure SetDeciRadius(const Value: integer);
    procedure SetEnabled(const Value: boolean);
    function GetDoubleRadius:double;
  protected
    procedure Changed;
  public
    procedure Clear; virtual;
    function IsCleared:boolean; virtual;
    function MaxJitter:integer;
    property Degree:integer read FDegree write SetDegree;
    property Distance:integer read FDistance write SetDistance default 5;
    property Alpha:byte read FAlpha write SetAlpha;
    property Radius:integer write SetRadius;
    property DeciRadius:integer read FDeciRadius write SetDeciRadius;
    property Color:TCSSColor read FColor write SetColor;
    property Flood:integer read FFlood write SetFlood;
    procedure Assign(Source: TPersistent); override;
  published
    property Enabled:boolean read FEnabled write SetEnabled default false;
  end;

  TShadow=class(TBlurEffect)
  public
    constructor Create(AOwner: TTransformations);
  published
    procedure Clear; Override;
    function IsCleared:boolean; Override;
    property Alpha default 191;
    property Radius default 5;
    property DeciRadius default 50;
    property Color default colShadowDefault;
    property Flood default 0;
    property Degree default 120;
    property Distance default 5;
  end;

  TGlow=class(TBlurEffect)
  public
    constructor Create(AOwner: TTransformations);
    procedure Clear; Override;
    function IsCleared:boolean; Override;
  published
    property Alpha default 191;
    property Radius default 5;
    property DeciRadius default 50;
    property Color default colGlowDefault;
    property Flood default 0;
  end;

  TBlur=class(TBlurEffect)
  public
    constructor Create(AOwner: TTransformations);
    procedure Clear; Override;
    function IsCleared:boolean; Override;
  published
    property Radius default 5;
    property DeciRadius default 50;
    //property Flood default 0;
  end;

//  TCommon=class;

  TCSSBorderRadius=class(TPersistent)
  private
  protected
    Owner:TStyle;
    Vals:array[TCornerAlign] of string;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create(AOwner: TStyle);
    procedure Changed;
    procedure SetBorderRadius(Align:TCornerAlign; Value:string);
    function IsCleared:boolean; overload;
    function IsCleared(align:TCornerAlign):boolean; overload;
  published
    property All: string index ealNone  read Vals[calNone] write SetBorderRadius;
    property TopLeft: string index ealTop read Vals[calTopLeft] write SetBorderRadius;
    property BottomRight: string index ealBottom read Vals[calBottomRight] write SetBorderRadius;
    property BottomLeft: string index ealLeft read Vals[calBottomLeft] write SetBorderRadius;
    property TopRight: string index ealRight read Vals[calTopRight] write SetBorderRadius;
  end;

  TTransformations=class(TPersistent)
  private
    FUseBased: boolean;
    FFullIfEasy: boolean;
    FAlpha: byte;
    FInnerShadow: TShadow;
    FInnerGlow: TGlow;
    FOuterGlow: TGlow;
    FOuterShadow: TShadow;
    FBlur: TBlur;
    FShiftY: integer;
    FShiftX: integer;
    FStretchLinear,FStretchParted,FRotateEnabled,FShiftEnabled,FEnabled:boolean;
    FRotationDegree:integer;
    FScaleX,FScaleY,FSkewX,FSkewY:integer;
    FAntiAliasing:boolean;
    FText:TEffectsOnText;
    //FTextOnly: boolean;
    //FTextExclude: boolean;
    Owner:TStyle;

{    function IsScaleXStored: Boolean;
    function IsScaleYStored: Boolean;
    function IsSkewXStored: Boolean;
    function IsSkewYStored: Boolean;}
    procedure SetRotationDegree(const Value: integer);
    procedure SetRotateEnabled(const Value: boolean);
    procedure SetShiftEnabled(const Value: boolean);
    procedure SetStretchLinear(const Value: boolean);
    procedure SetStretchParted(const Value: boolean);
    procedure SetEnabled(const Value: boolean);
    procedure SetAntiAliasing(const Value: boolean);
    procedure SetFullIfEasy(const Value: boolean);
    procedure SetAlpha(const Value: byte);
    procedure SetScaleX(const Value: integer);
    procedure SetScaleY(const Value: integer);
    procedure SetSkewX(const Value: integer);
    procedure SetSkewY(const Value: integer);
    procedure SetShiftX(const Value: integer);
    procedure SetShiftY(const Value: integer);
    procedure SetUseBased(const Value: boolean);
    function IsAntiAliasingStored: Boolean;
    //function IsTextOnlyStored: Boolean;
    //function IsTextExcludeStored: Boolean;
    function IsTextStored: Boolean;
    procedure SetTextOnly(const Value: boolean);
    function GetTextOnly:boolean;
    procedure SetTextExclude(const Value: boolean);
    function GetTextExclude:boolean;
    procedure SetText(const Value: TEffectsOnText);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
   procedure SkipValue(Reader: TReader);
   procedure Assign(Source: TPersistent); override;
   procedure Clear;
   function IsCleared:boolean;
   function IsMainCleared:boolean;
   function IsTransformationsCleared:boolean;
   function IsBlurEffectsCleared:boolean;
   constructor Create(AOwner: TStyle);
   destructor Destroy; override;
   procedure Changed;
   property UseBased:boolean read FUseBased write SetUseBased default false;
   property FullIfEasy:boolean read FFullIfEasy write SetFullIfEasy default true;
  published
   property Rotation:integer read FRotationDegree write SetRotationDegree default 0;
//   property PartX:integer read FPartPoint.X write FPartPoint.X;
//   property PartY:integer read FPartPoint.Y write FPartPoint.Y ;
   property ShiftX:integer read FShiftX write SetShiftX default 0;
   property ShiftY:integer read FShiftY write SetShiftY default 0;
   property ScaleX:integer read FScaleX write SetScaleX default 100;
   property ScaleY:integer read FScaleY write SetScaleY default 100;
   property SkewX:integer read FSkewX write SetSkewX default 0;
   property SkewY:integer read FSkewY write SetSkewY default 0;
//   property StretchLinear:boolean read FStretchLinear write SetStretchLinear;
//   property StretchParted:boolean read FStretchParted write SetStretchParted;
//   property RotateEnabled:boolean read FRotateEnabled write SetRotateEnabled;
//   property ShiftEnabled:boolean read FShiftEnabled write SetShiftEnabled;
   property Enabled:boolean read FEnabled write SetEnabled default false;
   property AntiAliasing:boolean read FAntiAliasing write SetAntiAliasing stored IsAntiAliasingStored;
   property TextOnly:boolean read GetTextOnly write SetTextOnly stored false;
   property TextExclude:boolean read GetTextExclude write SetTextExclude stored false;
   property Text:TEffectsOnText read FText write SetText stored IsTextStored;

   property Alpha:byte read FAlpha write SetAlpha default 255;
   property InnerShadow:TShadow read FInnerShadow write FInnerShadow;
   property OuterShadow:TShadow read FOuterShadow write FOuterShadow;
   property InnerGlow:TGlow read FInnerGlow write FInnerGlow;
   property OuterGlow:TGlow read FOuterGlow write FOuterGlow;
   property Blur:TBlur read FBlur write FBlur;
  end;

  TCSSBorder=class(TPersistent)
  private
    procedure AssignComputed(pn: TdhCustomPanel; Align:TEdgeAlign);
//    procedure WriteCompact(Writer: TWriter);
//    procedure WriteBorderColor(Writer: TWriter);
  protected
   Owner:TStyle;
   FColor:TCSSColor;
   FWidth:TCSSCardinal;
   FStyle:TCSSBorderStyle;
   procedure SetWidth(Value:TCSSCardinal);
   procedure SetColor(Value:TCSSColor);
   procedure SetStyle(Value:TCSSBorderStyle);
   procedure SetAll(Width:Integer;Color:TCSSColor;Style:TCSSBorderStyle);
   procedure DefineProperties(Filer: TFiler); override;
  public
   procedure Assign(Source: TPersistent); override;
   constructor Create(AOwner:TStyle);
   function IsStored:boolean;
   function IsWidthCleared:boolean;
   procedure Clear;
  published
   property Width:TCSSCardinal read FWidth write SetWidth default vsrInherit;
   property Color:TCSSColor read FColor write SetColor default colInherit;
   property Style:TCSSBorderStyle read FStyle write SetStyle default Low(TCSSBorderStyle);
  end;

  TPictureID=class(TPicture)
  private
  public
  end;

  TImageState=(isUninitialized,isAnalyzed,isOnePixel,isSemiTransparent,isAnimatedGIF);

  TLocationImage=class(TPersistent)
  private
    FOnChange:TNotifyEvent;
    FPictureID:TPictureID;
    FPath:String;
    FImageState:TImageState;
    FWidth,FHeight:Integer;
    Owner:TStyle;
    InChange:Boolean;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Changed(Sender: TObject);
    function CalculateImgCanT1X1:boolean;
    function CalculateImgCouldBeRastered:boolean;
    function CalculateAnimatedGIF:boolean;
    function ImgIsT1X1:boolean;
    function ImgNeedBeRastered:boolean;
    function IsAnimatedGIF:boolean;
    procedure UpdateCalculations(CanReleaseResources:Boolean);
    procedure RequestCalculations;
    function StoreCalculations:boolean;
    procedure ReleaseResources;
    function CachingIsUseful:Boolean;
    procedure Clear;
  public                             
    property PictureID:TPictureID read FPictureID;
    function HasPath: Boolean;
    function GraphicExtension:String;
    function GetGraphic:TGraphic;
    function RequestGraphic:TGraphic;
    function HasPicture:boolean;
    destructor Destroy; override;
    constructor Create;
    procedure LoadFromFile(const Filename: string);
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    procedure SetPath(const Path:String);
    function GetRelativePath:String;
    function GetAbsolutePath:String; 
    procedure UpdateAnimationState;
  published
    property Path:String read GetRelativePath write SetPath;
    property State:TImageState read FImageState write FImageState stored StoreCalculations;
    property Width:Integer read FWidth write FWidth stored StoreCalculations;
    property Height:Integer read FHeight write FHeight stored StoreCalculations;
  end;

  TCascaded = record
    Width: TCSSCardinal;
    CSSInteger: TCSSInteger;
    BorderStyle:TCSSBorderStyle;
    Color:TCSSColor;
    Picture:TLocationImage;
    BackgroundRepeat:TCSSBackgroundRepeat;
    BackgroundAttachment:TCSSBackgroundAttachment;
    WhiteSpace:TCSSWhiteSpace;
    Direction:TCSSDirection;
    TextAlign:TCSSTextAlign;
    TextTransform:TCSSTextTransform;
    FontStyle:TCSSFontStyle;
    FontWeight:TCSSFontWeight;
    FontVariant:TCSSFontVariant;
    TextDecoration:TCSSTextDecorations;
    Cursor:TCSSCursor;
    Display:TCSSDisplay;
    Visibility:TCSSVisibility;
    ListStyleType:TCSSListStyleType;
    AntiAliasing:boolean;//TCSSAntiAliasing;
    Transformations:TTransformations;

    Before,After:string;
    BackgroundPosition:TCSSBackgroundPosition;
    VerticalAlign:TCSSVerticalAlign;   
    LetterSpacing:TCSSLetterSpacing;
    WordSpacing:TCSSWordSpacing;
    LineHeight:TCSSLineHeight;
    TextIndent:TCSSTextIndent;
    BorderRadius:string;
    Margin:string;
    FontFamily:TCSSFontFamily;
    Other:HypeString;
    FontSize:string;
  end;

  THasCommon=function(Control:TPersistent; var Common:TdhCustomPanel):boolean;
  TSpecialBorderType=(sbtNormal,sbtButton,sbtEdit);

  ICon=interface
    //function GetOverBasedOnDown:boolean;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
    function DoGetVal(PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign; var DoExit:boolean):boolean;
    procedure UpdateNames(InlineUse,NewInlineUse:ICon; PropagateChange:boolean);
    function ChildHasAnchor(a:TAnchors):boolean;
    function FetchSharing(Sharing:TControl):TWhatChanged;
    procedure DoCSSToWinControl(WhatChanged:TWhatChanged=[]);
    function GetCommon:TdhCustomPanel;
    function GetName:string;
    //function InheritProp(PropChoose:TPropChoose):boolean;
    //function IsVisualAnchor:boolean;
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
    //procedure PreferStyleChange;
    procedure FocusPreferStyle(IsMain,RealChange:boolean);

    function RequiresRastering:boolean;
  end;

  IChangeReceiver=TdhCustomPanel;

  TStyle = class(TPersistent)
  private
    procedure ReadBool(Reader: TReader);
    procedure SkipValue(Reader: TReader);
    function BaseWH: TPoint;
    function BasePadding(IgnoreCSS:TRasterType):TRect;
    function BaseMargin(IgnoreCSS:TRasterType):TRect;
    function BaseBorder(IgnoreCSS:TRasterType):TRect;
    function BaseBorderColors:string;
    function PrepareBGImage:boolean;
    //function PrepareBGRastering: boolean;
    //procedure WriteBGRastering(Writer: TWriter);
    procedure WriteNewPadding(Writer: TWriter);
    procedure Write0px(Writer: TWriter);
    procedure WriteNewMargin(Writer: TWriter);

    function BaseRasteringFile:string;
    procedure PictureProgress(Sender: TObject; Stage: TProgressStage;
      PercentDone: Byte; RedrawNow: Boolean; const R: TRect;
      const Msg: string);
    procedure CopyFrom(s: TStyle; sub:boolean);
    procedure SetFontVariant(const Value: TCSSFontVariant);
    procedure SetBackgroundAttachment(
      const Value: TCSSBackgroundAttachment);
    procedure SetDirection(const Value: TCSSDirection);
    procedure SetBefore(const Value: String);
    procedure SetAfter(const Value: String);
    function IsFontSizeStored: boolean;
//    function IsMarginStored: boolean;
    procedure ReadMargin(Reader: TReader);
    procedure WriteMargin(Writer: TWriter);
    function IsMarginBottomStored: boolean;
    function IsMarginLeftStored: boolean;
    function IsMarginRightStored: boolean;
    function IsMarginTopStored: boolean;    
    function IsBorderColorsStored:boolean;
//    procedure WriteNewMargin(Writer: TWriter);
  protected
    OwnState:TState;
    FBorderColors:string;
    BGImageFile:string;
    _GetWantedSize:TPoint;
    _ContentWidthHeight:TPoint;
    IsWidthStored,IsHeightStored:boolean;
    IsNewPaddingStored,IsNewMarginStored,IsNewBorderStored:boolean;

    _BasePadding,_BaseMargin,_BaseBorder:TRect;

    FDirection: TCSSDirection;
    FBefore: String;
    FAfter: String;
    FBorders:array[TEdgeAlign] of TCSSBorder;
    FBackgroundImage: TLocationImage;
    FBackgroundAttachment: TCSSBackgroundAttachment;
    FBackgroundColor:TCSSColor;
    FBackgroundRepeat:TCSSBackgroundRepeat;
    FBackgroundPosition:TCSSBackgroundPosition;
    FPaddings:array[TEdgeAlign] of TCSSCardinal;
    FMargins:array[TEdgeAlign] of TCSSMargin;
    FOther:HypeString;
    FTextAlign:TCSSTextAlign;
    FWhiteSpace:TCSSWhiteSpace;
    FTextTransform:TCSSTextTransform;
    FCursor:TCSSCursor;
    FFontSize:TCSSFontSize;
    FFontFamily:TCSSFontFamily;
    FColor:TCSSColor;
    FFontStyle:TCSSFontStyle;
    FFontWeight:TCSSFontWeight;
    FFontVariant:TCSSFontVariant;
    FTextDecoration:TCSSTextDecorations;
    FZIndex:TCSSInteger;
    FMinWidth:TCSSCardinal;
    FMinHeight:TCSSCardinal;
    FVerticalAlign:TCSSVerticalAlign;
    FLetterSpacing:TCSSLetterSpacing;
    FWordSpacing:TCSSWordSpacing;
    FLineHeight:TCSSLineHeight;
    FDisplay:TCSSDisplay;
    FVisibility:TCSSVisibility;
    FListStyleType:TCSSListStyleType;
    FTextIndent:TCSSTextIndent;
    //FAntiAliasing:TCSSAntiAliasing;
    FTransformations:TTransformations;
    FBorderRadius:TCSSBorderRadius;

    //function IsItStored:boolean;
    function GetStyleVal(PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign):boolean;
    function GetNameByStyle:string;


    //function GetClientMeasure(Index:integer):TCSSInteger;
    //procedure SetClientMeasure(Index:integer; Value:TCSSInteger);
    procedure InitMisc;
    procedure SetBackgroundImage(Value: TLocationImage);
    procedure SetBackgroundRepeat(Value:TCSSBackgroundRepeat);
    procedure SetBackgroundColor(Value:TCSSColor);
    procedure SetTextAlign(Value:TCSSTextAlign);
    procedure SetWhiteSpace(Value:TCSSWhiteSpace);
    procedure SetTextTransform(Value:TCSSTextTransform);
    procedure SetCursor(Value:TCSSCursor);
    procedure SetBackgroundPosition(Value:TCSSBackgroundPosition);
    procedure SetVerticalAlign(Value:TCSSVerticalAlign);
    procedure SetLetterSpacing(Value:TCSSLetterSpacing);
    procedure SetWordSpacing(Value:TCSSWordSpacing);
    procedure SetLineHeight(Value:TCSSLineHeight);
    procedure SetTextIndent(Value:TCSSTextIndent);
    procedure SetZIndex(Value:TCSSInteger);
    procedure SetMinWidth(Value:TCSSCardinal);
    procedure SetMinHeight(Value:TCSSCardinal);
    procedure SetDisplay(Value:TCSSDisplay);
    procedure SetVisibility(Value:TCSSVisibility);
    procedure SetListStyleType(Value:TCSSListStyleType);

    procedure SetFontSize(Value:TCSSFontSize);
    //procedure SetAntiAliasing(Value:TCSSAntiAliasing);
    //function GetFontSize:TCSSFontSize;
    //function IsFontSizeStored:boolean;
    procedure SetFontFamily(Value:TCSSFontFamily);
    procedure SetColor(Value:TCSSColor);
    procedure SetFontStyle(Value:TCSSFontStyle);
    procedure SetFontWeight(Value:TCSSFontWeight);
    procedure SetTextDecorations(Value:TCSSTextDecorations);
    procedure pcs(WhatChanged:TWhatChanged);
    procedure pc(PropChoose:TPropChoose);



//    procedure WriteContentWidthHeight(Writer: TWriter);
//    procedure WriteClientTopLeft(Writer: TWriter);
//    procedure WriteClientBottomRight(Writer: TWriter);

//    procedure ReadString(Reader: TReader);
//    procedure ReadInteger(Reader: TReader);
//    procedure ReadInteger2(Reader: TReader);

//    procedure WriteStyleText(Writer: TWriter);
    procedure WriteContentWidth(Writer: TWriter);
    procedure WriteContentHeight(Writer: TWriter);

{
    procedure WriteClientLeft(Writer: TWriter);
    procedure WriteClientTop(Writer: TWriter);
    procedure WriteClientBottom(Writer: TWriter);
    procedure WriteClientRight(Writer: TWriter);   }
    procedure WriteRastering(Writer: TWriter);
    procedure WriteBackgroundImageUrl(Writer: TWriter);
    procedure WriteBorderColors(Writer: TWriter);

//    procedure ReadBool(Reader: TReader);
    procedure WriteTrue(Writer: TWriter);
    procedure DefineProperties(Filer: TFiler); override;
    function UndefFilter(IsRastered:boolean):boolean;

    procedure PictureChange(Sender: TObject);



  public
    Owner:IChangeReceiver;//TCommon;
    RasteringFile:string;
    
    function ProposedBackgroundFilename: String;
    function PrepareRastering(addheight:integer; const PostFix:string): boolean;
    function IsMarginCleared(Align:TEdgeAlign):boolean;
    function IsBGImageCleared: boolean;
    function IsEdgeCleared(Align: TEdgeAlign): boolean;
    procedure AssignComputedEdge(Align: TEdgeAlign; pn: TdhCustomPanel);
    function CopyBlurEffectsByInherited: boolean;

    function HasInheritedTransformations(var tt: TTransformations):boolean;
    procedure LoadImage(const filename: string);
    function IsPictureStored:boolean;
    procedure SetPadding(Align:TEdgeAlign; Value:TCSSCardinal=vsrInherit);
    //function ReadMargin(Align:TEdgeAlign):TCSSMargin;
//    function ReadPadding(Align:TEdgeAlign):TCSSCardinal;
    procedure SetMargin(Align:TEdgeAlign; Value:TCSSMargin);
    function GetBorder(Align: TEdgeAlign): TCSSBorder;
    //function GetPadding(Align: TEdgeAlign): TCSSCardinal;
    function IsPaddingCleared(Align: TEdgeAlign): boolean;
    //function GetMargin(Align: TEdgeAlign): TCSSCardinal;
    //function IsContentWidthHeightStored:boolean;
    procedure AssignEdge(Align: TEdgeAlign; s: TStyle);
    procedure AssignBackground(s: TStyle);
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create(AOwner:IChangeReceiver; OwnState:TState);
    destructor Destroy; override;
    procedure GetFontDifferences({const Font:TFont}FontStyle:TFontStyles; FontColor:TCSSColor; FontName:TFontName; FontHeight:Integer);
//    function IsMeasureStored(Index:integer):boolean;
    function GetInfo:string;
    function IsStyleStored:boolean;
    function GetBorderByName(const name:string; var r:TCSSBorder):boolean;
    procedure ClearEdge(Align:TEdgeAlign);
    property Borders[Align:TEdgeAlign]:TCSSBorder read GetBorder;

{    property FontSize:TCSSFontSize read FFontSize write SetFontSize;
    property Margin: TCSSMargin index ealNone read FMargins[ealNone] write SetMargin;
    property MarginLeft: TCSSMargin index ealLeft read FMargins[ealLeft] write SetMargin;
    property MarginTop: TCSSMargin index ealTop read FMargins[ealTop] write SetMargin;
    property MarginRight: TCSSMargin index ealRight read FMargins[ealRight] write SetMargin;
    property MarginBottom: TCSSMargin index ealBottom read FMargins[ealBottom] write SetMargin;
}
  published
    property Border: TCSSBorder read FBorders[ealNone] write FBorders[ealNone];
    property BorderTop: TCSSBorder read FBorders[ealTop] write FBorders[ealTop];
    property BorderBottom: TCSSBorder read FBorders[ealBottom] write FBorders[ealBottom];
    property BorderLeft: TCSSBorder read FBorders[ealLeft] write FBorders[ealLeft];
    property BorderRight: TCSSBorder read FBorders[ealRight] write FBorders[ealRight];
    property BackgroundAttachment: TCSSBackgroundAttachment read FBackgroundAttachment write SetBackgroundAttachment default cbaInherit;
    property BackgroundImage: TLocationImage read FBackgroundImage write SetBackgroundImage stored IsPictureStored;
    property BackgroundPosition: TCSSBackgroundPosition read FBackgroundPosition write SetBackgroundPosition;
    property BackgroundRepeat: TCSSBackgroundRepeat read FBackgroundRepeat write SetBackgroundRepeat default cbrInherit;
    property Padding: TCSSCardinal index ealNone read FPaddings[ealNone] write SetPadding default vsrInherit;
    property PaddingLeft: TCSSCardinal index ealLeft read FPaddings[ealLeft] write SetPadding default vsrInherit;
    property PaddingTop: TCSSCardinal index ealTop read FPaddings[ealTop] write SetPadding default vsrInherit;
    property PaddingRight: TCSSCardinal index ealRight read FPaddings[ealRight] write SetPadding default vsrInherit;
    property PaddingBottom: TCSSCardinal index ealBottom read FPaddings[ealBottom] write SetPadding default vsrInherit;


    property FontSize:TCSSFontSize read FFontSize write SetFontSize;
    property Margin: TCSSMargin index ealNone read FMargins[ealNone] write SetMargin;
    property MarginLeft: TCSSMargin index ealLeft read FMargins[ealLeft] write SetMargin;
    property MarginTop: TCSSMargin index ealTop read FMargins[ealTop] write SetMargin;
    property MarginRight: TCSSMargin index ealRight read FMargins[ealRight] write SetMargin;
    property MarginBottom: TCSSMargin index ealBottom read FMargins[ealBottom] write SetMargin;

    property Other: HypeString read FOther write FOther;
    property ContentBefore: String read FBefore write SetBefore;
    property ContentAfter: String read FAfter write SetAfter;
    property BackgroundColor:TCSSColor read FBackgroundColor write SetBackgroundColor default colInherit;
    property TextAlign:TCSSTextAlign read FTextAlign write SetTextAlign default ctaInherit;
    property WhiteSpace:TCSSWhiteSpace read FWhiteSpace write SetWhiteSpace default cwsInherit;
    property Direction:TCSSDirection read FDirection write SetDirection default cdiInherit;
    property TextTransform:TCSSTextTransform read FTextTransform write SetTextTransform default cttInherit;
    property Cursor:TCSSCursor read FCursor write SetCursor default ccuInherit;

    property FontFamily:TCSSFontFamily read FFontFamily write SetFontFamily;
    property Color:TCSSColor read FColor write SetColor default colInherit;
    property FontStyle:TCSSFontStyle read FFontStyle write SetFontStyle default cfsInherit;
    property FontWeight:TCSSFontWeight read FFontWeight write SetFontWeight default cfwInherit;
    property FontVariant:TCSSFontVariant read FFontVariant write SetFontVariant default cfvInherit;
    property TextDecoration:TCSSTextDecorations read FTextDecoration write SetTextDecorations default [];
    property ZIndex:TCSSInteger read FZIndex write SetZIndex default vsrInherit;
    property MinWidth:TCSSCardinal read FMinWidth write SetMinWidth default vsrInherit;
    property MinHeight:TCSSCardinal read FMinHeight write SetMinHeight default vsrInherit;
    property TextIndent:TCSSTextIndent read FTextIndent write SetTextIndent;

    property VerticalAlign: TCSSVerticalAlign read FVerticalAlign write SetVerticalAlign;
    property LetterSpacing: TCSSLetterSpacing read FLetterSpacing write SetLetterSpacing;
    property WordSpacing: TCSSWordSpacing read FWordSpacing write SetWordSpacing;
    property LineHeight: TCSSLineHeight read FLineHeight write SetLineHeight;
    property Display:TCSSDisplay read FDisplay write SetDisplay default cdsInherit;
    property Visibility:TCSSVisibility read FVisibility write SetVisibility default cviInherit;
    property ListStyleType:TCSSListStyleType read FListStyleType write SetListStyleType default clsInherit;

    //Effects
    //property AntiAliasing:TCSSAntiAliasing read FAntiAliasing write SetAntiAliasing default caaInherit;


    property Effects:TTransformations read FTransformations write FTransformations;
    property BorderRadius:TCSSBorderRadius read FBorderRadius write FBorderRadius;

    //TODO: SpeedupGeneration property Generated:String read RasteringFile write RasteringFile;

  end;
//  (n:'filter';b:bbFilter;v:'"Alpha(opacity=100, finishopacity=0, style=2)","Blur(direction=235, strength=6)",Chroma(color=#DDBB99),"DropShadow(color=#C0C0C0, offx=3, offy=3)",FlipH(),FlipV(),"Glow(color=#000000, strength=12)",Gray(),Invert(),'+'Mask(color=#000066),"Shadow(color=#000000, direction=45)","Wave(freq=5, light=20, phase=50, strength=6)",XRay()';m:[MGvisual]),


  TFormName=type string;



  TMyScrollInfo = record
    nMax: Integer;
    nPage: Integer;
  end;

{$IFDEF CLX}
  TdhCustomPanel = class(TCustomControl,ICon)
{$ELSE}
  TdhCustomPanel = class(TWinControl,ICon)
{$ENDIF}
{TCommon start}
  private

    FNoSiblingsBackground:boolean;
    FIsScrollArea: boolean;
    FDownOverlayOver: boolean;
    Fetching,FIsDlg:boolean;

    {function IsButton:boolean;
    function IsEdit:boolean;  }


    procedure CopyFrom(Use:ICon; sub:boolean);
    //function GetVertRange: integer;
    procedure AddInfo(sl: TStringList);
    procedure WriteRealAutoSizeXY(Writer: TWriter);
    procedure WriteCenterLeft(Writer: TWriter);
    procedure WriteCenterRight(Writer: TWriter);
    function CenterMargins:TPoint;
    //procedure SetAutoSizeHorzOnly(Value: Boolean);
    //procedure SkipValue2(Reader: TReader);
    procedure CSSToWinControl(WhatChanged:TWhatChanged=[]);
    procedure InvalTop(WithChilds,ExcludeOneself:boolean);
    procedure InvalBack(const R2:TRect);
    function GetAffine(inv: boolean): TAffineTransformation;
    //function HasEdgeImage(var FPicture: TPicture): boolean;
    //function HasStretchImage(var FPicture:TPicture):boolean;
    //function IsBGRastered: boolean;
    procedure WriteClientBottom(Writer: TWriter);
    procedure WriteClientLeft(Writer: TWriter);
    procedure WriteClientRight(Writer: TWriter);
    procedure WriteClientTop(Writer: TWriter);
    //procedure WritePadding(Writer: TWriter);
    //function NeedPadding: boolean;

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
    procedure WriteMarginHorz(Writer: TWriter);
    procedure WriteMarginVert(Writer: TWriter);
    procedure SetIsDlg(Value:Boolean);
    function GetSpecialBorderType:TSpecialBorderType;
    //function BorderClientRect:TRect;


    procedure LockDefinedCSS(var sStyleArr:TStyleArray);
    procedure UnlockDefinedCSS(var sStyleArr:TStyleArray);

    function HasImage(var FPicture: TGraphic): boolean; overload;


  protected
    function HasBackgroundImage:boolean; overload;
    function HasImage: boolean; overload;
    function HasImage(var PicWidth, PicHeight: integer): boolean; overload;
    function GetImageDir:String; virtual;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;

  public
    function HasBackgroundImage(var FPicture: TGraphic): boolean; overload;
    function HasBackgroundImage(var FPicture:TLocationImage):boolean; overload;

  public
    IsVertScrollBarVisible,IsHorzScrollBarVisible:boolean;
    FVertScrollbarAlwaysVisible,FHorzScrollbarAlwaysVisible:boolean;
    FVertScrollbarNeverVisible,FHorzScrollbarNeverVisible:boolean;
    NCScrollbars:boolean;
    FOneButton:boolean;
    ActTopGraph:TMyBitmap32;
    InlineUsedByList:TList;
    StyleArr:array[TState] of TStyle;
    //Control:TControl;
    //Con:ICon;
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

//    function GetClientTopLeft:TPoint;
//    function GetClientBottomRight:TPoint;
//    property ClientTopLeft:TPoint read GetClientTopLeft;
//    property ClientBottomRight:TPoint read GetClientBottomRight;

    procedure ClearAllStyles(ClearUse:boolean);
    procedure TransferStylesToUse;
    procedure TransferStylesToElement(Use:ICon);
    procedure ExchangeDownOverStyles;
    procedure GetStylesFromUse;
    procedure GetStylesFromElement(Use:ICon);
    function HasTransformations(var tt: TTransformations): boolean;
//    function IsImage:boolean;
    procedure DoDefineProperties(Filer: TFiler);
    procedure ReleaseResources;
//    procedure ReadBool(Reader: TReader);
    procedure CheckDesignState(inv:boolean=true);
    procedure WriteTrue(Writer: TWriter);
    procedure CSSToFont(Font:TFont=nil);
    function GetCharset:TFontCharset;
    procedure CSSToColor;
    procedure CSSToCursor;
    procedure FontHasChanged;
    procedure ColorHasChanged;
    procedure CursorHasChanged;
    procedure ParentFontHasChanged;
    procedure ParentColorHasChanged;
    procedure NameChanged;
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
    //procedure SetUsed(Value:boolean);
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
    //function PaddingClientRect:TRect;
    function PaddingPure:TRect;
    function MarginPure:TRect;
    function BorderPure:TRect;
    function BorderPureWithHidden:TRect;
    function AllEdgesPure:TRect;
    function GetBorderRadii(var TopLeft,TopRight,BottomLeft,BottomRight:TPoint; var TopLeftDouble,TopRightDouble,BottomLeftDouble,BottomRightDouble:boolean):boolean;
    function HasBorderRadii:boolean;
    function GetBorderRadius(EdgeAlign:TEdgeAlign):TPoint;
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
    //procedure UpdateSharing;

    function UsePn:TdhCustomPanel;

    procedure TransformUse(P:ICon; DoSUse:boolean);
    destructor Destroy; override;
    function FastDestroy:boolean;
    property Use:ICon read FUse write SetUse;

    function ItGetVal(state:TState; PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign=ealNone):boolean;
    procedure InvDesigner;
    function ActStyle:TStyle;
    procedure Frame3D(Border:TEdgeAlign; Points: array of TPoint);
    procedure SpecialBg(const ref_scrolled,ref_fixed:TRect; Src:TMyBitmap32; const brct: TRect; IsFixed:boolean{; OffsetPoint:TPoint});
    procedure SpecialPaintBorder(const rct,brct: TRect);
    function IsAbsolutePositioned:boolean;
    function GetStyleByName(const name:string; var r:TStyle):boolean;
    procedure SetIsOver(Value:boolean);
    procedure UpdateMouse(MouseEnter:boolean);
    procedure UpdateMousePressed(Down:boolean; DownIfDown:boolean);
    function IsVirtualParentOf(pn:TControl):boolean;
//    procedure ReadString(Reader: TReader);
    function GetLev:integer;
{TCommon end}

  private
    FTooltip:HypeString;
    EqArea:TRect;
    FPreciseClick:boolean;
    FComputedFontSize:single;
    FOnStateTransition:TOnStateTransition;
    FImageType:TImageType;
    FImageFormat:TImageFormat;
    DragHPos, DragVPos: Integer;
    FDragOffset:TPoint;
    TopIsValid,BackIsValid:boolean;
    BackGraph:TMyBitmap32;
    TopGraph:TMyBitmap32;
    TransparentTop:TMyBitmap32;
    _SelfCBound:TRect;
    VertScrollInfo: TMyScrollInfo;
    HorzScrollInfo: TMyScrollInfo;
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
//    FViewportHandle: QWidgetH;
{$ENDIF}


    //procedure ChildrenWeakToStrong;
    procedure ChildrenAdjustStrong(DeltaX,DeltaY:Integer);
    //procedure ChildrenValidateStrong;
    procedure InvalDeepestBack;
    procedure AssertTop(addheight:integer; NeedTransparentImage:boolean=false);
    procedure PaintHidden;
    procedure BeginPainting(bmp:TMyBitmap32);
    procedure EndPainting;
    procedure PixelCombineNormal(F: TColor32; var B: TColor32;
      M: TColor32);
    procedure PixelCombineMultiply(F: TColor32; var B: TColor32;
      M: TColor32);
    procedure PixelCombineNegativeMultiply(F: TColor32; var B: TColor32;
      M: TColor32);
    function TransPainting(nWidth:integer=-1; nHeight:integer=-1): TMyBitmap32;
    procedure SetImageType(const Value: TImageType);
    procedure WriteSUse(Writer: TWriter);
    procedure ReadSUse(Reader: TReader);

    procedure SetRight(const Value:integer);
    procedure SetBottom(const Value:integer);
    procedure ReadRight(Reader: TReader);
    procedure WriteRight(Writer: TWriter);
    procedure ReadBottom(Reader: TReader);
    procedure WriteBottom(Writer: TWriter);
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
    procedure WeakToStrong(IncludeActiveStrong:boolean);

    //function ClientArea: TPoint;
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
    //procedure SetAnchors(const Value: TAnchors);
    //function DoubleDown: boolean;
    procedure PixelCombineUnderpaint(F: TColor32; var B: TColor32;
      M: TColor32);
    procedure PixelCombineInner(F: TColor32; var B: TColor32; M: TColor32);
    procedure SetCenter(const Value: boolean);
    procedure PreventFlicker;
    procedure TransFromBlackWhite_BG(bmp: TMyBitmap32);
    procedure TransFromBlackWhite_TP(bmp:TMyBitmap32);
    procedure DoAutoSize(var PreferedWidth,PreferedHeight:integer);
  protected
   // FSharingEnabled:boolean;
    //FCaptionBoolean:boolean;
    SimplifiedAnchors:TAnchors;
    ActDown:TActMode;
    HPos, VPos: Integer;
    //OldWH:TPoint;
    //FIsDesignerSelected:boolean;
    //UC:integer;
    //SpecIn:boolean;
    //fmComponentState:TComponentState;
    //FFinal:string;
    //FBaseOverOnDown{,FBaseDownOnOverDown}:boolean;
    //LogMsg:string;

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
    //Realign

    procedure AdjustBackgroundColor(var Col: TCSSColor); virtual;
    function TextOnly: boolean; virtual;
    function TextExclude: boolean; virtual;
    function CustomSizesForEffects:boolean; virtual;
    function EasyBounds(var Transformations: TTransformations; var T: TAffineTransformation;
      var W,H:Integer; var HorzRotated, VertRotated: boolean): boolean;

    procedure ProcessMouseMove(StateChanged:boolean); virtual;
    function AdjustZIndex(ChildPos,ParentControlCount:integer):integer; virtual;
    procedure AdjustScrolling(var R: TRect);
    function Opaque:boolean;
    function TransparentEdges:TRect;
    function SemiTransparentEdges:TRect;
    procedure PaintWhiteBackground(ref_brct: TRect; Src: TMyBitmap32; const brct: TRect); virtual;
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
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;

    //procedure AdjustPainter(Painter: QPainterH); override;
    //function GetChildHandle: QWidgetH; override;
    //function ViewportHandle: QWidgetH;
    procedure ScrollBy(DeltaX, DeltaY: Integer); override;
    procedure CreateWidget; override;
    //function GetPaintDevice: QPaintDeviceH; override;
    //procedure BoundsChanged; //override;
    //procedure UpdateScrollMask;

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
(*
{$IFDEF CLX}
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
{$ELSE}
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
{$ENDIF}
*)


    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
(*
{$IFDEF CLX}
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
{$ELSE}
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
{$ENDIF}
*)

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
    procedure Invalidate; override;

    procedure DoTopPainting; virtual;
    //tocopy
    //procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
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
    //function GetUse:TControl;
    //procedure SetUse(Value: TControl);
    function GetStyle(Index:TState):TStyle;
    procedure SetStyle(Index:TState; Value:TStyle);


    procedure AdjustClientRect(var Rect: TRect); override;
    procedure DefineProperties(Filer: TFiler); override;


    //procedure SetIsDesignerSelected(Value:boolean);

    //Procedure WMAlignParent(Var Msg: TMessage); message WM_ALIGNPARENT;



    //function GetStyleStored:boolean;
    //procedure SetStyleStored(Value:boolean);

//    procedure UpdateMenuCoords; virtual;

    //procedure WriteFirstRealUse(Writer: TWriter);
//    procedure ReadString(Reader: TReader);
//    procedure ReadBool(Reader: TReader);
    procedure WriteFalse(Writer: TWriter);
    //procedure WriteTrue(Writer: TWriter);


{    procedure CustomAlignPosition(Control: TControl; var NewLeft, NewTop, NewWidth,
      NewHeight: Integer; var AlignRect: TRect; AlignInfo: TAlignInfo); override;
 }
    //function GetComponentState:TComponentState;
    procedure PaintBorder;

    function GetClientRect:TRect; override;
    //property IsDesignerSelected:boolean read FIsDesignerSelected write SetIsDesignerSelected;
    //property OverBasedOnDown:boolean read FBaseOverOnDown write FBaseOverOnDown default false;
//    property BaseDownOnOverDown:boolean read FBaseDownOnOverDown write FBaseOverDownOnDown;
    //function AdjPosList(i:integer; seIndex:TList):boolean; virtual;
    function LeaveY:boolean; virtual;
    procedure PrepareAlign; virtual;
    procedure AlignDone; virtual;
    procedure SetZOrder(TopMost: Boolean); override;
    //procedure AlignControls2(AControl: TControl; var Rect: TRect);

    //ICon
    //function GetOverBasedOnDown:boolean; virtual;
    function ChildHasAnchor(a:TAnchors):boolean;
    function FetchSharing(Sharing:TControl):TWhatChanged; virtual;
    procedure DoCSSToWinControl(WhatChanged:TWhatChanged); virtual;
    function DoGetVal(PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign; var DoExit:boolean):boolean; virtual;
    function GetCommon:TdhCustomPanel;
    //function InheritProp(PropChoose:TPropChoose):boolean; virtual;
    //function IsVisualAnchor:boolean; virtual;
    procedure AddOwnInfo(sl:TStrings); virtual;
    function GetHTMLState:TState; virtual;
    function GetCanvas:TCanvas;
    function GetName:string;
    procedure UpdateNames(InlineUse,NewInlineUse:ICon; PropagateChange:boolean); virtual;

    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); virtual;
    function GetSuperiorAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer):boolean;
    function AlignedTo:TAlign;
    function AllowAutoSizeY:boolean; virtual;


    function GetMaxWidth:integer;
    function GetMaxHeight:integer;

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
    { Public declarations }

    VariableHeight:boolean;
    //FCommon:TCommon;
    SUse:string;
//    Canvas:boolean;
//    function Canvas:

    //property Masked;

    DragEnabled:boolean;

    procedure MyRealign;

    function GetWantedSize:TPoint;

    function ShallBeAnchor:boolean; virtual;
    function GetInlineHTMLState(Over,Down:boolean):TState; virtual;

    function HeightDiff: integer; virtual;

    procedure PreferStyleChange;
    procedure FocusPreferStyle(IsMain,RealChange:boolean); virtual;

    function State:TState;

    property PreciseClick:boolean read FPreciseClick write FPreciseClick;

    //procedure SkipValue(Reader: TReader);
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

    function GetOpaquePainting(var TopGraph: TMyBitmap32): boolean;

    function HorizontalCenter:boolean;
    function VerticalCenter:boolean;
    //property Center:boolean read FCenter write SetCenter stored false default false;

    procedure SetBoundedVHPos(H, V: integer);
    property HTMLAttributes:HypeString read FHTMLAttributes write FHTMLAttributes;
//    procedure TryBrokenReferences; virtual;
    procedure CopyDependencies(CopyList:TList); virtual;

    procedure TryBrokenReferences(sl:TStringList); virtual;
    procedure ScrollInView(AControl: TControl; ForceTop:boolean);
    procedure DoStateTransition(OldState:TState); virtual;
    function TransitionInvalidates: boolean; virtual;
    function GetImageType: TImageType; //virtual;
    function GetImageFormat: TImageFormat;
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
    procedure SaveAsImage(const FileName:string; WithBackground:boolean=false);

    function VirtualParent:TControl; virtual;
    constructor Create(AOwner: TComponent); override;
    procedure ConstrainedResize(var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer); override;
{}
//    procedure Paint; override;

    property Style:TStyle index hsNormal read GetStyle write SetStyle;
    property Transparent : boolean read GetTransparent write SetTransparent stored false;
    //property Use:TControl read GetUse write SetUse;
    property Color stored false;
    property Font stored false;
    property Cursor stored false;
    property AutoSizeXY:TASXY read FAutoSize write SetASXY{ default asNone};

    property ImageType:TImageType read FImageType write SetImageType default bitInherit;
    property ImageFormat:TImageFormat read FImageFormat write FImageFormat default ifInherit;

    property VertPosition:integer read VPos write SetVPos default 0;
    property HorzPosition:integer read HPos write SetHPos default 0;

    //property PreferDownStyles:boolean read GetDownOverlayOver write SetDownOverlayOver{ default false};

    property OnDragOver;
    property OnDragDrop;


    property Right:Integer read CSSRight write SetRight stored IsRightStored default InvalidCSSPos;
    property Bottom:Integer read CSSBottom write SetBottom stored IsBottomStored default InvalidCSSPos;

    //property Cursor write SetCursor stored false default crDefault;
    //property ParentColor stored false;
    //property ParentFont stored false;

              {
    property UseStyle:TStyle read FUseStyle write FUseStyle stored false;
    property UseForm:TCustomForm read FUseForm write FUseForm stored false;

    property NCCalc:boolean read FNCCalc write FNCCalc stored false;
    property ACR:boolean read FACR write FACR stored false;

    property Log:string read FLog write FLog stored false;
    }
    //property Design:TState read FDesignState write SetDesignState stored false;
    //property Log:string read LogMsg write LogMsg stored false;
  published
    //property Anchors{: TAnchors read GetAnchors} write SetAnchors{ stored IsAnchorsStored default [akLeft, akTop]};
    property Left stored IsLeftStored;
    property Top stored IsTopStored;
    property Width stored IsWidthStored;
    property Height stored IsHeightStored;
    property Tooltip:HypeString read FTooltip write FTooltip;
    //property Anchors write SetAnchors;
  end;

  TdhPanel = class(TdhCustomPanel)
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
    property Cursor;
{    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
}
    property Enabled;
//    property FullRepaint;
//    property Locked;
//    property ParentBiDiMode;
//    property ParentColor;
//    property ParentCtl3D;
//    property ParentFont;
    property ParentShowHint;
//    property PopupMenu;
    property ShowHint;
//    property TabStop;


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

type TPreAddCompo=procedure(parent:TdhCustomPanel);
type TPostAddCompo=procedure(Page:TdhCustomPanel{; Anchor:TControl});
var glPreAddCompo:TPreAddCompo;
var glPostAddCompo:TPostAddCompo;

function GetCursorBack(Cursor:TCursor):TCSSCursor;
function FindForm(Value:string; var f:TForm):boolean;


function GetCRCFromBitmap32(b:TMyBitmap32; w,h:integer; ResumeCrc:DWORD=0):DWORD;

//function ColorToIdent(Color: Longint; var Ident: string): Boolean;
function IdentToColor(const Ident: string; var Color: Longint): Boolean;
function ColorToString(Color: TCSSColor): string; overload;
function ColorToString(Color: Longint): string; overload;
function CursorToString(Cursor: TCSSCursor): string;
//function HasCommon(Control:TPersistent; var Common:TCommon):boolean;

function CharPos(const S: String; const C: Char; Index: Integer): Integer; overload;
function CharPos(const S: WideString; const C: WideChar; Index: Integer): Integer; overload;
function CharPosBack(const S: String; const C: Char; Index: Integer): Integer; overload;
function CharPosBack(const S: WideString; const C: WideChar; Index: Integer): Integer; overload;
function AbsCopy(const s:string; von,bis:integer):String; overload;
function AbsCopy(const s:WideString; von,bis:integer):WideString; overload;

//function HasCommon(Control:TPersistent; var Common:TCommon):boolean;

procedure FixDialogBorderStyle(Form:TForm);      
procedure FixDialogBorderStyleToTool(Form:TForm);

procedure Browse(URL:String; Viewer:String; maxi:boolean; browse:boolean=false);

var _RuntimeMode:boolean=false;
    DesignStyle:TState=hsNormal;
    glPaintOnlyBg:boolean;
var CancelCheckDesignState:boolean;
    glShowingChanged:boolean=false;
    glSelCompo,glEventObj:TControl;
    glSharing:boolean;
    OuterControl:TControl;
    Cascaded:TCascaded;
//    FontColorIsFromParent:boolean;
    StoredChecking:boolean=false;

(*type ITopGraph=interface ['{B238529C-08BE-4067-8262-93906552568C}']
       function TopGraph:TMyBitmap32;
end;
*)
const

  cl3DFace = clBtnFace;
  cl3DHighlight=clBtnHighlight;
  cl3DShadow=clBtnShadow;
{  cl3DFace = clBtnFace;
  cl3DHighlight=clBtnHighlight;
  cl3DShadow=clBtnShadow;
}  (*
  COLOR_3DFACE = COLOR_BTNFACE;
  {$EXTERNALSYM COLOR_3DSHADOW}
  COLOR_3DSHADOW = COLOR_BTNSHADOW;
  {$EXTERNALSYM COLOR_3DHIGHLIGHT}
  COLOR_3DHIGHLIGHT = COLOR_BTNHIGHLIGHT;
  {$EXTERNALSYM COLOR_3DHILIGHT}
  COLOR_3DHILIGHT = COLOR_BTNHIGHLIGHT;
*)                        //PaleGreen

var
  TrueColors: array[0..17] of TIdentMapEntry = (
    (Value: colInherit; Name: scolInherit),
    (Value: colTransparent; Name: scolTransparent),
    (Value: clBlack; Name: 'Black'),
    (Value: clMaroon; Name: 'Maroon'),
    (Value: clGreen; Name: 'Green'),
    (Value: clOlive; Name: 'Olive'),
    (Value: clNavy; Name: 'Navy'),
    (Value: clPurple; Name: 'Purple'),
    (Value: clTeal; Name: 'Teal'),
    (Value: clGray; Name: 'Gray'),
    (Value: clSilver ; Name: 'Silver'),
    (Value: clRed; Name: 'Red'),
    (Value: clLime; Name: 'Lime'),
    (Value: clYellow; Name: 'Yellow'),
    (Value: clBlue; Name: 'Blue'),
    (Value: clFuchsia; Name: 'Fuchsia'),
    (Value: clAqua; Name: 'Aqua'),
    (Value: clWhite; Name: 'White'));

  Colors: array[0..43] of TIdentMapEntry = (
    (Value: colInherit; Name: scolInherit),
    (Value: colTransparent; Name: scolTransparent),
    (Value: clBlack; Name: 'Black'),
    (Value: clMaroon; Name: 'Maroon'),
    (Value: clGreen; Name: 'Green'),
    (Value: clOlive; Name: 'Olive'),
    (Value: clNavy; Name: 'Navy'),
    (Value: clPurple; Name: 'Purple'),
    (Value: clTeal; Name: 'Teal'),
    (Value: clGray; Name: 'Gray'),
    (Value: clSilver; Name: 'Silver'),
    (Value: clRed; Name: 'Red'),
    (Value: clLime; Name: 'Lime'),
    (Value: clYellow; Name: 'Yellow'),
    (Value: clBlue; Name: 'Blue'),
    (Value: clFuchsia; Name: 'Fuchsia'),
    (Value: clAqua; Name: 'Aqua'),
    (Value: clWhite; Name: 'White'),

    (Value: clActiveBorder; Name: 'ActiveBorder'),
    (Value: clActiveCaption; Name: 'ActiveCaption'),
    (Value: clAppWorkSpace; Name: 'AppWorkSpace'),
    (Value: clBackground; Name: 'Background'),
    (Value: clBtnFace; Name: 'ButtonFace'),
    (Value: clBtnHighlight; Name: 'ButtonHighlight'),
//    (Value: clBtnShadow; Name: 'ButtonShadow'),    {}
    (Value: clBtnText; Name: 'ButtonText'),
    (Value: clCaptionText; Name: 'CaptionText'),
    (Value: clGrayText; Name: 'GrayText'),
    (Value: clHighlight; Name: 'Highlight'),
    (Value: clHighlightText; Name: 'HighlightText'),
    (Value: clInactiveBorder; Name: 'InactiveBorder'),
    (Value: clInactiveCaption; Name: 'InactiveCaption'),
//    (Value: clInactiveCaptionText; Name: 'InactiveCaptionText'),     {}
    (Value: clInfoBk; Name: 'InfoBackground'),
    (Value: clInfoText; Name: 'InfoText'),
    (Value: clMenu; Name: 'Menu'),
    (Value: clMenuText; Name: 'MenuText'),

    (Value: clScrollBar; Name: 'ScrollBar'),
    (Value: cl3DDkShadow; Name: 'ThreeDDarkShadow'),
    (Value: cl3DFace; Name: 'ThreeDFace'),
    (Value: cl3DHighlight; Name: 'ThreeDHighlight'),
    (Value: cl3DLight; Name: 'ThreeDLightShadow'),   {}
    (Value: cl3DShadow; Name: 'ThreeDShadow'),

    (Value: clWindow; Name: 'Window'),
    (Value: clWindowFrame; Name: 'WindowFrame'),
    (Value: clWindowText; Name: 'WindowText')
    {,
    (Value: clNone; Name: 'inherit')});

function FinalID(c:TControl):string;
//function RealAutoSizeXY(Self:TControl):TASXY;
{function AutoSizeX(Self:TControl):boolean;
function AutoSizeY(Self:TControl):boolean;}
function CanAutoSizeX(Self:TControl):boolean;

function GetVerticalAlignPixels(const Value:TCSSVerticalAlign; FontAscend,FontHeight,OwnAscend,OwnHeight,OwnLineHeight:integer):integer;
function GetLetterSpacing(const Value:TCSSLetterSpacing; FontSize:single):Integer;
function GetWordSpacing(const Value:TCSSWordSpacing; FontSize:single):Integer;
function GetLineHeight(const Value:TCSSLineHeight; ContentHeight,FontSize:integer):integer;
function GetTextIndentPixels(Value:TCSSTextIndent; const FontSize:single):integer;
function GetFontSizePixels(const Value:string; const ParentFontSize:single):single;
function GetBackgroundPixels(Value:TCSSBackgroundPosition; const rct:TRect; imgWidth,imgHeight:integer; var res:TPoint):boolean;
procedure SplitBackgroundPixels(Value:TCSSBackgroundPosition; var v1,v2:string);

function GoodAngle(Value:integer):integer;
function GetTopForm(P:TControl):TScrollingWinControl;
function NameWithForm(c:TControl):string;
function GetHyphens(const s:string; from:integer=4):string;
procedure AddRect(var Rect:TRect; a:TRect); //Rect:=Rect+a-b
function GetAddRect(Rect:TRect; a:TRect):TRect;
function ShrinkRect(const a,b:TRect):TRect;
function InflRect(const a,b:TRect):TRect;
function SubEqualEnd(const Substr,s:string):boolean;
function CopyLess(const s:String; less:integer): string;

function EqualPoint(const P1, P2: TPoint): Boolean;

procedure GetRepeatings(var BPos:TPoint; var num_across,num_down:integer; W,H:integer; const brct:TRect; RepeatX,RepeatY:boolean);

function GetNearestFont(const s:string):TFontName;
function GetFontList(const s:String):TStringList;
function GetAs32(Graphic:TGraphic):TMyBitmap32;

function GetGraphicExtension(Graphic:TGraphic):string;
procedure SaveGraphic(g:TGraphic; const FileName: string);


procedure _SkipValue(Reader: TReader);

const AutoInherit=[{pcDisplay,}{pcAntiAliasing,}pcDirection,pcTextAlign,{pcWhiteSpace (div, pre true),}pcTextIndent,pcTextTransform,     pcFontSize,pcFontFamily,pcColor,pcFontStyle,pcFontVariant,pcFontWeight,pcLetterSpacing,pcLineHeight,pcListStyleType,pcTextDecoration,   pcCursor,pcVisibility,pcWordSpacing];



type _TFakeControl=class(TControl)
  public
    //procedure PublicClick;
    property Color;
    property ParentFont;
    //property ParentColor;
    //property DragMode;
    ///property OnClick;
    //property Font;
end;



function HasSemiBmp32(res:TMyBitmap32):boolean;

{$IFNDEF CLX}
function GetJPEGImageFromBitmap32(Src:TMyBitmap32):TJPEGImage; 
{$ENDIF}

function TFakeControl(c:TControl):_TFakeControl; {$IFDEF VER160}unsafe;{$ENDIF}

function SubEqual(const Substr,s:string; i:integer=1):boolean;

function GoodWin(c:TControl):TWinControl;
function GetBaseZOrder(w:TControl; i:integer):integer;
function GetChildPosition(c:TControl):integer;
function iControlAtPos(c:TWinControl; const pt: TPoint):TControl;
function MyFindControl(Handle: HWnd): TControl; overload;
function MyFindControl(c:TControl): TControl; overload;
function MyFindDragTarget(const Pos: TPoint; AllowDisabled: Boolean): TControl;
function FinalVisible(c:TControl):boolean;


var InvRect:TRect;

procedure InvalTrans(C:TControl; R2:TRect; NotChilds:boolean=false);
function GetCBound(c:TControl):TRect;
function GetCBound2(c:TControl):TRect;
function GetScreenClientBound(c:TControl):TRect;
function GetPhysicalScreenClientBound(c:TControl):TRect;
function rGetOffsetRect(R:TRect; P:TPoint):TRect;
procedure rOffsetRect(var Rect: TRect; D:TPoint);
function AdjustedClientRect(c:TWinControl):TRect;
function DoIntersectStrong(R1,R2:TRect):boolean;
//function DoIntersectWeak(R1,R2:TRect):boolean;
function IsNullRect(const R:TRect):boolean;


//    FClickedControl:TControl;
var IsFromParent:boolean;

function GetBoundsFor(c:TControl; DeltaLeft,DeltaTop,DeltaWidth,DeltaHeight:integer):TRect;

var glIsDesignerSelected:function (Control:TControl):boolean;


function GetVirtualParent(C:TControl):TControl;
procedure DecPt(var pt:TPoint; const decr:TPoint);
procedure IncPt(var pt:TPoint; const decr:TPoint);


procedure UpdateZIndex(Self:TWinControl);
function GetGifImageFromBitmap32(Transparent:TBitmap32; Opaque:TBitmap32):TGifImage;
{$IFNDEF CLX}
function GetPNGObjectPTFromGif(gif:TGIFImage):TPNGObject;
function GetPNGObjectPTFromGifAndBitmap32(Transparent:TMyBitmap32; gif:TGIFImage):TPNGObject;
{$ENDIF}
function GetPNGObjectFromBitmap32(Src:TBitmap32{; WithTransparency:boolean}):TGraphic;
function GetBitmap32FromPNGObject(png:TPNGObject):TMyBitmap32;



procedure Register;


const GetItalicFontStyle:array[boolean] of TCSSFontStyle=(cfsNormal,cfsItalic);
const GetBoldFontWeight:array[boolean] of TCSSFontWeight=(cfwNormal,cfwBold);

var ValStyle:TPersistent=nil;

function GetCSSPropName(PropChoose:TPropChoose):string;
function GetCSSPropValue(PropChoose:TPropChoose{; var Value:TCSSProp}):string;
function WithPX(const s:string):string;

function ConsumeMouseWheel(c:TControl; WheelDelta: Integer):boolean;


var TopTextDecoration,ParentTextDecoration:TCSSTextDecorations;
    SelfHit:boolean;

var
    CancelInvDesigner:boolean;

var NotifyDebug:procedure(s:string);
const VertScrollbar=16;
      HorzScrollbar=16;
      VertScrollbarButtonHeight=16;
      HorzScrollbarButtonWidth=16;

var UseCSS3:boolean=false;
function GetBorderRadiusPixels(Value:string; var res:TPoint):boolean;overload;
function GetBorderRadiusString(al:TEdgeAlign):string;
function GetBorderRadiusStringMoz(al:TEdgeAlign):string;


function _GetNotClipped(Self: TControl; OnlyOneParent:boolean=False):TRect;

type TObjIdleProc=class
    procedure DoMouseIdle(Sender: TObject; var Done: Boolean);
  private
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
end;

const sst:array[TState] of string=('_nm','_ov','_dn','_od');

//const sst:array[TState] of string=('_mn','_hr','_dn','_hd');




























const NextStyle:array[boolean] of TState=(hsOver,hsDown);
const NextStyleOld:array[boolean,TState] of TState=((hsNormal,hsNormal,hsNormal,hsOver),(hsNormal,hsNormal,hsNormal,hsDown));
                               
var PreventGraphicOnChange:boolean=false;

procedure DoCalcStrongToWeak(var ALeft,ATop,AWidth,AHeight:integer; const ClientBound:TRect; Anchors:TAnchors; const CSSRight,CSSBottom:integer);
function GetSimplifiedAnchors(Anchors:TAnchors; ParentAnchors:TAnchors; StopSimplifyingRight,StopSimplifyingBottom:boolean):TAnchors;
function _RealAnchors(Anchors:TAnchors; img:boolean):TAnchors;

function hh(i:integer):string;

function HasSubTS(p:TdhCustomPanel):boolean;

function GetPixelCombineNormal(F: TColor32; B: TColor32; M: TColor32=255):TColor32;
Function ApplyDark(Color:TColor; HowMuch:Byte):TColor;

function CSSColorToColor(const Color:TCSSColor):TColor;
function ColorToCSSColor(const Color:TColor):TCSSColor;
function CSSColorToColor32(const Color:TCSSColor):TColor32;
function Color32ToCSSColor(const Color:TColor32):TCSSColor;
function IsOpaqueColor(Color:TCSSColor): boolean;

function WFormat(const c:WideString; const Args: array of const):WideString;

function WideStringReplace(const S, OldPattern, NewPattern: WideString;
  Flags: TReplaceFlags): WideString;

function CutCurrentDir(const path:string):string;
function FinalImageFolder(c:TControl):string;

type WException=class (Exception)
  public
    WMessage:WideString;
    constructor Create(const Value:WideString);
    property Message: WideString read WMessage write WMessage;
end;

type IRelativePathProvider=interface ['{F26D0C91-801B-44A4-86CC-0D265F94F7C6}']
    function GetRelativePath(const Path:String):String;
    function GetAbsolutePath(const Path:String):String;
end;

function findIRelativePathProvider(C:TControl):IRelativePathProvider;

//var _GetDefFontCharSet:TFontCharset=DEFAULT_CHARSET;

implementation


{$IFDEF CLX}
{$IFDEF MSWINDOWS}
uses QJpegLoader;
{$ENDIF}
{$ENDIF}

var PreventAdjustMargin:boolean=false;

{
var CollectChanges:TWhatChanged;
    InCollectChanges:boolean=false;
var InNotifyCSSChanged:boolean;
//    InCSSToWinControl:boolean;

}
const MyDragThreshold=5;
var MyDragStartPos:TPoint;

type TProxyReader=class(TFiler)
  protected
    OriReader:TReader;
    OriReadData: TStreamProc;
    LocationImage:TLocationImage;
    procedure MyReadData(Stream: TStream);
    procedure FlushBuffer; override;
    procedure DefineProperty(const Name: string;
      ReadData: TReaderProc; WriteData: TWriterProc;
      HasData: Boolean); override;
  public
    procedure DefineBinaryProperty(const Name: string;
  ReadData, WriteData: TStreamProc; HasData: Boolean); override;
end;

var ImageBitmap:TBitmap=nil;

function GetImageBitmap:TGraphic;
begin
   if (ImageBitmap=nil) then
   begin
    ImageBitmap := TBitmap.Create;
    ImageBitmap.LoadFromResourceName(HInstance, 'TIMAGEBITMAP');
    ImageBitmap.TransparentColor:=clWhite;
    ImageBitmap.Transparent:=false;
   end;
   result:=ImageBitmap;
end;




constructor WException.Create(const Value: WideString);
begin
 inherited Create(Value+' (ANSI error message)');
 WMessage:=Value;
end;

function WFormat(const c:WideString; const Args: array of const):WideString;
var cc:WideString;
begin
 cc:=WideStringReplace(c,'%','%s',[rfReplaceAll]);
 WideFmtStr(result,cc,Args)
end;

function WideStringReplace(const S, OldPattern, NewPattern: WideString;
  Flags: TReplaceFlags): WideString;
var
  SearchStr, Patt, NewStr: WideString;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := WideUpperCase(S);
    Patt := WideUpperCase(OldPattern);
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := EmptyStr;
  while SearchStr <> EmptyStr do
  begin
    Offset := Pos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function CutCurrentDir(const path:string):string;
begin
  result:=path;
  while Copy(result,1,Length('./'))='./' do
   result:=Copy(result,Length('./')+1,MaxInt);
end;



procedure TProxyReader.DefineBinaryProperty(const Name: string;
  ReadData, WriteData: TStreamProc; HasData: Boolean);
begin
 OriReadData:=ReadData;
 OriReader.DefineBinaryProperty(Name,MyReadData,WriteData,HasData);
end;

procedure TProxyReader.MyReadData(Stream: TStream);
var GraphicsID2:TPictureID;
    DummyResult:boolean;
begin
 if Stream is TMemoryStream then
 begin
   OriReadData(Stream);

   if LocationImage.FPictureID.Graphic=nil then   
   if Assigned(OriReader.OnError) then
    OriReader.OnError(OriReader,LocationImage.Owner.Owner.Name+': Unknown graphics format', DummyResult);
 end else
  Assert(false);
end;

type THackGraphic=class(TGraphic);


procedure TProxyReader.DefineProperty(const Name: string;
      ReadData: TReaderProc; WriteData: TWriterProc;
      HasData: Boolean);
begin
 //supress compiler warning
end;

procedure TProxyReader.FlushBuffer;
begin
 //supress compiler warning
end;

procedure TLocationImage.DefineProperties(Filer: TFiler);
var ProxyReader:TProxyReader;

  function DoWrite: Boolean;
  begin
    result:=not ((Filer.Ancestor is TLocationImage) and (TLocationImage(Filer.Ancestor).FPictureID=FPictureID));
  end;

begin
 if (Filer is TWriter) then
 begin
  if FPictureID<>nil then
  begin
   if DoWrite and not HasPath then
    FPictureID.DefineProperties(Filer);
  end;
 end else
 if (Filer is TReader) then
 begin
  if FPictureID<>nil then //see DoWrite
   Assign(Nil);
{  begin
  FPictureID.savetofile('c:\a.bmp');
    Filer.DefineProperty('Data', Owner.SkipValue, nil, false);
  //assert(FPictureID=nil);
//  FreeAndNil(FPictureID);
  end;}
  //Filer.DefineProperty('Path', ReadCRC, WriteCRC, true);
  if FPictureID=nil then
  begin
   ProxyReader:=TProxyReader.Create(nil,0);
   try
    ProxyReader.OriReader:=TReader(Filer);
    ProxyReader.LocationImage:=Self;
    FPictureID:=TPictureID.Create;
    try
     FPictureID.DefineProperties(ProxyReader);
    except
     FreeAndNil(FPictureID);
    end;
    UpdateCalculations(true);
   finally
    ProxyReader.Free;
   end;
  end;
 end;
end;

function TLocationImage.GetGraphic:TGraphic;
begin
 if FPictureID<>nil then
  result:=FPictureID.Graphic else
  result:=nil;
end;

function TLocationImage.RequestGraphic:TGraphic;
begin
 if GetGraphic<>nil then
 begin
  result:=GetGraphic;
 end else
 if HasPath then
 begin
  FreeAndNil(FPictureID);
  FPictureID:=TPictureID.Create;
  try
    FPictureID.LoadFromFile(GetAbsolutePath);
    FPictureID.OnChange:=Changed;
  except
    FreeAndNil(FPictureID);
  end;
  result:=GetGraphic;
  if result=nil then
  begin
    result:=GetImageBitmap;
  end;
  UpdateCalculations(false);
 end else
 begin
   result:=nil;
 end;
end;

constructor TLocationImage.Create;
begin
 FWidth:=24;
 FHeight:=24;
end;

destructor TLocationImage.Destroy;
begin
 Assign(nil);
 inherited;
end;


procedure TLocationImage.Clear;
begin
 FreeAndNil(FPictureID);
 FPath:='';
 FImageState:=isUninitialized;
end;


procedure TLocationImage.LoadFromFile(const Filename: string);
begin
 Clear;
 FPath:=Filename;
 Changed(Self);
end;


procedure TLocationImage.Assign(Source: TPersistent);
var GraphicsImage : TMemoryStream;
var GraphicsID2:TPictureID;
begin
  if (Source=FPictureID) or (Source<>nil{FPictureID.Source can be nil}) and (Source=GetGraphic) then exit;

  if FPictureID<>nil then
  begin
   Clear;
  end;

  if (Source is TLocationImage) then
  begin
   FWidth:=TLocationImage(Source).FWidth;
   FHeight:=TLocationImage(Source).FHeight;
   if TLocationImage(Source).HasPath then
   begin
    Path:=TLocationImage(Source).GetAbsolutePath;
   end;
   Source:=TLocationImage(Source).FPictureID;
  end;

  if (Source is TPicture) then
  begin
   Source:=TPicture(Source).Graphic;
  end;

  if Source <> nil then
  if Source is TGraphic then
  begin
    FPictureID:=TPictureID.Create;
    FPictureID.Graphic:=TGraphic(Source);
  end else
    inherited Assign(Source);

  UpdateCalculations(true);

  Changed(Self);

end;


procedure TLocationImage.Changed(Sender: TObject);
begin
 if InChange then exit; // prevent LoadFromFile -> PictureChange -> UpdateCalculations -> TGIFImage.SetForceFrame -> PictureChange
 InChange:=true;
 try
  if Assigned(FOnChange) then FOnChange(Self);
 finally
   InChange:=false;
 end;
end;

var
    glBinList:TBinList;




procedure Browse(URL:String; Viewer:String; maxi:boolean; browse:boolean=false);
var i:integer;
    success:boolean;
{$IFDEF MSWINDOWS}
    res:HINST;
{$ENDIF}
begin
//{$IFDEF VER160}get{$ELSE}pchar(get){$ENDIF}
{$IFDEF MSWINDOWS}
 if (URL<>EmptyStr) and (browse or (URL[length(URL)] in ['\','/'])) and not SubEqual('http:',URL) then
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
 success:=res>32; //http://www.tutorials.de/forum/c-c/142600-shellexecute.html
 if not success then
  showmessage('Failed to open browser window.'+#10+#10+'Command was:'+#10+Viewer+' '+URL+#10+#10+'Please choose a different browser application in the Options dialog.'+#10+#10+'Error message was:'+#10+SysErrorMessage(GetLastError));
{$ELSE}
 {if (URL<>EmptyStr) and (URL[length(URL)] in ['\','/']) then
 begin
  Viewer:=EmptyStr;
 end;   }
 if Viewer=EmptyStr then
  Viewer:='kfmclient exec';
 if libc.system(PChar(Viewer+' '+URL))<>0 then
  showmessage('Failed to execute'+#10+Viewer+' '+URL+#10+'Please choose a different browser application in the Options dialog');

{$ENDIF}
end;

function hh(i:integer):string;
begin
 result:=inttohex(i,8);
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



const NoWH=-1;

const DefaultNoncomputedFontSize=EmptyStr;//muß EmptyStr sein für SetFontSize

var NoRotating:boolean=false;

var NoImageNeeded:boolean;


type PPoint=^TPoint;

var FMouseControl:TControl;
{    bgs:TList;

type TBG=class
    style:TStyle;
    BackgroundPosition:TCSSBackgroundPosition;
    BackgroundRepeat:TCSSBackgroundRepeat;
    constructor Create(Style:TStyle);
end;     }

            {
procedure _TFakeControl.PublicClick;
begin
 Click;
end;    }

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

function ColorToColor32(Color:TColor):TColor32;
begin
 result:=ColorSwap(ColorToRGB(Color)) or $FF000000;
end;


function ColorToCSSColor(const Color:TColor):TCSSColor;
begin
 result:=ColorToRGB(Color) or ($FF000000 xor CSSAlphaInverter);
end;

function CSSColorToColor(const Color:TCSSColor):TColor;
begin
 result:=Color and $FFFFFF;
end;

function CSSColorToColor32(const Color:TCSSColor):TColor32;
begin
 result:=(ColorSwap(Color and $FFFFFF) and $FFFFFF) or ((Color xor CSSAlphaInverter) and $FF000000);
end;

function Color32ToCSSColor(const Color:TColor32):TCSSColor;
begin
 result:=(ColorSwap(Color and $FFFFFF) and $FFFFFF) or ((Color xor CSSAlphaInverter) and $FF000000);
end;

function IsOpaqueColor(Color:TCSSColor): boolean;
begin
 Result:=(Color xor CSSAlphaInverter) and $FF000000 = $FF000000;
end;

type PBoolean=^Boolean;

 var glAT:TAffineTransformation;
     glTrans,glATShiftX,glATShiftY:single;
     glRotate:integer;





function HasSomething(bt:TMyBitmap32):boolean;
begin
 result:=not bt.Empty;//{(bt<>nil) and }(bt.Width<>0) and (bt.Height<>0);
end;



{$IFDEF VER160}
function Pos(const substr, str: AnsiString): Integer;
var
  ch: AnsiChar;
  i, j: Integer;
  LSubStrLen, LStrLen: Integer;
begin
  Result := 0;
  LSubStrLen := Length(substr);
  LStrLen := Length(str);

  if (LStrLen = 0) or (LSubStrLen = 0) then
    Exit;

  ch := substr[1];
  for i := 1 to LStrLen - LSubStrLen do
    if str[i] = ch then
      for j := 1{!} to LSubStrLen do
        if str[i + j - 1] <> substr[j] then
          break
        else if j = LSubStrLen then
        begin
          Result := i;
          Exit;
        end;
end;
{$ENDIF}


function NameWithForm(c:TControl):string;
begin
 result:=GetTopForm(c).Name+'.'+c.Name;
end;



{$IFDEF VER130}
type TFakeReader=class(TReader);
{$ELSE}
type TFakeReader=TReader;
{$ENDIF}

function GoodAngle(Value:integer):integer;
begin
  result:=Value mod 360;
  if result<0 then
   result:=result+360;
end;

function MapMod(Value,m:integer):integer;
begin
  result:=Value mod m;
  if result<0 then
   result:=result+m;
end;

procedure _SkipValue(Reader: TReader);
begin
 TFakeReader(Reader).SkipValue;
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

function NotNull(const P1: TPoint): Boolean;
begin
  Result := (P1.X <> 0) or (P1.Y <> 0);
end;
    


function CopyLess(const s:String; less:integer): string;
begin
 result:=copy(s,1,length(s)-less);
end;

function SubEqual(const Substr,s:string; i:integer=1):boolean;
var L:integer;
begin
 L:=length(Substr);
// result:=not (L+i-1>length(s)) and ((L=0) or CompareMem(Pointer(Substr),PChar(Pointer(s))+i-1,L));
 result:=not (L+i-1>length(s)) and ((L=0) or (Substr=Copy(s,i,L)));
end;

function SubEqualEnd(const Substr,s:string):boolean;
var i:integer;
begin
 i:=length(s)+1-length(Substr);
 result:=(i>=1) and SubEqual(Substr,s,i);
end;

procedure Exch(var a,b:string); overload;
var c:string;
begin
 c:=a;
 a:=b;
 b:=c;
end;


function GetPixVal(const Value:string; range:integer):integer;
begin
 if (Value='top') or (Value='left') or (Value='0') then
  result:=0 else
 if (Value='bottom') or (Value='right') then
  result:=range else
 if (Value='center') then
  result:=range div 2 else
 if SubEqualEnd('%',Value) then
  result:=Round(strtoint(CopyLess(Value,1))/100*range) else
 if SubEqualEnd('px',Value) then
  result:=strtoint(CopyLess(Value,2)) else

 raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
end;

function GetPixVal2(const Value:string; range:integer):integer;
begin
 if SubEqualEnd('%',Value) then
  result:=Round(strtoint(CopyLess(Value,1))/100*range) else
  result:=strtoint(Value);
end;

function GetBorderRadiusPixels(Value:string; var res:TPoint; var IsDouble:boolean):boolean; overload;
var r:integer;
    v1,v2:string;
begin
 Value:=Trim(Value);
 r:=Pos(' ',Value);
 if r<>0 then
 begin
  v1:=Trim(Copy(Value,1,r-1));
  v2:=Trim(Copy(Value,r+1,maxint));
  IsDouble:=true;
 end else
 begin
  v1:=Value;
  v2:=v1;
  IsDouble:=false;
 end;
 result:=TryStrToInt(v1,res.X) and TryStrToInt(v2,res.Y);
end;

function GetBorderRadiusPixels(Value:string; var res:TPoint):boolean; overload;
var dummy:boolean;
begin
 result:=GetBorderRadiusPixels(value,res,dummy);
end;

//calculates offset of box's base line to parent box's base line
function GetVerticalAlignPixels(const Value:TCSSVerticalAlign; FontAscend,FontHeight,OwnAscend,OwnHeight,OwnLineHeight:integer):integer;
begin
 if Value='baseline' then
  result:=0 else
 if Value='super' then
  result:=FontHeight div 2-OwnHeight+OwnAscend-FontAscend else
 if Value='sub' then
  result:=FontHeight div 2+OwnAscend-FontAscend else
 if Value='text-top' then
  result:=-FontAscend+OwnAscend else
 if Value='text-bottom' then
  result:=(FontHeight-FontAscend)-(OwnHeight-OwnAscend) else
 if Value='top' then
  result:=atTop else
 if Value='bottom' then
  result:=atBottom else
 if Value='middle' then
  result:=-FontAscend-(OwnHeight-OwnAscend)+(OwnHeight+FontHeight) div 2  else
  //result:=-FontAscend+(OwnHeight+FontHeight) div 2  else

  //result:=OwnAscend+(-OwnHeight-FontAscend) div 2 else
  //result:=OwnAscend+(-OwnHeight-FontHeight) div 2 else
  result:=-GetPixVal2(Value,OwnLineHeight);
end;

function CanGetVerticalAlignPixels(var Value:TCSSVerticalAlign):boolean;
begin
 Value:=LowerCase(Trim(Value));
 try
  GetVerticalAlignPixels(Value,10,10,5,5,5);
  result:=true;
 except
  result:=false;
 end;
end;



function GetLineHeight(const Value:TCSSLineHeight; ContentHeight,FontSize:integer):integer;
begin
  if Value='normal' then
   result:=ContentHeight else
   result:=GetPixVal2(Value,FontSize);
end;

function CanGetLineHeight(var Value:TCSSLineHeight):boolean;
begin
 Value:=LowerCase(Trim(Value));
 try
  GetLineHeight(Value,10,0);
  result:=true;
 except
  result:=false;
 end;
end;

function MyStrToFloat(s:string):Extended;
var r:integer;
    negate:boolean;
begin
 if (s<>'') and (s[1]='-') then
 begin
  s:=Copy(s,2,MaxInt);
  negate:=true;
 end else
 begin
  negate:=false;
 end;
 r:=pos('.',s);
 if r=0 then
  result:=strtoint(s) else
  result:=strtoint(copy(s,1,r-1))+strtoint(copy(s,r+1,maxint))/IntPower(10,length(s)-r);
 if negate then
  result:=-result; 
end;


function GetLengthPixels(const Value:string; const FontSize:single):single;
begin
 if not SubEqualEnd('em',Value) then
  result:=strtoint(Value) else
  result:=MyStrToFloat(CopyLess(Value,2))*FontSize;
end;

function GetLetterSpacing(const Value:TCSSLetterSpacing; FontSize:single):Integer;
begin
  if Value='normal' then
   result:=0 else
   result:=Round(GetLengthPixels(Value,FontSize));
end;

function CanGetLetterSpacing(var Value:TCSSLetterSpacing):boolean;
begin
 Value:=LowerCase(Trim(Value));
 try
  GetLetterSpacing(Value,0);
  result:=true;
 except
  result:=false;
 end;
end;

function GetWordSpacing(const Value:TCSSWordSpacing; FontSize:single):Integer;
begin
  if Value='normal' then
   result:=0 else
   result:=Round(GetLengthPixels(Value,FontSize));
end;
      
function CanGetWordSpacing(var Value:TCSSWordSpacing):boolean;
begin
 Value:=LowerCase(Trim(Value));
 try
  GetWordSpacing(Value,0);
  result:=true;
 except
  result:=false;
 end;
end;

function GetTextIndentPixels(Value:TCSSTextIndent; const FontSize:single):integer;
begin
 result:=Round(GetLengthPixels(Value,FontSize));
end;

function GetMarginPixels(Value:string; const FontSize:single):integer;
begin
 result:=Round(GetLengthPixels(Value,FontSize));
end;

function GetFontSizePixels(const Value:string; const ParentFontSize:single):single;
begin
 if Value=DefaultNoncomputedFontSize then
  result:=ParentFontSize else
 if Value='xx-small' then
  result:=7 else
 if Value='x-small' then
  result:=9 else
 if Value='small' then
  result:=12 else
 if Value='medium' then
  result:=13 else
 if Value='large' then
  result:=16 else
 if Value='x-large' then
  result:=21 else
 if Value='xx-large' then
  result:=27 else
 if Value='smaller' then
  result:=GetLengthPixels('0.66em',ParentFontSize) else
 if Value='larger' then
  result:=GetLengthPixels({'1.54em'}'1.37em',ParentFontSize) else
  result:=GetLengthPixels(Value,ParentFontSize);
end;
                   
function TdhCustomPanel.GetStyleByName(const name:string; var r:TStyle):boolean;
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

function TStyle.GetNameByStyle:string;
begin
 result:=sStyle[OwnState];
end;

function TStyle.GetBorderByName(const name:string; var r:TCSSBorder):boolean;
begin
   if Name='Border' then
    r:=Border else
   if Name='BorderRight' then
    r:=BorderRight else
   if Name='BorderTop' then
    r:=BorderTop else
   if Name='BorderBottom' then
    r:=BorderBottom else
   if Name='BorderLeft' then
    r:=BorderLeft else
    r:=nil;
   result:=r<>nil;
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
 result:=TotalRect; //vorallem nötig für CLX
 //result:=inherited GetClientRect;
 //result:=ClientBound;
end;

const IgnoreBottomScrollbar=not true;

procedure TdhCustomPanel.AdjustScrolling(var R: TRect);
begin


 if IgnoreBottomScrollbar and not (FAutoSize in [asY,asXY]) then
  with ScrollEdgesPure do R:=ShrinkRect(R,Rect(Left,Top,Right,0)) else  //da unterer Scrollbalken zur client-area gehört, nur rechten ausschließen
  R:=ShrinkRect(R,ScrollEdgesPure);

 {with ScrollEdgesPure do
 begin
  inc(R.Left,Left);
  dec(R.Right,Right);
 end;}

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
  Color:={TFakeControl(Control.Parent).Color}CSSColorToColor(GetVirtualBGColor) else
  Color:=CSSColorToColor(BackgroundColor);
end;




function AdjustedClientRect(c:TWinControl):TRect;
begin
 result:=c.ClientRect;
 TFakeWinControl(c).AdjustClientRect(result);
end;

type PCursor=^TCursor;


procedure TdhCustomPanel.CSSToCursor;
begin
 Cursor:=CSSCursorMap[GetCursor];
end;

function TdhCustomPanel.FetchSharing(Sharing:TControl):TWhatChanged;
begin
 result:=[];
end;

function TdhCustomPanel.DoGetVal(PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign; var DoExit:boolean):boolean;
begin
 DoExit:=false;
 result:=false;
end;


function GetBaseZOrder(w:TControl; i:integer):integer;
begin
 if (w.Align<>alTop) and (w.Parent<>nil) then
  result:=i+1*w.Parent.ControlCount else
  result:=i;
end;




var BehindAllOthers:TControl;

function GetZOrder(w:TControl; i:integer):integer;
begin
  if w=BehindAllOthers then
   result:=-maxint else
  if (w is TdhCustomPanel){ and not (csDestroying in w.ComponentState)} then
   result:=TdhCustomPanel(w).AdjustZIndex(i,w.Parent.ControlCount) else
   result:=GetBaseZOrder(w,i);
end;

function TdhCustomPanel.AdjustZIndex(ChildPos,ParentControlCount:integer):integer;
begin
 result:=GetBaseZOrder(Self,ChildPos)+ZIndex*ParentControlCount*8;
end;

function GetChildPosition(c:TControl):integer;
begin
 with c.Parent do
 for result:=0 to ControlCount-1 do
 if Controls[result]=c then
  exit;
 result:=-1;
end;

function GetZOrder2(w:TControl):integer;
begin
 result:=GetZOrder(w,GetChildPosition(w));
end;

procedure TdhCustomPanel.InvalDeepestBack;
begin
 BehindAllOthers:=Self;
 try
  InvalBack(InvRect);
 finally
  BehindAllOthers:=nil;
 end;
end;


procedure UpdateZIndex(Self:TWinControl);
var i,p,sp,bestp,besti,szi:integer;
    Pos: HWND;
begin
 with Self do
 begin
 if not HandleAllocated then exit;

 if Parent=nil then exit;
 if Self is TdhCustomPanel then
 with TdhCustomPanel(Self) do
 begin                     {
 szi:=ActStyle.ZIndex;
 ActStyle.FZIndex:=-1000;
 InvalBack(InvRect);
 ActStyle.FZIndex:=szi;   }
 InvalDeepestBack;
 {BehindAllOthers:=Self;
 try
  InvalBack(InvRect);
 finally         
  BehindAllOthers:=nil;
 end;   }
 end;
 sp:=GetZOrder2(Self);
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

 if (Owner<>nil) and (Owner.ClassName='TPageContainer') and (ClassName<>'TMySiz') then
 if (Owner<>nil) and (Owner.ClassName='TPageContainer') and (ClassName<>'TMySiz') then{ exit};

 inherited;
// if not InCSSToWinControl then //can happen in TdhMenu.UpdateMenu due to a shared value
//  CSSToWinControl(ActStyleChanged);
 //AddHA.Add(Name);
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
var i:integer;
var _State:TState;

//    pn:TdhCustomPanel;
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
 if csDestroying in ComponentState then exit;//new added 28.01.2004
 InCSSToWinControl:=true;
 try

 (*
 if (wcTemplate in WhatChanged) and (FUse<>nil) and{ and FUse.}ExtendedUse{ and (glSharing<>Control)} then
 if (FUse<>nil) then
 begin
  assert(not Fetching);
  Fetching:=true;
  WhatChanged:=WhatChanged+Con.FetchSharing(FUse.GetCommon.Control);
  Fetching:=false;
 end else
 begin
  {for i:=0 to FUse.GetCommon.UsedByList.Count-1 do
  begin
  pn:=TCommon(FUse.GetCommon.UsedByList[i]);
  if (pn<>Self) and Control.InheritsFrom(pn.Control.ClassType) then
   glSharing:=pn.Control;
  end;
  if glSharing<>nil then
   Con.FetchSharing(glSharing);
  glSharing:=nil; }
 end;*)

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
  InvalBack(InvRect) else
// if VisualChanges*WhatChanged<>[] then
  InvalTop({not(wcNoOwnCSS in WhatChanged)}true,false);

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

 //Font.Assign(TdhCustomPanel(Control.Parent).Font);

 //diese beiden sind in TForm und im Browser voreingestellt:
 Font.Name:=NearestFontFamily;
 Font.Height:=-ComputedFontSize;
 //Font.Charset:=_GetDefFontCharSet;
 //Font.Charset:=THAI_CHARSET;//ANSI_CHARSET;//TURKISH_CHARSET;//ANSI_CHARSET;//GetCharset;


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
  if InNotifyCSSChanged then
   showmessage('CMFontChanged'+Name);
  //InNotifyCSSChanged:=true; //bei SetTextDecoration, ActStyle.TextDecoration:=ActStyle.TextDecoration;
  //try
   with Font do
    ActStyle.GetFontDifferences(Style,ColorToCSSColor(Color),Name,Height);
  //finally
   //InNotifyCSSChanged:=false;
  //end;
  NotifyCSSChanged([wcFont]);
 end;
end;



procedure TdhCustomPanel.ColorHasChanged;
begin
 if not InCSSToWinControl then
 begin
  //if not (Transparent and (TFakeWinControl(Parent).Color=Color)) then
  if BackgroundColor<>ColorToCSSColor(Color) then
   ActStyle.BackgroundColor:=ColorToCSSColor(Color);
  NotifyCSSChanged([wcColor]);
 end;
end;


procedure TdhCustomPanel.CursorHasChanged;
begin
 if not InCSSToWinControl then
 begin
  //if not (Transparent and (TFakeWinControl(Parent).Color=Color)) then
  if GetCursor<>GetCursorBack(Cursor) then
   ActStyle.FCursor:=GetCursorBack(Cursor);
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
  NotifyCSSChanged([wcColor,wcParent,wcNoOwnCSS]){ else
  Control.Invalidate}; //falls transparent, parentcolor durchscheinen lassen! jetzt nicht mehr
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


function FindForm(Value:string; var f:TForm):boolean;
var i:integer;
begin
    for i:=0 to Screen.FormCount-1 do
    if SameText(Screen.Forms[i].Name,Value) then
    begin
     f:=Screen.Forms[i];
     result:=true;
     exit;
    end;
    result:=false;
end;



procedure TStyle.SkipValue(Reader: TReader);
begin
 _SkipValue(Reader);
end;
               

procedure TdhCustomPanel.SkipValue(Reader: TReader);
begin
 _SkipValue(Reader);
end;

                        {
procedure TStyle.ReadInteger(Reader: TReader);
begin
 Reader.ReadInteger;
end;

procedure TStyle.ReadString(Reader: TReader);
begin
 Reader.ReadString;
end;

procedure TdhCustomPanel.ReadString(Reader: TReader);
begin
 Reader.ReadString;
end;

procedure TStyle.ReadInteger2(Reader: TReader);
begin               
  Reader.ReadListBegin;
 Reader.ReadInteger;
 Reader.ReadInteger;
  Reader.ReadListEnd;
end;
                     }

procedure TStyle.WriteContentWidth(Writer: TWriter);
begin
 Writer.WriteInteger(_ContentWidthHeight.X);
end;


function TStyle.IsFontSizeStored:boolean;
begin
 result:=FontSize<>EmptyStr;
end;

procedure TStyle.WriteMargin(Writer: TWriter);
begin
 Writer.WriteString(Margin);
end;

procedure TStyle.ReadMargin(Reader: TReader);
begin
 Margin:=Reader.ReadVariant;
end;

function TStyle.IsMarginLeftStored:boolean;
begin
 result:=MarginLeft<>EmptyStr;
end;

function TStyle.IsMarginRightStored:boolean;
begin
 result:=MarginRight<>EmptyStr;
end;

function TStyle.IsMarginTopStored:boolean;
begin
 result:=MarginTop<>EmptyStr;
end;

function TStyle.IsMarginBottomStored:boolean;
begin
 result:=MarginBottom<>EmptyStr;
end;

procedure TStyle.WriteContentHeight(Writer: TWriter);
begin
 Writer.WriteInteger(_ContentWidthHeight.Y);
end;



function GetShorter(const Top,Right,Bottom,Left:string):string;
begin
 if (Top=Right) and (Right=Bottom) and (Bottom=Left) then
  result:=Top else
  result:=Top+' '+Right+' '+Bottom+' '+Left;                  
end;



procedure TStyle{TCommon}.WriteNewPadding(Writer: TWriter);
begin
 with {Owner.AllEdgesPure}_BasePadding do
  Writer.WriteString(GetShorter(inttostr(Top)+'px',inttostr(Right)+'px',inttostr(Bottom)+'px',inttostr(Left)+'px'));
end;

procedure TStyle{TCommon}.WriteNewMargin(Writer: TWriter);
begin
 with {Owner.AllEdgesPure}_BaseMargin do
  Writer.WriteString(GetShorter(inttostr(Top)+'px',inttostr(Right)+'px',inttostr(Bottom)+'px',inttostr(Left)+'px'));
end;

procedure TStyle{TCommon}.Write0px(Writer: TWriter);
begin
 Writer.WriteString('0px');
end;

procedure TdhCustomPanel.WriteClientLeft(Writer: TWriter);
begin
 Writer.WriteInteger(GetClientAdjusting.Left);
end;

procedure TdhCustomPanel.WriteMarginVert(Writer: TWriter);
begin
 with MarginPure do
  Writer.WriteInteger(Top+Bottom);
end;

procedure TdhCustomPanel.WriteMarginHorz(Writer: TWriter);
begin
 with MarginPure do
  Writer.WriteInteger(Left+Right);
end;

procedure TdhCustomPanel.WriteClientTop(Writer: TWriter);
begin
 Writer.WriteInteger(GetClientAdjusting.Top);
end;

procedure TdhCustomPanel.WriteClientBottom(Writer: TWriter);
begin
 Writer.WriteInteger(GetClientAdjusting.Bottom);
end;

procedure TdhCustomPanel.WriteClientRight(Writer: TWriter);
begin
 Writer.WriteInteger(GetClientAdjusting.Right);
end;

procedure TStyle.ReadBool(Reader: TReader);
begin
 Reader.ReadBoolean;
end;


procedure TStyle.WriteTrue(Writer: TWriter);
begin
 Writer.WriteBoolean(true);
end;
                       {
procedure TdhCustomPanel.ReadBool(Reader: TReader);
begin
 Reader.ReadBoolean;
end;
                       }

procedure TdhCustomPanel.WriteTrue(Writer: TWriter);
begin
 Writer.WriteBoolean(true);
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



                          {

procedure TdhCustomPanel.ReadString(Reader: TReader);
begin
 Reader.ReadString;
end;
                           }
function FinalID(c:TControl):string;
var O:TComponent;
begin
 result:=c.Name;
 O:=c.Owner;
 while (O<>nil) and (O.Owner<>nil) and not (O is TForm) do
 begin
  result:=O.Name+result;
  O:=O.Owner;
 end;
end;

function FinalImageID(c:TControl):string;
begin
 result:=FinalImageFolder(c)+FinalID(c);
end;


function FinalImageFolder(c:TControl):string;
begin
 result:='';
 while (c<>nil) do
 begin
  if c is TdhCustomPanel then
  begin
    result:=CutCurrentDir(TdhCustomPanel(c).GetImageDir)+result;
  end;
  c:=c.Parent;
 end;
end;


(*procedure TdhCustomPanel.WriteFirstRealUse(Writer: TWriter);
begin
 Writer.WriteString(EmptyStr{FinalID(FirstRealUse)});
end;
  *)
procedure TdhCustomPanel.WriteFalse(Writer: TWriter);
begin
 Writer.WriteBoolean(false);
end;
                           {
procedure TdhCustomPanel.ReadBool(Reader: TReader);
begin
 Reader.ReadBoolean;
end;
                           }

{function TdhCustomPanel.VirOffset:TPoint;
begin
 d
end;
 }


type TAligns=set of TAlign;

function AllAligns(Self:TWinControl):TAligns;
var i:integer;
begin
 result:=[];
 for i:=0 to Self.ControlCount-1 do
  include(Result,Self.Controls[i].Align);
end;

function AllAlignedTop(Self:TWinControl):boolean;
var i:integer;
begin
 for i:=0 to Self.ControlCount-1 do
 if (Self.Controls[i].Align<>alTop) and (Self.Controls[i].Owner<>Self) and (Self.Controls[i].Owner=Self.Owner) then
 begin
  result:=false;
  exit;
 end;
 result:=Self.ControlCount<>0; //wenn keine Kindelemente, dann nicht autosize!
end;

function AutoSizeX(Self:TControl):boolean;
begin
 result:={Self.AutoSize and not}((self is TdhCustomPanel) and {not} (TdhCustomPanel(self).FAutoSize in [asX,asXY]));
 if result and (csAcceptsControls in Self.ControlStyle) and (Self is TWinControl) then
  result:=AllAlignedTop(TWinControl(Self)){AllAligns(TWinControl(Self))*[alNone,alBottom,alLeft,alRight,alClient]=[]};
end;

function AutoSizeY(Self:TControl):boolean;
begin
 result:={Self.AutoSize and not}((self is TdhCustomPanel) and {not} (TdhCustomPanel(self).FAutoSize in [asY,asXY])) and not (Self.Align in [alLeft,alRight]);
 if result and (csAcceptsControls in Self.ControlStyle) and (Self is TWinControl) then
  result:=AllAlignedTop(TWinControl(Self)){AllAligns(TWinControl(Self))*[alLeft,alRight]=[]};
 if result and (Self is TdhCustomPanel) then
  result:=TdhCustomPanel(Self).AllowAutoSizeY;
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


function CanAutoSizeX(Self:TControl):boolean;
begin
 if Self.Align=alBottom then
 begin
  result:=false;
  exit;
 end;
 if (Self.Align=alTop) and (Self.Parent is TdhCustomPanel) and TdhCustomPanel(Self.Parent).IsScrollArea then
 begin
  result:=false;//because a width must be provided when applying the IE selection bugfix
  exit;
 end;
 if (Self is TdhCustomPanel) and TdhCustomPanel(Self).HorizontalCenter then
 begin
  result:=false;
  exit;
 end;
 if AutoSizeX(Self) then
 begin
  result:=true;
  exit;
 end;
 if Self.Align<>alTop then
 begin
  result:=false;
  exit;
 end;
 if AutoSizeY(Self) then
 begin
  result:=true;
  exit;
 end;
 Self:=Self.Parent;  
 if Self is TTabSheet then
  Self:=Self.Parent;
 while (Self<>nil) do
 begin
  if Self.Parent=nil then
  begin
   result:=true;
   exit;
  end;
  if not AutoSizeX(Self) then
  begin
   result:=true;
   exit;
  end;
  if (Self.Align<>alTop) then
  begin
   result:=false;
   exit;
  end;
  Self:=Self.Parent;
  if Self is TTabSheet then
   Self:=Self.Parent;
 end; 
 result:=true;
end;


function RealAutoSizeXY(Self:TControl):TASXY;
begin
 result:=asar[CanAutoSizeX(Self),AutoSizeY(Self)];
end;

procedure TdhCustomPanel.WriteRealAutoSizeXY(Writer: TWriter);
begin
 Writer.WriteIdent(GetEnumName(TypeInfo(TASXY),Integer(RealAutoSizeXY(Self))));
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

procedure TdhCustomPanel.WriteCenterLeft(Writer: TWriter);
begin
 Writer.WriteInteger(CenterMargins.X);
end;

procedure TdhCustomPanel.WriteCenterRight(Writer: TWriter);
begin
 Writer.WriteInteger(CenterMargins.Y);
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


procedure TdhCustomPanel.DoDefineProperties(Filer:TFiler);
var NeedClientArea,NeedMargin:boolean;
    HasRastering:TRasterType;
begin
 if not WithMeta and (Filer is TWriter) then exit;
{$IFDEF CLX}
 Filer.DefineProperty('DesignSize', SkipValue, nil, False);
{$ENDIF}

 Filer.DefineProperty('TabOrder', SkipValue, nil, false);

 if (csLoading in ComponentState) then exit;

 HasRastering:=IsRastered(false);

 {OnlyBg:=false;//to compile without warnings
 if HasRastering<>rsNo then
  OnlyBg:=(HasRastering<>rsFull) or Self.PreventFull;
 }
 Filer.DefineProperty('TheoreticRastering', nil, WriteTrue, (HasRastering<>rsNo) and (HasRastering=rsFull));
 Filer.DefineProperty('TheoreticRasteringBG', nil, WriteTrue, (HasRastering<>rsNo) and (HasRastering<>rsFull));


 Filer.DefineProperty('img', nil, WriteTrue, GetImageType=bitImage);

 if InStylesheet(Self) then exit;


 if HorizontalCenter then
 with CenterMargins do
 begin
  Filer.DefineProperty('CenterLeft', nil, WriteCenterLeft, X<>0);
  Filer.DefineProperty('CenterRight', nil, WriteCenterRight, Y<>0);
 end;
 Filer.DefineProperty('RealAutoSizeXY', nil, WriteRealAutoSizeXY, RealAutoSizeXY(Self)<>self.FAutoSize);

 Filer.DefineProperty('NeedBlock', nil, WriteTrue, GetVal(pcDisplay) and (Cascaded.Display=cdsInline));



 NeedClientArea:=ChildHasAnchor([akLeft, akTop, akRight, akBottom]) and (HasRastering=rsNo);
 if NeedClientArea then
 with GetClientAdjusting do
 begin
  Filer.DefineProperty('ClientLeft', nil, WriteClientLeft, Left<>0);
  Filer.DefineProperty('ClientTop', nil, WriteClientTop, Top<>0);
  Filer.DefineProperty('ClientBottom', nil, WriteClientBottom, Bottom<>0);
  Filer.DefineProperty('ClientRight', nil, WriteClientRight, Right<>0);
 end;

 NeedMargin:= not (csLoading in ComponentState) and (HasRastering=rsNo) and not (IsScrollArea and EdgesInScrolledArea);
 if NeedMargin then
 with self.MarginPure do
 begin
  Filer.DefineProperty('MarginHorz', nil, WriteMarginHorz, (Left+Right<>0) and (Anchors*[akLeft,akRight]=[akRight]));
  Filer.DefineProperty('MarginVert', nil, WriteMarginVert, (Top+Bottom<>0) and (Anchors*[akTop,akBottom]=[akBottom]));
 end;

 Filer.DefineProperty('VariableSize',SkipValue,WriteTrue, VariableSize );

 //Filer.DefineProperty('VariableHeight',SkipValue,WriteTrue, pn.VariableHeight );

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


{function TCommon.NeedNewPadding:boolean;
begin
 result:=not (csLoading in Control.ComponentState) and (Control as TdhCustomPanel).NeedNewPadding;
end;
 }

function TdhCustomPanel.NeedPadding(HasRastering:TRasterType):boolean;
begin
 result:=(HasRastering<>rsNo) and ChildHasAnchor([akTop]);
end;





function GetBoundsFor(c:TControl; DeltaLeft,DeltaTop,DeltaWidth,DeltaHeight:integer):TRect;
begin
    if (akRight in c.Anchors) and not (akLeft in c.Anchors) then
    begin
     {Dec(DeltaWidth,DeltaLeft);}
     Dec(DeltaLeft,DeltaWidth{+DeltaLeft});
    end;
    if (akBottom in c.Anchors) and not (akTop in c.Anchors) then
    begin
     {Dec(DeltaHeight,DeltaTop);}
     Dec(DeltaTop,DeltaHeight{+DeltaTop});
    end;
    result:=Bounds(c.Left+DeltaLeft,c.Top+DeltaTop,c.Width+DeltaWidth,c.Height+DeltaHeight);
end;

              {
function TdhCustomPanel.GetBoundsFor(aWidth,aHeight:integer):TRect;
begin
    result.Top:=Top;
    result.Left:=Left;
    if (akRight in Anchors) and not (akLeft in Anchors) then
     dec(result.Left,aWidth-Width);
    if (akBottom in Anchors) and not (akTop in Anchors) then
     dec(result.Top,aHeight-Height);
    result:=Bounds(result.Left,result.Top,aWidth,aHeight);
end;
                }



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

function IsSemi(png:TPNGObject):boolean;
var X,Y:integer;
    bp:pByteArray;
begin
   if png.TransparencyMode=ptmPartial then
   for Y:=0 to png.Height-1 do
   begin
    bp:=png.AlphaScanline[Y];
    for X:=0 to png.Width-1 do
    if bp^[X]<>255 then
    begin
     result:=true;
     exit;
    end;
   end;
   result:=false;
end;

function TLocationImage.CalculateImgCanT1X1:boolean;
begin
 result:=(GetGraphic is TPNGObject) and (TPNGObject(GetGraphic).Width=1) and (TPNGObject(GetGraphic).Height=1) and IsSemi(TPNGObject(GetGraphic));
end;

function TLocationImage.ImgIsT1X1:boolean;
var i:timage;
begin
 RequestCalculations;
 result:=(FImageState=isOnePixel) and (Owner.Owner.GetImageFormat=ifSemiTransparent);
end;

function HasSemi(Graphic:TGraphic):boolean;
var res:TMyBitmap32;
begin
  res:=GetAs32(Graphic);
  try
   result:=HasSemiBmp32(res);
  finally
   res.Free;
  end;
end;

function HasSemiBmp32(res:TMyBitmap32):boolean;
var P: PColor32;
    i:integer;
begin
  P:=res.PixelPtr[0,0];
  for i:=0 to res.Width*res.Height-1 do
  begin
   case (p^ shr 24) of
    1..254:
    begin
     result:=true;
     exit;
    end;
   end;
   inc(P);
  end;
  result:=false;
end;


function TLocationImage.ImgNeedBeRastered:boolean;
begin
 RequestCalculations;
 result:=(FImageState in [isOnePixel,isSemiTransparent]) and not ImgIsT1X1;
end;

function TLocationImage.IsAnimatedGIF:boolean;
begin                  
 RequestCalculations;
 result:=FImageState=dhPanel.isAnimatedGIF;
end;                                     

function TLocationImage.CalculateImgCouldBeRastered:boolean;
begin
 result:=(GetGraphic is TPNGObject) and IsSemi(TPNGObject(GetGraphic));
end;


function TLocationImage.CalculateAnimatedGIF:boolean;
begin
 result:=(GetGraphic is TGIFImage) and (TGIFImage(GetGraphic).Images.Count>=2);
end;


function TStyle.UndefFilter(IsRastered:boolean):boolean;
var _FPictureID:TPictureID;
    _FPath:String;
    FPicture:TLocationImage;
begin
  if BackgroundImage.HasPicture or IsRastered then
  begin
   _FPictureID:=BackgroundImage.FPictureID;
   _FPath:=BackgroundImage.FPath;
   try
    BackgroundImage.FPictureID:=nil;
    BackgroundImage.FPath:='';
    result:=Owner.HasBackgroundImage(FPicture) and FPicture.ImgIsT1X1;
   finally
    BackgroundImage.FPictureID:=_FPictureID;
    BackgroundImage.FPath:=_FPath;
   end;
  end else
   result:=false;
end;

function HasSubTS(p:TdhCustomPanel):boolean;
var i:integer;
begin
 if not p.IsScrollArea then
 for i:=0 to p.ControlCount-1 do
 if (p.Controls[i] is TdhCustomPanel) and (TdhCustomPanel(p.Controls[i]).CanBeTopPC or HasSubTS(TdhCustomPanel(p.Controls[i]))) then
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

(* InvalidateFontSize;
 //TopIsValid:=false;
 InvalTop({not(wcNoOwnCSS in WhatChanged)}true,false);
// BackIsValid:=false;
 *)
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

procedure TStyle.DefineProperties(Filer: TFiler);
var HasRastering:TRasterType;


var
     R,R2:TRect;
var
    ReallyRastering,ReallyBGImage:boolean;
    _NeedNewPadding,_NeedNewMargin:boolean;


procedure ShrinkWH(PutAllToPadding:boolean);
var IE6:TRect;
begin
  PreventAdjustMargin:=true;
  try
   if Owner.IncludeBorderAndPadding then
   begin
    if PutAllToPadding then
    begin
     IE6:=Rect(0,0,0,0);
    end else
    begin
     IE6:=Owner.MarginPure;
    end;
   end else
   begin
    if PutAllToPadding then
    begin
     IE6:=Owner.AllEdgesPure;
    end else
    begin
     IE6:=Owner.AllEdgesPure;
    end;
   end;
  finally
   PreventAdjustMargin:=false;
  end;

   with IE6 do
   begin
   if _ContentWidthHeight.X<>NoWH then
    Dec( _ContentWidthHeight.X,Left+Right);
   if _ContentWidthHeight.Y<>NoWH then
    Dec( _ContentWidthHeight.Y,Top+Bottom);
   end;
end;

var ALeft,ATop:integer;

var prev,next:TdhCustomPanel;

procedure GetTopIndexes(pn:TdhCustomPanel; var prev,next:TdhCustomPanel);
var i:integer;
    p:TWinControl;
    c:TControl;
    best_prev,best_next:integer;
    pnTop:integer;
begin
 pnTop:=pn.BoundTop;
 best_prev:=-maxint;
 best_next:=maxint;
 prev:=nil;
 next:=nil;
 p:=pn.Parent;
 for i:=0 to p.ControlCount-1 do
 begin
  c:=p.Controls[i];
  if (c.Align=alTop) and (c is TdhCustomPanel) then
  if (c.Top<pnTop) and (c.Top>best_prev) then
  begin
   best_prev:=c.Top;
   prev:=TdhCustomPanel(c);
  end else
  if (c.Top>pnTop) and (c.Top<best_next) then
  begin
   best_next:=c.Top;
   next:=TdhCustomPanel(c);
  end;
 end;
 if prev is TdhCustomPanel then
 begin
  if (TdhCustomPanel(prev).BoundNextSibling<>pn) and (TdhCustomPanel(prev).BoundNextSibling<>nil) then
   prev:=TdhCustomPanel(prev).BoundNextSibling;
 end;
 if pn.BoundNextSibling<>nil then
  next:=pn.BoundNextSibling;

end;


begin
 inherited;


 if (csLoading in Owner.ComponentState) or not WithMeta and (Filer is TWriter) then exit;




  HasRastering:=Owner.IsRastered(false);
  glPaintOnlyBg:=not (HasRastering in [rsNo{needed for TdhLabel.FocusPreferStyle},rsFull]);

  Owner.SetPreferStyle(Self,false,true);
  try
  Filer.DefineProperty('T1X1', nil, WriteTrue, (HasRastering=rsNo) and BackgroundImage.ImgIsT1X1);
  if (HasRastering<>rsNo) and InStylesheet(Owner) then
   HasRastering:=rsNo;
  _NeedNewPadding:=Owner.NeedPadding(HasRastering);
  _NeedNewMargin:=(HasRastering<>rsNo) and (Owner.Align=alTop);
  Filer.DefineProperty('UndefFilter', nil, WriteTrue, UndefFilter(HasRastering<>rsNo));




//  HasBGRastering:=not HasRastering and Owner.IsBGRastered;



  Filer.DefineProperty('BorderColors', SkipValue, WriteBorderColors, IsBorderColorsStored);


  if HasRastering<>rsNo then
  with Owner do
  begin               
   InitSelfCBound(_ContentWidthHeight);
   if _NeedNewPadding then
   begin
    ShrinkWH(true);
   end;
  end else
  if {HasBGRastering and Owner.HasImage(FPicture)}Owner.HasImage then
  with Owner do
  begin
   _ContentWidthHeight:=GetWantedSize;
    ShrinkWH(false);
  end else
  begin
   if {(Self=Owner.FStyle) or }RealAutoSizeXY(Owner)=asXY then
   begin
     _ContentWidthHeight:=Point(NoWH,NoWH);
   end else
   begin
    //pn.CalcStrongToWeak(ALeft,ATop,_ContentWidthHeight.X,_ContentWidthHeight.Y);
     _ContentWidthHeight:=Point(Owner.Width,Owner.Height);
   end;
   ShrinkWH(false);
  end;

  ReallyRastering:=false;
  if HasRastering<>rsNo then
  if HasSubTS(Owner) then
  begin
   RasteringFile:='x';
   ReallyRastering:=true;
  end else
   ReallyRastering:=Assigned(glSaveBin) and PrepareRastering(0,EmptyStr);
  Filer.DefineProperty('Rastering', SkipValue, WriteRastering, ReallyRastering and not glPaintOnlyBg);
  Filer.DefineProperty('BGRastering', SkipValue, WriteRastering, ReallyRastering and glPaintOnlyBg);

  ReallyBGImage:=not ReallyRastering and Assigned(glSaveBin) and PrepareBGImage;
  Filer.DefineProperty('BackgroundImageUrl', SkipValue, WriteBackgroundImageUrl, ReallyBGImage);


  if Owner.IsScrollArea and Owner.EdgesInScrolledArea then
  begin
   _ContentWidthHeight:=Point(NoWH,NoWH);
  end;


  IsWidthStored:=(_ContentWidthHeight.X<>NoWH) and (_ContentWidthHeight.X<>BaseWH.X);
  IsHeightStored:=(_ContentWidthHeight.Y<>NoWH) and (_ContentWidthHeight.Y<>BaseWH.Y);

  Filer.DefineProperty('Width', SkipValue, WriteContentWidth, IsWidthStored);
  Filer.DefineProperty('Height', SkipValue, WriteContentHeight, IsHeightStored);

  if (Owner.Anchors*[akBottom,akRight]<>[]) then
  begin
   _GetWantedSize:=Owner.GetWantedSize;
   Filer.DefineProperty('NeedRight',SkipValue,WriteTrue, _GetWantedSize.X<>Owner.StyleArr[hsNormal]._GetWantedSize.X);
   Filer.DefineProperty('NeedBottom',SkipValue,WriteTrue, _GetWantedSize.Y<>Owner.StyleArr[hsNormal]._GetWantedSize.Y);
  end;


  IsNewPaddingStored:=false;
  if _NeedNewPadding then
  begin
   PreventAdjustMargin:=true;
   try
    _BasePadding:=Owner.AllEdgesPure;
   finally
    PreventAdjustMargin:=false;
   end;
   IsNewPaddingStored:=true;
  end else
  if (HasRastering<>rsNo) and (OwnState=hsNormal) then
  begin
   _BasePadding:=Rect(0,0,0,0);
   IsNewPaddingStored:=true;
  end;
  IsNewPaddingStored:=IsNewPaddingStored and not EqualRect(_BasePadding,BasePadding(HasRastering));
  Filer.DefineProperty('NewPadding', SkipValue, WriteNewPadding, IsNewPaddingStored);

  IsNewMarginStored:=false;
  if _NeedNewMargin then
  begin
   _BaseMargin:=Rect(0,0,0,0);
   GetTopIndexes(Owner,prev,next);
   if prev<>nil then
   begin
     _BaseMargin.Top:={min(}-min(prev.MarginWidthNormalStyle(ealBottom),Owner.MarginWidth(ealTop)){,prev.StyleArr[hsNormal]._BaseMargin.Bottom)};
   end;
   if next<>nil then
   begin
     _BaseMargin.Bottom:={min(}-min(next.MarginWidthNormalStyle(ealTop),Owner.MarginWidth(ealBottom)){,next.StyleArr[hsNormal]._BaseMargin.Top)};
   end;
   IsNewMarginStored:=true;
  end else
  if ((HasRastering<>rsNo) or IsNewPaddingStored) then
  begin
   _BaseMargin:=Rect(0,0,0,0);
   IsNewMarginStored:=true;
  end;
  IsNewMarginStored:=IsNewMarginStored and not EqualRect(_BaseMargin,BaseMargin(HasRastering));
  Filer.DefineProperty('NewMargin', SkipValue, WriteNewMargin, IsNewMarginStored);

  IsNewBorderStored:=false;
  if ((HasRastering<>rsNo) or IsNewPaddingStored) then
  begin
   _BaseBorder:=Rect(0,0,0,0);
   IsNewBorderStored:=true;
  end;           
  IsNewBorderStored:=IsNewBorderStored and not EqualRect(_BaseBorder,BaseBorder(HasRastering));
  Filer.DefineProperty('NewBorder', SkipValue, Write0px, IsNewBorderStored);


  finally
   Owner.SetPreferStyle(nil,false,true);
   glPaintOnlyBg:=false;
  end;
//  Filer.DefineProperty('IsPre', ReadBool, WriteTrue, ItGetVal(pcWhiteSpace,Value) and (Value.WhiteSpace=cwsPre));

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
 //assert(InNotifyCSSChanged);
 NotifyInlineUsedByList(WhatChanged-[wcTemplate]);
 for i:=UsedByList.Count-1 downto 0 do
 with TdhCustomPanel(UsedByList[i]) do
 begin
  CSSToWinControl(WhatChanged);
  NotifyUsedByList(WhatChanged{-[wcTemplate]});
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

 if ([wcTemplate]<>WhatChanged) and (wcChild in WhatChanged) then
  NotifyChilds(Self,WhatChanged*InheritableChanges+[wcNoOwnCSS]);
 finally
  InNotifyCSSChanged:=false;
 end;
end;



procedure TStyle.GetFontDifferences({const Font:TFont}FontStyle:TFontStyles; FontColor:TCSSColor; FontName:TFontName; FontHeight:Integer );
var OldOnChange:TNotifyEvent;
begin

{ OldOnChange:=Font.OnChange;
 Font.OnChange:=nil;
 }
 Owner.Bold:=fsBold in FontStyle;
 Owner.Italic:=fsItalic in FontStyle;
 Owner.Underline:=fsUnderline in FontStyle;
 Owner.LineThrough:=fsStrikeOut in FontStyle;

 Owner.FontColor:=FontColor;
 //if CSSFont.Name<>Font.Name then
 Owner.NearestFontFamily:=FontName;
 //if CSSFont.Height<>Font.Height then
 //Owner.FontSize:=inttostr(-FontHeight);
 Owner.FontSize:=IntToStr(Abs(FontHeight));

// Font.OnChange:=OldOnChange;
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


procedure TdhCustomPanel.CheckDesignState(inv:boolean);
var _LastActStyle:TState;
begin
// if InNotifyCSSChanged and not InCollectChanges {or CancelCheckDesignState} then exit;
 _LastActStyle:=LastActStyle;

 if RuntimeMode or not glIsDesignerSelected(Self) then
 begin
  LastActStyle:=GetHTMLState;
 end  else
  LastActStyle:=DesignStyle;

 if _LastActStyle<>LastActStyle then
 begin
  if not (csDestroying in ComponentState) and not (csLoading in  ComponentState) then
//  if (FStyleOver<>nil) and FStyleOver.IsItStored or FStyleDown.IsItStored or FStyleOverDown.IsItStored{( LastActStyle<>hsNormal) and StyleArr[ LastActStyle].IsItStored or
//  //   (_LastActStyle<>hsNormal) and StyleArr[_LastActStyle].IsItStored} then
  begin
    //Invalidate;
  try
    InvDesigner;

 except
 on e:exception do showmessage('ASDF77b '+e.Message);
 end;
     // LastActStyle:=hsNormal; exit;
    // if not (csLoading in ComponentState) then
    begin
//    Web1.memo1.lines.add('Name:'+name+' style:'+GetEnumName(TypeInfo(TState),integer(_LastActStyle))+' to '+GetEnumName(TypeInfo(TState),integer(LastActStyle)));
    if not inv and not CancelCheckDesignState then
    begin
     showmessage('Transition undetected from '+GetEnumName(TypeInfo(TState),integer(_LastActStyle))+' to '+GetEnumName(TypeInfo(TState),integer(LastActStyle))+' name:'+GetName);
    end;
    //if ControlCount<>0 then
    //if not InNotifyCSSChanged and not InCSSToWinControl then
    DoStateTransition(_LastActStyle);
    { if LastActStyle in [hsOver,hsOverDown] then
      Update;}
    end;

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
 CheckDesignState(false);
 result:=StyleArr[LastActStyle];
 if result=nil then
  result:=StyleArr[hsNormal];
end;

function TdhCustomPanel.State:TState;
begin
 //CheckDesignState(false);
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
// result:=Canvas;
 result:=ActTopGraph.Canvas;
end;

function TdhCustomPanel.GetName:string;
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

{function TdhCustomPanel.GetOverBasedOnDown:boolean;
begin
 result:=false;
end;
}

function ManageEventBubbling(Self:TControl):boolean;
begin
 result:=not ((Self<>glEventObj) and (Self is TWinControl) and TWinControl(Self).ContainsControl(glEventObj));
 glEventObj:=Self;
end;



procedure TdhCustomPanel.UpdateMousePressed(Down:boolean; DownIfDown:boolean);
begin
// if ManageEventBubbling(Control) then
 begin         {
  if not Down then
showmessage('1:'+booltostr(Down)+'/'+booltostr(DownIfDown));  }
 if DownIfDown then
 //if (Down and DownIfDown or not Down and not DownIfDown) and Control.HasParent then
 begin
  if not Visible and (csNoDesignVisible in ControlStyle) then //funzt net
   exit;                  {
  p:=Control.BoundsRect.TopLeft;
  p2:=Mouse.CursorPos;
  p:=Control.ClientToScreen(SmallPointToPoint(Pos)); }
  //showmessage(inttostr(TWMLButtonDown(Message).YPos));
  glUpdateOver(Self,{Control=FindDragTarget(Mouse.CursorPos, True)}FIsOver,Down);
//  glUpdateOver(Control,true,Down);
  //showmessage('x:'+inttostr(Left-p.X)+' y:'+inttostr(Top-p.Y));
{  dec(TWMLButtonDown(Message).XPos,Left-p.X);
  dec(TWMLButtonDown(Message).YPos,Top-p.Y+(Mouse.CursorPos.Y-p2.Y));
  }
//  p2:=Control.ScreenToClient(p);
//  p2:=Point(min(p2.X,Control.Parent.Width-Control.Left),min(p2.Y,Control.Parent.Height-Control.Top));

 end else
  glUpdateOver(Self,FIsOver,false);
 end;
end;





(*
procedure TdhCustomPanel.SetUsed(Value:boolean);
begin
 if csLoading in ComponentState then exit;

 if Value<>GetUsed then
 if Value then
 begin
   showmessage('This value cannot be set to TRUE manually.'#13#10'It is set to TRUE if another control uses the this controlEmptyStrs style (see StyleOf)');
 end else
 begin
  TransformUse(FUse);
  //showmessage('You have to add a TdhStyleSheet to the form so that controls using this controlEmptyStrs style are set to a new style');
 end;
end;
  *)
{procedure TdhCustomPanel.SetCursor(Value: TCursor);
begin
 if not CursorChanging then
//  showmessage('Cannot be changed manually. Please change the CSS cursor property') else
  TWinControl(Self).Cursor:=Value;
end;
 }





function TdhCustomPanel.GetUsed:boolean;
begin
 Result:=UsedByList.Count<>0;
end;



type PComponentState=^TComponentState;

                     (*
procedure TdhCustomPanel.UpdateSharing;
begin
 if not glSharing and not (csLoading in Control.ComponentState) then
 if (FUse<>nil) and ExtendedUse then
  FUse.FetchSharing(Control) else
 begin
  glSharing:=true;
  NotifyCSSChanged([wcTemplate]);
  glSharing:=false;
 end;          {
 if (FUse<>nil) and FUse.GetSharingEnabled and (glSharing=nil) and not (csLoading in Control.ComponentState) then
 begin
  glSharing:=Control;
  FUse.GetCommon.NotifyCSSChanged([wcTemplate]);
  glSharing:=nil;
 end;              }
end;
                       *)



                      {
procedure TdhCustomPanel.UpdateMenuCoords;
begin
end;                  }


   {
function TdhCustomPanel.CanResize(var NewWidth, NewHeight: Integer): Boolean;
var PicWidth,PicHeight:integer;
    Picture:TPicture;
begin
 if HasImage(Picture,PicWidth,PicHeight) then
 begin
  CanAutoSize(NewWidth, NewHeight);
  result:=false;
 end else
  result:=true;
end;    }

function TdhCustomPanel.GetMaxWidth:integer;
begin
 result:=Constraints.MaxWidth;
 if result=0 then
  result:=maxint;
end;

function TdhCustomPanel.GetMaxHeight:integer;
begin
 result:=Constraints.MaxHeight;
 if result=0 then
  result:=maxint;
end;



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
var NewWidth,NewHeight:integer;
begin

 GetAutoRect(CanAutoX,CanAutoY,PreferedWidth,PreferedHeight);
 {it not CanAutoX and not CanAutoY then exit;

 if CanAutoX then
  MaxWidth:=GetMaxWidth else
  MaxWidth:=PreferedWidth;
 if CanAutoY then
  MaxHeight:=GetMaxHeight else
  MaxHeight:=PreferedHeight;

 NewWidth:=maxint;
 NewHeight:=maxint;
 R:=GetAutoRect(MaxWidth,MaxHeight,NewWidth,NewHeight);
 if not CanAutoX and (NewWidth<>maxint) then
  PreferedWidth:=NewWidth;
 if not CanAutoY and (NewHeight<>maxint) then
  PreferedHeight:=NewHeight; }

end;



procedure TdhCustomPanel.ConstrainedResize(var MinWidth, MinHeight, MaxWidth,
  MaxHeight: Integer);
var R:TRect;
var PicWidth,PicHeight:integer;
    Width,Height:integer;
begin
 //inherited; for speed we uncomment it (since ConstrainedResize calls itself recursively); GetSuperiorAutoRect does this job

                                  {
 siehe GetSuperiorAutoRect

 if csDestroying in ComponentState then exit;
 R:=Rect(0,0,0,0);
 AdjustClientRect(R);
 Width:=R.Left-R.Right;
 Height:=R.Top-R.Bottom;
 if not TextOnly then
  AdjustLittle(Width,Height,false);
 MinWidth:=max(Width,MinWidth);
 MinHeight:=max(Height,MinHeight); }

   {
 if CanAutoX or CanAutoY then
 begin
  R:=GetAutoRect(MinWidth,MinHeight);

 end;   }


 (*if HasImage(Picture,PicWidth,PicHeight) then
 begin
  R:=GetAutoRect(MinWidth,MinHeight);
  MinWidth:=R.Right-R.Left;
  MinHeight:=R.Bottom-R.Top;
  MaxWidth:=MinWidth;
  MaxHeight:=MinHeight;
  {R:=ClientEdgesPure;
  inc(PicWidth,R.Left+R.Right);
  inc(PicHeight,R.Top+R.Bottom);
  MinWidth:=max(PicWidth,MinWidth);
  MinHeight:=max(PicHeight,MinHeight);
  MaxWidth:=MinWidth;
  MaxHeight:=MinHeight; }
 end;*)

 {R:=AllEdgesPure;
 MinWidth:=max(R.Left+R.Right,MinWidth);
 MinHeight:=max(R.Top+R.Bottom,MinHeight); }
end;


                   {
procedure IssueUpdateBoundsRect(c:TControl);
begin
  if not (csLoading in c.ComponentState) then exit;
  PComponentState(@c.ComponentState)^:=c.ComponentState-[csLoading];
  TFakeControl(c).UpdateBoundsRect(TFakeControl(c).BoundsRect);
  PComponentState(@c.ComponentState)^:=c.ComponentState+[csLoading];

end;

                       }

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
    i:integer;
begin
 {if (csLoading in ComponentState) and not (csReading in ComponentState) then
 begin
  AWidth:=Width;
  AHeight:=Height;
 end;   }

{ if (csLoading in ComponentState) and not (csReading in ComponentState) then
 for i:=0 to ControlCount-1 do
  IssueUpdateBoundsRect(Controls[i]);
 }
 //if (csLoading in ComponentState) and not (csReading in ComponentState) and not ((Parent<>nil) and not(csLoading in Parent.ComponentState)) then exit;//prevents problem with wsMaximized and Anchors


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

 WeakToStrong(true);

// UpdateScrollBars(false);


 //UpdateScrollMask;
 {
 if FViewportHandle<>nil then
 with ScrollArea do
 begin
   QWidget_setGeometry(FViewportHandle, Left, Top, (Right-Left), (Bottom-Top));
   s:=stringofchar(chr(1+4+16+64),(right-left)*(bottom-top) div 8);
   //QB := QBitmap_create(Right-Left, (Bottom-Top), @s[1], true);
   QB := QBitmap_create(Right-Left, Bottom-Top, false, QPixmapOptimization_DefaultOptim);

   QWidget_setMask(FViewportHandle, QB);

 end;  }
end;




function TdhCustomPanel.FinalShowing:boolean;
begin
 result:=Showing or WithMeta;
end;

procedure TdhCustomPanel.AdjustSize;
var R,R2,R3,nb:TRect;
    //aWidth,aHeight:integer;
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
  { R2:=GetCBound(Self);
   if not EqualRect(R2,R) then
    exit;  }
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
//    Perform(CM_BORDERCHANGED, 0, 0);
  if IsScrollArea and NCScrollbars then
  if not (csLoading in ComponentState) and HandleAllocated then
  begin
    PreventFlicker;
    SetWindowPos(Handle, 0, 0, 0, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or
      SWP_NOZORDER or SWP_FRAMECHANGED{ or SWP_DRAWFRAME });
    //RequestAlign;
  end;
{$ELSE}
//  PreventFlicker
  CheckNC;
  CheckChildrenNC;
 //UpdateScrollMask;
{$ENDIF}
// AdjustSize;
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
  {if csDestroying in ComponentState then
  if csDestroying in ComponentState then exit;}
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
    ScrollAreaDelta,_NC:TRect;
begin
  (*if IsScrollArea and NCScrollbars then
  begin
   ScrollAreaDelta:=GetOffsetRect(ScrollArea,-DeltaX,-DeltaY);
   for i:=0 to ControlCount-1 do
   if Controls[i] is TdhCustomPanel then
   with TdhCustomPanel(Controls[i]) do
   begin
    IntersectRect(_NC,{Rect(0,0,Width,Height)}ClientRect,GetOffsetRect(ScrollAreaDelta,-Left,-Top));
    if not EqualRect(NC,_NC) then
    begin
     NC:=_NC;
     DefDelta:=true;
     UpdateMask;
     DefDelta:=false;
    end;
   end;
  end;*)

  if IsScrollArea and NCScrollbars then
  for i:=0 to ControlCount-1 do
  if Controls[i] is TdhCustomPanel then
   TdhCustomPanel(Controls[i]).CheckNC(DeltaX, DeltaY);
end;
{$ENDIF}




constructor TTransformations.Create(AOwner:TStyle);
begin
  inherited Create;
  Owner:=AOwner;
  FScaleY:=100;
  FScaleX:=100;
  FAntiAliasing:=not true;
  FFullIfEasy:=true;
  FAlpha:=255;
  FInnerShadow:=TShadow.Create(Self);
  FOuterShadow:=TShadow.Create(Self);
  FInnerGlow:=TGlow.Create(Self);
  FOuterGlow:=TGlow.Create(Self);
  FBlur:=TBlur.Create(Self);
end;

destructor TTransformations.Destroy;
begin 
  FInnerShadow.Free;
  FOuterShadow.Free;
  FInnerGlow.Free;
  FOuterGlow.Free;
  FBlur.Free;
  inherited;
end;


constructor TCSSBorderRadius.Create(AOwner:TStyle);
begin
  inherited Create;
  Owner:=AOwner;
end;


constructor TCSSBorder.Create(AOwner:TStyle);
begin
  inherited Create;
  Owner:=AOwner;
  FColor:=colInherit;
  FWidth:=vsrInherit;
end;

procedure TCSSBorder.Clear;
begin
  FColor:=colInherit;
  FWidth:=vsrInherit;
  FStyle:=Low(TCSSBorderStyle);
end;


procedure TStyle.Clear;
var Align:TEdgeAlign;
begin
 InitMisc;

 FBackgroundImage.Assign(nil);

    for Align:=low(TEdgeAlign) to high(TEdgeAlign) do
    begin
     FBorders[Align].Clear;
     FMargins[Align]:=EmptyStr;
    end;

    FBackgroundPosition:=EmptyStr;
    FBefore:=EmptyStr;
    FAfter:=EmptyStr;
    FOther:=EmptyStr;
    FFontSize:=EmptyStr;
    FFontFamily:=EmptyStr;
    FVerticalAlign:=EmptyStr;
    FLetterSpacing:=EmptyStr;
    FWordSpacing:=EmptyStr;
    FLineHeight:=EmptyStr;
    FTextIndent:=EmptyStr;
    FBackgroundAttachment:=Low(TCSSBackgroundAttachment);
    FBackgroundRepeat:=Low(TCSSBackgroundRepeat);
    FTextAlign:=Low(TCSSTextAlign);
    FWhiteSpace:=Low(TCSSWhiteSpace);
    FDirection:=Low(TCSSDirection);
    FTextTransform:=Low(TCSSTextTransform);
    FCursor:=Low(TCSSCursor);
    FFontStyle:=Low(TCSSFontStyle);
    FFontVariant:=Low(TCSSFontVariant);
    FFontWeight:=Low(TCSSFontWeight);
    FDisplay:=Low(TCSSDisplay);
    FVisibility:=Low(TCSSVisibility);
    FListStyleType:=Low(TCSSListStyleType);
    FTextDecoration:=[];

    //FAntiAliasing:=Low(TCSSAntiAliasing);
    FTransformations.Clear;
    FBorderRadius.Clear;

    pcs(AllChanged);
end;

procedure TStyle.PictureChange(Sender: TObject);
begin
// Owner.InvalTop(true);
 if not PreventGraphicOnChange then
  pc(pcBackgroundImage);
end;

procedure TStyle.PictureProgress(Sender: TObject; Stage: TProgressStage;
    PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string);
begin
// if RedrawNow then
// if Stage=psStarting then
end;

constructor TStyle.Create(AOwner:IChangeReceiver; OwnState:TState);
var Align:TEdgeAlign;
begin
  inherited Create;
  Owner:=AOwner;
  Self.OwnState:=OwnState;
  FBackgroundImage := TLocationImage.Create;
  FBackgroundImage.OnChange := PictureChange;
  FBackgroundImage.Owner:=Self;
  //FBackgroundImage.OnProgress:=PictureProgress;

  for Align:=low(TEdgeAlign) to high(TEdgeAlign) do
  begin
   FBorders[Align]:=TCSSBorder.Create(Self);
  end;

  FTransformations:=TTransformations.Create(Self);
  FBorderRadius:=TCSSBorderRadius.Create(Self);
  InitMisc;
end;

procedure TStyle.InitMisc;
var Align:TEdgeAlign;
begin
  for Align:=low(TEdgeAlign) to high(TEdgeAlign) do
  begin
   FPaddings[Align]:=vsrInherit;
  end;
  FZIndex:=vsrInherit;
  FMinWidth:=vsrInherit;
  FMinHeight:=vsrInherit;
  FBackgroundColor:=colInherit;
  FColor:=colInherit;
end;




destructor TStyle.Destroy;
var Align:TEdgeAlign;
begin
 FBackgroundImage.Free;
 for Align:=low(TEdgeAlign) to high(TEdgeAlign) do
 begin
  FBorders[Align].Free;
 end;
 FTransformations.Free;
 FBorderRadius.Free;
 inherited;
end;

procedure TStyle.SetBackgroundRepeat(Value:TCSSBackgroundRepeat);
begin
 FBackgroundRepeat:=Value;
 pc(pcBackgroundRepeat);
end;


procedure TStyle.SetBackgroundImage(Value: TLocationImage);
begin
  FBackgroundImage.Assign(Value);
  pc(pcBackgroundImage);
end;


function TStyle.IsPictureStored:boolean;
begin
 result:=FBackgroundImage.HasPicture;
end;

function TLocationImage.HasPicture:boolean;
begin
 result:=(GetGraphic<>nil) or HasPath;
end;

procedure TLocationImage.UpdateAnimationState;
begin                     
 if (Owner<>nil) and (Owner.Owner<>nil) and (GetGraphic is TGIFImage) then
 if csDesigning in Owner.Owner.ComponentState then
 begin
  TGIFImage(GetGraphic).SetAnimateSilent(false);
  TGIFImage(GetGraphic).ForceFrame:=0;
 end else
 begin 
  TGIFImage(GetGraphic).SetAnimateSilent(true);
 end;
end;

procedure TLocationImage.UpdateCalculations;
begin
 if GetGraphic=nil then
 begin
  FImageState:=isUninitialized;
 end else
 begin
  FPictureID.OnChange:=Changed;
  FWidth:=GetGraphic.Width;
  FHeight:=GetGraphic.Height;
  if CalculateImgCanT1X1 then
  begin
   FImageState:=isOnePixel;
  end else
  if CalculateImgCouldBeRastered then
  begin
   FImageState:=isSemiTransparent;
  end else
  if CalculateAnimatedGIF then
  begin
   FImageState:=dhPanel.isAnimatedGIF;
   UpdateAnimationState;
  end else
  begin
   FImageState:=isAnalyzed;
  end;
 end;
 if CanReleaseResources then
 begin
  ReleaseResources;
 end;
end;

procedure TLocationImage.RequestCalculations;
begin
 if FImageState=isUninitialized then
 begin
  RequestGraphic;
  UpdateCalculations(true);
 end;
end;


function TLocationImage.StoreCalculations:boolean;
begin
 if WithMeta then
 begin
  RequestCalculations;
 end;
 result:=(FImageState<>isUninitialized) and HasPath;
end;

procedure TLocationImage.ReleaseResources;
begin
 if (FPictureID<>nil) and HasPath and not CachingIsUseful then
 begin
  FreeAndNil(FPictureID);
 end;
end;

function TLocationImage.HasPath: Boolean;
begin
 result:=FPath<>'';
end;

function TLocationImage.GraphicExtension:String;
var i:integer;
begin
 result:='';
 if HasPath then
 begin
  result:=ExtractFileExt(FPath);
  if result<>'' then exit;
 end;
 if GetGraphic<>nil then
 begin
  result:=GetGraphicExtension(GetGraphic);
 end;
end;


function TLocationImage.CachingIsUseful:Boolean;

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

function RecursiveShowing(panel:TdhCustomPanel):Boolean;
var pn:TdhCustomPanel;
    i:integer;
begin
 if ParentsVisible(panel) then
 begin
  result:=true;
  exit;
 end;
 for i:=panel.UsedByList.Count-1 downto 0 do
 begin
  pn:=TdhCustomPanel(panel.UsedByList[i]);
  if RecursiveShowing(pn) then
  begin
   result:=true;
   exit;
  end;
 end;
 for i:=panel.InlineUsedByList.Count-1 downto 0 do
 begin
  pn:=TdhCustomPanel(panel.InlineUsedByList[i]);
  if ParentsVisible(pn) then
  begin
   result:=true;
   exit;
  end;
 end;
 result:=false;
end;

begin
 result:=RecursiveShowing(self.Owner.Owner);
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

procedure TLocationImage.SetPath(const Path:String);
var RelativePathProvider:IRelativePathProvider;
begin
  RelativePathProvider:=findIRelativePathProvider(self.Owner.Owner);
  if RelativePathProvider<>nil then
  begin
   FPath:=RelativePathProvider.GetAbsolutePath(Path);
   Exit;
  end;
  FPath:=Path;
end;

function TLocationImage.GetRelativePath:String;
var RelativePathProvider:IRelativePathProvider;
begin
  RelativePathProvider:=findIRelativePathProvider(self.Owner.Owner);
  if RelativePathProvider<>nil then
  begin
   Result:=RelativePathProvider.GetRelativePath(FPath);
   Exit;
  end;
  Result:=FPath;
end;

function TLocationImage.GetAbsolutePath:String;
var RelativePathProvider:IRelativePathProvider;
begin
  RelativePathProvider:=findIRelativePathProvider(self.Owner.Owner);
  if RelativePathProvider<>nil then
  begin
   Result:=RelativePathProvider.GetAbsolutePath(FPath);
   Exit;
  end;
  Result:=FPath;
end;


function TStyle.IsStyleStored:boolean;
var PropChoose:TPropChoose;
begin
 StoredChecking:=true;
 try
 for PropChoose:=Low(TPropChoose) to High(PropChoose) do
 begin
 ValStyle:=nil;
 if GetStyleVal(PropChoose,ealNone) or (ValStyle<>nil) then
 begin
  Result:=true;
  exit;
 end;
 end;
 Result:=false;
 finally
  StoredChecking:=false;
 end;
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.CreateParams(var Params: TCreateParams);
begin
     { call the create of the params }
  inherited;
  with Params.WindowClass do
    style := style and not (CS_HREDRAW or CS_VREDRAW);
 { with Params.WindowClass do
    style := style or CS_CLASSDC or CS_BYTEALIGNCLIENT or CS_BYTEALIGNWINDOW	;     }

//     tcustompanel
{    with Params do
      WindowClass.style :=CS_PARENTDC or WindowClass.style and not  (CS_HREDRAW or CS_VREDRAW) and not CS_SAVEBITS	;
 }
//     Params.ExStyle := Params.ExStyle + WS_EX_Transparent; // geht, aber mit visuellem BringToFront
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
//  RR:TRect;
  all:TAlign;
  c:TControl;
  RandX,RandY,AccWidth,AccHeight:integer;
  ClientAllowModifyX,ClientAllowModifyY:boolean;
  IsHorzScrollBarVisible,IsVertScrollBarVisible:boolean;
  PreNewWidth,PreNewHeight:integer;
  Avail,Req:TPoint;


        {
function XIsGiven(Self:TWinControl):boolean;
var Common:TCommon;
begin
 if Self.Parent=nil then
  result:=true else
 if Self.Align in [alTop,alBottom,alClient] then
  result:=XIsGiven(Self.Parent) else
  result:=HasCommon(Self,Common) and not (Common.ASXY in [asX,asXY]))
end;

function YIsGiven(Self:TWinControl):boolean;
var Common:TCommon;
begin
 if Self.Parent=nil then
  result:=true else
 if Self.Align in [alLeft,alRight,alClient] then
  result:=YIsGiven(Self.Parent) else
  result:=HasCommon(Self,Common) and not (Common.ASXY in [asY,asXY]))
end;       }


var pn:TdhCustomPanel;
    mar:TRect;
    margintop:integer; 
begin
   if not AllowModifyX and not AllowModifyY then exit; //for speed

{   RR := Rect(0,0,0,0);
   AdjustClientRect(RR);
   RandX:=(-RR.Right)-(-RR.Left);
   RandY:=(-RR.Bottom)-(-RR.Top);  }
   with AllEdgesPure do
   begin
    RandX:=Left+Right;
    RandY:=Top+Bottom;
   end;
   {AllowModifyX:=AllowModifyX and (Common.ASXY in [asX,asXY]);
   AllowModifyY:=AllowModifyY and (Common.ASXY in [asY,asXY]);  }
   {if not AllowModifyX then
    MaxWidth:=NewWidth-RandX else
    MaxWidth:=maxint;
   if not AllowModifyY then
    MaxHeight:=NewHeight-RandY;  }

   {if MaxWidth<>maxint then
    MaxWidth:=MaxWidth-RandX;
   if MaxHeight<>maxint then
    MaxHeight:=MaxHeight-RandY;       }


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
      { if not FinalVisible(Self.Controls[i]) then
        Continue;
       if not (Align in [alLeft,alRight,alTop,alBottom,alClient]) then
        Continue;
       if all=alNone then
        all:=Align else
       if all<>Align then
       begin
        rNewHeight:=-1;
        rNewWidth:=-1;
        break;
       end;    }

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

    //if AllowModifyX then
    if (all in [alTop,alBottom,alClient]) then
    begin
     if (rNewWidth<>-1) then
      PreNewWidth:=rNewWidth+RandX;
    end else
    if (all in [alLeft,alRight,alClient]) then
    begin
     PreNewWidth:=AccWidth+RandX;
    end;

    //if AllowModifyY then
    if (all in [alLeft,alRight,alClient]) then
    begin
     if (rNewHeight<>-1) then
     begin
      PreNewHeight:=rNewHeight+RandY;
      {if not AllowModifyX then
      if AccWidth+RandX>NewWidth then
       Inc(NewHeight,HorzScrollBar);  }
     end;
    end else
    if (all in [alTop,alBottom,alClient]) then
    begin
     PreNewHeight:=AccHeight+RandY;
     {if not AllowModifyX then
     if AccWidth+RandX>NewWidth then
      Inc(NewHeight,HorzScrollBar);  }
    end;
    {if AllowModifyX then
     NewWidth:=PreNewWidth; 
    if AllowModifyY then        
     NewHeight:=PreNewHeight; }

    Avail:=Point(NewWidth,NewHeight);
    Req:=Point(PreNewWidth,PreNewHeight);
    AddScrollbarPlace(IsHorzScrollBarVisible,IsVertScrollBarVisible,AllowModifyX,AllowModifyY,Avail,Req);
    NewWidth:=Avail.X;
    NewHeight:=Avail.Y;

  {if XIsGiven(Self) then
   NewWidth:=Width else
   NewWidth:=rNewWidth+(-RR.Right)-(-RR.Left);
  if YIsGiven(Self) or LeaveY then
   NewHeight:=Height else
   NewHeight:=rNewHeight+(-RR.Bottom)-(-RR.Top);  }
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
//var NewWidth,NewHeight:integer;
begin
 if GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth, NewHeight) then exit;

 //if AutoSizeXY<>asNone then
 begin
  if _AutoResizing then
   showmessage('_AutoResizing already active!');
 _AutoResizing:=true;
  try
   {Extents:=GetControlExtents;
   R := Rect(0,0,0,0);
   AdjustClientRect(R);}
   ChildrenAutoRect({MaxWidth,MaxHeight}AllowModifyX,AllowModifyY, NewWidth, NewHeight);
  finally
   _AutoResizing:=false;
  end;
 {NewWidth:=Extents.Right+(-R.Right);
 NewHeight:=Extents.Bottom+(-R.Bottom); }
 end;
end;



function FinalVisible(c:TControl):boolean;
begin
 result:=c.Visible or (csDesigning in c.ComponentState) and
        not (csNoDesignVisible in c.ControlStyle);
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



            {
function TdhCustomPanel.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  Rect: TRect;
begin
    Rect := PaddingPure;
    NewHeight:=max(NewHeight,Rect.Top+Rect.Bottom);
    NewWidth:=max(NewWidth,Rect.Left+Rect.Right);


 _NewWidth:=NewWidth;
 _NewHeight:=NewHeight;
  if _AutoResizing then
   showmessage('_AutoResizing already active!');
 _AutoResizing:=true;
 result:=Inherited CanAutoSize(NewWidth, NewHeight);
 _AutoResizing:=false;
end;             }


                                 {
procedure TdhCustomPanel.WMLButtonUp(var Message: TWMLButtonUp);
begin
 UpdateMousePressed(false,DownIfDown,Message.Pos);
 inherited;
end;
                                      }


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
//UpdateBoundsRect(BoundsRect);
// QWidget_setBackgroundMode(Handle, QWidgetBackgroundMode_NoBackground);
 TryBrokenReferences(nil);

 //WeakToStrong(true); //wurde in SetBounds nicht aufgerufen wegen csReading-Status, also tun wirs hier


// Masked:=True;

// transparent:=false;

// if {(csLoading in Control.ComponentState) and }(Control.Owner<>nil) and not (Control.Owner.Name='dhStrEditDlg') and not(csDesigning in Control.ComponentState) then
//  RuntimeMode:=true;
 CSSToWinControl(ActStyleLoaded);

end;



procedure TdhCustomPanel.NameChanged;
begin
  if not (csDestroying in ComponentState) and not (csLoading in ComponentState) then
  begin
   NotifyInlineUsedByList([wcName]);
  end;
end;






procedure TdhCustomPanel.UpdateMouse(MouseEnter:boolean);
begin
 if OuterControl<>nil then exit;
 if ManageEventBubbling(Self) then
 if not (csDesigning in ComponentState) then
  SetIsOver(MouseEnter);
end;




{procedure TdhCustomPanel.CloseMenu;
var _TailSubMenu:TdhCustomPanel;
begin
 _TailSubMenu:=TailSubMenu;
 TailSubMenu:=nil;
 if _TailSubMenu<>nil then
  _TailSubMenu.CheckClose;
end;

 }

                {
function TdhCustomPanel.HasChild(States:TStates):boolean;
var i:integer;
begin
 for i:=0 to self.ControlCount-1 do
 if self.Controls[i] is TdhCustomPanel then
 if TdhCustomPanel(self.Controls[i]).HTMLState in States then
 begin
  result:=true;
  exit;
 end;
 result:=false;
end;       }



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

                               {
function TdhCustomPanel.GetFirstRealUse:TdhCustomPanel;
begin
 if (FUse<>nil) and FUse.StyleStored then
  result:=FUse else
 if FUse<>nil then
  result:=FUse.GetFirstRealUse else
  result:=nil;
end;
                      }
              {
function TdhCustomPanel.GetStyleStored:boolean;
begin
 result:=Common;
 result:=st.FStyle.IsStyleStored or FStyleOver.IsStyleStored or FStyleDown.IsStyleStored or FStyleOverDown.IsStyleStored;
end;              }

{function TdhCustomPanel.AdjPosList(i:integer; seIndex:TList):boolean;
begin
 result:=false;
end;
 }


type PAlign=^TAlign;

(*

function OrderedControls(Self:TWinControl):boolean;
var i:integer;
var seIndex:TList;
begin
 with Self do
 begin

 glSortComp:=self;
 seIndex:=DoSort(@AlignPosCompare,ControlCount);

 for i:=0 to ControlCount-1 do
 begin
  if Controls[i] is TdhCustomPanel then
   TdhCustomPanel(Controls[i]).SaveAlign:=Controls[i].Align;
  if Controls[i].Align in [alTop,alLeft] then
   PAlign(@Controls[i].Align)^:=alCustom;
 { if (Controls[i] is TdhCustomPanel) and not (Controls[i] is TdhLabel) then
   Controls[i].ControlStyle:=Controls[i].ControlStyle-[csAcceptsControls];   }
 end;
 //HasTop:=false;
 result:=false;
 for i:=0 to seIndex.Count-1  do
 begin
  seIndex[i]:=Controls[Integer(seIndex[i])];
//  HasTop:=HasTop or TControl(seIndex[i]).Align in [alTop];
 end;

 for i:=0 to seIndex.Count-1  do
 while (TControl(seIndex[i]) is TdhCustomPanel) and TdhCustomPanel(seIndex[i]).AdjPosList(i,seIndex) do;


 for i:=0 to seIndex.Count-1  do
 begin
  result:=result or (Controls[i]<>seIndex[i]);
//  result:=result or (Integer(seIndex[i])<>i);
 end;


 if {HasTop and }result then
 begin
 for i:=0 to seIndex.Count-1  do
 //if (Controls[Integer(seIndex[i])].Align in [alTop,alLeft]) then
 if TControl(seIndex[i]) is TWinControl then
  TControl(seIndex[i]).BringToFront;
// OrderedControls(self);
 end;

 end;
end;


procedure StopOrderedControls(Self:TWinControl);
var i:integer;
begin
 with Self do
 for i:=0 to ControlCount-1  do
 begin
  if Controls[i].Align=alCustom then
  if Controls[i] is TdhCustomPanel then
   PAlign(@Controls[i].Align)^:=TdhCustomPanel(Controls[i]).SaveAlign else
   PAlign(@Controls[i].Align)^:=alTop;
  {if (Controls[i] is TdhCustomPanel) and not (Controls[i] is TdhLabel) then
   Controls[i].ControlStyle:=Controls[i].ControlStyle+[csAcceptsControls]; }
  //TdhCustomPanel(Controls[i]).UpdateControlState;
 end;

end;
*)


function TdhCustomPanel.LeaveY:boolean;
begin
 result:=false;
end;                    

function DoIntersectStrong(R1,R2:TRect):boolean;
begin
 IntersectRect(R1,R1,R2);
 Result:=not IsRectEmpty(R1);
end;

function DoIntersectWeak(R1,R2:TRect):boolean;
begin
 result:=IntersectRect(R1,R1,R2);
end;
                      {
function TdhCustomPanel.ClientArea:TPoint;
begin
 result:=Point(ClientWidth,ClientHeight);
 if IsVertScrollBarVisible then
  dec(result.X,VertScrollbar);
 if IsHorzScrollBarVisible then
  dec(result.Y,HorzScrollbar);
end;
                    }

procedure RecursiveInvalidate(c:TWinControl);
var i:integer;
begin
 with c do
 begin
  for i:=0 to ControlCount-1 do
  if Controls[i] is TWinControl then
   RecursiveInvalidate(TWinControl(Controls[i]));   
  Invalidate;
 end;
end;

var PreventAlignControls:boolean=false;

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
{ if VertScrollInfo.nMax<>0 then
  P:=Point(min(P.X,HorzScrollInfo.nMax-HorzScrollInfo.nPage),min(P.Y,VertScrollInfo.nMax-VertScrollInfo.nPage));
 }
 if EqualPoint(P,OldPos) then exit;
 HPos:=P.X;
 VPos:=P.Y;
 ScrollPaintChanged;
 InvalTop(SomethingIsFixed,not SomethingIsScrolled);
 assert(not PreventAlignControls);
 PreventAlignControls:=true;
 ScrollBy(OldPos.X-HPos,OldPos.Y-VPos);
 ChildrenAdjustStrong(HPos-OldPos.X,VPos-OldPos.Y);
 //ChildrenWeakToStrong;
 PreventAlignControls:=false;
 //UpdateScrollBars(false);
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
//  with Result do
  result:=Bounds(Left-HPos,Top-VPos,max(HorzScrollInfo.nMax,Right-Left),max(VertScrollInfo.nMax,Bottom-Top));

{  result:=self.ScrollArea;
  with result do
  result:=Bounds(Left,Top,max(Right-Left,HorzScrollInfo.nMax),max(Bottom-Top,VertScrollInfo.nMax));
}end;




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

  (*
function MeasureArea:TRect;
begin
 //result:=Rect(0,0,Width,Height);
 {result:=ScrollAreaWithScrollBars;
 if IsVertScrollBarVisible then
  dec(result.Right,VertScrollbar);
 if IsHorzScrollBarVisible then
  dec(result.Bottom,HorzScrollbar);  }
 result:=ScrollArea;
end;
    *)
begin
  //if not HasParent then exit;
  if csDestroying in ComponentState then exit;
  //if csLoading in ComponentState then exit;
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

  //RC.TopLeft:=Point(0,0);
  RC:=MyGetControlExtents(OnlyCalculateVisibility);
  MeasureArea:=Point(Width,Height);
 { RC.Right:=max(RC.Right,RC.Left+1);
  RC.Bottom:=max(RC.Bottom,RC.Top+1);
    }


  AddScrollbarPlace(IsHorzScrollBarVisible,IsVertScrollBarVisible,false,false,MeasureArea,RC);
  {
  IsVertScrollBarVisible:=FVertScrollbarAlwaysVisible and not FVertScrollbarNeverVisible;
  IsHorzScrollBarVisible:=FHorzScrollbarAlwaysVisible and not FHorzScrollbarNeverVisible;

  if IsHorzScrollBarVisible then Dec(MeasureArea.Y,HorzScrollbar);
  if IsVertScrollBarVisible then Dec(MeasureArea.X,VertScrollbar);
  if not IsHorzScrollBarVisible and not FHorzScrollbarNeverVisible and (RC.X>MeasureArea.X) then
  begin
   IsHorzScrollBarVisible:=true;
   Dec(MeasureArea.Y,HorzScrollbar);
  end;
  if not IsVertScrollBarVisible and not FVertScrollbarNeverVisible and (RC.Y>MeasureArea.Y) then
  begin
   IsVertScrollBarVisible:=true;
   Dec(MeasureArea.X,VertScrollbar);
   if not IsHorzScrollBarVisible and not FHorzScrollbarNeverVisible and (RC.X>MeasureArea.X) then
   begin
    IsHorzScrollBarVisible:=true;
    Dec(MeasureArea.Y,HorzScrollbar);
   end;
  end;    }

       {
  if not IsHorzScrollBarVisible and not FHorzScrollbarNeverVisible and DoIntersectStrong(RC,Rect(MeasureArea.Right,0,maxint,maxint)) then
  begin
   IsHorzScrollBarVisible:=true;
   RC.BottomRight:=MyGetControlExtents.BottomRight;
  end;
  if not IsVertScrollBarVisible and not FVertScrollbarNeverVisible and DoIntersectStrong(RC,Rect(0,MeasureArea.Bottom,maxint,maxint)) then
  begin
   IsVertScrollBarVisible:=true;
   RC.BottomRight:=MyGetControlExtents.BottomRight;
   if not IsHorzScrollBarVisible and not FHorzScrollbarNeverVisible and DoIntersectStrong(RC,Rect(MeasureArea.Right,0,maxint,maxint)) then
   begin
    IsHorzScrollBarVisible:=true;
    RC.BottomRight:=MyGetControlExtents.BottomRight;
   end;
  end;       }           
//   BorderChanged;

  if OnlyCalculateVisibility then exit;

  {if not EdgesInScrolledArea then
  with ClientEdgesPure do
   DecPt(RC.BottomRight,Point(Left+Right,Top+Bottom));}
//  RC:=MyGetControlExtents ;

  with ScrollArea do
  begin
    VertScrollInfo.nPage := max(Bottom-Top,0);
    HorzScrollInfo.nPage := max(Right-Left,0);
    VertScrollInfo.nMax := VertScrollInfo.nPage+RC.Y-MeasureArea.Y;
    HorzScrollInfo.nMax := HorzScrollInfo.nPage+RC.X-MeasureArea.X;
   { VertScrollInfo.nMax := RC.Bottom-Top;
    HorzScrollInfo.nMax := RC.Right-Left;  }
  end;


  SetBoundedVHPos(HPos,VPos);

  ScrollPaintChanged((OldIsVertScrollBarVisible=IsVertScrollBarVisible) and (OldIsHorzScrollBarVisible=IsHorzScrollBarVisible)and
                     (OldVertMax=VertScrollInfo.nMax) and (OldHorzMax=HorzScrollInfo.nMax));

  //SetVHPos(HPos,VPos);
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
  //Invalidate;
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
    //ActTopGraph:=TopGraph;
    try
     DrawFrame;
    finally
     //ActTopGraph:=nil;
     EndPainting;
    end;
    AlreadyUpdated:=true;
   end;
   InvalScrollbars;
   InvalTop(not NCScrollbars,AlreadyUpdated);
  end else
  begin
   InvalTop(true,false);
  end;
  if not SameScrollbars then
   BorderChanged;
end;



{$IFNDEF VER160}
procedure TdhCustomPanel_AlignControls2(const nname:string; Self:TdhCustomPanel; AControl: TControl; var Rect: TRect{;  FOriginalParentSize:TPoint});
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
      //!alCustom: Result := CustomAlignInsertBefore(C1, C2);
    end;
  end;

  procedure DoPosition(Control: TControl; AAlign: TAlign{; AlignInfo: TAlignInfo!});

  (*ffunction FAnchorRules:TPoint;
  begin
   with Control do
   begin
    if akRight in Anchors then
      if akLeft in Anchors then
        FAnchorRules.X := Width else
        FAnchorRules.X := Left
    else
      FAnchorRules.X := Left + Width div 2;
    if akBottom in Anchors then
      if akTop in Anchors then
        FAnchorRules.Y := Height else
        FAnchorRules.Y := Top
    else
      FAnchorRules.Y := Top + Height div 2;
   end;
  end;

  unction FOriginalParentSize:TPoint;
  begin
   result:=PPoint(PChar(@TFakeControl(Control).{$IFDEF CLX}HelpContext{$ELSE}ScalingFlags{$ENDIF})-SizeOf(TPoint))^;
  end;

  function FAnchorRules:TPoint;
  begin
   result:=PPoint(PChar(@TFakeControl(Control).{$IFDEF CLX}HelpContext{$ELSE}ScalingFlags{$ENDIF})-SizeOf(TPoint)*2)^;
  end;

  function FAnchorMove:PBoolean;
  begin
{$IFDEF CLX}
   result:=PBoolean(PChar(@TFakeControl(Control).ShowHint)+SizeOf(Boolean));
{$ELSE}
   result:=PBoolean(PChar(@TFakeControl(Control).Anchors)+SizeOf(TAnchors));
{$ENDIF}
  end;
  *)


  var
    NewLeft, NewTop, NewWidth, NewHeight: Integer;
    ParentSize: TPoint;
    mar,R:TRect;
    sLightBoundsChanging:boolean;
//    FOriginalParentSize,FAnchorRules:TPoint;
//    FAnchorMove:boolean;
  begin        
      if (AAlign = alNone) then
      begin
       if Control is TdhCustomPanel then
       begin
        TdhCustomPanel(Control).StrongToWeak;
        //if not TdhCustomPanel(Control).LightBoundsChanging then
        begin
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
       end;
       exit;
      end;
    with Rect do
    begin
      (*if (AAlign = alNone) or (Control.Anchors <> AnchorAlign[AAlign]) then
      begin
        with Control do
          if (FOriginalParentSize.X <> 0) and (FOriginalParentSize.Y <> 0) then
          begin
            NewLeft := Left;
            NewTop := Top;
            NewWidth := Width;
            NewHeight := Height;
            if Parent.HandleAllocated then
{$IFDEF xCLX}
            begin
              if [akRight, akBottom] * Anchors <> [] then
              begin
                R := Parent.ClientRect;
                TFakeWinControl(Parent).AdjustClientRect(R);
                ParentSize := R.BottomRight;
              end
              else
                ParentSize := Parent.ClientRect.BottomRight;
            end
{$ELSE}
              ParentSize := Parent.ClientRect.BottomRight
{$ENDIF}
            else
              ParentSize := Point(Parent.Width, Parent.Height);

            //if not (csLoading in ComponentState) then
            //IncPt(ParentSize,-ParentDeltaX,-ParentDeltaY);

            if akRight in Anchors then
              if akLeft in Anchors then
                // The AnchorRules.X is the original width
                NewWidth := ParentSize.X - (FOriginalParentSize.X - FAnchorRules.X)
              else
                // The AnchorRules.X is the original left
                NewLeft := ParentSize.X - (FOriginalParentSize.X - FAnchorRules.X)
            else if not (akLeft in Anchors) then
              // The AnchorRules.X is the original middle of the control
              NewLeft := MulDiv(FAnchorRules.X, ParentSize.X, FOriginalParentSize.X) -
                NewWidth div 2;
            if akBottom in Anchors then
              if akTop in Anchors then
                // The AnchorRules.Y is the original height
                NewHeight := ParentSize.Y - (FOriginalParentSize.Y - FAnchorRules.Y)
              else
                // The AnchorRules.Y is the original top
                NewTop := ParentSize.Y - (FOriginalParentSize.Y - FAnchorRules.Y)
            else if not (akTop in Anchors) then
              // The AnchorRules.Y is the original middle of the control
              NewTop := MulDiv(FAnchorRules.Y, ParentSize.Y, FOriginalParentSize.Y) -
                NewHeight div 2;

            if Control is TdhCustomPanel and TdhCustomPanel(Control).Center then
            begin
             NewLeft:=Rect.Left+max(0,{Rect.Left + }((Rect.Right - Rect.Left)-Control.Width) div 2);
             NewWidth:=Control.Width;
            end;
             //NewLeft:=max(0,Rect.Left + ((Rect.Right - Rect.Left)-Control.Width) div 2);

            //FAnchorMove^ := True;
            try
              SetBounds(NewLeft, NewTop, NewWidth, NewHeight);
            finally
              //FAnchorMove^ := False;
            end;
          end;
        if AAlign = alNone then Exit;
      end;
      *)

      NewWidth := Right - Left;
      if (NewWidth < 0) or (AAlign in [alLeft, alRight{, alCustom!}]) then
        NewWidth := Control.Width;
      NewHeight := Bottom - Top;
      if (NewHeight < 0) or (AAlign in [alTop, alBottom{, alCustom!}]) then
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
        {
        alCustom:
          begin
            NewLeft := Control.Left;
            NewTop := Control.Top;
            CustomAlignPosition(Control, NewLeft, NewTop, NewWidth, NewHeight, Rect, AlignInfo);
          end;!}
      end;
    end;
    //{Control.}FAnchorMove^ := True;
    try
      Control.SetBounds(NewLeft, NewTop, NewWidth, NewHeight);
    finally
      //{Control.}FAnchorMove^ := False;
    end;
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
    {AlignInfo: TAlignInfo;!}
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
      {AlignInfo.AlignList := AlignList;
      AlignInfo.ControlIndex := I;
      AlignInfo.Align := AAlign;!}
      Control:=TControl(AlignList[I]);
      DoPosition(Control, AAlign{, AlignInfo!});
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

var P:TWinControl;
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
      {DoAlign(alCustom);!}
      DoAlign(alNone);// Move anchored controls
      {ControlsAligned;!}
    finally
      AlignList.Free;
    end;
  end;
  //Self.ChildrenWeakToStrong;
  { Apply any constraints }
  //if Showing then AdjustSize;
  end;
end;

{$ENDIF}


    {
procedure TdhCustomPanel.ChildrenWeakToStrong;
var
  I: Integer;
begin
  for I := ControlCount - 1 downto 0 do
    if Controls[I] is TdhCustomPanel then
      TdhCustomPanel(Controls[I]).WeakToStrong(true);
end;    }

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

{procedure TdhCustomPanel.ChildrenValidateStrong;
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
end;    }


//child.Align in [alTop,alLeft] können eine 2te berechnung notwendig machen
procedure TdhCustomPanel.AlignControls(AControl: TControl; var Rect: TRect);
var //R,OldScrollEdgesPure,NewScrollEdgesPure:TRect;
    //aWidth,aHeight:integer;
    i:integer;
    //P:TWinControl;
    OldIsVertScrollBarVisible,OldIsHorzScrollBarVisible:boolean;
    OldIsVertScrollBarVisible2,OldIsHorzScrollBarVisible2:boolean;
    SRect:TRect;
begin

 if PreventAlignControls then exit;
// if csLoading in ComponentState then exit;

   if FinalShowing then
   begin
    AdjustSize;
    Rect:=GetClientRect;
   end;

   //if csLoading in ComponentState then exit;
   
   if ControlCount=0 then
   begin
    UpdateScrollBars(false);
    exit;
   end;

   OldIsVertScrollBarVisible:=IsVertScrollBarVisible;
   OldIsHorzScrollBarVisible:=IsHorzScrollBarVisible;
   //OldScrollEdgesPure:=ScrollEdgesPure;
                          
   {if csLoading in ComponentState then
   begin
    OldWH:=Point(Width,Height);
   end;  }
   UpdateScrollBars(true);
   {NewScrollEdgesPure:=ScrollEdgesPure;
   if csLoading in ComponentState then
   begin
    OldScrollEdgesPure:=NewScrollEdgesPure;
   end;  }

   //Rect:=GetClientRect; //needed since can be changed by UpdateScrollBars
//   OrderedControls(Self);

   for i:=0 to ControlCount-1 do
   if Controls[i] is TdhCustomPanel then
    TdhCustomPanel(Controls[i]).PrepareAlign;
   SRect:=Rect;
   TdhCustomPanel_AlignControls2(Self.Name,Self,AControl,Rect{,Point(OldWH.X-OldScrollEdgesPure.Right+NewScrollEdgesPure.Right,OldWH.Y-OldScrollEdgesPure.Bottom+NewScrollEdgesPure.Bottom)});


 OldIsVertScrollBarVisible2:=IsVertScrollBarVisible;
 OldIsHorzScrollBarVisible2:=IsHorzScrollBarVisible;
 IsVertScrollBarVisible:=OldIsVertScrollBarVisible;
 IsHorzScrollBarVisible:=OldIsHorzScrollBarVisible;
 UpdateScrollBars(false);
 if (IsVertScrollBarVisible<>OldIsVertScrollBarVisible2) or
    (IsHorzScrollBarVisible<>OldIsHorzScrollBarVisible2) then
 begin
   Rect:=SRect;
   TdhCustomPanel_AlignControls2(Self.Name,Self,AControl,Rect{,Point(OldWH.X-OldScrollEdgesPure.Right+NewScrollEdgesPure.Right,OldWH.Y-OldScrollEdgesPure.Bottom+NewScrollEdgesPure.Bottom)});
   UpdateScrollBars(false);
 end;

   for i:=0 to ControlCount-1 do
   if Controls[i] is TdhCustomPanel then
    TdhCustomPanel(Controls[i]).AlignDone;
 
//   StopOrderedControls(Self);

{   aWidth:=Width;
   aHeight:=Height;
   if AutoSize and CanAutoSize(aWidth,aHeight) and ((aWidth<>Width) or (aHeight<>Height)) then
    SetBounds(Left,Top,AWidth,AHeight);   }

//  if not Showing then AdjustSize; //da AdjustSize in 'inherited' nur wenn 'showing' aufgerufen
end;

procedure TdhCustomPanel.PrepareAlign;
begin

end;

procedure TdhCustomPanel.AlignDone;
begin

end;



(*
procedure TdhCustomPanel.CustomAlignPosition(Control: TControl; var NewLeft, NewTop, NewWidth,
      NewHeight: Integer; var AlignRect: TRect; AlignInfo: TAlignInfo);
begin
 with AlignRect do
 if not(Control is TdhCustomPanel) or (TdhCustomPanel(Control).SaveAlign=alTop) then
 begin
      NewLeft := Left;
      NewTop := Top;
      NewWidth := Right - Left;
      if (Control.Visible or
         (csDesigning in Control.ComponentState) and not (csNoDesignVisible in Control.ControlStyle)) then
       Inc(Top, NewHeight);
 end else
 begin
      NewLeft := Left;
      NewTop := Top;
      NewHeight := Bottom - Top;
      if (Control.Visible or
         (csDesigning in Control.ComponentState) and not (csNoDesignVisible in Control.ControlStyle)) then
       Inc(Left, NewWidth);
 end;
 if Control is TdhCustomPanel then
  PAlign(@Control.Align)^:=TdhCustomPanel(Control).SaveAlign else
  PAlign(@Control.Align)^:=alTop;
end;
*)

{procedure TdhCustomPanel.WMAlignParent(Var Msg: TMessage);
begin
    Parent.DisableAlign;
    try
     if OrderedControls(Parent) then
      Parent.Realign;
     StopOrderedControls(Parent);
    finally
      Parent.EnableAlign;;
    end;
end; }



                   {
procedure TdhCustomPanel.UpdateOver(IsNewOver:boolean; clicked:boolean);
var _glSelCompo:TdhCustomPanel;

begin
 try
  _glSelCompo:=glSelCompo;
  glSelCompo:=nil;
  if isNewOver then
   glSelCompo:=self;
  ///////fill here
  if (_glSelCompo<>nil) then
   _glSelCompo.CheckDesignState;
  CheckDesignState;
 except
 end;
end;            }




function GetCBound(c:TControl):TRect;
begin
 if c.Parent<>nil then
 begin
  if (c is TWinControl) and TWinControl(c).HandleAllocated then
  begin
{$IFDEF CLX}
   //QWidget_geometry(TWinControl(c).Handle,@Result);
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

function GetCBound2(c:TControl):TRect;
begin
 result:=GetCBound(c);
   (*
 if c.Parent<>nil then
 begin    {
  if c is TWinControl then
  begin
   GetWindowRect(TWinControl(c).Handle,Result); //genauer falls Top und Left noch alte Werte haben, beim scrollen zum beispiel
  end else }
  begin
   result:=c.BoundsRect;
   rOffsetRect(result,c.Parent.ClientOrigin);
  end;
 end else
 begin
 result:=c.ClientRect;
 rOffsetRect(result,c.ClientOrigin);
 end;         *)
end;

procedure InvalTrans(C:TControl; R2:TRect; NotChilds:boolean=false);
//var R2:TRect;

procedure AllInval(_Parent:TWinControl);
var i:integer;
    pn:TdhCustomPanel;
begin
 for i:=0 to _Parent.ControlCount-1 do
 if _Parent.Controls[I] is TdhCustomPanel then
 begin
     pn:=TdhCustomPanel(_Parent.Controls[I]);
     if (csDestroying in pn.ComponentState) or not (pn.BackIsValid and FinalVisible(pn)) then continue;
     pn.BackIsValid:=false;
     //pn.TopIsValid:=false;
     pn.Invalidate;
     AllInval(pn);
 end else
 if _Parent.Controls[I] is TWinControl then
  AllInval(TWinControl(_Parent.Controls[I]));
end;




procedure Inval2(Self:TControl; _Parent:TWinControl);
var R:TRect;
    i,SelfZOrder:integer;
    pn:TdhCustomPanel;
begin
    if (csDestroying in _Parent.ComponentState) or (_Parent is TdhCustomPanel) and not TdhCustomPanel(_Parent).TopIsValid and not TdhCustomPanel(_Parent).ValidChildrenInvalidParent then exit;
    SelfZOrder:=0;
    if Self<>nil then
     SelfZOrder:=GetZOrder2(Self);
    for I := 0 to _Parent.ControlCount - 1 do
    if (_Parent.Controls[I] is TdhCustomPanel) then
    begin
     pn:=TdhCustomPanel(_Parent.Controls[I]);
     if (csDestroying in pn.ComponentState) or not (pn.BackIsValid and FinalVisible(pn) and not ((Self<>nil) and (GetZOrder(pn,i)<=SelfZOrder))) then continue;
     R:=GetCBound(pn);
     IntersectRect(R,R,R2);
     if not IsRectEmpty(R) then
     begin
      pn.BackIsValid:=false;
      //pn.TopIsValid:=false;
      pn.Invalidate;
      Inval2(nil,pn);
     end;
    end;
end;


begin


    If (c = Nil) or (c.Owner=nil) or (c.Parent=nil){ or ([csLoading,csDestroying] * C.Owner.ComponentState<>[])!!} then exit;
    if csLoading in c.ComponentState then exit;
    {!!!}//if csDestroying in c.ComponentState then exit;
    //!!!if (c is TWinControl) and not TWinControl(c).HandleAllocated then exit;
    //if c is TCustomForm then exit;

    if not NotChilds and (c is TWinControl) and not (csDestroying in c.ComponentState) then
     AllInval(TWinControl(C));
    if EqualRect(InvRect,R2) then
     R2:=GetCBound2(c);
    //GetWindowRect(C.Handle, R2);
    while (c.Parent<>nil) do
    begin
     Inval2(C,C.Parent);
     c:=c.Parent;
    end;
end;


function GetBitmapSize(bt:TBitmap; var len:integer; var data:pbyte):boolean;
var height,linesize:integer;
begin
 height:=bt.Height;
 result:=height>=2;
 if result then
 begin
  linesize:=(PAnsiChar(bt.ScanLine[0])-PAnsiChar(bt.ScanLine[1]));
  len:=linesize*height;
  data:=bt.ScanLine[height-1];
 end;
end;


//var b:array of byte;
//var b:array of byte=nil;

procedure TdhCustomPanel.InvalTop(WithChilds,ExcludeOneself:boolean);
var oriLen,actLen:integer;
    data:pbyte;
begin
   if not TopIsValid then exit;
   {if GetBitmapSize(pn.TopGraph,oriLen,data) then
   begin
    if oriLen>length(b) then
     setlength(b,oriLen);
    move(data^,b[0],oriLen);
    pn.AssertTop;
    if GetBitmapSize(pn.TopGraph,actLen,data) then
    if (oriLen=actLen) and CompareMem(data,@b[0],oriLen) then
    begin
     pn.AssertTop;
     exit;
    end else
     pn.AssertTop;
   end;   }
   if not ExcludeOneself then
   begin
    TopIsValid:=false;
   end;
   Invalidate;
   //if WithChilds then
   InvalTrans(Self,InvRect,not WithChilds);
end;


procedure TdhCustomPanel.InvalBack(const R2:TRect);
begin
 //if not TdhCustomPanel(Control).BackIsValid then exit;
 BackIsValid:=false;
 if TopIsValid and not((TransparentTop<>nil) and (TransparentTop.Width=Width) and (TransparentTop.Height=Height)) then
 begin
  TopIsValid:=false;
 end;
 if not (csDestroying in ComponentState) then
  Invalidate;
 InvalTrans(Self,R2);
end;

{function HasCommon(Control:TPersistent; var Common:TCommon):boolean;
begin
 if Control is TdhCustomPanel then
 begin
  Common:=TdhCustomPanel(Control).FCommon;
  result:=true;
 end else
  result:=false;
end;  }


procedure TdhCustomPanel.DesignPaintingChanged;           
var State:TState;
begin
 BackIsValid:=false;
 TopIsValid:=false;
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
  //StyleArr[hsNormal]._BaseMargin:=Rect(0,0,0,0);
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
   glUpdateOver(Self,Value,false) else
  if IsDlg then
  begin
   InvalTop(true,false){(true)};
  end;
 end;
end;
                   {
procedure TdhCustomPanel.SetIsDesignerSelected(Value:boolean);
begin
 if FIsDesignerSelected<>Value then
 begin
  FIsDesignerSelected:=Value;
 end;
end;
             }



{procedure TdhAnchor.CMCursorChanged(var Message: TMessage);
var
  P: TPoint;
begin
  if GetCapture = 0 then
  begin
    GetCursorPos(P);
    if FindDragTarget(P, False) = Self then
      Perform(WM_SETCURSOR, Handle, HTCLIENT);
  end;
end;

 }




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

  //FCommon:=TCommon.Create(self,self);
  UsedByList:=TList.Create;
  InlineUsedByList:=TList.Create;
  StyleArr[hsNormal]:=TStyle.Create(Self,hsNormal);
  FDownOverlayOver:=true;

  ParentFont:=false; //for speed
  ParentColor:=false; //for speed
  //DragMode:=dmAutomatic;
  SetBounds(0,0,100,100);
end;



procedure TdhCustomPanel.UpdateNames(InlineUse,NewInlineUse:ICon; PropagateChange:boolean);
begin
end;


procedure TdhCustomPanel.TransferStylesToUse;
var State:TState;
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

//    if ((c.Owner.Control as TdhCustomPanel).FImageType<>bitInherit) xor sub then
//     (Owner.Control as TdhCustomPanel).FImageType:=(s.Owner.Control as TdhCustomPanel).FImageType;

end;

procedure TdhCustomPanel.CopyStyles(fromState,toState:TState);
var UsePn,Pn:TdhCustomPanel;
    State:TState;
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
{ for State:=low(TState) to high(TState) do
 if (StyleArr[State]<>nil) and (Use.GetCommon.StyleArr[State]<>nil) then
  Use.GetCommon.StyleArr[State].CopyFrom(StyleArr[State],false);}
end;

procedure TdhCustomPanel.GetStylesFromElement(Use:ICon);
begin
 CopyFrom(Use,true);
{ for State:=low(TState) to high(TState) do
 if (StyleArr[State]<>nil) and (Use.GetCommon.StyleArr[State]<>nil) then
  StyleArr[State].CopyFrom(Use.GetCommon.StyleArr[State],true);
}
end;

procedure TdhCustomPanel.GetStylesFromUse;
var State:TState;
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

function AbsCopy(const s:string; von,bis:integer):String;
begin
 assert(bis>=von);
 result:=copy(s,von,bis-von);
end;

function AbsCopy(const s:WideString; von,bis:integer):WideString;
begin
 assert(bis>=von);
 result:=Copy(s,von,bis-von);
end;


function CharPos(const S: String; const C: Char; Index: Integer): Integer; overload;
begin
 for Result:=Index to length(s) do
 if S[Result]=C then
  exit;
 result:=0;
end;

function CharPos(const S: WideString; const C: WideChar; Index: Integer): Integer; overload;
begin
 for Result:=Index to length(s) do
 if S[Result]=C then
  exit;
 result:=0;
end;

function CharPosBack(const S: String; const C: Char; Index: Integer): Integer; overload;
begin
 for Result:=Index downto 1 do
 if S[Result]=C then
  exit;
 result:=0;
end;

function CharPosBack(const S: WideString; const C: WideChar; Index: Integer): Integer; overload;
begin
 for Result:=Index downto 1 do
 if S[Result]=C then
  exit;
 result:=0;
end;

function GetFontList(const s:String):TStringList;
var vn,vn2:integer;
    ss:string;
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


function GetNearestFont(const s:string):TFontName;
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


function TdhCustomPanel.FastDestroy:boolean;
//var O:TComponent;
begin
{ O:=Owner;
 while (O<>nil) and (O.Owner<>nil) and not (O.Owner is TApplication) do
  O:=O.Owner;
 result:= (O<>nil) and (csDestroying in O.ComponentState);
}
 result:=false;
end;







destructor TdhCustomPanel.Destroy;
var State:TState;
begin

 InvalBack(InvRect);

 {Free; //nicht FreeAndNil verwenden
 FCommon:=nil;
 }
begin
 if not FastDestroy then
 begin
  TransformUse(nil,true);
  Use:=nil;
 end;
 if FMouseControl=Self then FMouseControl:=nil;
 //if FClickedControl=Control then FClickedControl:=nil;
 if glSelCompo=Self then glSelCompo:=nil;
 if glEventObj=Self then glEventObj:=nil;
 for State:=low(TState) to high(TState) do
  StyleArr[State].Free;
 UsedByList.Free;
 UsedByList:=nil;
 FreeAndNil(InlineUsedByList);//kj
{ Control:=nil;
 Con:=nil;}
end;


 if BackGraph=TopGraph then
  TopGraph:=nil;
 FreeAndNil(BackGraph);
 FreeAndNil(TopGraph);
 FreeAndNil(TransparentTop);
 inherited;
end;

procedure TStyle.pc(PropChoose:TPropChoose);
begin
 pcs(pcChanges[PropChoose]);
end;

procedure TStyle.pcs(WhatChanged:TWhatChanged);
begin
 if Owner<>nil then
  Owner.NotifyCSSChanged(WhatChanged);
end;

procedure TCSSBorder.SetWidth(Value:TCSSCardinal);
begin
 FWidth:=Value;
 if (Value>0) and (FStyle=cbsNone) then
  FStyle:=cbsSolid;
 Owner.pc(pcBorderWidth);
end;

procedure TCSSBorder.SetColor(Value:TCSSColor);
begin
 FColor:=Value;
 Owner.pc(pcBorderColor);
end;

function TCSSBorder.IsStored:boolean;
begin
 result:=(FWidth<>vsrInherit) or (FColor<>colInherit) or (FStyle<>low(TCSSBorderStyle));
end;

function TCSSBorder.IsWidthCleared:boolean;
begin
 result:=FWidth=vsrInherit;
end;




procedure TCSSBorder.SetStyle(Value:TCSSBorderStyle);
begin
 FStyle:=Value;
 Owner.pc(pcBorderStyle);
end;

procedure TCSSBorder.SetAll(Width:Integer;Color:TCSSColor;Style:TCSSBorderStyle);
begin
 FWidth:=Width;
 FColor:=Color;
 FStyle:=Style;
 Owner.pcs(pcChanges[pcBorderWidth]+pcChanges[pcBorderColor]+pcChanges[pcBorderStyle]);
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




Function ApplyDark(Color:TColor; HowMuch:Byte):TColor;
Var r,g,b:Byte;

function GetRValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb);
end;

function GetGValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 8);
end;

function GetBValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 16);
end;
   
function RGB(r, g, b: Byte): DWORD;
begin
  Result := (r or (g shl 8) or (b shl 16));
end;

Begin
	Color:=ColorToRGB(Color);
	r:=GetRValue(Color);
	g:=GetGValue(Color);
	b:=GetBValue(Color);
	if r>HowMuch then r:=r-HowMuch else r:=0;
	if g>HowMuch then g:=g-HowMuch else g:=0;
	if b>HowMuch then b:=b-HowMuch else b:=0;
	result:=RGB(r,g,b);
End;

function In255(i:integer):integer;
begin
 if i>255 then
  result:=255 else
 if i<0 then
  result:=0 else
  result:=i;
end;


Function AddRGB(Color:TColor32; HowMuch:integer):TColor32;
Begin
	result:=Color32(In255(RedComponent(Color)+HowMuch),In255(GreenComponent(Color)+HowMuch),In255(BlueComponent(Color)+HowMuch));
End;


{$IFNDEF DEB}

procedure Exch(var a,b:Integer); overload;
var c:Integer;
begin
 c:=a;
 a:=b;
 b:=c;
end;

{$ENDIF}

function ExchP(a:TPoint):TPoint; overload;
begin
 result.X:=a.Y;
 result.Y:=a.X;
end;

procedure Exch(var a,b:TPoint); overload;
var c:TPoint;
begin
 c:=a;
 a:=b;
 b:=c;
end;

procedure LineSpec(Canvas:TCanvas; P1,P2:TPoint; Width,Length,Gap:Integer; ClosedInterval,Rectangular:boolean);
var i,Dist,Count,Incr:integer;
    Rct:TRect;
    Vertical:boolean;
begin
 Vertical:=P1.X=P2.X;
 if Vertical then
 begin
  P1:=ExchP(P1);
  P2:=ExchP(P2);
 end;
 Dist:=Round(Sqrt(Sqr(P1.X-P2.X)+Sqr(P1.Y-P2.Y)));
 Count:=(Dist-(Length)) div (Length+Gap);
 if (P1.X>P2.X) then
  Exch(P1,P2);
 if Count<>0 then
 for i:=0 to Count do
 if (i<>0) and (i<>Count) or ClosedInterval then
 begin
  if i=0 then //handles case Count=0 in particular
   Incr:=0 else
   Incr:=(Dist-Length)*i div Count;
  Rct:=Rect(P1.X+Incr,P1.Y-Width div 2,P1.X+Incr+Length+1,P1.Y-Width div 2+Width+1);
  if Vertical then
  begin
   Rct.TopLeft:=ExchP(Rct.TopLeft);
   Rct.BottomRight:=ExchP(Rct.BottomRight);
  end;
  if Rectangular then
   Canvas.Rectangle(Rct) else
   Canvas.Ellipse  (Rct);
 end;
end;

{
procedure LineSpec(Canvas:TCanvas; P1,P2:TPoint; Width:Integer; ClosedInterval,Rectangular,Horizontal:boolean);
var i,dist,count,m,plusX,plusY:integer;
    P:TPoint;
begin
 dist:=Round(Sqrt(Sqr(P1.X-P2.X)+Sqr(P1.Y-P2.Y)));
 plusY:=0;
 plusX:=0;
 gap:=Width;
 if Rectangular then
 begin
  m:=3;
  gap:=Width;
  if Horizontal then
   plusX:=Width else
   plusY:=Width;
 end else
  m:=2;
 count:=dist div (Width * m) * m;
 for i:=0 to count do
 if i mod m=0 then
 if (i<>0) and (i<>count) or ClosedInterval then
 begin
  P.X:=P1.X+(P2.X-P1.X) * i * (P2.X-P1.X) div (P2.X-P1.X) div count;
  P.Y:=P1.Y+(P2.Y-P1.Y) * i div count;
  if Rectangular then
   Canvas.Rectangle(P.X-Width div 2,P.Y-Width div 2,P.X-Width div 2+Width+1+plusX,P.Y-Width div 2+Width+1+plusY) else
   Canvas.Ellipse  (P.X-Width div 2,P.Y-Width div 2,P.X-Width div 2+Width+1+plusX,P.Y-Width div 2+Width+1+plusY);
 end;
end;
}




procedure TStyle.SetPadding(Align:TEdgeAlign; Value:TCSSCardinal=vsrInherit);
begin
 FPaddings[Align]:=Value;
 pc(pcPadding);
end;





function TStyle.BaseBorderColors:string;  
var PreferDown:boolean;
begin
{ if OwnState=hsNormal then
  result:=EmptyStr else
  result:=Owner.StyleArr[NextStyleOld[Owner.DownOverlayOver,OwnState]].FBorderColors;
} case OwnState of
  hsNormal: result:=EmptyStr;
  hsOver,hsDown: result:=Owner.StyleArr[hsNormal].FBorderColors;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    result:=Owner.StyleArr[NextStyle[PreferDown]].FBorderColors;
    if result=EmptyStr then
     result:=Owner.StyleArr[NextStyle[not PreferDown]].FBorderColors;
    if result=EmptyStr then
     result:=Owner.StyleArr[hsNormal].FBorderColors;
   end;
  end;
end;

function TStyle.BaseWH:TPoint;
var PreferDown:boolean;
begin
{
 if OwnState=hsNormal then
  result:=Point(Owner.Control.Width,Owner.Control.Height) else
  result:=Owner.StyleArr[NextStyleOld[Owner.DownOverlayOver,OwnState]]._ContentWidthHeight; }
 case OwnState of
  hsNormal: result:=Point(Owner.Width,Owner.Height);
  hsOver,hsDown: result:=Owner.StyleArr[hsNormal]._ContentWidthHeight;
  hsOverDown:
  begin
   PreferDown:=Owner.GetPreferDownStyles;
   if Owner.StyleArr[NextStyle[PreferDown]].IsWidthStored then
    result.X:=Owner.StyleArr[NextStyle[PreferDown]]._ContentWidthHeight.X else
    result.X:=Owner.StyleArr[NextStyle[not PreferDown]]._ContentWidthHeight.X;
   if Owner.StyleArr[NextStyle[PreferDown]].IsHeightStored then
    result.Y:=Owner.StyleArr[NextStyle[PreferDown]]._ContentWidthHeight.Y else
    result.Y:=Owner.StyleArr[NextStyle[not PreferDown]]._ContentWidthHeight.Y;
  end;
 end;
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


function TStyle.BasePadding(IgnoreCSS:TRasterType):TRect;
var PreferDown:boolean;
var sStyleArr:TStyleArray;
begin
 {if OwnState=hsNormal then
  result:=Owner.PaddingPure else
  result:=Owner.StyleArr[NextStyle[Owner.DownOverlayOver,OwnState]]._BasePadding;   }
 case OwnState of
  hsNormal: ;
  hsOver,hsDown:
  if Owner.StyleArr[hsNormal].IsNewPaddingStored then
  begin
   result:=Owner.StyleArr[hsNormal]._BasePadding;
   exit;
  end;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    if Owner.StyleArr[NextStyle[PreferDown]].IsNewPaddingStored then
    begin
     result:=Owner.StyleArr[NextStyle[PreferDown]]._BasePadding;
     exit;
    end else
    if Owner.StyleArr[NextStyle[not PreferDown]].IsNewPaddingStored then
    begin
     result:=Owner.StyleArr[NextStyle[not PreferDown]]._BasePadding;
     exit;
    end else
    if Owner.StyleArr[hsNormal].IsNewPaddingStored then
    begin
     result:=Owner.StyleArr[hsNormal]._BasePadding;
     exit;
    end;
   end;
  end;

  if EnableIgnoreCSS and (IgnoreCSS=rsFull) then
  begin
   Owner.LockDefinedCSS(sStyleArr);
   result:=Owner.PaddingPure;
   Owner.UnlockDefinedCSS(sStyleArr);
  end else
   result:=Owner.PaddingPure
end;

function TStyle.BaseMargin(IgnoreCSS:TRasterType):TRect;
var PreferDown:boolean;
var sStyleArr:TStyleArray;
begin
 {if OwnState=hsNormal then
  result:=Owner.MarginPure else
  result:=Owner.StyleArr[NextStyle[Owner.DownOverlayOver,OwnState]]._BaseMargin;   }
 case OwnState of
  hsNormal: ;
  hsOver,hsDown:
  if Owner.StyleArr[hsNormal].IsNewMarginStored then
  begin
   result:=Owner.StyleArr[hsNormal]._BaseMargin;
   exit;
  end;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    if Owner.StyleArr[NextStyle[PreferDown]].IsNewMarginStored then
    begin
     result:=Owner.StyleArr[NextStyle[PreferDown]]._BaseMargin;
     exit;
    end else
    if Owner.StyleArr[NextStyle[not PreferDown]].IsNewMarginStored then
    begin
     result:=Owner.StyleArr[NextStyle[not PreferDown]]._BaseMargin;
     exit;
    end else
    if Owner.StyleArr[hsNormal].IsNewMarginStored then
    begin
     result:=Owner.StyleArr[hsNormal]._BaseMargin;
     exit;
    end;
   end;
  end;

  if EnableIgnoreCSS and (IgnoreCSS=rsFull) then
  begin
   Owner.LockDefinedCSS(sStyleArr);
   result:=Owner.MarginPure;
   Owner.UnlockDefinedCSS(sStyleArr);
  end else
   result:=Owner.MarginPure;
end;

function TStyle.BaseBorder(IgnoreCSS:TRasterType):TRect;
var PreferDown:boolean;
var sStyleArr:TStyleArray;
begin
 {if OwnState=hsNormal then
  result:=Owner.BorderPure else
  result:=Owner.StyleArr[NextStyle[Owner.DownOverlayOver,OwnState]]._BaseBorder;   }
 case OwnState of
  hsNormal: ;
  hsOver,hsDown:
  if Owner.StyleArr[hsNormal].IsNewBorderStored then
  begin
   result:=Owner.StyleArr[hsNormal]._BaseBorder;
   exit;
  end;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    if Owner.StyleArr[NextStyle[PreferDown]].IsNewBorderStored then
    begin
     result:=Owner.StyleArr[NextStyle[PreferDown]]._BaseBorder;
     exit;
    end else
    if Owner.StyleArr[NextStyle[not PreferDown]].IsNewBorderStored then
    begin
     result:=Owner.StyleArr[NextStyle[not PreferDown]]._BaseBorder;
     exit;
    end else
    if Owner.StyleArr[hsNormal].IsNewBorderStored then
    begin
     result:=Owner.StyleArr[hsNormal]._BaseBorder;
     exit;
    end;
   end;
  end;

  if EnableIgnoreCSS and (IgnoreCSS=rsFull) then
  begin
   Owner.LockDefinedCSS(sStyleArr);
   result:=Owner.BorderPure;
   Owner.UnlockDefinedCSS(sStyleArr);
  end else
   result:=Owner.BorderPure;
end;

function TStyle.BaseRasteringFile:string;
var PreferDown:boolean;
begin
 case OwnState of
  hsNormal: result:=EmptyStr;
  hsOver,hsDown: result:=Owner.StyleArr[hsNormal].RasteringFile;
  hsOverDown:
   begin
    PreferDown:=Owner.GetPreferDownStyles;
    result:=Owner.StyleArr[NextStyle[PreferDown]].RasteringFile;
    if result=Owner.StyleArr[hsNormal].RasteringFile then
     result:=Owner.StyleArr[NextStyle[not PreferDown]].RasteringFile;
   end;
  end;
 //result:=Owner.StyleArr[NextStyle[Owner.DownOverlayOver,OwnState]].RasteringFile;
end;



function TStyle.CopyBlurEffectsByInherited:boolean;
var P:TPoint;
    tt:TTransformations;
    OldEnabled:boolean;
begin
   OldEnabled:=Effects.Enabled;
   Effects.Enabled:=false;
   try
    result:=false;
    if Owner.HasTransformations(tt) then
    begin
     Effects.InnerShadow.Assign(tt.InnerShadow);
     Effects.OuterShadow.Assign(tt.OuterShadow);
     Effects.InnerGlow.Assign(tt.InnerGlow);
     Effects.OuterGlow.Assign(tt.OuterGlow);
     Effects.Blur.Assign(tt.Blur);
     result:=true;
    end;
   finally
    Effects.Enabled:=OldEnabled;
   end;
end;

function TStyle.HasInheritedTransformations(var tt: TTransformations):boolean;
var OldEnabled:boolean;
begin
   OldEnabled:=Effects.Enabled;
   Effects.Enabled:=false;
   try
    result:=Owner.HasTransformations(tt);
   finally
    Effects.Enabled:=OldEnabled;
   end;
end;


                        {
function TCommon.GetClientTopLeft:TPoint;
begin
  Result:=(Control as TdhCustomPanel).ScrollArea.TopLeft;
end;


function TCommon.GetClientBottomRight:TPoint;
var rct:TRect;
begin
  //rct:=BorderClientRect;
  rct:=(Control as TdhCustomPanel).ScrollArea;
  Result.Y:=Control.Height-rct.Bottom;
  Result.X:=Control.Width-rct.Right;
end;            }


//siehe ScrollArea
function TdhCustomPanel.GetClientAdjusting:TRect;
begin                  
 result:=ScrollArea_Edges;
 //result:=ClientEdgesPure;
{ result:=ScrollAreaWithScrollbars;
 Result.Right:=Width-Result.Right;
 Result.Bottom:=Height-Result.Bottom;}
end;



(*
function TStyle.GetClientMeasure(Index:integer):TCSSInteger;
var rct,rct2:TRect;
begin
 Owner.PreferStyle:=Self;
 try
  Result:=0;
  if (Index=2) or (Index=3) then
  begin
  rct2:=Owner.PaddingClientRect;
  case Index of
  2:   Result:=rct2.Bottom-rct2.Top;
  3:   Result:=rct2.Right-rct2.Left;
  else Assert(false);
  end;
  end else
  begin
{  if true or Owner.IsAbsolutePositioned  then
  begin
}
  rct:=Owner.BorderClientRect;
  case Index of
  0:   Result:=rct.Left;
  1:   Result:=rct.Top;
  4:   Result:=Owner.Height-rct.Bottom;
  5:   Result:=Owner.Width-rct.Right;
  else Assert(false);
  end;
{  end else
  if Self=Owner.FStyle then
  begin
  case Index of
  0:   Result:=Owner.Left;
  1:   Result:=Owner.Top;
  4:   Result:=Owner.Parent.Height-(Owner.Top+Owner.Height);
  5:   Result:=Owner.Parent.Width-(Owner.Left+Owner.Width);
  else Assert(false);
  end;
  if not Owner.Visible then
  case Index of
  4:   inc(Result,Owner.Height);
  5:   inc(Result,Owner.Width);
  end;

  result:=-result;
  if Owner.Parent is TdhCustomPanel then
   inc(result,TdhCustomPanel(Owner.Parent).FStyle.GetClientMeasure(Index));
  end;
}
 end;
 finally
  Owner.PreferStyle:=nil;
 end;
end;
*)


function ColorToIdent(Color: Longint; var Ident: string): Boolean;
begin
  Result := IntToIdent(Color, Ident, TrueColors);
end;

function IdentToColor(const Ident: string; var Color: Longint): Boolean;
begin
  Result := IdentToInt(Ident, Color, Colors);
end;


function ColorToIntString(Color: TCSSColor): string;
var Col:TColor32;
    salpha:String;
    SaveSeparator:Char;
begin
  Col:=CSSColorToColor32(Color);
  if IsOpaqueColor(Color) then
   Result:='#'+inttohex(RedComponent(Col),2)+inttohex(GreenComponent(Col),2)+inttohex(BlueComponent(Col),2) else
  begin
   SaveSeparator := DecimalSeparator;
   DecimalSeparator := '.';
   try
    salpha:=FloatToStrF(AlphaComponent(Col)/255,ffFixed,10,3);
   finally
    DecimalSeparator := SaveSeparator;
   end;
   Result:='rgba('+inttostr(RedComponent(Col))+','+inttostr(GreenComponent(Col))+','+inttostr(BlueComponent(Col))+','+salpha+')';
  end;
end;

function ColorToString(Color: TCSSColor): string;
begin
  if not dhPanel.ColorToIdent(Color, Result) then
   Result:=ColorToIntString(Color);
end;

function ColorToString(Color: Longint): string;
begin
  if not dhPanel.ColorToIdent(Color, Result) then
   Result:=ColorToIntString(Color);
end;

function CursorToString(Cursor: TCSSCursor): string;
begin
  Result:=GetEnumName( TypeInfo( TCSSCursor ), Integer(Cursor));
end;


function GetHyphens(const s:string; from:integer):string;
var i:integer;
begin
 result:=copy(s,from,maxint);
 for i:=length(result) downto 1 do
 if result[i] in ['A'..'Z'] then
 begin
  result[i]:=chr(ord(result[i])+ord('a')-ord('A'));
  if i<>1 then
   insert('-',result,i);
 end;
// result:=lowercase(result);
end;

function GetCSSPropName(PropChoose:TPropChoose):string;
begin
 result:=GetHyphens(GetEnumName( TypeInfo(TPropChoose), Integer(PropChoose)),3)
end;


function WithPX(const s:string):string;
begin
 if (s<>EmptyStr) and (s[length(s)] in ['0'..'9']) then
  result:=s+'px' else
  result:=s;
end;

function GetCSSPropValue(PropChoose:TPropChoose):string;

function GetCSSName(TypeInfo: PTypeInfo; var Value): string;
begin
 result:=GetHyphens(GetEnumName( TypeInfo, Byte(Value)));
end;

function GetCSSSetProp(TypeInfo: PTypeInfo; var S): string;
var
  I: Integer;
begin
  result:=EmptyStr;
  TypeInfo:=GetTypeData(TypeInfo).CompType{$IFNDEF VER160}^{$ENDIF};
  for I := 0 to SizeOf(Byte) * 8 - 1 do
//    if I in S then
    if (1 shl I) and Byte(S)<> 0 then
    begin
      if Length(Result) <> 1 then Result := Result + ' ';
      Result := Result + GetHyphens(GetEnumName(TypeInfo, I),4);
    end;
end;

function _if(b:boolean; s1,s2:string):string; overload;
begin
 if b then
  result:=s1 else
  result:=s2;
end;

           (*

function GetCSSSetProp(TypeInfo: PTypeInfo): string;
var
  S: Integer;
  I: Integer;
  ss:TIntegerSet;
begin
  S :=Value.Width and 255;
  TypeInfo:=GetTypeData(TypeInfo).CompType{$IFNDEF VER160}^{$ENDIF};
  for I := 0 to SizeOf(Integer) * 8 - 1 do
    if (1 shl I) and S <> 0 then
    begin
      if Length(Result) <> 1 then Result := Result + ' ';
      Result := Result + GetHyphens(GetEnumName(TypeInfo, I),4);
    end;
end;          *)

begin

 case PropChoose of
 pcAntiAliasing:
  result:='(yes)';
 pcEffects:
  result:='(defined)';
 pcBackgroundImage{,pcImage,pcEdgeImage,pcStretchImage}:
 if Cascaded.Picture.HasPath then
  result:='('+Cascaded.Picture.GetAbsolutePath+')'{+_if(Cascaded.Picture.PictureID.ReferenceCount>0,'['+inttostr(Cascaded.Picture.PictureID.ReferenceCount)+' occurences]',EmptyStr)} else
  result:='('+UpperCase(Copy(Cascaded.Picture.GraphicExtension,2,maxint))+' image)'{+_if(Cascaded.Picture.PictureID.ReferenceCount>0,'['+inttostr(Cascaded.Picture.PictureID.ReferenceCount)+' occurences]',EmptyStr)};
  //result:='('+Cascaded.Picture.Graphic.ClassName+')';
 pcBorderColor,pcBackgroundColor,pcColor:
  result:=dhPanel.ColorToIntString(Cascaded.Color);
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

function FilledTo(const s:string; x:integer):string;
begin
 result:=s+StringOfChar(' ',x-length(s));
end;

                     (*
function TStyle.GetStyleText:TStringList;
var PropChoose:TPropChoose;
    CSSProp:TCSSProp;
    al:TAlign;
    s:string;
begin
 result:=TStringList.Create;
 for PropChoose:=Low(TPropChoose) to High(TPropChoose) do
 if not (PropChoose in [pcBorderColor,pcBorderWidth,pcBorderStyle{,pcMargin,pcPadding}]) then
 begin
 if GetStyleVal(PropChoose,CSSProp,alNone) then
 begin
  s:=PropNames[PropChoose];
  s:=s+':'+GetVisual(PropChoose,CSSProp);
  result.Add(s);
 end;
 end;
end;
                       *)


function TStyle.IsBorderColorsStored:boolean;
var Align:TEdgeAlign;
    NeedCompact,NeedColor:boolean;
    BorderColors:array[TEdgeAlign] of string;
begin
 NeedColor:=false;
 for Align:=ealTop to ealRight do
 if not NeedColor and not Owner.HasVal(pcBorderColor,Align) then
 if Owner.GetSpecialBorderType in [sbtEdit,sbtButton] then
  NeedColor:=not (Owner.BorderStyle(Align) in [cbsGroove,cbsRidge,cbsInset,cbsOutSet]) else
  {NeedColor:=Color32(Owner.FontColor)<>clBlack32};

 if NeedColor then
 for Align:=ealTop to ealRight do
 begin
  BorderColors[Align]:=dhPanel.ColorToIntString(Owner.BorderColor(Align));
 end;
 FBorderColors:=GetShorter(BorderColors[ealTop],BorderColors[ealRight],BorderColors[ealBottom],BorderColors[ealLeft]);
 if (FBorderColors<>EmptyStr) and (FBorderColors=BaseBorderColors) then
  FBorderColors:=EmptyStr;
 result:=(FBorderColors<>EmptyStr){ and (FBorderColors<>BaseBorderColors)};
end;




function TdhCustomPanel.IsInUseList(ob:TObject):boolean;
begin
 if ob is TStyle then
  ob:=TStyle(ob).Owner;
 result:=(ob is TdhCustomPanel) and InUseList(Self,ob as TdhCustomPanel);
end;

function TdhCustomPanel.IsDefinedOuter(ob:TObject):boolean;
begin
 result:=(ob is TStyle) and (GetParentForm(TStyle(ob).Owner)<>GetParentForm(Self));
end;


function GetBorderRadiusString(al:TEdgeAlign):string;
const sBorderCorner:array[TEdgeAlign] of string=(EmptyStr,'-top-left','-bottom-right','-bottom-left','-top-right');
begin
 result:='border'+sBorderCorner[al]+'-radius';
end;

function GetBorderRadiusStringMoz(al:TEdgeAlign):string;
const sBorderCorner:array[TEdgeAlign] of string=(EmptyStr,'-TopLeft','-BottomRight','-BottomLeft','-TopRight');
begin
 result:='-Moz-Border-Radius'+sBorderCorner[al];
end;




function TStyle.GetInfo:string;
var PropChoose:TPropChoose;
    al:TEdgeAlign;
    s:string;
    sl:TStringList;
    ob:TObject;
    i:integer;
 sl_byself:TStringList;
 sl_byselfuse:TStringList;
 sl_byparent:TStringList;
 sl_byouter:TStringList;

begin
 sl:=TStringList.Create;
 Owner.SetPreferStyle(Self,true,true);
 try
 for PropChoose:=Low(TPropChoose) to High(TPropChoose) do
 for al:=Low(TEdgeAlign) to High(TEdgeAlign) do
 if (PropChoose in [pcBorderColor,pcBorderWidth,pcBorderStyle,pcMargin,pcPadding,pcBorderRadius])=(al<>ealNone) then
 if Owner.GetVal(PropChoose,al) or (ValStyle<>nil) then
 begin
  s:=GetCSSPropName(PropChoose);
  if al<>ealNone then
  if PropChoose=pcBorderRadius then
   s:=GetBorderRadiusString(al) else
   s:=s+'-'+lowercase(copy(GetEnumName( TypeInfo(TAlign), Integer(al)),3,maxint));
  s:=s+':'+GetCSSPropValue(PropChoose);
  if ValStyle<>nil then
  if ValStyle is TStyle then
   s:=FilledTo(s,30)+'  (by '+TStyle(ValStyle).Owner.GetName+'.'+TStyle(ValStyle).GetNameByStyle+')' else
  if (PropChoose=pcCursor) and (Cascaded.Cursor=ccuInherit) then
   continue else
  if (ValStyle is TControl) and (TControl(ValStyle).Parent=nil) then
   s:=FilledTo(s,30)+'  (by default)' else
   s:=FilledTo(s,30)+'  (by '+ValStyle.GetNamePath+')';
  sl.AddObject(s,ValStyle);
 if PropChoose in [pcBorderColor,pcBorderWidth,pcBorderStyle,pcMargin,pcPadding] then
 begin

 end;
 end;
 finally
  Owner.SetPreferStyle(nil,true,true);
 end;

 sl_byself:=TStringList.Create;
 sl_byselfuse:=TStringList.Create;
 sl_byparent:=TStringList.Create;
 sl_byouter:=TStringList.Create;

 for i:=0 to sl.Count-1 do
 begin
  ob:=sl.Objects[i];
  if (ob is TStyle) and (TStyle(ob).Owner=Owner) then
   sl_byself.Add(sl[i]) else
  //if (ob is TdhCustomPanel) and InUseList(Owner.Con,ob as TdhCustomPanel) then
  if Owner.IsInUseList(ob) then
   sl_byselfuse.Add(sl[i]) else
  if Owner.IsDefinedOuter(ob) then
   sl_byouter.Add(sl[i]) else
   sl_byparent.Add(sl[i]);

 end;

 sl.Clear;
// sl.Add(inttostr(GetZOrder2(Owner.Control)));
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
 if RasteringFile<>'' then
 begin
 sl.Add('Generated image: '+RasteringFile);
 sl.Add(EmptyStr);
 end;

(* sl.Add('Inner width/height:');
 sl.Add('width='+inttostr(GetContentWidthHeight.X));
 sl.Add('height='+inttostr(GetContentWidthHeight.Y));
{ if not Owner.ConstantWidthHeight then
  sl.Add('WARNING: inner width/height is not the same for all styles');}
 sl.Add(EmptyStr);

*)
 Owner.AddOwnInfo(sl);
 Owner.AddInfo(sl);

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


procedure TStyle.SetBackgroundColor(Value:TCSSColor);
begin
 if FBackgroundColor<>Value then
 begin
  FBackgroundColor:=Value;
  pc(pcBackgroundColor);
 end;
end;

procedure TStyle.SetTextAlign(Value:TCSSTextAlign);
begin
 FTextAlign:=Value;
 pc(pcTextAlign);
end;

procedure TStyle.SetWhiteSpace(Value:TCSSWhiteSpace);
begin
 FWhiteSpace:=Value;
 pc(pcWhiteSpace);
end;

procedure TStyle.SetZIndex(Value:TCSSInteger);
begin
 FZIndex:=Value;
 pc(pcZIndex);
end;

procedure TStyle.SetMinWidth(Value:TCSSCardinal);
begin
 FMinWidth:=Value;
 pc(pcMinWidth);
end;

procedure TStyle.SetMinHeight(Value:TCSSCardinal);
begin
 FMinHeight:=Value;
 pc(pcMinHeight);
end;


procedure TStyle.SetTextTransform(Value:TCSSTextTransform);
begin
 FTextTransform:=Value;
 pc(pcTextTransform);
end;

function GetInt(const s:String; var res:integer):boolean;
var E: Integer;
begin
  Val(S, res, E);
  result:=E=0;
end;

(*
function LengthToVar(const s:string):Variant;
var res:integer;
begin
 res:=0;
// if s<>EmptyStr then
//  result:=nil{Unassigned} else
{ if s<>EmptyStr then
  begin
  if GetInt(s,res) then
   showmessage('int:'+s) else
   showmessage('notint:'+s);
  end;   }
 if GetInt(s,res) and (res>=0) {neg. Werte nicht erkannt (byte<>shortint-fehler): -1->255} then
  result:=res else
  result:=s;
end;
*)
{
function TStyle.IsFontSizeStored: boolean;
begin
 result:=FFontSize<>EmptyStr;
end;
}
{
function TStyle.GetFontSize:TCSSFontSize;
begin
 result:=LengthToVar(FFontSize);
end;
}

procedure TStyle.SetFontSize(Value:TCSSFontSize);
begin
 try
  if Value<>EmptyStr then
   GetFontSizePixels(Value,0);
  FFontSize:=Value;
  pc(pcFontSize);
 except
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 end;
end;

            
procedure TCSSBorderRadius.SetBorderRadius(Align:TCornerAlign; Value:string);
var P:TPoint;
begin
 if Vals[Align]<>Value then
 begin
  if (Value<>EmptyStr) and not GetBorderRadiusPixels(Value,P) then
   raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
  Vals[Align]:=Value;
  Changed;
 end;
end;

procedure TStyle.SetMargin(Align:TEdgeAlign; Value:TCSSMargin);
begin
 try
  if Value<>EmptyStr then
   GetMarginPixels(Value,0);
  FMargins[Align]:=Value;
  pc(pcMargin);
 except
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 end;
end;

                   {
function TStyle.ReadMargin(Align:TEdgeAlign):TCSSMargin;
begin
 result:=LengthToVar(FMargins[Align]);
end;                 }


function TStyle.IsMarginCleared(Align:TEdgeAlign):boolean;
begin
 result:=FMargins[Align]=MarginDefault;
end;


procedure TStyle.SetFontFamily(Value:TCSSFontFamily);
begin
 FFontFamily:=Value;
 pc(pcFontFamily);
end;

procedure TStyle.SetColor(Value:TCSSColor);
begin              
 if FColor<>Value then
 begin
  FColor:=Value;
  pc(pcColor);
 end;
end;

procedure TStyle.SetFontStyle(Value:TCSSFontStyle);
begin
 FFontStyle:=Value;
 pc(pcFontStyle);
end;

procedure TStyle.SetFontWeight(Value:TCSSFontWeight);
begin
 FFontWeight:=Value;
 pc(pcFontWeight);
end;

procedure TStyle.SetListStyleType(Value:TCSSListStyleType);
begin
 FListStyleType:=Value;
 pc(pcListStyleType);
end;

procedure TStyle.SetDisplay(Value:TCSSDisplay);
begin
 FDisplay:=Value;
 pc(pcDisplay);
end;

procedure TStyle.SetVisibility(Value:TCSSVisibility);
begin
 FVisibility:=Value;
 pc(pcVisibility);
end;

procedure TStyle.SetTextDecorations(Value:TCSSTextDecorations);
begin
 if (ctdNone in Value) and not(ctdNone in FTextDecoration) or (Value=[ctdNone]) then
  Value:=[ctdNone] else
  Value:=Value-[ctdNone];
 if FTextDecoration<>Value then
 begin
  FTextDecoration:=Value;
  pc(pcTextDecoration);
 end;
end;


procedure TStyle.SetCursor(Value:TCSSCursor);
begin
 FCursor:=Value;
 pc(pcCursor);
end;


procedure SplitBackgroundPixels(Value:TCSSBackgroundPosition; var v1,v2:string);
var r:integer;
begin
 Value:=LowerCase(Trim(Value));
 r:=Pos(' ',Value);
 if r<>0 then
 begin
  v1:=Trim(Copy(Value,1,r-1));
  v2:=Trim(Copy(Value,r+1,maxint));
 end else
 begin
  v1:=Value;
  v2:='center';
 end;
end;



function GetBackgroundPixels(Value:TCSSBackgroundPosition; const rct:TRect; imgWidth,imgHeight:integer; var res:TPoint):boolean;
var r:integer;
    v1,v2:string;
begin
 try
 SplitBackgroundPixels(Value,v1,v2);
 if (v2='left') or (v2='right') or (v1='top') or (v1='bottom') then
  Exch(v1,v2);
 {if v2='top' then
  v2:='left' else
 if v2='bottom' then
  v2:='right'; }
 res:=Point(rct.Left+GetPixVal(v1,rct.Right-rct.Left-imgWidth),rct.Top+GetPixVal(v2,rct.Bottom-rct.Top-imgHeight));
 result:=true;
 except
  result:=false;
 end;
end;



procedure TStyle.SetBackgroundPosition(Value:TCSSBackgroundPosition);
var res:TPoint;
begin
 Value:=Trim(Value);
 if (Value<>EmptyStr) and not GetBackgroundPixels(Value,Rect(0,0,0,0),0,0,res) then
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 FBackgroundPosition:=Value;
 pc(pcBackgroundPosition);
end;



procedure TCSSBorder.Assign(Source: TPersistent);
var b:TCSSBorder;
begin
  if Source is TCSSBorder then
  begin
    b:=TCSSBorder(Source);
    FWidth:=b.Width;
    FColor:=b.Color;
    FStyle:=b.Style;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TCSSBorder.AssignComputed(pn:TdhCustomPanel; Align:TEdgeAlign);
begin
    FWidth:=pn.BorderWidth(Align);
    FColor:=pn.BorderColor(Align);
    FStyle:=pn.BorderStyle(Align);
end;



procedure TStyle.Assign(Source: TPersistent);
var s:TStyle;
    Align:TEdgeAlign;
begin
  if Source is TStyle then
  begin
    s:=TStyle(Source);

    for Align:=low(TEdgeAlign) to high(TEdgeAlign) do
    begin
     FBorders[Align].Assign(s.FBorders[Align]);
     FMargins[Align]:=s.FMargins[Align];
     FPaddings[Align]:=s.FPaddings[Align];
    end;
    FBackgroundImage.Assign(s.FBackgroundImage);
    FBackgroundColor:=s.FBackgroundColor;
    FBackgroundRepeat:=s.FBackgroundRepeat;
    FBackgroundAttachment:=s.FBackgroundAttachment;
    FBackgroundPosition:=s.FBackgroundPosition;
    FOther:=s.FOther;
    FBefore:=s.FBefore;
    FAfter:=s.FAfter;
    FTextAlign:=s.FTextAlign;
    FWhiteSpace:=s.FWhiteSpace;
    FDirection:=s.FDirection;
    FTextTransform:=s.FTextTransform;
    FCursor:=s.FCursor;
    FFontSize:=s.FFontSize;
    FFontFamily:=s.FFontFamily;
    FColor:=s.FColor;
    FFontStyle:=s.FFontStyle;
    FFontWeight:=s.FFontWeight;
    FFontVariant:=s.FFontVariant;
    FTextDecoration:=s.FTextDecoration;
    FZIndex:=s.FZIndex;
    FMinWidth:=s.FMinWidth;
    FMinHeight:=s.FMinHeight;
    FVerticalAlign:=s.FVerticalAlign;
    FLetterSpacing:=s.FLetterSpacing;
    FWordSpacing:=s.FWordSpacing;
    FLineHeight:=s.FLineHeight;
    FDisplay:=s.FDisplay;
    FListStyleType:=s.FListStyleType;
    FTextIndent:=s.FTextIndent;

    //FAntiAliasing:=s.FAntiAliasing;
    FTransformations.Assign(s.FTransformations);
    FBorderRadius.Assign(s.FBorderRadius);

    pcs(AllChanged);
    Exit;
  end;
  inherited Assign(Source);
end;

//sub=false: get style from s if defined by s
//sub=true:  get style from s if not defined by oneself
procedure TStyle.CopyFrom(s:TStyle; sub:boolean);
var Align:TEdgeAlign;
    c:TStyle;
begin

    if sub then
     c:=self else
     c:=s;

    for Align:=High(TEdgeAlign) downto Low(TEdgeAlign){wenn sub=true, dann MUSS ealNone als letztes da abhängig in If-Statements} do
    begin
     if ((c.FBorders[ealNone].FColor<>colInherit) or (c.FBorders[Align].FColor<>colInherit)) xor sub then
      FBorders[Align].FColor:=s.FBorders[Align].FColor;
     if ((c.FBorders[ealNone].FWidth<>vsrInherit) or (c.FBorders[Align].FWidth<>vsrInherit)) xor sub then
      FBorders[Align].FWidth:=s.FBorders[Align].FWidth;
     if ((c.FBorders[ealNone].FStyle<>Low(TCSSBorderStyle)) or (c.FBorders[Align].FStyle<>Low(TCSSBorderStyle))) xor sub then
      FBorders[Align].FStyle:=s.FBorders[Align].FStyle;
     if ((c.FMargins[ealNone]<>EmptyStr) or (c.FMargins[Align]<>EmptyStr)) xor sub then
      FMargins[Align]:=s.FMargins[Align];
     if ((c.FPaddings[ealNone]<>vsrInherit) or (c.FPaddings[Align]<>vsrInherit)) xor sub then
      FPaddings[Align]:=s.FPaddings[Align];
     if ((c.FBorderRadius.Vals[ealNone]<>EmptyStr) or (c.FBorderRadius.Vals[Align]<>EmptyStr)) xor sub then
      FBorderRadius.Vals[Align]:=s.FBorderRadius.Vals[Align];
    end;
    if (c.IsPictureStored) xor sub then FBackgroundImage.Assign(s.FBackgroundImage);
    if (c.FBackgroundAttachment<>Low(TCSSBackgroundAttachment)) xor sub then FBackgroundAttachment:=s.FBackgroundAttachment;
    if (c.FBackgroundColor<>colInherit) xor sub then FBackgroundColor:=s.FBackgroundColor;
    if (c.FBackgroundRepeat<>Low(TCSSBackgroundRepeat)) xor sub then FBackgroundRepeat:=s.FBackgroundRepeat;
    if (c.FBackgroundPosition<>EmptyStr) xor sub then FBackgroundPosition:=s.FBackgroundPosition;
    if (c.FOther<>EmptyStr) xor sub then FOther:=s.FOther;
    if (c.FBefore<>EmptyStr) xor sub then FBefore:=s.FBefore;
    if (c.FAfter<>EmptyStr) xor sub then FAfter:=s.FAfter;
    if (c.FTextAlign<>Low(TCSSTextAlign)) xor sub then FTextAlign:=s.FTextAlign;
    if (c.FWhiteSpace<>Low(TCSSWhiteSpace)) xor sub then FWhiteSpace:=s.FWhiteSpace;
    if (c.FDirection<>Low(TCSSDirection)) xor sub then FDirection:=s.FDirection;
    if (c.FTextTransform<>Low(TCSSTextTransform)) xor sub then FTextTransform:=s.FTextTransform;
    if (c.FCursor<>Low(TCSSCursor)) xor sub then FCursor:=s.FCursor;
    if (c.FFontSize<>EmptyStr) xor sub then FFontSize:=s.FFontSize;
    if (c.FFontFamily<>EmptyStr) xor sub then FFontFamily:=s.FFontFamily;
    if (c.FColor<>colInherit) xor sub then FColor:=s.FColor;
    if (c.FFontStyle<>Low(TCSSFontStyle)) xor sub then FFontStyle:=s.FFontStyle;
    if (c.FFontVariant<>Low(TCSSFontVariant)) xor sub then FFontVariant:=s.FFontVariant;
    if (c.FFontWeight<>Low(TCSSFontWeight)) xor sub then FFontWeight:=s.FFontWeight;
    if (c.FTextDecoration<>[]) xor sub then FTextDecoration:=s.FTextDecoration;
    if (c.FZIndex<>vsrInherit) xor sub then FZIndex:=s.FZIndex;
    if (c.FMinWidth<>vsrInherit) xor sub then FMinWidth:=s.FMinWidth;
    if (c.FMinHeight<>vsrInherit) xor sub then FMinHeight:=s.FMinHeight;
    if (c.FVerticalAlign<>EmptyStr) xor sub then FVerticalAlign:=s.FVerticalAlign;
    if (c.FLetterSpacing<>EmptyStr) xor sub then FLetterSpacing:=s.FLetterSpacing;
    if (c.FWordSpacing<>EmptyStr) xor sub then FWordSpacing:=s.FWordSpacing;
    if (c.FLineHeight<>EmptyStr) xor sub then FLineHeight:=s.FLineHeight;
    if (c.FDisplay<>Low(TCSSDisplay)) xor sub then FDisplay:=s.FDisplay;
    if (c.FVisibility<>Low(TCSSVisibility)) xor sub then FVisibility:=s.FVisibility;
    if (c.FListStyleType<>Low(TCSSListStyleType)) xor sub then FListStyleType:=s.FListStyleType;
    if (c.FTextIndent<>EmptyStr) xor sub then FTextIndent:=s.FTextIndent;

    if (c.FTransformations.Enabled) xor sub then FTransformations.Assign(s.FTransformations);

    //Changed(AllChanged);

end;




procedure TStyle.SetVerticalAlign(Value:TCSSVerticalAlign);
begin
 if (Value<>EmptyStr) and not CanGetVerticalAlignPixels(Value) then
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 FVerticalAlign:=Value;
 pc(pcVerticalAlign);
end;

procedure TStyle.SetLetterSpacing(Value:TCSSLetterSpacing);
begin
 if (Value<>EmptyStr) and not CanGetLetterSpacing(Value) then
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 FLetterSpacing:=Value;
 pc(pcLetterSpacing);
end;

procedure TStyle.SetWordSpacing(Value:TCSSWordSpacing);
begin
 if (Value<>EmptyStr) and not CanGetWordSpacing(Value) then
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 FWordSpacing:=Value;
 pc(pcWordSpacing);
end;

procedure TStyle.SetLineHeight(Value:TCSSLineHeight);
begin
 if (Value<>EmptyStr) and not CanGetLineHeight(Value) then
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 FLineHeight:=Value;
 pc(pcLineHeight);
end;   

procedure TStyle.SetTextIndent(Value:TCSSTextIndent);
begin
 try
  if (Value<>EmptyStr) then
   GetTextIndentPixels(Value,0);
  FTextIndent:=Value;
  pc(pcTextIndent);
 except
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 end;
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


function TStyle.GetBorder(Align: TEdgeAlign): TCSSBorder;
begin
 result:=FBorders[Align];
end;

{function TStyle.GetPadding(Align: TEdgeAlign): TCSSCardinal;
begin
 result:=FPaddings[Align];
end;
 }
function TStyle.IsPaddingCleared(Align: TEdgeAlign): boolean;
begin
 result:=FPaddings[Align]=vsrInherit;
end;

{function TStyle.GetMargin(Align: TEdgeAlign): TCSSCardinal;
var res:integer;
begin
 if (FMargins[Align]<>EmptyStr) then
  result:=GetMarginPixels(FMargins[Align],Owner.ComputedFontSize) else
  result:=vsrInherit;
end;}

function TStyle.GetStyleVal(PropChoose:TPropChoose; const Align:TEdgeAlign):boolean;
var aBorder:TCSSBorder;
    i:integer;
begin
 result:=false;
 if StoredChecking and (Align=ealNone) and (PropChoose in [pcBorderColor,pcBorderWidth,pcBorderStyle,pcMargin,pcPadding]) then
  Result:=GetStyleVal(PropChoose,ealLeft) or GetStyleVal(PropChoose,ealRight) or
          GetStyleVal(PropChoose,ealTop) or GetStyleVal(PropChoose,ealBottom) else
 with Cascaded do
 case PropChoose of  
 pcBorderRadius:
 begin
  Cascaded.BorderRadius:=FBorderRadius.Vals[Align];
  if Cascaded.BorderRadius=EmptyStr then
   Cascaded.BorderRadius:=FBorderRadius.Vals[ealNone];
  Result:=Cascaded.BorderRadius<>EmptyStr;
 end;
 pcBorderColor,pcBorderWidth,pcBorderStyle:
 begin
 aBorder:=FBorders[Align];
 case PropChoose of
 pcBorderColor:
 begin
  if aBorder.Color=colInherit then
   aBorder:=FBorders[ealNone];
  Color:=aBorder.Color;
  Result:=Color<>colInherit;
 end;
 pcBorderWidth:
 begin
  if aBorder.Width=vsrInherit then
   aBorder:=FBorders[ealNone];
  Width:=aBorder.Width;
  Result:=Width<>vsrInherit;
 end;
 pcBorderStyle:
 begin
  if aBorder.Style=cbsInherit then
   aBorder:=FBorders[ealNone];
  BorderStyle:=aBorder.Style;
  Result:=BorderStyle<>cbsInherit;
 end;
 end;
 end;
 pcMargin:
 begin
  Cascaded.Margin:=FMargins[Align];
  if Cascaded.Margin=EmptyStr then
   Cascaded.Margin:=FMargins[ealNone];
  result:=Cascaded.Margin<>EmptyStr;
 end;
 pcPadding:
 begin
  Width:=FPaddings[Align];
  if Width=vsrInherit then
   Width:=FPaddings[ealNone];
  result:=Width<>vsrInherit;
 end;
 pcTransformationsMatrix:
 if not SelfHit then
 if FTransformations.Enabled and (glAT<>nil) then
 begin
  glAT.Skew(FTransformations.SkewX/100,FTransformations.SkewY/100);
  glAT.Scale(FTransformations.ScaleX/100,FTransformations.ScaleY/100);
  glAT.Rotate(0,0,-FTransformations.Rotation);
  glRotate:=glRotate+FTransformations.Rotation;
  glTrans:=glTrans*FTransformations.Alpha/255;
  glATShiftX:=glATShiftX+FTransformations.ShiftX;
  glATShiftY:=glATShiftY+FTransformations.ShiftY;
  SelfHit:=not FTransformations.FUseBased;
 end;
 pcEffects:
 if FTransformations.Enabled then
 begin
  Transformations:=FTransformations;
  Result:=true;
 end;
 pcBackgroundImage:
 if (*(Owner.FImageType in [bitNormal{,bitLayered}]) and *)IsPictureStored then
 begin
  Picture:=FBackgroundImage;
  Result:=true;
 end;
(*
 pcBackgroundImages:
 if bgs<>nil then
 begin
  if (Owner.FImageType in [bitNormal{,bitLayered}]) and IsPictureStored then
   bgs.Add(TBG.Create(Self));
  if FBackgroundPosition<>EmptyStr then
  for i:=bgs.Count-1 downto 0 do
  if TBG(bgs[i]).BackgroundPosition=EmptyStr then
   TBG(bgs[i]).BackgroundPosition:=FBackgroundPosition else
   break;
  if FBackgroundRepeat<>cbrInherit then
  for i:=bgs.Count-1 downto 0 do
  if TBG(bgs[i]).BackgroundRepeat=cbrInherit then
   TBG(bgs[i]).BackgroundRepeat:=FBackgroundRepeat else
   break;
 end;*)
(* pcEdgeImage: result:=false; {
 if (Owner.FImageType in [bitSplit]) and IsPictureStored then
 begin
  Picture:=FPicture;
  Result:=true;
 end;  }*)
(* pcStretchImage:
 if (Owner.FImageType in [bitStretch]) and IsPictureStored then
 begin
  Picture:=FPicture;
  Result:=true;
 end;*)
 {pcImage:
 if (Owner.FImageType in [bitImage]) and (IsPictureStored or NoImageNeeded) then
 begin
  Picture:=FPicture;
  Result:=true;
 end;   }
 pcBackgroundAttachment:
 if FBackgroundAttachment<>low(TCSSBackgroundAttachment) then
 begin
  BackgroundAttachment:= FBackgroundAttachment;
  Result:=true;
 end;
 pcBackgroundRepeat:
 if FBackgroundRepeat<>low(TCSSBackgroundRepeat) then
 begin
  BackgroundRepeat:= FBackgroundRepeat;
  Result:=true;
 end;
 pcOther:
 if FOther<>EmptyStr then
 begin
  Cascaded.Other:=FOther;
  Result:=true;
 end;
 pcContentBefore:
 if FBefore<>EmptyStr then
 begin
  Cascaded.Before:=FBefore;
  Result:=true;
 end;
 pcContentAfter:
 if FAfter<>EmptyStr then
 begin
  Cascaded.After:=FAfter;
  Result:=true;
 end;
 pcBackgroundColor:
 if FBackgroundColor<>colInherit then
 begin
  Color:=FBackgroundColor;
  Result:=true;
 end;
 pcTextAlign:
 if FTextAlign<>low(TCSSTextAlign) then
 begin
  TextAlign:=FTextAlign;
  Result:=true;
 end;
 pcWhiteSpace:
 if FWhiteSpace<>low(TCSSWhiteSpace) then
 begin
  WhiteSpace:=FWhiteSpace;
  Result:=True;
 end;
 pcDirection:
 if FDirection<>low(TCSSDirection) then
 begin
  Direction:=FDirection;
  Result:=True;
 end;
 pcTextTransform:
 if FTextTransform<>low(TCSSTextTransform) then
 begin
  TextTransform:=FTextTransform;
  Result:=True;
 end;
 pcFontStyle:
 if FFontStyle<>low(TCSSFontStyle) then
 begin
  FontStyle:=FFontStyle;
  Result:=True;
 end;
 pcBackgroundPosition:
 if FBackgroundPosition<>EmptyStr then
 begin
  Cascaded.BackgroundPosition:=FBackgroundPosition;
  Result:=True;
 end;
 pcTextIndent:
 if FTextIndent<>EmptyStr then
 begin
  Cascaded.TextIndent:=FTextIndent;
  Result:=True;
 end;
 pcVerticalAlign:
 if FVerticalAlign<>EmptyStr then
 begin
  Cascaded.VerticalAlign:=FVerticalAlign;
  Result:=True;
 end;
 pcLetterSpacing:
 if FLetterSpacing<>EmptyStr then
 begin
  Cascaded.LetterSpacing:=FLetterSpacing;
  Result:=True;
 end;
 pcWordSpacing:
 if FWordSpacing<>EmptyStr then
 begin
  Cascaded.WordSpacing:=FWordSpacing;
  Result:=True;
 end;
 pcLineHeight:
 if FLineHeight<>EmptyStr then
 begin
  Cascaded.LineHeight:=FLineHeight;
  Result:=True;
 end;
 pcFontVariant:
 if FFontVariant<>low(TCSSFontVariant) then
 begin
  FontVariant:=FFontVariant;
  Result:=True;
 end;
 pcFontWeight:
 if FFontWeight<>low(TCSSFontWeight) then
 begin
  FontWeight:=FFontWeight;
  Result:=True;
 end;
 pcDisplay:
 if FDisplay<>low(TCSSDisplay) then
 begin
  Display:=FDisplay;
  Result:=True;
 end;
 pcVisibility:
 if FVisibility<>low(TCSSVisibility) then
 begin
  Visibility:=FVisibility;
  Result:=True;
 end;
 {
 pcListStyleType:
 if FListStyleType<>low(TCSSListStyleType) then
 begin
  ListStyleType:=FListStyleType;
  Result:=True;
 end;      }
 pcListStyleType:
 begin
  if not SelfHit then
  begin
   if FListStyleType<>low(TCSSListStyleType) then
   begin
    if ValStyle=nil then
    begin
     ListStyleType:=FListStyleType;
     if Owner.Name<>'ul' then
      result:=true;
    end else
    begin
     if (Owner.Name='ul') or (Owner.Name='ol') then
     begin
      case ListStyleType of
      clsDisk:   ListStyleType:=clsCircle;
      clsCircle: ListStyleType:=clsSquare;
      clsSquare: {so belassen};
      end;
     end;
    end;
    SelfHit:=true;
    if ValStyle=nil then
     ValStyle:=Self;
   end;
  end;
 end;
 pcTextDecoration:
 begin
  if not SelfHit then
  begin
   if not IsFromParent then
   begin
    TextDecoration:=[];
    TopTextDecoration:=[];
    ParentTextDecoration:=[];
   end;
   if (FTextDecoration<>[]) then
   begin
    if not IsFromParent then
    begin
     TextDecoration:=FTextDecoration;
     TopTextDecoration:=FTextDecoration;
    end else
    begin
     TextDecoration:=TextDecoration+(FTextDecoration-[ctdNone]);
     ParentTextDecoration:=ParentTextDecoration+FTextDecoration;
    end;
    SelfHit:=true;
    if ValStyle=nil then
     ValStyle:=Self;
   end;
  end;
 end;
 pcFontSize:
 if FFontSize<>EmptyStr then
 begin
  Cascaded.FontSize:=FFontSize;
  Result:=True;
 end;
 pcFontFamily:
 if FFontFamily<>EmptyStr then
 begin
  Cascaded.FontFamily:=FFontFamily;
  Result:=True;
 end;
 pcColor:
 if FColor<>colInherit then
 begin
  Color:=FColor;
  Result:=True;
 end;
 pcCursor:
 if FCursor<>ccuInherit then
 begin
//  FontColorIsFromParent:=IsFromParent;
  Cursor:=FCursor;
  Result:=True;
 end;
 pcZIndex:
 if FZIndex<>vsrInherit then
 begin
  CSSInteger:=FZIndex;
  Result:=True;
 end;
 pcMinWidth:
 if FMinWidth<>vsrInherit then
 begin
  Width:=FMinWidth;
  Result:=True;
 end;
 pcMinHeight:
 if FMinHeight<>vsrInherit then
 begin
  Width:=FMinHeight;
  Result:=True;
 end;
 pcAntiAliasing:
 if FTransformations.Enabled then
 begin
  AntiAliasing:=FTransformations.AntiAliasing;
  Result:=true;
 end;
  {
 if FAntiAliasing<>caaInherit then
 begin
  AntiAliasing:=FAntiAliasing;
  Result:=True;
 end;        }
 else
  showmessage('TStyle.GetVal errornoues')
 end;
 if Result then
  ValStyle:=Self;
end;


{
function FindParent(Self:TdhCustomPanel; var Parent:TWinControl):boolean;
begin
 Parent:=Self.Parent;
 while (Parent<>nil) and not (Parent is TdhCustomPanel) do
  Parent:=Parent.Parent;
 Result:=Parent<>nil;
end;}

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

{function TdhCustomPanel.InheritProp(PropChoose:TPropChoose):boolean;
begin
 result:=PropChoose in AutoInherit;
end;
}

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

{function TdhCustomPanel.ShallContentWidthHeightStore:boolean;
begin
 result:=true;
end;
 }




function TdhCustomPanel.GetVal(PropChoose:TPropChoose; const Align:TEdgeAlign=ealNone; CanInherit:boolean=true):boolean;
var P:TWinControl;
    AStyle:TStyle;
    _ActStyle:TState;
    DoExit:boolean;


function _ItGetVal(state:TState):boolean;
begin
 result:=ItGetVal(state,PropChoose,Align);
end;

function _ItGetVal2(state:TState):boolean;
begin
 result:=GetFinal.GetCommon.ItGetVal(state,PropChoose,Align);
end;
                {
function _ItGetVal(state:TState):boolean;
begin
 result:=ItGetVal(state,PropChoose,Value,Align);
 if result then exit;
 if Con.GetFinal<>nil then
  Result:=Con.GetFinal.GetCommon.ItGetVal(state,PropChoose,Value,Align);
end;
               }

begin
 try
 result:=false;
 if (csDestroying in ComponentState) then exit;
 //Value.DoImg:=false;
 if not IsFromParent then
  ValStyle:=nil;
 result:=DoGetVal(PropChoose,Align,DoExit);
 SelfHit:=false;
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
 if CanInherit and {Con.InheritProp(PropChoose)}(PropChoose in AutoInherit) then
 while not Result and (P<>nil) and not (csDestroying in P.ComponentState) do
 begin
 IsFromParent:=true;
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
  pcFontSize: AStyle.FFontSize:=inttostr(Abs(TFakeControl(P).Font.Height));
  pcFontFamily: AStyle.FFontFamily:=TFakeControl(P).Font.Name;
  pcColor: AStyle.FColor:=ColorToCSSColor(TFakeControl(P).Font.Color);
  pcFontStyle: AStyle.FFontStyle:=GetItalicFontStyle[fsItalic in TFakeControl(P).Font.Style];
  pcFontWeight: AStyle.FFontWeight:=GetBoldFontWeight[fsBold in TFakeControl(P).Font.Style];
  pcTextDecoration:
  begin
   AStyle.TextDecoration:=[];
   if fsUnderline in TFakeControl(P).Font.Style then
    Include(AStyle.FTextDecoration,ctdUnderline);
   if fsStrikeOut in TFakeControl(P).Font.Style then
    Include(AStyle.FTextDecoration,ctdLineThrough);
  end;
  end;
  //AStyle.GetFontDifferences(TFakeControl(P).Font);

  Result:=AStyle.GetStyleVal(PropChoose,Align);
  if Result then ValStyle:=P;
  finally
   FreeAndNil(AStyle);
  end;

 end;
 pcCursor:
 begin
  Cascaded.Cursor:=GetCursorBack(P.Cursor);
  ValStyle:=P;
  Result:=Cascaded.Cursor<>ccuInherit;
 end;
 end;
{ if (P is TdhScrollingWinControl) and TdhScrollingWinControl(P).CutParent then
  break;}
 P:=P.Parent;
 end;
 finally
  IsFromParent:=false;
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
 if GetVal(pcBorderRadius,ealTop) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,TopLeft,TopLeftDouble);
 if GetVal(pcBorderRadius,ealRight) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,TopRight,TopRightDouble);
 if GetVal(pcBorderRadius,ealLeft) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,BottomLeft,BottomLeftDouble);
 if GetVal(pcBorderRadius,ealBottom) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,BottomRight,BottomRightDouble);
 result:=(TopLeft.X<>0) or (TopLeft.Y<>0) or (TopRight.X<>0) or (TopRight.Y<>0) or (BottomLeft.X<>0) or (BottomLeft.Y<>0) or (BottomRight.X<>0) or (BottomRight.Y<>0);
end;

function TdhCustomPanel.GetBorderRadius(EdgeAlign:TEdgeAlign):TPoint;
begin
 result:=Point(0,0);
 if GetVal(pcBorderRadius,EdgeAlign) then
  GetBorderRadiusPixels(Cascaded.BorderRadius,result);
end;

//const MapCornerToEdge:array[TCornerAlign] of TEdgeAlign=(ealNone, ealTop, ealBottom, ealLeft, ealRight);

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
var tt:TTransformations;
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
var tt:TTransformations;
begin
 if IsScrollArea and EdgesInScrolledArea then
 begin
  result:=Rect(0,0,0,0);
  exit;
 end;
 result:=MarginPure;
 if not IsNullRect(result) then exit;
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
 result:=not SemiTransparent and {IsNullRect(ClientEdgesPure}{EqualRect(ScrollAreaWithScrollbars,Rect(0,0,Width,Height))}IsNullRect(TransparentEdges) and not IsRasterized and Visibility;
end;



{    function TdhCustomPanel.GetComponentState:TComponentState;
     begin
     result:=ComponentState;
    end;
 }
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
  result:=clBlackCSS{FontColor};
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
 if IsDlg {and (Align in [alLeft,alRight,alBottom])} then
  inc(Result,3);
 if not PreventAdjustMargin then
  AdjustMarginWidth(result,Align);
// if HasVertScroll and
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




procedure TdhCustomPanel.Frame3D(Border:TEdgeAlign; Points: array of TPoint);
var BottomRight:boolean;
    bs:TCSSBorderStyle;
    bc:TColor;
    L,bw:integer;
    P0,P1:TPoint;
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
  {if not ColorDefined and (IsButton or IsEdit) and (bs in [cbsGroove,cbsRidge,cbsInset,cbsOutSet])  then
   bc:=clWhite;  }
  
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
  begin           {
   P0:=Points[0];
   P1:=Points[1];
   ConvexPoint(Points[0],Points[3],1);
   ConvexPoint(Points[1],Points[2],1);
   Canvas.Polygon(Points);
   Points[0]:=P0;
   Points[1]:=P1;
   ConvexPoint(Points[3],Points[0],1);
   ConvexPoint(Points[2],Points[1],1);
   Canvas.Polygon(Points);
   exit;     }
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
   //dec(Points[1].X);
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


 if DisplayBorderWidth(Border)=0 then
 begin        {
 if (csDesigning in ComponentState) and Transparent then
 begin
  Canvas.Brush.Color:=clBtnShadow;
  Canvas.Pen.Style := psDash;
  Canvas.Brush.Style := bsClear;
//  Canvas.MoveTo(Points[0].X,Points[0].Y);
//  Canvas.LineTo(Points[1].X,Points[1].Y);
  rct.TopLeft:=Points[0];
  rct.BottomRight:=Points[1];
  Canvas.Rectangle(rct);
 end;     }
{
 if (csDesigning in ComponentState) and FTransparent then
 begin
  Canvas.Brush.Color:=clBtnShadow;
  Canvas.Pen.Style := psDash;
  Canvas.Brush.Style := bsClear;
  Canvas.Rectangle(ClientRect);
 end;  }
 exit;
 end;

 if not IsOpaqueColor(BorderColor(Border)) then
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
    bitmap.DrawTo(ActTopGraph, 0, 0);
  finally
   bitmap.Free;
  end;
 end else
 begin
  DrawToCanvas(GetCanvas);
 end;
end;



(*

procedure TWinControl_WMNCPaint(P:TWinControl; DC: HDC; EdgeFlags,BorderFlags:integer);
const
  InnerStyles: array[TBevelCut] of Integer = (0, BDR_SUNKENINNER, BDR_RAISEDINNER, 0);
  OuterStyles: array[TBevelCut] of Integer = (0, BDR_SUNKENOUTER, BDR_RAISEDOUTER, 0);
  EdgeStyles: array[TBevelKind] of Integer = (0, 0, BF_SOFT, BF_FLAT);
  Ctl3DStyles: array[Boolean] of Integer = (BF_MONO, 0);
var
  RC, RW, SaveRW: TRect;
  EdgeSize: Integer;
  WinStyle: Longint;
begin
 with TFakeWinControl(P) do
  { Get window DC that is clipped to the non-client area }
  if (BevelKind <> bkNone) or (BorderWidth > 0) then
  begin
    //!DC := GetWindowDC(Handle);
    try
      Windows.GetClientRect(Handle, RC);
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RC, -RW.Left, -RW.Top);
      RW:=RC;

      //!ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);{client area not drawn yet}
      { Draw borders in non-client area }
      SaveRW := RW;
      InflateRect(RC, BorderWidth, BorderWidth);
      RW := RC;
      if BevelKind <> bkNone then
      begin
        EdgeSize := 0;
        if BevelInner <> bvNone then Inc(EdgeSize, BevelWidth);
        if BevelOuter <> bvNone then Inc(EdgeSize, BevelWidth);
        with RW do
        begin
          WinStyle := GetWindowLong(Handle, GWL_STYLE);
          if beLeft in BevelEdges then Dec(Left, EdgeSize);
          if beTop in BevelEdges then Dec(Top, EdgeSize);
          if beRight in BevelEdges then Inc(Right, EdgeSize);
          if (WinStyle and WS_VSCROLL) <> 0 then Inc(Right, GetSystemMetrics(SM_CYVSCROLL));
          if beBottom in BevelEdges then Inc(Bottom, EdgeSize);
          if (WinStyle and WS_HSCROLL) <> 0 then Inc(Bottom, GetSystemMetrics(SM_CXHSCROLL));
        end;
        DrawEdge(DC, RW, {EdgeFlags or} InnerStyles[BevelInner] or OuterStyles[BevelOuter],
          {BorderFlags or }Byte(BevelEdges) or EdgeStyles[BevelKind] or Ctl3DStyles[Ctl3D] or BF_ADJUST);
      end;
      IntersectClipRect(DC, RW.Left, RW.Top, RW.Right, RW.Bottom);
      //!RW := SaveRW;
      { Erase parts not drawn }
      //!OffsetRect(RW, -RW.Left, -RW.Top);
      Windows.FillRect(DC, RW, Brush.Handle);
    finally
      //!ReleaseDC(Handle, DC);
    end;
  end;
//!inherited;
end;
*)
(*

function IsAlone(Self:TdhCustomPanel; var col:TColor; P:TWinControl; R2:TRect):boolean;
var R,R3:TRect;
    i:integer;
    c:TControl;
    IsTop:boolean;
    P1:TPoint;
    lastP:TWinControl;
    Common:TCommon;
begin
 lastP:=nil;
 IsTop:=true;
 while (P<>nil) and P.HandleAllocated do
 begin
  GetWindowRect(P.Handle, R);
  IntersectRect(R3,R,R2);
  R2:=R3;
  {
  if not (P is TScrollingWinControl) and not (P is TdhScrollingWinControl) then
   TFakeWinControl(P).AdjustClientRect(R); geht nicht in Delphi8}
  if not (IntersectRect(R,R,R2) and EqualRect(R,R2)) then
  begin
   result:=false;
   exit;
  end;
  P1:=P.ClientOrigin;
  for I := 0 to P.ControlCount - 1 do
  if {(P.Controls[I] is TWinControl) and }(P.Controls[I]<>Self) and (P.Controls[I]<>lastP) and FinalVisible(P.Controls[I]) then
  begin
   if IsTop and (P.Controls[I] is TWinControl) then continue;
   c:=P.Controls[I];
   //GetWindowRect(c.Handle, R);
   R:=c.BoundsRect;
   OffsetRect(R,P1.X,P1.Y);
   if IntersectRect(R,R,R2) then
   begin
    result:=false;
    exit;
   end;
  end;
  if (P is TCustomForm) or (P is TTabSheet) or (P is TdhScrollingWinControl) then
  begin
   col:=TFakeWinControl(P).Color;
   result:=true;
   exit;
  end;
  if not HasCommon(P,Common) or Common.HasVal(pcBackgroundImage) or Common.HasVal(pcImage) then
  begin
   result:=false;
   exit;
  end;
  col:=Common.BackgroundColor;
  if col<>colTransparent then
  begin
   result:=true;
   exit;
  end;
  IsTop:=false;
  lastP:=P;
  P:=P.Parent;
 end;
 col:=clYellow;
 result:=true;
end;
*)


function GetParentList(c:TControl):TList;
begin
 result:=TList.Create;
 while c<>nil do
 begin
  result.Add(c);
  c:=c.Parent;
 end;
end;


//type TFakeCustomControl=class(TCustomControl);
             {
procedure CopyTop2(src:TCustomControl; dst:TdhCustomPanel; rr:TRect);
var s,d:TRect;
    bt:TBitmap;
begin
 s:=rr;
 d:=rr;
 with src.ClientOrigin do OffsetRect(s,-x,-y);
 with dst.ClientOrigin do OffsetRect(d,-x,-y);
 dst.Canvas.CopyRect(d,TFakeCustomControl(src).Canvas,s);
end;
          }  {
procedure CopyTop3(src:TControl; dst:TdhCustomPanel; rr:TRect);
var s,d:TRect;
    bt:TBitmap;
begin
 s:=rr;
 d:=rr;
 with src.ClientOrigin do OffsetRect(s,-x,-y);
 with dst.ClientOrigin do OffsetRect(d,-x,-y);
 bt:=TBitmap.Create;
 bt.Width:=src.Width;
 bt.Height:=src.Height;
 src.pa
 dst.Canvas.CopyRect(d,TFakeControl(src).Canvas,s);
end;      }


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
  //_Parent.PaintTo(Self.BackGraph.Canvas,-(p1.X-p2.x),-(p1.y-p2.y));

  with _Parent do
  begin

   Self.BackGraph.Canvas.Lock;

  try
  DC:=Self.BackGraph.Canvas.Handle;
  _Parent.ControlState:=_Parent.ControlState+[csPaintCopy];
  SaveIndex := SaveDC(DC);
  //MoveWindowOrg(DC, -(p1.X-p2.x),-(p1.y-p2.y));

  //GetWindowRect(_Parent.Handle, R);
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
    //MoveWindowOrg(DC, -R.Left, -R.Top);
    SetWindowOrgEx(DC,(p1.X-p3.x),(p1.y-p3.y), nil); //! genauer, z.b. bei TPageControl
    IntersectClipRect(DC, cCutR.Left, cCutR.Top, cCutR.Right, cCutR.Bottom);
    SetRect(R, 0, 0, Width, Height);
    DrawEdge(DC, R, EdgeFlags, BorderFlags);
    //MoveWindowOrg(DC, R.Left, R.Top);
    //IntersectClipRect(DC, 0, 0, R.Right - R.Left, R.Bottom - R.Top);
    //IntersectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  end;
  SetWindowOrgEx(DC,(p1.X-p2.x),(p1.y-p2.y), nil); //! genauer, z.b. bei TPageControl
  OffsetRect(cCutR,-(p2.x-p3.x),-(p2.y-p3.y));
  IntersectClipRect(DC, cCutR.Left, cCutR.Top, cCutR.Right, cCutR.Bottom);
  Perform(WM_ERASEBKGND, Longint(DC), 0);
  Perform(WM_PAINT, Longint(DC), 0);
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
     //R:=GetCBound(p);
     //IntersectRect(R,R,CutR);
     //if not IsRectEmpty(R) then
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

procedure CopyTop(src:TWinControl; dst:TdhCustomPanel; srcTopGraph:TMyBitmap32; rr:TRect);
var s,d:TRect;
begin
 s:=rr;
 d:=rr;
 with GetCBound(src).TopLeft do OffsetRect(s,-x,-y);
 with SelfCBound.TopLeft do OffsetRect(d,-x,-y);
 if not srcTopGraph.Empty{wenn src=_parent und _parent.Height=0, bei menu slide z.b.} then
 begin
  dst.BackGraph.Canvas.CopyRect(d,srcTopGraph.Canvas,s); //<-bei CLX: update verspätet
  //GetPNGObjectFromBitmap32(srcTopGraph).savetofile('c:\b1.png');
  //GetPNGObjectFromBitmap32(dst.BackGraph).savetofile('c:\b2.png');
 end;
//  dst.BackGraph.Draw(d,s,srcTopGraph); //<-is not clipped WO GENAU?
end;

var i:integer;
    R,R2:TRect;
    AllWins:boolean;
    ppn:TdhCustomPanel;
    ref_fixed,ref_scrolled,OriCutR:TRect;
    cZOrder:integer;
    c:TControl;
    ObjHolder:TBinList;
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
 //FilledByChildren:=false;

 if not FilledByChildren then
 if (_Parent is TdhCustomPanel) and AllWins then
 begin
  ppn:=TdhCustomPanel(_Parent);
  if ppn.IsScrollArea then
   addheight:=0;
  R:=GetCBound(ppn);
  scrolledInParent:=ppn.IsScrollArea and ppn.ContainsControl(Self);
  if scrolledInParent and not ppn.SomethingIsFixed{nachteilhaft bei HTML-Generierung, wenn über Rand hinaus, sonst ok}(* and (not RectInRect(GetScreenClientBound(ppn),CutR){for Speed: e.g. JPeg drawing extremely slow})*) then
  begin
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
    //wichtig für HTML-Generierung, da dort auch noch nicht sichtbare Elemente Graphiken haben müssen
    PaintParentBGs(Self, ppn, OriCutR, SelfCBound);
    //Self.BackGraph.Clear(Color32(ppn.GetVirtualBGColor));
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
    //with cCutR do Self.BackGraph.FillRect(Left,Top.Right,Bottom,TFakeWinControl(_Parent).Color);
    //hintergrund wo TWinControls standen wird net gezeichnet
    //wird auch von TMemo benötigt, wenn eigene Hintergrundfarbe


{$IFNDEF CLX}
  MyPaintTo(Self,_Parent,CutR,SelfCBound,addheight);
{$ENDIF}

  if not((_parent is TScrollingWinControl) and _parent.ContainsControl(Self)) then
   IntersectRect(CutR,CutR,GetScreenClientBound(_parent));
 end;

//   if not(ppn.IsScrollArea and ppn.ContainsControl(Self) and ppn.SomethingIsFixed) and
//      not((ppn.IsScrollArea and ppn.ContainsControl(Self) and ppn.SomethingIsFixed) then
//    IntersectRect(CutR,CutR,GetClientBound(_parent));


    if Self.NoSiblingsBackground then
     exit;

    glBinList.ClearFast;
    ObjHolder:=TBinList.Create;
    ObjHolder.Capacity:=_Parent.ControlCount;
    with _Parent do
    for I := 0 to ControlCount - 1 do
    begin
     c:=Controls[I];
     if not ((c is TWinControl) and FinalVisible(c) and not (csDestroying in c.ComponentState)) or (_Parent=Self.Parent) and (Self.Align in [alTop,alLeft,alBottom,alRight]) and (Self.Align=c.Align) then continue;
     cZOrder:=GetZOrder(c,i);
     if ({(Controls[I].Parent=Self.Parent)}(SelfZOrder<>-5555) and (cZOrder>=SelfZOrder)) then continue;
     ObjHolder.Insert(glBinList.AddItemGetIndex(@PointerCompare,Pointer(cZOrder)),c);
    end;
    for i:=0 to ObjHolder.Count-1 do
    begin
     c:=ObjHolder[i];
     R:=GetCBound(TWinControl(c));
     {dec(r.Top,4);
     dec(r.Bottom,4); }
     IntersectRect(R,R,CutR{R2});
     if not IsRectEmpty(R) then
      ParentPaintTo(Self, TWinControl(c), false, R,SelfCBound,addheight,-5555);

    end;
    ObjHolder.Free;

end;

function TdhCustomPanel.HasBackgroundImage(var FPicture:TGraphic):boolean;
begin
 result:=GetVal(pcBackgroundImage){ and not CSSProp.AsImage};
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
     (*
function TdhCustomPanel.HasEdgeImage(var FPicture:TPicture):boolean;
var CSSProp:TCSSProp;
begin
 result:=GetVal(pcEdgeImage,CSSProp){ and not CSSProp.AsImage};
 if result then
  FPicture:=CSSProp.Picture;
end;

function TdhCustomPanel.HasStretchImage(var FPicture:TPicture):boolean;
var CSSProp:TCSSProp;
begin
 result:=GetVal(pcStretchImage,CSSProp){ and not CSSProp.AsImage};
 if result then
  FPicture:=CSSProp.Picture;
end;   *)

function TdhCustomPanel.HasTransformations(var tt:TTransformations):boolean;
begin
 result:=EffectsAllowed and GetVal(pcEffects){ and not CSSProp.AsImage};
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
 if result=ifInherit then
  result:=ifSimple;
 {if result=ifSemiPNG then
 for state:=low(TState) to high(TState) do
 begin     
  Con:=Self;
  while (Con<>nil) do
  begin
   if (Con.GetCommon.StyleArr[state]<>nil) and Con.GetCommon.StyleArr[state].Effects.Enabled then
   begin
    OnlyBG:=false;
    result:=ifSimple;
    exit;
   end;
   Con:=Con.GetCommon.Use;
  end;
 end;  }
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

function TdhCustomPanel.GetImageDir:String;
begin
 result:='';
end;

procedure TdhCustomPanel.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited;
  if Child is TdhCustomPanel then
    TdhCustomPanel(Child).NotifyCSSChanged([wcZIndex,wcNoOwnCSS]);
end;
        {

function TdhCustomPanel.HasImage(var FPicture:TPicture):boolean;
var CSSProp:TCSSProp;
begin
 result:=GetVal(pcImage,CSSProp);
 if result then
  FPicture:=CSSProp.Picture;
end;         }

{
function TdhCustomPanel.IsImage:boolean;
var CSSProp:TCSSProp;
begin
 NoImageNeeded:=true;
 try
  result:=GetVal(pcImage,CSSProp);
 finally
  NoImageNeeded:=false;
 end;
end;    }



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


function TdhCustomPanel.GetAffine(inv:boolean):TAffineTransformation;
begin
  glAT:=TAffineTransformation.Create;
  glRotate:=0;
  glTrans:=1;
  glATShiftX:=0;
  glATShiftY:=0;
  GetVal(pcTransformationsMatrix);

//  result.SrcRect:=SrcRect;
  if not inv or true then
  begin
  //result.Translate(Transformations.ShiftX,Transformations.ShiftY);
  end;
//  with Result.GetTransformedBoundsf do result.Translate(-Left,-Top);
  result:=glAT;
  glAT:=nil;
end;


procedure NegRect(var R:TRect);
begin
 R.Left:=-R.Left;
 R.Top:=-R.Top;
 R.Bottom:=-R.Bottom;
 R.Right:=-R.Right;
end;


procedure TdhCustomPanel.AdjustLittle(var W,H:integer; infl:boolean; adj:boolean=true);
var
  SrcR: Integer;
  SrcB: Integer;
  T: TAffineTransformation;
  Sx, Sy, Scale, ScaleX,ScaleY: Single;
  Transformations:TTransformations;
begin


//  NegRect(R);
 { AdjustClientRect(R);
  R:=InflRect(R,AllEdgesPure);  }
//  NegRect(R);     
 if NoRotating then exit;

 if HasTransformations(Transformations) then
 begin

    SrcR := W-1;
    SrcB := H-1;
    T:=GetAffine(not infl);
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
    {R.Right := Round(R.Right/((Right-Left)/R.Right));
    if R.Bottom<>0 then
     R.Bottom:= Round(R.Bottom/((Bottom-Top)/R.Bottom));   }
    end;
 end else
 begin              {
  SrcR := R.Right-R.Left;
  SrcB := R.Bottom-R.Top;
  T:=GetAffine(Transformations,FloatRect(0, 0, SrcR + 1, SrcB + 1),true); }
    with T.GetTransformedBoundsf do
    begin        
    W := Round(T.GetTransformedBoundsf.Right);
    H := Round(T.GetTransformedBoundsf.Bottom);
    W := Round(T.GetTransformedBoundsf.Right);
    H := Round(T.GetTransformedBoundsf.Bottom);


                          {
    R.Right := Round(R.Right*Scale);
    R.Bottom:= Round(R.Bottom*Scale);  }
     {
    R.Right := Round(R.Right*((Right-Left)/R.Right));
    R.Bottom:= Round(R.Bottom*((Bottom-Top)/R.Bottom));   }
    end;
 end;
 T.Free;
 end;

   {
 if infl then
 begin
  AdjustClientRect(R);
  R:=InflRect(R,AllEdgesPure);
 end else
 begin
  NegRect(R);
  AdjustClientRect(R);
  R:=InflRect(R,AllEdgesPure);
  NegRect(R);
 end;   }
end;



function GetBitmap32FromPNGObject(png:TPNGObject):TMyBitmap32;
var P: PColor32;
    bp:pByteArray;
    x,y:integer;
    TransparentColor:TColor;
    sl:pRGBLine;
begin
  result:=TMyBitmap32.Create;
  case png.TransparencyMode of
  ptmPartial:
  begin
   result.SetSize(png.Width,png.Height);
   P:=result.PixelPtr[0,0];
   for Y:=0 to png.Height-1 do
   begin
    bp:=png.AlphaScanline[Y];
    sl:=pRGBLine(png.Scanline[Y]);
    for X:=0 to png.Width-1 do
    begin
     with sl[X] do
      P^:=Color32(rgbtRed,rgbtGreen,rgbtBlue,bp^[X]);
     inc(P);
    end;
   end;
   result.DrawMode:=dmBlend;
  end;
  ptmBit:
  begin
//   result.Assign(png);      
   result.SetSize(png.Width,png.Height);
   TransparentColor:=png.TransparentColor;
   P:=result.PixelPtr[0,0];
   for Y:=0 to png.Height-1 do
   begin
    for X:=0 to png.Width-1 do
    begin
     if png.Pixels[X,Y]=TransparentColor then
      P^:=0 else
      P^:=Color32(png.Pixels[X,Y]){ or $FF000000};
     inc(P);
    end;
   end;
   result.DrawMode:=dmBlend;
  end;
  ptmNone:
  begin
   result.SetSize(png.Width,png.Height);
   P:=result.PixelPtr[0,0];
   for Y:=0 to png.Height-1 do
   begin
    for X:=0 to png.Width-1 do
    begin
     P^:=Color32(png.Pixels[X,Y]){ or $FF000000};
     inc(P);
    end;
   end;
  end;
  end;
end;


function GetPNGObjectFromBitmap32(Src:TBitmap32{; WithTransparency:boolean}):TGraphic;
var y,x,intFormCount:integer;
var P,P2,P3: PColor32;
    bp:pByteArray;
    png:TPNGObject;
begin
  png:=TPNGObject.Create;
  result:=png;
  png.CompressionLevel:=9;
  png.AssignHandle(Src.BitmapHandle,false,0);


{$IFDEF CLX}
   //eigentlich nur von CLX benötigt
   P:=Src.PixelPtr[0,0];
   for Y:=0 to png.Height-1 do
   begin
    for X:=0 to png.Width-1 do
    begin
     png.Pixels[X,Y]:=WinColor(P^);
     inc(P);
    end;
   end;
{$ENDIF}

//  png.Assign(Src);
  if {WithTransparency}Src.DrawMode<>dmOpaque then
  begin
  png.CreateAlpha;
  //GetParentForm(Owner.Control).
  for Y:=0 to result.Height-1 do
  begin
   bp:=png.AlphaScanline[Y];
   P:=Src.PixelPtr[0,Y];
   for X:=0 to result.Width-1 do
   begin
    bp^[X]:=P^ shr 24;
    inc(P);
    //inc(bp);
   end;
  end;
  end;
end;


type TFakeGIFImage=class(TGIFImage);
type TGraphicAccess = class(TGraphic);

function GetBitmap32FromGifImage(gif:TGIFImage):TMyBitmap32;
var P: PColor32;
    bp:pByteArray;
    x,y,i,ForceFrame:integer;
    TransparentColorIndex:BYTE;
    GIFSubImage:TGIFSubImage;
    //col:TColor;
    Source:TGraphic;     
    Canvas: TCanvas;

procedure DrawParts(ForceFrame:integer);
begin
 if (ForceFrame>=0) and ({(ForceFrame=27) or} (gif.Images[ForceFrame].GraphicControlExtension=nil) or (gif.Images[ForceFrame].GraphicControlExtension.Disposal in [dmNone,dmNoDisposal]))  then
 begin
  DrawParts(ForceFrame-1);
  gif.ForceFrame:=ForceFrame;
  TGraphicAccess(Source).Draw(Canvas, MakeRect(0, 0, result.Width, result.Height));
 end;
end;


begin

  result:=TMyBitmap32.Create;

  Source:=gif;
  begin //siehe result.Assign(TGraphic);
      result.SetSize(TGraphic(Source).Width, TGraphic(Source).Height);
      if GIFPaintPerHand then
       result.Clear($00000000) else
       result.Clear($AA000000);
      if result.Empty then Exit;
      //Canvas := TCanvas.Create;
      try
        //Canvas.Handle := result.Handle;
        Canvas:=result.Canvas;  
        if (gif.Images.Count = 1) or // Only one image
          (not (goAnimate in gif.DrawOptions)) then // Don't animate
        begin
         FastPaint:=TFastPaint(result.PixelPtr[0,0]);
         FastPaintWidth:=result.Width;
        end;
        if gif.ForceFrame>=0 then
        begin
         ForceFrame:=gif.ForceFrame;
         DrawParts(gif.ForceFrame-1);
         gif.ForceFrame:=ForceFrame;
        end;

        TGraphicAccess(Source).Draw(Canvas, MakeRect(0, 0, result.Width, result.Height));
        //result.ResetAlpha;
      finally
        //Canvas.Free;
        FastPaint:=nil;
      end;
  end;

  if not GIFPaintPerHand then
  //{can be false negative}if gif.Transparent then
  begin
   P:=result.PixelPtr[0,0];
   for x:=0 to result.Width*result.Height-1 do
   begin
     //when TGIFImage set an pixel, Alpha=0; else it is not changed
     if p^<>$AA000000 then
      P^:=P^ or $FF000000 else
      P^:=0;
     inc(P);
   end;
  end;
  result.DrawMode:=dmBlend;
(*

                    
  result:=TMyBitmap32.Create;
  result.Assign(gif);
  if gif.ForceFrame>=0 then
   GIFSubImage:=gif.Images[gif.ForceFrame] else
  if (TFakeGIFImage(gif).DrawPainter<>nil) and (TFakeGIFImage(gif).DrawPainter.ActiveImage>=0)  then
   GIFSubImage:=gif.Images[TFakeGIFImage(gif).DrawPainter.ActiveImage] else
   GIFSubImage:=gif.Images[0];
  if GIFSubImage.Transparent then
  begin
   TransparentColorIndex:=GIFSubImage.GraphicControlExtension.TransparentColorIndex;
   P:=result.PixelPtr[0,0];
   for Y:=0 to GIFSubImage.Height-1 do
   begin
    bp:=GIFSubImage.Scanline[Y];
    for X:=0 to GIFSubImage.Width-1 do
    begin
     if bp^[X]=TransparentColorIndex then
      P^:=0;
     inc(P);
    end;
   end;
   result.DrawMode:=dmBlend;
  end;
*)
end;
{$IFNDEF CLX}
{$ENDIF}
         {
function GetBitmap32FromBitmap(bt:TBitmap):TMyBitmap32;
var P: PColor32;
    bp:pByteArray;
    x,y:integer;
    TransparentColor:TColor32;
begin
  result:=TMyBitmap32.Create;
  result.Assign(bt);
  if bt.Transparent and ((bt.Width<>0) or (bt.Height<>0)) then
  begin
   bt.
   TransparentColor:=ColorToColor32(bt.TransparentColor);
   P:=result.PixelPtr[0,0];
   for Y:=0 to result.Height*result.Width-1 do
   begin
     if P^=TransparentColor then
      P^:=0;
     inc(P);
   end;
  end;
end;    }

function GetBitmap32FromGraphic(bt:TGraphic):TMyBitmap32;
var P: PColor32;
    bp:pByteArray;
    x,y:integer;
    TransparentColor:TColor32;
begin
  result:=TMyBitmap32.Create;
  result.Assign(bt);
  if bt.Transparent and ((result.Width<>0) or (result.Height<>0)) then
  begin
   TransparentColor:=result.Pixel[0,result.Height-1];
   P:=result.PixelPtr[0,0];
   for Y:=0 to result.Height*result.Width-1 do
   begin
     if P^=TransparentColor then
      P^:=0;
     inc(P);
   end;
   result.DrawMode:=dmBlend;
  end;
end;

function GetGraphicExtension(Graphic:TGraphic):string;
begin
 result:=EmptyStr;
 if Graphic is TPNGObject then
 begin
  result:='.png';
 end else
 if Graphic is TGifImage then
 begin
  result:='.gif';
 end else
{$IFNDEF CLX}
 if Graphic is TJPEGImage then
 begin
  result:='.jpg';
 end else
 if Graphic is TBitmap then
 begin
  result:='.bmp';
 end else
 if Graphic is TIcon then
 begin
  result:='.ico';
 end;                
{$ENDIF}
end;

function GetAs32(Graphic:TGraphic):TMyBitmap32;
begin
 if Graphic is TPNGObject then
 begin
  result:=GetBitmap32FromPNGObject(TPNGObject(Graphic));
 end else
 if Graphic is TGifImage then
 begin
  result:=GetBitmap32FromGifImage(TGifImage(Graphic));
 end else
{$IFNDEF CLX}
 {if Graphic is TBitmap then
 begin
  res:=GetBitmap32FromBitmap(TBitmap(Graphic));
  result:=true;
 end else }
{$ENDIF}
 if Graphic<>nil then
 begin
  result:=GetBitmap32FromGraphic(Graphic);
 end else
 begin
  result:=nil;
 end;
end;

procedure TdhCustomPanel.PaintWhiteBackground(ref_brct:TRect; Src:TMyBitmap32; const brct: TRect);
begin

end;


function integral(rel_pos,abs_pos,W:integer): integer;
begin
 if rel_pos>abs_pos then
  result:=rel_pos-((rel_pos-abs_pos+W-1) div W) * W else
  result:=rel_pos-((rel_pos-abs_pos    ) div W) * W;
end;


procedure GetRepeatings(var BPos:TPoint; var num_across,num_down:integer; W,H:integer; const brct:TRect; RepeatX,RepeatY:boolean);
begin
 if RepeatX then
 begin
  BPos.X:=integral(BPos.X,brct.Left,W);
  num_across := ((brct.Right-BPos.X-1) div W) + 1;
  {BPos.X:=BPos.X-((BPos.X-brct.Left+W-1) div W)*W;
  num_across := ((brct.Right-BPos.X-1) div W) + 1;}
 end else
  num_across:=1;
 if RepeatY then
 begin
  BPos.Y:=integral(BPos.Y,brct.Top,H);
  num_down := ((brct.Bottom-BPos.Y) div H) + 1;
  {BPos.Y:=BPos.Y-((BPos.Y-brct.Top+H-1) div H)*H;
  num_down := ((brct.Bottom-BPos.Y) div H) +1;}
 end else
  num_down:=1;
end;



function Multiply32(Strech32:TMyBitmap32; NewWidth,NewHeight:integer):TMyBitmap32;
var w,h,x,y:integer;
    OldDrawMode:TDrawMode;
begin
 OldDrawMode:=Strech32.DrawMode;
 Strech32.DrawMode:=dmOpaque;
 w:=Strech32.Width;
 h:=Strech32.Height;
 Result:=TMyBitmap32.Create;
 Result.DrawMode:=dmOpaque;
 Result.Width:=NewWidth;
 Result.Height:=NewHeight;
 Strech32.DrawTo(Result);
 x:=w;
 y:=h;
 h:=min(h,Result.Height);
 w:=Result.Width;
 while x<Result.Width do
 begin
  Result.DrawTo(Result,Rect(x,0,2*x,h),Rect(0,0,x,h));
  x:=x*2;
 end;
 while y<Result.Height do
 begin
  Result.DrawTo(Result,Rect(0,y,w,2*y),Rect(0,0,w,y));
  y:=y*2;
 end;
 Strech32.DrawMode:=OldDrawMode;
 Result.DrawMode:=OldDrawMode;
end;

procedure TdhCustomPanel.SpecialBg(const ref_scrolled,ref_fixed:TRect; Src:TMyBitmap32; const brct: TRect; IsFixed:boolean{; OffsetPoint:TPoint});
var
  //bmp:TBitmap;
  num_across, num_down,
  y_coord, x_coord,
  y, x : integer;
  {yoff, xoff:integer;
  p,p1:tpoint;  }
  FPicture:TGraphic;
  FBackgroundRepeat:TCSSBackgroundRepeat;
  BPos:TPoint;
  //MyRgn: HRGN ;
  SaveIndex: Integer;
  x1,x2,y1,y2,i:integer;
  Strech32,Strech32Mult:TMyBitmap32;
  R,R2,ref:TRect;
  Col:TColor32;
  P:PColor32;


procedure cp(const R1,R2:TRect);
begin
   Strech32.DrawTo(Src,R1,R2);
end;



procedure StretchDrawEx(Graphic:TGraphic);
var Strech32:TMyBitmap32;
begin
  Strech32:=GetAs32(Graphic);
  try
  Strech32.StretchFilter:=sfLanczos;
  R:=Rect(0,0,Strech32.Width,Strech32.Height);
  RealDst:=ref;
  Strech32.DrawTo(Src,brct,R);
  RealDst:=Rect(0,0,0,0);
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
 //Canvas:=Con.GetCanvas;


 if IsRectEmpty(brct) then exit;


 //OffsetRect(ref_brct,OffsetPoint.X,OffsetPoint.Y);
 OldPreventGraphicOnChange:=PreventGraphicOnChange;
 PreventGraphicOnChange:=true;
 try
 if not Transparent then
 begin
  {Canvas.Brush.Color := BackgroundColor;
  Canvas.FillRect(rct);}
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
 {if IsFixed then
 begin
  //ref_brct:=brct;
  ref_brct:=Bounds(brct.Left,brct.Top,ref_brct.Right-ref_brct.Left,ref_brct.Bottom-ref_brct.Top);
  OffsetRect(ref_brct,OffsetPoint.X,OffsetPoint.Y);
 end; }



{ bgs:=TList.Create;

 GetVal(pcBackgroundImages,CSSProp);

 if bgs.Count<>0 then
 begin
        }
 {SaveIndex := SaveDC(Canvas.Handle);
 IntersectClipRect(Canvas.Handle, brct.Left,brct.Top,brct.Right,brct.Bottom);
  }

 //for i:=bgs.Count-1 downto 0 do


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
   Strech32.StretchFilter:=sfNearest;//sfLanczos;
   try
   //Strech32.StretchFilter:=sfLanczos;

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

 //if ((Control as TdhCustomPanel).Referer.GetImageType=bitTile) then
 begin

 { if (i-1>=0) and (TBG(bgs[i-1]).Style.Owner.FImageType=bitNormal) then
   continue; }



 { with TBG(bgs[i]) do
  begin
   FPicture:=Style.FPicture;
   FBackgroundRepeat:=BackgroundRepeat;
   if FBackgroundRepeat=cbrInherit then
    FBackgroundRepeat:=cbrRepeat;
   if BackgroundPosition<>EmptyStr then
    GetBackgroundPixels(BackgroundPosition,ref,FPicture.Width,FPicture.Height,BPos);
  end;  }

 FBackgroundRepeat:=BackgroundRepeat;
 BPos:=ref.TopLeft;
 if GetVal(pcBackgroundPosition) then
  GetBackgroundPixels(Cascaded.BackgroundPosition,ref,FPicture.Width,FPicture.Height,BPos);

 {MyRgn := CreateRectRgn(brct.Left,brct.Top,brct.Right,brct.Bottom);
 SelectClipRgn(Canvas.Handle,MyRgn);
   }

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

 {for x := 0 to num_across-1 do
 for y := 0 to num_down-1 do
 begin
  x_coord := (x * Strech32.Width) + BPos.X;
  y_coord := (y * Strech32.Height) + BPos.Y;
  R:=Bounds(x_coord,y_coord,Strech32.Width,Strech32.Height);
  R2:=R;
  IntersectRect(R,R,brct);
  if not IsRectEmpty(R) then
  begin
   R2:=GetOffsetRect(R,-R2.Left,-R2.Top);
   Strech32.DrawTo(Src,R,R2);
  end;
 end; }


 finally
  FreeAndNil(Strech32);
 end;
    {SelectClipRgn(Canvas.Handle,0);
 DeleteObject(MyRgn); }


 //end;

{ for i:=bgs.Count-1 downto 0 do
  TBG(bgs[i]).Free;

 FreeAndNil(bgs);  }

// RestoreDC(Canvas.Handle, SaveIndex);

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

{function TdhCustomPanel.BorderClientRect:TRect;
begin
 result:=ShrinkRect(MarginClientRect,BorderPure);
end;}

function TdhCustomPanel.BorderPure:TRect;
begin                             
{ if Display=cdsNone then
 begin
  result:=Rect(0,0,0,0);
  exit;
 end;
 }
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
{ if Display=cdsNone then
 begin
  result:=Rect(0,0,0,0);
  exit;
 end;}
 result.Left:=PaddingWidth(ealLeft);
 result.Top:=PaddingWidth(ealTop);
 result.Bottom:=PaddingWidth(ealBottom);
 result.Right:=PaddingWidth(ealRight);
end;

function TdhCustomPanel.MarginPure:TRect;
begin
{ if Display=cdsNone then
 begin
  result:=Rect(0,0,0,0);
  exit;
 end;}
 result.Left:=MarginWidth(ealLeft);
 result.Top:=MarginWidth(ealTop);
 result.Bottom:=MarginWidth(ealBottom);
 result.Right:=MarginWidth(ealRight);
end;


(*
procedure TdhCustomPanel.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  SaveIndex: Integer;
  _DC: HDC;
begin
  if not FDoubleBuffered or (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
    begin
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  _DC:=Message.DC;
  Message.DC:=DC;
  try
          SaveIndex := SaveDC(DC);
          IntersectClipRect(DC, 0, 0, Width, Height-20);
      PaintHandler(Message);
          RestoreDC(DC, SaveIndex);
  finally
  Message.DC:=_DC;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
    end;
  end
  else inherited;
end;
*)

procedure TdhCustomPanel.SpecialPaintBorder(const rct,brct: TRect);
begin
  if BorderStyle(ealLeft)<cbsSolid then
   Frame3D(ealLeft,[Point(rct.Left,rct.Bottom),rct.TopLeft,brct.TopLeft,Point(brct.Left,brct.Bottom)]);
  if BorderStyle(ealRight)<cbsSolid then
   Frame3D(ealRight,[Point(rct.Right, rct.Top),rct.BottomRight,brct.BottomRight,Point(brct.Right,brct.Top)]);
  if BorderStyle(ealBottom)<cbsSolid then
   Frame3D(ealBottom,[rct.BottomRight,Point(rct.Left,rct.Bottom),Point(brct.Left,brct.Bottom),brct.BottomRight]);
  if BorderStyle(ealTop)<cbsSolid then
   Frame3D(ealTop,[rct.TopLeft,Point(rct.Right,rct.Top),Point(brct.Right,brct.Top), Point(brct.Left,brct.Top)]);
  if BorderStyle(ealLeft)>=cbsSolid then
   Frame3D(ealLeft,[Point(rct.Left,rct.Bottom),rct.TopLeft,brct.TopLeft,Point(brct.Left,brct.Bottom)]);
  if BorderStyle(ealRight)>=cbsSolid then
   Frame3D(ealRight,[Point(rct.Right, rct.Top),rct.BottomRight,brct.BottomRight,Point(brct.Right,brct.Top)]);
  if BorderStyle(ealBottom)>=cbsSolid then
   Frame3D(ealBottom,[rct.BottomRight,Point(rct.Left,rct.Bottom),Point(brct.Left,brct.Bottom),brct.BottomRight]);
  if BorderStyle(ealTop)>=cbsSolid then
   Frame3D(ealTop,[rct.TopLeft,Point(rct.Right,rct.Top),Point(brct.Right,brct.Top), Point(brct.Left,brct.Top)]);
end;


procedure TdhCustomPanel.PaintBorder;
//var rct,brct: TRect;
var tt:TTransformations;
begin
  {rct:=MarginClientRect;
  brct:=BorderClientRect;}
  if {(csDesigning in ComponentState)}not RuntimeMode and (csDesigning in ComponentState) and {EqualRect(brct,rct)}IsNullRect(BorderPure) and not Opaque then
  if {not IsEffects(OnlyBG)}not IsRasterized then
//  if EqualRect(brct,rct) and not HasTransformations(tt) and not IsScrollArea then
//  if (csDesigning in ComponentState) and Transparent then
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

function Between(i,_min,_max:integer):integer;
begin
 result:=min(max(i,_min),_max);
end;


function GetEqArea(bmp:TMyBitmap32;TryX,TryY:integer):TRect;
var x,y,w,h:integer;
    bbase,base,compareTo:PColor32;
    Eq:boolean;
begin
 result.Left:={bmp.Width div 2}Between(TryX,0,bmp.Width-1);
 result.Top:={bmp.Height div 2}Between(TryY,0,bmp.Height-1);
 result.Right:=result.Left;
 result.Bottom:=result.Top;

 //compare horizontal lines
 bbase:=bmp.PixelPtr[0,result.Top];
 compareTo:=bmp.PixelPtr[0,result.Bottom+1];
 w:=bmp.Width;
 h:=bmp.Height;

 for y:=result.Bottom+1 to h-1 do
 begin
  base:=bbase;
  Eq:=true;
  for x:=0 to w-1 do
  begin
   if base^<>compareTo^ then
   begin
    Eq:=false;
    break;
   end;
   inc(base);
   inc(compareTo);
  end;
  if Eq then
  begin
   inc(result.Bottom);
  end;
 end;

 for y:=result.Top-1 downto 0 do
 begin
  compareTo:=bmp.PixelPtr[0,result.Top-1];
  base:=bbase;
  Eq:=true;
  for x:=0 to w-1 do
  begin
   if base^<>compareTo^ then
   begin
    Eq:=false;
    break;
   end;
   inc(base);
   inc(compareTo);
  end;
  if Eq then
  begin
   dec(result.Top);
  end;
 end;


 //compare vertical lines
 bbase:=bmp.PixelPtr[result.Left,0];
 compareTo:=bmp.PixelPtr[result.Right+1,0];

 for x:=result.Right+1 to w-1 do
 begin                                
  compareTo:=bmp.PixelPtr[result.Right+1,0];
  base:=bbase;
  Eq:=true;
  for y:=0 to h-1 do
  begin
   if base^<>compareTo^ then
   begin
    Eq:=false;
    break;
   end;
   inc(base,w);
   inc(compareTo,w);
  end;
  if Eq then
  begin
   inc(result.Right);
  end;
 end;

 for x:=result.Left-1 downto 0 do
 begin
  compareTo:=bmp.PixelPtr[result.Left-1,0];
  base:=bbase;
  Eq:=true;
  for y:=0 to h-1 do
  begin
   if base^<>compareTo^ then
   begin
    Eq:=false;
    break;
   end;
   inc(base,w);
   inc(compareTo,w);
  end;
  if Eq then
  begin
   dec(result.Left);
  end;
 end;

 inc(result.Right);
 inc(result.Bottom);

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

function ToFloatRect(Rect:TRect):TFloatRect;
begin
 result:=FloatRect(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
end;

procedure ExtractTransparency(P,P2:PColor32; Size:integer);
var i:integer;
begin
 for i:=0 to Size-1 do
 begin
  P2^:=P^ shr 24;
  inc(P);
  inc(P2);
 end;
end;

const bias = $00800080;

procedure _BlendMemEx(F: TColor32; var B: TColor32; M: TColor32);
asm
  // EAX <- F
  // [EDX] <- B
  // ECX <- M

  // Check Fa > 0 ?
        TEST    EAX,$FF000000   // Fa = 0? => write nothing
        JZ      @2

        PUSH    EBX

  // Get weight W = Fa * M
        MOV     EBX,EAX         // EBX  <-  Fa Fr Fg Fb
        INC     ECX             // 255:256 range bias
        SHR     EBX,24          // EBX  <-  00 00 00 Fa
        IMUL    ECX,EBX         // ECX  <-  00 00  W **
        SHR     ECX,8           // ECX  <-  00 00 00  W
        JZ      @1              // W = 0 ?  => write nothing
        INC ECX

        PUSH    ESI

  // P = W * F
        MOV     EBX,EAX         // EBX  <-  ** Fr Fg Fb
        AND     EAX,$00FF00FF   // EAX  <-  00 Fr 00 Fb
        AND     EBX,$0000FF00   // EBX  <-  00 00 Fg 00
        IMUL    EAX,ECX         // EAX  <-  Pr ** Pb **
        SHR     EBX,8           // EBX  <-  00 00 00 Fg
        IMUL    EBX,ECX         // EBX  <-  00 00 Pg **
        ADD     EAX,bias
        AND     EAX,$FF00FF00   // EAX  <-  Pr 00 Pb 00
        SHR     EAX,8           // EAX  <-  00 Pr ** Pb
        ADD     EBX,bias
        AND     EBX,$0000FF00   // EBX  <-  00 00 Pg 00
        OR      EAX,EBX         // EAX  <-  00 Pr Pg Pb

  // W = 1 - W; Q = W * B
        MOV     ESI,[EDX]
        DEC ECX//
        XOR     ECX,$000000FF   // ECX  <-  1 - ECX
        //INC ECX//
        MOV     EBX,ESI         // EBX  <-  00 Br Bg Bb
        AND     ESI,$00FF00FF   // ESI  <-  00 Br 00 Bb
        AND     EBX,$0000FF00   // EBX  <-  00 00 Bg 00
        IMUL    ESI,ECX         // ESI  <-  Qr ** Qb **
        SHR     EBX,8           // EBX  <-  00 00 00 Bg
        IMUL    EBX,ECX         // EBX  <-  00 00 Qg **
        ADD     ESI,bias
        AND     ESI,$FF00FF00   // ESI  <-  Qr 00 Qb 00
        SHR     ESI,8           // ESI  <-  00 Qr ** Qb
        ADD     EBX,bias
        AND     EBX,$0000FF00   // EBX  <-  00 00 Qg 00
        OR      EBX,ESI         // EBX  <-  00 Qr Qg Qb

  // Z = P + Q (assuming no overflow at each byte)
        ADD     EAX,EBX         // EAX  <-  00 Zr Zg Zb

        MOV     [EDX],EAX
        POP     ESI

@1:     POP     EBX
@2:     RET
end;


function GetBlendMemEx(F: TColor32; B: TColor32; M: TColor32):TColor32;
begin
 BlendMemEx(F,B,M);
 result:=B;
end;


function ColorNegMult(C1, C2: TColor32; M:TColor32=255): TColor32;
var
  r1, g1, b1: DWORD;
  r2, g2, b2, r,g,b: DWORD;
begin
  M := M * (C1 shr 24);
  
  r1 := C1 and $00FF0000 shr 16;
  g1 := C1 and $0000FF00 shr 8;
  b1 := C1 and $000000FF;

  r2 := C2 and $00FF0000 shr 16;
  g2 := C2 and $0000FF00 shr 8;
  b2 := C2 and $000000FF;

  r:=M * r1 * (255 - r2) shr 24 + r2;
  g:=M * g1 * (255 - g2) shr 24 + g2;
  b:=M * b1 * (255 - b2) shr 24 + b2;

  Result := r shl 16 + g shl 8 + b;
end;
                         

function ColorMult(C1, C2: TColor32; M:TColor32=255): TColor32;
var
  r1, g1, b1: DWORD;
  r2, g2, b2, r,g,b: DWORD;
begin
  M := M * (C1 shr 24);

  r1 := C1 and $00FF0000 shr 16;
  g1 := C1 and $0000FF00 shr 8;
  b1 := C1 and $000000FF;

  r2 := C2 and $00FF0000 shr 16;
  g2 := C2 and $0000FF00 shr 8;
  b2 := C2 and $000000FF;

  r:=M * (r1 * r2 - r2 shl 8) shr 24 + r2;
  g:=M * (g1 * g2 - g2 shl 8) shr 24 + g2;
  b:=M * (b1 * b2 - b2 shl 8) shr 24 + b2;

  Result := r shl 16 + g shl 8 + b;
end;


procedure zerl(comp_black,comp_white:dword; var red_alpha:dword);
begin
 //red_alpha:= 255*comp_black / (255 + comp_black - comp_white);
 red_alpha:= 255 + comp_black - comp_white;
end;


function GetOriginalRGB(Black:TColor32; alpha:DWORD):TColor32;
begin
      if alpha=0 then //is color completely transparent?
      begin
       result:=0; //if yes, we dont need (and cant) calc rgb values
      end else
      begin
       //otherwise reconstruct rgb values;
       result:=(((Black and $0000FF)*255 div alpha) and $0000FF) or
               (((Black and $00FF00)*255 div alpha) and $00FF00) or
               (((Black and $FF0000)*255 div alpha) and $FF0000) or
               (alpha shl 24);
      end;
end;

//Note that the real alpha value is "alpha/255/255", but this is no integer
//"alpha/255/255/255" would be the value between 0 and 1
function GetOriginalRGB2(Black:TColor32; alpha:DWORD):TColor32;
var r,g,b,ai:DWORD;
    f:single;
const augm=255;
begin
      if alpha=0 then //is color completely transparent?
      begin
       result:=0; //if yes, we dont need (and cant) calc rgb values
      end else
      begin
       //otherwise reconstruct rgb values;
       ai:=((augm+1) shl 16) div alpha;
       r:=dword((Black and $FF)*ai) shr 8;
       g:=dword((Black shr 8 and $FF)*ai) shr 8;
       b:=dword((Black shr 16 and $FF)*ai) shr 8;

        {
       r:=dword((Black and $FF)*256*augm) div alpha;
       g:=dword((Black shr 8 and $FF)*256*augm) div alpha;
       b:=dword((Black shr 16 and $FF)*256*augm) div alpha;     }
       {if r>=255 then
        r:=255;
       if g>=255 then
        g:=255;
       if b>=255 then
        b:=255; }
       result:=(r and $0000FF) or (g shl 8 and $00FF00) or (b shl 16 and $FF0000) or ((alpha{ div augm} shr 8) shl 24  and $FF000000);
      end;
end;

//Note that the real alpha value is "alpha/255/255", but this is no integer
//"alpha/255/255/255" would be the value between 0 and 1
function GetOriginalRGB3(Black:TColor32; alpha:DWORD):TColor32;
var r,g,b,ai:DWORD;
    f:single;
const augm=255;
begin
      if alpha=0 then //is color completely transparent?
      begin
       result:=0; //if yes, we dont need (and cant) calc rgb values
      end else
      begin
       //otherwise reconstruct rgb values;
       r:=dword((Black and $FF)*256*augm) div alpha;
       g:=dword((Black shr 8 and $FF)*256*augm) div alpha;
       b:=dword((Black shr 16 and $FF)*256*augm) div alpha;
       {if r>=255 then
        r:=255;
       if g>=255 then
        g:=255;
       if b>=255 then
        b:=255; }
       result:=(r and $0000FF) or (g shl 8 and $00FF00) or (b shl 16 and $FF0000) or ((alpha div augm) shl 24  and $FF000000);
      end;
end;

function ExtractAlphaColor2(Black,White:TColor32):TColor32;
var red_alpha,green_alpha,blue_alpha,all_alpha,alpha,r,g,b:dword;
    result2:TColor32;
    nBlack,nWhite:TColor32;
begin
       all_alpha:=(Black and $FFFFFF) - (White and $FFFFFF) + $FFFFFF;
       assert((Black and $FF) - (White and $FF) + $FF<=255);

       //alpha:=((all_alpha and $0000FF) + ((all_alpha and $00FF00) shr 8) + ((all_alpha and $FF0000) shr 16) +2{2, to have a ceil- and not a floor-divide}) *85{div 3}{= *255 div 3};
       //result:=GetOriginalRGB2(Black,alpha);
       red_alpha:=all_alpha and $FF;
       green_alpha:=all_alpha shr 8 and $FF;
       blue_alpha:=all_alpha shr 16 and $FF;

       if red_alpha<green_alpha then
        red_alpha:=green_alpha;
       if red_alpha<blue_alpha then
        red_alpha:=blue_alpha;
       blue_alpha:=red_alpha;
       green_alpha:=red_alpha;



       if (red_alpha=0) or (green_alpha=0) or (blue_alpha=0) then
       begin
        result:=0;
       end else
       begin
        alpha:=(red_alpha+green_alpha+blue_alpha) div 3;
        r:=(Black and $FF)*255 div red_alpha;
        g:=(Black shr 8 and $FF)*255 div green_alpha;
        b:=(Black shr 16 and $FF)*255 div blue_alpha;
        result:=r or (g shl 8) or (b shl 16) or (alpha shl 24{= *255 div 3});
       end;
end;


function ExtractAlphaColor(Black,White:TColor32):TColor32;
var alpha:dword;
    red_alpha,green_alpha,blue_alpha:integer;
    r,g,b:dword;
    //result2:TColor32;
    //nBlack,nWhite:TColor32;
    //nBlack2,nWhite2:TColor32;
begin
       //alpha:=((all_alpha and $0000FF) + ((all_alpha and $00FF00) shr 8) + ((all_alpha and $FF0000) shr 16) +2{2, to have a ceil- and not a floor-divide}) *85{div 3}{= *255 div 3};
       //result:=GetOriginalRGB2(Black,alpha);

       red_alpha:=$FF + (Black and $FF) - (White and $FF);
       green_alpha:=$FF + (Black shr 8 and $FF) - (White shr 8 and $FF);
       blue_alpha:=$FF + (Black shr 16 and $FF) - (White shr 16 and $FF);
       if not(red_alpha<=255) or not(green_alpha<=255) or not(blue_alpha<=255) then
       begin
        result:=Black;
        exit;
       end;

       {all_alpha:=$FFFFFF + (Black and $FFFFFF) - (White and $FFFFFF); //funzt nur gut, wenn wirklich black<=white ist, was aber bei ungenauem Blur nicht garantiert werden kann

       if not($FF + (Black and $FF) - (White and $FF)<=255) then
       begin
        result:=Black;
        exit;
       end;
       if not($FF + (Black shr 8 and $FF) - (White shr 8 and $FF)<=255) then
       begin
        result:=Black;
        exit;
       end;
       if not($FF + (Black shr 16 and $FF) - (White shr 16 and $FF)<=255) then
       begin
        result:=Black;
        exit;
       end;
       assert(($FF + (Black and $FF) - (White and $FF)<=255));


       red_alpha:=all_alpha and $FF;
       green_alpha:=all_alpha shr 8 and $FF;
       blue_alpha:=all_alpha shr 16 and $FF;}



      { if red_alpha<green_alpha then
        red_alpha:=green_alpha;
       if red_alpha<blue_alpha then
        red_alpha:=blue_alpha;
       blue_alpha:=red_alpha;
       green_alpha:=red_alpha;

              }
       if (red_alpha=0) or (green_alpha=0) or (blue_alpha=0) then
       begin
        result:=0;
       end else
       begin
        alpha:=(red_alpha+green_alpha+blue_alpha) div 3;
        r:=(Black and $FF)*255 div dword(red_alpha);
        g:=(Black shr 8 and $FF)*255 div dword(green_alpha);
        b:=(Black shr 16 and $FF)*255 div dword(blue_alpha);
        result:=r or (g shl 8) or (b shl 16) or (alpha shl 24);
       end;
              {
       nBlack:=GetBlendMemEx(result,$FF000000,256);
       nWhite:=GetBlendMemEx(result,$FFFFFFFF,256);
       result2:=ExtractAlphaColor2(Black,White);;
       nBlack2:=GetBlendMemEx(result2,$FF000000,256);
       nWhite2:=GetBlendMemEx(result2,$FFFFFFFF,256);
       if (Black<>nBlack) or (White<>nWhite) then
       if (Black<>nBlack) or (White<>nWhite) then
       if (Black<>nBlack2) or (White<>nWhite2) then
       if (result<>result2) or true then
        ExtractAlphaColor(Black,White);

       if black=43245 then
        showmessage(inttohex(black,8));
                        }

      //now, "Result" drawn onto white/black background gives "White"/"Black" again
      //note: if you paint several partly-transparent layers over another, you
      //      CANT reconstruct one single argb layer which has the same effect
      //      as painting those many layers. It will always be an approximation,
      //      only on white and black background pixels it should be the same


(*
      zerl(RedComponent(Black),RedComponent(White),red_alpha);
      zerl(GreenComponent(Black),GreenComponent(White),green_alpha);
      zerl(BlueComponent(Black),BlueComponent(White),blue_alpha);
      alpha:=(red_alpha+green_alpha+blue_alpha +2) div 3;
      if (red_alpha=0) or (green_alpha=0) or (blue_alpha=0) or (alpha=0) then
      begin
       result2:=0;
       if alpha<>0 then
        result2:=0;
      end else
      begin       {
      if (red_alpha<>green_alpha) or (green_alpha<>blue_alpha) then
      begin
      alpha:=(red_alpha+green_alpha+blue_alpha)/3;
      end;              }

      result2:=Color32((dword(RedComponent(Black))*255 div red_alpha),
                  (dword(GreenComponent(Black))*255 div green_alpha),
                  (dword(BlueComponent(Black))*255 div blue_alpha),
                  (alpha));
      end;
      //result:=result2;

      if result2<>result then
      if result2<>result then
      begin
       ExtractAlphaColor(Black,White);
      end;      *)
      //result:=result2;

end;

{function GetBetterDraw(F: TColor32; B: TColor32; M: TColor32):TColor32;
begin

 result:=ExtractAlphaColor(GetBlendMemEx(F,GetBlendMemEx(B,$000000,$FF),M),GetBlendMemEx(F,GetBlendMemEx(B,$FFFFFF,$FF),M));

end;
 }

function GetPixelCombineNormal(F: TColor32; B: TColor32; M: TColor32=255):TColor32;
begin
  result:=CombineReg(F or $FF000000,B,F shr 24 * (M+1) shr 8);
end;

procedure TdhCustomPanel.PixelCombineUnderpaint(F: TColor32; var B: TColor32; M: TColor32);
var B1,B2,B3:TColor32;
    alpha,alpha2:DWORD;
var r1,r2,g1,g2,bb1,bb2,a1,a2,r,g,bb,a,x,y:integer;
begin
 B:=GetPixelCombineNormal(B,{(F and $FFFFFF) or (M shl 24)}F,$FF);
end;

procedure TdhCustomPanel.PixelCombineInner(F: TColor32; var B: TColor32; M: TColor32);
var B1,B2,B3:TColor32;
    alpha,alpha2:DWORD;
var r1,r2,g1,g2,bb1,bb2,a1,a2,r,g,bb,a,x,y:integer;
begin
// F:=F and $FFFFFF or ($FF-(F shr 24)) shl 24;
// B:=GetPixelCombineNormal(F and $FFFFFF or max(0,F shr 24-($FF-(B shr 24))) shl 24,B or $FF000000,F shr 24) and $FFFFFF or (B and $FF000000);
 B:=GetPixelCombineNormal(F and $FFFFFF or max(0,round((F shr 24 - ($FF-B shr 24)*eigen))) shl 24,B or $FF000000,$FF) and $FFFFFF or (B and $FF000000);
// B:=GetPixelCombineNormal(B and $FFFFFF or $FF000000,(F and $FFFFFF) or ((F shr 24)*(B shr 24) shr 8) shl 24,$FF-(F shr 24));
end;

procedure TdhCustomPanel.PixelCombineNormal(F: TColor32; var B: TColor32; M: TColor32);
var B1,B2,B3:TColor32;
    alpha,alpha2:DWORD;

var r1,r2,g1,g2,bb1,bb2,a1,a2,r,g,bb,a,x,y:integer;
begin

 {if W=$FF then
 begin
  result:=X;
  exit;
 end else
 if W=0 then
 begin
  result:=Y;
  exit;
 end;  }
{ x:=f;
 y:=b;


 a1:=X shr 24*(W+1);
 a2:=Y shr 24*(255-W+1);
 r1:=X shr 16 and $FF;
 r2:=Y shr 16 and $FF;
 g1:=X shr 8 and $FF;
 g2:=Y shr 8 and $FF;
 b1:=X and $FF;
 b2:=Y and $FF;

 r:=(r1*a1+r2*a2) shr 16;
 g:=(g1*a1+g2*a2) shr 16;
 b:=(b1*a1+b2*a2) shr 16;
 alpha:=(a1+a2);
 assert(alpha<=256*256-1);
 assert(r<=255);
 assert(g<=255);
 assert(b<=255);
 B2:=r shl 16 or g shl 8 or b;

 //result:=B2 and $FFFFFF or (alpha shr 8 shl 24);
 B:=GetOriginalRGB2(B2,alpha);
 exit;
 }
 {
 if (F<>0) and (F shr 24<>255) then
  b:=$0 else
  b:=$0;     }
 //B1:=ExtractAlphaColor(GetBlendMemEx(F,GetBlendMemEx(B,$000000,$FF),M),GetBlendMemEx(F,GetBlendMemEx(B,$FFFFFF,$FF),M));
 //B:=CombineReg(F or $FF000000,B,F shr 24);
 B:=GetPixelCombineNormal(F,B,M);
 exit;
 B2:=GetBlendMemEx(F,GetBlendMemEx(B,$00000000,$FF),255);
// alpha:=((F shr 24)*(255 - (B shr 24))) div 255 + (B shr 24);
 alpha:=((F shr 24)*(255 - (B shr 24))) + (B shr 24)*255;
 {if alpha<>alpha2 then
  assert(alpha=alpha2);   }
 B3:=GetOriginalRGB2(B2,alpha);
 {if b1<b3 then
 begin
 B3:=GetOriginalRGB2(B2,alpha);
 if b1+b2+b3+f+b+m+alpha<>0 then;
 end;    }
 B:=B3;

                         {
  if f=3420 then
   showmessage(inttohex(GetBlendMemEx(f,b,m),3));; }
{ F:=F and $FFFFFF;
 BlendMemEx(F,B,M);
 GetBlendMemEx(F,B,M);}
 //B:=F;
end;


procedure TdhCustomPanel.PixelCombineNegativeMultiply(F: TColor32; var B: TColor32; M: TColor32);
var B1,B2,B3:TColor32;
    alpha,alpha2:DWORD;
begin
// B:=ExtractAlphaColor(ColorNegMult(F,GetBlendMemEx(B,$FF000000,$FF),M),ColorNegMult(F,GetBlendMemEx(B,$FFFFFFFF,$FF),M));
 B2:=ColorNegMult(F,GetBlendMemEx(B,$FF000000,$FF),M);

 alpha:=M*(((F shr 24)*(255 - (B shr 24))) + (B shr 24)*255);
 B3:=GetOriginalRGB2(B2,alpha);
 B:=B3;
        {
  if f=34220 then showmessage(inttohex(GetBlendMemEx(f,b,m),8));;
  if f=34220 then showmessage(inttohex(int64(GetBlendMemEx(f,b,m)),8));;  }
{ F:=F and $FFFFFF;
 BlendMemEx(F,B,M);
 GetBlendMemEx(F,B,M);}
 //B:=F;
end;

procedure TdhCustomPanel.PixelCombineMultiply(F: TColor32; var B: TColor32; M: TColor32);
var B1,B2,B3:TColor32;
    alpha,alpha2:DWORD;
begin
//howmessage(inttohex(colormult($FFFF0000,$FF00FF00,255),8));
 B:=ExtractAlphaColor(ColorMult(F,GetBlendMemEx(B,$FF000000,$FF),M),ColorMult(F,GetBlendMemEx(B,$FFFFFFFF,$FF),M));

// B:=ExtractAlphaColor(ColorNegMult(F,GetBlendMemEx(B,$FF000000,$FF),M),ColorNegMult(F,GetBlendMemEx(B,$FFFFFFFF,$FF),M));
{ B2:=ColorMult(F,GetBlendMemEx(B,$FF000000,$FF),M);

 alpha:=((F shr 24)*(255 - (B shr 24))) + (B shr 24)*255;
 B3:=GetOriginalRGB2(B2,alpha);
 B:=B3;  }

//  if f=34220 then showmessage(inttohex(GetBlendMemEx(f,b,m),3));;
{ F:=F and $FFFFFF;
 BlendMemEx(F,B,M);
 GetBlendMemEx(F,B,M);}
 //B:=F;
end;

type TPixelCombineMode=(pcNormal,pcMult,pcNegMult);

procedure ExtractTransparencyInverse(P,P2:PColor32; Size:integer);
var i:integer;
begin
 for i:=0 to Size-1 do
 begin
  P2^:=$FF - P^ shr 24;
  inc(P);
  inc(P2);
 end;
end;

procedure ExtractAlphaBitmap(P,P2:PColor32; Size:integer);
var i:integer;
begin
  for i := 0 to Size - 1 do
  begin
   P^:=ExtractAlphaColor(P^,P2^);
   Inc(P);
   Inc(P2);
  end;
end;


procedure MixColor(Src:TMyBitmap32; Color:TColor32);
var P:PColor32;
    i:integer;
begin
 P:=Src.PixelPtr[0,0];
 for i := 0 to Src.Width*Src.Height - 1 do
 begin
  P^:=GetBlendMemEx(P^,Color,255);
  Inc(P);
 end;
end;


procedure Exch(var a,b:TMyBitmap32); overload;
var c:TMyBitmap32;
begin
 c:=a;
 a:=b;
 b:=c;
end;

procedure MixAlpha(Src:TMyBitmap32);
var P:PColor32;
    i:integer;
    alpha,alpha_shifted,p1,p2:DWORD;
    a:array[0..255] of record min,max:integer end;
    good:boolean;
begin
 P:=Src.PixelPtr[0,0];
 alpha:=Src.MasterAlpha;
 alpha_shifted:=alpha*256*256*256 div 255+1;
 if alpha<>255 then
 for i := 0 to Src.Width*Src.Height - 1 do
 begin
  { P^:=(P^ and $00FFFFFF) or (P^ shr 24 * alpha div 255 shl 24);  //original version }
  P^:=(P^ and $00FFFFFF) or (P^ shr 24 * alpha_shifted and $FF000000); //speed-optimized version, but no division, so faster
  Inc(P);
 end;
 Src.MasterAlpha:=255;

(*  for alpha:=0 to 255 do
  begin
    a[alpha].min:=maxint;
    a[alpha].max:=0;
  end;

 //The proof why the optimized version yields the same result:
 for alpha:=0 to 255 do
 for alpha_shifted:=0 to 256*256*256 do
 begin
  good:=true;
  for p1:=0 to 255 do
  begin
   p2:=round(p1 * alpha / 255);
   begin
    if not(((p1 * alpha_shifted {+ $8080}) shr 24) = p2) then
    begin
     good:=false;
     break;
    end;
   end;
  end;
  if good then
  begin
   a[alpha].min:=min(a[alpha].min,alpha_shifted);
   a[alpha].max:=max(a[alpha].max,alpha_shifted);
  end;
 end;

  for alpha:=0 to 256*256 do
   if a[alpha].max<>0 then
    showmessage(inttostr(alpha));
   *)

   (*
 for p1:=0 to 255 do
 for alpha:=0 to 255 do
 begin
  alpha_shifted:=alpha*256*256 div 255{++$FFFF}+1;
  if not (((p1 * alpha_shifted{ + $8080}) shr 16) = round(p1 * alpha / 255)) then
  assert(p1 * alpha_shifted shr 16 = round(p1 * alpha / 255));
//  assert(p1 * alpha_shifted shl 8 and $FF000000 = p1 * alpha div 255 shl 24);
 end;   *)
 //A look-up table with 255 entries may be even faster, but has another data access, not tested

end;

procedure ClearBit(P:PColor32; Size:integer);
var i:integer;
begin
  for i := 0 to Size - 1 do
  begin
   if i div 11 mod 2=1 then
   P^:=0;
   Inc(P);
  end;
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


function TdhCustomPanel.EasyBounds(var Transformations:TTransformations;var T: TAffineTransformation; var W,H:Integer; var HorzRotated,VertRotated:boolean): boolean;
var T2: TAffineTransformation;
begin
  result:=true;
  if not HasTransformations(Transformations) then
   Transformations:=nil;

  T:=GetAffine(false);

  {
  Skew muß doch als rotation gezählt werden weil x und y voneinander abhängen

  HorzRotated:=MapMod(glRotate,180)=0;
  VertRotated:=MapMod(glRotate,180)=90;
  if HorzRotated or VertRotated then
  begin

   if not EffectsAllowed then exit;

   if (Transformations=nil) or Transformations.FullIfEasy then
   begin
    if IsRegular(Determinant(t.Matrix)) then
    begin
     T2:= TAffineTransformation.Create;
     try
      T2.Matrix:=T.Matrix;
      Invert(T2.Matrix);
      T2.SrcRect:=FloatRect(0,0,Rct.Right,Rct.Bottom);
      Rct:=T2.GetTransformedBounds;
     except
      T2.Free;
     end;
    end;
   end else
    result:=false;

  end else
  begin
   result:=false;
  end;    }

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

type TTransFromProc=procedure (bmp:TMyBitmap32) of object;


procedure TdhCustomPanel.TransFromBlackWhite_BG(bmp:TMyBitmap32);
begin
  BeginPainting(bmp);
  try
   PaintOuterBorder;
   PaintOuterBg;
  finally
   EndPainting;
  end;
end;

procedure TdhCustomPanel.TransFromBlackWhite_TP(bmp:TMyBitmap32);
begin
  BeginPainting(bmp);
  try
   DoTopPainting;
  finally
   EndPainting;
  end;
end;



function TransFromBlackWhite(callback:TTransFromProc; w,h:integer):TMyBitmap32;
var Src2:TMyBitmap32;
begin
  result:=TMyBitmap32.Create;
  result.Width:=w;
  result.Height:=h;
  if not result.Empty then
  begin
  Src2:=TMyBitmap32.Create;
  Src2.SetSize(result.Width,result.Height);
  Src2.Clear(clWhite32);
  callback(Src2);
  result.Clear(clBlack32);
  callback(result);
  ExtractAlphaBitmap(result.PixelPtr[0, 0],Src2.PixelPtr[0, 0],result.Height*result.Width);
  Src2.Free;
  end;
  result.DrawMode:=dmBlend;
end;


procedure ColXor(bmp:TMyBitmap32);
var i:integer;
var P: PColor32;
begin
   P:=bmp.PixelPtr[0,0];
   for i := 0 to bmp.Width*bmp.Height do
   begin
    P^:=P^ xor $FF000000;
    inc(P);
   end;
end;

function _CombineReg(X, Y, W: TColor32): TColor32;
var r1,r2,g1,g2,b1,b2,a1,a2,r,g,b,a,alpha:integer;
begin
 if W=0 then
 begin
  result:=Y;
  exit;
 end;
 if W=$FF then
 begin
  result:=X;
  exit;
 end;
 if X=Y then
 begin
  result:=Y;
  exit;
 end;



 a1:=X shr 24*(W+1);
 a2:=Y shr 24*(255-W+1);
 {if a1=0 then
 begin
  result:=Y and $FFFFFF or (a2 shr 8 shl 24);
  exit;
 end;
 if a2=0 then
 begin
  result:=X and $FFFFFF or (a1 shr 8 shl 24);
  exit;
 end; }
 r1:=X shr 16 and $FF;
 r2:=Y shr 16 and $FF;
 g1:=X shr 8 and $FF;
 g2:=Y shr 8 and $FF;
 b1:=X and $FF;
 b2:=Y and $FF;

 r:=(r1*a1+r2*a2) shr 16;
 g:=(g1*a1+g2*a2) shr 16;
 b:=(b1*a1+b2*a2) shr 16;
 alpha:=(a1+a2);
 assert(r<=255);
 assert(g<=255);
 assert(b<=255);
 assert(alpha<=256*256-1);
 B2:=r shl 16 or g shl 8 or b;

 //result:=B2 and $FFFFFF or (alpha shr 8 shl 24);
 Result:=GetOriginalRGB2(B2,alpha);

end;


function TdhCustomPanel.TransPainting(nWidth:integer=-1; nHeight:integer=-1):TMyBitmap32;
var Src:TMyBitmap32;
var T: TAffineTransformation;
    Transformations:TTransformations;
    bWidth,bHeight:integer;     
    cr:TRect;

procedure DoBlurPure(_Src:TMyBitmap32; Blur:TBlur; shift:integer; inv:boolean=false);
var P,P2,P3: PColor32;
    j,OffsX,OffsY,Offs,count:integer;
    a:DWORD;
    col:DWORD;
begin
 count:=Src.Width*Src.Height;
// inv:=false;

 P:=Src.PixelPtr[0, 0];
 P2:=_Src.PixelPtr[0, 0];
 for j := 0 to _Src.Height*_Src.Width - 1 do
 begin
  P2^:=(P^ shr shift) and $FF; {
  if inv then
   P2^:=255-P2^;            }
  inc(P2);
  inc(P);
 end;

 gauss.Blur(PDWORD(_Src.PixelPtr[0, 0]),_Src.Width,_Src.Height,Blur.GetDoubleRadius,Blur.FFlood/100,inv);


 P:=Src.PixelPtr[0, 0];
 P2:=_Src.PixelPtr[0, 0];
 for j := 0 to _Src.Height*_Src.Width - 1 do
 begin     {
  if inv then
   P^:=(P^ and not ($FF shl shift)) or ((255-P2^) shl shift) else   }
   P^:=(P^ and not ($FF shl shift)) or (P2^ shl shift);
  inc(P2);
  inc(P);
 end;
end;

procedure DoBlur(_Src:TMyBitmap32; Blur:TBlurEffect; inv:boolean);
var P,P2,P4: PColor32;
    j,OffsX,OffsY{,Offs},count:integer;
    Alpha:double;
    a:DWORD;
    col:DWORD;
    y,dx,dy:integer;
    R1,R2:TRect;
begin
 Alpha := Blur.Degree * 3.14159265358979 / 180;

 offsX:=-Round(Cos(Alpha)*Blur.Distance);
 offsY:=--Round(Sin(Alpha)*Blur.Distance);

 count:=Src.Width*Src.Height;
 P:=Src.PixelPtr[0, 0];
 P2:=_Src.PixelPtr[0, 0];      
 FillLongword(_Src.PixelPtr[0,0]^,count,0);


 R1:=Src.BoundsRect;
 R2:=R1;
 OffsetRect(R2,offsX,offsY);
 IntersectRect(R2,R1,R2);
 dx:=R2.Right-R2.Left;
 dy:=R2.Bottom-R2.Top;
 if (dx>0) and (dy>0) then
 begin
 p2:=_Src.PixelPtr[R2.Left,R2.Top];
 p:=Src.PixelPtr[Src.Width-R2.Right,Src.Height-R2.Bottom];
 for y:=0 to dy-1 do
 begin
  if inv then
   ExtractTransparencyInverse(p,p2,dx) else
   ExtractTransparency(p,p2,dx);
  inc(p,Src.Width);
  inc(p2,Src.Width);
 end;
 end;

 (*
 offs:=offsY*_Src.Width+OffsX;

 FillLongword(_Src.PixelPtr[0,0]^,count,0);

 ausschnittHeight:=Src.Height-abs(offsY);
 ausschnittWidth:=Src.Width-abs(offsX);
 if offs>0 then
 begin
  FillLongword(P2^,offs,$0);
  inc(P2,offs);
  dec(count,offs);
 end else
 begin
  P4:=P2;
  inc(P4,count-(-offs));
  FillLongword(P4^,(-offs),$0);
  inc(P,(-offs));
  dec(count,(-offs));
  inc(P,

 end;

{ if inv then
  ExtractTransparencyInverse(p,p2,count) else
  ExtractTransparency(p,p2,count);
 }                                                              
 for y:=0 to ausschnittHeight-1 do
 begin
  if inv then
   ExtractTransparencyInverse(p,p2,ausschnittWidth) else
   ExtractTransparency(p,p2,ausschnittWidth);
  inc(p,Src.Width);
  inc(p2,Src.Width);
 end;*)


 gauss.Blur(PDWORD(_Src.PixelPtr[0, 0]),_Src.Width,_Src.Height,Blur.GetDoubleRadius,Blur.FFlood/100,inv);

 P:=Src.PixelPtr[0, 0];
 P2:=_Src.PixelPtr[0, 0];
// P3:=SrcFinal.PixelPtr[0, 0];
 a:=(Blur.Alpha*(CSSColorToColor32(Blur.Color) shr 24)) div 255;
 col:=CSSColorToColor32(Blur.Color) and $FFFFFF;
 (*if inv then
 begin
 for j := 0 to _Src.Height*_Src.Width - 1 do
 begin         {
  if P^ shr 24=0 then
   P2^:=0 else
   P2^:=(min(0,P2^-256+(P^ shr 24))*a shr 8) shl 24 or col;  }
  //P2^:=((((P^ shr 24))*P2^ shr 8)*a shr 8) shl 24 or col;


//  P2^:={P^ and $FF000000 or} (GetBetterDraw((P2^ shl 24) or col,0,P^ shr 24) {and $FFFFFF});

//  P2^:=P^ and $FF000000 or (GetBlendMemEx((P2^ shl 24) or col,P^,255) and $FFFFFF);
  //P2^:=((min(P^ shr 20,P2^))*a shr 8) shl 24 or col;
  //P2^:=(((P^ shr 24)*P2^ shr 8)*a shr 8) shl 24 or col;
  P2^:=P2^ shl 24 or col;


  inc(P3);
  inc(P2);
  inc(P);
 end;
 end else
 *)
 begin
 for j := 0 to _Src.Height*_Src.Width - 1 do
 begin
  //P2^:={((max(P^ shr 32,P2^)*a shr 8) shl 24) or}{ col}$FFFFFF;
  //((P2^:=(((255-(P^ shr 24))*P2^ shr 8)*a shr 8) shl 24 or col;
{  if P2^=0 then
   P2^:=P^ else
  P2^:=((P2^*a shr 8) shl 24) or col;}
  //P2^:=((P2^*a shr 8) shl 24) or col;


  //P2^:=((($ff-(P^ shr 24))*P2^ shr 8)*a shr 8) shl 24 or col;
  P2^:=P2^ shl 24 or col;

  inc(P2);
  inc(P);
 end;
 _Src.MasterAlpha:=a;
  MixAlpha(_Src);
 end;
end;

function Rest(r:Double):Double;
begin
 result:=-(R/2-Round(R/2));
end;

function roundrest(x:double):double;
begin
 result:=x-round(x);
end;


function GetAngle(FX,FY:double):double;
begin
 result:=sqrt(sqr(FX)+sqr(FY));
 if result>0 then
  result:=arccos(FX/result);
end;

function GetEllipseParameterizedAngle(a,b,x,y:double):double;
begin
 result:=arccos(x/a);
end;


procedure EllipsePoint2(alpha:double; a,b:double; var x,y:double);
begin
 if a=b then
 begin
  x:=cos(alpha)*a;
  y:=sin(alpha)*b;
 end else
 begin
  if a=0 then a:=0.001;
  if b=0 then b:=0.001;
  x:=1/sqrt( sqr(1/a) + sqr(  tan(alpha)/b) );
  if alpha=0 then
   y:=0 else
   y:=1/sqrt( sqr(1/b) + sqr(1/tan(alpha)/a) );
 end;
 //http://groups.google.de/groups?hl=de&lr=&threadm=3E4917BF.7F0082BE%40bluemail.ch&rnum=1&prev=/groups%3Fhl%3Dde%26lr%3D%26q%3Dellipsenbogen%26btnG%3DSuche
//http://home.att.net/~numericana/answer/ellipse.htm#gausskummer
end;

//const old_alpha:double=pi/2;


procedure GetNormal(alpha,a,b:double; var rx,ry:double);
var f_derived,g_derived,Sqrt_fg:double;
begin
 f_derived:=-a*sin(alpha);
 g_derived:= b*cos(alpha);
 {
 //if alpha<pi/4 then
 begin
  //f_derived:=-f_derived;
  g_derived:=-g_derived;
 end;
  }
 Sqrt_fg:=Sqrt(Sqr(f_derived)+Sqr(g_derived));
 rx:=g_derived/Sqrt_fg;
 ry:=-f_derived/Sqrt_fg;
 //http://mathworld.wolfram.com/ParallelCurves.html
end;

var maxit:integer;


{$DEFINE XYS}
{$IFDEF XYS}

procedure EllipsePoint(x,y:double; a,b:double; var rx,ry,ralpha:double);
var T:double;
    f,f_pred,T_pred,D,Sqr_a_b,ax,by,COS_t,SIN_t:double;
    i:integer;
    UseOld:boolean;
begin

 if a=b then
 begin
  ralpha:=GetAngle(x,y);
  rx:=cos(ralpha)*a;
  ry:=sin(ralpha)*a;
  exit;
 end;

      {

 T:=ralpha;    
// if (a<
 if a<b then
  UseOld:=t<2*pi/8 else
 if a>b then
  UseOld:=t>2*pi/8 else
  UseOld:=false;  }
      {
 UseOld:=T:=ralpha
 if not UseOld then   }
 if a=b then
  t:=2*pi/8 else
 if a<b then
  t:=1*pi/8 else
 //if a>b then
  t:=3*pi/8;
 //T:=GetWinkel(X/a,Y/b);
// t := ArcTan2  ( y, x );
{ assert(x>0);
 assert(y>0);}
 Sqr_a_b:=(Sqr(a) - Sqr(b));
 ax:=a*x;
 by:=b*y;
 //Newton approximation
 for i:=1 to 20 do
 begin

 COS_t:=COS(t);
 SIN_t:=SIN(t);
 D:=
 (COS_t*(Sqr_a_b*SIN_t + by) - ax*SIN_t)/
 (2*Sqr_a_b*Sqr(COS_t) - ax*COS_t - by*SIN_t - Sqr_a_b);
 //maxit:=max(maxit,i);
 inc(maxit);
 T:=T-d;
 if abs(D)<0.000001 then break;
 end;

 while t>2*pi do
  t:=t-2*pi;
 while t<0 do
  t:=t+2*pi;
// if t>=

  rx := a * cos ( t );
  ry := b * sin ( t );
  ralpha:=T;
  //old_alpha:=T;


end;
{$ELSE}


procedure EllipsePoint(x,y:double; a,b:double; var rx,ry,ralpha:double);
var T:double;
    f,f_pred,T_pred,D,SIN_t,COS_t:double;
    i:integer;
begin

 if a<b then
  T:=0 else
  T:=pi/2;
 //t := ArcTan2  ( y, x );
f_pred:=
- A * sin ( T ) * ( X - A * cos ( T ) )
+ B * cos ( T ) * ( Y - B * sin ( T ) );
 T_pred:=T;
 T:=pi/4;
 //f_pred:=0.4522345;
 //Secand approximation
 for i:=1 to 20 do
 begin
SIN_t:=sin ( T );
COS_t:=cos ( T );
f:=
- A * SIN_t * ( X - A * COS_t )
+ B * COS_t * ( Y - B * SIN_t );
 //maxit:=max(maxit,i);
 inc(maxit);
D:=(T-T_pred)/(f-f_pred)*f;
f_pred:=f;
T_pred:=T;
T:=T-d;
if abs(D)<0.000001 then
begin
 break;
end;
 end;
  rx := a * cos ( t );
  ry := b * sin ( t );
  ralpha:=T;
//  http://www.csit.fsu.edu/~burkardt/m_src/geometry/ellipse_point_near_2d.m
end;
{$ENDIF}

procedure EllipsePointBoth(x,y:double; c,d,a,b:double; var orx,ory,irx,iry,ralpha:double);
var lo,hi,t,a1,a2,dist,quot,delta,COS_t,SIN_t:double;
    i:integer;
begin
 if (a=c) and (b=d) then
 begin
  EllipsePoint(x,y,c,d,orx,ory,ralpha);
  irx:=orx;
  iry:=ory;
  exit;
 end;

 //find t so that cross product of (orx,ory)-(irx,iry) and (x,y)-(irx,iry) becomes 0
 (*
 lo:=0;
 hi:=pi/2;
 t:=(lo+hi)/2;
 repeat
  orx:=c*cos(t);
  ory:=d*sin(t);
  irx:=a*cos(t);
  iry:=b*sin(t);
  quot:=(irx*ory-orx*iry);
  if quot=0 then
  begin
   {if irx-orx<>0 then
   begin
    a2:=1;
    a1:=(ory-iry)/(irx-orx);
   end else
   begin
    a1:=1;
    a2:=(orx-irx)/(iry-ory);
   end; }break;
  end else
  begin
   a2:=(irx-orx)/quot;
   a1:=(1-a2*iry)/irx;
  end;
  dist:=a1*x+a2*y-1;
  if abs(dist)<0.01 then break;
  if dist<0 then
   lo:=t else
   hi:=t;
  t:=(lo+hi)/2;
 until false;
 ralpha:=t;
*)
         {
 if a=b then
 begin
  ralpha:=GetWinkel(x,y);
  rx:=cos(ralpha)*a;
  ry:=sin(ralpha)*a;
  exit;
 end;    }
 //t:=pi/2;


 if a=b then
  t:=2*pi/8 else
 if a<b then
  t:=1*pi/8 else
 //if a>b then
  t:=3*pi/8;
 for i:=1 to 20 do
 begin

 COS_t:=COS(t);
 SIN_t:=SIN(t);
 try
 delta:=
(COS(t)*((a*d - b*c)*SIN_t - y*(a - c)) + x*(b - d)*SIN_t)/
(2*(a*d - b*c)*Sqr(COS_t) + x*(b - d)*COS_t + y*(a - c)*SIN_t - a*d + b*c);
except
 delta:=
(COS(t)*((a*d - b*c)*SIN_t - y*(a - c)) + x*(b - d)*SIN_t)/
(2*(a*d - b*c)*Sqr(COS_t) + x*(b - d)*COS_t + y*(a - c)*SIN_t - a*d + b*c);
end;
 //maxit:=max(maxit,i);
 inc(maxit);
 T:=T-delta;
 if abs(delta)<0.000001 then break;
 end;

 while t>2*pi do
  t:=t-2*pi;
 while t<0 do
  t:=t+2*pi;
// if t>=

  irx := a * cos ( t );
  iry := b * sin ( t );
  orx := c * cos ( t );
  ory := d * sin ( t );
  ralpha:=T;
  //old_alpha:=T;


end;

function arc_function(Sqr_a,Sqr_b,t:double):double ;
var Sqr_Sin:double;
begin
 Sqr_Sin:=Sqr(Sin(t));
 result:= Sqrt(Sqr_a*Sqr_Sin + Sqr_b*(1-Sqr_Sin));
end;

var old_t1,old_t1_x:double;
    old_result,old_result_x:double;
    first_arc_x:boolean;


function arclength(t1:double; a,b:integer; n:integer=0):double;
var j:integer;
    t0,ttt,re,Sqr_a,Sqr_b:double;
    UseOldVal:boolean;
begin
 if a=b then
 begin
  result:=t1*a;
  exit;
 end;
 if b=0 then
 begin
  result:=a - a * cos ( t1 );
  exit;
 end;
 if a=0 then
 begin
  result:=b * sin ( t1 );
  exit;
 end;

 //old_t1:=0;  //wenn keine Optimierung
 UseOldVal:=false;
 if t1<old_t1 then
 begin
  //t0:=old_t1;
  t0:=t1;
  t1:=old_t1;
  UseOldVal:=true;
 end else
 if t1=old_t1 then
 begin
  result:=old_result;
  exit;
 end else
 begin
  t0:=0;
  ttt:=pi/2;
  //assert(t1=ttt);
 end;

 if n=0 then
  n:=Round((a+b)*abs(t1-t0)/(pi/2)+0.5);
 Sqr_a:=Sqr(a);
 Sqr_b:=Sqr(b);
 result := 0;
 For j := 0 To n-1 do
 begin
    re:=arc_function(Sqr_a, Sqr_b, t0 + (t1 - t0)*(j/n));
    result := result + re;
 end;
 result := result * ((t1 - t0) / n);
 if UseOldVal then
 begin
  //result:=result+old_result;
  result:=-result+old_result;
  t1:=t0;
 end;
 old_t1:=t1;
 old_result:=result;
end;

function convex(a,b,epsilon:double):double;
begin
 result:=b+(a-b)*epsilon;
end;
                        
function RoundTo2(const AValue: Double; const ADigit: TRoundToRange): Double;
var
  LFactor: Double;
begin
  LFactor := IntPower(2, ADigit);
  Result := Round(AValue / LFactor) * LFactor;
end;

function Round2(d,von,einheit:double):double;
var e:double;
begin
 result:=round((d-von)/einheit)*einheit+von;
end;

function Round3(d,von,ber,einheit:double;var e:double):double;
begin
 e:=1;
 while einheit<ber/e do
  e:=e*2;
 //einheit>=ber/e
 //if einheit-ber/e>ber/(e/2)-einheit then
  //e:=e/2;
// e:=e/2;
 //einheit<=e
{ if e-einheit>einheit-e/2 then
  e:=e/2;  }
 einheit:=ber/e;
 e:=einheit;
 result:=round((d-von)/einheit)*einheit+von;
end;

function ScaledCol(Src:TMyBitmap32; X,Y,ScaleX,ScaleY:Double; const BorderClip:TRect):TColor32;
{$DEFINE ScaleColDouble}
var vonX,vonY,bisX,bisY:Double;
    iX,iY:integer;
    Col:TColor32;
var r1,g1,b1,a1,r,g,b,alpha:{$IFDEF ScaleColDouble}double{$ELSE}integer{$ENDIF};
    PixelPower:double;
    B2:TColor32;
    ivonX,ivonY,ibisX,ibisY:integer;
    begPartX,begPartY,endPartX,endPartY,actPartX,actPartY:double;
begin
 vonX:=X-ScaleX/2;
 bisX:=X+ScaleX/2;
 vonY:=Y-ScaleY/2;
 bisY:=Y+ScaleY/2;
 ivonX:=Floor(vonX);
 ivonY:=Floor(vonY);
 ibisX:=Floor(bisX);
 ibisY:=Floor(bisY);
 if not DoIntersectStrong({Src.BoundsRect}BorderClip,Rect(ivonX,ivonY,ibisX+1,ibisY+1)) then
 begin
  result:=0;
  exit;
 end;
 r:=0;
 g:=0;
 b:=0;
 alpha:=0;
 PixelPower:=256/(ScaleX*ScaleY);
 if ivonY=ibisY then
 begin
  begPartY:=bisY-vonY;
  endPartY:=0;
 end else
 begin
  begPartY:=(ivonY+1)-vonY;
  endPartY:=bisY-ibisY;
 end;
 if ivonX=ibisX then
 begin
  begPartX:=bisX-vonX;
  endPartX:=0;
 end else
 begin
  begPartX:=(ivonX+1)-vonX;
  endPartX:=bisX-ibisX;
 end;
 assert(begPartX<=1);
 assert(begPartY<=1);
 assert(endPartX<=1);
 assert(endPartY<=1);
 assert(begPartX>=0);
 assert(begPartY>=0);
 assert(endPartX>=0);
 assert(endPartY>=0);

 actPartY:=begPartY;
 for iY:=ivonY to ibisY do
 begin
 actPartX:=begPartX;
 for iX:=ivonX to ibisX do
 begin
 if PtInRect(BorderClip,Point(iX,iY)) then
  Col:=Src.PixelS[iX,iY] else
  Col:=0;

 a1:={$IFNDEF ScaleColDouble}Round{$ENDIF}((Col shr 24)*actPartX*actPartY*PixelPower);
 r1:=Col shr 16 and $FF;
 g1:=Col shr 8 and $FF;
 b1:=Col and $FF;

 r:=r+r1*a1;
 g:=g+g1*a1;
 b:=b+b1*a1;
 alpha:=alpha+a1;

 if iX<>ibisX-1 then
  actPartX:=1 else
  actPartX:=endPartX;
 end;
 if iY<>ibisY-1 then
  actPartY:=1 else
  actPartY:=endPartY;
 end;

{$IFDEF ScaleColDouble}
 if alpha=0 then
 begin
  result:=0;
  exit;
 end;
 r:=r/alpha;
 g:=g/alpha;
 b:=b/alpha;
 alpha:=alpha/(256*255);
 result:=round(r) shl 16 or round(g) shl 8 or round(b) or round(alpha*255) shl 24;

{$ELSE}

 r:=r shr 16;
 b:=b shr 16;
 g:=g shr 16;
 assert(r<=255);
 assert(g<=255);
 assert(b<=255);
 alpha:=min(alpha,256*256-1);
 assert(alpha<=256*256-1);
 B2:=r shl 16 or g shl 8 or b;
 Result:=GetOriginalRGB2(B2,alpha);
{$ENDIF}

end;

procedure Get_X_EQ_CY_PLUS_D(x,y,m,n:double; var c,d:double);
begin
 //x=cy+d and m=cn+d
 c:=(m-x)/(n-y);
 d:=x-c*y;
end;

procedure Line_Intersects_Ellipse(c,d,a,b:double; var rx,ry:double);
var p_halbe,q,nenner:double;
begin
 nenner:=Sqr(a/b)+Sqr(c);
 p_halbe:=c*d/nenner;
 q:=(Sqr(d)-Sqr(a))/nenner;
 ry:=-p_halbe+Sqrt(Sqr(p_halbe)-q); //pq-Formel
 rx:=c*ry+d;
end;


function Distance(a,b,x,y:double):double;
begin
 result:=Sqrt(Sqr(a-x)+Sqr(b-y));
end;



procedure RoundCorner(const OuterRect:TRect; Src,Dst:TMyBitmap32; HorzOuterRadius,VertOuterRadius,HorzBorderWidth,VertBorderWidth:integer; Align:TAlign);
var HorzInnerRadius,VertInnerRadius,x,y:integer;
    alpha,betta,_alpha,alphaO,alphaI,perimeter,act_arc,beta,
    NormalX,NormalY,DistRound,DistOuter,DistInner,projX,projY,RoundOuterX,RoundOuterY,RoundInnerX,RoundInnerY,OuterX,OuterY,InnerX,InnerY,pct,pct2:double;
    P,RP,FinalPixel:TPoint;
    multPX,multPY:integer;
    NewCol,OldCol,NewCol2:TColor32;
    AlphaX,AlphaY,NewAlpha:integer;
    FirstQuarter:boolean;
    fx,fy,assimilate,ScaleX,ScaleY,einheit,assimilate1,assimilate2,_C,_D,w1,w2,w:double;
const AntiAliaseCorner=not false;

function Proj(x,y:integer):TPoint;
begin
 result:=Point(P.X+multPX*X,P.Y+multPY*Y);
end;

function RectFromPoints(P1,P2:TPoint):TRect;
begin
 result.Left:=min(P1.X,P2.X);
 result.Right:=max(P1.X,P2.X);
 result.Top:=min(P1.Y,P2.Y);
 result.Bottom:=max(P1.Y,P2.Y);
end;

var FirstQuarterClip,NonFirstQuarterClip,BorderClip,TryR:TRect;
    FirstQuarterRange,NonFirstQuarterRange:Double;



begin
 if (HorzOuterRadius=0) or (VertOuterRadius=0) then exit;


 case Align of
 alTop:    P:=Point(OuterRect.Left+HorzOuterRadius-1,OuterRect.Top+VertOuterRadius-1);
 alRight:  P:=Point(OuterRect.Right-HorzOuterRadius ,OuterRect.Top+VertOuterRadius-1);
 alBottom: P:=Point(OuterRect.Right-HorzOuterRadius ,OuterRect.Bottom-VertOuterRadius);
 alLeft:   P:=Point(OuterRect.Left+HorzOuterRadius-1,OuterRect.Bottom-VertOuterRadius);
 end;
 multPX:=1;
 multPY:=1;
 if Align in [alTop,alLeft] then multPX:=-1;
 if Align in [alTop,alRight] then multPY:=-1;
 HorzInnerRadius:=HorzOuterRadius-VertBorderWidth;
 VertInnerRadius:=VertOuterRadius-HorzBorderWidth;
 HorzInnerRadius:=max(1,HorzInnerRadius);
 VertInnerRadius:=max(1,VertInnerRadius);
 FirstQuarterClip:=RectFromPoints(Proj(HorzInnerRadius,-1),Proj(HorzOuterRadius-1,VertOuterRadius-1));
 Inc(FirstQuarterClip.Bottom);{Bottom is exclusive, Top is inclusive}
 Inc(FirstQuarterClip.Right);{Right is exclusive, Left is inclusive}
 NonFirstQuarterClip:=RectFromPoints(Proj(-1,VertInnerRadius),Proj(HorzOuterRadius-1,VertOuterRadius-1));
 Inc(NonFirstQuarterClip.Bottom);
 Inc(NonFirstQuarterClip.Right);
 HorzBorderWidth:=VertOuterRadius-VertInnerRadius;
 VertBorderWidth:=HorzOuterRadius-HorzInnerRadius;
 //Assert(IntersectRect(TryR,FirstQuarterClip,Src.BoundsRect) and EqualRect(TryR,FirstQuarterClip));
 //Assert(IntersectRect(TryR,NonFirstQuarterClip,Src.BoundsRect) and EqualRect(TryR,NonFirstQuarterClip));



{ old_t1:=0; old_result:=0;
 perimeter:=arclength(pi/2,HorzInnerRadius,VertInnerRadius,2);
 if perimeter<>-1 then
 begin
 old_t1:=0; old_result:=0;
 perimeter:=arclength(pi/4,HorzInnerRadius,VertInnerRadius,1);
 perimeter:=arclength(pi/2,HorzInnerRadius,VertInnerRadius,1);
 if perimeter<>-1 then
 perimeter:=0;
 end;     }

 old_t1:=0; old_result:=0;
 //perimeter:=arclength(pi/2,HorzOuterRadius,VertOuterRadius);
 perimeter:=arclength(pi/2,HorzInnerRadius,VertInnerRadius);
 old_t1_x:=old_t1; old_result_x:=old_result;


  FirstQuarterRange:=VertInnerRadius-0.5;
  NonFirstQuarterRange:=HorzInnerRadius-0.5;
  if AntiAliaseCorner then
  if (VertBorderWidth<>0) and (HorzBorderWidth<>0) then
  begin

  ScaleY:=HorzBorderWidth/VertBorderWidth;
  ScaleX:=1;
  for x:=0 to VertBorderWidth-1 do
  begin
   projX:=HorzInnerRadius-ScaleX/2;
   projY:=VertInnerRadius+x*ScaleY+ScaleY/2;
   NewCol:=ScaledCol(Src,P.X+multPX*(projX-0.5)+0.5,P.Y+multPY*(projY-0.5)+0.5,ScaleX,ScaleY,NonFirstQuarterClip);
   //if x=0 then NewCol:=_CombineReg(NewCol,Src.PixelS[P.X+multPX*(HorzInnerRadius),P.Y+multPY*(VertInnerRadius)],$FF div 2);
   Src.PixelS[P.X+multPX*(HorzInnerRadius+x),P.Y+multPY*(VertInnerRadius)]:=NewCol;
  end;
  FirstQuarterRange:=VertInnerRadius-0.5+1;//perimeter/(HorzInnerRadius+VertInnerRadius);


  {ScaleX:=VertBorderWidth/HorzBorderWidth;
  ScaleY:=1;
  for y:=0 to HorzBorderWidth-1 do
  begin
   projY:=VertInnerRadius-ScaleY/2;
   projX:=HorzInnerRadius+y*ScaleX+ScaleX/2;
   NewCol:=ScaledCol(Src,P.X+multPX*(projX-0.5)+0.5,P.Y+multPY*(projY-0.5)+0.5,ScaleX,ScaleY,FirstQuarterClip);
   //if y=0 then NewCol:=_CombineReg(NewCol,Src.PixelS[P.X+multPX*(HorzInnerRadius),P.Y+multPY*(VertInnerRadius)],$FF div 2);
   Src.PixelS[P.X+multPX*(HorzInnerRadius),P.Y+multPY*(VertInnerRadius+y)]:=NewCol;
  end;
  NonFirstQuarterRange:=HorzInnerRadius+0.5;
  }


  end;
  //beta:=fx/HorzOuterRadius/(fx/HorzOuterRadius+fy/VertOuterRadius);
  //beta:=arccos(HorzOuterRadius/sqrt(sqr(HorzOuterRadius)+sqr(VertOuterRadius)))/pi*2;
  //beta:=0.5;
  //beta:=(VertOuterRadius/(HorzOuterRadius+VertOuterRadius));
  if (HorzBorderWidth=0) and (VertBorderWidth<>0) then
   beta:=1 else
  if (VertBorderWidth=0) and (HorzBorderWidth<>0) then
   beta:=0 else
   beta:=(FirstQuarterRange/(NonFirstQuarterRange+FirstQuarterRange));
   //beta:=(VertInnerRadius/(HorzInnerRadius+VertInnerRadius));


 alphaO:=0;
 alphaI:=0;

 y:=VertOuterRadius-1;
 while y>={-2}0 do
 begin
  RP.Y:=P.Y+multPY*Y;
  FY:=y+0.5;
  Dec(y);
  x:=0;
  //decrease VertInnerRadius/HorzInnerRadius by one to include semi-transparent pixels
  if VertInnerRadius-1>FY then
  begin
   FX:=Sqrt(Sqr(HorzInnerRadius-1)-Sqr(FY)*Sqr(HorzInnerRadius-1)/Sqr(VertInnerRadius-1));//Get X for given Y
   x:=Max(0,Trunc(FX-0.5));
  end;  
  old_t1:=old_t1_x; old_result:=old_result_x; first_arc_x:=true;
 while x<=HorzOuterRadius-1 do
 begin
  RP.X:=P.X+multPX*X;
  FX:=x+0.5;
  Inc(x);
      {
 //if (x=177) and (y=6) then
 if (fx=2.5) and (fy=2.5) then
 //if (x=150) and (y=-1) then
  begin
  Dst.PixelS[RP.X,RP.Y]:=clRed32;;//random(255) shl 16 or $FF000000;
  //continue;
  end;   }


  //alpha:=GetWinkel(FX,FY);
{  EllipsePoint2(alpha,HorzOuterRadius,VertOuterRadius,RoundOuterX,RoundOuterY);
  EllipsePoint2(alpha,HorzInnerRadius,VertInnerRadius,RoundInnerX,RoundInnerY);
  alpha:=alpha/pi*2;
 }


//  EllipsePointBoth(FX,FY,HorzOuterRadius,VertOuterRadius,HorzInnerRadius,VertInnerRadius,RoundOuterX,RoundOuterY,RoundInnerX,RoundInnerY,alphai);


  EllipsePoint(FX,FY,HorzInnerRadius,VertInnerRadius,RoundInnerX,RoundInnerY,alphaI);
  //EllipsePoint(FX,FY,HorzOuterRadius,VertOuterRadius,RoundOuterX,RoundOuterY,alphaO);

  Get_X_EQ_CY_PLUS_D(FX,FY,RoundInnerX,RoundInnerY,_C,_D);
  Line_Intersects_Ellipse(_C,_D,HorzOuterRadius,VertOuterRadius,RoundOuterX,RoundOuterY);
  alphaO:=GetEllipseParameterizedAngle(HorzOuterRadius,VertOuterRadius,RoundOuterX,RoundOuterY);



{  Get_X_EQ_CY_PLUS_D(FX,FY,RoundOuterX,RoundOuterY,_C,_D);
  Line_Intersects_Ellipse(_C,_D,HorzInnerRadius,VertInnerRadius,RoundInnerX,RoundInnerY);
  alphaI:=alphaO;
}
  {alpha:=GetWinkel(RoundInnerX,RoundInnerY);
  EllipsePoint2(alpha,HorzOuterRadius,VertOuterRadius,RoundOuterX,RoundOuterY);}
{  RoundOuterX:=cos(alphaI)*HorzOuterRadius;
  RoundOuterY:=sin(alphaI)*VertOuterRadius;
}
  //alphaI:=alphaO;
  act_arc:=arclength(alphaI,HorzInnerRadius,VertInnerRadius);

{  EllipsePoint(FX,FY,HorzInnerRadius,VertInnerRadius,RoundInnerX,RoundInnerY,alphaI);
  act_arc:=arclength(alphaI,HorzInnerRadius,VertInnerRadius);
  GetNormal(alphaI,HorzInnerRadius,VertInnerRadius,NormalX,NormalY);
  RoundOuterX:=RoundInnerX+HorzBorderWidth*NormalX;
  RoundOuterY:=RoundInnerY+HorzBorderWidth*NormalY;
}

{  EllipsePoint(FX,FY,HorzOuterRadius,VertOuterRadius,RoundOuterX,RoundOuterY,alphaO);
  act_arc:=arclength(alphaO,HorzOuterRadius,VertOuterRadius);
  GetNormal(alphaO,HorzOuterRadius,VertOuterRadius,NormalX,NormalY);
  RoundInnerX:=RoundOuterX-convex(HorzBorderWidth,VertBorderWidth,act_arc/perimeter)*NormalX;
  RoundInnerY:=RoundOuterY-convex(HorzBorderWidth,VertBorderWidth,act_arc/perimeter)*NormalY;
 }


(*  if {(alphaO<0) or (alphaO>pi/2) or}(abs((-NormalY)*(RoundOuterX-FX)+(NormalX)*(RoundOuterY-FY))>0.0001) or (RoundOuterY<0) or (RoundOuterX<0) then
  begin
//    Dst.PixelS[RP.X,RP.Y]:=clYellow32;
    continue;
  end;*)
  //  if not ((RoundInnerX<=FX) and (FX<=RoundOuterX)) or not ((RoundInnerY<=FY) and (FY<=RoundOuterY)) then continue;
  //if (y<0) and (x>HorzInnerRadius) {and (RoundInnerY>=0)} then   continue;


(*  while RoundInnerY<0 do
  begin
  { RoundInnerX:=RoundInnerX+NormalX;
   RoundInnerY:=RoundInnerY+NormalY;     }
   RoundOuterX:=RoundOuterX+NormalX;
   RoundOuterY:=RoundOuterY+NormalY;
  RoundInnerX:=RoundOuterX-HorzBorderWidth*NormalX;
  RoundInnerY:=RoundOuterY-HorzBorderWidth*NormalY;

  end;*)


  if first_arc_x then
  begin
   old_t1_x:=old_t1; old_result_x:=old_result; first_arc_x:=false;
  end;
  alpha:=act_arc/perimeter;

  //alpha:=0;
  //alpha:=alpha/pi*2;
  //alpha:=alpha/pi*4/(VertOuterRadius/HorzOuterRadius);

  FirstQuarter:=alpha<beta;

  //if alpha=beta then continue;
  //FirstQuarter:=alpha/pi*2<0.5;

         {
  RoundInnerY:=max(0,RoundInnerY);
  RoundInnerX:=max(0,RoundInnerX);
              }
  {if (RoundOuterY<0) or (RoundInnerY<0) or (RoundOuterX<0) or (RoundInnerX<0) then
  begin
   Dst.PixelS[RP.X,RP.Y]:=clWhite32;//random(255) shl 16 or $FF000000;
   continue;
  end; }         {
  if RoundOuterY<0 then
   RoundOuterY:=0;
  if RoundInnerY<0 then
   RoundInnerY:=0;   }
  //alpha:=GetWinkel(RoundOuterX-RoundInnerX,RoundOuterY-RoundInnerY);



  DistOuter:=Distance(RoundOuterX,RoundOuterY,FX,FY);
  DistInner:=Distance(RoundInnerX,RoundInnerY,FX,FY);
  DistRound:=Distance(RoundOuterX,RoundOuterY,RoundInnerX,RoundInnerY);


  if (DistRound=0) or FirstQuarter and (HorzInnerRadius=HorzOuterRadius) or not FirstQuarter and (VertInnerRadius=VertOuterRadius) then
  begin
   if (FX>RoundOuterX) or (FY>RoundOuterY) then
    DistOuter:=-DistOuter;
   pct:=0;
   pct2:=0;
   DistRound:=0;
   w:=1;
  end else
  begin
   pct:=  DistOuter/DistRound;
   pct2:= DistInner/DistRound;
   if (pct2>=1) and (pct2>=pct) then
   begin
    pct:=-pct;
   end else
   if (pct>1) and (pct>=pct2) then
   begin
    pct2:=-pct2;
   end;

   betta:=GetEllipseParameterizedAngle(HorzInnerRadius,VertInnerRadius, RoundInnerX,RoundInnerY);
   GetNormal(betta,HorzInnerRadius,VertInnerRadius,NormalX,NormalY);
   w1:=GetAngle(NormalX,NormalY);

   betta:=GetEllipseParameterizedAngle(HorzOuterRadius,VertOuterRadius, RoundOuterX,RoundOuterY);
   GetNormal(betta,HorzOuterRadius,VertOuterRadius,NormalX,NormalY);
   w2:=GetAngle(NormalX,NormalY);

   w:=(w1-w2);
   w:=DistRound/(DistRound*cos(w));
  // w:=convex(w,1,pct2);
   //w:=1;
  end;

  if FirstQuarter then
  begin
   _alpha:=alpha/beta;
   OuterX:=HorzOuterRadius;
   InnerX:=HorzInnerRadius;
   //OuterY:=(VertOuterRadius{-0.5})*_alpha;
   InnerY:=FirstQuarterRange*_alpha;
   OuterY:=InnerY;
   //InnerY:=OuterY;
  end else
  begin
   _alpha:=(1-alpha)/(1-beta);
   OuterY:=VertOuterRadius;
   InnerY:=VertInnerRadius;
   //OuterX:=(HorzOuterRadius{-0.5})*_alpha;
   InnerX:=NonFirstQuarterRange*_alpha;
   OuterX:=InnerX;
   //InnerX:=OuterX;
   {if VertOuterRadius=VertInnerRadius then
    DistRound:=0;}
  end;
   ScaleX:=1;
   ScaleY:=1;
   if DistRound=0  then
   begin
    if FirstQuarter then
    begin
     projX:=OuterX-DistOuter;
     projY:=OuterY;
    end else
    begin
     projY:=OuterY-DistOuter;
     projX:=OuterX;
    end;
   end else
   begin
    projX:=OuterX+(InnerX-OuterX)*pct;//InnerX+(OuterX-InnerX)*pct2;
    projY:=OuterY+(InnerY-OuterY)*pct;//InnerY+(OuterY-InnerY)*pct2;
    
    //if false then
    if FirstQuarter then
    begin
     if VertBorderWidth<>0 then
      ScaleX:=(VertBorderWidth*{convex(VertBorderWidth/DistRound,1,Pct2*w1)}w)/DistRound;//*(HorzBorderWidth/VertBorderWidth*abs(AlphaO-AlphaI)/(pi/2));

     //ScaleY:= perimeter/((VertInnerRadius)+(HorzInnerRadius));
    end else
    begin
     if HorzBorderWidth<>0 then
      ScaleY:=HorzBorderWidth*w/DistRound;
    end;
    (*
    if not FirstQuarter then
    begin
     if (HorzBorderWidth<>0) and (DistRound>HorzBorderWidth)  then
     begin
      assimilate:=roundrest(ProjY)*DistRound/HorzBorderWidth;
      if Abs(assimilate)<=0.5 then
       ProjY:=round(ProjY)+assimilate else
       ProjY:=round(ProjY-0.5)+0.5;
     end else
     if (HorzBorderWidth<>0) then
     begin
      assimilate:=Round2(ProjY,InnerY,HorzBorderWidth/round(DistRound));
      ProjY:=(assimilate)+(ProjY-assimilate)/(HorzBorderWidth/round(DistRound));
     end;
    end else
    begin
     if (VertBorderWidth<>0) and (DistRound>VertBorderWidth) then
     begin
      assimilate:=roundrest(ProjX)*DistRound/VertBorderWidth;
      if Abs(assimilate)<=0.5 then
       ProjX:=round(ProjX)+assimilate else
       ProjX:=round(ProjX-0.5)+0.5;
     end else
     if (VertBorderWidth<>0) and ((ProjX>OuterX-0.5) or (ProjX<InnerX+0.5)) then
     begin
      assimilate:=Round2(ProjX,InnerX,VertBorderWidth/round(DistRound));
      ProjX:=(assimilate)+(ProjX-assimilate)/(VertBorderWidth/round(DistRound));
     end;
    end;*)
   end;

     {
  if abs(alpha-0.5)<0.001 then
  begin
  Dst.PixelS[RP.X,RP.Y]:=clBlue32;//random(255) shl 16 or $FF000000;
  continue;
  end;    }

 if DistRound=0 then
  NewCol:=0 else
 begin
 if FirstQuarter then
  BorderClip:=FirstQuarterClip else
  BorderClip:=NonFirstQuarterClip;
  //BorderClip:=Rect(-1000,-1000,2000,2000);
  //NewCol:=Src.PixelS[P.X+multPX*round(projX),P.Y+multPY*round(projY)];
 if AntiAliaseCorner then
 begin
{.$DEFINE NEED_LINEAR_ANTIALIASING}
  //if (ScaleX=1) and (ScaleY=1) then
  // NewCol:=Src.PixelFDS[P.X+multPX*(projX-0.5),P.Y+multPY*(projY-0.5)] else
   NewCol:=ScaledCol(Src,P.X+multPX*(projX-0.5)+0.5,P.Y+multPY*(projY-0.5)+0.5,ScaleX,ScaleY,BorderClip);
 end else
 begin
  FinalPixel:=Point(Round(P.X+multPX*(projX-0.5)),Round(P.Y+multPY*(projY-0.5)));
  if PtInRect(BorderClip,FinalPixel) then
   NewCol:=Src.PixelS[FinalPixel.X,FinalPixel.Y] else
   NewCol:=0;
 end;
 end;
  //if false then
  if AntiAliaseCorner then
  begin
   if FirstQuarter and (projX<HorzInnerRadius-ScaleX/2) or not FirstQuarter and (projY<VertInnerRadius-ScaleY/2) then
   begin
    assert(NewCol shr 24=0);
    continue;
   end;
  end else
  begin
   if FirstQuarter and (projX<HorzInnerRadius) or not FirstQuarter and (projY<VertInnerRadius) then
   begin
    assert(NewCol shr 24=0);
    continue;
   end;
  end;
           
  //if false then
  if FirstQuarter and (projX>HorzOuterRadius+ScaleX/2) or not FirstQuarter and (projY>VertOuterRadius+ScaleY/2) then
  begin
   assert(NewCol shr 24=0);
   for x:=x-1 to HorzOuterRadius-1 do
   begin
    Dst.PixelS[RP.X,RP.Y]:=0;
    Inc(RP.X,multPX);
   end;
   break;
  end;

 if AntiAliaseCorner  then
 if FirstQuarter and (projX<HorzInnerRadius+ScaleX/2) or not FirstQuarter and (projY<VertInnerRadius+ScaleY/2) then
 begin
   NewCol2:=NewCol;
   OldCol:=Dst.PixelS[RP.X,RP.Y];
   if FirstQuarter then
    NewAlpha:=max(min(round(((HorzInnerRadius-projX)/ScaleX+0.5)*255),255),0) else
    NewAlpha:=max(min(round(((VertInnerRadius-projY)/ScaleY+0.5)*255),255),0);

   {if 255-integer(NewCol shr 24)-1(*für rundungsfehler*)>NewAlpha then
    OldCol:=(OldCol and $FFFFFF) or cardinal(min(255,max((NewAlpha*integer(OldCol shr 24)) div 255,0))) shl 24;
   PixelCombineNormal(NewCol,OldCol,255);
   NewCol:=OldCol;
   }
   if NewAlpha=255 then
    NewCol:=OldCol else
    NewCol:=_CombineReg(NewCol and $FFFFFF or min(round((NewCol shr 24)/((255-NewAlpha)/255)),255) shl 24,OldCol,255-NewAlpha);

 end;
 Dst.PixelS[RP.X,RP.Y]:=NewCol;


 end;
 end;

end;



procedure PaintBlur(_Src,SrcFinal:TMyBitmap32; pc:TPixelCombineMode; inv:boolean);
begin
 _Src.DrawMode:=dmCustom;
 (*
 case pc of
 pcNormal: _Src.OnPixelCombine:= self.PixelCombineNormal;
 pcMult: _Src.OnPixelCombine:= self.PixelCombineMultiply;
 pcNegMult: _Src.OnPixelCombine:= self.PixelCombineNegativeMultiply;//}_Src.OnPixelCombine:= self.PixelCombineNormal;
 end;                 *)
 if not inv then
  _Src.OnPixelCombine:= PixelCombineUnderpaint else
  _Src.OnPixelCombine:= PixelCombineInner;
 _Src.DrawTo(SrcFinal);
end;

var HorzRotated,VertRotated,IsEasy:boolean;
var c1,c2:int64;
    i:integer;
//    car:cardinal;

procedure NotTooBig(var L,R,L2,R2:integer; avail:integer; LDouble,RDouble:boolean);
var sL,sR:integer;
    done:boolean;
begin
 if L+R>avail then
 begin
  sL:=L;
  sR:=R;
  done:=false;
  if L>R then
  begin
   L:=avail-R;
   if L>=R then done:=true;
  end else
  begin
   R:=avail-L;
   if R>=L then done:=true;
  end;
  if not done then
  begin
   L:=avail div 2;
   R:=avail-L;
  end;
  //if sL=L2 then
  if not LDouble then
   Inc(L2,L-sL);
  //if sR=R2 then
  if not RDouble then
   Inc(R2,R-sR);
 end;
end;

        
procedure NotTooBig2(var Corner:TPoint; AvailX,AvailY:integer; IsDouble:boolean);
begin
 if Corner.X>AvailX then
 begin
  if not IsDouble then
   Corner.Y:=max(0,Corner.Y-(Corner.X-AvailX));
  Corner.X:=AvailX;
 end;
 if Corner.Y>AvailY then
 begin
  if not IsDouble then
   Corner.X:=max(0,Corner.X-(Corner.Y-AvailY));
  Corner.Y:=AvailY;
 end;
end;

procedure DoBlurEffects;
var Src2,SrcFinal:TMyBitmap32;
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

   Src2:=TMyBitmap32.Create;
   Src2.SetSize(Src.Width,Src.Height);
   SrcFinal:=TMyBitmap32.Create;
   SrcFinal.Assign(Src);
   try
   if Transformations.InnerGlow.Enabled then
   begin
    DoBlur(Src2,Transformations.InnerGlow,true);
    PaintBlur(Src2,SrcFinal,pcNegMult,true);
   end;
   if Transformations.InnerShadow.Enabled then
   begin
    DoBlur(Src2,Transformations.InnerShadow,true);
    PaintBlur(Src2,SrcFinal,pcMult,true);
   end;
   if Transformations.OuterGlow.Enabled then
   begin
    DoBlur(Src2,Transformations.OuterGlow,false);
    PaintBlur(Src2,SrcFinal,pcNegMult,false);
   end;
   if Transformations.OuterShadow.Enabled then
   begin
    DoBlur(Src2,Transformations.OuterShadow,false);
    PaintBlur(Src2,SrcFinal,pcMult,false);
   end;

   if Transformations.Blur.Enabled then
   begin
    Src.Clear(clWhite32);
    SrcFinal.DrawTo(Src);
    DoBlurPure(Src2,Transformations.Blur,0,true);
    DoBlurPure(Src2,Transformations.Blur,8,true);
    DoBlurPure(Src2,Transformations.Blur,16,true);
    Exch(Src2,Src);
    Src.Clear(clBlack32);
    SrcFinal.DrawTo(Src);
    Exch(Src2,SrcFinal);
    DoBlurPure(Src2,Transformations.Blur,0);
    DoBlurPure(Src2,Transformations.Blur,8);
    DoBlurPure(Src2,Transformations.Blur,16);
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
var Src2:TMyBitmap32;
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
var Src2:TMyBitmap32;
begin

  assert(bWidth=Src.Width); 

  Dec(nWidth,cr.Left+cr.Right);
  Dec(nHeight,cr.Top+cr.Bottom);
  Dec(bWidth,cr.Left+cr.Right);
  Dec(bHeight,cr.Top+cr.Bottom);

  //T.SrcRect:=FloatRect(0,0,Src.Width,Src.Height);
  //T.SrcRect:=FloatRect(0,0,bWidth,bHeight);
  T.SrcRect:=FloatRect(cr.Left,cr.Top,bWidth+cr.Left,bHeight+cr.Top);
  with T.GetTransformedBoundsf do
  if not IsEasy and HorzRotated then
   T.Translate(-Left+(nWidth/2)-((bWidth+nWidth) mod 2 / 2)-(Right-Left)/2,-Top+(nHeight/2)-((bHeight+nHeight) mod 2 / 2)-(Bottom-Top)/2) else
  if not IsEasy and VertRotated then
   T.Translate(-Left+(nWidth/2)-((bHeight+nWidth) mod 2 / 2)-(Right-Left)/2,-Top+(nHeight/2)-((bWidth+nHeight) mod 2 / 2)-(Bottom-Top)/2) else
   T.Translate(-Left+Round((nWidth/2){-((bHeight+nHeight) mod 2 / 2)}-(Right-Left)/2),-Top+Round((nHeight/2){-((bWidth+nWidth) mod 2 / 2)}-(Bottom-Top)/2));
   //T.Translate(-Left+(nWidth/2){-((bHeight+nHeight) mod 2 / 2)}-(Right-Left)/2,-Top+(nHeight/2){-((bWidth+nWidth) mod 2 / 2)}-(Bottom-Top)/2);

  Inc(nWidth,cr.Left+cr.Right);
  Inc(nHeight,cr.Top+cr.Bottom);
  Inc(bWidth,cr.Left+cr.Right);
  Inc(bHeight,cr.Top+cr.Bottom);

  T.Translate(cr.Left,cr.Top);

  T.Translate(glATShiftX, glATShiftY);

  T.SrcRect:=FloatRect(0,0,Src.Width,Src.Height);
//  if not NearSameMatrix(T.Matrix,IdentityMatrix) then
    begin

  Src.StretchFilter:=sfLinear;
  Src.StretchFilter:=sfNearest;
  Src.StretchFilter:=sfLanczos;
  Src.DrawMode:=dmBlend;
  Src.OnPixelCombine:= PixelCombineNormal;
  Src.DrawMode:=dmCustom;
  Src2:=TMyBitmap32.Create;
  Src2.SetSize(nWidth,nHeight);
  Src2.Clear(0);

  //ClearBit(Src.PixelPtr[0, 0],Src.Height*Src.Width);
    if IsRegular(Determinant(t.Matrix)) then
    begin
     Transform(Src2, Src, T);
    end;
    FreeAndNil(Src);
    Src:=Src2;
    Src.DrawMode:=dmBlend;
    end;

    { else
    begin
    FreeAndNil(Src2);
    result:=Src;
    end};

    if IsEasy then
    begin
     with EqArea do
      T.SrcRect:=FloatRect(Left,Top,Right,Bottom);
     EqArea:=T.GetTransformedBounds;
     EqArea.Left:=Between(EqArea.Left,0,Src.Width);
     EqArea.Right:=Between(EqArea.Right,0,Src.Width);
     EqArea.Top:=Between(EqArea.Top,0,Src.Height);
     EqArea.Bottom:=Between(EqArea.Bottom,0,Src.Height);
     //IntersectRect(EqArea,EqArea,Src.BoundsRect);
    end else
     EqArea.Left:=InvalidEqArea;

end;

procedure DoRoundCorners;
var SrcFinal:TMyBitmap32;
    bo,OuterRect,InnerRect:TRect;
    brTopLeft,brTopRight,brBottomLeft,brBottomRight:TPoint;
    AvailX,AvailY:integer;
var TopLeftDouble,TopRightDouble,BottomLeftDouble,BottomRightDouble:boolean;
begin

  if GetBorderRadii(brTopLeft,brTopRight,brBottomLeft,brBottomRight,TopLeftDouble,TopRightDouble,BottomLeftDouble,BottomRightDouble) then
  begin

   SrcFinal:=TMyBitmap32.Create;
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

   //SrcFinal.FillRect(InnerRect.Left,InnerRect.Top,InnerRect.Right,InnerRect.Bottom,0);
   maxit:=0;
{$IFNDEF CLX}
   QueryPerformanceCounter(c1);
{$ENDIF}
   RoundCorner(OuterRect,SrcFinal,Src,brTopLeft.X,brTopLeft.Y,bo.Top,bo.Left,alTop);
   RoundCorner(OuterRect,SrcFinal,Src,brBottomLeft.X,brBottomLeft.Y,bo.Bottom,bo.Left,alLeft);
   RoundCorner(OuterRect,SrcFinal,Src,brTopRight.X,brTopRight.Y,bo.Top,bo.Right,alRight);
   RoundCorner(OuterRect,SrcFinal,Src,brBottomRight.X,brBottomRight.Y,bo.Bottom,bo.Right,alBottom);
{$IFNDEF CLX}
   QueryPerformanceCounter(c2);
{$ENDIF}
{   if csDesigning in ComponentState then
    Application.MainForm.Caption:=inttostr((c2-c1) div 1000);//inttostr(maxit);
 }


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
  if EffectsAllowed and not IsEasy{ and CustomSizesForEffects} then
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

   Src.MasterAlpha:=Round(glTrans*255);
   MixAlpha(Src);
  end;

  AllOrTextOnly;
  if TextOnly then
  begin
   EqArea:=ShrinkRect(ShrinkRect(Src.BoundsRect,MarginPure),BorderPure);
   DoRoundCorners;
  end;

  //if PtInRect(Src.BoundsRect,EqArea.TopLeft) then Src.FrameRectS(EqArea,clRed32);

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

//für frame:
var Scrollbar3dlightColor,ScrollbarDarkshadowColor:TColor32;
    ScrollbarHighlightColor,ScrollbarShadowColor:TColor32;

    ScrollbarFaceColor,ScrollbarArrowColor,ScrollbarBaseColor:TColor32;
                                                                       
var Src:TMyBitmap32;

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

var It:integer;
    H, S, L : Single;

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

// It:=Intensity(ScrollbarBaseColor);
// RGBtoHSL(ScrollbarBaseColor, H, S, L);
// ScrollbarHighlightColor:=GoodRGB(RedComponent(ScrollbarBaseColor));
// ScrollbarHighlightColor:=HSLtoRGB(H,S/2,min(L+0.2+(1-L)*0.63,1));
// ScrollbarShadowColor:=HSLtoRGB(H,S,max(L*0.63+0.1,0));

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


procedure GetSlack(const ScrollInfo: TMyScrollInfo; Range,Pos:integer; var h,position:integer; inverse:boolean);
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
   //if not ((Parent is TdhCustomPanel) and not TdhCustomPanel(Parent).Visibility) then
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


{function FullOpaque(b:TMyBitmap32):boolean;
var x,y:integer;
begin
 for x:=0 to b.Width-1 do
 for y:=0 to b.Height-1 do
 if b.Pixel[x,y] shr 24<>$ff then
 if b.Pixel[x,y] shr 24<>$ff then
 begin
  result:=false;
  exit;
 end;
 result:=true;
end;
 }

function TdhCustomPanel.AlwaysVisibleVisibility:boolean;
begin
 result:=false;
end;


function TdhCustomPanel.CanBeTopPC:boolean;
begin
 result:=false;
end;


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
 if BackIsValid and (BackGraph.Height<>nHeight) then
  BackIsValid:=false;
 if TopIsValid  and ((TopGraph.Height<>nHeight)) then
  TopIsValid:=false; //note: next condition is dependent from this statement
 if BackIsValid and not TopIsValid and (BackGraph<>nil) and (BackGraph=TopGraph) then
  BackIsValid:=False;

 if not BackIsValid then
 begin
  if not Opaque then
  begin
   if BackGraph=nil then
    BackGraph:=TMyBitmap32.Create;
   BackGraph.SetSize(nWidth,nHeight);
   PaintOnlyBg:=glPaintOnlyBg;
   glPaintOnlyBg:=false;
   try
    //BackGraph.Clear(clYellow32);
    ParentPaintTo(Self,Parent,true,SelfCBound,SelfCBound,addheight,GetZOrder2(Self));
   finally
    glPaintOnlyBg:=PaintOnlyBg;
   end;
   BackIsValid:=true;    
   //BackGraph.ResetAlpha;

  if TopIsValid then
  if TransparentTop=nil then
   TopIsValid:=false else
  begin
   if BackIsValid and (BackGraph<>TopGraph) then
    BackGraph.DrawTo(TopGraph);//TopGraph.Canvas.Draw(0,0,BackGraph);

   //TransparentTop.OnPixelCombine:= PixelCombineNormal;
   //TransparentTop.DrawMode:=dmCustom;
   // TopGraph.ResetAlpha;
   TransparentTop.DrawTo(TopGraph);
  end;
  end;

 end;


 if not TopIsValid or NeedTransparentImage and (TransparentTop=nil) then
 begin
  if TopGraph=nil then
  if BackGraph<>nil then
   TopGraph:=BackGraph else
   TopGraph:=TMyBitmap32.Create;

  TopGraph.SetSize(nWidth,nHeight);
  if BackIsValid and (BackGraph<>TopGraph) and not TopIsValid then
   //TopGraph.Canvas.Draw(0,0,BackGraph);
   BackGraph.DrawTo(TopGraph);
  FreeAndNil(TransparentTop);

  if not Visibility and (not AlwaysVisibleVisibility or ((Parent is TdhCustomPanel) and not TdhCustomPanel(Parent).Visibility)) then
  begin
   if ((csDesigning in ComponentState) or IsDlg) and not ((Parent is TdhCustomPanel) and not TdhCustomPanel(Parent).Visibility) then
    PaintHidden;
   if NeedTransparentImage then
   begin
    TransparentTop:=TMyBitmap32.Create;
    TransparentTop.SetSize(nWidth,nHeight);
   end;
  end else
  if NeedTransparentImage or IsRasterized then
  begin
   TransparentTop:=TransPainting(nWidth,nHeight);
   {if not Visibility then
   begin
    //TransparentTop.Clear($00000000);
    TransparentTop.MasterAlpha:=64;
    MixAlpha(TransparentTop);
   end;}             
   if not TopIsValid then
   begin
    TransparentTop.DrawTo(TopGraph);
    //{TopGraph.ResetAlpha;} Sowohl Blend.DrawTo(Opaque) als auch TCanvas.Polygon kann alpha<$FF verursachen bei TopGraph
   end;
  end else
  if not TopGraph.Empty then
  begin
   BeginPainting(TopGraph);
   try
    DoTopPainting;
    //TopGraph.ResetAlpha;
   finally
    EndPainting;
   end;
  end;
  TopIsValid:=true;
 end;
end;

procedure TdhCustomPanel.BeginPainting(bmp:TMyBitmap32);
begin
   assert(ActTopGraph=nil);
   assert(not bmp.Empty);
   ActTopGraph:=bmp;
{$IFDEF CLX}
   //if not ActTopGraph.PixmapChanged then
{   if ValidBG then
    ActTopGraph.PixmapActive:=false;}
//   ActTopGraph.Canvas.Start;
{$ENDIF}
end;

procedure TdhCustomPanel.EndPainting;
begin
   assert(ActTopGraph<>nil);
{$IFDEF CLX}
//   ActTopGraph.Canvas.Stop;
{$ENDIF}
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
  {StretchBlt(FHandle, Dest.Left, Dest.Top, Dest.Right - Dest.Left,
    Dest.Bottom - Dest.Top, Canvas.Handle, Source.Left, Source.Top,
    Source.Right - Source.Left, Source.Bottom - Source.Top, CopyMode);   }
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
{    P:=Parent;
    if OnlyOneParent then
    begin
     if P<>nil then
      IntersectRect(Result,Result,GetClientBound(P));
    end else
    while P<>nil do
    begin
     IntersectRect(Result,Result,GetClientBound(P));
     P:=P.Parent;
    end;
    with GetCBound(Self) do OffsetRect(Result,-Left,-Top);}
end;


{$IFDEF CLX}

type TFakeWinControl2=class(TWinControl);
           (*
procedure TdhCustomPanel.AdjustPainter(Painter: QPainterH);
var
  R: TRect;
begin
  if (Parent.Width > 0) and (Parent.Height > 0) then
  begin
    R := TFakeWinControl2(Parent).ViewportRect;
    OffsetRect(R,-Left,-Top);
    //QPainter_translate(Painter, Left, Top);
    if Name='Panel11' then
    QPainter_setClipRect(Painter,0,0,100,100 {R.Left, R.Top, R.Right-R.Left, R.Bottom-R.Top});
  end;
end;         *)

procedure TdhCustomPanel.Paint;
var R:TRect;
begin
 if Parent=nil then exit;

 AssertTop(0);
 if HasSomething(TopGraph) then
 begin         

    {
    //clip TdhPage-scrollbars
    R:=GetNotClipped;
    IntersectRect(R,R,Canvas.ClipRect);
    //R := TFakeWinControl2(Parent).ViewportRect;
    //OffsetRect(R,-Left,-Top);
    if IsRectEmpty(R) then exit;
    QPainter_setClipRect(Canvas.Handle,@R);
    }

    TopGraph.DrawTo(Canvas.Handle,0,0);
 end;
end;

{$ELSE}

procedure TdhCustomPanel.PaintWindow(DC: HDC);
begin


 AssertTop(0);

 //Canvas.Draw(0,0,TopGraph);
 if HasSomething(TopGraph) then
 begin

  with ClientBound do CopyRect2(DC,Rect(0,0,Right-Left,Bottom-Top),TopGraph.Canvas,Rect(Left,Top,Right,Bottom));
{  if IsScrollArea and NCScrollbars then
   with ScrollArea do CopyRect2(DC,Rect(0,0,Right-Left,Bottom-Top),TopGraph.Canvas,Rect(Left,Top,Right,Bottom)) else
   CopyRect2(DC,ClientRect,TopGraph.Canvas,ClientRect);0
{ if Assigned(NotifyDebug) then
  NotifyDebug(Name+':'+inttostr(ClientRect.Bottom));}
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
{ if IsScrollArea and EdgesInScrolledArea then
  result:=TotalRect else
  result:=BorderClientRect;}
end;

function TdhCustomPanel.ScrollArea:TRect;
begin                     
 result:=ShrinkRect(DynamicTotalRect,ScrollArea_Edges);
 {result:=ScrollAreaWithScrollbars;
 result:=ShrinkRect(result,ScrollEdgesPure);}

end;









{
procedure TdhCustomPanel.CMMouseDown(var Message: TMessage);
begin
 UpdateMousePressed(true,DownIfDown);
 inherited;
end;

procedure TdhCustomPanel.CMMouseUp(var Message: TMessage);
begin
 UpdateMousePressed(false,DownIfDown)
 inherited;
end;
 }

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

procedure TdhCustomPanel.SetName(const Value: TComponentName);

function IsValidIdent(const Ident: string): Boolean;
const
  Alpha = ['A'..'Z', 'a'..'z', '_'];
  AlphaNumeric = Alpha + ['0'..'9'];
var
  I: Integer;
begin
  Result := False;
  if (Length(Ident) = 0) or not (Ident[1] in ['A'..'Z', 'a'..'z']) then Exit;
  for I := 2 to Length(Ident) do if not (Ident[I] in AlphaNumeric) then Exit;
  Result := True;
end;

begin
 if Name<>Value then
 begin
  if not (csDestroying in ComponentState) and (not IsValidIdent(Value)) then
   raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
  Inherited;
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
  { By default, Qt doesn't pass mouse messages to the transparent areas of
the widget. Uncomment the 2nd
    line below to get mouse messages }
  Result := inherited WidgetFlags
   {or Integer($00400000) }or Integer(WidgetFlags_WRepaintNoErase);
end;

function TdhCustomPanel.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
var c:TControl;
begin

(*  case QEvent_type(Event) of
    QEventType_MouseButtonPress,
    QEventType_MouseButtonRelease,
    QEventType_MouseButtonDblClick,
    QEventType_MouseMove:
    begin
      c := MyFindControl(self);
      if not MouseCapture then
      if {(c<>self) and (c is TdhCustomPanel)}classname='TMySiz' then
      begin
       TdhCustomPanel(c).MainEventFilter(Sender,Event);
       result:=False;
       exit;
      end;
    end;
  end;*)
  result:=inherited EventFilter(Sender,Event);
end;


procedure TdhCustomPanel.InitWidget;
const
  FocusPolicy: array[Boolean] of QWidgetFocusPolicy =
    (QWidgetFocusPolicy_ClickFocus, QWidgetFocusPolicy_NoFocus);
begin
 inherited;
 QWidget_setBackgroundMode(Handle, QWidgetBackgroundMode_NoBackground);
{ if classname='TMySiz' then
 begin

  QWidget_setMouseTracking(Handle, false);
  QWidget_setAcceptDrops(FHandle, false);
  QWidget_setFocusPolicy(Handle, FocusPolicy[true]);
 end;
 }        
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


 {if not Opaque then
 begin
  Canvas.Brush.Color := clMask;
  if not (TopIsValid and (TransparentTop<>nil)) then
   exit;//AssertTop(0,true);
  if TopIsValid and (TransparentTop<>nil) then
  for X:=0 to TransparentTop.Width-1 do
  for Y:=0 to TransparentTop.Height-1 do
  if AlphaComponent(TransparentTop.PixelS[X,Y]) = 0 then
  begin
   Canvas.Pixels[X,Y]:=clMask;
  end;
 end else
  exit;    }

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
var ParentWH:TPoint;
    i:integer;
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
 end{ else
 if not HasActiveStrong([akBottom]) then
  CSSBottom:=InvalidCSSPos};
 if CSSRight=InvalidCSSPos then
 begin
  i:=CSSBottom;
  WeakToStrong(true);
  CSSBottom:=i;
 end{ else
 if not HasActiveStrong([akRight]) then
  CSSRight:=InvalidCSSPos};
 DoCalcStrongToWeak(ALeft,ATop,AWidth,AHeight,GetLocalClientBound(Parent),Anchors,CSSRight,CSSBottom);

 {
 with GetLocalClientBound(Parent) do
  ParentWH:=Point(Right-Left,Bottom-Top);

 if akBottom in Anchors then
 if [akTop,akBottom]*Anchors=[akTop,akBottom] then
  AHeight:=ParentWH.Y-(CSSBottom+Top) else
  ATop:=ParentWH.Y-(CSSBottom+Height);

 if akRight in Anchors then
 if [akLeft,akRight]*Anchors=[akLeft,akRight] then
  AWidth:=ParentWH.X-(CSSRight+Left) else
  ALeft:=ParentWH.X-(CSSRight+Width);      }
end;



procedure TdhCustomPanel.StrongToWeak; //entspricht UpdateAnchorRules
var ALeft,ATop,AWidth,AHeight:integer;
begin
 if LightBoundsChanging{ or not HasActiveStrong([akBottom,akRight])} then exit;

 CalcStrongToWeak(ALeft,ATop,AWidth,AHeight);

 //assert(not LightBoundsChanging);
 LightBoundsChanging:=true;
 SetBounds(ALeft,ATop,AWidth,AHeight);
 LightBoundsChanging:=false;

end;

function TdhCustomPanel.HasActiveStrong(TestAnchors:TAnchors):boolean;
begin
  result:=((Align=alNone) and (TestAnchors*Anchors<>[]));
end;



//assumes that that the normal BoundsRect has more current data than CSSRight or CSSBottom
procedure TdhCustomPanel.WeakToStrong(IncludeActiveStrong:boolean);
var ParentWH:TPoint;
begin
 if LightBoundsChanging or (csReading in ComponentState) or (Parent=nil){ or not ((Align=alNone) and ([akBottom,akRight]*Anchors<>[]))} then exit;

 with GetLocalClientBound(Parent) do
  ParentWH:=Point(Right-Left,Bottom-Top);

 //if IncludeActiveStrong or (HasActiveStrong([akRight]){wichtig da z.b. Left nicht persistent war (-> =0), in StrongToWeak auch nicht geändert wurde (wegen HasActiveStrong dort) und nun Left mit undefiniertem Wert gelesen wird}) then
  CSSRight:=ParentWH.X-(Left+Width);

 //if IncludeActiveStrong or HasActiveStrong([akBottom]) then
  CSSBottom:=ParentWH.Y-(Top+Height);

end;


procedure TdhCustomPanel.ReadRight(Reader: TReader);
//var Right,ParentWidth:integer;
begin
 CSSRight:=Reader.ReadInteger;
 StrongToWeak;
 {
 with GetClientBound(Parent) do
  ParentWidth:=(Right-Left);
 if [akLeft,akRight]*Anchors=[akLeft,akRight] then
  Width:=ParentWidth-(Right+Left) else
  Left:=ParentWidth-(Right+Width); }
end;

procedure TdhCustomPanel.SetRight(const Value:integer);
begin         
 CSSRight:=Value;
 StrongToWeak;
end;

procedure TdhCustomPanel.WriteRight(Writer: TWriter);
var ParentWidth:integer;
begin
 {with GetClientBound(Parent) do
  ParentWidth:=(Right-Left);
 Writer.WriteInteger(ParentWidth-(Left+Width)); }
 Writer.WriteInteger(CSSRight);
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
 result:={not (Align in [alTop,alBottom,alClient]) and }(akRight in RealAnchors);
end;

function TdhCustomPanel.IsLeftStored:boolean;
begin
 result:=(akLeft in RealAnchors);
end;

procedure TdhCustomPanel.ReadBottom(Reader: TReader);
var Bottom,ParentHeight:integer;
begin
 {Bottom:=Reader.ReadInteger;
 with GetClientBound(Parent) do
  ParentHeight:=(Bottom-Top);
 if [akTop,akBottom]*Anchors=[akTop,akBottom] then
  Height:=ParentHeight-(Bottom+Top) else
  Top:=ParentHeight-(Bottom+Height);}
 CSSBottom:=Reader.ReadInteger;
 StrongToWeak;
end;

procedure TdhCustomPanel.SetBottom(const Value:integer);
begin
 CSSBottom:=Value;
 StrongToWeak;
end;


{function GetCSSBottomRight(Self:TControl):TPoint;
begin
 with GetClientBound(Self.Parent) do
 begin
  Result.X:=(Right-Left)-(Self.Left+Self.Width);
  Result.Y:=(Bottom-Top)-(Self.Top+Self.Height);
 end;
end;  }


procedure TdhCustomPanel.WriteBottom(Writer: TWriter);
var ParentHeight:integer;
begin
 {with GetClientBound(Parent) do
  ParentHeight:=(Bottom-Top);
 Writer.WriteInteger(ParentHeight-(Top+Height)); }
 Writer.WriteInteger(CSSBottom);
end;

function TdhCustomPanel.IsBottomStored:boolean;
begin
 result:={not (Align in [alLeft,alRight,alClient]) and }(akBottom in RealAnchors);
end;

function TdhCustomPanel.IsTopStored:boolean;
begin
 result:=(akTop in RealAnchors);
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
 DoDefineProperties(Filer);
end;

                                            {
procedure TdhCustomPanel.SetAutoSizeVertOnly(Value:Boolean);
begin
 SetAutoSizeVertOnly(Value);
end;                                         }


{procedure TdhCustomPanel.SetUse(Value:TControl);
var Common:TCommon;
begin
 if Value=nil then
  FCommon.SetUse(nil) else
 if HasCommon(Value,Common) then
  FCommon.SetUse(Common.Con);
end;

function TdhCustomPanel.GetUse:TControl;
begin
 if FCommon.FUse<>nil then
  result:=FCommon.FUse.GetCommon.Control else
  result:=nil;
end; }

function TdhCustomPanel.GetStyle(Index:TState):TStyle;
begin
 result:=StyleArr[Index];
end;

procedure TdhCustomPanel.SetStyle(Index:TState; Value:TStyle);
begin
 StyleArr[Index]:=Value;
end;






function CountSpace(const s:string):integer;
var i:integer;
begin
 result:=0;
 for i:=1 to length(s) do
 if s[i]=' ' then
  inc(result);
end;




procedure TdhCustomPanel.SetUse(Value:ICon);
var OldValue:ICon;
begin
  SUse:=EmptyStr;
  if FUse=Value then exit;
  {if (Value<>nil) and not (csDestroying in Control.ComponentState) and (GetTopForm(Value.GetCommon.Control)<>GetTopForm(Control)) then
  begin
   showmessage(NameWithForm(Control)+': The Use component must be on the same form');
   exit;
  end;  !! }
  if (Value<>nil) and (Self=Value.GetCommon) then
  begin
   //raise Exception.Create('"'+Value.GetName+'" is not a valid value due to causing a circular reference');
   ShowMessage('"'+Value.GetName+'" is not a valid value due to causing a circular reference');
   exit;
  end;
   //showmessage('Cannot use oneself');

  {sonst kann Body element kein Use setzen
  if (Value<>nil) and (Control is TWinControl) and TWinControl(Control).ContainsControl(Value.GetCommon.Control) then
  begin
   showmessage('Cannot inherit from child control');
   exit;
  end;    }
  if InUseList(Value,Self) then
  begin
   //raise Exception.Create('"'+Value.GetName+'" is not a valid value due to causing a circular reference');
   ShowMessage('"'+Value.GetName+'" is not a valid value due to causing a circular reference');
   exit;
  end;

  {P:=Value;
  while P<>nil do
  if P=Con then
  begin
   showmessage('Circular reference');
   exit;
  end else
   P:=P.GetCommon.FUse;}
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
// result:=RuntimeMode or (ActDown<>amNone) or CanUseMouseClick and  and;
 result:=false;
 if Message.Msg=WM_MOUSEWHEEL then
  showmessage('WM_MOUSEWHEEL');
 if Message.Msg=CM_MOUSEWHEEL then
  showmessage('CM_MOUSEWHEEL');
end;
{$ENDIF}

function TdhCustomPanel.DesignHitTest:boolean;
begin
 result:=RuntimeMode or (ActDown<>amNone) or CanUseMouseClick {and (Message.Msg >= WM_MOUSEMOVE) and (Message.Msg <= WM_MOUSEWHEEL){and ((Message.Msg = WM_LBUTTONUP) or (Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK) or (Message.Msg = WM_MOUSEMOVE))};
end;

{$IFDEF CLX}
function TdhCustomPanel.DesignEventQuery(Sender: QObjectH; Event: QEventH): Boolean;
begin
 result:=//Event is QMouseEventH and
  //(QEvent_type(Event) in [QEventType_MouseButtonPress,QEventType_MouseButtonRelease,QEventType_MouseButtonDblClick,QEventType_MouseMove])  and
  DesignHitTest;
end;
{$ELSE}
procedure TdhCustomPanel.CMDesignHitTest(var Message: TCMDesignHitTest);
{var HitIndex: Integer;
    HitTestInfo: TTCHitTestInfo;
}begin
//  HitTestInfo.pt := SmallPointToPoint(Message.Pos);
//  HitIndex := SendMessage(Handle, TCM_HITTEST, 0, Longint(@HitTestInfo));
  {if (HitIndex >= 0) and (HitIndex <> TabIndex) then} //Message.Result := 0;
  //inherited;

{  if (Message.Msg = WM_RBUTTONDOWN) or
     (Message.Msg = WM_RBUTTONUP) or
     (Message.Msg = WM_RBUTTONDBLCLK) then
  begin
   Message.Result:=0;
   exit;
  end;    }       
  Message.Result:=0;
//  if not(ssRight in KeysToShiftState(Message.Keys)) then
  if RuntimeMode or (ActDown<>amNone) or CanUseMouseClick{ and (Message.Msg >= WM_MOUSEFIRST) and (Message.Msg <= WM_MOUSELAST)}{and ((Message.Msg = WM_LBUTTONUP) or (Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK) or (Message.Msg = WM_MOUSEMOVE))} then
   Message.Result:=1;
      //Message.Result:=1;
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
  if not (TopIsValid and (TransparentTop<>nil)) then
   AssertTop(0,true);
  if TopIsValid and (TransparentTop<>nil) then
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
 //P:=ScreenToClient(Point(Message.XPos,Message.YPos));

 if not ((P.X >= 0) and (P.Y >= 0) and (P.X < Width) and (P.Y < Height)) then
 begin //wird nie verzweigt bisher
  Message.Result := Windows.HTNOWHERE;
  exit;
 end;
 if (csDesigning in ComponentState) and (Parent <> nil) and not RuntimeMode then
 begin
  //DefaultHandler(Message);
  //Message.Result:=HTBORDER;
  //Message.Result:=HTVSCROLL;
  Message.Result := HTCLIENT;
  //inherited;
  exit;
 end;
 if not AcceptClick(P) then
 begin
    Message.Result := Windows.{HTNOWHERE}HTTRANSPARENT;
    exit;
 end;
 //inherited;
 (*if {not PtInRect(P,ScrollArea) and }CanUseMouseClick then
 begin
  Message.Result:=HTVSCROLL;
  Message.Result:=HTBORDER;
  //exit;
//  SetCapture(d
 end;*)
  Message.Result:=HTCLIENT;

// DefaultHandler(Message);

end;

{$ELSE}


function TdhCustomPanel.HitTest(X, Y: Integer): Boolean;
begin
  Result := Inherited HitTest(X,Y) and AcceptClick(Point(X,Y));
end;

{$ENDIF}



{Type TCWPStruct = Packed record
    lParam: LPARAM;
    wParam: WPARAM;
    message: integer;
    wnd: HWND;
  End;
         }

function iControlAtPos(c:TWinControl; const pt: TPoint):TControl;
var i,ri:integer;
    cc:TControl;
    rct:TRect;
begin
 result:=nil;
 ri:=0;
 //bei CLX ist ActiveMDIChild=MDIChildren[0] nicht gegeben
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
// if not((result<>nil) and (GetZOrder(result,ri)>GetZOrder(cc,i))) then
 begin
   result:=cc;
   ri:=i-TForm(c).MDIChildCount;
   break;
 end;
 end;
 end;

 //if result=nil then
 for i:=0 to c.ControlCount-1 do
 begin
 cc:=c.Controls[i];
 rct:=GetCBound(cc);
 if PtInRect(rct,pt) and FinalVisible(cc) and (cc.ClassName<>'TMySiz') and not ((csDesigning in c.ComponentState) and (c.Owner<>cc.Owner) and not (csAncestor in cc.ComponentState)) then
 if not((result<>nil) and (GetZOrder(result,ri)>GetZOrder(cc,i))) then
 begin
   result:=cc;
   ri:=i;
     //break;
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
 if {(result.ClassName='TMySiz')) and }(result.Owner is TWinControl){ and not (result is TCustomForm)} then
  result:=iControlAtPos(GetVeryTop(result),Mouse.CursorPos) else
  result:=iControlAtPos(TWinControl(result),Mouse.CursorPos);

 //if (result<>nil) and (result.Owner is TWinControl) and (not NeedDesigning or not (csDesigning in result.ComponentState)){(result.ClassName='TMySiz')} then
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
   {if (cc<>nil) and (cc.Owner is TScrollingWinControl) then
    cc:=TScrollingWinControl(cc);  }
    {if cc<>nil then
     showmessage(cc.ClassName);
                                   }
  {GetCursorPos(P);
  c := FindDragTarget(P, True);
  if (cc<>nil) and (cc.ContainsControl(c)) then }

  //  showmessage(inttostr(result));
  while c<>nil do
  begin
    if (c<>nil){ and (c.Parent=nil) }and (c is TScrollingWinControl) then
    begin
     sm:=-WheelDelta;
     fin:=min(max(0,TScrollingWinControl(c).VertScrollBar.Position+sm),TScrollingWinControl(c).VertScrollBar.Range);
     if TScrollingWinControl(c).VertScrollBar.Position<>fin then
     begin
      if {(c is TCustomForm) or (c is TCustomFrame)}c is TScrollingWinControl then
      begin
       (c as TScrollingWinControl).VertScrollBar.Position:=fin;
       c.Repaint;  //nur TdhPanel-scroll machen}
      end;
      result:=true;
      //c.Update;
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
    ////break;
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

  Rect := Types.Rect(0,0,AControl.Width,AControl.Height);//AControl.ClientRect wäre falsch
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

function GoodWin(c:TControl):TWinControl;
begin
 if (c=nil) or (c is TWinControl) then
  result:=TWinControl(c) else
  result:=c.Parent;
end;





{$ENDIF}


procedure TdhCustomPanel.DoClickAction(Initiator:TdhCustomPanel);
begin
 //do nothing
end;




var OldOnIdle:TIdleEvent;
    ObjIdleProc:TObjIdleProc;

var glerrorlog:string;


procedure TObjIdleProc.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
var s,ss:string;
    sl:TStringList;
begin
{$IFDEF DEB}
 sl:=TStringList.Create;
 JclLastExceptStackListToStrings(sl,not false,not false,not false);

 s:=Format('Exception %s: %s at %s',
    [E.ClassName, E.Message, {GetLocationInfoStr(ExceptAddr,true,true,true)}sl.Text]);

 glerrorlog:=glerrorlog+#13#10+#13#10+#13#10+timetostr(now)+#13#10+s;
 StringToFile('c:\z.txt',glerrorlog);

 sl.Free;
{$ENDIF}
end;

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
      //FMouseControl.Perform(CM_MOUSELEAVE, 0, 0);
    if not (Result is TdhCustomPanel) then Result:=nil;
//    if (Result<>nil) and (Result.Name='SubMenu2') then
     //Result := FindDragTarget(P, True);

    FMouseControl := Result;
    if ((FMouseControl <> nil) and (CaptureControl = nil)) or
      ((CaptureControl <> nil) and (FMouseControl = CaptureControl)) then
      if (FMouseControl is TdhCustomPanel) then TdhCustomPanel(FMouseControl).SetIsOver(true);
      //FMouseControl.Perform(CM_MOUSEENTER, 0, 0);
  end;
end;
            {

function TdhCustomPanel.DownIfOver:boolean;
begin

 result:=(FSubMenu<>nil) or (aoDownIfMouseDown in FAnchorOptions) or (aoDownIfURL in FAnchorOptions) and (FLinkTab<>nil) and (FLinkTab.PageControl is TdhPageControl) and TdhPageControl(FLinkTab.PageControl).UseIFrame;
end;            }



{function TStyle.ReadPadding(Align: TEdgeAlign): TCSSCardinal;
begin

 case Align of
 alLeft:   result:=FPaddingLeft;
 alRight:  result:=FPaddingRight;
 alTop:    result:=FPaddingTop;
 alBottom: result:=FPaddingBottom;
 else      result:=FPadding;
 end;
end;
}
procedure TStyle.AssignBackground(s: TStyle);
begin
 if s<>nil then
 begin
    //FBackgroundColor:=s.FBackgroundColor;
    FBackgroundAttachment:=s.FBackgroundAttachment;
    FBackgroundRepeat:=s.FBackgroundRepeat;
    FBackgroundPosition:=s.FBackgroundPosition;
    FBackgroundImage.Assign(s.FBackgroundImage);
    pcs(pcChanges[pcBackgroundAttachment]+pcChanges[pcBackgroundRepeat]+pcChanges[pcBackgroundPosition]+pcChanges[pcBackgroundImage]);
 end;
end;


function TStyle.IsBGImageCleared:boolean;
begin
 result:=not IsPictureStored and
        (FBackgroundPosition=EmptyStr) and (FBackgroundRepeat=cbrInherit) and (FBackgroundAttachment=cbaInherit);
end;

procedure TStyle.LoadImage(const filename:string);
begin
 FBackgroundImage.LoadFromFile(filename);
 pc(pcBackgroundImage);
end;

procedure TStyle.AssignEdge(Align:TEdgeAlign; s: TStyle);
begin
  FMargins[Align]:=s.FMargins[Align];
  FPaddings[Align]:=s.FPaddings[Align];
  FBorders[Align].Assign(s.FBorders[Align]);
  pcs(pcChanges[pcMargin]+pcChanges[pcPadding]+(pcChanges[pcBorderWidth]+pcChanges[pcBorderColor]+pcChanges[pcBorderStyle]));
end;

function TStyle.IsEdgeCleared(Align:TEdgeAlign):boolean;
begin
 result:=not FBorders[Align].IsStored and (FMargins[Align]=MarginDefault) and (FPaddings[Align]=vsrInherit);
end;

procedure TStyle.AssignComputedEdge(Align:TEdgeAlign; pn: TdhCustomPanel);
begin
  FMargins[Align]:=inttostr(pn.MarginWidth(Align));
  FPaddings[Align]:=pn.PaddingWidth(Align);
  FBorders[Align].AssignComputed(pn,Align);
  pcs(pcChanges[pcMargin]+pcChanges[pcPadding]+(pcChanges[pcBorderWidth]+pcChanges[pcBorderColor]+pcChanges[pcBorderStyle]));
end;
                                           {
function TdhCustomPanel.GetAutoSizeHorzOnly: boolean;
begin
 result:=FAutoSizeHorzOnly;
end;

procedure TdhCustomPanel.SetAutoSizeHorzOnly(const Value: boolean);
begin
 SetAutoSizeHorzOnly(Value);
end;                                        }

procedure TdhCustomPanel.Invalidate;
begin
 inherited;
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
   //WeakToStrong;
  end;
  //Masked:=true;
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
 //if not Visible then exit;
 if HandleAllocated then
  InvalBack(GetCBound(Self));
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


{procedure TStyle.SetAntiAliasing(Value: TCSSAntiAliasing);
begin
 FAntiAliasing:=Value;
 Changed([wcFont]);
end;}

procedure TdhCustomPanel.SetASXY(const Value: TASXY);
begin
  FAutoSize := Value;
  AdjustSize;
end;




procedure TCSSBorderRadius.Assign(Source: TPersistent);
var tt:TCSSBorderRadius;
begin
  if Source is TCSSBorderRadius then
  begin
    tt:=TCSSBorderRadius(Source);
    self.All:=tt.All;
    self.TopLeft:=tt.TopLeft;
    self.BottomRight:=tt.BottomRight;
    self.BottomLeft:=tt.BottomLeft;
    self.TopRight:=tt.TopRight;
    Changed;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TCSSBorderRadius.Clear;
begin
    All:=EmptyStr;
    TopLeft:=EmptyStr;
    BottomRight:=EmptyStr;
    BottomLeft:=EmptyStr;
    TopRight:=EmptyStr;
end;

function TCSSBorderRadius.IsCleared:boolean;
begin
 result:=(All=EmptyStr) and (TopLeft=EmptyStr) and (BottomRight=EmptyStr) and (BottomLeft=EmptyStr) and (TopRight=EmptyStr);
end;

function TCSSBorderRadius.IsCleared(align:TCornerAlign):boolean;
begin
 result:=Vals[align]=EmptyStr;
end;

procedure TTransformations.Assign(Source: TPersistent);
var tt:TTransformations;
begin
  if Source is TTransformations then
  begin
    tt:=TTransformations(Source);
    //self.FPartPoint:=tt.FPartPoint;
    self.FShiftX:=tt.FShiftX;
    self.FShiftY:=tt.FShiftY;
    self.FRotationDegree:=tt.FRotationDegree;
    self.FStretchLinear:=tt.FStretchLinear;
    self.FStretchParted:=tt.FStretchParted;
    self.FShiftEnabled:=tt.FShiftEnabled;
    self.FRotateEnabled:=tt.FRotateEnabled;
    self.FScaleX:=tt.FScaleX;
    self.FScaleY:=tt.FScaleY;
    self.FSkewX:=tt.FSkewX;
    self.FSkewY:=tt.FSkewY;
    self.FEnabled:=tt.FEnabled;
    self.FAntiAliasing:=tt.FAntiAliasing;
    self.FText:=tt.FText;
    self.FFullIfEasy:=tt.FFullIfEasy;
    self.FUseBased:=tt.FUseBased;
    self.FAlpha:=tt.FAlpha;
    self.OuterShadow.Assign(tt.OuterShadow);
    self.InnerShadow.Assign(tt.InnerShadow);
    self.OuterGlow.Assign(tt.OuterGlow);
    self.InnerGlow.Assign(tt.InnerGlow);
    self.Blur.Assign(tt.Blur);
    Changed;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TTransformations.SetRotateEnabled(const Value: boolean);
begin
  FRotateEnabled := Value;
  Changed;
end;



procedure TTransformations.SetRotationDegree(const Value: integer);
begin
  FRotationDegree := Value;
  Changed;
end;

procedure TTransformations.SetShiftEnabled(const Value: boolean);
begin
  FShiftEnabled := Value;
  Changed;
end;

procedure TTransformations.SetStretchLinear(const Value: boolean);
begin
  FStretchLinear := Value;
  Changed;
end;

procedure TTransformations.SetStretchParted(const Value: boolean);
begin
  FStretchParted := Value;
  Changed;
end;

procedure TTransformations.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
  Changed;
end;

procedure TTransformations.Changed;
begin
  if Owner<>nil then
   Owner.pc(pcEffects);
end;

procedure TCSSBorderRadius.Changed;
begin
  if Owner<>nil then
   Owner.pc(pcBorderRadius);
end;


procedure ClearX87Exceptions;
{ clears pending FPU exceptions.}
ASM
  FNCLEX
end;


               {
function TTransformations.IsScaleXStored: Boolean;
begin
try
  result:=FScaleX<>1;
except
  result:=FScaleX<>1;
end;
end;

function TTransformations.IsScaleYStored: Boolean;
begin
  result:=ScaleY<>1;
end;

function TTransformations.IsSkewXStored: Boolean;
begin
  result:=SkewX<>0;
end;

function TTransformations.IsSkewYStored: Boolean;
begin
  result:=SkewY<>0;
end;     }

procedure TTransformations.SetAntiAliasing(const Value: boolean);
begin
  FAntiAliasing := Value;
  Changed;
end;

procedure TTransformations.SetFullIfEasy(const Value: boolean);
begin
  FFullIfEasy := Value;
  Changed;
end;

procedure TTransformations.SetAlpha(const Value: byte);
begin
  FAlpha := Value;
  Changed;
end;

procedure TTransformations.SetScaleX(const Value: integer);
begin
  FScaleX := Value;
  Changed;
end;

procedure TTransformations.SetScaleY(const Value: integer);
begin
  FScaleY := Value;
  Changed;
end;

procedure TTransformations.DefineProperties(Filer: TFiler);
begin
 inherited;
 Filer.DefineProperty('FullIfEasy', SkipValue, nil, false);
 Filer.DefineProperty('UseBased', SkipValue, nil, false);
end;

procedure TTransformations.SkipValue(Reader: TReader);
begin
 _SkipValue(Reader);
end;

procedure TTransformations.SetShiftX(const Value: integer);
begin
  FShiftX := Value;
  Changed;
end;

procedure TTransformations.SetShiftY(const Value: integer);
begin
  FShiftY := Value;
  Changed;
end;

procedure TTransformations.SetSkewX(const Value: integer);
begin
  FSkewX := Value;
  Changed;
end;

procedure TTransformations.SetSkewY(const Value: integer);
begin
  FSkewY := Value;
  Changed;
end;

procedure TTransformations.SetUseBased(const Value: boolean);
begin
  FUseBased := Value;
  Changed;
end;

function TTransformations.IsCleared:boolean;
begin
  result:=not FEnabled and IsMainCleared and IsBlurEffectsCleared and IsTransformationsCleared;
end;

function TTransformations.IsMainCleared:boolean;
begin
 result:=not FAntiAliasing and not TextOnly and not TextExclude and not FUseBased and FFullIfEasy;
end;

function TTransformations.IsTransformationsCleared:boolean;
begin
 result:=(FRotationDegree=0) and (FAlpha=255) and (FShiftX=0) and (FShiftY=0) and (FScaleX=100) and (FScaleY=100) and (FSkewX=0) and (FSkewY=0);
end;

function TTransformations.IsBlurEffectsCleared:boolean;
begin
 result:=FInnerShadow.IsCleared and FOuterShadow.IsCleared and FInnerGlow.IsCleared and FOuterGlow.IsCleared and FBlur.IsCleared;
end;


{
function TTransformations.IsCleared:boolean;
begin
  result:=not FEnabled and
          (FRotationDegree=0) and (FAlpha=255) and (FShiftX=0) and (FShiftY=0) and (FScaleX=100) and (FScaleY=100) and (FSkewX=0) and (FSkewY=0) and
          not FAntiAliasing and not FTextOnly and not FUseBased and FFullIfEasy and
          FInnerShadow.IsCleared and FOuterShadow.IsCleared and FInnerGlow.IsCleared and FOuterGlow.IsCleared and FBlur.IsCleared;
end;
}

procedure TTransformations.Clear;
begin
   FScaleX:=100;
   FScaleY:=100;
   FAntiAliasing:=not true;
   FText:=etInclude;
   FFullIfEasy:=true;
   FAlpha:=255;
   FInnerShadow.Clear;
   FOuterShadow.Clear;
   FInnerGlow.Clear;
   FOuterGlow.Clear;
   FBlur.Clear;

   FShiftY:=0;
   FShiftX:=0;
   FEnabled:=false;
   FUseBased:=false;
   FRotationDegree:=0;
   FSkewX:=0;
   FSkewY:=0;

   Changed;
end;

{ TBlur }

procedure TShadow.Clear;
begin
  FEnabled:=false;
  FAlpha:=191;
  FDeciRadius:=50;
  FColor:=colShadowDefault;
  FFlood:=0;
  FDegree:=120;
  FDistance:=5;
end;

function TShadow.IsCleared:boolean;
begin
 result:=not FEnabled and (FAlpha=191) and (FDeciRadius=50) and (FColor=colShadowDefault) and (FFlood=0) and (FDegree=120) and (FDistance=5);
end;


constructor TShadow.Create(AOwner: TTransformations);
begin
 Inherited Create;
 Owner:=AOwner;
 Clear;
end;

procedure TBlurEffect.Assign(Source: TPersistent);
var tt:TTransformations;
begin
  if Source is TBlurEffect then
  with TBlurEffect(Source) do
  begin
    Self.FDegree:=FDegree;
    Self.FDistance:=FDistance;
    Self.FAlpha:=FAlpha;
    Self.FDeciRadius:=FDeciRadius;
    Self.FColor:=FColor;
    Self.FFlood:=FFlood;
    Self.FEnabled:=FEnabled;
  end else
   Inherited;
end;

function TBlurEffect.MaxJitter:integer;
begin
 if FEnabled then
  result:=Ceil(GetDoubleRadius)+FDistance else
  result:=0;
end;

constructor TBlur.Create(AOwner: TTransformations);
begin
 inherited Create;
 Owner:=AOwner;
 Clear;
end;

procedure TBlur.Clear;
begin
 FEnabled:=false;
 FDeciRadius:=50;
end;

function TBlur.IsCleared:boolean;
begin
 result:=not FEnabled and (FDeciRadius=50);
end;


{ TGlow }

procedure TGlow.Clear;
begin
  FEnabled:=false;
  FAlpha:=191;
  FDeciRadius:=50;
  FColor:=colGlowDefault;
  FFlood:=0;
end;

function TGlow.IsCleared:boolean;
begin
 result:=not FEnabled and (FAlpha=191) and (FDeciRadius=50) and (FColor=colGlowDefault) and (FFlood=0);
end;


constructor TGlow.Create(AOwner: TTransformations);
begin
 Inherited Create;
 Owner:=AOwner;
 Clear;
end;

type
  TDWORDArray = Array[Word] of DWORD;
  pDWORDArray = ^TDWORDArray;

procedure NormalizeOpaque(Transparent:TMyBitmap32; Opaque:TMyBitmap32);
var P,P2: PColor32;
    i:integer;
begin
   assert((Transparent.Width=Opaque.Width) and (Transparent.Height=Opaque.Height));
   P:=Transparent.PixelPtr[0,0];
   P2:=Opaque.PixelPtr[0,0];
   for i:=0 to Transparent.Width*Transparent.Height-1 do
   begin
     if P^ shr 24=$00 then
      P2^:=$0 else //if fully transparent, then take this one color
      P2^:=P2^ or $FF000000; //otherwise set full opacity
     Inc(P);
     Inc(P2);
   end;
end;

{.$IFNDEF CLX}


function AddGIFSubImageFromBitmap32(Transparent:TBitmap32; Opaque:TBitmap32; GIF:TGIFImage; Loop:boolean=false; CopyFrom:TGIFSubImage=nil; PrevSubImage:TGIFSubImage=nil):TGIFSubImage;
var y,x,i:integer;
var P,P2,P3: PColor32;
    bp:pByteArray;
    bt:TBitmap;
    PP : pDWORDArray;
    Ext : TGIFGraphicControlExtension;
    LoopExt: TGIFAppExtNSLoop;
    TransparentIndex	: integer;
    TransparentIndex2	: integer;
    WasTransparent:boolean;
    GIFSubImage:TGIFSubImage;
    ba,ba2:PByteArray;
    imageIndex:integer;
    DelayMS:Word;
    png:TPNGObject;
begin

  if (CopyFrom<>nil) and (CopyFrom.GraphicControlExtension<>nil) then
   DelayMS:=CopyFrom.GraphicControlExtension.Delay else
   DelayMS:=0;

  bt:=TBitmap.Create;
  //bt.PixelFormat:=pf24bit;
  bt.PixelFormat:=pf32bit;


  {bt.Transparent:=true;
  bt.TransparentColor:=0;
  Problem: bt.TransparentColor verschmilzt mit ähnlicher Farbe im Bild
   }


  {png:=TPNGObject.Create;
  png.CompressionLevel:=9;
  png.AssignHandle(Opaque.BitmapHandle,false,0); 
  bt.Assign(png);
  png.Free;   }

  bt.Width:=Opaque.Width;
  bt.Height:=Opaque.Height;
  //Opaque.DrawTo(bt.Canvas.Handle,0,0);
  bt.Canvas.CopyRect(Opaque.BoundsRect,Opaque.Canvas,Opaque.BoundsRect);
//  bt.Assign(Opaque);


  WasTransparent:=false;
  if Transparent<>nil then
  begin
   P:=Transparent.PixelPtr[0,0];
   for y:=0 to Transparent.Height-1 do
   begin
    pp:=bt.ScanLine[y];
    for x:=0 to Transparent.Width-1 do
    begin
     if P^ shr 24=$00 then
     begin
      WasTransparent:=true;
      pp[x]:=$0;
     end;
     inc(P);
    end;
   end;
  end;


  imageIndex:=GIF.Add(bt);
  bt.Free;

  GIFSubImage:=GIF.Images[imageIndex];
  result:=GIFSubImage;

  if Loop and (imageIndex=0) then //siehe FTGifAnimate
  begin
    LoopExt := TGIFAppExtNSLoop.Create(GIFSubImage);
    LoopExt.Loops := 0; // Number of loops (0 = forever)
    for i := 0 to CopyFrom.Extensions.Count-1 do
    if (CopyFrom.Extensions[i] is TGIFAppExtNSLoop) then
     LoopExt.Loops:=TGIFAppExtNSLoop(CopyFrom.Extensions[i]).Loops;
    GIFSubImage.Extensions.Add(LoopExt);
  end;

  Ext:=nil;
  if WasTransparent then
  begin
    //GIF.Transparent:=true;

    GIFSubImage.ColorMap.Optimize;
    // Can't make transparent if no color or colormap full
    if not((GIFSubImage.ColorMap.Count = 0) or (GIFSubImage.ColorMap.Count = 256)) then
    begin

      // Add the transparent color to the color map
      TransparentIndex := GIFSubImage.ColorMap.Add{Unique}(TColor({ $112211}$0));

      Ext:=TGIFGraphicControlExtension.Create(GIFSubImage);
      Ext.Transparent := True;
      //TransparentIndex:=result.Images[0].Pixels[TransparentX,TransparentY];
      Ext.TransparentColorIndex := TransparentIndex;
      Ext.Delay := DelayMS{ div 10};  // 30; // Animation delay (30 = 300 mS)
      GIFSubImage.Extensions.Add(Ext);

//      GIFSubImage.ColorMap.Optimize;
      Assert(TransparentIndex=GIFSubImage.GraphicControlExtension.TransparentColorIndex);


       P:=Transparent.PixelPtr[0,0];
       for y:=0 to Transparent.Height-1 do
       begin
        ba:=GIFSubImage.ScanLine[y];
        for x:=0 to Transparent.Width-1 do
        begin
         if P^ shr 24=$00 then
          ba[x]:=TransparentIndex;
         inc(P);
        end;
       end;
       //GIFSubImage.ColorMap.Optimize;

    end;
  end;

  if (Ext=nil) and (DelayMS<>0) then
  begin
      Ext:=TGIFGraphicControlExtension.Create(GIFSubImage);
      Ext.Delay := DelayMS{ div 10};  // 30; // Animation delay (30 = 300 mS)
      //GIFSubImage.Extensions.Insert(0,Ext);
      GIFSubImage.Extensions.Add(Ext);
  end;

  {if GIFSubImage.GraphicControlExtension<>nil then
   GIFSubImage.GraphicControlExtension.Disposal:=dmBackground;
   exit; }
  if (PrevSubImage<>nil) and (PrevSubImage.Height=GIFSubImage.Height)  and (PrevSubImage.Width=GIFSubImage.Width) and GIFSubImage.Transparent and (PrevSubImage.GraphicControlExtension<>nil) then
  begin
       //GIFSubImage.GraphicControlExtension.Disposal:=dmNoDisposal;
       TransparentIndex:=GIFSubImage.GraphicControlExtension.TransparentColorIndex;
       if PrevSubImage.GraphicControlExtension<>nil then
        TransparentIndex2:=PrevSubImage.GraphicControlExtension.TransparentColorIndex else
        TransparentIndex2:=-1;
       for y:=0 to GIFSubImage.Height-1 do
       begin
        ba:=GIFSubImage.ScanLine[y];
        ba2:=PrevSubImage.ScanLine[y];
        for x:=0 to Transparent.Width-1 do
        begin
         if (ba[x]=TransparentIndex) and (ba2[x]<>TransparentIndex2) then
         begin
          PrevSubImage.GraphicControlExtension.Disposal:=dmBackground;
          //GIFSubImage.GraphicControlExtension.Disposal:=dmBackground;
          exit;
         end;
        end;
       end;
{  if (PrevSubImage.GraphicControlExtension<>nil) and (imageIndex=27) then
   GIFSubImage.GraphicControlExtension.Disposal:=dmNoDisposal;
   transparent.SaveToFile('c:\bm.bmp');
   opaque.SaveToFile('c:\bm2.bmp');
   if (imageIndex)=0 then
   exit;}
  end; 

end;

function GetNewGif:TGifImage;
begin
  result:=TGifImage.Create;
  result.ColorReduction:=rmPalette;
  result.ColorReduction:=rmQuantize;
  result.DitherMode := dmFloydSteinberg;
  result.Compression := gcLZW;
end;

        
procedure CloseGif(GIF:TGifImage);
begin
 GIF.Optimize([{ooCrop, Opera cannot deal with cropping: treats as if cropped edges not exist}ooMerge,ooCleanup,ooColorMap],GIF.ColorReduction,GIF.DitherMode,GIF.ReductionBits);
  //result.OptimizeColorMap;
end;

function GetGifImageFromBitmap32(Transparent:TBitmap32; Opaque:TBitmap32):TGifImage;
begin
  result:=GetNewGif;
  AddGIFSubImageFromBitmap32(Transparent,Opaque,result);
  CloseGif(result);
end;

(*
function GetIconFromBitmap32(Transparent:TMyBitmap32; Opaque:TMyBitmap32):TIcon;
var b:TBitmap;
begin
  result:=TIcon.Create;
  b:=TBitmap.Create;
  b.Assign(Opaque);
  b.Width:=16;
  b.Height:=16;
  result.
  result.Assign(b);
  //result.Assign(Opaque);
  b.Free;
  result.Transparent:=true;
{  AddGIFSubImageFromBitmap32(Transparent,Opaque,result);
  CloseGif(result);}
end;
*)



(*
function GetGifImageFromBitmap32(Transparent:TMyBitmap32; Opaque:TMyBitmap32):TGifImage;
var y,x:integer;
var P,P2,P3: PColor32;
    bp:pByteArray;
    bt:TBitmap;
    PP : pDWORDArray;
    GCE : TGIFGraphicControlExtension;
    TransparentIndex	: integer;
    WasTransparent:boolean;
    GIFSubImage:TGIFSubImage;
    ba:PByteArray;
begin
  bt:=TBitmap.Create;
  bt.PixelFormat:=pf24bit;

        {
  WasTransparent:=false;
  if Transparent<>nil then
  begin
   P:=Transparent.PixelPtr[0,0];
   for y:=0 to Transparent.Height-1 do
   begin
    //pp:=bt.ScanLine[y];
    for x:=0 to Transparent.Width-1 do
    begin
     if P^ shr 24=$00 then
     begin
      WasTransparent:=true;
      pp[x]:=$00000000;
     end;
     inc(P);
    end;
   end;
  end;    }

  bt.Assign(Opaque);

  WasTransparent:=false;
  if Transparent<>nil then
  begin
   P:=Transparent.PixelPtr[0,0];
   for y:=0 to Transparent.Height-1 do
   begin
    pp:=bt.ScanLine[y];
    for x:=0 to Transparent.Width-1 do
    begin
     if P^ shr 24=$00 then
     begin
      WasTransparent:=true;
      pp[x]:=$0;
     end;
     inc(P);
    end;
   end;
  end;


  result:=TGifImage.Create;
  result.ColorReduction:=rmPalette;
  result.ColorReduction:=rmQuantize;
//  result.ColorReduction:=rmNetscape;
  result.Assign(bt);
  bt.Free;

  if (WasTransparent) then
  begin
    result.Transparent:=true;
    GIFSubImage:=Result.Images[0];

    GIFSubImage.ColorMap.Optimize;
    // Can't make transparent if no color or colormap full
    if not((GIFSubImage.ColorMap.Count = 0) or (GIFSubImage.ColorMap.Count = 256)) then
    begin

      // Add the transparent color to the color map
      TransparentIndex := GIFSubImage.ColorMap.Add{Unique}(TColor({ $112211}$0));


      GCE := TGIFGraphicControlExtension.Create(GIFSubImage);
      GCE.Transparent := True;
      //TransparentIndex:=result.Images[0].Pixels[TransparentX,TransparentY];
      GCE.TransparentColorIndex := TransparentIndex;
      GIFSubImage.Extensions.Add(GCE);

//      GIFSubImage.ColorMap.Optimize;
      TransparentIndex:=GIFSubImage.GraphicControlExtension.TransparentColorIndex;


       P:=Transparent.PixelPtr[0,0];
       for y:=0 to Transparent.Height-1 do
       begin
        ba:=GIFSubImage.ScanLine[y];
        for x:=0 to Transparent.Width-1 do
        begin
         if P^ shr 24=$00 then
          ba[x]:=TransparentIndex;
         inc(P);
        end;
       end;
      GIFSubImage.ColorMap.Optimize;
      TransparentIndex:=GIFSubImage.GraphicControlExtension.TransparentColorIndex;

    end;

  end;
end;

*)

type TFakeChunkPLTE=class(TChunkPLTE);

procedure SetPaletteColorCount(png:TPNGObject; Count:integer);
var j:integer;
begin
  FOR j := 0 TO png.Chunks.Count - 1 DO
  if png.Chunks.Item[j] is TChunkPLTE then
  begin
   TFakeChunkPLTE(png.Chunks.Item[j]).fCount:=Count;
  end;
end;

{$IFNDEF CLX}

function GetPNGObjectPTFromGifAndBitmap32(Transparent:TMyBitmap32; gif:TGIFImage):TPNGObject;
var bt:TBitmap;
var P: PColor32;
    bp:pByteArray;
    x,y:integer;
begin
 result:=TPNGObject.Create;
 result.CompressionLevel:=9;
 bt:=TBitmap.Create;
 bt.Assign(Transparent);
{ bt.Transparent:=gif.Transparent;
 bt.TransparentMode:=tmFixed;
}
 //result.Assign(bt);
 bt.Width:=gif.Width;
 bt.Height:=gif.Height;
 {bt.Canvas.Brush.Color:=clRed;
 bt.canvas.Pen.Style:=psClear;
 bt.Canvas.FillRect(Rect(0,0,gif.Width,gif.Height));   }
 bt.Assign(gif);
// bt.Palette:=gif.Images[0].ColorMap.ExportPalette;
{ bt.Transparent:=gif.Transparent;
 bt.TransparentMode:=tmFixed;
 bt.TransparentColor:=gif.Images[0].GraphicControlExtension.TransparentColor;
}
 if {gif.Transparent}gif.Images[0].Transparent then
 begin
  gif.Images[0].GraphicControlExtension.TransparentColor;
//  result.transparentcolor:=gif.Images[0].GraphicControlExtension.TransparentColor;



  result.AssignHandle(bt.Handle,true,{ TColor($112211)}{bt.TransparentColor} gif.Images[0].GraphicControlExtension.TransparentColor);
  SetPaletteColorCount(result,gif.Header.ColorMap.Count);
  //result.TransparentColor:=gif.Images[0].GraphicControlExtension.TransparentColor;
  result.TransparentColor:=gif.Images[0].GraphicControlExtension.TransparentColor;
  begin
   P:=Transparent.PixelPtr[0,0];
   for Y:=0 to result.Height-1 do
   begin
    bp:=result.Scanline[Y];
    for X:=0 to result.Width-1 do
    begin
     if Transparent.Pixel[x,y] shr 24=0 then
      result.Pixels[x,y]:=result.transparentcolor;
      //bp^[X]:=gif.Images[0].GraphicControlExtension.TransparentColorIndex;//gif.Images[0].GraphicControlExtension.TransparentColorIndex;
     inc(P);
    end;
   end;
  end;
 end else
 begin
  result.AssignHandle(bt.Handle,false,0);
  SetPaletteColorCount(result,gif.Header.ColorMap.Count-1);
 end;
 //result.Palette:=gif.Palette;
 {if gif.Transparent then
  result.CreateAlpha;  }
 bt.Free;
end;


function GetPNGObjectPTFromBitmap32(Transparent:TMyBitmap32; Opaque:TMyBitmap32):TPNGObject;
var gif:TGifImage;
begin
 gif:=GetGifImageFromBitmap32(Transparent,Opaque);
 try
  result:=GetPNGObjectPTFromGifAndBitmap32(Transparent,gif);
 finally
  gif.Free;
 end;
end;     


function GetPNGObjectPTFromGif(gif:TGIFImage):TPNGObject;
var Transparent:TMyBitmap32;
begin
 Transparent:=GetAs32(gif);
 try
  result:=GetPNGObjectPTFromGifAndBitmap32(Transparent,gif);
 finally
  Transparent.Free;
 end;
end;     
{$ENDIF}



                  
{$IFNDEF CLX}
function GetJPEGImageFromBitmap32(Src:TMyBitmap32):TJPEGImage;
var bt:TBitmap;
begin
  bt:=TBitmap.Create;
  bt.Assign(Src);
  result:=TJPegImage.Create;
  //result.CompressionQuality:=20;
  result.Assign(bt);
  bt.Free;
end;
{$ENDIF}


function GetFromBitmap32(Transparent:TMyBitmap32):TGraphic;
begin
 result:=TBitmap.Create;
 result.Assign(Transparent);
end;

  {TMyBitmap=class(TBitmap)
  protected
    BitmapWithMask:TBitmap;
    function GetMaskHandle: HBITMAP; override;

  end; }

function GetGifTransparent(Opaque:TMyBitmap32; Transparent:TMyBitmap32):TMyBitmap32;
var J:integer;
var P,P2: PColor32;
begin
 result:=TMyBitmap32.Create;
 result.Assign(Opaque);
 P:=Transparent.PixelPtr[0,0];
 P2:=result.PixelPtr[0,0];
 for j:=0 to Transparent.Width*Transparent.Height-1 do
 begin
//  if integer(p) div 10 mod 2=1 then
  if P^ shr 24=$00 then
   P2^:=0;
  inc(P);
  inc(P2);
 end;
end;



procedure TStyle.WriteRastering(Writer: TWriter);
begin
 Writer.WriteString(RasteringFile);
end;

procedure TStyle.WriteBackgroundImageUrl(Writer: TWriter);
begin
 Writer.WriteString(BGImageFile);
end;


procedure TStyle.WriteBorderColors(Writer: TWriter);
begin
 Writer.WriteString(FBorderColors);
end;

{procedure TStyle.WriteNewMargin(Writer: TWriter);
begin
 with Owner.ClientEdgesPure do
  Writer.WriteString(inttostr(Top)+'px '+inttostr(Right)+'px '+inttostr(Bottom)+'px '+inttostr(Left)+'px');
end;
}


procedure NormalizeTransparency(Transparent:TMyBitmap32);
var J:integer;
var P: PColor32;
begin
 P:=Transparent.PixelPtr[0,0];
 for j:=0 to Transparent.Width*Transparent.Height-1 do
 begin
//  if integer(p) div 10 mod 2=1 then
  if (P^ shr 24=$00) and (P^<>0) then
   assert(P^=0);
{  if P^=$323735 then
   P^:=0 else
   P^:=P^ or $FF000000;}
  inc(P);
 end;
end;

function GetCRCFromBitmap32(b:TMyBitmap32; w,h:integer; ResumeCrc:DWORD=0):DWORD; overload;
var y:integer;
begin
   result:=w;
   result:=calc_crc32(sizeof(result),@result,ResumeCrc);
   if w<>0 then
   for y:=0 to {b.Height}h-1 do
    result:=calc_crc32(w*sizeof(TColor32),PByte(b.PixelPtr[0,y]),result);
//   result:=calc_crc32(b.Width*b.Height*sizeof(TColor32),pchar(b.PixelPtr[0,0]),result);
end;

function GetCRCFromBitmap32(Transparent,Opaque:TMyBitmap32; w,h:integer; ResumeCrc:DWORD=0):DWORD; overload;
var Opaque2:TMyBitmap32;
begin
 Opaque2:=TMyBitmap32.Create;
 Opaque2.Assign(Opaque);
 NormalizeOpaque(Transparent,Opaque2);
 result:=GetCRCFromBitmap32(Opaque2,w,h,ResumeCrc);
 Opaque2.Free;
end;


procedure TrimBottom(b:TMyBitmap32; var w,h:integer);
var x,y:integer;
begin
   for y:=h-1 downto 0 do
   for x:=0 to w-1 do
   if b.Pixel[x,y] and $FF000000<>0 then
   begin
    h:=y+1;
    exit;
   end;
end;

procedure TrimRight(b:TMyBitmap32; var w,h:integer);
var x,y:integer;
begin
   for x:=w-1 downto 0 do
   for y:=0 to h-1 do
   if b.Pixel[x,y] and $FF000000<>0 then
   begin
    w:=x+1;
    exit;
   end;
end;

procedure TrimRightBottom(b:TMyBitmap32; var w,h:integer);
begin
   w:=b.Width;
   h:=b.Height;
   TrimBottom(b,w,h);
   TrimRight(b,w,h);
   if (w=0) or (h=0) then
   begin
    w:=0;
    h:=0;
   end;
end;



function SaveImg(Opaque:TMyBitmap32; Transparent:TMyBitmap32; var RasteringFile:string; CheckBaseRasteringFile:boolean; BaseRasteringFile:string; PhysicalImageFormat:TPhysicalImageFormat; AllowCutWhiteSpace:boolean):boolean;
var gif_pre:TMyBitmap32;
    i,w,h:integer;
    _crc:DWORD;
    graph:TGraphic;
    NeedSave:boolean;
    AbsoluteRasteringFile:string;
const ext:array[TPhysicalImageFormat] of string=('.gif','.png','.jpg');
begin




         {
   RasteringFile:=RasteringFile+'.gif';
   gif_pre:=GetGifTransparent(Opaque,Transparent);
   _crc:=GetCRCFromBitmap32(gif_pre);
   FreeAndNil(gif_pre); }
   RasteringFile:=RasteringFile+ext[PhysicalImageFormat];
   _crc:=calc_crc32_String(ext[PhysicalImageFormat]);
   if AllowCutWhiteSpace then
   begin
    TrimRightBottom(Transparent,w,h);
   end else
   begin           
    w:=Transparent.Width;
    h:=Transparent.Height;
   end;
   if PhysicalImageFormat=pifSaveAsGIF then
   begin
    _crc:=GetCRCFromBitmap32(Transparent,Opaque,w,h,_crc);
   end else
   if PhysicalImageFormat=pifSaveAsPNG then
   begin
    _crc:=GetCRCFromBitmap32(Transparent,w,h,_crc);
   end else
   begin
    _crc:=GetCRCFromBitmap32(Opaque,w,h,_crc);
   end;

   result:=glSaveBin(_crc,RasteringFile,AbsoluteRasteringFile,CheckBaseRasteringFile,BaseRasteringFile,NeedSave,false);



  if NeedSave then
  try
{.$IFNDEF CLX}
  if PhysicalImageFormat=pifSaveAsGIF then
   graph:=GetGifImageFromBitmap32(Transparent,Opaque) else
  if PhysicalImageFormat=pifSaveAsJPEG then
   graph:=GetJPEGImageFromBitmap32(Opaque) else
{.$ENDIF}
   graph:=GetPNGObjectFromBitmap32(Transparent{,true});
{.$ENDIF}
   graph.SaveToFile(AbsoluteRasteringFile);
   graph.Free;
   glAfterSaveBin;
  except
  end;
end;



(*
function TStyle.PrepareBGRastering:boolean;
const sst:array[TState] of string=('_mn','_hr','_dn','_hd');
var pn:TdhCustomPanel;
    R:TRect;
    Src,Src2:TMyBitmap32;
begin

 pn:=TdhCustomPanel(Owner.Control);

  with pn do
  begin
   if _ContentWidthHeight.X=NoWH then
   begin
    R:=Rect(0,0,Width,Height);
    MyCheckNewSize(R.Right,R.Bottom);
    R:=ShrinkRect(ShrinkRect(R,MarginPure),BorderPure);
   end else
   begin
    R:=Rect(0,0,_ContentWidthHeight.X,_ContentWidthHeight.Y);
    R:=InflRect(R,PaddingPure);
   end;
  end;
   OffsetRect(R,-R.Left,-R.Top);
   Src:=TMyBitmap32.Create;
   Src.DrawMode:=dmBlend;
   Src.Width:=R.Right;
   Src.Height:=R.Bottom;

  Owner.ActTopGraph:=Src;
  Src.Clear(clWhite32);
  Owner.SpecialBg(R,R,Src,R,false{,Point(0,0)});
  Src2:=TMyBitmap32.Create;
  Src2.Assign(Src);
  Src.Clear(clBlack32);
  Owner.SpecialBg(R,R,Src,R,false{,Point(0,0)});
  Owner.ActTopGraph:=nil;

  ExtractAlphaBitmap(Src.PixelPtr[0, 0],Src2.PixelPtr[0, 0],Src.Height*Src.Width);
  Src2.Clear(ColorToColor32(pn.GetVirtualBGColor));
  Src.DrawTo(Src2);

  BGRasteringFile:=RasteringSaveDir+'bg_'+FinalID(pn)+sst[OwnState];
  result:=SaveImg(Src2,Src,BGRasteringFile,OwnState<>hsNormal,Owner.StyleArr[NextStyle[Owner.DownOverlayOver,OwnState]].BGRasteringFile);

  FreeAndNil(Src2);
  FreeAndNil(Src);
//   Owner.
end;
*)


function _if(q:boolean; a,b:integer):integer;
begin
 if q then
  result:=a else
  result:=b;
end;

function getPhysicalImageFormat(pn:TdhCustomPanel;TransparentTop:TMyBitmap32):TPhysicalImageFormat;
const LogicalToPhysicalFileFormat:array[TImageFormat] of TPhysicalImageFormat=(pifSaveAsGIF,pifSaveAsGIF,pifSaveAsPNG,pifSaveAsJPEG);
begin
  result:=LogicalToPhysicalFileFormat[pn.GetImageFormat];
  if (result=pifSaveAsJPEG) and ((TransparentTop.Height<=1) or (TransparentTop.Width<=1)) then
  begin
   //jpeg implementation requires at least height>1 when saving
   result:=pifSaveAsGIF;
  end;
end;


var EqSizing:array[0..2,0..2] of TRect;
const EqNaming:array[0..2,0..2] of string=(('_topleft','_topmiddle','_topright'),('_middleleft','_middle','_middleright'),('_bottomleft','_bottommiddle','_bottomright'));

function TStyle.PrepareRastering(addheight:integer; const PostFix:string):boolean;
var //_BackIsValid,_TopIsValid:boolean;
    //_TopGraph,_BackGraph,_TransparentTop:TMyBitmap32;
    pn:TdhCustomPanel;
    graph:TGraphic;
    imageIndex,w,h:integer;
    _crc:DWORD;
    NeedSave:boolean;
    bt:TBitmap;

    fingif,Sub:TGIFImage;
    GCE:TGIFGraphicControlExtension;
    PrevSubImage:TGIFSubImage;
    si:TGIFSubImage;
    OldAnimate:boolean;
    pnTopGraph,pnTransparentTop:TMyBitmap32;
    EqArea:TRect;
    EqX,EqY:integer;
    EqSize:TRect;
    RasteringFiles:String;
    AbsoluteRasteringFile:String;
begin

  pn:=Owner;

  //Src:=(Owner.Control as TdhCustomPanel).TransPainting(tt);
  //MixColor(Src,ColorToColor32((Owner.Control as TdhCustomPanel).GetVirtualBGColor));
  {TODO: SpeedupGeneration if RasteringFile<>'' then
  begin
    result:=true;
    exit;
  end;}

  if (pn.GetImageFormat=ifSimple) and Owner.HasBackgroundImage(graph) and (graph is TGIFImage) and (TGIFImage(graph).Images.Count>=2) then
  begin
   _crc:=calc_crc32_String('.gif');
   Assert(not PreventGraphicOnChange);
   PreventGraphicOnChange:=true;
   //TGIFImage(graph).Painters.LockList;
   //TGIFImage(graph).PaintStop;
   try
    OldAnimate:=TGIFImage(graph).Animate;
    TGIFImage(graph).SetAnimateSilent(false);
    for imageIndex:=0 to TGIFImage(graph).Images.Count-1 do
    begin
     //PreventGraphicOnChange:=true;
     TGIFImage(graph).ForceFrame:=imageIndex;
     pn.TopIsValid:=false;
     pn.AssertTop(addheight,true);
     if HasSomething(pn.TransparentTop) then
     begin
      TrimRightBottom(pn.TransparentTop,w,h);
      _crc:=GetCRCFromBitmap32(pn.TransparentTop,pn.TopGraph,w,h,_crc);
     end;
    end;

    RasteringFile:=FinalImageID(pn)+PostFix+sst[OwnState];
    RasteringFile:=RasteringFile+'.gif';
    result:=glSaveBin(_crc,RasteringFile,AbsoluteRasteringFile,OwnState<>hsNormal,BaseRasteringFile,NeedSave,false);

    if NeedSave then
    begin
     fingif:=GetNewGif;
     try
     try
      PrevSubImage:=nil;
      for imageIndex:=0 to TGIFImage(graph).Images.Count-1 do
      begin
       //PreventGraphicOnChange:=true;
       TGIFImage(graph).ForceFrame:=imageIndex;
       si:=TGIFSubImage(TGIFImage(graph).Images[imageIndex]);
       pn.TopIsValid:=false;
       pn.AssertTop(addheight,true);
       if HasSomething(pn.TransparentTop) then
       begin
       {if fingif.Images.Count-1>=0 then
        PrevSubImage:=fingif.Images[fingif.Images.Count-1];}
 {      GCE:=si.GraphicControlExtension;
       if GCE<>nil then
        AddGIFSubImageFromBitmap32(pn.TransparentTop,pn.TopGraph,fingif,GCE.Delay,PrevSubImage) else
  }
        PrevSubImage:=AddGIFSubImageFromBitmap32(pn.TransparentTop,pn.TopGraph,fingif,true,si,PrevSubImage);
       end;
      end;
      CloseGif(fingif);
      //fingif.OptimizeColorMap; //saves many kb at many frames
      fingif.SaveToFile(AbsoluteRasteringFile);
      glAfterSaveBin;
     except
     end;
     finally
      fingif.Free;
     end;
    end;
    TGIFImage(graph).ForceFrame:=-1;
    TGIFImage(graph).SetAnimateSilent(OldAnimate);
   finally
    PreventGraphicOnChange:=false;
   //TGIFImage(graph).Painters.UnlockList;
   end;
   //TGIFImage(graph).PaintStart;

   {fingif.SaveToFile('c:\asa.gif');
   fingif.Free;}
   //result:=false;
  end else
  begin
   pn.AssertTop(addheight,true);

   //pn.BackGraph.SaveToFile('c:\b.bmp');
   if HasSomething(pn.TransparentTop) then
   begin
    if (csAcceptsControls in pn.ControlStyle) and (pn.EqArea.Left<>InvalidEqArea){ and (pn.GetImageFormat<>ifSemiTransparent)} then
    begin
     pn.TopGraph.ResetAlpha; //transparency value is undefined for opaque image, so make it defined for GetEqArea to work correctly
     EqArea:=GetEqArea(pn.TopGraph,(pn.EqArea.Left+pn.EqArea.Right) div 2,(pn.EqArea.Top+pn.EqArea.Bottom) div 2);
     if not pn.VariableHeightSize and (EqArea.Bottom-EqArea.Top<pn.TransparentTop.Height div _if(pn.VariableHeightSize,4,2)) then
     begin
      //EqArea.Top:=pn.EqArea.Top; //then, alternative pages with different heights can reuse the same top three graphics
      EqArea.Top:=0;
      EqArea.Bottom:=EqArea.Top;
     end;
     if not pn.VariableWidthSize and (EqArea.Right-EqArea.Left<pn.TransparentTop.Width div _if(pn.VariableWidthSize,4,2)) then
     begin
      EqArea.Left:=0;
      EqArea.Right:=EqArea.Left;
     end;
     if (EqArea.Right<>EqArea.Left) and (EqArea.Bottom<>EqArea.Top) or (pn.VariableWidthSize and (EqArea.Right<>EqArea.Left)) or (pn.VariableHeightSize and (EqArea.Top<>EqArea.Bottom)){ or (EqArea.Right-EqArea.Left>=1) and (EqArea.Bottom-EqArea.Top>=1) and pn.VariableSize} then
     begin
      pnTopGraph:=TMyBitmap32.Create;
      pnTransparentTop:=TMyBitmap32.Create;
      pnTransparentTop.DrawMode:=pn.TransparentTop.DrawMode;
      pn.TransparentTop.DrawMode:=dmOpaque;
      try

       EqSizing[0,0]:=Rect(0,0,EqArea.Left,EqArea.Top);
       EqSizing[1,0]:=Rect(EqArea.Left,0,Min(EqArea.Left+1,EqArea.Right),EqArea.Top);
       EqSizing[2,0]:=Rect(EqArea.Right,0,pn.TransparentTop.Width,EqArea.Top);

       EqSizing[0,1]:=Rect(0,EqArea.Top,EqArea.Left,Min(EqArea.Top+1,EqArea.Bottom));
       EqSizing[1,1]:=Rect(EqArea.Left,EqArea.Top,Min(EqArea.Left+1,EqArea.Right),Min(EqArea.Top+1,EqArea.Bottom));
       EqSizing[2,1]:=Rect(EqArea.Right,EqArea.Top,pn.TransparentTop.Width,Min(EqArea.Top+1,EqArea.Bottom));

       EqSizing[0,2]:=Rect(0,EqArea.Bottom,EqArea.Left,pn.TransparentTop.Height);
       EqSizing[1,2]:=Rect(EqArea.Left,EqArea.Bottom,Min(EqArea.Left+1,EqArea.Right),pn.TransparentTop.Height);
       EqSizing[2,2]:=Rect(EqArea.Right,EqArea.Bottom,pn.TransparentTop.Width,pn.TransparentTop.Height);

       RasteringFiles:=EmptyStr;
       for EqY:=0 to 2 do
       for EqX:=0 to 2 do
       begin
        EqSize:=EqSizing[EqX,EqY];
        if (EqSize.Left=EqSize.Right) or (EqSize.Bottom=EqSize.Top) then
        begin
         RasteringFile:=EmptyStr;
        end else
        begin
         pnTopGraph.SetSize(EqSize.Right-EqSize.Left,EqSize.Bottom-EqSize.Top);
         pnTransparentTop.SetSize(pnTopGraph.Width,pnTopGraph.Height);
         pn.TopGraph.DrawTo(pnTopGraph,pnTopGraph.BoundsRect,EqSize);
         pn.{TopGraph}TransparentTop.DrawTo(pnTransparentTop,pnTransparentTop.BoundsRect,EqSize);
         RasteringFile:=FinalImageID(pn)+PostFix+EqNaming[EqY,EqX];
         result:=SaveImg(pnTopGraph,pnTransparentTop,RasteringFile,OwnState<>hsNormal,BaseRasteringFile,getPhysicalImageFormat(pn,pnTransparentTop),false);
        end;
        RasteringFiles:=RasteringFiles+RasteringFile+'|';
       end;
       RasteringFiles:=RasteringFiles+inttostr(EqArea.Top)+'|'+inttostr(pn.TransparentTop.Height-EqArea.Bottom)+'|'+inttostr(EqArea.Left)+'|'+inttostr(pn.TransparentTop.Width-EqArea.Right)+'|';
       RasteringFile:=RasteringFiles;
      finally     
       pn.TransparentTop.DrawMode:=pnTransparentTop.DrawMode;
       pnTopGraph.Free;
       pnTransparentTop.Free;
      end;
      result:=true;
      exit;
     end;
    end;
    RasteringFile:=FinalImageID(pn)+PostFix+sst[OwnState];
    result:=SaveImg(pn.TopGraph,pn.TransparentTop,RasteringFile,OwnState<>hsNormal,BaseRasteringFile,getPhysicalImageFormat(pn,pn.TransparentTop),true);
   end else
    result:=false;
  end;
     {
  png:=GetPNGObjectFromBitmap32(TdhCustomPanel(Owner.Control).TopGraph,false);
  png.SaveToFile(RasteringSaveDir+RasteringFile);
  png.Free;  }


//  TdhCustomPanel(Owner.Control).TopGraph.SaveToFile('c:\test.bmp');

  (*
  with pn do
  begin
   //gif_pre:=GetGifTransparent(TopGraph,TransparentTop);
   NormalizeTransparency(TransparentTop);
   _crc:=calc_crc32(TransparentTop.Width*TransparentTop.Height*sizeof(TColor32),pchar(TransparentTop.PixelPtr[0,0]));
   i:=TopGraph.Width;
   _crc:=calc_crc32(sizeof(i),@i,_crc);
   //FreeAndNil(gif_pre);
  end;

  i:=CrcList.IndexOfObject(Pointer(_crc));
  if i<>-1 then
  if not FileExists(CrcList[i]) or not SameText(RasteringSaveDir,ExtractFileDir(CrcList[i])+PathDelim)  then
  begin
   CrcList.Delete(i);
  end else
  begin
   RasteringFile:=CrcList[i];
   if (OwnState<>hsNormal) and (Owner.StyleArr[NextStyle[OwnState]].RasteringFile=RasteringFile) then
   begin
    result:=false;
    exit;
   end else
   begin
    result:=true;
    exit;
   end;
  end;

  gif:=GetGifImageFromBitmap32(pn.TransparentTop,pn.TopGraph);

  RasteringFile:=RasteringSaveDir+{GetTypeData(PTypeInfo(GetParentForm(Owner.Control).ClassType.ClassInfo)).UnitName + '\' + }FinalID(pn)+sst[OwnState]{+'.png'}+'.gif';
  CrcList.AddObject(RasteringFile,Pointer(_crc));
  ForceDirectories(ExtractFilePath(RasteringSaveDir));
  gif.SaveToFile(RasteringFile);


  result:=true;

  *)
end;


function TStyle.ProposedBackgroundFilename: String;
begin
 result:=FinalImageID(Owner)+sst[OwnState]+FBackgroundImage.GraphicExtension
end;
                         
function AsString(graphic:TGraphic):String;
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create('');
  try
    graphic.SaveToStream(Stream);
    Result:=Stream.DataString;
  finally
    Stream.Free;
  end;
end;

function StringFromFile(const FileName:string):string;
begin
 with TFileStream.create(FileName,fmOpenRead) do
 begin
  SetLength(result,Size);
  if Size<>0 then
   ReadBuffer(result[1],Size);
  Free;
 end;
end;

procedure StringToFile(const FileName,s:string);
begin
 with TFileStream.create(FileName,fmCreate) do
 begin
  if s<>EmptyStr then
   WriteBuffer(s[1],length(s));
  Free;
 end;
end;

function TStyle.PrepareBGImage:boolean;
var NeedSave:boolean;
    AbsoluteBGImageFile,StringContent:string;
begin
 result:=false;
 if not IsPictureStored then
  exit;

 StringContent:='';
 if FBackgroundImage.HasPath then
 try
  StringContent:=StringFromFile(FBackgroundImage.GetAbsolutePath);
 except
  // let the dummy image be load next
 end;
 if StringContent='' then
  StringContent:=AsString(FBackgroundImage.RequestGraphic);

 BGImageFile:=ProposedBackgroundFilename;
 result:=glSaveBin(calc_crc32_String(StringContent),BGImageFile,AbsoluteBGImageFile,false,EmptyStr,NeedSave,false);

 if NeedSave then
 try
  StringToFile(AbsoluteBGImageFile,StringContent);
  glAfterSaveBin;
 except
 end;
 result:=true;
end;


procedure TStyle.ClearEdge(Align: TEdgeAlign);
begin
 FBorders[Align].Clear;
 FMargins[Align]:=MarginDefault;
 FPaddings[Align]:=vsrInherit;
 pcs(pcChanges[pcMargin]+pcChanges[pcPadding]+(pcChanges[pcBorderWidth]+pcChanges[pcBorderColor]+pcChanges[pcBorderStyle]));
end;


procedure TBlurEffect.Changed;
begin
 Owner.Changed;
end;

procedure TBlurEffect.Clear;
begin
{    FAlpha:=191;
    FRadius:=5;
    FFlood:=0;
    FEnabled:=false;
    }
end;

function TBlurEffect.IsCleared:boolean;
begin
 result:=true;//(FAlpha=191) and (FRadius=5) and (FFlood=0) and not FEnabled;
end;


procedure TBlurEffect.SetAlpha(const Value: byte);
begin
  FAlpha := Value;
  Changed;
end;

procedure TBlurEffect.SetColor(const Value: TCSSColor);
begin
 if FColor <> Value then
 begin
  FColor := Value;
  Changed;
 end;
end;

procedure TBlurEffect.SetDegree(const Value: integer);
begin
  FDegree := Value;
  Changed;
end;

procedure TBlurEffect.SetDistance(const Value: integer);
begin
  FDistance := Value;
  Changed;
end;

procedure TBlurEffect.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;  
  Changed;
end;

procedure TBlurEffect.SetFlood(const Value: integer);
begin
  FFlood := Value;
  Changed;
end;

procedure TBlurEffect.SetRadius(const Value: integer);
begin
  DeciRadius:=Value*10;
end;

procedure TBlurEffect.SetDeciRadius(const Value: integer);
begin
  FDeciRadius := Value;
  Changed;
end;


function TBlurEffect.GetDoubleRadius:double;
begin
  result:=DeciRadius/10;
end;

procedure TdhCustomPanel.SetImageType(const Value:TImageType);
begin
 if FImageType<>Value then
 begin
  FImageType:=Value;   
  NotifyCSSChanged([wcSize,wcText]);
 end;
end;


 {
constructor TBG.Create(Style: TStyle);
begin
  inherited Create;
  Self.Style:=Style;
end;  }


{ TMyBitmap }
                  {
function TMyBitmap.GetMaskHandle: HBITMAP;
begin
 if BitmapWithMask<>nil then
  result:=BitmapWithMask.MaskHandle else
  result:=Inherited GetMaskHandle;
end;
                 }

procedure TdhCustomPanel.InvalidateFontSize;
begin
 FComputedFontSize:=InvalidFontSize;
end;


procedure TdhCustomPanel.SetZOrder(TopMost: Boolean);
begin
{  if TopMost then
   InvalBack(InvRect);     }
  inherited;
  NotifyCSSChanged([wcZIndex,wcNoOwnCSS]);
{  if not TopMost then
   InvalBack(InvRect);   }
end;



procedure SaveBmp32(Transparent,Opaque:TMyBitmap32; const FileName: string);
var ext:string;
    g:TGraphic;
begin
 g:=nil;
 try
 ext:=lowercase(ExtractFileExt(Filename));
 if ext='.png' then
  g:=GetPNGObjectFromBitmap32(Transparent{,true}) else
 if ext='.gif' then
  g:=GetGifImageFromBitmap32(Transparent,Opaque) else
 {if ext='.ico' then
  g:=GetIconFromBitmap32(Transparent,Opaque) else  }
{$IFNDEF CLX}
// if ext='.png' then
//  g:=GetPNGObjectPTFromBitmap32(TransparentTop,TopGraph) else
 if (ext='.jpg') or (ext='.jpeg') then
  g:=GetJPEGImageFromBitmap32(Opaque) else
{$ENDIF}
 begin
  g:=TBitmap.Create;
  //TBitmap(g).PixelFormat:=pf8bit;
  g.Assign(Opaque);
  //TBitmap(g).PixelFormat:=pf8bit;
 end;
 ForceDirectories(ExtractFilePath(FileName));
 g.SaveToFile(FileName);
 finally
  FreeAndNil(g);
 end;
end;


procedure SaveGraphic(g:TGraphic; const FileName: string);
var ext:string;
    bmp:TMyBitmap32;
begin
 ext:=lowercase(ExtractFileExt(Filename));
 if GetGraphicExtension(g)=ext then
  g.SaveToFile(FileName) else
 begin
  bmp:=GetAs32(g);
  try
   SaveBmp32(bmp,bmp,FileName);
  finally
   bmp.Free;
  end;
 end;
end;


procedure TdhCustomPanel.SaveAsImage(const FileName: string; WithBackground:boolean);
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
 TopTextDecoration:=[];
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
begin    {
 if Con.IsVisualAnchor then
 begin
  TextDecoration; //sets TopTextDecoration
  result:=(TopTextDecoration=[]) or (ctdUnderline in TextDecoration);
 end else    }
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

procedure TStyle.SetFontVariant(const Value: TCSSFontVariant);
begin
 FFontVariant := Value;
 pc(pcFontVariant);
end;

//GetCSSBottomRight
function TdhCustomPanel.MyGetControlExtents(OnlyForScrollbars:boolean): TPoint;
var
  I,_Right,_Bottom: Integer;
  IncrPt{,AdjWH}:TPoint;
  //OriClientBound:TRect;
  c:TControl;
begin

 Result:=Point(0,0);

// AdjWH:=Point(OldWH.X-Width,OldWH.Y-Height);


 IncPt(Result,HPos,VPos);


 //with ScrollAreaWithScrollbars do IncPt(Result.BottomRight,BottomRight);
 //if IsScrollArea and EdgesInScrolledArea then
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

      //was gerade bei [alLeft,alRight,alTop,alBottom] nicht berücksichtigt wird ist min-width/min-height
      if not (c.Align in [alBottom,alRight,alClient]) then
      begin

        if c.Align<>alTop then
        if (akRight in c.Anchors) and (TdhCustomPanel(c).CSSRight<>InvalidCSSPos) then
        begin
         if {GetCSSBottomRight(c).X-HPos+AdjWH.X}(c is TdhCustomPanel) and (TdhCustomPanel(c).CSSRight-HPos<0) then
          Result.X:=MaxInt;
        end else
        //if not ((akRight in Anchors) and {(_Right<=MeasureArea.X)}GetCSSBottomRight(ClientBound)) then
        begin
         _Right:=c.Left + c.Width + IncrPt.X;
         if _Right > Result.X then Result.X := _Right;
        end;

        if c.Align<>alLeft then
        if (akBottom in c.Anchors) and (TdhCustomPanel(c).CSSBottom<>InvalidCSSPos) then
        begin
         if {GetCSSBottomRight(c).Y-VPos+AdjWH.Y}(c is TdhCustomPanel) and (TdhCustomPanel(c).CSSBottom-VPos<0) then
          Result.Y:=MaxInt;
        end else
        //if not (OnlyForScrollbars and (akBottom in Anchors) and (_Bottom<=MeasureArea.Y)) then
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

{ Result.Left:=Min(Result.Left,Result.Right);
 Result.Top:=Min(Result.Top,Result.Bottom);
 if (Result.Left=Result.Right) and (Result.Top<Result.Bottom) then
  Inc(Result.Right); //so that it can return True at DoIntersectStrong
 if (Result.Left<Result.Right) and (Result.Top=Result.Bottom) then
  Inc(Result.Bottom); //so that it can return True at DoIntersectStrong
 }  


// IncPt(Result,AllEdgesPure.BottomRight);
// with ScrollAreaWithScrollbars do OffsetRect(Result,-Left,-Top);
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
  //(Control as TdhCustomPanel).UpdateScrollbars(false);
end;



                                  {
function TdhCustomPanel.DoubleDown:boolean;
begin
 result:=FIsScrollArea and NCScrollbars and (not (csDesigning in ComponentState) or (GetParentForm(Self)<>nil) and (GetParentForm(Self).ClassName='TPageContainer'));
end;
                                   }

procedure TdhCustomPanel.SetVPos(Value: Integer);
begin
 SetVHPos(HPos,Value);
end;

procedure TdhCustomPanel.SetHPos(Value: Integer);
begin
 SetVHPos(Value,VPos);
end;
        
procedure TdhCustomPanel.SetBoundedVHPos(H,V:integer);
var OldPos,P:TPoint;
    R:TRect;
begin
  {V:=min(V,VertScrollInfo.nMax-VertScrollInfo.nPage);
  H:=min(H,HorzScrollInfo.nMax-HorzScrollInfo.nPage);}
  SetVHPos(H,V);
end;

procedure TdhCustomPanel.SetBoundedVPos(p: Integer);
begin
 {if VertScrollInfo.nMax<>0 then
  P:=min(P,VertScrollInfo.nMax-VertScrollInfo.nPage);}
 SetVHPos(HPos,p);
end;

procedure TdhCustomPanel.SetBoundedHPos(p: Integer);
begin
 {if VertScrollInfo.nMax<>0 then
  P:=min(P,HorzScrollInfo.nMax-HorzScrollInfo.nPage);}
 SetVHPos(p,VPos);
end;


//procedure TdhCustomPanel.WMMouseMove(var Message: TWMMouseMove);
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
//     MouseTimer.Handle;
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
    //SetBoundedVPos(Round(DragVPos + (Mouse.CursorPos.Y-FDragOffset.Y)*VertScrollInfo.nMax/(Bottom-Top-h_slick)));
   end;
   HorzBar:
   if HorzBarVisible then 
   begin
    with GetHorzChecked do GetSlack(HorzScrollInfo,Right-Left,Mouse.CursorPos.X-FDragOffset.X,h,position,true);
    SetBoundedHPos(DragHPos + position);
    //SetBoundedHPos(Round(DragHPos + (Mouse.CursorPos.X-FDragOffset.X)*(HorzScrollInfo.nMax-HorzScrollInfo.nPage)/(Right-Left-h_slick-h)));
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



(*
{$IFNDEF CLX}


procedure TdhCustomPanel.WMLButtonUp(var Message: TWMLButtonUp);
begin
 inherited;
 ProcessFrameEvent(feMouseUp);
end;

{$ELSE}
*)

procedure TdhCustomPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin               
  inherited;
  if Button=mbLeft then
  begin
   UpdateMousePressed(false,DownIfDown);
   ProcessFrameEvent(feMouseUp);
  end;
end;

{.$ENDIF}




procedure TdhCustomPanel.OnMouseTimer(Sender:TObject);
begin
 MouseTimer.Interval:=30;
 ProcessFrameEvent(feMouseDown);
end;

(*
{$IFNDEF CLX}
procedure TdhCustomPanel.WMLButtonDown(var Message: TWMLButtonDown);
begin
 //UpdateMousePressed(true,DownIfDown,Message.Pos);
 Inherited;
 ProcessFrameEvent(feMouseDown);
end;

procedure TdhCustomPanel.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
 inherited;
 ProcessFrameEvent(feMouseDown);
end;

{$ELSE}
*)

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

{.$ENDIF}




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
{  with Message.CalcSize_Params^ do
   InflateRect(rgrc[0],-30,-30);
}end;
{$ENDIF}

{$IFDEF CLX}
function TdhCustomPanel.ViewportRect: TRect;
var R:TRect;
begin
    //Result:=inherited ViewportRect;
  if IsScrollArea and NCScrollbars then
  begin
   result:=ScrollArea;
   //RectAddSub(Result,R,TotalRect);
  end else
   result:=Bounds(0,0,Width,Height);
end;
{$ENDIF}

                         
function TdhCustomPanel.GetOpaquePainting(var TopGraph:TMyBitmap32):boolean;
begin
  AssertTop(0);
  result:=HasSomething(Self.TopGraph);
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
  if HasSomething(TopGraph) then
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

procedure TStyle.SetBackgroundAttachment(const Value: TCSSBackgroundAttachment);
begin
  FBackgroundAttachment := Value;
  pc(pcBackgroundAttachment);
end;

function TdhCustomPanel.GetAnchors: TAnchors;
begin
 result:=inherited Anchors;
end;

function TdhCustomPanel.IsAnchorsStored: Boolean;
begin
  Result := Anchors <> AnchorAlign[Align];
end;

(*
procedure TdhCustomPanel.SetAnchors(const Value: TAnchors);
begin
{ if csLoading in ComponentState then
 begin
  inherited Anchors:=Value;
  PComponentState(@ComponentState)^:=ComponentState-[csLoading];
  UpdateBoundsRect(BoundsRect);
  PComponentState(@ComponentState)^:=ComponentState+[csLoading];
  exit;
 end;}
 if Anchors<>Value then
 begin
  inherited Anchors:=Value;
  //WeakToStrong;
 end;
end;
*)

procedure FixDialogBorderStyle(Form:TForm);
begin
{$IFDEF CLX}
 Form.BorderStyle:=fbsDialog;
{$ELSE}
 Form.BorderStyle:=bsDialog;
{$ENDIF}
end;

procedure FixDialogBorderStyleToTool(Form:TForm);
begin
{$IFDEF CLX}
 Form.BorderStyle:=fbsToolWindow;
{$ELSE}
 Form.BorderStyle:=bsToolWindow;
{$ENDIF}
end;

procedure TCSSBorder.DefineProperties(Filer: TFiler);
var Align:TEdgeAlign;
    NeedCompact,NeedColor:boolean;
begin
(* Owner.Owner.SetPreferStyle(Owner);
 NeedCompact:=False;
 for Align:=Low(TEdgeAlign) to High(TEdgeAlign) do
 if Owner.Borders[Align]=Self then
  Break;
 if false then
 if not (csLoading in Owner.Owner.Control.ComponentState) and (Owner.Borders[ealNone]<>Self) and ((FStyle<>Low(TCSSBorderStyle)) or (FColor<>colInherit) or (FWidth<>vsrInherit) or (Owner.Borders[ealNone].FStyle<>Low(TCSSBorderStyle)) or (Owner.Borders[ealNone].FColor<>colInherit) or (Owner.Borders[ealNone].FWidth<>vsrInherit)) then
 begin
  NeedCompact:=not Owner.Owner.HasVal(pcBorderWidth,Align) or Owner.Owner.HasVal(pcBorderColor,Align) and Owner.Owner.IsDefinedOuter(ValStyle);
 end;
// NeedCompact:=false;
 Filer.DefineProperty('Compact', Owner.SkipValue, WriteCompact, NeedCompact);
// Filer.DefineProperty('cWidth', Owner.SkipValue, WriteBorderWidth,(FWidth=vsrInherit) and (Owner.Borders[ealNone]=Self) and (Owner.Owner.FUse=nil));
 NeedColor:=false;
 if (Owner.Borders[ealNone]<>Self) then
 if not Owner.Owner.HasVal(pcBorderColor,Align) then
 if Owner.Owner.IsEdit or Owner.Owner.IsButton then
  NeedColor:=not (Owner.Owner.BorderStyle(Align) in [cbsGroove,cbsRidge,cbsInset,cbsOutSet]) else
  NeedColor:=Color32(Owner.Owner.FontColor)<>clBlack32;
 Filer.DefineProperty('cColor', Owner.SkipValue, WriteBorderColor,NeedColor);
 Owner.Owner.SetPreferStyle(nil);
*)end;                      

{procedure TCSSBorder.WriteCompact(Writer:TWriter);
var Align:TEdgeAlign;
    Val:TCSSProp;
begin
  for Align:=Low(TEdgeAlign) to High(TEdgeAlign) do
  if Owner.Borders[Align]=Self then
   Break;
  Owner.Owner.SetPreferStyle(Owner);
  Val.Width:=Owner.Owner.BorderWidth(Align);
  Val.BorderStyle:=Owner.Owner.BorderStyle(Align);
  Val.Color:=Owner.Owner.BorderColor(Align);
  Writer.WriteString(GetCSSPropValue(pcBorderWidth,Val)+' '+GetCSSPropValue(pcBorderStyle,Val)+' '+GetCSSPropValue(pcBorderColor,Val));
  Owner.Owner.SetPreferStyle(nil);
end;
}
                   {
procedure TCSSBorder.WriteBorderColor(Writer:TWriter);
var Align:TEdgeAlign;
    Val:TCSSProp;
begin
  for Align:=Low(TEdgeAlign) to High(TEdgeAlign) do
  if Owner.Borders[Align]=Self then
   Break;
  Val.Color:=Owner.Owner.BorderColor(Align);
  Writer.WriteString(GetCSSPropValue(pcBorderColor,Val));
end;                }





function TdhCustomPanel.GetPreferDownStyles:boolean;
begin
 result:=false; //irgendwass zurückliefern (da geht "false" wohl am schnellsten)
end;


               {
procedure TdhCustomPanel.SetDownOverlayOver(const Value: boolean);
var s:string;

procedure ItSet(const pn:TCommon);
var i:integer;
begin
 pn.FDownOverlayOver := Value;
 for i:=pn.UsedByList.Count-1 downto 0 do
  ItSet(TCommon(pn.UsedByList[i]));
end;


begin
 if Use=nil then
 begin
  ItSet(Self);
  NotifyCSSChanged(AllChanged);
 end;
end;       }

procedure TStyle.SetDirection(const Value: TCSSDirection);
begin
  FDirection := Value;
  pc(pcDirection);
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

procedure TStyle.SetBefore(const Value: String);
begin
  FBefore := Value;
  pc(pcContentBefore);
end;

procedure TStyle.SetAfter(const Value: String);
begin
  FAfter := Value;
  pc(pcContentAfter);
end;

function TTransformations.IsAntiAliasingStored: Boolean;
begin
 result:=FEnabled or FAntiAliasing;
end;

function TdhCustomPanel.GetSpecialBorderType:TSpecialBorderType;
var Con:ICon;
    s:string;
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

{
function TdhCustomPanel.IsButton:boolean;
begin
 result:=(Con.GetFinal<>nil) and ((Con.GetFinal.GetName='button') or (Con.GetFinal.GetName='filebutton'));
end;

function TdhCustomPanel.IsEdit:boolean;
begin
 result:=(Con.GetFinal<>nil) and ((Con.GetFinal.GetName='edit') or (Con.GetFinal.GetName='memo') or (Con.GetFinal.GetName='listbox'));
end;}


function TdhCustomPanel.HorizontalCenter:boolean;
begin
  result:=Anchors*[akLeft,akRight]=[];
end;

function TdhCustomPanel.VerticalCenter:boolean;
begin
  result:=Anchors*[akTop,akBottom]=[];
end;

procedure TdhCustomPanel.SetCenter(const Value: boolean);
begin
  if FCenter<>Value then
  begin
   FCenter := Value;
   Align:=alNone;
   if FCenter then
   begin
    Anchors:=[akTop];
   end else
   begin        
    Anchors:=[akLeft,akTop];
   end;
   RequestAlign;
   FCenter:=false;//dont support this property any longer
  end;
end;

{$IFNDEF CLX}
procedure TdhCustomPanel.WMPaint(var Message: TWMPaint);
begin
  ControlState:=ControlState+[csCustomPaint];
  inherited;
  ControlState:=ControlState-[csCustomPaint];
end;
{$ENDIF}

function TTransformations.IsTextStored: Boolean;
begin
 result:=FEnabled or (FText<>etInclude);
end;

{function TTransformations.IsTextOnlyStored: Boolean;
begin
 result:=FEnabled or TextOnly;
end;

function TTransformations.IsTextExcludeStored: Boolean;
begin
 result:=TextExclude;
end;
}
procedure TTransformations.SetTextOnly(const Value: boolean);
begin
 if Value then
  FText := etOnly else
 if FText = etOnly then
  FText:=etInclude;
 Changed;
end;

function TTransformations.GetTextOnly:boolean;
begin
  result:=FText=etOnly;
end;

procedure TTransformations.SetTextExclude(const Value: boolean);
begin
 if Value then
  FText := etExclude else
 if FText = etExclude then
  FText:=etInclude;
 Changed;
end;

function TTransformations.GetTextExclude:boolean;
begin
  result:=FText=etExclude;
end;

procedure TTransformations.SetText(const Value: TEffectsOnText);
begin
 FText:=Value;
 Changed;
end;


function TdhCustomPanel.RequiresRastering: boolean;
begin
 result:=false;
end;

{
function TdhCustomPanel.ViewportHandle: QWidgetH;
var QB: QBitmapH;
begin
  if not (csDestroying in ComponentState) then
    HandleNeeded;
  Result := FViewportHandle;
end;}


(*function TdhCustomPanel.GetChildHandle: QWidgetH;
begin
 if {IsScrollArea and NCScrollbars} classname='TdhPage' then
  Result := ViewportHandle else
  Result:=inherited GetChildHandle;
end;*)

procedure TdhCustomPanel.SetIsDlg(Value:Boolean);
begin
 FIsDlg:=Value;
end;


{$IFDEF CLX}
procedure TdhCustomPanel.ScrollBy(DeltaX, DeltaY: Integer);
var
  IsVisible: Boolean;
  R:TRect;
begin
  CheckChildrenNC(DeltaX, DeltaY);
  R:=ScrollArea;
  //Inherited;
  IsVisible := Visible and HandleAllocated;
  if IsVisible then
    QWidget_scroll(Handle, DeltaX, DeltaY{, @R});
  ScrollControls(DeltaX, DeltaY, IsVisible);
  //Realign; //not needed
  //UpdateScrollBars(false);  //done by Realign
end;

procedure TdhCustomPanel.CreateWidget;
var QB: QBitmapH;
begin
  Inherited;
  (*
  if {IsScrollArea and NCScrollbars} classname='TdhPage' then
  if FViewportHandle=nil then
  begin
   FViewportHandle:=QWidget_create(Self.Handle, nil, Integer(WidgetFlags_WRepaintNoErase));
   QClxObjectMap_add(FViewportHandle, Integer(Self));
   QB := QBitmap_create(0, 0, True, QPixmapOptimization_DefaultOptim);
   QWidget_setMask(FViewportHandle, QB);
  end;*)
end;




                    {

function TdhCustomPanel.GetPaintDevice: QPaintDeviceH;
begin
  Result := QWidget_to_QPaintDevice(Handle);
end;
                       }
                       (*
procedure TdhCustomPanel.BoundsChanged;
begin

 if FViewportHandle<>nil then
 with ScrollArea do
 begin
   QWidget_setGeometry(FViewportHandle, Left, Top, (Right-Left), (Bottom-Top));
{   s:=stringofchar(chr(1+4+16+64),(right-left)*(bottom-top) div 8);
   QB := QBitmap_create(Right-Left, (Bottom-Top) div 2, @s[1], true);
   //QB := QBitmap_create(Right-Left, Bottom-Top, false, QPixmapOptimization_DefaultOptim);
   QWidget_setMask(FViewportHandle, QB);
}
 end;
end;                     *)


(*
procedure TdhCustomPanel.UpdateScrollMask;
var
  QB: QBitmapH;
  QP: QPainterH;
  Canvas: TCanvas;
begin
  if (FViewportHandle=nil) or not HandleAllocated then Exit;
  QB := QBitmap_create(Width, Height, True, QPixmapOptimization_DefaultOptim);
  try
    QP := QPainter_create(QB, Handle);
    try
      Canvas := TCanvas.Create;
      try
        Canvas.Start(False);
        Canvas.Handle := QP;
        //DrawMask(Canvas);
        Canvas.Brush.Color:=clMask;
        Canvas.FillRect(Bounds(0,0,Width,Height));
        Canvas.Brush.Color:=clDontMask;
        Canvas.FillRect(ScrollArea);
        Canvas.Stop;
      finally
        Canvas.Free;
      end;
      QWidget_setMask(Handle, QB);
    finally
      QPainter_destroy(QP);
    end;
  finally
    QBitmap_destroy(QB);
  end;
end;
  *)

{$ENDIF}

var PropChoose:TPropChoose;
    iColor:Integer;
initialization

 for PropChoose:=Low(TPropChoose) to high(TPropChoose) do
 if PropChoose in AutoInherit then
  pcChanges[PropChoose]:=pcChanges[PropChoose]+[wcChild];


{$IFDEF CLX}
 Exclude(GIFImageDefaultDrawOptions,goAnimate); //gif-animations has problems at CLX
{$ENDIF}


{$IFDEF NEED_LINEAR_ANTIALIASING}
 SetGamma(1);
{$ENDIF}
 SetGamma(1); //looks better

 FullEdge:=false;

 CombineReg:=_CombineReg;

 glIsDesignerSelected:=CustomIsDesignerSelected;
 InvRect:=Rect(-1,-1,-1,-1);
 try
// if csDesigning in Application.ComponentState then
 begin
 OldOnIdle:=Application.OnIdle;
 ObjIdleProc:=TObjIdleProc.Create;
 Application.OnIdle:=ObjIdleProc.DoMouseIdle;



{$IFDEF DEB}
  // Start Exception tracking
  JclStartExceptionTracking;
{$IFDEF ShowAllExceptions}
  // Assign notification procedure for hooked RaiseException API call. This
  // allows being notified of any exception
  JclAddExceptNotifier(AnyExceptionNotify);
{$ENDIF}
 Application.OnException:=ObjIdleProc.ApplicationEvents1Exception;
{$ENDIF}

 end;
 except
 showmessage('exp in ini');
 end;

 for iColor := 2 to High(Colors) do Colors[iColor].Value:=Integer(ColorToCSSColor(Colors[iColor].Value));
 for iColor := 2 to High(TrueColors) do TrueColors[iColor].Value:=Integer(ColorToCSSColor(TrueColors[iColor].Value));
 RegisterIntegerConsts(TypeInfo(TCSSColor), dhPanel.IdentToColor, dhPanel.ColorToIdent);

 glBinList:=TBinList.Create;

 hh(0);
             {
 AddHA:=TStringList.Create;
 i:=342;
 i:=i div 255; }

// inttohex((GetBlendMemEx(i+{ $FF0000FF}$80008A84,$FFFFFFFF,{255 shl 16 div 255 + 1}255)),8);

finalization
 FreeAndNil(glBinList);
 //AddHA.Free;
 if ObjIdleProc<>nil then
 begin
 Application.OnIdle:=OldOnIdle;                            
 ObjIdleProc.Free;
 end;
 FreeAndNil(ImageBitmap);
   {
 while TPicture(GraphicsRepository.MinItem)<>nil do
 begin
  TPicture(GraphicsRepository.MinItem).savetofile('c:\t.bmp');
  GraphicsRepository.DeleteMin(GraphicsIDCompare);
 end;   }           

//http://www.matlus.com/scripts/website.dll
//http://devedge.netscape.com/library/xref/2003/css-support/css2/selectors.html
//http://www.csszengarden.com
//http://www.designdetector.com/tips/3DBorderDemo2.html
//http://tantek.com/CSS/Examples/boxmodelhack.html
//pure css menu: http://www.meyerweb.com/eric/css/edge/menus/demo.html
//http://www.devexpress.com/comments.asp
//http://msdn.microsoft.com/library/default.asp?url=/workshop/author/dhtml/overview/recalc.asp
//http://msdn.microsoft.com/workshop/author/dhtml/overview/ccomment_ovw.asp
(*
function Px(px) {
 if (!px) alert("programming error"); else
 return Number(px.substr(0,px.length-2));
}


var everything=document.all;
if (!everything) everything=document.getElementsByTagName("*");
if (true || document.all && !window.opera)  {
//alert("all");
for(var i=0; i<everything.length; i++) {
 var e=everything[i];
 if (e.style.right && e.style.left && e.parentNode.style.width) {
  alert(e.parentNode.style.borderLeftWidth);
  e.style.width=e.parentNode.offsetWidth-Px(e.style.left)-Px(e.style.right)+"px";
 }
 if (e.style.bottom && e.style.top && e.parentNode.style.height)  {
  e.style.height=Px(e.parentNode.style.height)-Px(e.style.top)-Px(e.style.bottom)+"px";
 }

}
}

*)
{$IFDEF CLX }
 Screen.Fonts.Free;  //wird von MemProof angezeigt, dass nicht freigegeben wurde
{$ENDIF}
end.


//http://groups.google.de/groups?q=WM_MOUSEWHEEL+designer+group:*delphi*&hl=de&lr=&ie=UTF-8&oe=UTF-8&selm=s7XL5.7312%247p3.80613%40e420r-atl1.usenetserver.com&rnum=1

//inttohex(integer(GetBlendMemEx($FF0000FF,$FFFFFFFF,255)),8)
//=$FF0101FF, obwohl $FF0000FF erwartet

http://www.psychology.nottingham.ac.uk/staff/cr1/png.html#delphi
