unit MyTabControl;

interface

uses       
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QComCtrls,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls, ComCtrls,
  {$ENDIF}
  SysUtils, Classes;

type
  TMyTabControl = class(TTabControl)
  private
    { Private declarations }
  protected
    { Protected declarations }   
{$IFDEF CLX}
//    procedure DoShow; override; 
{$ENDIF}
  public
    { Public declarations }
  published
    { Published declarations }
    property OnDrawTab;
    property TabIndex;
    property Tabs stored False;
//    property BiDiMode:TBiDiMode read FBiDiMode write FBiDiMode stored false;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMyTabControl]);
end;

{ TMyTabControl }
                 
{$IFDEF CLX}
{procedure TMyTabControl.DoShow;
begin
 if not Showing then exit;
 inherited;
end;}            
{$ENDIF}

end.
