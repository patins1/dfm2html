unit Unit2;

interface

uses
  SysUtils, Classes, TypInfo,
{$IFDEF CLX}
  QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls, QComCtrls,
  QStdCtrls, QImgList, QMenus, QStyle,  QTntStdCtrls,
{$ELSE}
  Controls, Forms, Windows, Messages, Graphics, Dialogs, ExtDlgs, ExtCtrls, clipbrd, Buttons, JPeg,
  ComCtrls, CommCtrl, StdCtrls, ShellAPI, RTLConsts,  Menus,
  Mask, ToolWin, ImgList, AppEvnts, Spin, UnicodeCtrls,
{$ENDIF}
   Generics.Defaults,Generics.Collections,
   uChooseWide,
   dhLabel,
   dhPanel,

  dhPageControl, dhStyleSheet, dhMenu,
  math, Unit3, funcutils, uGradientWizard, dhDirectHTML,
  dhEdit, dhMemo, dhCheckBox,dhHTMLForm, dhFileField,
  dhColorPicker, OpenSave,
  dhMultilineCaptionEdit, dhRadioButton,
  hComboBox, hEdit, hMemo,
  dhOleContainer,dhFile,dhHiddenField,GR32,
  MyPageControl, MyFontDialog,
  MySpinEdit, MyTrackBar, hCheckBox, dhSelect, UseFastStrings, DKLang,UIConstants,
  MyGroupBox, MyPanel, MyForm, Contnrs, dhStrUtils, uMetaWriter, dhStyles,dhGraphicFormats,dhColorUtils,
  SynEditHighlighter, SynHighlighterHtml, SynEdit, SynMemo, hSynMemo;


var PropsAlign:TAlign=alBottom;

type
  TTabs = class(TMyForm,IhLogReceiver)
    PageControl1: TMyPageControl;
    AnchorFont: TTntTabSheet;
    AnchorBorder: TTntTabSheet;
    AnchorBackground: TTntTabSheet;
    AnchorPosition: TTntTabSheet;
    IGNORE_SampleFont: TdhLabel;
    FontDialog1: TMyFontDialog;
    OpenPictureDialog1: TMyOpenPictureDialog;
    dhPanel2: TdhPanel;
    SamplePosition: TdhPanel;
    GroupBox1: TMyGroupBox;
    cClient: TTntRadioButton;
    cNone: TTntRadioButton;
    cLeft: TTntRadioButton;
    cTop: TTntRadioButton;
    cRight: TTntRadioButton;
    cBottom: TTntRadioButton;
    GroupBox2: TMyGroupBox;
    caLeft: TTntCheckBox;
    caTop: TTntCheckBox;
    caRight: TTntCheckBox;
    caBottom: TTntCheckBox;
    AnchorName: TTntTabSheet;
    AnchorPage: TTntTabSheet;
    AnchorPageControl: TTntTabSheet;
    AnchorLink: TTntTabSheet;
    IGNORE_SavePictureDialog1: TMySavePictureDialog;
    AnchorEdit: TTntTabSheet;
    AnchorCheckBox: TTntTabSheet;
    AnchorForm: TTntTabSheet;
    GroupBox4: TMyGroupBox;
    spLeft: TMySpinEdit;
    spTop: TMySpinEdit;
    dhLabel29: TdhLabel;
    dhLabel30: TdhLabel;
    dhLabel31: TdhLabel;
    spWidth: TMySpinEdit;
    dhLabel32: TdhLabel;
    spHeight: TMySpinEdit;
    cAutoX: TTntCheckBox;
    cAutoY: TTntCheckBox;
    GroupBox3: TMyGroupBox;
    GroupBox5: TMyGroupBox;
    GroupBox6: TMyGroupBox;
    slMargin: TMyTrackBar;
    slPadding: TMyTrackBar;
    spPadding: TMySpinEdit;
    spMargin: TMySpinEdit;
    dhLabel2: TdhLabel;
    dhLabel6: TdhLabel;
    GroupBox7: TMyGroupBox;
    slBorder: TMyTrackBar;
    dhLabel3: TdhLabel;
    spBorder: TMySpinEdit;
    dhComboBox1: ThComboBox;
    GroupBox8: TMyGroupBox;
    dhLabel8: TdhLabel;
    spBGX: TMySpinEdit;
    slBGX: TMyTrackBar;
    IGNORE_dhComboBoxX: ThComboBox;
    IGNORE_dhComboBoxY: ThComboBox;
    slBGY: TMyTrackBar;
    spBGY: TMySpinEdit;
    dhLabel9: TdhLabel;
    GroupBox9: TMyGroupBox;
    dhLabel26: TdhLabel;
    GroupBox11: TMyGroupBox;
    dhLabel14: TdhLabel;
    cbLinkPage: ThComboBox;
    cbLinkAnchor: ThComboBox;
    dhLabel15: TdhLabel;
    eAction: ThEdit;
    AnchorEffects: TTntTabSheet;
    PageControl2: TdhPageControl;
    TabSheet3: TdhPage;
    cAntiAliasing: TTntCheckBox;
    TabSheet7: TdhPage;
    Label9: TdhLabel;
    Label10: TdhLabel;
    slSkewX: TMyTrackBar;
    spSkewX: TMySpinEdit;
    spSkewY: TMySpinEdit;
    slSkewY: TMyTrackBar;
    TabSheet8: TdhPage;
    panelpc2:TdhPanel;
    IGNORE_Button1: TTntButton;
    bClearFont: TTntButton;
    bClearEdge: TTntButton;
    bClearImage: TTntButton;
    AnchorText: TTntTabSheet;
    Button8: TTntButton;
    PopupMenu2: TTntPopupMenu;
    mText: TTntMenuItem;
    mMenu: TTntMenuItem;
    N6: TTntMenuItem;
    mSendToBack: TTntMenuItem;
    mBringToFront: TTntMenuItem;
    N5: TTntMenuItem;
    mAlignToGrid: TTntMenuItem;
    AnchorMenu: TTntTabSheet;
    Button10: TTntButton;
    mSubMenu: TTntMenuItem;
    mNewPage: TTntMenuItem;
    cBold: TTntCheckBox;
    cItalic: TTntCheckBox;
    cUnderline: TTntCheckBox;
    cLineThrough: TTntCheckBox;
    cOverline: TTntCheckBox;
    cTransparent: TTntCheckBox;
    cpBackgroundColor: TdhColorPicker;
    cpBorderColor: TdhColorPicker;
    Button11: TTntButton;
    Button12: TTntButton;
    mSaveImage: TTntMenuItem;
    AnchorMisc: TTntTabSheet;
    GroupBox13: TMyGroupBox;
    ppp:TPanel;
    cDownIfMenu: TTntCheckBox;
    cDownIfMouseDown: TTntCheckBox;
    cDownIfOver: TTntCheckBox;
    cDown: TTntCheckBox;
    cDownIfUrl: TTntCheckBox;
    GroupBox14: TMyGroupBox;
    cInline: TTntCheckBox;
    cResumeOpen: TTntCheckBox;
    cStatic: TTntCheckBox;
    cHorizontalLayout: TTntCheckBox;
    CheckGroupBox1: TMyGroupBox;
    spSlidePixel: TMySpinEdit;
    IGNORE_Label20: TdhLabel;
    Label21: TdhLabel;
    Button17: TTntButton;
    IGNORE_cRightJustify: TTntCheckBox;
    GroupBox16: TMyGroupBox;
    cDynamicNavigation: TTntCheckBox;
    cFixedHeight: TTntCheckBox;
    bClearMore: TTntButton;
    bClearEffects: TTntButton;
    N2: TTntMenuItem;
    mGoto: TTntMenuItem;
    mGotoUse: TTntMenuItem;
    mGotoLink: TTntMenuItem;
    mGotoFragment: TTntMenuItem;
    mStyleInfo: TTntMenuItem;
    N3: TTntMenuItem;
    mStyles: TTntMenuItem;
    mPushStylesToUse: TTntMenuItem;
    mGetUseStyles: TTntMenuItem;
    mClearAllStyles: TTntMenuItem;
    AnchorMemo: TTntTabSheet;
    eMemo: ThMemo;
    Label35: TdhLabel;
    mGetClipboardStyles: TTntMenuItem;
    N4: TTntMenuItem;
    Panel1: TdhPanel;
    GroupBox21: TMyGroupBox;
    Label19: TdhLabel;
    eName: ThEdit;
    gPageProperties: TMyGroupBox;
    dhLabel16: TdhLabel;
    eTitle: ThEdit;
    eOutputDirectory: ThEdit;
    dhLabel4: TdhLabel;
    GroupBox23: TMyGroupBox;
    ComboBox1: ThComboBox;
    cBGFixed: ThCheckBox;
    GroupBox24: TMyGroupBox;
    Label25: TdhLabel;
    cbTextTransform: ThComboBox;
    cbWhiteSpace: ThComboBox;
    cbFontVariant: ThComboBox;
    Label26: TdhLabel;
    Label13: TdhLabel;
    GroupBox25: TMyGroupBox;
    Label16: TdhLabel;
    CODE_cbVerticalAlign: ThComboBox;
    CODE_cbTextIndent: ThComboBox;
    Label18: TdhLabel;
    Label12: TdhLabel;
    cbTextAlign: ThComboBox;
    GroupBox26: TMyGroupBox;
    Label15: TdhLabel;
    cbCursor: ThComboBox;
    cbZIndex: ThComboBox;
    Label24: TdhLabel;
    Label30: TdhLabel;
    cbDirection: ThComboBox;
    GroupBox28: TMyGroupBox;
    dhLabel19: TdhLabel;
    dhLabel1: TdhLabel;
    CODE_eTarget: ThComboBox;
    CODE_eLink: ThComboBox;
    GroupBox18: TMyGroupBox;
    Label2: TdhLabel;
    cbUse: ThComboBox;
    cDownOverlayOver: TTntRadioButton;
    cOverOverlayDown: TTntRadioButton;
    Image1: TImage;
    Label36: TdhLabel;
    Panel2: TPanel;
    Button14: TTntButton;
    bDeletePage: TTntButton;
    bMovePageUp: TTntButton;
    bMovePageDown: TTntButton;
    GroupBox15: TMyGroupBox;
    eEdit: ThEdit;
    GroupBox20: TMyGroupBox;
    cReadOnly: TTntCheckBox;
    cPassword: TTntCheckBox;
    GroupBox29: TMyGroupBox;
    cMemoReadOnly: TTntCheckBox;
    cWrap: TTntCheckBox;
    Label3: TdhLabel;
    Label4: TdhLabel;
    slScaleX: TMyTrackBar;
    spScaleX: TMySpinEdit;
    spScaleY: TMySpinEdit;
    slScaleY: TMyTrackBar;
    Panel3: TMyPanel;
    Label7: TdhLabel;
    Label8: TdhLabel;
    Label6: TdhLabel;
    Label5: TdhLabel;
    slShiftX: TMyTrackBar;
    spShiftX: TMySpinEdit;
    spShiftY: TMySpinEdit;
    slShiftY: TMyTrackBar;
    slAngle: TMyTrackBar;
    spAngle: TMySpinEdit;
    slMasterAlpha: TMyTrackBar;
    spMasterAlpha: TMySpinEdit;
    pcnav_vert: TdhPanel;
    Panel5: TMyPanel;
    lOpacity: TdhLabel;
    lFlood: TdhLabel;
    lDistance: TdhLabel;
    lDegree: TdhLabel;
    spBlurAlpha: TMySpinEdit;
    spBlurFlood: TMySpinEdit;
    spBlurDistance: TMySpinEdit;
    spBlurDegree: TMySpinEdit;
    cEffectsEnabled: TTntCheckBox;
    cpFontColor: TdhColorPicker;
    dhStyleSheet1: TdhStyleSheet;
    STYLE_Label14: TdhLabel;
    EffectsMain: TdhLink;
    EffectsBlur: TdhLink;
    EffectsTransformations: TdhLink;
    STYLE_Link1: TdhLink;
    pcnav_horz: TdhPanel;
    EffectsMain2: TdhLink;
    EffectsBlur2: TdhLink;
    EffectsTransformations2: TdhLink;
    STYLE_dhLink7: TdhLink;
    Panel31: TMyPanel;
    dhPanel1: TdhPanel;
    GroupBox30: TMyGroupBox;
    dhLabel7: TdhLabel;
    CODE_eFormTarget: ThComboBox;
    mPageProperties: TTntMenuItem;
    bPageProperties: TTntButton;
    mOle: TTntMenuItem;
    AnchorHidden: TTntTabSheet;
    GroupBox31: TMyGroupBox;
    eHiddenField: ThEdit;
    AnchorOle: TTntTabSheet;
    Button2: TTntButton;
    Button4: TTntButton;
    cTextOnly: TTntCheckBox;
    PopupMenu1: TTntPopupMenu;
    mCopyImage: TTntMenuItem;
    mPasteImage: TTntMenuItem;
    mChangeColors: TTntMenuItem;
    dhComboBox4: ThComboBox;
    Label17: TdhLabel;
    cTransparentWhite: TTntCheckBox;
    mSaveImageToFile: TTntMenuItem;
    N7: TTntMenuItem;
    vs: TListBox;
    cSlide: TTntCheckBox;
    GroupBox32: TMyGroupBox;
    cbParentMenuItem: ThComboBox;
    cOpenByOver: TTntCheckBox;
    spReactionTime: TMySpinEdit;
    IGNORE_Label22: TdhLabel;
    slBlurFlood: TMyTrackBar;
    slBlurDistance: TMyTrackBar;
    slBlurDegree: TMyTrackBar;
    slBlurAlpha: TMyTrackBar;
    bBorderRadius: TTntButton;
    cLinkAuto: TTntCheckBox;
    cLinkLayout: TTntRadioGroup;
    mExchangeDownAndOverStyles: TTntMenuItem;
    mAlign: TTntMenuItem;
    N8: TTntMenuItem;
    mLeftEdges: TTntMenuItem;
    mRightEdges: TTntMenuItem;
    mTopEdges: TTntMenuItem;
    mBottomEdges: TTntMenuItem;
    N9: TTntMenuItem;
    mEqualHorizontal: TTntMenuItem;
    mEqualVertical: TTntMenuItem;
    N10: TTntMenuItem;
    mLoadfromHTTPaddress: TTntMenuItem;
    bMoreMisc: TTntButton;
    AnchorSelect: TTntTabSheet;
    dhSelect1: TdhSelect;
    GroupBox12: TMyGroupBox;
    Label29: TdhLabel;
    Label34: TdhLabel;
    cSelectSelected: TTntCheckBox;
    eSelectLabel: ThEdit;
    eSelectValue: ThEdit;
    Panel4: TPanel;
    Button5: TTntButton;
    bMoveItemUp: TTntButton;
    bMoveItemDown: TTntButton;
    bDeleteItem: TTntButton;
    GroupBox19: TMyGroupBox;
    cMultiple: TTntCheckBox;
    cDropDown: TTntRadioButton;
    cList: TTntRadioButton;
    rgChecked: TTntRadioGroup;
    GroupBox33: TMyGroupBox;
    eCheckValue: ThEdit;
    cFontFamily: ThComboBox;
    cFontSize: ThComboBox;
    dhStyleSheet2: TdhStyleSheet;
    EdgeNavigation: TdhPanel;
    cEdgeBottom: TdhLink;
    cEdgeRight: TdhLink;
    cEdgeTop: TdhLink;
    cEdgeLeft: TdhLink;
    dhPanel4: TdhPanel;
    dhLink9: TdhLink;
    dhLink10: TdhLink;
    dhLink11: TdhLink;
    dhLink12: TdhLink;
    dhLink13: TdhLink;
    gScrolling: TTntRadioGroup;
    cImageFormat: TTntRadioGroup;
    IGNORE_cDoAction: ThComboBox;
    IGNORE_Button9: TTntButton;
    eText: ThSynMemo;
    STYLE_Link2: TdhLink;
    STYLE_dhLabel10: TdhLabel;
    STYLE_Link14: TdhLink;
    cEdgeAll: TdhLink;
    Panel6: TMyPanel;
    Label11: TdhLabel;
    spBlurRadius: TMySpinEdit;
    slBlurRadius: TMyTrackBar;
    cpBlurColor: TdhColorPicker;
    cBlurEnabled: TTntCheckBox;
    dhPanel3: TdhPanel;
    SampleBorder: TdhPanel;
    dhPanel5: TdhPanel;
    AnchorPureHTML: TTntTabSheet;
    ePureHTML: ThSynMemo;
    IGNORE_dhDirectHTML1: TdhDirectHTML;
    STYLE_Label33: TdhLabel;
    EffectsTransformations_Border: TdhLabel;
    dhLabel12: TdhLabel;
    EffectsBlur_Border: TdhLabel;
    EffectsMain_Border: TdhLabel;
    EffectsMain_top: TdhLabel;
    STYLE_dhLabel11: TdhLabel;
    EffectsBlur2_Border: TdhLabel;
    EffectsTransformations2_Border: TdhLabel;
    EffectsMain2_Border: TdhLabel;
    EffectsMain2_top: TdhLabel;
    dhLabel13: TdhLabel;
    dhLabel17: TdhLabel;
    STYLE_dhLink2: TdhLink;
    gHTMLFrame: TTntRadioGroup;
    cLinkForm: TTntRadioGroup;
    cGenerateContainingElement: TTntCheckBox;
    cbMethod: TTntRadioGroup;
    Label37: TdhLabel;
    eTooltip: ThEdit;
    Label38: TdhLabel;
    IGNORE_Label39: TdhLabel;
    cExcludeText: TTntCheckBox;
    IGNORE_cUsage: TTntRadioGroup;
    Button6: TTntButton;
    AnchorFile: TTntTabSheet;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    cFileUsage: TTntRadioGroup;
    dhStyleSheet3: TdhStyleSheet;
    STYLE_FileInfo: TdhLabel;
    Panel7: TPanel;
    Button15: TTntButton;
    cLoop: TTntCheckBox;
    mLoadFromFile: TTntMenuItem;
    cLinked: TTntCheckBox;
    STYLE_Label28: TdhLabel;
    EffectsTransformations2_top: TdhLabel;
    DKLanguageController1: TDKLanguageController;
    lFileInfo: TdhLabel;
    mOrder: TTntMenuItem;
    mEdit: TTntMenuItem;
    mCut: TTntMenuItem;
    mCopy: TTntMenuItem;
    mPaste: TTntMenuItem;
    mDelete: TTntMenuItem;
    mFullCopy: TTntMenuItem;
    mGotoMenu: TTntMenuItem;
    cMenuAuto: TTntCheckBox;
    mSetBackgroundColorTransparent: TTntMenuItem;
    mCopyOverStylesToDownStyles: TTntMenuItem;
    mClearStyles: TTntMenuItem;
    SynHTMLSyn1: TSynHTMLSyn;
    mLoadStylesheet: TMenuItem;
    OpenCSSDialog: TOpenDialog;
    procedure mClearStylesClick(Sender: TObject);
    procedure cpBlurColorPreviewColorChanged(Sender: TObject);
    procedure cpBlurColorBackup(Sender: TObject; backup: TList;
      restore: Boolean);
    procedure cpFontColorBackup(Sender: TObject; backup: TList;
      restore: Boolean);
    procedure cpBackgroundColorBackup(Sender: TObject; backup: TList;
      restore: Boolean);
    procedure cpBackgroundColorPreviewColorChanged(Sender: TObject);
    procedure cpFontColorPreviewColorChanged(Sender: TObject);
    procedure cpBorderColorBackup(Sender: TObject; backup: TList;
      restore: Boolean);
    procedure cpBorderColorPreviewColorChanged(Sender: TObject);
    procedure IGNORE_Button1Click(Sender: TObject);
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
    //procedure cMultiSelectClick(Sender: TObject);
    procedure cAutoXClick(Sender: TObject);
    procedure dhAnchor26Click(Sender: TObject);
    procedure spAngleChange(Sender: TObject);
    procedure cRenderClick(Sender: TObject);
    procedure cpFontColorColorChanged(Sender: TObject);
    procedure cpBorderColorColorChanged(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure AnchorEffectsShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cClearStylesClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure mSubMenuClick(Sender: TObject);
    procedure mAlignToGridClick(Sender: TObject);
    procedure mSendToBackClick(Sender: TObject);
    procedure mBringToFrontClick(Sender: TObject);
    procedure cTransparentClick(Sender: TObject);
    procedure cFixedHeightClick(Sender: TObject);
    procedure mSaveImageClick(Sender: TObject);
    procedure AnchorMiscShow(Sender: TObject);
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
    //procedure AnchorComboBoxShow(Sender: TObject);
    //procedure AnchorListBoxShow(Sender: TObject);
    procedure cReadOnlyClick(Sender: TObject);
    procedure AnchorEditShow(Sender: TObject);
    procedure AnchorCheckBoxShow(Sender: TObject);
    procedure cCheckedClick(Sender: TObject);
    procedure IGNORE_cRightJustifyClick(Sender: TObject);
    procedure cDownOverlayOverClick(Sender: TObject);
    procedure cExtendedUseClick(Sender: TObject);
    procedure AnchorBorderShow(Sender: TObject);
    procedure AnchorPositionShow(Sender: TObject);
    procedure AnchorBackgroundShow(Sender: TObject);
    procedure IGNORE_Button9Click(Sender: TObject);
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
    procedure mStyleInfoClick(Sender: TObject);
    procedure AnchorFormShow(Sender: TObject);
    procedure cMemoReadOnlyClick(Sender: TObject);
    procedure AnchorMemoShow(Sender: TObject);
    procedure cPasswordClick(Sender: TObject);
    procedure cWrapClick(Sender: TObject);
    procedure mGetClipboardStylesClick(Sender: TObject);
    procedure cEffectsEnabledClick(Sender: TObject);
    procedure mPagePropertiesClick(Sender: TObject);
    procedure mOleClick(Sender: TObject);
    procedure AnchorHiddenShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure dhPanel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mChangeColorsClick(Sender: TObject);
    procedure cTransparentWhiteClick(Sender: TObject);
    procedure AnchorOleShow(Sender: TObject);
    procedure mCopyImageClick(Sender: TObject);
    procedure mSaveImageToFileClick(Sender: TObject);
    procedure vsClick(Sender: TObject);
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
    //procedure eComboBoxTargetValueChange(Sender: TObject; Clear: Boolean);
    procedure eActionValueChange(Sender: TObject; Clear: Boolean);
    procedure eHiddenFieldValueChange(Sender: TObject; Clear: Boolean);
    procedure eMemoValueChange(Sender: TObject; Clear: Boolean);
    procedure CODE_eFormTargetValueChange(Sender: TObject; Clear: Boolean);
    procedure dhComboBox1ValueChange(Sender: TObject; Clear: Boolean);
    procedure CODE_cbTextIndentValueChange(Sender: TObject; Clear: Boolean);
    procedure CODE_cbVerticalAlignValueChange(Sender: TObject; Clear: Boolean);
    procedure cbZIndexValueChange(Sender: TObject; Clear: Boolean);
    procedure CODE_eLinkValueChange(Sender: TObject; Clear: Boolean);
    procedure CODE_eTargetValueChange(Sender: TObject; Clear: Boolean);
    procedure ComboBox1ValueChange(Sender: TObject; Clear: Boolean);
    procedure dhComboBox4ValueChange(Sender: TObject; Clear: Boolean);
    procedure cbCursorValueChange(Sender: TObject; Clear: Boolean);
    procedure cbDirectionValueChange(Sender: TObject; Clear: Boolean);
    procedure cbTextAlignValueChange(Sender: TObject; Clear: Boolean);
    procedure cbTextTransformValueChange(Sender: TObject; Clear: Boolean);
    procedure cbWhiteSpaceValueChange(Sender: TObject; Clear: Boolean);
    procedure cbFontVariantValueChange(Sender: TObject; Clear: Boolean);
    procedure cbUseValueChange(Sender: TObject; Clear: Boolean);
    procedure spReactionTimeValueChange(Sender: TObject; Clear: Boolean);
    procedure cbLinkPageValueChange(Sender: TObject; Clear: Boolean);
    procedure cBGFixedValueChange(Sender: TObject; Clear: Boolean);
    procedure cLinkLayoutClick(Sender: TObject);
    procedure cHorizontalLayoutClick(Sender: TObject);
    procedure cbParentMenuItemValueChange(Sender: TObject; Clear: Boolean);
    procedure mExchangeDownAndOverStylesClick(Sender: TObject);
    procedure mLeftEdgesClick(Sender: TObject);
    procedure mEqualHorizontalClick(Sender: TObject);
    procedure mLoadfromHTTPaddressClick(Sender: TObject);
    procedure bMoreMiscClick(Sender: TObject);
    procedure AnchorSelectShow(Sender: TObject);
    procedure mPushStylesToUseClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure bDeleteItemClick(Sender: TObject);
    procedure mClearAllStylesClick(Sender: TObject);
    procedure mGetUseStylesClick(Sender: TObject);
    procedure bMoveItemUpClick(Sender: TObject);
    procedure eSelectLabelValueChange(Sender: TObject; Clear: Boolean);
    procedure eSelectValueValueChange(Sender: TObject; Clear: Boolean);
    procedure cSelectSelectedClick(Sender: TObject);
    procedure dhSelect1Click(Sender: TObject);
    procedure cMultipleClick(Sender: TObject);
    procedure cDropDownClick(Sender: TObject);
    procedure bMoveItemDownClick(Sender: TObject);
    procedure eCheckValueValueChange(Sender: TObject; Clear: Boolean);
    procedure cFontFamilyValueChange(Sender: TObject; Clear: Boolean);
    procedure cFontSizeValueChange(Sender: TObject; Clear: Boolean);
    procedure cEdgeAllClick(Sender: TObject);
    procedure dhLink9Click(Sender: TObject);
    procedure gScrollingClick(Sender: TObject);
    procedure cImageFormatClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure AnchorPureHTMLShow(Sender: TObject);
    procedure ePureHTMLValueChange(Sender: TObject; Clear: Boolean);
    procedure EffectsMainStateTransition(Sender: TdhCustomPanel;
      OldState: TState);
    procedure gHTMLFrameClick(Sender: TObject);
    procedure dhSelect1GetDisplayText(Sender: TObject; Item: TSelectOption;
      var DisplayText: WideString);
    procedure cLinkFormClick(Sender: TObject);
    procedure cGenerateContainingElementClick(Sender: TObject);
    procedure cbMethodClick(Sender: TObject);
    procedure eTooltipValueChange(Sender: TObject; Clear: Boolean);
    procedure cExcludeTextClick(Sender: TObject);
    procedure cTextOnlyClick(Sender: TObject);
    procedure IGNORE_cUsageClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure bSaveToFileClick(Sender: TObject);
    procedure AnchorFileShow(Sender: TObject);
    procedure bGoToFileClick(Sender: TObject);
    procedure cFileUsageClick(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure cLoopClick(Sender: TObject);
    procedure cLinkedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mCutClick(Sender: TObject);
    procedure mCopyClick(Sender: TObject);
    procedure mDeleteClick(Sender: TObject);
    procedure mPasteClick(Sender: TObject);
    procedure mFullCopyClick(Sender: TObject);
    procedure mGotoMenuClick(Sender: TObject);
    procedure cMenuAutoClick(Sender: TObject);
    procedure mSetBackgroundColorTransparentClick(Sender: TObject);
    procedure mCopyOverStylesToDownStylesClick(Sender: TObject);
    procedure mLoadStylesheetClick(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
  private
    FAdjusting:boolean;
    LastClientWidth,LastClientHeight:Integer;

    procedure AssignFontColor;
    procedure AssignBackgroundColor(Sender: TObject);
    procedure AssignSingleBackgroundColor(Control:TControl; Color:TCSSColor);
    function GetSingleBackgroundColor(Control:TControl):TCSSColor;
    procedure AssignSingleFontColor(Control:TControl; Color:TCSSColor);
    function GetSingleFontColor(Control:TControl):TCSSColor;
    function DoNotUpdateDisplay:boolean;
    procedure SetAdjusting(Value:boolean);
//    gpc:TdhPageControl;
    procedure ActFontChanged;
    procedure LiveBorderChanged;
    procedure LiveBackgroundChanged;
    procedure BuildBGPos(Clear:boolean);
    procedure UpdateNameDisplay;
    procedure LinkChanged;
    //procedure UpdateComboBoxDisplay(OnlyItems:boolean);
    //procedure UpdateListBoxDisplay(OnlyItems:boolean);
    procedure BuildTransformations;
    procedure LiveBuildTransformations;
    procedure UpdateEffectsDisplay;
    function getblur(tt:TTransformations; i:integer=-1): TBlurEffect;
    procedure StylesChanged;
    procedure UpdateFontDisplay;
    procedure UpdateBorderDisplay;
    procedure UpdateBackgroundDisplay;

    procedure EnableChildren(Child: TComponent);
    procedure DisableChildren(Child: TComponent);
    procedure SetChildrenEnabled(p:TControl; Enabled:boolean);

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
    procedure UpdatePureHTMLDisplay;
    procedure UpdateCheckboxDisplay;
    procedure UpdateTextDisplay;
    procedure UpdatePageDisplay;
    procedure UpdateFileDisplay;
    function IsFontCleared: boolean;
    function IsEdgeCleared(EdgeAlign:TEdgeAlign): boolean;
    function IsBorderRadiusCleared:boolean;
    function IsAllEdgeCleared: boolean;
    function IsImageCleared: boolean;
    function IsMoreCleared: boolean;
    function IsEffectsCleared: boolean;
    procedure InstallDefaultFont;
    procedure UpdateFormDisplay;
    procedure UpdateHiddenFieldDisplay;
    procedure UpdateEffectsDisplay2;
    procedure UpdateOLEDisplay;
    procedure PageControl1DrawTabCLX(Control: TCustomTabControl;
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
    function GetEdgeAlign(c: TObject): TEdgeAlign;
    procedure UpdateContainer;
    procedure DoOnClose(Sender: TObject; var Action: TCloseAction);

  protected
    EdgeAlign:TEdgeAlign;
    BlurIndex:integer;
    FActiveEditControl:IhCommitable;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure LivePositionChanged(Sender:TObject);
    procedure ClearAllStyles(ClearUse:boolean);
    procedure LoadFile(f:TdhFile);
  public
    { Public declarations }
    Selection:TList;

    procedure UpdateTabImages;
    procedure InitialLoadFile(f:TdhFile);
    procedure Changed(const Reason: TReason; LogChange:TLogChange=lcCommit);
    function ActPn: TdhCustomPanel;
    procedure EditText(vn:integer=0);
    function ActiveEditControl: IhCommitable;
    function ActSel:TControl;
    function IsMoreExtCleared: boolean;
    function SetClearState(b: TButton; IsCleared: boolean):boolean;
    procedure InvTabs;
    property Adjusting:boolean read FAdjusting write SetAdjusting;
    procedure LogChange(Sender:TObject; LogChange:TLogChange);
    function ActStyle:TStyle;
    procedure PullStyles(Use:ICon; Clear:boolean);
    procedure Loaded; override;
    procedure LoadImage(URL: TPathName); overload;
    procedure LoadImageExt(URL: TPathName; pn:TdhCustomPanel); overload;
    procedure ActBoundsChanged;
    procedure ActContentChanged;
    procedure WriteTransformations(tt: TTransformations);
    procedure UpdateSel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CommitChanges:boolean;
    procedure AbortChanges;
    procedure EditPageProperties(pages:TList);


  end;

var
  Tabs: TTabs;



function Adj255to100(i:integer):integer;
function Adj100to255(i:integer):DWORD;

function GetComp(c:TControl):TComponent;
function AbsIncr(c:TControl):TPoint;

function WithoutPx(const s:TCSSStringValue):TCSSStringValue;

type TSecFilter=function (match,ori:TControl):boolean;
procedure GetRefs_(cb:ThComboBox; cl:TClass; c,find:TControl; SecFilter:TSecFilter; ClearValue:boolean);

function GoodIndex(i:integer):integer;
function GoodIndexBack(i:integer):integer;
procedure SetUnderlineState(b:TButton; IsCleared:boolean); overload;
procedure SetUnderlineState(b:TCanvas; IsCleared:boolean); overload;
procedure SetUnderlineState(b:TdhCustomPanel; IsCleared:boolean); overload;
procedure SetPrecise(p:TWinControl);

procedure UpdateAlign;

function ExtractActiveControl:TControl;
procedure ForceBounds(c:TControl; ALeft, ATop, AWidth, AHeight: Integer);

implementation

uses {Unit1,}MySiz, Unit1, {uTransparencyWizard,} uStyleInfo, uPageWizard,
  uColorizeImg, uTransparencyWizard, uBorderRadiusWizard,uMoreMisc,
  uObjectExplorer,uStyleImport;

{$R *.dfm}

const PAGE_STYLES=5;
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
 if EditableControl(p.Controls[i],true) then
 begin
  if p.Controls[i].InheritsFrom(c) and not (Assigned(SecFilter) and not SecFilter(p.Controls[i],ori)) then
   sl.Add(p.Controls[i].Name);
  if p.Controls[i] is TWinControl then
   GetAllNames(sl,TWinControl(p.Controls[i]),ori,c,SecFilter);
 end;
end;

procedure GetRefs_(cb:ThComboBox; cl:TClass; c,find:TControl; SecFilter:TSecFilter; ClearValue:boolean);
var sl:TStringList;
begin
 cb.Items.Clear;
 if (c=nil) or (GetParentForm(c)=nil) then exit;
 sl:=TStringList.Create;
 GetAllNames(sl,GetParentForm(c),c,cl,SecFilter);
 {if (c<>find) and (sl.IndexOf(c.Name)<>-1) then
  sl.Delete(sl.IndexOf(c.Name)); }
 sl.Sort;
 cb.Items.Assign(sl);
 if cb is ThComboBox then
 begin  
 if find<>nil then
  ThComboBox(cb).StoredItemIndex:=cb.Items.IndexOf(find.Name) else
  //ThComboBox(cb).StoredText:=find.Name else
  ThComboBox(cb).StoredText:=EmptyStr;
 end else
 if find<>nil then
  cb.ItemIndex:=cb.Items.IndexOf(find.Name) else
  cb.Text:=EmptyStr;
 sl.Free;

 if ClearValue then
 begin
 cb.Items.Insert(0,{sClearValue}'');
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

function TTabs.ActStyle:TStyle;
begin
 result:=ActPn.ActStyle;
end;


function TTabs.ActPn: TdhCustomPanel;
begin             
 result:=(TObject(Selection[0]) as TdhCustomPanel);
end;

procedure TTabs.IGNORE_Button1Click(Sender: TObject);
begin
 FontDialog1.Font.Assign(IGNORE_SampleFont.Font);
// if FontDialog1.Font.Size>0 then FontDialog1.Font.Size:=-FontDialog1.Font.Size;
 FontDialog1.Font.Color:=clBlack;
 if FontDialog1.Execute then
 begin
  IGNORE_SampleFont.Font.Size:=Abs(FontDialog1.Font.Size);
  IGNORE_SampleFont.Font.Name:=FontDialog1.Font.Name;
  IGNORE_SampleFont.Font.Style:=IGNORE_SampleFont.Font.Style*[fsUnderline,fsStrikeOut]+FontDialog1.Font.Style;
  ActFontChanged;
 end;
end;

function Adj255to100(i:integer):integer;
begin
 result:=i;
end;


function Adj100to255(i:integer):DWORD;
begin
 result:=i;
end;

function NormalizeDegree(Degree:integer):integer;
begin
 result:=(Degree mod 360 + 360) mod 360;
end;



procedure TTabs.ActFontChanged;
var i:integer;
begin
 if Adjusting then exit;
 dhMainForm.Act.MySiz.DoInval(true);
 try
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TControl then
 begin
  TFakeControl(Selection[i]).Font.Assign(IGNORE_SampleFont.Font);
  if TObject(Selection[i]) is TdhCustomPanel then
  begin
   TdhCustomPanel(TObject(Selection[i])).Overline:=IGNORE_SampleFont.Overline;
  end;
 end;

 if TObject(Selection[0]) is TdhCustomPanel then
 if not ActPn.SetTextDecoration(cUnderline.Checked,cLineThrough.Checked,cOverline.Checked,ActPn.Blink) then
 begin
  Showmessage(DKFormat(DELETEINHERITEDERROR));
  UpdateFontDisplay;
 end;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdateFontDisplay;
 Changed('Change Font');
end;



procedure TTabs.LiveBorderChanged;
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

var countable:integer=0;

procedure TTabs.EnableChildren(Child: TComponent);
var _countable:integer;
begin
 inc(countable);
 _countable:=countable;
 TFakeComponent(Child).GetChildren(EnableChildren,Child.Owner);
 if (Child is TControl) and not (Child is TdhLink) and (_countable=countable){and not ((Child is TWinControl) and (TWinControl(Child).ControlCount<>0))}  then TControl(Child).Enabled:=true;
end;

procedure TTabs.DisableChildren(Child: TComponent);
var _countable:integer;
begin
 inc(countable);
 _countable:=countable;
 TFakeComponent(Child).GetChildren(DisableChildren,Child.Owner);
 if (Child is TControl) and not (Child is TdhLink) and (_countable=countable){and not ((Child is TWinControl) and (TWinControl(Child).ControlCount<>0))} then TControl(Child).Enabled:=false;
end;

procedure TTabs.SetChildrenEnabled(p:TControl; Enabled:boolean);
var i:integer;
begin
 //if p.Enabled=Enabled then exit;
 if Enabled then
  EnableChildren(p) else
  DisableChildren(p);
{$IFDEF CLX}
 p.Invalidate; //caption of TGroupBox is still in disabled look
{$ENDIF}
end;

var _Showing:boolean=true;


procedure TTabs.UpdateBackgroundDisplay;
var res:TPoint;
    v1,v2:TCSSBackgroundPosition;
    BackgroundImage:TLocationImage;
begin
 if DoNotUpdateDisplay then exit;
 if Adjusting then exit;
 Adjusting:=true;
 if ActPn.HasBackgroundImage(BackgroundImage) then
  dhPanel1.Style.BackgroundImage.Assign(BackgroundImage) else
  dhPanel1.Style.BackgroundImage.Assign(nil);
 res:=Point(0,0);
 if ActPn.GetVal(pcBackgroundPosition) then
  GetBackgroundPixels(Cascaded.BackgroundPosition,Rect(0,0,100,100),0,0,res) else
  Cascaded.BackgroundPosition:='0% 0%';
 SplitBackgroundPixels(Cascaded.BackgroundPosition,v1,v2);
 spBGX.SetDetailedStoredValue(ActStyle.BackgroundPosition=EmptyStr,res.X);
 spBGY.SetDetailedStoredValue(ActStyle.BackgroundPosition=EmptyStr,res.Y);
 IGNORE_dhComboBoxX.SetDetailedStoredItemIndex(ActStyle.BackgroundPosition=EmptyStr,_if(System.Pos('px',v1)<>0,0,1));
 IGNORE_dhComboBoxY.SetDetailedStoredItemIndex(ActStyle.BackgroundPosition=EmptyStr,_if(System.Pos('px',v2)<>0,0,1));
 dhComboBox4.SetDetailedStoredItemIndex(ActStyle.BackgroundRepeat=Low(TCSSBackgroundRepeat),max(0,Integer(ActPn.BackgroundRepeat)-1));
 cBGFixed.SetDetailedStoredValue(ActStyle.BackgroundAttachment=Low(TCSSBackgroundAttachment),ActPn.BackgroundAttachment=cbaFixed);
 ComboBox1.SetDetailedStoredItemIndex((TObject(Selection[0]) as TdhCustomPanel).ImageType=Low(TImageType),max(0,Integer((TObject(Selection[0]) as TdhCustomPanel).GetImageType)-1));
 SetChildrenEnabled(GroupBox8,ComboBox1.ItemIndex=0);
 SetClearState(bClearImage,IsImageCleared);
 Adjusting:=false;
end;

procedure TTabs.InvTabs;

procedure setUnd(ts:TTabSheet; isCleared:boolean);
begin
 if not isCleared then
   ts.ImageIndex:=ts.ImageIndex mod 5 + 5 else
   ts.ImageIndex:=ts.ImageIndex mod 5;
end;

begin
  //PageControl1.Invalidate;
  setUnd(AnchorFont,IsFontCleared);
  setUnd(AnchorBorder,IsAllEdgeCleared);
  setUnd(AnchorBackground,IsImageCleared);
  setUnd(AnchorEffects,IsEffectsCleared);
  setUnd(AnchorMisc,IsAllMoreCleared);
end;

function TTabs.SetClearState(b:TButton; IsCleared:boolean):boolean;
begin
 if b.Enabled<>not IsCleared then
 begin
  b.Enabled:=not IsCleared;
  InvTabs;
  result:=true;
 end else
  result:=false;
end;

procedure SetUnderlineState(b:TButton; IsCleared:boolean);
begin
 if IsCleared then
  b.Font.Style:=[] else
  b.Font.Style:=[fsBold];
end;

procedure SetUnderlineState(b:TCanvas; IsCleared:boolean);
begin
 if IsCleared then
  b.Font.Style:=[] else
  b.Font.Style:=[fsBold];
end;

procedure SetUnderlineState(b:TdhCustomPanel; IsCleared:boolean);
begin
 if IsCleared then
  b.Style.FontWeight:=cfwNormal else
  b.Style.FontWeight:=cfwBold;
end;


      {
procedure SetUnderlineState(b:TButton; IsCleared:boolean);
begin
 if IsCleared then
  b.Font.Style:=[] else
  b.Font.Style:=[fsUnderline];
end;

procedure SetUnderlineState(b:TdhCustomPanel; IsCleared:boolean);
begin
 if IsCleared then
  b.Style.TextDecoration:=[] else
  b.Style.TextDecoration:=[ctdUnderline];
end;    }



procedure TTabs.ActBoundsChanged;
begin
 if AnchorPosition.TabVisible and (Selection.Count<>0) then
  UpdatePositionDisplay;
end;

procedure TTabs.ActContentChanged;
begin
 if (Selection.Count<>0) and (PageControl1.ActivePage<>nil) and PageControl1.ActivePage.TabVisible and Assigned(PageControl1.ActivePage) then
  PageControl1.ActivePage.OnShow(nil);
end;

function AbsIncr(c:TControl):TPoint;
begin
 if c.Parent is TdhCustomPanel then
  result:=Point(TdhCustomPanel(c.Parent).HorzPosition,TdhCustomPanel(c.Parent).VertPosition) else
  result:=Point(0,0);
end;


procedure TTabs.UpdatePositionDisplay;
var pn:TControl;
begin
 if DoNotUpdateDisplay then exit;
 Adjusting:=true;

 pn:=TObject(Selection[0]) as TControl;
 SamplePosition.Align:=pn.Align;
 SamplePosition.Anchors:=pn.Anchors;
 //SamplePosition.Center:=(pn is TdhCustomPanel) and TdhCustomPanel(pn).Center;

 //cCenter.Checked:=SamplePosition.Center;
 cNone.Checked:=SamplePosition.Align=alNone;
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
 spTop.Enabled:=cNone.Checked;
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

 cAutoX.Checked:=(pn is TdhCustomPanel) and (TdhCustomPanel(pn).AutoSizeXY in [asX,asXY]){ and not (pn is TRadioButton)}{ and not (pn is TdhCheckBox)};
 cAutoY.Checked:=(pn is TdhCustomPanel) and (TdhCustomPanel(pn).AutoSizeXY in [asY,asXY]){ or (pn is TEdit) and TEdit(pn).AutoSize};

 cAutoX.Enabled:=(pn is TdhFile) or (pn is TdhDirectHTML) or (pn is TdhOleContainer) or (pn is TdhCustomLabel) or (pn is TdhMenu);
 cAutoY.Enabled:=(pn is TdhFile) or (pn is TdhDirectHTML) or (pn is TdhOleContainer) or (pn is TdhCustomLabel) or (pn is TdhMenu){ or (pn is TdhEdit) and not (pn is TdhMemo)};

 Adjusting:=false;
end;

//const guiEdgesAlign:array[0..4] of TEdgeAlign = (ealNone,ealTop,ealRight,ealBottom,ealLeft);

//var EdgeAlignBut:TdhLink;

function TTabs.GetEdgeAlign(c:TObject):TEdgeAlign;
begin
 result:=ealNone;
 if c=cEdgeTop then result:=ealTop;
 if c=cEdgeRight then result:=ealRight;
 if c=cEdgeLeft then result:=ealLeft;
 if c=cEdgeBottom then result:=ealBottom;
end;


procedure TTabs.UpdateBorderDisplay;
var i:integer;
//const guiEdgesS:array[TEdgeAlign] of string = ('Reset','Reset top','Reset right','Reset bottom','Reset left');
begin
 if DoNotUpdateDisplay then exit;
 {if EdgeAlignBut=nil then
  cEdgeAllClick(cEdgeAll);}
 Adjusting:=true;
 spMargin.SetDetailedStoredValue(ActStyle.IsMarginCleared(EdgeAlign),ActPn.MarginWidth(EdgeAlign));
 spBorder.SetDetailedStoredValue(ActStyle.GetBorder(EdgeAlign).IsWidthCleared,ActPn.BorderWidth(EdgeAlign));
 spPadding.SetDetailedStoredValue(ActStyle.IsPaddingCleared(EdgeAlign),ActPn.PaddingWidth(EdgeAlign));
 dhComboBox1.SetDetailedStoredItemIndex(ActStyle.GetBorder(EdgeAlign).Style=Low(TCSSBorderStyle),max(0,Integer(ActPn.BorderStyle(EdgeAlign))-1));
 cpBorderColor.CSSColor:=ActPn.BorderColor(EdgeAlign);
 ActPn.AssignComputedEdge(ealRight,SampleBorder.Style);
 ActPn.AssignComputedEdge(ealTop,SampleBorder.Style);
 ActPn.AssignComputedEdge(ealBottom,SampleBorder.Style);
 ActPn.AssignComputedEdge(ealLeft,SampleBorder.Style);
 SampleBorder.Update;

{ cBorAll.Font.Color:=ClearColor[IsEdgeCleared(ealNone)];
 cBorLeft.Font.Color:=ClearColor[IsEdgeCleared(ealLeft)];
 cBorRight.Font.Color:=ClearColor[IsEdgeCleared(ealRight)];
 cBorBottom.Font.Color:=ClearColor[IsEdgeCleared(ealBottom)];
 cBorTop.Font.Color:=ClearColor[IsEdgeCleared(ealTop)];}
 SetClearState(bClearEdge,IsEdgeCleared(EdgeAlign));
 for i:=0 to EdgeNavigation.ControlCount-1 do
 if (EdgeNavigation.Controls[i] is TdhLink) then
 begin
  (EdgeNavigation.Controls[i] as TdhLink).Down:=GetEdgeAlign(EdgeNavigation.Controls[i])=EdgeAlign;
  SetUnderlineState(EdgeNavigation.Controls[i] as TdhLink,IsEdgeCleared(GetEdgeAlign(EdgeNavigation.Controls[i])));
  EdgeNavigation.Controls[i].Update;
 end;
 //bClearEdge.Caption:=guiEdgesS[EdgeAlign];
 SetUnderlineState(bBorderRadius,ActStyle.BorderRadius.IsCleared);
 Adjusting:=false;
end;

function TTabs.IsEdgeCleared(EdgeAlign:TEdgeAlign):boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
  result:=TdhCustomPanel(Selection[i]).ActStyle.IsEdgeCleared(EdgeAlign);
end;

function TTabs.IsBorderRadiusCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
  result:=TdhCustomPanel(Selection[i]).ActStyle.BorderRadius.IsCleared;
end;

function TTabs.IsAllEdgeCleared:boolean;
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
  Temp := Trim(LogFont.lfFaceName); //Trim wichtig ei All Times New Roman
  //if (S.Count = 0) or {(AnsiCompareText(S[S.Count-1], Temp) <> 0)}S.IndexOf( then
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
  i:integer;
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
      //LFont.lfCharset := THAI_CHARSET;
      //LFont.lfCharset := SYMBOL_CHARSET;
      EnumFontFamiliesEx(DC, LFont, @EnumFontsProc, LongInt(FFonts), 0);
      TStringList(FFonts).Sorted := TRUE;
      for i:=FFOnts.Count-1 downto 1 do
      if FFonts[i]=FFonts[i-1] then
       FFonts.Delete(i);
    finally
      ReleaseDC(0, DC);
    end;
  end;
  Result := FFonts;
end;

{$ENDIF}

function TTabs.DoNotUpdateDisplay:boolean;
begin
 result:=not _Showing or (Selection.Count=0);
end;

procedure TTabs.UpdateFontDisplay;
var Font:TFont;
    ScreenFonts:TStrings;
begin
 if DoNotUpdateDisplay then exit;
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
  cFontFamily.SetDetailedStoredValue(ActStyle.FontFamily=EmptyStr,ActPn.WidestFontFamily) else
  cFontFamily.StoredText:=TFakeControl(Selection[0]).Font.Name;

 if (TObject(Selection[0]) is TdhCustomPanel) then
  cFontSize.SetDetailedStoredValue(ActStyle.FontSize=EmptyStr,ActPn.FontSize) else
  cFontSize.StoredText:=IntToStr(Abs(TFakeControl(Selection[0]).Font.Height));

 Font:=TFont.Create;
 try
 if (TObject(Selection[0]) is TdhCustomPanel) then
  ActPn.CSSToFont(Font) else
  Font.Assign(TFakeControl(Selection[0]).Font);
 cOverline.Checked:=(TObject(Selection[0]) is TdhCustomPanel) and ActPn.Overline;
 cpBackgroundColor.CSSColor:=GetSingleBackgroundColor(TControl(Selection[0]));
 cTransparent.Checked:=cpBackgroundColor.GetTransparentColor;
 //FontStatus.Text:=Font.Name+#13#10+inttostr(-Font.Height)+'px';
 cBold.Checked:=fsBold in Font.Style;
 cItalic.Checked:=fsItalic in Font.Style;
 cUnderline.Checked:=fsUnderline in Font.Style;
 cLineThrough.Checked:=fsStrikeOut in Font.Style;
 cpFontColor.CSSColor:=GetSingleFontColor(TControl(Selection[0]));
 SetClearState(bClearFont,IsFontCleared);

 with Font do IGNORE_SampleFont.GetFontDifferences(Style,Color,Name,Height);
 IGNORE_SampleFont.ActStyle.BackgroundColor:=cpBackgroundColor.CSSColor;
 IGNORE_SampleFont.Overline:=cOverline.Checked;
 IGNORE_SampleFont.Update;
 finally
  Font.Free;
 end;
 Adjusting:=false;
end;

(*

procedure TPropsPC.UpdateFontDisplay;
begin
 if not _Showing then exit;
 if Adjusting then exit;
 Adjusting:=true;
 SampleFont.Font.Assign((TFakeControl(Selection[0])).Font);
 SampleFont.Color:=TFakeControl(Selection[0]).Color;
 SampleFont.FCommon.Overline:=(TObject(Selection[0]) is TdhCustomPanel) and ActPn.Overline;
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


procedure SetPrecise(p:TWinControl);
var i:integer;
begin
 for i:=0 to p.ControlCount-1 do
  (p.Controls[i] as TdhCustomPanel).PreciseClick:=true;
end;



constructor TTabs.Create(AOwner: TComponent);
begin

  LastClientWidth:=670;
  LastClientHeight:=300;

  inherited;      

end;

procedure TTabs.bClearEdgeClick(Sender: TObject);
begin
 ActStyle.ClearEdge(EdgeAlign);
 LiveBorderChanged;
 Changed('Reset Edge');
end;

procedure TTabs.ClearFontClick(Sender: TObject);
var i:integer;
begin                  
 dhMainForm.Act.MySiz.DoInval(true);
 try
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 with TdhCustomPanel(Selection[i]).ActStyle do
 begin
  FontSize:=EmptyStr;
  FontFamily:=EmptyStr;
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

procedure TTabs.InstallDefaultFont;
var p:TdhPage;
begin
{ p:=(TControl(Selection[0]).Owner as TPageContainer).MySiz.FindBody;
 if p<>nil then
 begin
  if (p.ActStyle.FontFamily=EmptyStr) then
   p.Font.Name:=FuncSettings.DefaultFont.Name;
  if (p.ActStyle.FontSize=EmptyStr) then
   p.Font.Size:=FuncSettings.DefaultFont.Size;
 end;
 }
end;



function TTabs.IsFontCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if result then
 if TObject(Selection[i]) is TdhCustomPanel then
 with TdhCustomPanel(Selection[i]).ActStyle do
 begin
  result:=(FontSize=EmptyStr) and (FontFamily=EmptyStr) and (FontStyle=cfsInherit) and
          (FontWeight=cfwInherit) and (TextDecoration=[]) and (Color=colInherit) and
          (BackgroundColor=colInherit);
 end else
 if TObject(Selection[i]) is TControl then
  result:=TFakeControl(Selection[i]).ParentFont and TFakeControl(Selection[i]).ParentColor;
end;


procedure TTabs.dhAnchor3Click(Sender: TObject);
begin
 if OpenPictureDialog1.Execute then
  LoadImage(OpenPictureDialog1.FileName);
end;

procedure TTabs.LoadImage(URL:TPathName);
begin          
 CommitChanges;
 ActStyle.LoadImage(URL);
 LiveBackgroundChanged;
 Changed('Define Image');
end;


procedure TTabs.LiveBackgroundChanged;
var i:integer;
begin
 for i:=1 to Selection.Count-1 do
 begin
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.AssignBackground(ActStyle);
  (TObject(Selection[i]) as TdhCustomPanel).ImageType:=(TObject(Selection[0]) as TdhCustomPanel).ImageType;
 end;
 UpdateBackgroundDisplay;
end;


function TTabs.IsImageCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
  result:=(TObject(Selection[i]) as TdhCustomPanel).ActStyle.IsBGImageCleared and
          (((TObject(Selection[i]) as TdhCustomPanel).ActStyle<>(TObject(Selection[i]) as TdhCustomPanel).Style) or ((TObject(Selection[i]) as TdhCustomPanel).ImageType=bitInherit));
end;

procedure TTabs.bClearBackgroundClick(Sender: TObject);
begin
 ActStyle.BackgroundImage.Assign(nil);
 ActStyle.BackgroundPosition:=EmptyStr;
 ActStyle.BackgroundRepeat:=cbrInherit;
 ActStyle.BackgroundAttachment:=cbaInherit;
 (TObject(Selection[0]) as TdhCustomPanel).ImageType:=bitInherit;
 LiveBackgroundChanged;
 Changed('Reset Image');
end;

procedure TTabs.BuildBGPos(Clear:boolean);
begin
 if Clear then
  ActStyle.BackgroundPosition:=EmptyStr else
  ActStyle.BackgroundPosition:=inttostr(spBGX.Value)+IGNORE_dhComboBoxX.Text+' '+inttostr(spBGY.Value)+IGNORE_dhComboBoxY.Text;
 LiveBackgroundChanged;
end;


procedure TTabs.cBoldClick(Sender: TObject);
var FontStyles:TFontStyles;
    i:integer;
begin
 if Adjusting then exit;

 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
  if TObject(Selection[i]) is TdhCustomPanel then
  begin
   TdhCustomPanel(TObject(Selection[i])).Bold:=cBold.Checked;
   TdhCustomPanel(TObject(Selection[i])).Italic:=cItalic.Checked;
   TdhCustomPanel(TObject(Selection[i])).Underline:=cUnderline.Checked;
   TdhCustomPanel(TObject(Selection[i])).LineThrough:=cLineThrough.Checked;
   TdhCustomPanel(TObject(Selection[i])).Overline:=cOverline.Checked;
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

 //if i1<>i2{not ActPn.SetTextDecoration(cUnderline.Checked,cLineThrough.Checked,cOverline.Checked,ActPn.Blink)} then
 if (TObject(Selection[0]) is TdhCustomPanel) then
 if (ActPn.Bold<>cBold.Checked) or (ActPn.Italic<>cItalic.Checked) or (ActPn.Underline<>cUnderline.Checked) or (ActPn.LineThrough<>cLineThrough.Checked) or(ActPn.Overline<>cOverline.Checked) then
  Showmessage(DKFormat(DELETEINHERITEDERROR));

 UpdateFontDisplay;
 Changed('Change Font Styles');
end;

procedure TTabs.cNoneClick(Sender: TObject);
var SampleAnchors:TAnchors;
begin
 if Adjusting then exit;
 Adjusting:=True;

 if not cNone.Checked then
 begin
  caLeft.Checked:=cLeft.Checked or cTop.Checked or cBottom.Checked or cClient.Checked;
  caRight.Checked:=cRight.Checked or cTop.Checked or cBottom.Checked or cClient.Checked;
  caTop.Checked:=cTop.Checked or cLeft.Checked or cRight.Checked or cClient.Checked;
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

 //SamplePosition.Center:=cCenter.Checked;
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

procedure ForceBounds(c:TControl; ALeft, ATop, AWidth, AHeight: Integer);
var pn:TdhCustomPanel;
begin
 if c is TdhCustomPanel then
 begin
 pn:=TdhCustomPanel(c);
 if  not (csLoading in pn.ComponentState) and not (csReading in pn.ComponentState) and (pn.Parent<>nil) then
  pn.WeakToStrong(true, ALeft, ATop, AWidth, AHeight);
 end;
 c.SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TTabs.LivePositionChanged(Sender:TObject);
var i:integer;
    rct:TRect;
    pn:TControl;
    _Left,_Top,_Width,_Height:integer;
begin

 dhMainForm.Act.MySiz.DoInval(true);
 try
 //trigger possible exception before modifing anything
 _Left:=spLeft.Value;
 _Top:=spTop.Value;
 _Width:=spWidth.Value;
 _Height:=spHeight.Value;  

 dhMainForm.Act.MySiz.ChildrenDisableAlign;
 try

 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TControl then
 if not ((TObject(Selection[i]) is TdhPage) and TdhPage(Selection[i]).IsTopScrollable and (SamplePosition.Align<>alClient)) then
 begin
  pn:=TControl(Selection[i]);

  ForceBounds(pn,pn.Left,pn.Top,pn.Width,pn.Height); //update right/bottom before setting akRight/akBottom
  pn.Anchors:=SamplePosition.Anchors;
  {if pn is TdhCustomPanel then
   TdhCustomPanel(pn).Center:=SamplePosition.Center; }
  pn.Align:=SamplePosition.Align;

  if (Sender=spLeft) then
   rct:=GetBoundsFor(pn,(_Left-AbsIncr(pn).X)-pn.Left,0,0,0) else
  if Sender=spTop then
   rct:=GetBoundsFor(pn,0,(_Top-AbsIncr(pn).Y)-pn.Top,0,0) else
  if Sender=spWidth then
   rct:=GetBoundsFor(pn,0,0,_Width-pn.Width,0) else
  if Sender=spHeight then
   rct:=GetBoundsFor(pn,0,0,0,_Height-pn.Height) else
   continue;
  ForceBounds(pn,rct.Left,rct.Top,rct.Right-rct.Left,rct.Bottom-rct.Top);
 end;

 finally
  dhMainForm.Act.MySiz.ChildrenEnableAlign;
 end;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdatePositionDisplay;
end;



function GetComp(c:TControl):TComponent;
begin
 result:=nil;

 if c is TdhHTMLForm then
  result:=dhMainForm.mForm else
 if c is TdhRadioButton then
  result:=dhMainForm.mRadiobutton else
 if c is TdhCheckBox then
  result:=dhMainForm.mCheckbox else
 if c is TdhEdit then
  result:=dhMainForm.mEditfield else
 if c is TdhMemo then
  result:=dhMainForm.mTextarea else

 if (c is TdhSelect) and (TdhSelect(c).SelectType=stDropDown) then
  result:=dhMainForm.mCombobox else
 if (c is TdhSelect) and (TdhSelect(c).SelectType=stList) then
  result:=dhMainForm.mListbox else

 if c is TdhFileField then
  result:=dhMainForm.mFilefield else
 if c is TdhHiddenField then
  result:=dhMainForm.mHiddenfield else


 if c is TdhDirectHTML then
  result:=dhMainForm.compDirectHTML else
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
 if c is TdhFile then
  result:=dhMainForm.compFile else
 if c is TdhPanel then
  result:=dhMainForm.compPanel;

end;



procedure TTabs.UpdateNameDisplay;
var c:TControl;
    cc:TComponent;
    ImageIndex:integer;
    Image:TIcon;
begin           
 if DoNotUpdateDisplay then exit;

 if TObject(Selection[0]) is TdhCustomPanel then
  eTooltip.StoredText:=TdhCustomPanel(Selection[0]).Tooltip else
 if TObject(Selection[0]) is TControl then
  eTooltip.StoredText:=TControl(Selection[0]).Hint;


 SetChildrenEnabled(Label19,Selection.Count=1);
 SetChildrenEnabled(eName,Selection.Count=1);
 if eName.Enabled then
 begin
 c:=TObject(Selection[0]) as TControl;
 eName.StoredText:=c.Name;
 ImageIndex:=-1;

 cc:=GetComp(c);
 if cc<>nil then
 if cc is TMenuItem then
 begin
  ImageIndex:=(cc as TMenuItem).ImageIndex;
  IGNORE_Label39.Text:=HypeSubstText('&',EmptyStr,(cc as TTntMenuItem).Caption);
 end else
 begin
  ImageIndex:=(cc as TToolButton).ImageIndex;
  IGNORE_Label39.Text:=HypeSubstText('&',EmptyStr,(cc as TTntToolButton).Hint);
 end;

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
  dhMainForm.ToolBar1.Images.Draw(Image1.Canvas, 0, 0, ImageIndex{, itImage, true});
 end;

 end;

 UpdateStylesDisplay;

end;

{$IFDEF CLX}

function WideCanvasTextWidth(Canvas: TCanvas; const Text: WideString): Integer;
begin
  Result := Canvas.TextWidth(Text);
end;
                     
procedure WideCanvasTextOut(Canvas: TCanvas; X, Y: Integer; const Text: WideString);
begin
  Canvas.TextOut(x,y,Text);
end;

{$ENDIF}


type TFakePC=class (TPageControl);

procedure TTabs.UpdateTabImages;
var ImageList:TCustomImageList;
    Bitmap:TBitmap;
    Bold:Boolean;

procedure AddImage(tab:TTntTabSheet);
var TextWidth:Integer;
begin
 Bitmap.Width:=ImageList.Width;
 Bitmap.Height:=ImageList.Height;
 Bitmap.Canvas.Brush.Style:=bsSolid;
 Bitmap.Canvas.Brush.Color:=clWhite;
 Bitmap.Canvas.FillRect(Rect(0,0,Bitmap.Width,Bitmap.Height));
 Bitmap.Canvas.Font.Assign(PageControl1.Font);
 if Bold then
  Bitmap.Canvas.Font.Style:=Bitmap.Canvas.Font.Style+[fsBold];
 tab.Caption:='';
{$IF CompilerVersion >= 21}
 TextWidth:=Bitmap.Canvas.TextWidth(tab.Hint);
{$ELSE}
 TextWidth:=WideCanvasTextWidth(Bitmap.Canvas,tab.Hint);
{$IFEND}
 {if Bold and (TextWidth>ImageList.Width) then
 begin
  //Bitmap.Canvas.Font.Size:=Bitmap.Canvas.Font.Size-2;
  //Bitmap.Canvas.Font.Style:=Bitmap.Canvas.Font.Style-[fsBold]+[fsUnderline];
  //TextWidth:=WideCanvasTextWidth(Bitmap.Canvas,tab.Hint); //Bitmap.Canvas.TextWidth(tab.Hint);
 end;  }
{$IF CompilerVersion >= 21}
 Bitmap.Canvas.TextOut((ImageList.Width-TextWidth) div 2,0,tab.Hint);
{$ELSE}
 WideCanvasTextOut(Bitmap.Canvas,(ImageList.Width-TextWidth) div 2,0,tab.Hint);
{$IFEND}
 ImageList.AddMasked(Bitmap,Bitmap.Canvas.Brush.Color);
end;

var i:integer;
    OldImageList:TCustomImageList;
begin
 Bitmap:=TBitmap.Create;
 try
 ImageList:=TImageList.Create(Self);
 ImageList.Width:=49;
 ImageList.Height:=13;
 for Bold:=False to True do
 begin
 AddImage(AnchorFont);
 AddImage(AnchorBorder);
 AddImage(AnchorBackground);
 AddImage(AnchorMisc);
 AddImage(AnchorEffects);
 end;
 OldImageList:=PageControl1.Images;
 PageControl1.Images:=ImageList;
 OldImageList.Free;
 finally
  Bitmap.Free;
 end;
end;

//pre: not dhMainForm.Act.IsLiveModified
procedure TTabs.UpdateSel;

function HasCommon(ts:TTntTabSheet; c:Tclass; LookParent:boolean=false; menuitem:TMenuItem=nil; OnlyOne:boolean=false{; NotHide:boolean=false}{; AssertIsImage:boolean=false; IsImage:boolean=false}{; NotFrom:Tclass=nil}):boolean;
var i:integer;
    ws:TCaption;
begin
 result:=(Selection.Count<>0);
 for i :=0 to Selection.Count-1  do
 if not (csDestroying in TComponent(Selection[i]).ComponentState) and not (TObject(Selection[i]).InheritsFrom(c) and
 not((ts<>nil) and (ts.PageIndex<PAGE_STYLES) and ((TObject(Selection[i]) is TdhPageControl) or (TObject(Selection[i]) is TdhStyleSheet) or (TObject(Selection[i]) is TdhHiddenField))) and
 not((ts=AnchorText) and (TObject(Selection[i]) is TdhEdit)) or LookParent and GetVirtualParent(TObject(Selection[i]) as TControl).InheritsFrom(c))
 (* or ((TObject(Selection[i]) is TdhPageControl) and not ((ts=AnchorName) or (ts=AnchorPageControl))){ or AssertIsImage and (IsImage<>(TObject(Selection[i]) as TdhCustomPanel).IsImage)}*) then
 begin
  result:=false;
  break;
 end;
 if {not NotHide or }{Result}true then
 begin
  {if Result then
  if (ts=AnchorFont) or (ts=AnchorBorder) or (ts=AnchorBackground) or (ts=AnchorEffects) or (ts=AnchorMisc) then
  begin
  if (ts=AnchorFont) and not IsFontCleared or (ts=AnchorBorder) and not IsAllEdgeCleared or (ts=AnchorBackground) and not IsImageCleared or (ts=AnchorEffects) and not IsEffectsCleared or (ts=AnchorMisc) and not IsAllMoreCleared  then
   ts.ImageIndex:=ts.ImageIndex mod 5 + 5 else
   ts.ImageIndex:=ts.ImageIndex mod 5;

  end; }
  if ts<>nil then
  if Result and ts.Visible and Assigned(ts.OnShow) then
  begin
   ts.OnShow(nil);
  end else
  begin
   if not result then
   if PageControl1.ActivePage=ts then
    PageControl1.ActivePage:=nil; //prevents activating next page
   ts.TabVisible:=result;

   {if result then
   begin
    ts.Caption:=ts.Caption;
   end;}
  end;
   if result then
   begin
    //captions are not aligned correctly
    ws:=ts.Caption;
    ts.Caption:=ws+' ';
    ts.Caption:=ws;
   end;

 end;
 if (menuitem<>nil){ and Assigned(menuitem.OnClick)} then
  menuitem.Visible:=result and not (OnlyOne and (Selection.Count<>1));
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

 //PageControl1.DisableAlign;
// LockWindowUpdate(dhMainForm.Handle);
 try

  Selection.Clear;
  if dhMainForm.Act<>nil then
  begin
   if dhMainForm.Act.IsLiveModified then
   begin
    ShowMessage(DKFormat(NONCRITICALERROR,'UpdateSel/IsLiveModified:'+dhMainForm.Act.LiveReason));
    dhMainForm.Act.SetModified(dhMainForm.Act.LiveReason,lcAbort);
    //assert(not dhMainForm.Act.IsLiveModified,'IsLiveModified');
   end;
   dhMainForm.Act.MySiz.AddSel(Selection);
  end;
  if Selection.Count<>0 then
  begin
   dhMainForm.cbName.ItemIndex:=dhMainForm.cbName.Items.IndexOf(TComponent(Selection[0]).Name);
   if ObjectExplorer<>nil then
    ObjectExplorer.UpdateSelection;
  end else
   dhMainForm.cbName.ItemIndex:=-1;
  //dhMainForm.ToolBar1.DoubleBuffered:=true;
  //np:=dhMainForm.stateNormal.Left+dhMainForm.stateNormal.Width;
  //dhMainForm.dhPureHTML1.Left:=1000;

  AllowStates:=(Selection.Count<>0);
  for i:=0 to Selection.Count-1 do
    AllowStates:=AllowStates and (TObject(Selection[0]) is TdhDynLabel);
  //AllowStates:=AllowStates or (Selection.Count=0) or (TObject(Selection[0]) is TdhPage);
  dhMainForm.ToolBar1.DisableAlign;
  try
   dhMainForm.stateOverDown.Visible:=AllowStates;
   dhMainForm.stateOver.Visible:=AllowStates;
   dhMainForm.stateDown.Visible:=AllowStates;
   //dhMainForm.UpdateStateClearing;
  finally
   dhMainForm.ToolBar1.EnableAlign;
  end;
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

 InvTabs;

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
 if HasCommon(AnchorMenu,TdhMenu,true,mMenu,true) then
 begin
 end;
 if HasCommon(AnchorOle,TdhOleContainer,false,mOle) then
 begin
 end;
 if HasCommon(AnchorFile,TdhFile,false,mLoadFromFile) then
 begin
 end;
 if HasCommon(nil,TdhStylesheet,false,mLoadStylesheet) then
 begin
 end;
 if dhMainForm.compMenu.Visible then
  HasCommon(AnchorLink,TdhLink,false,mSubMenu,true) else
  HasCommon(AnchorLink,TdhLink);
 if HasCommon(AnchorText,TdhLabel,false,mText) then
 begin
 end;
 if HasCommon(AnchorHidden,TdhHiddenField) then
 begin
 end;
 if HasCommon(AnchorMisc,TdhCustomPanel) then
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
 if HasCommon(AnchorPureHTML,TdhDirectHTML) then
 begin
 end;
 if HasCommon(AnchorCheckBox,TdhCheckBox) then
 begin
  UpdateCheckboxDisplay; //da AnchorCheckBox.Caption wechselt
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
 begin
  if PageControl1.ActivePage<>LastAct then
   PageControl1.ActivePage:=LastAct;
 end else
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
   mGotoUse.Enabled:=(FirstCandidate is TdhCustomPanel) and (TdhCustomPanel(FirstCandidate).Use<>nil);
   mGotoLink.Enabled:=(FirstCandidate is TdhLink) and (TdhLink(FirstCandidate).LinkPage<>nil);
   mGotoFragment.Enabled:=(FirstCandidate is TdhLink) and (TdhLink(FirstCandidate).LinkAnchor<>nil);
   mGotoMenu.Enabled:=(FirstCandidate is TdhLink) and (TdhLink(FirstCandidate).SubMenu<>nil);
   mGoto.Enabled:=mGotoUse.Enabled or mGotoLink.Enabled or mGotoFragment.Enabled or mGotoMenu.Enabled;
   if mGoto.Enabled then
   begin
    mGotoUse.Visible:=mGotoUse.Enabled;
    mGotoLink.Visible:=mGotoLink.Enabled;
    mGotoFragment.Visible:=mGotoFragment.Enabled;
   end;
   mStyleInfo.Enabled:=(FirstCandidate is TdhCustomPanel);
   mPageProperties.Enabled:=(FirstCandidate is TdhPage) and (TdhPage(FirstCandidate).IsHTMLBody or (TdhPage(FirstCandidate).PageControl<>nil));
 end;
 mStyles.Enabled:=AnchorBorder.TabVisible;

 UpdateContainer;
{$IFDEF CLX}
 PageControl1.Realign; //Font tab is hidden
 TFakePC(PageControl1).UpdateActivePage;
{$ENDIF}
 finally
  //PageControl1.EnableAlign;
//  LockWindowUpdate(0);
 end;

{ with Tabs do
 for i:=0 to PageControl1.PageCount-1 do
 begin
  s:=PageControl1.Pages[i].Caption;
  PageControl1.Pages[i].Caption:=s+' ';
  PageControl1.Pages[i].Caption:=s;
 end;}
end;

function IsFloating:boolean;
begin      
 result:=PropsAlign in [alNone,alClient];
end;

destructor TTabs.Destroy;
begin
  if not IsFloating then
  begin
   PropsAlign:=alNone;
   UpdateAlign;
  end;
  //PageControl1.ActivePage:=nil;
  FreeAndNil(Selection);
  inherited;
end;

procedure TTabs.Changed(const Reason:TReason; LogChange:TLogChange=lcCommit);
begin
 if dhMainForm.Act=nil then exit; //after design form is closed, edit control may be de-focused later
 dhMainForm.Act.SetModified(Reason,LogChange);
 dhMainForm.Update;
end;


procedure TTabs.dhAnchor4Click(Sender: TObject);
var backup:TObjectList<TStyle>;
    backupItem:TStyle;
    i:integer;
    pn:TdhCustomPanel;
    backupImageType:array of TImageType;
begin
 LateCreateForm(TGradientWizard,GradientWizard);
 backup:=TObjectList<TStyle>.Create;
 SetLength(backupImageType,Selection.Count);
 GradientWizard.LivePreview:=TList.Create;
 try
 backup.OwnsObjects:=true;
 for i:=0 to Selection.Count-1 do
 begin
  pn:=TObject(Selection[i]) as TdhCustomPanel;
  GradientWizard.LivePreview.add(pn.ActStyle);
  backupItem:=TStyle.Create(nil,hsNormal);
  backupItem.Assign(pn.ActStyle);
  backup.Add(backupItem);
  backupImageType[i]:=pn.ImageType;
 end;
 with {ActPn.BorderClientRect}ActPn.ScrollArea do
 GradientWizard.Prepare(ActPn,Right-Left,Bottom-Top);
 if GradientWizard.ShowModal=mrOk then
 begin
  LiveBackgroundChanged;
  Changed('Image From Gradient');
 end else
 begin
  for i:=0 to Selection.Count-1 do
  begin
   pn:=TObject(Selection[i]) as TdhCustomPanel;
   pn.ActStyle.Assign(backup[i]);
   pn.ImageType:=backupImageType[i];
  end;
 end;
 finally
  FreeAndNil(GradientWizard.LivePreview);
  backup.Free;
 end;
end;

function TTabs.ChooseTwice(i:integer; c:TClass):TControl;
begin
 if TObject(Selection[i]).InheritsFrom(c) then
  result:=TObject(Selection[i]) as TControl else
  result:=GetVirtualParent(TObject(Selection[i]) as TControl);
end;


procedure TTabs.dhAnchor8Click(Sender: TObject);
var gpc:TdhPageControl;
begin
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 gpc.AddSheet;
// SetControlTo(gpc.ActivePage,true,true);
 AnchorPageControlShow(nil);
 (gpc.Owner as TPageContainer).MySiz.SetControlTo(gpc.Pages[vs.ItemIndex{FocusedNode.Index}],true,true);
 Changed('Page Control');
end;


procedure TTabs.AnchorPageControlShow(Sender: TObject);
var i:integer;
    //Node:PVirtualNode;
    WasFocused:boolean;
var gpc:TdhPageControl;
begin            
 if DoNotUpdateDisplay then exit;
 Adjusting:=true;
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 //WasFocused:=vs.FocusedNode<>nil;
 cFixedHeight.Checked:=gpc.FixedHeight;
 cDynamicNavigation.Checked:=not gpc.DynamicNavigation;

 vs.Clear;
 for i:=0 to gpc.PageCount-1 do
 begin
  vs.Items.Add(gpc.Pages[i].Name);
  if gpc.Pages[i].IsActivePage then
   vs.ItemIndex:=i;
  //vs.ItemIndex:=gpc.ActivePageIndex;

 end;
 bDeletePage.Enabled:=vs.ItemIndex>=0;
 bMovePageUp.Enabled:=vs.ItemIndex>=0;//>0;
 bMovePageDown.Enabled:=vs.ItemIndex>=0;//<vs.Count-1;

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


procedure TTabs.dhAnchor11Click(Sender: TObject);
var gpc:TdhPageControl;
begin
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 if {vs.FocusedNode=nil}vs.ItemIndex<0 then
 begin
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

procedure TTabs.dhAnchor9Click(Sender: TObject);
var i:integer;
var gpc:TdhPageControl;
begin
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 if {vs.FocusedNode=nil}vs.ItemIndex<0 then
 begin
  exit;
 end;
 i:=gpc.Pages[{vs.FocusedNode.Index}vs.ItemIndex].PageIndex;
 if Sender=bMovePageUp then
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


procedure TTabs.AnchorLinkShow(Sender: TObject);
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
 result:=not (match as TdhPage).IsInternalScrollable;
end;

procedure TTabs.UpdateLinkDisplay;
var c:TdhLink;
begin               
 if DoNotUpdateDisplay then exit;
 Adjusting:=true;
 c:=TObject(Selection[0]) as TdhLink;

 GetRefs_(cbLinkPage,TdhPage,c,c.LinkPage,AcceptableLinkPage,not true);
 if cbLinkPage.Text=EmptyStr then cbLinkPage.StoredText:=c.SLinkPage;
 GetRefs_(cbLinkAnchor,TdhCustomPanel,c,c.LinkAnchor,AcceptableLinkAnchor,not true);
 if cbLinkAnchor.Text=EmptyStr then cbLinkAnchor.StoredText:=c.SLinkAnchor;

 CODE_eLink.StoredText:=c.Link;
 CODE_eTarget.StoredText:=c.Target;
 //bChangeLink.Left:=lLink.Left+lLink.Width+5;
 //cbLinkType.ItemIndex:=Integer(c.LinkType);
 cLinkLayout.ItemIndex:=Integer(c.Layout);
 cLinkForm.ItemIndex:=Integer(c.FormButtonType);
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

procedure TTabs.LinkChanged;
begin
 UpdateLinkDisplay;
 Changed('Link');
end;


procedure TTabs.cbLinkTypeClick(Sender: TObject);
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

procedure TTabs.dhAnchor13Click(Sender: TObject);
var i:integer;
begin               {
 if OpenPictureDialog1.Execute then
 begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhLink).ActStyle.LoadImage(OpenPictureDialog1.FileName);
  Changed('image');
 end;          }
end;

procedure TTabs.dhAnchor14Click(Sender: TObject);
var Picture:TPicture;
begin                        {
 if SavePictureDialog1.Execute then
 if (TObject(Selection[0]) as TdhLink).HasImage(Picture) then
  Picture.SaveToFile(SavePictureDialog1.FileName); }
end;

procedure TTabs.dhAnchor15Click(Sender: TObject);
var i:integer;
begin                                      {
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TMemo).Caption:=eMemo.Text;
  dhMainForm.Act.MySiz.DoInval(false);
  Changed('memo');                          }
end;

procedure TTabs.cAutoXClick(Sender: TObject);
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
 if (TObject(Selection[i]) is TdhFile) or (TObject(Selection[i]) is TdhDirectHTML) or (TObject(Selection[i]) is TdhOleContainer) or (TObject(Selection[i]) is TdhCustomLabel) or (TObject(Selection[i]) is TdhMenu) then
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

procedure TTabs.dhAnchor26Click(Sender: TObject);
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


procedure TTabs.WriteTransformations(tt: TTransformations);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Effects.Assign(tt);
end;

function GoodAngle(Value:integer):integer;
begin
  result:=Value mod 360;
  if result<0 then
   result:=result+360;
end;

procedure TTabs.spAngleChange(Sender: TObject);
begin
 spAngle.Value:=GoodAngle(spAngle.Value);
end;

function TTabs.getblur(tt:TTransformations; i:integer=-1):TBlurEffect;
begin
 if i=-1 then
  i:=BlurIndex;
 Case i of
 0: result:=tt.OuterShadow;
 1: result:=tt.InnerShadow;
 2: result:=tt.OuterGlow;
 3: result:=tt.InnerGlow;
 else result:=tt.Blur;
 end;
end;


procedure TTabs.BuildTransformations;
begin
 if Adjusting then exit;
 LiveBuildTransformations;
 Changed('Effects');
end;

procedure TTabs.LiveBuildTransformations;
var tt:TTransformations;
    blur:TBlur;
begin
 if Adjusting then exit;
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
 tt.TextExclude:=cExcludeText.Checked;
 tt.Alpha:=Adj100to255(spMasterAlpha.Value);
 with getblur(tt) do
 begin
  Alpha:=Adj100to255(spBlurAlpha.Value);
  Color:=cpBlurColor.CSSColor;
  DeciRadius:=spBlurRadius.Value;
  Flood:=spBlurFlood.Value;
  Distance:=spBlurDistance.Value;
  Degree:=NormalizeDegree(spBlurDegree.Value);
  Enabled:=cBlurEnabled.Checked;
 end;
 WriteTransformations(tt);
 tt.Free;
 UpdateEffectsDisplay2;
end;


procedure TTabs.UpdateEffectsDisplay2;
var i:integer;
    Bluring:boolean;
begin
 Bluring:=false;
 for i:=0 to dhPanel4.ControlCount-1 do
 begin
  (dhPanel4.Controls[i] as TdhLink).Down:=i=BlurIndex;
  SetUnderlineState(dhPanel4.Controls[i] as TdhLink,not getblur(ActStyle.Effects,i).Enabled);
  Bluring:=Bluring or getblur(ActStyle.Effects,i).Enabled;
 end;
 SetUnderlineState(EffectsMain,ActStyle.Effects.IsMainCleared);
 SetUnderlineState(EffectsBlur,{ActStyle.Effects.IsBlurEffectsCleared}not Bluring);
 SetUnderlineState(EffectsTransformations,ActStyle.Effects.IsTransformationsCleared);
 SetUnderlineState(EffectsMain2,ActStyle.Effects.IsMainCleared);
 SetUnderlineState(EffectsBlur2,{ActStyle.Effects.IsBlurEffectsCleared}not Bluring);
 SetUnderlineState(EffectsTransformations2,ActStyle.Effects.IsTransformationsCleared);
 SetClearState(bClearEffects,IsEffectsCleared);
end;

procedure TTabs.UpdateEffectsDisplay;
var tt:TTransformations;
    ShadowExt,GlowExt:boolean;
begin
 if DoNotUpdateDisplay then exit;
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
 cExcludeText.Checked:=tt.TextExclude;

 ShadowExt:=BlurIndex<=1;
 lDistance.Visible:=ShadowExt;
// lDistanceUnit.Visible:=ShadowExt;
 lDegree.Visible:=ShadowExt;
 //lDegreeUnit.Visible:=ShadowExt;
 spBlurDistance.Visible:=ShadowExt;
 spBlurDegree.Visible:=ShadowExt;
 slBlurDistance.Visible:=ShadowExt;
 slBlurDegree.Visible:=ShadowExt;

 GlowExt:=BlurIndex<=3;
 cpBlurColor.Visible:=GlowExt;
// lOpacityUnit.Visible:=GlowExt;
 lOpacity.Visible:=GlowExt;
 spBlurAlpha.Visible:=GlowExt;
 spBlurFlood.Visible:=GlowExt;
 slBlurAlpha.Visible:=GlowExt;
 slBlurFlood.Visible:=GlowExt;
// spFloodUnit.Visible:=GlowExt;
 lFlood.Visible:=GlowExt;
 
 with getblur(tt) do
 begin
  spBlurAlpha.StoredValue:=Adj255to100(Alpha);
  cpBlurColor.CSSColor:=Color;
  spBlurRadius.StoredValue:=DeciRadius;
  spBlurFlood.StoredValue:=Flood;
  spBlurDistance.StoredValue:=Distance;
  spBlurDegree.StoredValue:=Degree;
  cBlurEnabled.Checked:=Enabled;
 end;


 UpdateEffectsDisplay2;

 Adjusting:=false;
end;

function TTabs.IsEffectsCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
  result:=(TObject(Selection[i]) as TdhCustomPanel).ActStyle.Effects.IsCleared;
end;


procedure TTabs.cRenderClick(Sender: TObject);
begin
 BuildTransformations;
end;

procedure TTabs.cpFontColorBackup(Sender: TObject; backup: TList;
  restore: Boolean);
var i:integer;
begin
 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
  if restore then
   AssignSingleFontColor(TControl(Selection[i]),TCSSColor(backup[i])) else
   backup.add(Pointer(GetSingleFontColor(TControl(Selection[i]))));
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end
end;

procedure TTabs.cpFontColorColorChanged(Sender: TObject);
begin
 if Adjusting then exit;
 AssignFontColor;
 UpdateFontDisplay;
 Changed('Change Font Color');
end;

procedure TTabs.cpFontColorPreviewColorChanged(Sender: TObject);
begin
 AssignFontColor;
end;

procedure TTabs.AssignFontColor;
var i:integer;
begin
 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
   AssignSingleFontColor(TControl(Selection[i]),cpFontColor.CSSColor);
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end
end;

procedure TTabs.AssignSingleFontColor(Control:TControl; Color:TCSSColor);
var i:integer;
begin
 if Control is TdhCustomPanel then
  TdhCustomPanel(Control).ActStyle.Color:=Color else
  TFakeControl(Control).Font.Color:=CSSColorToColor(Color);
end;


procedure TTabs.cpBackgroundColorBackup(Sender: TObject; backup: TList;
  restore: Boolean);
var i:integer;
begin
 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
  if restore then
   AssignSingleBackgroundColor(TControl(Selection[i]),TCSSColor(backup[i])) else
   backup.add(Pointer(GetSingleBackgroundColor(TControl(Selection[i]))));
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end
end;

procedure TTabs.cpBackgroundColorPreviewColorChanged(Sender: TObject);
begin
 AssignBackgroundColor(Sender);
end;

procedure TTabs.cpBlurColorBackup(Sender: TObject; backup: TList;
  restore: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with getblur((TObject(Selection[i]) as TdhCustomPanel).ActStyle.Effects) do
 if restore then
  Color:=TCSSColor(backup[i]) else
  backup.add(Pointer(Color));
end;

procedure TTabs.cpBlurColorPreviewColorChanged(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with getblur((TObject(Selection[i]) as TdhCustomPanel).ActStyle.Effects) do
  Color:=cpBlurColor.CSSColor;
end;

procedure TTabs.cpBorderColorBackup(Sender: TObject; backup: TList;
  restore: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Borders[EdgeAlign] do
 if restore then
  Color:=TCSSColor(backup[i]) else
  backup.add(Pointer(Color));
end;

procedure TTabs.cpBorderColorColorChanged(Sender: TObject);
begin
  ActStyle.Borders[EdgeAlign].Color:=cpBorderColor.CSSColor;
 LiveBorderChanged;
 Changed('Border Color');
end;

procedure TTabs.cpBorderColorPreviewColorChanged(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Borders[EdgeAlign].Color:=cpBorderColor.CSSColor;
end;

procedure TTabs.ClearAllStyles(ClearUse:boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ClearAllStyles(ClearUse);
end;


function FilterUse(match,ori:TControl):boolean;
var pn:TdhCustomPanel;
begin
 result:=UsefulUse(match,ori,false,pn) or ((ori as TdhCustomPanel).UsePn=match);
end;

procedure TTabs.UpdateStylesDisplay;
var sl:TStringList;
    i:integer;
begin
 if not _Showing then exit;
 Adjusting:=true;

 SetChildrenEnabled(GroupBox18,TObject(Selection[0]) is TdhCustomPanel);
 SetChildrenEnabled(cImageFormat,TObject(Selection[0]) is TdhCustomPanel);
 if cImageFormat.Enabled then
 begin
  cImageFormat.ItemIndex:=Integer(ActPn.ImageFormat);
 end;
 if TObject(Selection[0]) is TdhCustomPanel then
 begin

 cDownOverlayOver.Enabled:=(ActPn is TdhDynLabel) and (ActPn.Use=nil);
 cOverOverlayDown.Enabled:=cDownOverlayOver.Enabled;
 cDownOverlayOver.Checked:=(ActPn is TdhDynLabel) and TdhDynLabel(ActPn).PreferDownStyles and cDownOverlayOver.Enabled;
 cOverOverlayDown.Checked:=not cDownOverlayOver.Checked and cOverOverlayDown.Enabled;
// cExtendedUse.Checked:=ActPn.ExtendedUse;

 //cClearStyles:=



 GetRefs_(cbUse,TdhCustomPanel,ActPn,ActPn.UsePn,FilterUse,not true);
 if cbUse.Text=EmptyStr then cbUse.StoredText:=ActPn.SUse;
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

procedure TTabs.StylesChanged;
begin
 Changed('Styles');
end;

procedure TTabs.EditText;
var
  Temp: HypeString;
  i:integer;
  Stored:array of HypeString;
begin

  LateCreateForm(TdhMultilineCaptionEdit2,dhMultilineCaptionEdit2);
  dhMultilineCaptionEdit2.Memo1.PopupMenu:=dhMainForm.mEditorPopupMenu;

  if TdhMultilineCaptionEdit2.Prepare2({GetComponent(0) as TdhLabel,}Selection) then
  begin
  SetLength(Stored,Selection.Count);
  for i:=0 to Selection.Count-1 do
   Stored[i]:=TdhLabel(Selection[i]).Text;

  for i:=0 to dhMainForm.Act.ComponentCount-1 do
   dhMultilineCaptionEdit2.VisitProc(dhMainForm.Act.Components[i]);
  //Temp:=EmptyStr;
  if dhMultilineCaptionEdit2.Execute(Temp,vn) then
  begin
   for i:=0 to Selection.Count-1 do
    TdhLabel(Selection[i]).Text:=Temp;
   UpdateTextDisplay;
   Changed('Edit Text');
  end else
  begin
   for i:=0 to Selection.Count-1 do
    TdhLabel(Selection[i]).Text:=Stored[i];
  end;
  //(GetComponent(0) as TdhLabel).Text:=Temp;

 end;

end;


procedure TTabs.Button8Click(Sender: TObject);
begin
 EditText;
end;

function TTabs.GetComponent(Index: Integer): TPersistent;
begin
 result:=TPersistent(Selection[Index]);
end;

procedure TTabs.AnchorEffectsShow(Sender: TObject);
begin
 UpdateEffectsDisplay;
end;

procedure TTabs.Button3Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 if not (TObject(Selection[i]) as TdhCustomPanel).ActStyle.CopyBlurEffectsByInherited then
  showmessage('No inherited values found');
 UpdateEffectsDisplay;
 BuildTransformations;
end;



procedure TTabs.cClearStylesClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Clear;
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

procedure TTabs.Button10Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (ChooseTwice(i,TdhMenu) as TdhMenu).AddMenuItem;
 Changed('Add Menu Item');
end;

procedure TTabs.mSubMenuClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhLink).AddSubMenu.Visible:=true;  
 Changed('Add Sub Menu');
end;

procedure TTabs.mAlignToGridClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with TMySiz.GetAlignedBounds(TObject(Selection[i]) as TControl) do
  ForceBounds(TObject(Selection[i]) as TControl,Left,Top,Right-Left,Bottom-Top);
 Changed('Align to Grid');
 ActBoundsChanged;
end;

procedure TTabs.mSendToBackClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 //if not((TObject(Selection[i]) as TControl).Parent is TPageContainer) then
  (TObject(Selection[i]) as TControl).SendToBack;
 if ObjectExplorer<>nil then ObjectExplorer.UpdateRootAndSelection;
 Changed('Send to Back');
end;

procedure TTabs.mBringToFrontClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 //if not((TObject(Selection[i]) as TControl).Parent is TPageContainer) then
  (TObject(Selection[i]) as TControl).BringToFront;
 dhMainForm.Act.MySiz.BringToFront; //alle Elemente sollten unter MySiz sein
 if ObjectExplorer<>nil then ObjectExplorer.UpdateRootAndSelection;
 Changed('Bring to Front');
end;

procedure TTabs.cTransparentClick(Sender: TObject);
var OldTrans:boolean;
begin
 if Adjusting then exit;
 OldTrans:=cTransparent.Checked;
 AssignBackgroundColor(Sender);
 UpdateFontDisplay;
 Changed('Change Background Color');

 if (Sender=cTransparent) and (OldTrans<>cTransparent.Checked) then
  showmessage(DKFormat(UNSUPPORTEDSTYLE));
end;

procedure TTabs.AssignBackgroundColor(Sender: TObject);
var i:integer;
begin
 dhMainForm.Act.MySiz.DoInval(true);
 try
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TControl then
 begin
  if Sender=cpBackgroundColor then
  begin
   AssignSingleBackgroundColor(TControl(Selection[i]),cpBackgroundColor.CSSColor);
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
end;

procedure TTabs.AssignSingleBackgroundColor(Control:TControl; Color:TCSSColor);
begin            
 if Control is TdhCustomPanel then
  TdhCustomPanel(Control).ActStyle.BackgroundColor:=Color else
  TFakeControl(Control).Color:=CSSColorToColor(Color);
end;

function TTabs.GetSingleBackgroundColor(Control:TControl):TCSSColor;
begin
 if Control is TdhCustomPanel then
  Result:=TdhCustomPanel(Control).BackgroundColor else
 if not TFakeControl(Control).ParentColor then
  Result:=ColorToCSSColor(TFakeControl(Control).Color) else
  Result:=colTransparent;
end;

function TTabs.GetSingleFontColor(Control:TControl):TCSSColor;
begin  
 if Control is TdhCustomPanel then
  Result:=TdhCustomPanel(Control).FontColor else
  Result:=ColorToCSSColor(TFakeControl(Control).Font.Color);
end;

procedure TTabs.cFixedHeightClick(Sender: TObject);
var gpc:TdhPageControl;
begin
 if Adjusting then exit;
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 gpc.FixedHeight:=cFixedHeight.Checked;
 Changed('Page Control');
end;

procedure TTabs.mSaveImageClick(Sender: TObject);
var pn:TdhCustomPanel;
begin
 IGNORE_SavePictureDialog1.FileName:=EmptyStr;
 if TObject(Selection[0]) is TdhCustomPanel then
 if IGNORE_SavePictureDialog1.Execute then
 begin
  dhMainForm.Act.SetDesigning(false,true);
  pn:=TdhCustomPanel(TObject(Selection[0]));
  pn.SaveAsImage(IGNORE_SavePictureDialog1.FileName);
  dhMainForm.Act.SetDesigning(not _RuntimeMode,true);
 end;
end;


procedure TTabs.AnchorMiscShow(Sender: TObject);
begin
 UpdateMoreDisplay;
end;

function cssinttostr(i:TCSSInteger):TCSSStringValue;
begin
 if i=vsrInherit then
  result:=EmptyStr else
  result:=inttostr(i);
end;

procedure TTabs.UpdateMoreDisplay;
begin
 if DoNotUpdateDisplay then exit;
 cbTextAlign.StoredItemIndex:=GoodIndex(Integer(ActStyle.TextAlign));
 cbWhiteSpace.StoredItemIndex:=GoodIndex(Integer(ActStyle.WhiteSpace));
 cbCursor.StoredItemIndex:=GoodIndex(Integer(ActStyle.Cursor));
 CODE_cbVerticalAlign.StoredText:=ActStyle.VerticalAlign;
 CODE_cbTextIndent.StoredText:=ActStyle.TextIndent;
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


procedure TTabs.cbCursorDrawItem(Control: TWinControl; Index: Integer;
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
     Value:=EmptyStr else
     Value:=cbCursor.Items[GoodIndexBack(Index)];
    DefaultPropertyListDrawValue(Value, cbCursor.Canvas, Classes.Rect(Right, Rect.Top,
      Rect.Right, Rect.Bottom), odSelected in State);
  end;
{$ENDIF}
end;

procedure TTabs.cbCursorMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
{$IFNDEF CLX}
 if Index>=2 then
  Height:=GetSystemMetrics(SM_CYCURSOR) + 4 else
  Height:=15;
{$ENDIF}
end;

           
function WithoutPx(const s:TCSSStringValue):TCSSStringValue;
begin
 if SubEqualEnd('px',s) then
  result:=CopyLess(s,2) else
  result:=s;
end;

procedure TTabs.cDownIfUrlClick(Sender: TObject);
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

procedure TTabs.cbLinkPageDrawItem(Control: TWinControl; Index: Integer;
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

procedure TTabs.cbCursorDrawItemCLX(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
begin
 cbCursorDrawItem(Sender as TWinControl,Index,Rect,State);
 Handled:=true;
end;

procedure TTabs.cbLinkPageDrawItemCLX(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
begin
 cbLinkPageDrawItem(Sender as TWinControl,Index,Rect,State);
 Handled:=true;
end;


procedure TTabs.cbUseDrawItemCLX(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
begin
 cbUseDrawItem(Sender as TWinControl,Index,Rect,State);
 Handled:=true;
end;

procedure TTabs.cbUseDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var pn:TdhCustomPanel;
begin
    cbUse.Canvas.FillRect(Rect);
    if not (TObject(Selection[0]) is TdhCustomPanel) then exit;
    pn:=(TObject(Selection[0]) as TdhCustomPanel);
    if (odComboBoxEdit in State) and (pn.Use=nil) then
    begin
      cbUse.Canvas.Font.Color:=clGray;
      cbUse.Canvas.TextOut(Rect.Left + 2, Rect.Top, pn.SUse);
    end else
    if Index >= 0 then
      cbUse.Canvas.TextOut(Rect.Left + 2, Rect.Top, cbUse.Items[Index]);
end;

procedure TTabs.AnchorMenuShow(Sender: TObject);
begin
 UpdateMenuDisplay;
end;

procedure TTabs.UpdateMenuDisplay();
var c:TdhMenu;
begin         
 if DoNotUpdateDisplay then exit;
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
 GetRefs_(cbParentMenuItem,TdhLink,c,c.ParentMenuItem,nil,true);
 if cbParentMenuItem.ItemIndex=0 then
  cbParentMenuItem.ItemIndex:=-1;
 SetChildrenEnabled(CheckGroupBox1,not c.AutoRelevant);
 //SetChildrenEnabled(GroupBox14,not c.AutoRelevant);
 cInline.Enabled:=not c.AutoRelevant;
 cResumeOpen.Enabled:=not c.AutoRelevant;
 cStatic.Enabled:=not c.AutoRelevant;
 cHorizontalLayout.Enabled:=not c.AutoRelevant;
 Label21.Enabled:=cSlide.Checked and not c.AutoRelevant;
 spSlidePixel.Enabled:=cSlide.Checked and not c.AutoRelevant;
 IGNORE_Label20.Enabled:=cSlide.Checked and not c.AutoRelevant;
 cOpenByOver.Enabled:=not c.AutoRelevant;
 spReactionTime.Enabled:=cOpenByOver.Checked and not c.AutoRelevant;
 IGNORE_Label22.Enabled:=spReactionTime.Enabled;
 Adjusting:=false;
end;

procedure TTabs.MenuChanged;
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

procedure TTabs.AnchorNameShow(Sender: TObject);
begin
 UpdateNameDisplay;
end;

procedure TTabs.AnchorFontShow(Sender: TObject);
begin
 UpdateFontDisplay;
end;

{procedure TPropsPC.AnchorComboBoxShow(Sender: TObject);
begin
 UpdateComboBoxDisplay(false);
end; }

{procedure TPropsPC.AnchorListBoxShow(Sender: TObject);
begin
 UpdateListBoxDisplay(false);
end; }

procedure TTabs.cReadOnlyClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhEdit).ReadOnly:=cReadOnly.Checked;
  Changed('Input Options');
end;

procedure TTabs.AnchorEditShow(Sender: TObject);
begin
 UpdateEditDisplay;
end;

procedure TTabs.UpdateEditDisplay;
begin         
  if DoNotUpdateDisplay then exit;
  Adjusting:=true;
  eEdit.StoredText:=(TObject(Selection[0]) as TdhEdit).Text;
  cReadOnly.Checked:=(TObject(Selection[0]) as TdhEdit).ReadOnly;
  cPassword.Checked:=(TObject(Selection[0]) as TdhEdit).Password;
  Adjusting:=false;
end;

procedure TTabs.UpdateMemoDisplay;
begin
  if DoNotUpdateDisplay then exit;
  Adjusting:=true;
  eMemo.StoredText:=(TObject(Selection[0]) as TdhMemo).Text;
  cMemoReadOnly.Checked:=(TObject(Selection[0]) as TdhMemo).ReadOnly;
  cWrap.Checked:=(TObject(Selection[0]) as TdhMemo).Wrap;
  Adjusting:=false;
end;


procedure TTabs.AnchorCheckBoxShow(Sender: TObject);
begin
 UpdateCheckboxDisplay;
end;

procedure TTabs.UpdateCheckboxDisplay;
var checkbox:TdhCheckBox;
begin         
 if DoNotUpdateDisplay then exit;
 Adjusting:=True;
 checkbox:=TdhCheckBox(TObject(Selection[0]));
 if checkbox is TdhRadioButton then
 begin
//  AnchorCheckBox.Caption:='Radio';
  IGNORE_cRightJustify.Caption:='Caption appears to the right of the radio button';
 end else
 begin
//  AnchorCheckBox.Caption:='Check';
  IGNORE_cRightJustify.Caption:='Caption appears to the right of the check box';
 end;
 rgChecked.ItemIndex:=booltoint(not checkbox.Checked);
 eCheckValue.StoredText:=checkbox.Value;
 IGNORE_cRightJustify.Checked:=checkbox.Alignment=taRightJustify;
 Adjusting:=false;
end;

procedure TTabs.cCheckedClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCheckBox).Checked:=rgChecked.ItemIndex=0;
  Changed(AnchorCheckBox.Caption);
end;

procedure TTabs.IGNORE_cRightJustifyClick(Sender: TObject);
var i:integer;
const GetAlignment:array[boolean] of TLeftRight=(taLeftJustify,taRightJustify);
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCheckBox).Alignment:=GetAlignment[IGNORE_cRightJustify.Checked];
  Changed(AnchorCheckBox.Caption);
end;

procedure TTabs.cDownOverlayOverClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 if (TObject(Selection[0]) as TdhCustomPanel).Use<>nil then
 begin
  //showmessage('Note: This option can only be set if no Use element is assigned');a
  UpdateStylesDisplay;
  exit;
 end;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhDynLabel then
  (TObject(Selection[i]) as TdhDynLabel).PreferDownStyles:=cDownOverlayOver.Checked;
 UpdateStylesDisplay;
 StylesChanged;
end;

procedure TTabs.cExtendedUseClick(Sender: TObject);
var i:integer;
begin
{ if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ExtendedUse:=cExtendedUse.Checked;
 UpdateStylesDisplay;
 StylesChanged;}
end;

procedure TTabs.AnchorBorderShow(Sender: TObject);
begin
 UpdateBorderDisplay;
end;

procedure TTabs.AnchorPositionShow(Sender: TObject);
begin
 UpdatePositionDisplay;
end;

procedure TTabs.AnchorBackgroundShow(Sender: TObject);
begin
 UpdateBackgroundDisplay;
end;

procedure TTabs.IGNORE_Button9Click(Sender: TObject);
var i:integer;
    pn:TdhCustomPanel;
const MapDoAction:array[1..4] of TState=(hsNormal,hsDown,hsOver,hsOverDown);
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
 begin
  pn:=(TObject(Selection[i]) as TdhCustomPanel);
  repeat
   case IGNORE_cDoAction.ItemIndex mod 5 of
   0: pn.ActStyle.Clear;
   1,2,3,4:
   if pn.StyleArr[MapDoAction[IGNORE_cDoAction.ItemIndex mod 5]]=nil then
    {showmessage('This element only supports one style')} else
    pn.ActStyle.Assign(pn.StyleArr[MapDoAction[IGNORE_cDoAction.ItemIndex mod 5]]);
   end;
   pn:=pn.UsePn;
  until (pn=nil) or (IGNORE_cDoAction.ItemIndex<5);
 end;
// InstallDefaultFont;
 UpdateStylesDisplay;
 StylesChanged;
end;

procedure TTabs.PageControl1DrawTabCLX(Control: TCustomTabControl; TabIndex: Integer;
    const Rect: TRect; Active: Boolean; var DefaultDraw: Boolean );
begin
// PageControl1DrawTab(Control,TabIndex,Rect,Active);
end;

procedure TTabs.Panel1Resize(Sender: TObject);
begin
 if IsFloating and (PageControl1.ActivePage<>nil) then
 if ((PageControl1.ActivePage=AnchorText) or (PageControl1.ActivePage=AnchorPureHTML)) and not dhMainForm.AlignDisabled then
 begin
  if PropsAlign=alNone then
  begin
   LastClientWidth:=Tabs.ClientWidth;
  end else
  begin
   LastClientHeight:=Tabs.ClientHeight;
  end;
 end;
end;

procedure TTabs.PageControl1DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var Tab:TTabSheet;
    XRect:TRect;
    XRect2:TRect;
    i:integer;
    s:string;
begin
 //Control.Canvas.Brush.Color:=clRed;
 Control.Canvas.FillRect(Rect);
// exit;

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
 if (Tab=AnchorFont) and not IsFontCleared or (Tab=AnchorBorder) and not IsAllEdgeCleared or (Tab=AnchorBackground) and not IsImageCleared or (Tab=AnchorEffects) and not IsEffectsCleared or (Tab=AnchorMisc) and not IsAllMoreCleared  then
  //s:=s+'*';
  //Control.Canvas.Font.Style:=Control.Canvas.Font.Style+[fsUnderline];
 begin
  SetUnderlineState(Control.Canvas,false);
  if (Control.Canvas.Font.Style=[fsBold]) then
   Dec(XRect.Left,2);
 { if (Tab=AnchorEffects) then
   Dec(XRect.Left,2) else
  if (Tab=AnchorBorder) then
   Dec(XRect.Left,3) else
   Dec(XRect.Left,length(s) div 2);}
 end;
 {if (Tab=AnchorFont) and IsFontCleared or (Tab=AnchorBorder) and IsAllEdgeCleared or (Tab=AnchorBackground) and IsImageCleared or (Tab=AnchorEffects) and IsEffectsCleared or (Tab=AnchorMisc) and IsMoreCleared  then
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


 inc(XRect.Right,5);
 //dec(XRect.Left,1);

 Control.Canvas.TextRect(XRect,XRect.Left,XRect.Top,s);
{ DrawText(Control.Canvas.Handle,
             PChar(s), length(s),
             XRect, DT_SINGLELINE or DT_LEFT or DT_TOP);
 }
 TabIndex:=3;
end;

procedure TTabs.AnchorTextShow(Sender: TObject);
begin
 UpdateTextDisplay;
end;

procedure TTabs.UpdateTextDisplay;
begin
 if DoNotUpdateDisplay then exit;
 //eText.Font.Name:=(TObject(Selection[0]) as TdhLabel).NearestFontFamily;
 eText.StoredText:=(TObject(Selection[0]) as TdhLabel).Text;
 //Edit1.Text:=(TObject(Selection[0]) as TdhLabel).Text;
end;

function ExtractActiveControl:TControl;
var h:HWND;
begin
 //ActiveControl can be nil with some TWinControl having the focus!
{$IFDEF CLX}
 result:=dhMainForm.ActiveControl;
{$ELSE}
 h:=GetFocus;
 if h=0 then
 begin
  result:=nil;
  exit;
 end;
 result:=FindControl(h);
 if (result=nil) then //TComboBox
  result:=FindControl(GetParent(h));
 if result is TForm then
  result:=nil;
{$ENDIF}
end;


function TTabs.ActiveEditControl:IhCommitable;
var c:TControl;
begin

  {if (MoreMisc<>nil) and MoreMisc.Visible then
   c:=MoreMisc.ActiveControl else
   c:=GetParentForm(Self).ActiveControl;   }

  {c:=ExtractActiveControl;
  if Supports(c,IhCommitable) then
   result:=(c as IhCommitable) else
   result:=nil;
   }
  result:=FActiveEditControl;
end;


function TTabs.CommitChanges:boolean;
var cc:TControl;
begin
 cc:=ExtractActiveControl;
 if cc is TdhCustomLabel then
  TdhCustomLabel(cc).StopEditing;
 if (ActiveEditControl=nil) then
 begin
  result:=true;
  exit;
 end;
 result:=ActiveEditControl.Commit;
end;

procedure TTabs.AbortChanges;
begin
  if ActiveEditControl<>nil then
   ActiveEditControl.Abort;
end;


procedure TTabs.UpdatePageDisplay;
var IsVis:boolean;
    page:TdhPage;
begin            
 if DoNotUpdateDisplay then exit;
 Adjusting:=true;
 page:=(ActPn as TdhPage);
 eTitle.StoredText:=page.Title;
 gScrolling.ItemIndex:=Integer(page.Scrolling);
 gHTMLFrame.ItemIndex:=_if(page.UseIFrame,1,0);
 SetChildrenEnabled(gScrolling,page.IsScrollable);
 SetChildrenEnabled(gHTMLFrame,page.IsInternalScrollable);

 bPageProperties.Enabled:=page.IsHTMLBody or (page.PageControl<>nil);
 SetChildrenEnabled(gPageProperties,bPageProperties.Enabled);
 mPageProperties.Enabled:=bPageProperties.Enabled;

 IsVis:=page.IsTopScrollable;
 eOutputDirectory.Visible:=IsVis;
 dhLabel4.Visible:=IsVis;
 //Button2.Visible:=IsVis;
 if IsVis then
  eOutputDirectory.StoredText:=page.OutputDirectory else
  eOutputDirectory.StoredText:=EmptyStr;

 Adjusting:=false;
end;

procedure TTabs.AnchorPageShow(Sender: TObject);
begin
 UpdatePageDisplay;
end;

procedure TTabs.Button17Click(Sender: TObject);   
var backup:TObjectList;
    backupItem:TStyle;
    i:integer;
    pn:TdhCustomPanel;
    backupImageType:array of TImageType;
begin
 LateCreateForm(TTransparencyWizard,TransparencyWizard);
 backup:=TObjectList.Create;                 
 SetLength(backupImageType,Selection.Count);
 TransparencyWizard.LivePreview:=TList.Create;
 try
 backup.OwnsObjects:=true;
 for i:=0 to Selection.Count-1 do
 begin
  pn:=TObject(Selection[i]) as TdhCustomPanel;
  TransparencyWizard.LivePreview.add(pn.ActStyle);
  backupItem:=TStyle.Create(nil,hsNormal);
  backupItem.Assign(pn.ActStyle);
  backup.Add(backupItem);  
  backupImageType[i]:=pn.ImageType;
 end;
 TransparencyWizard.Prepare(ActPn);
 if TransparencyWizard.ShowModal=mrOk then
 begin
  LiveBackgroundChanged;
  Changed('Image From Color');
 end else
 begin
  for i:=0 to Selection.Count-1 do
  begin
   pn:=TObject(Selection[i]) as TdhCustomPanel;
   pn.ActStyle.Assign(TPersistent(backup[i]));
   pn.ImageType:=backupImageType[i];
  end;
 end;
 finally
  FreeAndNil(TransparencyWizard.LivePreview);
  backup.Free;
 end;
end;

procedure TTabs.cDynamicNavigationClick(Sender: TObject);
var gpc:TdhPageControl;
begin
 if Adjusting then exit;
 gpc:=ChooseTwice(0,TdhPageControl) as TdhPageControl;
 gpc.DynamicNavigation:=not cDynamicNavigation.Checked;
 Changed('Page Control');
end;

function TTabs.IsMoreCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
 with (TObject(Selection[i]) as TdhCustomPanel).ActStyle do
 result:=
  (VerticalAlign=EmptyStr) and (TextIndent=EmptyStr) and (TextAlign=Low(TCSSTextAlign)) and (Direction=Low(TCSSDirection)) and
  (Cursor=Low(TCSSCursor)) and (TextTransform=Low(TCSSTextTransform)) and (WhiteSpace=Low(TCSSWhiteSpace)) and (FontVariant=Low(TCSSFontVariant)) and
  (ZIndex=vsrInherit);
end;

function TTabs.IsMoreExtCleared:boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
 if result then
 with (TObject(Selection[i]) as TdhCustomPanel) do
 with ActStyle do
 result:=(LetterSpacing=EmptyStr) and (WordSpacing=EmptyStr) and (LineHeight=EmptyStr) and (Visibility=Low(TCSSVisibility)) and (Display=Low(TCSSDisplay)) and (ContentBefore=EmptyStr) and (ContentAfter=EmptyStr) and (Other=EmptyStr) and (HTMLAttributes=EmptyStr);
end;

function TTabs.IsAllMoreCleared:boolean;
begin
 result:=IsMoreCleared and IsMoreExtCleared;
end;

procedure TTabs.bClearMoreClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TdhCustomPanel).ActStyle do
 begin
  Cursor:=Low(TCSSCursor);
  ZIndex:=vsrInherit;
  Direction:=Low(TCSSDirection);

  VerticalAlign:=EmptyStr;
  TextIndent:=EmptyStr;
  TextAlign:=Low(TCSSTextAlign);

  TextTransform:=Low(TCSSTextTransform);
  WhiteSpace:=Low(TCSSWhiteSpace);
  FontVariant:=Low(TCSSFontVariant);
 end;
 Changed('Reset Misc');
 UpdateMoreDisplay;
end;

procedure TTabs.bClearEffectsClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Effects.Clear;
 Changed('Reset Effects');
 UpdateEffectsDisplay;
end;

procedure TTabs.mGotoUseClick(Sender: TObject);
var pn:TdhCustomPanel;
begin
 pn:=(TObject(Selection[0]) as TdhCustomPanel).UsePn;
 dhMainForm.Act.History{(nil,pn)};
 (TControl(Selection[0]).Owner as TPageContainer).MySiz.SetControlTo(pn,true,true);
end;

procedure TTabs.mGotoLinkClick(Sender: TObject);
var link:TdhLink;
begin
 link:=TObject(Selection[0]) as TdhLink;
 link.Click;
 (TControl(Selection[0]).Owner as TPageContainer).MySiz.SetControlTo(link.LinkPage,true,true);
end;

procedure TTabs.mGotoFragmentClick(Sender: TObject);
var link:TdhLink;
begin
 link:=TObject(Selection[0]) as TdhLink;
 link.Click;
 (TControl(Selection[0]).Owner as TPageContainer).MySiz.SetControlTo(link.LinkAnchor,true,true);
end;


procedure TTabs.mStyleInfoClick(Sender: TObject);
begin
 LateCreateForm(TStyleInfo,StyleInfo);
 StyleInfo.Memo.Text:=(TObject(Selection[0]) as TdhCustomPanel).GetInfo;
 StyleInfo.Show;
end;

procedure TTabs.AnchorFormShow(Sender: TObject);
begin
 UpdateFormDisplay;
end;

procedure TTabs.UpdateFormDisplay;
var form:TdhHTMLForm;
begin
 if DoNotUpdateDisplay then exit;
 adjusting:=true;
 form:=TObject(Selection[0]) as TdhHTMLForm;
 eAction.StoredText:=form.Action;
 cbMethod.ItemIndex:=Integer(form.Method);
 CODE_eFormTarget.StoredText:=form.Target;
 adjusting:=false;
end;


procedure TTabs.cMemoReadOnlyClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhMemo).ReadOnly:=cMemoReadOnly.Checked;
  Changed('Memo');
end;

procedure TTabs.AnchorMemoShow(Sender: TObject);
begin
 UpdateMemoDisplay;
end;

procedure TTabs.cPasswordClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhEdit).Password:=cPassword.Checked;
  Changed('Input Options');
end;

procedure TTabs.cWrapClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhMemo).Wrap:=cWrap.Checked;
  Changed('Edit Memo Options');
end;

procedure TTabs.PullStyles(Use:ICon; Clear:boolean);
var i:integer;
    pn:TdhCustomPanel;
begin
 if Clear then
  ClearAllStyles(true);
 repeat
  for i:=0 to Selection.Count-1 do
  begin
   pn:=TObject(Selection[i]) as TdhCustomPanel;
   Use.GetCommon.TransferStylesToElement(pn);
   if (Use.GetCommon.Use=nil) and (Use.GetCommon.SUse<>EmptyStr) then
   begin
    pn.SUse:=Use.GetCommon.SUse;
   end;
  end;
  Use:=Use.GetCommon.Use;
 until Use=nil;

 StylesChanged;
 UpdateSel;
end;


procedure TTabs.mGetClipboardStylesClick(Sender: TObject);
var form:TForm;
    Use:TdhCustomPanel;
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
  showmessage(DKFormat(EMPTYCLIPBOARD));
  exit;
 end;

 PullStyles(Use,false);

 finally
  form.Free;
 end;
end;

procedure TTabs.cEffectsEnabledClick(Sender: TObject);
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
   showmessage(DKFormat(UNSUPPORTEDSTYLE));
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
    case MessageDlg(DKFormat(DUPLICATEEFFECTS), mtConfirmation,[mbYes, mbNo], 0) of
    {idYes}mrYes: asked:=true;
    else break;
    end;
    Effects.Assign(tt);
   end;
   //Effects.Enabled:=true;
  end;
  if asked then
   UpdateEffectsDisplay;
 end;
 BuildTransformations;
end;

procedure TTabs.DoOnClose(Sender:TObject; var Action: TCloseAction);
begin
 if Action=caHide then
 begin
  PropsAlign:=alBottom;
  UpdateAlign;
 end;
end;

function GetToSize:TControl;
begin
 if IsFloating then
 begin
  result:=Tabs;
 end else
 begin
  result:=Tabs.Panel1;
 end;
end;

procedure UpdateAlign;
var i,ii:integer;
    c:TControl;
    w:integer;
    lLock:boolean;
    tabindex:integer;
    R:TRect;
    floating,IsVertical:boolean;
    toSize:TControl;
const NeedWhite:array[boolean] of TCSSBorderStyle=(cbsNone,cbsSolid);
const NeedTrans:array[boolean] of TColor=(clBlack,clBtnFace);
const DistanceVert=5;
const DistanceHorz=7;
begin
 glLockWindowUpdate(true,lLock);
 dhMainForm.DisableAlign;


 try
 tabindex:=Tabs.PageControl1.TabIndex;
 floating:=IsFloating;
 toSize:=GetToSize;
 if floating<>(Tabs.Panel1.Parent=Tabs) then
 begin
 Tabs.CommitChanges;
 if floating then
 begin
 {form.ClientHeight:=Tabs.Height;
 form.ClientWidth:=Tabs.PageControl1.Width;    }
 //form.SetFocus;
 Tabs.Panel1.Parent:=Tabs;
 if (csDestroying in Tabs.ComponentState) then
  exit;
 Tabs.Panel1.Align:=alClient;
 Tabs.Show;
 Tabs.PageControl1.TabIndex:=tabindex;
 end else
 //if not (PropsAlign in [alNone,alClient]) and (Parent<>dhMainForm) then
 begin
 Tabs.Hide;
 Tabs.Panel1.Align:=alNone;
 Tabs.Panel1.Parent:=dhMainForm;
 Tabs.PageControl1.TabIndex:=tabindex;
 end;
 end;
 //PageControl1.TabWidth:=43;

 IsVertical:=PropsAlign in [alTop,alBottom,alNone];

 if floating then
 begin
  Tabs.Panel1.Align:=alClient;
 end else
{ if PropsAlign=alNone then
  toSize.Align:=alBottom else
 if PropsAlign=alClient then
  toSize.Align:=alLeft else}
  Tabs.Panel1.Align:=PropsAlign;
 Tabs.bClearEffects.BringToFront;
 //PageControl1.MultiLine:=not(PropsAlign in [alTop,alBottom]);
 Tabs.EffectsMainStateTransition(nil,hsNormal);


 if IsVertical then
 begin
{$IFDEF CLX}
  toSize.Height:=132;
{$ELSE}
  toSize.Height:=130;
{$ENDIF}
  //PageControl1.TabWidth:=0;
  //PageControl1.Width:=790;
  Tabs.panelpc2.Width:=513;
  Tabs.panelpc2.Height:=100;
  Tabs.pcnav_horz.Visible:=false;
  Tabs.pcnav_vert.Visible:=true;
  Tabs.STYLE_Label33.Style.BorderRadius.TopRight:=Tabs.STYLE_dhLabel11.Style.BorderRadius.TopRight;
  Tabs.STYLE_Label33.Style.BorderRadius.BottomLeft:='0';
  Tabs.STYLE_Label33.Style.BorderLeft.Style:=cbsNone;
  Tabs.STYLE_Label33.Style.BorderTop.Style:=Tabs.STYLE_dhLabel11.Style.BorderTop.Style;
 end else
 begin
//  PageControl1.TabPosition:=tpLeft;
{$IFDEF CLX}
  toSize.Width:=230;
{$ELSE}
  toSize.Width:=224;
{$ENDIF}
  //PageControl1.TabWidth:=70;
  Tabs.PageControl1.RaggedRight:=true;

{$IFNDEF CLX}
  Tabs.PageControl1.ScrollOpposite:=false;
{$ENDIF}
  Tabs.panelpc2.Width:=210;
  Tabs.panelpc2.Height:=300;
  //PageControl1.Width:=224;
  Tabs.pcnav_horz.Visible:=true;
  Tabs.pcnav_vert.Visible:=false;
  Tabs.STYLE_Label33.Style.BorderRadius.BottomLeft:=Tabs.STYLE_dhLabel11.Style.BorderRadius.BottomLeft;
  Tabs.STYLE_Label33.Style.BorderRadius.TopRight:='0';
  Tabs.STYLE_Label33.Style.BorderTop.Style:=cbsNone;
  Tabs.STYLE_Label33.Style.BorderLeft.Style:=Tabs.STYLE_dhLabel11.Style.BorderLeft.Style;
 end;

 Tabs.Panel1.Style.BorderLeft.Style:=NeedWhite[PropsAlign in [alRight]];
 Tabs.Panel1.Style.BorderRight.Style:=NeedWhite[PropsAlign in [alLeft]];
 //Panel4.Style.BorderRight.Color:=NeedTrans[PropsAlign in [alTop,alBottom]];
 //Panel4.Style.BorderBottom.Color:=NeedTrans[PropsAlign in [alLeft,alRight]];
 for ii:=0 to Tabs.PageControl1.PageCount-1 do
 begin
 if IsVertical then
  w:=5 else
  w:=5;
 for i:=0 to Tabs.PageControl1.Pages[ii].ControlCount-1 do
 begin
  c:=Tabs.PageControl1.Pages[ii].Controls[i];
  if (c is TdhPageControl) {or (c=panelpc2) }or (c is TdhDirectHTML) or not c.Visible then continue;
  if IsVertical then
  begin
   {if (c is TButton) and (TButton(c).Caption='Reset') then
   begin
    c.Left:=c.Parent.Width-c.Width-1;
    c.Top:=0;
   end else }
   begin
    c.Left:=w;
    if (c is TCustomGroupBox) or (c is TCustomRadioGroup) or (c is TPageControl) or (c=Tabs.pcnav_vert) or (c=Tabs.TabSheet7) or (c=Tabs.TabSheet3) or (c=Tabs.TabSheet8) or (c=Tabs.panelpc2) or (c=Tabs.ppp) then
     c.Top:=0 else
     c.Top:=5;
    inc(w,c.Width+DistanceHorz);
    if (c is TdhLabel) then
    begin
     inc(w,TdhLabel(c).GetWantedSize.X-c.Width);
    end;
    if c=Tabs.pcnav_vert then
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
    inc(w,c.Height+DistanceVert);
    if c=Tabs.pcnav_horz then
     dec(w,6);
   end;
  end;
 end;
 end;


 if IsVertical then
 begin
  //PageControl2.ActivePage.Top:=-8;
  Tabs.EdgeNavigation.Top:=1;
  Tabs.Panel3.Top:=2;
  Tabs.Panel3.Left:=256;
  Tabs.Panel31.Top:=2;
  Tabs.Panel31.Left:=26;
  Tabs.Panel5.Top:=2;
  Tabs.Panel5.Left:=314;
  Tabs.Panel6.Top:=Tabs.Panel5.Top;
  Tabs.Panel6.Left:=117;
  Tabs.dhPanel4.Top:=4;
  Tabs.dhPanel4.Left:=0;
  Tabs.bBorderRadius.Left:=Tabs.bClearEdge.Left;
  Tabs.bBorderRadius.Top:=Tabs.bClearEdge.Top+Tabs.bClearEdge.Height+DistanceVert;
  Tabs.bMoreMisc.Left:=Tabs.bClearMore.Left;
  Tabs.bMoreMisc.Top:=Tabs.bClearMore.Top+Tabs.bClearMore.Height+DistanceVert;
 end else
 begin
  Tabs.Panel3.Top:=107;
  Tabs.Panel3.Left:=0;
  Tabs.Panel31.Top:=15;
  Tabs.Panel31.Left:=0;
  Tabs.Panel5.Top:=190;
  Tabs.Panel5.Left:=10;
  Tabs.Panel6.Top:=102;
  Tabs.Panel6.Left:=Tabs.Panel5.Left;
  Tabs.dhPanel4.Top:=5;
  Tabs.dhPanel4.Left:=11;
  Tabs.bBorderRadius.Left:=Tabs.bClearEdge.Left+Tabs.bClearEdge.Width+DistanceHorz;
  Tabs.bBorderRadius.Top:=Tabs.bClearEdge.Top;
  Tabs.bMoreMisc.Left:=Tabs.bClearMore.Left+Tabs.bClearMore.Width+DistanceHorz;
  Tabs.bMoreMisc.Top:=Tabs.bClearMore.Top;
  //EdgeNavigation.Left:=(EdgeNavigation.Parent.Width-EdgeNavigation.Width) div 2;
 end;
 //InvalTrans(Panel4,InvRect);
 //Panel4.Style.ZIndex:=3;

 if floating then
 begin
  R:=rGetOffsetRect(AdjustedClientRect(dhMainForm),GetCBound(dhMainForm).TopLeft);
  Inc(R.Top,dhMainForm.dhPanel1.Height);
  Dec(R.Bottom,dhMainForm.StatusBar.Height);
  if PropsAlign=alNone then
  begin
   Tabs.ClientHeight:=Tabs.Height;
   {Parent.Top:=R.Bottom-Parent.Height;
   Parent.Left:=R.Left;}
   Tabs.SetBounds(R.Left,R.Bottom-Tabs.Height,Tabs.Width,Tabs.Height);

  end;
  if PropsAlign=alClient then
  begin
   Tabs.ClientWidth:=Tabs.Width;
   Tabs.SetBounds(R.Right-Tabs.Width,R.Top,Tabs.Width,Tabs.Height);

   {Parent.Top:=R.Top;
   Parent.Left:=R.Right-Parent.Width;}
  end;
 end;

{$IFNDEF CLX}
// TabCtrl_SetMinTabWidth(PageControl1.Handle,0);
{$ENDIF}
 Tabs.UpdateContainer;

 finally
  dhMainForm.EnableAlign;
  glLockWindowUpdate(false,lLock);
 end;
 Tabs.Realign;
end;

procedure TTabs.UpdateContainer;
var x,y,i:integer;
begin
 if IsFloating and (Panel1.Parent=dhMainForm) then exit;

 if IsFloating and (PageControl1.ActivePage<>nil) then
 if (PageControl1.ActivePage=AnchorText) or (PageControl1.ActivePage=AnchorPureHTML) then
 begin
  if PropsAlign=alNone then
  begin
   if LastClientWidth<>0 then
    Tabs.ClientWidth:=LastClientWidth;
  end else
  begin
   if LastClientHeight<>0 then
    Tabs.ClientHeight:=LastClientHeight;
  end;
 end else
 begin
  Y:=0;
  X:=0;
  for i:=0 to PageControl1.ActivePage.ControlCount-1 do
  with PageControl1.ActivePage.Controls[i] do
  if Visible then
  begin
   X:=Max(X,BoundsRect.Right);
   Y:=Max(Y,BoundsRect.Bottom);
  end;
  if PropsAlign=alNone then
   Tabs.ClientWidth:=X+5+(PageControl1.Width-PageControl1.ActivePage.Width) else
   Tabs.ClientHeight:=Y+6+(PageControl1.Height-PageControl1.ActivePage.Height);
 end;

 GetToSize.Visible:=not _RuntimeMode and (Selection.Count<>0);
end;


procedure TTabs.mPagePropertiesClick(Sender: TObject);
begin
 EditPageProperties(Selection);
end;

procedure TTabs.EditPageProperties;
begin
 if not CommitChanges then exit;
 LateCreateForm(TPageWizard,PageWizard);
 if PageWizard.Prepare(pages) then
 begin
  if PageControl1.ActivePage=AnchorPage then
   UpdatePageDisplay;
  Changed('Edit Page Properties');
 end;
end;


procedure TTabs.mOleClick(Sender: TObject);
begin      
// (TObject(Selection[0]) as TOleContainer).InsertObjectDialog;       

{$IFNDEF CLX}                 
 if (TObject(Selection[0]) as TdhOleContainer).InsertObjectDialog(true) then
  (TObject(Selection[0]) as TdhOleContainer).EditInPlace;
{$ENDIF}
end;

procedure TTabs.AnchorHiddenShow(Sender: TObject);
begin
 UpdateHiddenFieldDisplay;
end;

procedure TTabs.UpdateHiddenFieldDisplay;
begin       
  if DoNotUpdateDisplay then exit;
  eHiddenField.StoredText:=(TObject(Selection[0]) as TdhHiddenField).Value;
end;


procedure TTabs.Button2Click(Sender: TObject);
begin                                

{$IFNDEF CLX}                        
 if (TObject(Selection[0]) as TdhOleContainer).InsertObjectDialog(true) then
  (TObject(Selection[0]) as TdhOleContainer).EditInPlace;
{$ENDIF}
end;

procedure TTabs.Button4Click(Sender: TObject);
begin

{$IFNDEF CLX}                    
 if (TObject(Selection[0]) as TdhOleContainer).InsertObjectDialog(true) then
  (TObject(Selection[0]) as TdhOleContainer).ObjectPropertiesDialog;
{$ENDIF}
end;

procedure TTabs.LoadImageExt(URL: TPathName; pn: TdhCustomPanel);
begin
  //if not CommitChanges then exit; //may be a dragged image from browser, which causes no focus exit
  (pn.Owner as TPageContainer).MySiz.SetControlTo(pn,true,true);
  LoadImage(URL);
  {pn.ActStyle.LoadImage(URL);
  Changed('bg-image');
  if PageControl1.ActivePage=AnchorBackground then BackgroundChanged; }
end;

procedure TTabs.dhPanel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 //if dhPanel1.Style.BackgroundImage.Graphic<>nil then
 if Button=mbRight then
 begin
  mSaveImageToFile.Enabled:=dhPanel1.Style.BackgroundImage.HasPicture;
  mChangeColors.Enabled:=mSaveImageToFile.Enabled;
  mSetBackgroundColorTransparent.Enabled:=mSaveImageToFile.Enabled;
  PopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
 end;
end;

procedure TTabs.mChangeColorsClick(Sender: TObject);
begin
 LateCreateForm(TColorizeImg,ColorizeImg);
 if ColorizeImg.Prepare(dhPanel1.Style.BackgroundImage.RequestGraphic,CSSColorToColor((TObject(Selection[0]) as TdhCustomPanel).GetVirtualBGColor)) then
 begin                           
  if not CommitChanges then exit;
  with TObject(Selection[0]) as TdhCustomPanel do
   ColorizeImg.GetBG(ActStyle.BackgroundImage);
  LiveBackgroundChanged;
  Changed('Change Image Colors');
 end;
end;

                     (*

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


 {if Control=TabControl2 then
  IsCleared:=IsEdgeCleared(guiEdgesAlign[TabIndex]) else }
  IsCleared:=not getblur(ActStyle.Effects,TabIndex).Enabled{IsCleared};
 if not IsCleared then
  //s:=s+'*';
  Control.Canvas.Font.Style:=Control.Canvas.Font.Style+[fsUnderline];
 //Control.Canvas.Font.Color:=ClearColor[IsCleared];


 Control.Canvas.TextRect(XRect,XRect.Left,XRect.Top,s);
// DrawText(Control.Canvas.Handle,PChar(s),length(s), XRect, DT_SINGLELINE or DT_LEFT or DT_TOP);


end;
              *)
procedure TTabs.cTransparentWhiteClick(Sender: TObject);
begin
{$IFNDEF CLX}
 (TObject(Selection[0]) as TdhOleContainer).TransparentWhite:=cTransparentWhite.Checked;
{$ENDIF}
end;

procedure TTabs.AnchorOleShow(Sender: TObject);
begin
 UpdateOLEDisplay;
end;

procedure TTabs.UpdateOLEDisplay;
begin        
 if DoNotUpdateDisplay then exit;
{$IFNDEF CLX}                                      
 cTransparentWhite.Checked:=(TObject(Selection[0]) as TdhOleContainer).TransparentWhite;
 IGNORE_cUsage.ItemIndex:=Integer((TObject(Selection[0]) as TdhOleContainer).Usage);
{$ENDIF}
end;


procedure TTabs.mCopyImageClick(Sender: TObject);
begin
// (dhPanel1.Style.BackgroundImage.Graphic as TGifImage).SaveToClipboardFormat();
end;

procedure TTabs.mSaveImageToFileClick(Sender: TObject);
var i,FilterIndex:integer;
begin
 i:=System.Pos(dhPanel1.Style.BackgroundImage.GraphicExtension,IGNORE_SavePictureDialog1.Filter);
 FilterIndex:=0;
 for i:=i downto 1 do
 if IGNORE_SavePictureDialog1.Filter[i]='|' then
  inc(FilterIndex);
 IGNORE_SavePictureDialog1.FilterIndex:=FilterIndex div 2 + 1;

 if IGNORE_SavePictureDialog1.Execute then
 begin
  SaveGraphic(dhPanel1.Style.BackgroundImage.RequestGraphic,IGNORE_SavePictureDialog1.FileName);
 end;
end;

procedure TTabs.vsClick(Sender: TObject);
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

procedure TTabs.Loaded;
begin
  inherited;
  dhStyleSheet1.Visible:=False;
end;



procedure TTabs.AdjustClientRect(var Rect: TRect);
begin
 inherited;
  //do nothing, prevent TScrollingWinControl.AdjustClientRect
end;

procedure TTabs.cbCursorDropDown(Sender: TObject);
begin
{$IFNDEF CLX}
 SendMessage(cbCursor.Handle, CB_SETDROPPEDWIDTH, 120, 0);
{$ENDIF}
end;

procedure TTabs.cSlideClick(Sender: TObject);
begin               
 if Adjusting then exit;
 MenuChanged;
 Changed('Sliding');
end;

procedure TTabs.cOpenByOverClick(Sender: TObject);
begin
 if Adjusting then exit;
 MenuChanged;
 Changed('Popup Delay');
end;

procedure TTabs.bBorderRadiusClick(Sender: TObject);
var backup:TObjectList;
    backupItem:TCSSBorderRadius;
    i:integer;
begin
 LateCreateForm(TBorderRadiusWizard,BorderRadiusWizard);
 backup:=TObjectList.Create;
 try
 backup.OwnsObjects:=true;
 for i:=0 to Selection.Count-1 do
 begin
  backupItem:=TCSSBorderRadius.Create(nil);
  backupItem.Assign((TObject(Selection[i]) as TdhCustomPanel).ActStyle.BorderRadius);
  backup.Add(backupItem);
 end;
 BorderRadiusWizard.Prepare(Selection);
 if BorderRadiusWizard.ShowModal=mrOk then
 begin
  InvTabs;
  UpdateBorderDisplay;
  Changed('Change Border-Radius');
 end else
 begin          
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCustomPanel).ActStyle.BorderRadius.Assign(TPersistent(backup[i]));
 end;
 finally
  backup.Free;
 end;
end;

procedure TTabs.spMarginValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.SetMargin(EdgeAlign,_if(Clear,MarginDefault,IntToStr(spMargin.Value)));
 LiveBorderChanged;
end;

procedure TTabs.spPaddingValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.SetPadding(EdgeAlign,_if(Clear,vsrInherit,spPadding.Value));
 LiveBorderChanged;
end;

procedure TTabs.spBorderValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.Borders[EdgeAlign].Width:=_if(Clear,vsrInherit,spBorder.Value);
 LiveBorderChanged;
end;

procedure TTabs.spBGXValueChange(Sender: TObject; Clear: Boolean);
begin
 BuildBGPos(Clear);
end;

procedure TTabs.spLeftValueChange(Sender: TObject; Clear: Boolean);
begin
 LivePositionChanged(Sender);
end;

procedure TTabs.spSkewXValueChange(Sender: TObject; Clear: Boolean);
begin     
 LiveBuildTransformations;
end;

procedure TTabs.LogChange(Sender: TObject; LogChange: TLogChange);
begin
 if Supports(Sender,IhCommitable) and (LogChange=lcLive) then
   FActiveEditControl:=(TControl(Sender) as IhCommitable) else
   FActiveEditControl:=nil;
 if Sender is TMySpinEdit then
  Changed((Sender as TMySpinEdit).ChangeReason,LogChange) else
 if Sender is ThMemo then
  Changed((Sender as ThMemo).ChangeReason,LogChange) else
 if Sender is ThSynMemo then
  Changed((Sender as ThSynMemo).ChangeReason,LogChange) else
 if Sender is ThComboBox then
  Changed((Sender as ThComboBox).ChangeReason,LogChange) else
 if Sender is ThCheckBox then
  Changed((Sender as ThCheckBox).ChangeReason,LogChange) else
  Changed((Sender as ThEdit).ChangeReason,LogChange);
end;

procedure TTabs.eTextValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhLabel).Text:=eText.Text;
end;

procedure TTabs.eEditValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhEdit).Text:=eEdit.Text;
end;

procedure TTabs.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
 AllowChange:=not (csReading in ComponentState) and CommitChanges;
end;

procedure TTabs.eNameValueChange(Sender: TObject; Clear: Boolean);
begin
  (TObject(Selection[0]) as TControl).Name:=eName.Text;
  dhMainForm.UpdateNames(TObject(Selection[0]) as TControl);
  UpdateNameDisplay;
end;

procedure TTabs.eTitleValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhPage).Title:=eTitle.Text;
end;

procedure TTabs.eOutputDirectoryValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin                 
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhPage).OutputDirectory:=eOutputDirectory.Text;
end;

procedure TTabs.eActionValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhHTMLForm).Action:=eAction.Text;
end;

procedure TTabs.eHiddenFieldValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhHiddenField).Value:=eHiddenField.Text;
end;

procedure TTabs.eMemoValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhMemo).SetMemoText(eMemo.Text);
end;

procedure TTabs.CODE_eFormTargetValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhHTMLForm).Target:=CODE_eFormTarget.Text;
end;

function IncludeClear(Clear:Boolean; Value:integer): integer;
begin
 if Clear then
  result:=0 else
  result:=Value+1;
end;


procedure TTabs.dhComboBox1ValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.Borders[EdgeAlign].Style:=TCSSBorderStyle(IncludeClear(Clear,dhComboBox1.ItemIndex));
 LiveBorderChanged;
end;

procedure TTabs.CODE_cbTextIndentValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.TextIndent:=WithoutPx(GoodValue(CODE_cbTextIndent.Text));
 UpdateMoreDisplay;
end;

procedure TTabs.CODE_cbVerticalAlignValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.VerticalAlign:=WithoutPx(GoodValue(CODE_cbVerticalAlign.Text));
 UpdateMoreDisplay;
end;

procedure TTabs.cbZIndexValueChange(Sender: TObject; Clear: Boolean);
var i,ZIndex:integer;
begin
 if cbZIndex.Text=EmptyStr then
  ZIndex:=vsrInherit else
  ZIndex:=strtoint(cbZIndex.Text);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.ZIndex:=ZIndex;
 UpdateMoreDisplay;
end;

procedure TTabs.CODE_eLinkValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhLink).Link:=CODE_eLink.Text;
  UpdateLinkDisplay;
end;

procedure TTabs.CODE_eTargetValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhLink).Target:=CODE_eTarget.Text;
  UpdateLinkDisplay;
end;

procedure TTabs.ComboBox1ValueChange(Sender: TObject; Clear: Boolean);
var sIndex:integer;
begin
 sIndex:=ComboBox1.ItemIndex;
 (TObject(Selection[0]) as TdhCustomPanel).ImageType:=TImageType(IncludeClear(Clear,ComboBox1.ItemIndex));
 LiveBackgroundChanged;
 if sIndex<>ComboBox1.ItemIndex then
  raise WException.Create(DKFormat(UNSUPPORTEDSTYLE));
end;

procedure TTabs.dhComboBox4ValueChange(Sender: TObject; Clear: Boolean);
begin
 ActStyle.BackgroundRepeat:=TCSSBackgroundRepeat(IncludeClear(Clear,dhComboBox4.ItemIndex));
 LiveBackgroundChanged;
end;

procedure TTabs.cbCursorValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 cbCursor.ItemIndex:=GoodIndex(cbCursor.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Cursor:=TCSSCursor(GoodIndexBack(cbCursor.ItemIndex));
 UpdateMoreDisplay;
end;

procedure TTabs.cbDirectionValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 cbDirection.ItemIndex:=GoodIndex(cbDirection.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Direction:=TCSSDirection(GoodIndexBack(cbDirection.ItemIndex));
 UpdateMoreDisplay;
end;

procedure TTabs.cbTextAlignValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 cbTextAlign.ItemIndex:=GoodIndex(cbTextAlign.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.TextAlign:=TCSSTextAlign(GoodIndexBack(cbTextAlign.ItemIndex));
 UpdateMoreDisplay;
end;

procedure TTabs.cbTextTransformValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 cbTextTransform.ItemIndex:=GoodIndex(cbTextTransform.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.TextTransform:=TCSSTextTransform(GoodIndexBack(cbTextTransform.ItemIndex));
 UpdateMoreDisplay;    
end;

procedure TTabs.cbWhiteSpaceValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 cbWhiteSpace.ItemIndex:=GoodIndex(cbWhiteSpace.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.WhiteSpace:=TCSSWhiteSpace(GoodIndexBack(cbWhiteSpace.ItemIndex));
 UpdateMoreDisplay; 
end;

procedure TTabs.cbFontVariantValueChange(Sender: TObject;
  Clear: Boolean);
var i:integer;
begin
 cbFontVariant.ItemIndex:=GoodIndex(cbFontVariant.ItemIndex);
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.FontVariant:=TCSSFontVariant(GoodIndexBack(cbFontVariant.ItemIndex));
 UpdateMoreDisplay;
end;

procedure TTabs.cbUseValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
    c:TComponent;
begin
 c:=dhMainForm.Act.FindComponent(cbUse.Text);
 if not((cbUse.Text<>EmptyStr) and (c=nil) and (ActPn.SUse=cbUse.Text)) then
 begin
  if (cbUse.Text<>EmptyStr) and  (cbUse.Items.IndexOf(cbUse.Text)=-1){not (c is TdhCustomPanel)} then
   raise WException.Create(DKFormat(INVALIDVALUE));
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCustomPanel).Use:=(c as TdhCustomPanel);
 end;
 UpdateStylesDisplay;
end;

procedure TTabs.spReactionTimeValueChange(Sender: TObject;
  Clear: Boolean);
begin
 MenuChanged;
end;

procedure TTabs.cbLinkPageValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
    c:TComponent;
    cb:ThComboBox;
begin
 cb:=Sender as ThComboBox;
 c:=dhMainForm.Act.FindComponent(cb.Text);
 
 if not((cb.Text<>EmptyStr) and (c=nil) and ((cb=cbLinkPage) and ((ActPn as TdhLink).SLinkPage=cb.Text) or (cb=cbLinkAnchor) and ((ActPn as TdhLink).SLinkAnchor=cb.Text))) then
 begin
 if (cb.Text<>EmptyStr) and (cb.Items.IndexOf(cb.Text)=-1){((cb=cbLinkPage) and not (c is TdhPage) or (cb=cbLinkAnchor) and (cb=nil))} then
  raise WException.Create(DKFormat(INVALIDVALUE));
 for i:=0 to Selection.Count-1 do
 if cb=cbLinkPage then
  (TObject(Selection[i]) as TdhLink).LinkPage:=c as TdhPage else
  (TObject(Selection[i]) as TdhLink).LinkAnchor:=c as TdhCustomPanel;
 end;
 UpdateLinkDisplay;
end;

procedure TTabs.cBGFixedValueChange(Sender: TObject; Clear: Boolean);
const GetBGFixed:array[boolean] of TCSSBackgroundAttachment=(cbaScroll,cbaFixed);
begin
 if Clear then
  ActStyle.BackgroundAttachment:=Low(TCSSBackgroundAttachment) else
  ActStyle.BackgroundAttachment:=GetBGFixed[cBGFixed.Checked];
 LiveBackgroundChanged;

end;

procedure TTabs.cLinkLayoutClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhLink).Layout:=TLinkType(cLinkLayout.ItemIndex);
 LinkChanged;
end;

procedure TTabs.cHorizontalLayoutClick(Sender: TObject);
begin
 if Adjusting then exit;
 MenuChanged;
 Changed('Menu');
end;

procedure TTabs.cbParentMenuItemValueChange(Sender: TObject;
  Clear: Boolean);
var c:TComponent;
begin     
 cbParentMenuItem.ItemIndex:=GoodIndex(cbParentMenuItem.ItemIndex);
 c:=dhMainForm.Act.FindComponent(cbParentMenuItem.Text);
 if (c is TdhLink) or (c=nil) and (cbParentMenuItem.Text=EmptyStr) then
 begin
   (ChooseTwice(0,TdhMenu) as TdhMenu).ParentMenuItem:=TdhLink(c);
   if ObjectExplorer<>nil then ObjectExplorer.UpdateRootAndSelection;
 end;
 MenuChanged;
end;

procedure TTabs.mExchangeDownAndOverStylesClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ExchangeDownOverStyles;
 StylesChanged;
 UpdateSel;
end;

function TTabs.GetSelectionBounds:TRect;
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


procedure TTabs.mLeftEdgesClick(Sender: TObject);
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

function SortHorz(const Item1, Item2: TControl): Integer;
begin
 Result:=Item1.Left-Item2.Left;
end;

function SortVert(const Item1, Item2: TControl): Integer;
begin
 Result:=Item1.Top-Item2.Top;
end;

procedure TTabs.mEqualHorizontalClick(Sender: TObject);
var i,w:integer;
    spacing,d:double;
    SortedSel:TList<TControl>;
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
 if Sender=mEqualHorizontal then
  SortedSel:=TList<TControl>.Create(TComparer<TControl>.Construct(SortHorz)) else
  SortedSel:=TList<TControl>.Create(TComparer<TControl>.Construct(SortVert));
 try
  for i:=Selection.Count-1 downto 0 do
   SortedSel.Add(Selection[i]);
  SortedSel.Sort;
  {SortedSel.Assign(Selection);
  if Sender=mEqualHorizontal then
   SortedSel.Sort(SortHorz) else
   SortedSel.Sort(SortVert);  }
  if Sender=mEqualHorizontal then
   d:=GetSelectionBounds.Left else
   d:=GetSelectionBounds.Top;
  for i:=0 to Selection.Count-1 do
  with SortedSel[i] do
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

procedure TTabs.mLoadfromHTTPaddressClick(Sender: TObject);
var s:string;
begin
 s:='http://';
 if InputQuery(DKFormat(INPUTHTTPURL), 'URL:',s) then
  dhMainForm.ImageFromURL(s,nil);
end;

procedure TTabs.mLoadStylesheetClick(Sender: TObject);
var stylesheet:TdhStylesheet;
    i:integer;
begin
 if OpenCSSDialog.Execute then
 begin
   for i:=0 to Selection.Count-1 do
   begin
    stylesheet:=TObject(Selection[i]) as TdhStylesheet;
    ImportFromStylesheet(stylesheet,OpenCSSDialog.FileName);
   end;
  Changed('Load stylesheet');
 end;
end;

procedure TTabs.bMoreMiscClick(Sender: TObject);
begin
 LateCreateForm(TMoreMisc,MoreMisc);
 MoreMisc.Prepare;
 MoreMisc.ShowModal;
end;

procedure TTabs.SetAdjusting(Value: boolean);
begin
 FAdjusting:=Value;
end;

procedure TTabs.AnchorSelectShow(Sender: TObject);
begin
 UpdateSelectDisplay;
end;

procedure TTabs.UpdateSelectDisplay;
var index:integer;
    select:TdhSelect;
begin                    
 if DoNotUpdateDisplay then exit;
 if Adjusting then exit;
 select:=(ActPn as TdhSelect);

 Adjusting:=true;
 cDropDown.Checked:=select.SelectType=stDropDown;
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


procedure TTabs.mPushStylesToUseClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).TransferStylesToUse;
 StylesChanged;
 UpdateSel;
end;

procedure TTabs.Button5Click(Sender: TObject);
begin
 (ActPn as TdhSelect).Items.Add;
 UpdateAllSelects;
 dhSelect1.Items[dhSelect1.Count-1].BeTheOnlySelection;
 eSelectLabel.SetFocus;     
 Changed('Add Item');
end;

procedure TTabs.UpdateAllSelects;
var i:integer;
begin
 for i:=1 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhSelect).Items.Assign((ActPn as TdhSelect).Items);
 UpdateSelectDisplay;
end;


procedure TTabs.bDeleteItemClick(Sender: TObject);
var index:integer;
begin
 (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex].Free;
 index:=dhSelect1.SelectedIndex;
 UpdateAllSelects;
 if (index=dhSelect1.Count) and (index-1>=0) then
  dhSelect1.Items[index-1].Selected:=true;
 Changed('Delete Item');
end;

procedure TTabs.mClearAllStylesClick(Sender: TObject);
begin
 ClearAllStyles(false);
 StylesChanged;
 UpdateSel;
end;

procedure TTabs.mClearStylesClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).ActStyle.Clear;
 StylesChanged;
 UpdateSel;
end;

procedure TTabs.mGetUseStylesClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).GetStylesFromUse;
 StylesChanged;
 UpdateSel;
end;

procedure TTabs.bMoveItemUpClick(Sender: TObject);
begin
 with (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex] do
  Index:=Index-1;
 UpdateAllSelects;                   
 dhSelect1.Items[dhSelect1.SelectedIndex-1].Selected:=true;
 Changed('Move Item Up');
end;

procedure TTabs.eSelectLabelValueChange(Sender: TObject;
  Clear: Boolean);
begin
 (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex].Text:=eSelectLabel.Text;
 UpdateAllSelects;
end;

procedure TTabs.eSelectValueValueChange(Sender: TObject;
  Clear: Boolean);
begin
 (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex].Value:=eSelectValue.Text;
 UpdateAllSelects;
end;

procedure TTabs.cSelectSelectedClick(Sender: TObject);
begin
 if Adjusting then exit;
 (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex].Selected:=cSelectSelected.Checked;
 UpdateAllSelects;
end;

procedure TTabs.dhSelect1Click(Sender: TObject);
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
  eSelectLabel.StoredText:=EmptyStr;
  eSelectValue.StoredText:=EmptyStr;
  cSelectSelected.Checked:=false;
 end;
 Adjusting:=false;
end;

procedure TTabs.cMultipleClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhSelect).Multiple:=cMultiple.Checked;
 UpdateSelectDisplay;
 Changed('Multiple Selection');
end;

procedure TTabs.cDropDownClick(Sender: TObject);
var i:integer;
const bSelectType:array[boolean] of TSelectType=(stDropDown,stList);
begin
 cMultiple.Enabled:=cList.Checked;
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhSelect).SelectType:=bSelectType[cList.Checked]; 
 UpdateSelectDisplay;
 Changed('Select Type');
end;

procedure TTabs.bMoveItemDownClick(Sender: TObject);
var i:integer;
begin
 with (ActPn as TdhSelect).Items[dhSelect1.SelectedIndex] do
  Index:=Index+1;
 UpdateAllSelects;
 dhSelect1.Items[dhSelect1.SelectedIndex+1].Selected:=true;
 Changed('Move Item Down');
end;

procedure TTabs.eCheckValueValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhCheckBox).Value:=eCheckValue.Text;
end;

procedure TTabs.cFontFamilyValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 if Adjusting then exit;
 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
  if TObject(Selection[i]) is TdhCustomPanel then
  begin
   if Clear then
    TdhCustomPanel(TObject(Selection[i])).ActStyle.FontFamily:=EmptyStr else
    TdhCustomPanel(TObject(Selection[i])).ActStyle.FontFamily:=cFontFamily.Text
  end else
   TFakeControl(Selection[i]).Font.Name:=GetNearestFont(cFontFamily.Text);
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdateFontDisplay;
end;

procedure TTabs.cFontSizeValueChange(Sender: TObject; Clear: Boolean);
var i,fs:integer;
begin
 if Adjusting then exit;
 dhMainForm.Act.MySiz.DoInval(true);
 try
  for i:=0 to Selection.Count-1 do
  if TObject(Selection[i]) is TdhCustomPanel then
  begin
   if Clear then
    TdhCustomPanel(TObject(Selection[i])).ActStyle.FontSize:=EmptyStr else
    TdhCustomPanel(TObject(Selection[i])).ActStyle.FontSize:=cFontSize.Text;
  end else
  if TryStrToInt(cFontSize.Text,fs) then
   TFakeControl(Selection[i]).Font.Height:=-fs;
 finally
  dhMainForm.Act.MySiz.DoInval(false);
 end;
 UpdateFontDisplay;
end;

procedure TTabs.cEdgeAllClick(Sender: TObject);
begin
 CommitChanges;
 {if EdgeAlignBut<>nil then
 begin
  EdgeAlignBut.Down:=false;
  SetUnderlineState(EdgeAlignBut,true);
 end;}
 EdgeAlign:=GetEdgeAlign(Sender);
 {EdgeAlignBut:=Sender as TdhLink;
 EdgeAlignBut.Down:=true;
 if EdgeAlignBut=cEdgeAll then EdgeAlign:=ealNone;
 if EdgeAlignBut=cEdgeTop then EdgeAlign:=ealTop;
 if EdgeAlignBut=cEdgeRight then EdgeAlign:=ealRight;
 if EdgeAlignBut=cEdgeLeft then EdgeAlign:=ealLeft;
 if EdgeAlignBut=cEdgeBottom then EdgeAlign:=ealBottom;}
 UpdateBorderDisplay;
end;

procedure TTabs.dhLink9Click(Sender: TObject);
begin
 CommitChanges;
 if Sender=dhLink9 then BlurIndex:=0;
 if Sender=dhLink12 then BlurIndex:=1;
 if Sender=dhLink11 then BlurIndex:=2;
 if Sender=dhLink10 then BlurIndex:=3;
 if Sender=dhLink13 then BlurIndex:=4;
 UpdateEffectsDisplay;
end;

function TTabs.ActSel: TControl;
begin
 if Selection.Count<>0 then
  result:=TObject(Selection[0]) as TControl else
  result:=nil;
end;

procedure TTabs.gScrollingClick(Sender: TObject);
var i:integer;
    page:TdhPage;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
 begin
  page:=(TObject(Selection[i]) as TdhPage);
  page.Scrolling:=TScrolling(gScrolling.ItemIndex);
  if page.Scrolling=scNo then
  begin
   page.VertPosition:=0;
   page.HorzPosition:=0;
  end;                  
 end;
 Changed('Change Scrolling');
end;

procedure TTabs.cImageFormatClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
  (TObject(Selection[i]) as TdhCustomPanel).ImageFormat:=TImageFormat(cImageFormat.ItemIndex);
 Changed('Change Image Format');
end;

procedure TTabs.PageControl1Change(Sender: TObject);
begin    
 UpdateContainer;
end;

procedure TTabs.AnchorPureHTMLShow(Sender: TObject);
begin
 UpdatePureHTMLDisplay;
end;

procedure TTabs.UpdatePureHTMLDisplay;
begin
 if DoNotUpdateDisplay then exit;
 Adjusting:=true;
 ePureHTML.StoredText:=(ActPn as TdhDirectHTML).InnerHTML;
 cGenerateContainingElement.Checked:=(ActPn as TdhDirectHTML).GenerateContainer;
 Adjusting:=false;
end;

procedure TTabs.ePureHTMLValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhDirectHTML).InnerHTML:=ePureHTML.Text;
end;

const getBS:array[boolean] of TCSSBorderStyle=(cbsNone,cbsSolid);

procedure TTabs.EffectsMainStateTransition(Sender: TdhCustomPanel;
  OldState: TState);
begin

 EffectsMain_Border.Visible:=not (EffectsMain.State in [hsDown,hsOverDown]);
 EffectsBlur_Border.Visible:=not (EffectsBlur.State in [hsDown,hsOverDown]);
 EffectsTransformations_Border.Visible:=not (EffectsTransformations.State in [hsDown,hsOverDown]);
 //EffectsMain_top.Visible:=EffectsMain.State in [hsDown,hsOverDown];

 {if EffectsBlur_Border.Text=EmptyStr then
  EffectsBlur_Border.Text:='X' else
  EffectsBlur_Border.Text:=EmptyStr;   }

 EffectsMain2_Border.Visible:=not (EffectsMain2.State in [hsDown,hsOverDown]);
 EffectsBlur2_Border.Visible:=not (EffectsBlur2.State in [hsDown,hsOverDown]);
 EffectsTransformations2_Border.Visible:=not (EffectsTransformations2.State in [hsDown,hsOverDown]);
 //EffectsMain2_top.Visible:=EffectsMain2.State in [hsDown,hsOverDown];
end;

procedure TTabs.gHTMLFrameClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhPage).UseIFrame:=gHTMLFrame.ItemIndex=1;
 UpdatePageDisplay;
 Changed('Change Scrolling Implementation');
end;

procedure TTabs.dhSelect1GetDisplayText(Sender: TObject;
  Item: TSelectOption; var DisplayText: WideString);
begin
 if (ActPn as TdhSelect).Items[Item.Index].Selected then
  DisplayText:=DisplayText+'<small> (selected)</small>';
end;

procedure TTabs.cLinkFormClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhLink).FormButtonType:=TFormButtonType(cLinkForm.ItemIndex);
 LinkChanged;
end;

procedure TTabs.cGenerateContainingElementClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhDirectHTML).GenerateContainer:=cGenerateContainingElement.Checked;
 UpdatePureHTMLDisplay;
 Changed('Generate containing element');
end;


procedure TTabs.cbMethodClick(Sender: TObject);
var i:integer;
begin
 if Adjusting then exit;
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhHTMLForm).Method:=TFormMethod(cbMethod.ItemIndex);
 Changed('Change Form Request Method');
end;

procedure TTabs.eTooltipValueChange(Sender: TObject; Clear: Boolean);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 if TObject(Selection[i]) is TdhCustomPanel then
  TdhCustomPanel(TObject(Selection[i])).Tooltip:=eTooltip.Text else
 if TObject(Selection[i]) is TControl then
  TdhCustomPanel(TObject(Selection[i])).Hint:=eTooltip.Text;
end;

procedure TTabs.cExcludeTextClick(Sender: TObject);
begin
 if Adjusting then exit;
 if cExcludeText.Checked then
  cTextOnly.Checked:=false;
 BuildTransformations;
end;

procedure TTabs.cTextOnlyClick(Sender: TObject);
begin
 if Adjusting then exit;
 if cTextOnly.Checked then
  cExcludeText.Checked:=false;
 BuildTransformations;
end;




procedure TTabs.IGNORE_cUsageClick(Sender: TObject);
begin
{$IFNDEF CLX}
 (TObject(Selection[0]) as TdhOleContainer).Usage:=TOleUsage(IGNORE_cUsage.ItemIndex);
{$ENDIF}
end;


procedure TTabs.Button6Click(Sender: TObject);
begin       
{$IFNDEF CLX}
  (TObject(Selection[0]) as TdhOleContainer).ole.MySaveToFile('c:\my.swf.bmp');     
{$ENDIF}
end;
                     
function ExtractPureFileName(const FileName:TPathName):TPathName;
begin
    Result:=ExtractFileName(FileName);
    Result:=CopyLess(Result,Length(ExtractFileExt(Result)));
end;

procedure TTabs.InitialLoadFile(f:TdhFile);
begin        {
 OpenDialog1.Filter:=EmptyStr;
 OpenDialog1.DefaultExt:=EmptyStr;    }
 if OpenDialog1.Execute then
 begin
  LoadFile(f);
 end else
  f.Linked:=cLinked.Checked;
end;

procedure TTabs.LoadFile(f:TdhFile);
begin
    f.LoadFromFile(OpenDialog1.FileName,cLinked.Checked);
    if LowerCase(ExtractFileExt(OpenDialog1.FileName))='.swf' then
     f.Usage:=fuFlash;
    if LowerCase(ExtractFileExt(OpenDialog1.FileName))='.js' then
     f.Usage:=fuJavascript;
  try
   if f.HasFile then
   begin
    f.Name:=ExtractPureFileName(f.GetAbsolutePath);
   end;
  except
  end;

end;



procedure TTabs.Button15Click(Sender: TObject);
var i:integer;
    f:TdhFile;
begin
 OpenDialog1.Filter:=EmptyStr;
 OpenDialog1.DefaultExt:=EmptyStr;
 f:=TObject(Selection[0]) as TdhFile;
 if f.HasFile then
 begin
  OpenDialog1.FileName:=f.GetAbsolutePath
 end else
 begin
  OpenDialog1.FileName:=EmptyStr;
  OpenDialog1.InitialDir:=ExtractFilePath(OpenDialog1.FileName);
 end;

 if f.Usage=fuJavascript then
 begin
  OpenDialog1.Filter:='Javascript (*.js*)|*.js';
  OpenDialog1.DefaultExt:='js';
 end;
 if f.Usage=fuFlash then
 begin
  OpenDialog1.Filter:='Flash (*.swf*)|*.swf';
  OpenDialog1.DefaultExt:='swf';
 end;
 if OpenDialog1.Execute then
 begin
   for i:=0 to Selection.Count-1 do
   begin
    LoadFile(TObject(Selection[i]) as TdhFile);
   end;
  UpdateFileDisplay;
  Changed('Load File Contents');
 end;
end;

procedure TTabs.bSaveToFileClick(Sender: TObject);
begin
// if SaveDialog1.Execute then
// (TObject(Selection[0]) as TdhFile).SaveToFile(SaveDialog1.FileName);
end;

procedure TTabs.AnchorFileShow(Sender: TObject);
begin
 UpdateFileDisplay;
end;



function GetByteStr(l:Integer): string;
begin
 if l<1024 then
  FmtStr(Result, '%d Byte', [l]) else
 if (l<1024*1024) then
  FmtStr(Result, '%0:d.%d KB', [l div 1024, ((l mod 1024)*1000 div 1024) div 100]) else
 if l<1024*1024*1024 then
  FmtStr(Result, '%d.%.2d MB', [l div (1024*1024),      (((l div 1024) mod 1024)*1000 div 1024) div 10]) else
  FmtStr(Result, '%d.%.2d GB', [l div (1024*1024*1024), (((l div (1024*1024)) mod 1024)*1000 div 1024) div 10]);
end;

procedure TTabs.UpdateFileDisplay;
var f:TdhFile;
    fileInfo:DKString;
    fsize:integer;
    sfsize:String;
begin               
 if DoNotUpdateDisplay then exit;
 Adjusting:=true;
 f:=(TObject(Selection[0]) as TdhFile);
 //bGoToFile.Enabled:=f.HasFile;
 //bSaveToFile.Enabled:=f.HasFile;
 cFileUsage.ItemIndex:=Integer(f.Usage);
 cLoop.Visible:=f.Usage in [fuFlash,fuMusic];
 cLoop.Checked:=f.Loop;
 lFileInfo.Visible:=f.HasFile;
 cLinked.Checked:=f.Linked;
 cLinked.Visible:=not f.Linked;
 if f.HasFile then
 begin
  fsize:=f.FileSize;
  if fsize=-1 then
   sfsize:='(File not found)' else
   sfsize:=GetByteStr(fsize);
  fileInfo:=DKFormat(FILEINFO_FILENAME)+': '+ProposedFileName(f)+'<br>'+DKFormat(FILEINFO_FILESIZE)+':'+sfsize+'<br>'+'<STYLE_FileInfo>'+DKFormat(FILEINFO_HOWTOLINK,f.Name)+'</STYLE_FileInfo>';
  if f.Usage=fuMusic then
   fileInfo:=fileInfo+'<br>'+'<STYLE_FileInfo>'+DKFormat(FILEINFO_MUSIC)+'</STYLE_FileInfo>';
  if f.Usage=fuFlash then
   fileInfo:=fileInfo+'<br>'+'<STYLE_FileInfo>'+DKFormat(FILEINFO_FLASH)+'</STYLE_FileInfo>';
  if f.Usage=fuJavascript then
   fileInfo:=fileInfo+'<br>'+'<STYLE_FileInfo>'+DKFormat(FILEINFO_JAVASCRIPT)+'</STYLE_FileInfo>';
  lFileInfo.Text:=fileInfo;
 end;
 Adjusting:=false;
end;

procedure TTabs.bGoToFileClick(Sender: TObject);
begin
 Browse((TObject(Selection[0]) as TdhFile).GetAbsolutePath,EmptyStr,true,true);
end;

procedure TTabs.cFileUsageClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhFile).Usage:=TFileUsage(cFileUsage.ItemIndex);
  UpdateFileDisplay;
  Changed('Changed File Usage');
end;

procedure TTabs.Button18Click(Sender: TObject);
var i:integer;
    f:TdhFile;
begin
   for i:=0 to Selection.Count-1 do
   begin
    f:=(TObject(Selection[i]) as TdhFile);
    if f.HasFile and f.Linked then
     f.LoadFromFile(f.GetAbsolutePath,f.Linked);
   end;
  UpdateFileDisplay;
  Changed('Reload File Contents');
end;

procedure TTabs.cLoopClick(Sender: TObject);
var i:integer;
begin
  if Adjusting then exit;
  for i:=0 to Selection.Count-1 do
   (TObject(Selection[i]) as TdhFile).Loop:=cLoop.Checked;
  UpdateFileDisplay;
  Changed('Changed Loop');
end;

procedure TTabs.cLinkedClick(Sender: TObject);
var i:integer;
    f:TdhFile;
begin
  if Adjusting then exit;
  try
   for i:=0 to Selection.Count-1 do
   begin
    f:=(TObject(Selection[i]) as TdhFile);
    f.Linked:=cLinked.Checked;
   end;
  finally
   UpdateFileDisplay;
   Changed('Changed Linked');
  end;
end;
procedure TTabs.FormCreate(Sender: TObject);
begin           
//SendMessage(PageControl1.Handle, WM_SIZE, SIZE_RESTORED,
//        Word(PageControl1.Width) or Word(PageControl1.Height) shl 16);
  Panel1.Style.BackgroundColor:=ColorToCSSColor(clBtnFace);
  PageControl1.Align:=alClient;
  Adjusting:=true;
  EdgeAlign:=ealNone;
  Selection:=TList.Create;
  PageControl1.MultiLine:=true;
  SetPrecise(EdgeNavigation);

{$IFNDEF CLX}
 //cbUse.OnDrawItem:=cbUseDrawItem;
 //cbLinkPage.OnDrawItem:=cbLinkPageDrawItem;
 //cbLinkAnchor.OnDrawItem:=cbLinkPageDrawItem;

 cbCursor.OnDrawItem:=cbCursorDrawItem;
 cbCursor.OnMeasureItem:=cbCursorMeasureItem;
 cbCursor.Style:=csOwnerDrawVariable;

 //PageControl1.OwnerDraw:=true;
 //PageControl1.DoubleBuffered:=true; //DoubleBuffered=true not works for Delphi2006/WinXP-Style
 //PageControl1.OnDrawTab:=PageControl1DrawTab;
 //TabSheet7.DoubleBuffered:=true; //DoubleBuffered=true not works for Delphi2006/WinXP-Style
 //bBorderRadius.WordWrap:=true;
 //bMoreMisc.WordWrap:=true;

{$ELSE}
 PageControl1.OnDrawTab:=PageControl1DrawTabCLX;

 //cbUse.OnDrawItem:=cbUseDrawItemCLX;
 //cbLinkPage.OnDrawItem:=cbLinkPageDrawItemCLX;
 //cbLinkAnchor.OnDrawItem:=cbLinkPageDrawItemCLX;

 // cbCursor.OnDrawItem:=cbCursorDrawItemCLX;
// cbCursor.OnMeasureItem:=cbCursorMeasureItem;
{$ENDIF}

 STYLE_dhLabel11.Style.Border.Assign(STYLE_dhLink2.StyleDown.Border);
 STYLE_dhLabel11.Style.BorderTop.Assign(STYLE_dhLink2.StyleDown.BorderTop);
 STYLE_dhLabel11.Style.BorderBottom.Assign(STYLE_dhLink2.StyleDown.BorderBottom);
 STYLE_dhLabel11.Style.BorderLeft.Assign(STYLE_dhLink2.StyleDown.BorderLeft);
 STYLE_dhLabel11.Style.BorderRight.Assign(STYLE_dhLink2.StyleDown.BorderRight);
 //dhLabel11.Style.BorderRadius.Assign(dhLink2.StyleDown.BorderRadius);
 STYLE_dhLabel11.Style.BackgroundImage.Assign(STYLE_dhLink2.StyleDown.BackgroundImage);

{$IFDEF CLX}
 PageControl1.Color:=clRed;
 PageControl1.Color:=clBtnFace;
{$ENDIF}
 cDownIfMenu.Visible:=dhMainForm.CompMenu.Visible;    
 UpdateAlign;
 dhMainForm.UpdateCommands(true,true);
 UpdateTabImages;
end;

procedure TTabs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DoOnClose(Sender,Action);
end;

procedure TTabs.mCutClick(Sender: TObject);
begin      
 mCopyClick(Sender);
 mDeleteClick(Sender);
end;

procedure TTabs.mCopyClick(Sender: TObject);
begin
 dhMainForm.mCopyClick(Sender);
end;

procedure TTabs.mDeleteClick(Sender: TObject);
begin
 dhMainForm.mDeleteClick(Sender);
end;

procedure TTabs.mPasteClick(Sender: TObject);
begin
 dhMainForm.mPasteClick(Sender);
end;

procedure TTabs.mFullCopyClick(Sender: TObject);
begin
 dhMainForm.mFullCopyClick(Sender);
end;

procedure TTabs.mGotoMenuClick(Sender: TObject);
var link:TdhLink;
begin
 link:=TObject(Selection[0]) as TdhLink;
 (TControl(Selection[0]).Owner as TPageContainer).MySiz.SetControlTo(link.SubMenu,true,true);
end;

procedure TTabs.cMenuAutoClick(Sender: TObject);
var mm,menu: TdhMenu;
    asked:boolean;
    i:integer;
begin
 if Adjusting then exit;
 if not cMenuAuto.Checked then
 begin
  asked:=false;
  for i:=0 to Selection.Count-1 do
  begin
   menu:=ChooseTwice(i,TdhMenu) as TdhMenu;
   mm:=menu.ComputedMenu;
   if (mm<>nil) and (mm<>menu) then
   begin
    if not asked then
    case MessageDlg(DKFormat(DUPLICATEEFFECTS), mtConfirmation,[mbYes, mbNo], 0) of
    {idYes}mrYes: asked:=true;
    else break;
    end;
    menu.AssignMenuSettings(mm);
   end;
   //Effects.Enabled:=true;
  end;
  if asked then
   UpdateMenuDisplay;
 end;
 cHorizontalLayoutClick(nil);  
end;

procedure TTabs.mSetBackgroundColorTransparentClick(Sender: TObject);
var bmp32:TBitmap32;
    src:TPersistent;
    col32:TColor32;
    x,y:integer;
begin
 bmp32:=nil;
 try
  bmp32:=GetAs32(dhPanel1.Style.BackgroundImage.RequestGraphic);
  if (bmp32<>nil) and not bmp32.Empty then
  begin
   col32:=bmp32.Pixel[0,bmp32.Height-1];
   for x:=0 to bmp32.Width-1 do
   for y:=0 to bmp32.Height-1 do
   begin
     if bmp32.Pixel[x,y]=col32 then
      bmp32.Pixel[x,y]:=$0;
   end;
   src:=GetGifImageFromBitmap32(bmp32,bmp32);
   try
    with TObject(Selection[0]) as TdhCustomPanel do
     ActStyle.BackgroundImage.Assign(src);
   finally;
    src.Free;
   end;
   LiveBackgroundChanged;
   Changed('Change Image Colors');
  end;
 finally
  FreeAndNil(bmp32);
 end;
end;

procedure TTabs.mCopyOverStylesToDownStylesClick(Sender: TObject);
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
  (TObject(Selection[i]) as TdhCustomPanel).CopyStyles(hsOver,hsDown);
 StylesChanged;
 UpdateSel;
end;

end.

