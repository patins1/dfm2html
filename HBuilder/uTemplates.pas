unit uTemplates;

interface

{$I GR32.inc}

uses
  SysUtils, Classes, types,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QStdCtrls, QExtCtrls, QComCtrls,QTntStdCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, ExtCtrls, StdCtrls, Dialogs,Buttons,UnicodeCtrls,
{$ENDIF}
  GR32, math, pngimage,dhPanel,Contnrs, dhPageControl,dhMenu, dhLabel,
  dhStyleSheet, DKLang, MyForm, dhStrUtils, dhStyles{$IFDEF COMPILER2009}, GR32_Resamplers{$ENDIF};

type
  TTemplatesWizard = class(TMyForm)
    ListBox1: TTntListBox;
    Button1: TTntButton;
    Button2: TTntButton;
    dhStyleSheet1: TdhStyleSheet;
    STYLE_Link1: TdhLink;
    lEmpty: TdhLabel;
    DKLanguageController1: TDKLanguageController;
    ScrollBox1: TScrollBox;
    tt: TdhPanel;
    procedure ListBox1Click(Sender: TObject);
    procedure STYLE_Link1Click(Sender: TObject);
    procedure STYLE_Link1DblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ScrollBox1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
    ActDown:TPathName;
    function GetDir: TPathName;
  public
    { Public declarations }
    function Prepare(var Filename:TPathName):boolean;
  end;

var
  TemplatesWizard: TTemplatesWizard;

const MyTemplatesDir='My Templates';
      preview='Preview';

function GetRootTemplatesDir:TPathName;

implementation

uses Unit1,Unit3;

{$R *.dfm}

var OldIndex:integer=-1;

function GetRootTemplatesDir:TPathName;
begin
 result:=ExtractFilePath(Application.ExeName)+'Templates'+PathDelim;
end;


function TTemplatesWizard.GetDir:TPathName;
begin
 result:=GetRootTemplatesDir+ListBox1.Items[ListBox1.ItemIndex]+PathDelim;
end;


procedure TTemplatesWizard.ListBox1Click(Sender: TObject);

function GetGraph(graph:TBitmap32; const purename:TPathName): boolean;
var
    bmp,bmp2:TBitmap32;
    b:TBitmap;
    pn:TdhLink;
    i:integer;
var c1,c2:int64;

begin
 try
  bmp:=nil;
  bmp2:=nil;
  b:=TBitmap.Create;
  try
   bmp:=graph;//GetAs32(graph);
   with STYLE_Link1.AllEdgesPure do
    b.Width:=ScrollBox1.Width-16-(Left+Right);
   with STYLE_Link1.AllEdgesPure do
    b.Height:=min(maxint,Ceil(b.Width/graph.Width*graph.Height));
{$IFDEF COMPILER2009}
   TDraftResampler.Create(bmp);
{$ELSE}
   bmp.StretchFilter:=sfDraft;
{$ENDIF}
   bmp2:=TBitmap32.Create;
   bmp2.SetSize(b.Width,b.Height);
   bmp.DrawTo(bmp2,bmp2.BoundsRect,bmp.BoundsRect);
   b.Canvas.CopyRect(Bounds(0,0,b.Width,b.Height),bmp2.Canvas,bmp2.BoundsRect);
   //bmp2.DrawTo(b.Canvas.Handle,0,0); //funzt net unter CLX


   pn:=TdhLink.Create(Self);
   pn.Style.BackgroundImage.Assign(b);

   //pn.Style.LoadImage(GetDir+SearchRec.Name);
   pn.Align:=alTop;
   pn.Top:=-1;
   pn.AutoSizeXY:=asNone;
   pn.Use:=STYLE_Link1;
   pn.ImageType:=bitImage;
   {with Link1.FCommon.AllEdgesPure do
    pn.Height:=min(1023,Ceil((tt.Width-16-(Left+Right))/pn.Style.BackgroundImage.PictureID.Width*pn.Style.BackgroundImage.PictureID.Height+(Top+Bottom)));
   }
   pn.Hint:=purename;
   pn.OnClick:=STYLE_Link1Click;
   pn.OnDblClick:=STYLE_Link1DblClick;
   pn.Parent:=tt;

{   bmp:=GetBitmap32FromPNGObject(graph);
   bmp.DrawMode:=dmBlend;
   bmp.StretchFilter:=sfLanczos;
   ol.Add(bmp);
   ListBox2.Items.Add(Copy(SearchRec.Name,1,Length(SearchRec.Name)-length('.png'))+'.dfm');
}

  finally
   //FreeAndNil(bmp);
   FreeAndNil(bmp2);
   FreeAndNil(b);
  end;

  result:=true;
 except
  result:=false;
 end;
end;

var SearchRec: TSearchRec;
    graph:TBitmap32;
    dfmfile,pngfile,purename:TPathName;
    pc:TPageContainer;
    c1,c2:int64;
    dfmfileAge,pngfileAge:TDateTime;
    ItemIndex:integer;

begin
 ItemIndex:=ListBox1.ItemIndex;
{ if ListBox1.ItemIndex>0 then
 //dhMainForm.Open('C:\HBuilder\Tutorial.dfm',false,true);
 dhMainForm.Open('C:\HBuilder\Templates\Frames\Template1frames.dfm',false,true);
 exit;
 }
 //QueryPerformanceCounter(c1);
 if OldIndex=ItemIndex then exit;
 OldIndex:=ItemIndex;

 ActDown:='';
 Button1.Enabled:=false;
 while tt.ControlCount>0 do
  tt.Controls[0].Free;
 if ItemIndex<0 then exit;
 lEmpty.Visible:=false;
 Update;
 try
 if FindFirst(GetDir+'*.dfm',faAnyFile,SearchRec)=0 then
 repeat
  dfmfile:=GetDir+SearchRec.Name;
  purename:=Copy(SearchRec.Name,1,Length(SearchRec.Name)-length('.dfm'));
  pngfile:=GetRootTemplatesDir+preview+PathDelim+ListBox1.Items[ItemIndex]+'-'+purename+'.bmp';
  if FileAge(dfmfile,dfmfileAge) then
  try
  if not(FileAge(pngfile,pngfileAge) and (pngfileAge>=dfmfileAge)) then
  begin
   pc:=dhMainForm.Open(dfmfile,true,true);
   try
    pc.SaveAsImage(pngfile);
   finally
    pc.Free;
   end;
  end;
  if ItemIndex<>ListBox1.ItemIndex then exit;
  if FileAge(pngfile,pngfileAge) and (pngfileAge>=dfmfileAge) then
  begin
   graph:=TBitmap32.Create;
   try
    graph.LoadFromFile(pngfile);
    GetGraph(Graph,purename);
   finally
    graph.Free;
   end;
  end;
  except
  end;
  Update;
  if ItemIndex<>ListBox1.ItemIndex then exit;
 until FindNext(SearchRec)<>0;
 finally
  SysUtils.FindClose(SearchRec);
 end;
 lEmpty.Visible:=tt.ControlCount=0;

 //QueryPerformanceCounter(c2);
 //showmessage(' - time of comparison: '+inttostr((c2-c1) div 100));

end;

function TTemplatesWizard.Prepare(var Filename:TPathName):boolean;
var SearchRec: TSearchRec;
begin
 ListBox1.Clear;
 if FindFirst(GetRootTemplatesDir+'*',faDirectory,SearchRec)=0 then
 repeat
  if (SearchRec.Name<>'') and (SearchRec.Name[1]<>'.') and (SearchRec.Name<>Preview) then
  if SearchRec.Name=MyTemplatesDir then
   ListBox1.Items.Insert(0,SearchRec.Name) else
   ListBox1.Items.Add(SearchRec.Name);
 until FindNext(SearchRec)<>0;
 SysUtils.FindClose(SearchRec);
 ListBox1.ItemIndex:=OldIndex;
 if ListBox1.ItemIndex=-1 then
  ListBox1.ItemIndex:=0;
 if (ShowModal=mrOk) and (ActDown<>'') then
 begin
  Filename:=ActDown;
  result:=true;
 end else
  result:=false;
end;

procedure TTemplatesWizard.STYLE_Link1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to tt.ControlCount-1 do
  (tt.Controls[i] as TdhLink).Down:=false;
 (Sender as TdhLink).Down:=true;
 ActDown:=GetDir+(Sender as TdhLink).Hint+'.dfm';
 Button1.Enabled:=true;
end;

procedure TTemplatesWizard.STYLE_Link1DblClick(Sender: TObject);
begin
 STYLE_Link1Click(Sender);
 ModalResult:=mrOk;
end;

procedure TTemplatesWizard.FormKeyPress(Sender: TObject; var Key: Char);
begin   
 if Key=Char(VK_ESCAPE) then
 begin
  ModalResult:=mrCancel;
  Key:=#0;
 end;
end;

procedure TTemplatesWizard.FormCreate(Sender: TObject);
begin
 //tt.FVertScrollbarAlwaysVisible:=false;
 ScrollBox1.Anchors:=[akLeft,akTop,akRight,akBottom];
{$IFNDEF CLX}
 ScrollBox1.BevelEdges:=[];
 ScrollBox1.BevelInner:=bvNone;
 ScrollBox1.BevelOuter:=bvNone;
{$ENDIF}
end;

procedure TTemplatesWizard.ScrollBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 ScrollBox1.SetFocus;
end;

procedure TTemplatesWizard.ScrollBox1MouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
 ScrollBox1.VertScrollBar.Position:=ScrollBox1.VertScrollBar.Position-WheelDelta;
end;

end.
