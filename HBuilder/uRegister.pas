unit uRegister;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dhMenu, dhStyleSheet, dhPanel, dhLabel;

type
  TRegister = class(TForm)
    Edit1: TEdit;
    dhLabel1: TdhLabel;
    dhStyleSheet1: TdhStyleSheet;
    Link1: TdhLink;
    Button1: TButton;
    Button2: TButton;
    dhLink1: TdhLink;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Register: TRegister;

implementation

{$R *.dfm}

procedure TRegister.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=VK_RETURN then
 begin
  ModalResult:=mrOk;
  Key:=0;
 end;
end;

end.

You can find instructions how to register DFM2HTML <Link1>here</Link1>.<br/>
If you have received your password, please enter it in the 
following edit control:<br/>

<Link1>Find out</Link1> the advantages of registering DFM2HTML.
