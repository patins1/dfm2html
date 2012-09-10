{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is DFM2HTML

The Initial Developer of the Original Code is Joerg Kiegeland

You may retrieve the latest version of this file at the DFM2HTML home page,
located at http://www.dfm2html.com

-------------------------------------------------------------------------------}

unit dhPageControl;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls, QGraphics, QForms,
  {$ELSE}
  Dialogs, Controls, Windows, Messages, Graphics, Forms,
  {$ENDIF}
  SysUtils, Classes,
  dhPanel,dhLabel,GR32,dhStrUtils,dhBitmap32,dhStyles,dhColorUtils, dhGraphicsAlgorithms;

{$R 'dhPageControl.dcr'}

const def_outp='def_outp';

type

  TScrolling=(scAuto,scYes,scNo);

  TdhPage=class;

  TdhPageControl = class(TdhCustomPanel)
  private
    FPages:TList;
    FActivePage: TdhPage;
    FSelectFirstTab: boolean;
    FFixedHeight:boolean;
    FDynamicNavigation:boolean;
    loaddiff:integer;
    FDownForURLAnchors:TList;
    function GetPageCount: integer;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetActivePage(Value: TdhPage);
    procedure RemovePage(Page: TdhPage);
    procedure InsertPage(Page: TdhPage);
    Function FindNextPage(CurPage: TdhPage; GoForward, CheckTabVisible: Boolean): TdhPage;
    function LaterSelected: TdhPage;
    function GetPage(Index: Integer): TdhPage;
    function GetRealActivePage: TdhPage;
    procedure UpdateLinks(OldActivePage:TdhPage; OnlyLocal:boolean);
    procedure PushHeight(diff: integer);
    procedure SetFixedHeight(const Value: boolean);
    procedure SetDynamicNavigation(const Value: boolean);
    procedure Activate(p: TdhPage; ActivatedBy: TControl);
    function IsGlobalActive: boolean;
  protected
    procedure SetZOrder(TopMost: Boolean); override;
    procedure Loaded; override;
    function AdjustZIndex(ChildPos,ParentControlCount:integer):integer; override;
    procedure CalcVariableSizes(FirstPass:boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Pages[Index: Integer]: TdhPage read GetPage;
    function AddSheet: TdhPage;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    property RealActivePage: TdhPage read GetRealActivePage;
    procedure DoTopPainting; override;
    property GetTop:TdhPage read FActivePage;
    function EffectsAllowed: boolean; override;
    procedure PreferStyleChangeMenuSiblings(caller:TdhCustomPanel; ClearPrefer:boolean);
  published
    property Anchors;
    property ActivePage: TdhPage read FActivePage write SetActivePage;
    property PageCount:integer read GetPageCount;
    property SelectFirstTab:boolean read FSelectFirstTab write FSelectFirstTab default true;
    property FixedHeight:boolean read FFixedHeight write SetFixedHeight;
    property DynamicNavigation:boolean read FDynamicNavigation write SetDynamicNavigation default false;
  end;

  TdhPage = class(TdhPanel)
  private
    FTitle: HypeString;
    FPageControl:TdhPageControl;
    FOutputDirectory: TPathName;
    FHTMLBody: HypeString;
    FHTMLBodyClose: HypeString;
    FHTMLHead: HypeString;
    FHTMLTop: HypeString;
    FMetaAuthor: HypeString;
    FMetaKeywords: HypeString;
    FMetaDescription: HypeString;
    FForwardingDelay: integer;
    FForwardingURL: TPathName;
    FBackgroundSoundForever: boolean;
    FBackgroundSoundLoop: integer;
    FPublishURL: TPathName;
    FHTTPURL: TPathName;
    FGeneratedImageFolder: TPathName;
    FGeneratedJavaScriptFile: TPathName;
    FGeneratedCSSFile: TPathName;
    FScrolling:TScrolling;
    FUseIFrame:boolean;
    procedure SetTitle(const Value: HypeString);
    procedure SetPageControl(APageControl: TdhPageControl);
    function GetPageIndex: Integer;
    procedure SetPageIndex(const Value: Integer);
    procedure VisibleChanged; override;
    function IsOutputDirectoryStored: Boolean;
    function GetDefaultOutputDirectory: TPathName;
    procedure SetOutputDirectory(const Value: TPathName);
    function GetOutputDirectory: TPathName;
    function IsAlignStored: boolean;
    function InLinkedRange(link: TControl): boolean;
    procedure SetFTPURL(const Value: TPathName);
    procedure EnableMouseWheelData;
    procedure UpdateHidden;
  protected
    procedure SetZOrder(TopMost: Boolean); override;
    function AdjustZIndex(ChildPos,ParentControlCount:integer):integer; override;
    function NeedPadding(HasRastering:TRasterType): boolean; override;
    procedure PaintWhiteBackground(ref_brct: TRect; Src: TdhBitmap32; const brct: TRect); override;
    function SomethingIsScrolled: boolean; override;
    function HeightDiff: integer; override;
    procedure WriteState(Writer: TWriter); override;
{$IFDEF CLX}
    procedure SetParent(const AParent: TWidgetControl); override;
{$ELSE}
    procedure SetParent(AParent: TWinControl); override;
{$ENDIF}
    procedure Loaded; override;
    function VirtualParent:TControl; override;
    function EffectsAllowed: boolean; override;
    procedure AdjustBackgroundColor(var Col: TCSSColor); override;
    procedure SetScrolling(Value:TScrolling);
    procedure UpdateScrolling(changed:Boolean=True);
    function AlwaysVisibleVisibility:boolean; override;
    procedure SetUseIFrame(value:boolean);
    function CanBeTopPC:boolean; override;
  public
    function AllHTMLCode:HypeString; override;
    function DynamicNavigation:boolean;
    procedure Activate(ActivatedBy: TControl);
    function IsAlternativePage:boolean;
    function IsHTMLBody:boolean;
    function IsInternalHTMLBody:boolean;
    function IsScrollable:boolean;
    function IsInternalScrollable:boolean;
    function IsTopScrollable: boolean;
    function BetterNotToDelete(DeletionList: TList; var Reason: WideString): boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsLaterSelected: boolean;
{$IFDEF CLX}
    procedure ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
{$ELSE}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
{$ENDIF}
    function IsActivePage: boolean;
    property PageControl:TdhPageControl read FPageControl write SetPageControl;
    function AllowDownIfURL(c:TControl):boolean;
    procedure AddDownIfURL(c:TControl);
    procedure RemoveDownIfURL(c:TControl);
    procedure ScrollPage(PageDown:boolean);
  published
    property UseIFrame:boolean read FUseIFrame write SetUseIFrame;
    property Align stored IsAlignStored nodefault;
    property Title:HypeString read FTitle write SetTitle;
    property OutputDirectory:TPathName read GetOutputDirectory write SetOutputDirectory stored IsOutputDirectoryStored;
    property HTMLHead:HypeString read FHTMLHead write FHTMLHead;
    property HTMLBody:HypeString read FHTMLBody write FHTMLBody;
    property HTMLBodyClose:HypeString read FHTMLBodyClose write FHTMLBodyClose;
    property HTMLTop:HypeString read FHTMLTop write FHTMLTop;
    property ForwardingDelay:integer read FForwardingDelay write FForwardingDelay default 0;
    property ForwardingURL:TPathName read FForwardingURL write FForwardingURL;
    property BackgroundSoundForever:boolean read FBackgroundSoundForever write FBackgroundSoundForever default true;
    property BackgroundSoundLoop:integer read FBackgroundSoundLoop write FBackgroundSoundLoop default 0;
    property MetaAuthor:HypeString read FMetaAuthor write FMetaAuthor;
    property MetaDescription:HypeString read FMetaDescription write FMetaDescription;
    property MetaKeywords:HypeString read FMetaKeywords write FMetaKeywords;
    property FTPURL:TPathName read FPublishURL write SetFTPURL;
    property HTTPURL:TPathName read FHTTPURL write FHTTPURL;
    property GeneratedImageFolder:TPathName read FGeneratedImageFolder write FGeneratedImageFolder;
    property GeneratedJavaScriptFile:TPathName read FGeneratedJavaScriptFile write FGeneratedJavaScriptFile;
    property GeneratedCSSFile:TPathName read FGeneratedCSSFile write FGeneratedCSSFile;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored False;
    property Visible stored false;
    property VertPosition;
    property HorzPosition;
    property Scrolling:TScrolling read FScrolling write SetScrolling default scAuto;
  end;

type TGridDisplay=(gdNone,gdDotted,gdChecked,gdLined);
var  GridDefinition: record
     GridX, GridY: integer;
     GridDisplay:TGridDisplay;
end;

procedure Register;

function GoodLocalPath(const path:TPathName):TPathName;
function GoodPathDelimiters(const path:TPathName):TPathName;

implementation


uses dhMenu,dhDirectHTML;

var PageControlBitmap:TBitmap=nil;

var StopAdjusting:boolean;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhPageControl,TdhPage]);
end;

function TdhPage.HeightDiff:integer;
begin
 if (PageControl<>nil) and (PageControl.ActivePage<>nil) then
  result:=Height-PageControl.ActivePage.Height else
  result:=0;
end;

function TdhPage.BetterNotToDelete(DeletionList:TList; var Reason:WideString):boolean;
var DownForURLAnchor:TdhLink;
    i:integer;
begin
 if FPageControl<>nil then
 for i:=0 to FPageControl.FDownForURLAnchors.Count-1 do
 begin
 DownForURLAnchor:=FPageControl.FDownForURLAnchors[i];
 if (DownForURLAnchor.LinkPage=Self) and (DeletionList.IndexOf(DownForURLAnchor)=-1) then
 begin                                     
  Reason:=WFormat(REFOBJECT_STR,[Name,DownForURLAnchor.Name]);
  result:=true;
  exit;
 end;
 end;
 result:=inherited BetterNotToDelete(DeletionList,Reason);
end;


function TdhPageControl.GetPageCount: integer;
begin
  Result := FPages.Count;
end;

constructor TdhPageControl.Create(AOwner: TComponent);
begin
  inherited;
  FPages := TList.Create;
  ControlStyle:=ControlStyle+[csAcceptsControls];
  FSelectFirstTab:=true;
  FDownForURLAnchors:=TList.Create;
  Visible:=false;
end;

destructor TdhPageControl.Destroy;
var
  I: Integer;
begin        
  for I := FPages.Count - 1 downto 0 do TdhPage(FPages[I]).Free;//FPageControl := nil;
  FPages.Free;
  Assert(FDownForURLAnchors.Count=0);
  FreeAndNil(FDownForURLAnchors);
  inherited Destroy;
end;

procedure TdhPageControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin     
  for I := 0 to FPages.Count - 1 do
   Proc(TComponent(FPages[I]));
end;

constructor TdhPage.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle:=ControlStyle+[csNoDesignVisible];
  Visible := False;
  NCScrollbars:=true;
  OutputDirectory:=def_outp;
  FBackgroundSoundForever:=true;
end;

destructor TdhPage.Destroy;
begin
  if FPageControl <> nil then
    FPageControl.RemovePage(Self);
  inherited Destroy;
end;

procedure TdhPageControl.DoTopPainting;
begin
 if (csDesigning in ComponentState) then
 begin
   if (PageControlBitmap=nil) then
   begin
    PageControlBitmap := TBitmap.Create;
    PageControlBitmap.LoadFromResourceName(HInstance, 'TDHPAGECONTROLPURE');
    PageControlBitmap.Transparent:=true;
    PageControlBitmap.TransparentColor:=clYellow;
   end;
   if (PageControlBitmap<>nil) then
    GetCanvas.Draw(0,0,PageControlBitmap);
 end;
end;

procedure TdhPage.SetTitle(const Value: HypeString);
begin
  FTitle := Value;
end;

procedure ReleaseResourcesRecursively(pn:TdhCustomPanel);
var
  I: Integer;
begin
  pn.ReleaseResources;
  for I := 0 to pn.ControlCount - 1 do
  begin
   if pn.Controls[i] is TdhCustomPanel then
    ReleaseResourcesRecursively(TdhCustomPanel(pn.Controls[i]));
  end;
end;

procedure TdhPageControl.SetActivePage(Value: TdhPage);
var diff:integer;
    OldActivePage:TdhPage;
begin

 if FActivePage<>Value then
 begin
  //if Parent<>nil then Parent.DisableAlign;  //would block PushHeight

  if (csLoading in ComponentState) and FSelectFirstTab and not(csDesigning in ComponentState) and (PageCount<>0) and (ActivePage<>Pages[0]) then
  begin
   if Value<>Pages[0] then //otherwise OldActivePage=FActivePage and OldActivePage.Visible=false
    FActivePage:=Value;
   Value:=Pages[0];
  end;

  if (Value<>nil) and (csDestroying in Value.ComponentState) then
   Value:=nil;

  if (FActivePage<>nil) and (Value<>nil) then
   diff:=Value.Height-FActivePage.Height else
   diff:=0;

  OldActivePage:=FActivePage;
  FActivePage := Value;
  if csLoading in ComponentState then
   loaddiff:=diff else
   PushHeight(diff);
  UpdateLinks(OldActivePage,false);
  if FActivePage<>nil then
   FActivePage.Visible:=true;
  if OldActivePage<>nil then
  begin
   OldActivePage.Visible:=false;
   ReleaseResourcesRecursively(OldActivePage);
   //make old unvisible *after* making new visible, to keep scroll position in a parent scrollable object
  end;
 end;
end;

procedure TdhPageControl.PushHeight(diff:integer);
var P:TWinControl;
begin
 if csReading in ComponentState then exit;
 if diff=0 then exit;
 if FFixedHeight then exit;
 if Align in [alClient,alLeft,alRight] then exit;
 assert(not StopAdjusting);
 StopAdjusting:=true;
 P:=Parent;
 while (P<>nil) and not (P is TScrollingWinControl) and not ((P is TdhPage) and TdhPage(P).IsScrollable) and not (P.Anchors*[akTop,akBottom]=[akTop,akBottom]) and not (csDestroying in p.ComponentState) {$IFNDEF CLX} and (not p.AlignDisabled{in welchem Fall wahrscheinlich von p.AlignControls aufgerufen, und somit kein "eigener" SetBounds}){$ENDIF} do
 begin
  P.Height:=P.Height+diff;
  if (P is TdhPage) and not TdhPage(P).IsActivePage then
   break;
  P:=P.Parent;
 end;
 StopAdjusting:=false;
end;

function TdhPage.IsActivePage:boolean;
begin
 result:=(PageControl<>nil) and (PageControl.ActivePage=Self);
end;

procedure TdhPageControl.UpdateLinks(OldActivePage:TdhPage; OnlyLocal:boolean);
var ii:integer;
var DownForURLAnchor:TdhLink;

procedure ItUpdateLinks(p:TWinControl);
var i:integer;
begin
 for i:=0 to p.ControlCount-1 do
 if p.Controls[i] is TdhPageControl then
  TdhPageControl(p.Controls[i]).UpdateLinks(nil,false) else
 if p.Controls[i].Visible and (p.Controls[i] is TWinControl) and not ((p.Controls[i] is TdhPage) and (TdhPage(p.Controls[i]).FPageControl<>nil)) then
  ItUpdateLinks(TWinControl(p.Controls[i]));
end;

begin
 if not (csLoading in ComponentState) then //for speed
 for ii:=0 to FDownForURLAnchors.Count-1 do
 begin
 DownForURLAnchor:=FDownForURLAnchors[ii];
 if not (csDestroying in DownForURLAnchor.ComponentState) then
  DownForURLAnchor.CheckDesignState;
 end;

 if not OnlyLocal and IsGlobalActive then
 begin
  if OldActivePage<>nil then
   ItUpdateLinks(OldActivePage);
  if FActivePage<>nil then
   ItUpdateLinks(FActivePage);
 end;
end;

procedure TdhPageControl.PreferStyleChangeMenuSiblings(caller:TdhCustomPanel; ClearPrefer:boolean);
var ii:integer;
var DownForURLAnchor:TdhLink;
begin
 for ii:=0 to FDownForURLAnchors.Count-1 do
 begin
  DownForURLAnchor:=FDownForURLAnchors[ii];
  DownForURLAnchor.PreferStyleChangeMenuSibling(caller,ClearPrefer);
 end;
end;

procedure TdhPage.AdjustBackgroundColor(var Col:TCSSColor);
begin
 if IsHTMLBody and IsTopScrollable then
 begin
  Col:=Color32ToCSSColor(GetPixelCombineNormal(CSSColorToColor32(Col),CSSColorToColor32(clWhiteCSS)));
  if Parent is TdhCustomPanel then
   Col:=TdhCustomPanel(Parent).GetVirtualBGColor;
 end;
end;

procedure TdhPage.PaintWhiteBackground(ref_brct:TRect; Src:TdhBitmap32; const brct: TRect);
var BPos:TPoint;
var num_across,num_down:integer;
    W,H,x,y,x_coord,y_coord:integer;
    R,R2:TRect;
begin
 if not IsScrollArea then exit;

 if RuntimeMode then exit;

 if not(csDesigning in ComponentState) then exit;

 with GridDefinition do
 case GridDisplay of
 gdChecked:
 begin
 W:=GridX*2;
 H:=GridY*2;
 BPos:=ref_brct.TopLeft;
 GetRepeatings(BPos,num_across,num_down,W,H,brct,true,true);
 for x := 0 to num_across-1 do
 for y := 0 to num_down-1 do
 begin
  x_coord := (x * W) + BPos.X;
  y_coord := (y * H) + BPos.Y;
  R:=Bounds(x_coord+GridX,y_coord,GridX,GridY);
  R2:=R;
  IntersectRect(R,R,brct);
  if not IsRectEmpty(R) then
   Src.FillRect(R.Left,r.Top,r.Right,R.Bottom,clSilver);
  R:=Bounds(x_coord,y_coord+GridY,GridX,GridY);
  R2:=R;
  IntersectRect(R,R,brct);
  if not IsRectEmpty(R) then
   Src.FillRect(R.Left,r.Top,r.Right,R.Bottom,clSilver);
 end;
 end;
 gdDotted:
 begin
 W:=GridX;
 H:=GridY;
 BPos:=ref_brct.TopLeft;
 GetRepeatings(BPos,num_across,num_down,W,H,brct,true,true);
 for x := 0 to num_across-1 do
 for y := 0 to num_down-1 do
 begin
  x_coord := (x * W) + BPos.X;
  y_coord := (y * H) + BPos.Y;
  if PtInRect(brct,Point(x_coord,y_coord)) then
   Src.Pixel[x_coord,y_coord]:=clBlack32;
 end;
 end;
 gdLined:
 begin
 W:=GridX;
 H:=GridY;
 BPos:=ref_brct.TopLeft;
 GetRepeatings(BPos,num_across,num_down,W,H,brct,true,true);
 y:=0;
 for x := 0 to num_across-1 do
 begin
  x_coord := (x * W) + BPos.X;
  if (x_coord>=brct.Left) and (x_coord<brct.Right) then
   src.VertLineS(x_coord,brct.Top,brct.Bottom,clSilver);
 end;
 for y := 0 to num_down-1 do
 begin
  y_coord := (y * H) + BPos.Y;
  if (y_coord>=brct.Top) and (y_coord<brct.Bottom) then
   src.HorzLineS(brct.Left,y_coord,brct.Right,clSilver);
 end;
 end;
 end;

end;

procedure TdhPage.SetPageControl(APageControl: TdhPageControl);
begin
  if FPageControl <> APageControl then
  begin
    if FPageControl <> nil then FPageControl.RemovePage(Self);
    if APageControl <> nil then APageControl.InsertPage(Self);
    if PageControl<>nil then Parent := PageControl.Parent;
    UpdateScrolling;
  end;
end;

procedure TdhPageControl.GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); 
begin
 NewWidth:=24;
 NewHeight:=24;
end;

procedure TdhPageControl.InsertPage(Page: TdhPage);
begin
  FPages.Add(Page);
  Page.FPageControl := Self;
end;

procedure TdhPage.SetZOrder(TopMost: Boolean);
begin
 if FPageControl<>nil then
 begin
  FPageControl.SetZOrder(TopMost);
  exit;
 end;
 Inherited;
end;

procedure TdhPageControl.SetZOrder(TopMost: Boolean);
var i:integer;
begin
 Inherited;
 for i:=0 to FPages.Count-1 do
  UpdateZIndex(FPages[i]);
end;

procedure TdhPageControl.RemovePage(Page: TdhPage);
var
  NextSheet: TdhPage;
var DownForURLAnchor:TdhLink;
    i:integer;
begin
 for i:=FDownForURLAnchors.Count-1 downto 0 do
 begin
  DownForURLAnchor:=FDownForURLAnchors[i];
  if DownForURLAnchor.LinkPage=Page then
  begin
   DownForURLAnchor.LinkPage:=nil;
   DownForURLAnchor.SLinkPage:=Page.Name;
  end;
 end;

  NextSheet := FindNextPage(Page, True, not (csDesigning in ComponentState));
  if NextSheet = Page then NextSheet := nil;
  Page.FPageControl := nil;
  FPages.Remove(Page);
  SetActivePage(NextSheet);
end;


function TdhPageControl.FindNextPage(CurPage: TdhPage;
  GoForward, CheckTabVisible: Boolean): TdhPage;
var
  I, StartIndex: Integer;
begin
  if FPages.Count <> 0 then
  begin
    StartIndex := FPages.IndexOf(CurPage);
    if StartIndex = -1 then
      if GoForward then StartIndex := FPages.Count - 1 else StartIndex := 0;
    I := StartIndex;
    repeat
      if GoForward then
      begin
        Inc(I);
        if I = FPages.Count then I := 0;
      end else
      begin
        if I = 0 then I := FPages.Count;
        Dec(I);
      end;
      Result := FPages[I];
      if not CheckTabVisible then Exit;
    until I = StartIndex;
  end;
  Result := nil;
end;

function TdhPage.DynamicNavigation:boolean;
begin
 if FPageControl=nil then
  result:=false else
  result:=FPageControl.DynamicNavigation;
end;

function TdhPage.CanBeTopPC:boolean;
begin
 result:=(PageControl<>nil) and not PageControl.DynamicNavigation{ and not PageControl.FixedHeight};
end;

function TdhPage.IsLaterSelected:boolean;
begin
 result:=(PageControl is TdhPageControl) and (TdhPageControl(PageControl).LaterSelected=Self);
end;

function TdhPageControl.LaterSelected:TdhPage;
begin
 if SelectFirstTab and (PageCount<>0) then
  result:=FPages[0] else
  result:=ActivePage;
end;

function TdhPageControl.GetPage(Index: Integer): TdhPage;
begin     
  Result := FPages[Index];
end;

function TdhPage.GetPageIndex: Integer;
begin
  if FPageControl <> nil then
    Result := FPageControl.FPages.IndexOf(Self) else
    Result := -1;
end;

procedure TdhPage.SetPageIndex(const Value: Integer);
begin
//  if FPageControl <> nil then
  FPageControl.FPages.Move(PageIndex, Value);
end;

function TdhPageControl.GetRealActivePage: TdhPage;
begin
 result:=LaterSelected;
end;

function TdhPageControl.AddSheet:TdhPage;
begin              
 if Assigned(glPreAddCompo) then
  glPreAddCompo(Self);
 result:=TdhPage.Create(Owner);
 result._SetUniqueName('Page');
 result.Visible:=false;
 result.PageControl:=self;
 if ActivePage<>nil then
 begin
  result.SetBounds(ActivePage.Left,ActivePage.Top,ActivePage.Width,ActivePage.Height);
  result.Use:=ActivePage.Use;
 end else
  result.SetBounds(Left,Top,100,100);
 ActivePage:=result;
 if Assigned(glPostAddCompo) then
  glPostAddCompo(result);   
end;

function RectHeight(r:TRect):integer; inline;
begin
 result:=r.Bottom-r.Top;
end;

procedure TdhPage.UpdateHidden;
var page:TdhPage;
    i:integer;
begin
  if not (csLoading in ComponentState) and IsActivePage and not StopAdjusting then
  for i:=0 to PageControl.PageCount-1 do
  begin
   page:=PageControl.Pages[i];
   if page=Self then continue;
   page.Anchors:=Anchors;
   if page.Align<>Align then
    page.Align:=Align;
   if PageControl.FFixedHeight then
    page.SetBounds(Left,Top,Width,Height) else
    page.SetBounds(Left,Top,Width,page.Height);
  end;
end;


{$IFNDEF CLX}
procedure TdhPage.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
{$ELSE}
procedure TdhPage.ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer);
{$ENDIF}
begin
 if not (csLoading in ComponentState) and IsActivePage and not StopAdjusting then
 begin
  if ((Align in [alLeft,alRight]) and (AHeight=RectHeight(AdjustedClientRect(Parent)))) then
  begin
   Inherited;
   exit;
  end;
  PageControl.PushHeight(AHeight-Height);
  StopAdjusting:=true;
  Inherited;
  StopAdjusting:=false;
  UpdateHidden;
 end else
  inherited;
end;

procedure TdhPage.WriteState(Writer: TWriter);
begin
 if (FPageControl<>nil) then
 if not (csWriting in FPageControl.ComponentState) then
 if (csWriting in Parent.ComponentState) then
 begin
  if not (csWriting in Owner.ComponentState) and not (csWriting in Parent.ComponentState) then
  begin
   writer.Position:=writer.Position-4{=length(Classes.FilerSignature)};
  end;
  exit;
 end;
 Inherited;
 ReleaseResourcesRecursively(self);
end;

{$IFNDEF CLX}
procedure TdhPage.SetParent(AParent: TWinControl);
{$ELSE}
procedure TdhPage.SetParent(const AParent: TWidgetControl);
{$ENDIF}
begin
  if PageControl<>nil then
   inherited SetParent(PageControl.Parent) else
  if AParent is TdhPageControl then
   PageControl:=TdhPageControl(AParent) else
   Inherited;
  if not (csDestroying in ComponentState) then
   UpdateScrolling;
end;

procedure TdhPage.EnableMouseWheelData;
var F:TCustomForm;
begin
   if IsTopScrollable then
   begin
    F := GetParentForm(Self);
    if F <> nil then
      F.SetFocusedControl(Self);
  end;
end;

function TdhPage.IsAlignStored:boolean;
begin
 if IsTopScrollable then
  result:=Align<>alClient else
  result:=Align<>alNone;
end;

procedure TdhPage.Loaded;
begin
 Inherited;
 UpdateScrolling(false);
 if (PageControl<>nil) and (PageControl.ActivePage<>nil) and Visible then
  PageControl.ActivePage:=Self;
end;

procedure TdhPageControl.Loaded;
begin
  inherited;
  PushHeight(loaddiff);
end;

procedure TdhPage.VisibleChanged;
begin
 inherited;
 if Visible then
 if PageControl<>nil then
  PageControl.ActivePage:=Self;
end;

function TdhPage.VirtualParent: TControl;
begin    
 if PageControl<>nil then
  result:=PageControl else
  result:=Parent;
end;

procedure TdhPageControl.SetFixedHeight(const Value: boolean);
var i:integer;
begin
  FFixedHeight := Value;
  if FFixedHeight and (ActivePage<>nil) then
  for i:=0 to PageCount-1 do
  with ActivePage do
   Pages[i].SetBounds(Left,Top,Width,Height) else
end;

procedure TdhPageControl.CalcVariableSizes(FirstPass:boolean);
var p:TControl;
begin
 inherited;      
 p:=Self;
 if FirstPass and not FFixedHeight and FDynamicNavigation then
 while (p is TdhCustomPanel) and not ((p is TdhPage) and TdhPage(p).IsScrollable) do
 begin
  TdhCustomPanel(p).VariableHeight:=true;
  p:=p.Parent;
 end;
end;

function TdhPage.SomethingIsScrolled: boolean;
begin
 result:=(Inherited SomethingIsScrolled) or (csDesigning in ComponentState) and (GridDefinition.GridDisplay<>gdNone);
end;

function TdhPage.NeedPadding(HasRastering:TRasterType):boolean;
begin
 result:=IsHTMLBody;
end;

function TdhPage.IsAlternativePage: boolean;
begin
 result:=not IsScrollable;
end;

function TdhPage.IsScrollable: boolean;
begin
 result:=PageControl=nil;
end;

function TdhPage.IsInternalScrollable: boolean;
begin
 result:=IsScrollable and not (Parent is TCustomForm);
end;

function TdhPage.IsTopScrollable:boolean;
begin
 result:=IsScrollable and not IsInternalScrollable;
end;

function TdhPage.IsHTMLBody: boolean;
begin
 result:=IsScrollable and (FUseIFrame or IsTopScrollable);
end;

function TdhPage.IsInternalHTMLBody: boolean;
begin
 result:=IsHTMLBody and IsInternalScrollable;
end;

function TdhPage.EffectsAllowed: boolean;
begin
 result:=not IsScrollable;
end;

function TdhPageControl.AdjustZIndex(ChildPos,ParentControlCount:integer):integer;
begin
 result:=maxint-1000-3*ParentControlCount+ChildPos;
end;

function TdhPage.AdjustZIndex(ChildPos,ParentControlCount:integer):integer;
begin
 if FPageControl<>nil then
  result:=GetBaseZOrder(FPageControl,GetChildPosition(FPageControl))+ZIndex*ParentControlCount*8 else
  result:=inherited AdjustZIndex(ChildPos,ParentControlCount)
end;

function TdhPage.IsOutputDirectoryStored: Boolean;
begin
 result:=GetOutputDirectory<>GetDefaultOutputDirectory;
end;

function TdhPage.GetDefaultOutputDirectory:TPathName;
var p:TControl;
begin
 p:=Parent;
 while (p<>nil) and not (p is TdhPage) do
  p:=p.Parent;
 if p is TdhPage then
  result:=TdhPage(p).GetOutputDirectory else
  result:='DFM2HTML_'+Name+PathDelim;
end;

function GoodLocalPath(const path:TPathName):TPathName;
begin
 result:=path;
 if (result<>'') and not CharInSet(result[length(result)],['/','\']) then
  result:=result+PathDelim;
 result:=GoodPathDelimiters(result);
end;

function GoodPathDelimiters(const path:TPathName):TPathName;
begin
 result:=path;
 result:=StringReplace(result,'/',PathDelim,[rfReplaceAll]);
 result:=StringReplace(result,'\',PathDelim,[rfReplaceAll]);
end;

procedure TdhPage.SetOutputDirectory(const Value: TPathName);
begin
 if Value=def_outp then
 begin
  FOutputDirectory := Value;
 end else
 begin
  FOutputDirectory := GoodLocalPath(Value);
 end;
 if GetOutputDirectory=GetDefaultOutputDirectory then
  FOutputDirectory := def_outp;
end;

function TdhPage.GetOutputDirectory: TPathName;
begin
 if FOutputDirectory=def_outp then
  result:=GetDefaultOutputDirectory else
  result:=FOutputDirectory;
end;


procedure TdhPageControl.SetDynamicNavigation(const Value: boolean);
begin
 if FDynamicNavigation<>Value then
 begin
  FDynamicNavigation:=Value;
  UpdateLinks(nil,true);
 end;
end;

procedure TdhPageControl.Activate(p:TdhPage; ActivatedBy:TControl);
var i:integer;
begin
 if ActivatedBy is TdhLink then
 begin
  i:=FDownForURLAnchors.IndexOf(ActivatedBy);
  if (i<>-1) and (i<>FDownForURLAnchors.Count-1) then
  begin
   FDownForURLAnchors.Delete(i);
   FDownForURLAnchors.Add(ActivatedBy);
  end;
 end;
 ActivePage:=p;
end;

procedure TdhPage.Activate(ActivatedBy:TControl);
begin
 PageControl.Activate(Self,ActivatedBy);
end;

function TdhPage.InLinkedRange(link:TControl):boolean;
var i,i2:integer;
begin
  if TdhLink(link).PageRange=0 then //for speed
  begin
    result:=Self=FPageControl.GetTop;
    exit;
  end;
  i:=FPageControl.FPages.IndexOf(FPageControl.GetTop);
  i2:=FPageControl.FPages.IndexOf(Self);
  result:=(i>=i2) and (i<=i2+Abs(TdhLink(link).PageRange));
end;


function TdhPage.AllowDownIfURL(c:TControl): boolean;
begin
 if (FPageControl<>nil) and (FPageControl.GetTop<>nil) and (c is TdhLink) and (FPageControl.FDownForURLAnchors.Count<>0) and
    (FPageControl.FDynamicNavigation and (FPageControl.FDownForURLAnchors.Last=c) or not FPageControl.FDynamicNavigation and (TdhLink(c).LinkPage=Self) and (TdhLink(c).PageRange=0)) then
 begin
  result:=Self.InLinkedRange(TdhLink(c)) and FPageControl.IsGlobalActive;
 end else
  result:=IsTopScrollable;
end;

function TdhPageControl.IsGlobalActive:boolean;
var apage:TWinControl;
begin 
  apage:=GetParentPage(Self);
  while (apage is TdhPage) and (TdhPage(apage).PageControl<>nil) do
  begin
   if not TdhPage(apage).IsActivePage then
   begin
    result:=false;
    exit;
   end;
   apage:=GetParentPage(apage);
  end;
  result:=true;
end;

procedure TdhPage.AddDownIfURL(c: TControl);
begin
 if (FPageControl<>nil) and (FPageControl.FDownForURLAnchors.IndexOf(c)=-1) then
 begin
  FPageControl.FDownForURLAnchors.Add(c);
  FPageControl.UpdateLinks(nil,true);
 end;
end;

procedure TdhPage.RemoveDownIfURL(c: TControl);
begin
 if (FPageControl<>nil) and (FPageControl.FDownForURLAnchors<>nil) then
 begin
  FPageControl.FDownForURLAnchors.Remove(c);
  FPageControl.UpdateLinks(nil,true);
 end;
end;

procedure TdhPage.ScrollPage(PageDown: boolean);
begin
 if PageDown then
  VertPosition:=VertPosition+Height else
  VertPosition:=VertPosition-Height;
end;


function TdhPage.AllHTMLCode:HypeString;
begin
 result:=FHTMLTop+FHTMLHead+FHTMLBody+FHTMLBodyClose;
end;

function TdhPageControl.EffectsAllowed: boolean;
begin
 result:=false;
end;

procedure TdhPage.SetFTPURL(const Value: TPathName);
begin
 if FPublishURL<>Value then
 begin
  FPublishURL := Value;
 end;
end;

procedure TdhPage.SetUseIFrame(value:boolean);
begin
 if FUseIFrame<>Value then
 begin
  FUseIFrame:=Value;
  UpdateScrolling;
 end;
end;

procedure TdhPage.SetScrolling(Value:TScrolling);
begin
 if FScrolling<>Value then
 begin
  FScrolling:=Value;
  UpdateScrolling;
 end;
end;

procedure TdhPage.UpdateScrolling(changed:Boolean=True);
begin
   if csLoading in ComponentState then exit;
   FVertScrollbarAlwaysVisible:=IsScrollable and (FScrolling=scYes) or IsTopScrollable;
   FHorzScrollbarAlwaysVisible:=IsScrollable and (FScrolling=scYes) and not IsHTMLBody;
   FVertScrollbarNeverVisible:=IsScrollable and (FScrolling=scNo);
   FHorzScrollbarNeverVisible:=IsScrollable and (FScrolling=scNo);
   EdgesInScrolledArea:=IsHTMLBody;
   IsScrollArea:=IsScrollable;
   if changed then
    ScrollingParametersChanged;
   if PageControl=nil then
    Visible:=true;
   EnableMouseWheelData;
end;

function TdhPage.AlwaysVisibleVisibility:boolean;
begin
 result:=IsHTMLBody;
end;

initialization

finalization

 FreeAndNil(PageControlBitmap);

end.
