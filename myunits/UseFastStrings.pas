unit UseFastStrings;

interface
uses sysutils,StrUtils,dhStrUtils;

const space=' ';
      tabu=#9;
      FormFeed=#12;
      endl_main=#10;
      endl_space=#13;
      endl=endl_space+endl_main;
      endl_main_offset=1;

const likespace=[space,tabu,formfeed,endl_main,endl_space];

function CopyStr(const aSourceString : String; aStart, aLength : Integer) : String;
function CopyWithout(const s:String; von,bis:integer): String; overload;
function CopyInsert(const s:String; von:integer; const Subst:String): String; overload;
function CopyInsert(const s:String; von,bis:integer; const Subst:String): String; overload;
procedure AbsDelete(var s:String; von,bis:integer);
function AbsCopy(const s:String; von,bis:integer):String;

function ExtractRawFileName(const s:TPathName):TPathName;

function SubEqual(const Substr,s:String; i:integer; StartFIND,LenFIND:integer):boolean; overload;
function SubEqual(const Substr,s:String; i,bs:integer):boolean; overload;
function SubEqual(const Substr,s:String; i:integer=1):boolean; overload;
function SubEqualEnd(const Substr,s:String):boolean;
function SubSame(const Substr,s:String; i:integer=1):boolean; overload;
function SubSame(const Substr,s:String; i,l:integer):boolean;  overload;
function SubSameEnd(const Substr,s:String):boolean;

function AdvPos(const FindString, SourceString: String; StartPos: Integer=1): Integer;
function AdvPosAnsi(const FindString, SourceString: AnsiString; StartPos: Integer=1): Integer;
function bAdvPos(var r:integer; const FindString, SourceString: String; StartPos: Integer=1): boolean;
function bAdvPosAnsi(var r:integer; const FindString, SourceString: AnsiString; StartPos: Integer=1): boolean;
function AdvPosTil(const FindString, SourceString: String; StartPos,EndPos: Integer): Integer; overload;
function bAdvPosTil(var r:integer; const FindString, SourceString: String; StartPos,EndPos: Integer): boolean; overload;
function bAdvPosTil(var r:integer; const FindString, SourceString: String; StartPos,EndPos,StartFIND,LenFIND: Integer): boolean; overload;
function bAdvPosTilOver(var r:integer; const FindString, SourceString: String; StartPos,EndPos: Integer): boolean;
function AdvPosBack(const FindString, SourceString: String; StartPos: Integer): Integer;
function bAdvPosBack(var r:integer; const FindString, SourceString: String; StartPos: Integer): boolean;
function AdvPosBackTil(const FindString, SourceString: String; StartPos, EndPos: Integer): integer;
function bAdvPosBackTil(var r:integer; const FindString, SourceString: String; StartPos, EndPos: Integer): boolean; overload;
function bAdvPosBackTil(var r:integer; const FindString, SourceString: String; StartPos, EndPos,StartFIND,LenFIND: Integer): boolean; overload;

function LowerChar(ch:Char):Char; overload;

function AnsiSubstText(const Substr,durch, S: String): String;

function gethex(ch:Char):integer;


implementation


function FastPosBack(const aSourceString, aFindString : String; const aSourceLen, aFindLen, StartPos : Integer) : Integer;
var pResult,Buf:PChar;
begin
  Result:=0;
  Buf:=PChar(aSourceString);
  pResult:=SearchBuf(Buf,aSourceLen,StartPos,0,aFindString,[soMatchCase]);
  if pResult<>nil then
   Result:=(pResult-PChar(aSourceString))+1;
end;

function FastPosBackTil(const aSourceString: String; aFindString : PChar; aSourceLen, aFindLen, StartPos: Integer; EndPos:integer) : Integer;//!!
var pResult,Buf:PChar;
begin
  Result:=0;
  Buf:=PChar(aSourceString);
  Inc(Buf,EndPos-1);
  Dec(aSourceLen,EndPos-1);
  Dec(StartPos,EndPos-1);
  pResult:=SearchBuf(Buf,aSourceLen,StartPos,0,aFindString,[soMatchCase]);
  if pResult<>nil then
   Result:=(pResult-PChar(aSourceString))+1;
end;

function FastPos(const aSourceString, aFindString : String; const aSourceLen, aFindLen, StartPos : Integer) : Integer;
var pResult,Buf:PChar;
begin
  Result:=0;
  Buf:=PChar(aSourceString);
  pResult:=SearchBuf(Buf,aSourceLen,StartPos,0,aFindString,[soDown,soMatchCase]);
  if pResult<>nil then
   Result:=(pResult-PChar(aSourceString))+1;
end;

function FastPosAnsi(const aSourceString, aFindString : AnsiString; const aSourceLen, aFindLen, StartPos : Integer) : Integer;
var pResult,Buf:PAnsiChar;
begin
  Result:=0;
  Buf:=PAnsiChar(aSourceString);
  pResult:=SearchBuf(Buf,aSourceLen,StartPos,0,aFindString,[soDown,soMatchCase]);
  if pResult<>nil then
   Result:=(pResult-PAnsiChar(aSourceString))+1;
end;

function SubEqual(const Substr,s:String; i:integer; StartFIND,LenFIND:integer):boolean; overload;
begin
//L=LenFIND
 result:=not (LenFIND+i-1>length(s)) and ((LenFIND=0) or (StrLComp(PChar(Substr)+StartFIND-1,PChar(s)+i-1,LenFIND)=0));
end;


function SubEqual(const Substr,s:String; i,bs:integer):boolean;
var L:integer;
begin
 L:=length(Substr);
 result:=(bs-i=L) and not (L+i-1>length(s)) and ((L=0) or (StrLComp(PChar(Substr),PChar(Pointer(s))+i-1,L)=0));
end;

function SubEqual(const Substr,s:String; i:integer=1):boolean;
var L:integer;
begin
 L:=length(Substr);
 result:=not (L+i-1>length(s)) and ((L=0) or (StrLComp(PChar(Substr),PChar(Pointer(s))+i-1,L)=0));
end;

function SubEqualEnd(const Substr,s:String):boolean;
var i:integer;
begin
 i:=length(s)+1-length(Substr);
 result:=(i>=1) and SubEqual(Substr,s,i);
end;

function SubSameEnd(const Substr,s:String):boolean;
var i:integer;
begin
 i:=length(s)+1-length(Substr);
 result:=(i>=1) and SubSame(Substr,s,i);
end;

function SubSame(const Substr,s:String; i:integer=1):boolean;
var L:integer;
begin
 L:=length(Substr);
 result:=not (L+i-1>length(s)) and ((L=0) or (StrLIComp(PChar(Substr),PChar(Pointer(s))+i-1,L)=0));
end;

function SubSame(const Substr,s:String; i,l:integer):boolean;
begin
 result:=not (L+i-1>length(s)) and ((L=0) or (StrLIComp(PChar(Substr),PChar(Pointer(s))+i-1,L)=0));
end;

function bAdvPosBack(var r:integer; const FindString, SourceString: String; StartPos: Integer): boolean;
begin
 StartPos:=FastPosBack(SourceString,FindString,length(SourceString),length(FindString),StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function AdvPosBack(const FindString, SourceString: String; StartPos: Integer): Integer;
begin
 result:=FastPosBack(SourceString,FindString,length(SourceString),length(FindString),StartPos);
end;

function AdvPosBackTil(const FindString, SourceString: String; StartPos, EndPos: Integer): integer;
begin
 result:=FastPosBackTil(SourceString,PChar(FindString),length(SourceString),length(FindString),EndPos-length(FindString),StartPos);
end;

function AdvPos(const FindString, SourceString: String; StartPos: Integer): Integer;
begin
 result:=PosEx(FindString,SourceString,StartPos);
end;

function AdvPosAnsi(const FindString, SourceString: AnsiString; StartPos: Integer): Integer;
begin
 result:=FastPosAnsi(SourceString,FindString,Length(SourceString),Length(FindString),StartPos);
end;

function bAdvPos(var r:integer; const FindString, SourceString: String; StartPos: Integer): boolean;
begin
 StartPos:=AdvPos(FindString,SourceString,StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function bAdvPosAnsi(var r:integer; const FindString, SourceString: AnsiString; StartPos: Integer): boolean;
begin
 StartPos:=AdvPosAnsi(FindString,SourceString,StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;


function AdvPosTil(const FindString, SourceString: String; StartPos,EndPos: Integer): Integer;
begin
 result:=FastPos(SourceString,FindString,EndPos-1,length(FindString),StartPos);
end;

function bAdvPosTil(var r:integer; const FindString, SourceString: String; StartPos,EndPos: Integer): boolean;
begin
 StartPos:=AdvPosTil(FindString,SourceString,StartPos,EndPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function bAdvPosTilOver(var r:integer; const FindString, SourceString: String; StartPos,EndPos: Integer): boolean;
begin
 StartPos:=AdvPosTil(FindString,SourceString,StartPos,EndPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos+Length(FindString);
end;


function bAdvPosTil(var r:integer; const FindString, SourceString: String; StartPos,EndPos,StartFIND,LenFIND: Integer): boolean; overload;
begin
 assert(StartFIND+LenFIND-1<=length(FindString));
 StartPos:=FastPos(SourceString,PChar(@FindString[StartFIND]),EndPos-1,LenFIND,StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function bAdvPosBackTil(var r:integer; const FindString, SourceString: String; StartPos, EndPos: Integer): boolean;
begin
 StartPos:=FastPosBackTil(SourceString,PChar(FindString),length(SourceString),length(FindString),EndPos-length(FindString),StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function bAdvPosBackTil(var r:integer; const FindString, SourceString: String; StartPos, EndPos,StartFIND,LenFIND: Integer): boolean;
begin
 StartPos:=FastPosBackTil(SourceString,@FindString[StartFIND],length(SourceString),LenFIND,EndPos-LenFIND,StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;


function CopyStr(const aSourceString : String; aStart, aLength : Integer) : String;
begin
  Result:=Copy(aSourceString, aStart, aLength);
end;

function CopyInsert(const s:String; von:integer; const Subst:String): String;
begin
 result:=abscopy(s,1,von)+Subst+abscopy(s,von,maxint);
end;

function CopyInsert(const s:String; von,bis:integer; const Subst:String): String;
begin
 result:=abscopy(s,1,von)+Subst+abscopy(s,bis,maxint);
end;

function CopyWithout(const s:String; von,bis:integer): String;
begin
 result:=s;
 absdelete(result,von,bis);
end;

procedure AbsDelete(var s:String; von,bis:integer);
begin
 assert(bis>=von);
 delete(s,von,bis-von);
end;

function AbsCopy(const s:String; von,bis:integer):String;
begin
 assert(bis>=von);
 result:=Copy(s,von,bis-von);
end;

function LowerChar(ch:Char):Char;
begin
 if CharInSet(ch,['A'..'Z']) then
  result:=Char(ord(ch)-(ord('A')-ord('a'))) else
  result:=ch;
end;

function ExtractRawFileName(const s:TPathName):TPathName;
begin
 Result:=ChangeFileExt(ExtractFileName(s),'');
end;

function AnsiSubstText(const Substr,durch, S: String): String;
begin
 result:=StringReplace(S,Substr,durch,[rfReplaceAll]);
end;

function gethex(ch:Char):integer;
begin
 case ch of
 '0'..'9': result:=ord(ch)-ord('0');
 'a'..'f': result:=ord(ch)-ord('a')+10;
 'A'..'F': result:=ord(ch)-ord('A')+10;
 else result:=ord(space);
 end;
end;


end.
