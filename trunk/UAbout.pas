{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit UAbout;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes,
  Controls, mckControls, mckObjs, Graphics,
  mckCtrls {$IFEND (place your units here->)},ShellAPI;
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFAboutclass.inc} {$ELSE OBJECTS} PFAbout = ^TFAbout; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFAbout.inc}{$ELSE} TFAbout = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFAbout = class(TForm)
  {$IFEND KOL_MCK}
    KOLFrame1: TKOLFrame;
    GPMain: TKOLGradientPanel;
    LMail: TKOLLabel;
    LWeb: TKOLLabel;
    L1: TKOLLabel;
    Button1: TKOLButton;
    Button2: TKOLButton;
    Memo1: TKOLMemo;
    BtnHelp: TKOLButton;
    LTitle: TKOLLabel;
    procedure KOLFrame1FormCreate(Sender: PObj);
    procedure KOLFrame1Show(Sender: PObj);
    procedure KOLFrame1Destroy(Sender: PObj);
    procedure LWebClick(Sender: PObj);
    procedure LWebMouseMove(Sender: PControl; var Mouse: TMouseEventData);
    procedure LWebMouseLeave(Sender: PObj);
    procedure Button2Click(Sender: PObj);
    procedure Button1Click(Sender: PObj);
    procedure BtnHelpClick(Sender: PObj);
    procedure LMailClick(Sender: PObj);
    procedure LMailMouseLeave(Sender: PObj);
    procedure LMailMouseMove(Sender: PControl; var Mouse: TMouseEventData);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAbout {$IFDEF KOL_MCK} : PFAbout {$ELSE} : TFAbout {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFAbout( var Result: PFAbout; AParent: PControl );
{$ENDIF}

implementation

uses Shollu, Unit1;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UAbout_1.inc}
{$ENDIF}

procedure TFAbout.KOLFrame1FormCreate(Sender: PObj);
begin
//  Form1.CreateFrameRgn(Form);
  LTitle.Caption := 'Shollu '+versi;
  L1.Caption := 'copyright ©2004-2012 by Ebta setiawan';
  LMail.Caption := 'e-mail : ebta.setiawan@gmail.com';
  LWeb.Caption := 'http://ebsoft.web.id';
  Button1Click(sender);
end;

procedure TFAbout.KOLFrame1Show(Sender: PObj);
begin
  if IndexColor > 20 then
    GPMain.Color2 := cForm
  else
    GPMain.Color2 := cGPMain1Col1;
    
  GPMain.Color1 := cForm;
  Form.Color := cForm;
  Memo1.Color := cForm;
  BtnHelp.Caption :=lang.Items[150];
end;

procedure TFAbout.KOLFrame1Destroy(Sender: PObj);
begin
  if not AppletTerminated then
  FAbout := nil;
end;

procedure TFAbout.LWebClick(Sender: PObj);
begin
  ShellExecute(0, 'open', PChar(LWeb.Caption), '', '', SW_SHOWNORMAL);
end;

procedure TFAbout.LWebMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  LWeb.Font.FontStyle := [fsUnderline];
end;

procedure TFAbout.LWebMouseLeave(Sender: PObj);
begin
  LWeb.Font.FontStyle := [];
end;

procedure TFAbout.Button2Click(Sender: PObj);
begin
  Memo1.Text := StrLoadFromFile(SholluDir+'License.txt')
end;

procedure TFAbout.Button1Click(Sender: PObj);
begin
  Memo1.Text := StrLoadFromFile(SholluDir+'Lisensi.txt')
end;

procedure TFAbout.BtnHelpClick(Sender: PObj);
begin
  Form1.OpenHelpFile(BtnHelp.caption);
end;

procedure TFAbout.LMailClick(Sender: PObj);
begin
   ShellExecute(0, 'Open',PChar('mailto:ebta.setiawan@gmail.com?subject=Shollu '+versi)
                ,'', '', SW_SHOWNORMAL);
end;

procedure TFAbout.LMailMouseLeave(Sender: PObj);
begin
  LMail.Font.FontStyle := [];
end;

procedure TFAbout.LMailMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  LMail.Font.FontStyle := [fsUnderline];
end;

end.






