unit MyForm;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QButtons, QForms, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls, Buttons, Forms, UnicodeCtrls,
  {$ENDIF}
  SysUtils, Classes, dhPanel, Types;

type
  TMyForm = class(TTntForm)
  private
    { Private declarations }
  protected
    { Protected declarations }
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; {$IFDEF CLX}const {$ENDIF}MousePos: TPoint): Boolean; override;
    procedure DefineProperties(Filer: TFiler); override;        
    procedure SkipValue(Reader: TReader);
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMyForm]);
end;

{ TMyForm }

function TMyForm.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; {$IFDEF CLX}const {$ENDIF}MousePos: TPoint): Boolean;
begin
 result:=ConsumeMouseWheel(Self,WheelDelta);
end;

procedure TMyForm.DefineProperties(Filer: TFiler);
begin
 inherited;
{$IFDEF CLX}
 Filer.DefineProperty('DesignSize', SkipValue, nil, false);
 Filer.DefineProperty('ScreenSnap', SkipValue, nil, false);
{$ENDIF}
end;

procedure TMyForm.SkipValue(Reader: TReader);
begin
 _SkipValue(Reader);
end;

end.
