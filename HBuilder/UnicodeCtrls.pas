unit UnicodeCtrls;

interface

uses
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QMask, Qt, QComCtrls, QTntStdCtrls,
  {$ELSE}
  Controls, Windows, Messages, Graphics, StdCtrls, ShellAPI, Mask, ComCtrls,Buttons,Forms,Menus,ExtCtrls, {$IF CompilerVersion < 21}TntComCtrls,TntForms,{$IFEND}
  {$ENDIF}
  SysUtils, Classes;

{$IF CompilerVersion >= 21}
type
  TTntToolButton = class(TToolButton) end;
  TTntSpeedButton = class(TSpeedButton) end;
  TTntButton = class(TButton) end;
  TTntForm = class(TForm) end;
  TTntComboBox = class(TComboBox) end;
  TTntEdit = class(TEdit) end;
  TTntMemo = class(TMemo) end;
  TTntPageControl = class(TPageControl) end;
  TTntCheckBox = class(TCheckBox) end;
  TTntGroupBox = class(TGroupBox) end;
  TTntToolBar = class(TToolBar) end;
  TTntMainMenu = class(TMainMenu) end;
  TTntPopupMenu = class(TPopupMenu) end;
  TTntMenuItem = class(TMenuItem) end;
  TTntTabSheet = class(TTabSheet) end;
  TTntRadioButton = class(TRadioButton) end;
  TTntRadioGroup = class(TRadioGroup) end;
  TTntListBox = class(TListBox) end;
{$IFEND}

procedure Register;

implementation

procedure Register;
begin
{$IF CompilerVersion >= 21}
  RegisterComponents('TNT', [TTntToolBar]);
  RegisterComponents('TNT', [TTntMainMenu]);
  RegisterComponents('TNT', [TTntPopupMenu]);
  RegisterComponents('TNT', [TTntMenuItem]);
  RegisterComponents('TNT', [TTntTabSheet]);

  RegisterComponents('TNT', [TTntButton]);
  RegisterComponents('TNT', [TTntRadioButton]);
  RegisterComponents('TNT', [TTntRadioGroup]);
  RegisterComponents('TNT', [TTntListBox]);
{$IFEND}
end;

end.
