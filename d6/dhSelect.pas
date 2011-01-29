unit dhSelect;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls, QComCtrls,  QStdCtrls, QClipbrd, QMenus,
  {$ELSE}
  Controls, Windows, Messages, Graphics, StdCtrls, dialogs, Forms, clipbrd,
  {$ENDIF}
  dhLabel,dhEdit, SysUtils, Classes, math, dhPanel,dhStrUtils,dhStyles;

type
  TSelectType=(stDropDown,stList);

  TSelectOption = class(TCollectionItem)
  private
    FText,FValue: HypeString;
    FSelected,FInitialValue:boolean;
    procedure SetText(const Value: HypeString);
    procedure SetValue(const Value: HypeString);
    procedure SetSelected(const Value: boolean);
  protected
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    function GetEffectiveValue:HypeString;
    procedure BeTheOnlySelection;
  published
    property Text: HypeString read FText write SetText;
    property Value: HypeString read FValue write SetValue;
    property Selected: boolean read FSelected write SetSelected default false;
  end;

  TOnGetDisplayText=procedure (Sender:TObject; Item:TSelectOption; var DisplayText:HypeString) of object;

  TdhSelect=class;

  TSelectOptions = class(TCollection)
  private
    FdhSelect: TdhSelect;
    function GetItem(Index: Integer): TSelectOption;
    procedure SetItem(Index: Integer; Value: TSelectOption);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(dhSelect: TdhSelect);
    function Add: TSelectOption;
    property Items[Index: Integer]: TSelectOption read GetItem write SetItem; default;
  end;

  TdhPopupDataList=class;

  TdhSelect = class(TdhCustomEdit)
  private
    FItems: TSelectOptions;
    FType:TSelectType;
    FMultiple: Boolean;
    FDataList:TdhPopupDataList;
    FOnGetDisplayText: TOnGetDisplayText;
    procedure SetItems(const Value: TSelectOptions);
    procedure RecreateText;
    procedure SetSelectType(const Value: TSelectType);
    procedure AdjustToType;
    function ListBox: boolean;
    procedure UpdateScrollPosition;
    function EffectiveMultiSelect: boolean;
    procedure SetMultiple(const Value: boolean);
    procedure UpdateSelections;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CloseUp(Accept: Boolean); virtual;
    procedure DropDown;
    function GetOverLine: integer;
{$IFNDEF CLX}
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
{$ENDIF}
    function GetCount: integer;
  protected
    procedure ProcessFrameEvent(FrameEventType: TFrameEventType); override;
    procedure Loaded; override;
    function GetFinal: ICon; override;
    procedure GetModifiedText(var pre,s,suc:HypeString); override;
    function InterpreteDirectly:Boolean; override;
    function IncludeBorderAndPadding:boolean; override;
    procedure GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows, Cols: Integer); override;
    procedure DoCSSToWinControl(WhatChanged: TWhatChanged); override;
    procedure KeyPress(var Key: AChar); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Reset;
    procedure Memorize;
    function Value:HypeString;
    procedure Click; override;
    function SelectedIndex: integer;
    property Count:integer read GetCount;
  published
    property Items: TSelectOptions read FItems write SetItems;
    property SelectType:TSelectType read FType write SetSelectType;
    property Multiple:boolean read FMultiple write SetMultiple default False;
    property OnGetDisplayText:TOnGetDisplayText read FOnGetDisplayText write FOnGetDisplayText;
  end;

  TdhPopupDataList = class(TdhSelect)
  private
    procedure DoExit; override;
  protected
{$IFNDEF CLX}
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure CreateParams(var Params: TCreateParams); override;
{$ELSE}
    procedure InitWidget; override;
    function WidgetFlags: Integer; override;
{$ENDIF}
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function GetFinal: ICon; override;
  public
{$IFNDEF CLX}
    constructor Create(AOwner: TComponent); override;
{$ELSE}
    constructor CreateParented(ParentWidget: QWidgetH);
{$ENDIF}
  end;

procedure Register;

implementation

uses BasicHTMLElements;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhSelect]);
end;

constructor TdhSelect.Create(AOwner: TComponent);
begin
 inherited;
 FItems := TSelectOptions.Create(Self);
 ControlStyle:=ControlStyle-[csClickEvents];
 AutoSizeXY:=asY;
 AdjustToType;
 Width:=121;
end;

procedure TdhSelect.AdjustToType;
begin
 if ListBox then
 begin
  IsScrollArea:=true;
  FOneButton:=false;
  FHorzScrollbarNeverVisible:=true;
  FVertScrollbarAlwaysVisible:=true;
 end else
 begin
  IsScrollArea:=true;
  FOneButton:=true;
  FHorzScrollbarNeverVisible:=true;
  FVertScrollbarAlwaysVisible:=true;
 end;
 UpdateSelections;
 ScrollingParametersChanged;
end;

function TdhSelect.GetFinal: ICon;
begin
 if AssertTags2 then
  result:=dhStrEditDlg.listbox else
  result:=nil;
end;

procedure TdhSelect.RecreateText;

function GetDisplayText(i:integer):HypeString;
begin
   result:=ConvertWideStringToUnicode(Items[i].FText,true);
   if result='' then
    result:='&nbsp;';
   if Assigned(FOnGetDisplayText) then FOnGetDisplayText(Self,Items[i],result);
end;

var i,index:integer;
var s:HypeString;
begin
  s:='';
  if ListBox then
  begin
   for i:=0 to Count-1 do
   if Items[i].Selected then
    s:=s+'<selectedlistboxitem>'+GetDisplayText(i)+'</selectedlistboxitem>'{+endl_main} else
    s:=s+'<listboxitem>'+GetDisplayText(i)+'</listboxitem>'{+endl_main};
  end else
  if Count<>0 then
  begin
   index:=max(SelectedIndex,0);
   s:='<listboxitem>'+GetDisplayText(index)+'</listboxitem>'{+endl_main};
   for i:=0 to Count-1 do
   if i<>index then
    s:=s+'<listboxitem><hidden>'+GetDisplayText(i)+'</hidden></listboxitem>'{+endl_main};
  end;
  if s='' then
   s:='&nbsp;&nbsp;';
  SetHTMLText(s);
  UpdateScrollPosition;
end;

destructor TdhSelect.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

procedure TdhSelect.Loaded;
begin
  inherited;
  RecreateText;
  Memorize;
end;

procedure TdhSelect.Reset;
var i:integer;
begin
  for i:=0 to Count-1 do
   Items[i].Selected:=Items[i].FInitialValue;
end;

procedure TdhSelect.SetItems(const Value: TSelectOptions);
begin
 FItems.Assign(Value);
end;

procedure TdhSelect.GetModifiedText(var pre, s, suc: HypeString);
begin
 //do nothing
end;

function TdhSelect.InterpreteDirectly:Boolean;
begin
  result:=false;
end;

function TdhSelect.IncludeBorderAndPadding:boolean;
begin
 result:=true;
end;

function TdhSelect.Value: HypeString;
var i:integer;
begin
 result:='';
 for i:=0 to Count-1 do
 if Items[i].Selected then
  result:=result+Items[i].GetEffectiveValue;
end;


procedure TdhSelect.Memorize;
var i:integer;
begin
  for i:=0 to Count-1 do
   Items[i].FInitialValue:=Items[i].Selected;
end;

procedure TSelectOption.Assign(Source: TPersistent);
begin
  if Source is TSelectOption then
  begin
    Text := TSelectOption(Source).Text;
    Value := TSelectOption(Source).Value;
    Selected := TSelectOption(Source).Selected;
  end
  else inherited Assign(Source);
end;

constructor TSelectOption.Create(Collection: TCollection);
begin
  inherited;
end;

function TSelectOption.GetEffectiveValue: HypeString;
begin
 if FValue<>'' then
  result:=FValue else
  result:=FText;
end;

procedure TSelectOption.SetSelected(const Value: boolean);
begin
  if FSelected <> Value then
  begin
    FSelected := Value;
    if FSelected and not TSelectOptions(Collection).FdhSelect.EffectiveMultiSelect then
     BeTheOnlySelection;
    Changed(false);
  end;
end;

function TdhSelect.EffectiveMultiSelect:boolean;
begin
 result:=ListBox and FMultiple;
end;


procedure TSelectOption.SetText(const Value: HypeString);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed(true);
  end;
end;

procedure TSelectOption.SetValue(const Value: HypeString);
begin
  FValue:=Value;
end;

procedure TdhSelect.DropDown;
var
  P: TPoint;
  Y: Integer;
begin
  FDataList.Width:=Width;
  FDataList.Items.Assign(Items);
  
  P := Parent.ClientToScreen(Point(Left, Top));
  Y := P.Y + Height;
  if Y + FDataList.Height > Screen.Height then Y := P.Y - FDataList.Height;

  {SetWindowPos(FDataList.Handle, HWND_TOP, P.X, Y, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);}
  FDataList.Top:=Y;
  FDataList.Left:=P.X;
  FDataList.Visible := true;
  //FDataList.SetFocus;
end;


procedure TdhSelect.ProcessFrameEvent(FrameEventType: TFrameEventType);
begin
 if not (csDesigning in ComponentState) and false then
 if (FrameEventType=feMouseDown) then
 if (ActDown=amNone) and (GetActDown=VertOneButton) then
 begin
  if FDataList=nil then
  begin
{$IFDEF CLX}      
  FDataList := TdhPopupDataList.CreateParented(QApplication_Desktop);
{$ELSE}
  FDataList := TdhPopupDataList.Create(Self);
  FDataList.Visible := False;    
  FDataList.Parent := Self;
{$ENDIF}                      
  FDataList.OnMouseUp := ListMouseUp;
  end;
  if FDataList.Visible then
   CloseUp(false) else
   DropDown;

  (*sel:=TdhPopupDataList.CreateParented(Application.Handle);
   TDBLookupCombobox

  {sel:=TdhSelect.Create(Owner);
  sel.Parent:=(Owner as TWinControl);  }
  //sel.ParentWindow:=(Owner as TWinControl).Handle;
  sel.CreateHandle;
  sel.SelectType:=stList;
  sel.SetBounds(200,200,200,200);
  sel.Visible:=true;*)
 end;
 inherited;
end;

function TSelectOptions.Add: TSelectOption;
begin  
 Result := TSelectOption(inherited Add);
end;

constructor TSelectOptions.Create(dhSelect: TdhSelect);
begin   
 inherited Create(TSelectOption);
 FdhSelect := dhSelect; 
end;

function TSelectOptions.GetItem(Index: Integer): TSelectOption;
begin  
  Result := TSelectOption(inherited GetItem(Index));
end;

function TSelectOptions.GetOwner: TPersistent;
begin
 result:=FdhSelect;
end;

procedure TSelectOptions.SetItem(Index: Integer; Value: TSelectOption);
begin   
  inherited SetItem(Index, Value);
end;

procedure TSelectOptions.Update(Item: TCollectionItem);
begin
 if Item<>nil then
  FdhSelect.Click;
 FdhSelect.RecreateText;
end;

procedure TdhSelect.SetSelectType(const Value: TSelectType);
begin
 if FType<>Value then
 begin
  FType := Value;
  AdjustToType;
  if not (csLoading in ComponentState) then
  begin
   with AllEdgesPure do
   if ListBox then
    Height:=TextExtent('Wg').cy*4+Bottom+Top else
    Height:=TextExtent('Wg').cy+Bottom+Top;
   RecreateText;
  end;
 end;
end;

procedure TdhSelect.GetRowsCols(AllowModifyX, AllowModifyY: boolean;
  var NewWidth, NewHeight, Rows, Cols: Integer);
begin
  Rows:=0;
  Cols:=0;
  with AllEdgesPure do
  if ListBox then
  begin
   if AllowModifyY then
    NearestMod(TextExtent('Wg').cy,Bottom+Top,NewHeight,Rows);
  end else
  begin
   if AllowModifyY then
    NewHeight:=TextExtent('Wg').cy+Bottom+Top;
  end;
  if AllowModifyX then
   NewWidth:=GetAutoRectPoint(AllowModifyX,AllowModifyY,NewWidth,NewHeight).X;
end;

procedure TdhSelect.DoCSSToWinControl(WhatChanged: TWhatChanged);
begin
  inherited;    
  UpdateScrollPosition;
end;

function TdhSelect.ListBox:boolean;
begin
 result:=FType=stList;
end;

procedure TdhSelect.UpdateScrollPosition;
begin
{  if not HandleAllocated then exit;
  if not ListBox then
   SetVPos(SelectedIndex*TextExtent('Wg').cy);}
end;

function TdhSelect.SelectedIndex:integer;
begin
  for result:=0 to Count-1 do
  if Items[result].Selected then
   exit;
  result:=-1;
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

function CountPos(const subtext: string; Text: string): Integer;
begin
  if (Length(subtext) = 0) or (Length(Text) = 0) or (Pos(subtext, Text) = 0) then
    Result := 0
  else
    Result := (Length(Text) - Length(StringReplace(Text, subtext, '', [rfReplaceAll]))) div
      Length(subtext);
end;

function TdhSelect.GetOverLine:integer;
var OverCharPrefix:HypeString;
begin
 result:=-1;
 if GetOverChar<>0 then
 begin
  OverCharPrefix:=Copy(FHTMLText,1,GetOverChar);
  result:=CountPos('<selectedlistboxitem>',OverCharPrefix)+CountPos('<listboxitem>',OverCharPrefix); //CountChar(FHTMLText,endl_main,1,GetOverChar);
  if result>Count-1 then
   result:=-1;
 end;
end;


procedure TdhSelect.Click;
begin
 Inherited;
 Update;
end;

procedure TSelectOption.BeTheOnlySelection;
var i:integer;
begin
 Selected:=true;
 Collection.BeginUpdate;
 for i:=0 to TSelectOptions(Collection).Count-1 do
  TSelectOptions(Collection).Items[i].Selected:=TSelectOptions(Collection).Items[i]=Self;
 Collection.EndUpdate;
end;


procedure TdhSelect.SetMultiple(const Value: boolean);
begin
 if FMultiple<>Value then
 begin
  FMultiple := Value;
  UpdateSelections;
 end;
end;

procedure TdhSelect.UpdateSelections;
begin
 if not EffectiveMultiSelect and (SelectedIndex>=0) then
  Items[SelectedIndex].BeTheOnlySelection;
end;

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


procedure TdhSelect.KeyPress(var Key: AChar);
begin
 inherited;
end;

{$IFNDEF CLX}

constructor TdhPopupDataList.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  SelectType:=stList;
  FVertScrollbarAlwaysVisible:=false;
end;

{$ELSE}

constructor TdhPopupDataList.CreateParented(ParentWidget: QWidgetH);
begin      
  inherited;
  ControlStyle := ControlStyle + [csNoDesignVisible, csCaptureMouse, csReplicatable]; 
  SelectType:=stList;
  FVertScrollbarAlwaysVisible:=false;
end;

{$ENDIF}

{$IFNDEF CLX}

procedure TdhPopupDataList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP{ or WS_BORDER};
    ExStyle := WS_EX_TOOLWINDOW;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end; 
end;

procedure TdhPopupDataList.WMKillFocus(var Message: TMessage);
begin
 MouseUp(mbLeft,[],0,0);
end;

procedure TdhPopupDataList.WMMouseActivate(var Message: TMessage);
begin
 Message.Result := MA_NOACTIVATE;
end;

{$ELSE}

procedure TdhPopupDataList.InitWidget;
begin
  inherited;
  Visible := False;
end;

function TdhPopupDataList.WidgetFlags: Integer;
begin
  Result :=  inherited WidgetFlags
              or Integer(WidgetFlags_WType_Popup)
              or Integer(WidgetFlags_WStyle_Tool)
              or Integer(WidgetFlags_WNorthWestGravity);
end;

{$ENDIF}

procedure TdhPopupDataList.DoExit;
begin
 MouseUp(mbLeft,[],0,0);
end;

function TdhPopupDataList.GetFinal: ICon;
begin
 if AssertTags2 then
  result:=dhStrEditDlg.menupopup else
  result:=nil;
end;

procedure TdhPopupDataList.MouseMove(Shift: TShiftState; X, Y: Integer);
begin    
   if GetOverLine<>-1 then
    Items[GetOverLine].BeTheOnlySelection;
   inherited;
end;

procedure TdhSelect.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin          
  if Button = mbLeft then
    CloseUp(PtInRect(FDataList.ClientRect, Point(X, Y)));
end;

procedure TdhSelect.CloseUp(Accept: Boolean);
begin
 if Accept then
  Items[FDataList.SelectedIndex].Selected:=true;
 FDataList.Visible:=false;
end;

{$IFNDEF CLX}
procedure TdhSelect.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result:=DLGC_WANTARROWS;
end;
{$ENDIF}

procedure TdhSelect.KeyDown(var Key: Word; Shift: TShiftState);
begin
 case (Key) of
 VK_DOWN:
 begin
  if SelectedIndex+1<=Count-1 then
   Items[SelectedIndex+1].BeTheOnlySelection;
 end;
 VK_UP:
 begin
  if SelectedIndex-1>=0 then
   Items[SelectedIndex-1].BeTheOnlySelection;
 end;
 end;
end;

procedure TdhSelect.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 if not (csDesigning in ComponentState) then
 begin
 SetFocus;
 if ListBox then
 if GetOverLine<>-1 then
 if ssCtrl in GetShiftState then
  Items[GetOverLine].Selected:=not Items[GetOverLine].Selected else
  Items[GetOverLine].BeTheOnlySelection;
 end;
 Inherited;
end;

function TdhSelect.GetCount: integer;
begin
 result:=Items.Count;
end;

end.




