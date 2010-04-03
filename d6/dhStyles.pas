unit dhStyles;

interface

{$R 'imagebitmap.res'}

uses
  SysUtils, Classes, TypInfo,
  {$IFDEF MSWINDOWS}ShellAPI,jpeg,{$ELSE}libc,{$ENDIF}
{$IFDEF CLX}
  GIFImage, QControls,  Qt, QGraphics, QDialogs,
{$ELSE}
 {$IFDEF VER210}GIFImg{$ELSE}GIFImage{$ENDIF},Windows,Controls, Graphics, Dialogs,
{$ENDIF}
  math{$IFDEF DEB},funcutils,jclDebug{$ENDIF},
  GR32,dhBitmap32,dhStrUtils,WideStrUtils,dhGraphicFormats,Consts;

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

const atTop=-maxint;
      atBottom=maxint;

type  TPropChoose=(pcAntiAliasing,pcBackgroundAttachment,pcBackgroundColor,pcBackgroundImage,pcBackgroundPosition,pcBackgroundRepeat,pcBorderColor,pcBorderRadius, pcBorderWidth,pcBorderStyle,pcColor,pcContentAfter,pcContentBefore,pcCursor,pcDirection,pcDisplay,pcEffects,pcFontFamily,pcFontSize,pcFontStyle,pcFontVariant,pcFontWeight,pcLetterSpacing,pcLineHeight,pcListStyleType,
                   pcMargin,pcMinHeight,pcMinWidth,pcPadding,pcTextAlign,pcTextDecoration,pcTextIndent,pcTextTransform,pcTransformationsMatrix,pcVerticalAlign,pcVisibility,pcWhiteSpace,pcWordSpacing,pcZIndex,pcOther);

{enumeration for borders, ealNone being the default}
type TEdgeAlign= (ealNone, ealTop, ealBottom, ealLeft, ealRight);

{enumeration for corners, calNone being the default; identified with TEdgeAlign to work with query methods which use TEdgeAlign}
type TCornerAlign=TEdgeAlign;
const calNone=ealNone;
      calTopLeft=ealTop;
      calBottomRight=ealBottom;
      calBottomLeft=ealLeft;
      calTopRight=ealRight;

type
  TOneChanged=(
  wcChild, //propagates changes to children
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


type

  TCSSCursor=(ccuInherit,ccuAuto,ccuCrosshair, ccuDefault, ccuPointer, ccuMove,
    ccuEResize, ccuNeResize, ccuNwResize, ccuNResize, ccuSeResize, ccuSwResize, ccuSResize, ccuWResize,
    ccuText, ccuWait, ccuHelp);
  TCSSTextDecoration=(ctdNone,ctdUnderline,ctdOverline,ctdLineThrough,ctdBlink);
  TCSSTextDecorations=set of TCSSTextDecoration;
  TState=(hsNormal,hsOver,hsDown,hsOverDown);
  TStates=set of TState;
  TCSSStringValue=AString;
  TCSSBackgroundPosition=type TCSSStringValue;
  TCSSVerticalAlign=type TCSSStringValue;
  TCSSLetterSpacing=type TCSSStringValue;
  TCSSWordSpacing=type TCSSStringValue;
  TCSSLineHeight=type TCSSStringValue;
  TCSSFontFamily=type TFontName;
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
  TCSSTextIndent=type TCSSStringValue;
  TCSSFontSize=type TCSSStringValue;//variant;
  TCSSMargin=type TCSSStringValue;//variant;
  TCSSRadius=type TCSSStringValue;
  TCSSFontVariant=(cfvInherit,cfvNormal,cfvSmallCaps);
  TImageType=(bitInherit,bitTile,bitStretch,bitImage,bitSplit);
  TImageFormat=(ifInherit,ifSimple,ifSemiTransparent,ifJPEG);
  TPhysicalImageFormat=(pifSaveAsGIF,pifSaveAsPNG,pifSaveAsJPEG);
  TEffectsOnText=(etInclude,etExclude,etOnly);
  TImageState=(isUninitialized,isAnalyzed,isOnePixel,isSemiTransparent,isAnimatedGIF);

  TStyle=class;
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
  protected
    procedure Changed;
  public
    function GetDoubleRadius:double;
    procedure Clear; virtual; abstract;
    function IsCleared:boolean; virtual; abstract;
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
  end;

  TCSSBorderRadius=class(TPersistent)
  private
  protected
    Owner:TStyle;
    Vals:array[TCornerAlign] of TCSSRadius;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create(AOwner: TStyle);
    procedure Changed;
    procedure SetBorderRadius(Align:TCornerAlign; Value:TCSSRadius);
    function IsCleared:boolean; overload;
    function IsCleared(align:TCornerAlign):boolean; overload;
  published
    property All: TCSSRadius index calNone  read Vals[calNone] write SetBorderRadius;
    property TopLeft: TCSSRadius index calTopLeft read Vals[calTopLeft] write SetBorderRadius;
    property BottomRight: TCSSRadius index calBottomRight read Vals[calBottomRight] write SetBorderRadius;
    property BottomLeft: TCSSRadius index calBottomLeft read Vals[calBottomLeft] write SetBorderRadius;
    property TopRight: TCSSRadius index calTopRight read Vals[calTopRight] write SetBorderRadius;
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
    Owner:TStyle;
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
   property ShiftX:integer read FShiftX write SetShiftX default 0;
   property ShiftY:integer read FShiftY write SetShiftY default 0;
   property ScaleX:integer read FScaleX write SetScaleX default 100;
   property ScaleY:integer read FScaleY write SetScaleY default 100;
   property SkewX:integer read FSkewX write SetSkewX default 0;
   property SkewY:integer read FSkewY write SetSkewY default 0;
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
  protected
   Owner:TStyle;
   FColor:TCSSColor;
   FWidth:TCSSCardinal;
   FStyle:TCSSBorderStyle;
   procedure SetWidth(Value:TCSSCardinal);
   procedure SetColor(Value:TCSSColor);
   procedure SetStyle(Value:TCSSBorderStyle);
   procedure SetAll(Width:Integer;Color:TCSSColor;Style:TCSSBorderStyle);
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

  TLocationImage=class(TPersistent)
  public
    FOnChange:TNotifyEvent;
    FPicture:TPicture;
    FPath:TPathName;
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
    property Picture:TPicture read FPicture;
    function HasPath: Boolean;
    function GraphicExtension:TPathName;
    function GetGraphic:TGraphic;
    function RequestGraphic:TGraphic;
    function HasPicture:boolean;
    destructor Destroy; override;
    constructor Create;
    procedure LoadFromFile(const Filename: TPathName);
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    procedure SetPath(const Path:TPathName);
    function GetRelativePath:TPathName;
    function GetAbsolutePath:TPathName;
    procedure UpdateAnimationState;
  published
    property Path:TPathName read GetRelativePath write SetPath;
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
    AntiAliasing:boolean;
    Transformations:TTransformations;
    Before,After:HypeString;
    BackgroundPosition:TCSSBackgroundPosition;
    VerticalAlign:TCSSVerticalAlign;
    LetterSpacing:TCSSLetterSpacing;
    WordSpacing:TCSSWordSpacing;
    LineHeight:TCSSLineHeight;
    TextIndent:TCSSTextIndent;
    BorderRadius:TCSSRadius;
    Margin:TCSSMargin;
    FontFamily:TCSSFontFamily;
    Other:HypeString;
    FontSize:TCSSFontSize;
    glAT:TdhAffineTransformation;
    glATAlpha,glATShiftX,glATShiftY:single;
    ValStyle:TPersistent;
    TopTextDecoration,ParentTextDecoration:TCSSTextDecorations;
    IsFromParent:boolean;
    SelfHit:boolean;
  end;

  IRelativePathProvider=interface ['{F26D0C91-801B-44A4-86CC-0D265F94F7C6}']
    function GetRelativePath(const Path:TPathName):TPathName;
    function GetAbsolutePath(const Path:TPathName):TPathName;
  end;

  IStyleOwner=interface
    function GetElementName:TComponentName;
    function GetImageFormat: TImageFormat;
    procedure NotifyCSSChanged(WhatChanged:TWhatChanged);
    function IsDesigning:boolean;
    function RecursiveShowing:Boolean;
    function GetRelativePathProvider:IRelativePathProvider;
    function HasTransformations(var tt: TTransformations): boolean;
    function GetControl:TControl;
  end;

  TStyle = class(TPersistent)
  protected
    procedure ReadBool(Reader: TReader);
    procedure SkipValue(Reader: TReader);
    procedure WriteNewPadding(Writer: TWriter);
    procedure WriteNewMargin(Writer: TWriter);
    procedure SetFontVariant(const Value: TCSSFontVariant);
    procedure SetBackgroundAttachment(const Value: TCSSBackgroundAttachment);
    procedure SetDirection(const Value: TCSSDirection);
    procedure SetBefore(const Value: HypeString);
    procedure SetAfter(const Value: HypeString);
  protected
    FBorderColors:TColorName;
    BGImageFile:TPathName;
    _GetWantedSize:TPoint;
    _ContentWidthHeight:TPoint;
    IsWidthStored,IsHeightStored:boolean;
    IsNewPaddingStored,IsNewMarginStored,IsNewBorderStored:boolean;
    _BasePadding,_BaseMargin,_BaseBorder:TRect;
    FDirection: TCSSDirection;
    FBefore: HypeString;
    FAfter: HypeString;
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
    FTransformations:TTransformations;
    FBorderRadius:TCSSBorderRadius;
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
    procedure SetFontFamily(Value:TCSSFontFamily);
    procedure SetColor(Value:TCSSColor);
    procedure SetFontStyle(Value:TCSSFontStyle);
    procedure SetFontWeight(Value:TCSSFontWeight);
    procedure SetTextDecorations(Value:TCSSTextDecorations);
    procedure pcs(WhatChanged:TWhatChanged);
    procedure pc(PropChoose:TPropChoose);
    procedure DefineProperties(Filer: TFiler); override;
    procedure PictureChange(Sender: TObject);
  public
    Owner:IStyleOwner;
    RasteringFile:TPathName;
    OwnState:TState;
    FTextDecoration:TCSSTextDecorations;
    function GetStyleVal(PropChoose:TPropChoose; {var Value:TCSSProp; }const Align:TEdgeAlign):boolean;
    function GetNameByStyle:TPropertyName;
    procedure CopyFrom(s: TStyle; sub:boolean);
    function IsMarginCleared(Align:TEdgeAlign):boolean;
    function IsBGImageCleared: boolean;
    function IsEdgeCleared(Align: TEdgeAlign): boolean;
    function CopyBlurEffectsByInherited: boolean;
    function HasInheritedTransformations(var tt: TTransformations):boolean;
    procedure LoadImage(const filename: TPathName);
    function IsPictureStored:boolean;
    procedure SetPadding(Align:TEdgeAlign; Value:TCSSCardinal=vsrInherit);
    procedure SetMargin(Align:TEdgeAlign; Value:TCSSMargin);
    function GetBorder(Align: TEdgeAlign): TCSSBorder;
    function IsPaddingCleared(Align: TEdgeAlign): boolean;
    procedure AssignEdge(Align: TEdgeAlign; s: TStyle);
    procedure AssignBackground(s: TStyle);
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create(AOwner:IStyleOwner; OwnState:TState);
    destructor Destroy; override;
    function IsStyleStored:boolean;
    function GetBorderByName(const name:TPropertyName; var r:TCSSBorder):boolean;
    procedure ClearEdge(Align:TEdgeAlign);
    property Borders[Align:TEdgeAlign]:TCSSBorder read GetBorder;
    property RepresentingState:TState read OwnState;
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
    property ContentBefore: HypeString read FBefore write SetBefore;
    property ContentAfter: HypeString read FAfter write SetAfter;
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
    property Effects:TTransformations read FTransformations write FTransformations;
    property BorderRadius:TCSSBorderRadius read FBorderRadius write FBorderRadius;
    //TODO: SpeedupGeneration property Generated:TPathName read RasteringFile write RasteringFile;
  end;

function GetVerticalAlignPixels(const Value:TCSSVerticalAlign; FontAscend,FontHeight,OwnAscend,OwnHeight,OwnLineHeight:integer):integer;
function GetLetterSpacing(const Value:TCSSLetterSpacing; FontSize:single):Integer;
function GetWordSpacing(const Value:TCSSWordSpacing; FontSize:single):Integer;
function GetLineHeight(const Value:TCSSLineHeight; ContentHeight,FontSize:integer):integer;
function GetTextIndentPixels(Value:TCSSTextIndent; const FontSize:single):integer;
function GetFontSizePixels(const Value:TCSSFontSize; const ParentFontSize:single):single;
function GetBackgroundPixels(Value:TCSSBackgroundPosition; const rct:TRect; imgWidth,imgHeight:integer; var res:TPoint):boolean;
procedure SplitBackgroundPixels(Value:TCSSBackgroundPosition; var v1,v2:TCSSBackgroundPosition);
function GetBorderRadiusPixels(Value:TCSSRadius; var res:TPoint):boolean;overload;
function GetBorderRadiusPixels(Value:TCSSRadius; var res:TPoint; var IsDouble:boolean):boolean; overload;
function GetShorter(const Top,Right,Bottom,Left:AString):AString;
function GetMarginPixels(Value:TCSSMargin; const FontSize:single):integer;

function GetImageBitmap:TGraphic;

const sStyle:array[TState] of TPropertyName=('Style','StyleOver','StyleDown','StyleOverDown');
const MarginDefault=EmptyStr;
const DefaultNoncomputedFontSize=EmptyStr;//must be EmptyStr for SetFontSize
const AutoInherit=[pcDirection,pcTextAlign,pcTextIndent,pcTextTransform,pcFontSize,pcFontFamily,pcColor,pcFontStyle,pcFontVariant,pcFontWeight,pcLetterSpacing,pcLineHeight,pcListStyleType,pcTextDecoration,pcCursor,pcVisibility,pcWordSpacing];
const RES_PROT='res:';
const RES_PROT_TRANSPARENT='res:TRANSPARENT_';

{set by the HTML generator}
var
    PreventGraphicOnChange:boolean=false; {esp. prevent animated GIF graphics to change while generating images}
    glOnDefineProperties:TNotifyEvent=nil;
    WithMeta:boolean=false;

{used internally when (cascaded) styles are queried}
var
    Cascaded:TCascaded;

{message strings which may be localized}
var
    QUOTEINVALIDVALUE_STR:WideString='"%" is not a valid value';

implementation

var pcChanges:array[TPropChoose] of TWhatChanged=({pcAntiAliasing}[{empty}],{pcBackgroundAttachment}[],{pcBackgroundColor}[wcColor],{pcBackgroundImage}[wcSize,wcText],{pcBackgroundPosition}[],{pcBackgroundRepeat}[],{pcBorderColor}[],{pcBorderRadius}[],{pcBorderWidth}[wcSize,wcText2],{pcBorderStyle}[wcSize,wcText2],{pcColor}[wcFont],{pcContentAfter}[wcText,wcSize],{pcContentBefore}[wcText,wcSize],{pcCursor}[wcCursor],{pcDirection}[wcText2,wcSize],{pcDisplay}[wcText,wcSize],{pcEffects}[wcSize],{pcFontFamily}[wcFont,wcText2,wcSize],{pcFontSize}[wcFont,wcText2,wcSize],{pcFontStyle}[wcSize,wcFont,wcText2],{pcFontVariant}[wcText,wcSize],{pcFontWeight}[wcFont,wcText2,wcSize],{pcLetterSpacing}[wcText2,wcSize],{pcLineHeight}[wcText2,wcSize],{pcListStyleType}[],
                   {pcMargin}[wcSize,wcText2],{pcMinHeight}[wcSize],{pcMinWidth}[wcSize],{pcPadding}[wcSize,wcText2],{pcTextAlign}[wcText2],{pcTextDecoration}[wcFont],{pcTextIndent}[wcText2,wcSize],{pcTextTransform}[wcText,wcSize],{pcTransformationsMatrix}[{empty}],{pcVerticalAlign}[wcText2,wcSize],{pcVisibility}[],{pcWhiteSpace}[wcText,wcSize],{pcWordSpacing}[wcText2,wcSize],{pcZIndex}[wcZIndex],{pcOther}[]);
var ImageBitmap:TBitmap=nil;
var StoredChecking:boolean=false;

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

function MyStrToFloat(s:TCSSStringValue):Extended;
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

function GetPixVal(const Value:TCSSBackgroundPosition; range:integer):integer;
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

function GetPixVal2(const Value:TCSSStringValue; range:integer):integer;
begin
 if SubEqualEnd('%',Value) then
  result:=Round(strtoint(CopyLess(Value,1))/100*range) else
  result:=strtoint(Value);
end;

function GetBorderRadiusPixels(Value:TCSSRadius; var res:TPoint; var IsDouble:boolean):boolean; overload;
var r:integer;
    v1,v2:TCSSRadius;
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

function GetBorderRadiusPixels(Value:TCSSRadius; var res:TPoint):boolean; overload;
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

function GetShorter(const Top,Right,Bottom,Left:AString):AString;
begin
 if (Top=Right) and (Right=Bottom) and (Bottom=Left) then
  result:=Top else
  result:=Top+' '+Right+' '+Bottom+' '+Left;
end;

function GetLineHeight(const Value:TCSSLineHeight; ContentHeight,FontSize:integer):integer;
begin
  if Value='normal' then
   result:=ContentHeight else
   result:=GetPixVal2(Value,FontSize);
end;

function GetLengthPixels(const Value:TCSSStringValue; const FontSize:single):single;
begin
 if not SubEqualEnd('em',Value) then
  result:=strtoint(Value) else
  result:=MyStrToFloat(CopyLess(Value,2))*FontSize;
end;

function GetWordSpacing(const Value:TCSSWordSpacing; FontSize:single):Integer;
begin
  if Value='normal' then
   result:=0 else
   result:=Round(GetLengthPixels(Value,FontSize));
end;

function GetFontSizePixels(const Value:TCSSFontSize; const ParentFontSize:single):single;
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

function GetTextIndentPixels(Value:TCSSTextIndent; const FontSize:single):integer;
begin
 result:=Round(GetLengthPixels(Value,FontSize));
end;

function GetMarginPixels(Value:TCSSMargin; const FontSize:single):integer;
begin
 result:=Round(GetLengthPixels(Value,FontSize));
end;

function GetLetterSpacing(const Value:TCSSLetterSpacing; FontSize:single):Integer;
begin
  if Value='normal' then
   result:=0 else
   result:=Round(GetLengthPixels(Value,FontSize));
end;

procedure SplitBackgroundPixels(Value:TCSSBackgroundPosition; var v1,v2:TCSSBackgroundPosition);
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
var v1,v2,vi:TCSSBackgroundPosition;
begin
 try
 SplitBackgroundPixels(Value,v1,v2);
 if (v2='left') or (v2='right') or (v1='top') or (v1='bottom') then
 begin
  vi:=v1;
  v1:=v2;
  v2:=vi;
 end;
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

procedure TBlurEffect.Assign(Source: TPersistent);
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

procedure TBlurEffect.Changed;
begin
 Owner.Changed;
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

constructor TCSSBorderRadius.Create(AOwner:TStyle);
begin
  inherited Create;
  Owner:=AOwner;
end;

procedure TCSSBorderRadius.SetBorderRadius(Align:TCornerAlign; Value:TCSSRadius);
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

procedure TCSSBorderRadius.Changed;
begin
  if Owner<>nil then
   Owner.pc(pcBorderRadius);
end;

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

procedure TTransformations.Assign(Source: TPersistent);
var tt:TTransformations;
begin
  if Source is TTransformations then
  begin
    tt:=TTransformations(Source);
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
 Reader.SkipValue;
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

function TTransformations.IsAntiAliasingStored: Boolean;
begin
 result:=FEnabled or FAntiAliasing;
end;

function TTransformations.IsTextStored: Boolean;
begin
 result:=FEnabled or (FText<>etInclude);
end;

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

procedure TCSSBorder.SetWidth(Value:TCSSCardinal);
begin
 if FWidth<>Value then
 begin
  FWidth:=Value;
  if (Value>0) and (FStyle=cbsNone) then
   FStyle:=cbsSolid;
  Owner.pc(pcBorderWidth);
 end;
end;

procedure TCSSBorder.SetColor(Value:TCSSColor);
begin
 if FColor<>Value then
 begin
  FColor:=Value;
  Owner.pc(pcBorderColor);
 end;
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
 if FStyle<>Value then
 begin
  FStyle:=Value;
  Owner.pc(pcBorderStyle);
 end;
end;

procedure TCSSBorder.SetAll(Width:Integer;Color:TCSSColor;Style:TCSSBorderStyle);
begin
 FWidth:=Width;
 FColor:=Color;
 FStyle:=Style;
 Owner.pcs(pcChanges[pcBorderWidth]+pcChanges[pcBorderColor]+pcChanges[pcBorderStyle]);
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

type TFakePicture=class(TPicture);

procedure TLocationImage.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    result:=not ((Filer.Ancestor is TLocationImage) and (TLocationImage(Filer.Ancestor).FPicture=FPicture));
  end;

begin
 if (Filer is TWriter) then
 begin
  if FPicture<>nil then
  begin
   if DoWrite and not HasPath then
    TFakePicture(FPicture).DefineProperties(Filer);
  end;
 end else
 if (Filer is TReader) then
 begin
  if FPicture<>nil then
   Assign(Nil);
  if FPicture=nil then
  begin
    FPicture:=TPicture.Create;
    try
     TFakePicture(FPicture).DefineProperties(Filer);
    except
     FreeAndNil(FPicture);
    end;
    UpdateCalculations(true);
  end;
 end;
end;

function TLocationImage.GetGraphic:TGraphic;
begin
 if FPicture<>nil then
  result:=FPicture.Graphic else
  result:=nil;
end;

function TLocationImage.RequestGraphic:TGraphic;
var NewGraphic: TGraphic;
    Filename,Ext:TPathName;
    ResourceBitmap:TBitmap;
begin
 if GetGraphic<>nil then
 begin
  result:=GetGraphic;
 end else
 if HasPath then
 begin
  FreeAndNil(FPicture);
  FPicture:=TPicture.Create;
  try
   if Copy(FPath,1,Length(RES_PROT))=RES_PROT then
   begin
    ResourceBitmap := TBitmap.Create;
    ResourceBitmap.LoadFromResourceName(HInstance, Copy(FPath,Length(RES_PROT)+1));
    if Copy(FPath,1,Length(RES_PROT_TRANSPARENT))=RES_PROT_TRANSPARENT then
    begin
     ResourceBitmap.Transparent:=true;
    end;
    FPicture.Assign(ResourceBitmap);
   end else
   begin
    Filename:=GetAbsolutePath;
    Ext:=ExtractFileExt(Filename);
    if LowerCase(Ext)='.gif' then
    begin
     NewGraphic := TPatchedGifImage.Create;
     try
       NewGraphic.LoadFromFile(Filename);
       FPicture.Assign(NewGraphic);
     finally
       NewGraphic.Free;
     end;
    end else
    if Ext='' then
    begin
     // handle this case since TOleGraphic register empty extension otherwise and loads an empty image
     raise EInvalidGraphic.CreateFmt(SUnknownExtension, [Ext]);
    end else
     FPicture.LoadFromFile(Filename);
   end;
   FPicture.OnChange:=Changed;
  except
    FreeAndNil(FPicture);
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
 FreeAndNil(FPicture);
 FPath:='';
 FImageState:=isUninitialized;
end;

procedure TLocationImage.LoadFromFile(const Filename: TPathName);
begin
 Clear;
 FPath:=Filename;
 Changed(Self);
end;

procedure TLocationImage.Assign(Source: TPersistent);
begin
  if (Source=FPicture) or (Source<>nil{FPicture.Source can be nil}) and (Source=GetGraphic) then exit;

  if FPicture<>nil then
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
   Source:=TLocationImage(Source).FPicture;
  end;

  if (Source is TPicture) then
  begin
   Source:=TPicture(Source).Graphic;
  end;

  if Source <> nil then
  if Source is TGraphic then
  begin
    FPicture:=TPicture.Create;
    FPicture.Graphic:=TGraphic(Source);
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

function TLocationImage.CalculateImgCanT1X1:boolean;
begin
 result:=(GetGraphic<>nil) and (GetGraphic.Width=1) and (GetGraphic.Height=1) and HasSemiTransparence(GetGraphic);
end;

function TLocationImage.ImgIsT1X1:boolean;
begin
 RequestCalculations;
 result:=(FImageState=isOnePixel) and (Owner.Owner.GetImageFormat=ifSemiTransparent);
end;

function TLocationImage.ImgNeedBeRastered:boolean;
begin
 RequestCalculations;
 result:=(FImageState in [isOnePixel,isSemiTransparent]) and not ImgIsT1X1;
end;

function TLocationImage.IsAnimatedGIF:boolean;
begin
 RequestCalculations;
 result:=FImageState=TImageState.isAnimatedGIF;
end;

function TLocationImage.CalculateImgCouldBeRastered:boolean;
begin
 result:=HasSemiTransparence(GetGraphic);
end;

function TLocationImage.CalculateAnimatedGIF:boolean;
begin
 result:=(GetGraphic is TGIFImage) and (TGIFImage(GetGraphic).Images.Count>=2);
end;

function TLocationImage.HasPicture:boolean;
begin
 result:=(GetGraphic<>nil) or HasPath;
end;

procedure TLocationImage.UpdateAnimationState;
begin
 if (Owner<>nil) and (Owner.Owner<>nil) and (GetGraphic is TGIFImage) then
 if Owner.Owner.IsDesigning then
 begin
  TGIFImage(GetGraphic).Animate:=false;
{$IFNDEF VER210}
  TGIFImage(GetGraphic).ForceFrame:=0;
{$ENDIF}
 end else
 begin
  TGIFImage(GetGraphic).Animate:=true;
 end;
end;

procedure TLocationImage.UpdateCalculations;
begin
 if GetGraphic=nil then
 begin
  FImageState:=isUninitialized;
 end else
 begin
  FPicture.OnChange:=Changed;
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
   FImageState:=TImageState.isAnimatedGIF;
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
 if (FPicture<>nil) and HasPath and not CachingIsUseful then
 begin
  FreeAndNil(FPicture);
 end;
end;

function TLocationImage.HasPath: Boolean;
begin
 result:=FPath<>'';
end;

function TLocationImage.GraphicExtension:TPathName;
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
begin
 result:=(self.Owner<>nil) and (self.Owner.Owner<>nil) and self.Owner.Owner.RecursiveShowing;
end;

procedure TLocationImage.SetPath(const Path:TPathName);
var RelativePathProvider:IRelativePathProvider;
begin
  RelativePathProvider:=nil;
  if (self.Owner<>nil) and (self.Owner.Owner<>nil)  then
   RelativePathProvider:=self.Owner.Owner.GetRelativePathProvider;
  if RelativePathProvider<>nil then
  begin
   FPath:=RelativePathProvider.GetAbsolutePath(Path);
   Exit;
  end;
  FPath:=Path;
end;

function TLocationImage.GetRelativePath:TPathName;
var RelativePathProvider:IRelativePathProvider;
begin
  RelativePathProvider:=nil;
  if (self.Owner<>nil) and (self.Owner.Owner<>nil)  then
   RelativePathProvider:=self.Owner.Owner.GetRelativePathProvider;
  if RelativePathProvider<>nil then
  begin
   Result:=RelativePathProvider.GetRelativePath(FPath);
   Exit;
  end;
  Result:=FPath;
end;

function TLocationImage.GetAbsolutePath:TPathName;
var RelativePathProvider:IRelativePathProvider;
begin
  RelativePathProvider:=nil;
  if (self.Owner<>nil) and (self.Owner.Owner<>nil)  then
   RelativePathProvider:=self.Owner.Owner.GetRelativePathProvider;
  if RelativePathProvider<>nil then
  begin
   Result:=RelativePathProvider.GetAbsolutePath(FPath);
   Exit;
  end;
  Result:=FPath;
end;

function TStyle.GetNameByStyle:TPropertyName;
begin
 result:=sStyle[OwnState];
end;

function TStyle.GetBorderByName(const name:TPropertyName; var r:TCSSBorder):boolean;
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

procedure TStyle.SkipValue(Reader: TReader);
begin
 Reader.SkipValue;
end;

procedure TStyle.WriteNewPadding(Writer: TWriter);
begin
 with _BasePadding do
  Writer.WriteString(GetShorter(IntToStr(Top)+'px',IntToStr(Right)+'px',IntToStr(Bottom)+'px',IntToStr(Left)+'px'));
end;

procedure TStyle.WriteNewMargin(Writer: TWriter);
begin
 with _BaseMargin do
  Writer.WriteString(GetShorter(IntToStr(Top)+'px',IntToStr(Right)+'px',IntToStr(Bottom)+'px',IntToStr(Left)+'px'));
end;

procedure TStyle.ReadBool(Reader: TReader);
begin
 Reader.ReadBoolean;
end;

procedure TStyle.DefineProperties(Filer: TFiler);
begin
  inherited;
  if Assigned(glOnDefineProperties) then
    glOnDefineProperties(Self);
end;

procedure TStyle.Clear;
var Align:TEdgeAlign;
begin
    InitMisc;
    for Align:=low(TEdgeAlign) to high(TEdgeAlign) do
    begin
     FBorders[Align].Clear;
     FMargins[Align]:=EmptyStr;
    end;
    FBackgroundImage.Assign(nil);
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
    FTransformations.Clear;
    FBorderRadius.Clear;
    pcs(AllChanged);
end;

procedure TStyle.PictureChange(Sender: TObject);
begin
 if not PreventGraphicOnChange then
  pc(pcBackgroundImage);
end;

constructor TStyle.Create(AOwner:IStyleOwner; OwnState:TState);
var Align:TEdgeAlign;
begin
  inherited Create;
  Owner:=AOwner;
  Self.OwnState:=OwnState;
  FBackgroundImage := TLocationImage.Create;
  FBackgroundImage.OnChange := PictureChange;
  FBackgroundImage.Owner:=Self;
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

function TStyle.IsStyleStored:boolean;
var PropChoose:TPropChoose;
begin
 StoredChecking:=true;
 try
 for PropChoose:=Low(TPropChoose) to High(PropChoose) do
 begin
 Cascaded.ValStyle:=nil;
 if GetStyleVal(PropChoose,ealNone) or (Cascaded.ValStyle<>nil) then
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

procedure TStyle.pc(PropChoose:TPropChoose);
begin
 pcs(pcChanges[PropChoose]);
end;

procedure TStyle.pcs(WhatChanged:TWhatChanged);
begin
 if Owner<>nil then
  Owner.NotifyCSSChanged(WhatChanged);
end;

procedure TStyle.SetPadding(Align:TEdgeAlign; Value:TCSSCardinal=vsrInherit);
begin
 if FPaddings[Align]<>Value then
 begin
  FPaddings[Align]:=Value;
  pc(pcPadding);
 end;
end;

function TStyle.CopyBlurEffectsByInherited:boolean;
var tt:TTransformations;
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

procedure TStyle.SetMargin(Align:TEdgeAlign; Value:TCSSMargin);
begin
 if FMargins[Align]<>Value then
 try
  if Value<>EmptyStr then
   GetMarginPixels(Value,0);
  FMargins[Align]:=Value;
  pc(pcMargin);
 except
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 end;
end;

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

procedure TStyle.SetBackgroundPosition(Value:TCSSBackgroundPosition);
var res:TPoint;
begin
 Value:=Trim(Value);
 if (Value<>EmptyStr) and not GetBackgroundPixels(Value,Rect(0,0,0,0),0,0,res) then
  raise WException.Create(WFormat(QUOTEINVALIDVALUE_STR,[Value]));
 FBackgroundPosition:=Value;
 pc(pcBackgroundPosition);
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

function TStyle.GetBorder(Align: TEdgeAlign): TCSSBorder;
begin
 result:=FBorders[Align];
end;

function TStyle.IsPaddingCleared(Align: TEdgeAlign): boolean;
begin
 result:=FPaddings[Align]=vsrInherit;
end;

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
  glATAlpha:=glATAlpha*FTransformations.Alpha/255;
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
 if IsPictureStored then
 begin
  Picture:=FBackgroundImage;
  Result:=true;
 end;
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
 pcListStyleType:
 begin
  if not SelfHit then
  begin
   if FListStyleType<>low(TCSSListStyleType) then
   begin
    if ValStyle=nil then
    begin
     ListStyleType:=FListStyleType;
     if Owner.GetElementName<>'ul' then
      result:=true;
    end else
    begin
     if (Owner.GetElementName='ul') or (Owner.GetElementName='ol') then
     begin
      case ListStyleType of
      clsDisk:   ListStyleType:=clsCircle;
      clsCircle: ListStyleType:=clsSquare;
      clsSquare: {don't modify};
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
 else
  showmessage('TStyle.GetVal errornoues')
 end;
 if Result then
  Cascaded.ValStyle:=Self;
end;

procedure TStyle.AssignBackground(s: TStyle);
begin
 if s<>nil then
 begin
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

procedure TStyle.LoadImage(const filename:TPathName);
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

procedure TStyle.ClearEdge(Align: TEdgeAlign);
begin
 FBorders[Align].Clear;
 FMargins[Align]:=MarginDefault;
 FPaddings[Align]:=vsrInherit;
 pcs(pcChanges[pcMargin]+pcChanges[pcPadding]+(pcChanges[pcBorderWidth]+pcChanges[pcBorderColor]+pcChanges[pcBorderStyle]));
end;

procedure TStyle.SetFontVariant(const Value: TCSSFontVariant);
begin
 FFontVariant := Value;
 pc(pcFontVariant);
end;

procedure TStyle.SetBackgroundAttachment(const Value: TCSSBackgroundAttachment);
begin
  FBackgroundAttachment := Value;
  pc(pcBackgroundAttachment);
end;

procedure TStyle.SetDirection(const Value: TCSSDirection);
begin
  FDirection := Value;
  pc(pcDirection);
end;

procedure TStyle.SetBefore(const Value: HypeString);
begin
  FBefore := Value;
  pc(pcContentBefore);
end;

procedure TStyle.SetAfter(const Value: HypeString);
begin
  FAfter := Value;
  pc(pcContentAfter);
end;

var PropChoose:TPropChoose;

initialization

 for PropChoose:=Low(TPropChoose) to high(TPropChoose) do
 if PropChoose in AutoInherit then
  pcChanges[PropChoose]:=pcChanges[PropChoose]+[wcChild];

finalization

 FreeAndNil(ImageBitmap);

end.
