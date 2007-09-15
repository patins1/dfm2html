unit QTntStdCtrls;

interface

uses QStdCtrls,QControls,QForms,QExtCtrls,QButtons,QComCtrls,QMenus;

type TTntMemo=class(TMemo)
  public
    function CaretPosToPos(CaretPos: TCaretPos): Integer;
end;

type TTntCheckbox=class(TCheckbox)
  public
end;

type TTntComboBox=class(TComboBox)
  public
end;

type TTntEdit=class(TEdit)
  public
end;

type TTntForm=class(TForm)
  public
end;

type TTntButton=class(TButton)
end;

type TTntRadioGroup=class(TRadioGroup)
end;

type TTntGroupBox=class(TGroupBox)
end;

type TTntListBox=class(TListBox)
end;

type TTntSpeedButton=class(TSpeedButton)
end;

type TTntPageControl=class(TPageControl)
end;

type TTntRadioButton=class(TRadioButton)
end;

type TTntToolButton=class(TToolButton)
end;

type TTntMenuItem=class(TMenuItem)
end;

type TTntMainMenu=class(TMainMenu)
end;

type TTntPopupMenu=class(TPopupMenu)
end;

type TTntToolBar=class(TToolBar)
end;

type TTntTabSheet=class(TTabSheet)
end;

function CaretPos(Line,
    Col: Integer):TCaretPos;


implementation
                                   
function CaretPos(Line,
    Col: Integer):TCaretPos;
begin
 result.Line:=Line;
 result.Col:=Col;
end;


//copied from QStrCtrls
function TTntMemo.CaretPosToPos(CaretPos: TCaretPos): Integer;
var
  L, E: Integer;
begin
  L := 0;
  E := CaretPos.Line;
  Result := CaretPos.Col;
  while L < E do
  begin
    Inc(Result, LineLength(L));
    Inc(L);
  end;
end;

end.
