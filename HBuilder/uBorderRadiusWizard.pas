unit uBorderRadiusWizard;

interface

uses
  SysUtils, Classes, types,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QStdCtrls, QExtCtrls, QComCtrls, QTntStdCtrls,
  QMask,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd, Spin, UnicodeCtrls,
{$ENDIF}
  GR32, GR32_Image,math,
  hComboBox,unit3,dhPanel, MyTrackBar,  MySpinEdit, dhLabel, dhMenu,
  dhStyleSheet, DKLang, dhStyles;

type
  TBorderRadiusWizard = class(TTntForm)
    STYLE_dhStyleSheet1: TdhStyleSheet;
    STYLE_Link1: TdhLink;
    CornerNavigation: TdhPanel;
    cAll: TdhLink;
    cBottomLeft: TdhLink;
    cTopLeft: TdhLink;
    cTopRight: TdhLink;
    cBottomRight: TdhLink;
    Button1: TTntButton;
    Button2: TTntButton;
    bClear: TTntButton;
    STYLE_nob: TdhLabel;
    STYLE_Label4: TdhLabel;
    STYLE_Label3: TdhLabel;
    STYLE_Label5: TdhLabel;
    STYLE_Link2: TdhLink;
    Panel1: TPanel;
    cBoth: TTntCheckBox;
    cHorz: TMySpinEdit;
    MyTrackBar1: TMyTrackBar;
    tbVert: TMyTrackBar;
    cVert: TMySpinEdit;
    Label2: TdhLabel;
    Label1: TdhLabel;
    bClearAct: TTntButton;
    dhLabel1: TdhLabel;
    DKLanguageController1: TDKLanguageController;
    procedure FormCreate(Sender: TObject);
    procedure cAllClick(Sender: TObject);
    procedure cBothClick(Sender: TObject);
    procedure bClearActClick(Sender: TObject);
    procedure bClearClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cHorzValueChange(Sender: TObject; Clear: Boolean);
    procedure cBottomRightStateTransition(Sender: TdhCustomPanel;
      OldState: TState);
  private
    { Private declarations }
    LastBut:TdhLink;
    al:TCornerAlign;
    Adjusting:boolean;
    Selection:TList;
    procedure UpdateAllBorders;
    procedure UpdateRadiusDisplay;
    procedure LiveRadiusChanged;
    function ActStyle: TStyle;
  public
    { Public declarations }
    procedure Prepare(Selection: TList);
  end;

var
  BorderRadiusWizard: TBorderRadiusWizard;

implementation

uses Unit2;

{$R *.dfm}

procedure TBorderRadiusWizard.FormCreate(Sender: TObject);
var Alpha:Byte;

function Mix(c1:TColor; c2:TCSSColor):TCSSColor;
var r:TColor32;
begin
 r:=GetPixelCombineNormal(CSSColorToColor32(c2),Color32(c1),Alpha);
 result:=Color32ToCSSColor(r);
end;

begin
 FixDialogBorderStyle(Self);
 SetPrecise(CornerNavigation);
 //cAll.NoSiblingsBackground:=true;
 STYLE_Link2.StyleDown.BackgroundColor:=STYLE_Link2.Style.BackgroundColor;
 STYLE_Link2.StyleDown.Color:=STYLE_Link2.FontColor;
 STYLE_Link2.StyleDown.Border.Color:=STYLE_Link2.Style.Border.Color;
 STYLE_Link2.Style.Effects.Enabled:=False;
 STYLE_Link2.StyleDown.Effects.Enabled:=False;
 Alpha:=STYLE_Link2.Style.Effects.Alpha;

 STYLE_Link2.Style.BackgroundColor:=Mix(Color,STYLE_Link2.Style.BackgroundColor);
 STYLE_Link2.Style.Color:=Mix(Color,STYLE_Link2.StyleDown.Color);
 STYLE_Link2.Style.Border.Color:=Mix(Color,STYLE_Link2.Style.Border.Color);

// Alpha:=Alpha
 cAll.StyleDown.Border.Color:=ApplyDark(STYLE_Link2.StyleDown.Border.Color,20);

 cAll.Style.Effects.TextExclude:=true;

end;

procedure TBorderRadiusWizard.cAllClick(Sender: TObject);
var c:TdhLink;
begin
 if LastBut<>nil then
  LastBut.Down:=false;
 LastBut:=Sender as TdhLink;
 LastBut.Down:=true;
 if LastBut=cAll then al:=calNone;
 if LastBut=cTopLeft then al:=calTopLeft;
 if LastBut=cTopRight then al:=calTopRight;
 if LastBut=cBottomLeft then al:=calBottomLeft;
 if LastBut=cBottomRight then al:=calBottomRight;
 UpdateRadiusDisplay;
end;

procedure TBorderRadiusWizard.Prepare(Selection: TList);
begin
 Self.Selection:=Selection;
 if LastBut=nil then
  cAllClick(cAll);
 UpdateRadiusDisplay;
end;

function TBorderRadiusWizard.ActStyle:TStyle;
begin
 result:=(TObject(Selection[0]) as TdhCustomPanel).ActStyle;
end;



procedure TBorderRadiusWizard.UpdateRadiusDisplay;
var pn:TdhCustomPanel;

{procedure SetCleared(pn:TdhLink; IsCleared:boolean);
begin
 if IsCleared then
  pn.Style.TextDecoration:=[] else
  pn.Style.TextDecoration:=[ctdUnderline];
end;    }

const OnlyOneRadius=not true;

begin
 Adjusting:=true;
 pn:=ActStyle.Owner.GetControl as TdhCustomPanel;
 cBoth.Checked:=pn.IsBorderRadiusTwoValued(al);
 Label1.Visible:=cBoth.Checked;
 dhLabel1.Visible:=not cBoth.Checked;
 {if not cBoth.Checked then
  Label1.Caption:='Radius' else
  Label1.Caption:='Horz. Radius';
  }
 //cVert.Enabled:=cBoth.Checked;
 tbVert.Enabled:=cBoth.Checked;
 Label2.Enabled:=cBoth.Checked;
 cBoth.Visible:=cBoth.Checked or not OnlyOneRadius;
 cVert.Visible:=cBoth.Checked;
 tbVert.Visible:=cBoth.Checked;
 Label2.Visible:=cBoth.Checked;
 cHorz.StoredValue:=pn.GetBorderRadius(al).X;
 cVert.StoredValue:=pn.GetBorderRadius(al).Y;
 bClear.Enabled:=not ActStyle.BorderRadius.IsCleared;
 bClearAct.Enabled:=not ActStyle.BorderRadius.IsCleared(al);
 //bClearAct.Caption:='Reset '+sBorderCorner[al];
 SetUnderlineState(cAll,ActStyle.BorderRadius.IsCleared(calNone));
 SetUnderlineState(cTopLeft,ActStyle.BorderRadius.IsCleared(calTopLeft));
 SetUnderlineState(cTopRight,ActStyle.BorderRadius.IsCleared(calTopRight));
 SetUnderlineState(cBottomLeft,ActStyle.BorderRadius.IsCleared(calBottomLeft));
 SetUnderlineState(cBottomRight,ActStyle.BorderRadius.IsCleared(calBottomRight));

 UpdateAllBorders;

 CornerNavigation.Update;
 Adjusting:=false;
end;

procedure TBorderRadiusWizard.UpdateAllBorders;

function GetBorderColor(c:TdhLink):TCSSColor;
begin
 result:=STYLE_Link2.Style.Border.Color;
 if (c.State in [hsDown,hsOverDown]) then
  result:=cAll.StyleDown.Border.Color;
end;

begin
 cAll.Style.BorderTop.Color:=GetBorderColor(cTopLeft);
 cAll.Style.BorderRight.Color:=GetBorderColor(cTopRight);
 cAll.Style.BorderBottom.Color:=GetBorderColor(cBottomRight);
 cAll.Style.BorderLeft.Color:=GetBorderColor(cBottomLeft);
end;


procedure TBorderRadiusWizard.cBothClick(Sender: TObject);
begin
 if Adjusting then exit;
 LiveRadiusChanged;
end;

procedure TBorderRadiusWizard.LiveRadiusChanged;
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TdhCustomPanel) do
 if not cBoth.Checked then
  ActStyle.BorderRadius.SetBorderRadius(al,inttostr(cHorz.Value)) else
  ActStyle.BorderRadius.SetBorderRadius(al,inttostr(cHorz.Value)+' '+inttostr(cVert.Value));
 UpdateRadiusDisplay;
end;


procedure TBorderRadiusWizard.bClearActClick(Sender: TObject);   
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TdhCustomPanel) do
 ActStyle.BorderRadius.SetBorderRadius(al,'');
 UpdateRadiusDisplay;
end;

procedure TBorderRadiusWizard.bClearClick(Sender: TObject);  
var i:integer;
begin
 for i:=0 to Selection.Count-1 do
 with (TObject(Selection[i]) as TdhCustomPanel) do
 ActStyle.BorderRadius.Clear;
 UpdateRadiusDisplay;
end;

procedure TBorderRadiusWizard.FormKeyPress(Sender: TObject; var Key: Char);
begin    
 if Key=Char(VK_ESCAPE) then
 begin
  ModalResult:=mrCancel;
  Key:=#0;
 end;
end;

procedure TBorderRadiusWizard.cHorzValueChange(Sender: TObject;
  Clear: Boolean);
begin
 LiveRadiusChanged;
end;

procedure TBorderRadiusWizard.cBottomRightStateTransition(
  Sender: TdhCustomPanel; OldState: TState);
begin
 UpdateAllBorders;
end;

end.
