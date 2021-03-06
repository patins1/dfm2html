program DFM2HTML;

{$R *.res}

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  Dialogs,
  sysutils,
  classes,
  Unit1 in 'Unit1.pas' {dhMainForm},
  Unit2 in 'Unit2.pas' {Tabs: Frame},
  Unit3 in 'Unit3.pas' {DChild},
  uGradientWizard in 'uGradientWizard.pas' {GradientWizard},
  uWarnings in 'uWarnings.pas' {FormWarnings},
  uOptions in 'uOptions.pas' {Options},
  uTransparencyWizard in 'uTransparencyWizard.pas' {TransparencyWizard},
  uStyleInfo in 'uStyleInfo.pas' {StyleInfo},
  uPageWizard in 'uPageWizard.pas' {PageWizard},
  uPublishFTP in 'uPublishFTP.pas' {PublishFTP},
  uPublishLog in 'uPublishLog.pas' {PublishLog},
  uTemplates in 'uTemplates.pas' {TemplatesWizard},
  uColorizeImg in 'uColorizeImg.pas' {ColorizeImg},
  uBorderRadiusWizard in 'uBorderRadiusWizard.pas' {BorderRadiusWizard},
  uPresets in 'uPresets.pas' {Presets},
  uMoreMisc in 'uMoreMisc.pas' {MoreMisc},
  uStartUp in 'uStartUp.pas' {StartUp},
  uColorPicker in 'uColorPicker.pas' {ColorPicker},
  uFind in 'uFind.pas' {FindText},
  UIConstants in 'UIConstants.pas',
  dhMultilineCaptionEdit in 'dhMultilineCaptionEdit.pas' {dhMultilineCaptionEdit2},
  BasicHTMLElements in '..\d6\BasicHTMLElements.pas',
  uChooseWide in 'uChooseWide.pas' {ChooseUnicode},
  uObjectExplorer in 'uObjectExplorer.pas' {ObjectExplorer},
  uResourceExplorer in 'uResourceExplorer.pas' {ResourceExplorer},
  uMetaWriter in 'uMetaWriter.pas',
  uBella in 'uBella.pas' {Bella};

begin
  Application.Title := 'DFM2HTML';
  Application.HelpFile := '';
  Application.CreateForm(TdhMainForm, dhMainForm);
  Application.CreateForm(TTabs, Tabs);
  Application.Run;
end.
