unit BinList;

interface

uses Classes;


type IBinOp=interface
     function HasItem(Compare: TListSortCompare; Item1: Pointer):Pointer;
     function AddItem(Compare: TListSortCompare; Item1: Pointer):boolean;
     function DeleteItem(Compare: TListSortCompare; Item1: Pointer):boolean;
end;

type TBinList=class(TList)
  private
  protected
    procedure FindLE(Compare: TListSortCompare; Item1: Pointer;
      var Eq: boolean; var Index: integer; NeedSamePointer:boolean);
  public
    function SortedIndexOf(Compare: TListSortCompare; Item1: Pointer): Integer;
     function HasItem(Compare: TListSortCompare; Item1: Pointer):Pointer;
     function AddItem(Compare: TListSortCompare; Item1: Pointer):boolean;
     function DeleteItem(Compare: TListSortCompare; Item1: Pointer):boolean;
     procedure CheckConsistency(Compare: TListSortCompare);
     function MinItem:Pointer;
     procedure ClearFast;
     function AddItemGetIndex(Compare: TListSortCompare; Item1: Pointer): integer;
  end;

function PointerCompare(Item1, Item2: Pointer): Integer;

implementation


{ TBinList }
                   
{$RANGECHECKS OFF}
{$OVERFLOWCHECKS OFF}

function PointerCompare(Item1, Item2: Pointer): Integer;
begin

 //result:=Integer(Item1)-Integer(Item2);// is not the same: if i1-i2>2^31, Integer(i1-i2) is negative!
 if Integer(Item1)>Integer(Item2) then
  result:=1 else
 if Integer(Item1)=Integer(Item2) then
  result:=0 else
  result:=-1;
end;


function TBinList.AddItem(Compare: TListSortCompare;
  Item1: Pointer): boolean;
var Index:integer;
begin
 FindLE(Compare,Item1,result,Index,false);
 Insert(Index,Item1);
end;

function TBinList.AddItemGetIndex(Compare: TListSortCompare; Item1: Pointer): integer;
var Eq:boolean;
begin
 FindLE(Compare,Item1,Eq,result,false);
 Insert(result,Item1);
end;

procedure TBinList.CheckConsistency(Compare: TListSortCompare);
var i:integer;
begin
 for i:=1 to Count-1 do  
  assert(Compare(Items[i-1],Items[i])<=0);
end;

procedure TBinList.ClearFast;
begin
 SetCount(0);
end;

function TBinList.DeleteItem(Compare: TListSortCompare;
  Item1: Pointer): boolean;
var Index:integer;
begin
 FindLE(Compare,Item1,result,Index,true);
 if result then
  Delete(Index);
end;
       {
var bnd:record
  case byte of
        0:(lo,hi:integer);
        1:(sw:array[boolean] of integer);
  end;   }


  (*
procedure TBinList.FindLE(Compare: TListSortCompare; Item1:Pointer; var Eq:boolean; var Index:integer; NeedSamePointer:boolean);
var CompareRes:integer;
    lo,hi,i:integer;
begin
 lo:=Integer(@Self.List[0]);
 assert(@Self.List[0]=Self.List);
 if Self.Count<>0 then
 begin
 assert(lo mod 4=0);
 hi:=Integer(@Self.List[Self.Count-1]);
 while lo<=hi do
 begin
  i:=((lo+hi) shr 1) and not 3;
  CompareRes:=Compare(Item1,PPointer(i)^);
  if CompareRes=0 then
  begin
   Eq:=true;
   Index:=(i-Integer(@Self.List[0])) shr 2;
   if NeedSamePointer then
   begin
    repeat
     if Item1=List[Index] then
      exit;
     dec(Index);
    until not((Index>=0) and (Compare(Item1,List[Index])=0));
    Index:=i;
    repeat
     if Item1=List[Index] then
      exit;
     inc(Index);
    until not((Index<=Count-1) and (Compare(Item1,List[Index])=0));
    Eq:=false;
   end;
   exit;
  end;
  if CompareRes>0 then
   lo:=i+4 else
   hi:=i-4;
 end;
 end;
 Index:=(lo-Integer(@Self.List[0])) shr 2;
 Eq:=false;
 {
 if Index<=Count-1 then
  assert(Compare(Item1,Items[Index])<=0) else
 if Count<>0 then
  assert(Compare(Item1,Items[Count-1])>0);}
end;

*)


procedure TBinList.FindLE(Compare: TListSortCompare; Item1:Pointer; var Eq:boolean; var Index:integer; NeedSamePointer:boolean);
var lo,hi,i,CompareRes:integer;
    Items:PPointerList;
begin
 //with bnd do
 begin
 lo:=0;
 hi:=Count-1;
 Items:=Self.List;
 while lo<=hi do
 begin
  i:=(lo+hi) shr 1;
  CompareRes:=Compare(Item1,Items[i]);
  if CompareRes=0 then
  begin
   Eq:=true;
   Index:=i;
   if NeedSamePointer then
   begin
    repeat
     if Item1=Items[Index] then
      exit;
     dec(Index);
    until not((Index>=0) and (Compare(Item1,Items[Index])=0));
    Index:=i;
    repeat
     if Item1=Items[Index] then
      exit;
     inc(Index);
    until not((Index<=Count-1) and (Compare(Item1,Items[Index])=0));
    Eq:=false;
   end;
   exit;
  end;
  if CompareRes>0 then
   lo:=i+1 else
   hi:=i-1;  
 end;
 Index:=lo;
 Eq:=false;
 end;
 {
 if Index<=Count-1 then
  assert(Compare(Item1,Items[Index])<=0) else
 if Count<>0 then
  assert(Compare(Item1,Items[Count-1])>0);}
end;

function TBinList.HasItem(Compare: TListSortCompare;
  Item1: Pointer): Pointer;
var Index:integer;
    Found:boolean;
begin
 FindLE(Compare,Item1,Found,Index,false);
 if Found then
  result:=Items[Index] else
  result:=nil;
end;

function TBinList.SortedIndexOf(Compare: TListSortCompare; Item1: Pointer): Integer;
var Found:boolean;
begin
 FindLE(Compare,Item1,Found,Result,false);
 if not Found then
  Result:=-1;
end;


function TBinList.MinItem: Pointer;
begin
 if Count<>0 then
  result:=Items[0] else
  result:=nil;
end;

end.
 