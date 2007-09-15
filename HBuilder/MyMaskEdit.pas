unit MyMaskEdit;

interface

uses   
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QMask,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls, Mask,
  {$ENDIF}
  SysUtils, Classes;

type
  TMyMaskEdit = class(TEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(Owner:TComponent); override;
  published
    { Published declarations }
{$IFDEF CLX}
{$ELSE}
    property PasswordChar stored false;
{$ENDIF}

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMyMaskEdit]);
end;

{ TMyMaskEdit }

constructor TMyMaskEdit.Create(Owner: TComponent);
begin
  inherited;   
{$IFDEF CLX}  
  EchoMode:=emPassword;
{$ELSE}
  PasswordChar:='*';
{$ENDIF}
end;

end.
