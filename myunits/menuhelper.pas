unit menuhelper;

interface
uses
  SysUtils, types,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QDialogs, QStdCtrls, QExtCtrls, QMenus,
  QMask,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, Dialogs, Menus,
  ShellAPI, Mask, ExtCtrls, StdCtrls,  Variants, clipbrd,
{$ENDIF}
 Classes;



procedure AddStringsTo(Collect:TMenuItem; SubIEFavClick:TNotifyEvent; isUrl:boolean; lsl:TStringList; withHint:boolean; lslFree:boolean; addSub:boolean; LeaveEntries:integer=0);

const maxItems=30;
const EmptyMenuItem='';
      CaptionEmptyMenuItem='*EMPTY*';

implementation

procedure AddStringsTo;
var i:integer;
    Item:TMenuItem;
    s:String;
    halb:integer;
    sCount,ItemsPerPane,c:integer;
begin
  if withHint then
   halb:=2 else
   halb:=1;

  sCount:=Collect.Count;
  c:=lsl.Count div maxItems;
  if c>=1 then
   ItemsPerPane:=(lsl.Count+1) div (c+1) else
   ItemsPerPane:=maxItems;

  for i:=0 to lsl.count div halb-1 do
  begin
   s:=lsl[halb*i];
   Item:=TMenuItem.Create(Collect);
   if withHint then
    Item.Hint:=lsl[halb*i+1] else
    Item.Hint:=s;
   if isUrl and (pos('?',s)>0) then
    delete(s,pos('?',s),maxint);
   Item.Caption:=s;
   Item.OnClick:=SubIEFavClick;
   if addSub then
    Item.Add(TMenuItem.Create(Item));
   Item.Tag:=integer(lsl.Objects[halb*i]);
   if (Collect.Count-sCount<>0) and ((Collect.Count-sCount) mod ItemsPerPane=0) then
    Item.Caption:='-';//Break:=mbBarBreak;
   Collect.Add(Item);
  end;

  for i:=LeaveEntries to Collect.Count-lsl.count div halb-1 do
  if Collect.Count=1 then
  begin
   Collect.Items[LeaveEntries].Hint:=EmptyMenuItem;
   Collect.Items[LeaveEntries].Caption:=CaptionEmptyMenuItem;
  end else
   Collect.Items[LeaveEntries].Free;
  if lslFree then
   lsl.Free;
end;

end.
