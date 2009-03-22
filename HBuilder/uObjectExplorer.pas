unit uObjectExplorer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Unit3, dhPageControl, MySiz, dhPanel;

type
  TObjectExplorer = class(TForm)
    tree: TTreeView;
    procedure treeChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    selecting:Boolean;               
    procedure Select(node:TTreeNode; const selectionid:String);
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

procedure TObjectExplorer.Select(node:TTreeNode; const selectionid:String);
var childNode:TTreeNode;
begin
  if node.Text=selectionid then
  begin
   selecting:=true;
   try
    tree.Select(node);
   finally
     selecting:=false;
   end;
   exit;
  end;
  childNode:=node.getFirstChild;
  while childNode<>nil do
  begin
   Select(childNode,selectionid);
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
begin
 if tree.Items.Count<>0 then
 begin
  Select(tree.Items[0],dhMainForm.cbName.Text);
 end;
end;

procedure TObjectExplorer.treeChange(Sender: TObject; Node: TTreeNode);
begin
 if selecting or (tree.Selected=nil) or (dhMainForm.Act=nil) or _RuntimeMode then exit;
 PreventFocus:=true;
 try
  dhMainForm.Act.MySiz.AddSelectionByID(tree.Selected.Text);
 finally
   PreventFocus:=false;
 end;
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
