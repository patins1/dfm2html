unit dhPageControl;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls, QGraphics, QForms,
  {$ELSE}
  Dialogs, Controls, Windows, Messages, Graphics, Forms,
  {$ENDIF}
  SysUtils, Classes,{$IFDEF MSWINDOWS}OverbyteIcsUrl,{$ELSE}{IcsUrl,}{$ENDIF}
  dhPanel,dhLabel,GR32,UseFastStrings,MyBitmap32;

{$R 'dhPageControl.dcr'}

const def_outp='def_outp';

type

  //THTMLImplementation=(hiEmbedded,hiScript);
  TScrolling=(scAuto,scYes,scNo);

  TdhPage=class;

  TdhPageControl = class(TdhCustomPanel)
  private
    { Private declarations }
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
    Function FindNextPage(CurPage: TdhPage;
     GoForward, CheckTabVisible: Boolean): TdhPage;
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
    { Protected declarations }
    procedure SetZOrder(TopMost: Boolean); override;
    procedure Loaded; override;
    function AdjustZIndex(ChildPos,ParentControlCount:integer):integer; override;
    procedure CalcVariableSizes(FirstPass:boolean); override;

  public
    { Public declarations }

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
    { Published declarations }
    //property Style stored false;
    property Anchors;
    property ActivePage: TdhPage read FActivePage write SetActivePage;
    property PageCount:integer read GetPageCount;
    //property HTMLImplementation:THTMLImplementation read GetHTMLImplementation write SetHTMLImplementation stored false default hiEmbedded;
    property SelectFirstTab:boolean read FSelectFirstTab write FSelectFirstTab default true;
    property FixedHeight:boolean read FFixedHeight write SetFixedHeight;
    property DynamicNavigation:boolean read FDynamicNavigation write SetDynamicNavigation default false;
  end;

  TdhPage = class(TdhPanel)
  private
    FTitle: HypeString;
    FPageControl:TdhPageControl;
    OldFormat:boolean;
    FOutputDirectory: string;
    FHTMLBody: HypeString;
    FHTMLHead: HypeString;
    FHTMLTop: HypeString;
    FMetaAuthor: HypeString;
    FMetaKeywords: HypeString;
    FMetaDescription: HypeString;
    FForwardingDelay: integer;
    //FForwardingEnabled: string;
    FForwardingURL: string;
    FBackgroundSoundForever: boolean;
    FBackgroundSoundLoop: integer;
    FBackgroundSoundURL: string;
    FPublishURL: string;
    FHTTPURL: string;
    FGeneratedImageFolder: string;
    FGeneratedJavaScriptFile: string;
    FGeneratedCSSFile: string;
    FScrolling:TScrolling;
    FUseIFrame:boolean;
    procedure SetTitle(const Value: HypeString);
    procedure SetPageControl(APageControl: TdhPageControl);
    //procedure WriteDownAnchor(Writer: TWriter);
    procedure WriteInitialProps(Writer: TWriter);
    procedure WriteHeightDiff(Writer: TWriter);
    procedure WriteTrue(Writer: TWriter);
    function GetPageIndex: Integer;
    procedure SetPageIndex(const Value: Integer);
    procedure VisibleChanged; override;
    procedure ReadOldFormat(Reader: TReader);
    function IsOutputDirectoryStored: Boolean;
    function GetDefaultOutputDirectory: string;
    procedure SetOutputDirectory(const Value: string);
    function GetOutputDirectory: string;
    function IsAlignStored: boolean;
    function InLinkedRange(link: TControl): boolean;
    procedure SetFTPURL(const Value: string);
    //procedure SetPublishURL(const Value: string);
    procedure EnableMouseWheelData;
    procedure UpdateHidden;

  protected
    { Protected declarations }
    //function WhiteBackground: boolean; override;
    procedure SetZOrder(TopMost: Boolean); override;
    function AdjustZIndex(ChildPos,ParentControlCount:integer):integer; override;
    procedure SetName(const Value: TComponentName); override;
    function NeedPadding(HasRastering:TRasterType): boolean; override;
    //function Opaque: boolean; override;
    procedure PaintWhiteBackground(ref_brct: TRect; Src: TMyBitmap32; const brct: TRect); override;
    //function SomethingIsFixed: boolean; override;
    function SomethingIsScrolled: boolean; override;
    function HeightDiff: integer; override;
    procedure WriteState(Writer: TWriter); override;
    procedure DefineProperties(Filer: TFiler); override;

{$IFDEF CLX}
    procedure SetParent(const AParent: TWidgetControl); override;
{$ELSE}
    procedure SetParent(AParent: TWinControl); override;
{$ENDIF}

    procedure Loaded; override;
    function VirtualParent:TControl; override;
    function EffectsAllowed: boolean; override;
    //function GetClientAdjusting:TRect; override;
    procedure AdjustBackgroundColor(var Col: TCSSColor); override;
    procedure SetScrolling(Value:TScrolling);
    procedure UpdateScrolling(changed:Boolean=True);
    function AlwaysVisibleVisibility:boolean; override;

    procedure SetUseIFrame(value:boolean);
    function CanBeTopPC:boolean; override;
    function GetImageDir:String; override;

  public
    { Public declarations }
    function AllHTMLCode:HypeString; override;
    function Find(FileName:String; CRC:DWORD; AddOrReplace:boolean):boolean;
    function GetFTPShortcut:string;
    function DynamicNavigation:boolean;
    procedure Activate(ActivatedBy: TControl);
    function IsAlternativePage:boolean;
    function IsHTMLBody:boolean;
    function IsPHP:boolean;
    function IsInternalHTMLBody:boolean;
    //function IsTopHTMLBody: boolean;
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
    { Published declarations }
    property UseIFrame:boolean read FUseIFrame write SetUseIFrame;
    property Align stored IsAlignStored nodefault;
    property Title:HypeString read FTitle write SetTitle;
    property OutputDirectory:string read GetOutputDirectory write SetOutputDirectory stored IsOutputDirectoryStored;
    property HTMLHead:HypeString read FHTMLHead write FHTMLHead;
    property HTMLBody:HypeString read FHTMLBody write FHTMLBody;
    property HTMLTop:HypeString read FHTMLTop write FHTMLTop;
    //property ForwardingEnabled:string read FForwardingEnabled write FForwardingEnabled default false;
    property ForwardingDelay:integer read FForwardingDelay write FForwardingDelay default 0;
    property ForwardingURL:string read FForwardingURL write FForwardingURL;
    property BackgroundSoundURL:string read FBackgroundSoundURL write FBackgroundSoundURL;
    property BackgroundSoundForever:boolean read FBackgroundSoundForever write FBackgroundSoundForever default true;
    property BackgroundSoundLoop:integer read FBackgroundSoundLoop write FBackgroundSoundLoop default 0;
    property MetaAuthor:HypeString read FMetaAuthor write FMetaAuthor;
    property MetaDescription:HypeString read FMetaDescription write FMetaDescription;
    property MetaKeywords:HypeString read FMetaKeywords write FMetaKeywords;
    //property PublishURL:string read FPublishURL write SetPublishURL stored false;
    property FTPURL:string read FPublishURL write SetFTPURL;
    property HTTPURL:string read FHTTPURL write FHTTPURL;
    property GeneratedImageFolder:string read FGeneratedImageFolder write FGeneratedImageFolder;  
    property GeneratedJavaScriptFile:string read FGeneratedJavaScriptFile write FGeneratedJavaScriptFile;
    property GeneratedCSSFile:string read FGeneratedCSSFile write FGeneratedCSSFile;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored False;
    property Visible stored false;

    property VertPosition;
    property HorzPosition;

    property Scrolling:TScrolling read FScrolling write SetScrolling default scAuto;

    {property Font stored false;
    property ParentFont stored false;
    property ParentColor stored false;
    property Color stored false;
    property Align stored false;  }

  end;

procedure _SetUniqueName(Self:TComponent; const s:string);
function _GetUniqueName(Self:TComponent; const s:string):string;

var Uploaded:array of record FTP:String; Files:array of record FileName:String; CRC:DWORD; end; end;

type TGridDisplay=(gdNone,gdDotted,gdChecked,gdLined);

var
     FGridX, FGridY: integer;
     FGridDisplay:TGridDisplay;
     FViewer:string;
     FSmartPublishing:boolean;
     FPassiveFTP:boolean;
     FAutoUpdate:boolean;

procedure Register;

function GoodLocalPath(const path:string):string;
function GoodPathDelimiters(const path:string):string;
function GoodWebPathDelimiters(const path:string):string;
function AdjustAlternativeRastering(const TopPC,ID:String; var Rastering:String):boolean;

function FinalGeneratedJavaScriptFile(const GeneratedJavaScriptFile:String):String;
function FinalGeneratedImageFolder(const GeneratedImageFolder:String):String;
function FinalGeneratedCSSFile(const GeneratedCSSFile:String):String;


implementation


uses {dhScrollBox,}dhMenu,dhDirectHTML;

var PageControlBitmap:TBitmap=nil;

var StopAdjusting:boolean;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhPageControl,TdhPage]);
end;

{ TdhPageControl }    

procedure _SetUniqueName(Self:TComponent; const s:string);
var i:integer;
    NewName:string;
begin
(*
 with Self do
 For i := 1 to High(Integer) do
 begin
  NewName:=s+inttostr(i);
  if Owner.FindComponent(NewName)=nil then
  begin
   Name:=NewName;
   exit;
  end;
{  try
   Name:=s+inttostr(i);
  except
   Continue;
  end;
  exit;}
 end;*)
 Self.Name:=_GetUniqueName(Self,s);
end;

function _GetUniqueName(Self:TComponent; const s:string):string;
var i:integer;
    NewName:string;
    sl:TStringList;
begin
 sl:=TStringList.Create;
 try

 with Self.Owner do
 for i:=0 to ComponentCount-1 do
 if Components[i] is TdhCustomPanel then
  TdhCustomPanel(Components[i]).TryBrokenReferences(sl);
 sl.CaseSensitive:=false;
 with Self do
 For i := 1 to High(Integer) do
 begin
  NewName:=s+inttostr(i);
  if (Owner.FindComponent(NewName)=nil) and (sl.IndexOf(NewName)=-1) then
  begin
   result:=NewName;
   exit;
  end;
{  try
   Name:=s+inttostr(i);
  except
   Continue;
  end;
  exit;}
 end;
 finally
  sl.Free;
 end;
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
  Reason:=WFormat(REFOBJECT_STR,[Name,DownForURLAnchor.Name]); //is linked by
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

(*

procedure TdhPageControl.SetHTMLImplementation(
  const Value: THTMLImplementation);
{var sc:TdhScrollingWinControl;
    sHeight:integer;
    OldValue:THTMLImplementation;}
begin

 FDynamicNavigation:=Value=hiScript;
{ FHTMLImplementation:=Value;
 if FHTMLImplementation=hiIFrame then
  FHTMLImplementation:=hiEmbedded;
 }
{ if FHTMLImplementation<>Value then
 begin
  OldValue:=FHTMLImplementation;
  FHTMLImplementation:=Value;
  if csLoading in ComponentState  then exit;

  if FHTMLImplementation=hiIFrame then
  begin
   sc:=TdhScrollBox.Create(Owner);
   _SetUniqueName(sc,'dhScrollBox');
   TFakeControl(sc).ParentColor:=true;
   sc.Parent:=Parent;
   sc.BoundsRect:=Bounds(Left,Top,Width+16,Height);
   Left:=0;
   Top:=0;
   self.Parent:=sc;
  end else
  if OldValue=hiIFrame then
  begin
   sHeight:=Height;
   sc:=Parent as TdhScrollingWinControl;
   BoundsRect:=Bounds(sc.Left,sc.Top,Width,sc.Height);
   Parent:=sc.Parent;
   Height:=sHeight;
   sc.Free;
  end;
 end; }
end;
*)

constructor TdhPage.Create(AOwner: TComponent);
begin
  inherited;
  //Align:=alTop;
  ControlStyle:=ControlStyle+[csNoDesignVisible];
  Visible := False;
  NCScrollbars:=true;
  //EdgesInScrolledArea:=true;
  OutputDirectory:=def_outp;
  FBackgroundSoundForever:=true;
//  FDownForURLAnchors:=TList.Create;
end;



destructor TdhPage.Destroy;
begin
  if FPageControl <> nil then
    FPageControl.RemovePage(Self);
//  FreeAndNil(FDownForURLAnchors);
  inherited Destroy;
end;


procedure TdhPageControl.DoTopPainting;

var
  rct:TRect;
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

 // inherited;
// PaintOuterBg;
// FCommon.SpecialPaintBorder(FCommon.MarginClientRect,FCommon.BorderClientRect);
end;

procedure TdhPage.SetTitle(const Value: HypeString);
begin
  FTitle := Value;
  //(GetTopForm(Self) as TForm).Caption:=FTitle;
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
  //if Parent<>nil then Parent.DisableAlign;  //würde in PushHeight blockieren

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
  if (OldActivePage<>nil){ and FActivePage.HandleAllocated}{in Destroy, visible:=false setzt SetFocus neu} then
  begin
   {if FActivePage.ContainsControl(GetParentForm(Self).ActiveControl) then
   begin
    Windows.SetFocus(0);
    GetParentForm(Self).ActiveControl:=nil;
   end; }
   OldActivePage.Visible:=false;
   ReleaseResourcesRecursively(OldActivePage);
   //make old unvisible before making new visible, to keep scroll position in a parent scrollable object
  end;


  //if Parent<>nil then Parent.EnableAlign;
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
var {i,}ii:integer;
var {c,cc,}DownForURLAnchor:TdhLink;
    sl:TList;

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
// CancelCheckDesignState:=false;
// for i:=0 to PageCount-1 do
 for ii:=0 to {Pages[i].}FDownForURLAnchors.Count-1 do
 begin
 DownForURLAnchor:={Pages[i].}FDownForURLAnchors[ii];
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


         {
function TdhPage.WhiteBackground:boolean;
begin
 result:=FCommon.IsScrollArea;
end;

          }


procedure TdhPage.AdjustBackgroundColor(var Col:TCSSColor);
begin
 if IsHTMLBody and IsTopScrollable and (Col=colTransparent) then
 begin
  Col:=clWhite;
  if Parent is TdhCustomPanel then
   Col:=TdhCustomPanel(Parent).GetVirtualBGColor;
 end;
end;



{function TdhPage.Opaque:boolean;
begin
 result:=FCommon.IsScrollArea or (inherited Opaque);
// result:=false;
end;
 }
procedure TdhPage.PaintWhiteBackground(ref_brct:TRect; Src:TMyBitmap32; const brct: TRect);
var BPos:TPoint;
var num_across,num_down:integer;
    W,H,x,y,x_coord,y_coord:integer;
    R,R2:TRect;
begin
 if not IsScrollArea then exit;

 //Src.FillRectS(brct,clWhite32);

 if RuntimeMode then exit;

 if not(csDesigning in ComponentState) then exit;

 case FGridDisplay of
 gdChecked:
 begin
 W:=FGridX*2;
 H:=FGridY*2;
 BPos:=ref_brct.TopLeft;
 GetRepeatings(BPos,num_across,num_down,W,H,brct,true,true);
 for x := 0 to num_across-1 do
 for y := 0 to num_down-1 do
 begin
  x_coord := (x * W) + BPos.X;
  y_coord := (y * H) + BPos.Y;
  //Canvas.Draw(x_coord, y_coord, FPicture.Graphic);
  R:=Bounds(x_coord+FGridX,y_coord,FGridX,FGridY);
  R2:=R;
  IntersectRect(R,R,brct);
  if not IsRectEmpty(R) then
   Src.FillRect(R.Left,r.Top,r.Right,R.Bottom,clSilver);
  R:=Bounds(x_coord,y_coord+FGridY,FGridX,FGridY);
  R2:=R;
  IntersectRect(R,R,brct);
  if not IsRectEmpty(R) then
   Src.FillRect(R.Left,r.Top,r.Right,R.Bottom,clSilver);
 end;
 end;
 gdDotted:
 begin
 W:=FGridX;
 H:=FGridY;
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
 W:=FGridX;
 H:=FGridY;
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

                             {

function TdhPage.SomethingIsFixed:boolean;
var Picture:TPicture;
begin
 result:=not FCommon.NCScrollbars or (FCommon.BackgroundAttachment=cbaFixed) and FCommon.HasBackgroundImage(Picture);
end;
                            }
procedure TdhPage.SetPageControl(APageControl: TdhPageControl);
begin
  if FPageControl <> APageControl then
  begin
    if FPageControl <> nil then FPageControl.RemovePage(Self);
    if APageControl <> nil then APageControl.InsertPage(Self);
    if PageControl<>nil then Parent := PageControl.Parent;
    //if PageControl=nil then Visible:=true;
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
//  Page.UpdateTabShowing;
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
  //Page.SetTabShowing(False);
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
      if not CheckTabVisible{ or Result.TabVisible} then Exit;
    until I = StartIndex;
  end;
  Result := nil;
end;



                   {
function TdhPage.GetHTMLImplementation: THTMLImplementation;
begin
 if FPageControl=nil then
  result:=hiEmbedded else
  result:=FPageControl.HTMLImplementation;
end;               }


function TdhPage.DynamicNavigation:boolean;
begin
 if FPageControl=nil then
  result:=false else
  result:=FPageControl.DynamicNavigation;
end;


function TdhPage.GetFTPShortcut:string;
var Proto, Username, Password, Host, Port, Path : String;
begin
{$IFNDEF CLX}
 ParseURL(FPublishURL,Proto, Username, Password, Host, Port, Path);
{$ENDIF}
 result:=Lowercase(Host)+Path;
end;

function TdhPage.Find(FileName:String; CRC:DWORD; AddOrReplace:boolean):boolean;
var
    FTP:String;
    i,w:integer;
begin
 result:=false;
 //FileName:=Lowercase(FileName);
 FTP:=GetFTPShortcut;
 for i:=Low(Uploaded) to High(Uploaded) do
 if Uploaded[i].FTP=FTP then
 with Uploaded[i] do
 begin
  for w:=Low(Files) to High(Files) do
  if Files[w].FileName=FileName then
  begin
   if AddOrReplace then
   begin
    Files[w].CRC:=CRC;
    exit;
   end else
   begin
    result:=Files[w].CRC=CRC;
    exit;
   end;
  end;
  if AddOrReplace then
  begin
   if FileName='*' then
   begin
    SetLength(Files,0);
   end else
   begin
    SetLength(Files,Length(Files)+1);
    Files[High(Files)].FileName:=FileName;
    Files[High(Files)].CRC:=CRC;
   end;
   exit;
  end else
  begin
   result:=(FileName='*') and (Length(Files)<>0);
   exit;
  end;
 end;
 if AddOrReplace then
 begin
  SetLength(Uploaded,Length(Uploaded)+1);
  Uploaded[High(Uploaded)].FTP:=FTP;
  with Uploaded[High(Uploaded)] do
  begin
   SetLength(Files,Length(Files)+1);
   Files[High(Files)].FileName:=FileName;
   Files[High(Files)].CRC:=CRC;
  end;
  exit;
 end else
 begin
  result:=false;
  exit;
 end;
end;


var AlternativeRasterings:array of record TopPC,ID,Rastering:String; end;

function AdjustAlternativeRastering(const TopPC,ID:String; var Rastering:String):boolean;
var i:integer;
begin
 result:=true;
 for i := 0 to High(AlternativeRasterings) do
 if (AlternativeRasterings[i].TopPC=TopPC) and (AlternativeRasterings[i].ID=ID) then
 begin
  Rastering:=AlternativeRasterings[i].Rastering;
  exit;
 end;
end;


function TdhPage.CanBeTopPC:boolean;
begin
 result:=(PageControl<>nil) and not PageControl.DynamicNavigation{ and not PageControl.FixedHeight};
end;

procedure TdhPage.DefineProperties(Filer: TFiler);
var P:TControl;
    pn:TdhCustomPanel;
    addheight:integer;
begin
  inherited;
  Filer.DefineProperty('Caption', ReadOldFormat, nil, false);
  if (csLoading in ComponentState) or not WithMeta and (Filer is TWriter) then exit;
  Filer.DefineProperty('DownAnchor', SkipValue, {WriteDownAnchor}WriteTrue, {DownForURLAnchor<>nil}false);
  Filer.DefineProperty('HeightDiff', SkipValue, WriteHeightDiff, (FPageControl<>nil) and (FPageControl.ActivePage<>nil));
  Filer.DefineProperty('Selected', SkipValue, WriteTrue, IsLaterSelected);
  Filer.DefineProperty('InitialProps', SkipValue, WriteInitialProps, IsHTMLBody);
  Filer.DefineProperty('IsPHP', SkipValue, WriteTrue, IsPHP);
//  Filer.DefineProperty('NotFixScrollbar', SkipValue, WriteTrue, IsIFrame and not FCommon.IsVertScrollBarVisible);

  if IsTopScrollable then
  begin
    SetLength(AlternativeRasterings,0);
  end;             
  if not CanBeTopPC or HasSubTS(Self) then exit;
  addheight:=0;
  P:=Self;
  while P is TdhCustomPanel do
  begin
   pn:=TdhCustomPanel(P);
   if pn.IsScrollArea then break;
   if pn<>self then
   if (pn.IsRastered(false)<>rsNo) and Assigned(glSaveBin) and pn.Style.PrepareRastering(addheight,'_'+Self.Name) then
   begin
    SetLength(AlternativeRasterings,Length(AlternativeRasterings)+1);
    with AlternativeRasterings[High(AlternativeRasterings)] do
    begin
     TopPC:=Self.Name;
     ID:=pn.Name;
     Rastering:=pn.Style.RasteringFile;
    end;
    //;f
   end;
   //pn.AssertTop(addheight);
   inc(addheight,pn.HeightDiff);
   p:=p.Parent;
  end;


end;

procedure TdhPage.ReadOldFormat(Reader:TReader);
begin
 Self.SkipValue(Reader);
 OldFormat:=true;
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

{procedure TdhPage.WriteDownAnchor(Writer: TWriter);
begin
 Writer.WriteString(FinalID(DownForURLAnchor));
end;
 }
procedure TdhPage.WriteInitialProps(Writer: TWriter);
var PropChoose:TPropChoose;
    s:string;
begin
 s:='';
 for PropChoose:=low(TPropChoose) to high(TPropChoose) do
 begin
 if not (GetVal(PropChoose) and not IsInUseList(ValStyle)) then
  continue;
 if not((PropChoose=pcColor) and (Cascaded.Color=clWindowText) or (PropChoose=pcBackgroundColor) or (PropChoose=pcFontStyle) and (Cascaded.FontStyle=cfsNormal) or (PropChoose=pcFontWeight) and (Cascaded.FontWeight=cfwNormal)) then
  s:=s+GetCSSPropName(PropChoose)+':'+GetCSSPropValue(PropChoose)+';';
 end;

 Writer.WriteString(s);
end;




procedure TdhPage.WriteHeightDiff(Writer: TWriter);
begin
 Writer.WriteInteger(Height-PageControl.ActivePage.Height);
end;

procedure TdhPage.WriteTrue(Writer: TWriter);
begin
 Writer.WriteBoolean(true);
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
 result.Name:=_GetUniqueName(result,'Page');
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

function RectHeight(r:TRect):integer;
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
   //page.Center:=Center;
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
var diff,i:integer;
    r:TRect;
begin
 if not (csLoading in ComponentState) and IsActivePage and not StopAdjusting then
 begin

  {for i:=0 to PageControl.PageCount-1 do
  if PageControl.Pages[i]<>Self then
  begin
   PageControl.Pages[i].Anchors:=Anchors;
   if PageControl.Pages[i].Align<>Align then
    PageControl.Pages[i].Align:=Align;
   if PageControl.FFixedHeight then
    PageControl.Pages[i].SetBounds(ALeft,ATop,AWidth,AHeight) else
    PageControl.Pages[i].SetBounds(ALeft,ATop,AWidth,PageControl.Pages[i].Height);
  end; }

  if ((Align in [alLeft,alRight]) and (AHeight=RectHeight(AdjustedClientRect(Parent)))) then
  begin
   Inherited;
   exit;
  end;

 {if akBottom in Anchors then
 begin
  diff:=Height-AHeight;
  AHeight:=Height;
  inherited;
 end else} {
 begin
  diff:=Height;
  inherited;
  diff:=Height-diff;
 end;      }
  diff:=AHeight-Height;
  PageControl.PushHeight(diff);

  StopAdjusting:=true;
  r:=self.BoundsRect;
  for i:=0 to PageControl.PageCount-1 do
  if PageControl.Pages[i]<>Self then
  begin                {
   PageControl.Pages[i].Anchors:=Anchors;
   if PageControl.Pages[i].Align<>Align then
    PageControl.Pages[i].Align:=Align;  }
   //if not(akBottom in Anchors) then
{   if PageControl.FFixedHeight then
    PageControl.Pages[i].SetBounds(r.Left,r.Top,r.Right-r.Left,r.Bottom-r.Top) else
    PageControl.Pages[i].SetBounds(r.Left,r.Top,r.Right-r.Left,PageControl.Pages[i].Height);
}
  end;
  //if not (Align in [alLeft,alRight]) then
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
//   showmessage('EXIT:'+owner.name+'.'+name+': '+booltostr((FParentMenuItem<>nil) and not(csWriting in FParentMenuItem.ComponentState) and not IsInlineMenu,true)+' '+booltostr(csWriting in Owner.ComponentState,true)+' '+booltostr(not Visible,true));
  end;
  exit;
 end;

 //showmessage(owner.name+'.'+name+': '+booltostr((FParentMenuItem<>nil) and not(csWriting in FParentMenuItem.ComponentState) and not IsInlineMenu,true)+' '+booltostr(csWriting in Owner.ComponentState,true)+' '+booltostr(not Visible,true));
 Inherited;

end;

{$IFNDEF CLX}
procedure TdhPage.SetParent(AParent: TWinControl);
{$ELSE}
procedure TdhPage.SetParent(const AParent: TWidgetControl);
{$ENDIF}
var F:TCustomForm;
begin

  if PageControl<>nil then
   inherited SetParent(PageControl.Parent) else
  if {(PageControl=nil) and }(AParent is TdhPageControl) then
   PageControl:=TdhPageControl(AParent) else
//  if {(PageControl=nil) and }(AParent<>nil) and (GetParentTab(AParent,true) is TdhPage) and (TdhPage(GetParentTab(AParent,true)).PageControl<>nil) then
//   PageControl:=TdhPage(GetParentTab(AParent,true)).PageControl else
  Inherited;
  if not (csDestroying in ComponentState) then
  begin
   UpdateScrolling;
  end;
end;


procedure TdhPage.EnableMouseWheelData;
var F:TCustomForm;
begin
   //showmessage('ok1');
   if IsTopScrollable then
   begin
    F := GetParentForm(Self);
    if F <> nil then
      F.SetFocusedControl(Self);

{    if (F<>nil) and (F.ActiveControl<>nil) then
     showmessage('ok foc '+F.ActiveControl.Name) else
    if (F<>nil) then
     showmessage('ok not foc') else
     showmessage('ok not form');}
  end;
end;



function TdhPage.IsAlignStored:boolean;
begin
 if IsTopScrollable then
  result:=Align<>alClient else
  result:=Align<>alNone;

// result:=not IsTopBody;
end;



procedure TdhPage.Loaded;
begin
 if (PageControl<>nil) and OldFormat then
 begin
 Left:=Left+PageControl.Left;
 Top:=Top+PageControl.Top;
 end;
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

{function TdhPage.GetParentComponent: TComponent;
begin
 if PageControl<>nil then
  result:=PageControl else
  result:=Parent;;
end;}

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
 result:=(Inherited SomethingIsScrolled) or (csDesigning in ComponentState) and (FGridDisplay<>gdNone);
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


function TdhPage.IsPHP:boolean;

function FindPHP(p:TWinControl; ori:TdhPage):boolean;
var i:integer;
    page:TdhPage;
begin
 if p is TdhCustomPanel then
 begin
  if ContainsPHPTag(TdhCustomPanel(p).AllHTMLCode) then
  begin
   result:=true;
   exit;
  end;
 end;
 for i:=0 to p.ControlCount-1 do
 begin
 if (p.Controls[i] is TdhPage) then
 begin
  page:=TdhPage(p.Controls[i]);
  if page.IsHTMLBody then
    continue;
  if page.PageControl<>nil then
  if page.PageControl.IsVirtualParentOf(ori) then
  //if page.PageControl=ori.PageControl then
  begin
   if not page.IsVirtualParentOf(ori) then
   //if page<>ori then
    continue;
  end else
  if not page.IsLaterSelected then
    continue;
 end;
 if (p.Controls[i] is TWinControl) and FindPHP(TWinControl(p.Controls[i]),ori) then
 begin
  result:=true;
  exit;
 end;
 end;
 result:=false;
end;


var p:TControl;
begin
 p:=self;
 while (p<>nil) do
 begin
  if (p is TdhPage) and TdhPage(p).IsHTMLBody then
  begin
   result:=FindPHP(TdhPage(p),self);
   exit;
  end;
  p:=p.Parent;
 end;
 result:=false;
end;

function TdhPage.IsInternalHTMLBody: boolean;
begin
 result:=IsHTMLBody and IsInternalScrollable;
end;

{function TdhPage.IsTopHTMLBody:boolean;
begin
 result:=IsHTMLBody and not IsInternalHTMLBody;
end;}


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

procedure TdhPage.SetName(const Value: TComponentName);
begin
  inherited;
//  if IsBody and not IsIFrame and (Parent<>nil) and (Align=alClient) then
//   Parent.Name:=Name;
end;

function TdhPage.IsOutputDirectoryStored: Boolean;
begin
 result:=GetOutputDirectory<>GetDefaultOutputDirectory;
end;

function TdhPage.GetDefaultOutputDirectory:string;
var p:TControl;
begin
// if Parent is TCustomForm then
 p:=Parent;
 while (p<>nil) and not (p is TdhPage) do
  p:=p.Parent;
 if p is TdhPage then
  result:=TdhPage(p).GetOutputDirectory else
  result:='DFM2HTML_'+Name+PathDelim;
end;

function GoodLocalPath(const path:string):string;
begin        
 result:=path;
 if (result<>'') and not (result[length(result)] in ['/','\']) then
  result:=result+PathDelim;
 result:=GoodPathDelimiters(result);
end;

function GoodPathDelimiters(const path:string):string;
begin
 result:=path;
 result:=AnsiSubstText('/',PathDelim,result);
 result:=AnsiSubstText('\',PathDelim,result);
end;

function GoodWebPathDelimiters(const path:string):string;
begin
 result:=AnsiSubstText('\','/',path);
end;

procedure TdhPage.SetOutputDirectory(const Value: string);
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

function TdhPage.GetOutputDirectory: string;
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

{function TdhPageControl.GetHTMLImplementation: THTMLImplementation;
begin
 if FDynamicNavigation then
  result:=hiScript else
  result:=hiEmbedded;
end; }

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
var i:integer;
    p:TdhPage;
begin
 {if ActivatedBy is TdhLink then
 begin
  p:=TdhLink(ActivatedBy).LinkTab;
  i:=p.FDownForURLAnchors.IndexOf(ActivatedBy);
  if i<>p.FDownForURLAnchors.Count-1 then
  begin
   p.FDownForURLAnchors.Delete(i);
   p.FDownForURLAnchors.Add(ActivatedBy);
  end;
 end;
 PageControl.ActivePage:=Self;  }
 PageControl.Activate(Self,ActivatedBy);
end;

function TdhPage.InLinkedRange(link:TControl):boolean;
var i,i2:integer;
begin
  i:=FPageControl.FPages.IndexOf(FPageControl.GetTop);
  i2:=FPageControl.FPages.IndexOf(Self);
  result:=(i>=i2) and (i<=i2+Abs(TdhLink(link).PageRange));
end;


function TdhPage.AllowDownIfURL(c:TControl): boolean;
begin
 if (FPageControl<>nil) and (FPageControl.GetTop<>nil) and (c is TdhLink) and (FPageControl.FDownForURLAnchors.Count<>0) and
    (FPageControl.FDynamicNavigation and (FPageControl.FDownForURLAnchors.Last=c) or not FPageControl.FDynamicNavigation and (FPageControl.FDownForURLAnchors.IndexOf(c)>=0) and (TdhLink(c).PageRange=0)) then
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
 result:=FHTMLTop+FHTMLHead+FHTMLBody;
end;

(*
function TdhPage.GetClientAdjusting: TRect;
begin
 result:=ScrollArea_Edges;
 exit;
 if self.IsScrollable then
 begin
  //result:=PhysicalClientEdgesWithScrollbars;

  if true or IsHTMLBody then
   result:=Rect(0,0,0,0) else
   result:=inherited GetClientAdjusting;
  {if FCommon.IsHorzScrollBarVisible then
   result.Bottom:=16;
  if {not IsIFrame or  }{FCommon.IsVertScrollBarVisible then
   result.Right:=16;*}

  with FCommon.ScrollEdgesPure do
  begin
   Result.Right:=Left+Right;
   Result.Bottom:=Top+Bottom;
  end;

  //result.BottomRight:=FCommon.ScrollEdgesPure.BottomRight;
 end else
  result:=inherited GetClientAdjusting;
end;*)

function TdhPageControl.EffectsAllowed: boolean;
begin
 result:=false;
end;

procedure TdhPage.SetFTPURL(const Value: string);
begin
 if FPublishURL<>Value then
 begin
  FPublishURL := Value;
  //Uploaded.Clear;
 end;
end;

{procedure TdhPage.SetPublishURL(const Value: string);
begin
  FPublishURL := Value;
end;
 }

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
   if csLoading in ComponentState then
   begin
   if csLoading in ComponentState then
   exit;
   end;
   FVertScrollbarAlwaysVisible:=IsScrollable and (FScrolling=scYes) or IsTopScrollable;
   FHorzScrollbarAlwaysVisible:=IsScrollable and (FScrolling=scYes) and not IsHTMLBody;
   FVertScrollbarNeverVisible:=IsScrollable and (FScrolling=scNo);
   FHorzScrollbarNeverVisible:=IsScrollable and (FScrolling=scNo);
   EdgesInScrolledArea:=IsHTMLBody;
   IsScrollArea:=IsScrollable;
   if changed then
    ScrollingParametersChanged;
   {if IsTopScrollable then
   begin
    Align:=alClient;
   end;}
   if PageControl=nil then
    Visible:=true;  //!!
   EnableMouseWheelData;
end;



function TdhPage.AlwaysVisibleVisibility:boolean;
begin
 result:=IsHTMLBody;
end;

function TdhPage.GetImageDir:String;
begin
 result:=FinalGeneratedImageFolder(GeneratedImageFolder);
end;

function FinalGeneratedJavaScriptFile(const GeneratedJavaScriptFile:String):String;
begin
 if GeneratedJavaScriptFile='' then
  result:='dfm2html.js' else
  begin
   result:=GeneratedJavaScriptFile;
   if System.Pos('.js',LowerCase(result))=0 then
    result:=result+'.js';
  end;
 result:=GoodWebPathDelimiters(result);
end;

function FinalGeneratedImageFolder(const GeneratedImageFolder:String):String;
begin
 result:=GeneratedImageFolder;
 if result='' then
  result:='.';
 result:=GoodLocalPath(result);
 result:=GoodWebPathDelimiters(result);
end;

function FinalGeneratedCSSFile(const GeneratedCSSFile:String):String;
begin
 if GeneratedCSSFile='' then
  result:='' else
  begin
   result:=GeneratedCSSFile;
   if System.Pos('.css',LowerCase(result))=0 then
    result:=result+'.css';
  end;                      
 result:=GoodWebPathDelimiters(result);
end;




initialization
// RegisterClasses([TdhPage]);

finalization

 FreeAndNil(PageControlBitmap);


end.
