unit dhFileField;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls,QDialogs,
  {$ELSE}
  Controls, Windows,Messages,Dialogs,
  {$ENDIF}
  SysUtils, Classes, dhPanel, dhLabel,dhEdit,dhMenu;

type
  TdhFileField = class(TdhCustomEdit)
  private
    button:TdhLink;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    function IncludeBorderAndPadding:boolean; override;
    procedure AdjustMarginWidth(var i: integer; const Align: TEdgeAlign); override;
{$IFNDEF CLX}
    procedure CreateParams(var Params: TCreateParams); override;
{$ENDIF}
    function GetFinal:ICon; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;
 
procedure Register;

implementation
 
uses BasicHTMLElements,dhPageControl;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhFileField]);
end;

procedure TdhFileField.AdjustMarginWidth(var i: integer;
  const Align: TEdgeAlign);
begin
 if button<>nil then
 if Align=ealRight then
  inc(i,button.Width+4);
end;

procedure TdhFileField.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  with MarginTotalRect do
   button.SetBounds(Right+4,Top,button.Width,Bottom-Top);
end;

function TdhFileField.IncludeBorderAndPadding:boolean;
begin
 result:=true;
end;

type TdhFileButton=class(TdhLink)
 protected                        
   function GetFinal: ICon; override;
 public
   procedure Click; override;

end;

procedure TdhFileButton.Click;
begin
 if DelegateClick then exit;
 with TOpenDialog.Create(Nil) do
 begin
   Title:='File Upload';
   if Execute then
    (Parent as TdhFileField).SetHTMLText(FileName);
   Free;
 end;
end;


function TdhFileButton.GetFinal: ICon;
begin
  result:=nil;
  if AssertTags2 then
   result:=dhStrEditDlg.filebutton;
end;

constructor TdhFileField.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle:=ControlStyle-[csSetCaption];
  AutoSizeXY:=asXY;
  Width:=226;
  button:=TdhFileButton.Create(Self);
  button.AutoSizeXY:=asX;
  button.Layout:=ltButton;
  button.Text:='Browse...';
  button.Parent:=Self;
  IsScrollArea:=true;
  FVertScrollbarNeverVisible:=true;
  FHorzScrollbarNeverVisible:=true;
end;

{$IFNDEF CLX}
procedure TdhFileField.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
      Style := Style or WS_CLIPCHILDREN; //prevent flicker of button
      ExStyle := ExStyle or WS_EX_CONTROLPARENT;
  end;
end;      
{$ENDIF}

function TdhFileField.GetFinal: ICon;
begin   
  result:=nil;
  if AssertTags2 then
   result:=dhStrEditDlg.edit;
end;

end.
