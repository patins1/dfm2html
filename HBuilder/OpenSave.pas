unit OpenSave;

{$R-,H+,X+}

interface

uses
  {$IFDEF CLX}
  QConsts, QControls, QGraphics, QStdCtrls, Qt, QComCtrls,QDialogs,QButtons,QExtCtrls, QForms,
  {$ELSE}
  Consts, Graphics,Dialogs,Controls, Windows, Messages, StdCtrls, Spin, CommDlg, Dlgs, ExtCtrls,Buttons, Forms,
  {$ENDIF}
  SysUtils, Types, Classes, Math;

type


  TMyOpenPictureDialog = class(TOpenDialog)
  private
    FPicturePanel: TPanel;
    FPictureLabel: TLabel;
    FPreviewButton: TSpeedButton;
    FPaintPanel: TPanel;
    FImageCtrl: TImage;
    FSavedFilename: string;
    function  IsFilterStored: Boolean;
    procedure PreviewKeyPress(Sender: TObject; var Key: Char);
  protected
    procedure PreviewClick(Sender: TObject); virtual;
    procedure DoClose; override;
    procedure DoSelectionChange; {$IFNDEF CLX}override;{$ENDIF}
    procedure DoShow; override;
    property ImageCtrl: TImage read FImageCtrl;
    property PictureLabel: TLabel read FPictureLabel;
  published
    property Filter stored IsFilterStored;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

{ TSavePictureDialog }

  TMySavePictureDialog = class(TMyOpenPictureDialog)
  public
    function Execute: Boolean; override;
  end;
  
procedure Register;

implementation


type
  TSilentPaintPanel = class(TPanel)
  protected
    //procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure Paint; override;
  end;

procedure TSilentPaintPanel.Paint;//WMPaint(var Msg: TWMPaint);
begin
  try
    inherited;
  except
    Caption := 'Invalid image';
  end;
end;

{ TOpenPictureDialog }

{.$R ExtDlgs.res}

constructor TMyOpenPictureDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Filter := GraphicFilter(TGraphic);
  FPicturePanel := TPanel.Create(Self);
  with FPicturePanel do
  begin
    Name := 'PicturePanel';
    Caption := '';
    SetBounds(204, 5, 169, 200);
    BevelOuter := bvNone;
    BorderWidth := 6;
    TabOrder := 1;
    FPictureLabel := TLabel.Create(Self);
    with FPictureLabel do
    begin
      Name := 'PictureLabel';
      Caption := '';
      SetBounds(6, 6, 157, 23);
      Align := alTop;
      AutoSize := False;
      Parent := FPicturePanel;
    end;
    FPreviewButton := TSpeedButton.Create(Self);
    with FPreviewButton do
    begin
      Name := 'PreviewButton';
      SetBounds(77, 1, 23, 22);
      Enabled := False;
      //Glyph.LoadFromResourceName(HInstance, 'PREVIEWGLYPH');
      Hint := SPreviewLabel;
      ParentShowHint := False;
      ShowHint := True;
      OnClick := PreviewClick;
      Parent := FPicturePanel;
    end;
    FPaintPanel := TSilentPaintPanel.Create(Self);
    with FPaintPanel do
    begin
      Name := 'PaintPanel';
      Caption := '';
      SetBounds(6, 29, 157, 145);
      Align := alClient;
      BevelInner := bvRaised;
      BevelOuter := bvLowered;
      TabOrder := 0;
      FImageCtrl := TImage.Create(Self);
      Parent := FPicturePanel;
      with FImageCtrl do
      begin
        Name := 'PaintBox';
        Align := alClient;
        OnDblClick := PreviewClick;
        Parent := FPaintPanel;
{$IFNDEF CLX}
        Proportional := True;
{$ENDIF}
        Stretch := True;
        Center := True;
        IncrementalDisplay := True;
      end;
    end;
  end;
end;

procedure TMyOpenPictureDialog.DoSelectionChange;
var
  FullName: string;
  ValidPicture: Boolean;

  function ValidFile(const FileName: string): Boolean;
  begin
{$IFNDEF CLX}
    Result := GetFileAttributes(PChar(FileName)) <> $FFFFFFFF;
{$ELSE}
    Result:=true;
{$ENDIF}
  end;

begin
  FullName := FileName;
  if FullName <> FSavedFilename then
  begin
    FSavedFilename := FullName;
    ValidPicture := FileExists(FullName) and ValidFile(FullName);
    if ValidPicture then
    try
      FImageCtrl.Picture.LoadFromFile(FullName);
      FPictureLabel.Caption := Format(SPictureDesc,
        [FImageCtrl.Picture.Width, FImageCtrl.Picture.Height]);
      FPreviewButton.Enabled := True;
      FPaintPanel.Caption := '';
    except
      ValidPicture := False;
    end;
    if not ValidPicture then
    begin
      FPictureLabel.Caption := SPictureLabel;
      FPreviewButton.Enabled := False;
      FImageCtrl.Picture := nil;
      FPaintPanel.Caption := srNone;
    end;
  end;
  inherited;
end;

procedure TMyOpenPictureDialog.DoClose;
begin
  inherited DoClose;
  { Hide any hint windows left behind }
  Application.HideHint;
end;

procedure TMyOpenPictureDialog.DoShow;
var
  PreviewRect, StaticRect: TRect;
begin
  { Set preview area to entire dialog }
{$IFDEF CLX}
  PreviewRect:=Bounds(0,0,Width,Height);
  StaticRect := PreviewRect;
{$ELSE}
  GetClientRect(Handle, PreviewRect);
  StaticRect := GetStaticRect;
{$ENDIF}
  { Move preview area to right of static area }
  PreviewRect.Left := StaticRect.Left + (StaticRect.Right - StaticRect.Left);
  Inc(PreviewRect.Top, 4);
  FPicturePanel.BoundsRect := PreviewRect;
  FPreviewButton.Left := FPaintPanel.BoundsRect.Right - FPreviewButton.Width - 2;
  FImageCtrl.Picture := nil;
  FSavedFilename := '';
  FPaintPanel.Caption := srNone;
{$IFDEF CLX}
  FPicturePanel.Parent := Self.Form;
{$ELSE}
  FPicturePanel.ParentWindow := Handle;
{$ENDIF}
  inherited DoShow;
end;

function TMyOpenPictureDialog.Execute: Boolean;
begin
{$IFNDEF CLX}
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'DLGTEMPLATE' else
    Template := nil;
{$ENDIF}
  Result := inherited Execute;
end;

procedure TMyOpenPictureDialog.PreviewClick(Sender: TObject);
var
  PreviewForm: TForm;
  Panel: TPanel;
begin
  PreviewForm := TForm.Create(Self);
  with PreviewForm do
  try
    Name := 'PreviewForm';
    Visible := False;
    Caption := SPreviewLabel;   
{$IFDEF CLX}    
    BorderStyle := fbsSizeToolWin;
{$ELSE}
    BorderStyle := bsSizeToolWin;
{$ENDIF}
    KeyPreview := True;
    Position := poScreenCenter;
    OnKeyPress := PreviewKeyPress;
    Panel := TPanel.Create(PreviewForm);
    with Panel do
    begin
      Name := 'Panel';
      Caption := '';
      Align := alClient;
      BevelOuter := bvNone;
{$IFDEF CLX}
      BorderStyle := QControls.bsSingle;
{$ELSE}
      BorderStyle := bsSingle;
{$ENDIF}
      BorderWidth := 5;
      Color := clWindow;
      Parent := PreviewForm;
{$IFNDEF CLX}
      DoubleBuffered := True;
{$ENDIF}
      with TImage.Create(PreviewForm) do
      begin
        Name := 'Image';
        Align := alClient;
        Stretch := True;     
{$IFNDEF CLX}
        Proportional := True; 
{$ENDIF}
        Center := True;
        Picture.Assign(FImageCtrl.Picture);
        Parent := Panel;
      end;
    end;
    if FImageCtrl.Picture.Width > 0 then
    begin
      ClientWidth := Min(Screen.Width * 3 div 4,
        FImageCtrl.Picture.Width + (ClientWidth - Panel.ClientWidth)+ 10);
      ClientHeight := Min(Screen.Height * 3 div 4,
        FImageCtrl.Picture.Height + (ClientHeight - Panel.ClientHeight) + 10);
    end;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMyOpenPictureDialog.PreviewKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then TForm(Sender).Close;
end;

{ TMyOpenPictureDialog }

function TMySavePictureDialog.Execute: Boolean;
begin
{$IFNDEF CLX}
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'DLGTEMPLATE' else
    Template := nil;
  Result := DoExecute(@GetSaveFileName);
{$ELSE}           
  Result := inherited Execute();
{$ENDIF}
end;

function TMyOpenPictureDialog.IsFilterStored: Boolean;
begin
  Result := not (Filter = GraphicFilter(TGraphic));
end;

procedure Register;
begin
  RegisterComponents('Samples', [TMyOpenPictureDialog,TMySavePictureDialog]);
end;

end.
