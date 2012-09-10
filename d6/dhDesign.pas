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

unit dhDesign;

interface

{$IFDEF VER160}
{$UNSAFECODE ON}
{$ENDIF}

uses                    
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls, Qt,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, Dialogs,
  ShellAPI, ExtCtrls, StdCtrls,CommCtrl,
{$ENDIF}
  SysUtils, Classes, 
{$IFDEF CLX}
  DesignIntf,DesignEditors,ClxEditors,DesignMenus,RTLConsts,
{$ELSE}
{$IFDEF VER160}
  Borland.Vcl.Design.DesignIntf,Borland.Vcl.Design.DesignEditors,Borland.Vcl.Design.VCLEditors,Borland.Vcl.Design.DesignMenus,RTLConsts, {variants,}types,
{$ELSE}
  Consts,PicEdit,DesignIntf,DesignEditors,VCLEditors,DesignMenus,RTLConsts,
{$ENDIF}
{$ENDIF}
  dhMultiLine,typinfo, dhLabel,dhMenu,dhDirectHTML,dhPageControl,dhPanel,dhStyleSheet,dhStrUtils,dhStyles,dhColorUtils;

const StyleCol=clYellow;


type
  TCSSFontFamilyProperty = class(TFontNameProperty, ICustomPropertyListDrawing)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: AString); override;

    { ICustomPropertyListDrawing }
    procedure ListMeasureHeight(const Value: AnsiString; ACanvas: TCanvas;
      var AHeight: Integer);
    procedure ListMeasureWidth(const Value: AnsiString; ACanvas: TCanvas;
      var AWidth: Integer);
    procedure ListDrawValue(const Value: AString; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean);
  end;

  TCSSCursorProperty = class(TCursorProperty, ICustomPropertyListDrawing)
    function GetValue: AString; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: AString); override;
    procedure ListDrawValue(const Value: AnsiString; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean);
  end;

  TMyPictureProperty=class(TPictureProperty)
    procedure Edit; override;
    function GetValue: AString; override;
  end;

  TInhProperty = class(TEnumProperty)
  public
    function GetValue: AString; override;
    procedure SetValue(const Value: AString); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TMultiLineCaptionProperty = class(TCaptionProperty)
  protected
    procedure MemoChange(Sender: TObject);
  public
    function GetAttributes: TPropertyAttributes; override;
{$IFDEF WIN32}
    function GetEditLimit: Integer; override;
{$ENDIF}
    procedure Edit; override;
  end;

  TCSSCardinalProperty = class(TIntegerProperty)
    function GetValue: AString; override;
    procedure SetValue(const Value: AString); override;
  end;

  TCSSColorProperty = class(TColorProperty, ICustomPropertyDrawing, ICustomPropertyListDrawing)
    function GetValue: AString; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: AString); override;
    procedure ListDrawValue(const Value: AString; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
  end;

  TdhComponentEditor=class(TDefaultEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): AString; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  end;

  TdhLabelEditor=class(TdhComponentEditor)
    MyFirst: IProperty;
    procedure MyCheckEdit(const Prop: IProperty);
    procedure Edit; override;
  end;

  TStyleClassProperty=class(TClassProperty,ICustomPropertyDrawing)
    function GetValue: AString; override;
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
  end;

  TBorderClassProperty=class(TClassProperty)
    function GetValue: AString; override;
  end;

  TBorderRadiusClassProperty=class(TClassProperty)
    function GetValue: AString; override;
  end;

  TTransformationsProperty=class(TClassProperty)
    function GetValue: AString; override;
  end;

  TTargetProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TUseProperty = class(TComponentProperty)
  protected
    sProc: TGetStrProc;
    procedure _Proc(const S: AString);
  public
    //procedure SetValue(const Value: AString); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TFontSizeProperty = class(TStringProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TVerticalAlignProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: AString); override;
  end;

  TBackgroundPositionProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TBasedFormProperty = class(TComponentProperty)
  protected
    sProc: TGetStrProc;
    procedure _Proc(const S: AString);
  public
    //procedure SetValue(const Value: AString); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;



procedure Register;


implementation

function IsColorFormat(const Value: AString; var L:integer):boolean;
begin
 result:=dhColorUtils.IdentToColor(Value, L);
 if (Value<>'') and (Value[1]='#') and (length(Value)=7) then
 try
   L:=strtoint('$'+copy(Value,6,2))*256*256+strtoint('$'+copy(Value,4,2))*256+strtoint('$'+copy(Value,2,2));
   Result:=true;
 except
 end;
end;

procedure TCSSColorProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  if GetVisualValue <> '' then
    ListDrawValue(GetVisualValue, ACanvas, ARect, True{ASelected})
  else
    DefaultPropertyDrawValue(Self, ACanvas, ARect);
end;


procedure TCSSColorProperty.ListDrawValue(const Value: AString; ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
  function ColorToBorderColor(AColor: TColor): TColor;
  type
    TColorQuad = record
      Red,
      Green,
      Blue,
      Alpha: Byte;
    end;
  var Red,Green,Blue:integer;
  begin
    Red:=AColor and $FF;
    Green:=(AColor div 256) and $FF;
    Blue:=(AColor div (256*256)) and $FF;
    if (Red > 192) or
       (Green > 192) or
       (Blue > 192) then
      Result := clBlack
    else if ASelected then
      Result := clWhite
    else
      Result := AColor;
  end;
var
  Right: Integer;
  OldPenColor, OldBrushColor: TColor;
  L:integer;
begin
  Right := (ARect.Bottom - ARect.Top) {* 2} + ARect.Left;
  with ACanvas do
  begin
    // save off things
    OldPenColor := Pen.Color;
    OldBrushColor := Brush.Color;

    // frame things
    Pen.Color := Brush.Color;
    Rectangle(ARect.Left, ARect.Top, Right, ARect.Bottom);

    if IsColorFormat(Value,L) and (L<>Longint(colTransparent)) then
    begin
    Brush.Color := TColor(L);
    // set things up and do the work
    Pen.Color := ColorToBorderColor(ColorToRGB(Brush.Color));
    Rectangle(ARect.Left + 1, ARect.Top + 1, Right - 1, ARect.Bottom - 1);
    end else
     Right:=ARect.Left;//!

    // restore the things we twiddled with
    Brush.Color := OldBrushColor;
    Pen.Color := OldPenColor;
    DefaultPropertyListDrawValue(Value, ACanvas, Rect(Right, ARect.Top, ARect.Right,
      ARect.Bottom), ASelected);
  end;
end;



procedure TInhProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  EnumType: PTypeInfo;
begin
  EnumType := GetPropType;
  with GetTypeData(EnumType){$IFNDEF VER160}^{$ENDIF} do
  begin
      for I := MinValue+1 to MaxValue do Proc(GetHyphens(GetEnumName(EnumType, I)));
  end;
end;

function TInhProperty.GetValue: AString;
begin
 if GetOrdValue=0 then
  Result:='' else
  Result:=GetHyphens(Inherited GetValue);
end;


function GetInverseHyphens(const s:TEnumName):TEnumName;
var i:integer;
begin
 result:='-'+s;
 for i:=length(result) downto 1 do
 if result[i]='-' then
 begin
  if (i+1<=length(result)) and CharInSet(result[i+1],['a'..'z']) then
   result[i+1]:=chr(ord(result[i+1])+ord('A')-ord('a'));
  delete(result,i,1);
 end;
end;

function GetTwo(const s:TPropertyName):TEnumName;
var i:integer;
begin
 result:='';
 for i:=length(s) downto 1 do
 if CharInSet(s[i],['A'..'Z']) or (result='') and (i=2) then
  result:=s[i]+result;
 result:='c'+lowercase(copy(result,1,2));
 if s='Display' then
  result:='cds' else
 if s='Style' then
  result:='cbs'{ else
 if s='Cursor' then
  result:='ccr'};
end;

procedure TInhProperty.SetValue(const Value: AString);
begin
 if Value='' then
  SetOrdValue(0) else
  inherited SetValue(GetTwo(self.GetName)+GetInverseHyphens(Value));
end;


function TCSSCursorProperty.GetValue: AString;
begin
 if GetOrdValue=0 then
  Result:='' else
  Result:=GetHyphens({Inherited GetValue}CursorToString(TCSSCursor(GetOrdValue)));
(*  if TCSSCursor(GetOrdValue)=ccrInherit then
   Result:='' else
   Result:={CursorToString(TCSSCursor(GetOrdValue))}Inherited GetValue;
*)end;

procedure TCSSCursorProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  EnumType: PTypeInfo;
begin
  EnumType := GetPropType;
  with GetTypeData(EnumType){$IFNDEF VER160}^{$ENDIF} do
  begin
      for I := MinValue+1 to MaxValue do Proc(GetHyphens(GetEnumName(EnumType, I)));
  end;

{var i:TCSSCursor;
begin
 for i:=succ(low(TCSSCursor)) to high(TCSSCursor) do
  Proc(GetEnumName( TypeInfo( TCSSCursor ), Integer(i)));}
end;


function StringToCursor(const Ident: TEnumName): TCSSCursor;
begin
  Result:=TCSSCursor(GetEnumValue( TypeInfo( TCSSCursor ), Ident ));
end;

procedure TCSSCursorProperty.SetValue(const Value: AString);
begin
{ if Value='' then
  SetOrdValue(Longint(ccrInherit)) else
  SetOrdValue(Longint(StringToCursor(Value)));}
 if Value='' then
  SetOrdValue(0) else
  SetOrdValue(Longint(StringToCursor(GetTwo(self.GetName)+GetInverseHyphens(Value))));
//  inherited SetValue(GetTwo(self.GetName)+GetInverseHyphens(Value));
end;


procedure TCSSCursorProperty.ListDrawValue(const Value: AnsiString;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  Right: Integer;
  CursorIndex: Integer;
  CursorHandle: THandle;
  Cursor:TCSSCursor;
begin
{ if IdentToCursor(Value,CursorIndex) and CursorToIdent(CSSCursorMap[TCSSCursor(CursorIndex)],Ident) then
  Inherited ListDrawValue(Ident,ACanvas,ARect,ASelected) else
  Inherited;
}
  Right := ARect.Left + GetSystemMetrics(SM_CXCURSOR) + 4;
  with ACanvas do
  begin
    Cursor:=StringToCursor(GetTwo(self.GetName)+GetInverseHyphens(Value));
    if not (Cursor in [ccuInherit,ccuAuto]) then
    begin
    CursorIndex:=CSSCursorMap[Cursor];
    ACanvas.FillRect(ARect);
    CursorHandle := Screen.Cursors[CursorIndex];
    if CursorHandle <> 0 then
      DrawIconEx(ACanvas.Handle, ARect.Left + 2, ARect.Top + 2, CursorHandle,
        0, 0, 0, 0, DI_NORMAL or DI_DEFAULTSIZE);
    end else
     Right:=ARect.Left;
    DefaultPropertyListDrawValue(Value, ACanvas, Rect(Right, ARect.Top,
      ARect.Right, ARect.Bottom), ASelected);
  end;
end;


procedure Register;
begin
  RegisterComponentEditor(TdhStyleSheet,TdhComponentEditor);
  RegisterComponentEditor(TdhCustomPanel,TdhComponentEditor);
  RegisterComponentEditor(TdhLink,TdhLabelEditor);
  RegisterComponentEditor(TdhLabel,TdhLabelEditor);
  //RegisterComponentEditor(TdhDirectHTML,TdhLabelEditor);
  RegisterPropertyEditor(TypeInfo(HypeString), TdhPanel, 'Hint', TMultiLineCaptionProperty);
  RegisterPropertyEditor(TypeInfo(HypeString), TdhCustomPanel, 'Text', TMultiLineCaptionProperty);
  RegisterPropertyEditor(TypeInfo(HypeString), TdhDirectHTML, 'InnerHTML', TMultiLineCaptionProperty);
  RegisterPropertyEditor(TypeInfo(HypeString), TdhPage, 'HTMLBody', TMultiLineCaptionProperty);
  RegisterPropertyEditor(TypeInfo(HypeString), TdhPage, 'HTMLHead', TMultiLineCaptionProperty);
  RegisterPropertyEditor(TypeInfo(HypeString), TdhPage, 'MetaDescription', TMultiLineCaptionProperty);
  RegisterPropertyEditor(TypeInfo(HypeString), TdhPage, 'MetaKeywords', TMultiLineCaptionProperty);
  RegisterPropertyEditor(TypeInfo(TStyle), TdhCustomPanel, '', TStyleClassProperty);

  RegisterPropertyEditor(TypeInfo(TCSSBorder), TStyle, '', TBorderClassProperty);
  RegisterPropertyEditor(TypeInfo(TCSSBorderRadius), TStyle, '', TBorderRadiusClassProperty);
  RegisterPropertyEditor(TypeInfo(TTransformations), TStyle, '', TTransformationsProperty);
  RegisterPropertyEditor(TypeInfo(TCSSCardinal), nil, '', TCSSCardinalProperty);
  RegisterPropertyEditor(TypeInfo(TCSSInteger), nil, '', TCSSCardinalProperty);
  RegisterPropertyEditor(TypeInfo(TCSSColor), nil, '', TCSSColorProperty);
  RegisterPropertyEditor(TypeInfo(TCSSBorderStyle), nil, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSCursor), TStyle, '', TCSSCursorProperty);
  RegisterPropertyEditor(TypeInfo(TCSSTextTransform), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSBackgroundRepeat), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSBackgroundAttachment), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSWhiteSpace), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSTextAlign), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSDirection), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSFontVariant), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSFontWeight), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSFontStyle), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSDisplay), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSVisibility), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TCSSListStyleType), TStyle, '', TInhProperty);
  RegisterPropertyEditor(TypeInfo(TLocationImage), TStyle, '', TMyPictureProperty);
  //RegisterPropertyEditor(TypeInfo(TCSSAntiAliasing), TStyle, '', TInhProperty);

  RegisterPropertyEditor(TypeInfo(TCSSVerticalAlign), TStyle, 'VerticalAlign', TVerticalAlignProperty);
  RegisterPropertyEditor(TypeInfo(TCSSBackgroundPosition), TStyle, 'BackgroundPosition', TBackgroundPositionProperty);

  RegisterPropertyEditor(TypeInfo(TCSSFontSize), TStyle, 'FontSize', TFontSizeProperty);
  RegisterPropertyEditor(TypeInfo(TCSSFontFamily), TStyle, 'FontFamily', TCSSFontFamilyProperty);


  RegisterPropertyEditor(TypeInfo(AnsiString), TdhLink, 'Target', TTargetProperty);
  RegisterPropertyEditor(TypeInfo(TControl), TdhCustomPanel, 'Use', TUseProperty);

  RegisterPropertyEditor(TypeInfo(TdhLink), TdhCustomPanel, 'LinkAnchor', TBasedFormProperty);

end;



function TCSSCardinalProperty.GetValue: AString;
begin
 if GetOrdValue=MaxInt then
  Result:=srInherit else
  Result:=Inherited GetValue;
end;

procedure TCSSCardinalProperty.SetValue(const Value: AString);
begin
 if SameText(Value,srInherit) then
  SetOrdValue(vsrInherit) else
  Inherited;
end;

function TCSSColorProperty.GetValue: AString;
begin
  Result := dhColorUtils.ColorToString(TColor(GetOrdValue));
end;


procedure GetColorValues(Proc: TGetStrProc);
begin
  ListColorValues(Proc);
end;

procedure TCSSColorProperty.GetValues(Proc: TGetStrProc);
begin
  GetColorValues(Proc);
end;

procedure TCSSColorProperty.SetValue(const Value: AString);
var
  NewValue: Longint;
begin
  if IsColorFormat(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;

{$IFDEF WIN32}
 {$D-}
{$ENDIF}

function TMultiLineCaptionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{$IFDEF WIN32}
function TMultiLineCaptionProperty.GetEditLimit: Integer;
begin
  if GetPropType^.Kind = tkString then
    Result := GetTypeData(GetPropType)^.MaxLength
  else Result := 1024;
end;
{$ENDIF}


procedure TMultiLineCaptionProperty.Edit;
var
  OriginalValue: HypeString;
  Comp: TPersistent;
begin
  with TdhMultiLine.Create(Application) do
  try
    Comp := GetComponent(0);
    if Comp is TComponent then
      Caption := TComponent(Comp).Name + '.' + GetName
    else
      Caption := GetName;
    OriginalValue := GetStrValue;
    Memo.Lines.Text := OriginalValue;
    Memo.OnChange := Self.MemoChange;
    if ShowModal = mrOk then
      SetStrValue(Memo.Text) else
      SetStrValue(OriginalValue);
  finally
    Free;
  end;
end;



procedure TMultiLineCaptionProperty.MemoChange(Sender: TObject);
begin
 SetStrValue((Sender as TMemo).Text);
end;


procedure TFontSizeProperty.GetValues(Proc: TGetStrProc);
begin
 proc('xx-small');
 proc('x-small');
 proc('small');
 proc('medium');
 proc('large');
 proc('x-large');
 proc('xx-large');
 proc('smaller');
 proc('larger');  {
 proc('1.5em');
 proc('15px');  }
end;


function TBackgroundPositionProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=[paValueList, paRevertable];
end;

procedure TBackgroundPositionProperty.GetValues(Proc: TGetStrProc);
begin
 proc('0% 0%');
 proc('50% 0%');
 proc('100% 0%');
 proc('0% 50%');
 proc('50% 50%');
 proc('100% 50%');
 proc('0% 100%');
 proc('50% 100%');
 proc('100% 100%');
end;



procedure TVerticalAlignProperty.SetValue(const Value: AString);
var s:AString;
begin
 s:=LowerCase(Trim(Value));
 if SubEqualEnd('px',s) then
  s:=CopyLess(s,2);
 inherited SetValue(s);
end;

procedure TVerticalAlignProperty.GetValues(Proc: TGetStrProc);
begin
 proc('baseline');
 proc('sub');
 proc('super');
 proc('top');
 proc('text-top');
 proc('middle');
 proc('bottom');
 proc('text-bottom');
end;


function TVerticalAlignProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=[paValueList, paRevertable];
end;


procedure TStyleClassProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
var
    st:TStyle;
    pn:TdhCustomPanel;
begin
  if not _RuntimeMode and (PropCount=1) and (GetComponent(0) is TdhCustomPanel) then
  begin
  pn:=TdhCustomPanel(GetComponent(0));
  if pn.GetStyleByName(GetName,st) and (st=pn.ActStyle) then
  begin
    ACanvas.Brush.Color := StyleCol;
    ACanvas.FillRect(ARect);
    if not pn.ActStyle.IsStyleStored then
     ACanvas.Pen.Color:=clGray;
  end;
  end;

  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

procedure TdhLabelEditor.Edit;
var
  Components: IDesignerSelections;
begin
  Components := TDesignerSelections.Create;
  Components.Add(Component);
  MyFirst := nil;
  try
    GetComponentProperties(Components, tkAny, Designer, MyCheckEdit);
    if Assigned(MyFirst) then
        MyFirst.Edit;
  finally
    MyFirst := nil;
  end;
end;

procedure TdhLabelEditor.MyCheckEdit;
begin
 if SameText(Prop.GetName,'CAPTION') or SameText(Prop.GetName,'HTML')  or SameText(Prop.GetName,'InnerHTML') then
  MyFirst:=Prop;
end;

function TStyleClassProperty.GetValue: AString;
var
    st:TStyle;
    pn:TdhCustomPanel;
begin
  if (PropCount=1) and (GetComponent(0) is TdhCustomPanel) then
  begin
  pn:=TdhCustomPanel(GetComponent(0));
  if pn.GetStyleByName(GetName,st) and not st.IsStyleStored then
  begin
    result:='';
    exit;
  end;
  end;
  result:=inherited GetValue;
end;

function TBorderClassProperty.GetValue: AString;
var st:TStyle;
var Border:TCSSBorder;
begin
  if (PropCount=1) and (GetComponent(0) is TStyle) then
  begin
   st:=TStyle(GetComponent(0));
   if st.GetBorderByName(GetName,Border) and not Border.IsStored then
   begin
    result:='';
    exit;
   end;
  end;
  result:= inherited GetValue;
end;


procedure TStyleClassProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
begin
 { if not RuntimeMode and (PropCount=1) and (GetComponent(0) is TdhCustomPanel) then
  begin
   pn:=TdhCustomPanel(GetComponent(0));
   if (pn.GetStyleByName(GetName)<>nil) and (pn.GetStyleByName(GetName)<>pn.ActStyle) then
   begin
    ACanvas.TextRect(ARect, ARect.Left + 1, ARect.Top + 1, 'nix');
    exit;
   end;
  end;   }
   DefaultPropertyDrawValue(Self, ACanvas, ARect);
end;

procedure TdhComponentEditor.ExecuteVerb(Index: Integer);
var pn:TdhCustomPanel;
    StyleSheet:TdhStyleSheet;
begin
 case Index of
 0: DesignStyle:=hsNormal;
 1: DesignStyle:=hsDown;
 2: DesignStyle:=hsOver;
// 2: self.Designer.SelectComponent((GetComponent as TdhLink).FSubMenu);
 3: DesignStyle:=hsOverDown;
 4: _RuntimeMode:=true;
 5:
    if _RuntimeMode then
     showmessage('Not available in Runtime Mode') else
    if Component is TdhStyleSheet then
     showmessage('Please choose a style') else   
    if (Component is TdhCustomPanel) then
     begin
      pn:=TdhCustomPanel(Component);
      {if ShowInfo=nil then
       ShowInfo:=TShowInfo.Create(Application);
      ShowInfo.LoadInfo(pn);
      ShowInfo.ShowModal;}
      //showmessage((Component as TdhCustomPanel).ActStyle.GetInfo);
     end;
 6:;
 7:
 if InStyleSheet(Component as TControl,StyleSheet) then
   StyleSheet.AddStyle(false) else
 if Component is TdhMenu then
   TdhMenu(Component).AddMenuItem else
 if Component is TdhLink then
 if TdhLink(Component).Parent is TdhMenu then
  TdhMenu(TdhLink(Component).Parent).AddMenuItem else
  showmessage('No parent menu found !');

 8:   
 if InStyleSheet(Component as TControl,StyleSheet) then
   StyleSheet.AddStyle(true) else
  (Component as TdhLink).AddSubMenu.Visible:=true{(false)};
 end;
 if (Index>=0) and (Index<=2) then
  _RuntimeMode:=False;

 if (Component is TdhCustomPanel) then
  TdhCustomPanel(Component).CheckDesignState;
end;

function TdhComponentEditor.GetVerb(Index: Integer): AString;
var StyleSheet:TdhStyleSheet;
begin
 case Index of
 0: Result:='Edit Main Style';
 1: Result:='Edit Down Style';
 2: Result:='Edit Over Style';
 3: Result:='Edit OverDown Style';
 4: Result:='Runtime Mode';
 5: Result:='Show Info';
 6: Result:='-';
 7:
 if InStyleSheet(Component as TControl,StyleSheet)  then
   Result:='Add Style' else
   Result:='Insert Menu Item';
 8:
 if InStyleSheet(Component as TControl,StyleSheet)  then
   Result:='Add Link' else
   Result:='Create Submenu';
 end;
end;

function TdhComponentEditor.GetVerbCount: Integer;
var StyleSheet:TdhStyleSheet;
begin
 Result := 6;
 if InStyleSheet(Component as TControl,StyleSheet) then
  inc(Result,3) else
 if Component is TdhLink then
  inc(Result,3) else
 if Component is TdhMenu then
  inc(Result,2);
end;

const posi:array[TState] of integer=(0,2,1,3);
procedure TdhComponentEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
begin
 if (Index>=0) and (Index<=4) then
 begin
  AItem.GroupIndex:=3;
  AItem.RadioItem:=true;
 end;
 if (Index>=0) and (Index<=3) then
  AItem.Checked:=not _RuntimeMode and (posi[DesignStyle]=Index) else
 if Index=4 then
  AItem.Checked:=_RuntimeMode;
{ if AItem.Parent<>nil then
   showmessage(inttostr(AItem.Parent.Count));}
{ for i:=0 to AItem.Parent.Count-1 do
  AItem.Items[i].RadioItem:=true;}
end;

(*

constructor TdhComponentEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited;
{ try
  if (Component=nil) or not (Component is TdhCustomPanel) then
  begin
   if (Component=nil) then
    showmessage('TdhComponentEditor.Create: Component=nil') else
    showmessage('TdhComponentEditor.Create: Component:'+Component.ClassName+'/'+Component.Name);
   exit;
  end;
  TdhCustomPanel(Component).IsDesignerSelected:=true;
//  showmessage('create:'+Component.Name);
 except
 on e:exception do showmessage('Ex Create:'+e.Message+' :'+BoolToStr(csDestroying in Component.ComponentState));
 end;
 }
end;
*)

function TTargetProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=[paValueList, paRevertable];
end;

procedure TTargetProperty.GetValues(Proc: TGetStrProc);
begin
 Proc('_blank');
 Proc('_self');
 Proc('_parent');
 Proc('_top');
end;



procedure TUseProperty._Proc(const S: AString);
var pn:TdhCustomPanel;
begin
 if UsefulUse(Designer.GetComponent(S),GetComponent(0),false,pn) then
  sProc(S);
end;

procedure TUseProperty.GetValues(Proc: TGetStrProc);
begin
  sProc:=Proc;
  Designer.GetComponentNames(GetTypeData(GetPropType), _Proc);
end;
             {
procedure TUseProperty.SetValue(const Value: AString);
var
  Component: TComponent;
begin
    Component := Designer.GetComponent(Value);
    if Component.Owner<>nil then
     showmessage(Component.Owner.Name);
 inherited;
end;
           }


procedure TBasedFormProperty._Proc(const S: AString);
var c:TComponent;
begin
 c:=Designer.GetComponent(s);
 if c=nil then exit;
 if not (GetComponent(0) is TdhLink) or not (c is TWinControl) then exit;
 if (TdhLink(GetComponent(0)).LinkBase<>GetTopForm(TWinControl(c))) then exit;
 sProc(S);
end;

procedure TBasedFormProperty.GetValues(Proc: TGetStrProc);
begin
  sProc:=Proc;
  Designer.GetComponentNames(GetTypeData(GetPropType),_Proc);
end;

function TCSSFontFamilyProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=[paMultiSelect, paValueList, paRevertable];
end;

procedure TCSSFontFamilyProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin                     
  Proc('serif');
  Proc('sans-serif');
  Proc('cursive');
  Proc('fantasy');
  Proc('monospace');
  proc('Courier New, Courier, monospace');
  Proc('MS Serif, New York, serif');
  Proc('Times New Roman, Times, serif');
  Proc('MS Sans Serif, Geneva, sans-serif');
  Proc('Verdana, Geneva, Arial, Helvetica, sans-serif');
  Proc('Arial, Helvetica, sans-serif');
  inherited GetValues(Proc);
end;

const ExText='ABCabc';

procedure TCSSFontFamilyProperty.ListDrawValue(const Value: AString;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  OldFontName: AString;
  w:integer;
  r:TRect;
begin
    with ACanvas do
    begin
      TextRect(ARect, ARect.Left + 2, ARect.Top + 1, Value);

      // save off things
      OldFontName := Font.Name;

      // set things up and do work
      Font.Name := GetNearestFont(Value);
      w:=TextWidth(ExText);
      r:=Rect(ARect.Right - 2 -w,ARect.Top,ARect.Right,ARect.Bottom);
      TextRect(r, ARect.Right - 2 -w, ARect.Top + 1, ExText);

      // restore things
      Font.Name := OldFontName;
    end;
end;

procedure TCSSFontFamilyProperty.ListMeasureHeight(const Value: AnsiString;
  ACanvas: TCanvas; var AHeight: Integer);
var
  vOldFontName: AnsiString;
begin
{    with ACanvas do
    begin
      // save off things
      vOldFontName := Font.Name;

      // set things up and do work
      Font.Name := GetNearestFont(Value);
      AHeight := TextHeight(Value) + 2;

      // restore things
      Font.Name := vOldFontName;
    end;    }
end;

procedure TCSSFontFamilyProperty.ListMeasureWidth(const Value: AnsiString;
  ACanvas: TCanvas; var AWidth: Integer);
var
  vOldFontName: AnsiString;
begin
{    with ACanvas do
    begin
      // save off things
      vOldFontName := Font.Name;

      // set things up and do work
      Font.Name := GetNearestFont(Value);
      AWidth := TextWidth(Value) + 26;//!4;

      // restore things
      Font.Name := vOldFontName;
    end;
    }
//    AWidth:=200;
end;


procedure TCSSFontFamilyProperty.SetValue(const Value: AString);
var s:AString;
begin
 s:=Value;
 s:=StringReplace(s,'"','',[rfReplaceAll, rfIgnoreCase]);
 s:=StringReplace(s,'''','',[rfReplaceAll, rfIgnoreCase]);
 inherited SetValue(s);
end;

procedure TMyPictureProperty.Edit;
var
  PictureEditor: TPictureEditor;
begin
  PictureEditor := TPictureEditor.Create(nil);
  try
    PictureEditor.Picture := TLocationImage(Pointer(GetOrdValue)).Picture;
    if PictureEditor.Execute then
      SetOrdValue(Longint(PictureEditor.Picture));
  finally
    PictureEditor.Free;
  end;
end;

function TMyPictureProperty.GetValue: AString;
var
  Picture: TPicture;
begin
  Picture := TLocationImage(GetOrdValue).Picture;
  if (Picture=nil) or (Picture.Graphic = nil) then
    Result := srNone else
    Result := '(' + Picture.Graphic.ClassName + ')';
end;

function TBorderRadiusClassProperty.GetValue: AString;
var st:TStyle;
begin
  if (PropCount=1) and (GetComponent(0) is TStyle) then
  begin
   st:=TStyle(GetComponent(0));
   if st.BorderRadius.IsCleared then
   begin
    result:='';
    exit;
   end;
  end;
  result:= inherited GetValue;
end;

function TTransformationsProperty.GetValue: AString;
var st:TStyle;
begin
  if (PropCount=1) and (GetComponent(0) is TStyle) then
  begin
   st:=TStyle(GetComponent(0));
   if st.Effects.IsCleared then
   begin
    result:='';
    exit;
   end;
  end;
  result:= inherited GetValue;
end;


initialization

finalization

// FreeAndNil(ShowInfo);

end.


