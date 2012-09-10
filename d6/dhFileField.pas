{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is DFM2HTML

The Initial Developer of the Original Code is Joerg Kiegeland

You may retrieve the latest version of this file at the DFM2HTML home page,
located at http://www.dfm2html.com

-------------------------------------------------------------------------------}

unit dhFileField;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls,QDialogs,
  {$ELSE}
  Controls, Windows,Messages,Dialogs,
  {$ENDIF}
  SysUtils, Classes, dhPanel, dhLabel,dhEdit,dhMenu,dhStyles;

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
