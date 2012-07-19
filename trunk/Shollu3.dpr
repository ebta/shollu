{ KOL MCK } // Do not remove this line!
program Shollu3;
{$R *.res}
{.$WARNINGS OFF}

uses
KOL,
  HeapMM,
  Unit1 in 'Unit1.pas' {Form1},
  Shollu in 'Shollu.pas',
  UColConv in 'UColConv.pas',
  UMainPage in 'UMainPage.pas' {FMainPage},
  USettingpas in 'USettingpas.pas' {FSetting},
  UArea in 'UArea.pas' {FArea},
  UMessage in 'UMessage.pas' {FMessage},
  USchedule in 'USchedule.pas' {FSchedule},
  UAbout in 'UAbout.pas' {FAbout},
  UCities in 'UCities.pas' {FCities},
  UDialog in 'UDialog.pas' {FDialog},
  UBar in 'UBar.pas' {FBar},
  UTask in 'UTask.pas' {FTask},
  UConvert in 'UConvert.pas' {FConvert},
  UDropZone in 'UDropZone.pas' {FDropZone};

begin // PROGRAM START HERE -- Please do not remove this comment

{$IF Defined(KOL_MCK)} {$I Shollu3_0.inc} {$ELSE}

{$IFDEF KOL_MCK} {$I Shollu3_0.inc} {$ELSE}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
{$ENDIF}

{$IFEND}

end.

