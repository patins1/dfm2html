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

unit dhMemo;

interface

uses
  Types,
  {$IFDEF CLX}
  QControls, QGraphics, QDialogs, QForms,
  {$ELSE}
  Controls, Windows, Messages, Graphics,
  {$ENDIF}
  SysUtils, Classes, dhPanel, dhLabel, dhEdit, dhStrUtils, dhStyles;

type
  TdhMemo = class(TdhCustomEdit)
  private
    FWrap: boolean;
    procedure SetWrap(const Value: boolean);
  protected
    procedure GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows, Cols: Integer); override;
    function GetFinal:ICon; override;
    function WrapAlways: boolean; override;
  public
    procedure SetMemoText(const Value:HypeString);
    constructor Create(AOwner: TComponent); override;
  published
    property ReadOnly;
    property Text:HypeString read FHTMLText write SetHTMLText;
    property Wrap:boolean read FWrap write SetWrap default true;
  end;

procedure Register;

implementation

uses BasicHTMLElements;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhMemo]);
end;

constructor TdhMemo.Create(AOwner: TComponent);
begin
  inherited;
  FWrap:=true;
  IsScrollArea:=true;
  FVertScrollbarNeverVisible:=false;
  FHorzScrollbarNeverVisible:=true;
  FVertScrollbarAlwaysVisible:=true;
  FHorzScrollbarAlwaysVisible:=false;
  AutoSizeXY:=asNone;
  SetBounds(0,0,185,89);
end;

function TdhMemo.GetFinal: ICon;
begin        
  result:=nil;
  if AssertTags2 then
   result:=dhStrEditDlg.memo;
end;

procedure TdhMemo.GetRowsCols(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight, Rows,Cols: Integer);
var scrolls:TRect;
begin
  Rows:=0;
  Cols:=0;
  scrolls:=ScrollEdgesPure;
  with AllEdgesPure do
  begin
   if AllowModifyY then
    NearestMod(TextExtent('Wg').cy,Bottom+Top+scrolls.Bottom+scrolls.Top,NewHeight,Rows);
   if AllowModifyX then
    NearestMod(TextExtent('X').cx,Left+Right+scrolls.Left+scrolls.Right,NewWidth,Cols);
  end;
end;

procedure TdhMemo.SetWrap(const Value: boolean);
begin
 if FWrap<>Value then
 begin
  FWrap := Value;
  FHorzScrollbarAlwaysVisible:=not FWrap;
  FHorzScrollbarNeverVisible:=FWrap;
  NotifyCSSChanged([wcSize,wcText2,wcNoOwnCSS]);  
 end;
end;

function TdhMemo.WrapAlways:boolean;
begin
 Result:=Wrap;
end;

procedure TdhMemo.SetMemoText(const Value: HypeString);
begin
 Text:=Value;
end;

end.
