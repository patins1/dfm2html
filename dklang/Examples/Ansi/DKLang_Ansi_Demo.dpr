//**********************************************************************************************************************
//  $Id: DKLang_Ansi_Demo.dpr,v 1.1 2006/08/05 21:34:10 dale Exp $
//----------------------------------------------------------------------------------------------------------------------
//  DKLang Localization Package
//  Copyright 2002-2006 DK Software, http://www.dk-soft.org
//**********************************************************************************************************************
program DKLang_Ansi_Demo;

uses
  Forms,
  Main in 'Main.pas' {fMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.