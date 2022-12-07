unit uStyleImport;

interface
uses

  SysUtils, Classes, TypInfo,
{$IFDEF CLX}
  QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls, QComCtrls,  QStdCtrls, QTntStdCtrls,
  QImgList, QMenus, QClipbrd, QStyle,
{$ELSE}
  {uMutex,}Controls, Forms, Windows, Messages, Graphics, Dialogs, ExtCtrls, clipbrd, Buttons, JPeg,
  ComCtrls, CommCtrl, StdCtrls, ShellAPI, RTLConsts,  Menus, FileCtrl,
  {Mask, }ToolWin, ImgList,   AppEvnts, {IECache,} URLDropTarget, XPMan, UnicodeCtrls,  //XPdesign,
{$ENDIF}
  Unit2, dhDirectHTML,
  MySpeedButton, dhPanel, htmlrout, {$IFDEF MSWINDOWS}OverbyteIcsHttpProt,{$ELSE}{IcsUrl,}{$ENDIF}
  funcutils, dhHTMLForm,  dhPageControl,  dhStyleSheet,
  dhMenu, dhLabel, dhEdit, MySpinEdit,
  UseFastStrings, crc, math,
  MySiz, Unit3, uConversion,
  dhRadioButton, dhMemo, dhFileField,  MyToolButton,
  dhColorPicker,IniFiles,gr32, uOptions, menuhelper,
  pngimage, Contnrs,hEdit,hComboBox,hMemo,hSynMemo,SynMemo, UIConstants,DKLang, OpenSave,dhStrUtils,WideStrUtils,uMetaWriter,dhStyles,dhGraphicFormats,dhColorUtils,shlobj,Generics.Collections,
  seCSSParser,uColorPicker,uWarnings;


procedure ImportFromStylesheet(styleSheet:TdhStylesheet; const ThemeDir:TPathName);

implementation

type TStyleName=class
  private
    name:String;
    states:TStates;
    pn:TdhCustomPanel;
    supersets:TList<TStyleName>;
    largestSubset:TStyleName;
    CSSElementObjs: array[TState] of TList<TseCSSElement>;
    isSubset:boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function RequireLink:boolean;
    function IsSubordinate:boolean;
end;

function IsEdgeAtt(const attName, styleName: String; var edgeAlign:TEdgeAlign):boolean;
begin
  if SubEqual(styleName,attname) then
  begin
   if SubEqual(styleName+'-left',attname) then
     edgeAlign:=ealLeft else
   if SubEqual(styleName+'-right',attname) then
     edgeAlign:=ealright else
   if SubEqual(styleName+'-bottom',attname) then
     edgeAlign:=ealBottom else
   if SubEqual(styleName+'-top',attname) then
     edgeAlign:=ealTop else
     edgeAlign:=ealNone;
   result:=true;
  end else
    result:=false;
end;

function GetEnum(TypeInfo: PTypeInfo; Value:String):Integer;
begin
 result:=GetEnumValue(TypeInfo,Copy(GetEnumName(TypeInfo,0),1,3)+StringReplace(Value,'-','' ,[rfReplaceAll]) );
 if result=-1 then
  raise Exception.Create('Error Message');
end;

function SplitValues(s:String):TStringList;
var vn:integer;
    subValue:String;
    withinQuotes:boolean;
begin
  result:=TStringList.Create;
  vn:=1;
  withinQuotes:=false;
  s:=s+' ';
  while vn<=length(s) do
  begin
    if (s[vn]=' ') and not withinQuotes then
    begin
     while (vn<=length(s)) and (s[vn]=' ') do inc(vn);
     subValue:=Trim(Copy(s,1,vn-1));
     if (subValue<>'') and (subValue[length(subValue)]<>',') and not ((vn<=length(s)) and (s[vn]=',')) then
     begin
      if subValue<>'!important' then result.add(subValue);
      delete(s,1,vn-1);
      vn:=1;
      continue;
     end;
    end else
    if s[vn] in ['''','"'] then
      withinQuotes:=not withinQuotes;
    inc(vn);
  end;
end;

function Extract(Instance:TPersistent; PropName:String; values:TStringList):boolean;
var i:integer;
var
  PropInfo: PPropInfo;
  Value,MultiValue,url:String;
  Color:TCSSColor;
begin
  result:=false;
  PropInfo:=GetPropInfo(Instance,StringReplace(PropName,'-','' ,[rfReplaceAll]));
  i:=0;
  while i<values.Count do
  try
   Value:=values[i];
   case PropInfo.PropType^^.Kind of
    tkEnumeration:
      SetOrdProp(Instance, PropInfo, GetEnum(PropInfo.PropType^,Value));
    tkSet:
      TStyle(Instance).TextDecoration:=TStyle(Instance).TextDecoration+[TCSSTextDecoration(GetEnum(TypeInfo(TCSSTextDecoration),Value))];
    tkInteger:
      if PropInfo.PropType^^.Name='TCSSColor' then
      begin
      if GetColorFromString(Value,Color) then
       SetOrdProp(Instance, PropInfo, Longint(Color)) else
       raise Exception.Create('');
      end else
       SetOrdProp(Instance, PropInfo, GetPixels(Value));
    else
    if result and (PropName='background-position') then
      TStyle(Instance).BackgroundPosition:=TStyle(Instance).BackgroundPosition+' '+Value else
    if (PropName='background-image') then
    begin
      if SubEqual('url(',value) and SubEqualEnd(')',value) then
      begin
       url:=Trim(CopyLess(Copy(Value,5,maxint),1));
       if SubEqual('''',url) and SubEqualEnd('''',url) or SubEqual('"',url) and SubEqualEnd('"',url) then
        url:=Trim(CopyLess(Copy(url,2,maxint),1));
       TStyle(Instance).BackgroundImage.Path:=url;
      end else
       raise Exception.Create('');
    end else
      SetStrProp(Instance, PropInfo, Value);
   end;
   values.Delete(i);
   result:=true;
   if (PropName='background-position') or (PropName='text-decoration') then
    continue;
   exit;
  except
   inc(i);
  end;
end;

procedure ShorthandExtract(Instance:TPersistent; ShortHandOrPropName:String; PropName:String; values:TStringList);
begin
 if SubEqual(ShortHandOrPropName,PropName) then
  Extract(Instance,PropName,values);
end;

procedure GetBackground(style:TStyle; AttName:String; values:TStringList);
begin
  ShorthandExtract(style,AttName,'background-attachment',values);
  ShorthandExtract(style,AttName,'background-color',values);
  ShorthandExtract(style,AttName,'background-image',values);
  ShorthandExtract(style,AttName,'background-position',values);
  ShorthandExtract(style,AttName,'background-repeat',values);
end;

procedure GetBorder(border:TCSSBorder; values:TStringList);
begin
  Extract(border,'Color',values);
  Extract(border,'Style',values);
  Extract(border,'Width',values);
end;

procedure GetFont(style:TStyle; AttName:String; values:TStringList);
begin
  ShorthandExtract(style,AttName,'font-size',values);
  ShorthandExtract(style,AttName,'font-style',values);
  ShorthandExtract(style,AttName,'font-variant',values);
  ShorthandExtract(style,AttName,'font-weight',values);
  ShorthandExtract(style,AttName,'font-family',values);
end;

procedure GetListStyle(style:TStyle; AttName:String; values:TStringList);
begin
  ShorthandExtract(style,AttName,'list-style-type',values);
end;

procedure GetMargin(style:TStyle; AttName:String; values:TStringList);
begin
  if values.Count=1 then
   Extract(style,AttName,values) else
  begin
   Extract(style,'margin-top',values);
   Extract(style,'margin-right',values);
   if not Extract(style,'margin-bottom',values) then
     style.MarginBottom:=style.MarginTop;
   if not Extract(style,'margin-left',values) then
     style.MarginLeft:=style.MarginRight;
  end;
end;

procedure GetPadding(style:TStyle; AttName:String; values:TStringList);
begin
  if values.Count=1 then
   Extract(style,AttName,values) else
  begin
   Extract(style,'padding-top',values);
   Extract(style,'padding-right',values);
   if not Extract(style,'padding-bottom',values) then
     style.PaddingBottom:=style.PaddingTop;
   if not Extract(style,'padding-left',values) then
     style.PaddingLeft:=style.PaddingRight;
  end;
end;

procedure ImportFromStylesheet(styleSheet:TdhStylesheet; const ThemeDir:TPathName);
var styles,_message:String;
    seCSSParser1: TseCSSParser;
    CSSElementObj:TseCSSElement;
    e,i,c,n:integer;
    attName,attValue,name:String;
    pn:TdhCustomPanel;
    Names:TStringList;
    comp:TComponent;
    edge:TEdgeAlign;
    st,_st:TState;
    lLock:boolean;
    values,messages:TStringList;
    styleName,superset:TStyleName;
    styleNames:TDictionary<String,TStyleName>;
    style:TStyle;
    styleCompanions:TList<TStyleName>;
begin
 glLockWindowUpdate(true,lLock);
 try
 styleSheet.DisableAlign;
 try
 styles := StringFromFile(ThemeDir);
 styleNames:=TDictionary<String,TStyleName>.Create;
 messages:=TStringList.Create;
 seCSSParser1:=TseCSSParser.Create(nil);
 try
   seCSSParser1.CSSText.Text:=styles;
   seCSSParser1.Parse;
   for e := 0 to seCSSParser1.ElementsCount - 1 do
   begin
    CSSElementObj:=seCSSParser1.Elements[e];
    Names:=TStringList.Create;
    styleCompanions:=TList<TStyleName>.Create;
    try
    Names.Delimiter:=',';
    Names.DelimitedText:=CSSElementObj.Name;
    for n := 0 to Names.Count - 1 do
    begin
      name:=Trim(Names[n]);
      if name[1]='.' then
       delete(name,1,1);
      if not TdhCustomPanel.IsValidIdent(name) then
       continue;
      st:=hsNormal;
      for _st := Low(TState) to High(TState) do
      if SubEqualEnd(sst[_st],name) then
      begin
        st:=_st;
        name:=CopyLess(name,length(sst[st]));
        break;
      end;
      if not styleNames.TryGetValue(name,styleName) then
      begin
       pn:=nil;
       comp:=styleSheet.Owner.FindComponent(name);
       if comp<>nil then
       if (comp is TdhCustomPanel) and (TdhCustomPanel(comp).Parent=styleSheet) then
         pn:=TdhCustomPanel(comp) else
         continue;
       styleName:=TStyleName.Create;
       styleName.Name:=name;
       styleNames.add(name,styleName);
       styleName.pn:=pn;
      end;
      include(styleName.states,st);
      stylename.CSSElementObjs[st].add(CSSElementObj);
      styleCompanions.add(stylename);
    end;
    for styleName in styleCompanions do
    begin
      if styleName.supersets=nil then
      begin
       styleName.supersets:=TList<TStyleName>.Create;
       for superset in styleCompanions do
       if superset<>styleName then
       begin
        styleName.supersets.add(superset);
       end;
      end else
      for n:=styleName.supersets.Count-1 downto 0 do
      begin
       if styleCompanions.indexOf(styleName.supersets[n])=-1 then
         styleName.supersets.delete(n);
      end;
    end;
    finally
      Names.Free;
      styleCompanions.Free;
    end;
   end;
   //for identical sets, define one arbitrary set to be the "superset"
   for styleName in styleNames.Values do
   begin
     if styleName.largestSubset=nil then
     for superset in styleName.supersets do
     if styleName.supersets.Count=superset.supersets.Count then
     begin
       if (superset.largestSubset=nil) then
        superset.largestSubset:=styleName;
     end;
   end;
   // for supersets, find the largest subset
   for styleName in styleNames.Values do
   begin
     if not styleName.IsSubordinate then
     for superset in styleName.supersets do
     if styleName.supersets.Count>superset.supersets.Count then
     begin
       if (superset.largestSubset=nil) or superset.largestSubset.supersets.contains(styleName) and not styleName.supersets.contains(superset.largestSubset) then
        superset.largestSubset:=styleName;
     end else
     if styleName.supersets.Count<superset.supersets.Count then
       raise Exception.Create('Programming error');
   end;
   for styleName in styleNames.Values do
   begin
     if styleName.largestSubset<>nil then
       styleName.largestSubset.isSubset:=true;
   end;
   for styleName in styleNames.Values do
   begin
      if styleName.pn=nil then
      if styleName.IsSubordinate and not styleName.IsSubset then
      begin
        continue;
      end else
      begin
        styleName.pn:=styleSheet.AddStyle(styleName.RequireLink);
        styleName.pn.Name:=styleName.Name;
      end;
      pn:=styleName.pn;
      for st := Low(TState) to High(TState) do
      if pn.StyleArr[st]<>nil then
      for CSSElementObj in styleName.CSSElementObjs[st] do
      if not ((styleName.largestSubset<>nil) and styleName.largestSubset.CSSElementObjs[st].contains(CSSElementObj)) then
      for i := 0 to CSSElementObj.AttributesCount-1 do
      begin
        Style:=pn.StyleArr[st];
        if Style=nil then continue;
        attName := Trim(LowerCase(CSSElementObj.Attributes[i].Name));
        attValue := Trim(CSSElementObj.Attributes[i].Value);
        values:=SplitValues(attValue);
        try
          if IsEdgeAtt(attName,'border',edge) then
           GetBorder(Style.Borders[edge],values) else
          if IsEdgeAtt(attName,'margin',edge) then
           GetMargin(Style,attName,values) else
          if IsEdgeAtt(attName,'padding',edge) then
           GetPadding(Style,attName,values) else
          if SubEqual('background',attName) then
           GetBackground(Style,attName,values) else
          if SubEqual('font',attName) then
           GetFont(Style,attName,values) else
          if SubEqual('list-style',attName) then
           GetListStyle(Style,attName,values) else
          if (attName='color') or (attName='cursor') or (attName='direction') or (attName='display') or (attName='letter-spacing') or (attName='line-height') or (attName='text-align') or (attName='text-decoration') or (attName='text-indent') or (attName='text-transform') or (attName='vertical-align') or (attName='visibility') or (attName='white-space') or (attName='word-spacing') or (attName='z-index') then
           Extract(Style,attName,values) else
          begin
           Style.Other:=Style.Other+attName+':'+attValue+'; ';
           values.Clear;
          end;
          if values.Count<>0 then
          begin
           values.Delimiter:=',';
           _message:='Could not parse '+pn.Name+' -> '+attName+' : '+attValue+' ['+values.DelimitedText+']';
           if messages.IndexOf(_message)=-1 then
             messages.Add(_message);
          end;
        finally
          FreeAndNil(values);
        end;
      end;
   end;
   for styleName in styleNames.Values do
   begin
      if (styleName.largestSubset<>nil) and (styleName.pn<>nil) then
        styleName.pn.Use:=styleName.largestSubset.pn;
   end;
   if messages.Count>0 then
   begin
     LateCreateForm(TFormWarnings,FormWarnings);
     FormWarnings.Memo1.Lines.Assign(messages);
     FormWarnings.Show;
   end;
 finally
   for styleName in styleNames.Values do
   begin
      styleName.Free;
   end;
   styleNames.Free;
   messages.Free;
   seCSSParser1.Free;
 end;
 finally
  styleSheet.EnableAlign;
 end;
 finally
  glLockWindowUpdate(false,lLock);
 end;
end;


{ TStyleName }

constructor TStyleName.Create;
var st:TState;
begin
  for st := Low(TState) to High(TState) do
    CSSElementObjs[st]:=TList<TseCSSElement>.Create;
end;

destructor TStyleName.Destroy;
var st:TState;
begin
  for st := Low(TState) to High(TState) do
    FreeAndNil(CSSElementObjs[st]);
  FreeAndNil(supersets);
end;

function TStyleName.IsSubordinate: boolean;
begin
  result := (largestSubset<>nil) and (largestSubset.supersets.Count=supersets.Count);
end;

function TStyleName.RequireLink: boolean;
begin
 result := (CSSElementObjs[hsOver].Count+CSSElementObjs[hsDown].Count+CSSElementObjs[hsOverDown].Count>0) or (largestSubset<>nil) and largestSubset.RequireLink;
end;

end.

