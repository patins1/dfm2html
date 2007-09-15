unit BinTree;

{
A binary tree implementation can insert/delete items in O(log(n)) in contrast
to a binary list, which needs O(n).
Note that HasItem is faster than in TBinList,
I think this is because BinList[i] needs a complex function call
}

interface

uses Classes, math, binlist;

type
  TChildPos=(wcLeft,wcRight);

  PTreeNode=^TTreeNode;
  TTreeNode=record     
  parent:PTreeNode;
  Height:integer;
  Item:Pointer;
  case Integer of
  0:(Child:array[TChildPos] of PTreeNode);
  1:(left,right:PTreeNode);
  end;

  TBinTree=class(IBinOp)
  private
    FRoot:PTreeNode; //the root of the tree
    FCount:Integer; //total count of all nodes
    procedure Insert(Index: PTreeNode; Item: Pointer; Where:TChildPos);
    procedure Delete(Index: PTreeNode);
    function DecreaseBigTree(Index: PTreeNode; Where,
      OtherSide: TChildPos): PTreeNode;
    procedure Repair(Index: PTreeNode);
    procedure AddChild2(Index, Child: PTreeNode; Where: TChildPos);
    class function OuterMost(Index: PTreeNode; Where: TChildPos): PTreeNode;
    class function Neighbour(Index: PTreeNode; Where: TChildPos): PTreeNode;
  protected
    procedure FindLE(Compare: TListSortCompare; Item1: Pointer;
      var Eq: boolean; var Index: PTreeNode; NeedSamePointer:boolean; var Where:TChildPos; NeverFind:boolean);
  public
    destructor Destroy; override;
    function HasItem(Compare: TListSortCompare; Item1: Pointer):Pointer;
    function AddItem(Compare: TListSortCompare; Item1: Pointer):boolean;
    function AddItemIfNotContained(Compare: TListSortCompare; Item1: Pointer):boolean;
    procedure Clear;
    function DeleteItem(Compare: TListSortCompare; Item1: Pointer):boolean;
    procedure CheckConsistency(Compare: TListSortCompare);
    property Count:integer read FCount;
    property Pred[Index: PTreeNode]: PTreeNode index wcLeft read Neighbour;
    property Succ[Index: PTreeNode]: PTreeNode index wcRight read Neighbour;
    function GetFirst:PTreeNode;
    function GetLast: PTreeNode;
    function MinItem: Pointer;
    procedure DeleteMin(Compare: TListSortCompare);
  end;

const OtherSide:array[TChildPos] of TChildPos=(wcRight,wcLeft);
const BoolSide:array[boolean] of TChildPos=(wcLeft,wcRight);

var _2,_DecreaseBigTree:integer;
implementation

{ TBinTree }

{$RANGECHECKS OFF}


function OwnPos(Index:PTreeNode):TChildPos;
begin
 if (Index.parent<>nil) and (Index.parent.Child[wcLeft]=Index) then
  result:=wcLeft else
  result:=wcRight;
end;

procedure AddChild(Index,Child:PTreeNode; Where:TChildPos);
begin
 Index.Child[Where]:=Child;
 if Child<>nil then
  Child.parent:=Index;
end;

procedure TBinTree.AddChild2(Index,Child:PTreeNode; Where:TChildPos);
begin
 if Index<>nil then
  Index.Child[Where]:=Child else
  FRoot:=Child;
 if Child<>nil then
  Child.parent:=Index;
end;

function GetHeight(Index:PTreeNode):integer;
begin
 if Index=nil then
  result:=-1 else
  result:=Index.Height;
end;

function CalcHeight(Index:PTreeNode):boolean;
var h:integer;
begin
 h:=max(GetHeight(Index.Child[wcLeft]),GetHeight(Index.Child[wcRight]))+1;
 result:=Index.Height<>h;
 Index.Height:=h;
end;

function TBinTree.AddItem(Compare: TListSortCompare;
  Item1: Pointer): boolean;
var Index:PTreeNode;
var Where:TChildPos;
begin
 FindLE(Compare,Item1,result,Index,false,Where,true);
 Insert(Index,Item1,Where);
end;

function TBinTree.AddItemIfNotContained(Compare: TListSortCompare;
  Item1: Pointer): boolean;
var Index:PTreeNode;
var Where:TChildPos;
begin
 FindLE(Compare,Item1,result,Index,false,Where,not true);
 if not result then
  Insert(Index,Item1,Where);
end;

function TBinTree.DeleteItem(Compare: TListSortCompare;
  Item1: Pointer): boolean;
var Index:PTreeNode;
var Where:TChildPos;
begin
 FindLE(Compare,Item1,result,Index,true,Where,false);
 if result then
  Delete(Index);
end;

//Delete the node Index from the tree;
//Note that this operation is somehow more sophisticated than inserting a node since
//the node to be deleted need not be a leaf
procedure TBinTree.Delete(Index:PTreeNode);
var BigTree:PTreeNode;
    Where:TChildPos; //where to look for a better node to delete
begin

 Where:=BoolSide[GetHeight(Index.Child[wcRight])>GetHeight(Index.Child[wcLeft])];
 dec(FCount); //..support Tomasulo if possible
 BigTree:=Index.Child[Where];

 if BigTree<>nil then //is Index not a leaf?
 begin
  BigTree:=OuterMost(BigTree,OtherSide[Where]); //find the node, which is nearest to Index from chosen side
  Index.Item:=BigTree.Item; //move this node to the place of Index and set Index to the new place
  Index:=BigTree; //..and now remove that new node instead
  BigTree:=Index.Child[Where]; //get possible not-nil child
 end;

 //now one child of Index is nil, the other child is BigTree (which can be nil, too)
 AddChild2(Index.parent,BigTree,OwnPos(Index)); //remove Index from tree by replacing with child BigTree
 Repair(Index.Parent);
 Dispose(Index); //free finally
end;


function TBinTree.DecreaseBigTree(Index:PTreeNode; Where,OtherSide:TChildPos):PTreeNode;
var BigTree:PTreeNode;
begin
 inc(_DecreaseBigTree);
 BigTree:=Index.Child[Where];
 if GetHeight(BigTree.Child[OtherSide])>GetHeight(BigTree.Child[Where]) then
 begin
  {result:=}assert(DecreaseBigTree(BigTree,OtherSide,Where)=Index.Child[Where]);
  BigTree:=Index.Child[Where];
  assert(GetHeight(BigTree.Child[OtherSide])<=GetHeight(BigTree.Child[Where]));
  //if result then exit;
 end;
 AddChild2(Index.parent,BigTree,OwnPos(Index));
 AddChild(Index,BigTree.Child[OtherSide],Where);
 AddChild(BigTree,Index,OtherSide);
// OldHeight:=Index.Height;
 CalcHeight(Index);
 CalcHeight(BigTree);
 result:=BigTree;
// result:=OldHeight<>BigTree.Height;
end;
                 
procedure TBinTree.Insert(Index:PTreeNode; Item:Pointer; Where:TChildPos);
var BigTree:PTreeNode;
begin
 New(BigTree); 
 inc(FCount); //..support Tomasulo if possible
 BigTree.Height:=0;
 BigTree.Child[wcLeft]:=nil;
 BigTree.Child[wcRight]:=nil;
 BigTree.Item:=Item;
 AddChild2(Index,BigTree,Where);
 Repair(Index);
end;

//repairs height defect and calculates new subtree heights besides;
//only left and right subtree heights of Index may differ by 2; this difference will be leveled by DecreaseBigTree to 1
procedure TBinTree.Repair(Index:PTreeNode);
begin
 //if not((Index<>nil) and not CalcHeight(Index)) then
 while (Index<>nil) do
 begin
  case GetHeight(Index.Child[wcLeft])-GetHeight(Index.Child[wcRight]) of
  -1,0,1: ;//ok
  2 : begin Index:=DecreaseBigTree(Index,wcLeft,wcRight).parent; continue; inc(_2); end;//left tree too big
  -2: begin Index:=DecreaseBigTree(Index,wcRight,wcLeft).parent; continue; inc(_2); end;//right tree too big
  else assert(false);
  end;
  if not CalcHeight(Index) then //if height not changes, we can exit since next height diff. will be the old one (so one of -1,0,1)
    exit;
  Index:=Index.parent
 end;
end;

procedure AssertTree(Compare: TListSortCompare;Index:PTreeNode; var Count:integer);
begin
 inc(Count);
 if Index.left<>nil then
 begin
  //assert(Compare(Index.left.Item,Index.Item)<=0);
  AssertTree(Compare,Index.left,Count);
 end;
 if Index.right<>nil then
 begin
  //assert(Compare(Index.right.Item,Index.Item)>=0);
  AssertTree(Compare,Index.right,Count);
 end;
 assert(not CalcHeight(Index));
 assert(abs(GetHeight(Index.Child[wcLeft])-GetHeight(Index.Child[wcRight]))<=1);
end;

procedure TBinTree.CheckConsistency(Compare: TListSortCompare);
var _Count:integer;
    Index:PTreeNode;
begin
 _Count:=0;
 if FRoot<>nil then
 begin
  _Count:=1;
  Index:=Succ[GetFirst];
  while Index<>nil do
  begin
   assert(Compare(Pred[Index].Item,Index.Item)<=0); 
   Index:=Succ[Index];
   inc(_Count);
  end;
  assert(_Count=Count);
  _Count:=0;
  AssertTree(Compare,FRoot,_Count);
 end;
 assert(_Count=Count);
end;

class function TBinTree.OuterMost(Index:PTreeNode; Where:TChildPos):PTreeNode;
begin
 Result:=Index;
 if Result<>nil then
 while Result.Child[Where]<>nil do
  Result:=Result.Child[Where];
end;


class function TBinTree.Neighbour(Index:PTreeNode; Where:TChildPos):PTreeNode;
begin
 Result:=Index.Child[Where];
 if Result<>nil then
 begin
  Result:=OuterMost(Result,OtherSide[Where]);
 end else
 if (Index.parent<>nil) then
 begin
  while Index.parent.Child[Where]=Index do
  begin
   Index:=Index.Parent;
   if Index.parent=nil then exit;
  end;
  result:=Index.parent;
 end;
end;



procedure TBinTree.FindLE(Compare: TListSortCompare; Item1: Pointer;
  var Eq: boolean; var Index: PTreeNode; NeedSamePointer: boolean; var Where:TChildPos; NeverFind:boolean);
var i,_Index:PTreeNode;
    CompareRes:integer;
begin
 i:=FRoot;
 if i=nil then
 begin
  Index:=nil;
  Where:=wcLeft;
  Eq:=false;
  exit;
 end;
 repeat
// while i<>nil do
 begin
  _Index:=i;
  CompareRes:=Compare(Item1,i.Item);
  if (CompareRes=0) and not NeverFind then
  begin
   Eq:=true;
   Index:=i;
   if NeedSamePointer then
   begin
    repeat
     if Item1=Index.Item then
      exit;
     Index:=Pred[Index];
    until not((Index<>nil) and (Compare(Item1,Index.Item)=0));
    Index:=i;
    repeat
     if Item1=Index.Item then
      exit;
     Index:=Succ[Index];
    until not((Index<>nil) and (Compare(Item1,Index.Item)=0));
    Eq:=false;
   end;
   exit;
  end;
  i:=i.Child[BoolSide[CompareRes>0]];
 end;
 until i=nil;
 Index:=_Index;
 Where:=BoolSide[CompareRes>0]; 
 Eq:=false;
end;


function TBinTree.HasItem(Compare: TListSortCompare;
  Item1: Pointer): Pointer;
var Index:PTreeNode;
    Found:boolean;    
var Where:TChildPos;
begin
 FindLE(Compare,Item1,Found,Index,false,Where,false);
 if Found then
  result:=Index.Item else
  result:=nil;
end;

procedure FreeTree(Index:PTreeNode);
begin
 if Index=nil then exit;
 FreeTree(Index.Child[wcLeft]);
 FreeTree(Index.Child[wcRight]);
 Dispose(Index);
end;

destructor TBinTree.Destroy;
begin
  Clear;
  inherited;
end;

function TBinTree.GetFirst: PTreeNode;
begin
 result:=OuterMost(FRoot,wcLeft);
end;

function TBinTree.GetLast: PTreeNode;
begin
 result:=OuterMost(FRoot,wcRight);
end;


function TBinTree.MinItem: Pointer;
begin
 if FRoot=nil then
  result:=nil else
  result:=OuterMost(FRoot,wcLeft).Item;
end;


procedure TBinTree.DeleteMin(Compare: TListSortCompare);
begin
 if FRoot<>nil then
  Delete(GetFirst);
end;

procedure TBinTree.Clear;
begin     
  FreeTree(FRoot);
  FRoot:=nil;
end;

end.
