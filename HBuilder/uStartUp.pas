unit uStartUp;

interface

uses
  SysUtils, Classes, types,
{$IFDEF CLX}
  QControls, QGraphics, QForms, QStdCtrls, QExtCtrls, QComCtrls,QTntStdCtrls,
{$ELSE}
  Controls, Windows, Messages, Graphics, Forms, ComCtrls, ExtCtrls, StdCtrls, UnicodeCtrls,
{$ENDIF}
  dhPanel, dhLabel, dhMenu, dhStyleSheet, DKLang;

type
  TStartUpAction=(suNothing,suNewPage,suLastPage,suTutorial,suTemplates,su5minGuide,suOpen);
  TStartUp = class(TTntForm)
    dhStyleSheet1: TdhStyleSheet;
    STYLE_Link1: TdhLink;
    dhLink1: TdhLink;
    cTemplate: TdhLink;
    dhLink3: TdhLink;
    dhLink4: TdhLink;
    dhLink2: TdhLink;
    DKLanguageController1: TDKLanguageController;
    dhOpen: TdhLink;
    procedure dhOpenClick(Sender: TObject);
    procedure dhLink1Click(Sender: TObject);
    procedure dhLink4Click(Sender: TObject);
    procedure cTemplateClick(Sender: TObject);
    procedure dhLink3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dhLink2Click(Sender: TObject);
  private
    { Private declarations }
    res:TStartUpAction;
  public
    { Public declarations }
    function FirstAction:TStartUpAction;
  end;

var
  StartUp: TStartUp;

implementation

{$R *.dfm}

{ TStartUp }

function TStartUp.FirstAction: TStartUpAction;
begin
 res:=suNothing;
 ShowModal;
{$IFNDEF CLX}
 Application.MainForm.Update; //repaint damit form endgültig verschwindet
{$ENDIF} 
 result:=res; 
end;

procedure TStartUp.dhLink1Click(Sender: TObject);
begin    
 res:=suLastPage;
 ModalResult:=mrOk;
end;

procedure TStartUp.dhLink4Click(Sender: TObject);
begin
 res:=suNewPage;
 ModalResult:=mrOk;
end;

procedure TStartUp.dhOpenClick(Sender: TObject);
begin 
 res:=suOpen;
 ModalResult:=mrOk;
end;

procedure TStartUp.cTemplateClick(Sender: TObject);
begin
 res:=suTemplates;
 ModalResult:=mrOk;
end;

procedure TStartUp.dhLink3Click(Sender: TObject);
begin
 res:=suTutorial;
 ModalResult:=mrOk;
end;

procedure TStartUp.FormKeyPress(Sender: TObject; var Key: Char);
begin   
 if Key=Char(VK_ESCAPE) then
 begin
  ModalResult:=mrCancel;
  Key:=#0;
 end;
end;

procedure TStartUp.FormCreate(Sender: TObject);
begin    
 FixDialogBorderStyle(Self);
{$IFNDEF CLX}
 AutoSize:=true;
{$ENDIF}
end;

procedure TStartUp.dhLink2Click(Sender: TObject);
begin
 res:=su5minGuide;
 ModalResult:=mrOk;
end;

end.
