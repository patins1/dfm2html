unit dhHiddenField;

interface

uses                    
  {$IFDEF CLX}
  QControls, QGraphics,
  {$ELSE}
  Controls, Windows, Messages, Graphics,
  {$ENDIF}
   SysUtils, Classes,
  dhPanel,GR32,UseFastStrings;

{$R 'dhHiddenField.dcr'}

type
  TdhHiddenField = class(TdhCustomPanel)
  private
    FValue: HypeString;
    { Private declarations }
  protected
    { Protected declarations }
    procedure DoTopPainting; override;
    function EffectsAllowed: boolean; override;
  public
    { Public declarations }            
    procedure GetAutoRect(AllowModifyX,AllowModifyY:boolean; var NewWidth, NewHeight: Integer); override;
  published
    { Published declarations }
    property Value:HypeString read FValue write FValue;
  end;

procedure Register;

implementation
                        
var PageControlBitmap:TBitmap=nil;

procedure Register;
begin
  RegisterComponents('DFM2HTML', [TdhHiddenField]);
end;

{ TdhHiddenField }

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
