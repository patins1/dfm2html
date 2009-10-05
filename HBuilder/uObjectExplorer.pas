unit uObjectExplorer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, TntForms,
  Dialogs, ComCtrls, Unit2, dhPageControl, MySiz, dhPanel, DKLang;

type
  TObjectExplorer = class(TTntForm)
    tree: TTreeView;
    DKLanguageController1: TDKLanguageController;
    procedure treeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure treeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure treeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure treeChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    selecting,InEvent:Boolean;
    procedure Select(node:TTreeNode; const selectionids:TStringList; const Nodes: TList);
    procedure AddChildren(parentNode:TTreeNode; parent:TComponent);
    function IsContainedInSelection(Child:TControl):boolean;
  public
    { Public declarations }
    procedure UpdateRoot;
    procedure UpdateSelection;
    procedure UpdateRootAndSelection;
    procedure Clear;
  end;

var
  ObjectExplorer: TObjectExplorer;

implementation

uses Unit1, Unit3;

{$R *.dfm}

procedure TObjectExplorer.Select(node:TTreeNode; const selectionids:TStringList; const Nodes: TList);
var childNode:TTreeNode;
begin
  if selectionids.IndexOf(node.Text)<>-1 then
  begin
   Nodes.add(node);
  end;
  childNode:=node.getFirstChild;
  while childNode<>nil do
  begin
   Select(childNode,selectionids,Nodes);
   if selectionids.Count=Nodes.Count then exit;
   childNode:=node.GetNextChild(childNode);
  end;
end;

procedure TObjectExplorer.UpdateRootAndSelection;
begin
 UpdateRoot;
 UpdateSelection;
end;

procedure TObjectExplorer.Clear;
begin
 tree.Items.Clear;
end;

procedure TObjectExplorer.UpdateRoot;
var body:TdhPage;
    rootNode:TTreeNode;
    I:Integer;
    selectionid:String;
begin
 tree.Items.Clear;
 if dhMainForm.Act=nil then exit;
 body:=dhMainForm.Act.MySiz.FindBody;
 if body=nil then exit;
 rootNode:=tree.Items.AddFirst(nil,body.Name);
 AddChildren(rootNode,body);
end;

procedure TObjectExplorer.UpdateSelection;
var SelectionID:String;
    selectionids:TStringList;
    Nodes: TList;
    I:Integer;
begin
 if InEvent then exit;
 if tree.Items.Count<>0 then
 begin
  selectionids:=dhMainForm.Act.MySiz.GetSelectionIDs;
  Nodes:=TList.Create;
  try
   Select(tree.Items[0],selectionids,Nodes);
   selecting:=true;
   try
    tree.Select(Nodes);
   finally
     selecting:=false;
   end;
  finally
   Nodes.Free;
   selectionids.Free;
  end;
 end;
end;

procedure TObjectExplorer.treeChange(Sender: TObject; Node: TTreeNode);
var selectionids:TStringList;
    I:Integer;
begin
 if selecting or (tree.Selected=nil) or (dhMainForm.Act=nil) or _RuntimeMode then exit;
 PreventFocus:=true;
 InEvent:=true;
 selectionids:=TStringList.Create;
 try
  for I := 1 to tree.SelectionCount do
   selectionids.Add(tree.Selections[I-1].Text);
  dhMainForm.Act.MySiz.AddSelectionByIDs(selectionids);
 finally
   selectionids.Free;
   InEvent:=false;
   PreventFocus:=false;
 end;
end;

type TFakeWinControl=class(TWinControl);

function IsContained(Parent,Child:TControl):boolean;
begin
   Child:=GetVirtualParent(Child);
   while Child<>nil do
   begin
    if Parent=Child then
    begin
     Result:=True;
     exit;
    end;
    Child:=GetVirtualParent(Child);
   end;
   Result:=False;
end;

function TObjectExplorer.IsContainedInSelection(Child:TControl):boolean;
var I:Integer;
    Parent:TControl;
begin
   for I := 1 to tree.SelectionCount do
   begin
    Parent:=TControl(dhMainForm.Act.FindComponent(tree.Selections[I-1].Text));
    if IsContained(Parent,Child) then
    begin
      result:=true;
      exit;
    end;
   end;
   result:=false;
end;

procedure TObjectExplorer.treeDragDrop(Sender, Source: TObject; X, Y: Integer);
var I,Position:Integer;
    SourcePn,TargetPn:TControl;
    NewParent:TWinControl;
    PageControl:TdhPageControl;
begin
  TargetPn:=TControl(dhMainForm.Act.FindComponent(tree.DropTarget.Text));
  NewParent:=TargetPn.Parent;
  PageControl:=nil;
  if (TargetPn is TdhPage) and (TdhPage(TargetPn).PageControl<>nil) then
  begin
   PageControl:=TdhPage(TargetPn).PageControl;
  end;
  for I := tree.SelectionCount downto 1 do
  begin
   SourcePn:=TControl(dhMainForm.Act.FindComponent(tree.Selections[I-1].Text));
   if not IsContainedInSelection(SourcePn) then
   if PageControl<>nil then
   begin
    Position:=TdhPage(TargetPn).PageIndex;
    TdhPage(SourcePn).PageIndex:=Position;
    if Position>TdhPage(TargetPn).PageIndex then
     TargetPn:=SourcePn;
   end else
   begin
    SourcePn.Parent:=NewParent;         
    Position:=GetChildPosition(TargetPn);
    TFakeWinControl(NewParent).SetChildOrder(SourcePn,Position);
    if Position>GetChildPosition(TargetPn) then
     TargetPn:=SourcePn;
   end;
  end;
  UpdateRootAndSelection;
  Tabs.Changed('Drag&Drop');
end;

procedure TObjectExplorer.treeDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var I:Integer;
    SourcePn,TargetPn:TControl;
    PageControl:TdhPageControl;
begin
 Accept:=false;
 if (Sender=Source) and (tree.DropTarget<>nil) and (tree.SelectionCount<>0) then
 begin
  TargetPn:=TControl(dhMainForm.Act.FindComponent(tree.DropTarget.Text));
  PageControl:=nil;
  if (TargetPn is TdhPage) and (TdhPage(TargetPn).PageControl<>nil) then
  begin
   PageControl:=TdhPage(TargetPn).PageControl;
  end;
  if (TargetPn=nil) or (TargetPn=dhMainForm.Act.MySiz.FindBody) then exit;
  for I := 1 to tree.SelectionCount do
  begin
   SourcePn:=TControl(dhMainForm.Act.FindComponent(tree.Selections[I-1].Text));
   if (SourcePn=nil) or (SourcePn=TargetPn) or IsContained(SourcePn,TargetPn) then exit;
   if not IsContainedInSelection(SourcePn) then
   if PageControl<>nil then
   begin
     if not (SourcePn is TdhPage) or (TdhPage(SourcePn).PageControl<>PageControl) then exit;
   end else
   begin
     if (SourcePn is TdhPage) and (TdhPage(SourcePn).PageControl<>nil) then exit;
   end;
  end;
  Accept:=true;
 end;
end;

procedure TObjectExplorer.treeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // toggling selection using CTRL+mouseclick or right-click-select not fires a tree change, so simulate it here
  treeChange(Sender,nil);
end;

procedure TObjectExplorer.AddChildren(parentNode:TTreeNode; parent:TComponent);
var children:TMyList;
    child:TComponent;
    childNode:TTreeNode;
    I:Integer;
begin
 children:=TMyList.Create;
 try
   children.AddDirectChildren(parent);
   for I := 0 to children.Count - 1 do
   begin
    child:=children[I];
    childNode:=tree.Items.AddChild(parentNode,child.Name);
    AddChildren(childNode,child);
   end;
 finally
   children.Free;
 end;

end;

end.
