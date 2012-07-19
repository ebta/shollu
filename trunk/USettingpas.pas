{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit USettingpas;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror,  Classes, Controls, mckControls,
  mckObjs, Graphics,  mckCtrls {$IFEND (place your units here->)},
  ShellAPI, KOLMediaPlayer, err;
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFSettingclass.inc} {$ELSE OBJECTS} PFSetting = ^TFSetting; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFSetting.inc}{$ELSE} TFSetting = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFSetting = class(TForm)
  {$IFEND KOL_MCK}
    KOLFrame1: TKOLFrame;
    Timer1: TKOLTimer;
    L2: TKOLLabel;
    L1: TKOLLabel;
    CBLanguage: TKOLComboBox;
    CBSkin: TKOLComboBox;
    GB1: TKOLGroupBox;
    EBAdzanFile: TKOLEditBox;
    BtnPlay: TKOLBitBtn;
    BtnPause: TKOLBitBtn;
    BtnStop: TKOLBitBtn;
    BtnBrowse: TKOLBitBtn;
    ProgressBar1: TKOLProgressBar;
    GB2: TKOLGroupBox;
    RB_hm: TKOLRadioBox;
    RBhms: TKOLRadioBox;
    CBAdzan: TKOLComboBox;
    EPct: TKOLEditBox;
    CBPosition: TKOLComboBox;
    CBBarMotion: TKOLComboBox;
    LabelBar: TKOLLabel;
    LEffect: TKOLLabel;
    CBDlgEffect: TKOLComboBox;
    CBAlpha: TKOLCheckBox;
    LFormatJam: TKOLLabel;
    cbPembulatan: TKOLComboBox;
    Label1: TKOLLabel;
    EdAlpha: TKOLEditBox;
    CBAutoStart: TKOLCheckBox;
    CBOnTop: TKOLCheckBox;
    cbDropZone: TKOLCheckBox;
    BtnSaveSetting: TKOLBitBtn;
    BtnSave: TKOLBitBtn;
    BtnLoadSetting: TKOLBitBtn;
    btnOpenLang2: TKOLButton;
    procedure KOLFrame1FormCreate(Sender: PObj);
    procedure CBSkinChange(Sender: PObj);
    procedure BtnBrowseClick(Sender: PObj);
    procedure BtnPlayClick(Sender: PObj);
    procedure BtnPauseClick(Sender: PObj);
    procedure BtnStopClick(Sender: PObj);
    procedure Timer1Timer(Sender: PObj);
    procedure KOLFrame1Destroy(Sender: PObj);
    procedure BtnSaveClick(Sender: PObj);
    procedure KOLFrame1Show(Sender: PObj);
    procedure CBLanguageChange(Sender: PObj);
    procedure CBDlgEffectChange(Sender: PObj);
    procedure CBAdzanChange(Sender: PObj);
    procedure BtnSaveMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure BtnSaveMouseLeave(Sender: PObj);
    procedure RB_hmClick(Sender: PObj);
    procedure cbDropZoneClick(Sender: PObj);
    procedure BtnSaveSettingClick(Sender: PObj);
    procedure BtnLoadSettingClick(Sender: PObj);
    procedure btnOpenLang2Click(Sender: PObj);
  private
    { Private declarations }
    PReg : HKEY;
    P : PMediaPlayer;
    Procedure UpdateLanguage;
    Procedure UpdateSkin;
  public
    { Public declarations }
    // 3.07
    procedure UpdateOnShow;
  end;
var
  FSetting {$IFDEF KOL_MCK} : PFSetting {$ELSE} : TFSetting {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFSetting( var Result: PFSetting; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, Shollu, UBar, UDialog, UDropZone;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I USettingpas_1.inc}
{$ENDIF}

procedure TFSetting.KOLFrame1FormCreate(Sender: PObj);
var
  s : string;
  F : PDirList;
  i : Integer;
begin
  F := NewDirList(SholluDir+'languages','*.slp',FILE_ATTRIBUTE_NORMAL);
  if F.Count > 0 then
  begin
    for i:=0 to F.Count-1 do
      CBLanguage.Add(ExtractFileNameWOext(F.Names[i]));
  end;
  F.Free;

  Preg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  CBSkin.CurIndex := Str2Int(RegKeyGetStr(PReg,'Skin'));
//  s := RegKeyGetStr(PReg,'Adzan');

  // v3.04
  i := RegKeyGetDw(Preg,'BarWidth');
  if (i>100) or (i<10) then i:=100;
  EPct.Text := Int2Str(i)+'%';

  // v3.05
  i := RegKeyGetDw(PReg,'BarPosition');
  if (i<0) or (i>2) then i:=0;
  CBPosition.CurIndex :=i;
  CBAdzan.Clear;
  CBAdzan.Add(Lang.items[1]);
  CBAdzan.Add(Lang.items[3]);
  CBAdzan.Add(Lang.items[4]);
  CBAdzan.Add(Lang.items[5]);
  CBAdzan.Add(Lang.items[6]);

  CBLanguage.CurIndex := CBLanguage.IndexOf(RegKeyGetStr(PReg,'Language'));
  if RegKeyGetDw(PReg,'TimeFormat') = 0 then
  begin
    RBhms.Checked := False;
    RB_hm.Checked := True;
  end
  else
    begin
    RB_hm.Checked := False;
    RBhms.Checked := True;
    end;

  // v3.06
  cbPembulatan.Enabled := RB_hm.Checked;
  EBAdzanFile.Text := s;

  PReg := RegKeyOpenRead(HKEY_LOCAL_MACHINE,REG_RUN);
  CBAutoStart.Checked := (RegKeyValExists(Preg,'Shollu3') = True) and
                         (LowerCase(RegKeyGetStr(Preg,'Shollu3')) ='"'+LowerCase(ParamStr(0))+'"');

  if WinVer < wvY2K then
  begin
    CBAlpha.Enabled := False;
    CBAlpha.Checked := false;
  end;
  Preg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
end;

procedure TFSetting.UpdateSkin;
begin
//  if IndexColor > 20 then
//    GPMain.Color2 := cForm
//  else
//    GPMain.Color2 := cGPMain1Col1;
//
//  GPMain.Color1 := cForm;

  ProgressBar1.ProgressBkColor := cGPMain1Col1;
  ProgressBar1.ProgressColor := cBorder2;
  Form.Color := cForm;
  GB1.Color := cForm;
  GB2.Color := cForm;
//  GB3.Color := cForm;
  RB_hm.Color := cForm;
  RBhms.Color := cForm;
  L1.Color := cForm;
  L2.Color := cForm;
  L1.Font.Color := cMainFont;
  L2.Font.Color := cMainFont;
//  GBDialog.Color := cForm;

  CBSkin.Color := cForm;
  CBLanguage.Color := cForm;

  EBAdzanFile.Color := cForm;
  EBAdzanFile.Font.Color := cBorder1;
end;

procedure TFSetting.CBSkinChange(Sender: PObj);
begin
  Form1.LoadBmpTop(CBSkin.CurIndex);
  Form1.UpdateSkinColor;
  Form1.Form.Invalidate;
  Form1.TopPanel.Invalidate;
  UpdateSkin;
end;

procedure TFSetting.BtnBrowseClick(Sender: PObj);
var
  osd : POpenSaveDialog;
begin
  Osd := NewOpenSaveDialog('','',[]);
  osd.WndOwner := Form.Handle;
  osd.OpenDialog := True;
  osd.Title := Lang.Items[181];
  osd.Filter := 'Supported Sound Files (*.wav,*.mp3 ) | *.MP3;*.WAV'+
                '|Others Audio Video format (*.mid,*.midi,*.avi,*.rmi,*.mpg,*.wmv,*.asf)| *.MID;*.MIDI;*.AVI;*.RMI;*.MPG;*.WMV;*.ASF'+
                '|All Files (*.*)|*.*';
  if osd.Execute then
  begin
    EBAdzanFile.Text := osd.Filename;
    Preg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
    if PREg <> 0 then
    case CBAdzan.CurIndex of
      0 : RegKeySetStr(PReg,'AdzanShubuh',osd.Filename);
      1 : RegKeySetStr(PReg,'AdzanDhuhur',osd.Filename);
      2 : RegKeySetStr(PReg,'AdzanAsar',osd.Filename);
      3 : RegKeySetStr(PReg,'AdzanMaghrib',osd.Filename);
      4 : RegKeySetStr(PReg,'AdzanIsya',osd.Filename);
    end;
  end;
  osd.Free;
end;

procedure TFSetting.BtnPlayClick(Sender: PObj);
begin
  if FileExists(EBAdzanFile.Text) then
  begin
    if Assigned(P) then
    begin
      if P.State in [mpPaused] then
         P.Pause := False;
    end  

    else
      begin
        Timer1.Enabled := true;
        P := NewMediaPlayer(EBAdzanFile.Text,Form.Handle);

        ProgressBar1.MaxProgress := P.Length;
        P.Play(0,-1);
      end;
  end;
end;

procedure TFSetting.BtnPauseClick(Sender: PObj);
begin
  if P = nil then Exit;
  P.Pause := True;
end;

procedure TFSetting.BtnStopClick(Sender: PObj);
begin
  if P = nil then Exit;
  P.Stop;
  P.Close;
  Free_And_Nil(P);
  ProgressBAr1.Progress :=0;
end;

procedure TFSetting.Timer1Timer(Sender: PObj);
begin
  ProgressBar1.Progress := P.Position;
  if ProgressBar1.Progress = P.Length then
    begin
      Timer1.Enabled := false;
      P.Stop;
      Free_And_Nil(P);
    end;
end;

procedure TFSetting.KOLFrame1Destroy(Sender: PObj);
begin
  if Preg <> 0 then
    RegKeyClose(PReg);
  if P <> nil then
    begin
      P.Stop;
      Free_And_Nil(P);
    end;
  if not AppletTerminated then
  FSetting := nil;
end;

procedure TFSetting.BtnSaveClick(Sender: PObj);
var
  W : Integer;
begin
  Preg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  if PReg <> 0 then
    begin

    RegKeySetStr(PReg,'Skin',Int2Str(CBSkin.CurIndex));
    RegKeySetStr(PReg,'Language',CBLanguage.Text);

    // v3.05
    RegKeySetDw(PReg,'BarPosition',CBPosition.CurIndex);
    if CBAlpha.Checked then w:=1 else w:=0;
    RegKeySetDw(PReg,'UseAlphaBlend',w);
    RegKeySetDw(PReg,'DialogEffect',CBDlgEffect.CurIndex);
    RegKeySetDw(PReg,'BarMotion',CBBarMotion.CurIndex);

    // v3.04
    w := Str2Int(EPct.text);
    EPct.Text := Int2Str(w) +'%';
    if (w > 100) or (w<10) then w :=100;
    EPct.Text := Int2Str(w) +'%';
    RegKeySetDW(Preg,'BarWidth',w);
    if FBar <> nil then
    begin
      FBar.Form.Hide;
      FBar.Form.Width := Round(ScreenWidth * w div 100 );
      FBar.Form.Left := (ScreenWidth - FBar.form.Width) div 2;
      Fbar.ReadRegistry;
      FBar.form.Show;
    end;

    TIMEFORMAT := TIME_FMT_3;
    if RB_hm.Checked then
      begin
        RegKeySetDw(PReg,'TimeFormat',0);
        TIMEFORMAT := TIME_FMT_2;
      end
    else RegKeySetDw(PReg,'TimeFormat',1);
    if CBOnTop.Checked then
      RegKeySetDw(PReg,'AlwaysOnTop',1)
    else
      RegKeySetDw(PReg,'AlwaysOnTop',0);
    Form1.Form.StayOnTop := CBOnTop.Checked;
    if FDropZone <> nil then FDropZone.Form.StayOnTop := True;
    if FBar <> nil then FBar.Form.StayOnTop := True;
    // v3.06
    if RB_hm.Checked and (cbPembulatan.Count > 0 ) then
    begin
      Pembulatan := cbPembulatan.CurIndex;
      RegKeySetDw(PReg,'Pembulatan',Pembulatan);
    end;
    Form1.DropZone := cbDropZone.Checked;
    if cbDropZone.Checked then
      RegKeySetDw(PReg,'ShowDropZone',1)
    else
      RegKeySetDw(PReg,'ShowDropZone',0);

    // 3.07
    RegKeySetDw(PReg,'BarAlpha',Str2Int(EdAlpha.Text));
//    if FBar <> nil then
//      begin
//      //  new 3.08
//      //  FBar.Form.AlphaBlend := Str2Int(EdAlpha.Text);
//        FBar.Form.Show;
//      end
//    else
//      NewFBar(FBar,Applet);

    // --------------

    Form1.UpdateData;

    PReg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_RUN);
    if CBAutoStart.Checked then
      RegKeySetStr(PReg,'Shollu3','"'+ParamStr(0)+'"')
    else
      RegKeyDeleteValue(PReg,'Shollu3');
    PReg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
    Form1.animeSaved;
  end;
end;

procedure TFSetting.KOLFrame1Show(Sender: PObj);
begin
  UpdateOnShow;
end;

procedure TFSetting.CBLanguageChange(Sender: PObj);
begin
  if Lang <> nil then
  begin
    Form1.LoadLanguage(CBlanguage.Text);
    Form1.UpdateLanguage;
    UpdateLanguage;
 end;
end;

procedure TFSetting.UpdateLanguage;
var
  idx : Integer;
begin
  L1.Caption := Lang.Items[61];
  L2.Caption := Lang.Items[62];
  GB1.Caption := Lang.Items[63];
  BtnPlay.Caption := Lang.Items[64];
  BtnPause.Caption := Lang.Items[65];
  BtnStop.Caption := Lang.Items[66];
 // GB2.Caption := Lang.Items[67];
  GB2.Caption := '';
  LFormatJam.Caption := Lang.Items[67];
  CBAutoStart.Caption := Lang.Items[68];
  CBOnTop.Caption := Lang.Items[224];
  BtnSave.Caption := Lang.Items[69];
  LabelBar.Caption := Lang.Items[195];

  // 3.07
  BtnOpenLang2.Caption := Lang.Items[125];
//  BtnSaveSetting.Caption := Lang.Items[69];// + ' ' +Lang.Items[50];

  // v3.05
//  GBDialog.Caption := lang.Items[207];
  LEffect.Caption := {Lang.Items[208] + } lang.Items[207] ;

  idx := CBPosition.CurIndex;
  CBPosition.Clear;
  CBPosition.Add(lang.Items[209]);
  CBPosition.Add(lang.Items[210]);
  CBPosition.Add(lang.Items[211]);
  CBPosition.CurIndex := idx;

  idx := CBBarmotion.CurIndex;
  CBBarMotion.Clear;
  CBBarMotion.Add(Lang.Items[212]);
  CBBarMotion.Add(Lang.Items[213]);
  CBBarMotion.Add(Lang.Items[214]);
  CBBarMotion.Add(Lang.Items[215]);
  CBBarMotion.Add(Lang.Items[216]);
  CBBarMotion.CurIndex := idx;

  idx := CBAdzan.CurIndex;
  CBAdzan.Clear;
  CBAdzan.Add(Lang.items[1]);
  CBAdzan.Add(Lang.items[3]);
  CBAdzan.Add(Lang.items[4]);
  CBAdzan.Add(Lang.items[5]);
  CBAdzan.Add(Lang.items[6]);
  CBAdzan.CurIndex := idx;

  CBDlgEffect.Clear;
  CBDlgEffect.Add('Random');
  CBDlgEffect.Add('Normal');
  for idx:=1 to MAX_EFFECT do
    CBDlgEffect.Add(Lang.Items[208]+' '+Int2str(idx));

  cbPembulatan.Clear;
  for idx:=1 to 3 do
  begin
    cbPembulatan.Add(Lang.Items[220+idx]);
  end;  
end;

procedure TFSetting.CBDlgEffectChange(Sender: PObj);
begin
  Form1.EffectNow := True;
  if CBDlgEffect.CurIndex = 0 then
  begin
    randomize;
    Form1.DialogEffect := Random(CBDlgEffect.Count-1)+1;
  end
  else
    Form1.DialogEffect := CBDlgEffect.CurIndex;

  Form1.ShowMessage(False,'Sample / Contoh / Tulodho'+#13#10+
                          'Shollu '+versi,itInfo);
end;

procedure TFSetting.CBAdzanChange(Sender: PObj);
begin
  if Preg <> 0 then
  case CBAdzan.CurIndex of
    0 : EBAdzanFile.Text := RegKeyGetStr(PReg,'AdzanShubuh');
    1 : EBAdzanFile.Text := RegKeyGetStr(PReg,'AdzanDhuhur');
    2 : EBAdzanFile.Text := RegKeyGetStr(PReg,'AdzanAsar');
    3 : EBAdzanFile.Text := RegKeyGetStr(PReg,'AdzanMaghrib');
    4 : EBAdzanFile.Text := RegKeyGetStr(PReg,'AdzanIsya');
  end;
end;

procedure TFSetting.BtnSaveMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  TKOLBitBtn(Sender).Font.FontStyle := [fsBold]
end;

procedure TFSetting.BtnSaveMouseLeave(Sender: PObj);
begin
  TKOLBitBtn(Sender).Font.FontStyle := []
end;

procedure TFSetting.RB_hmClick(Sender: PObj);
begin
  cbPembulatan.Enabled := RB_hm.Checked;
end;

procedure TFSetting.cbDropZoneClick(Sender: PObj);
begin
  if cbDropZone.Checked then
    Form1.ShowFormDropZone
  else
    if FDropZone <> nil then
       FDropZone.Form.Hide;
end;

procedure TFSetting.BtnSaveSettingClick(Sender: PObj);
var
  OD : POpenSaveDialog;
begin
  OD := NewOpenSaveDialog('Export Setting',SholluDir,
        [OSOverwritePrompt]);
  OD.WndOwner := Form.Handle;
  OD.OpenDialog := False;
  OD.Filter := 'Shollu Setting (*.sav ) | *.SAV';
  if OD.Execute then
    Form1.SaveSetting(OD.Filename);
  OD.Free;
end;

procedure TFSetting.BtnLoadSettingClick(Sender: PObj);
var
  OD : POpenSaveDialog;
begin
  OD := NewOpenSaveDialog('Open Setting',SholluDir,
        [OSFileMustExist]);
  OD.WndOwner := Form.Handle;
  OD.OpenDialog := True;
  OD.Filter := 'Shollu Setting (*.sav ) | *.SAV';
  if OD.Execute then
    Form1.LoadSetting(OD.Filename);
  OD.Free;
end;

procedure TFSetting.UpdateOnShow;
var
  i : integer;
begin
  UpdateSkin;
  UpdateLanguage;
  PReg := RegKeyOpenRead(HKEY_LOCAL_MACHINE,REG_RUN);
  CBAutoStart.Checked := (RegKeyValExists(Preg,'Shollu3') = True) and
                         (LowerCase(RegKeyGetStr(Preg,'Shollu3')) = '"'+LowerCase(ParamStr(0))+'"');
  PReg := RegKeyOpenRead(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  CBAlpha.Checked := RegKeyGetDw(Preg,'UseAlphaBlend') =1;
  CBDlgEffect.CurIndex := RegKeyGetDw(Preg,'DialogEffect');
  CBOnTop.Checked := RegKeyGetDw(Preg,'AlwaysOnTop') =1;
  CBLanguage.CurIndex := CBLanguage.IndexOf(RegKeyGetStr(PReg,'Language'));
  
  i := RegKeyGetDw(Preg,'BarMotion');
  if (i > 4) or (i < 0) then i:=2;
  CBBarMotion.CurIndex := i;

  EBAdzanFile.Text := RegKeyGetStr(PReg,'AdzanShubuh');
  // v3.06
  if Pembulatan < cbPembulatan.Count then
     cbPembulatan.CurIndex  := Pembulatan;

  if FDropZone <> nil then
    cbDropZone.Checked := FDropZone.Form.Visible;

  // 3.07
  EdAlpha.Text := Int2Str(RegKeyGetDw(Preg,'BarAlpha'));
end;

procedure TFSetting.btnOpenLang2Click(Sender: PObj);
begin
  if FileExists( SholluDir+'languages\'+ CBLanguage.Text+'.slp') then
    begin
      Shellexecute(Applet.Handle,'Open','notepad.exe',
         PChar(CBLanguage.Text+'.slp'),
         PChar(SholluDir+'languages\'),SW_SHOW);
    end;
end;

end.









