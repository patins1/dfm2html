unit dhMultilineCaptionEdit;

interface

uses
  Types, BasicHTMLElements,
  {$IFDEF CLX}
  QControls, QGraphics, QForms, QButtons, QStdCtrls, Qt, QDialogs, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, Graphics, Forms, StdCtrls, Dialogs, Menus, Buttons, UnicodeCtrls,
  {$ENDIF}
  Classes, dhStyleSheet, dhPanel, dhLabel, dhPageControl, dhMenu, UseFastStrings, Math, DKLang, MyForm,dhStrUtils,uMetaWriter,
  SynEditHighlighter, SynHighlighterHtml, SynEdit, SynMemo;

type
  TdhMultilineCaptionEdit2 = class(TMyForm)
    OKButton: TTntButton;
    CancelButton: TTntButton;
    Memo1: TSynMemo;
    SpeedButton1: TTntSpeedButton;
    SpeedButton2: TTntSpeedButton;
    SpeedButton3: TTntSpeedButton;
    SpeedButton4: TTntSpeedButton;
    SpeedButton5: TTntSpeedButton;
    SpeedButton6: TTntSpeedButton;
    SpeedButton7: TTntSpeedButton;
    SpeedButton8: TTntSpeedButton;
    DKLanguageController1: TDKLanguageController;
    TBasicHTMLElements1: TBasicHTMLElements;
    SynHTMLSyn1: TSynHTMLSyn;
    procedure HelpButtonClick(Sender: TObject);
    procedure CodeWndBtnClick(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure pClick(Sender: TObject);
    procedure dtClick(Sender: TObject);
    procedure hrClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Memo1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    procedure Memo1Change(Sender: TObject);
    procedure EmSetSel(vn, bs: integer);
    function FirstComp: TdhLabel;
  protected
    Comps:TList;
    procedure SetSel(const s:WideString);
 public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    class function Prepare2(Comps:TList):boolean;
    function Prepare3(Comps:TList):boolean;
    function Execute(var NewStr:HypeString; vn:integer=0):boolean;
    procedure VisitProc(NewComp:TComponent);

  end;


var dhMultilineCaptionEdit2:TdhMultilineCaptionEdit2;

implementation

{$R *.dfm}

uses SysUtils,  TypInfo, uChooseWide;

procedure TdhMultilineCaptionEdit2.HelpButtonClick(Sender: TObject);
begin      
{$IFDEF CLX}     
  Application.ContextHelp(HelpContext);
{$ELSE}
  Application.HelpContext(HelpContext);
{$ENDIF}
end;

procedure TdhMultilineCaptionEdit2.CodeWndBtnClick(Sender: TObject);
begin
  ModalResult := mrYes;
end;


procedure TdhMultilineCaptionEdit2.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   CancelButton.Click;
end;

procedure TdhMultilineCaptionEdit2.SetSel(const s:WideString);
var start:integer;
begin
 start:=Memo1.SelStart;
 Memo1.SelText:='';
 Memo1.SelText:=s;
 Memo1.SelStart:=start;
 Memo1.SelLength:=length(s);
{$IFDEF CLX}
 Memo1.OnChange(nil);
{$ENDIF}
// showmessage(memo.seltext+#13#10+s+#13#10+inttostr(length(s)));
end;



procedure TdhMultilineCaptionEdit2.SpeedButton1Click(Sender: TObject);
begin
 TBasicHTMLElements1.b.Click;
end;

procedure TdhMultilineCaptionEdit2.SpeedButton2Click(Sender: TObject);
begin
 TBasicHTMLElements1.i.Click;
end;

procedure TdhMultilineCaptionEdit2.SpeedButton3Click(Sender: TObject);
begin
 TBasicHTMLElements1.u.Click;
end;

procedure TdhMultilineCaptionEdit2.SpeedButton4Click(Sender: TObject);
begin
 SetSel('<br/>'+Memo1.SelText);
end;

procedure TdhMultilineCaptionEdit2.SpeedButton5Click(Sender: TObject);
begin
 SetSel(ConvertWideStringToUnicode(Memo1.SelText,false));
end;

procedure TdhMultilineCaptionEdit2.pClick(Sender: TObject);
begin
 SetSel('<'+(Sender as TComponent).Name+'>'+Memo1.SelText+'</'+(Sender as TComponent).Name+'>');
end;

destructor TdhMultilineCaptionEdit2.Destroy;
begin
 inherited;
 //StringToFile('c:\de2.txt','Fehler');
end;



procedure TdhMultilineCaptionEdit2.dtClick(Sender: TObject);
var s:TComponentName;
begin
 s:=(Sender as TdhLabel).Use.GetName;
// showmessage('<'+s+'>'+Memo1.SelText+'</'+s+'>');
 SetSel('<'+s+'>'+Memo1.SelText+'</'+s+'>');
end;



constructor TdhMultilineCaptionEdit2.Create(AOwner: TComponent);
begin
 inherited;
// StringToFile('c:\cr2.txt','Fehler');
end;


procedure TdhMultilineCaptionEdit2.hrClick(Sender: TObject);
begin                
 SetSel('<hr/>'+Memo1.SelText);
end;


class function TdhMultilineCaptionEdit2.Prepare2(Comps:TList):boolean;
var ii:integer;
begin

  if not AssertTags2 then
  begin
   showmessage('Failed to create form');
   result:=false;
   exit;
  end;
  result:=dhMultilineCaptionEdit2.Prepare3(Comps);
end;

function TdhMultilineCaptionEdit2.Prepare3(Comps:TList):boolean;
var ii:integer;
begin

  if not AssertTags2 then
  begin
   showmessage('Failed to create form');
   result:=false;
   exit;
  end;
  TBasicHTMLElements1.dhStyleSheet1.DisableAlign;
   {
  dhMultilineCaptionEdit2.dhPanel1.DisableAlign;
  dhMultilineCaptionEdit2.dhPanel2.DisableAlign;       }


  for ii:=TBasicHTMLElements1.dhStyleSheet1.ControlCount-1 downto 0 do
   (TBasicHTMLElements1.dhStyleSheet1.Controls[ii] as TWinControl).HandleNeeded;

 Self.Comps:=Comps;
   result:=true;

end;

type
  TAccessControl = class(TControl);

  (*
function TntControl_GetText(Control: TWinControl): WideString;
begin
{  if ((Control is TWinControl) and TWinControl(Control).HandleAllocated and (not IsWindowUnicode(TWinControl(Control).Handle))) then
    // Win9x / non-unicode handle
    Result := TAccessControl(Control).Text
  else} begin
    // UNICODE & HANDLE
    SetLength(Result, GetWindowTextLengthW(TWinControl(Control).Handle) + 1);
    GetWindowTextW(TWinControl(Control).Handle, PWideChar(Result), Length(Result));
    SetLength(Result, Length(Result) - 1);
  end;
end;
*)

procedure TdhMultilineCaptionEdit2.Memo1Change(Sender: TObject);
var
  Temp: WideString;
  i:integer;
begin
      Temp := Memo1.Text;
      //Temp:=TntControl_GetText(Memo1);

      while (Length(Temp) > 0) and (Temp[Length(Temp)] < ' ') do
        Delete(Temp, Length(Temp), 1);
      for i:=0 to Comps.Count-1 do
       TdhLabel(Comps[i]).Text:=Temp;
      //SetStrValue(Temp);

//      Comp.Update;
end;

function TdhMultilineCaptionEdit2.FirstComp:TdhLabel;
begin
 result:=TdhLabel(Comps[0]);
end;


function TdhMultilineCaptionEdit2.Execute(var NewStr:HypeString; vn:integer=0):boolean;
var ii:integer;
    line,col,CharNo:integer;
    comp:TComponent;
    newPos:TBufferCoord;
begin
 NewStr:=FirstComp.Text;
//  c:=dhMultilineCaptionEdit2.TBasicHTMLElements1.dhStyleSheet1.Controls[dhMultilineCaptionEdit2.TBasicHTMLElements1.dhStyleSheet1.ControlCount-1];
//  c2:=
//  showmessage(c.name+' '+inttostr(c.Top));
  {dhMultilineCaptionEdit2.dhPanel2.EnableAlign;
  dhMultilineCaptionEdit2.dhPanel1.EnableAlign;    }
//  showmessage(c.name+' '+inttostr(c.Top));
  TBasicHTMLElements1.dhStyleSheet1.EnableAlign;
  TBasicHTMLElements1.dhStyleSheet1.Realign;
//  dhMultilineCaptionEdit2.TBasicHTMLElements1.dhStyleSheet1.Realign;
//  showmessage(c.name+' '+inttostr(c.Top)+' '+booltostr(dhMultilineCaptionEdit2.TBasicHTMLElements1.dhStyleSheet1.AlignDisabled,true));
  try

    Memo1.WordWrap:=false;//not((Comp is TdhCustomPanel) and TdhCustomPanel(Comp).AutoSize);
      Caption := {dhMultilineCaptionEdit2.name+' - '+}{'MultiLine Caption - '+}FirstComp.Name {+ '.' + GetName }
    ;
    //Temp2:=NewStr;

    Memo1.OnChange:=nil;
    //Memo1.Font.Name:=FirstComp.NearestFontFamily;

    Memo1.Lines.Text:=NewStr;
    if vn>=1 then
    begin
     line:=0;
     col:=vn-1;
     for ii:=1 to Math.min(vn,length(NewStr)) do
     if NewStr[ii]=endl_main then
     begin
      inc(line);
      col:=vn-ii-1;
     end;
     if Memo1 is TSynMemo then
     begin
       newPos.Char:=col+1;
       newPos.Line:=line+1;
       Memo1.CaretXY := newPos;
     end else
     begin
{$IFDEF CLX}
     CharNo := Memo1.CaretPosToPos(CaretPos(line,0));
{$ELSE}
     CharNo := Memo1.Perform(EM_LineIndex, line, 0);
{$ENDIF}
     Memo1.SelStart:=CharNo+col;
     end;
    end;
    //Memo1.MaxLength := GetEditLimit;
    Memo1.OnChange:=Memo1Change;

    //UpdateStatus(nil);
//  showmessage(c.name+' '+inttostr(c.Top));
    ActiveControl:=Memo1;
    result:=ShowModal = mrOk;
    NewStr := Memo1.Text;
    //  NewStr:=Temp2;
//  showmessage(c.name+' '+inttostr(c.Top));
    Memo1.OnChange:=nil;
  finally

  TBasicHTMLElements1.dhStyleSheet1.DisableAlign;
  {dhMultilineCaptionEdit2.dhPanel1.DisableAlign;
  dhMultilineCaptionEdit2.dhPanel2.DisableAlign;

          }
  for ii:=TBasicHTMLElements1.dhStyleSheet1.ControlCount-1 downto 0 do
  if (TBasicHTMLElements1.dhStyleSheet1.Controls[ii] is TdhLabel) and
     (TdhLabel(TBasicHTMLElements1.dhStyleSheet1.Controls[ii]).Use<>nil) and (TdhLabel(TBasicHTMLElements1.dhStyleSheet1.Controls[ii]).Use.GetCommon.Owner<>TBasicHTMLElements1)
     {(TdhRule(TBasicHTMLElements1.dhStyleSheet1.Controls[ii]).Top<=dhLabel1.Top)} then
   TBasicHTMLElements1.dhStyleSheet1.Controls[ii].Free;

 { for ii:=dhMultilineCaptionEdit2.dhPanel1.ControlCount-1 downto 0 do
   dhMultilineCaptionEdit2.dhPanel1.Controls[ii].Free;
  for ii:=dhMultilineCaptionEdit2.dhPanel2.ControlCount-1 downto 0 do
   dhMultilineCaptionEdit2.dhPanel2.Controls[ii].Free;

  dhMultilineCaptionEdit2.dhPanel1.EnableAlign;
  dhMultilineCaptionEdit2.dhPanel2.EnableAlign; }
  TBasicHTMLElements1.dhStyleSheet1.EnableAlign;
  end;
      while (Length(NewStr) > 0) and (NewStr[Length(NewStr)] < ' ') do
        Delete(NewStr, Length(NewStr), 1);
end;

procedure TdhMultilineCaptionEdit2.VisitProc(NewComp:TComponent);
var pn:TdhCustomPanel;
    p:TdhLink;
begin

 try
 if UsefulUse(NewComp,Comps,false,pn) then
 begin
  //showmessage(s+' is good');
        {
  if Common.Control.ClassName='TdhLink' then
   p:=TdhLink.Create(dhMultilineCaptionEdit2) else  }
  p:=TdhLink.Create(TBasicHTMLElements1);
  p.IsDlg:=true;
  p.OnClick:=dtClick;
  p.Align:=alTop;
  if (NewComp is TdhDynLabel) then
   p.Layout:=TdhDynLabel(NewComp).ComputedLayout else
   p.Layout:=ltText;

       {
  if Common.Control.ClassName='TdhLink' then
   p.Parent:=dhMultilineCaptionEdit2.dhPanel2 else
   p.Parent:=dhMultilineCaptionEdit2.dhPanel1;   }

//  p.Left:=0;
  if pn.ClassName='TdhLink' then
   p.Top:=TBasicHTMLElements1.dhLabel2.Top else
   p.Top:=TBasicHTMLElements1.dhLabel3.Top;
  p.Use:=pn;
  if pn is TdhLabel then
   p.Text:=(pn as TdhLabel).Text;
  p.Hint:=NewComp.Name;
  p.ShowHint:=true;
  p.Parent:=TBasicHTMLElements1.dhStyleSheet1;
  p.HandleNeeded;
//  p.Top:=-1000;

 end else
  //showmessage(s+' failed');
 except
 end;
end;


procedure TdhMultilineCaptionEdit2.FormCreate(Sender: TObject);
var i:integer;
begin
//         TBasicHTMLElements1.dhStyleSheet1.Anchors:=[akBottom,akRight,akTop];
         TBasicHTMLElements1.Anchors:=[akBottom,akRight,akTop];
         Memo1.OnChange:=Memo1Change;

 for i:=0 to TBasicHTMLElements1.dhStyleSheet1.ControlCount-1 do
 if (TBasicHTMLElements1.dhStyleSheet1.Controls[i] is TdhLink) then
  TdhCustomPanel(TBasicHTMLElements1.dhStyleSheet1.Controls[i]).IsDlg:=true;
              
{$IFNDEF CLX}
 Memo1.HideSelection:=False;
{$ENDIF}
end;

procedure TdhMultilineCaptionEdit2.EmSetSel(vn,bs:integer);
begin
{$IFDEF CLX}
 Memo1.SelStart:=vn-1;
 Memo1.SelLength:=bs-vn;
{$ELSE}
 SendMessage(Memo1.Handle, EM_SETSEL, vn-1,bs-1);
{$ENDIF}
end;


procedure TdhMultilineCaptionEdit2.SpeedButton6Click(Sender: TObject);
var itagbs:integer;
    vn:integer;
    s:WideString;
    text:WideString;
    tag:HypeString;
    Closing,EmptyEle:boolean;
    itag,start_itag,close_itag:TPoint;
    ouritag:integer;

procedure GetPosi(ourtag:string);
var _itag:TPoint;
begin
 _itag:=itag;
 while getTag2(s,vn,itag.x,itag.y,tag,text,Closing,EmptyEle) do
 begin
 itag.x:=CharPosBack(s,'<',itag.x);
 itag.y:=CharPos(s,'>',itag.y)+1;
 if (ouritag>=itag.x) and (ouritag<itag.y) then
 if Closing then
 begin
  if (tag=ourtag) then
   start_itag:=_itag;
  close_itag:=itag;
 end else
 if not Closing then
 begin
  start_itag:=itag;
 end;

 if tag<>'br' then
 if Closing then
 begin
  if tag=ourtag then
  begin
   if EqualPoint(start_itag,_itag) then
    close_itag:=itag;
   exit;
  end;
 end else
 if not EmptyEle then
 begin
  GetPosi(tag);
 end;
 end;
end;


begin
 s:=Memo1.Text;
 ouritag:=Memo1.SelStart+1;
 vn:=1;
 start_itag.x:=0;
 close_itag.x:=0;
 GetPosi('#notag');
 if close_itag.x<>0 then
 begin
  EmSetSel(close_itag.x,close_itag.y);
  Memo1.SelText:='';
 end;
 if start_itag.x<>0 then
 begin
  EmSetSel(start_itag.x,start_itag.y);
  Memo1.SelText:='';
  if close_itag.x<>0 then
   EmSetSel(start_itag.x,close_itag.x-(start_itag.y-start_itag.x));
 end;
{$IFDEF CLX}
 Memo1.OnChange(nil);
{$ENDIF}
end;

{$IFNDEF CLX}
const IcmpDLL='gdi32.dll';
var hICMPdll:HModule=0;
type TIcmpCreateFile=function (DC: HDC; lpgs: PGlyphSet):DWORD; stdcall;
var IcmpCreateFile:TIcmpCreateFile=nil;

function GetFontUnicodeRanges(DC: HDC; lpgs: PGlyphSet):DWORD;
begin
 result:=0;
 if hICMPdll = 0 then
  hICMPdll := LoadLibrary(icmpDLL);
 if hICMPdll <> 0 then
 begin
  if not Assigned(ICMPCreateFile) then
   @ICMPCreateFile  := GetProcAddress(hICMPdll, 'GetFontUnicodeRanges');
  if Assigned(ICMPCreateFile) then
   result:=ICMPCreateFile(DC,lpgs);
 end;
end;
{$ENDIF}

{$RANGECHECKS OFF}

procedure TdhMultilineCaptionEdit2.SpeedButton7Click(Sender: TObject);
{$IFNDEF CLX}
var i,i2,w:integer;
var GlyphSet:PGlyphSet;
    g:string;
    //sl:TStringList;
    sl:WideString;
    uname:string;
var c1,c2:tlargeinteger;  
{$ENDIF}
begin                 
{$IFNDEF CLX}
 if ChooseUnicode=nil then
  ChooseUnicode:=TChooseUnicode.Create(nil);
 ChooseUnicode.Clear;
 if ChooseUnicode.IGNORE_dhLabel2.NearestFontFamily<>FirstComp.NearestFontFamily then
 begin

 ChooseUnicode.IGNORE_dhLabel2.Style.FontFamily:=FirstComp.NearestFontFamily;
 ChooseUnicode.IGNORE_dhLabel1.Style.FontFamily:=FirstComp.NearestFontFamily;
 ChooseUnicode.IGNORE_Label1.Font.Name:=FirstComp.NearestFontFamily;
                 // GetGlyphIndicesW
 setlength(g,GetFontUnicodeRanges(ChooseUnicode.IGNORE_Label1.Canvas.Handle,nil));
 if g='' then
 begin
  ChooseUnicode.IGNORE_dhLabel2.Style.FontFamily:='';
  showmessage('This function is not available for the current platform');
  exit;
 end;
 GlyphSet:=@g[1];
 GetFontUnicodeRanges(ChooseUnicode.IGNORE_Label1.Canvas.Handle,GlyphSet);


 //sl:=TStringList.Create;
 sl:='';
 for i:=0 to GlyphSet.cRanges-1 do
 begin
  for w:=Integer(GlyphSet.ranges[i].wcLow) to Integer(GlyphSet.ranges[i].wcLow)+GlyphSet.ranges[i].cGlyphs-1 do
  if (w<>10) and (w<>13) then
  begin
   if true then
   begin
    if HasUnicodeName(w,uname) then
     sl:=sl+'<uniw>'+ConvertWideStringToUnicode(WideChar(w),true)+'</uniw>'+endl_main else
     sl:=sl+ConvertWideStringToUnicode(WideChar(w),true)+endl_main;
   end else
   begin
    if HasUnicodeName(w,uname) then
     sl:=sl+('<uniw>'+'&'+uname+';'+'</uniw>')+endl_main else
     sl:=sl+CharRef(w)+endl_main;
   end;
  end;
//  s:=s+'<br>';
 end;
 //if Pos(WideChar(#2),sl)=0 then

 QueryPerformanceCounter(c1);
{ for i:=0 to unicode.Count-1 do
  s:=s+'<uniw>&'+unicode[i]+';</uniw> ';}
 ChooseUnicode.IGNORE_dhLabel1.Text:=sl;
 QueryPerformanceCounter(c2);
 //showmessage(' - time of comparison: '+inttostr((c2-c1) div 100));
 end;
// RuntimeMode:=true;
 if ChooseUnicode.ShowModal=mrOk then
  SetSel(ChooseUnicode.GetClickedText);
// RuntimeMode:=false;
{$ELSE}
 showmessage('Not implemented');  
{$ENDIF}
end;

procedure TdhMultilineCaptionEdit2.SpeedButton8Click(Sender: TObject);
begin   
 SetSel('&nbsp;'+Memo1.SelText);
end;

procedure TdhMultilineCaptionEdit2.FormActivate(Sender: TObject);
begin
{$IFNDEF CLX}
 Memo1.Perform(EM_SCROLLCARET, 0, 0);
{$ENDIF}
end;

procedure TdhMultilineCaptionEdit2.Memo1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin      
 Memo1.SetFocus;
end;

initialization

finalization

                  
 {if dhMultilineCaptionEdit2<>nil then
 if not (csDestroying in dhMultilineCaptionEdit2.ComponentState) then
  FreeAndNil(dhMultilineCaptionEdit2);}
{$IFNDEF CLX}
 if hICMPdll <> 0 then
  FreeLibrary(hICMPdll);
{$ENDIF}

 //FreeAndNil(dhMultilineCaptionEdit2);

end.





