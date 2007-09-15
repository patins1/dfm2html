unit uSearchStr;

interface

uses FastStringFuncs,UseFastStrings;

const DomCommentTagName='!';

const valfirstpas=['_','a'..'z','A'..'Z'];
      valsecpas=['0'..'9'] + valfirstpas;

type
 tcharset=set of char;

 tg=object
    private
    g_s:String;
    g_i,g_w:Integer;
    public

    function getZahl: boolean;
    function getBckZahl: boolean;
    function PasPos(const f:String):boolean;
    function OverPasPos(const f:String):boolean;
    function OverPasPosTil(const f:String; bis:integer):boolean;
    function getPasID:boolean;
    function getBckPasID:boolean;
    function isPas:boolean;
    procedure unload;
    function OverPasWithin(const f:String):boolean;

  {  function OverPasPos(const f:String):boolean;
    function OverPasPosTil(const f:String; bis:integer):boolean;
    function getPasID:boolean;
    function isPas:boolean;
         }
    function FindTag(NotSkipHtml:boolean):boolean;
    function getName:boolean; overload;
    function getName(const ValFirst,ValSec:tcharset):boolean; overload;
    function saveS(var s:String):boolean;
    function getSecName:boolean;
    function isSecName:boolean;
    function overShit:boolean;
    function backShit:boolean;
    function getPos(var i:integer):boolean; overload;
    function getPos(var i:integer; delta:integer):boolean; overload;
    function SetPos(i:integer=1):boolean;
    function SetBackPos(i:integer):boolean;
    function init(const s:string; i:integer=1):boolean;
    function Copy:string;
    function CopyFrom(bck:integer):string;
//    function CopyTrim:string;
    function Text:string;
//    function TextTrim:string;
    function geti(var i:integer):boolean; overload;
    function geti(var i:int64):boolean; overload;
    function zeige(delta:integer=0):string;
    function StartsWith(const f:String):boolean;
    function Over(const f:String):boolean;
    function IOver(const f:String):boolean;
    function Within(const f:String):boolean;
    function WithinPos(const f:String):boolean;
    function OverPos(const f:String):boolean;
    function OverPosNoCase(const f:String):boolean;
    function OverPosTil(const f:String; bis:integer):boolean;
    function Pos(const f:String):boolean;
    function PosBck(const f:String):boolean;
    function OverPosBck(const f:String):boolean;
    function PosNoCase(const f:String):boolean;
    function SaveOverPos(const f:string; var s:string): boolean;
    function SaveOverPosNoCase(const f:string; var s:string): boolean;
    function SaveOverPosTrim(const f:string; var s:string): boolean;
{    function relPos(const f:String; jump_over:boolean=false):boolean;
    function absPos(const f:String; jump_over:boolean=false):boolean;
}    function forw(const f:char='<'):boolean;
    function backw(const f:String='>'; jump_over:boolean=false):boolean;
    function getBasis:integer;
    function relMove(r:integer):boolean;
    function mislegit(c:char; var i:integer):boolean;
    function mislegitf(c:char):boolean;
    function getRel:integer;
    function LastChar:Char;
    function Char:Char;
    function RelChar(r:integer):Char;
    function Inside:boolean;
    function SetBack:boolean;
    function MoveToEnd:boolean;
    function GetEnd:integer;
    function FindSet(const st:tcharset):boolean;
    function isStringSl(const st:tcharset):boolean; overload;
    function isStringSl(ch:Char):boolean; overload;
    function isStringTag(const st:tcharset):boolean; overload;
    function isStringTag(ch:Char):boolean; overload;
    function FindTagEnding:boolean;
    function FindTagEnding_NotSkipHtml:boolean;
    function FindTagOpening:boolean;
    function HasTagName(var MyTagName:string; var ClosingTag:boolean; noClosing:boolean):boolean;
    function ActBack:boolean;

    function OverTag:boolean;
    function JumpOut:boolean;
    function OverJump:boolean;
    function Bordered(const s:string=''):string;

    property Point:integer read g_i write g_i;
    property Back:integer read g_w write g_w;
    property ReferencedString :string read g_s;

    function SameText(const s:String):boolean;
    function EqualText(const s:String):boolean;
    function Behind(const s:String; delta:integer=0):boolean;


    procedure FixDerivingBug;

  end;

function getName(const s:string; i:integer):integer;


implementation
uses math, sysutils,htmlrout{,funcutils};

const valsec=['_','-','.',':'] + valfirst;

const _valfirst=['a'..'z','A'..'Z','0'..'9'];
      _valsec=['_','-','.'] + _valfirst;


procedure tg.FixDerivingBug;
begin
 pinteger(@g_s)^:=0;
end;

function tg.isStringSl(ch:Char):boolean;
var i,w:integer;
begin
 i:=g_i;
 w:=g_w;
 if Over(ch) then
 begin
 result:=true;
 repeat
  if not OverPos(ch) then
  begin
   result:=false;
   break;
  end;
 until RelChar(-2)<>'\';
 end else
  result:=false;
 if not Result then
 begin
  g_i:=i;
  g_w:=w;
 end;
{
 begin
  dec(g_w);
  result:=true;
 end;
 result:=Inside;
 end else
 begin
  dec(g_w);
  dec(g_i);
 end;
}
end;

function tg.isStringSl(const st:tcharset):boolean;
begin
 if Char in st then
  result:=isStringSl(Char) else
  result:=false;
end;

function tg.isStringTag(ch:Char):boolean;
var i,w:integer;
begin
 i:=g_i;
 w:=g_w;
 if Over(ch) then
 begin
  result:=true;
  if not OverPos(ch) then
   result:=false{ else
  if AdvPosTil(i1,c_cl,g_s,g_w,g_i-1) then
   g_i:=i1};
 end else
  result:=false;
 if not Result then
 begin
  g_i:=i;
  g_w:=w;
 end;
{
 begin
  dec(g_w);
  result:=true;
 end;
 result:=Inside;
 end else
 begin
  dec(g_w);
  dec(g_i);
 end;
}
end;

{
function tg.isStringTag(ch:Char):boolean;
var i,w:integer;
begin
 i:=g_i;
 w:=g_w;
 if Over(ch) then
 begin
 result:=true;
 repeat
  if not OverPos(ch) then
  begin
   result:=false;
   break;
  end;
 until true;
 end else
  result:=false;
 if not Result then
 begin
  g_i:=i;
  g_w:=w;
 end;
end;
}

function tg.isStringTag(const st:tcharset):boolean;
begin
 if Char in st then
  result:=isStringTag(Char) else
  result:=false;
end;



function tg.getPos(var i:integer):boolean;
begin
 i:=g_i;
 result:=true;
end;

function tg.getPos(var i:integer; delta:integer):boolean;
begin
 i:=g_i+delta;
 result:=true;
end;

function tg.SetPos(i:integer):boolean;
begin
 result:=i<=length(g_s);
 if result then
  g_i:=i;
end;

function tg.SetBackPos(i:integer):boolean;
begin
 result:=i<=length(g_s);
 if result then
  g_w:=i;
end;

function tg.init(const s:string; i:integer=1):boolean;
begin
 g_s:=s;
 g_i:=i;
 result:=i<=length(s);
end;

function tg.FindTagEnding:boolean;
begin
 g_w:=g_i;
 g_i:=htmlrout.FindTagEnding(g_s,g_i);
 result:=g_i<>0;
// result:=g_s[g_i-1]=c_cl;
end;

function tg.FindTagEnding_NotSkipHtml:boolean;
begin
 g_w:=g_i;
 g_i:=htmlrout.FindTagEnding_NotSkipHtml(g_s,g_i);
 result:=g_i<>0;
// result:=g_s[g_i-1]=c_cl;
end;

function tg.FindTag(NotSkipHtml:boolean):boolean;
begin
 if NotSkipHtml then
  result:=FindTagOpening and FindTagEnding_NotSkipHtml else
  result:=FindTagOpening and FindTagEnding;
end;

function tg.FindTagOpening:boolean;
begin
 g_i:=htmlrout.FindTagOpening(g_s,g_i);
 result:=g_i<>0;
// result:=g_i<=length(g_s);
end;

function tg.OverTag:boolean;
begin
 g_w:=g_i;
 g_i:=htmlrout.overTag(g_s,g_i);
// result:={g_i<=length(g_s)+1}g_s[g_i-1]=c_cl;
 result:=g_i<>0;
end;


function tg.JumpOut:boolean;
begin
  g_i:=htmlrout.overTag(g_s,g_i);
  result:=g_i<>0;
//  result:=overShit;
end;

function tg.overShit:boolean;
begin
 while {$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in likespace)do
  inc(g_i);
 result:=g_i<=length(g_s)+1;  
 if g_i=maxint then zeige;
end;


function tg.backShit:boolean;
begin
 g_i:=SkipBckWhiteSpaces(g_s,g_i);
 result:=g_i<=length(g_s)+1;
end;


function tg.getSecName:boolean;
begin
 g_w:=g_i;
 result:={$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in _valfirst);
 if result then
  while {$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in _valsec) do
   inc(g_i);
end;

function tg.isSecName:boolean;
begin
 result:=not ((g_w>=2) and (g_s[g_w-1] in _valfirst)) and
         not({$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in _valsec));
end;

function tg.OverJump:boolean;
begin
 while {$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in (likespace+['<'])) do
  if g_s[g_i]='<' then
   g_i:=htmlrout.overTag(g_s,g_i) else
   inc(g_i);
//  g_w:=g_i;
 result:=g_i<=length(g_s)+1;
end;

function tg.getBasis:integer;
begin
 result:=min(g_i,g_w);
end;

function tg.getRel:integer;
begin
 result:=abs(g_w-g_i);
end;


{function tg.CopyTrim:string;
begin
 result:=trim(CopyStr(g_s,g_w,g_i-g_w));
end;
}
function tg.Copy:string;
begin
 result:=CopyStr(g_s,g_w,g_i-g_w);
end;

function tg.CopyFrom(bck:integer):string;
begin
 result:=AbsCopy(g_s,bck,g_i);
end;

{function tg.TextTrim:string;
begin
 result:=trim(CopyStr(g_s,getBasis,getRel));
end;
}
function tg.Text:string;
begin
 result:=CopyStr(g_s,getBasis,getRel);
end;

function tg.saveS(var s:string):boolean;
begin
 s:=CopyStr(g_s,getBasis,getRel);
 result:=true;
end;

function tg.geti(var i:int64):boolean;
var s:string;
begin
 s:=trim(Text);
 try
  i:=StrToInt64(s);
  result:=true;
 except
  result:=false;
 end;
end;

function tg.geti(var i:integer):boolean;
var s:string;
begin
 s:=trim(Text);
 try
  i:=strtoint(s);
  result:=true;
 except
  result:=false;
 end;
end;

function tg.zeige(delta:integer=0):string;
begin
 result:=CopyStr(g_s,g_i+delta,1000);
end;

function tg.Within(const f:String):boolean;
var i:integer;
begin
 i:=AdvPosTil(f,g_s,g_w,g_i);
 result:=i>0;
 if result then
 begin
  g_i:=i;
{  if jump_over then
   inc(g_i,length(f));
} end;
end;

function tg.WithinPos(const f:String):boolean;
begin
 result:=AdvPosTil(f,g_s,g_w,g_i)<>0;
end;


{function SubEqual(const Substr,s:string; i:integer=1):boolean;
begin
 try
 result:=CopyStr(s,i,length(Substr))=Substr;
 except
 result:=CopyStr(s,i,length(Substr))=Substr;//!!
 end;
end;
}
function tg.StartsWith(const f:String):boolean;
begin
 result:=SubEqual(f,g_s,g_i);
end;

function tg.IOver(const f:String):boolean;
begin
 result:=SubSame(f,g_s,g_i);
 if result then
 begin
  g_w:=g_i;
  inc(g_i,length(f));
 end;
end;

function tg.Over(const f:String):boolean;
begin
 result:=SubEqual(f,g_s,g_i);
 if result then
 begin
  g_w:=g_i;
  inc(g_i,length(f));
 end;
end;


function tg.OverPos(const f:String):boolean;
begin
 g_w:=g_i;
 g_i:=AdvPos(f,g_s,g_i);
 result:=g_i<>0;
 if not result then
  g_i:=g_w else
  inc(g_i,length(f));
end;

function tg.OverPosNoCase(const f:String):boolean;
begin
 g_w:=g_i;
 g_i:=AdvPosNoCase(f,g_s,g_i);
 result:=g_i<>0;
 if not result then
  g_i:=g_w else
  inc(g_i,length(f));
end;


function tg.OverPosTil(const f:String; bis:integer):boolean;
begin
 g_w:=g_i;
 g_i:=AdvPosTil(f,g_s,g_i,bis);
 result:=g_i<>0;
 if not result then
  g_i:=g_w else
  inc(g_i,length(f));
end;

function tg.SaveOverPos(const f:string; var s:string): boolean;
begin
 result:=OverPos(f);
 if result then
  s:=CopyStr(g_s,g_w,g_i-g_w-length(f));
end;


function tg.SaveOverPosNoCase(const f:string; var s:string): boolean;
begin
 result:=OverPosNoCase(f);
 if result then
  s:=CopyStr(g_s,g_w,g_i-g_w-length(f));
end;

function tg.SaveOverPosTrim(const f:string; var s:string): boolean;
begin
 result:=SaveOverPos(f,s);
 if result then
  s:=Trim(s);
end;


function tg.Pos(const f:String):boolean;
begin
 g_w:=g_i;
 g_i:=AdvPos(f,g_s,g_i);
 result:=g_i<>0;
 if not result then
  g_i:=g_w;
end;

function tg.PosBck(const f:String):boolean;
begin
 g_w:=g_i;
 g_i:=AdvPosBack(f,g_s,g_i);
 result:=g_i<>0;
 if not result then
  g_i:=g_w;
end;

function tg.OverPosBck(const f:String):boolean;
begin
 g_w:=g_i;
 g_i:=AdvPosBack(f,g_s,g_i);
 result:=g_i<>0;
 if not result then
  g_i:=g_w else
  inc(g_i,length(f));
end;

function tg.PosNoCase(const f:String):boolean;
begin
 g_w:=g_i;
 g_i:=AdvPosNoCase(f,g_s,g_i);
 result:=g_i<>0;
 if not result then
  g_i:=g_w;
end;


{function tg.absPos(const f:String; jump_over:boolean=false):boolean;
begin
 g_i:=1;
 result:=relPos(f,jump_over);
end;
 }
function tg.mislegit(c:char; var i:integer):boolean;
begin
 i:=g_i;
 if g_s[g_i-1]=c then
  dec(g_i);
 result:=true;
end;

function tg.mislegitf(c:char):boolean;
begin
 if g_s[g_i]=c then
  inc(g_i);
 result:=true;
end;

function tg.relMove(r:integer):boolean;
begin
 inc(g_i,r);
 result:=g_i<=length(g_s);
end;

function tg.FindSet(const st:tcharset):boolean;
begin
 g_w:=g_i;
 while (g_i<=length(g_s)) and not (g_s[g_i] in st) do
  inc(g_i);
 result:=g_i<=length(g_s);
 if not result then
  g_i:=g_w;
end;

function tg.ActBack:boolean;
begin
 g_w:=g_i;
 result:=g_i<=length(g_s);
end;

function tg.forw(const f:char='<'):boolean;
begin
 g_w:=g_i;
 while (g_i<=length(g_s)) and (g_s[g_i]<>f) do
  inc(g_i);
 result:=g_i<=length(g_s);
end;

function tg.backw(const f:String='>'; jump_over:boolean=false):boolean;
begin
 g_w:=g_i;
 while (g_i>=1) and (CopyStr(g_s,g_i-length(f),length(f))<>f) do
  dec(g_i);
 result:=g_i>=1;
 if result and jump_over then
  dec(g_i,length(f));
end;

function tg.Inside:boolean;
begin
 result:=g_i<=length(g_s);
end;

function tg.GetEnd:integer;
begin
 result:=length(g_s)+1;
end;

function tg.MoveToEnd:boolean;
begin
 g_i:=GetEnd;
 result:=true;
// result:=g_i<=length(g_s);
end;


function tg.SetBack:boolean;
begin
 g_i:=g_w;
 result:=g_i<=length(g_s);
end;

function tg.SameText(const s:String):boolean;
begin
 result:=(length(s)=g_i-g_w) and SubSame(s,g_s,g_w);
end;

function tg.EqualText(const s:String):boolean;
begin
 result:=(length(s)=g_i-g_w) and SubEqual(s,g_s,g_w);
end;

function tg.Behind(const s:String; delta:integer=0):boolean;
begin
 result:=SubEqual(s,g_s,g_i+delta-length(s));
end;



function tg.RelChar(r:integer):Char;
begin
 result:=g_s[g_i+r];
end;

function tg.LastChar:Char;
begin
 result:=g_s[g_i-1];
end;

function tg.Char:Char;
begin
 result:=g_s[g_i];
end;


function getName(const s:string; i:integer):integer;
begin
 if {$IFOPT R+}(i<=length(s)) and {$ENDIF}(s[i] in valfirst) then
 repeat
  inc(i);
 until not ({$IFOPT R+}(i<=length(s)) and {$ENDIF}(s[i] in valsec));
 result:=i;
end;

function tg.getName:boolean;
begin
 g_w:=g_i;
 g_i:=uSearchStr.getName(g_s,g_i);;
 result:=g_i<>g_w;
{ result:=(g_i<=length(g_s)) and (g_s[g_i] in valfirst);
 if result then
  while (g_i<=length(g_s)) and (g_s[g_i] in valsec) do
   inc(g_i);
}end;


function tg.getName(const ValFirst,ValSec:tcharset):boolean;
begin
 g_w:=g_i;
 result:={$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in valfirst);
 if result then
 repeat
   inc(g_i);
 until not({$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in valsec));
{ result:=(g_i<=length(g_s)) and (g_s[g_i] in valfirst);
 if result then
  while (g_i<=length(g_s)) and (g_s[g_i] in valsec) do
   inc(g_i);
}end;

procedure RightEleName(var MyTagName:string);
var i:integer;
begin
  while bAdvPos(i,':',MyTagName) do
  if i=length(MyTagName) then
   delete(MyTagName,i,maxint) else
   delete(MyTagName,1,i);
end;



function tg.HasTagName(var MyTagName:string; var ClosingTag:boolean; noClosing:boolean):boolean;
var w,i:integer;
begin
 w:=g_w+1;
 ClosingTag:=g_s[w]='/';
 if ClosingTag then
 begin
  if noClosing then
  begin
   result:=False;
   exit;
  end;
  inc(w);
 end;
 i:=uSearchStr.getName(g_s,w);
 if i<>w then
 begin
  MyTagName:=CopyStr(g_s,w,i-w);
  RightEleName(MyTagName);
  result:=true;
 end else
 if (i=w) and {SubEqual('!--',g_s,w)}(g_s[w] in [DomCommentTagName,'?']) then
 begin
  MyTagName:=DomCommentTagName;
  result:=true;
 end else
  result:=false;
end;

(*
function tg.getPasID:boolean;
begin
// form1.Edit1.Text:='ADS';
 g_w:=g_i;
 result:={$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in valfirstpas);
 if result then
  while {$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in valsecpas) do
   inc(g_i);
end;

function tg.isPas:boolean;
begin
 result:=not ((g_w>=2) and (g_s[g_w-1] in valfirstpas)) and
         not({$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in valsecpas));
end;

function tg.OverPasPos(const f:String):boolean;
begin
 repeat
  result:=OverPos(f);
 until not result or SetBackPos(g_i-length(f)) and IsPas;
end;

function tg.OverPasPosTil(const f:String; bis:integer):boolean;
begin
 repeat
  result:=OverPosTil(f,bis);
 until not result or SetBackPos(g_i-length(f)) and IsPas;
end;

  *)

function tg.Bordered(const s:string=''):string;
begin
 result:=abscopy(g_s,1,g_w)+s+abscopy(g_s,g_i,maxint);
end;


procedure tg.unload;
begin
 g_s:='';
end;

function tg.getPasID:boolean;
begin
 g_w:=g_i;
 result:={$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in valfirstpas);
 if result then
 repeat
   inc(g_i);
 until not({$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in valsecpas));
end;

function tg.getBckPasID:boolean;
begin
 backShit;
 g_w:=g_i;
 while (g_w>=2) and (g_s[g_w-1] in valsecpas) do
  dec(g_w);
 result:=(g_i<>g_w) and (g_s[g_w] in valfirstpas);
end;

function tg.getBckZahl:boolean;
begin
 g_w:=g_i;
 while (g_w>=2) and (g_s[g_w-1] in ['0'..'9']) do
  dec(g_w);
 result:=g_i<>g_w;
end;

function tg.getZahl:boolean;
begin  
 g_w:=g_i;
 dec(g_i);
 repeat
   inc(g_i);
 until not({$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in ['0'..'9']));
 result:=g_i<>g_w;
end;

function tg.isPas:boolean;
begin
 result:=not ((g_w>=2) and (g_s[g_w-1] in valfirstpas)) and
         not({$IFOPT R+}(g_i<=length(g_s)) and {$ENDIF}(g_s[g_i] in valsecpas));
end;

function tg.OverPasPos(const f:String):boolean;
begin
 result:=OverPasPosTil(f,length(g_s)+1);
end;

function tg.PasPos(const f:String):boolean;
begin
 result:=OverPasPosTil(f,length(g_s)+1);
 if result then
  dec(g_i,length(f));
end;

function tg.OverPasPosTil(const f:String; bis:integer):boolean;
var si:integer;
begin
 si:=g_i;
 repeat
  result:=OverPosTil(f,bis);
 until not result or SetBackPos(g_i-length(f)) and IsPas;
 if not result then
  g_i:=si;
 g_w:=si;
end;

function tg.OverPasWithin(const f:String):boolean;
var si:integer;
begin
 si:=g_i;
 g_i:=g_w;
 result:=OverPasPosTil(f,si);
 if not result then
  g_i:=si;
end;



end.

//overload functions für char-parameter schreiben: overpos etc.
