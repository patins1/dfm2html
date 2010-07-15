unit funcutils;

interface
uses
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QClipbrd, Qt,
  QMask, QComCtrls, QMenus, QFileCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, Dialogs, Menus,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, ComCtrls,
{$ENDIF}
classes, types, IniFiles, UseFastStrings, dhStrUtils;

{$T+}


function BooleanFromStream(const Stream:TStream):Boolean;
procedure BooleanToStream(const Stream:TStream; const b:Boolean);

type NToStream=procedure (const Stream:TStream; i:Integer);
type NFromStream=function (const Stream:TStream):Integer;

function ByteOrIntegerFromStream(const Stream:TStream):Integer;
procedure ByteOrIntegerToStream(const Stream:TStream; i:Integer);
procedure IntOptToStream(const Stream:TStream; i:Int64);
function IntOptFromStream(const Stream:TMemoryStream):Int64;
function IntegerFromStream(const Stream:TStream):integer;
function DWORDFromStream(const Stream:TStream):DWORD;
function TimeFromStream (const Stream:TStream):TDateTime;
procedure IntegerToStream(const Stream:TStream; const i:integer);
procedure DWORDToStream(const Stream:TStream; const i:DWORD);
procedure TimeToStream(const Stream:TStream; const Time:TDateTime);
function ByteFromStream(const Stream:TStream):Byte;
procedure ByteToStream(const Stream:TStream; const i:Byte);
function WordFromStream(const Stream:TStream):Word;
procedure WordToStream(const Stream:TStream; const i:Word);


function CanStringFromFileST(const FileName:TPathName; var s:TFileContents):boolean;
function _if(cond:boolean;const a,b:string):string;overload;
function _if(cond:boolean;a,b:integer):integer;overload;
function _if(cond:boolean;a,b:int64):int64;overload;
function _if(cond:boolean;a,b:TComponent):TComponent;overload;

function BoolToInt(const b:boolean):integer;

const FullEdging=4;
//function IsFullEdging(var Msg:TWMWINDOWPOSCHANGING):boolean;

function CanStringFromFile(const FileName:TPathName; var s:TFileContents):boolean;
{$IFNDEF CLX}
function CanStringToFileForceDir(const FileName:TPathName; var s:TFileContents):boolean;
procedure CalcRightPos(var Msg:TWMWINDOWPOSCHANGING; Anchors: TAnchors; WindowEdging:integer=0);


procedure SaveFormPlacement(Form:TForm; IniFile:TIniFile; const Section: string = 'Bounds');
procedure LoadFormPlacement(Form:TForm; IniFile:TIniFile; maxi:boolean; w,h:integer; const Section: string = 'Bounds');
procedure LoadPlacement(var BoundsRect:TRect; var Maximized:boolean; IniFile:TIniFile; maxi:boolean; w,h:integer; const Section: string = 'Bounds');
procedure DoFormPlacement(Form:TForm; BoundsRect:TRect; Maximized:boolean);
function GetWindowsWorkArea: TRect;


{$ENDIF}


//procedure RightPopupMenu(PopupTray1:TPopupMenu; x, y:Integer);

procedure ShowFromInactive;
procedure ShowMainFromInactive;

procedure MyHide;

function EqTil(s1,s2:pchar; max:integer):integer;




function LateCreateForm(InstanceClass: TComponentClass; var Reference):TForm;



type TIntListSortCompare = function (Item1, Item2: Integer): Integer;
function DoSort(Compare: TListSortCompare; Count:integer): TList;
function DoSortInt(Compare: TIntListSortCompare; Count:integer): TList;

//procedure FreeStringList2(sl:TStringList);
procedure FreeStringList(var sl:TStringList);
procedure FreeStringListAs(sl:TStringList);
//procedure ClearStringList(sl:TStrings);

//function SLIndexOf(sl:TStringList; const s:string; var i:integer): boolean;

{function NewComma(CommaText:string):TStringList;
function NewSortedComma(CommaText:string):TStringList;
 }


function checked(Sender:tobject):boolean;

type TMyStringList=class(TStringList)
     public
{       FHashList,FSortedHashIndexes:TList;
       FHash:TmwStringHash;
       FAverageHashDelta:integer;
       FFindDelta,FAvFindDelta:integer;
}
//       FUseFast:boolean;
//       fastar:array['a'..'z'] of record low,high:integer end;
//       function FindInterval(const S: string; var Index: Integer; L, H : integer): Boolean;
       function CompareStrings(const S1, S2: string): Integer; override;
       procedure FreeWithObjects; overload;
       procedure FreeWithObjects(var sl:TMyStringList); overload;
       procedure ClearWithObjects;
       function IndexOf(const s:string): integer; reintroduce; overload;
       function IndexOf(const s:string; var i:integer): boolean;  reintroduce; overload;
       function Find(const s:string): boolean;  reintroduce; overload;
//       function Find(const S: string; var Index: Integer): Boolean; overload;
       function Duplicate:TMyStringList;
       procedure SetAssumedSorted;
//       procedure Free;
       procedure UseFastFind;
       procedure DeleteWithObject(Index: Integer);
       function Last:String;
       function First:String;


{       procedure FreeWithObjects;
       procedure ClearWithObjects;
}
     end;


function MyNewComma(const CommaText:string):TMyStringList;
function MyNewSortedComma(const CommaText:string):TMyStringList;
function MyNewAssumedSortedComma(const CommaText:string):TMyStringList;

//function LastCommaCleared:TMyStringList;
function SetComma(const CommaText:string):TMyStringList;
function SetCommaAsText(const CommaText:string):TMyStringList;
//procedure BackComma(var CommaText:string);

var LastComma:TMyStringList;

function IntToBin(D:DWord):string;

procedure Exch(var a,b:byte); overload;
procedure Exch(var a,b:integer); overload;

function HexToByte(const s:string):string;

//function GetSystemFileDescription(FileName:string):string;

implementation

uses sysutils{, Registry}{, ShellAPI};

type
  TStringListCracker = class(TStrings)
  private
    FList: PStringItemList;
    FCount: Integer;
    FCapacity: Integer;
    FSorted: Boolean;
  end;


function IntToBin(D:DWord):string;
begin
 result:='';
 while D<>0 do
 begin
  result:=result+_if(D mod 2=1,'1','0');
  D:=D div 2;
 end;
 while length(result)<8 do
  result:=result+'0'; 
end;

function BoolToInt(const b:boolean):integer;
begin
 if b then
  result:=1 else
  result:=0;
end;

procedure TMyStringList.DeleteWithObject(Index: Integer);
begin
 Objects[Index].Free;
 Delete(Index);
end;

function DoSort(Compare: TListSortCompare; Count:integer): TList;
var seIndex:TList;
    w:integer;
begin
 seIndex:=TList.Create;
 seIndex.Capacity:=Count;
 for w:=0 to Count-1 do
  seIndex.Add(pointer(w));
 seIndex.Sort(Compare);
 result:=seIndex;
end;

function DoSortInt(Compare: TIntListSortCompare; Count:integer): TList;
begin
 result:=DoSort(TListSortCompare(Compare),Count);
end;


(*
procedure TMyStringList.Free;
begin
 Inherited;
 if Self=nil then exit;
 FHashList.Free;
 FSortedHashIndexes.Free;
end;

var glHashList:TList;

function SortHashValues(Item1, Item2: Pointer): Integer;
begin
 result:=integer(glHashList[integer(Item1)])-integer(glHashList[integer(Item2)]);
end;

function TMyStringList.Find(const S: string; var Index: Integer): Boolean;
var h,i,_i,Index2:integer;
begin
 if Assigned(FHashList) then
 begin
  h:=Abs(FHash(S));
  i:=h div FAverageHashDelta;
  _i:=i;
  if i<=Count-1 then
  begin
   if Integer(FHashList[integer(FSortedHashIndexes[i])])>h then
    repeat
     dec(i);
    until not(i>=0) or not (Integer(FHashList[integer(FSortedHashIndexes[i])])>h) else
    while (i<=Count-1) and (Integer(FHashList[integer(FSortedHashIndexes[i])])<h) do
     inc(i);
   result:=(i>=0) and (i<=Count-1) and (Integer(FHashList[integer(FSortedHashIndexes[i])])=h);
   if result then
   begin
    Index:=integer(FSortedHashIndexes[i]);
   end;
   {if not Inherited Find(S,Index2) then
    Index2:=-1;
   if not (result and (Index=Index2) or not result and (Index2=-1)) then
   assert(result and (Index=Index2) or not result and (Index2=-1));
   }
   inc(FAvFindDelta,(_i-i));
   if abs(_i-i)>FFindDelta then
    FFindDelta:=abs(_i-i);
  end else
   result:=false;
 end else
 begin
  result:=Inherited Find(S,Index);
 end;
end;

function MyCrcHash(const aString: string): integer;
begin
 result:=abs(integer(calc_crc32_String(aString)))
end;


procedure TMyStringList.UseFastFind;
var
    HighestHash,i,Index:integer;
begin
 assert(Sorted);
 FFindDelta:=0;
 FHash:=MyCrcHash;
 FHashList:=TList.Create;
 if Count<>0 then
 begin
  FHashList.Capacity:=Count;
  for i:=0 to Count-1 do
   FHashList.Add(Pointer(Abs(FHash(Strings[i]))));
  glHashList:=FHashList;
  FSortedHashIndexes:=DoSort(SortHashValues,Count);
  FAverageHashDelta:=Integer(FHashList[Integer(FSortedHashIndexes[Count-1])]) div (Count-1);
  for i:=0 to Count-2 do
  if not(Integer(FHashList[Integer(FSortedHashIndexes[i])])<Integer(FHashList[Integer(FSortedHashIndexes[i+1])])) then
  if not(Integer(FHashList[Integer(FSortedHashIndexes[i])])<Integer(FHashList[Integer(FSortedHashIndexes[i+1])])) then;
//   assert(Integer(FHashList[Integer(FSortedHashIndexes[i])])<Integer(FHashList[Integer(FSortedHashIndexes[i+1])]));
  for i:=0 to Count-1 do
   if not (Find(Strings[i],Index) and (Index=i)) then
   if not (Find(Strings[i],Index) and (Index=i)) then;
//    assert(Find(Strings[i],Index) and (Index=i));
  FAvFindDelta:=FAvFindDelta div Count;

  showmessage('FAvFindDelta:'+inttostr(FAvFindDelta)+' FFindDelta:'+inttostr(FFindDelta));

 end;
end;
*)


{function TMyStringList.FindInterval(const S: string; var Index: Integer; L, H : integer): Boolean;
var
  I, C: Integer;
begin
  Result := False;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := CompareStrings(TStringListCracker(Self).FList^[I].FString, S);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then L := I;
      end;
    end;
  end;
  Index := L;
end;
 }

{function TMyStringList.Find(const S: string; var Index: Integer): Boolean;
var ch:char;
begin
 if FUseFast then
 begin
  if S='' then
   result:=false else
   begin
    ch:=LowerChar(S[1]);
    if ch in ['a'..'z'] then
     Result:=FindInterval(S,Index,fastar[ch].low,fastar[ch].high) else
     Result:=False;
   end;
 end else
  result:=Inherited Find(S,Index);
end;
 }

{procedure TMyStringList.UseFastFind;
var c:char;
    i:integer;
begin
 assert(Sorted);
 i:=0;
 for c:='a' to 'z' do
 begin
  fastar[c].low:=i;
  while (i<=Count-1) and (Strings[i]<>'') and (LowerChar(Strings[i][1])=c) do
   inc(i);
  fastar[c].high:=i-1;
 end;
 FUseFast:=i=Count;
 Assert(FUseFast);
// FUseFast:=false;
end;
 }
function LateCreateForm(InstanceClass: TComponentClass; var Reference):TForm;
begin
 if TForm(Reference)=nil then
  Application.CreateForm(InstanceClass, Reference);
 result:=TForm(Reference);
end;


type tbo=type boolean;


procedure TMyStringList.UseFastFind;
begin
// SetAssumedSorted;
end;

procedure TMyStringList.SetAssumedSorted;
var i:integer;
begin
 Assert(not Sorted);
 TStringListCracker(Self).FSorted := True;
// Boolean((@Sorted)^):=TRUE;
 for i:=0 to Count-2 do
 if CompareStrings(Strings[i],Strings[i+1])>0 then
  showmessage(Strings[i]+' is lower than '+Strings[i+1]);
 Assert(Sorted);
end;


function TMyStringList.CompareStrings(const S1, S2: string): Integer;
begin
  if CaseSensitive then
    Result := CompareStr(S1,S2)
  else
    Result := CompareText(S1, S2);
end;


{function vPos(const Substr: string; const S: string; var i:integer): boolean;
begin
 i:=pos(Substr,S);
 result:=i<>0;
end;
}
function TMyStringList.IndexOf(const s:string; var i:integer): boolean;
begin
 i:=inherited IndexOf(s);
 result:=i<>-1;
end;
                                 {
function TMyStringList.IndexOf(const s:string): boolean;
begin
 result:=inherited IndexOf(s)<>-1;
end;
                             }
function TMyStringList.IndexOf(const s:string): integer;
begin
 result:=inherited IndexOf(s);
end;

function TMyStringList.Find(const s:string): boolean;
var dummyIndex:integer;
begin
 result:=inherited Find(s,dummyIndex);
end;

{function SLIndexOf(sl:TStringList; const s:string; var i:integer): boolean;
begin
 i:=sl.IndexOf(s);
 result:=i<>-1;
end;
 }
function LastCommaCleared:TMyStringList;
begin
 LastComma.Clear;
 result:=LastComma;
end;

function NewComma(const CommaText:string):TStringList;
begin
 result:=TStringList.Create;
 result.CommaText:=CommaText;
end;

function MyNewComma(const CommaText:string):TMyStringList;
begin
 result:=TMyStringList.Create;
 result.CommaText:=CommaText;
end;

function NewSortedComma(const CommaText:string):TStringList;
begin
 result:=NewComma(CommaText);
 result.Sorted:=true;
end;

function MyNewSortedComma(const CommaText:string):TMyStringList;
begin
 result:=MyNewComma(CommaText);
 result.Sorted:=true;
end;

function MyNewAssumedSortedComma(const CommaText:string):TMyStringList;
begin
 result:=MyNewComma(CommaText);
 result.CaseSensitive:=true;
 result.SetAssumedSorted;
end;

function SetComma(const CommaText:string):TMyStringList;
begin
 LastComma.CommaText:=CommaText;
 result:=LastComma;
end;

function SetCommaAsText(const CommaText:string):TMyStringList;
begin
 LastComma.Text:=CommaText;
 result:=LastComma;
end;

procedure BackComma(var CommaText:string);
begin
 CommaText:=LastComma.CommaText;
end;

procedure FreeStringList(var sl:TStringList);
var i:integer;
begin
 if sl<>nil then
 begin
 for i:=0 to sl.count-1 do
  sl.Objects[i].Free;
 sl.Free;
 sl:=nil;
 end;
end;


function TMyStringList.Duplicate:TMyStringList;
begin
 result:=TMyStringList.Create;
 result.CaseSensitive:=self.CaseSensitive;
 result.Sorted:=self.Sorted;
 result.Assign(self);
end;

procedure TMyStringList.FreeWithObjects(var sl:TMyStringList);
begin
 assert(sl=self);
 FreeWithObjects;
 sl:=nil;
end;

procedure TMyStringList.FreeWithObjects;
begin
 ClearWithObjects;
 Free;
end;

procedure TMyStringList.ClearWithObjects;
var i:integer;
begin
 for i:=0 to Count-1 do
  Objects[i].Free;
 Clear;
end;

procedure FreeStringList2(sl:TStringList);
begin
 FreeStringList(sl);
end;


procedure ClearStringList(sl:TStrings);
var i:integer;
begin
 if sl<>nil then
 begin
 for i:=0 to sl.count-1 do
  sl.Objects[i].Free;
 sl.Clear;
 end;
end;


procedure FreeStringListAs(sl:TStringList);
begin
 FreeStringList(sl);
end;


function GetActiveForm:TCustomForm;
begin
 if Screen.ActiveForm<>nil then
  result:=Screen.ActiveForm else
  result:=Application.MainForm;
end;

function BooleanFromStream(const Stream:TStream):Boolean;
begin
 Stream.Read(result,sizeof(boolean));
end;

procedure BooleanToStream(const Stream:TStream; const b:Boolean);
begin
 Stream.WriteBuffer(b,sizeof(b));
end;

function TimeFromStream(const Stream:TStream):TDateTime;
begin
 Stream.Read(result,sizeof(result));
end;

function IntegerFromStream(const Stream:TStream):Integer;
begin
 Stream.Read(result,sizeof(result));
end;

function DWORDFromStream(const Stream:TStream):DWORD;
begin
 Stream.Read(result,sizeof(result));
end;

procedure TimeToStream(const Stream:TStream; const Time:TDateTime);
begin
 Stream.WriteBuffer(Time,sizeof(Time));
end;

procedure IntegerToStream(const Stream:TStream; const i:Integer);
begin
 Stream.WriteBuffer(i,sizeof(i));
end;

procedure DWORDToStream(const Stream:TStream; const i:DWORD);
begin
 Stream.WriteBuffer(i,sizeof(i));
end;

const Int0:byte=128;
const Int14:byte=1;

procedure IntOptToStream(const Stream:TStream; i:Int64);
var i2,i3:integer;
    i4:integer;
begin
 assert(i>=0);

 if i=0 then
 begin
  Stream.WriteBuffer(Int14,sizeof(Int14));
 end else
 if i<=$3FFFFFFF then
 begin
  i4:=i shl 2;
  Stream.WriteBuffer(i4,sizeof(i4));
 end else
 begin
  //i:=i or $C000000000000000{(2 shl (6+7*8))};
  i:=(i shl 2) or 2;
  Stream.WriteBuffer(i,sizeof(i));
 end;
{ if i=0 then
  Stream.WriteBuffer(Int0,sizeof(Int0)) else
  begin
  i2:=i;
  i:=(i shr 24) + (i  shl 8);
  i3:=(i shr 8) + (i shl 24);
  if (i2<>i3) or (byte(pchar(@i)^) =128) then
  begin
   showmessage(inttostr(i+i2+i3));
   i:=((i2 and (1 shl 8 - 1)) shr 24) + (i2 and (1 shl 24 - 1) shl 8);
  end;

  Stream.WriteBuffer(i,sizeof(i));
  end;}
end;

procedure ByteOrIntegerToStream(const Stream:TStream; i:Integer);
begin
 assert(i>=0);
 if i<=127 then
 begin
  i:=(i shl 1) or 1;
  Stream.WriteBuffer(i,sizeof(Byte));
 end else
 begin
  i:=i shl 1;
  Stream.WriteBuffer(i,sizeof(Integer));
 end;
end;

function ByteOrIntegerFromStream(const Stream:TStream):Integer;
begin
{ result:=Integer14FromStream(Stream);
 exit;
}
 Result:=0;
 Stream.Read(Result,sizeof(Byte));
 if (Result and 1)=0 then
  Stream.Read((pchar(@Result)+sizeof(Byte))^,sizeof(Integer)-sizeof(Byte));
 result:=result shr 1;
end;


function IntOptFromStream(const Stream:TMemoryStream):Int64;
var pc:pchar;
    i4:integer;
begin
 pc:=pchar(Stream.Memory)+Stream.Position;
 case byte(pc^) and 3 of
 1:
 begin
  Stream.Seek(1,soCurrent);
  result:=0;
 end;
 0:
 begin
  Stream.Read(i4,sizeof(i4));
  result:=i4 shr 2{and $3FFFFFFF};
 end;
 2:
 begin
  Stream.Read(result,sizeof(result));
  result:=result shr 2{and $3FFFFFFFFFFFFFFF};
 end;
 3: assert(false,'Integer14FromStream 3 happened');
 end;
{ if byte(pc^)=128 then
 begin
  Stream.Seek(1,soCurrent);
  result:=0;
 end else
 begin
  Stream.Read(result,sizeof(Integer));
  result:=(result shr 8) + (result shl 24);
  assert(result>=0);
 end;}
end;


function ByteFromStream(const Stream:TStream):byte;
begin
 Stream.Read(result,sizeof(result));
end;

procedure ByteToStream(const Stream:TStream; const i:Byte);
begin
 Stream.WriteBuffer(i,sizeof(i));
end;


function WordFromStream(const Stream:TStream):word;
begin
 Stream.Read(result,sizeof(Word));
end;

procedure WordToStream(const Stream:TStream; const i:word);
begin
 Stream.WriteBuffer(i,sizeof(Word));
end;


function CanStringFromFileST(const FileName:TPathName; var s:TFileContents):boolean;
begin
try
 s:=StringFromFile(FileName);
 result:=true;
except
 result:=false;
end;
end;

{$IFNDEF CLX}

function CanStringToFile(const FileName:TPathName; const s:TFileContents):boolean;
var f:File;
var
  wOldErrorMode : Word;
var sIOResult:integer;

begin
//result:=ffrom_file(filename);

wOldErrorMode :=SetErrorMode(SEM_FAILCRITICALERRORS);
try
try
{ if FileExists(FileName) then
  result:=ffrom_file(FileName) else
  result:=NoFile;
}{$I-}
Assign(f,Filename);
Rewrite(f,1);
//form1.Label5.caption:=inttostr(ioresult);
{$I+}
sIOResult:=IOResult;
if sIOResult<>0 then
begin
 result:=false;
end else
begin
 result:=true;
if length(s)<>0 then
blockwrite(f,s[FileContentsStart],length(s));
CloseFile(f);
end;

except
result:=false;
end

finally
SetErrorMode( wOldErrorMode );
end;
End;

function CanStringToFileForceDir(const FileName:TPathName; var s:TFileContents):boolean;
begin
 result:=ForceDirectories(ExtractFilePath(FileName)) and CanStringToFile(Filename,s);
end;                
{$ENDIF}

{$IFNDEF CLX}

function CanStringFromFile(const FileName:TPathName; var s:TFileContents):boolean;
var f:File;
var
  wOldErrorMode : Word;
var sIOResult:integer;


begin
//result:=ffrom_file(filename);
FileMode:=0;
wOldErrorMode :=SetErrorMode(SEM_FAILCRITICALERRORS);
try
try
{ if FileExists(FileName) then
  result:=ffrom_file(FileName) else
  result:=NoFile;
}{$I-}

AssignFile(f,Filename);
Reset(f,1);
//form1.Label5.caption:=inttostr(ioresult);
{$I+}
sIOResult:=IOResult;
if sIOResult<>0 then
begin
 result:=false;
end else
begin
 result:=true;
setlength(s,filesize(f));
if Length(s)<>0 then
 blockread(f,s[FileContentsStart],length(s));
CloseFile(f);
end;

except
result:=false;
end

finally
SetErrorMode( wOldErrorMode );
end;
End;


{$ELSE}

function CanStringFromFile(const FileName:TFileName; var s:TFileContents):boolean;
begin
 try
  s:=StringFromFile(FileName);
  result:=true;
 except
  result:=false;
 end;
end;
{$ENDIF}

function _if(cond:boolean;const a,b:string):string;overload;
begin
 if cond then
  result:=a else
  result:=b;
end;
function _if(cond:boolean;a,b:TComponent):TComponent;
begin
 if cond then
  result:=a else
  result:=b;
end;

function _if(cond:boolean;a,b:integer):integer;overload;
begin
 if cond then
  result:=a else
  result:=b;
end;

function _if(cond:boolean;a,b:int64):int64;overload;
begin   
 if cond then
  result:=a else
  result:=b;
end;
{function IsFullEdging(var Msg:TWMWINDOWPOSCHANGING):boolean;
var r:TRect;
begin
 r:=GetWindowsWorkArea;
 result:=(msg.WindowPos.cx=r.Right-r.Left+2*FullEdging) and
         (msg.WindowPos.cy=r.Bottom-r.Top+2*FullEdging) ;
end;
}
{$IFNDEF CLX}
procedure CalcRightPos;
var r:TRect;
    alt:integer;
const al=10;
begin
 r:=GetWindowsWorkArea;
 if GetActiveForm=nil then exit;


 if (akLeft in Anchors)  and (abs(r.Left  -WindowEdging-(msg.WindowPos.x                 ))<al) then
 begin
  alt:=msg.WindowPos.x;
  msg.WindowPos.x :=r.Left                   -WindowEdging;
  if (msg.WindowPos.cx<>GetActiveForm.Width) then
   dec(msg.WindowPos.cx,msg.WindowPos.x-alt);
 end;

 if (akBottom in Anchors)and (abs(r.Bottom+WindowEdging-(msg.WindowPos.y+msg.WindowPos.cy))<al) then
 if (msg.WindowPos.cy=GetActiveForm.Height) then
  msg.WindowPos.y :=r.Bottom-msg.WindowPos.cy+WindowEdging else
  msg.WindowPos.cy:=r.Bottom-msg.WindowPos.y +WindowEdging;

 if (akRight in Anchors) and (abs(r.Right +WindowEdging-(msg.WindowPos.x+msg.WindowPos.cx))<al) then
 if (msg.WindowPos.cx=GetActiveForm.Width) then
  msg.WindowPos.x :=r.Right -msg.WindowPos.cx+WindowEdging else
  msg.WindowPos.cx:=r.Right -msg.WindowPos.x +WindowEdging;

 if (akTop in Anchors)   and (abs(r.Top   -WindowEdging-(msg.WindowPos.y                 ))<al) then
 begin
  alt:=msg.WindowPos.y;
  msg.WindowPos.y :=r.Top                    -WindowEdging;
  if (msg.WindowPos.cy<>GetActiveForm.Height) then
   dec(msg.WindowPos.cy,msg.WindowPos.y-alt);
 end;

{ if (akLeft in Anchors)  and (abs(r.Left  -WindowEdging-(msg.WindowPos.x                 ))<al) then
  msg.WindowPos.x:=r.Left                   -WindowEdging;
 if (akBottom in Anchors)and (abs(r.Bottom+WindowEdging-(msg.WindowPos.y+msg.WindowPos.cy))<al) then
  msg.WindowPos.y:=r.Bottom-msg.WindowPos.cy+WindowEdging;

 if (akRight in Anchors) and (abs(r.Right +WindowEdging-(msg.WindowPos.x+msg.WindowPos.cx))<al) then
  msg.WindowPos.x:=r.Right -msg.WindowPos.cx+WindowEdging;
 if (akTop in Anchors)   and (abs(r.Top   -WindowEdging-(msg.WindowPos.y                 ))<al) then
  msg.WindowPos.y:=r.Top                    -WindowEdging;
}
end;
{$ENDIF}

{function GetSystemFileDescription(FileName:string):string;
var
 SysIL : UInt;
 Info  : TSHFileInfo;
begin
  SysIL:=SHGetFileInfo(PChar(FileName), 0, Info, SizeOf(TSHFileInfo), SHGFI_TYPENAME);
  if SysIL<>0 then
    Result:=Info.szTypeName
  else
    Result:='';
end;
 }

 
{$IFNDEF CLX}

procedure SaveFormPlacement(Form:TForm; IniFile:TIniFile; const Section: string = 'Bounds');
var WindowPlacement:TWindowPlacement;
    normalBounds:TRect;
begin
 WindowPlacement.length:=sizeof(WindowPlacement);
 if GetWindowPlacement(Form.Handle,@WindowPlacement) then
 with IniFile, Form do
 begin
  normalBounds:=WindowPlacement.rcNormalPosition;
  WriteInteger(Section,'Left',normalBounds.Left);
  WriteInteger(Section,'Top',normalBounds.Top);
  WriteInteger(Section,'Right',normalBounds.Right);
  WriteInteger(Section,'Bottom',normalBounds.Bottom);
  WriteBool(Section,'Maximized',wsMaximized=WindowState);
 end;
end;

procedure LoadPlacement(var BoundsRect:TRect; var Maximized:boolean; IniFile:TIniFile; maxi:boolean; w,h:integer; const Section: string = 'Bounds');
var r:TRect;
begin
 with IniFile do
 begin
  r:=GetWindowsWorkArea;
  if w<0 then
   inc(w,r.Right-r.Left);
  if h<0 then
   inc(h,r.Bottom-r.Top);
  BoundsRect:=Rect(ReadInteger(Section,'Left'  ,(r.Left+r.Right) div 2-w div 2),
                   ReadInteger(Section,'Top'   ,(r.Top+r.Bottom) div 2-h div 2),
                   ReadInteger(Section,'Right' ,(r.Left+r.Right) div 2+w div 2),
                   ReadInteger(Section,'Bottom',(r.Top+r.Bottom) div 2+h div 2));
{  Width:= ReadInteger('Bounds','Width' ,Constraints.MinWidth+100);
  Height:=ReadInteger('Bounds','Height',Constraints.MinHeight);
}
  Maximized:=ReadBool(Section,'Maximized',maxi);
 end;
end;

procedure LoadFormPlacement(Form:TForm; IniFile:TIniFile; maxi:boolean; w,h:integer; const Section: string = 'Bounds');
var BoundsRect:TRect;
var Maximized:boolean;
begin
 LoadPlacement(BoundsRect,Maximized,IniFile,maxi,w,h,Section);
 DoFormPlacement(Form,BoundsRect,Maximized);
end;

procedure DoFormPlacement(Form:TForm; BoundsRect:TRect; Maximized:boolean);
begin
 Form.BoundsRect:=BoundsRect;
 if Maximized then
  Form.WindowState:=wsMaximized;
end;


function GetWindowsWorkArea: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0);
end;



procedure RightPopupMenu(PopupTray1:TPopupMenu; x, y:Integer);
var CurPos:TPoint;
    h:integer;
begin
// if GetForegroundWindow=PopupTray1.Handle then exit;

// SetForegroundWindow(0);

// GetActiveForm.Perform( WM_NULL, 0, 0);
// Application.ProcessMessages;
// IF not SetForegroundWindow(popuptray1.WindowHandle) then
 h:=GetActiveForm.Handle;
 SetForegroundWindow(h);
// Application.ProcessMessages;
{ if not Application.Active then
 SetForegroundWindow(GetActiveForm.Handle) else
 SetForegroundWindow(GetActiveForm.Handle);
}
 GetCursorPos(CurPos);
 PopupTray1.Popup(CurPos.x, CurPos.y);
// Application.ProcessMessages;
//
 PostMessage(h, WM_NULL, 0, 0);
// SetForegroundWindow(h);
// GetActiveForm.Perform( WM_NULL, 0, 0);
 // Application.ProcessMessages;
// PostMessage(GetActiveForm.Handle, WM_NULL, 0, 0);
end;

{$ENDIF}

procedure MyHide;
begin
 GetActiveForm.Hide;
end;

procedure ShowFromInactive;
begin
 GetActiveForm.Show;
 Application.Restore;
 Application.BringToFront;
end;

procedure ShowMainFromInactive;
begin
 if GetActiveForm.Visible then
  GetActiveForm.Show else
  Application.MainForm.Show;
 Application.Restore;
 Application.BringToFront;
end;


function checked(Sender:tobject):boolean;
begin
 result:=(sender as tcheckbox).checked;
end;


procedure Exch(var a,b:byte); overload;
var c:byte;
begin
 c:=a;
 a:=b;
 b:=c;
end;


procedure Exch(var a,b:integer); overload;
var c:integer;
begin
 c:=a;
 a:=b;
 b:=c;
end;

function HexToByte(const s:string):string;
var i:integer;
begin
 assert(length(s) mod 2=0);
 setlength(result,length(s) div 2);
 for i:=1 to length(result) do
  result[i]:=chr(gethex(s[2*i-1])*16+gethex(s[2*i]));
end;

function EqTil(s1,s2:pchar; max:integer):integer;
begin
 for result:=0 to max-1 do
 if s1[result]<>s2[result] then
  exit;
 result:=max;
end;

function TMyStringList.First: String;
begin
 result:=Get(0);
end;

function TMyStringList.Last: String;
begin
 result:=Get(Count-1);
end;

initialization
 LastComma:=TMyStringList.Create;
finalization
 LastComma.Free;
end.



