{*************************************************************}
{            seCSSParser component for Delphi 32              }
{ Version:   1.0                                              }
{ E-Mail:    info@tmedia.de                                   }
{ WWW:       http://www.tmedia.de                             }
{ Created:   July  17, 2004                                   }
{ Modified:                                                   }
{ Legal:     Copyright (c) 2004, TMEDIA cross-communication   }
{*************************************************************}
{ Please see demo program for more information.               }
{*************************************************************}
{                     IMPORTANT NOTE:                         }
{ This software is provided 'as-is', without any express or   }
{ implied warranty. In no event will the author be held       }
{ liable for any damages arising from the use of this         }
{ software.                                                   }
{ Permission is granted to anyone to use this software for    }
{ any purpose, including commercial applications, and to      }
{ alter it and redistribute it freely, subject to the         }
{ following restrictions:                                     }
{ 1. The origin of this software must not be misrepresented,  }
{    you must not claim that you wrote the original software. }
{    If you use this software in a product, an acknowledgment }
{    in the product documentation would be appreciated but is }
{    not required.                                            }
{ 2. Altered source versions must be plainly marked as such,  }
{    and must not be misrepresented as being the original     }
{    software.                                                }
{ 3. This notice may not be removed or altered from any       }
{    source distribution.                                     }
{*************************************************************}

unit seCSSParser;

interface

uses
  SysUtils, Classes, CSSstrings, Dialogs;

type

  TseCSSAttribute = class(TObject)
  public
    Name, Value : String;
    constructor Create(AttrName:String=''; AttrValue:String='');
  end;


  TseCSSAttributes = class(TStringlist)
  private
    Function GetValue(Name:String):String;
    Function GetName(Index:Integer):TseCSSAttribute;
  public
    constructor Create();
    Property Count;
    Property Value[Name:String]:String read GetValue;
    Property Name[Index:Integer]:TseCSSAttribute read GetName;
  end;

  TseCSSElement = class(TObject)
  private
    fAttributtes : TseCSSAttributes;
    Function GetCSSAttribute(Index:Integer):TseCSSAttribute;
    Function GetAttributesCount:Integer;
  public
    Name : String;
    RawText : String;

    constructor Create(Element:String);

    Property Attributes[Index:Integer]:TseCSSAttribute read GetCSSAttribute;
    Property AttributesCount: Integer read GetAttributesCount;

  end;

  TseCSSElements = class(TStringlist)
  private
    function GetElement(Name:String):TseCSSElement;
  public
    constructor Create();

    property Element[Name:String]:TseCSSElement read GetElement;
  end;





  TseCSSParser = class(TComponent)
  private
    { Private-Deklarationen }
    fCSSText : TStrings;
    fAutoParse : Boolean;
    fAutoLoad : Boolean;
    fFilename : TFilename;

    fCSSLines : TStrings;
    fCSSElements : TseCSSElements;

    procedure SetCSSText(Value : TStrings);
    procedure SetFilename(Value : TFilename);

    Function GetCSSLines(Var S:WideString; CSSLines:TStrings):Integer;
    Function GetElementsCount:Integer;
    Function GetElement(Index:Integer):TseCSSElement;
    Function GetValue(Element:String;Attribute:String):String;

    Function RemoveFirstBracket(Var S:WideString):Boolean;
    Function RemoveCSSElement(Var S:WideString):Boolean;
    Function GetCSSElement(Var CSSLine:WideString; Var CSSElement:WideString; RemoveName:Boolean=True):Boolean;
    Function SearchFirstCSSName(Var CSSLine, CSSName, CSSValue: WideString; RemoveName:Boolean=True):Boolean;


  protected
    { Protected-Deklarationen }
  public
    { Public-Deklarationen }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    Procedure Parse;
    Procedure AssignTo(Strings:TStrings);

    Property ElementsCount: Integer read GetElementsCount;
    Property Elements[Index:Integer]: TseCSSElement read GetElement;
    Property Value[Element:String;Attribute:String]:String read GetValue;

  published
    { Published-Deklarationen }
    Property AutoParse: Boolean read fAutoParse write fAutoParse;
    Property AutoLoadFilename: Boolean read fAutoLoad write fAutoLoad;
    Property Filename: TFilename read fFilename write SetFilename;
    Property CSSText : TStrings read fCSSText write SetCSSText;
  end;

procedure Register;

implementation



procedure Register;
begin
  RegisterComponents('OSC', [TseCSSParser]);
end;


// ************ TseCSSAttribute *************
constructor TseCSSAttribute.Create(AttrName:String=''; AttrValue:String='');
begin
  inherited Create;
  Name := AttrName;
  Value := AttrValue;
end;


// ************ TseCSSAttributes *************
constructor TseCSSAttributes.Create;
begin
  inherited Create;
  Clear;
  CaseSensitive := false;
  Sorted := false;
end;

Function TseCSSAttributes.GetValue(Name:String):String;
Var
  i : integer;
  At : TseCSSAttribute;
begin
  result := '';
  for i := 0 to Count -1 do begin
    At := TseCSSAttribute(self.Objects[i]);
    if assigned(At) and (lowercase(At.Name) = lowercase(Name)) then begin
      result := At.Value;
      break;
    end;
  end;
end;

Function TseCSSAttributes.GetName(Index:Integer):TseCSSAttribute;
begin
  try
    result := TseCSSAttribute(Objects[Index]);
  except
    result := nil;
  end;
end;



// ************ TseCSSElement *************
constructor TseCSSElement.Create(Element:String);
begin
  inherited Create;
  self.Name := Element;
  fAttributtes := TseCSSAttributes.Create;
end;

Function TseCSSElement.GetCSSAttribute(Index:Integer):TseCSSAttribute;
begin
  try
    result := TseCSSAttribute(fAttributtes.Objects[Index]);
  except
    result := nil;
  end;
end;

Function TseCSSElement.GetAttributesCount:Integer;
begin
  result := fAttributtes.Count;
end;

// ************ TseCSSElement *************
constructor TseCSSElements.Create;
begin
  inherited Create;
  self.Clear;
  self.CaseSensitive := false;
  self.Sorted := false;
end;

function TseCSSElements.GetElement(Name:String):TseCSSElement;
Var
  i : integer;
  El : TseCSSElement;
  lst : TStringList;
begin
  result := nil;
  lst := TStringlist.Create;
  for i := 0 to Count-1 do begin
    try
      El := TseCSSElement(Objects[i]);
      if assigned(El) then begin
        if fastpos(El.Name, ',', length(El.Name), 1, 1) > 0 then begin
          lst.CommaText := lowercase(El.Name);
          if lst.IndexOf(lowercase(Name)) >= 0 then begin
            result := El;
            break;
          end;
        end
        else begin
          if (lowercase(El.Name) = lowercase(Name)) then begin
            result := El;
            break;
          end;  
        end;
      end;
    except
    end;
  end;
  lst.Free;
end;



constructor TseCSSParser.Create;
begin
  inherited Create(AOwner);
  fCSSLines := TStringlist.Create;
  fCSSElements := TseCSSElements.Create;
  fCSSText := TStringlist.Create;
end;

destructor TseCSSParser.Destroy;
begin
  fCSSText.Free;
  fCSSElements.Free;
  fCSSLines.Free;
  inherited Destroy;
end;

Procedure TseCSSParser.SetCSSText(Value : TStrings);
begin
  if assigned(Value) then
    fCSSText.Assign(Value);
end;

Procedure TseCSSParser.SetFilename(Value : TFilename);
begin
  if Value <> fFilename then begin
    fFilename := Value;
    if fAutoLoad and (Trim(fFilename)<>'') then begin
      try
        fCSSText.LoadFromFile(fFilename);
      except

      end;
    end
    else
      fCSSText.Text := '';
  end;
end;


Function TseCSSParser.GetCSSLines(Var S:WideString; CSSLines:TStrings):Integer;
Var
  CSS : WideString;
  pBegin, pEnd, i,j : integer;
begin
  result := 0;
  if not assigned(CSSLines) then exit;
  CSSLines.Clear;


  // Erst alle Kommentare entfernen
  pBegin := fastpos(S, '/*', length(S), 2, 1);
  while pBegin > 0 do begin
    pEnd := fastpos(S, '*/', length(S), 2, pBegin+2);
    if pEnd > 0 then
      Delete(S, pBegin, (pEnd+2)-pBegin)
    else
      pBegin := 0;
    if pBegin > 0 then
      pBegin := fastpos(S, '/*', length(S), 2, 1);

  end;

//  SynEdit2.Lines.Text := trim(S);


  // Nun alle CSS-Werte finden
  // Erst alle Kommentare entfernen
  pBegin := fastpos(S, '{', length(S), 1, 1);
  while pBegin > 0 do begin
    pEnd := fastpos(S, '}', length(S), 1, pBegin+1);
    if pEnd > 0 then begin
      CSS := Copy(S, 1, pEnd+1);
      CSS := Trim(CSS);
      CSS := fastreplace(CSS, #13, '');
      CSS := fastreplace(CSS, #10, '');
      CSSLines.Add(CSS);
      inc(result);
      Delete(S, 1, (pEnd));
    end
    else
      pBegin := 0;
    if pBegin > 0 then
      pBegin := fastpos(S, '{', length(S), 1, 1);
  end;

end;


Function TseCSSParser.RemoveFirstBracket(Var S:WideString):Boolean;
Var
  _S, CSS : WideString;
  pBegin, pEnd, i,j : integer;
begin
  result := false;
  _S := S;

  pEnd := fastpos(_S, '{', length(_S), 1, 1);
  if pEnd > 0 then begin
    Delete(_S, 1, pEnd);
    S := _S;
    result := true;
  end;
end;

Function TseCSSParser.RemoveCSSElement(Var S:WideString):Boolean;
Var
  _S, CSS : WideString;
  pBegin, pEnd, i,j : integer;
begin
  result := false;
  _S := S;

  pEnd := fastpos(_S, '{', length(_S), 1, 1);
  if pEnd > 0 then begin
    Delete(_S, 1, pEnd-1);
    S := _S;
    result := true;
  end;
end;

Function TseCSSParser.GetCSSElement(Var CSSLine:WideString; Var CSSElement:WideString; RemoveName:Boolean=True):Boolean;
Var
  pBegin, pEnd, i,j : integer;
begin
  result := false;
  pEnd := fastpos(CSSLine, '{', length(CSSLine), 1, 1);
  if pEnd > 0 then begin
    CSSElement := Copy(CSSLine, 1, pEnd-1);
    CSSElement := Trim(CSSElement);
    if RemoveName then
      RemoveCSSElement(CSSLine);
    if CSSElement = '' then
      result := false
    else
      result := true;
  end;
end;

Function TseCSSParser.SearchFirstCSSName(Var CSSLine, CSSName, CSSValue: WideString; RemoveName:Boolean=True):Boolean;
Var
  S, temp : WideString;
  pBegin, pEnd, i,j : integer;

begin
  result := false;

  // First Extract Name and Value
  try
  pEnd := fastpos(CSSLine, ';', length(CSSLine), 1, 1);
  if pEnd > 0 then begin
    pBegin := fastpos(CSSLine, ':', length(CSSLine), 1, 1);
    if pBegin > 0 then begin
      S := Copy(CSSLine, 1, pEnd-1);
      S := Trim(S);

      // Now explode Name and Value
      pBegin := fastpos(S, ':', length(S), 1, 1);
      if pBegin>0 then begin
        temp := Copy(S, 1, pBegin-1);
        CSSName := Trim(temp);
        temp := Copy(S, pBegin+1, length(S)-1);
        CSSValue := Trim(temp);

        if RemoveName then
          Delete(CSSLine, 1, pEnd);
        result := true;

      end;


    end
    else begin
      CSSName := '';
      CSSValue := '';
    end;

  end;
  except
    result := false;
    CSSName := '';
    CSSValue := '';
  end;
end;

Procedure TseCSSParser.Parse;
Var
  RawCSS, CSSElement, CSSAName, CSSAValue : WideString;
  i : integer;
  CSSElementObj: TseCSSElement;
  CSSAttributeObj: TseCSSAttribute;
  hasAttribute: Boolean;
begin
  fCSSElements.Clear;
  fCSSLines.Clear;

  RawCSS := fCSSText.Text;
  // Remove Comments and Creating Single Lines of RAW CSS-Elements
  if GetCSSLines(WideString(RawCSS),fCSSLines) > 0 then begin

    for i := 0 to fCSSLines.Count-1 do begin
      RawCSS := fCSSLines[i];
      if Trim(RawCSS) <> '' then begin

        // Get the Name of the CSS Element
        CSSElementObj := TseCSSElement.Create('');
        CSSElementObj.RawText := RawCSS;
        if GetCSSElement(RawCSS, CSSElement) then begin
          CSSElementObj.Name := CSSElement;
          fCSSElements.AddObject(CSSElement,CSSElementObj);

          // Now extrat all Attributes
          if RemoveFirstBracket(RawCSS) then begin
            hasAttribute := SearchFirstCSSName(RawCSS, CSSAName, CSSAValue);
            while hasAttribute do begin
              CSSAttributeObj:= TseCSSAttribute.Create(CSSAName, CSSAValue);
              CSSElementObj.fAttributtes.AddObject(CSSAName,CSSAttributeObj);
              hasAttribute := SearchFirstCSSName(RawCSS, CSSAName, CSSAValue);
            end;
          end;


        end
        else begin
          try
            CSSElementObj.Free;
          except end;
        end;

      end;
    end;
  end;
end;

Procedure TseCSSParser.AssignTo(Strings:TStrings);
begin
  if assigned(Strings) then
    Strings.Assign(fCSSElements);
end;

Function TseCSSParser.GetElementsCount:Integer;
begin
  if assigned(fCSSElements) then
    result := fCSSElements.Count
  else
    result := 0;
end;

Function TseCSSParser.GetElement(Index:Integer):TseCSSElement;
begin
  try
    result := TseCSSElement(fCSSElements.Objects[Index]);
  except
    result := nil;
  end;
end;

Function TseCSSParser.GetValue(Element:String;Attribute:String):String;
Var
  El : TseCSSElement;
  i : integer;
begin
  result := '';
  EL := fCSSElements.Element[Element];
  if assigned(EL) then
    result := EL.fAttributtes.Value[Attribute];
end;


end.
