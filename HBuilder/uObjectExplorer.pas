unit uObjectExplorer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, TntForms,
  Dialogs, ComCtrls, Unit2, dhPageControl, MySiz, dhPanel, DKLang;

type
  TObjectExplorer = class(TTntForm)
    tree: TTreeView;
    DKLanguageController1: TDKLanguageController;
    procedure treeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure treeChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    selecting,InEvent:Boolean;
    procedure Select(node:TTreeNode; const selectionids:TStringList; const Nodes: TList);
    procedure AddChildren(parentNode:TTreeNode; parent:TComponent);
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

uses Unit1;

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
  selectionids:=TStringList.Create;
  Nodes:=TList.Create;
  try
   for I := 0 to Tabs.Selection.Count - 1 do
      selectionids.add(TComponent(Tabs.Selection[i]).Name);
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

procedure TObjectExplorer.treeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // toggling selection using CTRL+mouseclick not fires a tree change, so simulate it here
  if ssCtrl in Shift then
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
