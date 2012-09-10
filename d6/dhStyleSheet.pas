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

unit dhStyleSheet;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls, QGraphics, QDialogs, QForms,
  {$ELSE}
  Controls, Windows, Messages, Graphics, Dialogs,
  {$ENDIF}
  SysUtils, Classes, dhPanel, dhLabel, GR32, dhStyles;

{$R 'dhStyleSheet.dcr'}

type
  TdhStyleSheet = class(TdhCustomPanel)
  private
    FExpanded: boolean;
    sBounds:TPoint;
    function GetCloseButton: TRect;
    function GetAddButton: TRect;
    function GetAddLinkButton: TRect;
    function GetOpenButton: TRect;
    function GetActDown: TActMode; override;
    procedure SetExpanded(Value: boolean);
  protected
    procedure AdjustBackgroundColor(var Col: TCSSColor); override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    function EffectsAllowed: boolean; override;
    procedure Loaded; override;
    function AdjustZIndex(ChildPos,ParentControlCount:integer):integer; override;
    procedure DoDrawFrame(Canvas: TCanvas; _ActDown: TActMode); override;
    procedure DoInvalFrame; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ConstrainedResize(var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer); override;
    procedure ControlsListChanged(Control: TControl; Inserting: Boolean); override;
    procedure ReadExpandedWidth(Reader:TReader);
    procedure ReadExpandedHeight(Reader:TReader);
    procedure ReadExpanded(Reader:TReader);
    procedure WriteExpandedWidth(Writer:TWriter);
    procedure WriteExpandedHeight(Writer:TWriter);
    procedure WriteExpanded(Writer:TWriter);
    procedure ProcessFrameEvent(FrameEventType: TFrameEventType); override;
  public
    constructor Create(AOwner: TComponent); override;
    function AddStyle(anAnchor:boolean):TdhLabel;
  published
    property Expanded:boolean read FExpanded write SetExpanded nodefault;
    property VertPosition;
    property HorzPosition;
    property Visible default false;
    property ParentColor stored False;
    property ParentFont stored False;
    property OnMouseMove;
  end;

function InStyleSheet(p:TControl; var StyleSheet:TdhStyleSheet):boolean;
function UsefulUse(c,comp:TPersistent; ForInline:boolean; var pn:TdhCustomPanel):boolean; overload;
function UsefulUse(c:TPersistent; Comps:TList; ForInline:boolean; var pn:TdhCustomPanel):boolean; overload;

procedure Register;

var UndoRedoLoad:boolean=false;

implementation

uses dhHTMLForm,dhMenu,dhPageControl;

var TempBitmap:TBitmap;

const
      TopNC=27;
      _bottom=25;
      Contracted=28;
      ic=4;

function InStyleSheet(p:TControl; var StyleSheet:TdhStyleSheet):boolean;
begin
 p:=GetVirtualParent(p);
 while p<>nil do
 if p is TdhStyleSheet then
 begin
  StyleSheet:=TdhStyleSheet(p);
  result:=true;
  exit;
 end else
  p:=GetVirtualParent(p);
 result:=false;
end;

function UsefulUse(c,comp:TPersistent; ForInline:boolean; var pn:TdhCustomPanel):boolean; overload;
var StyleSheet:TdhStyleSheet;
begin
 result:=false;
 if c=nil then exit;
 if not (comp is TControl) or not (c is TControl) or not (c is TdhCustomPanel) or (comp=c) then
  exit;
 pn:=c as TdhCustomPanel;
 if (GetTopForm(TControl(comp))<>GetTopForm(TControl(c))){ or
    ForInline and not (c is TdhRule) and (comp.ClassName<>c.ClassName)} then exit;
 if not (GetParentPage(TControl(c)).ContainsControl(TControl(comp))) then
  exit;

 result:=InStyleSheet(TControl(c),StyleSheet);
end;

function UsefulUse(c:TPersistent; Comps:TList; ForInline:boolean; var pn:TdhCustomPanel):boolean; overload;
var i:integer;
begin
 for i:=0 to Comps.Count-1 do
 if not UsefulUse(c,TPersistent(Comps[i]),ForInline,pn) then
 begin
  result:=false;
  exit;
 end;
 result:=true;
end;


function TdhStyleSheet.AdjustZIndex(ChildPos,ParentControlCount:integer):integer;
begin
 result:=maxint-1000-2*ParentControlCount+ChildPos;
end;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhStyleSheet]);
end;

function TdhStyleSheet.AddStyle(anAnchor:boolean):TdhLabel;
begin
 result:=nil;
 if csAncestor in Self.ComponentState then
 begin
  showmessage('Cannot add a style within a frame');
  exit;
 end;
 if Assigned(glPreAddCompo) then
  glPreAddCompo(Self);
 if anAnchor then
  result:=TdhLink.Create(Self.Owner) else
  result:=TdhLabel.Create(Self.Owner);
 if anAnchor then
  result._SetUniqueName('Link') else
  result._SetUniqueName('Label');
 result.Top:={VPos+Height}GetInnerClientArea.Bottom+Height{maxint};
 result.Align:=alTop;
 result.Parent:=Self;
 if Assigned(glPostAddCompo) then
  glPostAddCompo(result);
end;

constructor TdhStyleSheet.Create(AOwner: TComponent);
begin
 Inherited;
 FExpanded:=true;
 SetBounds(0,0,100,100);
 Visible:=False;
 FVertScrollbarAlwaysVisible:=true;
 NCScrollbars:=true;
 IsScrollArea:=true;
 Style.Margin:='1';
 Style.MarginTop:=inttostr(TopNC);
end;


procedure TdhStyleSheet.AdjustBackgroundColor(var Col:TCSSColor);
begin
  if Parent is TdhCustomPanel then
   Col:=TdhCustomPanel(Parent).GetVirtualBGColor;
end;

procedure TdhStyleSheet.ControlsListChanged(Control: TControl; Inserting: Boolean);
begin
  inherited;
  if not (csReading in ComponentState) then
    if Inserting then
     Control.Align:=alTop;
end;

function TdhStyleSheet.GetCloseButton:TRect;
begin
 result:=Rect(2,2,27,_bottom);
end;

function TdhStyleSheet.GetOpenButton:TRect;
begin
 result:=Bounds(4,5,20,17);
end;

function TdhStyleSheet.GetAddButton:TRect;
begin
 result:=Rect(28,2,53,_bottom);
end;

function TdhStyleSheet.GetAddLinkButton:TRect;
begin
 result:=Rect(54,2,79,_bottom);
end;
           
procedure TdhStyleSheet.DoDrawFrame(Canvas: TCanvas; _ActDown: TActMode);

procedure myrect(Canvas:TCanvas; r:TRect; topleft,bottomright,content:TColor; down:boolean=false);
begin
 with Canvas do
 begin
 if down then
  Pen.Color:=topleft else
  Pen.Color:=bottomright;
 MoveTo(r.Right-1,r.Top);
 LineTo(r.Right-1,r.Bottom-1);
 LineTo(r.Left,r.Bottom-1);
 if down then
  Pen.Color:=bottomright else
  Pen.Color:=topleft;
 LineTo(r.Left,r.Top);
 LineTo(r.Right,r.Top);
 if content<>clNone then
 begin
  Brush.Color:=content;
  InflateRect(r,-1,-1);
  FillRect(r);
 end;
 end;
end;

var RW:TRect;

begin
    RW:=ActTopGraph.BoundsRect;
    Canvas.Pen.Style:=psSolid;
    myrect(Canvas,RW,$EEEEEE,clGray,clNone); 
    Canvas.Brush.Style:=bsSolid;
    if FExpanded then
    begin
      Inherited;
      Canvas.Brush.Color:=clBtnFace;
      Canvas.FillRect(Rect(1,1,RW.Right-1,TopNC));

      myrect(Canvas,GetCloseButton,clWhite,clGray,clNone,_ActDown=amCloseDown);
      Canvas.Brush.Color:=clBlack;
      Canvas.Pen.Color:=clBlack;
      with GetCloseButton do
       Canvas.Polygon([Point(Left+12,Top+4+ic),Point(Left+12,Top+10+ic),Point(Left+9,Top+7+ic)]);

      myrect(Canvas,GetAddButton,clWhite,clGray,clNone,_ActDown=amAddDown);
      Canvas.Brush.Color:=clBlack;
      Canvas.Pen.Color:=clBlack;
      with GetAddButton do
      begin
       Canvas.FillRect(Rect(Left+11,Top+4+ic,Left+13,Top+12+ic));
       Canvas.FillRect(Rect(Left+8,Top+7+ic,Left+16,Top+9+ic));
      end;

      myrect(Canvas,GetAddLinkButton,clWhite,clGray,clNone,_ActDown=amAddLinkDown);
      Canvas.Brush.Color:=clBlue;
      Canvas.Pen.Color:=clBlue;
      with GetAddLinkButton do
      begin
       Canvas.FillRect(Rect(Left+11,Top+4+ic,Left+13,Top+12+ic));
       Canvas.FillRect(Rect(Left+8,Top+7+ic,Left+16,Top+9+ic));
      end;

    end else
    begin
      Canvas.Brush.Color:=clBtnFace;
      Canvas.FillRect(Rect(1,1,RW.Right-1,RW.Bottom-1));
      if TempBitmap=nil then
      begin
        TempBitmap := TBitmap.Create;
        TempBitmap.LoadFromResourceName(HInstance, 'TDHSTYLESHEET2');
      end;
      if _ActDown=amOpenDown then
       Canvas.Draw(5,6,TempBitmap) else
       Canvas.Draw(4,5,TempBitmap);
    end;
end;


procedure TdhStyleSheet.DoInvalFrame;
var R:TRect;
begin                  
  Inherited;            
{$IFNDEF CLX}
  R:=Rect(0,0,Width,TopNC);
  if not IsRectEmpty(R) then
   InvalidateRect(Handle,@R,false);  
{$ENDIF}
end;


function TdhStyleSheet.GetActDown:TActMode;
var P:TPoint;
begin
 P:=Mouse.CursorPos;
 with GetCBound(Self).TopLeft do P:=Point(P.X-X,P.Y-Y);
 result:=amNone;
 if FExpanded then
 begin
 if PtInRect(GetAddButton,P) then
  result:=amAddDown else
 if PtInRect(GetAddLinkButton,P) then
  result:=amAddLinkDown else
 if PtInRect(GetCloseButton,P) then
  result:=amCloseDown else
  result:=Inherited GetActDown;
 end else
 if PtInRect(GetOpenButton,P) then
  result:=amOpenDown;
end;

procedure TdhStyleSheet.SetExpanded(Value:boolean);
begin
 if FExpanded<>Value then
 begin
  FExpanded:=Value;
  if FExpanded then
  begin
   SetBounds(Left,Top,sBounds.X,sBounds.Y); 
   Style.MarginTop:=inttostr(TopNC);
  end else
  begin
   sBounds:=Point(Width,Height);
   Style.MarginTop:=inttostr(Contracted-1);
   AdjustSize;
  end;
 end;
end;

procedure TdhStyleSheet.ConstrainedResize(var MinWidth, MinHeight,
  MaxWidth, MaxHeight: Integer);
begin
  inherited;
  if not FExpanded then
  begin
   MaxWidth:=Contracted;
   MaxHeight:=Contracted;
  end;
end;

procedure TdhStyleSheet.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ExpandedWidth', ReadExpandedWidth, WriteExpandedWidth, not FExpanded);
  Filer.DefineProperty('ExpandedHeight', ReadExpandedHeight, WriteExpandedHeight, not FExpanded);
  Filer.DefineProperty('Expanded', ReadExpanded, WriteExpanded, not FExpanded);
end;

procedure TdhStyleSheet.ReadExpanded(Reader: TReader);
begin
 FExpanded:=Reader.ReadBoolean;
end;

procedure TdhStyleSheet.ReadExpandedHeight(Reader: TReader);
begin
 sBounds.Y:=Reader.ReadInteger;
end;

procedure TdhStyleSheet.ReadExpandedWidth(Reader: TReader);
begin
 sBounds.X:=Reader.ReadInteger;
end;

procedure TdhStyleSheet.WriteExpanded(Writer: TWriter);
begin
 Writer.WriteBoolean(FExpanded);
end;

procedure TdhStyleSheet.WriteExpandedHeight(Writer: TWriter);
begin
 Writer.WriteInteger(sBounds.Y);
end;

procedure TdhStyleSheet.WriteExpandedWidth(Writer: TWriter);
begin
 Writer.WriteInteger(sBounds.X);
end;

procedure TdhStyleSheet.ProcessFrameEvent(FrameEventType: TFrameEventType);
var ActDown:TActMode;
begin
 ActDown:=Self.ActDown;
 inherited;
 if FrameEventType=feMouseUp then
  if ActDown=GetActDown then
   case ActDown of
   amAddDown,amAddLinkDown:
   begin
    AddStyle(ActDown=amAddLinkDown);
    SetBoundedVPos(maxint);
   end;
   amCloseDown: Expanded:=False;
   amOpenDown: Expanded:=True;
   end;
end;

procedure TdhStyleSheet.Loaded;
begin
  inherited;
  if not UndoRedoLoad then
   Expanded:=False;
end;

function TdhStyleSheet.EffectsAllowed: boolean;
begin
 result:=false;
end;

procedure TdhStyleSheet.GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
begin
 if not FExpanded then
 begin
  NewWidth:=Contracted;
  NewHeight:=Contracted;
 end else
 begin
  if GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth,NewHeight) then exit;
 end;
end;


procedure TdhStyleSheet.AlignControls(AControl: TControl; var Rect: TRect);
begin    
 if not FExpanded then exit;
 inherited;
end;

initialization

finalization
 FreeAndNil(TempBitmap);

end.

