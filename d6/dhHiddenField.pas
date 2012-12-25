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

unit dhHiddenField;

interface

uses                    
  {$IFDEF CLX}
  QControls, QGraphics,
  {$ELSE}
  Controls, Windows, Messages, Graphics,
  {$ENDIF}
   SysUtils, Classes,
  dhPanel,GR32, dhStrUtils;

{$R 'dhHiddenField.dcr'}

type
  TdhHiddenField = class(TdhCustomPanel)
  private
    FValue: HypeString;
  protected
    procedure DoTopPainting; override;
    function EffectsAllowed: boolean; override;
  public
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
  published
    property Value:HypeString read FValue write FValue;
  end;

implementation
                        
var PageControlBitmap:TBitmap=nil;

procedure TdhHiddenField.DoTopPainting;
begin
 if (csDesigning in ComponentState) then
 begin
   if (PageControlBitmap=nil) then
   begin
    PageControlBitmap := TBitmap.Create;
    PageControlBitmap.LoadFromResourceName(HInstance, 'TDHHIDDENFIELDPURE');
   end;
   if (PageControlBitmap<>nil) then
    GetCanvas.Draw(0,0,PageControlBitmap);
 end;
end;

function TdhHiddenField.EffectsAllowed: boolean;
begin
 result:=false;
end;

procedure TdhHiddenField.GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer);
begin
 NewWidth:=24;
 NewHeight:=24;
end;

initialization

finalization

 FreeAndNil(PageControlBitmap);

end.
