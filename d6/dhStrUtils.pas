unit dhStrUtils;

interface

uses Classes,SysUtils,Graphics,WideStrUtils;

const EmptyStr='';

type AString=String;
     AChar=Char;
     HypeString=WideString;
     HypeChar=WideChar;
     TPathName=type TFileName; // a relative/absolute file/URL path
     TColorName=AString; // a color as string
     TEnumName=AString; // an enumeration literal, as pure string or with hyphens, or a space separated list of those
     TPropertyName=AString; // a name of a VCL property

{
type
     TFileContents=TBytes; // the contents of a file
     FileContentsByte=Byte;

const
      FileContentsStart=0;
}
type
     TFileContents=AnsiString; // the contents of a file
     FileContentsByte=AnsiChar;

const
      FileContentsStart=1;

type
{$IF CompilerVersion >= 21}
  WException=Exception;
{$ELSE}
  WException=class (Exception)
  public
    WMessage:WideString;
    constructor Create(const Value:WideString);
    property Message: WideString read WMessage write WMessage;
  end;
{$IFEND}


function CharPos(const S: AnsiString; const C: AnsiChar; Index: Integer): Integer; overload;
function CharPos(const S: WideString; const C: WideChar; Index: Integer): Integer; overload;
function CharPosBack(const S: AnsiString; const C: AnsiChar; Index: Integer): Integer; overload;
function CharPosBack(const S: WideString; const C: WideChar; Index: Integer): Integer; overload;
function AbsCopy(const s:AnsiString; von,bis:integer):AnsiString; overload;
function AbsCopy(const s:WideString; von,bis:integer):WideString; overload;
function SubEqual(const Substr,s:AnsiString; i:integer=1):boolean; overload;
function SubEqual(const Substr,s:WideString; i:integer=1):boolean; overload;
function SubEqualEnd(const Substr,s:AnsiString):boolean; overload;
function SubEqualEnd(const Substr,s:WideString):boolean; overload;
function CopyLess(const s:AnsiString; less:integer): AnsiString; overload
function CopyLess(const s:WideString; less:integer): WideString; overload

function AsString(Stream: TMemoryStream):TFileContents; overload;
function AsString(graphic:TGraphic):TFileContents; overload;
function StringFromFile(const FileName:TPathName):TFileContents;
procedure StringToFile(const FileName:TPathName; s:TFileContents);

function WFormat(const c:WideString; const Args: array of const):WideString;

implementation

function WFormat(const c:WideString; const Args: array of const):WideString;
var cc:WideString;
begin
 cc:=WideStringReplace(c,'%','%s',[rfReplaceAll]);
 WideFmtStr(result,cc,Args)
end;

function AbsCopy(const s:AnsiString; von,bis:integer):AnsiString;
begin
 assert(bis>=von);
 result:=copy(s,von,bis-von);
end;

function AbsCopy(const s:WideString; von,bis:integer):WideString;
begin
 assert(bis>=von);
 result:=Copy(s,von,bis-von);
end;


function CharPos(const S: AnsiString; const C: AnsiChar; Index: Integer): Integer; overload;
begin
 for Result:=Index to length(s) do
 if S[Result]=C then
  exit;
 result:=0;
end;

function CharPos(const S: WideString; const C: WideChar; Index: Integer): Integer; overload;
begin
 for Result:=Index to length(s) do
 if S[Result]=C then
  exit;
 result:=0;
end;

function CharPosBack(const S: AnsiString; const C: AnsiChar; Index: Integer): Integer; overload;
begin
 for Result:=Index downto 1 do
 if S[Result]=C then
  exit;
 result:=0;
end;

function CharPosBack(const S: WideString; const C: WideChar; Index: Integer): Integer; overload;
begin
 for Result:=Index downto 1 do
 if S[Result]=C then
  exit;
 result:=0;
end;

function CopyLess(const s:AnsiString; less:integer): AnsiString;
begin
 result:=copy(s,1,length(s)-less);
end;

function CopyLess(const s:WideString; less:integer): WideString;
begin
 result:=copy(s,1,length(s)-less);
end;

function SubEqual(const Substr,s:AnsiString; i:integer=1):boolean;
var L:integer;
begin
 L:=length(Substr);
 result:=not (L+i-1>length(s)) and ((L=0) or (StrLComp(PAnsiChar(Substr),PAnsiChar(s)+i-1,L)=0));
end;

function SubEqual(const Substr,s:WideString; i:integer=1):boolean;
var L:integer;
begin
 L:=length(Substr);
 result:=not (L+i-1>length(s)) and ((L=0) or (StrLComp(PWideChar(Substr),PWideChar(s)+i-1,L)=0));
end;

function SubEqualEnd(const Substr,s:AnsiString):boolean;
var i:integer;
begin
 i:=length(s)+1-length(Substr);
 result:=(i>=1) and SubEqual(Substr,s,i);
end;

function SubEqualEnd(const Substr,s:WideString):boolean;
var i:integer;
begin
 i:=length(s)+1-length(Substr);
 result:=(i>=1) and SubEqual(Substr,s,i);
end;

function AsString(Stream: TMemoryStream):TFileContents; overload;
var
  size:Int64;
begin
    size:=Stream.Size;
    SetLength(Result,Size);
    if Size<>0 then
    begin
     Stream.Position:=0;
     Stream.Read(Result[FileContentsStart],Size);
    end;
end;

function AsString(graphic:TGraphic):TFileContents; overload;
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    graphic.SaveToStream(Stream);
    Result:=AsString(Stream);
  finally
    Stream.Free;
  end;
end;

function StringFromFile(const FileName:TPathName):TFileContents;
begin
 with TFileStream.create(FileName,fmOpenRead) do
 try
  SetLength(Result,Size);
  if Size<>0 then
   ReadBuffer(Result[FileContentsStart],Size);
 finally
  Free;
 end;
end;

procedure StringToFile(const FileName:TPathName; s:TFileContents);
begin
 with TFileStream.create(FileName,fmCreate) do
 try
  if length(s)<>0 then
   WriteBuffer(s[FileContentsStart],length(s));
 finally
  Free;
 end;
end;

{$IF CompilerVersion < 21}
constructor WException.Create(const Value: WideString);
begin
 inherited Create(Value+' (ANSI error message)');
 WMessage:=Value;
end;
{$IFEND}


end.
