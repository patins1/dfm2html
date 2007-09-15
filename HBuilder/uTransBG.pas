unit uTransBG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckGroupBox, ComCtrls, RXSlider, FlEdit, GR32_Image, dhPanel;

type
  TTransBG = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    CheckGroupBox1: TCheckGroupBox;
    cStrechParted: TCheckBox;
    cStrechLinear: TCheckBox;
    Label1: TLabel;
    slPartX: TRxSlider;
    Label2: TLabel;
    spPartX: TSpinFloatEdit;
    Label3: TLabel;
    spPartY: TSpinFloatEdit;
    slPartY: TRxSlider;
    CheckGroupBox2: TCheckGroupBox;
    Label6: TLabel;
    slAngle: TRxSlider;
    spAngle: TSpinFloatEdit;
    cRotateEnabled: TCheckBox;
    CheckGroupBox3: TCheckGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    slShiftX: TRxSlider;
    spShiftX: TSpinFloatEdit;
    spShiftY: TSpinFloatEdit;
    slShiftY: TRxSlider;
    cShiftEnabled: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    TabSheet4: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure slAngleChange(Sender: TObject);
    procedure spAngleChange(Sender: TObject);
    procedure spShiftXChange(Sender: TObject);
    procedure spShiftYChange(Sender: TObject);
    procedure slShiftXChange(Sender: TObject);
    procedure slShiftYChange(Sender: TObject);
    procedure spPartXChange(Sender: TObject);
    procedure spPartYChange(Sender: TObject);
    procedure slPartXChange(Sender: TObject);
    procedure slPartYChange(Sender: TObject);
    procedure cRotateEnabledClick(Sender: TObject);
    procedure cStrechLinearClick(Sender: TObject);
    procedure cStrechPartedClick(Sender: TObject);
  private
    { Private declarations }
    Adjusting:boolean;
  public
    { Public declarations }
    tt:TTransformations;
    procedure Prepare(tt:TTransformations);
    procedure BuildTransformations;
  end;

var
  TransBG: TTransBG;

implementation

uses Unit1;

{$R *.dfm}

{ TTransBG }

procedure TTransBG.Prepare(tt: TTransformations);
begin
 Adjusting:=true;
 Self.tt.Assign(tt);
 cStrechLinear.Checked:=tt.StrechLinear;
 cStrechParted.Checked:=tt.StrechParted;
 cRotateEnabled.Checked:=tt.RotateEnabled;
 cShiftEnabled.Checked:=tt.ShiftEnabled;
 spAngle.Value:=tt.RotationDegree;
 spPartX.Value:=tt.PartX;
 spPartY.Value:=tt.PartY;
 spShiftX.Value:=tt.ShiftX;
 spShiftY.Value:=tt.ShiftY;
 Adjusting:=false;
end;

procedure TTransBG.FormCreate(Sender: TObject);
begin
 tt:=TTransformations.Create(nil);
end;

procedure TTransBG.slAngleChange(Sender: TObject);
begin
 spAngle.Value:=slAngle.Value;
end;

procedure TTransBG.spAngleChange(Sender: TObject);
begin
 slAngle.Value:=spAngle.IntValue;
 if Adjusting then exit;
 BuildTransformations;
end;

procedure TTransBG.BuildTransformations;
begin
 tt.StrechLinear:=cStrechLinear.Checked;
 tt.StrechParted:=cStrechParted.Checked;
 tt.RotateEnabled:=cRotateEnabled.Checked;
 tt.ShiftEnabled:=cShiftEnabled.Checked;
 tt.RotationDegree:=spAngle.IntValue;
 tt.PartX:=spPartX.IntValue;
 tt.PartY:=spPartY.IntValue;
 tt.ShiftX:=spShiftX.IntValue;
 tt.ShiftY:=spShiftY.IntValue;
 FrameForm.PropsPC.WriteTransformations(tt);
end;

procedure TTransBG.spShiftXChange(Sender: TObject);
begin
 slShiftX.Value:=spShiftX.IntValue;
 if Adjusting then exit;
 BuildTransformations;
end;

procedure TTransBG.spShiftYChange(Sender: TObject);
begin            
 slShiftY.Value:=spShiftY.IntValue;
 if Adjusting then exit;
 BuildTransformations;
end;

procedure TTransBG.slShiftXChange(Sender: TObject);
begin
 spShiftX.Value:=slShiftX.Value;
end;

procedure TTransBG.slShiftYChange(Sender: TObject);
begin  
 spShiftY.Value:=slShiftY.Value;
end;

procedure TTransBG.spPartXChange(Sender: TObject);
begin
 slPartX.Value:=spPartX.IntValue;
 if Adjusting then exit;
 BuildTransformations;
end;

procedure TTransBG.spPartYChange(Sender: TObject);
begin   
 slPartY.Value:=spPartY.IntValue;
 if Adjusting then exit;
 BuildTransformations;  
end;

procedure TTransBG.slPartXChange(Sender: TObject);
begin    
 spPartX.Value:=slPartX.Value;
end;

procedure TTransBG.slPartYChange(Sender: TObject);
begin
 spPartY.Value:=slPartY.Value;
end;

procedure TTransBG.cRotateEnabledClick(Sender: TObject);
begin
 BuildTransformations;
end;

procedure TTransBG.cStrechLinearClick(Sender: TObject);
begin
 if cStrechLinear.Checked then
  cStrechParted.Checked:=false;
 BuildTransformations;
end;

procedure TTransBG.cStrechPartedClick(Sender: TObject);
begin 
 if cStrechParted.Checked then
  cStrechLinear.Checked:=false;
 BuildTransformations;
end;

end.
