unit UseFastStrings;

interface
uses FastStrings,FastStringFuncs, sysutils;

const space=' ';
      tabu=#9;
      FormFeed=#12;
      endl_main=#10;
      endl_space=#13;
      endl=endl_space+endl_main;
      endl_main_offset=1;

const likespace=[space,tabu,formfeed,endl_main,endl_space];

function AbsCopy(const s:string;von,bis:integer):String;
function CopyLess(const s:String; less:integer): string;
function CopyWithout(const s:String; von,bis:integer): string; overload;
function CopyInsert(const s:String; von:integer; const Subst:string): string; overload;
function CopyInsert(const s:String; von,bis:integer; const Subst:string): string; overload;
procedure AbsDelete(var s:string; von,bis:integer);

function Pos(const Substr, S: string): Integer; overload;
function Pos(const Substr, S: WideString): Integer; overload;
function Pos(Substr: char; const S: string; StartPos:integer=1): Integer; overload;
//type tf=function(const aSourceString : string; aStart, aLength : Integer):String;
//const Copy=tf(@CopyStr);
function Copy(const S:String; Index, Count: Integer): string; overload;
function Copy(const S:WideString; Index, Count: Integer): WideString; overload;
procedure Move(const Source; var Dest; Count: Integer);


function ExtractRawFileName(const s:String):String;



function SubEqual(const Substr,s:string; i:integer; StartFIND,LenFIND:integer):boolean; overload;
function SubEqual(const Substr,s:string; i:integer=1):boolean; overload;
function SubEqual(const Substr,s:string; i,bs:integer):boolean; overload;
function SubEqualEnd(const Substr,s:string):boolean;
function SubSame(const Substr,s:string; i:integer=1):boolean; overload;
function SubSame(const Substr,s:string; i,l:integer):boolean;  overload;
function SubSameEnd(const Substr,s:string):boolean;

function AdvPos(const C:Char; const SourceString: string; StartPos: Integer=1): Integer; overload;
function bAdvPos(var r:integer; const C:Char; const SourceString: string; StartPos: Integer=1): boolean; overload;
function AdvPos(const FindString, SourceString: string; StartPos: Integer=1): Integer; overload;
function bAdvPos(var r:integer; const FindString, SourceString: string; StartPos: Integer=1): boolean; overload;
function AdvPosTil(const FindString, SourceString: string; StartPos,EndPos: Integer): Integer; overload;
function AdvPosNoCaseTil(const FindString, SourceString: string; StartPos,EndPos: Integer): Integer; overload;
function bAdvPosTil(var r:integer; const C:Char; const SourceString: string; StartPos,EndPos: Integer): boolean; overload;
function bAdvPosTil(var r:integer; const FindString, SourceString: string; StartPos,EndPos: Integer): boolean; overload;
function bAdvPosTil(var r:integer; const FindString, SourceString: string; StartPos,EndPos,StartFIND,LenFIND: Integer): boolean; overload;
function bAdvPosTilOver(var r:integer; const FindString, SourceString: string; StartPos,EndPos: Integer): boolean;
function AdvPosBack(const FindString, SourceString: string; StartPos: Integer): Integer;
function bAdvPosBack(var r:integer; const FindString, SourceString: string; StartPos: Integer): boolean;
function AdvPosNoCase(const FindString, SourceString: string; StartPos: Integer=1):integer; overload; overload;
function bAdvPosNoCase(var r:integer; const FindString, SourceString: string; StartPos: Integer=1): boolean; overload;
function AdvPosBackTil(const FindString, SourceString: string; StartPos, EndPos: Integer): integer;
function bAdvPosBackTil(var r:integer; const FindString, SourceString: string; StartPos, EndPos: Integer): boolean; overload;
function bAdvPosBackTil(var r:integer; const FindString, SourceString: string; StartPos, EndPos,StartFIND,LenFIND: Integer): boolean; overload;

function StringCountRange(const aSourceString:String; von,bis:integer; const aFindString : string; Const CaseSensitive : Boolean = TRUE) : Integer;

function LowerChar(ch:Char):Char; overload;

function AnsiSubstText(const Substr,durch, S: string): String;

function gethex(ch:char):integer;


implementation


procedure Move(const Source; var Dest; Count: Integer);
begin  
 if (Cardinal(@Dest) > Cardinal(@Source)) and (Cardinal(@Source)+Cardinal(Count) > Cardinal(@Dest)) then
  System.Move(Source,Dest,Count) else
  FastCharMove(Source,Dest,Count);
end;

function Pos(const Substr, S: string): Integer;
begin
 result:=FastPos(S,Substr,length(S),length(Substr),1);
end;

function Pos(const Substr, S: WideString): Integer;
begin
 result:=System.Pos(Substr,S);
end;

function Pos(Substr: char; const S: string; StartPos:integer=1): Integer;
begin
 result:=FastCharPos(S,Substr,StartPos);
end;

function Copy(const S:String; Index, Count: Integer): string; overload;
begin
 result:=CopyStr(S,Index,Count);
end;

function Copy(const S:WideString; Index, Count: Integer): WideString; overload;
begin
 result:=System.Copy(S,Index,Count);
end;









//siehe MyStrLIComp
function CompareIMem(const Str1, Str2: PChar; MaxLen: Cardinal): boolean; assembler;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     EBX,ECX

        XOR     EAX,EAX
{
        OR      ECX,ECX
        JE      @@4
        REPNE   SCASB
        SUB     EBX,ECX
        MOV     ECX,EBX
        MOV     EDI,EDX
}
        XOR     EDX,EDX
@@1:    REPE    CMPSB
        JE      @@4
        MOV     AL,[ESI-1]
        CMP     AL,'a'
        JB      @@2
        CMP     AL,'z'
        JA      @@2
        SUB     AL,20H
@@2:    MOV     DL,[EDI-1]
        CMP     DL,'a'
        JB      @@3
        CMP     DL,'z'
        JA      @@3
        SUB     DL,20H
@@3:    SUB     EAX,EDX
        JE      @@1
        xor     eax,eax //
        jmp     @@5     //
@@4:
        mov     al,1    //
@@5:                    //
        POP     EBX
        POP     ESI
        POP     EDI
end;


function SubEqualEnd(const Substr,s:string):boolean;
var i:integer;
begin
 i:=length(s)+1-length(Substr);
 result:=(i>=1) and SubEqual(Substr,s,i);
end;

function SubEqual(const Substr,s:string; i:integer; StartFIND,LenFIND:integer):boolean; overload;
begin
//L=LenFIND
 result:=not (LenFIND+i-1>length(s)) and ((LenFIND=0) or CompareMem(PChar(Pointer(Substr))+StartFIND-1,PChar(Pointer(s))+i-1,LenFIND));
end;

function SubEqual(const Substr,s:string; i:integer=1):boolean;
var L:integer;
begin
 L:=length(Substr);
 result:=not (L+i-1>length(s)) and ((L=0) or CompareMem(Pointer(Substr),PChar(Pointer(s))+i-1,L));
end;

function SubEqual(const Substr,s:string; i,bs:integer):boolean;
var L:integer;
begin
 L:=length(Substr);
 result:=(bs-i=L) and not (L+i-1>length(s)) and ((L=0) or CompareMem(Pointer(Substr),PChar(Pointer(s))+i-1,L));
end;

{function SubEqual(const Substr,s:string; i,von,l:integer):boolean;
begin
 result:=not (L+i-1>length(s)) and ((L=0) or CompareMem(PChar(Pointer(Substr))+von-1,PChar(Pointer(s))+i-1,L));
end;
 }
function SubSameEnd(const Substr,s:string):boolean;
var i:integer;
begin
 i:=length(s)+1-length(Substr);
 result:=(i>=1) and SubSame(Substr,s,i);
end;

function SubSame(const Substr,s:string; i:integer=1):boolean;
var L:integer;
begin
 L:=length(Substr);
 result:=not (L+i-1>length(s)) and ((L=0) or CompareIMem(Pointer(Substr),PChar(Pointer(s))+i-1,L));
end;

function SubSame(const Substr,s:string; i,l:integer):boolean;
begin
 result:=not (L+i-1>length(s)) and ((L=0) or CompareIMem(Pointer(Substr),PChar(Pointer(s))+i-1,L));
end;




{function AdvPos(const FindString, SourceString: string; StartPos: Integer): Integer;
asm
        PUSH    ESI
        PUSH    EDI
        PUSH    EBX
        PUSH    EDX
        TEST    EAX,EAX
        JE      @@qt
        TEST    EDX,EDX
        JE      @@qt0
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     EAX,[EAX-4]
        MOV     EDX,[EDX-4]
        DEC     EAX
        SUB     EDX,EAX
        DEC     ECX
        SUB     EDX,ECX
        JNG     @@qt0
        MOV     EBX,EAX
        XCHG    EAX,EDX
        NOP
        ADD     EDI,ECX
        MOV     ECX,EAX
        MOV     AL,BYTE PTR [ESI]
@@lp1:  CMP     AL,BYTE PTR [EDI]
        JE      @@uu
@@fr:   INC     EDI
        DEC     ECX
        JNZ     @@lp1
@@qt0:  XOR     EAX,EAX
        JMP     @@qt
@@ms:   MOV     AL,BYTE PTR [ESI]
        MOV     EBX,EDX
        JMP     @@fr
@@uu:   TEST    EDX,EDX
        JE      @@fd
@@lp2:  MOV     AL,BYTE PTR [ESI+EBX]
        XOR     AL,BYTE PTR [EDI+EBX]
        JNE     @@ms
        DEC     EBX
        JNE     @@lp2
@@fd:   LEA     EAX,[EDI+1]
        SUB     EAX,[ESP]
@@qt:   POP     ECX
        POP     EBX
        POP     EDI
        POP     ESI
end;
}


function AdvPosNoCase(const FindString, SourceString: string; StartPos: Integer): Integer;
begin
 result:=FastPosNoCase(SourceString,FindString,length(SourceString),length(FindString),StartPos);
end;

function bAdvPosBack(var r:integer; const FindString, SourceString: string; StartPos: Integer): boolean;
begin
 StartPos:=FastPosBack(SourceString,FindString,length(SourceString),length(FindString),StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function AdvPosBack(const FindString, SourceString: string; StartPos: Integer): Integer;
begin
 result:=FastPosBack(SourceString,FindString,length(SourceString),length(FindString),StartPos);
end;

function AdvPosBackTil(const FindString, SourceString: string; StartPos, EndPos: Integer): integer;
begin
 result:=FastPosBackTil(SourceString,PChar(FindString),length(SourceString),length(FindString),EndPos-length(FindString),StartPos);
end;



function AdvPos(const FindString, SourceString: string; StartPos: Integer): Integer;
begin
 result:=FastPos(SourceString,FindString,length(SourceString),length(FindString),StartPos);
end;

function AdvPos(const C:Char; const SourceString: string; StartPos: Integer): Integer;
begin
 result:=FastCharPos(SourceString,C,StartPos);
end;

function bAdvPos(var r:integer; const FindString, SourceString: string; StartPos: Integer): boolean;
begin
 StartPos:=FastPos(SourceString,FindString,length(SourceString),length(FindString),StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function bAdvPos(var r:integer; const C:Char; const SourceString: string; StartPos: Integer): boolean;
begin
 StartPos:=FastCharPos(SourceString,C,StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function bAdvPosTil(var r:integer; const C:Char; const SourceString: string; StartPos,EndPos: Integer): boolean;
begin
 StartPos:=FastCharPosTil(SourceString,C,StartPos,EndPos-1);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;


function bAdvPosNoCase(var r:integer; const FindString, SourceString: string; StartPos: Integer): boolean;
begin
 StartPos:=FastPosNoCase(SourceString,FindString,length(SourceString),length(FindString),StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function AdvPosTil(const FindString, SourceString: string; StartPos,EndPos: Integer): Integer;
begin
 try
 result:=FastPos(SourceString,FindString,EndPos-1,length(FindString),StartPos);
 except
 result:=FastPos(SourceString,FindString,EndPos-1,length(FindString),StartPos);
 end;
end;

function AdvPosNoCaseTil(const FindString, SourceString: string; StartPos,EndPos: Integer): Integer;
begin
 result:=FastPosNoCase(SourceString,FindString,EndPos-1,length(FindString),StartPos);
end;

//The first thing to note here is that I am passing the SourceLength and FindLength
//As neither Source or Find will alter at any point during FastReplace there is
//no need to call the LENGTH subroutine each time !
function FastPos(const aSourceString:String; aFindString : PChar; const aSourceLen, aFindLen, StartPos : Integer) : Integer;
//Source konnte voll übernommen werden
var
  JumpTable: TBMJumpTable;
begin
  //If this assert failed, it is because you passed 0 for StartPos, lowest value is 1 !!
  Assert(StartPos > 0);

  MakeBMTable(PChar(aFindString), aFindLen, JumpTable);
  Result := Integer(BMPos(PChar(aSourceString) + (StartPos - 1), PChar(aFindString),aSourceLen - (StartPos-1), aFindLen, JumpTable));
  if Result > 0 then
    Result := Result - Integer(@aSourceString[1]) +1;
end;


function bAdvPosTil(var r:integer; const FindString, SourceString: string; StartPos,EndPos: Integer): boolean;
begin
 StartPos:=FastStrings.FastPos(SourceString,FindString,EndPos-1,length(FindString),StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function bAdvPosTilOver(var r:integer; const FindString, SourceString: string; StartPos,EndPos: Integer): boolean;
begin
 StartPos:=FastStrings.FastPos(SourceString,FindString,EndPos-1,length(FindString),StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos+length(FindString);
end;


function bAdvPosTil(var r:integer; const FindString, SourceString: string; StartPos,EndPos,StartFIND,LenFIND: Integer): boolean; overload;
begin
 assert(StartFIND+LenFIND-1<=length(FindString));
 StartPos:=FastPos(SourceString,PChar(@FindString[StartFIND]),EndPos-1,LenFIND,StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function bAdvPosBackTil(var r:integer; const FindString, SourceString: string; StartPos, EndPos: Integer): boolean;
begin
 StartPos:=FastPosBackTil(SourceString,PChar(FindString),length(SourceString),length(FindString),EndPos-length(FindString),StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;

function bAdvPosBackTil(var r:integer; const FindString, SourceString: string; StartPos, EndPos,StartFIND,LenFIND: Integer): boolean;
begin
 StartPos:=FastPosBackTil(SourceString,@FindString[StartFIND],length(SourceString),LenFIND,EndPos-LenFIND,StartPos);
 result:=StartPos<>0;
 if result then
  r:=StartPos;
end;


function StringCount(Source:PChar; LSource:integer; const aFindString : string; Const CaseSensitive : Boolean = TRUE) : Integer; overload;
//bis auf Auskommentieren wie Originalcode
var
  Find,
//!!  Source,
  NextPos                     : PChar;
//!!  LSource,
  LFind                       : Integer;
  Next                        : TFastPosProc;
  JumpTable                   : TBMJumpTable;
begin
  Result := 0;
//!!  LSource := Length(aSourceString);
  if LSource = 0 then exit;

  LFind := Length(aFindString);
  if LFind = 0 then exit;

  if CaseSensitive then
  begin
    Next := BMPos;
    MakeBMTable(PChar(aFindString), Length(aFindString), JumpTable);
  end else
  begin
    Next := BMPosNoCase;
    MakeBMTableNoCase(PChar(aFindString), Length(aFindString), JumpTable);
  end;

//  Source := @aSourceString[1];
  Find := @aFindString[1];

  repeat
    NextPos := Next(Source, Find, LSource, LFind, JumpTable);
    if NextPos <> nil then
    begin
      Dec(LSource, (NextPos - Source) + LFind);
      Inc(Result);
      Source := NextPos + LFind;
    end;
  until NextPos = nil;
end;

function StringCountRange(const aSourceString:String; von,bis:integer; const aFindString : string; Const CaseSensitive : Boolean = TRUE) : Integer;
begin
 result:=StringCount(PChar(aSourceString)+von-1,bis-von,aFindString);
 //length=10, dann ist von=11 und bis=11 gestattet!
// result:=StringCount(@aSourceString[von],bis-von,aFindString);
end;

function CopyLess(const s:String; less:integer): string;
begin
 result:=copy(s,1,length(s)-less);
end;

function CopyInsert(const s:String; von:integer; const Subst:string): string;
begin
 result:=abscopy(s,1,von)+Subst+abscopy(s,von,maxint);
end;

function CopyInsert(const s:String; von,bis:integer; const Subst:string): string;
begin
 result:=abscopy(s,1,von)+Subst+abscopy(s,bis,maxint);
end;

function CopyWithout(const s:String; von,bis:integer): string;
begin
 result:=s;
 absdelete(result,von,bis);
end;

function AbsCopy(const s:string; von,bis:integer):String;
begin
 assert(bis>=von);
 result:=copystr(s,von,bis-von);
end;

procedure AbsDelete(var s:string; von,bis:integer);
begin
 assert(bis>=von);
 delete(s,von,bis-von);
end;

function LowerChar(ch:Char):Char;
begin
 if ch in ['A'..'Z'] then
  result:=chr(ord(ch)-(ord('A')-ord('a'))) else
  result:=ch;
end;

function ExtractRawFileName(const s:String):String;
begin
 Result:=ChangeFileExt(ExtractFileName(s),'');
end;

function AnsiSubstText(const Substr,durch, S: string): String;
{var i,von,rel,sl,rl,dl:integer;
const br=2000;
}begin

 result:=FastReplace(S,Substr,durch,true);
{

 result:=s;
 rel:=0;
 von:=length(result)+1;
 sl:=length(Substr);
 rl:=length(result);
 dl:=length(durch);
 for i:=length(result)+1-sl downto 1 do
 if (result[i]=Substr[1]) then
 if (CopyStr(result,i,sl)=Substr) then
 begin
  if rel<dl-sl then
  begin
   setlength(result,rl+br);
   rl:=length(result);
   if 1+(rl-br)-(von+rel)<>0 then
    move(result[von+rel],result[von+rel+br],1+(rl-br)-(von+rel));
   inc(rel,br);
  end;

  if von-(i+sl)>0 then
   move(result[(i+sl)],result[(von+rel-(von-(i+sl)))],(von-(i+sl)));
  von:=i;
  inc(rel,sl);
  if dl<>0 then
   move(durch[1],result[(von+rel-dl)],dl);
  dec(rel,dl);
//  if dl<>sl then
  if rel<>0 then
   result[von]:=#0;
 end;
// move(result[von+rel],result[von],length(result)-(von+rel));
 delete(result,von,rel);
// result:=s;
//result:=StringReplace(s,substr,durch,[rfReplaceAll]);
}end;


function gethex(ch:char):integer;
begin
 case ch of
 '0'..'9': result:=ord(ch)-ord('0');
 'a'..'f': result:=ord(ch)-ord('a')+10;
 'A'..'F': result:=ord(ch)-ord('A')+10;
 else result:=ord(space);
 end;
end;


end.
