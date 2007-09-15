unit MyPanel;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, Qt, QTntStdCtrls, QExtCtrls,
  {$ELSE}
  Controls, Windows, Messages, StdCtrls, TntStdCtrls, ExtCtrls,
  {$ENDIF}
  SysUtils, Classes, dhPanel;

type
  TMyPanel = class(TPanel)
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
  RegisterComponents('Samples', [TMyPanel]);
end;      

procedure TMyPanel.DefineProperties(Filer: TFiler);
begin
 inherited;
 Filer.DefineProperty('DesignSize', SkipValue, nil, false);
end;

procedure TMyPanel.SkipValue(Reader: TReader);
begin
 _SkipValue(Reader);
end;

end.
