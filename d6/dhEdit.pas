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

unit dhEdit;

interface

uses
   Types, SysUtils, Classes, dhPanel, dhLabel, dhStrUtils, dhStyles, Controls;

type
  TdhCustomEdit = class(TdhCustomLabel)
  private
    FReadOnly: boolean;
  protected
    FInitialValue:HypeString;
    procedure NearestMod(m,frame:integer; var n,times:integer);
    procedure Loaded; override;
    procedure GetModifiedText(var pre,s,suc:HypeString); override;
    function InterpreteDirectly:Boolean; override;
    function NeedPadding(HasRastering:TRasterType): boolean; override;
    function EffectsAllowed: boolean; override;
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
    procedure GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows, Cols: Integer); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    property ReadOnly:boolean read FReadOnly write FReadOnly default False;
    procedure Reset;
    procedure Memorize;
  published
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

  TdhEdit = class(TdhCustomEdit)
  private
    FPassword: boolean;
    procedure SetPassword(const Value: boolean);
  protected
    function GetFinal:ICon; override;
    procedure SetHTMLText(const Value:HypeString); override;
    procedure GetModifiedText(var pre, s, suc: HypeString); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ReadOnly;
    property Password:boolean read FPassword write SetPassword default false;
    property Text:HypeString read FHTMLText write SetHTMLText;
  end;

implementation

uses BasicHTMLElements;

procedure TdhCustomEdit.NearestMod(m,frame:integer; var n,times:integer);
begin
 times:=((n-frame)+m div 2) div m;
 n:=times * m + frame;
end;

procedure TdhCustomEdit.GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows,Cols: Integer);
begin
  Rows:=0;
  Cols:=0;
  with AllEdgesPure do
  begin
   if AllowModifyY then
    NewHeight:=TextExtent('Wg').cy+Bottom+Top;
   if AllowModifyX then
    NearestMod(TextExtent('X').cx,Left+Right,NewWidth,Cols);
  end;
end;

procedure TdhCustomEdit.GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
var dummyRows,dummyCols:integer;
begin
 if GetSuperiorAutoRect(AllowModifyX,AllowModifyY,NewWidth,NewHeight) then exit;
 GetRowsCols(AllowModifyX,AllowModifyY,NewWidth, NewHeight, dummyRows,dummyCols);
end;

constructor TdhEdit.Create(AOwner: TComponent);
begin
  inherited;
  IsScrollArea:=true;
  FVertScrollbarNeverVisible:=true;
  FHorzScrollbarNeverVisible:=true;
  Width:=121;
end;

function TdhEdit.GetFinal: ICon;
begin
  result:=nil;
  if AssertTags2 then
   result:=dhStrEditDlg.edit;
end;

function TdhCustomEdit.EffectsAllowed: boolean;
begin
 result:=false;
end;

procedure TdhCustomEdit.GetModifiedText(var pre, s, suc: HypeString);
begin
  suc:=#10;
end;

function TdhCustomEdit.InterpreteDirectly:Boolean;
begin
  result:=true;
end;

procedure TdhCustomEdit.Loaded;
begin
  inherited;
  Memorize;
end;

procedure TdhCustomEdit.Memorize;
begin                  
  FInitialValue:=FHTMLText;
end;

function TdhCustomEdit.NeedPadding(HasRastering:TRasterType): boolean;
begin
 result:=HasRastering<>rsNo;
end;

procedure TdhCustomEdit.Reset;
begin
 SetHTMLText(FInitialValue);
end;

procedure TdhEdit.SetHTMLText(const Value: HypeString);
begin
  inherited SetHTMLText(HypeSubstText(#13,' ',Value));
end;

procedure TdhEdit.SetPassword(const Value: boolean);
begin
 if FPassword<>Value then
 begin
  FPassword := Value;
  NotifyCSSChanged([wcText,wcNoOwnCSS]);
 end;
end;

procedure TdhEdit.GetModifiedText(var pre, s, suc: HypeString);
begin
 if FPassword then
  s:=StringOfChar('*',length(s));
 inherited;
end;

procedure TdhCustomEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 Inherited;
 if not (csDesigning in ComponentState) then
 begin
  StartOrContinueEditingAtMousePosition;
 end;
end;

end.
