unit uResourceExplorer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, MyForm, dhPanel, dhFile, DKLang, UIConstants;

type
  TResourceExplorer = class(TMyForm)
    RichEdit1: TTntMemo;
    cShowObjectNames: TTntCheckBox;
    DKLanguageController1: TDKLanguageController;
    procedure cShowObjectNamesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateListing;
  end;

var
  ResourceExplorer: TResourceExplorer;

implementation

uses Unit1;

{$R *.dfm}

procedure TResourceExplorer.cShowObjectNamesClick(Sender: TObject);
begin
 UpdateListing;
end;

procedure TResourceExplorer.UpdateListing;
Var
    I: Integer;
    pn:TdhCustomPanel;
    dhFile:TdhFile;
    State:TState;
    sl:TStringList;

procedure Add(const s:String; c:TComponent);
begin
 if sl.IndexOf(s)=-1 then
 begin
  sl.Add(s);
  if cShowObjectNames.Checked then
   RichEdit1.Lines.Add(s+' ('+c.Name+')') else
   RichEdit1.Lines.Add(s);
 end;
end;   

Begin
 if dhMainForm.Act=nil then exit; 

 RichEdit1.Clear;

 sl:=TStringList.Create;
 try
 sl.CaseSensitive:=False;
 sl.Sorted:=True;

 RichEdit1.Lines.Add(DKFormat(RESOURCEEXPLORER_FILES)+':');
 for I := 0 to dhMainForm.Act.ComponentCount - 1 do
 begin
   if dhMainForm.Act.Components[i] is TdhFile then
   begin
     dhFile:=TdhFile(dhMainForm.Act.Components[i]);
     if dhFile.HasFile then
     begin
       Add(dhFile.GetAbsolutePath,dhFile);
     end;
   end;
 end;
 RichEdit1.Lines.Add('');

 RichEdit1.Lines.Add(DKFormat(RESOURCEEXPLORER_IMAGES)+':');
 for I := 0 to dhMainForm.Act.ComponentCount - 1 do
 begin
   if dhMainForm.Act.Components[i] is TdhCustomPanel then
   begin
     pn:=TdhCustomPanel(dhMainForm.Act.Components[i]);
     for state:=low(TState) to high(TState) do
     if pn.StyleArr[state]<>nil then with pn.StyleArr[state] do
     if BackgroundImage.HasPicture then
     if BackgroundImage.HasPath then
     begin
       Add(BackgroundImage.GetAbsolutePath,pn);
     end;
   end;
 end;
 RichEdit1.Lines.Add('');

 RichEdit1.Lines.Add(DKFormat(RESOURCEEXPLORER_FONTS)+':');
 for I := 0 to dhMainForm.Act.ComponentCount - 1 do
 begin
   if dhMainForm.Act.Components[i] is TdhCustomPanel then
   begin
     pn:=TdhCustomPanel(dhMainForm.Act.Components[i]);
     for state:=low(TState) to high(TState) do
     if pn.StyleArr[state]<>nil then with pn.StyleArr[state] do
     if FontFamily<>'' then
     begin
       Add(FontFamily,pn);
     end;
   end;
 end;

 finally
  sl.Free;
 end;

End;

end.
