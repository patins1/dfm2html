unit dhMenu;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QExtCtrls,
  {$ELSE}
  Controls, Windows, Messages, Graphics, Forms, Dialogs, ExtCtrls,
  {$ENDIF}
  SysUtils, Classes, math, typinfo, {$IFNDEF VER130} types, {$ENDIF}
  dhPanel, dhLabel, dhPageControl, dhStyleSheet, dhStrUtils;

type TMenuOption=(moNoAuto,moHorizontalLayout,moInline,moSlide,moClickToOpen,moResumeOpen,moStatic);
     TMenuOptions=set of TMenuOption;
type TAnchorOption=(loNoAuto,loDownIfOver,loDownIfMenu,loDownIfMouseDown,loDownIfURL,loNoOverIfDown);
     TAnchorOptions=set of TAnchorOption;
     TLinkType=(ltAuto,ltText,ltLink,ltButton);
var glOnHistory:procedure(Sender:TControl);
var glOnAfterNavigate:procedure(Sender:TdhPage);

const NoExtraVerticalMenuStyle=true;
const RelMenuPosIsNoExtraMenuStyle=true;
const DisableMenuPos=false;

var INVALIDMENUNESTING_STR:WideString= 'Menu % cannot be opened by the link % because the link is a child of the menu.';

type
  TdhMenu=class;

  TdhDynLabel=class(TdhLabel)
  private
    FLayout: TLinkType;
    FPreferDownStyles:boolean;
    function IsButton:boolean;
    procedure SetLayout(const Value: TLinkType);
    procedure WriteComputedLayout(Writer: TWriter);
    procedure SetPreferDownStyles(const Value: boolean);
  protected
    function IsAnchor:boolean; virtual;
    function ShallBeAnchor:boolean; override;
    procedure CopyObjectStylesFrom(src:TdhCustomPanel; sub:boolean; test:TdhCustomPanel); override;
    procedure ClearObjectStyles; override;
    function TotalInlineBox: boolean; override;  
    function GetPreferDownStyles:boolean; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoStateTransition(OldState: TState); override;
    function TransitionInvalidates: boolean; override;
{$IFNDEF CLX}
    procedure WndProc(var Message:TMessage); override;
{$ENDIF}
    function GetInlineHTMLState(Over,Down:boolean):TState; override;
    function IncludeBorderAndPadding:boolean; override;
    function GetFinal:ICon; override;
    function CenterVertical:boolean; override;
    function GetDefaultLayout:TLinkType; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    function ComputedLayout:TLinkType;
    procedure Click; override;
  published
    property StyleDown:TStyle index hsDown read GetStyle write SetStyle;
    property StyleOver:TStyle index hsOver read GetStyle write SetStyle;
    property StyleOverDown:TStyle index hsOverDown read GetStyle write SetStyle;
    property OnStateTransition;
    property Layout:TLinkType read FLayout write SetLayout default ltAuto;
    property PreferDownStyles:boolean read FPreferDownStyles write SetPreferDownStyles;
  end;

  TdhLink = class(TdhDynLabel)
  private
    FFormButtonType:TFormButtonType;
    procedure WriteSLinkPage(Writer: TWriter);
    procedure ReadSLinkPage(Reader: TReader);
    procedure WriteSLinkAnchor(Writer: TWriter);
    procedure ReadSLinkAnchor(Reader: TReader);
    function GetAuto: boolean;
    procedure SetAuto(const Value: boolean);
    function ComputedLink: TdhLink;
    procedure SetFormButtonType(Value:TFormButtonType);
    function GetVerticalLayout:boolean;
  protected
    FSubMenu:TdhMenu;
    FLink:TPathName;
    FLinkAnchor:TdhCustomPanel;
    FLinkPage:TdhPage;
    FTarget:TPathName;
    FOptions:TAnchorOptions;
    FPageRange:integer;
    FDown:boolean;
    function ComputedOptions:TAnchorOptions;
    procedure CopyObjectStylesFrom(src:TdhCustomPanel; sub:boolean; test:TdhCustomPanel); override;
    procedure ClearObjectStyles; override;
    function GetDefaultLayout:TLinkType; override;
    function GetInlineHTMLState(Over,Down:boolean):TState; override;
    function GetHTMLState:TState; override;
    procedure UpdateSubMenuCoords;
    function SubmenuOpen:boolean;
    procedure Loaded; override;
    procedure LinkDestinationChanged;
    procedure SetLink(Value:TPathName);
    procedure SetLinkAnchor(Value:TdhCustomPanel);
    procedure SetLinkPage(Value:TdhPage);
    procedure SetTarget(Value:TPathName);
    procedure ClearAnchors(LinkAnchorToo:boolean);
    function GetChildParent: TComponent; override;
    function IsAnchor:boolean; override;
    procedure TimerNotify(Sender: TObject);
    procedure WriteTrue(Writer: TWriter);
    procedure WriteRealLastPage(Writer: TWriter);
    procedure WriteRealLinkPage(Writer: TWriter);
    function GetLastPage:TdhPage;
    function RealLastPage:TdhPage;
    function RealLinkPage:TdhPage;
    procedure DefineProperties(Filer: TFiler); override;
    function NeedJS:boolean;
    function NeedID:boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetOptions(Value:TAnchorOptions);
    procedure UpdateMenuItemDesign;
    function HasParentMenu(var P:TdhMenu):boolean;
    function ResumeOpen:boolean;
    function IsClickToOpen:boolean;
    procedure SetDown(Value:boolean);
    function DownIfDown:boolean; override;
    function GetNextPage(CurrPage:TdhPage):TdhPage;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure FocusPreferStyle(IsMain,RealChange:boolean); override;
    function BoundNextSibling:TdhCustomPanel; override;
  public
    SLinkPage:TComponentName;
    SLinkAnchor:TComponentName;
    function IsActivated:boolean;
    procedure DoClickAction(Initiator:TdhCustomPanel); override;
    property Auto:boolean read GetAuto write SetAuto;
    function AutoRelevant:boolean;
    class procedure NavigateLocation(Page: TdhPage; Anchor: TControl; ActivatedBy:TdhLink);
    procedure TryBrokenReferences(sl:TStringList); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function SuitableKind:TDesignedFor; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddSubMenu:TdhMenu;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function LinkBase:TWinControl;
    function AllHTMLCode:HypeString; override;
    procedure PreferStyleChangeMenuSibling(caller:TdhCustomPanel; ClearPrefer:boolean);
    property SubMenu:TdhMenu read FSubMenu;
  published
    property Options:TAnchorOptions read FOptions write SetOptions nodefault{ default [aoDownIfMenu]};
    property Down:boolean read FDown write SetDown default false;
    property Link:TPathName read FLink write SetLink;
    property LinkPage:TdhPage read FLinkPage write SetLinkPage;
    property LinkAnchor:TdhCustomPanel read FLinkAnchor write SetLinkAnchor;
    property Target:TPathName read FTarget write SetTarget;
    property PageRange:integer read FPageRange write FPageRange default 0;
    property FormButtonType:TFormButtonType read FFormButtonType write SetFormButtonType default fbNone;
  end;

  TdhMenu = class(TdhPanel)
  private
    function IsMainMenu: boolean;
    procedure SetReactionTime(const Value: TReactionTime);
    procedure UpdateParent;
    procedure CopyObjectStylesFrom(src: TdhCustomPanel; sub: boolean;
      test: TdhCustomPanel); override;
    function GetAuto: boolean;
    procedure SetAuto(const Value: boolean);
    function ComputedMenuPos:TPoint;
  protected
    FMenuOptions:TMenuOptions;
    FMenuLeft,FMenuTop:integer;
    FParentMenuItem:TdhLink;
    OriWidthHeight:TPoint;
    OriAutoSizeXY:TASXY;
    FSlidePixel:TSlidePixel;
    FReactionTime:TReactionTime;
    CancelSetMenuPos:boolean;
    procedure RestoreSlide;
    procedure DoCSSToWinControl(WhatChanged:TWhatChanged); override;
    procedure ClearObjectStyles; override;
    procedure SetParent({$IFDEF CLX}const {$ENDIF}AParent: TWinControl); override;
    function GetMenuCoordsOrigin:TPoint;
    function GetRelativePos:TPoint;
    procedure UpdateMenuCoords;
    procedure SetMenuLeft(Value:integer);
    procedure SetMenuTop(Value:integer);
    procedure SetMenuPos(Left,Top:integer);
    function GetMenuPosBrothers(NeedOnlyOne:boolean=false; without:TdhMenu=nil):TList;
    function GetMenuPosBrother(without:TdhMenu):TdhMenu;
    procedure UpdateMenuPos;
    function GetIsInlineMenu:boolean;
    procedure UpdateInlineMenu;
    procedure UpdateVerticalLayout;
    procedure SetParentMenuItem(Value:TdhLink);
    procedure WriteState(Writer: TWriter); override;
    procedure WriteRealMenuLeft(Writer: TWriter);
    procedure WriteRealMenuTop(Writer: TWriter);
    procedure WriteMenuLeft(Writer: TWriter);
    procedure WriteMenuTop(Writer: TWriter);
    procedure ReadMenuLeft(Reader: TReader);
    procedure ReadMenuTop(Reader: TReader);
    procedure WritePadw(Writer: TWriter);
    procedure WriteAlPos(Writer: TWriter);
    procedure WriteOnlyIf(Writer: TWriter);
    procedure DefineProperties(Filer: TFiler); override;
    procedure SlideNotify(Sender: TObject);
    procedure SlideUpNotify(Sender: TObject);
    procedure SetMenuOptions(Value:TMenuOptions);
    procedure ControlsListChanged(Control: TControl; Inserting: Boolean); override;
    procedure GetMenuThings(ls:TList; AllNested:boolean=false);
    function FindSuitable(MenuStyles:TList; SuitableKind:TDesignedFor; Lev:Integer; var BestUse:TdhCustomPanel; ForWhich:TControl):boolean;
    procedure VisibleChanged; override;
    procedure SetSlidePixel(Value:TSlidePixel);
    function NewControlsAlign:TAlign;
    function HasOpenedMenu:boolean;
    function GetVerticalLayout:boolean;
    property VerticalLayout:boolean read GetVerticalLayout;
    function GetTotalPos:TPoint;
    function IsVirtual:boolean;
    function LeaveY:boolean; override;
    procedure PrepareAlign; override;
    procedure AlignDone; override;
    procedure NotifyUseChanged(OldValue: ICon); override;
    function AdjustZIndex(ChildPos,ParentControlCount:integer):integer; override;
    function MenuPos:TPoint;
    procedure CalcVariableSizes(FirstPass:boolean); override;
  public
    function BoundTop:Integer; override;
    procedure AssignMenuSettings(fromMenu:TdhMenu);
    function ComputedMenu: TdhMenu;
    function AutoRelevant: boolean;
    property Auto:boolean read GetAuto write SetAuto;
    function VirtualParent:TControl; override;
    function SuitableKind:TDesignedFor; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function AddMenuItem:TdhLink;
    property MenuLeft:integer read FMenuLeft write SetMenuLeft stored not DisableMenuPos default 0;
    property MenuTop:integer read FMenuTop write SetMenuTop stored not DisableMenuPos default 0;
    property IsInlineMenu:boolean read GetIsInlineMenu stored false;
    procedure OpenMenu;
  published
    property Visible stored false;
    property MenuOptions:TMenuOptions read FMenuOptions write SetMenuOptions;
    property ParentMenuItem:TdhLink read FParentMenuItem write SetParentMenuItem stored false;
    property SlidePixel:TSlidePixel read FSlidePixel write SetSlidePixel default 1;
    property ReactionTime:TReactionTime read FReactionTime write SetReactionTime nodefault;
  end;

function GetParentPage(P:TControl; SameLevel:boolean=false; AllowPage:boolean=true):TWinControl;
function FindPage(c:TControl; var res:TWinControl; RealActivePage:boolean):boolean;
procedure ScrollInView(p,cc:TControl; ForceTop:boolean);


procedure Register;

implementation

uses BasicHTMLElements,dhHTMLForm;


var SlideTimer,LinkTimer:TTimer;

const DefaultPreferDownStyles=true;
  
const AnchorNameBase='Link';
      MenuNameBase='Menu';

var
    TailSubMenu:TdhMenu=nil;
    ToOpen:TdhMenu=nil;
    IsSliding:boolean=false;

function FindPage(c:TControl; var res:TWinControl; RealActivePage:boolean):boolean;
var i:integer;
    r:TdhPage;
begin
 if (c is TdhPageControl) then
 begin
  if RealActivePage then
   r:=TdhPageControl(c).RealActivePage else
   r:=TdhPageControl(c).ActivePage;
  if r<>nil then
  begin
   res:=r;
   result:=true;
   exit;
  end;
 end;
 if c is TWinControl then
 with TWinControl(c) do
 for i:=0 to ControlCount-1 do
 if not((Controls[i] is TdhPage) and (TdhPage(Controls[i]).PageControl<>nil)) then
 if FindPage(Controls[i],res,RealActivePage) then
 begin
  result:=True;
  exit;
 end;
 result:=false;
end;

function GetParentPage(P:TControl; SameLevel:boolean; AllowPage:boolean):TWinControl;
begin
 if SameLevel and (P is TWinControl) then
  result:=TWinControl(P) else
  result:=P.Parent;
 while (result<>nil) and not ((result is TCustomForm) or (result is TdhPage) and TdhPage(result).IsHTMLBody or AllowPage and (result is TdhPage) and (TdhPage(result).PageControl<>nil)) do
  result:=result.Parent;
end;

procedure SetIsSliding(_IsSliding:boolean;m:TdhMenu);
begin
 IsSliding:=_IsSliding;
end;


procedure SetTimer(OnTimer: TNotifyEvent; Interval:Cardinal; const Timer:TTimer);
begin
 if Timer.Enabled then
 begin
  Timer.OnTimer(nil);
 end;
   assert(not Timer.Enabled);
   Timer.Enabled:=false;
   Timer.Interval:=Interval;
   Timer.OnTimer:=OnTimer;
   Timer.Enabled:=true;
end;


procedure TdhMenu.RestoreSlide;
begin
  Height:=OriWidthHeight.Y;
  Width:=OriWidthHeight.X;
  AutoSizeXY:=OriAutoSizeXY;
  SlideTimer.Enabled:=False;
  SetIsSliding(false,self);
end;



procedure glCheckClose(CloseItem:TdhLink=nil);
var p:TdhMenu;
    pn:TControl;
begin
 if (glSelCompo<>nil) and (TailSubMenu<>nil) and (TailSubMenu.Owner<>glSelCompo.Owner) and (ToOpen=nil) then
 begin
  exit;
 end;
 LinkTimer.Enabled:=false;
 p:=TailSubMenu;
 while (p<>nil) and (p.FParentMenuItem<>nil) do
 begin
  TailSubMenu:=p;
  if p.Visible then
  begin
  if not (csDestroying in TailSubMenu.ComponentState) then
  if TailSubMenu.IsVirtualParentOf(ToOpen) then
  begin
    if IsSliding then
    begin
     TailSubMenu.RestoreSlide;
    end;
    break;
  end;
  if (ToOpen=nil) and TailSubMenu.IsVirtualParentOf(glSelCompo) and not((CloseItem<>nil) and CloseItem.IsVirtualParentOf(TailSubMenu)) then
  begin
    break;
  end;
  if (p.Height<>0) and not ((ToOpen<>nil) and (not ToOpen.IsInlineMenu or ToOpen.Visible or not GetParentPage(TailSubMenu).Visible)) then
  if (csDestroying in TailSubMenu.ComponentState) then
  begin
   SlideTimer.Enabled:=false;
  end else
  if (moSlide in p.ComputedMenu.FMenuOptions) and p.IsInlineMenu and p.RuntimeMode then
  begin
   if IsSliding then
    SlideTimer.Enabled:=false;
   SetIsSliding(true,p);
   SetTimer(p.SlideUpNotify,10,SlideTimer);
   exit;
  end else
  if IsSliding then
  begin
   exit;
  end;
  end;
  CancelCheckDesignState:=true;
  p.Visible:=false;
  if p<>TailSubMenu then break;
  if IsSliding then
  begin
   p.RestoreSlide();
  end;
  TailSubMenu:=nil;
  p.FParentMenuItem.CheckDesignState;
  pn:=p.FParentMenuItem;
  while (pn<>nil) and not((pn is TdhMenu) and (TdhMenu(pn).FParentMenuItem<>nil)) do
  if pn is TdhCustomPanel then
   pn:=TdhCustomPanel(pn).VirtualParent else
   pn:=pn.Parent;
  if pn is TdhMenu then
   p:=TdhMenu(pn) else
   break;
 end;

 if not IsSliding and (ToOpen<>nil) then
  ToOpen.OpenMenu;
end;

function GetPageID(LinkPage:TWinControl; FindFile:boolean=False):TControl ;
var apage:TWinControl;
const BottomUp=false;
begin
  apage:=LinkPage;
  if BottomUp then
   while FindPage(apage,apage,true) do
   else
   while (apage is TdhPage) and (TdhPage(apage).PageControl<>nil) do
    apage:=GetParentPage(apage);
  result:=apage;
end;


procedure TdhLink.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var R:TRect;
begin
 R:=BoundsRect;
 Inherited;
 if not EqualRect(R,BoundsRect) then
  UpdateSubMenuCoords;
end;

function TdhLink.AddSubMenu:TdhMenu;
var P:TdhMenu;
    BestUse:TdhCustomPanel;
begin
 result:=nil;
 try
 if Assigned(glPreAddCompo) then
  glPreAddCompo(Self);
 result:=TdhMenu.Create(Owner);
 _SetUniqueName(result,MenuNameBase);
 result.ParentMenuItem:=Self;
 if HasParentMenu(P) and P.FindSuitable(nil,result.SuitableKind,result.GetLev,BestUse,result) then
 begin
  result.Use:=BestUse;  
 end;
 result.AddMenuItem;
 if Assigned(glPostAddCompo) then
  glPostAddCompo(result);
 except
 on e:exception do showmessage('ASDF2 '+e.Message);
 end;
end;

function TdhDynLabel.TransitionInvalidates: boolean;
begin
 result:=true;
end;

procedure TdhLink.WriteRealLastPage(Writer: TWriter);
begin
 Writer.WriteString(FinalID(RealLastPage));
end;

procedure TdhLink.WriteRealLinkPage(Writer: TWriter);
begin
 Writer.WriteString(FinalID(RealLinkPage));
end;

procedure TdhLink.WriteSLinkPage(Writer: TWriter);
begin
 Writer.WriteString(SLinkPage);
end;

procedure TdhLink.ReadSLinkPage(Reader: TReader);
begin
 SLinkPage:=Reader.ReadString;
end;

procedure TdhLink.WriteSLinkAnchor(Writer: TWriter);
begin
 Writer.WriteString(SLinkAnchor);
end;

procedure TdhLink.ReadSLinkAnchor(Reader: TReader);
begin
 SLinkAnchor:=Reader.ReadString;
end;

procedure TdhLink.WriteTrue(Writer: TWriter);
begin
 Writer.WriteBoolean(true);
end;

function TdhLink.NeedJS:boolean;
begin
 result:=(loNoOverIfDown in ComputedOptions) or (loDownIfMouseDown in ComputedOptions) and not IsButton or
         (FSubMenu<>nil) and not (moStatic in FSubMenu.ComputedMenu.FMenuOptions) or
         (FLinkPage<>nil) and FLinkPage.DynamicNavigation or
         ItGetVal(hsOver,pcZIndex) or ItGetVal(hsOverDown,pcZIndex);
end;

function TdhLink.NeedID:boolean;
begin
 result:=(FSubMenu<>nil);
end;

procedure TdhDynLabel.DefineProperties(Filer: TFiler);
begin
 inherited;
 if (csLoading in ComponentState) or not WithMeta and (Filer is TWriter) then exit;
 Filer.DefineProperty('ComputedLayout', nil, WriteComputedLayout, ComputedLayout<>GetDefaultLayout);
end;

procedure TdhLink.DefineProperties(Filer: TFiler);
var NotSelfTargeted:boolean;
begin
  inherited;
  if not WithMeta and (Filer is TWriter) then exit;
  NotSelfTargeted:=(FLinkPage<>nil) and (GetPageID(GetParentPage(Self),True)<>GetPageID(FLinkPage,True));
  Filer.DefineProperty('NeedJS', SkipValue, WriteTrue, NeedJS);
  Filer.DefineProperty('NeedID', SkipValue, WriteTrue, NeedID);
  Filer.DefineProperty('Linked', SkipValue, WriteTrue, (FLinkPage<>nil) and FLinkPage.IsLaterSelected and (GetLastPage=nil) and (NotSelfTargeted or FLinkPage.DynamicNavigation));
  Filer.DefineProperty('RealLastPage', SkipValue, WriteRealLastPage, (GetLastPage<>nil) and FLinkPage.DynamicNavigation and not NotSelfTargeted);
  Filer.DefineProperty('RealLinkPage', SkipValue, WriteRealLinkPage, (FLinkPage<>nil) and FLinkPage.DynamicNavigation and not NotSelfTargeted);
  Filer.DefineProperty('NotIfUrl', SkipValue, WriteTrue, (FLinkPage<>nil) and not (loDownIfUrl in ComputedOptions) and (NotSelfTargeted or FLinkPage.DynamicNavigation));
  Filer.DefineProperty('SLinkPage', ReadSLinkPage, WriteSLinkPage, SLinkPage<>'');
  Filer.DefineProperty('SLinkAnchor', ReadSLinkAnchor, WriteSLinkAnchor, SLinkAnchor<>'');
  Filer.DefineProperty('TabTarget', SkipValue, WriteTrue, False);
  Filer.DefineProperty('Href', SkipValue, WriteTrue, False);
  Filer.DefineProperty('IfUrl', SkipValue, WriteTrue, False);
  Filer.DefineProperty('IfDown', SkipValue, WriteTrue, False);
  Filer.DefineProperty('IsLine', SkipValue, WriteTrue, False);
end;

function TdhLink.GetLastPage:TdhPage;
begin
 if (FPageRange<>0) and (FLinkPage<>nil) and (FLinkPage.PageControl<>nil) then
  result:=FLinkPage.PageControl.Pages[min(FLinkPage.PageIndex+min(abs(FPageRange),1000),FLinkPage.PageControl.PageCount-1)] as TdhPage else
  result:=nil;
end;

function TdhLink.RealLastPage:TdhPage;
begin
 if (FPageRange>=0) then
  result:=GetLastPage else
  result:=FLinkPage;
end;

function TdhLink.RealLinkPage:TdhPage;
begin
 if (FPageRange<0) then
  result:=GetLastPage else
  result:=FLinkPage;
end;

procedure TdhDynLabel.DoStateTransition(OldState:TState);
begin
 NotifyCSSChanged(ActStyleChanged);
 inherited;
end;

function TdhLink.IsActivated:boolean;
begin
 result:=(FLinkPage<>nil) and (loDownIfURL in ComputedOptions) and (FLinkPage.AllowDownIfURL(Self));
end;

function TdhLink.GetHTMLState:TState;
var IsDown:boolean;
begin
  Result:=hsNormal;
  IsDown:=FDown or
     IsActivated or
     (loDownIfOver in ComputedOptions) and (Self=glSelCompo) or
     (FSubMenu=nil) and (csLButtonDown in ControlState) and ((loDownIfMouseDown in ComputedOptions) or IsButton)  or
     (FSubMenu<>nil) and FSubMenu.Visible and (loDownIfMenu in ComputedOptions);
  if (Self=glSelCompo) and not (IsDown and (loNoOverIfDown in ComputedOptions)) then
  begin
   if IsDown then
    Result:=hsOverDown else
    Result:=hsOver;
  end else
  if IsDown then
   Result:=hsDown;
end;

function TdhDynLabel.GetInlineHTMLState(Over,Down:boolean):TState;
var IsDown:boolean;
begin
  result:=hsNormal;
  if Over then
   result:=hsOver;
  IsDown:=(Over and Down);
  if Over then
  begin
   if IsDown then
    Result:=hsOverDown else
    Result:=hsOver;
  end else
  if IsDown then
   Result:=hsDown;
end;

function TdhLink.GetInlineHTMLState(Over,Down:boolean):TState;
var IsDown:boolean;
begin
  result:=hsNormal;
  IsDown:=FDown or
     (FSubMenu=nil) and (Over and Down) and ((loDownIfMouseDown in ComputedOptions) or IsButton);
  if Over and not (IsDown and (loNoOverIfDown in ComputedOptions)) then
  begin
   if IsDown then
    Result:=hsOverDown else
    Result:=hsOver;
  end else
  if IsDown then
   Result:=hsDown;
end;

function TdhDynLabel.IncludeBorderAndPadding:boolean;
begin
 result:=IsButton;
end;

procedure TdhLink.UpdateSubMenuCoords;
begin
  if (FSubMenu=nil) or (FSubMenu.Parent=nil) then exit;
  FSubMenu.UpdateMenuCoords;
end;

                     
{$IFNDEF CLX}
procedure TdhDynLabel.WndProc(var Message:TMessage);
begin
 Inherited;
 if (Message.Msg=WM_LBUTTONDOWN) or (Message.Msg=WM_LBUTTONUP) then
 begin
  CheckDesignState; //csLButtonDown may have changed
 end;           
end;          
{$ENDIF}

function TdhLink.HasParentMenu(var P:TdhMenu):boolean;
begin
 if Parent is TdhMenu then
 begin
  P:=TdhMenu(Parent);
  result:=true;
 end else
  result:=false;
end;

procedure TdhLink.UpdateMenuItemDesign;
var P:TdhMenu;
    BestUse:TdhCustomPanel;
begin
 if not (csLoading in ComponentState) and not (csDestroying in ComponentState) then
 if HasParentMenu(P) and P.FindSuitable(nil,SuitableKind,GetLev,BestUse,self) then
  Use:=BestUse;
end;


function TdhLink.GetNextPage(CurrPage:TdhPage):TdhPage;
var z,v:integer;
begin
  if FPageRange<0 then
   z:=-1 else
   z:=1;
  v:=CurrPage.PageIndex;
  if (v*z>=RealLinkPage.PageIndex*z) and (v*z<RealLastPage.PageIndex*z) then
   result:=FLinkPage.PageControl.Pages[v+z] else
   result:=RealLinkPage;
end;


procedure TdhDynLabel.Click;
begin
 if DelegateClick then exit;
 Inherited;
 DoClickAction(Self);
end;

procedure TdhLink.DoClickAction(Initiator:TdhCustomPanel);
var apage:TWinControl;
    p:TControl;
    histPage:TdhPage;
    histAnchor:TControl;
begin

 if (FFormButtonType<>fbNone) and not ((FFormButtonType=fbSubmit) and (FLinkPage<>nil)) then
 begin
  p:=Initiator;
  while (p<>nil) do
  begin
   if p is TdhHTMLForm then
   begin
    if FFormButtonType=fbSubmit then
     TdhHTMLForm(p).Submit(self) else
     TdhHTMLForm(p).Reset;
    break;
   end;
   p:=p.Parent;
  end;
 end;

 histPage:=nil;
 histAnchor:=nil;

 if not DownIfDown or not RuntimeMode then
 begin
  glUpdateOver(Self,true,true);
 end;

 if FLink<>'' then
 begin
  if FTarget='_blank' then
   Browse(FLink,'iexplore',false) else
   Browse(FLink,'',false);
 end else
 if (FLinkPage<>nil) and (FLinkPage.PageControl is TdhPageControl) then
 begin
  if GetLastPage<>nil then
  begin
   histPage:=GetNextPage(FLinkPage.PageControl.ActivePage);
  end else
  begin
   histPage:=FLinkPage;
  end;
 end;

 if (FLinkPage<>nil) and (GetTopForm(Self)<>LinkBase) then
 with GetTopForm(FLinkPage) do
 begin
   Show;
   BringToFront;
 end;
 if FLinkAnchor<>nil then
 begin
  histAnchor:=FLinkAnchor;
 end;

 if (histPage<>nil) and (GetTopForm(Self)<>LinkBase) then
 with GetTopForm(histPage) do
 begin
   Show;
   BringToFront;
 end;

 if ((histAnchor<>nil) or (histPage<>nil)) and Assigned(glOnHistory) then
  glOnHistory(Self);
 NavigateLocation(histPage,histAnchor,Self);
 if ((histPage<>nil)) and Assigned(glOnAfterNavigate) then
  glOnAfterNavigate(histPage);

end;


class procedure TdhLink.NavigateLocation(Page:TdhPage; Anchor:TControl; ActivatedBy:TdhLink);
var apage:TWinControl;
begin
 if (Page<>nil) and (Page.PageControl is TdhPageControl) then
 begin
  apage:=Page;
  while (apage is TdhPage) and (TdhPage(apage).PageControl<>nil) do
  begin
   TdhPage(apage).Activate(ActivatedBy);
   apage:=GetParentPage(apage);
  end;
 end;
 if Anchor<>nil then
 begin
  dhMenu.ScrollInView(Anchor.Parent,Anchor,true);
 end;
end;

procedure ScrollInView(p,cc:TControl; ForceTop:boolean);
var R:TRect;
begin
  if p=nil then exit;
  R:=GetCBound(p);
  if not IntersectRect(R,R,GetCBound(cc)) or ForceTop and (p is TdhCustomPanel) then
  if p is TdhCustomPanel then
   TdhCustomPanel(p).ScrollInView(cc,ForceTop) else
  if p is TScrollingWinControl then
   TScrollingWinControl(p).ScrollInView(cc);
  ScrollInView(p.Parent,cc,ForceTop);
end;

function TdhLink.SubmenuOpen:boolean;
begin
 result:=(FSubMenu<>nil) and FSubMenu.Visible;
end;

function TdhLink.SuitableKind:TDesignedFor;
begin
 if FSubMenu<>nil then
  result:=dfMenuItemWithMenu else
 if FHTMLText='' then
  result:=dfSeparatorBar else
  result:=dfMenuItem;
end;

procedure TdhLink.TryBrokenReferences(sl:TStringList);
var AComponent:TComponent;
begin
 Inherited;
 if (SLinkPage<>'') then
 if sl<>nil then
  sl.Add(SLinkPage) else
 begin
  AComponent:=Owner.FindComponent(SLinkPage);
  if AComponent is TdhPage then
   LinkPage:=TdhPage(AComponent);
 end;
 if (SLinkAnchor<>'') then
 if sl<>nil then
  sl.Add(SLinkAnchor) else
 begin
  AComponent:=Owner.FindComponent(SLinkAnchor);
  if AComponent is TdhCustomPanel then
   LinkAnchor:=TdhCustomPanel(AComponent);
 end;
end;

procedure TdhLink.Loaded;
begin
 inherited;
 CheckDesignState;
end;

procedure TdhMenu.OpenMenu;
var i:integer;
begin
   ToOpen:=nil;
   if Visible then exit;
   TailSubMenu:=Self;
   CancelCheckDesignState:=true;
   Visible:=true;
   AdjustSize;
   if (moSlide in ComputedMenu.FMenuOptions) and RuntimeMode then
   begin
    OriWidthHeight:=Point(Width,Height);
    OriAutoSizeXY:=AutoSizeXY;
    AutoSizeXY:=asar[ASXY in [asX,asXY],false];
    SetIsSliding(true,self);
    DisableAlign;
    try
     Height:=0;
     {!! for i:=0 to ControlCount-1 do
      TFakeControl(Controls[i]).UpdateBoundsRect(Controls[i].BoundsRect);  }
    finally
     EnableAlign;
    end;
    SetTimer(SlideNotify,10,SlideTimer);
   end;
   FParentMenuItem.CheckDesignState;
   CancelCheckDesignState:=false;
end;

function TdhMenu.LeaveY:boolean;
begin
 result:=(IsSliding and (Self=TailSubMenu));
end;


function TdhLink.IsClickToOpen:boolean;
begin
 result:=RuntimeMode and (FSubMenu<>nil) and (moClickToOpen in FSubMenu.ComputedMenu.MenuOptions){HasParentMenu(pn) and (moClickToOpen in pn.MenuOptions)};
end;

function TdhLink.ResumeOpen:boolean;
begin
 result:=RuntimeMode and (FSubMenu<>nil) and (moResumeOpen in FSubMenu.ComputedMenu.MenuOptions){HasParentMenu(pn) and (moResumeOpen in pn.MenuOptions)};
end;

procedure UpdateOver(Self:TControl; IsOver:boolean; Clicked:boolean);
var _glSelCompo:TControl;
var pn:TdhMenu;

procedure CheckSiblings;
var i:integer;
begin
 if Self.Parent is TdhCustomPanel then
 with TdhCustomPanel(Self.Parent) do
 for i:=0 to ControlCount-1 do
 if Controls[i] is TdhLink then
  TdhLink(Controls[i]).CheckDesignState;
end;

begin
  assert(Self<>nil);
  _glSelCompo:=glSelCompo;
  glSelCompo:=nil;
  if IsOver then
   glSelCompo:=Self;
  if (Self is TdhLink) and TdhLink(Self).IsClickToOpen then
  begin
   if TdhLink(Self).SubmenuOpen then
   begin
    if clicked then
    begin
     if not TdhLink(Self).DownIfDown then  
      ToOpen:=TdhLink(Self).FSubMenu;
     glCheckClose(TdhLink(Self));
    end;
   end else
   if clicked or IsOver and TdhLink(Self).ResumeOpen and TdhLink(Self).HasParentMenu(pn) and pn.HasOpenedMenu then
   begin
    ToOpen:=TdhLink(Self).FSubMenu;
    glCheckClose;
   end;
  end else
  begin
   if IsOver and (Self is TdhLink) then
     ToOpen:=TdhLink(Self).FSubMenu;
   if clicked then
   begin
    glCheckClose;
   end else
   if IsOver and (glSelCompo is TdhLink) and (TdhLink(glSelCompo).FSubMenu<>nil) {and not IsSliding }and TdhLink(glSelCompo).DownIfDown then
   if TdhLink(Self).ResumeOpen and TdhLink(Self).HasParentMenu(pn) and pn.HasOpenedMenu then
   begin
    glCheckClose;
   end else
   begin
    LinkTimer.Enabled:=false;
    SetTimer(TdhLink(glSelCompo).TimerNotify,TdhLink(glSelCompo).FSubMenu.ComputedMenu.FReactionTime,LinkTimer);
   end;
  end;
  CheckSiblings;
  if (_glSelCompo is TdhCustomPanel) then
   TdhCustomPanel(_glSelCompo).CheckDesignState;
  if (Self is TdhCustomPanel) then
   TdhCustomPanel(Self).CheckDesignState;

  if not (glSelCompo is TdhCustomPanel) then
   glSelCompo:=nil;//since only TdhCustomPanel.Destroy would reset it
end;

procedure TdhLink.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  inherited;
  if FSubMenu<>nil then Proc(FSubMenu);
end;

procedure TdhLink.SetLink(Value:TPathName);
begin
 if Value<>'' then
 begin
  ClearAnchors(true);
 end;
 FLink:=Value;
 LinkDestinationChanged;
end;

procedure TdhLink.LinkDestinationChanged;
begin
 NotifyCSSChanged([wcNoOwnCSS]); //only if a link is defined, text is blue and underlined
end;

procedure TdhLink.SetFormButtonType(Value:TFormButtonType);
begin
 FFormButtonType:=Value;
 LinkDestinationChanged;
end;

procedure TdhLink.SetLinkPage(Value:TdhPage);
begin
 SLinkPage:='';
 if FLinkPage=Value then exit;
 if Value<>nil then
  ClearAnchors(false);
 if FLinkPage<>nil then FLinkPage.RemoveDownIfURL(Self);
 FLinkPage:=Value;
 if (FLinkAnchor<>nil) and (LinkBase<>GetTopForm(FLinkAnchor)) then
  LinkAnchor:=nil;
 if FLinkPage<>nil then FLinkPage.AddDownIfURL(Self);
 LinkDestinationChanged;
end;


function TdhLink.LinkBase:TWinControl;
begin
 if FLinkPage=nil then
  result:=GetTopForm(Self) else
  result:=GetTopForm(FLinkPage);
end;
               
function TdhLink.AllHTMLCode:HypeString;
begin
 result:=inherited AllHTMLCode + FLink;
end;

procedure TdhLink.SetLinkAnchor(Value:TdhCustomPanel);
begin
 SLinkAnchor:='';
 if FLinkAnchor=Value then exit;
 if (Value<>nil) and not (csLoading in ComponentState) and (GetTopForm(Value)<>LinkBase) then
 begin
  showmessage(NameWithForm(Self)+ ': The LinkAnchor component must belong to form '+LinkBase.Name);
  exit;
 end;
 if Value<>nil then
 begin
  FLink:='';
  LinkAnchor:=nil;
 end;
 if FLinkAnchor<>nil then FLinkAnchor.RemoveFreeNotification(Self);
 FLinkAnchor:=Value;
 if FLinkAnchor<>nil then FLinkAnchor.FreeNotification(Self);
 LinkDestinationChanged;
end;

procedure TdhLink.ClearAnchors(LinkAnchorToo:boolean);
begin
 FLink:='';
 LinkPage:=nil;
 if LinkAnchorToo then
  LinkAnchor:=nil;
end;

function TdhLink.IsAnchor:boolean;
begin
 result:=(FLink<>'') or (FLinkAnchor<>nil) or (FLinkPage<>nil) or (FFormButtonType<>fbNone);
end;


function TdhDynLabel.IsAnchor:boolean;
begin
 result:=false;
end;

function TdhDynLabel.ShallBeAnchor:boolean;
begin
 result:=not IsDlg;
end;

procedure TdhLink.SetDown(Value:boolean);
begin
 if FDown<>Value then
 begin
  FDown:=Value;
  CheckDesignState;
 end;
end;

procedure TdhLink.SetOptions(Value:TAnchorOptions);
begin
 if FOptions<>Value then
 begin
  FOptions:=Value;
  NotifyCSSChanged([wcState]);
 end;
end;

procedure TdhLink.SetTarget(Value:TPathName);
begin
 FTarget:=Value;
end;

constructor TdhDynLabel.Create(AOwner: TComponent);
begin
 inherited;
 StyleArr[hsOver]:=TStyle.Create(Self,hsOver);
 StyleArr[hsDown]:=TStyle.Create(Self,hsDown);
 StyleArr[hsOverDown]:=TStyle.Create(Self,hsOverDown);
 AutoSizeXY:=asXY;      
 FPreferDownStyles:=DefaultPreferDownStyles;
end;

constructor TdhLink.Create(AOwner: TComponent);
begin
 inherited;
 FOptions:=[loDownIfMenu,loDownIfURL,loDownIfMouseDown];
end;

procedure TdhLink.Notification(AComponent: TComponent; Operation: TOperation);
begin
 if Operation = opRemove then
 begin
  if not FastDestroy then
  if LinkAnchor=AComponent then
  begin
   CancelInvDesigner:=true;
   LinkAnchor:=nil;
   SLinkAnchor:=AComponent.Name;
   CancelInvDesigner:=false;
  end else
  if LinkPage=AComponent then
  begin
   CancelInvDesigner:=true;
   LinkPage:=nil;
   SLinkPage:=AComponent.Name;
   CancelInvDesigner:=false;
  end;
 end;
end;

procedure TdhLink.TimerNotify(Sender: TObject);
begin
 glCheckClose;
end;


destructor TdhLink.Destroy;
begin
 if not FastDestroy then
 begin
  FSubMenu.Free;
  LinkAnchor:=nil;
  LinkPage:=nil;
 end;
 Inherited;
end;

function TdhDynLabel.IsButton:boolean;
begin
 result:=ComputedLayout=ltButton;
end;


function TdhDynLabel.CenterVertical:boolean;
begin
 result:=IsButton;
end;

function TdhLink.GetDefaultLayout:TLinkType;
begin
 result:=ltLink;
end;

procedure TdhLink.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Inherited;
 if not IsAnchor and not (loDownIfMouseDown in ComputedOptions) then
  MouseCapture:=False;
end;

function TdhLink.GetChildParent: TComponent;
begin
 result:=Self;;
 if FSubMenu<>nil then
 if FSubMenu.IsInlineMenu then
  Result:=Parent else
  Result := GetParentPage(Self);
end;                

function AddPoint(const a:TPoint; const b:TPoint):TPoint;
begin
 result.X:=a.X+b.X;
 result.Y:=a.Y+b.Y;
end;


function DecPoint(const a:TPoint; const b:TPoint):TPoint;
begin
 result.X:=a.X-b.X;
 result.Y:=a.Y-b.Y;
end;


function TdhMenu.MenuPos:TPoint;
begin
 if DisableMenuPos then
  Result:=Point(0,0) else
  Result:=Point(FMenuLeft,FMenuTop);
end;

function TdhMenu.ComputedMenuPos:TPoint;
begin
 if RelMenuPosIsNoExtraMenuStyle then
  Result:=MenuPos else
  Result:=ComputedMenu.MenuPos;
end;


function TdhMenu.GetTotalPos:TPoint;
var p:TWinControl;
    pn:TdhCustomPanel;
begin
 assert(IsVirtual);

 Result:=AddPoint(GetRelativePos,ComputedMenuPos);
 p:=VirtualParent.Parent;
 while p<>nil do
 begin
  if (p is TdhCustomPanel) and TdhCustomPanel(p).IsAbsolutePositioned then
  begin
   pn:=TdhCustomPanel(p);
   if pn.IsRastered(false)=rsNo then
    Result:=AddPoint(Result,pn.BorderPure.TopLeft);
  end;
  p:=p.Parent;
 end;

 p:=VirtualParent as TWinControl;
 if (p is TdhCustomPanel) then
 begin
  pn:=TdhCustomPanel(p);
  if pn.IsRastered(false)=rsNo then
   Result:=DecPoint(Result,pn.MarginPure.TopLeft);
 end;

end;



procedure TdhMenu.WriteRealMenuLeft(Writer: TWriter);
begin
 Writer.WriteInteger(GetTotalPos.X);
end;

procedure TdhMenu.WriteRealMenuTop(Writer: TWriter);
begin
 Writer.WriteInteger(GetTotalPos.Y);
end;

procedure TdhMenu.WriteMenuTop(Writer: TWriter);
begin
 Writer.WriteInteger(FMenuTop);
end;


procedure TdhMenu.WriteMenuLeft(Writer: TWriter);
begin
 Writer.WriteInteger(FMenuLeft);
end;

procedure TdhMenu.WritePadw(Writer: TWriter);
begin
 with GetAddRect(PaddingPure,BorderPure) do
  Writer.WriteInteger(Left+Right);
end;

procedure TdhMenu.WriteAlPos(Writer: TWriter);
begin
 Writer.WriteInteger(FParentMenuItem.Top+1);
end;

procedure TdhMenu.WriteOnlyIf(Writer: TWriter);
begin
 Writer.WriteString(FinalID(FParentMenuItem.FLinkPage));
end;

procedure TdhMenu.ReadMenuLeft(Reader: TReader);
begin
 FMenuLeft:=Reader.ReadInteger;
end;

procedure TdhMenu.ReadMenuTop(Reader: TReader);
begin
 FMenuTop:=Reader.ReadInteger;
end;

function TdhMenu.IsVirtual:boolean;
begin
 result:=FParentMenuItem<>nil;
end;


procedure TdhMenu.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('MenuLeft', ReadMenuLeft, WriteMenuLeft, FMenuLeft<>0);
  Filer.DefineProperty('MenuTop', ReadMenuTop, WriteMenuTop, FMenuTop<>0);
  if not WithMeta and (Filer is TWriter) then exit;
  Filer.DefineProperty('RealMenuLeft', SkipValue, WriteRealMenuLeft, not IsInlineMenu and IsVirtual);
  Filer.DefineProperty('RealMenuTop', SkipValue, WriteRealMenuTop, not IsInlineMenu and IsVirtual);
  Filer.DefineProperty('OnlyIf', SkipValue, WriteOnlyIf, {(moStatic in ComputedMenu.FMenuOptions) and }IsInlineMenu and (FParentMenuItem<>nil) and (FParentMenuItem.LinkPage<>nil) and not FParentMenuItem.LinkPage.DynamicNavigation);
  Filer.DefineProperty('padw', SkipValue, WritePadw, moSlide in ComputedMenu.FMenuOptions);
  Filer.DefineProperty('AlPos', SkipValue, WriteAlPos, (FParentMenuItem<>nil) and IsInlineMenu and (Align=alTop));
end;

constructor TdhMenu.Create(AOwner: TComponent);
begin
 Inherited;
 Visible:=false;
 FSlidePixel:=1;
 FReactionTime:=400;
 AutoSizeXY:=asXY;
 ControlStyle:=ControlStyle+[csNoDesignVisible,csAcceptsControls];
end;

function TdhMenu.AddMenuItem:TdhLink;
var _NewControlsAlign:TAlign;
begin;
 _NewControlsAlign:=NewControlsAlign;
 if Assigned(glPreAddCompo) then
  glPreAddCompo(Self);
 result:=TdhLink.Create(Owner);
 _SetUniqueName(result,AnchorNameBase);
 if VerticalLayout then
 begin
  result.Top:=Height;
 end else
 begin
  result.Left:=Width;
 end;
 result.Parent:=Self;
 result.Align:=_NewControlsAlign;
 result.UpdateMenuItemDesign;
 if Assigned(glPostAddCompo) then
  glPostAddCompo(result);
end;

function TdhMenu.GetMenuPosBrothers(NeedOnlyOne:boolean=false; without:TdhMenu=nil):TList;
var StyleMenu,UsedByMenu:TdhMenu;
    UsedBy:TdhCustomPanel;
    i:integer;
begin
 Result:=TList.Create;
 if (Use<>nil) and (Use.GetCommon is TdhMenu) then
 begin
  StyleMenu:=TdhMenu(Use.GetCommon);
  for i:=0 to StyleMenu.UsedByList.Count-1 do
  begin
   UsedBy:=TdhCustomPanel(StyleMenu.UsedByList[i]);
   if UsedBy is TdhMenu then
   begin
    UsedByMenu:=TdhMenu(UsedBy);
    if (UsedByMenu<>without) and (ParentMenuItem<>nil) and (UsedByMenu.ParentMenuItem<>nil) and (ParentMenuItem.GetVerticalLayout=UsedByMenu.ParentMenuItem.GetVerticalLayout) then
    begin
     Result.Add(UsedByMenu);
     if NeedOnlyOne then Exit;
    end;
   end;
  end;
 end;
end;

function TdhMenu.GetMenuPosBrother(without:TdhMenu):TdhMenu;
var Results:TList;
begin
 Results:=GetMenuPosBrothers(true,without);
 if Results.Count>=1 then
  Result:=TdhMenu(Results[0]) else
  Result:=nil;
 Results.Free;
end;

procedure TdhMenu.SetMenuPos(Left,Top:integer);
var MenuPosBrother:TdhMenu;
    MenuPosBrothers:TList;
    i:integer;
begin
 if (FMenuLeft<>Left) or (FMenuTop<>Top) then
 begin
  FMenuLeft:=Left;
  FMenuTop:=Top;
  if not RelMenuPosIsNoExtraMenuStyle then
  begin
   NotifyCSSChanged([wcState]);
  end;
  MenuPosBrother:=GetMenuPosBrother(nil);
  if MenuPosBrother=Self then
  begin
   MenuPosBrothers:=GetMenuPosBrothers;
   for i:=0 to MenuPosBrothers.Count-1 do
   begin
    MenuPosBrother:=TdhMenu(MenuPosBrothers[i]);
    MenuPosBrother.SetMenuPos(Left,Top);
   end;
  end else
  if MenuPosBrother<>nil then
  begin
   MenuPosBrother.SetMenuPos(Left,Top);
  end;
 end;
end;

procedure TdhMenu.UpdateMenuPos;
var MenuPosBrother:TdhMenu;
begin
   MenuPosBrother:=GetMenuPosBrother(Self);
   if MenuPosBrother<>nil then
   begin
    SetMenuPos(MenuPosBrother.MenuLeft,MenuPosBrother.MenuTop);
   end;
end;

procedure TdhMenu.SetSlidePixel(Value:TSlidePixel);
begin
 if FSlidePixel<>Value then
 begin
  FSlidePixel:=Value;
 end;
end;


procedure TdhMenu.SetMenuLeft(Value:integer);
begin
 SetMenuPos(Value,FMenuTop);
end;

procedure TdhMenu.SetMenuTop(Value:integer);
begin
 SetMenuPos(FMenuLeft,Value);
end;

function TdhMenu.GetRelativePos:TPoint;
begin
  with GetAddRect(BorderPure,PaddingPure) do
  if FParentMenuItem.GetVerticalLayout{ and not IsInlineMenu} then
  begin
   result:=Point(FParentMenuItem.Width,0);
   dec(result.X,Left);
   dec(result.Y,Top);
  end else
  begin
   result:=Point(0,FParentMenuItem.Height);       
   dec(result.X,Left);
   dec(result.Y,Top);
  end;
end;

function TdhMenu.IsMainMenu:boolean;
begin
 result:=FParentMenuItem=nil;
end;


function TdhMenu.GetMenuCoordsOrigin:TPoint;
begin
 result:=Point(0,0);
 if IsMainMenu then exit;
 if Parent=nil then exit;
 result:=Parent.ScreenToClient(FParentMenuItem.ClientToScreen(GetRelativePos));
end;

procedure TdhMenu.UpdateMenuCoords;
var p1:TPoint;
begin
 if not FinalShowing or IsInlineMenu or IsMainMenu then exit;
 p1:=AddPoint(GetMenuCoordsOrigin,ComputedMenuPos);
 if not CancelSetMenuPos then
 begin
  CancelSetMenuPos:=true;
  try
   SetBounds(p1.X,p1.Y,Width,Height);
  finally
   CancelSetMenuPos:=false;
  end;
 end;
end;


procedure TdhMenu.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var p1:TPoint;
    R:TRect;
    i:integer;
    CancelSetBounds:boolean;
begin
 if csDestroying in ComponentState then exit; // possible during glCheckClose
 R:=BoundsRect;
 Inherited;
 CancelSetBounds:=(FParentMenuItem<>nil) and (Parent<>FParentMenuItem.GetChildParent);
 if not CancelSetMenuPos and Visible and (FParentMenuItem<>nil) and not CancelSetBounds and not ((R.Left=Left) and (R.Top=Top)) and not IsInlineMenu then
 begin
  p1:=GetMenuCoordsOrigin;
  SetMenuPos(Left-p1.X,Top-p1.Y);
 end;
 if Visible and not EqualRect(R,BoundsRect) then
 begin
  for i:=0 to ControlCount-1 do
   if Controls[i] is TdhLink then
    TdhLink(Controls[i]).UpdateSubMenuCoords;
 end;
end;

procedure TdhMenu.VisibleChanged;
var P:TdhMenu;
begin
 inherited;
 try
  if FParentMenuItem=nil then exit;
  if not Visible then
  begin
   glCheckClose(FParentMenuItem);
   exit;
  end;
  ToOpen:=Self;
  glCheckClose;
  ToOpen:=nil;
  if FParentMenuItem.HasParentMenu(P) then
   P.Visible:=true;
  TailSubMenu:=Self;
  UpdateMenuCoords;
 finally
  inherited;
 end;
end;


procedure TdhMenu.SetParent({$IFDEF CLX}const {$ENDIF}AParent: TWinControl);
begin
  if ParentMenuItem<>nil then
   inherited SetParent(FParentMenuItem.GetChildParent as TWinControl) else
  if AParent is TdhLink then
   ParentMenuItem:=TdhLink(AParent) else
   Inherited;
  if not (csDestroying in ComponentState) then
  begin
   if ParentMenuItem=nil then
    Visible:=true;
   UpdateMenuCoords;
  end;
end;

procedure TdhMenu.SetParentMenuItem(Value:TdhLink);
var OldVisible:boolean;
begin
 if (Value<>nil) and IsVirtualParentOf(Value) then
 begin
  raise WException.Create(WFormat(INVALIDMENUNESTING_STR,[Name,Value.Name]));
 end;
 if FParentMenuItem<>Value then
 begin
  OldVisible:=Visible;
  Visible:=false;
  if FParentMenuItem<>nil then
  begin
   FParentMenuItem.FSubMenu:=nil;
   if not (csDestroying in FParentMenuItem.ComponentState) then
    glCheckClose(FParentMenuItem);
  end;
  FParentMenuItem:=Value;
  if FParentMenuItem<>nil then
  begin
   if FParentMenuItem.FSubMenu<>nil then
    FParentMenuItem.FSubMenu.ParentMenuItem:=nil;
   FParentMenuItem.FSubMenu:=Self;
   Visible:=OldVisible;
   UpdateParent;
  end else
   Visible:=OldVisible;
 end;
end;

function TdhMenu.HasOpenedMenu:boolean;
var i:integer;
begin
 for i:=0 to ControlCount-1 do
 if (Controls[i] is TdhLink) and TdhLink(Controls[i]).SubmenuOpen then
 begin
  result:=true;
  exit;
 end;
 result:=false;
end;

function TdhMenu.GetIsInlineMenu:boolean;
begin
 result:=moInline in ComputedMenu.FMenuOptions;
end;

function TdhMenu.NewControlsAlign:TAlign;
begin
 if VerticalLayout then
  Result:=alTop else
  Result:=alLeft;
end;

procedure TdhMenu.UpdateInlineMenu;
begin
 if FParentMenuItem<>nil then
 begin
  if moInline in ComputedMenu.FMenuOptions then
   Align:=FParentMenuItem.Align else
   Align:=alNone;
  UpdateParent;
 end;
end;

procedure TdhMenu.UpdateParent;
begin
 if FParentMenuItem<>nil then
  Parent:=FParentMenuItem.GetChildParent as TWinControl;
end;


type TFakeApplication=class(TApplication);

procedure TdhMenu.SlideNotify(Sender: TObject);
{$IFNDEF CLX}
var Msg: TMsg;
{$ENDIF}
begin
 Height:=Math.min(Height+ComputedMenu.FSlidePixel,OriWidthHeight.Y);
 if Height=OriWidthHeight.Y then
 begin
  RestoreSlide();
  if ToOpen<>nil then
   glCheckClose;
 end;
{$IFNDEF CLX}
 TFakeApplication(Application).Idle(Msg); //to receive mouse-over messages while sliding
{$ENDIF}
end;

procedure TdhMenu.SlideUpNotify(Sender: TObject);
begin
 Height:=max(Height-ComputedMenu.FSlidePixel,0);
 if Height=0 then
 begin
  SlideTimer.Enabled:=False;
  glCheckClose;
 end;
end;

procedure TdhMenu.GetMenuThings;
var i:integer;
begin
 ls.Add(Self);
 for i:=0 to ControlCount-1 do
 if Controls[i] is TdhLink then
 begin
  ls.Add(Controls[i]);
  if TdhLink(Controls[i]).FSubMenu<>nil then
  if AllNested then
   TdhLink(Controls[i]).FSubMenu.GetMenuThings(ls) else
   ls.Add(TdhLink(Controls[i]).FSubMenu);
 end else
 if (Controls[i] is TdhMenu) then
 if AllNested then
  TdhMenu(Controls[i]).GetMenuThings(ls) else
  ls.Add(Controls[i]);
end;


function GetTopStyleMenu(c:TControl):TdhMenu;
begin
 while (c<>nil) and not (c.Parent is TdhStyleSheet) do
  c:=GetVirtualParent(c);
 if c is TdhMenu then
  result:=TdhMenu(c) else
  result:=nil;
end;

function NoWithSubMenus(SuitableKind:TDesignedFor):TDesignedFor;
begin
 if SuitableKind=dfMenuItemWithMenu then
  result:=dfMenuItem else
  result:=SuitableKind;
end;


function TdhMenu.FindSuitable(MenuStyles:TList; SuitableKind:TDesignedFor; Lev:Integer; var BestUse:TdhCustomPanel; ForWhich:TControl):boolean;
var i:integer;
    pn:TdhCustomPanel;
    P:TdhMenu;
    SelfCreated:boolean;
    NewTopMenu:TdhMenu;
    DesignedFor,BestUseDesignedFor:TDesignedFor;

function bet(pnDesignedForLevel,bDesignedForLevel:integer):boolean;
begin
  result:=(bDesignedForLevel>pnDesignedForLevel) and (pnDesignedForLevel>=Lev) or
          (bDesignedForLevel<pnDesignedForLevel) and (Lev>=pnDesignedForLevel);
end;

begin
 result:=false;
 if csDestroying in ComponentState then exit;
 BestUse:=nil;
 BestUseDesignedFor:=dfAnything; //to prevent a warning
 SelfCreated:=false;
 if (MenuStyles=nil) and (Use<>nil) then
 begin

  NewTopMenu:=GetTopStyleMenu(Use.GetCommon);
  if NewTopMenu<>nil then
  begin
   SelfCreated:=true;
   MenuStyles:=TList.Create;
   NewTopMenu.GetMenuThings(MenuStyles,true);
  end;
 end;

 if MenuStyles<>nil then
 for i:=MenuStyles.Count-1 downto 0 do
 if (TObject(MenuStyles[i]) is TdhCustomPanel) and (ForWhich<>MenuStyles[i]) then
 begin
  pn:=TdhCustomPanel(MenuStyles[i]);
  DesignedFor:=pn.SuitableKind;
  if (NoWithSubMenus(DesignedFor)=NoWithSubMenus(SuitableKind)) and ((BestUse=nil) or (BestUseDesignedFor<>SuitableKind) and not bet(BestUse.GetLev,pn.GetLev) or bet(pn.GetLev,BestUse.GetLev)) or
     (DesignedFor=dfMenuItem) and (SuitableKind in [dfMenuItemWithMenu,dfSeparatorBar]) and ((BestUse=nil) or bet(pn.GetLev,BestUse.GetLev)) then
  begin
   BestUse:=pn;
   BestUseDesignedFor:=DesignedFor;
  end;
 end;

 result:=(BestUse<>nil) or (FParentMenuItem<>nil) and FParentMenuItem.HasParentMenu(P) and P.FindSuitable(nil,SuitableKind,Lev,BestUse,ForWhich);
 if SelfCreated then
  MenuStyles.Free;
end;


function TdhMenu.SuitableKind:TDesignedFor;
begin
 result:=dfMenu;
end;

procedure TdhMenu.NotifyUseChanged(OldValue:ICon);
var ls:TList;
    i,lev:integer;
    pn:TdhCustomPanel;
    BestUse:TdhCustomPanel;
    OldTopMenu,NewTopMenu:TdhMenu;
begin
 if (Use<>nil) and (Use<>OldValue) and (GetTopStyleMenu(Use.GetCommon)<>nil) and not (csLoading in ComponentState) then
 begin
  OldTopMenu:=nil;
  if (OldValue<>nil) and (OldValue.GetCommon is TdhMenu) then
   OldTopMenu:=GetTopStyleMenu(OldValue.GetCommon);
  NewTopMenu:=GetTopStyleMenu(Use.GetCommon);
  ls:=TList.Create;
  GetMenuThings(ls);
  for i:=1 to ls.Count-1 do
  if (TControl(ls[i]) is TdhCustomPanel) then
  begin
   pn:=TdhCustomPanel(ls[i]);
   if ((pn.Use=nil) or (GetTopStyleMenu(pn.Use.GetCommon)=OldTopMenu)) and FindSuitable(nil,pn.SuitableKind,pn.GetLev,BestUse,pn) then
    pn.Use:=BestUse;
  end;
  ls.Free;
  UpdateMenuPos;
 end;
end;

procedure TdhMenu.SetMenuOptions(Value:TMenuOptions);
begin
 if FMenuOptions<>Value then
 begin
  FMenuOptions:=Value;
  NotifyCSSChanged([wcState]);
 end;
end;

function TdhMenu.GetVerticalLayout:boolean;
var i:integer;
begin
 if NoExtraVerticalMenuStyle then
 begin
  if ControlCount=0 then
  begin
   if self.UsePn is TdhMenu then
   begin
    Result:=TdhMenu(self.UsePn).GetVerticalLayout;
    exit;
   end;
  end;
  for i:=0 to ControlCount-1 do
  begin
   if (Controls[i] is TdhLink) and (TdhLink(Controls[i]).Align=alLeft) then
   begin
    result:=false;
    exit;
   end;
  end;
  result:=true;
 end else
 begin
  result:=not(moHorizontalLayout in ComputedMenu.FMenuOptions);
 end;
end;

function TdhLink.GetVerticalLayout:boolean;
var pn:TdhMenu;
begin
 if NoExtraVerticalMenuStyle then
 begin
  result:=Align<>alLeft;
 end else
 begin
  result:=HasParentMenu(pn) and pn.VerticalLayout;
 end;
end;

procedure TdhMenu.UpdateVerticalLayout;
var i:integer;
begin
 if NoExtraVerticalMenuStyle then exit;
 if (csLoading in ComponentState) or not (FAutoSize=asXY) then exit;
 DisableAlign;
 try
  for i:=0 to ControlCount-1 do
  if (Controls[i] is TdhCustomPanel) and (Controls[i].Align in [alLeft,alTop]) then
  with Controls[i] do
  if ((Align=alTop)<>VerticalLayout) then
  begin
   if VerticalLayout then
   begin
    Top:=Left;
    Align:=alTop;
   end else
   begin
    Left:=Top;
    Align:=alLeft;
   end;
  end;
 finally
  EnableAlign;
 end;
end;

destructor TdhMenu.Destroy;
begin                         
 ToOpen:=nil; //set always to nil
 if not FastDestroy then
  ParentMenuItem:=nil;                
 if TailSubMenu=Self then TailSubMenu:=nil;
 Inherited;
end;

procedure TdhMenu.WriteState(Writer: TWriter);
begin
 if FParentMenuItem<>nil then
 if not (csWriting in FParentMenuItem.ComponentState) then
 begin
 if (csWriting in Owner.ComponentState){normal saven, nicht ins Clipboard kopieren} or not Visible{ins ClipBoard nur wenn visible} then
 begin
  if not (csWriting in Owner.ComponentState) and not (csWriting in Parent.ComponentState) then
  begin
   writer.Position:=writer.Position-4{=length(Classes.FilerSignature)};
//   showmessage('EXIT:'+owner.name+'.'+name+': '+booltostr((FParentMenuItem<>nil) and not(csWriting in FParentMenuItem.ComponentState) and not IsInlineMenu,true)+' '+booltostr(csWriting in Owner.ComponentState,true)+' '+booltostr(not Visible,true));
  end;
  exit;
 end;
 end;
 Inherited;
end;


function TdhLink.DownIfDown:boolean;
begin
 result:=true;//not((FSubMenu<>nil) and (moStatic in FSubMenu.ComputedMenu.MenuOptions));
end;


procedure TdhMenu.ControlsListChanged(Control: TControl; Inserting: Boolean);
begin
  inherited;
  if not (csReading in ComponentState) then
    if not Inserting and (ControlCount=1) and (FParentMenuItem<>nil) and {AutoSize}(FAutoSize=asXY) then
     Release;
end;

function TdhMenu.VirtualParent:TControl;
begin
 if FParentMenuItem<>nil then
  result:=FParentMenuItem else
  result:=Parent;
end;


procedure TdhMenu.PrepareAlign;
begin
    ControlStyle:=ControlStyle-[csAcceptsControls];
    if not (Visible and (ParentMenuItem<>nil) and (ParentMenuItem.Align=Align) and IsInlineMenu and (Align in [alLeft,alTop])) then exit;
    if Align=alTop then
     Top:=ParentMenuItem.Top+1;
    if Align=alLeft then
     Left:=ParentMenuItem.Left+1;
end;

procedure TdhMenu.AlignDone;
begin
    ControlStyle:=ControlStyle+[csAcceptsControls];
end;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhLink]);
  RegisterComponents('DFM2HTML', [TdhMenu]);
  RegisterClasses([TdhMenu]);
end;

procedure TdhDynLabel.SetLayout(const Value: TLinkType);
begin
 if FLayout<>Value then
 begin
  FLayout:=Value;
  NotifyCSSChanged(AllChanged);
 end;
end;


function TdhDynLabel.GetFinal: ICon;
begin
  result:=nil;
  if AssertTags2 then
  case ComputedLayout of
  ltButton: result:=dhStrEditDlg.button;
  ltLink:   result:=dhStrEditDlg.a;
  end;
end;


procedure TdhMenu.SetReactionTime(const Value: TReactionTime);
begin
 if FReactionTime<>Value then
 begin
  FReactionTime := Value;
 end;
end;

function TdhMenu.AdjustZIndex(ChildPos,ParentControlCount:integer):integer;
begin
 if IsVirtual and not IsInlineMenu then        
  result:=maxint-500-1*ParentControlCount+ChildPos+GetLev else
  result:=inherited AdjustZIndex(ChildPos,ParentControlCount);
end;

procedure TdhDynLabel.WriteComputedLayout(Writer: TWriter);
begin
 Writer.WriteIdent(GetEnumName(TypeInfo(TLinkType),Integer(ComputedLayout)));
end;

procedure WriteValue(Writer: TWriter; Value: TValueType);
begin        
  Writer.Write(Value, SizeOf(Value));
end;

procedure TdhDynLabel.ClearObjectStyles;
begin
  inherited;
  FLayout:=ltAuto;
  FPreferDownStyles:=DefaultPreferDownStyles;
end;

procedure TdhDynLabel.CopyObjectStylesFrom(src: TdhCustomPanel;
  sub: boolean; test: TdhCustomPanel);
begin
 inherited;
 if (src is TdhDynLabel) then
 begin
  if ((test as TdhDynLabel).FLayout<>ltAuto) xor sub then
   FLayout:=(src as TdhDynLabel).FLayout;
  FPreferDownStyles:=(src as TdhDynLabel).FPreferDownStyles;
 end;
end;

procedure TdhLink.ClearObjectStyles;
begin
  inherited;
  Auto:=true;
end;

procedure TdhLink.CopyObjectStylesFrom(src: TdhCustomPanel;
  sub: boolean; test: TdhCustomPanel);
begin
 inherited;
 if (src is TdhLink) then
 if (not TdhLink(test).Auto) xor sub then
  Options:=TdhLink(src).FOptions;
end;

procedure TdhMenu.ClearObjectStyles;
begin
  inherited;
  Auto:=true;
end;

procedure TdhMenu.CopyObjectStylesFrom(src: TdhCustomPanel;
  sub: boolean; test: TdhCustomPanel);
begin
 inherited;
 if (src is TdhMenu) then
 if (not TdhMenu(test).Auto) xor sub then
 begin
  MenuOptions:=TdhMenu(src).FMenuOptions;
  SetMenuPos(TdhMenu(src).FMenuLeft,TdhMenu(src).FMenuTop);
  SlidePixel:=TdhMenu(src).FSlidePixel;
  ReactionTime:=TdhMenu(src).FReactionTime;
 end;
end;

function TdhDynLabel.ComputedLayout:TLinkType;
var Con:ICon;
begin
 result:=FLayout;
 Con:=Self;
 while (result=ltAuto) and (Con.GetCommon.Use<>nil) do
 begin
  Con:=Con.GetCommon.Use;
  if Con.GetCommon is TdhDynLabel then
   result:=TdhDynLabel(Con.GetCommon).FLayout;
 end;
 if result=ltAuto then
 begin
  result:=GetDefaultLayout;
  if (result=ltLink) and not IsAnchor then
  begin
   result:=ltText;
  end;
 end;
end;


function TdhLink.ComputedOptions:TAnchorOptions;
var Con:ICon;
begin
 //result:=ComputedLink.FOptions;
 result:=FOptions;
 Con:=Self;
 while not (loNoAuto in result) and (Con.GetCommon.Use<>nil) do
 begin
  Con:=Con.GetCommon.Use;
  if Con.GetCommon is TdhLink then
   result:=TdhLink(Con.GetCommon).FOptions;
 end;
end;

function TdhMenu.ComputedMenu:TdhMenu;
var Con:ICon;
begin
 result:=Self;
 Con:=Self;
 while result.Auto and (Con.GetCommon.Use<>nil) do
 begin
  Con:=Con.GetCommon.Use;
  if Con.GetCommon is TdhMenu then
   result:=TdhMenu(Con.GetCommon);
 end;
end;

function TdhLink.ComputedLink:TdhLink;
var Con:ICon;
begin
 result:=Self;
 Con:=Self;
 while result.Auto and (Con.GetCommon.Use<>nil) do
 begin
  Con:=Con.GetCommon.Use;
  if Con.GetCommon is TdhLink then
   result:=TdhLink(Con.GetCommon);
 end;
end;



function TdhLink.GetAuto: boolean;
begin
 result:=not(loNoAuto in FOptions);
end;

procedure TdhLink.SetAuto(const Value: boolean);
begin
 if Value then
  Options:=FOptions-[loNoAuto] else
  Options:=FOptions+[loNoAuto];
end;

function TdhMenu.GetAuto: boolean;
begin
 result:=not(moNoAuto in FMenuOptions);
end;

procedure TdhMenu.SetAuto(const Value: boolean);
begin
 if Value then
  MenuOptions:=FMenuOptions-[moNoAuto] else
  MenuOptions:=FMenuOptions+[moNoAuto];
end;

procedure TdhMenu.DoCSSToWinControl(WhatChanged: TWhatChanged);
begin
 inherited;
 if wcState in WhatChanged then
 begin
  UpdateVerticalLayout;
  UpdateInlineMenu;
  UpdateMenuCoords;
 end;
end;

function TdhLink.AutoRelevant: boolean;
begin
 result:=ComputedLink<>Self;
end;

function TdhMenu.AutoRelevant: boolean;
begin
 result:=ComputedMenu<>Self;
end;

function TdhDynLabel.TotalInlineBox: boolean;
begin
 result:=IsButton;
end;

function TdhDynLabel.GetPreferDownStyles: boolean;
var Con:ICon;
begin
 result:=FPreferDownStyles;
 Con:=Self;
 while (Con.GetCommon.Use<>nil) do
 begin
  Con:=Con.GetCommon.Use;
  if Con.GetCommon is TdhDynLabel then
   result:=TdhDynLabel(Con.GetCommon).FPreferDownStyles;
 end;
end;

procedure TdhDynLabel.SetPreferDownStyles(const Value: boolean);
begin
 if FPreferDownStyles<>Value then
 begin
  FPreferDownStyles:=Value;
  NotifyCSSChanged(AllChanged);
 end;
end;
       
procedure PreferStyleChangeParentSiblings(caller:TdhCustomPanel; ClearPrefer:boolean);
var ii:integer;
var DownForURLAnchor:TdhLink;
    c:TControl;
begin
 for ii:=0 to caller.Parent.ControlCount-1 do
 begin
  c:=caller.Parent.Controls[ii];
  if (c is TdhLink) then
  begin
   DownForURLAnchor:=TdhLink(c);
   DownForURLAnchor.PreferStyleChangeMenuSibling(caller,ClearPrefer);
  end;
 end;
end;

procedure TdhLink.FocusPreferStyle(IsMain,RealChange: boolean);
var dummy:TPoint;
begin
  inherited;
  if IsMain then
  begin
   if (Parent<>nil) then
   begin
    PreferStyleChangeParentSiblings(self,PreferStyle=nil);
   end;
  end else
   InitSelfCBound(dummy);
end;


procedure TdhLink.PreferStyleChangeMenuSibling(caller:TdhCustomPanel; ClearPrefer:boolean);
begin
 if (Self<>caller) and not Down then
 begin
 if ClearPrefer then
  SetPreferStyle(nil,false,false) else
  SetPreferStyle(Style,false,false);
 end;
end;

procedure TdhMenu.AssignMenuSettings(fromMenu:TdhMenu);
begin
 MenuOptions:=fromMenu.MenuOptions+[moNoAuto];
 ReactionTime:=fromMenu.ReactionTime;
end;


function TdhLink.BoundNextSibling:TdhCustomPanel;
begin
 if (FSubMenu<>nil) and FSubMenu.IsInlineMenu then
  Result:=FSubMenu else
  Result:=nil;
end;

function TdhMenu.BoundTop:Integer;
begin
 if (FParentMenuItem<>nil) and IsInlineMenu then
  Result:=FParentMenuItem.Top+1 else
  Result:=Top;
end;


procedure TdhMenu.CalcVariableSizes(FirstPass:boolean);
var i:integer;
begin
 inherited;
 if FirstPass and (AutoSizeXY in [asY,asXY]) then
 for i:=0 to ControlCount-1 do
 if (Controls[i] is TdhMenu) and TdhMenu(Controls[i]).IsInlineMenu then
 begin
  VariableHeight:=true;
  break;
 end;
end;

initialization
 SlideTimer:=TTimer.Create(nil);
 SlideTimer.Enabled:=false;
 LinkTimer:=TTimer.Create(nil);
 LinkTimer.Enabled:=false;
 glUpdateOver:=UpdateOver;

finalization
 LinkTimer.Free;
 SlideTimer.Free;

end.
