{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit UMessage;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls, mckControls, mckObjs, Graphics, mckCtrls {$IFEND (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFMessageclass.inc} {$ELSE OBJECTS} PFMessage = ^TFMessage; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFMessage.inc}{$ELSE} TFMessage = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFMessage = class(TForm)
  {$IFEND KOL_MCK}
    KOLFrame1: TKOLFrame;
    GPmain: TKOLGradientPanel;
    BtnSave: TKOLBitBtn;
    CB8: TKOLCheckBox;
    DateJumat: TKOLDateTimePicker;
    CB9: TKOLCheckBox;
    EBInfo: TKOLEditBox;
    Lbl4: TKOLLabel;
    GBMain: TKOLGroupBox;
    CB2: TKOLCheckBox;
    CB3: TKOLCheckBox;
    CB4: TKOLCheckBox;
    CB5: TKOLCheckBox;
    CBHibernate: TKOLCheckBox;
    GB3: TKOLGroupBox;
    EBShutdown: TKOLEditBox;
    CBHibernateAfter: TKOLCheckBox;
    CB7: TKOLCheckBox;
    CB6: TKOLCheckBox;
    EBMsg2: TKOLEditBox;
    GB1: TKOLGroupBox;
    CB1: TKOLCheckBox;
    EBMsg1: TKOLEditBox;
    Button1: TKOLButton;
    procedure KOLFrame1Show(Sender: PObj);                                                                                              
    procedure CB1Click(Sender: PObj);
    procedure BtnSaveClick(Sender: PObj);
    procedure CB6Click(Sender: PObj);
    procedure CB7Click(Sender: PObj);
    procedure CB8Click(Sender: PObj);
    procedure CB9Click(Sender: PObj);
    procedure KOLFrame1Destroy(Sender: PObj);
    procedure CB5Click(Sender: PObj);
    procedure CBHibernateClick(Sender: PObj);
    procedure CBHibernateAfterClick(Sender: PObj);
    procedure BtnSaveMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure BtnSaveMouseLeave(Sender: PObj);
  private
    { Private declarations }
    procedure UpdateLanguage;
  public
    { Public declarations }
  end;

var
  FMessage {$IFDEF KOL_MCK} : PFMessage {$ELSE} : TFMessage {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFMessage( var Result: PFMessage; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, Shollu;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UMessage_1.inc}
{$ENDIF}

procedure TFMessage.KOLFrame1Show(Sender: PObj);
var
  Preg : HKEY;
  D : Double;
  dw: Integer;
begin
  if IndexColor > 20 then
    GPmain.Color2 := cForm
  else
    GPmain.Color2 := cGPMain1Col1;
    
  GPmain.Color1 := cForm;
  GBmain.Color := cForm;
  GB1.Color := cForm;
  GB3.Color := cForm;
  Form.Color := cForm;

  CB1.Color := cForm;
  CB2.Color := cForm;
  CB3.Color := cForm;
  CB4.Color := cForm;
  CB5.Color := cForm;
  CB6.Color := cForm;
  CB7.Color := cForm;
  CBHibernate.Color := cForm;
  CBHibernateAfter.Color := cForm;

  UpdateLanguage;
  EBMsg1.Left := CB1.Left + CB1.Width + 5;
  EBMsg2.Left := CB6.Left + CB6.Width + 5;
  DateJumat.Left := CB8.Left + CB8.Width +5;
  CBHibernate.Left := CB5.Left + CB5.Width + 5;
  CBHibernateAfter.Left := CB7.Left +CB7.Width +5;
  EBShutdown.Left := CBHibernateAfter.Left + CBHibernateAfter.Width + 5;

  Preg := RegKeyOpenRead(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  if Preg <> 0 then
  begin
    CB1.Checked := RegKeyGetDw(Preg,'Message1')>0;
    CB2.Checked := RegKeyGetDw(Preg,'MMessage')=1;
    CB3.Checked := RegKeyGetDw(Preg,'MMinimize')=1;
    CB4.Checked := RegKeyGetDw(Preg,'MAdzan')=1;
    CB5.Checked := RegKeyGetDw(Preg,'MShutdown')=1;
    CB6.Checked := RegKeyGetDw(Preg,'Message2')>1;
    CB7.Checked := RegKeyGetDw(Preg,'MShutdownAfter')=1;
    CBHibernateAfter.Checked := RegKeyGetDw(Preg,'MShutdownAfter') =2;
    CBHibernate.Checked := RegKeyGetDw(Preg,'MShutdown') = 2;
    RegKeyGetBinary(Preg,'MJumat',D,8);
    CB8.Checked := D > 0;
    dw := RegKeyGetDw(Preg,'ShowInformation');
    CB9.Checked := dw > 0;
    EBInfo.Text := Int2Str(dw);

    EBMsg1.Text := Int2Str(RegKeyGetDw(Preg,'Message1'));
    EBMsg2.Text := Int2Str(RegKeyGetDw(Preg,'Message2'));
    EBShutdown.Text := Int2Str(RegKeyGetDw(Preg,'MTimeShutdown'));
    DateJumat.Time := D;
  end;
  EBMsg1.Visible :=  CB1.Checked = True;
  EBMsg2.Visible :=  CB6.Checked = True;
  DateJumat.Visible := CB8.Checked = True;
  EBShutdown.Visible := CB7.Checked or CBHibernateAfter.Checked;
  RegKeyClose(PReg);

  if isWinVer([wv31,wv95,wv98,wvME]) then
    begin
      CBHibernate.Enabled := False;
      CBHibernate.Checked := False;

      CBHibernateAfter.Enabled := False;
      CBHibernateAfter.Checked := False;
    end;  
end;

procedure TFMessage.UpdateLanguage;
begin
  GB1.Caption := Lang.Items[90];
  CB1.Caption := Lang.Items[91];

  GBmain.Caption := Lang.Items[92];
  CB2.Caption := Lang.Items[93];
  CB3.Caption := Lang.Items[94];
  CB4.Caption := Lang.Items[95];
  CB5.Caption := Lang.Items[96];
  CBHibernate.Caption := lang.Items[97];

  GB3.Caption := Lang.Items[98];
  CB6.Caption := Lang.Items[99];
  CB7.Caption := Lang.Items[100];
  CBHibernateAfter.Caption := Lang.Items[101];

  CB8.Caption := Lang.Items[102];
  CB9.Caption := Lang.Items[103];
  Lbl4.Caption := Lang.Items[104];
  BtnSave.Caption := Lang.Items[105];
  EBInfo.Left := CB9.Left + CB9.Width + 4;
  Lbl4.Left := EBinfo.Left + EBinfo.Width + 4;

  GB1.TextAlign := taCenter;
  GBMain.TextAlign := taCenter;
  GB3.TextAlign := taCenter;
end;

procedure TFMessage.BtnSaveClick(Sender: PObj);
var
  M1,M2,Ms,w1,w2,w3,w4,i1,MH,SA : Word;
  D : TDateTime;
  Preg : HKEY;
begin
  M1 :=0; M2 := 0; Ms :=0; D := 0; MH :=0;
  w1 :=0; w2 := 0; w3 :=0; w4 :=0; i1 :=0; SA :=0;
  if CB1.Checked then M1 := Str2Int(EBMsg1.Text);
  if CB6.Checked then M2 := Str2Int(EBMsg2.Text);

  if CB2.Checked then w1 := 1;
  if CB3.Checked then w2 := 1;
  if CB4.Checked then w3 := 1;
  if CB5.Checked then w4 := 1;
  if CB8.Checked then D := DateJumat.DateTime;
  if CB9.Checked then i1 := Str2Int(EBinfo.Text);
  if CBHibernate.Checked then MH :=2;

  if CB7.Checked then SA :=1
  else if CBHibernateAfter.Checked then SA := 2;

  if CB7.Checked or CBHibernateAfter.Checked then
    Ms := Str2Int(EBShutdown.Text);

  Preg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  if PReg = 0 then
    Preg := RegKeyOpenCreate(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  if Preg <> 0 then
  begin
    RegKeySetDw(Preg,'Message1',M1);
    RegKeySetDw(Preg,'Message2',M2);
    RegKeySetDw(Preg,'MMessage',w1);
    RegKeySetDw(Preg,'MMinimize',w2);
    RegKeySetDw(Preg,'MAdzan',w3);
    RegKeySetDw(Preg,'MShutdown',w4);
    RegKeySetDw(Preg,'MTimeShutdown',Ms);
    RegKeySetDw(Preg,'ShowInformation',i1);
    RegKeySetDw(Preg,'MShutdown',MH);
    RegKeySetBinary(Preg,'MJumat',D,8);
    RegKeySetDw(Preg,'MShutdownAfter',SA);
  end;
  RegCloseKey(Preg);
  Form1.ReadRegistry;
  Form1.LTitleInfo.Caption := Lang.Items[89];
  Form1.animeSaved;
end;

procedure TFMessage.CB1Click(Sender: PObj);
begin
  EBMsg1.Visible :=  CB1.Checked = True;
end;

procedure TFMessage.CB6Click(Sender: PObj);
begin
  EBMsg2.Visible :=  CB6.Checked = True;
end;

procedure TFMessage.CB7Click(Sender: PObj);
begin
  if CB7.Checked then
  begin
    if CBHibernateAfter.Checked then CBHibernateAfter.Checked := False
    else EBShutdown.Visible := True;
  end
  else
    EBShutdown.Visible := CBHibernateAfter.Checked;
end;

procedure TFMessage.CB8Click(Sender: PObj);
begin
  DateJumat.Visible := CB8.Checked;
end;

procedure TFMessage.CB9Click(Sender: PObj);
begin
  EBInfo.Visible := CB9.Checked = True;
end;

procedure TFMessage.KOLFrame1Destroy(Sender: PObj);
begin
  if not AppletTerminated then
  FMessage := nil;
end;

procedure TFMessage.CB5Click(Sender: PObj);
begin
  if CB5.Checked then
  if CBHibernate.Checked then CBHibernate.Checked := False;
end;

procedure TFMessage.CBHibernateClick(Sender: PObj);
begin
  if CBHibernate.Checked then
  if CB5.Checked then CB5.Checked := False;
end;

procedure TFMessage.CBHibernateAfterClick(Sender: PObj);
begin
  if CBHibernateAfter.Checked then
  begin
    if CB7.Checked then CB7.Checked := False;
    EBShutdown.Visible := True;
  end
  else
    EBShutdown.Visible := CB7.Checked;
end;

procedure TFMessage.BtnSaveMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  TKOLBitBtn(Sender).Font.FontStyle := [fsBold]
end;

procedure TFMessage.BtnSaveMouseLeave(Sender: PObj);
begin
  TKOLBitBtn(Sender).Font.FontStyle := []
end;

end.







