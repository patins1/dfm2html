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
{$IFDEF VER130}
  dsgnintf, toolintf, Menus, Consts,
{$ELSE}
  Consts,PicEdit,DesignIntf,DesignEditors,VCLEditors,DesignMenus,RTLConsts, {variants, }
{$ENDIF}
{$ENDIF}
{$ENDIF}
  //stredit,
  (*ToolsAPI,*)dhMultiLine,typinfo, dhLabel,dhMenu,dhDirectHTML,dhPageControl;

const StyleCol=clYellow;


type

{$IFDEF VER130}
  IMenuItem=TMenuItem;
  IProperty=TPropertyEditor;
  TDesignerSelections=TDesignerSelectionList;
{$ENDIF}



  TCSSFontFamilyProperty = class(TFontNameProperty{$IFNDEF VER130}, ICustomPropertyListDrawing{$ENDIF})
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;

    { ICustomPropertyListDrawing }
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFDEF VER130} override;{$ENDIF}
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer); {$IFDEF VER130} override;{$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFDEF VER130} override;{$ENDIF}
  end;

  TCSSCursorProperty = class(TCursorProperty{$IFNDEF VER130}, ICustomPropertyListDrawing{$ENDIF})
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFDEF VER130} override;{$ENDIF}
  end;

  TMyPictureProperty=class(TPictureProperty)
    procedure Edit; override;
    function GetValue: string; override;
  end;

  TInhProperty = class(TEnumProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TMultiLineCaptionProperty = class(TCaptionProperty)
  protected
    procedure MemoChange(Sender: TObject);
    procedure _Proc(const S: string);
  public
    function GetAttributes: TPropertyAttributes; override;
{$IFDEF WIN32}
    function GetEditLimit: Integer; override;
{$ENDIF}
    procedure Edit; override;
  end;

  TCSSCardinalProperty = class(TIntegerProperty)
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  TCSSColorProperty = class(TColorProperty{$IFNDEF VER130}, ICustomPropertyDrawing, ICustomPropertyListDrawing{$ENDIF})
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFDEF VER130} override;{$ENDIF}
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean); {$IFDEF VER130} override;{$ENDIF}
  end;


  TdhComponentEditor=class(TDefaultEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  end;

  TdhLabelEditor=class(TdhComponentEditor)
    MyFirst: IProperty;
    procedure MyCheckEdit({$IFNDEF VER130}const {$ENDIF}Prop: IProperty);
    procedure Edit; override;
  end;

  TStyleClassProperty=class(TClassProperty{$IFNDEF VER130},ICustomPropertyDrawing{$ENDIF})
    function GetValue: string; override;
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean); {$IFDEF VER130} override;{$ENDIF}
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean); {$IFDEF VER130} override;{$ENDIF}
  end;

  TBorderClassProperty=class(TClassProperty)
    function GetValue: string; override;
  end;

  TBorderRadiusClassProperty=class(TClassProperty)
    function GetValue: string; override;
  end;

  TTransformationsProperty=class(TClassProperty)
    function GetValue: string; override;
  end;

  TTargetProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;



  TUseProperty = class(TComponentProperty)
  protected
    sProc: TGetStrProc;
    procedure _Proc(const S: string);
  public
    //procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;
               

(*  TFormNameEditor = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
//    procedure SetValue(const Value: string); override;
  end;
  *)


  (*
  TVarEditor = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  TMarginProperty = class(TVarEditor)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    function GetAttributes: TPropertyAttributes; override;
  end;
  *)

  TFontSizeProperty = class({TVarEditor}TStringProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TVerticalAlignProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;


  TBackgroundPositionProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

 (*
  TFormProperty = class(TComponentProperty{$IFNDEF VER130},ICustomPropertyDrawing{$ENDIF})
  protected
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean); {$IFDEF VER130} override;{$ENDIF}
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean); {$IFDEF VER130} override;{$ENDIF}
  public
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
  end;
     *)

  TBasedFormProperty = class(TComponentProperty)
  protected
    sProc: TGetStrProc;
    procedure _Proc(const S: string);
  public
    //procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;


  TJvHintProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;  



procedure Register;


implementation

//uses StrLEdit;
uses dhPanel,dhStyleSheet;

function IsColorFormat(const Value: string; var L:integer):boolean;
begin
 result:=dhPanel.IdentToColor(Value, L);
 if (Value<>'') and (Value[1]='#') and (length(Value)=7) then
 try
   L:=strtoint('$'+copy(Value,6,2))*256*256+strtoint('$'+copy(Value,4,2))*256+strtoint('$'+copy(Value,2,2));
   Result:=true;
 except
 end;
end;





         {
function ColorToString(Color: TColor): string;
begin
  if Color=colInherit then
   Result:=scolInherit else
  if Color=colTransparent then
   Result:=scolTransparent else
  if not ColorToIdent(Color, Result) then
    FmtStr(Result, '%s%.8x', [HexDisplayPrefix, Color]);
end;

function StringToColor(const S: string): TColor;
begin
  if S=scolInherit then
   Result:=colInherit else
  if S=scolTransparent then
   Result:=colTransparent else
  if not IdentToColor(S, Longint(Result)) then
    Result := TColor(StrToInt(S));
end;
             }
                  {
function ColorToIdent(Color: Longint; var Ident: string): Boolean;
begin
//showmessage('ColorToIdent');
 result:=true;
 if Color=colInherit then
  Ident:=scolInherit else
 if Color=colTransparent then
  Ident:=scolTransparent else
 if not Graphics.ColorToIdent(Color,Ident) then
  Ident:='#'+inttohex(Color and 255,2)+inttohex((Color shr 8) and 255,2)+inttohex((Color shr 16) and 255,2);
end;

function IdentToColor(const Ident: string; var Color: Longint): Boolean;
begin
 Result:=true;
 if Ident=scolInherit then
  Color:=colInherit else
 if Ident=scolTransparent then
  Color:=colTransparent else
 if not OurStringToColor(Ident, Longint(Color)) then
  result:=Graphics.IdentToColor(Ident,Color);
end;     }

              {
function ColorToString(Color: TColor): string;
begin
  if not ColorToIdent(Color, Result) then
    FmtStr(Result, '%s%.8x', [HexDisplayPrefix, Color]);
end;

function StringToColor(const S: string): TColor;
begin
  if not IdentToColor(S, Longint(Result)) then
    Result := TColor(StrToInt(S));
end;
                }

                (*
function GetForms:TStringList;

//var i:integer;
//var intFormCount,intLoopCount:integer;
var
  XModuleServices: IOTAModuleServices;
  XModule: IOTAModule;
  XModuleInfo: IOTAModuleInfo;
  XProject: IOTAProject;
  XResult: HRESULT;
  XFormMame: String;
  i: integer;
begin
 Result:=TStringList.Create;
  if Assigned(BorlandIDEServices) then begin
    XResult:=BorlandIDEServices.QueryInterface(IOTAModuleServices,XModuleServices);
    if (XResult=S_Ok) and Assigned(XModuleServices) then begin
      XModule:=XModuleServices.CurrentModule;
      if Assigned(XModule) and (XModule.OwnerCount>0) then begin
        XProject:=XModule.Owners[0];
{      if Assigned(XModule) and (XModule.GetOwnerCount>0) then begin
        XProject:=XModule.GetOwner(0);
}
        if Assigned(XProject) then begin
          for i:=0 to XProject.GetModuleCount-1 do begin
            XModuleInfo:=XProject.GetModule(i);
            if Assigned(XModuleInfo) then begin
              XFormMame:=XModuleInfo.FormName;
              if trim(XFormMame)<>''
                then Result.Add(XModuleInfo.FormName);
              end;
            end;
          XProject:=nil;
          end;
        XModule:=nil;
        end;
      XModuleServices:=nil;
      end;
    end;
      {
  intFormCount := ToolServices.GetFormCount;
  for intLoopCount := 0 to IntFormCount-1 do
   Result.Add(ToolServices.GetFormName(intLoopCount));
         }

//  Designer.GetComponentNames(GetTypeData(TypeInfo(TForm)), Proc);
{ for i:=0 to Screen.FormCount-1 do
  Result.Add(Screen.Forms[i].Name);}

end;
*)

{$IFDEF VER130}
procedure DefaultPropertyListDrawValue(const Value: string; Canvas: TCanvas;
  const Rect: TRect; Selected: Boolean);
begin
  Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, Value);
end;
{$ENDIF}

procedure TCSSColorProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  if GetVisualValue <> '' then
    ListDrawValue(GetVisualValue, ACanvas, ARect, True{ASelected})
  else
{$IFDEF VER130}
   Inherited;
{$ELSE}
    DefaultPropertyDrawValue(Self, ACanvas, ARect);
{$ENDIF}
end;


procedure TCSSColorProperty.ListDrawValue(const Value: string; ACanvas: TCanvas;
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

    if IsColorFormat(Value,L) and (L<>colTransparent) then
    begin
    Brush.Color := TColor(L);
    // set things up and do the work
    //Brush.Color := StringToColor(Value);
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

function TInhProperty.GetValue: string;
begin
 if GetOrdValue=0 then
  Result:='' else
  Result:=GetHyphens(Inherited GetValue);
end;


function GetInverseHyphens(const s:string):string;
var i:integer;
begin
 result:='-'+s;
 for i:=length(result) downto 1 do
 if result[i]='-' then
 begin
  if (i+1<=length(result)) and (result[i+1] in ['a'..'z']) then
   result[i+1]:=chr(ord(result[i+1])+ord('A')-ord('a'));
  delete(result,i,1);
 end;
end;

function GetTwo(const s:string):string;
var i:integer;
begin
 result:='';
 for i:=length(s) downto 1 do
 if (s[i] in ['A'..'Z']) or (result='') and (i=2) then
  result:=s[i]+result;
 result:='c'+lowercase(copy(result,1,2));
 if s='Display' then
  result:='cds' else
 if s='Style' then
  result:='cbs'{ else
 if s='Cursor' then
  result:='ccr'};
end;

procedure TInhProperty.SetValue(const Value: String);
begin
 if Value='' then
  SetOrdValue(0) else
  inherited SetValue(GetTwo(self.GetName)+GetInverseHyphens(Value));
end;


function TCSSCursorProperty.GetValue: string;
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


function StringToCursor(const Ident: string): TCSSCursor;
begin
  Result:=TCSSCursor(GetEnumValue( TypeInfo( TCSSCursor ), Ident ));
end;

procedure TCSSCursorProperty.SetValue(const Value: string);
begin
{ if Value='' then
  SetOrdValue(Longint(ccrInherit)) else
  SetOrdValue(Longint(StringToCursor(Value)));}
 if Value='' then
  SetOrdValue(0) else
  SetOrdValue(Longint(StringToCursor(GetTwo(self.GetName)+GetInverseHyphens(Value))));
//  inherited SetValue(GetTwo(self.GetName)+GetInverseHyphens(Value));
end;


procedure TCSSCursorProperty.ListDrawValue(const Value: string;
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
//  RegisterPropertyEditor(TypeInfo(String), TdhPanel, 'Hint', TMultiLineCaptionProperty);
  RegisterComponentEditor(TdhStyleSheet,TdhComponentEditor);
  RegisterComponentEditor(TdhCustomPanel,TdhComponentEditor);
  RegisterComponentEditor(TdhLink,{TdhComponentEditor}TdhLabelEditor);
  RegisterComponentEditor(TdhLabel,TdhLabelEditor);
  //RegisterComponentEditor(TdhDirectHTML,TdhLabelEditor);
  RegisterPropertyEditor(TypeInfo(string), TdhCustomPanel, 'Text', TMultiLineCaptionProperty);
  RegisterPropertyEditor(TypeInfo(HypeString), TdhDirectHTML, 'InnerHTML', TJvHintProperty);
  RegisterPropertyEditor(TypeInfo(string), TdhPage, 'HTMLBody', TJvHintProperty);
  RegisterPropertyEditor(TypeInfo(string), TdhPage, 'HTMLHead', TJvHintProperty);
  RegisterPropertyEditor(TypeInfo(string), TdhPage, 'MetaDescription', TJvHintProperty);
  RegisterPropertyEditor(TypeInfo(string), TdhPage, 'MetaKeywords', TJvHintProperty);
//  RegisterPropertyEditor(TypeInfo(string), TdhPureHTML, 'InsertText', TMultiLineCaptionProperty);
//  RegisterPropertyEditor(TypeInfo(string), TdhCustomPanel, 'Log', TMultiLineCaptionProperty);
//  RegisterPropertyEditor(TypeInfo(TFormName), TdhCustomPanel, '', TFormNameEditor);
//  RegisterPropertyEditor(TypeInfo(TForm), TdhPanel, 'AForm', TFormComponentProperty);
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
       {
  RegisterPropertyEditor(TypeInfo(TCSSMargin), TStyle, 'Margin', TMarginProperty);
  RegisterPropertyEditor(TypeInfo(TCSSMargin), TStyle, 'MarginBottom', TMarginProperty);
  RegisterPropertyEditor(TypeInfo(TCSSMargin), TStyle, 'MarginTop', TMarginProperty);
  RegisterPropertyEditor(TypeInfo(TCSSMargin), TStyle, 'MarginLeft', TMarginProperty);
  RegisterPropertyEditor(TypeInfo(TCSSMargin), TStyle, 'MarginRight', TMarginProperty);
}
  RegisterPropertyEditor(TypeInfo(TCSSFontSize), TStyle, 'FontSize', TFontSizeProperty);
  RegisterPropertyEditor(TypeInfo(TCSSFontFamily), TStyle, 'FontFamily', TCSSFontFamilyProperty);


  RegisterPropertyEditor(TypeInfo(string), TdhLink, 'Target', TTargetProperty);
  //RegisterPropertyEditor(TypeInfo(string), TdhComboBox, 'Target', TTargetProperty);
  RegisterPropertyEditor(TypeInfo(TControl), TdhCustomPanel, 'Use', TUseProperty);
  //RegisterPropertyEditor(TypeInfo(TCustomForm), TdhCustomPanel, 'LinkForm', TFormProperty);

//  RegisterPropertyEditor(TypeInfo(TdhTabSheet), TdhCustomPanel, 'LinkTab', TBasedFormProperty);
  RegisterPropertyEditor(TypeInfo(TdhLink), TdhCustomPanel, 'LinkAnchor', TBasedFormProperty);

end;



function TCSSCardinalProperty.GetValue: string;
begin
 if GetOrdValue=MaxInt then
  Result:=srInherit else
  Result:=Inherited GetValue;
end;

procedure TCSSCardinalProperty.SetValue(const Value: string);
begin
 if SameText(Value,srInherit) then
  SetOrdValue(vsrInherit) else
  Inherited;
end;

function TCSSColorProperty.GetValue: string;
begin
  Result := dhPanel.ColorToString(TColor(GetOrdValue));{
  Result:=ColorToString(TColor(GetOrdValue));
  if Result='clNone' then
   Result:=scolTransparent else
  if Result='clNone' then
   Result:=scolTransparent else
  if (Result<>'') and (Result[1]='$') then
   Result:='#'+copy(Result,8,2)+copy(Result,6,2)+copy(Result,4,2);}
end;


procedure GetColorValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Low(dhPanel.Colors)+1 to High(dhPanel.Colors) do Proc(dhPanel.Colors[I].Name);
end;

procedure TCSSColorProperty.GetValues(Proc: TGetStrProc);
begin
  GetColorValues(Proc);
end;

procedure TCSSColorProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IsColorFormat(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
{var L:integer;
begin
  if IdentToColor(Value, NewValue) then
 if Value=scolTransparent then
  SetOrdValue(colTransparent) else
 if OurStringToColor(Value,L) then
  SetOrdValue(L) else
  Inherited;  }
end;

type
  TCharSet = TSysCharSet;

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

procedure TMultiLineCaptionProperty._Proc(const S: string);
begin
 {dhStrEditDlg.VisitProc(Designer.GetComponent(S));
 }
end;

procedure TMultiLineCaptionProperty.Edit;
var
  Temp: HypeString;
  Comp: TPersistent;
  ii:integer;
  ls:TList;
begin
 {ls:=TList.Create;
 try
  ls.Add(GetComponent(0) as TdhLabel);
  if not dhStrEditDlg.Prepare2(ls) then exit;
  Designer.GetComponentNames(GetTypeData(TypeInfo(TdhLabel)), _Proc);
  dhStrEditDlg.Execute(Temp);
  SetStrValue(Temp);
 finally
  ls.Free;
 end;
 }
end;



procedure TMultiLineCaptionProperty.MemoChange(Sender: TObject);
var
  Temp: string;
begin    
{      Temp := dhStrEditDlg.Memo1.Text;

      while (Length(Temp) > 0) and (Temp[Length(Temp)] < ' ') do
        Delete(Temp, Length(Temp), 1);
      SetStrValue(Temp);

      (GetComponent(0) as TControl).update;
}
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



procedure TVerticalAlignProperty.SetValue(const Value: string);
var s:string;
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

{procedure TMarginProperty.GetValues(Proc: TGetStrProc);
begin
// proc('auto');
end;
}


{function TFontSizeProperty.GetValue: string;
begin
  Value := VarToStrDef(GetVarValue, '(Null)');
end;
 }
 (*
function TFormNameEditor.GetAttributes: TPropertyAttributes;
begin
  Result:=[paValueList, paRevertable];
end;


procedure TFormNameEditor.GetValues(Proc: TGetStrProc);
var i:integer;
    sl:TStringList;
begin
 sl:=GetForms;
 for i:=0 to sl.Count-1 do
  Proc(sl[i]);
 sl.Free;
end;
*)
(*
procedure TFormProperty.GetValues(Proc: TGetStrProc);
var i:integer;
    sl:TStringList;
begin
{ sl:=GetForms;
 for i:=0 to sl.Count-1 do
  Proc(sl[i]);
 sl.Free;
}
 inherited;
end;*)

{procedure TFormNameEditor.SetValue(const Value: string);
var sl:TStringList;
begin
 sl:=GetForms;
 try
 if (Value<>'') and (sl.IndexOf(Value)=-1) then
  raise EPropertyError.Create(SInvalidPropertyValue);
 finally
  sl.Free;
 end;
 Inherited;
end;
}


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

{$IFDEF VER130}
   Inherited;
{$ELSE}
  DefaultPropertyDrawName(Self, ACanvas, ARect);
{$ENDIF}
end;

procedure TdhLabelEditor.Edit;
{$IFDEF VER130}
var
  Components: TDesignerSelections;
{$ELSE}
var
  Components: IDesignerSelections;
{$ENDIF}
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


// GetPropInfo(Component,'Caption');
//end;






function TStyleClassProperty.GetValue: string;
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

function TBorderClassProperty.GetValue: string;
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
{$IFDEF VER130}
   Inherited;
{$ELSE}
   DefaultPropertyDrawValue(Self, ACanvas, ARect);
{$ENDIF}
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

function TdhComponentEditor.GetVerb(Index: Integer): string;
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



procedure TUseProperty._Proc(const S: string);
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
procedure TUseProperty.SetValue(const Value: string);
var
  Component: TComponent;
begin
    Component := Designer.GetComponent(Value);
    if Component.Owner<>nil then
     showmessage(Component.Owner.Name);
 inherited;
end;
           }



procedure TBasedFormProperty._Proc(const S: string);
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


(*
function TFormProperty.GetValue: string;
var pn:TdhLink;
begin   {
 if (PropCount=1) and (GetComponent(0) is TdhLink) then
 begin
  pn:=TdhLink(GetComponent(0));
  pn.CheckS;
  if pn.LastLinkForm<>'' then
  begin
   result:=pn.LastLinkForm;
   exit;
  end;
 end; }
 Result := Inherited GetValue;
end;


procedure TFormProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var pn:TdhLink;
begin
{ if not RuntimeMode and (PropCount=1) and (GetComponent(0) is TdhLink) then
 begin
  pn:=TdhLink(GetComponent(0));
  if pn.LastLinkForm<>'' then
  begin
   ACanvas.Font.Color:=clGray;
  end;
 end;}
{$IFDEF VER130}
   Inherited;
{$ELSE}
  DefaultPropertyDrawName(Self, ACanvas, ARect);
{$ENDIF}
end;

*)


(*
procedure TFormProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
begin

//   showmessage(GetVisualValue+':'+GetValue+' '+booltostr(AllEqual,true));
 if GetComponentReference=nil then
  ACanvas.Font.Color:=clGray;
 if PropCount=1 then
  ACanvas.TextRect(ARect, ARect.Left + 1, ARect.Top + 1, GetValue) else
  ACanvas.TextRect(ARect, ARect.Left + 1, ARect.Top + 1, GetVisualValue);
*)(*
{$IFDEF VER130}
   Inherited;
{$ELSE}
   DefaultPropertyDrawValue(Self, ACanvas, ARect);
{$ENDIF}
*)
(*end;
*)

(*
procedure TFormProperty.SetValue(const Value: string);
var
  Component: TComponent;
  s:String;
  var f:TForm ;
begin  //IDesignNotification IDesignerHook
  if Value = '' then
    Component := nil
  else
  begin
    {Component := Designer.GetComponent(Value);
    try
    //    s:=GetTypeData(GetPropType)^.ClassType.ClassName;
    s:=Designer.GetComponentName(Component);
    except
    s:='nb';
    end;
    if Component=nil then
     s:='nil';
    if FindForm(Value,f) then
    begin
     s:=f.ClassName;
     Component:=f;
    end; }
    Component:=nil;
    if FindForm(Value,f) then
    begin
     Component:=f;
    end;
    if not (Component is GetTypeData(GetPropType)^.ClassType) then
      raise EPropertyError.Create('Invalid property value'{+Component.ClassName});

  end;
  SetOrdValue(LongInt(Component));
end;
*)


{function TVarEditor.GetAttributes: TPropertyAttributes;
begin
  Result:=[paValueList, paRevertable];
end;

function TMarginProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=[paRevertable];
end;

function TVarEditor.GetValue: string;

  function GetVariantStr(const Value: Variant): string;
  begin
    case VarType(Value) of
      varBoolean:
        Result := BooleanIdents[Value = True];
      varCurrency:
        Result := CurrToStr(Value);
    else
      Result := VarToStr(Value);
    end;
  end;

var
  Value: Variant;
begin
  Value := GetVarValue;
  Result := GetVariantStr(Value);
end;

procedure TVarEditor.SetValue(const Value: string);

  function Cast(var Value: Variant; NewType: Integer): Boolean;
  var
    V2: Variant;
  begin
    Result := True;
    if NewType = varCurrency then
      Result := Pos(CurrencyString, Value) > 0;
    if Result then
    try
      VarCast(V2, Value, NewType);
      Result := (NewType = varDate) or (VarToStr(V2) = VarToStr(Value));
      if Result then Value := V2;
    except
      Result := False;
    end;
  end;

var s:string;
var
  V: Variant;
  OldType: Integer;
begin
 s:=LowerCase(Trim(Value));
 if SubEqualEnd('px',s) then
  s:=CopyLess(s,2);


  OldType := VarType(GetVarValue);
  V := s;
  if Value = '' then
    VarClear(V) else
  if not Cast(V, OldType) then
    V := Value;
  SetVarValue(V);
end;
}


function TCSSFontFamilyProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=[paMultiSelect, paValueList, paRevertable];
//!  Result := [paMultiSelect, paValueList, paSortList, paRevertable];
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

procedure TCSSFontFamilyProperty.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  OldFontName: string;
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

procedure TCSSFontFamilyProperty.ListMeasureHeight(const Value: string;
  ACanvas: TCanvas; var AHeight: Integer);
var
  vOldFontName: string;
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

procedure TCSSFontFamilyProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
var
  vOldFontName: string;
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


procedure TCSSFontFamilyProperty.SetValue(const Value: string);
var s:string;
begin
 s:=Value;
 s:=StringReplace(s,'"','',[rfReplaceAll, rfIgnoreCase]);
 s:=StringReplace(s,'''','',[rfReplaceAll, rfIgnoreCase]);
 inherited SetValue(s);
end;

{ TMyPictureProperty }

procedure TMyPictureProperty.Edit;
var
  PictureEditor: TPictureEditor;
begin
  PictureEditor := TPictureEditor.Create(nil);
  try
    PictureEditor.Picture := TLocationImage(Pointer(GetOrdValue)).PictureID;
    if PictureEditor.Execute then
      SetOrdValue(Longint(PictureEditor.Picture));
  finally
    PictureEditor.Free;
  end;
end;

function TMyPictureProperty.GetValue: string;
var
  Picture: TPictureID;
begin
  Picture := TLocationImage(GetOrdValue).PictureID;
  if (Picture=nil) or (Picture.Graphic = nil) then
    Result := srNone else
    Result := '(' + Picture.Graphic.ClassName + ')'+'[References:'+inttostr(Picture.ReferenceCount)+']';
end;


{ TBorderRadiusClassProperty }

function TBorderRadiusClassProperty.GetValue: string;
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

function TTransformationsProperty.GetValue: string;
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

{ TJvHintProperty }

function TJvHintProperty.GetAttributes: TPropertyAttributes;
begin
  Result := {inherited GetAttributes +} [paDialog];
end;

procedure TJvHintProperty.Edit;
var
  Temp: string;
  Comp: TPersistent;
begin
  with TJvStrEditDlg.Create(Application) do
  try
    Comp := GetComponent(0);
    if Comp is TComponent then
      Caption := TComponent(Comp).Name + '.' + GetName
    else
      Caption := GetName;
    Temp := GetStrValue;
    Memo.Lines.Text := Temp;
    UpdateStatus(nil);
    if ShowModal = mrOk then
    begin
      Temp := Memo.Text;
      while (Length(Temp) > 0) and (Temp[Length(Temp)] < ' ') do
        System.Delete(Temp, Length(Temp), 1);
      SetStrValue(Temp);
    end;
  finally
    Free;
  end;
end;

initialization

finalization

// FreeAndNil(ShowInfo);

end.


