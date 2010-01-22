unit MyGroupBox;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls,UnicodeCtrls,
  {$ENDIF}
  SysUtils, Classes, dhPanel;

type
  TMyGroupBox = class(TTntGroupBox)
  private
    { Private declarations } 
    procedure SkipValue(Reader: TReader);
  protected
    { Protected declarations }        
    procedure DefineProperties(Filer: TFiler); override;
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMyGroupBox]);
end;

procedure TMyGroupBox.DefineProperties(Filer: TFiler);
begin
 inherited;
 Filer.DefineProperty('DesignSize', SkipValue, nil, false);
end;

procedure TMyGroupBox.SkipValue(Reader: TReader);
begin
 Reader.SkipValue;
end;

end.
