unit uConversion;

interface

uses       
 SysUtils, Classes, TypInfo, {$IFNDEF VER130} types, {schnelles IntersectRect} {$ENDIF}
{$IFDEF CLX}
  QControls, QForms, Qt, QGraphics, QDialogs, QExtCtrls, QComCtrls,  QStdCtrls, QMask, QButtons,
{$ELSE}
  Controls, Forms, Windows, Messages, Graphics, Dialogs, ExtCtrls, clipbrd, Buttons, GIFImage, JPeg,
  ComCtrls, CommCtrl, StdCtrls, ShellAPI, pngimage,  Menus,
  {Mask,} ToolWin, ImgList, AppEvnts,
{$ENDIF}
  funcutils, uSearchStr, MyPageControl,
  htmlrout, RTLConsts,
  dhFile,dhHTMLForm, dhPanel, dhPageControl, dhMultilineCaptionEdit, dhStyleSheet, dhOleContainer,dhHiddenField,
  dhDirectHTML, dhMenu, dhLabel, dhCheckBox, dhRadioButton, dhEdit, dhMemo, dhFileField,dhSelect,
  UseFastStrings, {GIFImage, JPeg, }//crc,
  math,binlist,bintree;

const directIE=false;
type TBounds=record Left, Top, Width, Height: Longint; end;

var DFM2HTML_VERSION:string='DFM2HTML v3.1';
var Registered:boolean=false;
//var DFM2HTML_REG:string='';

var glStringToFile:procedure (FileName:string; const s:string);
//const ShareWare=not true;
var DFMs:TStringList;
var men:string='';
//var SaveDir:string;
//var c1,c2:TLargeInteger;
var Warnings:TStringList;
//    FormName:string;

type TGetFrameDFM=function (const FrameClass:string; var FrameFile:string):boolean;

procedure StartConverting(const _BaseDir:string; _Compress:boolean; _GetFrameDFM:TGetFrameDFM);
procedure EndConverting;
//procedure DoConvert(const PureFileName,FileName:string);
function DoConvertContent(var PureFileName:string; const {PureFileName,}_Content:string):string;

function _ObjectTextToResource(f:TStringStream):TStringStream;
function ExtractPureFileName(const f:string): string;

var OnLoad:boolean=false;

implementation



const gif1by1='4749463839610100010080000000000000000021F90401000000002C00000000010001000002024401003B';

var cssfile:string;
var EverNeeded1by1,EverNeededSplit,EverNeededButton,EverNeededJS:Boolean;

function GetBackBinary(const ss:string):string;
var i:integer;
    s:string;
begin
 setlength(s,length(ss) div 2);
 for i:=1 to length(s) do
  s[i]:=chr(strtoint('$'+ss[i*2-1]+ss[i*2]));
 result:=s;
end;


//type TStat=(stMN,stDN,stOV,stOD);

type tnest= class(TList)
    id:string;
    borders:TPoint;
    InnerPos:integer;
    MinWidth:integer;
    AutoY,AutoX,NeedParentColor:boolean;
    Props,PropVals:TMyStringList;
    InlineUse,UsedInlineBy:TList;
    Anchors,OriAnchors:TAnchors;
    Align:TAlign;
    Use,Auto,menu:TNest;
    Refs:integer;
    Style:array[TState] of string;
    FlattenedStyle:array[TState] of string;
    IDs:array[TState] of string;
    sUse{,img}:string;
    img:boolean;
    OverBasedOnDown,DownOverlayOver,NeverVisible,IsPopupMenu,IsInlineMenu:boolean;
    ChildInfo,{DownAnchor,}Characters,hclass,PureFileName,dclass,addprops,LinkPage,insertloc,ParentMenuItem:string;
    FClient{,ClientAdj}:TRect;
    bo:TBounds;
    HorzPosition,VertPosition:integer;
    CloneCharacters:boolean;
    IsAlwaysDown,IsDown,IsPC,RuntimeVariableHeight:boolean;
    HeightDiff,addheight,addtop,PageRange:integer;
    IsSel,HasSubTS,Show,Melt,NeedJS:boolean;
    StyleStored,NeedOwnClass,IsIn:boolean;
    properties,attributes,tag,bgColor:string;
    parent,parentTS:tnest;
    {Rastering,BGRastering,}pmn:string;
    IsScrollable:boolean;
    destructor destroy; override;
    function FinalHeight:integer;

    function frameborder:TPoint;
    function RealParent: TNest;
    function ClientBound:TRect;
    function offsetParent: string;
    function clientWidth: integer;
    function clientHeight: integer;
    function IsDyn:boolean;
    property Client:TRect read FClient;
    function IsRastered(SemiTransparent:boolean):boolean;
    function HasStyleProp(const Prop:String): boolean;
    function HorizontalCenter:boolean;
    function OriginalAutoX:boolean;
    function OriginalAutoY:boolean;
  private
    function contains(const PropName, Value: string): boolean;
    function HasProp(const PropName: string; var s: string): boolean; overload;
    function HasProp(const PropName: string; var i: integer): boolean; overload;
    function HasProp(const PropName: string): boolean; overload;
    function IsProp(const PropName, Value: string): boolean;

    function IsBody:boolean;
    function IsTopBody: boolean;
    function IsIFrame: boolean;

    function iProp(const PropName: string): integer;
    procedure AddAttr(const Name,Value:string);
    function PngToChild: boolean;
    function MenuIsVisible:boolean;
    function MenuIsStatic:boolean;

  end;

destructor TNest.destroy;
var i:integer;
begin
 FreeAndNil(Props);
 FreeAndNil(PropVals);
 FreeAndNil(InlineUse);
 FreeAndNil(UsedInlineBy);
 for i:=0 to Count-1 do
  TNest(Items[i]).Free;
 Inherited;
end;

function tnest.FinalHeight: integer;
begin
 result:=bo.Height+addheight;
end;

function tnest.HasProp(const PropName:string; var s:string):boolean;
var i:integer;
begin
 i:=Props.IndexOf(PropName);
 result:=i<>-1;
 if result then
  s:=PropVals[i];
end;

function tnest.iProp(const PropName:string):integer;
begin
 if not HasProp(PropName,result) then
  result:=0;
end;


function tnest.HasProp(const PropName:string; var i:integer): boolean;
var s:string;
begin
 result:=HasProp(Propname,s);
 if result then
  i:=strtoint(s);
end;

function tnest.HasProp(const PropName:string):boolean;
begin
 result:=Props.IndexOf(PropName)<>-1;
end;

procedure tnest.AddAttr(const Name,Value:string);
begin
 attributes:=attributes+' '+Name+'="'+Value+'"';
end;


function tnest.OriginalAutoX:boolean;
var AutoSizeXY:String;
begin
  result:=HasProp('AutoSizeXY',AutoSizeXY) and ((AutoSizeXY='asX') or (AutoSizeXY='asXY'));
end;

function tnest.OriginalAutoY:boolean;
var AutoSizeXY:String;
begin
  result:=HasProp('AutoSizeXY',AutoSizeXY) and ((AutoSizeXY='asY') or (AutoSizeXY='asXY'));
end;



function tnest.IsProp(const PropName,Value:string):boolean;
var s:string;
begin
 result:=HasProp(Propname,s) and (Value=s);
end;

function tnest.contains(const PropName,Value:string):boolean;
var s:string;
begin
 result:=HasProp(Propname,s) and (AdvPos(Value,s)<>0);
end;

{function tnest.contains_computed(const PropName,Value:string):boolean;
var s:string;
begin
 result:=(HasProp('Computed'+Propname,s) or HasProp(Propname,s)) and (AdvPos(Value,s)<>0);
end;
 }

function tnest.IsBody: boolean;
begin
 //result:=parentTS=nil;
 result:=(tag='body');
 //assert(result=(tag='body'));
end;

function tnest.IsTopBody: boolean;
begin
 result:=IsBody and not IsIFrame;
end;

function tnest.IsIFrame: boolean;
begin
 result:=IsBody and (parent<>nil) and (parent.parent<>nil);
end;


function tnest.frameborder: TPoint;
begin               
 {if RealParent.IsBody then
 begin
  result.X:=RealParent.ClientAdj.Right;
  result.Y:=RealParent.ClientAdj.Bottom;
  if RealParent.IsTopBody then
  begin
   inc(Result.X,4);
   inc(Result.Y,4);
  end;
 end else  }
  result:=Point(0,0);
end;

function tnest.offsetParent: string;
begin
 if RealParent.IsBody then
  result:='parentNode.parentNode' else
  result:='parentNode';
end;

function tnest.clientWidth: integer;
begin
 result:=Client.Right-Client.Left;
end;

function tnest.clientHeight: integer;
begin
 result:=Client.Bottom-Client.Top;
end;

function tnest.RealParent: TNest;
begin
 result:=parent;
 while (result<>nil) and result.Melt do
  result:=result.parent;
end;

function tnest.HasStyleProp(const Prop:String): boolean;
begin
 result:=HasProp('Style.'+Prop) or HasProp('StyleOver.'+Prop) or HasProp('StyleDown.'+Prop) or HasProp('StyleOverDown.'+Prop);
end;

    
function tnest.ClientBound:TRect;
begin                    
  if {IsBody}IsScrollable then
   result:=Client else
   result:=Rect(0,0,bo.Width,bo.Height);
end;


var
    WrittenPages,WrittenObjs:TStringList;
    docg:tg;
    gnest:TNest;
    gln:TMyStringList;
var IndentSpace: string;
var CRLF: string;
    SuppressWrite:boolean=false;
    PreventApplyTemplates:boolean=False;
    BaseDir:string;
    Compress:boolean;
    GetFrameDFM:TGetFrameDFM;
const svg=false;    


procedure StartConverting(const _BaseDir:string; _Compress:boolean; _GetFrameDFM:TGetFrameDFM);
begin
 BaseDir:=_BaseDir;
 Compress:=_Compress;
 GetFrameDFM:=_GetFrameDFM;

  if Compress then
  begin
   IndentSpace:='';
   CRLF:='';
  end else
  begin
   IndentSpace:=' ';
   CRLF:=endl_main;
  end;

  WrittenPages:=TStringList.Create;
  WrittenObjs:=TStringList.Create;
  Warnings:=TStringList.Create;

end;


procedure AddWarning(const id,s:string);
var ss:string;
begin
 ss:={FormName+'.'+}id+' '+s;
 if Warnings.IndexOf(ss)=-1 then
  Warnings.Add(ss);
end;


var ccc:integer;

function GetAttr(const Substr,s:string; var vn:integer; var inhalt:string):boolean;
var g:tg;
begin
 result:=g.init(s) and g.OverPos(Substr+'="') and g.getPos(vn) and g.SaveOverPos('"',inhalt);
end;



     //Unicode/ANSI: http://www.codeproject.com/win32/safesubclassing.asp#xx93366xx
(*
procedure loggerr(const s:string);
begin
{$IFDEF DOLOG}
// StringToFile('c:\loggerr.txt',s);
{$ENDIF}
end;
  *)


{procedure StringToFile(const FileName,s:string);
begin
 with TFileStream.create(FileName,fmCreate) do
 begin
  if s<>'' then
   WriteBuffer(s[1],length(s));
  Free;
 end;
end;
}

function StringFromFile(const FileName:string):string;
begin
 with TFileStream.create(FileName,fmOpenRead) do
 begin
  SetLength(result,Size);
  if Size<>0 then
   ReadBuffer(result[1],Size);
  Free;
 end;
end;

{
function GetHexColor(c:integer):string;
begin
 result:=IntToHex(c,6);
 result:=copy(result,5,2)+copy(result,3,2)+copy(result,1,2);
end;
 }

const {//MaskAmp='AmP';
      //MaskEndl='#13#10';]}
      MaskQuotes=#1;

function MaskAnd(const s:WideString): WideString;
begin
 result:=s;
{ result:=StringReplace(result,'&','',[rfReplaceAll]);
 result:=StringReplace(result,'<','&lt;',[rfReplaceAll]);
 result:=StringReplace(result,'>','&gt;',[rfReplaceAll]);
 result:=StringReplace(result,'"','&quot;',[rfReplaceAll]);
}

// result:=StringReplace(result,'€',MaskAmp+'euro;',[rfReplaceAll]);
// result:=StringReplace(result,'€',MaskAmp+'#8364;',[rfReplaceAll]);
// result:=StringReplace(result,'ö','oe',[rfReplaceAll]);
// result:=StringReplace(result,endl,MaskEndl{'&#xA;'},[rfReplaceAll]);
// result:=StringReplace(result,'€','&#8364; eur',[rfReplaceAll]);
// result:=result+'&';
// result:=StringReplace(result,endl,'<br>',[rfReplaceAll]);

 result:=ConvertWideStringToUnicode(result,true);
{ result:=StringReplace(result,'&',MaskAmp,[rfReplaceAll]);
    }
end;

function FormattedHTML(s:WideString):string;
var vn,itag:integer;
    Closing:boolean;
    tag,text:string;
begin
 //uUnicode.ConvertUnicodeToChar(s,' ');
  {vn:=1;
 while getTag(s,vn,itag,tag,text,Closing) and (itag<>0) do
 begin
 if (tag<>'b') and (tag<>'i') and (tag<>'u') and (tag<>'br') then
 if not Closing then
  s:=CopyInsert(s,itag,CharPos(s,'>',itag),'span class="'+tag+'_mn"') else
  s:=CopyInsert(s,itag,CharPos(s,'>',itag),'span');
 vn:=itag;
 end;       }
 result:={XMLconformant}(LE127(s));  //XMLconformant nicht unbedingt notwendig
end;


var FontColor:string='WindowText';
    AllObjs:string;

procedure ObjectBinaryToXML(Input, Output: TStream);
var
  NestingLevel: Integer;
  SaveSeparator: Char;
  Reader: TReader;
  Writer: TWriter;
  ObjectName, PropName: string; 
  ClassName: string;

  procedure WriteIndent;
  const
    Blanks: array[0..1] of Char = '  ';
  var
    I: Integer;
  begin
    for I := 1 to NestingLevel do Writer.Write(Blanks, SizeOf(Blanks));
  end;

  procedure WriteStr(const S: string);
  begin
    //if Propname='DesignSize' then exit;
   if not SuppressWrite then
    Writer.Write(S[1], Length(S));
  end;

  procedure NewLine;
  begin
    WriteStr(sLineBreak);
    WriteIndent;
  end;


  procedure ConvertObject;
  var ObjType:string;

  procedure ConvertValue; forward;

  procedure ConvertHeader;
  var
    Flags: TFilerFlags;
    Position: Integer;
  begin
    Reader.ReadPrefix(Flags, Position);
    ClassName := Reader.ReadStr;
    ObjectName := Reader.ReadStr;
    AllObjs:=AllObjs+'    '+ObjectName+': '+ClassName+';'+endl;
    WriteIndent;
    if ffInherited in Flags then
      ObjType:='inherited'
    else if ffInline in Flags then
      ObjType:='inline'
    else
      ObjType:='object';
    WriteStr('<'+ObjType);

    if ObjectName <> '' then
    begin
      WriteStr(' name="'+ObjectName+'"');
    end;
    WriteStr(' classname="'+ClassName+'"');
//    WriteStr(' si="'+IntToStr(ccc)+'"');
    inc(ccc);
    if ffChildPos in Flags then
    begin
      WriteStr(' childpos="'+IntToStr(Position)+'"');
    end;
    WriteStr('>');

    if ObjectName = '' then
      ObjectName := ClassName;  // save for error reporting

    WriteStr(sLineBreak);
  end;

  procedure ConvertBinary;
  const
    BytesPerLine = 32;
  var
    MultiLine: Boolean;
    I: Integer;
    Count: Longint;
    Buffer: array[0..BytesPerLine - 1] of Char;
    Text: array[0..BytesPerLine * 2 - 1] of Char;

    s,f:string;
    AHandle,r: Integer;
  begin
    Reader.ReadValue;
    Inc(NestingLevel);
    Reader.Read(Count, SizeOf(Count));

    setlength(s,Count);
    if Count<>0 then
     Reader.Read(s[1], Count);

{    inc(BinCount);
    if BinCount>1 then
     Objectname:=ObjectName+'_'+inttostr(BinCount);
 }

    WriteStr(' value="');
    (*
    if copy(s,2,length('TIcon'))='TIcon' then
    begin
     delete(s,1,1+length('TIcon'));
     f:='.ico';
    end else
    if bAdvPosTil(r,'GIF89a',s,1,50) or bAdvPosTil(r,'GIF87a',s,1,50) then
    begin
     delete(s,1,r-1);
     f:='.gif';
     {s[$b+1]:=chr($00);
     s[$313+1]:=chr($FF);   }
    end else
    if copy(s,2,length('TGIFImage'))='TGIFImage' then
    begin
     delete(s,1,1+length('TGIFImage')+4);
     f:='.gif';
    end else
    if copy(s,2,length('TJPEGImage'))='TJPEGImage' then
    begin
     delete(s,1,1+length('TJPEGImage')+4);
     f:='.jpeg';
    end else
    if copy(s,2,length('TPNGObject'))='TPNGObject' then
    begin
     delete(s,1,1+length('TPNGObject'));
     f:='.png';
    end else
    begin
     delete(s,1,pos('BM',s)-1);
     f:='.bmp';
    end;
    if WrittenObjs.IndexOf(ObjectName+f)<>-1 then
    for i:=2 to maxint do
    if WrittenObjs.IndexOf(ObjectName+'_'+inttostr(i)+f)=-1 then
    begin
     f:='_'+inttostr(i)+f;
     break;
    end;
    f:=ObjectName+f;
    WriteStr(f);
    WrittenObjs.Add(f);
    try
    AHandle:=FileCreate(SaveDir+f,0);
    if AHandle>=0 then
    begin
     FileClose(AHandle);
     StringToFile(SaveDir+f,s);
    end;
    except
    end;
{    MultiLine := Count >= BytesPerLine;
    while Count > 0 do
    begin
      if MultiLine then NewLine;
      if Count >= 32 then I := 32 else I := Count;
      Reader.Read(Buffer, I);
      BinToHex(Buffer, Text, I);
      Writer.Write(Text, I * 2);
      Dec(Count, I);
    end;
}

    *)
//    WriteStr('"');

    Dec(NestingLevel);
    WriteStr('"/>');
  end;
                       {
  function MaskQuotes(const s:string):string;
  begin
//   result:=StringReplace(result,'\','\\',[rfReplaceAll, rfIgnoreCase]);
   result:=StringReplace(s,'"','""',[rfReplaceAll, rfIgnoreCase]);
  end;

  function UnMaskQuotes(const s:string):string;
  begin
   result:=s;
   result:=StringReplace(s,'""','"',[rfReplaceAll, rfIgnoreCase]);
   result:=StringReplace(result,'\\','\',[rfReplaceAll, rfIgnoreCase]);
  end;
                          }

  function Enc(const s:string):string;
  var i:integer;
  begin
   result:=AnsiSubstText('"',MaskQuotes,s);
   (*result:=s;
   for i:=1 to length(s) do
   if (s[i]='<') or (s[i]='"') then
//   if (pos('<',s)>0) or (pos('"',s)>0) then
   begin
    result:='txt'+inttostr(calc_crc32_String(s));
    InsTexts.Add(result+'='+s);
    exit;
   end;*)
  end;


  procedure ConvertProperty; forward;

  procedure ConvertValue;
  const
    LineLength = 64;
  var
    I, J, K, L: Integer;
    S: string;
    W: WideString;
    LineBreak: Boolean;
    colval,sn:string;
    val:integer;
    _Cursor:TCSSCursor;
    nv:TValueType;
    _SuppressWrite:boolean;

  function GetRight(s:WideString):string;
  begin
          if ((ClassName='TdhLabel') or (ClassName='TdhLink') or (ClassName='TdhCheckBox') or (ClassName='TdhRadioButton') or (ClassName='TdhFormButton')) and (PropName='Text') or
             (ClassName='TdhDirectHTML') and (PropName='InnerHTML') or
             (ClassName='TdhPage') and ((PropName='HTMLHead') or (PropName='HTMLBody') or (PropName='HTMLTop')) or
             (ClassName='TdhSelect') and (PropName='HTMLOptions') or
             ((ClassName='TdhLink') and (PropName='Link') or (ClassName='TdhHTMLForm') and (PropName='Action')) and ContainsPHPTag(s) or
             (PropName='HTMLAttributes') then
           result:=FormattedHTML(s) else
           result:=FormattedHTML(MaskAnd(s));
  end;


  begin
   {if Propname='DesignSize' then
   if Propname='DesignSize' then; }
    case Reader.NextValue of
      vaList:
      if (PropName='HTML.Strings') or (PropName='Items.Strings') or (PropName='Lines.Strings') then
      begin
          Reader.ReadValue;
          s:='';
          while not Reader.EndOfList do
          begin
            nv:=Reader.NextValue;
            assert(nv in [vaString, vaLString, vaWString,vaUTF8String]);
            s:=s+GetRight(Reader.ReadString)+endl_main;
          end;
          s:=copy(s,1,length(s)-length(endl_main));
          Reader.ReadListEnd;
          //if (PropName='HTML.Strings') then
          // s:=Enc(s);
          {begin
          sn:='txt'+inttostr(calc_crc32_String(s));
          WriteStr(' value="'+sn+'"');
          InsTexts.Add(sn+'='+s);
          end else  }
          begin
          WriteStr(' value="'+Enc(s)+'"');
          end;

          WriteStr(' type="list"/>');
      end else
        begin
//          WriteStr(' value="');
          Reader.ReadValue;
//          WriteStr('(');
          WriteStr(' value="" type="list"/>');
          Inc(NestingLevel);
          _SuppressWrite:=SuppressWrite;
          SuppressWrite:=true;
          while not Reader.EndOfList do
          begin
            NewLine;
            WriteStr('<item ');
            ConvertValue;
          end;
          SuppressWrite:=_SuppressWrite;
          Reader.ReadListEnd;
          Dec(NestingLevel);
//          WriteStr(')');
//          WriteStr('" type="list"/>');
          NewLine;
//          WriteStr('</property>');
        end;
      vaInt8, vaInt16, vaInt32:
//      if (Copy(PropName,length(PropName)-length('Color'),maxint)='Color') then
      if SubEqualEnd('Color',PropName) then
      begin
        val:=Reader.ReadInteger;
       { if (val>=256*256*256) and ColorToIdent(val,colval) then
        begin
         delete(colval,1,2);
         if SubEqual('Btn',colval) then
          colval:=CopyInsert(colval,1,4,'Button');
        end else   }
        colval:=dhPanel.ColorToString(val);
        //colval:='#'+GetHexColor(val);
{        if PropName='Font.Color' then
        if FontColor=colval then
        begin
         WriteStr(' type="hex"/>');
         exit;
        end else
         FontColor:=colval;
}
        WriteStr(' value="'+colval+'" type="hex"/>');
      end else
        WriteStr(' value="'+IntToStr(Reader.ReadInteger)+'" type="integer"/>');
      vaExtended:
        WriteStr(' value="'+FloatToStr(Reader.ReadFloat)+'" type="extended"/>');
      vaSingle:
        WriteStr(' value="'+FloatToStr(Reader.ReadSingle) + 's'+'" type="single"/>');
      vaCurrency:
        WriteStr(' value="'+FloatToStr(Reader.ReadCurrency * 10000) + 'c'+'" type="currency"/>');
      vaDate:
        WriteStr(' value="'+FloatToStr(Reader.ReadDate) + 'd'+'" type="date"/>');
      vaWString, vaUTF8String:
        begin
          W := Reader.ReadWideString;

          WriteStr(' value="'+Enc(GetRight(W))+'" type="wstring"/>');
        end;
      vaString, vaLString:
        begin
          S := Reader.ReadString;
          //if ClassName='TdhDirectHTML' then
          // WriteStr(' value="'+ConvertStringToUnicode(s,true)+'" type="string"/>') else
          begin
           WriteStr(' value="'+Enc(GetRight(S))+'" type="string"/>');
          end;
        end;
      vaFalse, vaTrue, vaNil, vaNull:
         WriteStr(' value="'+Reader.ReadIdent+'" type="ident"/>');
      vaIdent:
      if 'Cursor'=PropName then
      begin
        val:=StringToCursor(Reader.ReadIdent);
        _Cursor:=GetCursorBack(TCursor(val));
        colval:=dhPanel.CursorToString(_Cursor);
        WriteStr(' value="'+colval+'" type="ident"/>');
      end else
      if SubEqualEnd('Color',PropName) and not SubEqual('Style',PropName) then
      begin
        s:=Reader.ReadIdent;

        val:=StringToColor(s);
        colval:=dhPanel.ColorToString(val);
         // colval:=SubstText('Btn','Button',copy(Reader.ReadIdent,3,maxint));
        {if PropName='Font.Color' then
        if FontColor=colval then
        begin
         WriteStr(' type="ident"/>');
         exit;
        end else
         FontColor:=colval; }
        WriteStr(' value="'+colval+'" type="ident"/>');
      end else
         WriteStr(' value="'+Reader.ReadIdent+'" type="ident"/>');
      vaBinary:
        ConvertBinary;
      vaSet:
        begin
          Reader.ReadValue;
          WriteStr(' value="');
          WriteStr('[');
          I := 0;
          while True do
          begin
            S := Reader.ReadStr;
            if S = '' then Break;
            if I > 0 then WriteStr(', ');
            WriteStr(S);
            Inc(I);
          end;
          WriteStr(']');
          WriteStr('" type="set"/>');
        end;
      vaCollection:
        begin
          Reader.ReadValue;
          WriteStr(' value="" type="collection"/>');
          Inc(NestingLevel); 
          _SuppressWrite:=SuppressWrite;
          SuppressWrite:=true;
          while not Reader.EndOfList do
          begin
            NewLine;
            WriteStr('<item>');
            if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
            begin
              WriteStr(' [');
              ConvertValue;
              WriteStr(']');
            end;
            WriteStr(sLineBreak);
            Reader.CheckValue(vaList);
            Inc(NestingLevel);
            while not Reader.EndOfList do ConvertProperty;
            Reader.ReadListEnd;
            Dec(NestingLevel);
            WriteIndent;
            WriteStr('</item>');
          end;                  
          SuppressWrite:=_SuppressWrite;
          Reader.ReadListEnd;
          Dec(NestingLevel);
          //WriteStr('</property>');
        end;
      vaInt64:
        WriteStr(' value="'+IntToStr(Reader.ReadInt64)+'" type="int64"/>');
    else
      raise EReadError.CreateResFmt(@sPropertyException,
        [ObjectName, DotSep, PropName, IntToStr(Ord(Reader.NextValue))]);
    end;
  end;



  procedure ConvertProperty;
  begin
    WriteIndent;
    PropName := Reader.ReadStr;  // save for error reporting

    //damit wirs nicht in der xsl-datei codieren müssen:
    if PropName='ClientHeight' then
     PropName:='Height';
    if PropName='ClientWidth' then
     PropName:='Width'{ else
    if Propname='Tag' then
     PropName:='Color'}; 

    WriteStr('<property name="'+PropName+'"');
    ConvertValue;
    WriteStr(sLineBreak);
    PropName:='';//wegen DesignSize
  end;

  var sFontColor:string;
  begin
    //BinCount:=0;
    sFontColor:=FontColor;

    ConvertHeader;
    Inc(NestingLevel);
    while not Reader.EndOfList do ConvertProperty;
    Reader.ReadListEnd;
    while not Reader.EndOfList do ConvertObject;
    Reader.ReadListEnd;
    Dec(NestingLevel);
    WriteIndent;
    WriteStr('</'+ObjType+'>' + sLineBreak);
    //WriteStr('</object>' + sLineBreak);

    FontColor:=sFontColor;
  end;

begin
  ccc:=1;
  NestingLevel := 0;
  Reader := TReader.Create(Input, 4096);
  SaveSeparator := DecimalSeparator;
  DecimalSeparator := '.';
  try
    Writer := TWriter.Create(Output, 4096);
    try
      Reader.ReadSignature;
      ConvertObject;
    finally
      Writer.Free;
    end;
  finally
    DecimalSeparator := SaveSeparator;
    Reader.Free;
  end;
end;

procedure ObjectResourceToXML(Input, Output: TStream);
begin
  Input.ReadResHeader;
  ObjectBinaryToXML(Input, Output);
end;


function _ObjectTextToResource(f:TStringStream):TStringStream;
begin
    result:=f;
    result:=TStringStream.Create('');
    ObjectTextToResource(f,result);
    result.Seek(0,soFromBeginning);
    f.Free;
end;

function signedinttostr(i:integer):string;
begin
 result:=inttostr(i);
 if result[1]<>'-' then
  result:='+'+result;
end;

function SaveOverPos(const s:string; var r:integer; vn:integer; const Subst:string; var sa:string): boolean;
begin
 if bAdvPos(r,Subst,s,vn) then
 begin
  sa:=AbsCopy(s,vn,r);
  inc(r,Length(Subst));
  result:=true;
 end else
  result:=false;
end;

function FindPropEnd(const s:String; vn:integer):integer;
begin
 vn:=AdvPos('>',s,vn);
 if s[vn-1]='/' then
  result:=vn+1 else
  result:=AdvPos('>',s,AdvPos('</',s,vn))+1;
end;

function FindParentInherit(const ns:string; vn:integer; var res:integer):boolean;
var vn2:integer;
begin
 vn2:=vn;
 while (vn>1) and bAdvPosBack(vn,'<inherit',ns,vn-1) do
 if not bAdvPosBackTil(vn2,'</inherit',ns,vn,vn2) then
 begin
  res:=vn;
  result:=true;
  exit;
 end;
 result:=false
end;


function GetAttrS(const Substr,s:string; r:integer; var attr:string):boolean;
var vn1,vn2:integer;
begin
 result:=bAdvPosTil(vn1,Substr+'="',s,r,OverTag(s,r)) and bAdvPos(vn2,'"',s,vn1+length(Substr)+length('="'));
 if result then
  attr:=AbsCopy(s,vn1+length(Substr)+length('="'),vn2);
end;

function GetXMLFile(const filename,prefix:string): string; forward;

function GetXMLContent(const Content,prefix:string): string;
var d:TStringStream;
    f,f2:TStringStream;
    dd:string;
    g:tg;
    i,i2,vn,vn2:integer;
    FrameFile,FrameClass,InlineS,FrameS,PropName,ObjectName,Subst,Indent,AsP:string;
    vnInline,vnInline2,vnInline3,vnInline4,vnInlineP,vnFrame,vnFrame2,vnFrame3,vnFrame4:integer;
    SaveExtern:boolean;
    OriObjectName,clname,obname:string;
    HasSrc:boolean;
begin
   f:=TStringStream.Create(Content);

   if TestStreamFormat(f)=sofText then //we need not Text but Resource format
    f:=_ObjectTextToResource(f);


   //convert to dfm to xml
   d:=TStringStream.Create('');
   AllObjs:='';
   ObjectResourceToXML(f,d);
   f.Free;
   dd:=d.DataString;
   d.Free;
         {
   i:=1;
   while bAdvPos(i2,'type="',dd,i) and bAdvPos(i,'"',dd,i2+length('type="')) do
    FillChar(dd[i2],i-i2+1,#1);
   dd:=SubstText(#1,'',dd);
                  }

   while g.init(dd) and g.OverPos('<inline name="') and g.getPos(vn,-length('<inline name="')) and g.SaveOverPos('"',ObjectName) and g.OverPos('classname="') and g.SaveOverPos('"',FrameClass) do
   begin
    HasSrc:=Assigned(GetFrameDFM) and GetFrameDFM(FrameClass,FrameFile);
    //insert(prefix,dd,vn+length('<inline name="'),
    vn2:=AdvPos('</inline>',dd,vn)+length('</inline>');
    InlineS:=AbsCopy(dd,vn,vn2);
    if HasSrc then
     FrameS:=GetXMLFile(FrameFile,ObjectName) else
     FrameS:='<object name="x" classname="x"></object>';
    OriObjectName:=ObjectName;

    vnInline:=1;
    assert(bAdvPos(vnFrame,'"',FrameS) and bAdvPos(vnFrame2,'"',FrameS,vnFrame+1));
    FrameS:=CopyInsert(FrameS,vnFrame+1,vnFrame2,ObjectName);
    assert(bAdvPos(vnFrame,'classname="',FrameS) and bAdvPos(vnFrame2,'"',FrameS,vnFrame+length('classname="')));
    FrameS:=CopyInsert(FrameS,vnFrame+length('classname="'),vnFrame2,'TFrame');
    //AsP:='<property name="BevelOuter" value="bvNone" type="ident"/>';
    AsP:='<property name="Transparent" value="False" type="ident"/>';
    SaveExtern:=false;
    repeat//while bAdvPos(vnInline2,'<in',InlineS,vnInline+1) do
     assert(bAdvPos(vnInline,'>',InlineS,vnInline));
     //vnInline:=SkipWhiteSpaces(InlineS,vnInline+1);
     assert(bAdvPos(vnFrame,'>',FrameS,vnFrame));
     inc(vnFrame);
     //vnFrame:=SkipWhiteSpaces(FrameS,vnFrame);
     Indent:=AbsCopy(FrameS,vnFrame,SkipWhiteSpaces(FrameS,vnFrame));
     if not bAdvPos(vnInline2,'<in',InlineS,vnInline+1) then
      vnInline2:=length(InlineS);;
     if not bAdvPos(vnFrame2,'<object',FrameS,vnFrame+1   ) then
      vnFrame2:=length(FrameS);
     while (AsP<>'') or not SaveExtern and bAdvPosTil(vnInline,'<property name="',InlineS,vnInline+1,vnInline2) and SaveOverPos(InlineS,vnInline3,vnInline+length('<property name="'),'"',PropName) do
     begin
      {if PropName='SaveExtern' then
       SaveExtern:=true;    }
      if (AsP='') and bAdvPosTilOver(vnFrame3,'<property name="'+PropName+'"',FrameS,vnFrame,vnFrame2) then
      begin
       vnFrame4:=FindPropEnd(FrameS,vnFrame3);
       vnInline:=vnInline3;
       Subst:='';
       Subst:=Subst+AbsCopy(InlineS,vnInline,FindPropEnd(InlineS,vnInline));
       if (PropName='Left') or (PropName='Top') or (PropName='Width') or (PropName='Height') then
        vnFrame:=vnFrame3+length(Subst);

      end else
      begin
       vnFrame3:=vnFrame;
       vnFrame4:=vnFrame;
       Subst:=Indent;
       if AsP<>'' then
       Subst:=Subst+AsP else
       Subst:=Subst+AbsCopy(InlineS,vnInline,FindPropEnd(InlineS,vnInline));
       AsP:='';
       inc(vnFrame,length(Subst));
      end;     
      FrameS:=CopyInsert(FrameS,vnFrame3,vnFrame4,Subst);
      dec(vnFrame2,(vnFrame4-vnFrame3)-length(Subst));
     end;
     if not bAdvPosTilOver(vnInline,'<inherited name="',InlineS,vnInline2,length(InlineS)) then break;
     vnInlineP:=vnInline-length('<inherited name="');
     SaveExtern:=SaveExtern and not (bAdvPosTilOver(vnInline4,'</inherited>',InlineS,vnInline2,vnInline) and bAdvPosTilOver(vnInline4,'</inherited>',InlineS,vnInline4,vnInline2));
     assert(SaveOverPos(InlineS,vnInline,vnInline,'"',ObjectName));

     while FindParentInherit(InlineS,vnInlineP,vnInlineP) do
     if GetAttrS('classname',InlineS,vnInlineP,clname) and (DFMs.IndexOfName(clname)<>-1) and GetAttrS('name',InlineS,vnInlineP,obname) then
      ObjectName:=obname+ObjectName;
     assert(bAdvPos(vnFrame,'<object name="'+ObjectName+'"',FrameS,vnFrame2));
    until false;
    SaveExtern:=false;
    dd:=CopyInsert(dd,vn,vn2,endl+'<'+AnsiSubstText('<object name="','<object name="'+OriObjectName,copy(FrameS,2,maxint)));
   end;
   if prefix<>prefix+' ' then
   result:=dd;
end;

function GetXMLFile(const filename,prefix:string): string;
begin
 result:=GetXMLContent(StringFromFile({ResolveRelativeURL(}BaseDir+FileName{)}),prefix);
end;


//var glMainIDs2,glStyleBodys2:TMyStringList;



//const sst:array[TStat] of string=('_mn','_dn','_hr','_hd');

function GetMn(const s:string; const wh:TState=hsNormal):string;
begin
 result:=s+sst[wh];
end;

function SortStyles(Item1, Item2: TNest): Integer;
begin
 result:=Item2.Refs-Item1.Refs;
end;




function GoodStyle(const glStyle:string):string;
begin
 result:=glStyle;
 if Compress then
 if (result<>'') and (result[length(result)]=';') then
  delete(result,length(result),1);
end;

function MakeIndent(Level: Integer): string;
begin
 Result := '';
 if not Compress then
  result:=StringOfChar(' ',2*Level);
end;

var NeedJS,NeedButton,Need1by1,NeedSplit:boolean;


function GetNextPage(FLinkPage:TNest; FPageRange,CurrPage,RealLinkPage,RealLastPage:integer):string;
var z,v:integer;
begin
  if FPageRange<0 then
   z:=-1 else
   z:=1;
  v:=CurrPage;
  if (v*z>=RealLinkPage*z) and (v*z<RealLastPage*z) then
   result:=tnest(FLinkPage.parent[v+z]).PureFileName else
   result:=tnest(FLinkPage.parent[RealLinkPage]).PureFileName;
end;

function GetFrame(n:TNest):TNest;
begin
 result:=n;
 while result.parentTS<>nil do
  result:=result.parentTS;
end;

procedure getURI(nest:TNest; var href,target:string; AllPCs:TStringList);
var FPageRange,CurrPage,RealLinkPage,RealLastPage,r:integer;
    FLinkPage:TNest;
begin
 href:='';
 target:='';
 if not nest.HasProp('PageTarget',target) then
   nest.HasProp('Target',target);
 nest.HasProp('Link',href);

 if (nest.LinkPage<>'') and not nest.HasProp('RealLinkPage') {and (nest.PageRange<>0)} and gln.IndexOf(nest.LinkPage,RealLinkPage) then
 begin
  FLinkPage:=tnest(gln.Objects[RealLinkPage]);
  RealLinkPage:=FLinkPage.parent.IndexOf(FLinkPage);
  RealLastPage:=min(FLinkPage.parent.Count-1,RealLinkPage+abs(nest.PageRange));
  for CurrPage:=RealLinkPage to RealLastPage do
  if (CurrPage=RealLastPage) or Assigned(AllPCs) and (AllPCs.IndexOf(tnest(FLinkPage.parent[CurrPage]).id)<>-1) then
  begin
   if nest.PageRange<0 then
    Exch(RealLinkPage,RealLastPage);
   (*if {HasProp('Href',href) and }bAdvPos(r,'#',href) then
    delete(href,1,r-1) else
    href:='';*)
   href:=GetNextPage(FLinkPage, nest.PageRange,CurrPage,RealLinkPage,RealLastPage);
   if href<>'' then //javascript
   begin
   if (target='') then
   if GetFrame(nest)<>GetFrame(FLinkPage) then
    target:=GetFrame(FLinkPage).id;
   end;
   break;
  end;
 end;

end;


function getURINested(pnest:TNest; var href,target:string; AllPCs:TStringList):boolean;
var i:integer;
    nest:TNest;
    _href:String;
begin
 for i:=0 to pnest.Count-1 do
 begin
  nest:=TNest(pnest[i]);
  if (nest.Props<>nil) and (nest.dclass='TdhLink') and nest.IsProp('FormButtonType','fbSubmit') then
  begin
   getURI(nest,_href,target,AllPCs);
   if _href<>'' then
   begin
    href:=_href;
    result:=true;
    exit;
   end;
  end;
  if nest.Show and getURINested(nest,href,target,AllPCs) then
  begin
   result:=true;
   exit;
  end;
 end;
 result:=false;
end;

procedure AddFinalClass(nest:TNest; var attributes,attributes2:string; AllPCs:TStringList; var finalclass:string; IsTopLink:boolean);
var hclass:string;
    href,target,fragment,scrollFragment:string;
    nestFragment:TNest;
    iFragment:integer;
var RealLinkPage,iLinkAnchor:integer;
    FLinkPage,FLinkAnchor:TNest;


procedure AddAttr(const Name,Value:string); overload;
begin
 attributes:=attributes+' '+Name+'="'+Value+'"';
end;

procedure AddAttr2(const Name,Value:string); overload;
begin
 attributes2:=attributes2+' '+Name+'="'+Value+'"';
end;

begin
 if (nest.Props<>nil) and (nest.dclass='TdhHTMLForm') then
 begin
  nest.HasProp('Action',href);
  nest.HasProp('Target',target);
  getURINested(nest,href,target,AllPCs);
  if href<>'' then
   AddAttr('action',href);
  if target<>'' then
   AddAttr('target',target);
 end;

 if (nest.Props<>nil) and (nest.tag='iframe') and (nest.Count>=1) then
 begin
   FLinkPage:=tnest(tnest(nest[0]));
   AddAttr('src',FLinkPage.PureFileName);
 end;


 if (nest.Props<>nil) and (nest.dclass='TdhLink') and not nest.HasProp('FormButtonType') then
 begin

 getURI(nest,href,target,AllPCs);

 fragment:='';
 if nest.HasProp('LinkAnchor',fragment) then
 begin
  href:=href+'#'+fragment;
  if gln.IndexOf(fragment,iLinkAnchor) then
  begin
   FLinkAnchor:=tnest(gln.Objects[iLinkAnchor]);
   if FLinkAnchor.HasProp('HTMLFileName',href) then
    target:='';
  end;
 end;

 scrollFragment:='';
 nestFragment:=nil;
 if (href<>'') and (href[1]='#') then
 if gln.IndexOf(copy(href,2,maxint),iFragment) then
 begin
  nestFragment:=tnest(gln.Objects[iFragment]);
  if (nestFragment.parent<>nil) and nestFragment.parent.IsBody then
   scrollFragment:='scrollFragment('''+href+''')';
 end;


 if (href='') and (nest.tag='a') then
 begin
  if true or nest.HasProp('LinkPage') then
   href:='javascript:;' else
   href:='javascript:alert(''link not specified'')';
 end;
 if href<>'' then
 if (nest.tag<>'a') or (scrollFragment<>'') then
 begin
  if SubSame('javascript:',href) then
     AddAttr('onclick',href) else
  if (target='') or (target='_self') then
   AddAttr('onclick','self.location.href='''+href+''''+_if(scrollFragment<>'',';'+scrollFragment,'')) else
  if gln.Find(target) then
  begin
   AddAttr('onclick','frames.'+target+'.location.href='''+href+''''+_if(scrollFragment<>'',';'+scrollFragment,''));
   if target<>'' then
    AddAttr('target',target); //read out in dfm2html.js
  end else
   AddAttr('onclick','window.open('''+href+''','''+target+''')');
  if nest.tag='a' then
   AddAttr('href','javascript:;');
//   AddAttr('onclick','javascript:window.frames['''+target+'''].location.href='''+href+'''');
 end else
 begin
  AddAttr('href',href);
  if target<>'' then
   AddAttr('target',target);
  if scrollFragment<>'' then
   AddAttr('onclick',scrollFragment);
 end;

 end;

 if nest.StyleStored or nest.NeedOwnClass then
  hclass:=nest.id else
 if nest.Use<>nil then
  hclass:=nest.Use.id else
  hclass:='';

 finalclass:='';

 if hclass<>'' then
 begin
  if nest.IsDown and (nest.auto<>nil) and nest.auto.contains('Options','loDownIfURL') or nest.IsAlwaysDown then
  begin
   finalclass:=GetMn(hclass,hsNormal)+' '+GetMn(hclass,hsDown);
   if NeedJS then
    AddAttr2('down','true');
   if scrollFragment<>'' then
  end else
   finalclass:=GetMn(hclass,hsNormal);
  if IsTopLink and nest.IsDyn then
   AddAttr2('cbase',hclass);
 end;


 if finalclass<>'' then
  AddAttr2('class',finalclass);
end;


function FinalCharacters(nest:TNest; AllPCs:TStringList):string;
var unest,pnest:TNest;
    i,w:integer;
var vn,itag,r,von,itagbs:integer;
    Closing,EmptyEle:boolean;
    text:HypeString;
    tag,attributes,s,clean_s,res,addimg:string;
    newtag,attributes_class,AddProps,finalclass:string;
    Gate:integer;
begin
    s:=nest.Characters;
    result:=s;
    if nest.dclass='TdhDirectHTML' then
     exit;
    clean_s:=WithoutComments(s,' ');
    res:='';
    if clean_s='' then exit;
    vn:=1;
    von:=1;
    if {(nest.tag='button') or (nest.tag='a') or (nest.tag='input')}nest.IsDyn then
     Gate:=1 else
     Gate:=0;
    while getTag2(clean_s,vn,itag,itagbs,tag,text,Closing,EmptyEle) and (itag<>0) do
    begin
     //if (tag<>'b') and (tag<>'i') and (tag<>'u') and (tag<>'br') then
     if gln.Find(tag,r) then
     begin
      unest:=tnest(gln.Objects[r]);
      newtag:=unest.tag;
      attributes:='';
      if newtag='div' then
       newtag:='span';
      if newtag='input' then
       newtag:='button';
      if {unest.HasProp('TheoreticRastering') or unest.HasProp('TheoreticRasteringBG') and not unest.Img}unest.IsRastered(false) then
       AddWarning(nest.id,'contains rastered objects, like '+unest.id+'. It is not supported yet to format a text section with rastering-requiring (not CSS supported) effects, like a shadow or rounded corners. Look at Context Menu | Styles | Show Style Information for '+unest.id+' to see why '+unest.id+' is rastered.');
      if unest.IsDyn then
      if not Closing then
      begin
        if Gate>=1 then
        begin
         newtag:='span';
         //AddWarning(nest.id,'contains invalid nested elements');
        end;
        inc(Gate);
      end else
      begin
        dec(Gate);
        if Gate>=1 then
         newtag:='span';
      end;
      if Closing then
      begin
       if unest.img then
        res:=res+abscopy(s,von,itag-2){+'</'+newtag+'>'} else
        res:=res+abscopy(s,von,itag)+newtag+'>';
      end else
      begin

      if nest.InlineUse=nil then
       nest.InlineUse:=TList.Create;
      if nest.InlineUse.IndexOf(unest)=-1 then
       nest.InlineUse.Add(unest);

      if unest.UsedInlineBy=nil then
       unest.UsedInlineBy:=TList.Create;
      if unest.UsedInlineBy.IndexOf(nest)=-1 then
       unest.UsedInlineBy.Add(nest);


      //unest.UsedInline:=true;
      if unest.properties<>'' then
       AddProps:=' style="'+unest.properties+'"' else
       AddProps:='';
      if unest.img then
      begin
       attributes_class:='';
       AddFinalClass(unest,attributes,attributes_class,AllPCs,finalclass,Gate=1);
       if attributes=' href="javascript:;"' then
        attributes:='';
       if (newtag='a') and (attributes<>'') then
        res:=res+absCopy(s,von,itag)+newtag+attributes+'>'+'<img src="onebyone.gif"'+attributes_class+unest.attributes+AddProps+'/></a>' else
        res:=res+absCopy(s,von,itag)+'img'+' src="onebyone.gif"'+attributes_class+attributes+unest.attributes+AddProps+'/>';
      end else
 {     if unest.img then
      begin
       attributes_class:='';
       AddFinalClass(unest,attributes,attributes,AllPCs);
       res:=res+absCopy(s,von,itag)+'img'+' src="onebyone.gif"'+attributes+unest.attributes+'/>';
      end else}
      begin
       AddFinalClass(unest,attributes,attributes,AllPCs,finalclass,Gate=1);
       res:=res+absCopy(s,von,itag)+newtag+attributes+unest.attributes+AddProps;
       if newtag='img' then
        res:=res+'/';
       res:=res+'>';
      end;
      {if unest.img then
       res:=res+'<img src="onebyone.gif" style="border:0px; width:inherit; height:inherit; background-image:inherit; vertical-align:inherit; '+'width:expression(parentNode.currentStyle.width); height:expression(parentNode.currentStyle.height); background-image:expression(parentNode.currentStyle.backgroundImage); vertical-align:expression(parentNode.currentStyle.verticalAlign); ">';
      }
      if unest.CloneCharacters then
       res:=res+unest.Characters+'</a>';
      end;
      von:={CharPos(s,'>',itag)}vn;
     end;
     vn:=itag;
    end;
    res:=res+copy(s,von,maxint);
    if SubEqual('Tdh',nest.dclass) then
     res:=AnsiSubstText(#13,#13#10,res);
    result:=res;
end;


function IsSlice(const s:string):boolean;
begin
 result:=Pos('|',s)<>0;
end;

var TopPC:String;

procedure savenested(nest:tnest);
var ns,pre:string;
    i,last_in:integer;
    pnest,pagenest:tnest;
    filename,PureFileName:string;
    Preload:TMyStringList;
var AllPCs:TStringList;




function GetSelectorJS(s:string; st:TState):string;
begin
 if NeedJS or not (st in [hsOver,hsOverDown]) then
  result:=GetMn(s,st) else
  result:=GetMn(s,Pred(Pred(st)))+':hover';
end;

procedure AddToPreload(backimg:string);
begin
 backimg:=''''+backimg+'''';
 if not Preload.Find(backimg) then
  Preload.Add(backimg);
end;

function CallTemplate_get_WidthHeight(nest:TNest; const _sty:TState):string;

function CallTemplate_get_WidthHeight2(const sty:string; easy:boolean):string;
var w,h:integer;
    //Client:TRect;
begin
  //Client:=nest.RealParent.Client;

  w:=nest.bo.Width{nest.Client.Right-nest.Client.Left}{!!};
  if not nest.AutoX and (nest.HasProp(sty+'Width',w) or Easy) then
  begin
   if {(nest.Align<>alTop) and }(akLeft in nest.Anchors) and (akRight in nest.Anchors) then
   begin
    if directIE then result:=result+'width:expression('+nest.offsetParent+'.clientWidth'+signedinttostr(-(nest.RealParent.clientWidth-w+nest.frameborder.X))+');'+IndentSpace;
   end
   else
   begin
    result:=result+'width:'+inttostr(w)+'px;'+IndentSpace;
    if w<0 then
     AddWarning(nest.id,'has a negative width. Reducing padding sizes may solve this problem.');
    if (w=0) and (nest.bo.Width=0) then
     AddWarning(nest.id,'has a width of 0. The object is thereof not visible.');
   end;
  end;
  w:=nest.bo.Height{nest.Client.Bottom-nest.Client.Top};
  if not nest.AutoY and (nest.HasProp(sty+'Height',w) or Easy) then
  begin
   if (akTop in nest.Anchors) and (akBottom in nest.Anchors) then
   begin
    if directIE then result:=result+'height:expression('+nest.offsetParent+'.clientHeight'+signedinttostr(-(nest.RealParent.clientHeight-w+nest.frameborder.Y))+');'+IndentSpace;
   end
   else
//   if (akTop in nest.OriAnchors) and (akBottom in nest.OriAnchors) then
//    result:=result+'height:'+inttostr(w+nest.addheight{+nest.parent.addheight})+'px;'+IndentSpace else
   begin
    result:=result+'height:'+inttostr(w+nest.addheight)+'px;'+IndentSpace;
    if w<0 then
     AddWarning(nest.id,'has a negative height. Reducing padding sizes may solve this problem.');
    if (w=0) and (nest.bo.Height=0) then
     AddWarning(nest.id,'has a height of 0. The object is thereof not visible.');
   end;
  end;
end;

var //easy:boolean;
    Rastering:string;
    NewPadding:string;
    NewMargin:string;
    NewBorder:string;

procedure AddStyle(const Name,Value:string);
begin
 result:=result+Name+':'+Value+';'+IndentSpace;
end;


var sty:string;
begin
 result:='';
 sty:=sStyle[_sty]+'.';
 if (nest.tag<>'iframe') then
 begin
 if nest.HasProp(sty+'NewMargin',NewMargin) then
 begin
  AddStyle('margin',NewMargin);
 end;
 if nest.HasProp(sty+'NewPadding',NewPadding) then
 begin
  AddStyle('padding',NewPadding);
 end;
 if nest.HasProp(sty+'NewBorder',NewBorder) then
 begin
  AddStyle('border',NewBorder);
 end;
 result:=result+nest.FlattenedStyle[_sty];
 end;
 if (nest.HasProp(sty+'Rastering',Rastering) or nest.HasProp(sty+'BGRastering',Rastering)) and AdjustAlternativeRastering(TopPC,nest.id,Rastering) then
 if IsSlice(Rastering) then
 begin
   AddStyle('background','none');
 end else
 begin
  if (_sty<>hsNormal) and ((_sty<>hsDown) or nest.auto.contains('Options','loDownIfMouseDown') or nest.auto.contains('Options','loDownIfMenu') and (nest.menu<>nil)) then
   AddToPreload(Rastering);
  if _sty=hsNormal then
   AddStyle('background','url("'+Rastering+'") no-repeat transparent') else
   AddStyle('background-image','url("'+Rastering+'")');
  if nest.IsRastered(true) then
  begin
   AddStyle('filter','progid:DXImageTransform.Microsoft.AlphaImageLoader(src='+Rastering+',sizingmethod=crop'+')');
   AddStyle('background','expression("none")');
   {if nest.PngToChild then
    DoVoice:=true;}
  end else
  if (_sty=hsNormal) and (nest.HasProp('Style.UndefFilter') or nest.HasProp('StyleOver.UndefFilter') or nest.HasProp('StyleDown.UndefFilter') or nest.HasProp('StyleOverDown.UndefFilter')) then
  begin
   AddStyle('filter','none');
  end;
  //AddStyle('cursor','pointer');
 end;
 if not nest.IsBody then
 begin
  result:=result+CallTemplate_get_WidthHeight2(sty,_sty=hsNormal);
 end;
end;

var vv:TList;




procedure StyleArrange;
var s:string;
    ss:array[TState] of string;
    i,ii,p,r:integer;
    ws:boolean;
    sog:tg;
    backimg:string;
    nest,unest:TNest;
    st:TState;
    OverBasedOnDown:boolean;
const rs:array[boolean,TState] of TState=((hsNormal,hsDown,hsOver,hsOverDown),(hsNormal,hsOver,hsDown,hsOverDown));
//const rs:array[boolean,TState] of TStat=((stMN,stDN,stOV,stOD),(stMN,stOV,stDN,stOD));

function GetS(nest:tnest; st:TState):string;
var i:integer;
    pnest:TNest;
begin
 result:=','+'.'+GetSelectorJS(nest.id,st);

 if (nest.UsedInlineBy<>nil) and (st<>hsNormal){ and (nest.dclass='TdhLink')} then
 {for i:=0 to nest.UsedInlineBy.Count-1 do
 begin
 pnest:=TNest(nest.UsedInlineBy[i]);
 if pnest.Show then
  result:=result+','+'.'+GetSelectorJS(pnest.id,st)+' '+'.'+GetSelectorJS(nest.id,stMN);
 end;}
 if nest.UsedInlineBy.Count<>0 then
  result:=result+','+'.'+AnsiSubstText('_','',GetSelectorJS('',st))+' '+'.'+GetSelectorJS(nest.id,hsNormal);

end;



begin


 for i:=0 to gln.Count-1 do
  TNest(gln.Objects[i]).IsIn:=false;

{ for i:=0 to gln.Count-1 do
  TNest(gln.Objects[i]).UsedInline:=false;
 }
{ for i:=0 to glMainIDs2.Count-1 do
  glMainIDs2.Objects[i]:=nil;}
   {if (nest.hclass<>'') and glMainIDs2.Find(nest.hclass,r) then
    glMainIDs2.Objects[r]:=pointer(boolean(glMainIDs2.Objects[r]) or true);}


 vv.Sort(TListSortCompare(@SortStyles));

 s:='';
                         {
 for i:=vv.Count-1 downto 0 do
  assert(TNest(vv[i]).IDs='');}

 for st:=hsOverDown downto hsNormal do
 for i:=vv.Count-1 downto 0 do
 begin
  nest:=TNest(vv[i]);
//  if nest.Show then
  begin
   OverBasedOnDown:=false;
   pnest:=nest;
   if pnest.StyleStored or pnest.NeedOwnClass then
   while pnest<>nil do
   begin

    if OverBasedOnDown or pnest.OverBasedOnDown and (st=hsOver) then
     pnest.IDs[hsDown]:=pnest.IDs[hsDown]+GetS(nest,st);
    if not OverBasedOnDown then
     pnest.IDs[st]:=pnest.IDs[st]+GetS(nest,st);
    if not OverBasedOnDown and pnest.OverBasedOnDown and (st=hsOver) then
     OverBasedOnDown:=true;
    pnest:=pnest.Use;
   end;
   if (nest.IDs[st]<>'') and (nest.Style[st]<>'') then
   begin
    //wenn images mit 'Cache-Control: no-cache, must-revalidate' zurückgesendet werden, wird IMMER neuer Server-Kontakt aufgebaut, egal ob preloaded
    if (st>hsNormal) and sog.Init(nest.Style[st]) and sog.OverPos('background-image:url(''') and sog.SaveOverPos('''',backimg) then
     AddToPreload(backimg);
    s:=copy(nest.IDs[st],2,maxint)+IndentSpace+'{'+nest.Style[st]+'}'+CRLF;
    ss[rs[nest.DownOverlayOver,st]]:=s+ss[rs[nest.DownOverlayOver,st]];
   end;
  end;
  nest.IDs[st]:='';
 end;

 s:='';
 for st:=hsOverDown downto hsNormal do
  s:=ss[st]+s;

(* for i:=0 to glMainIDs2.Count-1 do
 if boolean(glMainIDs2.Objects[i]) then
  s:=s+'.'+glMainIDs2[i]+IndentSpace+'{'+glStyleBodys2[i]+'}'+CRLF;
 *)


(*

// RRestIDs:=TMyStringList.Create;
 li:=TList.Create;
 for i:=0 to glMainIDs.Count-1 do
 if (glStyleBodys[i]<>'') and (RestIDs[i]<>'') then
  li.Add(Pointer(i));
// li.Sort(TListSortCompare(@SortStyles));
 s:='';
 for i:=0 to li.Count-1 do
 begin
  ii:=Integer(li[i]);
  if (GetGrob(ii)>stMN) and sog.Init(glStyleBodys[ii]) and sog.OverPos('background-image:url(''') and sog.SaveOverPos('''',backimg) then
   Preload.Add(''''+backimg+'''');
  s:=s+{MakeIndent(3)+}GetSelectorJS(copy(RestIDs[ii],2,maxint))+IndentSpace+'{'+glStyleBodys[ii]+'}'+CRLF;
 end;

        *)
 pre:=s+pre;

end;



var classpos,r:integer;
    inhalt,sinhalt,attr:string;



            {
procedure GetWarnings;
var vn,attrpos:integer;
    LinkForm,ID:string;
begin
 vn:=length(ns);
 while bAdvPosBack(vn,' LinkForm="',ns,vn) and FindOut(ns,vn,inhalt) and GetAttr('LinkForm',inhalt,attrpos,LinkForm) and GetAttr('id',inhalt,attrpos,ID) do
 if DFMs.IndexOfName('T'+LinkForm)=-1 then
  Warnings:=Warnings+endl+FormName+'.'+ID+' references not existing form '+LinkForm;
end;
        }








procedure WriteNs(nest:TNest; CurIndent:integer);
var i:integer;
    properties,attributes:string;



var Client:TRect;
    bo:TBounds;

var glStyle:string;

procedure AddStyle(const Name,Value:string); overload;
begin
 glStyle:=glStyle+Name+':'+Value+';'+IndentSpace;
end;

procedure AddStyle(const Name:string; Value:integer); overload;
begin
 AddStyle(Name,inttostr(Value)+'px');
end;


procedure AddAttr(const Name,Value:string); overload;
begin
 attributes:=attributes+' '+Name+'="'+Value+'"';
end;



var
MinHeight:integer;
cPre,s:string;
Indent:boolean;
outrct,bnds:TRect;
var OneWarning,finalclass:string;
CenterLeft,CenterRight:integer;
CenterOffsetPx:string;
cnest:TNest;
var EqNaming:array[0..2,0..2] of String;
Rastering:string;
EqX,EqY:integer;
sPositionings,OuterElementProps:string;
closeSecondDiv:boolean;
//var ChildCurIndent:integer;

function GetRange(const EqRect:TRect; sides:TAnchors):String;

procedure GetS(anchor:String; i:integer);
begin                                     
  Result:=Result+' '+anchor+':'+IntToStr(i)+'px;';
end;


begin
 Result:='';
 if [akLeft,akRight]*sides=[akLeft,akRight] then
 begin
  GetS('left',EqRect.Left);
  GetS('right',EqRect.Right);
 end;
 if [akLeft,akRight]*sides=[akLeft] then
 begin
  GetS('left',0);
  GetS('width',EqRect.Left);
 end;
 if [akLeft,akRight]*sides=[akRight] then
 begin        
  GetS('right',0);
  GetS('width',EqRect.Right);
 end;

 if [akTop,akBottom]*sides=[akTop,akBottom] then
 begin
  GetS('top',EqRect.Top);
  GetS('bottom',EqRect.Bottom);
 end;
 if [akTop,akBottom]*sides=[akTop] then
 begin
  GetS('top',0);
  GetS('height',EqRect.Top);
 end;
 if [akTop,akBottom]*sides=[akBottom] then
 begin                   
  GetS('bottom',0);
  GetS('height',EqRect.Bottom);
 end;

end;


procedure AddSlice(const image,_repeat,position:String; zindex:integer; const sides:String);
var alpha:String;
begin
 if image='' then exit;
 alpha:='';
 if SubEqualEnd('.png',image) then
 begin
   alpha:=alpha+'filter'+':'+'progid:DXImageTransform.Microsoft.AlphaImageLoader(src='+image+',sizingmethod=scale'+')'+'; ';
   alpha:=alpha+'background'+':'+'expression(''none'')'+'; '+'overflow:hidden; ';
 end;

 cPre:=cPre+CRLF+MakeIndent(CurIndent+1)+'<div class="fill" style="background:url('''+image+''') '+_repeat+' '+position+'; z-index:'+inttostr(zindex)+'; '+sides+alpha+'"></div>';
// cPre:=cPre+CRLF+MakeIndent(CurIndent+1)+'<div style="position:absolute;left:0px;top:0px;width:100%;height:100%;width:expression(parentNode.clientWidth);background:url('''+image+''') '+_repeat+';background-position:'+position+';"></div>';
 //cPre:=cPre+CRLF+MakeIndent(CurIndent+1)+'<div style="position:absolute;left:0px;top:0px;width:100%;height:100%;background:url("'+image+'") '+_repeat+' '+position+'"></div>';
end;

function extract(prop:string):string;
var r,e:integer;
begin
 result:='';
 r:=1;
 while bAdvPos(r,prop+':',glStyle,r) do
 if (r-1>=1) and (glStyle[r-1]='-') then
  inc(r) else
 begin
  if not bAdvPos(e,';',glStyle,r) then
   e:=length(glStyle);
  while (e+1<=length(glStyle)) and (glStyle[e+1]=' ') do
   inc(e);
  result:=result+copy(glStyle,r,e-r+1);
  delete(glStyle,r,e-r+1);
 end;
end;

function ExtractEq(var Rastering:String):String;
var EqI:Integer;
begin
   EqI:=Pos('|',Rastering);
   Result:=Copy(Rastering,1,EqI-1);
   Delete(Rastering,1,EqI);
end;

var EqArea:TRect;

begin
 if not nest.Show {and (nest.dclass='TdhPage')} then exit;

 if nest.Melt{ and not nest.IsBody} then
 begin
  for i:=0 to nest.Count-1 do
   WriteNs(nest[i],CurIndent);
  exit;
 end;

 Indent:={(nest.tag<>'divdel') and }not Compress and not(((nest.dclass='TSpeedButton') or (nest.dclass='TRxSpeedButton') or (nest.dclass='TRadioButton') or (nest.dclass='TCheckBox') or (nest.dclass='TdhRadioButton') or (nest.dclass='TdhCheckBox')) and (nest.Props=nil));

 //ChildCurIndent:=CurIndent+1;
 properties:=nest.properties+nest.addprops;
 attributes:=nest.attributes;


            {
 if (nest.parentTS=nil) and (Preload.Count<>0) then
 begin
  Preload.Delimiter:=',';
  attributes:=attributes+' onload="preload_img('+Preload.DelimitedText+')"';
 end;
                      }

 {if nest.FinalHeight<>0 then
  AddStyle('height',nest.FinalHeight+nest.addheight) else }

 if nest.IsBody then
 begin
//  AddStyle('position','relative');
// height:expression(all.TdhLabel1.offsetTop+all.TdhLabel1.offsetHeight);
  {
  MinHeight:=0;
  HasProp('Contraints.MinHeight',MinHeight);
  for i:=0 to nest.Count-1 do
   MinHeight:=max(MinHeight,TNest(nest[i]).bo.Top+TNest(nest[i]).bo.Bottom); }
  if nest.dclass<>'TdhPageControl' then
  begin
   {MinHeight:=0;
   for i:=0 to nest.Count-1 do
   begin
    cnest:=TNest(nest[i]);
    if cnest.Show and not (akBottom in cnest.Anchors) then
     MinHeight:=max(MinHeight,(cnest.bo.Top-nest.Client.Top)+cnest.FinalHeight);
   end;
   AddStyle('height',MinHeight);
   Da Moz, Firefox, Netscape alle kaputte Selektion: nur für IE machen wir diesen scheiss nich!
   }
    {
   AddStyle('height','100%');
   AddStyle('width','100%');       }
  end;
 end;
                         
 glStyle:=glStyle+nest.pmn;

 if (nest.Props<>nil) {and (nest.parent<>nil)} then
 begin
 if not nest.IsBody then
 if nest.dclass<>'TdhPageControl' then
 begin
 assert(nest.parent<>nil);

 //inc(bo.Bottom,nest.addheight);

 bo:=nest.bo;
 pnest:=nest.RealParent;

 Client:=pnest.Client;
 //inc(Client.Bottom,pnest.addheight);

 if not nest.IsPopupMenu then
 begin
 if (bo.Top<>maxint) and ({nest.Anchors<>[]}nest.Align<>alTop) {and not IsProp('Align','alClient')} { (nest.HasProp('ParentMenuItem') and not nest.contains('MenuOptions','moInline'))}{ and not nest.HorizontalCenter} then
  AddStyle('position','absolute') else
/// if nest.dclass='TdhLink' then
  begin
  //if nest.tag<>'a' then
   AddStyle('position','relative');
  //AddStyle('overflow','visible');
  end;

  if {(nest.dclass<>'TdhOleContainer') and }(nest.tag<>'iframe') and (nest.tag<>'textarea') and (nest.tag<>'select') and (not nest.AutoY or not nest.AutoX) and not ((nest.Count<>0) and nest.OriginalAutoX and nest.OriginalAutoY){ and not ((nest.Count=0) and (nest.AutoX or nest.AutoY))} and not ((nest.Count=0) and (nest.AutoX and nest.AutoY)) and not nest.IsScrollable then
   AddStyle('overflow','hidden');
 end;

 if not nest.IsPopupMenu{ and (nest.dclass<>'TdhPage')} then
 begin
                              
 if nest.Align<>alTop then
 begin
 if akTop in nest.Anchors then
  AddStyle('top',bo.Top-Client.Top+nest.addtop);
 if akLeft in nest.Anchors then
  AddStyle('left',bo.Left-Client.Left);
 if akBottom in nest.Anchors then
 begin
  AddStyle('bottom',Client.Bottom+nest.HeightDiff-(bo.Top+bo.Height));
  if directIE then if not (akTop in nest.Anchors) then AddStyle('bottom','expression('+inttostr(Client.Bottom-(bo.Top+bo.Height))+'-'+nest.offsetParent+'.clientHeight % 2)');
 end;
 if akRight in nest.Anchors then
{if (pnest<>nil) and pnest.IsBody and not((pnest.parent<>nil) and pnest.parent.HasProp('NotFixScrollbar')) then
  AddStyle('right',Client.Right-(bo.Left+bo.Right)-16) else
}
 begin
  AddStyle('right',Client.Right-(bo.Left+bo.Width));
  //if (pnest<>nil) and pnest.IsBody then
   if directIE then if not (akLeft in nest.Anchors) then AddStyle('right','expression('+inttostr(Client.Right-(bo.Left+bo.Width))+'-'+nest.offsetParent+'.clientWidth % 2)');
 end;

 //2 gründe warum javascript-top-berechnung nicht weglassen (und nur bottom dalassen):
 //1. bei IE bezieht sich bottom auf unteren rand INKLUSIVE horz. scrollbar
 //2. bei IE wird erst beim erneuten laden an richtige stelle gebracht
 //3. wird nicht von IE5 untersützt
 //4. bei "top": margin-veränderung bei mouse-over wird nicht berücksichtigt 
 //Änderung: jetzt EXCLUSIVE horz. scrollbar. und 2. benötigt ein expression()-ausdruck; wird in java-script datei gemacht, da nicht gleichzeitig bottom:10px definiert sein darf

 //if ([akBottom,akTop]*nest.Anchors=[akBottom]) and (pnest<>nil) and pnest.IsBody then
 // AddStyle('top','expression('+nest.offsetParent+'.clientHeight-offsetHeight'+signedinttostr(-(nest.RealParent.clientHeight-(bo.Top+bo.Height)+nest.frameborder.Y+nest.iProp('MarginVert')))+')');


 //left lassen wir weg da unnötig
{ if ([akRight,akLeft]*nest.Anchors=[akRight]) and (pnest<>nil) and pnest.IsBody then
  AddStyle('left','expression('+nest.offsetParent+'.offsetWidth-offsetWidth'+signedinttostr(-(Client.Right-Client.Left-(bo.Left+bo.Width)+nest.frameborder.X+nest.iProp('MarginHorz')))+')');
 }

 if [akLeft,akRight]*nest.Anchors=[] then
 //if not nest.HasProp('Center') then
 begin
  {AddStyle('left',inttostr(round((bo.Left+bo.Width/2)/Client.Right*100))+'%');
  AddStyle('margin-left',-bo.Width div 2 );}
  AddStyle('left',0);
  AddStyle('right',0);
  AddStyle('margin-left','auto');
  AddStyle('margin-right','auto');
  if directIE then AddStyle('left','expression(Math.max(0,'+nest.offsetParent+'.clientWidth/2-clientWidth/2))');

 end;
 if [akTop,akBottom]*nest.Anchors=[] then
 begin
  AddStyle('top','50%');
  //AddStyle('top',inttostr(round((bo.Top+bo.Height/2)/Client.Bottom*100))+'%');
  AddStyle('margin-top',-bo.Height div 2 );
 end;
 end;
 end;

    (*

 if HasProp('StyleStored'){ or HasProp('ConstantWidthHeight')} then
  nest.hclass:=nest.id+'_mn' else
 if HasProp('FirstRealUse',FirstRealUse) then
  nest.hclass:=FirstRealUse+'_mn';
      *)
 //if (nest.dclass<>'TImage') or nest.IsProp('Stretch','True') then



 if(nest.HasProp('Style.Rastering',Rastering) or nest.HasProp('Style.BGRastering',Rastering)) and AdjustAlternativeRastering(TopPC,nest.id,Rastering) and IsSlice(Rastering) then
 begin
  for EqY:=0 to 2 do
  for EqX:=0 to 2 do
  begin
   EqNaming[EqX,EqY]:=ExtractEq(Rastering);
  end;
  EqArea.Top:=StrToInt(ExtractEq(Rastering));
  EqArea.Bottom:=StrToInt(ExtractEq(Rastering));
  EqArea.Left:=StrToInt(ExtractEq(Rastering));
  EqArea.Right:=StrToInt(ExtractEq(Rastering));

  AddSlice(EqNaming[1,1],'repeat','0% 0%',-99,GetRange(EqArea,[akTop,akBottom,akLeft,akRight]));

  AddSlice(EqNaming[0,0],'no-repeat','0% 0%',-97,GetRange(EqArea,[akTop,akLeft]));
  AddSlice(EqNaming[2,0],'no-repeat','100% 0%',-97,GetRange(EqArea,[akTop,akRight]));
  AddSlice(EqNaming[0,2],'no-repeat','0% 100%',-97,GetRange(EqArea,[akBottom,akLeft]));
  AddSlice(EqNaming[2,2],'no-repeat','100% 100%',-97,GetRange(EqArea,[akBottom,akRight]));

  AddSlice(EqNaming[1,0],'repeat-x','0% 0%',-98,GetRange(EqArea,[akTop,akLeft,akRight]));
  AddSlice(EqNaming[0,1],'repeat-y','0% 0%',-98,GetRange(EqArea,[akLeft,akTop,akBottom]));
  AddSlice(EqNaming[2,1],'repeat-y','100% 0%',-98,GetRange(EqArea,[akRight,akTop,akBottom]));
  AddSlice(EqNaming[1,2],'repeat-x','0% 100%',-98,GetRange(EqArea,[akBottom,akLeft,akRight]));

 end else
 if nest.IsRastered(false) and nest.HasProp('VariableSize') then//((([akLeft,akRight]*nest.Anchors)=[akLeft,akRight]){ and nest.AutoX} or (([akTop,akBottom]*nest.Anchors)=[akTop,akBottom]){ and nest.AutoY}) then
  AddWarning(nest.id,'is variable-sized and may not work with a fixed-sized rastering image.');
 //if nest.HasProp('VariableHeight') and (nest.OriAnchors*[akTop,akBottom]=[akTop,akBottom]) then
 // AddWarning(nest.id,'has a constant bottom distance, which conflicts with variable-sized contents. To resolve this conflict, uncheck "Bottom parent edge" in the Pos sheet');


(* if (nest.Align in [alNone,alCustom]) and (nest.parent<>nil) and not ((nest.dclass='TdhPage') or nest.parent.IsBody or (nest.parent.dclass='TdhStyleSheet') or (nest.parent.dclass='TdhStyleSheet')) then
 begin
 bnds:=Bounds(nest.bo.Left,nest.bo.Top,nest.bo.Right,nest.bo.Bottom{nest.FinalHeight});
 if not IntersectRect(outrct,bnds,Bounds(0,0,nest.parent.bo.Right,nest.parent.bo.Bottom{nest.parent.FinalHeight}{+nest.parent.HeightDiff})) or not EqualRect(outrct,bnds) then
  AddWarning(nest.id,'is not within it''s parent''s bounds; the exceeding area may be not displayed correctly');
 end;*)
{
 if (nest.IsProp('LinkType','ltLink') or nest.IsProp('LinkType','ltLinkButton')) and not (nest.HasProp('Href') or nest.HasProp('LinkPage')) then
  AddWarning(nest.id+'.LinkType','is set to ltLink or ltLinkButton, but no link is specified - set it to ltNone to suppress this warning');
 }

                          {
 if (nest.MinWidth<>0) then
  AddStyle('min-width',nest.MinWidth);  }

 if nest.HasProp('Overflow') then
  AddStyle('overflow','hidden');


  if (nest.dclass='TdhMenu') and (nest.IsPopupMenu or nest.IsInlineMenu) and not nest.MenuIsStatic then
  begin
    if nest.auto.contains('MenuOptions','ClickToOpen') then
     AddAttr('clicktoopen','true');
    if nest.HasProp('padw',s) then
     AddAttr('padw',s);
    if nest.HasProp('OnlyIf') then
     AddAttr('onlybyurl','true');
    if nest.auto.HasProp('SlidePixel',s) then
     AddAttr('slidepixel',s);
    if nest.auto.HasProp('ReactionTime',s) and (nest.ParentMenuItem<>'') then
     AddAttr('reactiontime',s);
    if nest.auto.contains('MenuOptions','ResumeOpen') then
     AddAttr('resumeopen','true');
    if nest.ParentMenuItem<>'' then
     AddAttr('parentmenuitem',nest.ParentMenuItem);
  end;

 if nest.IsProp('Visible','False') and (nest.dclass<>'TdhMenu') and not nest.IsPC or (nest.dclass='TdhMenu') and (nest.IsPopupMenu or nest.IsInlineMenu) and {not nest.Auto.contains('MenuOptions','Static')}not nest.MenuIsVisible then
  AddStyle('display','none') else
 if (nest.IsProp('Align','alTop') or nest.HorizontalCenter) and ((nest.tag='img') or (nest.tag='label') or (nest.tag='input') or (nest.tag='a')) or nest.HasProp('NeedBlock') or (nest.dclass='TdhMenu'){ or (nest.dclass='TdhLink') and nest.IsProp('Align','alTop')} then
  AddStyle('display','block');

 end;
 end;

 AddFinalClass(nest,attributes,attributes,AllPCs,finalclass,true);

 if not nest.Show then
 begin
  for i:=0 to nest.Count-1 do
   WriteNs(nest[i],CurIndent+1);
  exit;
 end;



 if {HasProp('Constraints.MinWidth',i) and }(nest.MinWidth<>0) then
 begin
  i:=nest.MinWidth;
  AddStyle('min-width',i-nest.borders.x);
  cPre:=cPre+CRLF+MakeIndent(CurIndent+1)+'<div style="width:'+inttostr(i-nest.borders.x)+'px;'+IndentSpace+'height:0px;'+IndentSpace+'overflow:hidden"></div>';  {nur font-size:0 ODER line-height:0 funktioniert}
 end;
 
 if nest.hclass<>'' then
  AddAttr('class',nest.hclass);

 if (nest.id<>'') and (nest.dclass<>'TRadioButton') and (nest.dclass<>'TCheckBox') and (nest.dclass<>'TdhRadioButton') and (nest.dclass<>'TdhCheckBox') then
  AddAttr('id',nest.id);




 closeSecondDiv:=false;
 (*if (nest.Props<>nil) and not nest.IsBody and nest.HorizontalCenter then  //!!
 begin
  CenterLeft:=0;
  nest.HasProp('CenterLeft',CenterLeft);
  CenterRight:=0;
  nest.HasProp('CenterRight',CenterRight);
  { CenterOffsetPx:=inttostr(CenterOffset)+'px' else
   CenterOffsetPx:='0px';   }

  OuterElementProps:='text-align:center;'+IndentSpace+extract('position')+extract('top')+extract('bottom')+extract('height')+extract('margin-top');
  ns:=ns+'<div style="'+OuterElementProps+'left:'+inttostr(CenterLeft)+'px;'+IndentSpace+'right:'+inttostr(CenterRight)+'px;'+IndentSpace+'width:expression('+nest.offsetParent+'.clientWidth'+_if(CenterLeft+CenterRight<>0,'-'+inttostr(CenterLeft+CenterRight),'')+');'+IndentSpace+'">';

  //ns:=ns+'<div style="text-align:center;'+IndentSpace+'position:absolute;'+IndentSpace+'top:'+inttostr(bo.Top-Client.Top)+'px;'+IndentSpace+'left:'+inttostr(CenterLeft)+'px;'+IndentSpace+'right:'+inttostr(CenterRight)+'px;'+IndentSpace+'width:expression('+nest.offsetParent+'.clientWidth'+_if(CenterLeft+CenterRight<>0,'-'+inttostr(CenterLeft+CenterRight),'')+');">';
  inc(CurIndent);
  ns:=ns+CRLF+MakeIndent(CurIndent);
  AddStyle('margin-right','auto');
  AddStyle('margin-left','auto');
  AddStyle('text-align','left');
  //if nest.Anchors*[akTop,akBottom]=[akTop,akBottom] then
   AddStyle('height','100%');
  AddStyle('position','relative');
  AddStyle('text-align','left');
  closeSecondDiv:=true;
 end;*)
(*

 if (nest.Props<>nil) and not nest.IsBody and nest.HorizontalCenter then  //!!
 begin
  CenterLeft:=0;
  nest.HasProp('CenterLeft',CenterLeft);
  CenterRight:=0;
  nest.HasProp('CenterRight',CenterRight);
  { CenterOffsetPx:=inttostr(CenterOffset)+'px' else
   CenterOffsetPx:='0px';   }

  OuterElementProps:='text-align:center;'+IndentSpace+extract('position')+extract('top')+extract('bottom')+extract('height')+extract('margin-top');
  ns:=ns+'<div style="'+OuterElementProps+'left:'+inttostr(CenterLeft)+'px;'+IndentSpace+'right:'+inttostr(CenterRight)+'px;'+IndentSpace+'width:expression('+nest.offsetParent+'.clientWidth'+_if(CenterLeft+CenterRight<>0,'-'+inttostr(CenterLeft+CenterRight),'')+');'+IndentSpace+'">';

  //ns:=ns+'<div style="text-align:center;'+IndentSpace+'position:absolute;'+IndentSpace+'top:'+inttostr(bo.Top-Client.Top)+'px;'+IndentSpace+'left:'+inttostr(CenterLeft)+'px;'+IndentSpace+'right:'+inttostr(CenterRight)+'px;'+IndentSpace+'width:expression('+nest.offsetParent+'.clientWidth'+_if(CenterLeft+CenterRight<>0,'-'+inttostr(CenterLeft+CenterRight),'')+');">';
  inc(CurIndent);
  ns:=ns+CRLF+MakeIndent(CurIndent);
  AddStyle('margin-right','auto');
  AddStyle('margin-left','auto');
  AddStyle('text-align','left');
  //if nest.Anchors*[akTop,akBottom]=[akTop,akBottom] then
   AddStyle('height','100%');
  AddStyle('position','relative');
  AddStyle('text-align','left');
  closeSecondDiv:=true;
 end;
*)

 if (nest.tag<>'divdel') then
 begin
 ns:=ns+CRLF+MakeIndent(CurIndent);

 if (nest.Props<>nil) and (nest.tag='iframe') and ((nest.Anchors*[akLeft,akRight]=[akLeft,akRight]) or (nest.Anchors*[akTop,akBottom]=[akTop,akBottom])) then
 begin
  sPositionings:=extract('left')+extract('top')+extract('right')+extract('bottom')+extract('width')+extract('height');
  ns:=ns+'<div style="position:absolute;'+IndentSpace+sPositionings+'">';
  inc(CurIndent);
  ns:=ns+CRLF+MakeIndent(CurIndent);
  AddStyle('left','0px');
  AddStyle('top','0px');
  AddStyle('width','100%');
  AddStyle('height','100%');
  closeSecondDiv:=true;
 end;
 if nest.PngToChild and (nest.Props<>nil) and nest.IsRastered(true) then
 begin
  cPre:=cPre+CRLF+MakeIndent(CurIndent+1);
  cPre:=cPre+'<div class="fill'{+' '+finalclass}+'" style="left:0;top:0;bottom:0;right:0;'+extract('background')+extract('filter')+'"></div>';
  //AddStyle('background','expression(''none'')');
  AddStyle('background','none');
  AddStyle('filter','none');
 end;

 properties:=properties+glStyle;
 if (properties<>'') and (nest.tag<>'bgsound') and (nest.tag<>'script') then
  AddAttr('style',GoodStyle(properties));

 if (nest.tag='input') or (nest.tag='img') then
  ns:=ns+'<'+nest.tag+attributes+'/>' else
 begin
  if (nest.tag<>'divdel') and not ((nest.Props<>nil) and nest.IsProp('GenerateContainer','False')) then
   ns:=ns+'<'+nest.tag+attributes+'>';
  ns:=ns+cPre;
  for i:=0 to nest.Count-1 do
   WriteNs(nest[i],CurIndent+1);
  ns:=ns+FinalCharacters(nest,AllPCs);
  if ((nest.Count<>0) or (nest.tag='body')) and Indent then
   ns:=ns+CRLF+MakeIndent(CurIndent);
  if (nest.tag<>'divdel') and not ((nest.Props<>nil) and nest.IsProp('GenerateContainer','False')) then
   ns:=ns+'</'+nest.tag+'>';
 end;
 end;

 if closeSecondDiv then
 begin
  dec(CurIndent);
  ns:=ns+CRLF+MakeIndent(CurIndent);
  ns:=ns+'</div>';
 end;

end;

procedure BeforeWrite(nest:TNest);
var i:integer;
begin
 if not nest.Show then exit;
 nest.addprops:='';
 nest.addheight:={nest.HeightDiff}0;
 nest.addtop:=0;
 if nest.Melt and (nest.parent<>nil) then
  nest.parent.addprops:=nest.properties;
 for i:=0 to nest.Count-1 do
  BeforeWrite(nest[i]);
// if not nest.HeightDiffCut then
 if (nest.parent<>nil) and not nest.parent.IsScrollable then
  inc(nest.parent.addheight,nest.addheight+nest.HeightDiff);
end;

procedure BeforeWrite2(nest:TNest);
var i:integer;
begin
 if not nest.Show then exit;
 if nest.parent<>nil then
 if (akTop in nest.OriAnchors) and (akBottom in nest.OriAnchors) then
  nest.addheight:=nest.parent.addheight else
 if not (akTop in nest.OriAnchors) and (akBottom in nest.OriAnchors) then
  nest.addtop:=nest.parent.addheight;
 for i:=0 to nest.Count-1 do
  BeforeWrite2(nest[i]);
end;

function DirectCSS(const s:string):string;
begin          
   result:=AnsiSubstText('"','''',s);
end;




procedure BeforeWrite3(nest:TNest);

procedure vvadd(nest:tnest);
var i:integer;
begin
 if nest.IsIn then exit;
 vv.Add(nest);
 nest.IsIn:=true;
 if nest.InlineUse<>nil then
 for i:=0 to nest.InlineUse.Count-1 do
 begin
  vvadd(nest.InlineUse[i]);
 end;
 if nest.Use<>nil then
  vvadd(nest.Use);
end;


var i:integer;
var pmn,phr,pdn,phd:string;
begin
 for i:=0 to gln.Count-1 do
 begin
  nest:=TNest(gln.Objects[i]);
  if nest.Show and not nest.IsIn then
  begin
   vvadd(nest);
  end;
 end;

end;


procedure BeforeWrite4(nest:TNest);

procedure AddWidthHeight(st:TState; const pmn:string);
begin
 if pmn<>'' then
  pre:=pre+'.'+GetSelectorJS(nest.id,st)+IndentSpace+'{'+GoodStyle(pmn)+'}'+CRLF;
end;


var i:integer;
var pmn,phr,pdn,phd:string;
begin
 for i:=0 to gln.Count-1 do
 begin
  nest:=TNest(gln.Objects[i]);
  nest.pmn:='';
  if (nest.Props<>nil){ and not nest.IsBody} then
  if nest.Show or nest.img and nest.IsIn and (nest.UsedInlineBy<>nil) then
  begin
   if not(nest.AutoX and nest.AutoY) then
   begin
    pmn:=CallTemplate_get_WidthHeight(nest,hsNormal);
    phr:=CallTemplate_get_WidthHeight(nest,hsOver);
    pdn:=CallTemplate_get_WidthHeight(nest,hsDown);
    phd:=CallTemplate_get_WidthHeight(nest,hsOverDown);
    if (phr<>'') or (pdn<>'') or (phd<>'') or nest.img and nest.IsIn and (nest.UsedInlineBy<>nil) then
    begin
     AddWidthHeight(hsNormal,pmn);
     if nest.DownOverlayOver then
     begin
      AddWidthHeight(hsOver,phr);
      AddWidthHeight(hsDown,pdn);
     end else
     begin
      AddWidthHeight(hsDown,pdn);
      AddWidthHeight(hsOver,phr);
     end;
     AddWidthHeight(hsOverDown,phd);
     nest.NeedOwnClass:=true;
    end else
     nest.pmn:=DirectCSS(pmn);
   end;
  end;
 end;

end;

procedure SetShow(nest:TNest);
var i:integer;
begin
 if not nest.IsPC and (nest.parentTS<>nil) then
  nest.Show:=not nest.NeverVisible and nest.parentTS.show;
// nest.Show:=nest.parentTS.show;
 {if nest.Show and (nest.IfDown<>'') then
  nest.Show:=NestIsDown(tnest(gln.Objects[gln.IndexOf(nest.IfDown)])); }
{ if nest.Show and (nest.RenderIn<>'') then
  nest.Show:=AllPCs.IndexOf(nest.RenderIn)<>-1;  }
 if nest.Show then
 begin
 //nest.IsDown:=nest.IsAlwaysDown or (nest.LinkPage<>'') and (nest.PageRange=0) and (AllPCs.IndexOf(nest.LinkPage)<>-1);
 for i:=0 to nest.Count-1 do
  SetShow(nest[i]);
 end;
end;



procedure CalcDown(nest:TNest);
var i:integer;
begin
 if nest.Show then
 begin
  for i:=0 to nest.Count-1 do
   CalcDown(nest[i]);
  nest.IsDown:=nest.IsAlwaysDown or (nest.LinkPage<>'') and (nest.PageRange=0) and (AllPCs.IndexOf(nest.LinkPage)<>-1);
 end;
end;

procedure CalcDown2(nest:TNest);
var i:integer;
begin
 if nest.Show then
 begin
  for i:=0 to nest.Count-1 do
   CalcDown2(nest[i]);
  if nest.IsDown then
  begin
   while (nest<>nil) do
   begin
    nest.IsDown:=true;
    if nest.ParentMenuItem<>'' then
     nest:=tnest(gln.Objects[gln.IndexOf(nest.ParentMenuItem)]) else
     nest:=nest.parent;
   end;
  end;
 end;
end;


procedure SetStaticMenuShow(nest:TNest);
var i:integer;
begin
 if nest.Show then
 begin
  if nest.MenuIsStatic then
  begin
    nest.Show:=nest.MenuIsVisible;
  end;
  for i:=0 to nest.Count-1 do
   SetStaticMenuShow(nest[i]);
 end;
end;



                   {
function CalcDown(nest:TNest):boolean;
var i:integer;
begin
 result:=false;
 if nest.Show then
 begin
  for i:=0 to nest.Count-1 do
   result:=CalcDown(nest[i]) or result;
  nest.IsDown:=result or nest.IsAlwaysDown or (nest.LinkPage<>'') and (nest.PageRange=0) and (AllPCs.IndexOf(nest.LinkPage)<>-1);
  result:=nest.IsDown;
 end;
end;
              }

                     {
function DoStaticMenus(nest:TNest):boolean;
var i:integer;
begin
 result:=false;
 if not nest.Show then exit;
 if (nest.IfDown<>'') and not tnest(gln.Objects[gln.IndexOf(nest.IfDown)]).IsDown then
  nest.Show:=false;
 if nest.IsDown then
  result:=true;
 for i:=0 to nest.Count-1 do
 if not result then
  result:=DoStaticMenus(nest[i]) else
  DoStaticMenus(nest[i]);
 if (nest.IfDown<>'') and result then
  nest.Show:=true;
end;             }

function HasPageProp(const PropName:string; var s:string; pagenest:TNest):boolean; overload;
var nest:tnest;
begin
 nest:=pagenest;
 repeat
  if (nest.Props<>nil) and nest.HasProp(PropName,s) then
  begin
   result:=true;
   exit;
  end;
  if nest.IsIFrame then
  begin
   result:=false;
   exit;
  end;
  nest:=nest.parent;
 until nest=nil;
 result:=false;
end;

function HasPageProp(const PropName:string; var s:string):boolean; overload;
begin
 result:=HasPageProp(PropName,s,pagenest);
end;

var page_info,ForwardingDelay,BackgroundSoundForever,BackgroundSoundLoop,NsLoop,preloadOneByOne,dfm2html_js:string;

var s_cssfile:string;
var s_EverNeeded1by1,s_EverNeededSplit,s_EverNeededButton,s_EverNeededJS:Boolean;


procedure SetShowWhenSameCSSFile(nest:TNest);
var i:integer;
    s_cssfile:String;
begin
 s_cssfile:=cssfile;
 try
 if nest.IsPC then
 begin
  HasPageProp('GeneratedCSSFile',cssfile,nest);
  cssfile:=FinalGeneratedCSSFile(cssfile);
 end;
 if not nest.IsPC and (nest.parentTS<>nil) then
  nest.Show:=not nest.NeverVisible and nest.parentTS.show else
  nest.Show:=cssfile=s_cssfile;
 if nest.Show then
 begin
 for i:=0 to nest.Count-1 do
  SetShowWhenSameCSSFile(nest[i]);
 end;
 finally
  cssfile:=s_cssfile;
 end;
end;


procedure InitAndStyles(nest:TNest;ForCSSFile:Boolean);
var i:Integer;
begin

 PureFileName:=nest.PureFileName;

// if (nest.parent=nil) and (nest.Count<>0) and tnest(nest[0]).IsBody then
//  nest:=tnest(nest[0]); //um in AllPCs reinzukommen, und für parentnest


 for i:=0 to gln.Count-1 do
 with TNest(gln.Objects[i]) do
 begin
  show:=false;
  IsIn:=false;
 end;


 pagenest:=nest;
 ns:='';
 pnest:=nest;
 TopPC:=pnest.id;
 AllPCs:=TStringList.Create;
 AllPCs.CaseSensitive:=true;
 AllPCs.Sorted:=true;
 while pnest<>nil do
 begin
  {if pnest.parent<>nil then
  for i:=0 to pnest.parent.Count-1 do
   TNest(pnest.parent[i]).show:=false; }
  {if (PureFileName='') and not pnest.IsSel then
   PureFileName:=pnest.id;  }
  AllPCs.AddObject(pnest.id,pnest);
  pnest.Show:=true;
  nest:=pnest;
  pnest:=pnest.parentTS;
 end;
 SetShow(nest);
 if ForCSSFile then SetShowWhenSameCSSFile(pagenest);
 
 CalcDown(nest);
 CalcDown2(nest);
 SetStaticMenuShow(nest);
 //DoStaticMenus(nest);

 for i:=0 to gln.Count-1 do //SetStaticMenuShow repair
 with TNest(gln.Objects[i]) do
 if (parentTS<>nil) and (parent<>nil) and not parent.Show then
  Show:=false;

 Need1by1:=false;

 NeedJS:=false;
 for i:=0 to gln.Count-1 do //DoStaticMenus repair
 if TNest(gln.Objects[i]).Show and TNest(gln.Objects[i]).NeedJS then
 begin
  NeedJS:=true;
  break;
 end;
 NeedJS:=true;
// NeedJS:=true;                     
 EverNeededJS:=EverNeededJS or NeedJS;
 if ForCSSFile then NeedJS:=EverNeededJS;




 
{ if svg then
  filename:=PureFileName+'.svg' else
  filename:=PureFileName+'.html';
}filename:=PureFileName;

{
 if WrittenPages.IndexOfName(PureFileName)<>-1 then
  AddWarning(PureFileName,'overwrites '+WrittenPages.Values[PureFileName]+' (both produce webpage '+filename+')');

 WrittenPages.Add(PureFileName+'='+FormName+'.'+PureFileName);
 }

 pre:='';



 Preload:=TMyStringList.Create;
 ns:='';

 vv:=TList.Create;
 try
 NeedButton:=false;
 BeforeWrite(nest);
 BeforeWrite2(nest);
 BeforeWrite3(nest);       
 if not ForCSSFile then BeforeWrite4(nest);
 if not ForCSSFile then WriteNs(nest,1);

 Need1by1:=AdvPos('onebyone.gif',ns)>0;
 EverNeeded1by1:=EverNeeded1by1 or Need1by1;     
 if ForCSSFile then Need1by1:=EverNeeded1by1;

 NeedSplit:=AdvPos('class="fill'{e.g. class="fill Panel1_nm"},ns)>0;
 EverNeededSplit:=EverNeededSplit or NeedSplit;
 if ForCSSFile then NeedSplit:=EverNeededSplit;

 for i:=0 to gln.Count-1 do
  NeedButton:=NeedButton or TNest(gln.Objects[i]).Show and (TNest(gln.Objects[i]).tag='button');
 EverNeededButton:=EverNeededButton or NeedButton;   
 if ForCSSFile then NeedButton:=EverNeededButton;

 if not ForCSSFile and (cssfile<>'') then exit;
 StyleArrange; //wegen NeedOwnClass
 finally
  FreeAndNil(vv);
 end;

// if NeedButton then pre:='.button'+IndentSpace+'{white-space:normal}'+CRLF+pre;

 if AdvPos('border-',pre){border-right-style}<>0 then
  pre:='div,span,img,a,form,body,label'+IndentSpace+'{border-width:'+inttostr(default_borderwidth)+'px;border-color:black}'+CRLF+pre;


 if Need1by1 then
 begin
  pre:='img'+IndentSpace+'{border-style:none}'+CRLF+pre;
  glStringToFile('onebyone.gif',GetBackBinary(gif1by1));
 end;

 if NeedSplit then
 begin
  //pre:=pre+'.fill'+IndentSpace+'{position:absolute;left:0;top:0;right:0;bottom:0;z-index:-99;padding:0;}'+CRLF;
  pre:=pre+'.fill'+IndentSpace+'{position:absolute;z-index:-99;padding:0;}'+CRLF;
  //pre:=pre+'.fill'+IndentSpace+'{position:absolute;left:0;top:0;width:100%;height:100%;width:expression(parentNode.clientWidth);height:expression(parentNode.clientHeight);z-index:-99;padding:0;}'+CRLF;
 end;

 (*
 //Für Firefox 1.5 ist dieser fix wirkunslos (d.h. bottom:0px taucht im scrollbar-bereich auf) (im Gegensatz zu Firefox 1.05);
 pre:='html'+IndentSpace+'{height:100%}'+CRLF+pre; //in order that bottom:0px is direct above scrollbar at mozilla
 *)
 //pre:='body'+IndentSpace+'{width:100%}'+CRLF+pre;   //geht nicht bei Padding/Margin bei Body   //in order that "right" works well in Opera
 pre:='body,iframe'+IndentSpace+'{margin:0px;padding:0px}'+CRLF+pre; //padding:0px for Opera
// pre:='div,a'+IndentSpace+'{overflow:hidden}'+CRLF+pre; //macht probleme bei elementen die kein width/height haben!
// pre:='div,a'+IndentSpace+'{max-width:1px;max-height:1px}'+CRLF+pre;
 pre:='a'+IndentSpace+'{cursor:pointer}'+CRLF+pre;//for IE, AlphaImageLoader
 pre:='*'+IndentSpace+'{-moz-background-clip:padding;z-index:0}'+CRLF+pre;   //"z-index:0" alTop and alNone scheinen unterschiedliche Defaults bei Opera zu haben
 if NeedButton then pre:='button'+IndentSpace+'{white-space:nowrap}'+CRLF+pre;


end;


begin
// if not nest.IsPC or nest.HasSubTS then

 s_cssfile:=cssfile;
 s_EverNeeded1by1:=EverNeeded1by1;
 s_EverNeededSplit:=EverNeededSplit;
 s_EverNeededButton:=EverNeededButton;
 s_EverNeededJS:=EverNeededJS;
 try
 if nest.IsPC then
 begin           
  HasPageProp('GeneratedCSSFile',cssfile,nest);
  cssfile:=FinalGeneratedCSSFile(cssfile);
  if cssfile<>s_cssfile then
  begin
   EverNeeded1by1:=false;
   EverNeededSplit:=false;
   EverNeededButton:=false;
   EverNeededJS:=false;
  end;
 end;

 if not nest.NeverVisible then
 for i:=0 to nest.Count-1 do
  savenested(nest[i]);


 if nest.IsPC and not nest.HasSubTS then
 begin

 InitAndStyles(nest,False);

 {if ShareWare and bAdvPosBack(r,'</body>',ns,length(ns)) then
 begin
  r:=SkipBckWhiteSpaces(ns,r);
  ns:=CopyInsert(ns,r,CRLF+MakeIndent(2)+'<a href="http://www.dfm2html.com" style="position:absolute; right:0px; top:0; width:28px; height:198px; background-image:url(''sharewarelogo.png''); background-repeat:no-repeat;"></a>');
 end; }

 if pre<>'' then
  pre:=MakeIndent(2)+'<style type="text/css">'+CRLF+'<!--'+CRLF+pre+'-->'+CRLF+MakeIndent(2)+'</style>'+CRLF;
  
 if cssfile<>'' then
  pre:=MakeIndent(2)+'<link rel="stylesheet" type="text/css" href="'+cssfile+'"/>'+CRLF+pre;

 if HasPageProp('ForwardingURL',page_info) then
 begin
  ForwardingDelay:='0';
  HasPageProp('ForwardingDelay',ForwardingDelay);
  pre:=MakeIndent(2)+'<meta http-equiv="refresh" content="'+ForwardingDelay+'; URL='+page_info+'"/>'+CRLF+pre;
 end;

 (*
 if HasPageProp('BackgroundSoundURL',page_info) then
 begin
  BackgroundSoundLoop:='0';
  HasPageProp('BackgroundSoundLoop',BackgroundSoundLoop);
  if not HasPageProp('BackgroundSoundForever',BackgroundSoundForever) then
   BackgroundSoundLoop:='infinite';
  pre:=MakeIndent(2)+'<bgsound src="'+page_info+'" loop="'+BackgroundSoundLoop+'">'+CRLF+pre;

  if BackgroundSoundLoop='infinite' then
   NsLoop:='true' else
   NsLoop:='false';
  //würde in IE doppelt abgespielt:
  //if bAdvPos(r,'<body',ns) and bAdvPos(r,'>',ns,r) then
  // Insert(CRLF+MakeIndent(2)+'<embed src="'+page_info+'" autostart="true" loop="'+NsLoop+'" hidden="true" height="0" width="0"/>',ns,r+length('>'));
 end;
*)
 if HasPageProp('MetaDescription',page_info) then
  pre:=MakeIndent(2)+'<meta name="description" content="'+page_info+'"/>'+CRLF+pre;
 if HasPageProp('MetaKeywords',page_info) then
  pre:=MakeIndent(2)+'<meta name="keywords" content="'+page_info+'"/>'+CRLF+pre;
 if HasPageProp('MetaAuthor',page_info) then
  pre:=MakeIndent(2)+'<meta name="author" content="'+page_info+'"/>'+CRLF+pre;




 //pre:=MakeIndent(2)+'<meta name="generator" content="'+DFM2HTML_VERSION+_if(Registered,'',' (Unregistered)')+', http://www.dfm2html.com'+'"/>'+CRLF+pre;

 if {nest.title<>''}HasPageProp('Title',page_info) or (nest.Props<>nil) and nest.HasProp('Caption',page_info) then
  pre:=MakeIndent(2)+'<title>'+page_info+'</title>'+CRLF+pre;

 if HasPageProp('HTMLHead',page_info) then
  pre:=pre+page_info+CRLF;

 dfm2html_js:='';
 HasPageProp('GeneratedJavaScriptFile',dfm2html_js);
 dfm2html_js:=FinalGeneratedJavaScriptFile(dfm2html_js);

 if bAdvPos(r,'<body',ns) and bAdvPos(r,'>',ns,r) then
 begin
  inc(r,length('>'));
  if not Registered then
   Insert(CRLF+MakeIndent(2)+'<a href="http://www.dfm2html.com" style="display:none">My favorite HTML editor is DFM2HTML</a>',ns,r);

  if HasPageProp('HTMLBody',page_info) then
   Insert(CRLF+page_info,ns,r);

  preloadOneByOne:='';
  if Need1by1 then
   preloadOneByOne:=CRLF+MakeIndent(2)+'<script type="text/javascript">preload(''onebyone.gif'');</script>';
  if not ((pagenest.parentTS<>nil) and pagenest.parentTS.IsIFrame) and (AdvPos('<noscript',ns)=0) then
   Insert(CRLF+MakeIndent(2)+'<noscript>This page requires JavaScript. <a href="http://www.dfm2html.com/js.html">Help</a></noscript>',ns,r);
  Insert(CRLF+MakeIndent(2)+'<script type="text/javascript" src="'+dfm2html_js+'"></script>'+preloadOneByOne,ns,r);
 end;


(* if (Preload.Count<>0) then
 begin
  pre:=pre+MakeIndent(2)+
          '<script language="JavaScript" type="text/JavaScript">'+CRLF+
          'function preload_img() {'+CRLF+
          ' if(document.images){var i; for(i=0; i<preload_img.arguments.length; i++) {(new Image).src=preload_img.arguments[i]; }}'+CRLF+
          '}'+CRLF+MakeIndent(2)+
          '</script>'+CRLF;
 end;*)




 //ghold:=THolding.Create('',
 if svg then
 ns:=
  '<?xml version="1.0" standalone="no"?>'+CRLF+
  '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">'+CRLF+
  '<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">'+CRLF+pre+ns+'</svg>' else
 ns:=
//  '<?xml version="1.0" encoding="UTF-8"?>'+CRLF+
{kein scrollbar-color:}'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html40/loose.dtd">'+CRLF+
//ganz alt  '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'+CRLF+
  '<html'+{ xmlns="http://www.w3.org/1999/xhtml"}'>'+CRLF+MakeIndent(1)+'<head>'+CRLF+
//  '<META http-equiv="Content-Type" content="text/html; charset=UTF-8">'+CRLF+
  //'<META http-equiv="Content-Type" content="text/html; charset=UTF-8">'+CRLF+
  pre+MakeIndent(1)+'</head>'+ns+CRLF+'</html>';


 if HasPageProp('HTMLTop',page_info) then
  ns:=page_info+CRLF+ns;

 if {OnLoad and }{(Preload.Count<>0) and }bAdvPos(r,'<body',ns) then
 begin
  Preload.Delimiter:=',';
  Insert(' onload="preload('+Preload.DelimitedText+')"',ns,r+length('<body'));
 end;

 if {not OnLoad and }NeedJS then
 begin
  if bAdvPosBack(r,'</body>',ns,length(ns)) then
  begin
   //r:=r+length('</body>');
   //r:=length(ns)+1;
   r:=SkipBckWhiteSpaces(ns,r);
   ns:=CopyInsert(ns,r,CRLF+MakeIndent(2)+'<script type="text/javascript">dhtml('{+Preload.DelimitedText}+');</script>'{+CRLF+MakeIndent(2)+'<noscript>This page requires JavaScript. <a href="http://www.dfm2html.com/faq.html#js">Help</a></noscript>'});
  end;
  (*
  if bAdvPosBack(r,'</body>',ns,length(ns)) then
  begin
   r:=SkipBckWhiteSpaces(ns,r);
   ns:=CopyInsert(ns,r,CRLF+MakeIndent(2)+'<script type="text/javascript">init('+Preload.DelimitedText+');</script>'{+CRLF+MakeIndent(2)+'<noscript>This page requires JavaScript. <a href="http://www.dfm2html.com/faq.html#js">Help</a></noscript>'});
  end;*)
  //if (men='') and CanStringFromFile('menu.js',men) then
 end;

 FreeAndNil(PreLoad);


(* if NeedJS then
 begin
  if bAdvPosBack(r,'<style',ns,length(ns)) then
  begin
   r:=SkipBckWhiteSpaces(ns,r);
   ns:=CopyInsert(ns,r,CRLF+MakeIndent(2)+'<script type="text/javascript" src="dfm2html.js"></script>'{+CRLF+MakeIndent(2)+'<noscript>This page requires JavaScript. <a href="http://www.dfm2html.com/faq.html#js">Help</a></noscript>'});
  end;
 end;
 *)
 if NeedJS then
   glStringToFile(dfm2html_js,men);

 //http://groups.google.de/groups?q=%22utf-8%22+encoding+html&hl=de&lr=&ie=UTF-8&selm=wmiIc.90209%24sj4.1828%40news-server.bigpond.net.au&rnum=4
 ns:=AnsiSubstText(MaskQuotes,'"',ns);
 (*for i:=1 to length(ns) do
 if ord(ns[i])>=127 then
  ns[i]:=ns[i];*)
// ns:=UTF8Encode(WideString(ns));
 {if pos(endl_space,ns)>0 then
  StringToFile(SaveDir+filename,SubstText(endl_main,endl,ns)) else }
 glStringToFile(filename,AnsiSubstText(endl_main,endl,ns));
 AllPCs.Free;
 end;



 if nest.isPC then
 begin
  if cssfile<>s_cssfile then
  begin
   InitAndStyles(nest,true);
   glStringToFile(cssfile,pre);
   EverNeeded1by1:=s_EverNeeded1by1;
   EverNeededSplit:=s_EverNeededSplit;
   EverNeededButton:=s_EverNeededButton;
   EverNeededJS:=s_EverNeededJS;        
   FreeAndNil(PreLoad);
  end;
 end;


 //result:=filename;
 finally
  cssfile:=s_cssfile;
 end;

end;

function ExtractPureFileName(const f:string): string;
begin
 result:=ExtractFileName(f);
 if (length(result)>=length('.dfm')) and (result[length(result)+1-length('.dfm')]='.') then
  delete(Result,length(result)-length('.dfm')+1,MaxInt);
end;

var glStyle,glAttributes,glClass,bgcolor:string;













{
procedure AddRule(const cl,use,stylebody:string);
begin
 glMainIDs.AddObject(cl,Pointer(glMainIDs.Count));
 glRestIDs.Add(use);
 glStyleBodys.Add(stylebody);
end;

 }


procedure TransNode(pnest:TNest);
var tagName,id,ClassName,ChildInfo:string;
    Props,PropVals:TMyStringList;
    snest,_nest,pp:TNest;
    i:integer;


function HasProp(const PropName:string; var s:string):boolean; overload;
var i:integer;
begin
 i:=Props.IndexOf(PropName);
 result:=i<>-1;
 if result then
  s:=PropVals[i];
end;


procedure PrepProps;
var //childNodes:IDOMNodeList;
    i:integer;
//    n:IDOMNode;
//    ele:IDOMElement;
    PropVals2:TMyStringList;
//    ValNode:IDOMAttr;
    _nam,_val:string;
    s:String;

begin
 PropVals2:=TMyStringList.Create;
 while docg.Over('<property name="') and docg.SaveOverPos('" value="',_nam) and docg.SaveOverPos('"',_val) and docg.OverPos('/>') and docg.overShit do
 begin
   Props.AddObject(_nam,Pointer(Props.Count));
   PropVals2.Add(_val);
 end;
 
 Props.CaseSensitive:=true;
 Props.Sorted:=true;
 for i:=0 to Props.Count-1 do
  PropVals.Add(PropVals2[Integer(Props.Objects[i])]);
 PropVals2.free;
 {if HasProp('FinalHeight',s) and Props.IndexOf('Height',i) then
  PropVals[i]:=s;     }
end;


function HasProp(const PropName:string; var i:integer): boolean; overload;
var s:string;
begin
 result:=HasProp(Propname,s);
 if result then
  i:=strtoint(s);
end;
           
function iProp(const PropName:string):integer;
begin
 if not HasProp(PropName,result) then
  result:=0;
end;

function HasProp(const PropName:string):boolean; overload;
begin
 result:=Props.IndexOf(PropName)<>-1;
end;

function IsProp(const PropName,Value:string):boolean;
var s:string;
begin
 result:=HasProp(Propname,s) and (Value=s);
end;

{function contains_computed(const PropName,Value:string):boolean;
var s:string;
begin
 result:=(HasProp('Computed'+Propname,s) or HasProp(Propname,s)) and (AdvPos(Value,s)<>0);
end;
 }

function contains(const PropName,Value:string):boolean;
var s:string;
begin
 result:=HasProp(Propname,s) and (AdvPos(Value,s)<>0);
end;


procedure ApplyTemplates;
begin
 if not PreventApplyTemplates then
 while docg.StartsWith('<object') do
  TransNode(snest);
end;

procedure AddStyle(const Name,Value:string); overload;
begin
 glStyle:=glStyle+Name+':'+Value+';'+IndentSpace;
end;

procedure AddStyleBgcolor(const Value:string);
begin
 bgcolor:=Value;
 AddStyle('background-color',Value);
end;

procedure AddStyle(const Name:string; Value:integer); overload;
begin
 AddStyle(Name,inttostr(Value)+'px');
end;


procedure AddAttr(const Name,Value:string); overload;
begin
 if name='class' then
  glClass:=Value else
  glAttributes:=glAttributes+' '+Name+'="'+Value+'"';
end;

procedure AddAttr(const Name:string; Value:integer); overload;
begin
 AddAttr(Name,inttostr(Value));
end;

procedure CallTemplate_set_TabOrder;
var ModalResult,TabOrder:integer;
    pTabOrder,ppTabOrder:string;
begin

 if not HasProp('ModalResult',ModalResult) then
  ModalResult:=0;
 if ModalResult=1 then
  AddAttr('tabindex','30001') else
 if ModalResult=2 then
  AddAttr('tabindex','30002') else
 if ModalResult=4 then
  AddAttr('tabindex','30004') else
 if HasProp('TabOrder',TabOrder) then
 {if HasParentProp('TabOrder',pTabOrder) then
 begin
  if HasParentParentProp('TabOrder',ppTabOrder) then
   AddAttr('tabindex',(TabOrder + 1) + 30 * (strtoint(pTabOrder) + 1) + 10 * 10 * (strtoint(ppTabOrder) + 1)) else
   AddAttr('tabindex',30 * (TabOrder + 1) + 30 * 30 * (strtoint(pTabOrder) + 1));
 end else }
  AddAttr('tabindex',30 * 30 * (TabOrder + 1));
end;

procedure CallTemplate_inherit_props;
var sFontName,sColor,TextDecoration:string;
    aHeight:integer;
begin
 if HasProp('Font.Height',aHeight) and HasProp('Font.Name',sFontName) then
 begin
  AddStyle('font','normal '+inttostr(Abs(aHeight))+'px '+ sFontName);
  if HasProp('Font.Color',sColor) then
  if svg then
   AddStyle('fill',sColor) else
   AddStyle('color',sColor);
  if contains('Font.Style','fsItalic') then
   AddStyle('font-style','italic');
  if contains('Font.Style','fsBold') then
   AddStyle('font-weight','bold');
  TextDecoration:='';
  if contains('Font.Style','fsUnderline') then
   TextDecoration:=TextDecoration+' underline';
  if contains('Font.Style','fsStrikeOut') then
   TextDecoration:=TextDecoration+' line-through';
  if TextDecoration<>'' then
   AddStyle('text-decoration',copy(TextDecoration,2,maxint));
 end;
 if HasProp('Color',sColor) and not(('TLabel'=classname) and HasProp('Transparent') or (classname='TSpeedButton') and not HasProp('Transparent') or (classname='TRxSpeedButton') and HasProp('Transparent')) then
  AddStyleBgcolor(sColor);
end;


procedure CallTemplate_templcontrol;
var i:integer;
    FirstRealUse,s:string;
    aLeft,aTop,aHeight,aWidth:integer;
begin
{ if HasProp('Top',i) then
  Atts.addAttribute('', '', 'Top', 'CDATA', IntToStr(i)); }
 (*
 if HasProp('FirstRealUse',FirstRealUse) or HasProp('StyleStored') then
 if HasProp('StyleStored'){ or HasProp('ConstantWidthHeight')} then
  AddAttr('class',id+'_mn') else
  AddAttr('class',FirstRealUse+'_mn');
  *)
 if IsProp('Enabled','False')  then
  AddAttr('disabled','disabled');

 if HasProp('Tooltip',s) or HasProp('Hint',s)  then
  AddAttr('title',s);

 if HasProp('Cursor',s)  then
  AddStyle('cursor',copy(s,3,maxint));

 CallTemplate_inherit_props;

end;


procedure DoEle(n:string; _addstyle:boolean=true; DoApplyTemplates:boolean=true; IsPC:boolean=false; NewPage:boolean=false; Melt:boolean=false);
var sCurIndent,Right,Bottom:integer;
    parent:TNest;
    Anchors:TAnchors;
    aAlign,AutoSizeXY,NewPadding:string;
    HasRastering:boolean;

var
    decr,z:integer;
    Client{,ClientRect}:TRect;
begin
 TagName:=n;

 if _addstyle then
  CallTemplate_templcontrol;

 if snest<>nil then
  parent:=snest else
  parent:=pnest;
 snest:=TNest.Create;
 snest.Melt:=Melt;
 snest.parent:=parent;
 snest.IsPC:=IsPC;
 if snest.parent<>nil then
 begin
  snest.parent.Add(snest);
  if not NewPage then
  if snest.parent.IsPC then
   snest.parentTS:=snest.parent else
   snest.parentTS:=snest.parent.parentTS;
 end else
 begin
  gnest:=snest;
 end;

 snest.hclass:=glClass;
 snest.dclass:=classname;
 snest.tag:=tagName;
 snest.attributes:=glAttributes;
 snest.bgColor:=bgColor;
 snest.IsScrollable:=(snest.dclass='TdhPage') and (pnest.ChildInfo='');


 if DoApplyTemplates then
 begin

 if SubEqual('Tdh',snest.dclass) then
 begin
  if HasProp('RealAutoSizeXY',AutoSizeXY) or HasProp('AutoSizeXY',AutoSizeXY) then
  begin
   snest.AutoX:=(AutoSizeXY='asX') or (AutoSizeXY='asXY');
   snest.AutoY:=(AutoSizeXY='asY') or (AutoSizeXY='asXY');
  end;
 end else
 if TagName='body' then
 begin
 snest.AutoX:=true;
 snest.AutoY:=true;
 end else
 begin
 snest.AutoX:=HasProp('AutoSize');
 snest.AutoY:=snest.AutoX;
 end;

 HasProp('Use',snest.sUse);


 snest.NeedJS:=HasProp('NeedJS');
 snest.ChildInfo:=ChildInfo;


 snest.Align:=alNone;
 if HasProp('Align',aAlign) then
 if aAlign='alTop' then snest.Align:=alTop else
 if aAlign='alBottom' then snest.Align:=alBottom else
 if aAlign='alLeft' then snest.Align:=alLeft else
 if aAlign='alRight' then snest.Align:=alRight else
 if aAlign='alClient' then snest.Align:=alClient;

 snest.id:=id;
 if id='' then
 snest.tag:='divdel';



 Anchors:=[];
 if snest.parent=nil then
 begin
  Anchors:=[akLeft,akTop,akRight,akBottom];
 end else
 if HasProp('Anchors') then
 begin
 if Contains('Anchors','akBottom') then
  include(Anchors,akBottom);
 if Contains('Anchors','akTop') then
  include(Anchors,akTop);
 if Contains('Anchors','akLeft') then
  include(Anchors,akLeft);
 if Contains('Anchors','akRight') then
  include(Anchors,akRight);
 end else
  Anchors:=AnchorAlign[snest.Align];
 snest.img:=HasProp('img');
 Anchors:=_RealAnchors(Anchors,snest.img);
  
 (*
 if IsProp('Align','alTop') then
  Anchors:=[akLeft,akTop,akRight]{[]} else
 if IsProp('Align','alRight') then
  Anchors:=[akTop,akRight,akBottom] else
 if IsProp('Align','alLeft') then
  Anchors:=[akLeft,akTop,akBottom] else
 if IsProp('Align','alBottom') then
  Anchors:=[akLeft,akRight,akBottom] else
 if IsProp('Align','alClient') then
  Anchors:=[akLeft,akTop,akRight,akBottom] else
 {if classname='TdhPage' then
  Anchors:=[] else}
  Anchors:=[akLeft,akTop];*)


 snest.bo:=TBounds(Rect(0,0,maxint,maxint));
 if snest.IsBody and (snest.parent<>nil) then
 begin
  snest.bo:=TBounds(Rect(0,0,snest.parent.bo.Width,snest.parent.bo.Height));
  //Alternative: als Melt definieren, so dass der iframe RealParent ist. Dann aber parent-Komplikationen
 end else
 begin
 HasProp('Left',snest.bo.Left);
 HasProp('Top',snest.bo.Top);
 HasProp('Height',snest.bo.Height);
 HasProp('Width',snest.bo.Width);
 //_Anchors:=Anchors;

 //für bitImage und alTop
 {if not HasProp('Right') then
  Exclude(_Anchors,akRight);
 if not HasProp('Bottom') then
  Exclude(_Anchors,akBottom); }

 if (snest.RealParent<>nil) then
 with snest.bo do
 begin
  DoCalcStrongToWeak(Left,Top,Width,Height,snest.RealParent.ClientBound,Anchors,iProp('Right'),iProp('Bottom'));
  inc(Left,snest.RealParent.ClientBound.Left);
  inc(Top,snest.RealParent.ClientBound.Top);
 end;

 (*if HasProp('Right',Right) and (snest.RealParent<>nil) then
 with snest.bo do //see TdhCustomPanel.ReadRight
 if [akLeft,akRight]*Anchors=[akLeft,akRight] then
  Width:=snest.RealParent.Client.Right-(Right+Left) else
  Left:=snest.RealParent.Client.Right-(Right+Width);
 {if [akLeft,akRight]*Anchors=[akLeft,akRight] then
  Width:=snest.RealParent.bo.Width-Right-Left else
  Left:= snest.RealParent.bo.Width-Right-Width; }


 if HasProp('Bottom',Bottom) and (snest.RealParent<>nil) then
 with snest.bo do //see TdhCustomPanel.ReadBottom
 if [akTop,akBottom]*Anchors=[akTop,akBottom] then
  Height:=snest.RealParent.Client.Bottom-(Bottom+Top) else
  Top:=snest.RealParent.Client.Bottom-(Bottom+Height);
 {if [akTop,akBottom]*Anchors=[akTop,akBottom] then
  Height:=snest.RealParent.bo.Height-Bottom-Top else
  Top:=snest.RealParent.bo.Height-Bottom-Height;  }
  *)

 end;



 if snest.RealParent<>nil then
 begin
  inc(snest.bo.Left,snest.RealParent.HorzPosition);
  inc(snest.bo.Top,snest.RealParent.VertPosition);
 end;
 Client:=Rect(0,0,snest.bo.Width,snest.bo.Height);

 {
 if pnest<>nil then
 begin
 if pnest.HasProp('HorzScrollBar.Position',z) or pnest.HasProp('HorzPosition',z) then
  dec(snest.bo.Left,z);
 if pnest.HasProp('VertScrollBar.Position',z) or pnest.HasProp('VertPosition',z) then
  dec(snest.bo.Top,z);
 end; }


 if snest.parent=nil then
 begin
  {dec(snest.bo.Height,27);
  dec(snest.bo.Width,8); }
  {snest.bo.Height:=snest.bo.Height+snest.bo.Top-4;
  snest.bo.Width:=snest.bo.Width+snest.bo.Left-4; }
 end;



 snest.OriAnchors:=Anchors;

 HasProp('Constraints.MinWidth',snest.MinWidth);

 if snest.tag<>'iframe' then
 begin

 if HasProp('HorzScrollBar.Position',snest.HorzPosition) or HasProp('HorzPosition',snest.HorzPosition) then;
 if HasProp('VertScrollBar.Position',snest.VertPosition) or HasProp('VertPosition',snest.VertPosition) then;





 HasRastering:=HasProp('Style.Rastering') or HasProp('Style.BGRastering');
 if HasRastering{ and (classname<>'TdhMenu')} then
 begin

   if classname<>'TdhMenu' then //inline menus may expand!
   begin
    snest.AutoY:=false;
   end;
    snest.AutoX:=false;

   {with ClientRect do
    AddStyle('padding',inttostr(Top)+'px '+inttostr(Right)+'px '+inttostr(Bottom)+'px '+inttostr(Left)+'px');}
   //AddStyle('margin',0);
   //AddStyle('border',0);
   {if HasProp('NewPadding',NewPadding) then
    AddStyle('padding',NewPadding) else
    AddStyle('padding',0);  }

   //AddStyle('overflow','hidden');
   snest.Characters:='';
 end else
 if HasProp('NewPadding',NewPadding) then
 begin
  AddStyle('margin',0);
  AddStyle('border',0);
  AddStyle('padding',NewPadding);
 end;

 {snest.ClientAdj:=Rect(0,0,0,0);
 HasProp('ClientLeft',snest.ClientAdj.Left);
 HasProp('ClientTop',snest.ClientAdj.Top);
 HasProp('ClientBottom',snest.ClientAdj.Bottom);
 HasProp('ClientRight',snest.ClientAdj.Right);}

 HasProp('ClientLeft',Client.Left);
 HasProp('ClientTop',Client.Top);
{ if HasProp('HorzScrollBar.Position',z) or HasProp('HorzPosition',z) then
  dec(Client.Left,z);
 if HasProp('VertScrollBar.Position',z) or HasProp('VertPosition',z) then
  dec(Client.Top,z);}
 if HasProp('ClientBottom',decr) then
  dec(Client.Bottom,decr);
 if HasProp('ClientRight',decr) then
  dec(Client.Right,decr);
 end;

 snest.FClient:=Client;

 snest.borders:=Point(snest.bo.Width-(snest.Client.Right-snest.Client.Left),
                      snest.bo.Height-(snest.Client.Bottom-snest.Client.Top));



 end;

 snest.properties:=glStyle;
 glAttributes:='';
 glClass:='';
 glStyle:='';
 bgColor:='';


 if DoApplyTemplates then
  ApplyTemplates;

end;


procedure EndEle(OldTag:string);
begin
  if OldTag='x' then
  begin
   snest.Props:=Props;
   snest.PropVals:=PropVals;
   Props:=nil;
   PropVals:=nil;
  end;
  snest:=snest.parent;
 tagName:=OldTag;
end;

procedure PureWrite(const s:string);
begin
 snest.Characters:=s;
(* if ParentInfo<>'no-vis' then
 if true or HasProp('Style.IsPre') or (classname='TMemo')  or (classname='TRichEdit') then
  SAXWriter.Characters(SubstText(#10,{'&#xA;'}endl,copy(s,1,length(s)))) else
  SAXWriter.Characters(SubstText(#10,'<br/>',copy(s,1,length(s))));
*)
end;

function ApplyTemplate_get_style(const sty:string): string;
var s,ss:string;

procedure ApplyTemplate_get_border(const sty,bor:string);
var aWidth,aColor,aStyle,aCompact:string;
begin
 if HasProp(sty+'Width',aWidth) or HasProp(sty+'cWidth',aWidth) then;
 if HasProp(sty+'Color',aColor) or HasProp(sty+'cColor',aColor) then;
 if HasProp(sty+'Style',aStyle) or HasProp(sty+'cStyle',aStyle) then;

 if HasProp(sty+'Compact', aCompact) then
  AddStyle(bor,aCompact) else
 if (aWidth<>'') and (aColor<>'') and (aStyle<>'') then
  AddStyle(bor,aWidth+'px'+' '+aColor+' '+GetHyphens(aStyle)) else
 begin
  if aWidth<>'' then AddStyle(bor+'-width',aWidth+'px');
  if aColor<>'' then AddStyle(bor+'-color',aColor);
  if aStyle<>'' then AddStyle(bor+'-style',GetHyphens(aStyle));
 end;
end;

procedure CalcBorderRadius(al:TEdgeAlign);
const sDelphiBorderCorner:array[TEdgeAlign] of string=('All','TopLeft','BottomRight','BottomLeft','TopRight');
var P:TPoint;
    s:string;
begin
  if UseCSSBorderRadius and HasProp(sty+'BorderRadius.'+sDelphiBorderCorner[al],s) and
     GetBorderRadiusPixels(s,P) then
  begin
   if P.X<>P.Y then
    s:=inttostr(P.X)+'px '+inttostr(P.Y)+'px' else
    s:=inttostr(P.X)+'px';
   AddStyle(GetBorderRadiusString(al),s);
   AddStyle(GetBorderRadiusStringMoz(al),s);
  end;
end;




var sglStyle,overwrite:string;
    sl:TStringList;
    i:integer;
begin
  sglStyle:=glStyle;
  if (sty='Style.') and HasProp('InitialProps',s) then
   glStyle:=glStyle+AnsiSubstText(';',';'+IndentSpace,s);

  if not (EnableIgnoreCSS and HasProp('TheoreticRastering')) then
  //if not IsRastered(false) then
  begin
  if HasProp(sty+'BackgroundColor',s) then AddStyleBgcolor(s);
  if HasProp(sty+'BackgroundImage.Path',s) then
  if not HasProp(sty+'BackgroundImage.State') then
  begin
   AddWarning(id,': Linked image file '''+s+''' cannot be found!');
  end;
  if HasProp(sty+{'BackgroundImage.Data'}'BackgroundImageUrl',s) then
  begin
  {if (sty='Style.') and HasProp('AsImage') then
   snest.img:=s else }
   AddStyle('background-image','url('''+s+''')');
   if HasProp(sty+'T1X1') then
   begin
    AddStyle('filter','progid:DXImageTransform.Microsoft.AlphaImageLoader(src='+s+',sizingmethod=scale'+')');
    AddStyle('background-image','expression("none")');
    //AddStyle('cursor','pointer');
   end;
  end;
  if HasProp(sty+'BackgroundPosition',s) then AddStyle('background-position',s);
  if HasProp(sty+'BackgroundRepeat',s) then AddStyle('background-repeat',GetHyphens(s));
  if HasProp(sty+'BackgroundAttachment',s) then AddStyle('background-attachment',GetHyphens(s));
  if HasProp(sty+'BorderLeft.Compact',s) and IsProp(sty+'BorderRight.Compact',s) and IsProp(sty+'BorderBottom.Compact',s) and IsProp(sty+'BorderTop.Compact',s) then
  begin
   AddStyle('border',s);
  end else
  begin
   ApplyTemplate_get_border(sty+'Border.','border');
   ApplyTemplate_get_border(sty+'BorderLeft.','border-left');
   ApplyTemplate_get_border(sty+'BorderRight.','border-right');
    ApplyTemplate_get_border(sty+'BorderBottom.','border-bottom');
   ApplyTemplate_get_border(sty+'BorderTop.','border-top');
  end;
  CalcBorderRadius(ealNone);
  CalcBorderRadius(ealTop);
  CalcBorderRadius(ealRight);
  CalcBorderRadius(ealBottom);
  CalcBorderRadius(ealLeft);
  if HasProp(sty+'BorderColors',s) then AddStyle('border-color',s);
  if HasProp(sty+'Color',s) then AddStyle('color',s);
  if HasProp(sty+'Direction',s) then AddStyle('direction',GetHyphens(s));
  if HasProp(sty+'FontFamily',s) then
  begin
   sl:=GetFontList(s);
   s:='';
   for i:=0 to sl.Count-1 do
   begin
    if Pos(' ',sl[i])<>0 then
     s:=s+'"'+sl[i]+'"'+',' else
     s:=s+sl[i]+',';
   end;
   AddStyle('font-family',copy(s,1,length(s)-1));
   sl.Free;
  end;
  if HasProp(sty+'FontSize',s) then AddStyle('font-size',WithPX(s));
  if HasProp(sty+'FontStyle',s) then AddStyle('font-style',GetHyphens(s));
  if HasProp(sty+'FontVariant',s) then AddStyle('font-variant',GetHyphens(s));
  if HasProp(sty+'FontWeight',s) then AddStyle('font-weight',GetHyphens(s));
  if HasProp(sty+'LineHeight',s) then AddStyle('line-height',WithPX(s));
  if HasProp(sty+'ListStyleType',s) then AddStyle('list-style-type',GetHyphens(s));
  if HasProp(sty+'Margin',s) then AddStyle('margin',WithPX(s));
  if HasProp(sty+'MarginLeft',s) then AddStyle('margin-left',WithPX(s));
  if HasProp(sty+'MarginRight',s) then AddStyle('margin-right',WithPX(s));
  if HasProp(sty+'MarginTop',s) then AddStyle('margin-top',WithPX(s));
  if HasProp(sty+'MarginBottom',s) then AddStyle('margin-bottom',WithPX(s));
  if HasProp(sty+'Padding',s) then AddStyle('padding',s+'px');
  if HasProp(sty+'PaddingLeft',s) then AddStyle('padding-left',s+'px');
  if HasProp(sty+'PaddingRight',s) then AddStyle('padding-right',s+'px');
  if HasProp(sty+'PaddingTop',s) then AddStyle('padding-top',s+'px');
  if HasProp(sty+'PaddingBottom',s) then AddStyle('padding-bottom',s+'px');
  if HasProp(sty+'TextAlign',s) then AddStyle('text-align',GetHyphens(s));
  if HasProp(sty+'TextDecoration',s) then
  begin
   ss:='';
   if AdvPos('ctdNone',s)<>0 then ss:=ss+' none';
   if AdvPos('ctdUnderline',s)<>0 then ss:=ss+' underline';
   if AdvPos('ctdOverline',s)<>0 then ss:=ss+' overline';
   if AdvPos('ctdLineThrough',s)<>0 then ss:=ss+' line-through';
   if AdvPos('ctdBlink',s)<>0 then ss:=ss+' blink';
   AddStyle('text-decoration',copy(ss,2,maxint));
  end;
  if HasProp(sty+'TextIndent',s) then AddStyle('text-indent',WithPX(s));
  if HasProp(sty+'TextTransform',s) then AddStyle('text-transform',GetHyphens(s));
  if HasProp(sty+'VerticalAlign',s) then AddStyle('vertical-align',WithPX(s));
  if HasProp(sty+'WhiteSpace',s) then AddStyle('white-space',GetHyphens(s));

  if HasProp(sty+'Cursor',s) then AddStyle('cursor',GetHyphens(s));
  if HasProp(sty+'Display',s) then AddStyle('display',GetHyphens(s));
  if HasProp(sty+'Visibility',s) then AddStyle('visibility',GetHyphens(s));
  if HasProp(sty+'ZIndex',s) then AddStyle('z-index',s);

  end;



  if {snest.IsRastered(false)}HasProp('Style.Rastering') or HasProp('Style.BGRastering') then
  begin
   {AddStyle('background','url("'+Rastering+'") no-repeat');

   AddStyle('filter','progid:DXImageTransform.Microsoft.AlphaImageLoader(src='+Rastering+',sizingmethod=crop'+')');
   AddStyle('background','expression("none")');}
   //AddStyle('cursor','pointer');
  end else
  begin
  if HasProp(sty+'UndefFilter') then
   AddStyle('filter','none');
  if (sty='Style.') and HasProp(sty+'ContentBefore',s) then snest.Characters:=s+snest.Characters;
  if (sty='Style.') and HasProp(sty+'ContentAfter',s) then snest.Characters:=snest.Characters+s;
  end;

    {
  if HasProp(sty+'BGRastering',BGRastering) then
  begin
   AddStyle('background','url("'+BGRastering+'") no-repeat');
   AddStyle('filter','progid:DXImageTransform.Microsoft.AlphaImageLoader(src='+BGRastering+',sizingmethod=scale)');
   AddStyle('background','expression("none")');
  end;      }



  if HasProp(sty+'Other',s) then glStyle:=glStyle+s+';'+IndentSpace;
  result:=GoodStyle(glStyle);
  glStyle:=sglStyle;
end;




var aMinWidth,BevelWidth,aHeight,aWidth,aItemHeight:integer;
    s,boxval,ModalResult,HTMLImplementation:string;
    ItemIndex,r:integer;
    sl:TStringList;
    IsTop:boolean;
    Layout:TLinkType;
    HeightDiffCut:boolean;

procedure FakeProp(const s:string; i:integer);
begin
 PropVals.Insert(Props.Add(s),inttostr(i));
end;

function ExtractAccessKey(const s:string):string;
var i:integer;
      AccessKey:string;
const OurAmp='&amp;';
begin
 result:=s;
 AccessKey:='';
 r:=length(result)+1;
 while (r-1>=1) and  bAdvPosBack(r,OurAmp,result,r-1) do
 begin
  delete(result,r,length(OurAmp));
  if (r-length(OurAmp)>=1) and SubEqual(OurAmp,result,r-length(OurAmp)) then
   dec(r,length(OurAmp)) else
  if AccessKey='' then
   AccessKey:=copy(result,r,1);
 end;
 if AccessKey<>'' then
  AddAttr('AccessKey',AccessKey);
end;


var edittag:string;
    UseIFrame,IsInternalHTMLBody,IsInternalScrollable:boolean;
    checkbox:string;
    HasRastering:boolean;
    jscript:string;
    FormButtonType:TFormButtonType;

begin
 ChildInfo:='';
 snest:=nil;
 Props:=TMyStringList.Create;
 PropVals:=TMyStringList.Create;
 try
  glStyle:='';
  id:='';
  IsTop:=docg.Point=1{Node.parentNode.nodeType=9}; 
  assert(docg.SaveOverPos('<object ',id));
  if docg.Over('name="') then
   assert(docg.SaveOverPos('" ',id));     
  assert(docg.OverPos('classname="'));
  assert(docg.SaveOverPos('">',ClassName));
  docg.overShit;
  PrepProps;
  UseIFrame:=false;
  //ClassName:=GetClass(Node);
  //id:=GetName(Node);


   { if HasProp('DownAnchor',s) then
     AddAttr('DownAnchor',s);    }
{   if HasProp('Style.IsPre') then
    AddAttr('escape','no');
 }

  if (pnest=nil) and (gnest<>nil) then
  begin
   ApplyTemplates;
  end else
  if (classname='TdhLabel') or (classname='TdhRule') then
  begin
    DoEle('div');
    if (HasProp('Caption',s) or HasProp('Text',s)) and not HasProp('Style.Rastering') then
     PureWrite(s);
  end else
  if (classname='TdhOleContainer') then
  begin
    //AddStyle('overflow','scroll');
    if HasProp('Link',s) then
    begin
     AddAttr('src','file:///'+s);
     DoEle('embed');
    end else
     DoEle('div');
    {if HasProp('OleImage',s) then
    begin
     AddAttr('src',s);
     DoEle('img');
     EndEle('div');
    end;}
  end else
  if (classname='TdhFile') then
  begin
    //AddStyle('overflow','scroll');

    if HasProp('FileName',s) and HasProp('InvalidFile') then
    begin
     AddWarning(id,': Linked file '''+s+''' cannot be found!');
    end;

    if IsProp('Usage','fuFlash') and HasProp('HTMLFileName',s) then
    begin
     AddAttr('src',s);
     AddAttr('quality','high');
     if not IsProp('Loop','True') then
       AddAttr('loop','false');
     DoEle('embed');
    end else
    if IsProp('Usage','fuJavascript') and HasProp('HTMLFileName',s) then
    begin
     AddAttr('src',s);
     AddAttr('type','text/javascript');
     //glStyle:='';
     DoEle('script');
    end else
    if IsProp('Usage','fuMusic') and HasProp('HTMLFileName',s) then
    begin
     AddAttr('src',s);
     if not IsProp('Loop','False') then
       AddAttr('loop','infinite');
     //AddStyle('display','none');
     //glStyle:='';
     DoEle('bgsound');
    end else
    begin
     DoEle('divdel');
    end;
    {if HasProp('OleImage',s) then
    begin
     AddAttr('src',s);
     DoEle('img');
     EndEle('div');
    end;}
  end else
  if classname='TdhMenu' then
  begin
   DoEle('div');
  end else
  if (ClassName='TdhLink') or (ClassName='TdhFormButton') then
  begin
   HasRastering:=HasProp('Style.Rastering'){ or HasProp('Style.BGRastering')};

   if IsProp('FormButtonType','fbReset') then
    FormButtonType:=fbReset else
   if IsProp('FormButtonType','fbSubmit') or (ClassName='TdhFormButton') then
    FormButtonType:=fbSubmit else
    FormButtonType:=fbNone;

   if ClassName='TdhLink' then
    Layout:=ltLink else
    Layout:=ltButton;

    if HasProp('ComputedLayout',s) or HasProp('Layout',s) then
    if s='ltButton' then
     Layout:=ltButton else
    if s='ltLink' then
     Layout:=ltLink else
    if s='ltText' then
     Layout:=ltText;

   if (FormButtonType=fbNone) then
   begin
    if HasProp('NotIfUrl') then
     AddAttr('notifurl','true');
    if HasProp('Linked') then
     AddAttr('linked','true');

    if HasProp('LinkedCount') then
     AddAttr('name',id);
    if HasProp('RealLinkPage',s) then
     AddAttr('linkpage',s);
    if HasProp('RealLastPage',s) then
      AddAttr('lastpage',s);

    if not HasRastering then
    if Layout=ltButton then
     AddAttr('type','button');
   end else
   begin

    if HasRastering or (Layout in [ltText,ltLink]) then
    begin
     pp:=pnest;
     while (pp<>nil) and (pp.dclass<>'TdhHTMLForm') do
      pp:=pp.parent;
     if pp<>nil then
     begin
      if FormButtonType=fbReset then
       jscript:='javascript:document.'+pp.id+'.reset()' else
       jscript:='javascript:document.'+pp.id+'.submit()';
      if Layout=ltLink then
       AddAttr('href',jscript) else
       AddAttr('onclick',jscript+';return false;');
     end;
    end else
    begin
     if FormButtonType=fbReset then
      AddAttr('type','reset') else
      AddAttr('type','submit');
    end;
   end;


   if (Layout in [ltButton]) and HasProp('Text',s) and (Pos('<',s)=0) and not HasRastering then
   begin
    AddAttr('value',s);
    DoEle('input');
   end else
   begin
    if not HasRastering and (Layout in [ltButton]) then
    begin
     DoEle('button');
     //snest.AutoX:=false;
    end else
    if (Layout in [ltLink]) then
     DoEle('a') else
     DoEle('div');
    if HasProp('Text',s) and not HasProp('Style.Rastering') then
     PureWrite(s);
   end;

   if IsProp('Down','True') then
    snest.IsAlwaysDown:=true;
   if HasProp('LinkPage',s) then
    snest.LinkPage:=s;
   if HasProp('PageRange',i) {and HasProp('Href')} then
    snest.PageRange:=i;
  end else
  if (classname='TdhPanel') or (classname='TdhBody') or (classname='TFrame') or (classname='TAsTransparentWindow') then
  begin
   DoEle('div');
  end else
  if (ClassName='TdhSelect'){ or (ClassName='TdhComboBox') or (classname='TdhListBox')} or (classname='TComboBox') or (classname='TListBox') or (classname='TMyColorComboBox') then
  begin
   AddAttr('name',id);
   CallTemplate_set_TabOrder;
   if (classname='TListBox'){ or (classname='TdhListBox')} or (classname='TdhSelect') and IsProp('SelectType','stList') then
   begin
    //_AutoY:=(classname='TdhListBox') and not IsProp('IntegralHeight','False');
    //if _AutoY and HasProp('Height',aHeight) and HasProp('ItemHeight',aItemHeight) then
    // AddAttr('size',inttostr(aHeight div aItemHeight)) else
    if HasProp('Rows',s) then   
     AddAttr('size',s) else
     AddAttr('size','2');
    if IsProp('MultiSelect','True') or IsProp('Multiple','True') then
     AddAttr('multiple','multiple');
   end else
   begin
    //_AutoY:=true;
    AddAttr('size','1');
   end;
   if HasProp('Target',s) then
    AddAttr('onchange','javascript:if(options[selectedIndex].value)window.open(options[selectedIndex].value,'''+s+''')');


   DoEle('select');
   if HasProp('HTMLOptions',s) then
    PureWrite(s) else
   if HasProp('Items.Strings',s) then
   begin
    sl:=TStringList.Create;
    sl.Text:=s;
    if not HasProp('ItemIndex',ItemIndex) then
     ItemIndex:=-1;
    for i:=0 to sl.Count-1 do
    begin
     if i=ItemIndex then
      AddAttr('selected','selected');
     s:=sl[i];
     //if ((classname='TdhComboBox') or (classname='TdhListBox')) and GetRealBoxText(s,boxval,s) then
     // AddAttr('value',boxval);

     DoEle('option',false,false);
     PureWrite(s);
     EndEle('select');
    end;
    sl.Free;
   end;
  end else
  if (ClassName='TLabel') or (ClassName='TRxLabel') then
  begin                
   if not IsProp('WordWrap','True') and IsProp('AutoSize','False') then
    AddStyle('overflow','hidden');

   if not IsProp('WordWrap','True') then
    AddStyle('white-space','nowrap');

   if HasProp('Alignment',s){ and not HasChildObjects}  then
   if s='taCenter' then
    AddStyle('text-align','center') else
   if s='taRightJustify' then
    AddStyle('text-align','right');

   DoEle('div');
   if HasProp('Text',s) or HasProp('Caption',s) then
    PureWrite(s);
   snest.AutoX:=not IsProp('AutoSize','False') and not IsProp('WordWrap','True');
   snest.AutoY:=not IsProp('AutoSize','False');
  end else
  if (classname='TdhStyleSheet'){ and not HasProp('Visible')} then
  begin
   DoEle('');
   snest.NeverVisible:=true;
  end else
  if (classname='TdhScrollBox') or (classname='TScrollBox') or (classname='TdhStyleSheet') then
  begin
   AddStyle('overflow','auto');
   DoEle('div');
  end else
  if ClassName='TButton' then
  begin
   if HasProp('Caption',s) then
    AddAttr('value',ExtractAccessKey(s));
   CallTemplate_set_TabOrder;
   if not HasProp('ModalResult',ModalResult) then
    ModalResult:='';
   if ModalResult='1' then
    AddAttr('type','submit') else
   if ModalResult='4' then
    AddAttr('type','reset') else
    AddAttr('type','button');
   if ModalResult='2' then
    AddAttr('onClick','window.close()');
   DoEle('input');
  end else
  if (classname='TPanel') or (classname='TWebBrowser') or (classname='TEmbeddedWB') or (classname='TChart') then
  begin
   (*
   if IsProp('ParentColor','True') then
    AddAttr('class','tpanel2') else
    AddAttr('class','tpanel');

//   PreventApplyTemplates:=true;
   DoEle('div');
//   PreventApplyTemplates:=false;
   if not IsProp('BevelOuter','bvNone') then
   begin
    if IsProp('BevelOuter','bvLowered') then
     AddStyle('border-color','#808080 #FFFFFF #FFFFFF #808080');

     AddAttr('class','tpanelborder');
{    if HasProp('BevelWidth',BevelWidth) then
     AddStyle('border-width',BevelWidth) else}
{     BevelWidth:=1;
    if HasProp('Height',aHeight) then
     AddStyle('height',aHeight-2*BevelWidth);   }
    DoEle('div',false,false);
    EndEle('div');
   end;*)

   if not IsProp('ParentColor','True') then
    AddStyleBgcolor('ButtonFace');

   BevelWidth:=0;
   if not IsProp('BevelOuter','bvNone') then
   begin
    if not HasProp('BevelWidth',BevelWidth) then
     BevelWidth:=1;
    AddStyle('border',inttostr(BevelWidth)+'px solid');
    if IsProp('BevelOuter','bvLowered') then
     AddStyle('border-color','#808080 #FFFFFF #FFFFFF #808080') else
     AddStyle('border-color','#FFFFFF #808080 #808080 #FFFFFF');
   end;
   HasProp('Width',aWidth);
   HasProp('Height',aHeight);
   FakeProp('ClientLeft',BevelWidth);
   FakeProp('ClientTop',BevelWidth);
   FakeProp('Style.Width',aWidth-2*BevelWidth);
   FakeProp('Style.Height',aHeight-2*BevelWidth);
   DoEle('div');
   snest.NeedParentColor:=IsProp('ParentColor','True');
//   InflateRect(snest.Client,-BevelWidth,-BevelWidth);

  end else
  if (classname='TGroupBox') or (classname='TCheckGroupBox') then
  begin   {
   DoEle('div');
   AddAttr('class','gbox1');
   if HasProp('Width',aWidth) then AddStyle('width',aWidth-3);
   if HasProp('Height',aHeight) then AddStyle('height',aHeight-8);
   DoEle('div',false,false);
   AddAttr('class','gbox2');
   if HasProp('Width',aWidth) then AddStyle('width',aWidth-3);
   if HasProp('Height',aHeight) then AddStyle('height',aHeight-8);
   EndEle('div');
   DoEle('div',false,false);
   AddAttr('class','gbox3');
   if HasProp('Color',s) then
    AddStyle('background-color',s);
   EndEle('div');
   DoEle('span',false,false);
   if HasProp('Caption',s) then
    PureWrite(s);
   EndEle('div');  }
//   AddAttr('class','gbox');

   PreventApplyTemplates:=true;
   DoEle('div');
   PreventApplyTemplates:=false;
   snest.NeedParentColor:=true;   
   AddAttr('class','gbox1');
   DoEle('div',false,false);
   AddAttr('class','gbox2');
   EndEle('div');
   DoEle('div',false,false);
   AddAttr('class','gbox3');
   EndEle('div');
   DoEle('span',false,false);
   snest.NeedParentColor:=true;
   if HasProp('Caption',s) then
    PureWrite(s);
   EndEle('div');
   ApplyTemplates;
  end else
  if (classname='TdhRadioButton') or (classname='TdhCheckBox') then
  begin
   AddAttr('for',id);
   //if HasProp('Caption',s) then
   // s:={ExtractAccessKey}(s);
   DoEle('label');
   CallTemplate_set_TabOrder;
   AddAttr('id',id);
   if (classname='TRadioButton') or (classname='TdhRadioButton') then
   begin
    AddAttr('type','radio');
    AddAttr('name',pnest.ID);
    if HasProp('Value',s) then
     AddAttr('value',s) else
     AddAttr('value',id);
   end else
   begin
    AddAttr('type','checkbox');
    AddAttr('name',id);
    if HasProp('Value',s) then
     AddAttr('value',s) else
     AddAttr('value','true');
   end;
   //AddStyle('vertical-align','middle');
   if HasProp('Checked') then
    AddAttr('checked','checked');  
   {DoEle('input',false,false);
   EndEle('label');}
   checkbox:='<input '+glAttributes+' style="vertical-align:baseline; margin-bottom:0px"'+'/>';
   glAttributes:='';
   if not HasProp('Text',s) then
    s:='';
   if IsProp('Alignment','taLeftJustify') then
    PureWrite(s+checkbox) else
    PureWrite(checkbox+s);
   //snest.TextFirst:=HasProp('Alignment','taLeftJustify');
  end else
  {
  if (classname='TRadioButton') or (classname='TCheckBox') or (classname='TdhRadioButton') or (classname='TdhCheckBox') then
  begin
   //AddAttr('class','nowr');
   AddStyle('white-space','nowrap');
   DoEle('div');
   AddAttr('id',id);
   CallTemplate_set_TabOrder;
   if (classname='TRadioButton') or (classname='TdhRadioButton') then
   begin
    AddAttr('type','radio');
    AddAttr('name',pnest.ID);
    AddAttr('value',id);
    AddAttr('class','tradiobox');
   end else
   begin
    AddAttr('type','checkbox');
    AddAttr('name',id);
    AddAttr('value','true');
    AddAttr('class','tcheckbox');
   end;
   if HasProp('Checked') then
    AddAttr('checked','checked');
   DoEle('input',false,false);
   EndEle('div');
   AddAttr('class','forlabel');
   AddAttr('for',id);
   if HasProp('Caption',s) then
    s:=ExtractAccessKey(s);
   DoEle('label',false,false);
   if HasProp('Caption') then
    PureWrite(s);
   EndEle('div');
  end else}
  if classname='TdhDirectHTML' then
  begin
   DoEle('div');
   if HasProp('InnerHTML',s) then
    PureWrite(s);
   {DoEle('divdel');
   if HasProp('HTML.Strings',s) then
   if not HasProp('InsertLocation',s) or (s='ilCurrent') then
    snest.insertloc:=pnest.ID else
   if s='ilHead' then
    snest.insertloc:='#head' else
   begin
    snest.insertloc:='#body';
//    snest.RenderIn:=snest.parentTS.id;
   end;
   if HasProp('HTML.Strings',s) then
    PureWrite(s);}
  end else
  if (classname='TSpeedButton') or (classname='TRxSpeedButton') then
  begin
   AddAttr('class','tspeedbutton');
   if IsProp('ModalResult','1') then
    AddAttr('type','submit') else
   if IsProp('ModalResult','4') then
    AddAttr('type','reset') else
    AddAttr('type','button');
   DoEle('button');
   if HasProp('Glyph.Data',s) then
   begin
    {s:='<img alt="" src="'+s+'"';
    if HasProp('Caption') and not IsProp('Layout','blGlyphTop') then
     s:=s+' style="vertical-align:middle"';
    s:=s+'/>';
    PureWrite(s);}
    AddAttr('alt','');
    AddAttr('src',s);
    if HasProp('Caption') and not IsProp('Layout','blGlyphTop') then
     AddStyle('vertical-align','middle');
    DoEle('img',false,false);
    EndEle('button');
   end;
   if HasProp('Caption',s) then
   begin
    if HasProp('Glyph.Data') and IsProp('Layout','blGlyphTop') then
     PureWrite('<br/>'+s) else
     PureWrite(s);
   end;
  end else
  (*if (classname='TMemo') or (classname='TdhMemo') or (classname='TRichEdit') then
  begin
   AddAttr('name',id);
   if HasProp('ReadOnly') then
    AddAttr('readonly','readonly');

   CallTemplate_set_TabOrder;
   DoEle('textarea');
   {dec(snest.bo.Right,4);
   dec(snest.bo.Bottom,4);}
   if HasProp('Caption',s) then
    PureWrite(s) else
   if HasProp('Lines.Strings',s) then
    PureWrite(s);
  end else*)
  if (ClassName='TdhHiddenField') then
  begin
   AddAttr('name',id);
   AddAttr('type','hidden');
   if HasProp('Value',s) then
    AddAttr('value',s);
   DoEle('input');
  end else
  if (ClassName='TEdit') or (ClassName='TdhEdit') or (ClassName='TdhFileField') or (classname='TSpinFloatEdit') or (classname='TDateTimePicker') or (classname='TFilenameEdit') or (classname='TMaskEdit') or (classname='TMemo') or (classname='TdhMemo') or (classname='TRichEdit') then
  begin
   AddAttr('name',id);
   if HasProp('ReadOnly') then
    AddAttr('readonly','readonly');
   CallTemplate_set_TabOrder;
   edittag:='input';
   if IsProp('Wrap','False') then
    AddAttr('wrap','off');
   if (classname='TMemo') or (classname='TdhMemo') then
    edittag:='textarea' else
   if HasProp('PasswordChar') or HasProp('Password') then
    AddAttr('type','password') else
   if (classname='TFilenameEdit') or (classname='TdhFileField') then
    AddAttr('type','file') else
    AddAttr('type','text');

   if HasProp('Columns',s) then
   if classname='TdhMemo' then
    AddAttr('cols',s) else
    AddAttr('size',s);
   if HasProp('Rows',s) then
    AddAttr('rows',s);

   s:='';
   if HasProp('Text',s) or HasProp('Value',s) or HasProp('Caption',s) or HasProp('Lines.Strings',s) then
   if edittag<>'textarea' then
    AddAttr('value',s);
   DoEle(edittag);
   if edittag='textarea' then
    PureWrite(s);

   //dec(snest.bo.Right,4);
  end else    {
  if (ClassName='TdhFileField') then
  begin
   AddAttr('name',id);
   CallTemplate_set_TabOrder;
   AddAttr('type','file');
   if HasProp('Text',s) or HasProp('Value',s) then
    AddAttr('value',s);
   DoEle('input');
   //dec(snest.bo.Right,4);
  end else   }
  if (classname='TImage') or (classname='TRxGIFAnimator') then
  begin
   if HasProp('Picture.Data',s) or HasProp('Image.Data',s) then
    AddAttr('src',s);
   AddAttr('alt','');
   DoEle('img');
   if IsProp('Stretch','True') then
   begin
    snest.AutoX:=false;
    snest.AutoY:=false;
   end;
  end else
  if classname='TdhPageControl' then
  begin
   if HasProp('DynamicNavigation') then
    ChildInfo:='hiScript' else
    ChildInfo:='hiEmbedded';
  { if not HasProp('HTMLImplementation',ChildInfo) then
    ChildInfo:='hiEmbedded';  }
   {if ChildInfo='hiIFrame' then
   begin
    CallTemplate_inherit_props;
    ChildInfo:=glStyle;
    glStyle:=pnest.ChildInfo;
    //glStyle:=pnest.ChildInfo+glStyle;
    AddStyle('margin',0);
    AddStyle('padding',0);
    AddStyle('height','100%');
    DoEle('body',false,true, true,true);
   end else  }
   if ChildInfo='hiScript' then
   begin

    PreventApplyTemplates:=true;
    //AddStyle('overflow','visible'); //sonst von div,a{overflow:hidden} überschrieben, und ZOrder stimmt net mehr der Kindelement
    DoEle('div');
    PreventApplyTemplates:=false;
    snest.Melt:=true;

    _nest:=snest;
    if not IsProp('FixedHeight','True') then
    while _nest.parentTS<>nil do
    begin
     _nest.RuntimeVariableHeight:=true;
     _nest:=_nest.parent;
    end;

    ApplyTemplates;


   end else
   begin

    DoEle('div',true,true,false,false,true);
    //snest.Melt:=true;
    {
    not overjump parent, since PageRange get problems!
    snest:=pnest;
    snest.ChildInfo:=ChildInfo;
    ApplyTemplates;
    snest.ChildInfo:='';
    snest:=nil; }
   end;
   snest.bo:=TBounds(Rect(-maxint div 4,-maxint div 4,maxint div 2,maxint div 2)); //for 2d-sorting
   {for i:=0 to snest.Count-1 do
   with TNest(snest[i]) do
   begin
    inc(bo.Left,pnest.HorzPosition);
    inc(bo.Top,pnest.VertPosition);
   end;   }

  end else
  if classname='TdhPage' then
  begin
   //if not HasParentProp('HTMLImplementation',HTMLImplementation) then
   HeightDiffCut:=false;
   HTMLImplementation:=pnest.ChildInfo;
   if HTMLImplementation='' then
   begin
    IsInternalScrollable:=pnest.parent<>nil;
    IsInternalHTMLBody:=IsInternalScrollable and IsProp('UseIFrame','True');
    if IsInternalScrollable and not IsInternalHTMLBody then
    begin
      if IsProp('Scrolling','scYes') then
       AddStyle('overflow','scroll') else
      if IsProp('Scrolling','scNo') then
       AddStyle('overflow','hidden') else
       AddStyle('overflow','auto');
     DoEle('div');
    end else
    begin
     {if IsProp('Scrolling','scYes') then
     begin
       AddStyle('overflow-x','auto');
       AddStyle('overflow-y','scroll');
     end;}
     UseIFrame:=IsInternalHTMLBody;
     if UseIFrame then
     begin
      AddAttr('frameborder','0');
      //AddAttr('src',id+'.html');
      AddAttr('name',id);
      AddAttr('allowtransparency','true');
      if HasProp('ScrollbarsAlwaysVisible') then
       AddAttr('scrollbars','yes');
      if IsProp('Scrolling','scYes') then
       AddAttr('scrolling','yes');
      if IsProp('Scrolling','scNo') then
       AddAttr('scrolling','no');
      PreventApplyTemplates:=true;
      DoEle('iframe',false,true);
      PreventApplyTemplates:=false;
     end else
     begin
      if IsProp('Scrolling','scYes') then
      begin
       AddAttr('scroll','yes');
      end;
      if IsProp('Scrolling','scNo') then
      begin
       AddAttr('scroll','no');
       AddStyle('overflow','hidden');
      end;
     end;

     //AddStyle('margin',0);
     //AddStyle('padding',0);
     //AddStyle('height','100%');
     AddAttr('vlink','#0000FF');   
     //AddStyle('visibility','hidden');
     //AddStyle('display','none');
     DoEle('body',true,true,{UseIFrame}true,UseIFrame{,UseIFrame});
     if not UseIFrame then
     begin
  //   snest.parentTS.HasSubTS:=true;
      snest.parentTS.HasSubTS:=true;
      snest.Align:=alClient;
      snest.OriAnchors:=[akTop,akBottom,akLeft,akRight];
     end else
     begin
      snest.Props:=Props.Duplicate;
      snest.PropVals:=PropVals.Duplicate;
     end;
    end;            
    //snest.Melt:=true;
   end else
   begin
   if HTMLImplementation='hiScript' then
   begin
    if HasProp('Selected') then
     AddAttr('pageselected','true');
    //AddStyle('position','relative');
    AddStyle('display','none');
    DoEle('div');
    //snest.AutoX:=true;
    HeightDiffCut:=not HasProp('Selected');

//    snest.RuntimeVariableHeight:=pnest.RuntimeVariableHeight;

//    if HasProp('FinalHeight',aHeight) then
{     AddAttr('FinalHeight',s); }
     //snest.FinalHeight:=aHeight;
   end else
   if HTMLImplementation='hiEmbedded' then
   begin
    AddAttr('noframe','true');
    DoEle('div',true,true,true);
    snest.IsPC:=true;
    //snest.Melt:=true;
    snest.parentTS.HasSubTS:=true;
    //HasProp('DownAnchor',snest.DownAnchor);
    snest.IsSel:=HasProp('Selected');
    {AddAttr('noframe','true');
    DoEle('newpage',true,true,true);
    snest.IsPC:=true;
    snest.Melt:=true;
    snest.parentTS.HasSubTS:=true;
    HasProp('DownAnchor',snest.DownAnchor);
    snest.IsSel:=HasProp('Selected');  }
   end else
   begin
    DoEle('div',true,true,true);
   end;
   HasProp('HeightDiff',snest.HeightDiff);
   //snest.bo.Bottom:=snest.parent.bo.Bottom+snest.HeightDiff;
   if HeightDiffCut then
    snest.HeightDiff:=0;
   end;

  end else
  if classname='TdhHTMLForm' then
  begin
   AddAttr('name',id);
   //action="http://selfaktuell.teamone.de/cgi-bin/formview.pl" method="post">
   {if HasProp('Action',s) then
    AddAttr('action',s);
   if HasProp('Target',s) then
    AddAttr('target',s);}
   if HasProp('Method') then
    AddAttr('method','post');
   if HasProp('FileUpload') then
    AddAttr('enctype','multipart/form-data');
   DoEle('form');
  end else
  if (classname='TTabControl') or (classname='TTabControlEx') then
  begin
   DoEle('div');
  end else
  if (classname='TPageControl') or (classname='TPageControlEx') then
  begin
   if HasProp('ActivePage',ChildInfo) then;
   DoEle('div');
  end else
  if (classname='TTabSheet') then
  begin
   if id<>pnest.ChildInfo then
    ApplyTemplates else
    DoEle('div');
  end else
  if IsTop then
  begin
   AddStyle('margin','0');
//   AddStyle('height','100%');
//   CallTemplate_inherit_props;
   DoEle('body',true,true,true,true);
   if (snest.Count=1) and TNest(snest[0]).IsBody then
    snest.Melt:=true;
   {if HasProp('Caption',s) then
    snest.title:=s;  }
  end else
  begin
   ApplyTemplates;
  end;



 if (snest<>nil) and SubEqual('Tdh',classname) {HasProp('StyleStored') or HasProp('ConstantWidthHeight')} then
 begin
  //snest.DownOverlayOver:=IsProp('PreferDownStyles','True');
  snest.OverBasedOnDown:=HasProp('OverBasedOnDown');
  snest.Style[hsNormal]:=ApplyTemplate_get_style('Style.');
  snest.bgcolor:=bgcolor;
  snest.Style[hsDown]:=ApplyTemplate_get_style('StyleDown.');
  snest.Style[hsOver]:=ApplyTemplate_get_style('StyleOver.');
  snest.Style[hsOverDown]:=ApplyTemplate_get_style('StyleOverDown.');
  snest.StyleStored:=(snest.Style[hsNormal]<>'') or (snest.Style[hsDown]<>'') or (snest.Style[hsOver]<>'') or (snest.Style[hsOverDown]<>'');
 end;

   if UseIFrame then
    EndEle('iframe');

 finally
 if snest<>nil then
  EndEle('x');

    {
 if Props<>nil then
 assert(Props=nil);}
 Props.Free;
 PropVals.Free;
 if not docg.Over('</object>') then
 assert(docg.Over('</object>'),'Object '''+id+''' has faulty content!');
 docg.overShit;
 end;

end;


function NestSortCompareInner(Item1, Item2: TNest): Integer;
var abst:integer;
begin
{ if result=0 then
 if not TNest(Item1).AlignTop then
  result:=TNest(Item1).parent.IndexOf(Item1)-TNest(Item1).parent.IndexOf(Item2);
 }
 result:=-Integer(Item1.Align=alTop)--Integer(Item2.Align=alTop);
 if (result=0) and (Item1.Align in [alTop,alNone]) then
 begin
 abst:=Item1.bo.Top-Item2.bo.Top;
 if Item1.Align=alTop then
  result:=abst else
 if (Item1.Align=alNone) and not Item1.IsPopupMenu and not Item2.IsPopupMenu then
 if (abst>0) and (Item2.bo.Height<=abst) or (abst<0) and (Item1.bo.Height<=-abst) then
  result:=abst else
 begin
 abst:=Item1.bo.Left-Item2.bo.Left;
 if (abst>0) and (Item2.bo.Width<abst) or (abst<0) and (Item1.bo.Width<-abst) then
  result:=abst;
 end;
 end;
end;

function NestSortCompare(Item1, Item2: TNest): Integer;
begin

{ result:=NestSortCompareInner(Item1,Item2);
 if result=0 then
  result:=Item1.InnerPos-Item2.InnerPos;}
 result:=Item1.InnerPos-Item2.InnerPos;
 if result=0 then
  result:=NestSortCompareInner(Item1,Item2);

{ if result=0 then
 if not TNest(Item1).AlignTop then
  result:=TNest(Item1).parent.IndexOf(Item1)-TNest(Item1).parent.IndexOf(Item2);
 }
// if result=0 then
//  result:=Item1.Pos-Item2.Pos{Item1.parent.IndexOf(Item1)-Item1.parent.IndexOf(Item2)};
end;


procedure ConvertDFM(var PureFileName:string; {var PureFileName:string; }const Content:string);

procedure SetGln(nest:TNest);
var i:integer;
begin
 gln.AddObject(nest.id,nest);
 for i:=nest.Count-1 downto 0 do
  SetGln(nest[i]);
end;

procedure Shift(_nest:TNest);
var nest,pnest:tnest;
    i,ii:integer;
begin
 for i:=_nest.Count-1 downto 0 do
 //for i:=0 to gln.Count-1 do
 begin
 //nest:=TNest(gln.Objects[i]);
 nest:=_nest[i];
 if (nest.insertloc<>'') and (nest.insertloc<>'#head') then
 begin
  pnest:=nest;
  if (nest.insertloc='#body') then
  begin
{  pnest:=nest.parentTS;
  while pnest.parentTS<>nil do
   pnest:=pnest.parentTS;   }
  while not pnest.IsBody or (pnest.parent<>nil) and (pnest.parent.parent<>nil) do
   pnest:=pnest.parent;
  end else
  begin
   ii:=gln.IndexOf(nest.insertloc);
   if ii=-1 then continue;
   pnest:=tnest(gln.Objects[ii]);
  end;
  nest.parent.Remove(nest);
  pnest.Add(nest);
  nest.parent:=pnest;
  nest.insertloc:='';
 end;
 Shift(nest);
 end;
end;

procedure SetPure(nest:TNest);
var i,ii:integer;
    pnest,nesti,nestii:tnest;
    InnerPos,LastFree:integer;
    bin:TBinList;

begin
 if nest.IsPC then
 begin
  nest.PureFileName:=nest.id;
  if nest.HasProp('IsPHP') then
   nest.PureFileName:=nest.PureFileName+'.php' else
   nest.PureFileName:=nest.PureFileName+'.html';
  if nest.IsSel and (nest.parentTS<>nil) then
   nest.PureFileName:=nest.parentTS.PureFileName{ else
  if (nest.parentTS=nil) and (nest.Count=1) and (TNest(nest[0]).dclass='TdhPage') then
   nest.PureFileName:=TNest(nest[0]).id};
 end;

 nest.Anchors:=nest.OriAnchors;


 if (nest.parentTS<>nil) and (nest.RealParent<>nil) then
 begin
  nest.Anchors:=GetSimplifiedAnchors(nest.Anchors,nest.RealParent.Anchors,nest.HasStyleProp('NeedRight'),nest.RealParent.RuntimeVariableHeight or nest.HasStyleProp('NeedBottom'));
 end;

 {if (nest.Anchors*[akLeft,akRight]=[akLeft,akRight]) and nest.img then
  exclude(nest.Anchors,akRight);
 if (nest.Anchors*[akTop,akBottom]=[akTop,akBottom]) and nest.img then
  exclude(nest.Anchors,akBottom);}

 for i:=nest.Count-1 downto 0 do
  SetPure(nest[i]);

 if nest.Count<>0 then
  TNest(nest[0]).InnerPos:=0;
 InnerPos:=1;
 LastFree:=0;
 for i:=0 to nest.Count-1 do
 begin
  nesti:=nest[i];
  if nesti.Align=alTop then continue; // InnerPos=0
  for ii:=i-1 downto LastFree do
  begin
   nestii:=TNest(nest[ii]);
   if NestSortCompareInner(nestii,nesti)=0 then
   begin
    LastFree:=i;
    inc(InnerPos);
    break;
   end;
  end;
  nesti.InnerPos:=InnerPos;
 end;
 nest.Sort(TListSortCompare(@NestSortCompare));

{ bin:=TBinList.Create;
 //nest.Sort(TListSortCompare(@NestSortCompare));
// for i:=0 to nest.Count-1 do
 for i:=nest.Count-1 downto 0 do
  bin.AddItem(TListSortCompare(@NestSortCompare),TNest(nest[i]));
 nest.Clear;
 nest.Assign(bin);
 bin.Free;
 }
end;

procedure SetUse;
var nest,unest,pnest:TNest;
    i,w:integer;
begin
   for i:=0 to gln.Count-1 do
   begin
    nest:=TNest(gln.Objects[i]);
    if nest.sUse<>'' then
     Nest.Use:=TNest(gln.Objects[gln.IndexOf(nest.sUse)]);
   end;
end;

procedure FlattenStyle;
var nest:TNest;
    i:integer;

function ApplyTemplate_get_style(const sty:string): string;

function GetInheritedVal(name:string; nest:TNest):String;
begin
 while (nest<>nil) do
 if nest.HasProp(name,result) then
  exit else
  nest:=nest.Use;
 result:='';
end;

procedure AddStyle(const Name,Value:string);
begin
 result:=result+Name+':'+Value+';'+IndentSpace;
end;


function HasProp(const PropName:string; var s:string):boolean; overload;
begin
 s:=GetInheritedVal(PropName,nest);
 result:=s<>'';
end;

var s:string;
begin
  result:='';
  if HasProp(sty+'Cursor',s) then AddStyle('cursor',GetHyphens(s));
  if HasProp(sty+'Display',s) then AddStyle('display',GetHyphens(s));
  if HasProp(sty+'Visibility',s) then AddStyle('visibility',GetHyphens(s));
  if HasProp(sty+'ZIndex',s) then AddStyle('z-index',s);
end;

begin
   for i:=0 to gln.Count-1 do
   begin
    nest:=TNest(gln.Objects[i]);
    if EnableIgnoreCSS and nest.HasProp('TheoreticRastering') then
    begin
     nest.FlattenedStyle[hsNormal]:=ApplyTemplate_get_style('Style.');
     nest.FlattenedStyle[hsDown]:=ApplyTemplate_get_style('StyleDown.');
     nest.FlattenedStyle[hsOver]:=ApplyTemplate_get_style('StyleOver.');
     nest.FlattenedStyle[hsOverDown]:=ApplyTemplate_get_style('StyleOverDown.');
   end;
   end;
end;


procedure UnsetUse;
var nest,unest,pnest:TNest;
    i,w:integer;
begin
   for i:=0 to gln.Count-1 do
   begin
    nest:=TNest(gln.Objects[i]);
    if EnableIgnoreCSS and nest.HasProp('TheoreticRastering') then
      Nest.Use:=nil;
   end;
end;

procedure MenusAndLinks;
var nest:TNest;
    i,w:integer;
    s,ParentMenuItem:string;

function GetAuto(name,val:string; nest:TNest):TNest;
begin
 result:=nest;
 while (nest<>nil) and not nest.contains(name,val) do
 begin
  nest:=nest.Use;
  if (nest<>nil) and (nest.dclass=result.dclass) then
   result:=nest;
 end;
end;

begin
  for i:=0 to gln.Count-1 do
  begin
   nest:=TNest(gln.Objects[i]);
   //nest.img:=(GetInheritedVal('ImageType',nest)='bitImage') and not ((nest.dclass='TdhPage') or (nest.dclass='TdhMemo') or (nest.dclass='TdhEdit'){ or (nest.dclass='TdhListBox')});
   if (nest.dclass='TdhLink') then
   begin
    nest.DownOverlayOver:=(GetAuto('','',nest)<>nil) and GetAuto('','',nest).IsProp('PreferDownStyles','True');
    nest.auto:=GetAuto('Options','loNoAuto',nest);
    if not nest.auto.contains('Options','loDownIfMouseDown') then
     nest.AddAttr('notifmouse','true');
 {   if nest.auto.contains('Options','loNoOverIfDown') then
     AddAttr('noover','true');  }
    if not nest.auto.contains('Options','loDownIfMenu') then
     nest.AddAttr('notifmenu','true');
    if nest.auto.contains('Options','loDownIfOver') then
     nest.AddAttr('ifover','true');
   end;
   if (nest.dclass='TdhMenu') then
   begin
    nest.auto:=GetAuto('MenuOptions','moNoAuto',nest);

    if nest.HasProp('RealMenuTop',s) then
     nest.AddAttr('menutop',s);
    if nest.HasProp('RealMenuLeft',s) then
     nest.AddAttr('menuleft',s);
    if nest.parent.dclass='TdhLink' then
    begin
     ParentMenuItem:=nest.parent.id;
     nest.parent.menu:=nest;
    end else
     ParentMenuItem:='';
    
   if (ParentMenuItem<>''){ and nest.auto.contains('MenuOptions','Static')} then
    nest.ParentMenuItem:=ParentMenuItem;

    //if not nest.auto.contains('MenuOptions','Static') then
    begin
    {if nest.auto.contains('MenuOptions','ClickToOpen') then
     nest.AddAttr('clicktoopen','true');
    if nest.HasProp('padw',s) then
     nest.AddAttr('padw',s);
    if nest.HasProp('OnlyIf') then
     nest.AddAttr('onlybyurl','true');
    if nest.auto.HasProp('SlidePixel',s) then
     nest.AddAttr('slidepixel',s);
    if nest.auto.HasProp('ReactionTime',s) and (nest.ParentMenuItem<>'') then
     nest.AddAttr('reactiontime',s);
    //if contains('MenuOptions','Slide') then
    if nest.auto.contains('MenuOptions','ResumeOpen') then
     nest.AddAttr('resumeopen','true');}

    end{ else
    snest.OnlyIf:=snest.parentTS.id};

    //nach doele:


   nest.HasProp('AlPos',nest.bo.Top);

   if not nest.auto.contains('MenuOptions','Inline') and (ParentMenuItem<>'') then
   begin
    nest.insertloc:='#body';
    nest.IsPopupMenu:=true;
//    nest.RenderIn:=nest.parentTS.ID;
   end;
   if nest.auto.contains('MenuOptions','Inline') and (ParentMenuItem<>'') then
   begin
    nest.insertloc:=nest.parent.parent.id;
    nest.IsInlineMenu:=true;
//    nest.RenderIn:=nest.parentTS.ID;
   end;
   end;
  end;

end;



procedure Ranking;
var nest,unest,pnest:TNest;
    i,w:integer;
var vn,itag,r,von,itagbs:integer;
    Closing,EmptyEle:boolean;
    tag,text,attributes,s,clean_s,res,addimg:string;
    newtag:string;
    Aligns:set of TAlign;
    MinWidth:integer;
    wihe,HTMLAttributes:string;

begin
   for i:=0 to gln.Count-1 do
   begin
    nest:=TNest(gln.Objects[i]);
    while (nest.Use<>nil) and not nest.Use.StyleStored do
     nest.Use:=nest.Use.Use;
   end;

   for i:=0 to gln.Count-1 do
   begin
    nest:=TNest(gln.Objects[i]).Use;
    while (nest<>nil) do
    begin
     inc(nest.Refs);
     nest:=nest.Use;
    end;
   end;    
   for i:=0 to gln.Count-1 do
   begin
    pnest:=TNest(gln.Objects[i]);
    nest:=pnest;
    while (nest<>nil) do
    begin
     if (nest.Props<>nil) and nest.HasProp('HTMLAttributes',HTMLAttributes) then
     begin
      if HTMLAttributes[1]<>' ' then
       HTMLAttributes:=' '+HTMLAttributes;
      pnest.attributes:=pnest.attributes+HTMLAttributes;
     end;

     nest:=nest.Use;
    end;
   end;

   for i:=0 to gln.Count-1 do
   begin
    pnest:=TNest(gln.Objects[i]);
    nest:=pnest;
    while (nest<>nil) do
    begin
     if nest.img then
     begin  
        pnest.AutoY:=false;
        pnest.AutoX:=false;
        //pnest.Characters:='';
        pnest.properties:=pnest.properties+'overflow:hidden;'+IndentSpace;
        //pnest.properties:=pnest.properties+'padding:0px;'+IndentSpace;
        break;
     end;
     (*
     if nest.img<>'' then
     begin
      addimg:=' src="'+nest.img+'" alt=""';
      r:=0;
      if not ({bAdvPos(r,'type="submit"',pnest.attributes) or }(pnest.tag='div')) then
      begin
       if pnest.tag='input' then
        pnest.tag:='button';
       wihe:='';
       if not (pnest.AutoX and pnest.AutoY) then
        wihe:=';'+IndentSpace+'width:'+inttostr(pnest.Client.Right)+'px;'+IndentSpace+'height:'+inttostr(pnest.Client.Bottom)+'px';
       pnest.Characters:='<img'+addimg+' style="border:0px'+wihe+'"'+'/>';
       pnest.CloneCharacters:=true;
       pnest.AutoY:=true;
       pnest.AutoX:=true;
      end else
      begin
       pnest.Characters:='';
       if r=0 then
        pnest.tag:='img' else
        pnest.attributes:=CopyInsert(pnest.attributes,r,r+length('type="submit"'),'type="image"');
       pnest.attributes:=pnest.attributes+addimg;
       if not (pnest.AutoX and pnest.AutoY) then
       begin
        pnest.AutoY:=false;
        pnest.AutoX:=false;
       end;
      end;
      break;
     end;
     *)
     nest:=nest.Use;
    end;
   end;


   for i:=0 to gln.Count-1 do
   begin
    pnest:=TNest(gln.Objects[i]);
    if not pnest.NeedParentColor then continue;
    nest:=pnest;
    while (nest<>nil) do
    begin
     if nest.bgColor<>'' then
     begin
      pnest.bgColor:=nest.bgColor;
      break;
     end;
     nest:=nest.Use;
    end;
    nest:=pnest;
    while (nest<>nil) do
    begin
     if nest.bgColor<>'' then
     begin
      pnest.bgColor:=nest.bgColor;
      break;
     end;
     nest:=nest.parent;
    end;
    if pnest.bgColor<>'' then
     pnest.properties:=pnest.properties+'background-color:'+pnest.bgColor+';'+IndentSpace;
   end;

   for i:=0 to gln.Count-1 do
   begin
    nest:=TNest(gln.Objects[i]);
    FinalCharacters(nest,nil);
   end;

   for i:=0 to gln.Count-1 do
   begin
    nest:=TNest(gln.Objects[i]);
    pnest:=nest;
    MinWidth:=nest.MinWidth;
    if MinWidth<>0 then
    while (pnest.parent<>nil) and not pnest.parent.IsBody and pnest.AutoX and (pnest.Align=alTop) do
    begin
     pnest:=pnest.parent;
     inc(MinWidth,pnest.borders.X);
    end;
    if (pnest<>nil) and (pnest<>nest) then
    begin
     if (pnest.MinWidth<MinWidth) and pnest.AutoX then
      pnest.MinWidth:=MinWidth;
     nest.MinWidth:=0;
    end;
      {
    repeat
     if not (pnest.AutoX and (pnest.Align=alTop)) then
      break;
     pnest:=pnest.parent;
     if (pnest=nil) or not pnest.AutoX then break;
     if pnest.MinWidth>=nest.MinWidth then
     begin
      if pnest.MinWidth>nest.MinWidth then
       nest.MinWidth:=0;
      break;
     end else
      pnest.MinWidth:=nest.MinWidth;
    until false;    }
   end;

   (*
   for i:=0 to gln.Count-1 do
   begin
    nest:=TNest(gln.Objects[i]);
    {Aligns:=[];
    if not nest.AutoX then continue;
    for w:=0 to nest.Count-1 do
     Aligns:=Aligns+[TNest(nest[w]).Align];
    if Aligns*[alTop,alNone]=[alTop,alNone] then }
    if nest.Align=alTop then
     nest.properties:='width:100%;'+IndentSpace+nest.properties;
   end;*)
end;


begin

   //StringToFile({SaveDir+PureFileName+'.xml'}'c:\t.txt',Content);{!!}

   docg.init(Content);
//   QueryPerformanceCounter(Int64((@c1)^));
   TransNode(nil);
//   QueryPerformanceCounter(Int64((@c2)^));

   gln:=TMyStringList.Create;
//   gln.CaseSensitive:=true;

   SetGln(gnest);
   gln.Sorted:=true;
   SetUse;
   MenusAndLinks;
   FlattenStyle;
   UnsetUse;

   Shift(gnest);

   SetPure(gnest);
   if gnest.Count>=1 then
    PureFileName:=TNest(gnest[0]).PureFileName;
   Ranking;
   {PureFileName:=}SaveNested(gnest);
   FreeAndNil(gln);
{   FreeAndNil(glMainIDs);
   FreeAndNil(GrobList);}
   FreeAndNil(gnest);
end;
{
procedure DoConvert(const PureFileName,FileName:string);
var Content:string;
begin
   FormName:=PureFileName;
   Content:=GetXMLFile(FileName,'');
   ConvertDFM(Content);
end;
}

function DoConvertContent(var PureFileName:string; const _Content:string):string;
var Content:string;
begin
//   FormName:=PureFileName;
   Content:=GetXMLContent(_Content,'');
   {result:=}ConvertDFM(PureFileName,Content);
end;

procedure EndConverting;
begin
 
  FreeAndNil(WrittenPages);
  FreeAndNil(WrittenObjs);
  FreeAndNil(Warnings);
end;

{procedure AddRule2(const cl,stylebody:string);
begin
 glMainIDs2.Add(cl);
 glStyleBodys2.Add(stylebody);
end;
 }

function tnest.IsDyn: boolean;
begin
 result:=(dclass='TdhLink') or (dclass='TdhFormButton');
end;




function tnest.IsRastered(SemiTransparent: boolean): boolean;
var s:string;
const sty:string='Style.';
begin
 result:=HasProp(sty+'Rastering',s) or HasProp(sty+'BGRastering',s);
 if not Result and not SemiTransparent then
  result:=HasProp('TheoreticRastering') or HasProp('TheoreticRasteringBG') else
 if result and SemiTransparent then
 begin
  AdjustAlternativeRastering(TopPC,id,s);
  result:=SubEqualEnd('.png',s);
 end;
end;

function tnest.HorizontalCenter:boolean;
begin
  result:=Anchors*[akLeft,akRight]=[];
end;

function tnest.PngToChild:boolean;
begin
 result:=(Count<>0);
end;

function tnest.MenuIsVisible:boolean;
begin
 result:=false;
 if IsInlineMenu then
  result:=(ParentMenuItem<>'') and tnest(gln.Objects[gln.IndexOf(ParentMenuItem)]).IsDown;
end;

function tnest.MenuIsStatic:boolean;
begin
 result:=false;
 if IsInlineMenu then
  result:=(ParentMenuItem<>'') and (tnest(gln.Objects[gln.IndexOf(ParentMenuItem)]).LinkPage<>'');
end;

initialization

 RegisterClasses([//TMyPageControl,TTabControl,TTabSheet,//TBevel,TNotebook,TMaskEdit,
                  TdhFile,TdhSelect,TdhOleContainer,TdhFormButton,TdhHTMLForm,TdhStyleSheet,TdhLabel,TdhPanel,TdhLink,TdhMenu,TdhPageControl,TdhDirectHTML,
                  TdhRadioButton,TdhCheckBox,TdhPage,TdhEdit,TdhMemo,TdhFileField,TdhHiddenField,
                  TPageControl,TImage,TEdit,TComboBox,TMemo,TSpeedButton,TPanel,TFrame,
                  TCheckBox,TButton,TRadioButton,TLabel,TGroupBox{$IFNDEF CLX},TGifImage,TJPEGImage{$ENDIF}{,TPNGImage}]);


(*glMainIDs2:=TMyStringList.Create;
glStyleBodys2:=TMyStringList.Create;

//AddRule2('forlabel','vertical-align:middle; margin-left:-1px');

//background-color:inherit; background-color:expression(parentNode.style.backgroundColor);
//AddRule2('gbox','');
AddRule2('gbox1','position:absolute; left:0px; top:0.5em; bottom:0px; right:0px; border:1px solid; border-color:#FFFFFF; margin-top:1px; margin-left:1px; width:expression(parentNode.offsetWidth-1); height:expression(parentNode.offsetHeight-offsetTop-0); '+'voice-family:"\"}\""; voice-family:inherit; width:expression(parentNode.offsetWidth-3); height:expression(parentNode.offsetHeight-offsetTop-2);');
AddRule2('gbox2','position:absolute; left:0px; top:0.5em; bottom:0px; right:0px; border:1px solid; border-color:#808080; margin-right:1px; margin-bottom:1px; width:expression(parentNode.offsetWidth-1); height:expression(parentNode.offsetHeight-offsetTop-1); '+'voice-family:"\"}\""; voice-family:inherit; width:expression(parentNode.offsetWidth-3); height:expression(parentNode.offsetHeight-offsetTop-3);');
{AddRule2('gbox1','position:absolute; left:1px; top:6px; border:1px solid; border-color:#FFFFFF');
AddRule2('gbox2','position:absolute; left:0px; top:5px; border:1px solid; border-color:#808080');
}
AddRule2('gbox3','position:absolute; top:0px; left:8px');

//AddRule2('nowr','white-space:nowrap');
AddRule2('tcheckbox','position:relative; left:-3px; vertical-align:middle');
AddRule2('tpagecontrol','border:1px White Solid; border-right:2px #BBBBBB Ridge; border-bottom:2px #BBBBBB Ridge; padding:3px 2px 2px 3px');
{AddRule2('tpanel','background-color:ButtonFace; ');
AddRule2('tpanel2','background-color:inherit; background-color:expression(parentNode.style.backgroundColor);');
AddRule2('tpanelborder','z-index:-10; border:1px solid; border-color:#FFFFFF #808080 #808080 #FFFFFF; position:absolute; top:0px; left:0px; bottom:0px; right:0px; width:expression(parentNode.offsetWidth-0); height:expression(parentNode.offsetHeight-0); '+'voice-family:"\"}\""; voice-family:inherit; width:expression(parentNode.offsetWidth-2); height:expression(parentNode.offsetHeight-2);');
}
//AddRule2('tpanelborder2','border:1px solid; border-color:#808080 #FFFFFF #FFFFFF #808080');

//AddRule2('tradiobox','position:relative; left:-3px; vertical-align:middle; top:-1px');
AddRule2('tspeedbutton','white-space:normal');
glMainIDs2.SetAssumedSorted;

*)
 DFMs:=TStringList.Create;

Finalization

 FreeAndNil(DFMs);
                       
// glMainIDs2.Free;
// glStyleBodys2.Free;

end.
