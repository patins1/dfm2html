{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is DFM2HTML

The Initial Developer of the Original Code is Joerg Kiegeland

You may retrieve the latest version of this file at the DFM2HTML home page,
located at http://www.dfm2html.com

-------------------------------------------------------------------------------}

unit BasicHTMLElements;

interface

{$R 'checkboxdown.res'}
{$R 'checkboxnormal.res'}
{$R 'radiobuttondown.res'}
{$R 'radiobuttonnormal.res'}

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
    cursor: TdhLabel;
  end;

var dhStrEditDlg:TBasicHTMLElements;

implementation

{$R *.dfm}

end.
