unit uPresets;

interface

uses
  SysUtils, Classes, types, funcutils,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QStdCtrls, QExtCtrls, QComCtrls, QDialogs, QMenus, QTntStdCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, ExtCtrls, StdCtrls, Dialogs, Menus, TntForms,
{$ENDIF}
  Unit3, Unit2, dhLabel, dhMenu, dhPanel, dhPageControl, dhStyleSheet, UseFastStrings,
  DKLang, MyForm;

type
  TPresets = class(TMyForm)
    dhStyleSheet1: TdhStyleSheet;
    dhPanel1: TdhPanel;
    dhPanel2: TdhPage;
    STYLE_Link1: TdhLink;
    dhPageControl1: TdhPageControl;
    PopupMenu1: TPopupMenu;
    mInsertObject: TMenuItem;
    mGetStylesOnly: TMenuItem;
    DKLanguageController1: TDKLanguageController;
    procedure mInsertObjectClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure mGetStylesOnlyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    PopupCompo:TComponent;
    procedure SetInsertClick(Child: TComponent);
    procedure ChangePresetsPage(Sender: TObject);
    { Private declarations }
  protected
    procedure CompoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  public
    { Public declarations }
    procedure InsertCompo(Sender: TObject);
    procedure Prepare;
  end;

var
  Presets: TPresets;

implementation

uses Unit1,MySiz;

{$R *.dfm}

{ TPresets }
                
function GetRootPresetsDir:String;
begin
 result:=ExtractFilePath(Application.ExeName)+'Presets'+PathDelim;
end;

                {

procedure TPresets.ComponentRead(Component: TComponent);
begin
 if (Component is TdhLink) and not (Component is TdhPage) then
 begin
  TdhLink(Component).OnClick:=InsertCompo;
  //SetDesignMode(TControl(Component));
//  MySiz.SetControlTo(TControl(Component),true);
 end;
end;          }

procedure TPresets.InsertCompo(Sender:TObject);
var c:TControl;
    FChildList:TList;
    CopyList:TList;
    lLock:boolean;

function IsPasteParent(p:TControl):boolean;
begin
 result:=false;
 if p=nil then exit;
 if (p.Parent<>nil) and (p.Parent.Parent=dhPanel1) then exit;
 if SubEqual('PresetsHelper',p.Name) then exit;
 result:=true;
end;

begin
 if (dhMainForm.Act=nil) or _RuntimeMode then
 begin
  ShowMessage('No target container element selected.');
  exit;
 end;
 glLockWindowUpdate(true,lLock);
 try
 c:=Sender as TControl;
 while IsPasteParent(GetVirtualParent(c)) do
  c:=GetVirtualParent(c);
 if (c<>nil) and (dhMainForm.Act<>nil) then
 begin
  Tabs.CommitChanges;
  FChildList:=TList.Create;
  try
   FChildList.Add(c);
   CopyList:=PrepareCopyList(true,FChildList);
   try
    dhMainForm.Act.PasteComponents(GetCopyComponentsStream(Self,CopyList));
   finally
    CopyList.Free;
   end;
  finally
   FChildList.Free;
  end;
 end;
 finally
  glLockWindowUpdate(false,lLock);
 end;
end;

type TFakeComponent=class(TComponent);

procedure TPresets.SetInsertClick(Child: TComponent);
begin
 TFakeComponent(Child).GetChildren(SetInsertClick,Child.Owner);
 if SubEqual('PresetsHelper',Child.Name) then exit;

 if (Child is TdhCustomPanel) then
 begin
  TdhCustomPanel(Child).OnClick:=InsertCompo;
  TdhCustomPanel(Child).OnMouseUp:=CompoMouseUp;
  //TdhLink(Child).DragMode:=dmAutomatic;
  //Mouse.DragImmediate:=false;
 end;
 if (Child is TdhCustomPanel) then
 begin
  TdhCustomPanel(Child).DragEnabled:=true;
  //TdhCustomPanel(Child).DragCursor:=cr;
 end;
end;




procedure TPresets.Prepare;
var link:TdhLink;
    page:TdhPage;
    NoSel:boolean;
    i:integer;
var SearchRec: TSearchRec;
begin
 NoSel:=dhPageControl1.ActivePage=nil;
 if FindFirst(GetRootPresetsDir+'*.dfm',faAnyFile,SearchRec)=0 then
 repeat

   for i:=0 to dhPanel2.ControlCount-1 do
   if (dhPanel2.Controls[i] as TdhLink).HTMLAttributes=SearchRec.Name then
    SearchRec.Name:='';

   if (SearchRec.Name<>'') and (SearchRec.Name[1]<>'.')  then
   begin
    link:=TdhLink.Create(Self);
    link.Use:=STYLE_Link1;
    link.Align:=alLeft;
    link.Text:=Copy(SearchRec.Name,1,length(SearchRec.Name)-length('.dfm'));
    link.HTMLAttributes:=SearchRec.Name;
    link.Left:=1000;
    link.Parent:=dhPanel2;
    page:=dhPageControl1.AddSheet;
    link.LinkPage:=page;
    link.OnClick:=ChangePresetsPage;
    page.Align:=alClient;
   end;

 until FindNext(SearchRec)<>0;
 SysUtils.FindClose(SearchRec);

 if NoSel then
 if (dhPanel2.ControlCount<>0) and (dhPanel2.Controls[0] is TdhLink) then
  (dhPanel2.Controls[0] as TdhLink).Click;


 if not Visible then
 begin
  Top:=dhMainForm.Height-Height-40;
  Left:=dhMainForm.Width-Width-20;
 end;
 Show;
end;

procedure TPresets.ChangePresetsPage(Sender:TObject);
var link:TdhLink;
    page:TdhPage;  
    Content,filename:string;
    i1,i2:integer;
begin
  link:=Sender as TdhLink;
  page:=link.LinkPage;
  filename:=GetRootPresetsDir+link.HTMLAttributes;
  if CanStringFromFile(filename,Content) and
     bAdvPos(i1,'object',Content,2) and bAdvPosBack(i2,'end',Content,length(Content)) then
  begin
   Content:=AbsCopy(Content,i1,i2);
   GeneralPasteComponentsString(Self,Page,nil{ComponentRead},Content);
   TFakeComponent(page.Controls[0]).GetChildren(SetInsertClick,page.Controls[0].Owner);
   page.Controls[0].Align:=alClient;
   link.OnClick:=nil;
  end else
   ShowMessage('Cannot open '+filename);
end;

procedure TPresets.mInsertObjectClick(Sender: TObject);
begin
// InsertCompo(Sender);
 InsertCompo(PopupCompo);
end;

procedure TPresets.PopupMenu1Popup(Sender: TObject);
begin
 PopupCompo:=iControlAtPos(Self,Mouse.CursorPos);
 //if (PopupCompo<>nil) and not PopupCompo.DragEnabled then
end;

procedure TPresets.mGetStylesOnlyClick(Sender: TObject);
begin
 if dhMainForm.Act=nil then
 begin
  ShowMessage('No object selected.');
  exit;
 end;
 Unit2.Tabs.CommitChanges;
 Tabs.PullStyles(PopupCompo as TdhCustomPanel,true);
end;

procedure TPresets.FormCreate(Sender: TObject);
begin
 dhPanel2.FVertScrollbarAlwaysVisible:=false;
{$IFNDEF CLX}
 mInsertObject.Default:=true;
{$ENDIF}
end;

procedure TPresets.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=Char(VK_ESCAPE) then
 begin
  Close;
  Key:=#0;
 end;
end;


procedure TPresets.CompoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then
 with Mouse.CursorPos do
 PopupMenu1.Popup(X,Y);
end;


end.
