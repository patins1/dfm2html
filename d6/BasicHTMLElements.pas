unit BasicHTMLElements;

interface

uses                       
  {$IFDEF CLX}
  QControls, QGraphics, QForms,
  {$ELSE}
  Controls, Windows, Messages, forms, Graphics,
  {$ENDIF}
  SysUtils, Classes,
  dhMenu, dhLabel, dhPanel, dhPageControl;
                  
type
  TBasicHTMLElements = class(TFrame)
    dhStyleSheet1: TdhPage;
    dhLabel1: TdhLabel;
    dhLabel2: TdhLabel;
    dhLabel3: TdhLabel;
    p: TdhLink;
    li: TdhLink;
    ul: TdhLink;
    blockquote: TdhLink;
    address: TdhLink;
    center: TdhLink;
    h1: TdhLink;
    h2: TdhLink;
    h3: TdhLink;
    h4: TdhLink;
    h5: TdhLink;
    h6: TdhLink;
    b: TdhLink;
    strong: TdhLink;
    i: TdhLink;
    cite: TdhLink;
    em: TdhLink;
    dfn: TdhLink;
    u: TdhLink;
    ins: TdhLink;
    s: TdhLink;
    strike: TdhLink;
    del: TdhLink;
    blink: TdhLink;
    big: TdhLink;
    small: TdhLink;
    sup: TdhLink;
    sub: TdhLink;
    nobr: TdhLink;
    hr: TdhLink;
    unknown_element: TdhLink;
    dd: TdhLink;
    dt: TdhLink;
    dl: TdhLink;
    tt: TdhLink;
    code: TdhLink;
    kbd: TdhLink;
    samp: TdhLink;
    menu: TdhLink;
    dir: TdhLink;
    ol: TdhLink;
    edit: TdhLink;
    radiobuttonnormal: TdhLink;
    radiobuttondown: TdhLink;
    checkboxnormal: TdhLink;
    checkboxdown: TdhLink;
    newchar: TdhLink;
    filebutton: TdhLink;
    button: TdhLink;
    memo: TdhLink;
    a: TdhLink;
    for_small_caps: TdhLabel;
    uniw: TdhLabel;
    listbox: TdhLabel;
    selectedlistboxitem: TdhLabel;
    listboxitem: TdhLabel;
    menupopup: TdhLabel;
    hidden: TdhLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Loaded; override;
  end;

var dhStrEditDlg:TBasicHTMLElements;

implementation

{$R *.dfm}

procedure TBasicHTMLElements.Loaded;
begin
 inherited;
 (RadioButtonDown.Style.BackgroundImage.RequestGraphic as TBitmap).Transparent:=true;
 (RadioButtonNormal.Style.BackgroundImage.RequestGraphic as TBitmap).Transparent:=true;
 dhStyleSheet1.VertPosition:=0;
end;


end.
