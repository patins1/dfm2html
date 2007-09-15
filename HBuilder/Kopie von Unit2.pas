unit Unit2;

interface

uses
  SysUtils, Classes, TypInfo, {$IFNDEF VER130} types, {schnelles IntersectRect} {$ENDIF}
{$IFDEF CLX}
  QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls, QComCtrls,
  QStdCtrls, QImgList, QMenus, QStyle,
{$ELSE}
  Controls, Forms, Windows, Messages, Graphics, Dialogs, ExtDlgs, ExtCtrls, clipbrd, Buttons, GIFImage, JPeg,
  ComCtrls, CommCtrl, StdCtrls, ShellAPI, RTLConsts,  Menus,
  Mask, ToolWin, ImgList, AppEvnts, Spin,
{$ENDIF}
  OpenSave, binlist,
  dhPanel, dhLabel, uChooseWide,
  dhPageControl, dhStyleSheet, dhMenu,
  math, Unit3, funcutils, uGradientWizard, dhPureHTML,
  dhEdit, dhMemo, dhCheckBox,dhHTMLForm,dhListBox, dhFileField,
  {ColorPickerButton,}  dhColorPicker,
  dhMultilineCaptionEdit, dhRadioButton,
  hComboBox, hEdit, hMemo,
  dhOleContainer,dhHiddenField,GR32,
  MyTabControl, MyPageControl, MyFontDialog,
  MySpinEdit, MyTrackBar, hCheckBox, dhSelect;


var PropsAlign:TAlign=alBottom;

//const ButtonClear:array[boolean] of TColor=(clBlack,clGray);

type
  TPropsPC = class(TFrame,IhLogReceiver)
    PageControl1: TMyPageControl;
    AnchorFont: TTabSheet;
    AnchorBorder: TTabSheet;
    AnchorBackground: TTabSheet;
    AnchorPosition: TTabSheet;
    SampleFont: TdhLabel;
    FontDialog1: TMyFontDialog;
    FontStatus: TdhLabel;
    SampleBorder: TdhPanel;
    OpenPictureDialog1: TMyOpenPictureDialog;
    dhPanel2: TdhPanel;
    SamplePosition: TdhPanel;
    GroupBox1: TGroupBox;
    cClient: TRadioButton;
    cNone: TRadioButton;
    cLeft: TRadioButton;
    cTop: TRadioButton;
    cRight: TRadioButton;
    cBottom: TRadioButton;
    GroupBox2: TGroupBox;
    caLeft: TCheckBox;
    caTop: TCheckBox;
    caRight: TCheckBox;
    caBottom: TCheckBox;
    AnchorName: TTabSheet;
    AnchorPage: TTabSheet;
    AnchorPageControl: TTabSheet;
    AnchorLink: TTabSheet;
    SavePictureDialog1: TMySavePictureDialog;
    AnchorEdit: TTabSheet;
    AnchorCheckBox: TTabSheet;
    AnchorComboBox: TTabSheet;
    dhLabel23: TdhLabel;
    dhComboBox2: ThComboBox;
    dhLabel24: TdhLabel;
    dhLabel22: TdhLabel;
    AnchorListBox: TTabSheet;
    dhLabel25: TdhLabel;
    dhComboBox3: ThComboBox;
    dhLabel27: TdhLabel;
    cMultiSelect: TCheckBox;
    AnchorForm: TTabSheet;
    GroupBox4: TGroupBox;
    spLeft: TMySpinEdit;
    spTop: TMySpinEdit;
    dhLabel29: TdhLabel;
    dhLabel30: TdhLabel;
    dhLabel31: TdhLabel;
    spWidth: TMySpinEdit;
    dhLabel32: TdhLabel;
    spHeight: TMySpinEdit;
    cAutoX: TCheckBox;
    cAutoY: TCheckBox;
    AnchorStyle: TTabSheet;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    slMargin: TMyTrackBar;
    slPadding: TMyTrackBar;
    spPadding: TMySpinEdit;
    spMargin: TMySpinEdit;
    dhLabel2: TdhLabel;
    dhLabel6: TdhLabel;
    GroupBox7: TGroupBox;
    slBorder: TMyTrackBar;
    dhLabel3: TdhLabel;
    spBorder: TMySpinEdit;
    dhLabel5: TdhLabel;
    dhComboBox1: ThComboBox;
    GroupBox8: TGroupBox;
    dhLabel8: TdhLabel;
    spBGX: TMySpinEdit;
    slBGX: TMyTrackBar;
    dhComboBoxX: ThComboBox;
    dhComboBoxY: ThComboBox;
    slBGY: TMyTrackBar;
    spBGY: TMySpinEdit;
    dhLabel9: TdhLabel;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    cbMethod: ThComboBox;
    dhLabel28: TdhLabel;
    dhLabel26: TdhLabel;
    GroupBox11: TGroupBox;
    dhLabel14: TdhLabel;
    cbLinkPage: ThComboBox;
    cbLinkAnchor: ThComboBox;
    dhLabel15: TdhLabel;
    eAction: ThEdit;
    AnchorEffects: TTabSheet;
    PageControl2: TdhPageControl;
    TabSheet3: TdhPage;
    cAntiAliasing: TCheckBox;
    cUseBased: TCheckBox;
    TabSheet7: TdhPage;
    Label9: TLabel;
    Label10: TLabel;
    slSkewX: TMyTrackBar;
    spSkewX: TMySpinEdit;
    spSkewY: TMySpinEdit;
    slSkewY: TMyTrackBar;
    TabSheet8: TdhPage;
    TabControl1: TMyTabControl;
    Button1: TButton;
    bClearFont: TButton;
    bClearEdge: TButton;
    bClearImage: TButton;
    AnchorText: TTabSheet;
    Button8: TButton;
    PopupMenu2: TPopupMenu;
    mText: TMenuItem;
    mMenu: TMenuItem;
    N6: TMenuItem;
    Sendtoback1: TMenuItem;
    Bringtofront1: TMenuItem;
    N5: TMenuItem;
    Aligntogrid1: TMenuItem;
    AnchorMenu: TTabSheet;
    Button10: TButton;
    mSubMenu: TMenuItem;
    mNewPage: TMenuItem;
    cBold: TCheckBox;
    cItalic: TCheckBox;
    cUnderline: TCheckBox;
    cLineThrough: TCheckBox;
    cOverline: TCheckBox;
    cTransparent: TCheckBox;
    cpBackgroundColor: TdhColorPicker;
    cpBorderColor: TdhColorPicker;
    Button11: TButton;
    Button12: TButton;
    SaveImage1: TMenuItem;
    N1: TMenuItem;
    AnchorMore: TTabSheet;
    GroupBox13: TGroupBox;
    cDownIfMenu: TCheckBox;
    cDownIfMouseDown: TCheckBox;
    cDownIfOver: TCheckBox;
    cDown: TCheckBox;
    cDownIfUrl: TCheckBox;
    GroupBox14: TGroupBox;
    cInline: TCheckBox;
    cResumeOpen: TCheckBox;
    cStatic: TCheckBox;
    cHorizontalLayout: TCheckBox;
    CheckGroupBox1: TGroupBox;
    spSlidePixel: TMySpinEdit;
    Label20: TLabel;
    Label21: TLabel;
    Button17: TButton;
    Label27: TLabel;
    cRightJustify: TCheckBox;
    cDoAction: ThComboBox;
    Button9: TButton;
    eHTMLAttributes: ThEdit;
    GroupBox16: TGroupBox;
    cDynamicNavigation: TCheckBox;
    cFixedHeight: TCheckBox;
    bClearMore: TButton;
    bClearEffects: TButton;
    eComboBoxTarget: ThEdit;
    eComboBox: ThMemo;
    eListBox: ThMemo;
    N2: TMenuItem;
    mGoto: TMenuItem;
    mGotoUse: TMenuItem;
    mGotoLink: TMenuItem;
    mGotoFragment: TMenuItem;
    AnchorFormButton: TTabSheet;
    GroupBox17: TGroupBox;
    rbSubmitButton: TRadioButton;
    rbResetButton: TRadioButton;
    mStyleInfo: TMenuItem;
    N3: TMenuItem;
    mStyles: TMenuItem;
    PushstylestoUseelement1: TMenuItem;
    PullstylesfromUseelement1: TMenuItem;
    Clearallstyles1: TMenuItem;
    AnchorMemo: TTabSheet;
    eMemo: ThMemo;
    Label35: TLabel;
    Pullstylesfromelementinclipboard1: TMenuItem;
    N4: TMenuItem;
    Panel1: TdhPanel;
    GroupBox21: TGroupBox;
    Label19: TLabel;
    eName: ThEdit;
    Text: TGroupBox;
    Label31: TLabel;
    eText: ThEdit;
    GroupBox22: TGroupBox;
    dhLabel16: TdhLabel;
    eTitle: ThEdit;
    eOutputDirectory: ThEdit;
    dhLabel4: TdhLabel;
    GroupBox23: TGroupBox;
    Label1: TLabel;
    ComboBox1: ThComboBox;
    cBGFixed: ThCheckBox;
    GroupBox24: TGroupBox;
    Label25: TLabel;
    cbTextTransform: ThComboBox;
    cbWhiteSpace: ThComboBox;
    cbFontVariant: ThComboBox;
    Label26: TLabel;
    Label13: TLabel;
    GroupBox25: TGroupBox;
    Label16: TLabel;
    cbVerticalAlign: ThComboBox;
    cbTextIndent: ThComboBox;
    Label18: TLabel;
    Label12: TLabel;
    cbTextAlign: ThComboBox;
    GroupBox26: TGroupBox;
    Label15: TLabel;
    cbCursor: ThComboBox;
    cbZIndex: ThComboBox;
    Label24: TLabel;
    Label30: TLabel;
    cbDirection: ThComboBox;
    GroupBox28: TGroupBox;
    dhLabel19: TdhLabel;
    dhLabel1: TdhLabel;
    eTarget: ThComboBox;
    eLink: ThComboBox;
    GroupBox18: TGroupBox;
    Label2: TLabel;
    cbUse: ThComboBox;
    cDownOverlayOver: TRadioButton;
    cOverOverlayDown: TRadioButton;
    Image1: TImage;
    Label36: TLabel;
    Panel2: TPanel;
    Button14: TButton;
    Button16: TButton;
    Button7: TButton;
    Button13: TButton;
    GroupBox15: TGroupBox;
    eEdit: ThEdit;
    GroupBox20: TGroupBox;
    cReadOnly: TCheckBox;
    cPassword: TCheckBox;
    GroupBox29: TGroupBox;
    cMemoReadOnly: TCheckBox;
    cWrap: TCheckBox;
    Label11: TLabel;
    cpBlurColor: TdhColorPicker;
    spBlurRadius: TMySpinEdit;
    cBlurEnabled: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    slScaleX: TMyTrackBar;
    spScaleX: TMySpinEdit;
    spScaleY: TMySpinEdit;
    slScaleY: TMyTrackBar;
    cFullIfEasy: TCheckBox;
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    slShiftX: TMyTrackBar;
    spShiftX: TMySpinEdit;
    spShiftY: TMySpinEdit;
    slShiftY: TMyTrackBar;
    slAngle: TMyTrackBar;
    spAngle: TMySpinEdit;
    slMasterAlpha: TMyTrackBar;
    spMasterAlpha: TMySpinEdit;
    pcnav_vert: TdhPanel;
    Panel5: TPanel;
    lOpacity: TLabel;
    lFlood: TLabel;
    lDistance: TLabel;
    lDegree: TLabel;
    spBlurAlpha: TMySpinEdit;
    spBlurFlood: TMySpinEdit;
    spBlurDistance: TMySpinEdit;
    spBlurDegree: TMySpinEdit;
    cEffectsEnabled: TCheckBox;
    cpFontColor: TdhColorPicker;
    dhStyleSheet1: TdhStyleSheet;
    Label14: TdhLabel;
    dhLink1: TdhLink;
    dhLink2: TdhLink;
    dhLink3: TdhLink;
    Link1: TdhLink;
    pcnav_horz: TdhPanel;
    dhLink4: TdhLink;
    dhLink5: TdhLink;
    dhLink6: TdhLink;
    dhLink7: TdhLink;
    Panel31: TPanel;
    dhPanel1: TdhPanel;
    GroupBox30: TGroupBox;          
    dhLabel7: TdhLabel;
    eFormTarget: ThComboBox;
    cCenter: TRadioButton;
    mPageProperties: TMenuItem;
    Button3: TButton;
    mOle: TMenuItem;
    AnchorHidden: TTabSheet;
    GroupBox31: TGroupBox;
    eHiddenField: ThEdit;
    AnchorOle: TTabSheet;
    Button2: TButton;
    Button4: TButton;
    cTextOnly: TCheckBox;
    PopupMenu1: TPopupMenu;
    CopyImage1: TMenuItem;
    PasteImage1: TMenuItem;
    mChangeColors: TMenuItem;
    dhComboBox4: ThComboBox;
    Label17: TLabel;
    cTransparentWhite: TCheckBox;
    mSaveImageToFile: TMenuItem;
    N7: TMenuItem;
    vs: TListBox;
    dhPureHTML1: TdhPureHTML;
    cSlide: TCheckBox;
    GroupBox32: TGroupBox;
    cbParentMenuItem: ThComboBox;
    cOpenByOver: TCheckBox;
    spReactionTime: TMySpinEdit;
    Label22: TLabel;
    slBlurFlood: TMyTrackBar;
    slBlurDistance: TMyTrackBar;
    slBlurDegree: TMyTrackBar;
    slBlurAlpha: TMyTrackBar;
    bBorderRadius: TButton;
    cLinkAuto: TCheckBox;
    cLinkLayout: TRadioGroup;
    cFormButtonLayout: TRadioGroup;
    cMenuAuto: TCheckBox;
    ExchangeDownandOverStyles1: TMenuItem;
    Align1: TMenuItem;
    N8: TMenuItem;
    mLeftEdges: TMenuItem;
    mRightEdges: TMenuItem;
    mTopEdges: TMenuItem;
    mBottomEdges: TMenuItem;
    N9: TMenuItem;
    mEqualHorizontal: TMenuItem;
    mEqualVertical: TMenuItem;
    N10: TMenuItem;
    LoadfromHTTPaddress1: TMenuItem;
    bMoreMisc: TButton;
    fasdf: TButton;
    AnchorSelect: TTabSheet;
    dhSelect1: TdhSelect;
    GroupBox12: TGroupBox;
    Label29: TLabel;
    Label34: TLabel;
    cSelectSelected: TCheckBox;
    eSelectLabel: ThEdit;
    eSelectValue: ThEdit;
    Panel4: TPanel;
    Button5: TButton;
    bMoveItemUp: TButton;
    bMoveItemDown: TButton;
    bDeleteItem: TButton;
    GroupBox19: TGroupBox;
    cMultiple: TCheckBox;
    cMenu: TRadioButton;
    cList: TRadioButton;
    rgChecked: TRadioGroup;
    GroupBox33: TGroupBox;
    eCheckValue: ThEdit;
    Label23: TLabel;
    cFontFamily: ThComboBox;
    cFontSize: ThComboBox;
    dhStyleSheet2: TdhStyleSheet;
    dhLink8: TdhLink;
    dhPanel3: TdhPanel;
    cAll: TdhLink;
    cBottomLeft: TdhLink;
    cTopRight: TdhLink;
    cTopLeft: TdhLink;
    cBottomRight: TdhLink;
    procedure Button1Click(Sender: TObject);
    procedure bClearEdgeClick(Sender: TObject);
    procedure ClearFontClick(Sender: TObject);
    procedure dhAnchor3Click(Sender: TObject);
    procedure bClearBackgroundClick(Sender: TObject);
    procedure cBoldClick(Sender: TObject);
    procedure cNoneClick(Sender: TObject);
    procedure dhAnchor4Click(Sender: TObject);
    procedure dhAnchor8Click(Sender: TObject);
    procedure AnchorPageControlShow(Sender: TObject);
    procedure dhAnchor11Click(Sender: TObject);
    procedure dhAnchor9Click(Sender: TObject);
    procedure AnchorLinkShow(Sender: TObject);
    procedure cbLinkTypeClick(Sender: TObject);
    procedure dhAnchor13Click(Sender: TObject);
    procedure dhAnchor14Click(Sender: TObject);
    procedure dhAnchor15Click(Sender: TObject);
    procedure cMultiSelectClick(Sender: TObject);
    procedure cAutoXClick(Sender: TObject);
    procedure dhAnchor26Click(Sender: TObject);
    procedure spAngleChange(Sender: TObject);
    procedure cRenderClick(Sender: TObject);
    procedure cpFontColorColorChanged(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure cpBorderColorColorChanged(Sender: TObject);
    procedure AnchorStyleShow(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure AnchorEffectsShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cClearStylesClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure mSubMenuClick(Sender: TObject);
    procedure Aligntogrid1Click(Sender: TObject);
    procedure Sendtoback1Click(Sender: TObject);
    procedure Bringtofront1Click(Sender: TObject);
    procedure cTransparentClick(Sender: TObject);
    procedure cFixedHeightClick(Sender: TObject);
    procedure SaveImage1Click(Sender: TObject);
    procedure AnchorMoreShow(Sender: TObject);
    procedure cbCursorDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbCursorMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure cDownIfUrlClick(Sender: TObject);
    procedure cbLinkPageDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbUseDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure AnchorMenuShow(Sender: TObject);
    procedure AnchorNameShow(Sender: TObject);
    procedure AnchorFontShow(Sender: TObject);
    procedure AnchorComboBoxShow(Sender: TObject);
    procedure AnchorListBoxShow(Sender: TObject);
    procedure cReadOnlyClick(Sender: TObject);
    procedure AnchorEditShow(Sender: TObject);
    procedure AnchorCheckBoxShow(Sender: TObject);
    procedure cCheckedClick(Sender: TObject);
    procedure cRightJustifyClick(Sender: TObject);
    procedure cDownOverlayOverClick(Sender: TObject);
    procedure cExtendedUseClick(Sender: TObject);
    procedure AnchorBorderShow(Sender: TObject);
    procedure AnchorPositionShow(Sender: TObject);
    procedure AnchorBackgroundShow(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure PageControl1DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure AnchorTextShow(Sender: TObject);
    procedure AnchorPageShow(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure cDynamicNavigationClick(Sender: TObject);
    procedure bClearMoreClick(Sender: TObject);
    procedure bClearEffectsClick(Sender: TObject);
    procedure mGotoUseClick(Sender: TObject);
    procedure mGotoLinkClick(Sender: TObject);
    procedure mGotoFragmentClick(Sender: TObject);
    procedure rbSubmitButtonClick(Sender: TObject);
    procedure AnchorFormButtonShow(Sender: TObject);
    procedure mStyleInfoClick(Sender: TObject);
    procedure AnchorFormShow(Sender: TObject);
    procedure cMemoReadOnlyClick(Sender: TObject);
    procedure AnchorMemoShow(Sender: TObject);
    procedure cPasswordClick(Sender: TObject);
    procedure cWrapClick(Sender: TObject);
    procedure Pullstylesfromelementinclipboard1Click(Sender: TObject);
    procedure cEffectsEnabledClick(Sender: TObject);
    procedure mPagePropertiesClick(Sender: TObject);
    procedure mOleClick(Sender: TObject);
    procedure AnchorHiddenShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure dhPanel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mChangeColorsClick(Sender: TObject);
    procedure TabControl2Change(Sender: TObject);
    procedure TabControl2DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure cTransparentWhiteClick(Sender: TObject);
    procedure AnchorOleShow(Sender: TObject);
    procedure CopyImage1Click(Sender: TObject);
    procedure mSaveImageToFileClick(Sender: TObject);
    procedure vsClick(Sender: TObject);
    procedure rbFORMDIVClick(Sender: TObject);
    procedure cbCursorDropDown(Sender: TObject);
    procedure cSlideClick(Sender: TObject);
    procedure cOpenByOverClick(Sender: TObject);
    procedure bBorderRadiusClick(Sender: TObject);
    procedure spMarginValueChange(Sender: TObject; Clear: Boolean);
    procedure spPaddingValueChange(Sender: TObject; Clear: Boolean);
    procedure spBorderValueChange(Sender: TObject; Clear: Boolean);
    procedure spBGXValueChange(Sender: TObject; Clear: Boolean);
    procedure spLeftValueChange(Sender: TObject; Clear: Boolean);
    procedure spSkewXValueChange(Sender: TObject; Clear: Boolean);
    procedure eTextValueChange(Sender: TObject; Clear: Boolean);
    procedure eEditValueChange(Sender: TObject; Clear: Boolean);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure eNameValueChange(Sender: TObject; Clear: Boolean);
    procedure eTitleValueChange(Sender: TObject; Clear: Boolean);
    procedure eOutputDirectoryValueChange(Sender: TObject; Clear: Boolean);
    procedure eComboBoxTargetValueChange(Sender: TObject; Clear: Boolean);
    procedure eActionValueChange(Sender: TObject; Clear: Boolean);
    procedure eHiddenFieldValueChange(Sender: TObject; Clear: Boolean);
    procedure eMemoValueChange(Sender: TObject; Clear: Boolean);
    procedure eComboBoxValueChange(Sender: TObject; Clear: Boolean);
    procedure eListBoxValueChange(Sender: TObject; Clear: Boolean);
    procedure eHTMLAttributesValueChange(Sender: TObject; Clear: Boolean);
    procedure eFormTargetValueChange(Sender: TObject; Clear: Boolean);
    procedure dhComboBox1ValueChange(Sender: TObject; Clear: Boolean);
    procedure cbTextIndentValueChange(Sender: TObject; Clear: Boolean);
    procedure cbVerticalAlignValueChange(Sender: TObject; Clear: Boolean);
    procedure cbZIndexValueChange(Sender: TObject; Clear: Boolean);
    procedure eLinkValueChange(Sender: TObject; Clear: Boolean);
    procedure eTargetValueChange(Sender: TObject; Clear: Boolean);
    procedure ComboBox1ValueChange(Sender: TObject; Clear: Boolean);
    procedure dhComboBox4ValueChange(Sender: TObject; Clear: Boolean);
    procedure cbCursorValueChange(Sender: TObject; Clear: Boolean);
    procedure cbDirectionValueChange(Sender: TObject; Clear: Boolean);
    procedure cbTextAlignValueChange(Sender: TObject; Clear: Boolean);
    procedure cbTextTransformValueChange(Sender: TObject; Clear: Boolean);
    procedure cbWhiteSpaceValueChange(Sender: TObject; Clear: Boolean);
    procedure cbFontVariantValueChange(Sender: TObject; Clear: Boolean);
    procedure cbUseValueChange(Sender: TObject; Clear: Boolean);
    procedure dhComboBox2ValueChange(Sender: TObject; Clear: Boolean);
    procedure dhComboBox3ValueChange(Sender: TObject; Clear: Boolean);
    procedure cbMethodValueChange(Sender: TObject; Clear: Boolean);
    procedure spReactionTimeValueChange(Sender: TObject; Clear: Boolean);
    procedure cbLinkPageValueChange(Sender: TObject; Clear: Boolean);
    procedure cBGFixedValueChange(Sender: TObject; Clear: Boolean);
    procedure cLinkLayoutClick(Sender: TObject);
    procedure cFormButtonLayoutClick(Sender: TObject);
    procedure cHorizontalLayoutClick(Sender: TObject);
    procedure cbParentMenuItemValueChange(Sender: TObject; Clear: Boolean);
    procedure ExchangeDownandOverStyles1Click(Sender: TObject);
    procedure mLeftEdgesClick(Sender: TObject);
    procedure mEqualHorizontalClick(Sender: TObject);
    procedure LoadfromHTTPaddress1Click(Sender: TObject);
    procedure bMoreMiscClick(Sender: TObject);
    procedure fasdfClick(Sender: TObject);
    procedure AnchorSelectShow(Sender: TObject);
    procedure PushstylestoUseelement1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure bDeleteItemClick(Sender: TObject);
    procedure Clearallstyles1Click(Sender: TObject);
    procedure PullstylesfromUseelement1Click(Sender: TObject);
    procedure bMoveItemUpClick(Sender: TObject);
    procedure eSelectLabelValueChange(Sender: TObject; Clear: Boolean);
    procedure eSelectValueValueChange(Sender: TObject; Clear: Boolean);
    procedure cSelectSelectedClick(Sender: TObject);
    procedure dhSelect1Click(Sender: TObject);
    procedure cMultipleClick(Sender: TObject);
    procedure cMenuClick(Sender: TObject);
    procedure bMoveItemDownClick(Sender: TObject);
    procedure dhSelect1GetDisplayText(Sender: TObject; Item: TSelectOption;
      var DisplayText: String);
    procedure eCheckValueValueChange(Sender: TObject; Clear: Boolean);
    procedure cFontFamilyValueChange(Sender: TObject; Clear: Boolean);
    procedure cFontSizeValueChange(Sender: TObject; Clear: Boolean);
  private
    FAdjusting:boolean;
    procedure SetAdjusting(Value:boolean);
//    gpc:TdhPageControl;
    procedure ActFontChanged;
    procedure BorderChanged;
    procedure LiveBorderChanged;
    procedure BackgroundChanged;
    procedure LiveBackgroundChanged;
    procedure BuildBGPos(Clear:boolean);
    procedure UpdateNameDisplay;
    procedure LinkChanged;
    procedure UpdateComboBoxDisplay(OnlyItems:boolean);
    procedure UpdateListBoxDisplay(OnlyItems:boolean);
    procedure BuildTransformations;
    procedure LiveBuildTransformations;
    procedure UpdateEffectsDisplay;
    function getblur(tt:TTransformations; i:integer=-1): TBlurEffect;
    function ActCommon: TCommon;
    function ActPn: TdhCustomPanel;
    procedure StylesChanged;
    procedure UpdateFontDisplay;
    procedure UpdateBorderDisplay;
    procedure UpdateBackgroundDisplay;

    procedure EnableChildren(Child: TComponent);
    procedure DisableChildren(Child: TComponent);
    procedure SetChildrenEnabled(p:TWinControl; Enabled:boolean);

    procedure UpdatePositionDisplay;
    procedure UpdateStylesDisplay;
    function GetComponent(Index: Integer): TPersistent;
    function ChooseTwice(i: integer; c: TClass): TControl;
    procedure UpdateMoreDisplay;
    procedure UpdateLinkDisplay;
    procedure UpdateMenuDisplay;
    procedure MenuChanged;
    procedure UpdateEditDisplay;
    procedure UpdateMemoDisplay;
    procedure UpdateCheckboxDisplay;
    procedure UpdateTextDisplay;
    procedure UpdatePageDisplay;
    function IsFontCleared: boolean;
    function IsEdgeCleared(EdgeAlign:TEdgeAlign): boolean;
    function IsBorderRadiusCleared:boolean;
    function IsAllEdgeCleared: boolean;
    function IsImageCleared: boolean;
    function IsMoreCleared: boolean;
    function IsEffectsCleared: boolean;
    procedure InstallDefaultFont;
    procedure UpdateFormButtonDisplay;
    procedure UpdateFormDisplay;
    procedure UpdateHiddenFieldDisplay;
    procedure UpdateEffectsDisplay2;
    procedure UpdateOLEDisplay;
    procedure PageControl1DrawTabCLX(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean;
      var DefaultDraw: Boolean);
    procedure TabControl2DrawTabCLX(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean;
      var DefaultDraw: Boolean);
    procedure cbUseDrawItemCLX(Sender: TObject; Index: Integer;
      Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
    procedure cbLinkPageDrawItemCLX(Sender: TObject; Index: Integer;
      Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
    procedure cbCursorDrawItemCLX(Sender: TObject; Index: Integer;
      Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
    function GetSelectionBounds: TRect;
    procedure UpdateSelectDisplay;
    procedure UpdateAllSelects;
    function IsAllMoreCleared: boolean;

  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure LivePositionChanged(Sender:TObject);
    procedure ClearAllStyles(ClearUse:boolean);
  public
    { Public declarations }
    Selection:TList;
    EdgeAlign:TEdgeAlign;
    function IsMoreExtCleared: boolean;
    function SetClearState(b: TButton; IsCleared: boolean):boolean;
    property Adjusting:boolean read FAdjusting write SetAdjusting;
    procedure LogChange(Sender:TObject; LogChange:TLogChange);
    function ActStyle:TStyle;
    procedure PullStyles(Use:ICon; Clear:boolean);
    procedure Loaded; override;
    procedure LoadImage(URL: String); overload;
    procedure LoadImageExt(URL: String; pn:TdhCustomPanel); overload;
    procedure Changed(const Reason: string; LogChange:TLogChange=lcCommit);
    procedure ActBoundsChanged;
    procedure WriteTransformations(tt: TTransformations);
    procedure UpdateSel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateAlign;
    function CommitChanges:boolean;
    procedure AbortChanges;
    procedure EditPageProperties(page:TdhPage);


  end;
                        {
var
  PropsPC: TPropsPC;
                         }


function Adj255to100(i:integer):integer;
function Adj100to255(i:integer):DWORD;

function GetComp(c:TControl):TComponent;
function AbsIncr(c:TControl):TPoint;

function WithoutPx(const s:string):string;

type TSecFilter=function (match,ori:TControl):boolean;
procedure GetRefs(cb:TComboBox; cl:TClass; c,find:TControl; SecFilter:TSecFilter; ClearValue:boolean);

function GoodIndex(i:integer):integer;
function GoodIndexBack(i:integer):integer;
procedure SetUnderlineState(b:TButton; IsCleared:boolean);

implementation

uses {Unit1,}MySiz, Unit1, {uTransparencyWizard,} uStyleInfo, uPageWizard,
  uColorizeImg, uTransparencyWizard, uBorderRadiusWizard,uMoreMisc;

{$R *.dfm}

const PAGE_STYLES=6;
//const PAGE_STYLES=14;

var Changing:TObject;

type TFakeWinControl=class(TWinControl);
type TFakeControl=class(TControl);

const ClearColor:array[boolean] of TColor=(clBlack,clGray{clBlack});



procedure GetAllNames(sl:TStringList; p:TWinControl; ori:TControl; c:Tclass; SecFilter:TSecFilter);
var i:integer;
begin
 if p<>nil then
 for i:=0 to p.ControlCount-1 do
 if EditableControl(p.Controls[i]) then
 begin
  if p.Controls[i].InheritsFrom(c) and not (Assigned(SecFilter) and not SecFilter(p.Controls[i],ori)) then
   sl.Add(p.Controls[i].Name);
  if p.Controls[i] is TWinControl then
   GetAllNames(sl,TWinControl(p.Controls[i]),ori,c,SecFilter);
 end;
end;

procedure GetRefs(cb:TComboBox; cl:TClass; c,find:TControl; SecFilter:TSecFilter; ClearValue:boolean);
var sl:TStringList;
begin
 cb.Items.Clear;
 if (c=nil) or (GetParentForm(c)=nil) then exit;
 sl:=TStringList.Create;
 GetAllNames(sl,GetParentForm(c),c,cl,SecFilter);
 if (c<>find) and (sl.IndexOf(c.Name)<>-1) then
  sl.Delete(sl.IndexOf(c.Name));
 sl.Sort;
 cb.Items.Assign(sl);
 if cb is ThComboBox then
 begin  
 if find<>nil then
  ThComboBox(cb).StoredItemIndex:=cb.Items.IndexOf(find.Name) else
  //ThComboBox(cb).StoredText:=find.Name else
  ThComboBox(cb).StoredText:='';
 end else
 if find<>nil then
  cb.ItemIndex:=cb.Items.IndexOf(find.Name) else
  cb.Text:='';
 sl.Free;

 if ClearValue then
 begin
 cb.Items.Insert(0,sClearValue);
 if cb.ItemIndex=-1 then
  cb.ItemIndex:=cb.ItemIndex+1;
 end;
end;

function GoodIndex(i:integer):integer;
begin
 if i=0 then
  result:=-1 else
  result:=i;
end;

function GoodIndexBack(i:integer):integer;
begin
 if i=-1 then
  result:=0 else
  result:=i;
end;

function TPropsPC.ActStyle:TStyle;
begin
 result:=ActCommon.ActStyle;
end;

function TPropsPC.ActCommon:TCommon;
begin
 result:=(TObject(Selection[0]) as TdhCustomPanel).FCommon;
end;


function TPropsPC.ActPn: TdhCustomPanel;
begin             
 result:=(TObject(Selection[0]) as TdhCustomPanel);
end;

procedure TPropsPC.Button1Click(Sender: TObject);
begin
 FontDialog1.Font.Assign(SampleFont.Font);
// if FontDialog1.Font.Size>0 then FontDialog1.Font.Size:=-FontDialog1.Font.Size;
 FontDialog1.Font.Color:=clBlack;
 if FontDialog1.Execute then
 begin
  SampleFont.Font.Size:=Abs(FontDialog1.Font.Size);
  SampleFont.Font.Name:=FontDialog1.Font.Name;
  SampleFont.Font.Style:=SampleFont.Font.Style*[fsUnderline,fsStrikeOut]+FontDialog1.Font.Style;
  ActFontChanged;
 end;
end;

function Adj255to100(i:integer):integer;
begin
 result:=round(i*100/255);
end;


function Adj100to255(i:integer):DWORD;
begin
 result:=round(i*255/100);
end;

function NormalizeDegree(Degree:integer):integer;
begin
 result:=(Degree mod 360 + 360) mod 360;
end;



procedure TPropsPC.ActFontChanged;
var i:integer;
begin
 if Adjusting then exit;
 dhMainForm.Act.MySiz.DoInval(true);
 try
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TControl then
 begin
  TFakeControl(Selection[i]).Font.Assign(SampleFont.Font);
  if TObject(Selection[i]) is TdhCustomPanel then
  begin
   TdhCustomPanel(TObject(Selection[i])).FCommon.Overline:=SampleFont.FCommon.Overline;
  end;
 end;

 if TObject(Selection[0]) is TdhCustomPanel then
 if not ActCommon.SetTextDecoration(cUnderline.Checked,cLineThrough.Checked,cOverline.Checked,ActCommon.Blink) then
 begin
  Showmessage('This flag is inherited from the parent element and cannot be deleted');
  UpdateFontDisplay;
 end;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdateFontDisplay;
 Changed('Change Font');
end;


procedure TPropsPC.BorderChanged;
begin
 LiveBorderChanged;
 Changed('Border');
end;

procedure TPropsPC.LiveBorderChanged;
var i:integer;
begin
 for i:=1 to Selection.Count-1 do
 begin
  TdhCustomPanel(Selection[i]).ActStyle.AssignEdge(EdgeAlign,ActStyle);
  TdhCustomPanel(Selection[i]).ActStyle.BorderRadius.Assign(ActStyle.BorderRadius);
 end;
 UpdateBorderDisplay;
end;
                 

type TFakeComponent=class(TComponent);

procedure TPropsPC.EnableChildren(Child: TComponent);
begin
 if Child is TControl then TControl(Child).Enabled:=true;
 TFakeComponent(Child).GetChildren(EnableChildren,Child.Owner);
end;

procedure TPropsPC.DisableChildren(Child: TComponent);
begin
 if Child is TControl then TControl(Child).Enabled:=false;
 TFakeComponent(Child).GetChildren(DisableChildren,Child.Owner);
end;

procedure TPropsPC.SetChildrenEnabled(p:TWinControl; Enabled:boolean);
var i:integer;
begin
 if p.Enabled=Enabled then exit;
 if Enabled then
  EnableChildren(p) else
  DisableChildren(p);
{$IFDEF CLX}
 p.Invalidate; //caption of TGroupBox is still in disabled look
{$ENDIF}
end;


procedure TPropsPC.UpdateBackgroundDisplay;
var res:TPoint;
    i:integer;                        
    FPicture:TPicture;
begin
 if not Showing then exit;
 Adjusting:=true;
 if ActCommon.HasBackgroundImage(FPicture) then
  dhPanel1.Style.BackgroundImage.Assign(FPicture) else
  dhPanel1.Style.BackgroundImage.Assign(nil);
 res:=Point(0,0);
 if ActCommon.GetVal(pcBackgroundPosition) then
  GetBackgroundPixels(Cascaded.BackgroundPosition,Rect(0,0,100,100),0,0,res) else
  Cascaded.BackgroundPosition:='0% 0%';
 i:=pos('%',Cascaded.BackgroundPosition);
 spBGX.SetDetailedStoredValue(ActStyle.BackgroundPosition='',res.X);
 spBGY.SetDetailedStoredValue(ActStyle.BackgroundPosition='',res.Y);
 dhComboBoxX.SetDetailedStoredItemIndex(ActStyle.BackgroundPosition='',_if(pos('px',copy(Cascaded.BackgroundPosition,1,i))<>0,0,1));
 dhComboBoxY.SetDetailedStoredItemIndex(ActStyle.BackgroundPosition='',_if(pos('px',copy(Cascaded.BackgroundPosition,i,maxint))<>0,0,1));
 dhComboBox4.SetDetailedStoredItemIndex(ActStyle.BackgroundRepeat=Low(TCSSBackgroundRepeat),max(0,Integer(ActCommon.BackgroundRepeat)-1));
 cBGFixed.SetDetailedStoredValue(ActStyle.BackgroundAttachment=Low(TCSSBackgroundAttachment),ActCommon.BackgroundAttachment=cbaFixed);
 ComboBox1.SetDetailedStoredItemIndex((TObject(Selection[0]) as TdhCustomPanel).ImageType=Low(TImageType),max(0,Integer((TObject(Selection[0]) as TdhCustomPanel).GetImageType)-1));
 SetChildrenEnabled(GroupBox8,ComboBox1.ItemIndex=0);
 SetClearState(bClearImage,IsImageCleared);
 Adjusting:=false;
end;

function TPropsPC.SetClearState(b:TButton; IsCleared:boolean):boolean;
begin
 if b.Enabled<>not IsCleared then
 begin
  b.Enabled:=not IsCleared;
  PageControl1.Invalidate;
  result:=true;
 end else
  result:=false;
end;

procedure SetUnderlineState(b:TButton; IsCleared:boolean);
begin         
 if IsCleared then
  b.Font.Style:=[] else
  b.Font.Style:=[fsUnderline];
end;


procedure TPropsPC.ActBoundsChanged;
begin
 if AnchorPosition.TabVisible then
  UpdatePositionDisplay;
end;

function AbsIncr(c:TControl):TPoint;
begin
 if c.Parent is TdhCustomPanel then
  result:=Point(TdhCustomPanel(c.Parent).HorzPosition,TdhCustomPanel(c.Parent).VertPosition) else
  result:=Point(0,0);
end;


procedure TPropsPC.UpdatePositionDisplay;
var pn:TControl;
    Common:TCommon;
begin
 if not Showing then exit;
 Adjusting:=true;

 pn:=TObject(Selection[0]) as TControl;
 SamplePosition.Anchors:=pn.Anchors;
 SamplePosition.Center:=(pn is TdhCustomPanel) and TdhCustomPanel(pn).Center;
 SamplePosition.Align:=pn.Align;

 cCenter.Checked:=SamplePosition.Center;
 cNone.Checked:=not cCenter.Checked and (SamplePosition.Align=alNone);
 cLeft.Checked:=SamplePosition.Align=alLeft;
 cTop.Checked:=SamplePosition.Align=alTop;
 cBottom.Checked:=SamplePosition.Align=alBottom;
 cRight.Checked:=SamplePosition.Align=alRight;
 cClient.Checked:=SamplePosition.Align=alClient;

 caLeft.Checked:=akLeft in SamplePosition.Anchors;
 caTop.Checked:=akTop in SamplePosition.Anchors;
 caRight.Checked:=akRight in SamplePosition.Anchors;
 caBottom.Checked:=akBottom in SamplePosition.Anchors;


 spLeft.Enabled:=cNone.Checked;
 spTop.Enabled:=cNone.Checked or cCenter.Checked;
 spWidth.Enabled:=not cClient.Checked and not cTop.Checked and not cBottom.Checked;
 spHeight.Enabled:=not cClient.Checked and not cLeft.Checked and not cRight.Checked;
 caLeft.Enabled:=cNone.Checked;
 caTop.Enabled:=cNone.Checked;
 caBottom.Enabled:=cNone.Checked;
 caRight.Enabled:=cNone.Checked;


 spLeft.StoredValue:=pn.Left+AbsIncr(pn).X;
 spTop.StoredValue:=pn.Top+AbsIncr(pn).Y;
 spWidth.StoredValue:=pn.Width;
 spHeight.StoredValue:=pn.Height;

 cAutoX.Checked:=HasCommon(pn,Common) and (Common.ASXY in [asX,asXY]){ and not (pn is TRadioButton)}{ and not (pn is TdhCheckBox)};
 cAutoY.Checked:=HasCommon(pn,Common) and (Common.ASXY in [asY,asXY]){ or (pn is TEdit) and TEdit(pn).AutoSize}{ or (pn is TdhComboBox)};

 cAutoX.Enabled:=(pn is TdhOleContainer) or (pn is TdhCustomLabel) or (pn is TdhMenu);
 cAutoY.Enabled:=(pn is TdhOleContainer) or (pn is TdhCustomLabel) or (pn is TdhMenu){ or (pn is TdhEdit) and not (pn is TdhMemo)};

 Adjusting:=false;
end;

var OldEdgeIsCleared:boolean;
const guiEdgesAlign:array[0..4] of TEdgeAlign = (ealNone,ealTop,ealRight,ealBottom,ealLeft);
const guiEdgesS:array[0..4] of string = ('Clear','Clear top','Clear right','Clear bottom','Clear left');

procedure TPropsPC.UpdateBorderDisplay;
var IsInvalidated:boolean;
begin
 if not Showing then exit;
 Adjusting:=true;
 spMargin.SetDetailedStoredValue(ActStyle.IsMarginCleared(EdgeAlign),ActCommon.MarginWidth(EdgeAlign));
 spBorder.SetDetailedStoredValue(ActStyle.GetBorder(EdgeAlign).IsWidthCleared,ActCommon.BorderWidth(EdgeAlign));
 spPadding.SetDetailedStoredValue(ActStyle.IsPaddingCleared(EdgeAlign),ActCommon.PaddingWidth(EdgeAlign));
 dhComboBox1.SetDetailedStoredItemIndex(ActStyle.GetBorder(EdgeAlign).Style=Low(TCSSBorderStyle),max(0,Integer(ActCommon.BorderStyle(EdgeAlign))-1));
 cpBorderColor.Color:=ActCommon.BorderColor(EdgeAlign);
 SampleBorder.Style.AssignComputedEdge(ealRight,ActCommon);
 SampleBorder.Style.AssignComputedEdge(ealTop,ActCommon);
 SampleBorder.Style.AssignComputedEdge(ealBottom,ActCommon);
 SampleBorder.Style.AssignComputedEdge(ealLeft,ActCommon);

{ cBorAll.Font.Color:=ClearColor[IsEdgeCleared(ealNone)];
 cBorLeft.Font.Color:=ClearColor[IsEdgeCleared(ealLeft)];
 cBorRight.Font.Color:=ClearColor[IsEdgeCleared(ealRight)];
 cBorBottom.Font.Color:=ClearColor[IsEdgeCleared(ealBottom)];
 cBorTop.Font.Color:=ClearColor[IsEdgeCleared(ealTop)];}
 IsInvalidated:=SetClearState(bClearEdge,IsEdgeCleared(EdgeAlign));
 if OldEdgeIsCleared<>IsEdgeCleared(guiEdgesAlign[TabControl2.TabIndex]) then
 begin
  OldEdgeIsCleared:=not OldEdgeIsCleared;
  //if not IsInvalidated then
  TabControl2.Invalidate;
 end;
 SetUnderlineState(bBorderRadius,ActStyle.BorderRadius.IsCleared);
 Adjusting:=false;
end;

function TPropsPC.IsEdgeCleared(EdgeAlign:TEdgeAlign):boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
  result:=TdhCustomPanel(Selection[i]).ActStyle.IsEdgeCleared(EdgeAlign);
end;

function TPropsPC.IsBorderRadiusCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
  result:=TdhCustomPanel(Selection[i]).ActStyle.BorderRadius.IsCleared;
end;

function TPropsPC.IsAllEdgeCleared:boolean;
begin
 result:=IsEdgeCleared(ealNone) and IsEdgeCleared(ealTop) and IsEdgeCleared(ealBottom) and IsEdgeCleared(ealLeft) and IsEdgeCleared(ealRight) and IsBorderRadiusCleared;
end;

{$IFDEF CLX}

function Screen_Fonts: TStrings;
var
  FFonts:TStrings;
begin
    FFonts := TStringList.Create;
    FFonts.Assign(Screen.Fonts);
  Result := FFonts;
end;


{$ELSE}

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
var
  S: TStrings;
  Temp: string;
begin
  S := TStrings(Data);
  Temp := LogFont.lfFaceName;
  if (S.Count = 0) or (AnsiCompareText(S[S.Count-1], Temp) <> 0) then
  if (TextMetric.tmPitchAndFamily and TMPF_TRUETYPE) <> 0 then //added condition
    S.Add(Temp);
  Result := 1;
end;

//we give back the same fonts as Cool Page.
//help file of Cool Page: "The choice of typeface is limited to what Internet browsers support." ok..
function Screen_Fonts: TStrings;
var
  DC: HDC;
  LFont: TLogFont;
  FFonts:TStrings;
begin
  FFonts:=nil;
  if FFonts = nil then
  begin
    FFonts := TStringList.Create;
    DC := GetDC(0);
    try
      //FFonts.Add('Default');
      FillChar(LFont, sizeof(LFont), 0);
      LFont.lfCharset := ANSI_CHARSET;//DEFAULT_CHARSET;
      EnumFontFamiliesEx(DC, LFont, @EnumFontsProc, LongInt(FFonts), 0);
      TStringList(FFonts).Sorted := TRUE;
    finally
      ReleaseDC(0, DC);
    end;
  end;
  Result := FFonts;
end;

{$ENDIF}

procedure TPropsPC.UpdateFontDisplay;
var Font:TFont;
    ScreenFonts:TStrings;
begin
 if not Showing then exit;
 if Adjusting then exit;
 Adjusting:=true;
 if cFontFamily.Items.Count=0 then
 begin
  {
  They are not in dreamweaver explicit, so we dont add them, too
  cFontFamily.Items.Add('serif');
  cFontFamily.Items.Add('sans-serif');
  cFontFamily.Items.Add('cursive');
  cFontFamily.Items.Add('fantasy');
  cFontFamily.Items.Add('monospace'); }
  ScreenFonts:=Screen_Fonts;
  try
   cFontFamily.Items.AddStrings(ScreenFonts);
  finally
   ScreenFonts.Free;
  end;
 end;


 if (TObject(Selection[0]) is TdhCustomPanel) then
  cFontFamily.SetDetailedStoredValue(ActStyle.FontFamily='',ActCommon.FontFamily) else
  cFontFamily.StoredText:=TFakeControl(Selection[0]).Font.Name;

 if (TObject(Selection[0]) is TdhCustomPanel) then
  cFontSize.SetDetailedStoredValue(ActStyle.FontSize='',ActCommon.FontSize) else
  cFontSize.StoredText:=IntToStr(Abs(TFakeControl(Selection[0]).Font.Height));

 Font:=TFont.Create;
 try
 if (TObject(Selection[0]) is TdhCustomPanel) then
  ActPn.FCommon.CSSToFont(Font) else
  Font.Assign(TFakeControl(Selection[0]).Font);
 cOverline.Checked:=(TObject(Selection[0]) is TdhCustomPanel) and ActCommon.Overline;
 if (TObject(Selection[0]) is TdhCustomPanel) then
  cpBackgroundColor.Color:=ActPn.FCommon.BackgroundColor else
 if not TFakeControl(Selection[0]).ParentColor then
  cpBackgroundColor.Color:=TFakeControl(Selection[0]).Color else
  cpBackgroundColor.TransparentColor:=true;
 cTransparent.Checked:=cpBackgroundColor.TransparentColor;
 FontStatus.Text:=Font.Name+#13#10+inttostr(-Font.Height)+'px';
 cBold.Checked:=fsBold in Font.Style;
 cItalic.Checked:=fsItalic in Font.Style;
 cUnderline.Checked:=fsUnderline in Font.Style;
 cLineThrough.Checked:=fsStrikeOut in Font.Style;
 cpFontColor.Color:=Font.Color;
 SetClearState(bClearFont,IsFontCleared);

 with Font do SampleFont.FCommon.ActStyle.GetFontDifferences(Style,Color,Name,Height);
 SampleFont.ActStyle.BackgroundColor:=cpBackgroundColor.Color;
 SampleFont.FCommon.Overline:=cOverline.Checked;
 finally
  Font.Free;
 end;
 Adjusting:=false;
end;

(*

procedure TPropsPC.UpdateFontDisplay;
begin
 if not Showing then exit;
 if Adjusting then exit;
 Adjusting:=true;
 SampleFont.Font.Assign((TFakeControl(Selection[0])).Font);
 SampleFont.Color:=TFakeControl(Selection[0]).Color;
 SampleFont.FCommon.Overline:=(TObject(Selection[0]) is TdhCustomPanel) and ActCommon.Overline;
 if (TObject(Selection[0]) is TdhCustomPanel) then
  SampleFont.Transparent:=TdhCustomPanel(Selection[0]).Transparent else
  SampleFont.Transparent:=TFakeControl(Selection[0]).ParentColor;
 cTransparent.Checked:=SampleFont.Transparent;
 FontStatus.Text:=SampleFont.Font.Name+#13#10+inttostr(-SampleFont.Font.Height)+'px';
 cBold.Checked:=fsBold in SampleFont.Font.Style;
 cItalic.Checked:=fsItalic in SampleFont.Font.Style;
 cUnderline.Checked:=fsUnderline in SampleFont.Font.Style;
 cLineThrough.Checked:=fsStrikeOut in SampleFont.Font.Style;
 cOverline.Checked:=SampleFont.FCommon.Overline;
 cpFontColor.Color:=SampleFont.Font.Color;
 cpBackgroundColor.Color:=SampleFont.FCommon.BackgroundColor;
 SetClearState(bClearFont,IsFontCleared);
 Adjusting:=false;
end;

*)



constructor TPropsPC.Create(AOwner: TComponent);
begin
  inherited;
  Adjusting:=true;
  EdgeAlign:=ealNone;
  Selection:=TList.Create;
  PageControl1.MultiLine:=true;
{$IFNDEF CLX}
 PageControl1.OnDrawTab:=PageControl1DrawTab;
 TabControl1.OnDrawTab:=TabControl2DrawTab;
 TabControl2.OnDrawTab:=TabControl2DrawTab;
 //cbUse.OnDrawItem:=cbUseDrawItem;
 //cbLinkPage.OnDrawItem:=cbLinkPageDrawItem;
 //cbLinkAnchor.OnDrawItem:=cbLinkPageDrawItem;

 cbCursor.OnDrawItem:=cbCursorDrawItem;
 cbCursor.OnMeasureItem:=cbCursorMeasureItem;
 cbCursor.Style:=csOwnerDrawVariable;

 PageControl1.OwnerDraw:=true;
 TabControl2.OwnerDraw:=true;
 TabControl1.OwnerDraw:=true;
 PageControl1.DoubleBuffered:=true;
 TabSheet7.DoubleBuffered:=true;
 bBorderRadius.WordWrap:=true;
 bMoreMisc.WordWrap:=true;
{$ELSE}
 PageControl1.OnDrawTab:=PageControl1DrawTabCLX;
 TabControl1.OnDrawTab:=TabControl2DrawTabCLX;
 TabControl2.OnDrawTab:=TabControl2DrawTabCLX;

 //cbUse.OnDrawItem:=cbUseDrawItemCLX;
 //cbLinkPage.OnDrawItem:=cbLinkPageDrawItemCLX;
 //cbLinkAnchor.OnDrawItem:=cbLinkPageDrawItemCLX;

 // cbCursor.OnDrawItem:=cbCursorDrawItemCLX;
// cbCursor.OnMeasureItem:=cbCursorMeasureItem;
{$ENDIF}

 TabControl2.Tabs.Add('All');
 TabControl2.Tabs.Add('Top');
 TabControl2.Tabs.Add('Right');
 TabControl2.Tabs.Add('Bottom');
 TabControl2.Tabs.Add('Left');

 TabControl1.Tabs.Add('Outer shadow');
 TabControl1.Tabs.Add('Inner shadow');
 TabControl1.Tabs.Add('Outer glow');
 TabControl1.Tabs.Add('Inner glow');
 TabControl1.Tabs.Add('Blur');

end;

procedure TPropsPC.bClearEdgeClick(Sender: TObject);
begin
 ActStyle.ClearEdge(EdgeAlign);
 BorderChanged;
end;

procedure TPropsPC.ClearFontClick(Sender: TObject);
var i:integer;
begin                  
 dhMainForm.Act.MySiz.DoInval(true);
 try
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 with TdhCustomPanel(Selection[i]).ActStyle do
 begin
  FontSize:='';
  FontFamily:='';
  FontStyle:=cfsInherit;
  FontWeight:=cfwInherit;
  TextDecoration:=[];
  Color:=colInherit;
  BackgroundColor:=colInherit;
 end else
 if TObject(Selection[i]) is TControl then
 begin
  TFakeControl(Selection[i]).ParentFont:=true;
  TFakeControl(Selection[i]).ParentColor:=true;
 end;       
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
// InstallDefaultFont;
 UpdateFontDisplay;    
 Changed('Reset Font');
end;

procedure TPropsPC.InstallDefaultFont;
var p:TdhPage;
begin
{ p:=(TControl(Selection[0]).Owner as TPageContainer).MySiz.FindBody;
 if p<>nil then
 begin
  if (p.ActStyle.FontFamily='') then
   p.Font.Name:=FuncSettings.DefaultFont.Name;
  if (p.ActStyle.FontSize='') then
   p.Font.Size:=FuncSettings.DefaultFont.Size;
 end;
 }
end;



function TPropsPC.IsFontCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if result then
 if TObject(Selection[i]) is TdhCustomPanel then
 with TdhCustomPanel(Selection[i]).ActStyle do
 begin
  result:=(FontSize='') and (FontFamily='') and (FontStyle=cfsInherit) and
          (FontWeight=cfwInherit) and (TextDecoration=[]) and (Color=colInherit) and
          (BackgroundColor=colInherit);
 end else
 {if TObject(Selection[i]) is TdhListBox then
  result:=TdhListBox(TObject(Selection[i])).IsCleared else}
 {if TObject(Selection[i]) is TdhComboBox then
  result:=TdhComboBox(TObject(Selection[i])).IsCleared else}
 if TObject(Selection[i]) is TControl then
  result:=TFakeControl(Selection[i]).ParentFont and TFakeControl(Selection[i]).ParentColor;
end;


procedure TPropsPC.dhAnchor3Click(Sender: TObject);
begin
 if OpenPictureDialog1.Execute then
 begin
  ActStyle.LoadImage(OpenPictureDialog1.FileName);
  BackgroundChanged;
  //dhMainForm.ImageFromURL(OpenPictureDialog1.FileName,nil);
 end;
end;

procedure TPropsPC.LoadImage(URL:String);
begin          
  CommitChanges;
  ActStyle.LoadImage(URL);
  BackgroundChanged;
end;

procedure TPropsPC.BackgroundChanged;
begin
 LiveBackgroundChanged;
 Changed('Image');
end;

procedure TPropsPC.LiveBackgroundChanged;
var i:integer;
begin
 for i:=1 to Selection.Count-1 do
 begin
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.AssignBackground(ActStyle);
  (TObject(Selection[i]) as TdhCustomPanel).ImageType:=(TObject(Selection[0]) as TdhCustomPanel).ImageType;
 end;
 UpdateBackgroundDisplay;
end;


function TPropsPC.IsImageCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
  result:=(TObject(Selection[i]) as TdhCustomPanel).ActStyle.IsBGImageCleared and
          ((TObject(Selection[i]) as TdhCustomPanel).ImageType=bitInherit);
end;

procedure TPropsPC.bClearBackgroundClick(Sender: TObject);
begin
 ActStyle.BackgroundImage.Assign(nil);
 ActStyle.BackgroundPosition:='';
 ActStyle.BackgroundRepeat:=cbrInherit;
 ActStyle.BackgroundAttachment:=cbaInherit;
 (TObject(Selection[0]) as TdhCustomPanel).ImageType:=bitInherit;
 BackgroundChanged;
end;

procedure TPropsPC.BuildBGPos(Clear:boolean);
begin
 if Clear then
  ActStyle.BackgroundPosition:='' else
  ActStyle.BackgroundPosition:=inttostr(spBGX.Value)+dhComboBoxX.Text+' '+inttostr(spBGY.Value)+dhComboBoxY.Text;
 LiveBackgroundChanged;
end;


procedure TPropsPC.cBoldClick(Sender: TObject);
var FontStyles:TFontStyles;
    i:integer;
begin
 if Adjusting then exit;

 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
  if TObject(Selection[i]) is TdhCustomPanel then
  begin
   TdhCustomPanel(TObject(Selection[i])).FCommon.Bold:=cBold.Checked;
   TdhCustomPanel(TObject(Selection[i])).FCommon.Italic:=cItalic.Checked;
   TdhCustomPanel(TObject(Selection[i])).FCommon.Underline:=cUnderline.Checked;
   TdhCustomPanel(TObject(Selection[i])).FCommon.LineThrough:=cLineThrough.Checked;
   TdhCustomPanel(TObject(Selection[i])).FCommon.Overline:=cOverline.Checked;
  end else
  begin
   FontStyles:=[];
   if cBold.Checked then
    Include(FontStyles,fsBold);
   if cItalic.Checked then
    Include(FontStyles,fsItalic);
   if cUnderline.Checked then
    Include(FontStyles,fsUnderline);
   if cLineThrough.Checked then
    Include(FontStyles,fsStrikeOut);
   TFakeControl(Selection[i]).Font.Style:=FontStyles;
  end;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;

 //if i1<>i2{not ActCommon.SetTextDecoration(cUnderline.Checked,cLineThrough.Checked,cOverline.Checked,ActCommon.Blink)} then
 if (TObject(Selection[0]) is TdhCustomPanel) then
 if (ActCommon.Bold<>cBold.Checked) or (ActCommon.Italic<>cItalic.Checked) or (ActCommon.Underline<>cUnderline.Checked) or (ActCommon.LineThrough<>cLineThrough.Checked) or(ActCommon.Overline<>cOverline.Checked) then
  Showmessage('This flag is inherited from the parent object and cannot be deleted');

 UpdateFontDisplay;
 Changed('Change Font Styles');
end;

procedure TPropsPC.cNoneClick(Sender: TObject);
var SampleAnchors:TAnchors;
begin
 if Adjusting then exit;
 Adjusting:=True;

 if not cNone.Checked then
 begin
  caLeft.Checked:=cLeft.Checked or cTop.Checked or cBottom.Checked or cClient.Checked;
  caRight.Checked:=cRight.Checked or cTop.Checked or cBottom.Checked or cClient.Checked;
  caTop.Checked:=cTop.Checked or cLeft.Checked or cRight.Checked or cClient.Checked or cCenter.Checked;
  caBottom.Checked:=cBottom.Checked or cLeft.Checked or cRight.Checked or cClient.Checked;
 end;

 SampleAnchors:=[];
 if caLeft.Checked then
  include(SampleAnchors,akLeft);
 if caTop.Checked then
  include(SampleAnchors,akTop);
 if caBottom.Checked then
  include(SampleAnchors,akBottom);
 if caRight.Checked then
  include(SampleAnchors,akRight);
 SamplePosition.Anchors:=SampleAnchors;

 SamplePosition.Center:=cCenter.Checked;
 if cNone.Checked then
  SamplePosition.Align:=alNone else
 if cLeft.Checked then
  SamplePosition.Align:=alLeft else
 if cTop.Checked then
  SamplePosition.Align:=alTop else
 if cBottom.Checked then
  SamplePosition.Align:=alBottom else
 if cRight.Checked then
  SamplePosition.Align:=alRight else
 if cClient.Checked then
  SamplePosition.Align:=alClient;

 SamplePosition.SetBounds(32,32,33,33);

 Adjusting:=false;

 LivePositionChanged(Sender);
 Changed('Alignment');

end;


procedure TPropsPC.LivePositionChanged(Sender:TObject);
var i:integer;
    rct:TRect;
    pn:TControl;
begin

 dhMainForm.Act.MySiz.DoInval(true);
 try
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TControl then
 if not ((TObject(Selection[i]) is TdhPage) and TdhPage(Selection[i]).IsBody and not TdhPage(Selection[i]).IsIFrame and (SamplePosition.Align<>alClient)) then
 begin
  pn:=TControl(Selection[i]);
  pn.Anchors:=SamplePosition.Anchors;
  if pn is TdhCustomPanel then
   TdhCustomPanel(pn).Center:=SamplePosition.Center;
  pn.Align:=SamplePosition.Align;
  {
  rct:=Rect(pn.Left,pn.Top,pn.Width,pn.Height);
  if Sender=spLeft then
  begin
   if (akRight in SamplePosition.Anchors) then
    inc(rct.Right,rct.Left-spLeft.Value);
   rct.Left:=spLeft.Value;
  end else
  if Sender=spTop then
  begin
   if (akBottom in SamplePosition.Anchors) then
    inc(rct.Bottom,rct.Top-spTop.Value);
   rct.Top:=spTop.Value;
  end else
  if Sender=spWidth then
  begin
   if not (akLeft in SamplePosition.Anchors) then
    inc(rct.Left,rct.Right-spWidth.Value);
   rct.Right:=spWidth.Value;
  end else
  if Sender=spHeight then
  begin
   if not (akTop in SamplePosition.Anchors) then
    inc(rct.Top,rct.Bottom-spHeight.Value);
   rct.Bottom:=spHeight.Value;
  end;
  pn.SetBounds(rct.Left,rct.Top,rct.Right,rct.Bottom);
         }

  if (Sender=spLeft) then
   rct:=GetBoundsFor(pn,(spLeft.Value-AbsIncr(pn).X)-pn.Left,0,0,0) else
  if Sender=spTop then
   rct:=GetBoundsFor(pn,0,(spTop.Value-AbsIncr(pn).Y)-pn.Top,0,0) else
  if Sender=spWidth then
   rct:=GetBoundsFor(pn,0,0,spWidth.Value-pn.Width,0) else
  if Sender=spHeight then
   rct:=GetBoundsFor(pn,0,0,0,spHeight.Value-pn.Height) else
   continue;
  pn.SetBounds(rct.Left,rct.Top,rct.Right-rct.Left,rct.Bottom-rct.Top);
 end;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdatePositionDisplay;
end;



function GetComp(c:TControl):TComponent;
begin
 result:=nil;

 if c is TdhFormButton then
 begin
  if TdhFormButton(c).FormButtonType=fbSubmit then
   result:=dhMainForm.Submitbutton1 else
   result:=dhMainForm.Resetbutton1;
 end else
 if c is TdhHTMLForm then
  result:=dhMainForm.Formcontainer1 else
 if c is TdhRadioButton then
  result:=dhMainForm.Radiobutton1 else
 if c is TdhCheckBox then
  result:=dhMainForm.Checkbox1 else
 if c is TdhEdit then
  result:=dhMainForm.Editfield1 else
 if c is TdhMemo then
  result:=dhMainForm.Textarea1 else

 if (c is TdhSelect) and (TdhSelect(c).SelectType=stMenu) then
  result:=dhMainForm.Combobox1 else
 if (c is TdhSelect) and (TdhSelect(c).SelectType=stList) then
  result:=dhMainForm.Listbox1 else
 if c is TdhComboBox then
  result:=dhMainForm.Combobox1 else
 if c is TdhListBox then
  result:=dhMainForm.Listbox1 else
  
 if c is TdhFileField then
  result:=dhMainForm.Filefield1 else
 if c is TdhHiddenField then
  result:=dhMainForm.Hiddenfield1 else

 if c is TdhLink then
  result:=dhMainForm.compAnchor else
 if c is TdhLabel then
  result:=dhMainForm.compText else
 if c is TdhStyleSheet then
  result:=dhMainForm.compStyleSheet else
 if c is TdhPage then
  result:=dhMainForm.compPage else
 if c is TdhMenu then
  result:=dhMainForm.compMenu else
 if c is TdhPageControl then
  result:=dhMainForm.compPageControl else
 if c is TdhStyleSheet then
  result:=dhMainForm.compStyleSheet else
 if c is TdhOleContainer then
  result:=dhMainForm.compOle else
 if c is TdhPanel then
  result:=dhMainForm.compPanel;
end;



procedure TPropsPC.UpdateNameDisplay;
var c:TControl;
    cc:TComponent;
    ImageIndex:integer;
    Image:TIcon;
begin

 SetChildrenEnabled(GroupBox21,Selection.Count=1);
 if GroupBox21.Enabled then
 begin
 c:=TObject(Selection[0]) as TControl;
 eName.StoredText:=c.Name;
 eHTMLAttributes.StoredText:='';
 if c is TdhCustomPanel then
  eHTMLAttributes.StoredText:=TdhCustomPanel(c).HTMLAttributes;
 ImageIndex:=-1;

 cc:=GetComp(c);
 if cc<>nil then
 if cc is TMenuItem then
  ImageIndex:=(cc as TMenuItem).ImageIndex else
  ImageIndex:=(cc as TToolButton).ImageIndex;

 if Image1.Picture.Bitmap=nil then
 begin
  Image1.Picture.Bitmap:=TBitmap.Create;
 end;
 Image1.Picture.Bitmap.Width:=25;
 Image1.Picture.Bitmap.Height:=25;
 Image1.Canvas.Brush.Style:=bsSolid;
 Image1.Canvas.Brush.Color:=clBtnFace;
 Image1.Canvas.FillRect(Image1.ClientRect);
 if ImageIndex<>-1 then
 begin
 (*
{$IFNDEF CLX}
 Image:=TIcon.Create;
 try
 dhMainForm.ImageList1.GetIcon(ImageIndex,Image);
 Image.Transparent:=true;
 Image1.Picture.Assign(Image);
 finally
 Image.Free;
 end;
{$ELSE}
 {dhMainForm.ImageList1.GetBitmap(ImageIndex,Image1.Picture.Bitmap);
 Image1.Picture.Bitmap.Transparent:=True;   }


 Image1.Canvas.Brush.Style:=bsSolid;
 Image1.Canvas.Brush.Color:=clBtnFace;
 Image1.Canvas.FillRect(Image1.ClientRect);
          dhMainForm.ToolBar1.Images.Draw(Image1.Canvas, 0, 0, ImageIndex, itImage,
            true);

{$ENDIF}
*)
  dhMainForm.ToolBar1.Images.Draw(Image1.Canvas, 0, 0, ImageIndex{, itImage, true});

 end;

 end;

 UpdateStylesDisplay;

end;


procedure TPropsPC.UpdateSel;

function HasCommon(ts:TTabSheet; c:Tclass; LookParent:boolean=false; menuitem:TMenuItem=nil; OnlyOne:boolean=false{; NotHide:boolean=false}{; AssertIsImage:boolean=false; IsImage:boolean=false}{; NotFrom:Tclass=nil}):boolean;
var i:integer;
begin
 result:=(Selection.Count<>0) and not (OnlyOne and (Selection.Count<>1));
 for i :=0 to Selection.Count-1  do
 if not (csDestroying in TComponent(Selection[i]).ComponentState) and not (TObject(Selection[i]).InheritsFrom(c) and
 not((ts.PageIndex<PAGE_STYLES) and ((TObject(Selection[i]) is TdhPageControl) or (TObject(Selection[i]) is TdhStyleSheet) or (TObject(Selection[i]) is TdhHiddenField))) and
 //not((ts=AnchorLink) and ((TObject(Selection[i]) as TdhLink).LinkType in [ltSubmitButton,ltResetButton])) and
 //not((ts=AnchorFormButton) and not ((TObject(Selection[i]) as TdhLink).LinkType in [ltSubmitButton,ltResetButton])) and
// not((ts=AnchorEffects) and not (TObject(Selection[i]) as TdhCustomPanel).EffectsAllowed) and
 not((ts=AnchorText) and (TObject(Selection[i]) is TdhEdit)) or LookParent and GetVirtualParent(TObject(Selection[i]) as TControl).InheritsFrom(c))
 (* or ((TObject(Selection[i]) is TdhPageControl) and not ((ts=AnchorName) or (ts=AnchorPageControl))){ or AssertIsImage and (IsImage<>(TObject(Selection[i]) as TdhCustomPanel).FCommon.IsImage)}*) then
 begin
  result:=false;
  break;
 end;
 if {not NotHide or }{Result}true then
 begin
  if Result and ts.Visible and Assigned(ts.OnShow) then
   ts.OnShow(nil) else
   begin
   if not result then
   if PageControl1.ActivePage=ts then
    PageControl1.ActivePage:=nil;
   ts.TabVisible:=result;
   end;
 end;
 if (menuitem<>nil){ and Assigned(menuitem.OnClick)} then
  menuitem.Visible:=result;
end;

function FirstCandidate:TControl;
begin       {
 for i :=0  to Selection.Count-1  do
 if TObject(Selection[i]).InheritsFrom(c) then
 begin
  result:=TFakeWinControl(Selection[i]);
  exit;
 end;
 result:=nil;   }
 result:=Selection[0];
end;




var i:integer;
    LastAct:TTabSheet;
    np:integer;
    AllowStates:boolean;
begin

// LockWindowUpdate(dhMainForm.Handle);
 try
 PageControl1.Invalidate;

  Selection.Clear;
  if dhMainForm.Act<>nil then
  begin
   if dhMainForm.Act.IsLiveModified then
    assert(not dhMainForm.Act.IsLiveModified);
   dhMainForm.Act.MySiz.AddSel(Selection);
  end;
  if Selection.Count<>0 then
   dhMainForm.cbName.ItemIndex:=dhMainForm.cbName.Items.IndexOf(TComponent(Selection[0]).Name) else
   dhMainForm.cbName.ItemIndex:=-1;
  //dhMainForm.ToolBar1.DoubleBuffered:=true;
  //np:=dhMainForm.stateNormal.Left+dhMainForm.stateNormal.Width;
  //dhMainForm.dhPureHTML1.Left:=1000;

  AllowStates:=(Selection.Count<>0);
  for i:=0 to Selection.Count-1 do
    AllowStates:=AllowStates and (TObject(Selection[0]) is TdhDynLabel);
  //AllowStates:=AllowStates or (Selection.Count=0) or (TObject(Selection[0]) is TdhPage);
  dhMainForm.ToolBar1.DisableAlign;
  dhMainForm.stateOverDown.Visible:=AllowStates;
  dhMainForm.stateOver.Visible:=AllowStates;
  dhMainForm.stateDown.Visible:=AllowStates;
  dhMainForm.ToolBar1.EnableAlign;
  dhMainForm.SpeedButton1.Repaint;
  {if AllowStates then
  if (TObject(Selection[0]) as TdhCustomPanel).DownOverlayOver then
  begin
   if dhMainForm.stateOver.Left<>np then
   begin
    dhMainForm.stateOver.Left:=np;
   end;
  end else
  if dhMainForm.stateDown.Left<>np then
  begin
    dhMainForm.stateDown.Left:=np;
  end; }

 //dhMainForm.cbName.Top:=6;

// TFakeWinControl(dhMainForm.ToolBar1).RecreateWidget;
{$IFNDEF CLX}
 //TFakeWinControl(dhMainForm.ToolBar1).RecreateWnd;
{$ENDIF}

 LastAct:=PageControl1.ActivePage;

 {if HasCommon(AnchorStyle,TdhCustomPanel) then
 begin
 end;}
 if HasCommon(AnchorName,TControl) then
 begin
 end;
 if HasCommon(AnchorFont,TControl) then
 begin
 end;
 if HasCommon(AnchorBorder,TdhCustomPanel) then
 begin
 end;
 if HasCommon(AnchorBackground,TdhCustomPanel) then
 begin
 end;
 if HasCommon(AnchorPosition,TControl) then
 begin
 end;
 if HasCommon(AnchorPage,TdhPage,false,mPageProperties) then
 begin
 end;
 if HasCommon(AnchorMenu,TdhMenu,true,mMenu) then
 begin
 end;
 if HasCommon(AnchorOle,TdhOleContainer,false,mOle) then
 begin
 end;
 if dhMainForm.compMenu.Visible then
  HasCommon(AnchorLink,TdhLink,false,mSubMenu) else
  HasCommon(AnchorLink,TdhLink);
 if HasCommon(AnchorFormButton,TdhFormButton) then
 begin
 end;
 if HasCommon(AnchorText,TdhLabel,false,mText) then
 begin
 end;
 if HasCommon(AnchorHidden,TdhHiddenField) then
 begin
 end;
 if HasCommon(AnchorMore,TdhCustomPanel) then
 begin
 end;
 if HasCommon(AnchorEffects,TdhCustomPanel) then
 begin
 end;
 if HasCommon(AnchorEdit,TdhEdit) then
 begin
 end;
 if HasCommon(AnchorMemo,TdhMemo) then
 begin
 end;
 if HasCommon(AnchorCheckBox,TdhCheckBox) then
 begin
  UpdateCheckboxDisplay; //da AnchorCheckBox.Caption wechselt
 end;
 if HasCommon(AnchorComboBox,TdhComboBox) then
 begin
 end;
 if HasCommon(AnchorListBox,TdhListBox) then
 begin
 end;
 if HasCommon(AnchorSelect,TdhSelect) then
 begin
 end;
 if HasCommon(AnchorForm,TdhHTMLForm) then
 begin
 end;
 if HasCommon(AnchorPageControl,TdhPageControl,true,mNewPage) then
 begin
 end;

 if (LastAct<>nil) and LastAct.TabVisible then
  PageControl1.ActivePage:=LastAct else
 begin  
    //for i:=AnchorStyle.PageIndex-1 downto 0 do
    for i:=PageControl1.PageCount-1 downto PAGE_STYLES do
    if PageControl1.Pages[i].TabVisible then
    begin
     PageControl1.ActivePage:=PageControl1.Pages[i];
     break;
    end;
 end;
 PageControl1.Visible:=PageControl1.ActivePage<>nil;
 if (Selection.Count<>0) then
 begin
   mGotoUse.Visible:=(FirstCandidate is TdhCustomPanel) and (TdhCustomPanel(FirstCandidate).Use<>nil);
   mGotoLink.Visible:=(FirstCandidate is TdhLink) and (TdhLink(FirstCandidate).LinkPage<>nil);
   mGotoFragment.Visible:=(FirstCandidate is TdhLink) and (TdhLink(FirstCandidate).LinkAnchor<>nil);
   mStyleInfo.Enabled:=(FirstCandidate is TdhCustomPanel);
   mGoto.Enabled:=mGotoUse.Visible or mGotoLink.Visible or mGotoFragment.Visible;
 end;
 mStyles.Enabled:=AnchorBorder.TabVisible;

 finally
//  LockWindowUpdate(0);
 end;
end;

destructor TPropsPC.Destroy;
begin
  FreeAndNil(Selection);
  inherited;
end;

procedure TPropsPC.Changed(const Reason:string; LogChange:TLogChange=lcCommit);
begin
 if dhMainForm.Act=nil then exit; //after design form is closed, edit control may be de-focused later
 dhMainForm.Act.SetModified(Reason,LogChange);
 dhMainForm.Update;
end;


procedure TPropsPC.dhAnchor4Click(Sender: TObject);
begin
 LateCreateForm(TGradientWizard,GradientWizard);
 with ActCommon.BorderClientRect do
 GradientWizard.Prepare(ActCommon,Right-Left,Bottom-Top);
 if GradientWizard.ShowModal=mrOk then
 begin
  with TObject(Selection[0]) as TdhCustomPanel do
   GradientWizard.GetBG(ActStyle.BackgroundImage,{Width,Height}GradientWizard.sw,GradientWizard.sh);
  ActStyle.BackgroundRepeat:=GradientWizard.SampleGradient.Style.BackgroundRepeat;
  ActStyle.BackgroundPosition:=GradientWizard.SampleGradient.Style.BackgroundPosition;
  BackgroundChanged;
 end;
end;

function TPropsPC.ChooseTwice(i:integer; c:TClass):TControl;
begin
 if TObject(Selection[0]).InheritsFrom(c) then
  result:=TObject(Selection[0]) as TControl else
  result:=GetVirtualParent(TObject(Selection[0]) as TControl);
end;


procedure TPropsPC.dhAnchor8Click(Sender: TObject);
var gpc:TdhPageControl;
begin
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 gpc.AddSheet;
// SetControlTo(gpc.ActivePage,true,true);
 AnchorPageControlShow(nil);
 (gpc.Owner as TPageContainer).MySiz.SetControlTo(gpc.Pages[vs.ItemIndex{FocusedNode.Index}],true,true);
 Changed('Page Control');
end;


procedure TPropsPC.AnchorPageControlShow(Sender: TObject);
var i:integer;
    //Node:PVirtualNode;
    WasFocused:boolean;
var gpc:TdhPageControl;
begin
 Adjusting:=true;
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 //WasFocused:=vs.FocusedNode<>nil;
 cFixedHeight.Checked:=gpc.FixedHeight;
 cDynamicNavigation.Checked:=gpc.DynamicNavigation;

 vs.Clear;
 for i:=0 to gpc.PageCount-1 do
 begin
  vs.Items.Add(gpc.Pages[i].Name);
  if gpc.Pages[i].IsActivePage then
   vs.ItemIndex:=i;
  //vs.ItemIndex:=gpc.ActivePageIndex;

 end;
 {vs.BeginUpdate;
 vs.Clear;
 for i:=0 to gpc.PageCount-1 do
 begin
  Node:=VsAddNode(vs);
  if gpc.Pages[i].IsActivePage then
  begin
   vs.Selected[Node]:=true;
//   if WasFocused then
   vs.FocusedNode:=Node;
  end;
 end;
 vs.ScrollIntoView(vs.FocusedNode,false);
 vs.EndUpdate;}
 
 Adjusting:=false;
end;


procedure TPropsPC.dhAnchor11Click(Sender: TObject);
var gpc:TdhPageControl;
begin
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 if {vs.FocusedNode=nil}vs.ItemIndex<0 then
 begin
  showmessage('You have to select a page');
  exit;
 end;
 gpc.Pages[{vs.FocusedNode.Index}vs.ItemIndex].Free;
 if gpc<>nil then
 begin                       
  (gpc.Owner as TPageContainer).MySiz.SetControlTo(gpc,true,true);
  AnchorPageControlShow(nil);
 end;
 Changed('Page Control');

end;

procedure TPropsPC.dhAnchor9Click(Sender: TObject);
var i:integer;
var gpc:TdhPageControl;
begin
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 if {vs.FocusedNode=nil}vs.ItemIndex<0 then
 begin
  showmessage('You have to select a page');
  exit;
 end;
 i:=gpc.Pages[{vs.FocusedNode.Index}vs.ItemIndex].PageIndex;
 if Sender=Button7 then
  i:=i-1 else
  i:=i+1;
 i:=(i+gpc.PageCount) mod gpc.PageCount;
 gpc.Pages[{vs.FocusedNode.Index}vs.ItemIndex].PageIndex:=i;
 AnchorPageControlShow(nil);
 Changed('Page Control');
end;

{
procedure TPropsPC.vsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
var i:integer;
var gpc:TdhPageControl;
begin
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 if Integer(Node.Index)>gpc.PageCount-1 then
  AnchorPageControlShow(nil) else
  CellText:=gpc.Pages[Node.Index].Name+' - '+gpc.Pages[Node.Index].Title;
end;
 }                      {
procedure TPropsPC.vsFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var i,OffsetY:integer;
    Page:TdhPage;
var gpc:TdhPageControl;
begin
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 if vs.FocusedNode=nil then exit;
 page:=gpc.Pages[vs.FocusedNode.Index];
 if page=gpc.ActivePage then exit;
 OffsetY:=vs.OffsetY;
 gpc.ActivePage:=page;
 (gpc.Owner as TPageContainer).MySiz.SetControlTo(gpc.Pages[vs.FocusedNode.Index],true,true);
 vs.OffsetY:=OffsetY;
 vs.SetFocus;
end;                 }


procedure TPropsPC.AnchorLinkShow(Sender: TObject);
begin
 UpdateLinkDisplay;
end;

function AcceptableLinkAnchor(match,ori:TControl):boolean;
var StyleSheet:TdhStyleSheet;
begin
 result:=not InStyleSheet(match,StyleSheet);
end;

function AcceptableLinkPage(match,ori:TControl):boolean;
var StyleSheet:TdhStyleSheet;
begin
 result:=not (match as TdhPage).IsIFrame;
end;

procedure TPropsPC.UpdateLinkDisplay;
var c:TdhLink;
begin
 Adjusting:=true;
 c:=TObject(Selection[0]) as TdhLink;

 GetRefs(cbLinkPage,TdhPage,c,c.LinkPage,AcceptableLinkPage,not true);
 if cbLinkPage.Text='' then cbLinkPage.StoredText:=c.SLinkPage;
 GetRefs(cbLinkAnchor,TdhCustomPanel,c,c.LinkAnchor,AcceptableLinkAnchor,not true);
 if cbLinkAnchor.Text='' then cbLinkAnchor.StoredText:=c.SLinkAnchor;

 eLink.StoredText:=c.Link;
 eTarget.StoredText:=c.Target;
 //bChangeLink.Left:=lLink.Left+lLink.Width+5;
 //cbLinkType.ItemIndex:=Integer(c.LinkType);
 cLinkLayout.ItemIndex:=Integer(c.Layout);
 {rbAUTO.Checked:=c.Layout=ltAuto;
 rbDIV.Checked:=c.Layout=ltText;
 rbLINK.Checked:=c.Layout=ltLink;
 rbBUTTON.Checked:=c.Layout=ltButton;}
 cDownIfUrl.Checked:=loDownIfUrl in c.Options;
 cDownIfMenu.Checked:=loDownIfMenu in c.Options;
 cDownIfMouseDown.Checked:=loDownIfMouseDown in c.Options;
 cDownIfOver.Checked:=loDownIfOver in c.Options;
 cLinkAuto.Checked:=c.Auto;
 cDown.Checked:=c.Down;
 cDownIfMouseDown.Enabled:=not c.AutoRelevant;
 cDownIfOver.Enabled:=not c.AutoRelevant;
 cDownIfUrl.Enabled:=not c.AutoRelevant;
 cDownIfMenu.Enabled:=not c.AutoRelevant;
 Adjusting:=false;
end;

procedure TPropsPC.LinkChanged;
begin
 UpdateLinkDisplay;
 Changed('Link');
end;


procedure TPropsPC.cbLinkTypeClick(Sender: TObject);
var i:integer;
//    c:TComponent;
//    lt:TLinkType;
begin
 //lt:=TLinkType(cbLinkType.ItemIndex);
 {if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
 with TObject(Selection[i]) as TdhLink do
 if rbAUTO.Checked then
  Layout:=ltAuto else
 if rbDIV.Checked then
  Layout:=ltText else
 if rbLINK.Checked then
  Layout:=ltLink else
 if rbBUTTON.Checked then
  Layout:=ltButton;
 LinkChanged;  }
end;

procedure TPropsPC.dhAnchor13Click(Sender: TObject);
var i:integer;
begin               {
 if OpenPictureDialog1.Execute then
 begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhLink).ActStyle.LoadImage(OpenPictureDialog1.FileName);
  Changed('image');
 end;          }
end;

procedure TPropsPC.dhAnchor14Click(Sender: TObject);
var Picture:TPicture;
begin                        {
 if SavePictureDialog1.Execute then
 if (TObject(Selection[0]) as TdhLink).FCommon.HasImage(Picture) then
  Picture.SaveToFile(SavePictureDialog1.FileName); }
end;

procedure TPropsPC.dhAnchor15Click(Sender: TObject);
var i:integer;
begin                                      {
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TMemo).Caption:=eMemo.Text;
  dhMainForm.Act.MySiz.DoInval(false);
  Changed('memo');                          }
end;

procedure TPropsPC.UpdateComboBoxDisplay(OnlyItems:boolean);
var combobox:TdhComboBox;
begin
  combobox:=TObject(Selection[0]) as TdhComboBox;
  if not OnlyItems then
   eComboBox.StoredText:=combobox.Items.Text;
  dhComboBox2.Items.Text:='*CLEAR VALUE*'+#13#10+combobox.Items.Text;
  dhComboBox2.StoredItemIndex:=GoodIndex(combobox.ItemIndex+1);
  eComboBoxTarget.StoredText:=combobox.Target;
end;

procedure TPropsPC.UpdateListBoxDisplay(OnlyItems:boolean);
var listbox:TdhListBox;
begin
  listbox:=TObject(Selection[0]) as TdhListBox;
  if not OnlyItems then
   eListBox.StoredText:=listbox.Items.Text;
  dhComboBox3.Items.Text:='*CLEAR VALUE*'+#13#10+listbox.Items.Text;
  dhComboBox3.StoredItemIndex:=GoodIndex(listbox.ItemIndex+1);
  cMultiSelect.Checked:=listbox.MultiSelect;
end;


procedure TPropsPC.cMultiSelectClick(Sender: TObject);
var i,sHeight:integer;
begin
  for i:=0 to Selection.Count-1 do
  with (TObject(Selection[i]) as TdhListBox) do
  begin
   sHeight:=Height;
   MultiSelect:=cMultiSelect.Checked;
   Height:=sHeight;
  end;
  Changed('List Box');
end;

procedure TPropsPC.cAutoXClick(Sender: TObject);
var i:integer;
    rct:TRect;
    pn:TdhCustomPanel;
const asar:array[boolean,boolean] of TASXY=((asNone,asY),(asX,asXY));    
begin
 if Adjusting then exit;
 dhMainForm.Act.MySiz.DoInval(true);
 try
 for i:=0 to Selection.Count-1 do      {
 if TObject(Selection[i]) is TEdit then
  TEdit(TObject(Selection[i])).AutoSize:=cAutoY.Checked else  }
 if (TObject(Selection[i]) is TdhOleContainer) or (TObject(Selection[i]) is TdhCustomLabel) or (TObject(Selection[i]) is TdhMenu) then
 begin
  pn:=TdhCustomPanel(Selection[i]);
  pn.AutoSizeXY:=asar[cAutoX.Checked,cAutoY.Checked];
 end;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdatePositionDisplay;
 Changed('Autosize');
end;

procedure TPropsPC.dhAnchor26Click(Sender: TObject);
var i:integer;
begin
(* LateCreateForm(TTransBG,TransBG);
 TransBG.Prepare((TObject(Selection[0]) as TdhCustomPanel).Style.Transformations);
 if TransBG.ShowModal=mrOk then
 begin                     {
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCustomPanel).Style.Transformations.Assign(TransBG.tt); }
  Changed('transformations');
 end else
  dhMainForm.Act.UpdateContent;*)
end;


procedure TPropsPC.WriteTransformations(tt: TTransformations);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Effects.Assign(tt);
end;

procedure TPropsPC.spAngleChange(Sender: TObject);
begin
 spAngle.Value:=GoodAngle(spAngle.Value);
end;

function TPropsPC.getblur(tt:TTransformations; i:integer=-1):TBlurEffect;
begin
 if i=-1 then
  i:=TabControl1.TabIndex;
 Case i of
 0: result:=tt.OuterShadow;
 1: result:=tt.InnerShadow;
 2: result:=tt.OuterGlow;
 3: result:=tt.InnerGlow;
 else result:=tt.Blur;
 end;
end;


procedure TPropsPC.BuildTransformations;
begin
 if Adjusting then exit;
 assert(not Adjusting);
 LiveBuildTransformations;
 Changed('Effects');
end;

procedure TPropsPC.LiveBuildTransformations;
var tt:TTransformations;
    blur:TBlur;
begin
 if Adjusting then exit;
 assert(not Adjusting);
 tt:=TTransformations.Create(nil);
 tt.Assign(ActStyle.Effects);
 tt.Enabled:=cEffectsEnabled.Checked;
 tt.Rotation:=spAngle.Value;
 tt.ShiftX:=spShiftX.Value;
 tt.ShiftY:=spShiftY.Value;
 tt.ScaleX:=spScaleX.Value;
 tt.ScaleY:=spScaleY.Value;
 tt.SkewX:=spSkewX.Value;
 tt.SkewY:=spSkewY.Value;
 tt.AntiAliasing:=cAntiAliasing.Checked;
 tt.TextOnly:=cTextOnly.Checked;
 tt.UseBased:=cUseBased.Checked;
 tt.FullIfEasy:=cFullIfEasy.Checked;
 tt.Alpha:=Adj100to255(spMasterAlpha.Value);
 with getblur(tt) do
 begin
  Alpha:=Adj100to255(spBlurAlpha.Value);
  Color:=cpBlurColor.Color;
  Radius:=spBlurRadius.Value;
  Flood:=spBlurFlood.Value;
  Distance:=spBlurDistance.Value;
  Degree:=NormalizeDegree(spBlurDegree.Value);
  Enabled:=cBlurEnabled.Checked;
 end;
 WriteTransformations(tt);
 tt.Free;
 UpdateEffectsDisplay2;
end;

var OldBlurIsCleared:boolean=false;

procedure TPropsPC.UpdateEffectsDisplay2;
begin
 SetClearState(bClearEffects,IsEffectsCleared);
 if OldBlurIsCleared<>not getblur(ActStyle.Effects).Enabled then
 begin
  OldBlurIsCleared:=not OldBlurIsCleared;
  TabControl1.Invalidate;
 end;
end;

procedure TPropsPC.UpdateEffectsDisplay;
var tt:TTransformations;
    Common:TCommon;
    ShadowExt,GlowExt:boolean;
begin
 if not Showing then exit;
 //AnchorEffects.Color:=clRed;
 Adjusting:=true;
 tt:=ActStyle.Effects;                 
 cEffectsEnabled.Checked:=tt.Enabled;
 spAngle.StoredValue:=tt.Rotation;
 spShiftX.StoredValue:=tt.ShiftX;
 spShiftY.StoredValue:=tt.ShiftY;
 spScaleX.StoredValue:=tt.ScaleX;
 spScaleY.StoredValue:=tt.ScaleY;
 spSkewX.StoredValue:=tt.SkewX;
 spSkewY.StoredValue:=tt.SkewY;
 spMasterAlpha.StoredValue:=Adj255to100(tt.Alpha);
 cAntiAliasing.Checked:=tt.AntiAliasing;
 cTextOnly.Checked:=tt.TextOnly;
 cUseBased.Checked:=tt.UseBased;
 cFullIfEasy.Checked:=tt.FullIfEasy;
 with getblur(tt) do
 begin
  spBlurAlpha.StoredValue:=Adj255to100(Alpha);
  cpBlurColor.Color:=Color;
  spBlurRadius.StoredValue:=Radius;
  spBlurFlood.StoredValue:=Flood;
  spBlurDistance.StoredValue:=Distance;
  spBlurDegree.StoredValue:=Degree;
  cBlurEnabled.Checked:=Enabled;
 end;

 ShadowExt:=TabControl1.TabIndex<=1;
 lDistance.Visible:=ShadowExt;
// lDistanceUnit.Visible:=ShadowExt;
 lDegree.Visible:=ShadowExt;
 //lDegreeUnit.Visible:=ShadowExt;
 spBlurDistance.Visible:=ShadowExt;
 spBlurDegree.Visible:=ShadowExt;
 slBlurDistance.Visible:=ShadowExt;
 slBlurDegree.Visible:=ShadowExt;

 GlowExt:=TabControl1.TabIndex<=3;
 cpBlurColor.Visible:=GlowExt;
// lOpacityUnit.Visible:=GlowExt;
 lOpacity.Visible:=GlowExt;
 spBlurAlpha.Visible:=GlowExt;
 spBlurFlood.Visible:=GlowExt;
 slBlurAlpha.Visible:=GlowExt;
 slBlurFlood.Visible:=GlowExt;
// spFloodUnit.Visible:=GlowExt;
 lFlood.Visible:=GlowExt;

 UpdateEffectsDisplay2;

 Adjusting:=false;
end;

function TPropsPC.IsEffectsCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
  result:=(TObject(Selection[i]) as TdhCustomPanel).ActStyle.Effects.IsCleared;
end;


procedure TPropsPC.cRenderClick(Sender: TObject);
begin
 BuildTransformations;
end;

procedure TPropsPC.cpFontColorColorChanged(Sender: TObject);
var i:integer;
begin               
 if Adjusting then exit;    
 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
  if TObject(Selection[i]) is TdhCustomPanel then
   TdhCustomPanel(TObject(Selection[i])).ActStyle.Color:=cpFontColor.Color else
   TFakeControl(Selection[i]).Font.Color:=cpFontColor.Color;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdateFontDisplay;
 Changed('Change Font Color');
end;

procedure TPropsPC.TabControl1Change(Sender: TObject);
begin
 UpdateEffectsDisplay;
end;

procedure TPropsPC.cpBorderColorColorChanged(Sender: TObject);
begin
  ActStyle.Borders[EdgeAlign].Color:=cpBorderColor.Color;
  BorderChanged;
end;

procedure TPropsPC.ClearAllStyles(ClearUse:boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).FCommon.ClearAllStyles(ClearUse);
end;


procedure TPropsPC.AnchorStyleShow(Sender: TObject);
begin
 UpdateStylesDisplay;
end;
                      
function FilterUse(match,ori:TControl):boolean;
var Common:TCommon;
begin
 result:=UsefulUse(match,ori,false,Common) or ((ori as TdhCustomPanel).Use=match);
end;

procedure TPropsPC.UpdateStylesDisplay;
var sl:TStringList;
    i:integer;
    Common:TCommon;
    pn:TdhCustomPanel;
begin
 if not Showing then exit;
 Adjusting:=true;

 SetChildrenEnabled(GroupBox18,TObject(Selection[0]) is TdhCustomPanel);
 if GroupBox18.Enabled then
 begin

 cDownOverlayOver.Checked:=ActCommon.DownOverlayOver;
 cOverOverlayDown.Checked:=not cDownOverlayOver.Checked;
// cExtendedUse.Checked:=ActCommon.ExtendedUse;

 //cClearStyles:=

 pn:=(TObject(Selection[0]) as TdhCustomPanel);


 GetRefs(cbUse,TdhCustomPanel,pn,pn.Use,FilterUse,not true);
 if cbUse.Text='' then cbUse.StoredText:=pn.SUse;
                         {
 sl:=TStringList.Create;
 sl.Add('*CLEAR VALUE*');
 for i:=0 to dhMainForm.Act.ComponentCount-1 do
 if UsefulUse(dhMainForm.Act.Components[i],(TObject(Selection[0]) as TdhCustomPanel),false,Common) or ((TObject(Selection[0]) as TdhCustomPanel).Use=dhMainForm.Act.Components[i]) then
  sl.Add(dhMainForm.Act.Components[i].Name);
 sl.Sort;
 cbUse.Items.Assign(sl);
 if (TObject(Selection[0]) as TdhCustomPanel).Use<>nil then
  cbUse.StoredItemIndex:=cbUse.Items.IndexOf((TObject(Selection[0]) as TdhCustomPanel).Use.Name);
 if cbUse.ItemIndex=-1 then cbUse.StoredItemIndex:=0;
 sl.Free;        }
 end;
 Adjusting:=false;
end;

procedure TPropsPC.StylesChanged;
begin
 Changed('Styles');
end;

procedure TPropsPC.Button8Click(Sender: TObject);
var
  Temp,Temp2: string;
  Comp: TPersistent;
  i:integer;
begin
  if TdhStrEditDlg.Prepare2(GetComponent(0) as TdhLabel) then
  begin
  for i:=0 to dhMainForm.Act.ComponentCount-1 do
   dhStrEditDlg.VisitProc(dhMainForm.Act.Components[i]);
  dhStrEditDlg.Execute(Temp);
  (GetComponent(0) as TdhLabel).Text:=Temp;
  UpdateTextDisplay;
  Changed('Edit Text');
 end;
end;

function TPropsPC.GetComponent(Index: Integer): TPersistent;
begin
 result:=TPersistent(Selection[Index]);
end;

procedure TPropsPC.AnchorEffectsShow(Sender: TObject);
begin
 UpdateEffectsDisplay;
end;

procedure TPropsPC.Button3Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 if not (TObject(Selection[i]) as TdhCustomPanel).ActStyle.CopyBlurEffectsByInherited then
  showmessage('No inherited values found');
 UpdateEffectsDisplay;
 BuildTransformations;
end;



procedure TPropsPC.cClearStylesClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).FCommon.ActStyle.Clear;
 UpdateStylesDisplay;
 StylesChanged;
end;
                     {
procedure TPropsPC.Addmenuitem1Click(Sender: TObject);
var
  Temp,Temp2: string;
  Comp: TPersistent;
  i:integer;
begin
  dhStrEditDlg.Prepare2(GetComponent(0) as TdhLabel);
  for i:=0 to dhMainForm.Act.ComponentCount-1 do
   dhStrEditDlg.VisitProc(dhMainForm.Act.Components[i]);
  dhStrEditDlg.Execute(Temp);
  (GetComponent(0) as TdhLabel).Caption:=Temp;
end;               }

procedure TPropsPC.Button10Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (ChooseTwice(i,TdhMenu) as TdhMenu).AddMenuItem;
 Changed('Add Menu Item');
end;

procedure TPropsPC.mSubMenuClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhLink).AddSubMenu.Visible:=true;  
 Changed('Add Sub Menu');
end;

procedure TPropsPC.Aligntogrid1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with TMySiz.GetAlignedBounds(TObject(Selection[i]) as TControl) do
  (TObject(Selection[i]) as TControl).SetBounds(Left,Top,Right-Left,Bottom-Top);
 Changed('Align to Grid');
 ActBoundsChanged;
end;

procedure TPropsPC.Sendtoback1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do                 
 //if not((TObject(Selection[i]) as TControl).Parent is TPageContainer) then
  (TObject(Selection[i]) as TControl).SendToBack;
 Changed('Send to Back');
end;

procedure TPropsPC.Bringtofront1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 //if not((TObject(Selection[i]) as TControl).Parent is TPageContainer) then
  (TObject(Selection[i]) as TControl).BringToFront;
 dhMainForm.Act.MySiz.BringToFront; //alle Elemente sollten unter MySiz sein
 Changed('Bring to Front');
end;

procedure TPropsPC.cTransparentClick(Sender: TObject);
var OldTrans:boolean;
    i:integer;
begin
 if Adjusting then exit;
 OldTrans:=cTransparent.Checked;

 dhMainForm.Act.MySiz.DoInval(true);
 try
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TControl then
 begin
  if Sender=cpBackgroundColor then
  begin
   if TObject(Selection[i]) is TdhCustomPanel then
    TdhCustomPanel(TObject(Selection[i])).ActStyle.BackgroundColor:=cpBackgroundColor.Color else
    TFakeControl(Selection[i]).Color:=cpBackgroundColor.Color;
  end else
  begin
   if TObject(Selection[i]) is TdhCustomPanel then
    TdhCustomPanel(TObject(Selection[i])).Transparent:=cTransparent.Checked else
    TFakeControl(Selection[i]).ParentColor:=cTransparent.Checked;
  end;
 end;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;

 UpdateFontDisplay;
 Changed('Change Background Color');

 if (Sender=cTransparent) and (OldTrans<>cTransparent.Checked) then
  showmessage('Transparency is not supported for this object');
end;

procedure TPropsPC.cFixedHeightClick(Sender: TObject);
var gpc:TdhPageControl;
begin
 if Adjusting then exit;
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 gpc.FixedHeight:=cFixedHeight.Checked;
 Changed('Page Control');
end;

procedure TPropsPC.SaveImage1Click(Sender: TObject);
var pn:TdhCustomPanel;
    s:string;
begin
 SavePictureDialog1.FileName:='';
 if TObject(Selection[0]) is TdhCustomPanel then
 if SavePictureDialog1.Execute then
 begin
  dhMainForm.Act.SetDesigning(false,true);
  pn:=TdhCustomPanel(TObject(Selection[0]));
  pn.SaveAsImage(SavePictureDialog1.FileName);
  dhMainForm.Act.SetDesigning(not _RuntimeMode,true);
 end;
end;


procedure TPropsPC.AnchorMoreShow(Sender: TObject);
begin
 UpdateMoreDisplay;
end;

function cssinttostr(i:TCSSInteger):string;
begin
 if i=vsrInherit then
  result:='' else
  result:=inttostr(i);
end;

procedure TPropsPC.UpdateMoreDisplay;
begin            
 if not Showing then exit;
 cbTextAlign.StoredItemIndex:=GoodIndex(Integer(ActStyle.TextAlign));
 cbWhiteSpace.StoredItemIndex:=GoodIndex(Integer(ActStyle.WhiteSpace));
 cbCursor.StoredItemIndex:=GoodIndex(Integer(ActStyle.Cursor));
 cbVerticalAlign.StoredText:=ActStyle.VerticalAlign;
 cbTextIndent.StoredText:=ActStyle.TextIndent;
 cbZIndex.StoredText:=cssinttostr(ActStyle.ZIndex);
 cbTextTransform.StoredItemIndex:=GoodIndex(Integer(ActStyle.TextTransform));
 cbFontVariant.StoredItemIndex:=GoodIndex(Integer(ActStyle.FontVariant));
 cbDirection.StoredItemIndex:=GoodIndex(Integer(ActStyle.Direction));  
 SetClearState(bClearMore,IsMoreCleared);
 SetUnderlineState(bMoreMisc,IsMoreExtCleared);
end;

procedure DefaultPropertyListDrawValue(const Value: string; Canvas: TCanvas;
  const Rect: TRect; Selected: Boolean);
begin
  Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, Value);
end;


procedure TPropsPC.cbCursorDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Right: Integer;
  CursorIndex: Integer;
  Cursor:TCSSCursor;
  Value:string;
begin
{$IFNDEF CLX}
  Right := Rect.Left + GetSystemMetrics(SM_CXCURSOR) + 4;
  with cbCursor.Canvas do
  begin
    Cursor:=TCSSCursor(GoodIndexBack(Index));
    if not (Cursor in [ccuInherit,ccuAuto]) and not (odComboBoxEdit in State) then
    begin
    CursorIndex:=CSSCursorMap[Cursor];
    FillRect(Rect);
    if Screen.Cursors[CursorIndex] <> 0 then
      DrawIconEx(Handle, Rect.Left + 2, Rect.Top + 2, Screen.Cursors[CursorIndex],
        0, 0, 0, 0, DI_NORMAL or DI_DEFAULTSIZE);
    end else
     Right:=Rect.Left;
    if Index<0 then
     Value:='' else
     Value:=cbCursor.Items[GoodIndexBack(Index)];
    DefaultPropertyListDrawValue(Value, cbCursor.Canvas, Classes.Rect(Right, Rect.Top,
      Rect.Right, Rect.Bottom), odSelected in State);
  end;
{$ENDIF}
end;

procedure TPropsPC.cbCursorMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
{$IFNDEF CLX}
 if Index>=2 then
  Height:=GetSystemMetrics(SM_CYCURSOR) + 4 else
  Height:=15;
{$ENDIF}
end;

           
function WithoutPx(const s:string):string;
begin
 if SubEqualEnd('px',s) then
  result:=CopyLess(s,2) else
  result:=s;
end;

procedure TPropsPC.cDownIfUrlClick(Sender: TObject);
var i:integer;
    c:TComponent;
    lt:TLinkType;
    lo:TAnchorOptions;
begin
 if Adjusting then exit;
 lo:=[];
 if cDownIfUrl.Checked then
  include(lo,loDownIfUrl);
 if cDownIfOver.Checked then
  include(lo,loDownIfOver);
 if cDownIfMenu.Checked then
  include(lo,loDownIfMenu);
 if cDownIfMouseDown.Checked then
  include(lo,loDownIfMouseDown);
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TdhLink) do
 begin
  Options:=lo;
  Auto:=cLinkAuto.Checked;
  Down:=cDown.Checked;
 end;
 LinkChanged;
end;

procedure TPropsPC.cbLinkPageDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var pn:TdhLink;
    cb:TComboBox;
begin

// cbLinkPage.OnDrawItem:=cbLinkPageDrawItemCLX;

    cb:=Control as TComboBox;
    cb.Canvas.FillRect(Rect);
    pn:=(TObject(Selection[0]) as TdhLink);
    if (odComboBoxEdit in State) and (_if(Control=cbLinkPage,pn.LinkPage,pn.LinkAnchor)=nil) then
    begin
      cb.Canvas.Font.Color:=clGray;
      cb.Canvas.TextOut(Rect.Left + 2, Rect.Top, _if(Control=cbLinkPage,pn.SLinkPage,pn.SLinkAnchor));
    end else
    if Index >= 0 then
      cb.Canvas.TextOut(Rect.Left + 2, Rect.Top, cb.Items[Index]);
end;

procedure TPropsPC.cbCursorDrawItemCLX(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
begin
 cbCursorDrawItem(Sender as TWinControl,Index,Rect,State);
 Handled:=true;
end;

procedure TPropsPC.cbLinkPageDrawItemCLX(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
begin
 cbLinkPageDrawItem(Sender as TWinControl,Index,Rect,State);
 Handled:=true;
end;


procedure TPropsPC.cbUseDrawItemCLX(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
begin
 cbUseDrawItem(Sender as TWinControl,Index,Rect,State);
 Handled:=true;
end;

procedure TPropsPC.cbUseDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var pn:TdhCustomPanel;
begin
    cbUse.Canvas.FillRect(Rect);
    if not GroupBox18.Enabled then exit;
    pn:=(TObject(Selection[0]) as TdhCustomPanel);
    if (odComboBoxEdit in State) and (pn.Use=nil) then
    begin
      cbUse.Canvas.Font.Color:=clGray;
      cbUse.Canvas.TextOut(Rect.Left + 2, Rect.Top, pn.SUse);
    end else
    if Index >= 0 then
      cbUse.Canvas.TextOut(Rect.Left + 2, Rect.Top, cbUse.Items[Index]);
end;

procedure TPropsPC.AnchorMenuShow(Sender: TObject);
begin
 UpdateMenuDisplay;
end;

procedure TPropsPC.UpdateMenuDisplay();
var c:TdhMenu;
begin
 if not Showing then exit;
 Adjusting:=true;
 c:= ChooseTwice(0,TdhMenu) as TdhMenu;
 cHorizontalLayout.Checked:=moHorizontalLayout in c.MenuOptions;
 cInline.Checked:=moInline in c.MenuOptions;
 cResumeOpen.Checked:=moResumeOpen in c.MenuOptions;
 cStatic.Checked:=moStatic in c.MenuOptions;
 cSlide.Checked:=moSlide in c.MenuOptions;
 cOpenByOver.Checked:=not(moClickToOpen in c.MenuOptions);
 cMenuAuto.Checked:=c.Auto;
 spSlidePixel.StoredValue:=c.SlidePixel;
 spReactionTime.StoredValue:=c.ReactionTime;
 GetRefs(cbParentMenuItem,TdhLink,c,c.ParentMenuItem,nil,true);
 if cbParentMenuItem.ItemIndex=0 then
  cbParentMenuItem.ItemIndex:=-1;
 SetChildrenEnabled(CheckGroupBox1,not c.AutoRelevant);
 SetChildrenEnabled(GroupBox14,not c.AutoRelevant);
 Label21.Enabled:=cSlide.Checked and not c.AutoRelevant;
 spSlidePixel.Enabled:=cSlide.Checked and not c.AutoRelevant;
 Label20.Enabled:=cSlide.Checked and not c.AutoRelevant;
 cOpenByOver.Enabled:=not c.AutoRelevant;
 spReactionTime.Enabled:=cOpenByOver.Checked and not c.AutoRelevant;
 Label22.Enabled:=spReactionTime.Enabled;
 Adjusting:=false;
end;

procedure TPropsPC.MenuChanged;
var mo:TMenuOptions;
var i:integer;
begin
 if Adjusting then exit;
 mo:=[];
 if cHorizontalLayout.Checked then
  Include(mo,moHorizontalLayout);
 if cInline.Checked then
  Include(mo,moInline);
 if cResumeOpen.Checked then
  Include(mo,moResumeOpen);
 if cStatic.Checked then
  Include(mo,moStatic);
 if cSlide.Checked then
  Include(mo,moSlide);
 if not cOpenByOver.Checked then
  Include(mo,moClickToOpen);    
 if not cMenuAuto.Checked then
  Include(mo,moNoAuto);
 for i:=0 to Selection.Count-1 do
 with ChooseTwice(i,TdhMenu) as TdhMenu do
 begin
  MenuOptions:=mo;
  SlidePixel:=spSlidePixel.Value;
  ReactionTime:=spReactionTime.Value;
 end;          
 UpdateMenuDisplay;
end;

procedure TPropsPC.AnchorNameShow(Sender: TObject);
begin
 UpdateNameDisplay;
end;

procedure TPropsPC.AnchorFontShow(Sender: TObject);
begin
 UpdateFontDisplay;
end;

procedure TPropsPC.AnchorComboBoxShow(Sender: TObject);
begin
 UpdateComboBoxDisplay(false);
end;

procedure TPropsPC.AnchorListBoxShow(Sender: TObject);
begin
 UpdateListBoxDisplay(false);
end;

procedure TPropsPC.cReadOnlyClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhEdit).ReadOnly:=cReadOnly.Checked;
  Changed('Input Options');
end;

procedure TPropsPC.AnchorEditShow(Sender: TObject);
begin
 UpdateEditDisplay;
end;

procedure TPropsPC.UpdateEditDisplay;
begin
  Adjusting:=true;
  eEdit.StoredText:=(TObject(Selection[0]) as TdhEdit).Text;
  cReadOnly.Checked:=(TObject(Selection[0]) as TdhEdit).ReadOnly;
  cPassword.Checked:=(TObject(Selection[0]) as TdhEdit).Password;
  Adjusting:=false;
end;

procedure TPropsPC.UpdateMemoDisplay;
begin
  Adjusting:=true;
  eMemo.StoredText:=(TObject(Selection[0]) as TdhMemo).Lines.Text;
  cMemoReadOnly.Checked:=(TObject(Selection[0]) as TdhMemo).ReadOnly;
  cWrap.Checked:=(TObject(Selection[0]) as TdhMemo).Wrap;
  Adjusting:=false;
end;


procedure TPropsPC.AnchorCheckBoxShow(Sender: TObject);
begin
 UpdateCheckboxDisplay;
end;

procedure TPropsPC.UpdateCheckboxDisplay;
var checkbox:TdhCheckBox;
begin
 Adjusting:=True;
 checkbox:=TdhCheckBox(TObject(Selection[0]));
 if checkbox is TdhRadioButton then
 begin
  AnchorCheckBox.Caption:='Radio button    ';
  cRightJustify.Caption:='Caption appears to the right of the radio button';
 end else
 begin
  AnchorCheckBox.Caption:='Check box    ';
  cRightJustify.Caption:='Caption appears to the right of the check box';
 end;
 rgChecked.ItemIndex:=booltoint(not checkbox.Checked);
 eCheckValue.StoredText:=checkbox.Value;
 cRightJustify.Checked:=checkbox.Alignment=taRightJustify;
 Adjusting:=false;
end;

procedure TPropsPC.cCheckedClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCheckBox).Checked:=rgChecked.ItemIndex=0;
  Changed(AnchorCheckBox.Caption);
end;

procedure TPropsPC.cRightJustifyClick(Sender: TObject);
var i:integer;
const GetAlignment:array[boolean] of TLeftRight=(taLeftJustify,taRightJustify);
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCheckBox).Alignment:=GetAlignment[cRightJustify.Checked];
  Changed(AnchorCheckBox.Caption);
end;

procedure TPropsPC.cDownOverlayOverClick(Sender: TObject);      
var i:integer;
begin
 if Adjusting then exit;
 if (TObject(Selection[0]) as TdhCustomPanel).Use<>nil then
 begin
  showmessage('Note: This option can only be set if no Use element is assigned');
  UpdateStylesDisplay;
  exit;
 end;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).DownOverlayOver:=cDownOverlayOver.Checked;
 UpdateStylesDisplay;
 StylesChanged;
end;

procedure TPropsPC.cExtendedUseClick(Sender: TObject);
var i:integer;
begin
{ if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ExtendedUse:=cExtendedUse.Checked;
 UpdateStylesDisplay;
 StylesChanged;}
end;

procedure TPropsPC.AnchorBorderShow(Sender: TObject);
begin
 UpdateBorderDisplay;
end;

procedure TPropsPC.AnchorPositionShow(Sender: TObject);
begin
 UpdatePositionDisplay;
end;

procedure TPropsPC.AnchorBackgroundShow(Sender: TObject);
begin
 UpdateBackgroundDisplay;
end;

procedure TPropsPC.Button9Click(Sender: TObject);
var i:integer;
    pn:TCommon;
const MapDoAction:array[1..4] of TState=(hsNormal,hsDown,hsOver,hsOverDown);
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
 begin
  pn:=(TObject(Selection[i]) as TdhCustomPanel).FCommon;
  repeat
   case cDoAction.ItemIndex mod 5 of
   0: pn.ActStyle.Clear;
   1,2,3,4:
   if pn.StyleArr[MapDoAction[cDoAction.ItemIndex mod 5]]=nil then
    showmessage('This element only supports one style') else
    pn.ActStyle.Assign(pn.StyleArr[MapDoAction[cDoAction.ItemIndex mod 5]]);
   end;
   if pn.Use=nil then
    pn:=nil else
    pn:=pn.Use.GetCommon;
  until (pn=nil) or (cDoAction.ItemIndex<5);
 end;
// InstallDefaultFont;
 UpdateStylesDisplay;
 StylesChanged;
end;

procedure TPropsPC.PageControl1DrawTabCLX(Control: TCustomTabControl; TabIndex: Integer;
    const Rect: TRect; Active: Boolean; var DefaultDraw: Boolean );
begin
// PageControl1DrawTab(Control,TabIndex,Rect,Active);
end;


procedure TPropsPC.TabControl2DrawTabCLX(Control: TCustomTabControl; TabIndex: Integer;
    const Rect: TRect; Active: Boolean; var DefaultDraw: Boolean );
begin
 TabControl2DrawTab(Control,TabIndex,Rect,Active);
end;


procedure TPropsPC.PageControl1DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var Tab:TTabSheet;
    XRect:TRect;
    XRect2:TRect;
    i:integer;
    s:string;
begin
 //Control.Canvas.Brush.Color:=clRed;
 Control.Canvas.FillRect(Rect);

 XRect:=Rect;
    InflateRect( XRect, -4, -3 );
    inc(XRect.Bottom,4);
    if Active then
     inc(XRect.Left,4);

  OffsetRect(XRect,0,-1);
// InflateRect(XRect, -5, -5);
 //Control.Canvas.FillRect(XRect);
    Tab:=nil;
    for i:= 0 to (Control as TPageControl).PageCount - 1 do
    if (Control as TPageControl).Pages[i].TabIndex = TabIndex then
      begin
        Tab:=PageControl1.Pages[i];
        Break;
      end;

 //Tab:=PageControl1.Pages[TabIndex];
 Control.Canvas.Font.Color:=clBlack;
 s:=Tab.Caption;
 if (Tab=AnchorFont) and not IsFontCleared or (Tab=AnchorBorder) and not IsAllEdgeCleared or (Tab=AnchorBackground) and not IsImageCleared or (Tab=AnchorEffects) and not IsEffectsCleared or (Tab=AnchorMore) and not IsAllMoreCleared  then
  //s:=s+'*';
  Control.Canvas.Font.Style:=Control.Canvas.Font.Style+[fsUnderline];
 {if (Tab=AnchorFont) and IsFontCleared or (Tab=AnchorBorder) and IsAllEdgeCleared or (Tab=AnchorBackground) and IsImageCleared or (Tab=AnchorEffects) and IsEffectsCleared or (Tab=AnchorMore) and IsMoreCleared  then
  Control.Canvas.Font.Color:=ClearColor[true];  }
 {if Tab.PageIndex>=PAGE_STYLES then
 begin                    
  XRect2:=Rect;
  //dec(XRect2.Top);
  //dec(XRect2.Left);
  //dec(XRect2.Right);
  if active then
   dec(XRect2.Bottom,1) else
   inc(XRect2.Bottom,1);
  Control.Canvas.Brush.Color:=$EEEEEE;//clWhite;
  Control.Canvas.FillRect(XRect2);
  Control.Canvas.Font.Style:=[fsBold];
 end; }
 if Tab.PageIndex>=PAGE_STYLES then
  Control.Canvas.Font.Style:=[fsBold]{ else
  Control.Canvas.Font.Style:=[]};


 {if s='Edg' then s:='Edge';
 if s='Effecti' then s:='Effects';
 if s='Imag' then s:='Image';

 if (s='Effects') or (s='Image') then
  dec(XRect.Left,1); }

 inc(XRect.Right,5);
 //dec(XRect.Left,1);

 Control.Canvas.TextRect(XRect,XRect.Left,XRect.Top,s);
{ DrawText(Control.Canvas.Handle,
             PChar(s), length(s),
             XRect, DT_SINGLELINE or DT_LEFT or DT_TOP);
 }
 TabIndex:=3;
end;

procedure TPropsPC.AnchorTextShow(Sender: TObject);
begin
 UpdateTextDisplay;
end;

procedure TPropsPC.UpdateTextDisplay;
begin
 eText.StoredText:=(TObject(Selection[0]) as TdhLabel).Text;
end;


function TPropsPC.CommitChanges:boolean;     
var c:TControl;
begin
  result:=true;
  //c:=FindControl(GetFocus);
  if (MoreMisc<>nil) and MoreMisc.Visible then
   c:=MoreMisc.ActiveControl else
   c:=dhMainForm.ActiveControl;
  //if not Supports(c,IhCommitable) and (Screen.acti then

  if Supports(c,IhCommitable) then
   result:=(c as IhCommitable).Commit;
end;

procedure TPropsPC.AbortChanges;
var c:TControl;
begin
  //c:=FindControl(GetFocus);
  c:=dhMainForm.ActiveControl;
  if Supports(c,IhCommitable) then
   (c as IhCommitable).Abort;
end;


procedure TPropsPC.UpdatePageDisplay;
var IsVis:boolean;
begin
 eTitle.StoredText:=(TObject(Selection[0]) as TdhPage).Title;
 IsVis:=(TObject(Selection[0]) as TdhPage).IsTopBody;
 eOutputDirectory.Visible:=IsVis;
 dhLabel4.Visible:=IsVis;
 //Button2.Visible:=IsVis;
 if IsVis then
  eOutputDirectory.StoredText:=(TObject(Selection[0]) as TdhPage).OutputDirectory else
  eOutputDirectory.StoredText:='';
end;

procedure TPropsPC.AnchorPageShow(Sender: TObject);
begin
 UpdatePageDisplay;
end;

procedure TPropsPC.Button17Click(Sender: TObject);
begin
 LateCreateForm(TTransparencyWizard,TransparencyWizard);
 TransparencyWizard.Prepare(ActCommon);
 if TransparencyWizard.ShowModal=mrOk then
 begin
  with TObject(Selection[0]) as TdhCustomPanel do
   TransparencyWizard.GetBG(ActStyle.BackgroundImage,Width,Height);
  ActStyle.BackgroundRepeat:=TransparencyWizard.SampleGradient.Style.BackgroundRepeat;
  ActStyle.BackgroundPosition:=TransparencyWizard.SampleGradient.Style.BackgroundPosition;
  BackgroundChanged;
 end;
end;

procedure TPropsPC.cDynamicNavigationClick(Sender: TObject);
var gpc:TdhPageControl;
begin
 if Adjusting then exit;
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 gpc.DynamicNavigation:=cDynamicNavigation.Checked;
 Changed('Page Control');
end;

function TPropsPC.IsMoreCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
 with (TObject(Selection[i]) as TdhCustomPanel).ActStyle do
 result:=
  (VerticalAlign='') and (TextIndent='') and (TextAlign=Low(TCSSTextAlign)) and (Direction=Low(TCSSDirection)) and
  (Cursor=Low(TCSSCursor)) and (TextTransform=Low(TCSSTextTransform)) and (WhiteSpace=Low(TCSSWhiteSpace)) and (FontVariant=Low(TCSSFontVariant)) and
  (ZIndex=vsrInherit);
end;

function TPropsPC.IsMoreExtCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
 with (TObject(Selection[i]) as TdhCustomPanel).ActStyle do
 result:=(LineHeight='') and (Visibility=Low(TCSSVisibility)) and (ContentBefore='') and (ContentAfter='') and (Other='');
end;

function TPropsPC.IsAllMoreCleared:boolean;
begin
 result:=IsMoreCleared and IsMoreExtCleared;
end;

procedure TPropsPC.bClearMoreClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TdhCustomPanel).ActStyle do
 begin
  Cursor:=Low(TCSSCursor);
  ZIndex:=vsrInherit;
  Direction:=Low(TCSSDirection);

  VerticalAlign:='';
  TextIndent:='';
  TextAlign:=Low(TCSSTextAlign);

  TextTransform:=Low(TCSSTextTransform);
  WhiteSpace:=Low(TCSSWhiteSpace);
  FontVariant:=Low(TCSSFontVariant);
 end;
 Changed('Reset Misc');
 UpdateMoreDisplay;
end;

procedure TPropsPC.bClearEffectsClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Effects.Clear;
 Changed('Clear Effects');
 UpdateEffectsDisplay;
end;

procedure TPropsPC.mGotoUseClick(Sender: TObject);
var pn:TdhCustomPanel;
begin
 pn:=(TObject(Selection[0]) as TdhCustomPanel).Use as TdhCustomPanel;
 dhMainForm.Act.History{(nil,pn)};
 (TControl(Selection[0]).Owner as TPageContainer).MySiz.SetControlTo(pn,true,true);
end;

procedure TPropsPC.mGotoLinkClick(Sender: TObject);
var link:TdhLink;
begin
 link:=TObject(Selection[0]) as TdhLink;
 link.Click;
 (TControl(Selection[0]).Owner as TPageContainer).MySiz.SetControlTo(link.LinkPage,true,true);
end;

procedure TPropsPC.mGotoFragmentClick(Sender: TObject);
var link:TdhLink;
begin
 link:=TObject(Selection[0]) as TdhLink;
 link.Click;
 (TControl(Selection[0]).Owner as TPageContainer).MySiz.SetControlTo(link.LinkAnchor,true,true);
end;

procedure TPropsPC.rbSubmitButtonClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 //lt:=TLinkType(cbLinkType.ItemIndex);
 for i:=0 to Selection.Count-1 do
 with TObject(Selection[i]) as TdhFormButton do
 if rbSubmitButton.Checked then
  FormButtonType:=fbSubmit else
  FormButtonType:=fbReset;
 Changed('Form Button');
end;

procedure TPropsPC.AnchorFormButtonShow(Sender: TObject);
begin
 UpdateFormButtonDisplay;
end;

procedure TPropsPC.UpdateFormButtonDisplay;
var fb:TdhFormButton;
begin
 Adjusting:=true;
 fb:=(TObject(Selection[0]) as TdhFormButton);
 rbSubmitButton.Checked:=fb.FormButtonType=fbSubmit;
 rbResetButton.Checked:=not rbSubmitButton.Checked;
 cFormButtonLayout.ItemIndex:=Integer(fb.Layout);
{ rbFORMAUTO.Checked:=fb.Layout=ltAuto;
 rbFORMDIV.Checked:=fb.Layout=ltText;
 rbFORMLINK.Checked:=fb.Layout=ltLink;
 rbFORMBUTTON.Checked:=fb.Layout=ltButton;}
 Adjusting:=false;
end;

procedure TPropsPC.mStyleInfoClick(Sender: TObject);
begin
 LateCreateForm(TStyleInfo,StyleInfo);
 StyleInfo.Memo.Text:=(TObject(Selection[0]) as TdhCustomPanel).ActStyle.GetInfo;
 StyleInfo.ShowModal;
end;

procedure TPropsPC.AnchorFormShow(Sender: TObject);
begin
 UpdateFormDisplay;
end;

procedure TPropsPC.UpdateFormDisplay;
var form:TdhHTMLForm;
begin
 form:=TObject(Selection[0]) as TdhHTMLForm;
 eAction.StoredText:=form.Action;
 cbMethod.StoredItemIndex:=Integer(form.Method);
 eFormTarget.StoredText:=form.Target;
end;


procedure TPropsPC.cMemoReadOnlyClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhMemo).ReadOnly:=cMemoReadOnly.Checked;
  Changed('Memo');
end;

procedure TPropsPC.AnchorMemoShow(Sender: TObject);
begin         
 UpdateMemoDisplay;
end;

procedure TPropsPC.cPasswordClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhEdit).Password:=cPassword.Checked;
  Changed('Input Options');
end;

procedure TPropsPC.cWrapClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhMemo).Wrap:=cWrap.Checked;
  Changed('Edit Memo Options');
end;

procedure TPropsPC.PullStyles(Use:ICon; Clear:boolean);  
var i:integer;
begin
 if Clear then
  ClearAllStyles(true);
 repeat
  for i:=0 to Selection.Count-1 do
   Use.GetCommon.TransferStylesToElement(TObject(Selection[i]) as TdhCustomPanel);
  Use:=Use.GetCommon.Use;
 until Use=nil;

 StylesChanged;
 UpdateSel;
end;


procedure TPropsPC.Pullstylesfromelementinclipboard1Click(Sender: TObject);
var form:TForm;
    Use:ICon;
    i:integer;
begin
 form:=TForm.Create(nil);
 try
 GeneralPasteComponents(form,form,{nil,nil,}nil);
 Use:=nil;
 for i:=0 to form.ControlCount-1 do
 if form.Controls[i] is TdhCustomPanel then
 begin
  Use:=form.Controls[i] as TdhCustomPanel;
  break;
 end;

 if Use=nil then
 begin
  showmessage('No suitable element in clipboard');
  exit;
 end;

 PullStyles(Use,false);

 finally
  form.Free;
 end;
end;

procedure TPropsPC.cEffectsEnabledClick(Sender: TObject);
var tt: TTransformations;
    asked:boolean;
    i:integer;
begin        
 SetChildrenEnabled(PageControl2,cEffectsEnabled.Checked);
 if Adjusting then exit;
 if cEffectsEnabled.Checked then
 begin   
  for i:=0 to Selection.Count-1 do
  if not (TObject(Selection[i]) as TdhCustomPanel).EffectsAllowed then
  begin
   showmessage('Effects cannot be applied to this type of element');
   UpdateEffectsDisplay;
   exit;
  end;
  asked:=false;
  for i:=0 to Selection.Count-1 do
  with (TObject(Selection[i]) as TdhCustomPanel).ActStyle do
  begin
   if HasInheritedTransformations(tt) then
   begin
    if not asked then
    case MessageDlg('There exist inherited effects which are hidden now. Do you want to copy them?', mtConfirmation,[mbYes, mbNo], 0) of
    {idYes}mrYes: asked:=true;
    else exit;
    end;
    Effects.Assign(tt);
   end;
   Effects.Enabled:=true;
  end;
  if asked then
   UpdateEffectsDisplay;
 end;
 BuildTransformations;
end;

procedure TPropsPC.UpdateAlign;
var i,ii:integer;
    c:TControl;
    w:integer;
    lLock:boolean;
const NeedWhite:array[boolean] of TCSSBorderStyle=(cbsNone,cbsSolid);
const NeedTrans:array[boolean] of TColor=(clBlack,clBtnFace);
begin
 glLockWindowUpdate(true,lLock);
 dhMainForm.DisableAlign;
 try
 Align:=PropsAlign;
 bClearEffects.BringToFront;
 //PageControl1.MultiLine:=not(PropsAlign in [alTop,alBottom]);
 if PropsAlign in [alTop,alBottom] then
 begin            
{$IFDEF CLX}
  Height:=132;
{$ELSE}
  Height:=130;
{$ENDIF}
  PageControl1.TabWidth:=0;
  //PageControl1.Width:=790;
  //PageControl2.TabPosition:=tpLeft;
  PageControl2.ActivePage.Width:=493;
  PageControl2.ActivePage.Height:=100;
  pcnav_horz.Visible:=false;
  pcnav_vert.Visible:=true;
 end else
 begin
//  PageControl1.TabPosition:=tpLeft;
{$IFDEF CLX}
  Width:=230;
{$ELSE}   
  Width:=224;
{$ENDIF}
  //PageControl1.TabWidth:=70;
  PageControl1.RaggedRight:=true;

{$IFNDEF CLX}    
  PageControl1.ScrollOpposite:=false;
{$ENDIF}
  //PageControl2.TabPosition:=tpTop;
  PageControl2.ActivePage.Width:=210;
  PageControl2.ActivePage.Height:=220;
  //PageControl1.Width:=224;
  pcnav_horz.Visible:=true;
  pcnav_vert.Visible:=false;
 end;
 Panel1.Style.BorderLeft.Style:=NeedWhite[PropsAlign=alRight];
 Panel1.Style.BorderRight.Style:=NeedWhite[PropsAlign=alLeft];
 //Panel4.Style.BorderRight.Color:=NeedTrans[PropsAlign in [alTop,alBottom]];
 //Panel4.Style.BorderBottom.Color:=NeedTrans[PropsAlign in [alLeft,alRight]];
 for ii:=0 to PageControl1.PageCount-1 do
 begin
 if PropsAlign in [alTop,alBottom] then
  w:=5 else
  w:=5;
 for i:=0 to PageControl1.Pages[ii].ControlCount-1 do
 begin
  c:=PageControl1.Pages[ii].Controls[i];
  if (c is TdhPageControl) or not c.Visible then continue;
  if PropsAlign in [alTop,alBottom] then
  begin
   {if (c is TButton) and (TButton(c).Caption='Reset') then
   begin
    c.Left:=c.Parent.Width-c.Width-1;
    c.Top:=0;
   end else }
   begin
    c.Left:=w;
    if (c is TGroupBox) or (c is TRadioGroup) or (c is TPageControl) or (c=pcnav_vert) or (c=TabSheet7) or (c=TabSheet3) or (c=TabSheet8) then
     c.Top:=0 else
     c.Top:=5;
    inc(w,c.Width+7);
    if c=pcnav_vert then
     dec(w,8);
   end;
  end else
  begin          
   {if (c is TButton) and (TButton(c).Caption='Reset') then
   begin
    c.Top:=c.Parent.Height-c.Height-1;
    c.Left:=0;
   end else  }
   begin
    c.Top:=w;
    c.Left:=3;
    inc(w,c.Height+5);
    if c=pcnav_horz then
     dec(w,6);
   end;
  end;
 end;
 end;


 if PropsAlign in [alTop,alBottom] then
 begin
  //PageControl2.ActivePage.Top:=-8;
  Panel3.Top:=2;
  Panel3.Left:=256;
  Panel31.Top:=2;
  Panel31.Left:=26;
  Panel5.Top:=2;
  Panel5.Left:=264;
  TabControl1.Top:=4;
 end else
 begin
  Panel3.Top:=107;
  Panel3.Left:=8;  
  Panel31.Top:=15;
  Panel31.Left:=8;
  Panel5.Top:=108;
  Panel5.Left:=10;
  TabControl1.Top:=11;
 end;


  //InvalTrans(Panel4,InvRect);
  //Panel4.Style.ZIndex:=3;

 finally
  dhMainForm.EnableAlign;
  glLockWindowUpdate(false,lLock);
 end;
end;

procedure TPropsPC.mPagePropertiesClick(Sender: TObject);
begin
 EditPageProperties(TObject(Selection[0]) as TdhPage);
end;

procedure TPropsPC.EditPageProperties;
begin
 if not CommitChanges then exit;
 LateCreateForm(TPageWizard,PageWizard);
 if PageWizard.Prepare(page) then
 begin
  if PageControl1.ActivePage=AnchorPage then
   UpdatePageDisplay;
  Changed('Edit Page Properties');
 end;
end;


procedure TPropsPC.mOleClick(Sender: TObject);
begin      
// (TObject(Selection[0]) as TOleContainer).InsertObjectDialog;       

{$IFNDEF CLX}                 
 if (TObject(Selection[0]) as TdhOleContainer).InsertObjectDialog(true) then
  (TObject(Selection[0]) as TdhOleContainer).EditInPlace;
{$ENDIF}
end;

procedure TPropsPC.AnchorHiddenShow(Sender: TObject);
begin
 UpdateHiddenFieldDisplay;
end;

procedure TPropsPC.UpdateHiddenFieldDisplay;
begin
  eHiddenField.StoredText:=(TObject(Selection[0]) as TdhHiddenField).Value;
end;


procedure TPropsPC.Button2Click(Sender: TObject);
begin                                

{$IFNDEF CLX}                        
 if (TObject(Selection[0]) as TdhOleContainer).InsertObjectDialog(true) then
  (TObject(Selection[0]) as TdhOleContainer).EditInPlace;
{$ENDIF}
end;

procedure TPropsPC.Button4Click(Sender: TObject);
begin                                            

{$IFNDEF CLX}                    
 if (TObject(Selection[0]) as TdhOleContainer).InsertObjectDialog(true) then
  (TObject(Selection[0]) as TdhOleContainer).ObjectPropertiesDialog;
{$ENDIF}
end;

procedure TPropsPC.LoadImageExt(URL: String; pn: TdhCustomPanel);
begin
  (pn.Owner as TPageContainer).MySiz.SetControlTo(pn,true,true);
  LoadImage(URL);
  {pn.FCommon.ActStyle.LoadImage(URL);
  Changed('bg-image');
  if PageControl1.ActivePage=AnchorBackground then BackgroundChanged; }
end;

procedure TPropsPC.dhPanel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 //if dhPanel1.Style.BackgroundImage.Graphic<>nil then
 if Button=mbRight then
 begin
  mSaveImageToFile.Enabled:=dhPanel1.Style.BackgroundImage.Graphic<>nil;
  mChangeColors.Enabled:=mSaveImageToFile.Enabled;
  PopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
 end;
end;

procedure TPropsPC.mChangeColorsClick(Sender: TObject);
begin
 LateCreateForm(TColorizeImg,ColorizeImg);
 if ColorizeImg.Prepare(dhPanel1.Style.BackgroundImage.Graphic,(TObject(Selection[0]) as TdhCustomPanel).GetVirtualBGColor) then
 begin
  with TObject(Selection[0]) as TdhCustomPanel do
   ColorizeImg.GetBG(ActStyle.BackgroundImage);
  BackgroundChanged;
 end;
end;



procedure TPropsPC.TabControl2Change(Sender: TObject);
begin
 CommitChanges;
 EdgeAlign:=guiEdgesAlign[TabControl2.TabIndex];
 UpdateBorderDisplay;
 bClearEdge.Caption:=guiEdgesS[TabControl2.TabIndex];
end;

procedure TPropsPC.TabControl2DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var XRect:TRect;
    s:String;
    IsCleared:boolean;
begin


 Control.Canvas.FillRect(Rect);

 XRect:=Rect;
//    InflateRect( XRect, -4, -3 );
    //inc(XRect.Bottom,4);  
    dec(XRect.Top,1);

 {if not Active or true then
  OffsetRect(XRect,4,0) else
  OffsetRect(XRect,15,0);  }
  if not Active then
  OffsetRect(XRect,7,-1) else
  OffsetRect(XRect,8,0);
    {if Active then
     inc(XRect.Left,2);
    if Active then
     inc(XRect.Top,2);  }

 s:=(Control as TTabControl).Tabs[TabIndex]{$IFDEF CLX}.Caption{$ENDIF};

 {if Active then
  s:='> '+s;  }


 if Control=TabControl2 then
  IsCleared:=IsEdgeCleared(guiEdgesAlign[TabIndex]) else
  IsCleared:=not getblur(ActStyle.Effects,TabIndex).Enabled{IsCleared};
 if not IsCleared then
  //s:=s+'*';
  Control.Canvas.Font.Style:=Control.Canvas.Font.Style+[fsUnderline];
 //Control.Canvas.Font.Color:=ClearColor[IsCleared];


 Control.Canvas.TextRect(XRect,XRect.Left,XRect.Top,s);
// DrawText(Control.Canvas.Handle,PChar(s),length(s), XRect, DT_SINGLELINE or DT_LEFT or DT_TOP);


end;

procedure TPropsPC.cTransparentWhiteClick(Sender: TObject);
begin               
{$IFNDEF CLX}                                    
 (TObject(Selection[0]) as TdhOleContainer).TransparentWhite:=cTransparentWhite.Checked;
{$ENDIF}
end;

procedure TPropsPC.AnchorOleShow(Sender: TObject);
begin
 UpdateOLEDisplay;
end;

procedure TPropsPC.UpdateOLEDisplay;
begin
{$IFNDEF CLX}                                      
 cTransparentWhite.Checked:=(TObject(Selection[0]) as TdhOleContainer).TransparentWhite;
{$ENDIF}
end;


procedure TPropsPC.CopyImage1Click(Sender: TObject);
begin
// (dhPanel1.Style.BackgroundImage.Graphic as TGifImage).SaveToClipboardFormat();
end;

procedure TPropsPC.mSaveImageToFileClick(Sender: TObject);
var i,FilterIndex:integer;
begin
 i:=Pos(GetGraphicExtension(dhPanel1.Style.BackgroundImage.Graphic),SavePictureDialog1.Filter);
 FilterIndex:=0;
 for i:=i downto 1 do
 if SavePictureDialog1.Filter[i]='|' then
  inc(FilterIndex);
 SavePictureDialog1.FilterIndex:=FilterIndex div 2 + 1;

 if SavePictureDialog1.Execute then
 begin
  SaveGraphic(dhPanel1.Style.BackgroundImage.Graphic,SavePictureDialog1.FileName);
 end;
end;

procedure TPropsPC.vsClick(Sender: TObject);
var i,OffsetY:integer;
    Page:TdhPage;
var gpc:TdhPageControl;
begin
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 if {vs.FocusedNode=nil}vs.ItemIndex<0 then exit;
 page:=gpc.Pages[{vs.FocusedNode.Index}vs.ItemIndex];
 if page=gpc.ActivePage then exit;    
// OffsetY:=vs.OffsetY;
 gpc.ActivePage:=page;
 (gpc.Owner as TPageContainer).MySiz.SetControlTo(gpc.Pages[{vs.FocusedNode.Index}vs.ItemIndex],true,true);
// vs.OffsetY:=OffsetY;
 vs.SetFocus;

end;

procedure TPropsPC.Loaded;
begin
  inherited;
  dhStyleSheet1.Visible:=False;
end;

procedure TPropsPC.AdjustClientRect(var Rect: TRect);
begin
  //do nothing, prevent TScrollingWinControl.AdjustClientRect
end;

procedure TPropsPC.rbFORMDIVClick(Sender: TObject);
var i:integer;
//    c:TComponent;
//    lt:TLinkType;
begin
 //lt:=TLinkType(cbLinkType.ItemIndex);
{ if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
 with TObject(Selection[i]) as TdhFormButton do
 if rbFORMAUTO.Checked then
  Layout:=ltAuto else
 if rbFORMDIV.Checked then
  Layout:=ltText else
 if rbFORMLINK.Checked then
  Layout:=ltLink else
 if rbFORMBUTTON.Checked then
  Layout:=ltButton;
 Changed('Form Button Layout'); }
end;

procedure TPropsPC.cbCursorDropDown(Sender: TObject);
begin
{$IFNDEF CLX}
 SendMessage(cbCursor.Handle, CB_SETDROPPEDWIDTH, 110, 0);
{$ENDIF}
end;

procedure TPropsPC.cSlideClick(Sender: TObject);
begin               
 if Adjusting then exit;
 MenuChanged;
 Changed('Sliding');
end;

procedure TPropsPC.cOpenByOverClick(Sender: TObject);
begin
 if Adjusting then exit;
 MenuChanged;
 Changed('Popup Delay');
end;

procedure TPropsPC.bBorderRadiusClick(Sender: TObject);
var sBorderRadius:TCSSBorderRadius;
begin
 LateCreateForm(TBorderRadiusWizard,BorderRadiusWizard);
 sBorderRadius:=TCSSBorderRadius.Create(nil);
 try
 sBorderRadius.Assign(ActStyle.BorderRadius);
 BorderRadiusWizard.Prepare(self.ActStyle);
 if BorderRadiusWizard.ShowModal=mrOk then
 begin             
  PageControl1.Invalidate; //see SetClearState
  LiveBorderChanged;
  Changed('Change Border-Radius');
 end else
 begin
  ActStyle.BorderRadius.Assign(sBorderRadius);
 end;
 finally
  sBorderRadius.Free;
 end;
end;

procedure TPropsPC.spMarginValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.SetMargin(EdgeAlign,_if(Clear,MarginDefault,IntToStr(spMargin.Value)));
 LiveBorderChanged;
end;

procedure TPropsPC.spPaddingValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.SetPadding(EdgeAlign,_if(Clear,vsrInherit,spPadding.Value));
 LiveBorderChanged;
end;

procedure TPropsPC.spBorderValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.Borders[EdgeAlign].Width:=_if(Clear,vsrInherit,spBorder.Value);
 LiveBorderChanged;
end;

procedure TPropsPC.spBGXValueChange(Sender: TObject; Clear: Boolean);
begin
 BuildBGPos(Clear);
end;

procedure TPropsPC.spLeftValueChange(Sender: TObject; Clear: Boolean);
begin
 LivePositionChanged(Sender);
end;

procedure TPropsPC.spSkewXValueChange(Sender: TObject; Clear: Boolean);
begin     
 LiveBuildTransformations;
end;

procedure TPropsPC.LogChange(Sender: TObject; LogChange: TLogChange);
begin
 if Sender is TMySpinEdit then
  Changed((Sender as TMySpinEdit).ChangeReason,LogChange) else
 if Sender is ThMemo then
  Changed((Sender as ThMemo).ChangeReason,LogChange) else
 if Sender is ThComboBox then
  Changed((Sender as ThComboBox).ChangeReason,LogChange) else
 if Sender is ThCheckBox then
  Changed((Sender as ThCheckBox).ChangeReason,LogChange) else
  Changed((Sender as ThEdit).ChangeReason,LogChange);
end;

procedure TPropsPC.eTextValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhLabel).Text:=eText.Text;
end;

procedure TPropsPC.eEditValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhEdit).Text:=eEdit.Text;
end;

procedure TPropsPC.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin     
 AllowChange:=CommitChanges;
end;

procedure TPropsPC.eNameValueChange(Sender: TObject; Clear: Boolean);
begin
  (TObject(Selection[0]) as TControl).Name:=eName.Text;
  dhMainForm.UpdateNames;
  UpdateNameDisplay;
end;

procedure TPropsPC.eTitleValueChange(Sender: TObject; Clear: Boolean);
begin
  (TObject(Selection[0]) as TdhPage).Title:=eTitle.Text;
end;

procedure TPropsPC.eOutputDirectoryValueChange(Sender: TObject;
  Clear: Boolean);
begin
  (TObject(Selection[0]) as TdhPage).OutputDirectory:=eOutputDirectory.Text;
end;

procedure TPropsPC.eComboBoxTargetValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhComboBox).Target:=eComboBoxTarget.Text;
end;

procedure TPropsPC.eActionValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhHTMLForm).Action:=eAction.Text;
end;

procedure TPropsPC.eHiddenFieldValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhHiddenField).Value:=eHiddenField.Text;
end;

procedure TPropsPC.eMemoValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhMemo).Lines.Text:=eMemo.Text;
end;

procedure TPropsPC.eComboBoxValueChange(Sender: TObject; Clear: Boolean);
var i,sItemIndex:integer;
begin
  for i:=0 to Selection.Count-1 do
  with (TObject(Selection[i]) as TdhComboBox) do
  begin
   sItemIndex:=ItemIndex;
   Items.Text:=eComboBox.Text;
   ItemIndex:=sItemIndex;
  end;
  dhMainForm.Act.MySiz.DoInval(false);
  UpdateComboBoxDisplay(true);
end;

procedure TPropsPC.eListBoxValueChange(Sender: TObject; Clear: Boolean);
var i,sItemIndex:integer;
begin
  for i:=0 to Selection.Count-1 do
  with (TObject(Selection[i]) as TdhListBox) do
  begin
   sItemIndex:=ItemIndex;
   Items.Text:=eListBox.Text;
   ItemIndex:=sItemIndex;
  end;
  dhMainForm.Act.MySiz.DoInval(false);
  UpdateListBoxDisplay(true);
end;

procedure TPropsPC.eHTMLAttributesValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
  if TObject(Selection[i]) is TdhCustomPanel then
   (TObject(Selection[i]) as TdhCustomPanel).HTMLAttributes:=eHTMLAttributes.Text;
  UpdateNameDisplay;
end;

procedure TPropsPC.eFormTargetValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhHTMLForm).Target:=eFormTarget.Text;
end;

function IncludeClear(Clear:Boolean; Value:integer): integer;
begin
 if Clear then
  result:=0 else
  result:=Value+1;
end;


procedure TPropsPC.dhComboBox1ValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.Borders[EdgeAlign].Style:=TCSSBorderStyle(IncludeClear(Clear,dhComboBox1.ItemIndex));
 LiveBorderChanged;
end;

procedure TPropsPC.cbTextIndentValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.TextIndent:=WithoutPx(GoodValue(cbTextIndent.Text));
 UpdateMoreDisplay;
end;

procedure TPropsPC.cbVerticalAlignValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.VerticalAlign:=WithoutPx(GoodValue(cbVerticalAlign.Text));
 UpdateMoreDisplay;
end;

procedure TPropsPC.cbZIndexValueChange(Sender: TObject; Clear: Boolean);
var i,ZIndex:integer;
begin
 if cbZIndex.Text='' then
  ZIndex:=vsrInherit else
  ZIndex:=strtoint(cbZIndex.Text);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.ZIndex:=ZIndex;
 UpdateMoreDisplay;
end;

procedure TPropsPC.eLinkValueChange(Sender: TObject; Clear: Boolean);
var NewLink:String;
    i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhLink).Link:=eLink.Text;
  UpdateLinkDisplay;
end;

procedure TPropsPC.eTargetValueChange(Sender: TObject; Clear: Boolean);
var NewLink:String;
    i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhLink).Target:=eTarget.Text;
  UpdateLinkDisplay;
end;

procedure TPropsPC.ComboBox1ValueChange(Sender: TObject; Clear: Boolean);
var sIndex:integer;
begin
 sIndex:=ComboBox1.ItemIndex;
 (TObject(Selection[0]) as TdhCustomPanel).ImageType:=TImageType(IncludeClear(Clear,ComboBox1.ItemIndex));
 LiveBackgroundChanged;
 if sIndex<>ComboBox1.ItemIndex then
  raise Exception.Create('Not supported value for this type of object');
  //showmessage('Not supported value for the type of object');
end;

procedure TPropsPC.dhComboBox4ValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.BackgroundRepeat:=TCSSBackgroundRepeat(IncludeClear(Clear,dhComboBox4.ItemIndex));
 LiveBackgroundChanged;
end;

procedure TPropsPC.cbCursorValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 cbCursor.ItemIndex:=GoodIndex(cbCursor.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Cursor:=TCSSCursor(GoodIndexBack(cbCursor.ItemIndex));
 UpdateMoreDisplay;
end;

procedure TPropsPC.cbDirectionValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 cbDirection.ItemIndex:=GoodIndex(cbDirection.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Direction:=TCSSDirection(GoodIndexBack(cbDirection.ItemIndex));
 UpdateMoreDisplay;
end;

procedure TPropsPC.cbTextAlignValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 cbTextAlign.ItemIndex:=GoodIndex(cbTextAlign.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.TextAlign:=TCSSTextAlign(GoodIndexBack(cbTextAlign.ItemIndex));
 UpdateMoreDisplay;
end;

procedure TPropsPC.cbTextTransformValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 cbTextTransform.ItemIndex:=GoodIndex(cbTextTransform.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.TextTransform:=TCSSTextTransform(GoodIndexBack(cbTextTransform.ItemIndex));
 UpdateMoreDisplay;    
end;

procedure TPropsPC.cbWhiteSpaceValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 cbWhiteSpace.ItemIndex:=GoodIndex(cbWhiteSpace.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.WhiteSpace:=TCSSWhiteSpace(GoodIndexBack(cbWhiteSpace.ItemIndex));
 UpdateMoreDisplay; 
end;

procedure TPropsPC.cbFontVariantValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 cbFontVariant.ItemIndex:=GoodIndex(cbFontVariant.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.FontVariant:=TCSSFontVariant(GoodIndexBack(cbFontVariant.ItemIndex));
 UpdateMoreDisplay;
end;

procedure TPropsPC.cbUseValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
    c:TComponent;
begin
 c:=dhMainForm.Act.FindComponent(cbUse.Text);
 if not((cbUse.Text<>'') and (c=nil) and (ActPn.SUse=cbUse.Text)) then
 begin
  if (cbUse.Text<>'') and  (cbUse.Items.IndexOf(cbUse.Text)=-1){not (c is TdhCustomPanel)} then
   raise Exception.Create('Invalid value.');
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCustomPanel).Use:=(c as TdhCustomPanel);
 end;
 UpdateStylesDisplay;
end;

procedure TPropsPC.dhComboBox2ValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  dhComboBox2.ItemIndex:=GoodIndex(dhComboBox2.ItemIndex);
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhComboBox).ItemIndex:=GoodIndexBack(dhComboBox2.ItemIndex)-1;
  dhMainForm.Act.MySiz.DoInval(false);
end;

procedure TPropsPC.dhComboBox3ValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  dhComboBox3.ItemIndex:=GoodIndex(dhComboBox3.ItemIndex);
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhListBox).ItemIndex:=GoodIndexBack(dhComboBox3.ItemIndex)-1;
  dhMainForm.Act.MySiz.DoInval(false);    
end;

procedure TPropsPC.cbMethodValueChange(Sender: TObject; Clear: Boolean); 
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhHTMLForm).Method:=TFormMethod(cbMethod.ItemIndex);
end;

procedure TPropsPC.spReactionTimeValueChange(Sender: TObject;
  Clear: Boolean);
begin       
 MenuChanged;
end;

procedure TPropsPC.cbLinkPageValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
    c:TComponent;
    cb:TComboBox;
begin
 cb:=Sender as TComboBox;
 c:=dhMainForm.Act.FindComponent(cb.Text);
 
 if not((cb.Text<>'') and (c=nil) and ((cb=cbLinkPage) and ((ActPn as TdhLink).SLinkPage=cb.Text) or (cb=cbLinkAnchor) and ((ActPn as TdhLink).SLinkAnchor=cb.Text))) then
 begin
 if (cb.Text<>'') and (cb.Items.IndexOf(cb.Text)=-1){((cb=cbLinkPage) and not (c is TdhPage) or (cb=cbLinkAnchor) and (cb=nil))} then
  raise Exception.Create('Invalid value.');
 for i:=0 to Selection.Count-1 do
 if cb=cbLinkPage then
  (TObject(Selection[i]) as TdhLink).LinkPage:=c as TdhPage else
  (TObject(Selection[i]) as TdhLink).LinkAnchor:=c as TdhCustomPanel;
 end;
 UpdateLinkDisplay;
end;

procedure TPropsPC.cBGFixedValueChange(Sender: TObject; Clear: Boolean);
const GetBGFixed:array[boolean] of TCSSBackgroundAttachment=(cbaScroll,cbaFixed);
begin
 if Clear then
  ActStyle.BackgroundAttachment:=Low(TCSSBackgroundAttachment) else
  ActStyle.BackgroundAttachment:=GetBGFixed[cBGFixed.Checked];
 LiveBackgroundChanged;
end;

procedure TPropsPC.cLinkLayoutClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhLink).Layout:=TLinkType(cLinkLayout.ItemIndex);
 LinkChanged;
end;

procedure TPropsPC.cFormButtonLayoutClick(Sender: TObject);    
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhFormButton).Layout:=TLinkType(cFormButtonLayout.ItemIndex);    
 Changed('Form Button Layout'); 
end;

procedure TPropsPC.cHorizontalLayoutClick(Sender: TObject);
begin                
 if Adjusting then exit;
 MenuChanged;
 Changed('Menu');
end;

procedure TPropsPC.cbParentMenuItemValueChange(Sender: TObject;
  Clear: Boolean);
var c:TComponent;
begin     
 cbParentMenuItem.ItemIndex:=GoodIndex(cbParentMenuItem.ItemIndex);
 c:=dhMainForm.Act.FindComponent(cbParentMenuItem.Text);
 if (c is TdhLink) or (c=nil) and (cbParentMenuItem.Text='') then
  (TObject(Selection[0]) as TdhMenu).ParentMenuItem:=TdhLink(c);
 MenuChanged;
end;

procedure TPropsPC.ExchangeDownandOverStyles1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).FCommon.ExchangeDownOverStyles;
 StylesChanged;
 UpdateSel;
end;

function TPropsPC.GetSelectionBounds:TRect;
var i,w:integer;
begin
 result:=Rect(maxint,maxint,-maxint,-maxint);
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TControl).BoundsRect do
 begin
  Result.Left:=Min(Result.Left,Left);
  Result.Top:=Min(Result.Top,Top);
  Result.Bottom:=Max(Result.Bottom,Bottom);
  Result.Right:=Max(Result.Right,Right);
 end;
end;


procedure TPropsPC.mLeftEdgesClick(Sender: TObject);
var i:integer;
    al:TEdgeAlign;
    r:TRect;
begin
 r:=GetSelectionBounds;
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TControl) do 
 if Sender=mLeftEdges then
  Left:=r.Left else
 if Sender=mRightEdges then
  Left:=r.Right-Width else
 if Sender=mTopEdges then
  Top:=r.Top else
 if Sender=mBottomEdges then
  Top:=r.Bottom-Height;
 Changed((Sender as TMenuItem).Caption);
 ActBoundsChanged;
end;

function SortHorz(Item1, Item2: Pointer): Integer;
begin
 Result:=TControl(Item1).Left-TControl(Item2).Left;
end;

function SortVert(Item1, Item2: Pointer): Integer;
begin
 Result:=TControl(Item1).Top-TControl(Item2).Top;
end;

procedure TPropsPC.mEqualHorizontalClick(Sender: TObject);
var i,w:integer;
    spacing,d:double;
    SortedSel:TBinList;
begin
 w:=0;
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TControl) do
 if Sender=mEqualHorizontal then
  Inc(w,Width) else
  Inc(w,Height);
 if Selection.Count=1 then
  spacing:=0 else
 if Sender=mEqualHorizontal then
  spacing:=(GetSelectionBounds.Right-GetSelectionBounds.Left-w)/(Selection.Count-1) else
  spacing:=(GetSelectionBounds.Bottom-GetSelectionBounds.Top-w)/(Selection.Count-1);
 SortedSel:=TBinList.Create;
 try                    
  for i:=Selection.Count-1 downto 0 do  
  if Sender=mEqualHorizontal then
   SortedSel.AddItem(SortHorz,Selection[i]) else
   SortedSel.AddItem(SortVert,Selection[i]);
  {SortedSel.Assign(Selection);
  if Sender=mEqualHorizontal then
   SortedSel.Sort(SortHorz) else
   SortedSel.Sort(SortVert);  }
  if Sender=mEqualHorizontal then
   d:=GetSelectionBounds.Left else
   d:=GetSelectionBounds.Top;
  for i:=0 to Selection.Count-1 do
  with TControl(SortedSel[i]) do
  begin         
   if Sender=mEqualHorizontal then
    Left:=Round(d) else
    Top:=Round(d);
   if Sender=mEqualHorizontal then
    d:=d+Width else
    d:=d+Height;
   d:=d+spacing;
  end;
 finally
  SortedSel.Free;
 end;     
 Changed((Sender as TMenuItem).Caption);
 ActBoundsChanged;
end;

procedure TPropsPC.LoadfromHTTPaddress1Click(Sender: TObject);
var s:string;
begin
 s:='http://';
 if InputQuery('Load from HTTP address', 'HTTP URL:',s) then
  dhMainForm.ImageFromURL(s,nil);
end;

procedure TPropsPC.bMoreMiscClick(Sender: TObject);
begin
 LateCreateForm(TMoreMisc,MoreMisc);
 MoreMisc.Prepare;
 MoreMisc.ShowModal; 
end;

procedure TPropsPC.fasdfClick(Sender: TObject);
begin
  (TObject(Selection[0]) as TControl).Width:=100;
end;

procedure TPropsPC.SetAdjusting(Value: boolean);
begin
 FAdjusting:=Value;
end;

procedure TPropsPC.AnchorSelectShow(Sender: TObject);
begin
 UpdateSelectDisplay;
end;

procedure TPropsPC.UpdateSelectDisplay;
var index:integer;
    select:TdhSelect;
begin
 if Adjusting then exit;
 select:=(ActPn as TdhSelect);

 Adjusting:=true;
 cMenu.Checked:=select.SelectType=stMenu;
 cList.Checked:=select.SelectType=stList;
 cMultiple.Checked:=select.Multiple;

 index:=max(dhSelect1.SelectedIndex,0);
 dhSelect1.Items.Assign(select.Items);
 if dhSelect1.Count>=1 then
 if index<=dhSelect1.Count-1 then
  dhSelect1.Items[index].BeTheOnlySelection else
 if 0<=dhSelect1.Count-1 then
  dhSelect1.Items[0].BeTheOnlySelection;
 Adjusting:=false;
 
 dhSelect1Click(nil);
end;


procedure TPropsPC.PushstylestoUseelement1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).FCommon.TransferStylesToUse;
 StylesChanged;
 UpdateSel;
end;

procedure TPropsPC.Button5Click(Sender: TObject);
begin
 (ActPn as TdhSelect).Items.Add;
 UpdateAllSelects;
 dhSelect1.Items[dhSelect1.Count-1].BeTheOnlySelection;
 eSelectLabel.SetFocus;     
 Changed('Add Item');
end;

procedure TPropsPC.UpdateAllSelects;
var i:integer;
begin
 for i:=1 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhSelect).Items.Assign((ActPn as TdhSelect).Items);
 UpdateSelectDisplay;
end;


procedure TPropsPC.bDeleteItemClick(Sender: TObject);
var index:integer;
begin
 (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex].Free;
 index:=dhSelect1.SelectedIndex;
 UpdateAllSelects;
 if (index=dhSelect1.Count) and (index-1>=0) then
  dhSelect1.Items[index-1].Selected:=true;
 Changed('Delete Item');
end;

procedure TPropsPC.Clearallstyles1Click(Sender: TObject);
begin          
 ClearAllStyles(false);
 StylesChanged;
 UpdateSel;
end;

procedure TPropsPC.PullstylesfromUseelement1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).FCommon.GetStylesFromUse;
 StylesChanged;
 UpdateSel;
end;

procedure TPropsPC.bMoveItemUpClick(Sender: TObject);
begin
 with (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex] do
  Index:=Index-1;
 UpdateAllSelects;                   
 dhSelect1.Items[dhSelect1.SelectedIndex-1].Selected:=true;
 Changed('Move Item Up');
end;

procedure TPropsPC.eSelectLabelValueChange(Sender: TObject;
  Clear: Boolean);
begin
 (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex].Text:=eSelectLabel.Text;
 UpdateAllSelects;
end;

procedure TPropsPC.eSelectValueValueChange(Sender: TObject;
  Clear: Boolean);
begin
 (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex].Value:=eSelectValue.Text;
 UpdateAllSelects;
end;

procedure TPropsPC.cSelectSelectedClick(Sender: TObject);
begin
 if Adjusting then exit;
 (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex].Selected:=cSelectSelected.Checked;
 UpdateAllSelects;
end;

procedure TPropsPC.dhSelect1Click(Sender: TObject);
begin
 if Adjusting then exit;
 Adjusting:=(sender=nil) or true;
 SetChildrenEnabled(GroupBox12,dhSelect1.SelectedIndex<>-1);
 bDeleteItem.Enabled:=dhSelect1.SelectedIndex<>-1;
 bMoveItemUp.Enabled:=dhSelect1.SelectedIndex-1>=0;
 bMoveItemDown.Enabled:=dhSelect1.SelectedIndex+1<=dhSelect1.Count-1;
 if dhSelect1.SelectedIndex<>-1 then
 with (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex] do
 begin
  eSelectLabel.StoredText:=Text;
  eSelectValue.StoredText:=Value;
  cSelectSelected.Checked:=Selected;
 end else
 begin 
  eSelectLabel.StoredText:='';
  eSelectValue.StoredText:='';
  cSelectSelected.Checked:=false;
 end;
 Adjusting:=false;
end;

procedure TPropsPC.cMultipleClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhSelect).Multiple:=cMultiple.Checked;
 UpdateSelectDisplay;
 Changed('Multiple Selection');
end;

procedure TPropsPC.cMenuClick(Sender: TObject);
var i:integer;
const bSelectType:array[boolean] of TSelectType=(stMenu,stList);
begin
 cMultiple.Enabled:=cList.Checked;
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhSelect).SelectType:=bSelectType[cList.Checked]; 
 UpdateSelectDisplay;
 Changed('Select Type');
end;

procedure TPropsPC.bMoveItemDownClick(Sender: TObject);
var i:integer;
begin
 with (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex] do
  Index:=Index+1;
 UpdateAllSelects;
 dhSelect1.Items[dhSelect1.SelectedIndex+1].Selected:=true;
 Changed('Move Item Down');
end;

procedure TPropsPC.dhSelect1GetDisplayText(Sender: TObject;
  Item: TSelectOption; var DisplayText: String);
begin
 if (ActPn as TdhSelect).Items[Item.Index].Selected then
  DisplayText:=DisplayText+'<small> (selected)</small>';
end;

procedure TPropsPC.eCheckValueValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCheckBox).Value:=eCheckValue.Text;
end;

procedure TPropsPC.cFontFamilyValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 if Adjusting then exit;
 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
  if TObject(Selection[i]) is TdhCustomPanel then
  begin
   if Clear then
    TdhCustomPanel(TObject(Selection[i])).ActStyle.FontFamily:='' else
    TdhCustomPanel(TObject(Selection[i])).ActStyle.FontFamily:=cFontFamily.Text
  end else
   TFakeControl(Selection[i]).Font.Name:=GetNearestFont(cFontFamily.Text);
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdateFontDisplay;
end;

procedure TPropsPC.cFontSizeValueChange(Sender: TObject; Clear: Boolean);
var i,fs:integer;
begin
 if Adjusting then exit;
 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
  if TObject(Selection[i]) is TdhCustomPanel then
  begin
   if Clear then
    TdhCustomPanel(TObject(Selection[i])).ActStyle.FontSize:='' else
    TdhCustomPanel(TObject(Selection[i])).ActStyle.FontSize:=cFontSize.Text;
  end else
  if TryStrToInt(cFontSize.Text,fs) then
   TFakeControl(Selection[i]).Font.Height:=-fs;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdateFontDisplay;
end;

end.



