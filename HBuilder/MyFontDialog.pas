unit MyFontDialog;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls,  Qt, QDialogs,
  {$ELSE}
  Controls, Windows, Messages,  StdCtrls, dialogs,
  {$ENDIF}
   SysUtils, Classes;

type
  TMyFontDialog = class(TFontDialog)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  {$IFNDEF CLX}
    property MinFontSize stored false;
    property MaxFontSize stored false;    
  {$ENDIF}
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMyFontDialog]);
end;

end.
