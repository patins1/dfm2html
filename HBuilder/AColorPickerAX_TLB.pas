unit AColorPickerAX_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 98336 $
// File generated on 12/7/2022 11:16:12 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files (x86)\Eltima Software\Absolute Color Picker ActiveX Control\AColorPickerAXOEM.ocx (1)
// LIBID: {5B0E435A-5156-4445-914C-45CA3B845805}
// LCID: 0
// Helpfile: 
// HelpString: Absolute Color Picker ActiveX Control OEM
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleCtrls, Vcl.OleServer, Winapi.ActiveX;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  AColorPickerAXMajorVersion = 3;
  AColorPickerAXMinorVersion = 18;

  LIBID_AColorPickerAX: TGUID = '{5B0E435A-5156-4445-914C-45CA3B845805}';

  IID_IColorDialogAX: TGUID = '{BF7E84AA-F5DF-4FCA-A329-0A806B97FD01}';
  DIID_IColorDialogAXEvents: TGUID = '{6F5A41D1-BE78-41AF-B88C-E76C4BBF09F7}';
  CLASS_AColorDialog: TGUID = '{A6D3DCA6-C12E-4C3C-A1E5-F1EEEF971013}';
  IID_IGradientDialogAX: TGUID = '{6714ED92-6D2C-43B0-B415-39D1DBF9409B}';
  DIID_IGradientDialogAXEvents: TGUID = '{CADD7E50-5F21-4DE5-A5C2-4BAA28E494A9}';
  CLASS_AGradientDialog: TGUID = '{94939C10-DFE6-4AD4-97B1-62C65C6DF198}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IColorDialogAX = interface;
  IColorDialogAXDisp = dispinterface;
  IColorDialogAXEvents = dispinterface;
  IGradientDialogAX = interface;
  IGradientDialogAXDisp = dispinterface;
  IGradientDialogAXEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  AColorDialog = IColorDialogAX;
  AGradientDialog = IGradientDialogAX;


// *********************************************************************//
// Interface: IColorDialogAX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BF7E84AA-F5DF-4FCA-A329-0A806B97FD01}
// *********************************************************************//
  IColorDialogAX = interface(IDispatch)
    ['{BF7E84AA-F5DF-4FCA-A329-0A806B97FD01}']
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
    procedure AboutBox; safecall;
    function ExecuteFromHandle(Handle: OLE_HANDLE): OLE_ENABLEDEFAULTBOOL; safecall;
    function ExecuteFromPos(X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS): OLE_ENABLEDEFAULTBOOL; safecall;
    function ExecuteFromMouse: WordBool; safecall;
    function Execute: WordBool; safecall;
    function Get_UseAlpha: WordBool; safecall;
    procedure Set_UseAlpha(Value: WordBool); safecall;
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    function Get_Alpha: Smallint; safecall;
    procedure Set_Alpha(Value: Smallint); safecall;
    function Get_RGBA: Integer; safecall;
    procedure Set_RGBA(Value: Integer); safecall;
    function Get_RGB: Integer; safecall;
    procedure Set_RGB(Value: Integer); safecall;
    function Get_RGB_R: Smallint; safecall;
    procedure Set_RGB_R(Value: Smallint); safecall;
    function Get_RGB_G: Smallint; safecall;
    procedure Set_RGB_G(Value: Smallint); safecall;
    function Get_RGB_B: Smallint; safecall;
    procedure Set_RGB_B(Value: Smallint); safecall;
    function Get_HSBA: Integer; safecall;
    procedure Set_HSBA(Value: Integer); safecall;
    function Get_HSB: Integer; safecall;
    procedure Set_HSB(Value: Integer); safecall;
    function Get_HSB_H: Smallint; safecall;
    procedure Set_HSB_H(Value: Smallint); safecall;
    function Get_HSB_S: Smallint; safecall;
    procedure Set_HSB_S(Value: Smallint); safecall;
    function Get_HSB_B: Smallint; safecall;
    procedure Set_HSB_B(Value: Smallint); safecall;
    function Get_Pages_ActivePage: Smallint; safecall;
    procedure Set_Pages_ActivePage(Value: Smallint); safecall;
    function Get_Pages_ShowIcons: WordBool; safecall;
    procedure Set_Pages_ShowIcons(Value: WordBool); safecall;
    function Get_Pages_ShowCaptions: WordBool; safecall;
    procedure Set_Pages_ShowCaptions(Value: WordBool); safecall;
    function Get_Pages_HSBBrightness: WordBool; safecall;
    procedure Set_Pages_HSBBrightness(Value: WordBool); safecall;
    function Get_Pages_HSBRadial: WordBool; safecall;
    procedure Set_Pages_HSBRadial(Value: WordBool); safecall;
    function Get_Pages_HSBHue: WordBool; safecall;
    procedure Set_Pages_HSBHue(Value: WordBool); safecall;
    function Get_Pages_RGB3D: WordBool; safecall;
    procedure Set_Pages_RGB3D(Value: WordBool); safecall;
    function Get_Pages_Sphere: WordBool; safecall;
    procedure Set_Pages_Sphere(Value: WordBool); safecall;
    function Get_Pages_HSBHue2: WordBool; safecall;
    procedure Set_Pages_HSBHue2(Value: WordBool); safecall;
    function Get_Pages_Pens: WordBool; safecall;
    procedure Set_Pages_Pens(Value: WordBool); safecall;
    function Get_Pages_Hexagons: WordBool; safecall;
    procedure Set_Pages_Hexagons(Value: WordBool); safecall;
    function Get_Pages_Palettes: WordBool; safecall;
    procedure Set_Pages_Palettes(Value: WordBool); safecall;
    function Get_ShowCaption: WordBool; safecall;
    procedure Set_ShowCaption(Value: WordBool); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function Get_WebColor: OLE_COLOR; safecall;
    procedure Set_WebColor(Value: OLE_COLOR); safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property UseAlpha: WordBool read Get_UseAlpha write Set_UseAlpha;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property Alpha: Smallint read Get_Alpha write Set_Alpha;
    property RGBA: Integer read Get_RGBA write Set_RGBA;
    property RGB: Integer read Get_RGB write Set_RGB;
    property RGB_R: Smallint read Get_RGB_R write Set_RGB_R;
    property RGB_G: Smallint read Get_RGB_G write Set_RGB_G;
    property RGB_B: Smallint read Get_RGB_B write Set_RGB_B;
    property HSBA: Integer read Get_HSBA write Set_HSBA;
    property HSB: Integer read Get_HSB write Set_HSB;
    property HSB_H: Smallint read Get_HSB_H write Set_HSB_H;
    property HSB_S: Smallint read Get_HSB_S write Set_HSB_S;
    property HSB_B: Smallint read Get_HSB_B write Set_HSB_B;
    property Pages_ActivePage: Smallint read Get_Pages_ActivePage write Set_Pages_ActivePage;
    property Pages_ShowIcons: WordBool read Get_Pages_ShowIcons write Set_Pages_ShowIcons;
    property Pages_ShowCaptions: WordBool read Get_Pages_ShowCaptions write Set_Pages_ShowCaptions;
    property Pages_HSBBrightness: WordBool read Get_Pages_HSBBrightness write Set_Pages_HSBBrightness;
    property Pages_HSBRadial: WordBool read Get_Pages_HSBRadial write Set_Pages_HSBRadial;
    property Pages_HSBHue: WordBool read Get_Pages_HSBHue write Set_Pages_HSBHue;
    property Pages_RGB3D: WordBool read Get_Pages_RGB3D write Set_Pages_RGB3D;
    property Pages_Sphere: WordBool read Get_Pages_Sphere write Set_Pages_Sphere;
    property Pages_HSBHue2: WordBool read Get_Pages_HSBHue2 write Set_Pages_HSBHue2;
    property Pages_Pens: WordBool read Get_Pages_Pens write Set_Pages_Pens;
    property Pages_Hexagons: WordBool read Get_Pages_Hexagons write Set_Pages_Hexagons;
    property Pages_Palettes: WordBool read Get_Pages_Palettes write Set_Pages_Palettes;
    property ShowCaption: WordBool read Get_ShowCaption write Set_ShowCaption;
    property Caption: WideString read Get_Caption write Set_Caption;
    property WebColor: OLE_COLOR read Get_WebColor write Set_WebColor;
  end;

// *********************************************************************//
// DispIntf:  IColorDialogAXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BF7E84AA-F5DF-4FCA-A329-0A806B97FD01}
// *********************************************************************//
  IColorDialogAXDisp = dispinterface
    ['{BF7E84AA-F5DF-4FCA-A329-0A806B97FD01}']
    property Visible: WordBool dispid 209;
    procedure SetSubComponent(IsSubComponent: WordBool); dispid 210;
    procedure AboutBox; dispid 201;
    function ExecuteFromHandle(Handle: OLE_HANDLE): OLE_ENABLEDEFAULTBOOL; dispid 202;
    function ExecuteFromPos(X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS): OLE_ENABLEDEFAULTBOOL; dispid 203;
    function ExecuteFromMouse: WordBool; dispid 204;
    function Execute: WordBool; dispid 205;
    property UseAlpha: WordBool dispid 206;
    property Color: OLE_COLOR dispid 207;
    property Alpha: Smallint dispid 208;
    property RGBA: Integer dispid 211;
    property RGB: Integer dispid 212;
    property RGB_R: Smallint dispid 213;
    property RGB_G: Smallint dispid 214;
    property RGB_B: Smallint dispid 215;
    property HSBA: Integer dispid 216;
    property HSB: Integer dispid 217;
    property HSB_H: Smallint dispid 218;
    property HSB_S: Smallint dispid 219;
    property HSB_B: Smallint dispid 220;
    property Pages_ActivePage: Smallint dispid 221;
    property Pages_ShowIcons: WordBool dispid 222;
    property Pages_ShowCaptions: WordBool dispid 223;
    property Pages_HSBBrightness: WordBool dispid 224;
    property Pages_HSBRadial: WordBool dispid 225;
    property Pages_HSBHue: WordBool dispid 226;
    property Pages_RGB3D: WordBool dispid 227;
    property Pages_Sphere: WordBool dispid 228;
    property Pages_HSBHue2: WordBool dispid 229;
    property Pages_Pens: WordBool dispid 230;
    property Pages_Hexagons: WordBool dispid 231;
    property Pages_Palettes: WordBool dispid 232;
    property ShowCaption: WordBool dispid 233;
    property Caption: WideString dispid 234;
    property WebColor: OLE_COLOR dispid 235;
  end;

// *********************************************************************//
// DispIntf:  IColorDialogAXEvents
// Flags:     (4096) Dispatchable
// GUID:      {6F5A41D1-BE78-41AF-B88C-E76C4BBF09F7}
// *********************************************************************//
  IColorDialogAXEvents = dispinterface
    ['{6F5A41D1-BE78-41AF-B88C-E76C4BBF09F7}']
  end;

// *********************************************************************//
// Interface: IGradientDialogAX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6714ED92-6D2C-43B0-B415-39D1DBF9409B}
// *********************************************************************//
  IGradientDialogAX = interface(IDispatch)
    ['{6714ED92-6D2C-43B0-B415-39D1DBF9409B}']
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
    function Get_CurrentIndex: Smallint; safecall;
    procedure Set_CurrentIndex(Value: Smallint); safecall;
    function Get_CurrentColor: OLE_COLOR; safecall;
    procedure Set_CurrentColor(Value: OLE_COLOR); safecall;
    function Get_CurrentR: Smallint; safecall;
    procedure Set_CurrentR(Value: Smallint); safecall;
    function Get_CurrentG: Smallint; safecall;
    procedure Set_CurrentG(Value: Smallint); safecall;
    function Get_CurrentB: Smallint; safecall;
    procedure Set_CurrentB(Value: Smallint); safecall;
    function Get_CurrentA: Smallint; safecall;
    procedure Set_CurrentA(Value: Smallint); safecall;
    function Get_CurrentRatio: Smallint; safecall;
    procedure Set_CurrentRatio(Value: Smallint); safecall;
    function Get_Count: Smallint; safecall;
    procedure Set_Count(Value: Smallint); safecall;
    function Get_UseAlpha: WordBool; safecall;
    procedure Set_UseAlpha(Value: WordBool); safecall;
    function ExecuteFromHandle(Handle: OLE_HANDLE): OLE_ENABLEDEFAULTBOOL; safecall;
    function ExecuteFromPoint(X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS): OLE_ENABLEDEFAULTBOOL; safecall;
    function ExecuteFromMouse: WordBool; safecall;
    function Execute: WordBool; safecall;
    procedure AboutBox; safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property CurrentIndex: Smallint read Get_CurrentIndex write Set_CurrentIndex;
    property CurrentColor: OLE_COLOR read Get_CurrentColor write Set_CurrentColor;
    property CurrentR: Smallint read Get_CurrentR write Set_CurrentR;
    property CurrentG: Smallint read Get_CurrentG write Set_CurrentG;
    property CurrentB: Smallint read Get_CurrentB write Set_CurrentB;
    property CurrentA: Smallint read Get_CurrentA write Set_CurrentA;
    property CurrentRatio: Smallint read Get_CurrentRatio write Set_CurrentRatio;
    property Count: Smallint read Get_Count write Set_Count;
    property UseAlpha: WordBool read Get_UseAlpha write Set_UseAlpha;
  end;

// *********************************************************************//
// DispIntf:  IGradientDialogAXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6714ED92-6D2C-43B0-B415-39D1DBF9409B}
// *********************************************************************//
  IGradientDialogAXDisp = dispinterface
    ['{6714ED92-6D2C-43B0-B415-39D1DBF9409B}']
    property Visible: WordBool dispid 209;
    procedure SetSubComponent(IsSubComponent: WordBool); dispid 210;
    property CurrentIndex: Smallint dispid 201;
    property CurrentColor: OLE_COLOR dispid 202;
    property CurrentR: Smallint dispid 203;
    property CurrentG: Smallint dispid 204;
    property CurrentB: Smallint dispid 205;
    property CurrentA: Smallint dispid 206;
    property CurrentRatio: Smallint dispid 207;
    property Count: Smallint dispid 208;
    property UseAlpha: WordBool dispid 211;
    function ExecuteFromHandle(Handle: OLE_HANDLE): OLE_ENABLEDEFAULTBOOL; dispid 212;
    function ExecuteFromPoint(X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS): OLE_ENABLEDEFAULTBOOL; dispid 213;
    function ExecuteFromMouse: WordBool; dispid 214;
    function Execute: WordBool; dispid 215;
    procedure AboutBox; dispid 216;
  end;

// *********************************************************************//
// DispIntf:  IGradientDialogAXEvents
// Flags:     (4096) Dispatchable
// GUID:      {CADD7E50-5F21-4DE5-A5C2-4BAA28E494A9}
// *********************************************************************//
  IGradientDialogAXEvents = dispinterface
    ['{CADD7E50-5F21-4DE5-A5C2-4BAA28E494A9}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TAColorDialog
// Help String      : Absolute Color Picker ActiveX Control by Eltima Software
// Default Interface: IColorDialogAX
// Def. Intf. DISP? : No
// Event   Interface: IColorDialogAXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TAColorDialog = class(TOleControl)
  private
    FIntf: IColorDialogAX;
    function  GetControlInterface: IColorDialogAX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure SetSubComponent(IsSubComponent: WordBool);
    procedure AboutBox;
    function ExecuteFromHandle(Handle: OLE_HANDLE): OLE_ENABLEDEFAULTBOOL;
    function ExecuteFromPos(X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS): OLE_ENABLEDEFAULTBOOL;
    function ExecuteFromMouse: WordBool;
    function Execute: WordBool;
    property  ControlInterface: IColorDialogAX read GetControlInterface;
    property  DefaultInterface: IColorDialogAX read GetControlInterface;
    property Visible: WordBool index 209 read GetWordBoolProp write SetWordBoolProp;
  published
    property Anchors;
    property UseAlpha: WordBool index 206 read GetWordBoolProp write SetWordBoolProp stored False;
    property Color: TColor index 207 read GetTColorProp write SetTColorProp stored False;
    property Alpha: Smallint index 208 read GetSmallintProp write SetSmallintProp stored False;
    property RGBA: Integer index 211 read GetIntegerProp write SetIntegerProp stored False;
    property RGB: Integer index 212 read GetIntegerProp write SetIntegerProp stored False;
    property RGB_R: Smallint index 213 read GetSmallintProp write SetSmallintProp stored False;
    property RGB_G: Smallint index 214 read GetSmallintProp write SetSmallintProp stored False;
    property RGB_B: Smallint index 215 read GetSmallintProp write SetSmallintProp stored False;
    property HSBA: Integer index 216 read GetIntegerProp write SetIntegerProp stored False;
    property HSB: Integer index 217 read GetIntegerProp write SetIntegerProp stored False;
    property HSB_H: Smallint index 218 read GetSmallintProp write SetSmallintProp stored False;
    property HSB_S: Smallint index 219 read GetSmallintProp write SetSmallintProp stored False;
    property HSB_B: Smallint index 220 read GetSmallintProp write SetSmallintProp stored False;
    property Pages_ActivePage: Smallint index 221 read GetSmallintProp write SetSmallintProp stored False;
    property Pages_ShowIcons: WordBool index 222 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_ShowCaptions: WordBool index 223 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_HSBBrightness: WordBool index 224 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_HSBRadial: WordBool index 225 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_HSBHue: WordBool index 226 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_RGB3D: WordBool index 227 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_Sphere: WordBool index 228 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_HSBHue2: WordBool index 229 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_Pens: WordBool index 230 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_Hexagons: WordBool index 231 read GetWordBoolProp write SetWordBoolProp stored False;
    property Pages_Palettes: WordBool index 232 read GetWordBoolProp write SetWordBoolProp stored False;
    property ShowCaption: WordBool index 233 read GetWordBoolProp write SetWordBoolProp stored False;
    property Caption: WideString index 234 read GetWideStringProp write SetWideStringProp stored False;
    property WebColor: TColor index 235 read GetTColorProp write SetTColorProp stored False;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TAGradientDialog
// Help String      : Absolute Gradient Picker ActiveX Control by Eltima Software
// Default Interface: IGradientDialogAX
// Def. Intf. DISP? : No
// Event   Interface: IGradientDialogAXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TAGradientDialog = class(TOleControl)
  private
    FIntf: IGradientDialogAX;
    function  GetControlInterface: IGradientDialogAX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure SetSubComponent(IsSubComponent: WordBool);
    function ExecuteFromHandle(Handle: OLE_HANDLE): OLE_ENABLEDEFAULTBOOL;
    function ExecuteFromPoint(X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS): OLE_ENABLEDEFAULTBOOL;
    function ExecuteFromMouse: WordBool;
    function Execute: WordBool;
    procedure AboutBox;
    property  ControlInterface: IGradientDialogAX read GetControlInterface;
    property  DefaultInterface: IGradientDialogAX read GetControlInterface;
    property Visible: WordBool index 209 read GetWordBoolProp write SetWordBoolProp;
  published
    property Anchors;
    property CurrentIndex: Smallint index 201 read GetSmallintProp write SetSmallintProp stored False;
    property CurrentColor: TColor index 202 read GetTColorProp write SetTColorProp stored False;
    property CurrentR: Smallint index 203 read GetSmallintProp write SetSmallintProp stored False;
    property CurrentG: Smallint index 204 read GetSmallintProp write SetSmallintProp stored False;
    property CurrentB: Smallint index 205 read GetSmallintProp write SetSmallintProp stored False;
    property CurrentA: Smallint index 206 read GetSmallintProp write SetSmallintProp stored False;
    property CurrentRatio: Smallint index 207 read GetSmallintProp write SetSmallintProp stored False;
    property Count: Smallint index 208 read GetSmallintProp write SetSmallintProp stored False;
    property UseAlpha: WordBool index 211 read GetWordBoolProp write SetWordBoolProp stored False;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses System.Win.ComObj;

procedure TAColorDialog.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{A6D3DCA6-C12E-4C3C-A1E5-F1EEEF971013}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80040112*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TAColorDialog.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IColorDialogAX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TAColorDialog.GetControlInterface: IColorDialogAX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TAColorDialog.SetSubComponent(IsSubComponent: WordBool);
begin
  DefaultInterface.SetSubComponent(IsSubComponent);
end;

procedure TAColorDialog.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

function TAColorDialog.ExecuteFromHandle(Handle: OLE_HANDLE): OLE_ENABLEDEFAULTBOOL;
begin
  Result := DefaultInterface.ExecuteFromHandle(Handle);
end;

function TAColorDialog.ExecuteFromPos(X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS): OLE_ENABLEDEFAULTBOOL;
begin
  Result := DefaultInterface.ExecuteFromPos(X, Y);
end;

function TAColorDialog.ExecuteFromMouse: WordBool;
begin
  Result := DefaultInterface.ExecuteFromMouse;
end;

function TAColorDialog.Execute: WordBool;
begin
  Result := DefaultInterface.Execute;
end;

procedure TAGradientDialog.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID:      '{94939C10-DFE6-4AD4-97B1-62C65C6DF198}';
    EventIID:     '';
    EventCount:   0;
    EventDispIDs: nil;
    LicenseKey:   nil (*HR:$80040112*);
    Flags:        $00000000;
    Version:      500);
begin
  ControlData := @CControlData;
end;

procedure TAGradientDialog.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IGradientDialogAX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TAGradientDialog.GetControlInterface: IGradientDialogAX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TAGradientDialog.SetSubComponent(IsSubComponent: WordBool);
begin
  DefaultInterface.SetSubComponent(IsSubComponent);
end;

function TAGradientDialog.ExecuteFromHandle(Handle: OLE_HANDLE): OLE_ENABLEDEFAULTBOOL;
begin
  Result := DefaultInterface.ExecuteFromHandle(Handle);
end;

function TAGradientDialog.ExecuteFromPoint(X: OLE_XPOS_PIXELS; Y: OLE_YPOS_PIXELS): OLE_ENABLEDEFAULTBOOL;
begin
  Result := DefaultInterface.ExecuteFromPoint(X, Y);
end;

function TAGradientDialog.ExecuteFromMouse: WordBool;
begin
  Result := DefaultInterface.ExecuteFromMouse;
end;

function TAGradientDialog.Execute: WordBool;
begin
  Result := DefaultInterface.Execute;
end;

procedure TAGradientDialog.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TAColorDialog, TAGradientDialog]);
end;

end.
