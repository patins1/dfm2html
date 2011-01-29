{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O-,P+,Q+,R+,S-,T-,U-,V+,W+,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}

unit MySiz;

interface

uses
 SysUtils, Classes, TypInfo, types,
{$IFDEF CLX}
  QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls, QComCtrls,  QStdCtrls, QClipbrd, QMenus,
{$ELSE}
  Windows,Forms, Controls, Messages, Graphics, Dialogs, ExtCtrls, clipbrd,
  ComCtrls, CommCtrl, StdCtrls, ShellAPI, pngimage, Menus,
{$ENDIF}
  math,hComboBox,dhSelect,
  funcutils, Contnrs, UseFastStrings,
  dhMenu,dhLabel,dhPanel,dhHTMLForm,dhPageControl,
  dhStyleSheet, dhFile,
  dhRadioButton,dhCheckBox, dhMemo,dhEdit,
  dhFileField,dhOleContainer,dhHiddenField,dhDirectHTML,Generics.Defaults,Generics.Collections,uFind,gr32,UIConstants,dhStyles;

type
  TDragStyle = (dsMove, dsSizeTopLeft, dsSizeTopRight, dsSizeBottomLeft, dsSizeBottomRight,
                dsSizeTop, dsSizeLeft, dsSizeBottom, dsSizeRight);

                        
const AllowBodyOnly=True;

type
  TMyHintWindow=class(THintWindow)
  public
    property Caption;
  end;
  TSelectionList=class(TList)
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  end;
  TMySiz = class(TdhCustomPanel)
  private
    { Private declarations }
    //SavedSel:TStringList;
    Changed:boolean;
    FChildList: TSelectionList;
    FDragStyle: TDragStyle;
    FDragOffset: TPoint;
    ClipSizing:TRect;
    FDragging: boolean;
    pret:boolean;

    DeletionList:TList;
    FHintWindow:TMyHintWindow;
    FHintTimer:TTimer;
    HintStr:string;
    procedure Attach(ChildControl: TControl);
    procedure Detach(ChildControl: TControl);
    class function XGridAdjust(const GridBase:TPoint; X: integer): integer;
    class function YGridAdjust(const GridBase:TPoint; Y: integer): integer;
    class function GridAdjust(const GridBase:TPoint; Pt: TPoint): TPoint;
    function AllowedBox: TDragStyle;
    procedure OneParentSelection;
    function EmptySelection: boolean;
    function GetGoodMouse: TPoint;
    function GetSelRect(MouseCursorPos: TPoint): TRect;
    class function ZGridAdjust(GridBase, Y, FGrid: integer): integer;
    procedure AddToDeletion(Child: TComponent);
    procedure FlushSelection;

    procedure UpdateHintWindow;
    procedure KillHint;
    function ActHintStr: boolean;

    procedure PaintHandles(MouseCursorPos:TPoint; ACanvas:TCanvas=nil);
    procedure NeedPaint;

    procedure DoTopPainting; override;
    function AdjustZIndex(ChildPos,ParentControlCount:integer):integer; override;
    function AcceptClick(P:TPoint):boolean; override;

    procedure StopDragging;
    procedure StartDragging(cw:TControl=nil);
    function GetModifiedRect(c:TControl; const p:TPoint): TRect;
    function WhatDragStyle(canedit:boolean; HitPos:TPoint):boolean;
    function GetBox(const Base: TPoint; const pbounds:TRect; c:TControl; ds:TDragStyle): TRect;
    function GetBase(c: TControl): TPoint;
    procedure AssignCursor;
    function GetRealC(const pt: TPoint): TControl;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WriteState(Writer: TWriter); override;

//    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;

    //procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;

{$IFDEF CLX}
    procedure DrawMask(Canvas: TCanvas); override;
    procedure InitWidget; override;
{$ENDIF}

    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    //procedure AddToOrderList(Child: TComponent);


  public
    { Public declarations }
    procedure ChildrenDisableAlign;
    procedure ChildrenEnableAlign;
    procedure StopPositioning;
    procedure ObjectAdded(c: TControl);

    procedure DesignMouseMove;
    function DesignMouseDown(Button: TMouseButton; Shift: TShiftState):boolean;
    procedure DesignMouseUp(Button: TMouseButton);

    procedure ShiftIntoView;
    procedure AddComp(p: TWinControl; ARect:TRect);
    procedure Select(All, Below: boolean);
    procedure Find(FindNext:boolean);
    function FindBody: TdhPage;
    class function GetAlignedBounds(c: TControl): TRect;
    procedure SelCheckDesignState;
    property IsDragging:boolean read FDragging;
    procedure DoInval(Before: boolean=false);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddSel(sl: TList);
    function GetPasteParent: TWinControl;
    procedure CopyComponents(CopyDependencies:boolean; _WithMeta:boolean=false);
    procedure DeleteComponents;
    procedure SetControlTo(c: TControl; Att: boolean; All:boolean=false);
    procedure ClearSelection;
    procedure DoKeyDown(Key: Word; Shift: TShiftState);
    procedure DoKeyUp(Key: Word; Shift: TShiftState);
    //property Selection:TList read FChildList;
    function GetSelectionIDs: TStringList;
    procedure AddSelectionByIDs(sl: TStringList);
    procedure AddSelectionByID(const id:TComponentName);
    function IsSelected(Control:TControl):boolean;
    function HasSelectedComponents:boolean;
    function HasOneSelectedComponent:boolean;
  published
    { Published declarations }
    property Align;
    property Anchors;
  end;

function GetShiftState: TShiftState;

var gActDown:TControl=nil;

var glPreferMousePosition:boolean=false;

type PComponentState=^TComponentState;

function EditableControl(c:TControl; NeedName:boolean): boolean;
function PrepareCopyList(CopyDependencies:boolean; FChildList:TList):TList;

function GetCopyComponentsStream(Root: TComponent; const Components: TList):TMemoryStream;
//procedure glAddSheet(pc:TdhPageControl);


//var IsAlt:boolean;

type TMyList=class(TList)
    procedure AddDirectChildren(Parent: TComponent);   
    procedure AddChild(Child: TComponent);
    procedure AddChildren(Child: TComponent);
    procedure TopDeleteChildren(Child: TComponent);
    procedure DeleteChildren(Child: TComponent);
end;

var PreventFocus:Boolean=false;

procedure Register;

implementation

uses Unit1,Unit2, Unit3;

var glPreventScrollInView:boolean=False;

const InvalOld=-43233;

const DragStyleCursor:array[TDragStyle] of TCursor =
(crArrow, crSizeNWSE, crSizeNESW, crSizeNESW, crSizeNWSE,
                crSizeNS, crSizeWE, crSizeNS, crSizeWE);



procedure Register;
begin
//  RegisterComponents('Standard', [TMySiz]);
end;


function GoodParent(c:TControl):TWinControl;
begin
  while not(c is TWinControl) or not (csAcceptsControls in c.ControlStyle) do
   c:=c.Parent;
  result:=c as TWinControl;
end;

           
{$IFDEF CLX}
//ClxEditors.pas
procedure CopyStreamToClipboard(S: TStream);
var
  T: TStringStream;
  I: TValueType;
  V: Integer;
begin
//  Clipboard.Open;
//  try
    //Clipboard.SetFormat(SDelphiComponent, S);
    S.Position := 0;
    T := TStringStream.Create('');
    try
      repeat
        S.Read(I, SizeOf(I));
        S.Seek(-SizeOf(I), 1);
        if I = vaNull then Break;
        ObjectBinaryToText(S, T);
      until False;
      V := 0;
      T.Write(V, 1);
      Clipboard.AsText := T.DataString;
    finally
      T.Free;
    end;
//  finally
//    Clipboard.Close;
//  end;
end;

{$ELSE}

//VCLEditors.pas
procedure CopyStreamToClipboard(S: TMemoryStream);
var
  T: TMemoryStream;
  I: TValueType;
  V: Integer;

  procedure CopyToClipboard(Format: Word; S: TMemoryStream);
  var
    Handle: THandle;
    Mem: Pointer;
  begin
    Handle := GlobalAlloc(GMEM_MOVEABLE, S.Size);
    Mem := GlobalLock(Handle);
    Move(S.Memory^, Mem^, S.Size);
    GlobalUnlock(Handle);
    Clipboard.SetAsHandle(Format, Handle);
  end;

begin
  Clipboard.Open;
  try
    CopyToClipboard(CF_COMPONENTS, S);
    S.Position := 0;
    T := TMemoryStream.Create;
    try
      repeat
        S.Read(I, SizeOf(I));
        S.Seek(-SizeOf(I), 1);
        if I = vaNull then Break;
        ObjectBinaryToText(S, T);
      until False;
      V := 0;
      T.Write(V, 1);
      CopyToClipboard(CF_TEXT, T);
    finally
      T.Free;
    end;
  finally
    Clipboard.Close;
  end;
end;
{$ENDIF}



procedure _CopyComponents(Root: TComponent;
  const Components: TList);
var
  S: TMemoryStream;
begin
  S := GetCopyComponentsStream(Root,Components);
  try
    CopyStreamToClipboard(S);
  finally
   S.Free;
  end;
end;

function GetCopyComponentsStream(Root: TComponent;
  const Components: TList):TMemoryStream;
var
  S: TMemoryStream;
  W: TWriter;
  I: Integer;
begin
  S := TMemoryStream.Create;         
  try
    IsCopying:=true;
    try
      W := TWriter.Create(S, 1024);
      try
        W.Root := Root;
        for I := 0 to Components.Count - 1 do
        if Components[I]<>nil then
        begin
          {if (TComponent(Components[I]) is TdhPage) and (Components.IndexOf(TdhPage(Components[I]).PageControl)<>-1) then
           Continue;}
          W.WriteSignature;
          W.WriteComponent(TComponent(Components[I]));
        end;
        W.WriteListEnd;
      finally
        W.Free;
      end;
    finally
      IsCopying:=false;
    end;
  finally
   //S.Free;
  end;
  Result:=S;
  Result.Seek(0,soFromBeginning);
end;


procedure NormalizeRect(var ARect:TRect);
begin
  if ARect.Left>ARect.Right then
   Exch(ARect.Right,ARect.Left);
  if ARect.Top>ARect.Bottom then
   Exch(ARect.Bottom,ARect.Top);
end;


procedure IncPt(var pt:TPoint; const decr:TPoint);
begin
 inc(pt.X,decr.X);
 inc(pt.Y,decr.Y);
end;

procedure IntersectPt(var Pt:TPoint; rct:TRect);
begin
 if Pt.X<rct.Left then pt.X:=rct.Left;
 if Pt.X>rct.Right then pt.X:=rct.Right;
 if Pt.Y<rct.Top then pt.Y:=rct.Top;
 if Pt.Y>rct.Bottom then pt.Y:=rct.Bottom;
end;
           {
procedure OffsetRect(var);
begin

end;
             }

function GetCBoundClient(c:TControl):TRect;
begin
 {if c is TWinControl then
 begin
  Windows.GetClientRect(TWinControl(c).Handle, result);
  rOffsetRect(result,c.ClientOrigin);
 end else
  result:=GetCBound(c); }
 result:=GetPhysicalScreenClientBound(c);
end;


function GetPBound(c:TControl):TRect;
begin
 result:=GetCBoundClient(c.Parent);
end;

function GetPClip(c:TControl):TRect;
var p:TWinControl;
begin                                 
 result:=Rect(0,0,maxint,maxint);
 p:=c.Parent;
 while (p<>nil) do
 begin
  IntersectRect(result,result,GetCBoundClient(p));
  p:=p.Parent;
 end;
end;

function GetShiftState: TShiftState;
begin
  Result := [];
{$IFNDEF CLX}
  if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
  if GetKeyState(VK_MENU) < 0 then Include(Result, ssAlt);
{$ELSE}
  Result := Application.KeyState;
{$ENDIF}
end;



{function ShiftPressed(ss:TShiftState):boolean;
begin

end;}


{
function KeyPressed(VK:DWORD):boolean;
begin
 result:=HiWord(DWORD(GetKeyState(VK))) <> 0;
end;     }

procedure TMySiz.AddSel(sl:TList);
var i:integer;
begin
 for i:=0 to FChildList.Count-1 do
  sl.Add(FChildList[i]);
end;



constructor TMySiz.Create(AOwner: TComponent);
begin
 inherited;
 FChildList:=TSelectionList.Create;
 Align:=alClient;
 ControlStyle := ControlStyle+[csCaptureMouse]-[csAcceptsControls];
end;

function TMySiz.GetGoodMouse:TPoint;
begin
 result:=Mouse.CursorPos;
{ if FDragging and (FDragStyle<>dsMove) then
   IntersectPt(result,ClipSizing);
   }
end;

procedure TMySiz.DoTopPainting;
begin
// inherited;
 PaintHandles(GetGoodMouse);
{$IFDEF CLX}
 MaskChanged;
{$ENDIF}  
end;
                                
function TMySiz.AdjustZIndex(ChildPos,ParentControlCount:integer):integer;
begin
 result:=maxint;
end;

procedure TMySiz.Attach(ChildControl: TControl);
var i:integer;
begin
 i:=FChildList.IndexOf(ChildControl);
 if i<>-1 then
 begin
  FChildList.Move(i,0);
  exit;
 end;
 if ChildControl<>nil then
  FChildList.Add(ChildControl);
end;

procedure TMySiz.Detach(ChildControl: TControl);
var cc:TControl;
begin
 if ChildControl=nil then
  FChildList.Clear else
  FChildList.Delete(FChildList.IndexOf(ChildControl));
end;

function InClip(x,Left,Right:integer):integer;
begin        
 if x<Left then
  x:=Left else
 if x>Right then
  x:=Right;
 result:=x;
end;



function GetGridBase(p:TControl; IsSelf:boolean):TPoint;
begin
 if IsSelf then
  result:=GetCBound(p).TopLeft else
  result:=GetCBoundClient(p).TopLeft;
  if not IsSelf then
  if p is TdhCustomPanel then
   with TdhCustomPanel(p) do IncPt(result,Point(-HorzPosition,-VertPosition));
end;


class function TMySiz.GetAlignedBounds(c:TControl):TRect;
var
  ARect: TRect;
  GridBase:TPoint;
begin
  ARect:=GetCBound(c);
  GridBase:=GetGridBase(c.Parent,false);
  ARect.Top := YGridAdjust(GridBase,ARect.Top);
  ARect.Left := XGridAdjust(GridBase,ARect.Left);
  DecPt(ARect.TopLeft,GetPBound(c).TopLeft);
  ARect.BottomRight:=Point(ARect.Left+c.Width,ARect.Top+c.Height);
  result:=ARect;
end;




function TMySiz.GetModifiedRect(c:TControl; const p:TPoint):TRect;
var
  ARect: TRect;
  GridBase:TPoint;
begin

{  ARect.TopLeft:=c.ClientOrigin;
  ARect.BottomRight:=Point(ARect.Left+c.Width,ARect.Top+c.Height);
 }

  ARect:=GetCBound(c);
  GridBase:=GetGridBase(c{.Parent},true);//ARect.TopLeft;
  if FDragStyle=dsMove then
  begin
   {ARect.Top := YGridAdjust(GridBase,ARect.Top+p.Y-FDragOffset.Y);
   ARect.Left := XGridAdjust(GridBase,ARect.Left+p.X-FDragOffset.X);
   }
   ARect.Top := YGridAdjust(GridBase,ARect.Top+p.Y-FDragOffset.Y);
   ARect.Left := XGridAdjust(GridBase,ARect.Left+p.X-FDragOffset.X);
   ARect.BottomRight:=Point(ARect.Left+c.Width,ARect.Top+c.Height);
  end else
  begin

  if FDragStyle in [dsMove,dsSizeTopLeft,dsSizeTopRight,dsSizeTop] then
  begin
        ARect.Top := InClip(YGridAdjust(GridBase,p.Y),ClipSizing.Top,ClipSizing.Bottom);
  end;
  if FDragStyle in [dsMove,dsSizeTopLeft,dsSizeBottomLeft,dsSizeLeft] then
  begin
        ARect.Left := InClip(XGridAdjust(GridBase,p.X),ClipSizing.Left,ClipSizing.Right);
  end;
  if FDragStyle in [dsSizeTopRight,dsSizeBottomRight,dsSizeRight] then
  begin
        ARect.Right := InClip(XGridAdjust(GridBase,p.X),ClipSizing.Left,ClipSizing.Right);
  end;
  if FDragStyle in [dsSizeBottomLeft,dsSizeBottomRight,dsSizeBottom] then
  begin
        ARect.Bottom := InClip(YGridAdjust(GridBase,p.Y),ClipSizing.Top,ClipSizing.Bottom);
  end;

  end;
                 {
  orct.TopLeft:=po;
  orct.BottomRight:=Point(c.Parent.Width,c.Parent.Height);
  IncPt(orct.BottomRight,orct.TopLeft);
  IntersectRect(ARect,ARect,orct); }

  NormalizeRect(ARect);
                                          {
  if FDragging and (FDragStyle<>dsMove) then
   IntersectRect(ARect,ARect,ClipSizing2);  }

  DecPt(ARect.BottomRight,ARect.TopLeft);
  Result := ARect;
end;




function TMySiz.GetRealC(const pt: TPoint):TControl;
begin
 result:=iControlAtPos(TWinControl(Owner),pt);
end;


function TMySiz.AcceptClick(P:TPoint):boolean;
begin
 if pret then
  result:=true else
 result:=WhatDragStyle(false,ClientToScreen(P));
 //result:=inherited AcceptClick(P);
 //result:=false; //xor-zeichnen schadet ExtractAlphaColor
end;


{$IFDEF CLX}
procedure TMySiz.DrawMask(Canvas: TCanvas);
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clMask;
  Canvas.FillRect(ClientRect);
  Canvas.Brush.Color := clDontMask;
  PaintHandles(GetGoodMouse,Canvas);
end;

procedure TMySiz.InitWidget;
begin
  inherited;
  Masked:=true;
  //ComponentState:=ComponentState+[csDesigning];
end;

{$ENDIF}





function TMySiz.WhatDragStyle(canedit:boolean; HitPos:TPoint):boolean;
var i:integer;
    Base:TPoint;
    ds:TDragStyle;
    pbound:TRect;
var AControl:TControl;

begin
 result:=false;
 if canedit then
  FDragStyle := dsMove;
 //p:=Mouse.CursorPos;

 if FChildList.Count=1 then
 begin
  AControl:=TControl(FChildList[0]);

          Base:=GetBase(AControl);
          pbound:=GetPClip(AControl);

          for ds:=dsSizeTopLeft to AllowedBox do
          if PtInRect(GetBox(Base,pbound,AControl,ds),HitPos) then
          begin
           if canedit then
            FDragStyle := ds;
           result:=true;
           break;
          end;
  end;         
  if canedit then                                       
{$IFDEF CLX}
 QWidget_setCursor(Handle, Screen.Cursors[DragStyleCursor[FDragStyle]]);
{$ELSE}
 Windows.SetCursor(Screen.Cursors[DragStyleCursor[FDragStyle]]); 
{$ENDIF}
{  if canedit then
   AssignCursor else
   Screen.Cursor:=crDefault;}
end;

procedure TMySiz.AssignCursor;
begin
 Cursor:=DragStyleCursor[FDragStyle];
 Screen.Cursor:=DragStyleCursor[FDragStyle];
// Windows.SetCursor(Screen.Cursors[Screen.Cursor]);
// form1.label1.caption:=inttostr(integer(Screen.Cursor));
// Application.ProcessMessages;
end;



procedure TMySiz.StartDragging(cw:TControl=nil);
begin
 assert(not FDragging);
 Tabs.CommitChanges;
 FDragOffset := Mouse.CursorPos;
 if cw<>nil then
  ClipSizing:=GetCBound(cw);
 FDragging:=True;
 ActHintStr;
 NeedPaint;
 dhMainForm.Update;
{$IFNDEF CLX}//für CLX funzt noch net
 Self.MouseCapture:=true;
{$ENDIF}
end;


function EditableControl(c:TControl; NeedName:boolean): boolean;
begin
 result:=(c<>nil) and not (c is TCustomForm){ and not (c is TMySiz)} and (csDesigning in c.ComponentState) and (not NeedName or (c.Name<>''));
end;


function TMySiz.GetBase(c:TControl):TPoint;
var R:TRect;
begin
 result:=GetCBound(c).TopLeft;
end;

function IsFinalShowing(c:TControl):boolean;
begin
 result:=(c is TWinControl) and TWinControl(c).Showing or
         (c is TdhCustomPanel) and TdhCustomPanel(c).FinalShowing or
         not (c is TWinControl) and (c.Parent<>nil) and IsFinalShowing(c.Parent);
end;

const half=2;


function TMySiz.GetBox(const Base:TPoint; const pbounds:TRect; c:TControl; ds:TDragStyle):TRect;
var offs_y,offs_x:integer;
begin
 if not IsFinalShowing(c) then
 begin
  result:=Rect(0,0,0,0);
  exit;
 end;
 case ds of
 dsSizeTopRight, dsSizeBottomRight, dsSizeRight: offs_x:=c.Width-1;
 dsSizeTop, dsSizeBottom: offs_x:=(c.Width-1) div 2;
 else offs_x:=0;
 end;
 case ds of
 dsSizeBottomLeft, dsSizeBottomRight, dsSizeBottom: offs_y:=c.Height-1;
 dsSizeLeft, dsSizeRight: offs_y:=(c.Height-1) div 2;
 else offs_y:=0;
 end;
 result.Top:=Base.Y+offs_y-half;
 result.Bottom:=Base.Y+offs_y+(half+1);
 result.Left:=Base.X+offs_x-half;
 result.Right:=Base.X+offs_x+(half+1);
 IntersectRect(result,result,pbounds);
end;

function TMySiz.AllowedBox:TDragStyle;
begin
 if FChildList.Count=1 then
  result:=dsSizeRight else
  result:=dsSizeBottomRight;
end;

function TMySiz.EmptySelection:boolean;
begin
 result:=FChildList.Count=0;
end;


function TMySiz.GetSelRect(MouseCursorPos:TPoint):TRect;
var GridBase:TPoint;
begin
       MouseCursorPos:=Point(InClip(MouseCursorPos.X,ClipSizing.Left,ClipSizing.Right),InClip(MouseCursorPos.Y,ClipSizing.Top,ClipSizing.Bottom));
       Result.TopLeft:=FDragOffset;
       Result.BottomRight:=MouseCursorPos;
       NormalizeRect(result);
       if gActDown<>nil then
       begin
        GridBase:=GetGridBase(GoodParent(GetRealC(FDragOffset)),false);
        Result.TopLeft:=GridAdjust(GridBase,Result.TopLeft);
        Result.BottomRight:=GridAdjust(GridBase,Result.BottomRight);
       end;               
       DecPt(Result.BottomRight,Result.TopLeft);
end;


function IsBlackArea(c:TCanvas; const r:TRect):Single;
var x,y,blacks,F:integer;
    H,S,L,AllLightness:Single;
begin
 AllLightness:=0;
 for x:=r.Left to r.Right-1 do
 for y:=r.Top to r.Bottom-1 do
 begin
  RGBtoHSL(Color32(c.Pixels[x,y]),H,S,L);
  AllLightness:=AllLightness+L;
  {if (c.Pixels[x,y] and $FFFFFF)=$000000 then
  begin
   inc(blacks);
  end;}
 end;
 {F:=((r.Right-r.Left)*(r.Bottom-r.Top));
 if F<>0 then
  result:=blacks/F else
  result:=0;  }
 result:=AllLightness;
end;

procedure TMySiz.PaintHandles;
var i: integer;
    c: TWinControl;
    AControl:TControl;
    Base:TPoint;
    ds:TDragStyle;
    pbound:TRect;
    rct,r:TRect;
    p:TPoint;
    Canvas:TCanvas;
    F:integer;
    AllLightness:Single;
begin

 Canvas:=ACanvas;

 if ACanvas=nil then
  Canvas:=GetCanvas;



 if FDragging then
 begin
      with Canvas.Brush do begin
         Style := bsClear;
      end;
      with Canvas.Pen do begin
         if ACanvas=nil then
          Color :=$a0a0a0;//clBlack;
         Style := psSolid;
         Mode := pmMaskPenNot{or pmXor};//pmNot;
         Width := 2;
      end;
      if EmptySelection then
      begin
       if (gActDown=nil) then
       with Canvas.Pen do begin
          Style := psDot;
          if ACanvas=nil then
           Mode := pmNot;
          Width := 1;
       end;
       rct:=GetSelRect(MouseCursorPos);
       DecPt(rct.TopLeft,ClientOrigin);
       Canvas.Rectangle(rct.Left,rct.Top,rct.Left+rct.Right,rct.Top+rct.Bottom);
      end else
      for i := 0 to FChildList.Count - 1 do
      begin
          AControl := TControl(FChildList.Items[i]);
          rct:=GetModifiedRect(AControl,MouseCursorPos);
          DecPt(rct.TopLeft,ClientOrigin);
          DecPt(rct.TopLeft,Point(-Canvas.Pen.Width div 2,-Canvas.Pen.Width div 2));
          DecPt(rct.BottomRight,Point(Canvas.Pen.Width-1,Canvas.Pen.Width-1));
          Canvas.Rectangle(rct.Left,rct.Top,rct.Left+rct.Right,rct.Top+rct.Bottom);
      end;
 end else
 begin

      Canvas.Brush.Style:=bsSolid;
      if ACanvas=nil then
       Canvas.Brush.Color:=clBlack;

      with Canvas.Pen do begin
         if ACanvas=nil then
          Color := clBlack;
         Style := psSolid;
         Mode := pmCopy;
         Width := 2;
      end;

     { if ACanvas=nil then
      if FChildList.Count = 1 then
        Canvas.Brush.Color := clBlack else
        Canvas.Brush.Color := clGray; }
      p:=ClientOrigin;
      for i := 0 to FChildList.Count - 1 do
      begin
          AControl := TControl(FChildList.Items[i]);
          if AControl.Parent=nil then continue;
          Base:=GetBase(AControl);
          pbound:=GetPClip(AControl);
          DecPt(Base,p);
          DecPt(pbound.TopLeft,p);
          DecPt(pbound.BottomRight,p);

          if ACanvas=nil then
          begin
           if (FChildList.Count<>1) then
            Canvas.Brush.Color := clGray else
           begin
            AllLightness:=0;
            F:=0;
            for ds:=dsSizeTopLeft to AllowedBox do
            begin
             r:=GetBox(Base,pbound,AControl,ds);
             //inc(Blacks,IsBlackArea(Canvas,r));
             AllLightness:=AllLightness+IsBlackArea(Canvas,r);
             inc(F,(r.Right-r.Left)*(r.Bottom-r.Top));
            end;
            if (F<>0) and (AllLightness/F<=0.20) then
             Canvas.Brush.Color := clGray else
             Canvas.Brush.Color := clBlack;
           end;
          end;


          for ds:=dsSizeTopLeft to AllowedBox do
          begin
           r:=GetBox(Base,pbound,AControl,ds);
           {if (FChildList.Count<>1) then
            Canvas.Brush.Color := clGray else
           if IsBlackArea(Canvas,r)>=0.4 then
            Canvas.Brush.Color := clGray else
            Canvas.Brush.Color := clBlack;}
           Canvas.FillRect(r);
          end;
      end;
 end;

end;
{
procedure TMySiz.WMSetCursor(var Message: TWMSetCursor);
begin
  with Message do
    if CursorWnd = TWinControl(Self).Handle then
      case Smallint(HitTest) of
        HTCLIENT:
          begin
            if DragStyleCursor[FDragStyle] <> crDefault then
            begin
              Windows.SetCursor(Screen.Cursors[DragStyleCursor[FDragStyle]]);
              Result := 1;
              Exit;
            end;
          end;
      end;
end;
}

procedure TMySiz.NeedPaint;
begin
 NotifyCSSChanged([]);
 UpdateHintWindow;
end;


class function TMySiz.ZGridAdjust(GridBase,Y,FGrid:integer): integer;
begin
 if {KeyPressed(VK_MENU)}{IsAlt}ssAlt in GetShiftState then
  FGrid:=1;
 result:=Y - GridBase + FGrid div 2;
 if result<0 then
  dec(result,FGrid);
 Result := (result div FGrid) * FGrid + GridBase;
end;

class function TMySiz.XGridAdjust(const GridBase:TPoint; X: integer): integer;
begin
 with GridDefinition do Result :=ZGridAdjust(GridBase.X,X,GridX);
end;

class function TMySiz.YGridAdjust(const GridBase:TPoint; Y: integer): integer;
begin
 with GridDefinition do Result :=ZGridAdjust(GridBase.Y,Y,GridY);
end;


procedure TMySiz.AddComp(p:TWinControl; ARect:TRect);
var c:TControl;
begin
  DecPt(ARect.TopLeft,GetCBoundClient(p).TopLeft);
  c:=nil;
  try
  if gActDown=dhMainForm.compText then
  begin
   c:=TdhLabel.Create(Owner);
   c.Name:=_GetUniqueName(c,'Label');
  end;
  if gActDown=dhMainForm.compAnchor then
  begin
   c:=TdhLink.Create(Owner);
   c.Name:=_GetUniqueName(c,'Link');
  end;
  if gActDown=dhMainForm.compDirectHTML then
  begin
   c:=TdhDirectHTML.Create(Owner);
   c.Name:=_GetUniqueName(c,'DirectHTML');
  end;
  if gActDown=dhMainForm.compImg then
  begin
   c:=TdhLink.Create(Owner);
   TdhLink(c).ImageType:=bitImage;
   c.Name:=_GetUniqueName(c,'Image');
   TdhLink(c).Text:='';
   if Tabs.OpenPictureDialog1.Execute then
    TdhLink(c).ActStyle.LoadImage(Tabs.OpenPictureDialog1.FileName);
  end;
  if gActDown=dhMainForm.compOle then
  begin
   c:=TdhOleContainer.Create(Owner);
   c.Name:=_GetUniqueName(c,'OleContainer');
  end;
  if gActDown=dhMainForm.compFile then
  begin
   c:=TdhFile.Create(Owner);
   c.Name:=_GetUniqueName(c,'File');
   Tabs.InitialLoadFile(TdhFile(c));
  end;
  if gActDown=dhMainForm.compPanel then
  begin
   c:=TdhPanel.Create(Owner);
   c.Name:=_GetUniqueName(c,'Panel');
  end;
  if gActDown=dhMainForm.compMenu then
  begin
   c:=TdhMenu.Create(Owner);
   c.Name:=_GetUniqueName(c,'Menu');
  end;
  if gActDown=dhMainForm.compForm then
  case dhMainForm.compForm.ImageIndex of
  13:
  begin
   c:=TdhHTMLForm.Create(Owner);
   c.Name:=_GetUniqueName(c,'Form');
  end;
  7:
  begin
   c:=TdhRadioButton.Create(Owner);
   c.Name:=_GetUniqueName(c,'RadioButton');
  end;
  10:
  begin
   c:=TdhCheckBox.Create(Owner);
   c.Name:=_GetUniqueName(c,'CheckBox');
  end;
  4:
  begin
   c:=TdhMemo.Create(Owner);
   //TMemo(c).BorderStyle:= bsNone;
   //InitialSize:=Point(185,89);
   c.Name:=_GetUniqueName(c,'Memo');
  end;
  3:
  begin
   c:=TdhSelect.Create(Owner);
   c.Name:=_GetUniqueName(c,'Select');
   TdhSelect(c).SelectType:=stList;
  end;
  0:
  begin
   c:=TdhSelect.Create(Owner);
   c.Name:=_GetUniqueName(c,'Select');
   TdhSelect(c).SelectType:=stDropDown;
  end;
  1:
  begin
   c:=TdhEdit.Create(Owner);
   c.Name:=_GetUniqueName(c,'Edit');
   //TEdit(c).Text:=c.Name;
  end;
  15:
  begin
   c:=TdhFileField.Create(Owner);
   c.Name:=_GetUniqueName(c,'FileField');
  end;
  23:
  begin
   c:=TdhLink.Create(Owner);
   TdhLink(c).FormButtonType:=fbSubmit;
   TdhLink(c).Layout:=ltButton;
   c.Name:=_GetUniqueName(c,'Submit');
  end;
  22:
  begin
   c:=TdhLink.Create(Owner);
   TdhLink(c).FormButtonType:=fbReset;
   TdhLink(c).Layout:=ltButton;
   c.Name:=_GetUniqueName(c,'Reset');
  end;
  28:
  begin
   c:=TdhHiddenField.Create(Owner);
   c.Name:=_GetUniqueName(c,'HiddenField');
  end;
  end;
  if gActDown=dhMainForm.compStyleSheet then
  begin
   c:=TdhStyleSheet.Create(Owner);
   c.Name:=_GetUniqueName(c,'StyleSheet');
  end;
  if gActDown=dhMainForm.compPageControl then
  begin
   c:=TdhPageControl.Create(Owner);
   c.Name:=_GetUniqueName(c,'PageControl');
  end;
  if gActDown=dhMainForm.compPage then
  begin
   c:=TdhPage.Create(Owner);
   c.Name:=_GetUniqueName(c,'Page');
  end;

  finally

  //SetDesignMode(c);
  if (ARect.Right<=10) and (ARect.Bottom<=10) then
   c.SetBounds(ARect.Left,ARect.Top,c.Width,c.Height) else
   c.SetBounds(ARect.Left,ARect.Top,ARect.Right,ARect.Bottom);
  c.Parent:=p;

  if c is TdhOleContainer then
  begin        
{$IFNDEF CLX}        
   if TdhOleContainer(c).InsertObjectDialog(true) then
    TdhOleContainer(c).EditInPlace;
{$ENDIF}
  end;
   {
  if c is TWinControl then
   TWinControl(c).HandleNeeded;  }
  if gActDown=dhMainForm.compPageControl then
  begin
   TdhPageControl(c).AddSheet;
  end;
  //dhMainForm.compImgClick(nil);
  (gActDown as TToolButton).Down:=false;
  gActDown:=nil;
  ObjectAdded(c);

  end;
  //bringtofront;
end;

procedure TMySiz.ObjectAdded(c:TControl);
begin
  SetControlTo(c,true,true);
  dhMainForm.UpdateCommands(false,true);
  (Owner as TPageContainer).SetModified('Add Object',lcCommit);
end;


                       {
procedure glAddSheet(pc:TdhPageControl);
var page:TdhPage;
    WasSelected:boolean;
begin
   page:=pc.AddSheet;
   //ts.Caption:='Sheet';
   SetDesignMode(page);
end;
                     }


                   
{$IFDEF CLX}
const VK_NEXT=Key_Next;
      VK_PRIOR=Key_Prior;
      VK_MENU=Key_Menu;
      VK_CONTROL=Key_Control;
      VK_UP=Key_Up;
      VK_DOWN=Key_Down;
      VK_RIGHT=Key_Right;
      VK_LEFT=Key_Left;
      VK_HOME=Key_Home;
      VK_END=Key_End;
      
{$ENDIF}

procedure TMySiz.DoKeyUp(Key: Word; Shift: TShiftState);
begin
 if key=VK_MENU then
  NeedPaint;
 if (Key=VK_UP) or (Key=VK_DOWN) or (Key=VK_LEFT) or (Key=VK_RIGHT) then
  StopPositioning;
end;

procedure TMySiz.StopPositioning;
begin
 if Changed then
  (Owner as TPageContainer).SetModified('Position',lcCommit);
 Changed:=False;
end;






function GetNearest(s:TControl; al:TAlign; var res:TControl):boolean;
var p:TWinControl;
    c:TControl;
    L,R,i,BestDist,dist:integer;
    rs,rc:TRect;
    smid,cmid:TPoint;

function InArea(X,Y:integer):boolean;
begin
 result:=false;
 if PtInRect(rs,Point(X,Y)) then
  result:=True else
 if (Y>=rs.Bottom) then
 if (Y>=rs.Bottom+(rs.Left-X)) and (Y>=rs.Bottom+(X-rs.Right)) then
  result:=true;
end;

function GetDist(P1,P2:TPoint):integer;
begin
 result:=Sqr(P1.X-P2.X)+Sqr(P1.Y-P2.Y);
 //calculate no sqrt since only relative comparison
end;

function ConvertRect(R:TRect):TRect;
begin
 result:=R;
 if al in [alRight,alLeft] then
  with result do begin Top:=R.Left; Left:=R.Top; Right:=R.Bottom; Bottom:=R.Right; R:=result; end;
 if al in [alTop,alLeft] then
  with result do begin Top:=-R.Bottom; Bottom:=-R.Top; R:=result; end;
{ case al of
 alTop: begin Top:=-Top; Bottom:=-Bottom; end;
 alRight: begin Top:=R.Left; Left:=R.Top; Right:=R.Bottom; Bottom:=R.Right; end;
 alLeft:  begin Top:=R.Left; Left:=R.Top; Right:=R.Bottom; Bottom:=R.Right; Top:=-Top; Bottom:=-Bottom; end;
 end;}
end;


begin
 result:=false;
 p:=s.Parent;
 rs:=ConvertRect(s.BoundsRect);
 smid:=Point((rs.Right-rs.Left) div 2,rs.Bottom);
 BestDist:=maxint;
 for i:=0 to p.ControlCount-1 do
 begin
  c:=p.Controls[i];
  if (c=s) or not FinalVisible(c) then continue;
  rc:=ConvertRect(c.BoundsRect);
  if rc.Top<rs.Top then continue;
  if rc.Top<=rs.Bottom then
  begin
   L:=rs.Left;
   R:=rs.Right;
  end else
  begin
   L:=rs.Left-(rc.Top-rs.Bottom);
   R:=rs.Right+(rc.Top-rs.Bottom);
  end;
  {if InArea(rc.Right,rc.Bottom) and InArea(rc.Right,rc.Top) or
     InArea(rc.Left,rc.Bottom) and InArea(rc.Left,rc.Top) then}
  if (rc.Left<=L) and (rc.Right>=L) or (rc.Left<=R) and (rc.Right>=R) or (rc.Left>=L) and (rc.Right<=R) then
  begin

   //cmid:=Point((rc.Right-rc.Left) div 2,rc.Top);
   //if cmid.Y<smid.Y then continue;
   {if (rc.Left<=smid.X) and (rc.Right>=smid.X) then
    dist:=Abs(rc.Top-smid.Y) else
   if (rc.Left<=smid.X) and (rc.Right<=smid.X) then
    dist:=GetDist(smid,Point(rc.Right,rc.Top)) else
    dist:=GetDist(smid,Point(rc.Left,rc.Top));   }
   dist:=rc.Top-rs.Top;
   if dist<BestDist then
   begin
    result:=true;
    res:=c;
    BestDist:=dist;
   end;
  end;
 end;
end;

procedure TMySiz.ChildrenDisableAlign;
var i:integer;
begin
  if FChildList.Count>1 then //TdhPage und PushHeight: DisableAlign verhindert dies
  for i:=0 to FChildList.Count-1 do
   TControl(FChildList[i]).Parent.DisableAlign;
end;

procedure TMySiz.ChildrenEnableAlign;
var i:integer;
begin
  if FChildList.Count>1 then
  for i:=0 to FChildList.Count-1 do
   TControl(FChildList[i]).Parent.EnableAlign;
end;

procedure TMySiz.DoKeyDown(Key: Word; Shift: TShiftState);

procedure DeltaBounds(L,T,W,H:integer);
var i:integer;
    c:TControl;
    R:TRect;
begin
 DoInval(true);
 try
  OneParentSelection;
  ChildrenDisableAlign;
  for i:=0 to FChildList.Count-1 do
  begin
   c:=TControl(FChildList[i]);
   R:=GetBoundsFor(c,L,T,W,H);
   ForceBounds(c,R.Left,R.Top,R.Right-R.Left,R.Bottom-R.Top);
  end;              
  ChildrenEnableAlign;
  Tabs.ActBoundsChanged;
 finally
  DoInval(false);
 end;
 Update;
 Changed:=true;
end;

var c:TControl;
i:integer;
var c1,c2:Int64;
    r:TRect;

begin

 if (key=VK_F2) then
 begin
  if Tabs.mText.Visible then
   Tabs.EditText;
  exit;
 end;

 if ((key=VK_UP) or (key=VK_DOWN) or (key=VK_LEFT) or (key=VK_RIGHT)) and _RuntimeMode then
 if FindBody<>nil then
 begin
  case key of
  VK_UP: FindBody.VertPosition:=FindBody.VertPosition-19;
  VK_DOWN: FindBody.VertPosition:=FindBody.VertPosition+19;
  VK_RIGHT: FindBody.HorzPosition:=FindBody.HorzPosition+19;
  VK_LEFT: FindBody.HorzPosition:=FindBody.HorzPosition-19;
  end;
  exit;
 end;
 if (key=VK_NEXT) or (key=VK_PRIOR) then
 if FindBody<>nil then
  FindBody.ScrollPage(key=VK_NEXT);
 if (key=VK_MENU) then
  NeedPaint;
 {if (key=VK_DELETE) then
  DeleteComponents;}
 if (key=VK_ESCAPE) then
 begin
  if FDragging and (FDragStyle<>dsMove) then
  begin
   StopDragging;
  end else
  if not EmptySelection then
  begin
   c:=TControl(FChildList[0]).Parent;
   if not EditableControl(c,false) then
    StopDragging else
   if FDragging then
   begin
    StopDragging;
    SetControlTo(c,true,true);
    StartDragging(c.Parent);
   end else
    SetControlTo(c,true,true);
  end;
 end;
 if Key=VK_CONTROL then exit;


  if [ssShift,ssCtrl]*Shift=[ssShift,ssCtrl] then
  with GridDefinition do
  case Key of
    VK_UP: DeltaBounds(0,-GridY,0,0);
    VK_DOWN: DeltaBounds(0,GridY,0,0);
    VK_LEFT: DeltaBounds(-GridX,0,0,0);
    VK_RIGHT: DeltaBounds(GridX,0,0,0);
  end else
  if ssShift in Shift then
  case Key of
    VK_UP: DeltaBounds(0,0,0,-1);
    VK_DOWN: DeltaBounds(0,0,0,1);
    VK_LEFT: DeltaBounds(0,0,-1,0);
    VK_RIGHT: DeltaBounds(0,0,1,0);
  end else
  if ssCtrl in Shift then
  case Key of
    VK_UP: DeltaBounds(0,-1,0,0);
    VK_DOWN: DeltaBounds(0,1,0,0);
    VK_LEFT: DeltaBounds(-1,0,0,0);
    VK_RIGHT: DeltaBounds(1,0,0,0);
    VK_HOME: if FindBody<>nil then FindBody.VertPosition:=0;
    VK_END: if FindBody<>nil then FindBody.SetBoundedVHPos(FindBody.HorzPosition,maxint);
  end else
  if FChildList.Count<>0 then
  case Key of
    VK_UP: if GetNearest(FChildList[0],alTop,c) then SetControlTo(c,true,true);
    VK_DOWN: if GetNearest(FChildList[0],alBottom,c) then SetControlTo(c,true,true);
    VK_LEFT: if GetNearest(FChildList[0],alLeft,c) then SetControlTo(c,true,true);
    VK_RIGHT: if GetNearest(FChildList[0],alRight,c) then SetControlTo(c,true,true);
  end;

{$IFDEF MSWINDOWS}
  {if (ssShift in Shift) and (Key=VK_END) then
  begin

   QueryPerformanceCounter(Int64((@c1)^));

   for i:=0 to 1 do DeltaBounds(0,0,1,0);
   //for i:=0 to 100 do DeltaBounds(0,1,0,0);
    //FindBody.VertPosition:=FindBody.VertPosition+1;//DeltaBounds(0,1,0,0);//TdhPanel(FChildList[0]).paint;

   QueryPerformanceCounter(Int64((@c2)^));
   showmessage(inttostr((c2-c1) div 1000));
  end;}
{$ENDIF}  

end;



procedure TMySiz.SetControlTo(c: TControl; Att:boolean; All:boolean);
var cc:TControl;
    NeedScroll:boolean;
    i:integer;
    R:TRect;
begin
 //if _RuntimeMode then exit;
 Tabs.CommitChanges;

 if not (not All and Att and (FChildList.IndexOf(c)<>-1) and
    not((dhMainForm.Act<>nil) and (Tabs.Selection.Count=0)))  then
 begin
 if All then
  FChildList.Clear;
 if Att then
  Attach(c) else
  Detach(c);
 for i:=FChildList.Count-1 downto 0 do
 if csDestroying in TComponent(FChildList[i]).ComponentState then
  FChildList.Delete(i); 
 if Att and (c=nil) and (FChildList.Count<>0) then
  c:=FChildList[0];
 if Att and (c<>nil) and not _RuntimeMode then
 begin
  cc:=c;
  NeedScroll:=false;
  while (c<>nil) and (c<>Owner) do
  begin
   if c is TdhStyleSheet then
   begin
    if c<>cc then
     TdhStyleSheet(c).Expanded:=true;
   end else
   if not {c.Visible}FinalVisible(c) then
   begin
    NeedScroll:=true;
    c.Visible:=true;
   end;
   c:=GetVirtualParent(c);
  end;
 // if NeedScroll then
  if not glPreventScrollInView then
   TdhLink.ScrollInView(cc.Parent,cc,false);
 end;
  dhMainForm.UpdateCommands(true,false);
  NeedPaint;
 end;
{$IFNDEF CLX}
 //receive key input and mouse wheel; note that WM_EXIT is not triggered for the active control (and this is not needed)
 if not PreventFocus and (Parent=dhMainForm.Act) then
//  dhMainForm.Act.SendCancelMode;
  //dhMainForm.ToolBar1.SetFocus;
  Windows.SetFocus(TWinControl(Self.Parent).Handle);
{$ENDIF}
end;



destructor TMySiz.Destroy;
begin
  FreeAndNil(FChildList);
  //FreeAndNil(SavedSel);
  inherited;
end;

procedure TMySiz.ClearSelection;
begin
 SetControlTo(nil,false);
end;


procedure TMySiz.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var c:TControl;
begin
 if not DesignMouseDown(Button,Shift) then
  inherited;
 //DesignMouseDown(Button,Shift)
end;


function TMySiz.DesignMouseDown(Button: TMouseButton; Shift: TShiftState):boolean;
var c:TControl;
    l:TdhLabel;
    cl:TdhCustomLabel;
    cp:integer;
begin
 result:=false;
 //Parent.SetFocus;
 if _RuntimeMode then exit;

 if ssDouble in Shift then
 begin
  c:=GetRealC(Mouse.CursorPos);
  if not EditableControl(c,false) or not (c is TdhCustomLabel) then
  begin
   exit;
  end;
  cl:=TdhCustomLabel(c);
  cl.SetSelStart(Max(0,l.CharPos-1));
  cl.SetFocus;
  exit;
 end;

 if not Tabs.CommitChanges then exit;

 if FDragging then
 begin
  StopDragging;
 end;

 if ((gActDown<>nil) or (ssCtrl in GetShiftState){KeyPressed(VK_CONTROL) }) and (Button<>mbRight)then
 begin
  //ClearSelection;
  c:=GoodParent(GetRealC(Mouse.CursorPos));
  if AllowBodyOnly and (gActDown<>nil) and (c=Owner) then
  begin
   showmessage('You can only insert elements into the body element');
   exit;
  end;
  FChildList.Clear;
//  ClipSizing:=GetCBound();
  FDragStyle:=dsSizeBottomRight;
  StartDragging(c);
  result:=true;
 end else
 begin
 {if (gActDown<>nil) then
 begin
  c:=GoodParent(c);
  AddComp(c as TWinControl);
  StartDragging;
  FDragStyle:=dsSizeBottomRight;
  ClipSizing:=GetCBound(c);
  AssignCursor;
 end else   }
 begin

 if WhatDragStyle(true,Mouse.CursorPos) then
 begin
  //ClipSizing:=GetCBound();
  if Button=mbRight then exit;
  StartDragging(TControl(FChildList[0]).Parent);
  result:=true;
 end else
 begin
  c:=GetRealC(Mouse.CursorPos);
  if not EditableControl(c,false) then
  begin
   //Screen.Cursor:=crDefault;
   exit;
  end;
  if (FChildList.IndexOf(c)<>-1) then
  begin
   if ssShift in GetShiftState{KeyPressed(VK_SHIFT)} then
   begin
    SetControlTo(c,false);
    exit;
   end;
  end;
  SetControlTo(c,true,(FChildList.IndexOf(c)=-1) and not (ssShift in GetShiftState){KeyPressed(VK_SHIFT)});
  if not (ssShift in GetShiftState) and (Button<>mbRight) and (ssAlt in GetShiftState) then
  begin
   if c is TdhLabel then
   begin
    l:=TdhLabel(c);
    cp:=l.CharPos;
    if cp<>0 then
     Tabs.EditText(l.CharPosToTrackChar(cp).vn) else
     Tabs.EditText;
   end;
  end else
  if not (ssShift in GetShiftState){KeyPressed(VK_SHIFT)} and (Button<>mbRight) then
   StartDragging;
 end;
 end;
 end;
end;


function TMySiz.ActHintStr:boolean;
var ARect:TRect;
    OldHintStr:string;
    c:TControl;
begin
   if FDragging and ((FChildList.Count<>0) or (FDragStyle<>dsMove) and (gActDown<>nil)) then
   begin
    if (FChildList.Count<>0) then
    begin
     c:=TControl(FChildList[0]);
     ARect := GetModifiedRect(c,GetGoodMouse);
     DecPt(ARect.TopLeft,GetPBound(c).TopLeft);
    end else
    begin
     c:=nil;
     ARect:=GetSelRect(GetGoodMouse);
    end;
    OldHintStr:=HintStr;
    if FDragStyle=dsMove then
     HintStr:=inttostr(ARect.Left+AbsIncr(c).X)+', '+inttostr(ARect.Top+AbsIncr(c).Y) else
     HintStr:=inttostr(ARect.Right)+' x '+inttostr(ARect.Bottom);
    result:=OldHintStr<>HintStr;
   end else
    result:=false;
end;

procedure TMySiz.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 inherited;
 DesignMouseMove;
end;


 procedure TMySiz.KillHint;
 begin
   //FActive := false;

   if Assigned(FHintWindow) then begin
     FHintWindow.ReleaseHandle;
     FHintWindow.Free;
     FHintWindow := nil;
   end;
 end;

const
  DefHintColor = clInfoBk;

procedure TMySiz.DesignMouseMove;
var c:TControl;
    ARect:TRect;
    cc:TComponent;
begin
 if _RuntimeMode then exit;


 if not FDragging then
 begin
  HintStr:='';
  c:=GetRealC(Mouse.CursorPos);
  if c is TdhCustomPanel then
  begin
   {  if c is TdhLink then
      HintStr:=  }
   if (c is TdhPage) and TdhPage(c).IsTopScrollable then
    HintStr:='' else
   if (c is TdhPage) and not TdhPage(c).IsScrollable then
   begin
    HintStr:='Page';
   end else
   begin
   cc:=GetComp(c);
   if cc is TMenuItem then
    HintStr:=(cc as TMenuItem).Caption else
    HintStr:=(cc as TToolButton).Hint;
   end;
   if HintStr<>'' then
   begin
    dhMainForm.StatusBar.Panels[StatusBar_ObjName].Text:=c.Name+': '+AnsiSubstText('&','',HintStr);
    dhMainForm.StatusBar.Panels[StatusBar_ObjPos].Text:=' Pos: ('+inttostr(c.Left+AbsIncr(c).X)+', '+inttostr(c.Top+AbsIncr(c).Y)+')  Size: '+inttostr(c.Width)+' x '+inttostr(c.Height);
   end;
(*
     dhMainForm.StatusBar1.Panels[0].Text:=c.Name+':'+
     HintStr:=c.Name+endl+';


     //application.MainForm.caption:=hintstr+inttostr(gettickcount);
     if FHintWindow<>nil then
     begin
      //ActHint;
      if FHintWindow.Caption<>HintStr then
      begin
       FHintWindow.Caption:=HintStr;
       FHintWindow.Top:=Mouse.CursorPos.Y+20;
       FHintWindow.Left:=Mouse.CursorPos.X;
      end;
     end else
//     if not ((FHintWindow<>nil) and (FHintWindow.Caption=HintStr)) then
     begin
     //FHintTimer:=TTimer.Create(Self);

     FreeAndNil(FHintWindow);
     FHintWindow := THintWindow.Create(self);
     FHintWindow.Color:=DefHintColor;
     HintWinRect := FHintWindow.CalcHintRect(Screen.Width, HintStr, nil);
     OffsetRect(HintWinRect,Mouse.CursorPos.X,Mouse.CursorPos.Y);
     FHintWindow.ActivateHint(HintWinRect, HintStr);
     end;
     //FActive        := true;

  { Msg.Pos:=PointToSmallPoint(Self.ScreenToClient(Mouse.CursorPos));
   pret:=true;
   Application.HintMouseMessage(Self, TMessage(Msg));
   //pret:=false;
   c.Hint:=c.Name;
   c.ShowHint:=true;
   Parent.Hint:=c.Name+'X';
   Parent.ShowHint:=true;
   ShowHint:=true;
   Hint:=c.Name+'X';
//   Application.Hint:=c.Name;
   Application.ShowHint:=true;
      }
//   Application.ActivateHint(Mouse.CursorPos);
*)
  end;
  if HintStr='' then
  begin
   dhMainForm.StatusBar.Panels[StatusBar_ObjName].Text:='';
   dhMainForm.StatusBar.Panels[StatusBar_ObjPos].Text:='';
  end;

  WhatDragStyle(true,Mouse.CursorPos);
 end else
 begin
  if not EqualPoint(Mouse.CursorPos,FDragOffset) then
   OneParentSelection;
  NeedPaint;
 end;
end;

procedure TMySiz.UpdateHintWindow;
var
    First:boolean;
    HintWinRect:TRect;
begin
  if ActHintStr then
  begin
    First:=false;
    if (FHintWindow=nil) then
    begin
     First:=true;
     FHintWindow := TMyHintWindow.Create(self);
     FHintWindow.Color:=DefHintColor;
     {
     FHintWindow.ActivateHint(HintWinRect, HintStr);  }
    end;    
    HintWinRect := FHintWindow.CalcHintRect(Screen.Width, HintStr, nil);  
    OffsetRect(HintWinRect,Mouse.CursorPos.X,Mouse.CursorPos.Y+20);
       if First then
        FHintWindow.ActivateHint(HintWinRect, HintStr) else
       begin
       Inc(HintWinRect.Bottom, 4); //see ActivateHint
       FHintWindow.Invalidate;
       FHintWindow.Caption:=HintStr;
       FHintWindow.SetBounds(HintWinRect.Left,HintWinRect.Top,HintWinRect.Right-HintWinRect.Left,HintWinRect.Bottom-HintWinRect.Top);
       //FHintWindow.SetBounds(HintWinRect.Left,HintWinRect.Top,FHintWindow.Width,FHintWindow.Height);
{       FHintWindow.Top:=HintWinRect.Top;
       FHintWindow.Left:=HintWinRect.Left;}
       {FHintWindow.Invalidate; }
{$IFNDEF CLX}
       SetWindowPos(FHintWindow.Handle, 0, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOMOVE or
         SWP_NOZORDER or SWP_FRAMECHANGED{ or SWP_DRAWFRAME}); //um NC zu aktualisieren
{$ENDIF}         
       FHintWindow.Update;
       end;
  end;

end;


function ParentList(c:TControl):TList;
begin
 result:=TList.Create;
 c:=c.Parent;
 while c<>nil do
 begin
  result.Add(c);
  c:=c.Parent;
 end;
end;

function TMySiz.GetSelectionIDs:TStringList;
var i:integer;
begin
 result:=TStringList.Create;
 for i:=0 to FChildList.Count-1 do
  result.Add(TControl(FChildList[i]).Name);
end;

procedure TMySiz.AddSelectionByIDs(sl:TStringList);
var i:integer;
    c:TComponent;
begin
 with GetSelectionIDs do
 try
  if Equals(sl) then exit; //may encounter in Unit1.cbNameChange 
 finally
  Free;
 end;
 FChildList.Clear;
 for i:=0 to sl.Count-1 do
 begin
  c:=Owner.FindComponent(sl[i]);
  if c<>nil then
  begin
   FChildList.Add(c);
   if (c is TdhPage) and (TdhPage(c).PageControl<>nil) then
    TdhPage(c).PageControl.ActivePage:=TdhPage(c);
  end;
 end;
 FlushSelection;
end;

procedure TMySiz.AddSelectionByID(const id:TComponentName);
var sl:TStringList;
begin
 sl:=TStringList.Create;
 try
  sl.Add(id);
  AddSelectionByIDs(sl);
 finally
  sl.Free;
 end;
end;

procedure TMySiz.FlushSelection;
begin
 SetControlTo(nil,true);
end;



procedure TMySiz.OneParentSelection;
var i:integer;
begin
 if FChildList.Count=0 then exit;
 for i:=FChildList.Count-1 downto 1 do
 if GetVirtualParent(TControl(FChildList[i]))<>GetVirtualParent(TControl(FChildList[0])) then
  SetControlTo(TControl(FChildList[i]),false);
end;


function NestSortCompareInner(const Item1, Item2: TControl): Integer;
var abst:integer;
begin
 result:=Item1.Top-Item2.Top;
 if result=0 then
 begin
  result:=Item1.Left-Item2.Left;
 end;
 if result=0 then
 begin
  result:=GetChildPosition(Item1)-GetChildPosition(Item2);
 end;
end;

                       
var OnceOK:boolean=false;
var FindStr:WideString;
    FindForward:boolean;
    FindCaseSensitive:boolean;
    FindDefinition:boolean;
    FindHidden:boolean;
    //FindLS:TBinTree;

function UpperCaseIf(const s:WideString; doIt:boolean):WideString;
begin
 if doIt then
  result:=WideUpperCase(s) else
  result:=s;
end;


type TFakeComponent=class(TComponent);

{procedure TMySiz.AddToOrderList(Child: TComponent);
begin             
  if (Child is TControl) and (csDesigning in Child.ComponentState) and FinalVisible(TControl(Child)) then
   FindLS.AddItem(@NestSortCompareInner,TControl(Child));
end; }

procedure TMySiz.Find(FindNext:boolean);


function HaveFound(c:TControl):boolean;
var
    S:WideString;
begin
  S:='';
  if c is TdhCustomPanel then
  if not FindDefinition then
  begin
   if c is TdhLabel then
    S:=TdhLabel(c).RenderedText;
  end else
  begin
    S:=TdhCustomPanel(c).AllHTMLCode;
  end;

  {if (c is TdhLabel) then
  begin
   if FindDefinition then
    S:=TdhLabel(c).Text else
    S:=TdhLabel(c).RenderedText;
  end else
  if (c is TdhDirectHTML) then
  begin
   if FindDefinition then
    S:=TdhDirectHTML(c).InnerHTML else
    S:='';
  end else
  if (c is TdhPage) then
  begin
   if FindDefinition then
    S:=TdhPage(c).HTMLHead+TdhPage(c).HTMLBody else
    S:='';
  end else
   S:='';}
  if (FindStr='') or (S<>'') and (Pos(UpperCaseIf(FindStr,not FindCaseSensitive),UpperCaseIf(S,not FindCaseSensitive))>0) then
  begin
   SetControlTo(c,true,true);
   result:=true;
  end else
   result:=false;
end;

function FindRec(p:TWinControl; oric:TControl=nil):boolean;
var
    c:TControl;
    ls:TList<TControl>;
    node:Integer;
    i:integer;
begin
 ls:=TList<TControl>.Create(TComparer<TControl>.Construct(NestSortCompareInner));
 try
 for i:=0 to p.ControlCount-1do
 begin
  c:=p.Controls[i];
  if (p.Owner=c.Owner) and (FindHidden or FinalVisible(c)) then
   ls.Add(c);
 end;
 ls.Sort;
{ FindLS:=ls;
 TFakeComponent(p).GetChildren(AddToOrderList,p.Owner);
 FindLS:=nil;
 }
 //ls.Sort(@NestSortCompareInner);
 //from:=ls.IndexOf(oric);
 //for i:=from+1 to ls.Count-1 do

 node:=-1;
 if oric<>nil then
  ls.BinarySearch(oric,node);
 if node=-1 then
 if FindForward then
  node:=0 else
  node:=ls.Count-1;
 while (node>=0) and (node<=ls.Count-1) do
 begin
  c:=ls[node];
  if (c<>oric) then
  begin
  if FindForward and HaveFound(c) then
  begin
   result:=true;
   exit;
  end;
  (*if FindHidden and (c is TdhPage) and (TdhPage(c).PageControl<>nil) then
  begin
   pc:=TdhPage(c).PageControl;
   for i:=0 to pc.PageCount-1 do
   if {(pc.Pages[i]<>c) and }FindRec(pc.Pages[i]) then
   begin
    result:=true;
    exit;
   end;
  end else*)
  if (c is TWinControl) and FindRec(TWinControl(c)) then
  begin
   result:=true;
   exit;
  end;
  if not FindForward and HaveFound(c) then
  begin
   result:=true;
   exit;
  end;
  end;
  if FindForward then
   node:=node+1 else
   node:=node-1;
 end;
     
 result:=false;
 finally
  ls.Free;
 end;
end;


var
    //p:TWinControl;
    c:TControl;
    index:integer;
begin
 if (FindText=nil) or not OnceOK or not FindNext then
 begin
  LateCreateForm(TFindText,FindText);
  FindText.ActiveControl:=FindText.eFind;
  if FindText.ShowModal<>mrOK then
  begin
   exit;
  end;

  FindStr:=FindText.eFind.Text;
  FindCaseSensitive:=FindText.cCaseSensitive.Checked;
  FindHidden:=FindText.cHidden.Checked;
  FindForward:=FindText.gDirection.ItemIndex=0;
  FindNext:=FindText.gOrigin.ItemIndex=0;
  FindDefinition:=FindText.gKind.ItemIndex=0;

  index:=FindText.eFind.Items.IndexOf(FindStr);
  if index<>-1 then
   FindText.eFind.Items.Delete(index);
  if FindStr<>'' then
  begin
   FindText.eFind.Items.Insert(0,FindStr);
   FindText.eFind.ItemIndex:=0;
  end;
  OnceOK:=true;
 end;

 if not Tabs.CommitChanges then exit;
 if (FChildList.Count=0) or not FindNext then
  c:=FindBody else
  c:=TControl(FChildList[0]);
 {if (c=FindBody) and (FindBody.ControlCount>=1) then
 begin
  p:=FindBody;
  c:=nil;
 end else
 begin
  p:=c.Parent;
  //childpos:=GetChildPosition(c);
 end; }
 //w:=c.Top;
 if FindForward and (c is TWinControl) and FindRec(TWinControl(c)) then
  exit;
 while not(c.Parent is TCustomForm) do
 if FindRec(c.Parent,c) then
  exit else
 begin
  c:=c.Parent;
  if not FindForward and HaveFound(c) then
   exit;
 end;

 MessageDlg(DKFormat(SEARCHFAILED,FindStr),mtInformation,[mbOK],0);
end;

procedure TMySiz.Select(All:boolean; Below:boolean);
var i,w:integer;
    p:TWinControl;
    c:TControl;
begin
 if not Tabs.CommitChanges then exit;
 OneParentSelection;
 if FChildList.Count=0 then exit;
 c:=TControl(FChildList[0]);
 if (c=FindBody) and (FindBody.ControlCount>=1) then
 begin
  p:=FindBody;
  FChildList.Delete(0);
 end else
  p:=c.Parent;
 w:=c.Top;
 for i:=0 to p.ControlCount-1 do
 if (csDesigning in p.Controls[i].ComponentState) and FinalVisible(p.Controls[i]) then
 if All or not All and
    (Below and (p.Controls[i].Top>=w) or not Below and (p.Controls[i].Top<=w)) then
 if FChildList.IndexOf(p.Controls[i])=-1 then
  FChildList.Add(p.Controls[i]);
 FlushSelection;
end;

procedure TMySiz.StopDragging;
begin
  if not FDragging then exit;
  FDragging:=false;
  FreeAndNil(FHintWindow);
  NeedPaint;
end;



procedure TMySiz.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 inherited;
 DesignMouseUp(Button);
end;


        
procedure TMySiz.DesignMouseUp(Button: TMouseButton);
var ARect:TRect;
    i:integer;
    c:TControl;
    p:TWinControl;
    changed:boolean;
    gm:TPoint;
begin


 Self.MouseCapture:=false;
 if Button=mbRight then
 begin
  Tabs.PopupMenu2.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
  exit;
 end;          
 if _RuntimeMode then exit;

 if FDragging then
 begin
  DoInval(true);
  try
  StopDragging;
  if EmptySelection then
  begin
   p:=GoodParent(GetRealC(FDragOffset));
   ARect:=GetSelRect(GetGoodMouse);
   if gActDown<>nil then
   begin
     AddComp(p,ARect);
   end else
   begin
    IncPt(ARect.BottomRight,ARect.TopLeft);
    for i:=0 to p.ControlCount-1 do
    begin
     c:=p.Controls[i];
     if EditableControl(c,false) and FinalVisible(c) and DoIntersectStrong(ARect,GetCBound(c)) then
     if FChildList.IndexOf(c)=-1 then
      FChildList.Add(c);
    end;
    FlushSelection;
   end;
  end else
  begin
  changed:=false;
  gm:=GetGoodMouse;
  for i:=0 to FChildList.Count-1 do
  begin
   c:=TControl(FChildList[i]);
   ARect := GetModifiedRect(c,gm);
   DecPt(ARect.TopLeft,GetPBound(c).TopLeft);
   if not EqualRect(c.BoundsRect,Rect(ARect.Left,ARect.Top,ARect.Left+ARect.Right,ARect.Top+ARect.Bottom)) then
   begin
    ForceBounds(c,ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    changed:=true;
   end;
  end;
  Tabs.ActBoundsChanged;
  if changed then
   (Owner as TPageContainer).SetModified(_if(FDragStyle=dsMove,'Position','Resize'),lcCommit);
  end;
  finally
   DoInval(false);
  end;

  //SetFocus;
 end;
end;



function TMySiz.FindBody:TdhPage;
var i:integer;
begin              {
 if (TWinControl(Owner).ControlCount<>0) and (TWinControl(Owner).Controls[0] is TdhPage) then
  result:=TdhPage(TWinControl(Owner).Controls[0]) else
  result:=nil;   }

 for i:=0 to TWinControl(Owner).ControlCount-1 do
 if TWinControl(Owner).Controls[i] is TdhPage then
 begin
  result:=TWinControl(Owner).Controls[i] as TdhPage;
  exit;
 end;
 result:=nil;
end;


function TMySiz.GetPasteParent:TWinControl;
begin
 if FChildList.Count=1 then
  result:=GoodParent(TControl(FChildList[0])) else
  result:=FindBody;
end;

procedure TMyList.AddChildren(Child: TComponent);
begin
 if IndexOf(Child)<>-1 then exit;
 Add(Child);
 TFakeComponent(Child).GetChildren(AddChildren,Child.Owner);
end;

procedure TMyList.AddDirectChildren(Parent: TComponent);
begin
 TFakeComponent(Parent).GetChildren(AddChild,Parent.Owner);
end;

procedure TMyList.AddChild(Child: TComponent);
begin
 Add(Child);
end;


procedure TMyList.TopDeleteChildren(Child: TComponent);
begin
 if IndexOf(Child)=-1 then exit;
 TFakeComponent(Child).GetChildren(DeleteChildren,Child.Owner);
  {
 if c is TWinControl then
 with TWinControl(c) do
 for i:=0 to ControlCount-1 do
 if CopyList.IndexOf(Controls[i])<>-1 then
 begin
  CopyList[CopyList.IndexOf(Controls[i])]:=nil;
  DeleteChildren(CopyList,Controls[i]);
 end;   }
end;

procedure TMyList.DeleteChildren(Child: TComponent);
begin
 if IndexOf(Child)=-1 then exit;
 Items[IndexOf(Child)]:=nil;
 TFakeComponent(Child).GetChildren(DeleteChildren,Child.Owner);
end;


function PrepareCopyList(CopyDependencies:boolean; FChildList:TList):TList;
var CopyList:TMyList;
var i,c,i2,c2:integer;
begin

  CopyList:=TMyList.Create;
  try

  for i:=0 to FChildList.Count-1 do
   CopyList.AddChildren(TComponent(FChildList[i]));

  c:=CopyList.Count;

  i:=0;
  while i<=CopyList.Count-1 do
  begin
  if (TComponent(CopyList[i]) is TdhCustomPanel) then
  begin
   c2:=CopyList.Count;
   TdhCustomPanel(CopyList[i]).CopyDependencies(CopyList);
   for i2:=c2 to CopyList.Count-1 do
   begin
    CopyList.AddChildren(TComponent(CopyList[i2]));
    if (TComponent(CopyList[i2]) is TdhCustomPanel) then
    if (TdhCustomPanel(CopyList[i2]).Parent is TdhStyleSheet) then
     CopyList.AddChildren(TdhCustomPanel(CopyList[i2]).Parent);
   end;
  end;
  inc(i);
  end;

  if not CopyDependencies then
   CopyList.Count:=c;

  {if c<>CopyList.Count then
  case MessageDlg('The selected elements reference elements not included in the selection, like '+TComponent(CopyList[c]).Name+'.'+#13#10+
                  'Do you want to include them?', mtConfirmation,[mbYes, mbNo, mbCancel], 0) of
  mrYes: ;
  mrNo: CopyList.Count:=c;
  mrCancel:exit;
  end;  }

  for i:=CopyList.Count-1 downto 0 do
  if CopyList[i]<>nil then
    TFakeComponent(CopyList[i]).GetChildren(CopyList.DeleteChildren,TComponent(CopyList[i]).Owner);

  //_CopyComponents(Owner, CopyList);
  except
   CopyList.Clear;
  end;
  result:=CopyList;
end;


procedure TMySiz.CopyComponents(CopyDependencies:boolean; _WithMeta:boolean);
var CopyList:TList;
begin              
  if not Tabs.CommitChanges then exit;

  assert(not WithMeta);
  WithMeta:=_WithMeta;
  try
   CopyList:=PrepareCopyList(CopyDependencies,FChildList);
   try
    _CopyComponents(Owner, CopyList);
   finally
    CopyList.Free;
   end;
  finally
   WithMeta:=false;
  end;
end;


procedure TMySiz.AddToDeletion(Child: TComponent);
begin
 DeletionList.Add(Child);
 TFakeComponent(Child).GetChildren(AddToDeletion,Child.Owner);
end;

procedure TMySiz.DeleteComponents;
var i:integer;
    page:TdhPage;
    pn:TdhCustomPanel;
    Reason:WideString;
    NewParent:TControl;
begin
  if not Tabs.CommitChanges then exit;
  DoInval(true);
  try

  DeletionList:=TList.Create;
  try
  for i:=0 to FChildList.Count-1 do
   AddToDeletion(FChildList[i]);

  for i:=0 to DeletionList.Count-1 do
  if (TComponent(DeletionList[i]) is TdhCustomPanel) and TdhCustomPanel(DeletionList[i]).BetterNotToDelete(DeletionList,Reason) then
  if MessageDlg(Reason+'.'+#13#10+DKFormat(CONFIRMDELETE), mtConfirmation,[mbYes, mbNo], 0)={idYes}mrYes then break else exit;

  finally
  FreeAndNil(DeletionList);
  end;

  NewParent:=nil;
  i:=0;
  while (i<=FChildList.Count-1) do
  if FChildList[i]<>FindBody then
  begin
   NewParent:=TControl(FChildList[i]).Parent;
   TControl(FChildList[i]).Free;
   i:=0;
  end else
   inc(i);
  (Owner as TPageContainer).SetModified('Delete Object',lcCommit);
  if NewParent<>nil then
   SetControlTo(NewParent,true,true);
  finally
   DoInval(false);
  end;
  dhMainForm.UpdateCommands(false,true);
end;



procedure TMySiz.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and (FChildList<>nil) and (FChildList.IndexOf(AComponent)<>-1) then
   SetControlTo(AComponent as TControl,false);
end;


class function TMySiz.GridAdjust(const GridBase: TPoint; Pt: TPoint): TPoint;
begin
 result:=Point(XGridAdjust(GridBase,Pt.X),YGridAdjust(GridBase,Pt.Y));
end;

procedure TMySiz.WriteState(Writer: TWriter);
begin
 if not (csDesigning in ComponentState) then exit; //niemals saven
 Inherited;
end;


procedure TMySiz.DoInval(Before:boolean);
var i:integer;
begin
 for i:=0 to FChildList.Count-1 do
 if (TObject(FChildList[i]) is TControl) and not (TObject(FChildList[i]) is TdhCustomPanel) then
  InvalTrans(TControl(FChildList[i]));
{ if not Before then
  NeedPaint;}
 //PreventBoundsChanging:=Before;
end;


procedure TMySiz.SelCheckDesignState;
var i:integer;
begin                            
 {if _RuntimeMode then
 begin
  if SavedSel=nil then
   SavedSel:=GetSelectionIDs;
  ClearSelection;
 end else
 if SavedSel<>nil then
 begin
  glPreventScrollInView:=true;
  try
   AddSelectionByIDs(SavedSel);
  finally
   glPreventScrollInView:=false;
  end;
  FreeAndNil(SavedSel);
 end; }
 //(Parent as TPageContainer).SetDesigning(not _RuntimeMode,false);
 for i:=0 to FChildList.Count-1 do
 if TControl(FChildList[i]) is TdhCustomPanel then
  TdhCustomPanel(FChildList[i]).CheckDesignState; 
end;

function TMySiz.IsSelected(Control: TControl): boolean;
begin
 result:=FChildList.IndexOf(Control)<>-1;
end;

function TMySiz.HasSelectedComponents: boolean;
begin
 result:=FChildList.Count<>0;
end;

{ TSelectionList }

procedure TSelectionList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited;

  if (TObject(Ptr) is TdhCustomPanel) and not (csDestroying in TdhCustomPanel(Ptr).ComponentState) then
   TdhCustomPanel(Ptr).CheckDesignState;
end;

        {
type TFakeWidgetControl=class(TWidgetControl);
function TMySiz.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
begin                         
  case QEvent_type(Event) of
    QEventType_MouseButtonPress,
    QEventType_MouseButtonRelease,
    QEventType_MouseButtonDblClick,
    QEventType_MouseMove:
    begin
      TFakeWidgetControl(Parent).EventFilter(Sender,Event);
      Result := false;
      exit;
    end;
  end;
  result:=inherited EventFilter(Sender,Event);
end;      }


procedure TMySiz.ShiftIntoView;
var i:integer;
    AControl,P:TControl;
    prct:TRect;
    L,T:integer;
begin
 for i:=0 to FChildList.Count-1 do
 begin
  AControl:=TControl(FChildList[i]);
  P:=AControl.Parent;
  if P is TdhCustomPanel then
   prct:=TdhCustomPanel(P).GetInnerClientArea else
   prct:=P.ClientRect;   
  L:=AControl.Left;
  T:=AControl.Top;
  if glPreferMousePosition{ and not (AControl is TdhStyleSheet)} then
  with Mouse.CursorPos do
  begin
   L:=X-GetPBound(AControl).Left;
   T:=Y-GetPBound(AControl).Top;
  end;
  if not ((P is TdhCustomPanel) and TdhCustomPanel(P).IsScrollArea) then
  begin
   L:=Min(L,prct.Right-AControl.Width);
   T:=Min(T,prct.Bottom-AControl.Height);
  end;
  L:=Max(L,prct.Left);
  T:=Max(T,prct.Left);
  ForceBounds(AControl,L,T,AControl.Width,AControl.Height);
 end;
end;

function TMySiz.HasOneSelectedComponent: boolean;
begin
 result:=FChildList.Count=1;
end;

end.
