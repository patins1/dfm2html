unit htmlrout;

interface

uses
 sysutils,FastStrings,FastStringFuncs,UseFastStrings;


const
      c_op='<';
      c_cl='>';
      c_end='/';// </..>
      space=' ';

const valfirst=['a'..'z','A'..'Z','0'..'9'];

const noValidFilenameChars=['\','/',':','*','?','"','<','>','|'{,' '}{space nich in url erlaubt}];

function overTag(const s:String;i:integer):integer;
function BeforeTagSimple(const s:String;i:integer):integer;
function CanBeforeTagSimple(const s:String;i:integer; var i_save:integer):boolean;

function SkipSpaces(const s:string;i:integer):integer; overload;
function SkipSpaces(const s:string;i,length_s:integer):integer; overload;
function SkipBckSpaces(const s:string;i:integer):integer;
function IsStartingCommentTag(const s:String;i:integer):boolean;

function SkipWhiteSpacesWithoutEndlAll(const s:string;i:integer):integer; overload;
function SkipWhiteSpacesWithoutEndlMain(const s:string;i:integer):integer; overload;
function SkipBckWhiteSpacesWithoutEndlAll(const s:string;i:integer):integer;
function SkipBckWhiteSpacesWithoutEndlMain(const s:string;i:integer):integer;
function SkipWhiteSpaces(const s:string;i:integer):integer; overload;
function SkipBckWhiteSpaces(const s:string;i:integer):integer;
function SkipWhiteSpacesSaveEndlAll(const s:string;i:integer; var lastline:integer):integer;
function SkipOnlySpaces(const s:string;i,length_s:integer):integer;
function SkipWhiteSpacesOnlyEndlAll(const s:string;i:integer):integer; overload;

function IsTagOpening(const s:String; i:Integer): boolean;
function FindTagOpening(const s:String; i:Integer): integer;
function FindTagEnding(const ls:String;i:integer):integer;
function FindTagEnding_NotSkipHtml(const ls:String;i:integer):integer;
function CanFindTagEnding(const ls:String;var i:integer):boolean;
function CanFindTagEnding_NotSkipHtml(const ls:String;var i:integer):boolean;

function NivelSpaces(const s:String): string;
function NivelLines(const s:String): string;
function CutWhiteSpace(const s:String): string;
function NivelWhiteSpaces(const s:String): string;
function ReduceWhiteSpace(const s:String): string;

function IsHTTP(const URL:string):boolean;
function IsFTP(const URL:string):boolean;
function IsLocal(const URL:string):boolean;
function IsQuery(const URL:string):boolean;
function IsMail(const URL:string):boolean;

function IsAbsoluteURL(const URL:string):boolean;
function ResolveRelativeURL(const base,rel:string): string;
function AdjustURLPure(const URL:string):String;
function ShortenURL(const URL:String):string;
function RightSlashes(const URI:string): string;
function WebSlashes(const URI:string): string;
function CalcPathDiff(fromURI,toURI:string; var newURI:string): boolean;
function ExtractUrlPath(const FileName: string): string;
function ExtractUrlFile(const FileName: string): string;
function CutURLParams(const URL: string): string;


function Same(const S1, S2: string): boolean;
function SameLo(const S1, S2: string): boolean;

procedure RightEleName(var MyTagName:string);
function getRightEleName(MyTagName:string):string;

function HtmlTag(const TagName:string; ClosingTag:boolean=false): string;    

function ValidWindowsFilename(const URL:String):String;
//function CachingName(s:String; const CachingDirectory:string; AddExt:boolean=true):String;

function IsExtHTML(const s:string):boolean;

//function GetProtHost(const URL:string; var res:string): boolean;


const textHttps='https://';
const textHttp='http://';
      textFile='file://';
      textFtp='ftp://';
      textMail='mailto:';
const textC='c:\';

const DefaultFile='index.html';

implementation



const javascript_URL_Separator=#1#1;
      textFileExt='file:///';

function HtmlTag(const TagName:string; ClosingTag:boolean=false): string;
begin
 if ClosingTag then
  result:='</'+TagName+'>' else
  result:='<'+TagName+'>';
end;



      {function overTag2(const s:String;i:integer):integer;
var pc:PChar;
begin
   while (i<=length(s)) and (s[i]<>c_cl) do
   begin
    if s[i]='"' then
    repeat
      inc(i);
    until not (i<=length(s)) or (s[i]='"');
    inc(i);
   end;
   if (i<=length(s)) then
    result:=i+1 else
    result:=i;
end;
 }
function overTag(const s:String;i:integer):integer;
var pc:PChar;
    ch:char;
begin
   try
   assert(s[i]=c_op);
   except
   assert(s[i]=c_op);
   end;
{   if not(s[i]=c_op) then
   pc:=@s[i+1] else
}
   pc:=@s[i+1];
   while not (pc^ in [c_cl,#0]) do
   begin
    if pc^='=' then
    begin
      inc(pc);
      while pc^ in likespace do
       inc(pc);
      if pc^ in ['''','"'] then
      begin
       ch:=pc^;
       inc(pc);
       while not(pc^ in [ch,#0]) do
        inc(pc);
       if pc^<>#0 then
        inc(pc);
      end;
    end else
     inc(pc);
{
    if pc^='"' then
    repeat
      inc(pc);
      if pc^=endl_main then
      begin
       result:=AdvPos(c_cl,s,i);
       if result=0 then
        result:=length(s)+1 else
        inc(result);
       exit;
      end else
      if pc^=#0 then
      begin
       dec(pc);
       break;
      end;
    until pc^ in ['"',#0];
}

   end;
   if pc^=c_cl then
    result:=pc-pchar(s)+1+1 else
    result:=0;
{
   result:=pc-pchar(s)+1;
   if pc^=c_cl then
    result:=result+1;
}
    
{   if result <>overTag2(s,i) then
   begin
    showmessage(inttostr(result)+' '+inttostr(overTag2(s,i)));
    i:=overTag2(s,i);
    result:=i;
   end;
 }
{
   while (i<=length(s)) and (s[i]<>c_cl) do
   begin
    if s[i]='"' then
    repeat
      inc(i);
    until not (i<=length(s)) or (s[i]='"');
    inc(i);
   end;
   if (i<=length(s)) then
    result:=i+1 else
    result:=i;
}
end;

function BeforeTagSimple(const s:String;i:integer):integer;
begin //result=0 wenn nicht gefunden
   result:=i-1;
   while (result>=1) and (s[result]<>c_op) do
    dec(result);
end;

function CanBeforeTagSimple(const s:String;i:integer; var i_save:integer):boolean;
begin 
   i:=BeforeTagSimple(s,i);
   result:=i<>0;
   if result then
    i_save:=i;
end;



function Same(const S1, S2: string): boolean;
begin
 result:=SameText(S1,S2);
// result:=(length(s1)=length(s2)) and (LowerCase(s1)=LowerCase(s2));
end;

function SameLo(const S1, S2: string): boolean;
begin
 result:=SameText(S1,S2);
// result:=(length(s1)=length(s2)) and (LowerCase(s1)=s2);
end;


function IsStartingCommentTag(const s:String;i:integer):boolean;
begin
 result:=SubEqual('<!--',s,i);
end;


function ExtractUrlPath(const FileName: string): string;
var
  I: Integer;
begin
  I := LastDelimiter('/\:', FileName);
  Result := CopyStr(FileName, 1, I);
end;

function ExtractUrlFile(const FileName: string): string;
var
  I: Integer;
begin
  I := LastDelimiter('/\:', FileName);
  Result := CopyStr(FileName, I+1, MaxInt);
end;

function CutURLParams(const URL: string): string;
var
  I: Integer;
begin
 i:=AdvPos('?',URL);
 if i<>0 then
  result:=copystr(URL,1,i-1) else
  result:=URL;
end;

function ShortenURL(const URL:String):string;
begin
{ if AdvPos('/index.htm',URL)>0 then
  delete(URL,AdvPos('/index.htm',URL)+1,MaxInt) else
}
 if AdvPos('#',URL)>0 then
  result:=CopyStr(URL,1,AdvPos('#',URL)-1) else
  result:=URL;
end;

function IsAbsoluteURL(const URL:string):boolean;
begin
 result:=AdvPosTil(':',URL,1,10)>0;
end;

function ResolveRelativeURL(const base,rel:string): string;
var i,i2:integer;
begin
 assert(ExtractUrlFile(base)='');
 if isAbsoluteURL(rel) then
 result:=rel else
 begin
 assert(isAbsoluteURL(base));
// result:=ExtractURLPath(base);
 result:=base;
 i:=0;

 if bAdvPos(i2,'://',result) then
 begin
  inc(i2,length('://'));
  i:=i2;
 end else
 if bAdvPos(i2,':\',result) then
 begin
  inc(i2,length(':\'));
  i:=i2;
 end else
 assert(i<>0);

 if SubEqual('//',rel) then
  result:=CopyStr(result,1,i-1)+CopyStr(rel,3,maxint) else
 if SubEqual('/',rel) then
 begin
  if isLocal(base) then
   result:=CopyStr(result,1,length(base))+CopyStr(rel,2,maxint) else
   result:=CopyStr(result,1,AdvPos('/',base,i))+CopyStr(rel,2,maxint);
//  result:=CopyStr(result,1,_if(isLocal(base),length(base),AdvPos('/',base,i)))+CopyStr(rel,2,maxint);
 end else
 begin
  result:=result+rel;
  while bAdvPos(i,'/./',WebSlashes(result)) do
   delete(result,i,length('/.'));
  while bAdvPos(i,'/../',WebSlashes(result)) do
  begin
   if (i2<>0) and (AdvPos('/',WebSlashes(result),i2)=i) then
   begin
    delete(result,i,length('/..'));
   end else
   begin
   delete(result,i,length('/../'));
   while (i-1>=1) and not (result[i-1] in ['/','\']) do
   begin
    delete(result,i-1,1);
    dec(i);
   end;
   end;
  end;
 end;
 result:=RightSlashes(result);
{ if pos('#',result)>0 then
  showmessage(base+'    '+rel);
}
 end;
end;

function CalcPathDiff(fromURI,toURI:string; var newURI:string): boolean;
var fromI,toI:integer;
begin
 result:=false;
 fromURI:=AdjustURLPure(fromURI);
 toURI:=AdjustURLPure(toURI);
 assert(bAdvPos(fromI,':',fromURI));
 inc(fromI);
 while (fromI<=length(fromURI)) and (fromURI[fromI] in ['/','\']) do
  inc(fromI);
 if not IsLocal(fromURI) then
 begin
  if not bAdvPos(fromI,'/',fromURI,fromI) then
   exit;
  inc(fromI);
 end;
 if SubSame(fromURI,toURI,1,fromI-1) then
 begin
  newURI:='';
  toI:=fromI;
  while bAdvPos(fromI,'/',WebSlashes(fromURI),fromI) do
  begin
  inc(fromI);
  if not SubSame(fromURI,toURI,1,fromI-1) then
   newURI:='../'+newURI else
   toI:=fromI;
  end;
  newURI:=newURI+WebSlashes(abscopy(toURI,toI,maxint));
  result:=true;
 end;
end;

function RightSlashes(const URI:string): string;
begin
 if isLocal(URI) then
  result:=AnsiSubstText('/','\',URI) else
  result:=AnsiSubstText('\','/',URI);
end;


function WebSlashes(const URI:string): string;
begin
 result:=AnsiSubstText('\','/',URI);
end;



function AdjustURLPure(const URL:string):String;
begin
 result:=URL;

 if AdvPos(javascript_URL_Separator,result)>0 then
  delete(result,1,AdvPos(javascript_URL_Separator,result)-1+length(javascript_URL_Separator));

 if SubEqual(textFileExt,result) then
 begin
  delete(result,1,length(textFileExt));
  result:=AnsiSubstText('/','\',result);
 end else
 if SubEqual(textFile,result) then
  delete(result,1,length(textFile));

end;

function IsHTTP(const URL:string):boolean;
begin
 result:=SubEqual(textHttp,URL) or SubEqual(textHttps,URL);
end;

function IsFTP(const URL:string):boolean;
begin
 result:=SubEqual(textFTP,URL);
end;

function IsMail(const URL:string):boolean;
begin
 result:=SubEqual(textMail,URL);
end;

function IsLocal(const URL:string):boolean;
begin
{ if (AdvPos(':\',URL)>0) and (AdvPos('/',url)<>0) then
  showmessage('islocal: '+url);
}
 result:=(AdvPos(':\',URL)>0){ and (AdvPos('/',url)=0) wegen relative path};
end;

function IsQuery(const URL:string):boolean;
begin
 result:=AdvPos('?',URL)>0;
end;

{function FindNextTag(const s:String; i:Integer): integer;
begin
 result:=FindTagOpening(
end;
 }

const buc_op=valfirst+['!','?'];
const buc_cl=valfirst;


function IsTagOpening(const s:String; i:Integer): boolean;
begin
 result:= {$IFOPT R+}(i<=length(s)-2) and {$ENDIF} (s[i]=c_op) and ((s[i+1]=c_end) and (s[i+2] in buc_cl) or (s[i+1] in buc_op));
end;

function FindTagOpening(const s:String; i:Integer): integer;
begin
 repeat
  i:=AdvPos(c_op,s,i);
  if (i<>0) and {$IFOPT R+}(i<=length(s)-2) and {$ENDIF}((s[i+1]=c_end) and (s[i+2] in buc_cl) or (s[i+1] in buc_op)) then
  begin
   result:=i;
   exit;
  end;
  inc(i);
 until (i=1);
 //result:=length(s)+1;
 result:=0;

{ result:=i;
 repeat
  result:=AdvPos(c_op,s,result);
  if (result<>0) and (s[result+1] in buc_op) then
   exit;
  inc(result);
 until (result=1);
 result:=length(s)+1;
}{ while (i<=length(s)-1) and not ((s[i]=c_op) and (s[i+1] in buc_op)) do
  inc(i);
 if i=length(s) then
  inc(i);
 result:=i;
}{ pc:=AnsiStrScan(pchar(@s[i]),Chr);
 if pc=nil then
  Result:=0 else
  Result:=pc-pchar(s)+1;
}end;




function FindTagEnding_NotSkipHtml(const ls:String;i:integer):integer;
begin
 if SubSame('noframes',ls,i+1) then
  result:=overTag(ls,i) else
  result:=FindTagEnding(ls,i);
end;

function CanFindTagEnding_NotSkipHtml(const ls:String;var i:integer):boolean;
var ii:integer;
begin
 ii:=FindTagEnding_NotSkipHtml(ls,i);
 result:=ii<>0;
 if result then
  i:=ii;
end;

function CanFindTagEnding(const ls:String;var i:integer):boolean;
var ii:integer;
begin
 ii:=FindTagEnding(ls,i);
 result:=ii<>0;
 if result then
  i:=ii;
end;

function FindTagEnding(const ls:String;i:integer):integer;
var //etag:String;
    ch:char;

function CleverClose(const Substr:string; i:integer): integer;
begin
 result:=AdvPos('</',ls,i);
 while not((result=0) or SubSame(Substr,ls,result+length('</'))) do
  result:=AdvPos('</',ls,result+length('</'){+length(Substr)});
 if result<>0 then
  inc(result,length('</')+length(Substr));
end;

begin
try
  ch:=LowerChar(ls[i+1]);
except
  ch:=LowerChar(ls[i+1]);
end;
  if (ch='!') and SubEqual('--',ls,i+2) then begin result:=AdvPos('-->',ls,i+length('<!--')); if result<>0 then inc(result,length('-->')) end else
  if (ch='n') and SubSame('oframes',ls,i+2) then result:=CleverClose('noframes>',i+length('<noframes')) else
  if (ch='s') and SubSame('cript',ls,i+2) then result:=CleverClose('script>',i+length('<script')) else
  if (ch='t') and SubSame('itle',ls,i+2) then result:=CleverClose('title>',i+length('<title')) else
  if (ch='s') and SubSame('tyle',ls,i+2) then result:=CleverClose('style>',i+length('<style')) else
  begin
   result:=overTag(ls,i);
//   assert(result>=i);
   exit;
  end;

//  result:=AdvPosNoCase(etag,ls,i);
  if (result=0) then
   result:=overTag(ls,i){ else
   inc(result,length(etag))};

//  assert(result>=i);
end;

function NivelSpaces(const s:String): string;
begin
 result:=s;
// result:=SubstText(endl_main,space,SubstText(endl_space,space,SubstText(tabu,space,SubstText(FormFeed,space,s)))){)};
end;


{
function HTMLExtractText(const s:string; FillWith:Char=space; ex:boolean=false):string;
var i,i2:integer;
    ls:String;
begin
 result:=s;
 i:=FindTagOpening(result,1);
 ls:=LowerCase(result);
 while (i<=length(result)) do
 begin
  i2:=FindTagEnding(ls,i);
  fillchar( result[i],i2-i,FillWith);
  fillchar(ls[i],i2-i,FillWith);
  i:=FindTagOpening(result,i);
 end;
 result:=NivelSpaces(result);
 if not ex then
  ConvertUnicodeToChar(result,FillWith,false);
End;
}

function SkipBckWhiteSpacesWithoutEndlAll(const s:string;i:integer):integer;
begin
 while (i-1>=1) and (s[i-1] in (likespace-[endl_space,endl_main])) do
  dec(i);
 result:=i;
end;

function SkipBckWhiteSpacesWithoutEndlMain(const s:string;i:integer):integer;
begin
 while (i-1>=1) and (s[i-1] in (likespace-[endl_main])) do
  dec(i);
 result:=i;
end;

function SkipWhiteSpacesWithoutEndlAll(const s:string;i:integer):integer; overload;
begin
 while {$IFOPT R+}(i<=length(s)) and{$ENDIF} (s[i] in (likespace-[endl_space,endl_main])) do
  inc(i);
 result:=i;
end;

function SkipWhiteSpacesWithoutEndlMain(const s:string;i:integer):integer; overload;
begin
 while {$IFOPT R+}(i<=length(s)) and{$ENDIF} (s[i] in (likespace-[endl_main])) do
  inc(i);
 result:=i;
end;

function SkipWhiteSpacesOnlyEndlAll(const s:string;i:integer):integer; overload;
begin
 while {$IFOPT R+}(i<=length(s)) and{$ENDIF} (s[i] in [endl_space,endl_main]) do
  inc(i);
 result:=i;
end;


function SkipBckWhiteSpaces(const s:string;i:integer):integer;
begin
 while (i-1>=1) and (s[i-1] in likespace) do
  dec(i);
 result:=i;
end;

function SkipWhiteSpaces(const s:string;i:integer):integer; overload;
begin
 while {$IFOPT R+}(i<=length(s)) and{$ENDIF} (s[i] in likespace) do
  inc(i);
 result:=i;
end;

function SkipWhiteSpacesSaveEndlAll(const s:string;i:integer; var lastline:integer):integer;
begin
 while {$IFOPT R+}(i<=length(s)) and{$ENDIF} true do
 if s[i] in (likespace-[endl_space,endl_main]) then
  inc(i) else
 if s[i]=endl_space then
 begin
  inc(i,2);
  lastline:=i;
 end else
  break;
 result:=i;
end;

function SkipOnlySpaces(const s:string;i,length_s:integer):integer;
begin
 while (i<length_s) and (s[i]=space) do
  inc(i);
 result:=i;
end;


function SkipSpaces(const s:string;i:integer):integer; overload;
begin
 while {$IFOPT R+}(i<=length(s)) and{$ENDIF} (s[i]=space) do
  inc(i);
 result:=i;
end;

function SkipSpaces(const s:string;i,length_s:integer):integer; overload;
begin
 while (i<=length_s) and (s[i]=space) do
  inc(i);
 result:=i;
end;

function SkipBckSpaces(const s:string;i:integer):integer;
begin
 while (i-1>=1) and (s[i-1]=space) do
  dec(i);
 result:=i;
end;


procedure RightEleName(var MyTagName:string);
begin
  while AdvPos(':',MyTagName)>0 do
   delete(MyTagName,1,AdvPos(':',MyTagName));
end;

function getRightEleName(MyTagName:string):string;
begin
 result:=MyTagName;
 RightEleName(result);
end;

function NivelLines(const s:String): string;
begin
   result:=s;
   result:=AnsiSubstText(FormFeed,space,result);
   result:=AnsiSubstText(tabu,space, result);
   result:=AnsiSubstText(endl,endl_main, result);
   result:=AnsiSubstText(endl_space,endl_main,result);
   result:=AnsiSubstText(endl_main,endl,result);
//   s:=SubstText(#0,space,s);
end;

function NivelWhiteSpaces(const s:String): string;
begin
   result:=s;
   result:=AnsiSubstText(FormFeed,space,result);
   result:=AnsiSubstText(tabu,space, result);
   result:=AnsiSubstText(endl_space,space,result);
   result:=AnsiSubstText(endl_main,space,result);
//   s:=SubstText(#0,space,s);
end;

function CutWhiteSpace(const s:String): string;
begin
   result:=AnsiSubstText(space,'',NivelWhiteSpaces(s));
end;

function ReduceWhiteSpace(const s:String): string;
var i:integer;
begin
   result:=NivelWhiteSpaces(s);
   i:=0;
   while bAdvPos(i,space,result,i+1) do
    absdelete(result,i+1,SkipSpaces(result,i+1));
end;


{function NivelLines(s:String): string;
begin
   s:=SubstText(FormFeed,space,s);
   s:=SubstText(tabu,space, s);
   s:=SubstText(endl,endl_main, s);
   s:=SubstText(endl_space,endl_main,s);
   s:=SubstText(endl_main,endl,s);
//   s:=SubstText(#0,space,s);
   result:=s;
end;
 }

{
function SkipSpaces(const s:string;i:integer):integer; overload;
begin
// result:=SkipSpaces(s,i,length(s));
  result:=SkipWhiteSpaces(s,i);
end;
}





function IsHTML(const s:string):boolean;
begin
 result:=(UseFastStrings.pos('.htm',lowercase(s))>0) or (UseFastStrings.pos('.sht',lowercase(s))>0);
end;

function IsExtHTML(const s:string):boolean;
begin
 result:=(UseFastStrings.pos('.htm',lowercase(s))>0);
end;



function ValidWindowsFilename(const URL:String):String;
var i:integer;
const aValidFilenameChar='-';
begin
 result:=Trim(URL);
 for i:=length(result) downto 1 do
  if result[i] in noValidFilenameChars then
   result[i]:=aValidFilenameChar;
 if result='' then
  result:='(empty)';
end;


function CachingName(s:String; const CachingDirectory:string; AddExt:boolean=true):String;
var i:integer;
begin
 s:=ShortenURL(s);
 if AddExt then
 if not IsExtHTML(s) then
 if IsHTTP(s) then
  s:=s+'.html' else
  s:=s+'.txt';

 if SubEqual(TextHttps,s) then
  delete(s,1,length(TextHttps)) else
 if IsHTTP(s) then
  delete(s,1,length(textHttp)) else
 if SubEqual(textC,lowercase(s)) then
  delete(s,1,length(textC));
 s:=ValidWindowsFilename(s);

 s:=CachingDirectory+s;
 if length(s)>240 then
  setlength(s,240);//kann nur 254 zeichen haben
 result:=s;
end;

function GetProtHost(const URL:string; var res:string): boolean;
//var g:tg;
var i:integer;
begin
// result:=g.Init(URL) and g.OverPos('//') and (g.Pos('/') or g.MoveToEnd) and g.SetBackPos(1) and g.saveS(res);
 i:=AdvPos('//',URL);
 if (i<>0) then
 begin
  i:=AdvPos('/',URL,i+length('//'));
  if i<>0 then
   res:=copy(URL,1,i-1) else
   res:=URL;
  result:=true;
 end else
  result:=false;
end;

end.





