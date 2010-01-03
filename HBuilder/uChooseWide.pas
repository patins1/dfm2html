unit uChooseWide;

interface

uses
  UseFastStrings, 
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QMask, QForms, QButtons, QDialogs, QTntStdCtrls,
  {$ELSE}
  Dialogs, Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Mask, Forms, Buttons, Spin, UnicodeCtrls,
  {$ENDIF}
  SysUtils, Classes, Types, dhPanel, dhPageControl, dhLabel, binlist, DKLang, MyForm, dhStrUtils;

type
  TChooseUnicode = class(TMyForm)
    dhPage1: TScrollBox;
    IGNORE_dhLabel1: TdhLabel;
    Button1: TTntButton;
    IGNORE_dhLabel2: TdhLabel;
    Button2: TTntButton;
    IGNORE_Label3: TLabel;
    Button3: TTntButton;
    Button4: TTntButton;
    DKLanguageController1: TDKLanguageController;
    IGNORE_Label1: TLabel;
    procedure IGNORE_dhLabel1Click(Sender: TObject);
    procedure IGNORE_dhLabel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure IGNORE_dhLabel1StateTransition(Sender: TdhCustomPanel;
      OldState: TState);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    NextClickedText:WideString;
    procedure UpdateDisplay;
  protected
  public
    ClickedText:array of WideString;
    function GetClickedText:WideString;
    procedure Clear;
    { Public declarations }
  end;

var
  ChooseUnicode: TChooseUnicode;

implementation

{$R *.dfm}

procedure TChooseUnicode.IGNORE_dhLabel1Click(Sender: TObject);
begin
{ if dhLabel1.ClientStyleTree<>nil then
 with dhLabel1.TrackChar[dhLabel1.ClientStyleTree.vn-1] do
  dhLabel2.Caption:=dhLabel2.Caption+abscopy(dhLabel1.Caption,vn,bs);}
 if IGNORE_Label3.Caption<>'' then
 begin
  SetLength(ClickedText,Length(ClickedText)+1);
  ClickedText[high(ClickedText)]:=NextClickedText;
  Button3.Enabled:=Length(ClickedText)<>0;
  Button4.Enabled:=Length(ClickedText)<>0;
 end;
end;

procedure TChooseUnicode.IGNORE_dhLabel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var s,sss:WideString;
    ss:string;
    w:integer;
    uname:string;
    cp:integer;
begin
 ss:='';
 cp:=IGNORE_dhLabel1.CharPos;
 if (cp<>0) then
 begin
  with IGNORE_dhLabel1.TrackChar[cp-1] do
   s:=abscopy(IGNORE_dhLabel1.Text,vn,bs);
  if (s<>'') then
  begin
   sss:=ConvertUnicodeToWideString_(s);
   if length(sss)=1 then
   begin
    w:=ord(sss[1]);
    if w=ord(endl_main) then
    begin
     if IGNORE_Label3.Caption<>'' then
     begin
      s:=NextClickedText;
      ss:=IGNORE_Label3.Caption;
     end else
      s:='';
    end else
    begin
     ss:=CharRefDecimal(w)+' '+CharRef(w);
     if HasUnicodeName(w,uname) then
      ss:=ss+'  &'+uname+';';
    end;
   end;
   IGNORE_dhLabel2.Text:=GetClickedText+'<newchar>'+s+'</newchar>';
   NextClickedText:=s;
  end;
 end else
 begin
  IGNORE_dhLabel2.Text:=GetClickedText;
 end;
 IGNORE_Label3.Caption:=ss;
end;

procedure TChooseUnicode.IGNORE_dhLabel1StateTransition(Sender: TdhCustomPanel;
  OldState: TState);
begin
 if (IGNORE_dhLabel1.LastActStyle=hsNormal) then
  UpdateDisplay;
end;

procedure TChooseUnicode.FormCreate(Sender: TObject);
begin
 FixDialogBorderStyle(Self);
end;

procedure TChooseUnicode.Button4Click(Sender: TObject);
begin
 Clear;
end;

procedure TChooseUnicode.Button3Click(Sender: TObject);
var i:integer;
begin
  if Length(ClickedText)=0 then exit;
  SetLength(ClickedText,Length(ClickedText)-1);
  UpdateDisplay;
end;

function TChooseUnicode.GetClickedText: WideString;
var i:integer;
begin
 result:='';
 for i:=low(ClickedText) to high(ClickedText) do
  result:=result+ClickedText[i];
end;

procedure TChooseUnicode.Clear;
begin  
  SetLength(ClickedText,0);
  UpdateDisplay;
end;

procedure TChooseUnicode.UpdateDisplay;
begin
  IGNORE_dhLabel2.Text:=GetClickedText;
  IGNORE_Label3.Caption:='';
  Button3.Enabled:=Length(ClickedText)<>0;
  Button4.Enabled:=Length(ClickedText)<>0;
end;


end.
