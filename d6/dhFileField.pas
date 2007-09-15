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
    { Private declarations }
  protected
    { Protected declarations }
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    //function ContentClientRect: TRect; override;
    //procedure ShrinkToContent(var IE5,IE6:TRect; HasRastering,OnlyBg:boolean); override;
    function IncludeBorderAndPadding:boolean; override;
    procedure AdjustMarginWidth(var i: integer; const Align: TEdgeAlign); override;
{$IFNDEF CLX}
    procedure CreateParams(var Params: TCreateParams); override;
{$ENDIF}
    function GetFinal:ICon; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;    
  published
    { Published declarations }
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
   button.SetBounds(Right+4{Width-button.Width-4},Top,button.Width,Bottom-Top);
end;
                         {
function TdhFileField.ContentClientRect: TRect;
begin
 result:=FCommon.MarginClientRect;
 AdjustMarginWidth(result.Right,ealRight);
end;
                         }

(*procedure TdhFileField.ShrinkToContent(var IE5,IE6:TRect; HasRastering,OnlyBg:boolean);
begin
 {R:=ShrinkRect(R,FCommon.MarginPure);
 AdjustMarginWidth(R.Right,ealRight); }
  IE5:=FCommon.MarginPure;
  IE5.Right:=-IE5.Right;
  AdjustMarginWidth(IE5.Right,ealRight);
  IE5.Right:=-IE5.Right;

  IE6:=IE5;
end;*)

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
var Directory:{$IFDEF CLX}widestring{$ELSE}string{$ENDIF};
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
  Button:=TdhFileButton.Create(Self);
  //_SetUniqueName(button,'button');
  //button.Left:=Width;
  //button.Anchors:=[akTop,akBottom,akRight];
  Button.AutoSizeXY:=asX;
  button.Layout:=ltButton;
  // button.FinalStyleElement:=dhStrEditDlg.filebutton;
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
