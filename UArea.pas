{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit UArea;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls, mckControls, mckObjs, Graphics,  mckCtrls {$IFEND (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFAreaclass.inc} {$ELSE OBJECTS} PFArea = ^TFArea; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFArea.inc}{$ELSE} TFArea = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFArea = class(TForm)
  {$IFEND KOL_MCK}
    KOLFrame1: TKOLFrame;
    GB1: TKOLGroupBox;
    RB1: TKOLRadioBox;
    RB4: TKOLRadioBox;
    RB6: TKOLRadioBox;
    RB2: TKOLRadioBox;
    RB3: TKOLRadioBox;
    RB5: TKOLRadioBox;
    cbGd: TKOLComboBox;
    cbGn: TKOLComboBox;
    LArea5: TKOLLabel;
    LArea3: TKOLLabel;
    LArea4: TKOLLabel;
    LArea6: TKOLLabel;
    EBLat: TKOLEditBox;
    EBlong: TKOLEditBox;
    EBAlt: TKOLEditBox;
    CBTZ: TKOLComboBox;
    LArea2: TKOLLabel;
    LAddDhuhur: TKOLLabel;
    LAddMaghrib: TKOLLabel;
    CBSyafii: TKOLComboBox;
    cbAddDhuhur: TKOLComboBox;
    cbAddMaghrib: TKOLComboBox;
    LArea1: TKOLLabel;
    EBArea: TKOLEditBox;
    BtnSaveArea: TKOLBitBtn;
    Label1: TKOLLabel;
    Label2: TKOLLabel;
    LAddIsya: TKOLLabel;
    LAddAsar: TKOLLabel;
    LAddShubuh: TKOLLabel;
    cbAddShubuh: TKOLComboBox;
    cbAddAsar: TKOLComboBox;
    cbAddIsya: TKOLComboBox;
    BtnSelectCity: TKOLButton;
    procedure KOLFrame1FormCreate(Sender: PObj);
    procedure KOLFrame1Show(Sender: PObj);
    procedure BtnSaveAreaClick(Sender: PObj);
    procedure RB1Click(Sender: PObj);
    procedure RB2Click(Sender: PObj);
    procedure RB3Click(Sender: PObj);
    procedure RB4Click(Sender: PObj);
    procedure RB5Click(Sender: PObj);
    procedure RB6Click(Sender: PObj);
    procedure KOLFrame1Destroy(Sender: PObj);
    procedure BtnSaveAreaMouseLeave(Sender: PObj);
    procedure BtnSaveAreaMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure BtnSelectCityClick(Sender: PObj);
  private
    { Private declarations }
    function TestInputData: Boolean;
    procedure UpdateData;
    Procedure UpdateLanguage;
    procedure UpdateSkin;
  public
    { Public declarations }
  end;

var
  FArea {$IFDEF KOL_MCK} : PFArea {$ELSE} : TFArea {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFArea( var Result: PFArea; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, Shollu, UCities;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UArea_1.inc}
{$ENDIF}

procedure TFArea.KOLFrame1FormCreate(Sender: PObj);
begin
  UpdateData;
end;

procedure UnchekAll;
begin
  with FArea^ do
  begin
    RB1.Checked := False;
    RB2.Checked := False;
    RB3.Checked := False;
    RB4.Checked := False;
    RB5.Checked := False;
    RB6.Checked := False;
  end;
end;

procedure TFArea.UpdateData;
begin
  with Form1^ do
  begin
    EBArea.Text := Area;
    EBLat.Text := Latitude;
    EBlong.Text := Longitude;
    EBAlt.Text := Int2Str(Altitude);
    if Syafii = True then CBSyafii.CurIndex := 0
    else CBSyafii.CurIndex :=1;
    CBTZ.Text := Double2Str(TZ);
    cbAddDhuhur.Text := Int2Str(Add_Dhuhur);
    cbAddMaghrib.Text := Int2Str(Add_Maghrib);
    // v3.06
    cbAddShubuh.Text := Int2Str(Add_Shubuh);
    cbAddAsar.Text := Int2Str(Add_Asar);
    cbAddIsya.Text := Int2Str(Add_Isya);

    UnchekAll;
    case Methods of
     1 : RB1.Checked := True;
     2 : RB2.Checked := True;
     3 : RB3.Checked := True;
     4 : RB4.Checked := True;
     5 : RB5.Checked := True;
    else RB6.Checked := True;
    end;
    cbGn.Text := Double2Str(Gn);
    cbGd.Text := Double2Str(Gd);
    cbGn.Enabled := Methods > 5;
    cbGd.Enabled := Methods > 5;
  end;
end;

procedure TFArea.UpdateSkin;
begin
  Form.Color := cForm;

  form.Color := cForm;
  Gb1.Color := cForm;

  EBArea.Color := cForm;
  EBLat.Color := cForm;
  EBlong.Color := cForm;
  EBAlt.Color := cForm;

  RB1.Color := cForm;
  RB2.Color := cForm;
  RB3.Color := cForm;
  RB4.Color := cForm;
  RB5.Color := cForm;
  RB6.Color := cForm;

  cbAddDhuhur.Color := cForm;
  CBTZ.Color := cForm;
  CBSyafii.Color := cForm;
  cbAddMaghrib.Color := cForm;
  //3.06
  cbAddShubuh.Color := cForm;
  cbAddAsar.Color := cForm;
  cbAddIsya.Color := cForm;
end;

procedure TFArea.KOLFrame1Show(Sender: PObj);
begin
  UpdateData;
  UpdateLanguage;
  UpdateSkin;
  GB1.TextAlign := taCenter;
  GB1.Caption := Lang.items[202];
end;

procedure TFArea.BtnSaveAreaClick(Sender: PObj);
var
  method : Byte;
  Preg : HKEY;
begin
  if testInputData then
  begin
    if rb1.Checked then method :=1
      else if rb2.Checked then method := 2
      else if rb3.Checked then method := 3
      else if rb4.Checked then method := 4
      else if rb5.Checked then method := 5
      else method := 6;                        

    Add_Shubuh := Str2Int(cbAddShubuh.Text);
    Add_Dhuhur := Str2Int(cbAddDhuhur.Text);
    Add_Asar := Str2Int(cbAddAsar.Text);
    Add_Maghrib := Str2Int(cbAddMaghrib.Text);
    Add_Isya := Str2Int(cbAddIsya.Text);

    Preg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
    if PReg = 0 then
      Preg := RegKeyOpenCreate(HKEY_LOCAL_MACHINE,REG_SHOLLU3);

    if PReg <> 0 then
    begin
      RegKeySetStr(Preg,'Area',EBArea.Text);
      RegKeySetStr(Preg,'latitude',ebLat.Text);
      RegKeySetStr(Preg,'Longitude',ebLong.Text);
      RegKeySetStr(Preg,'Altitude',ebAlt.Text);
      RegKeySetStr(Preg,'Gn',cbGn.Text);
      RegKeySetStr(Preg,'Gd',cbGd.Text);
      RegKeySetStr(Preg,'TZ',cbTZ.Text);
      RegKeySetStr(Preg,'Add_Dhuhur',Int2Str(Add_Dhuhur) );
      RegKeySetStr(Preg,'Add_Maghrib',Int2Str(Add_Maghrib));
      // 3.06
      RegKeySetStr(Preg,'Add_Shubuh',Int2Str(Add_Shubuh));
      RegKeySetStr(Preg,'Add_Asar',Int2Str(Add_Asar));
      RegKeySetStr(Preg,'Add_Isya',Int2Str(Add_Isya));

      RegKeySetDw(Preg,'Methods',method);
      RegKeySetDw(Preg,'Syafii',CBSyafii.CurIndex);
    end;
    RegCloseKey(Preg);

    // versi 3.05 kebawah Gn dan Gd terbalik
    tNow := GetPrayerTime(Date,Str2Int(ebAlt.Text),Str2Double(cbTZ.Text),
                    Str2Double(cbGd.Text),Str2Double(cbGn.Text),
                    Str2Double(ebLat.Text),Str2Double(ebLong.Text),CBSyafii.CurIndex=0);

{    tNow.tDhuhur := tNow.tDhuhur + Str2Int(cbAddDhuhur.Text)*SatuMenit;
    tNow.tMaghrib := tNow.tMaghrib + Str2Int(cbAddMaghrib.Text)*SatuMenit;
    // v3.06
    tNow.tShubuh := tNow.tShubuh + Str2Int(cbAddShubuh.Text)*SatuMenit;
    tNow.tAsar := tNow.tAsar + Str2Int(cbAddAsar.Text)*SatuMenit;
    tNow.tIsya := tNow.tIsya + Str2Int(cbAddIsya.Text)*SatuMenit;  }

    Form1.tS := tNow;
    Form1.ReadRegistry;
    Form1.UpdateData;
    Form1.LTitleInfo.Caption :=  Lang.Items[70];
    Form1.animeSaved;
  end;
end;

procedure SetGdGn(Enabled : Boolean; Gd,Gn : string);
begin
  with FArea^ do
  begin
    cbGn.Text := Gn;
    cbGd.Text := Gd;
    cbGn.Enabled := Enabled;
    cbGd.Enabled := Enabled;
  end;
end;

procedure TFArea.RB1Click(Sender: PObj);
begin
  if rb1.Checked then SetGdGn(False,'18','18');
end;

procedure TFArea.RB2Click(Sender: PObj);
begin
  if rb2.Checked then SetGdGn(False,'15','15');
end;

procedure TFArea.RB3Click(Sender: PObj);
begin
  if rb3.Checked then SetGdGn(False,'18','17');
end;

procedure TFArea.RB4Click(Sender: PObj);
begin
  if rb4.Checked then SetGdGn(False,'19','18');
end;

procedure TFArea.RB5Click(Sender: PObj);
begin
  if rb5.Checked then SetGdGn(False,'19.5','17.5');
end;

procedure TFArea.RB6Click(Sender: PObj);
begin
  if rb6.Checked then SetGdGn(True,'18','18.5');
end;

function TFArea.TestInputData : Boolean;
begin
  Result := True;
  { Lat and Long }
  if (not (ebLat.Text = '0') and (Str2Double(ebLat.Text) = 0)) OR
     (not (ebLong.Text = '0') and (Str2Double(ebLong.Text) = 0)) then
      begin
        Form1.ShowMessage(False,Lang.Items[159],itError);
        Result := False;
        Exit;
      end;

  { TZ and Altitude }
  if (not (cbTZ.Text = '0') and (Str2Double(cbTZ.Text) = 0)) or
     (not (ebAlt.Text = '0') and (Str2Int(ebAlt.Text) = 0)) then
      begin
        Form1.ShowMessage(False,Lang.Items[160],itError);
        Result := False;
        Exit;
      end;

  { ComboBoxDhuhur & CbMaghrib }
  if (not (cbAddDhuhur.Text = '0') and (Str2Int(cbAddDhuhur.Text)=0)) or
     (not (cbAddMaghrib.Text = '0') and (Str2Int(cbAddMaghrib.Text)=0))or
     // v3.06
     (not (cbAddShubuh.Text = '0') and (Str2Int(cbAddShubuh.Text)=0))or
     (not (cbAddAsar.Text = '0') and (Str2Int(cbAddAsar.Text)=0))or
     (not (cbAddIsya.Text = '0') and (Str2Int(cbAddIsya.Text)=0)) then
      begin
        Form1.ShowMessage(False,Lang.Items[161],itError);
        Result := False;
        Exit;
      end;

  { Gd and Gn }
  if (not (cbGn.Text = '0') and (Str2Double(cbGn.Text) = 0)) or
     (not (cbGd.Text = '0') and (Str2Double(cbGd.Text) = 0)) then
      begin
        Form1.ShowMessage(False,Lang.Items[162],itError);
        Result := False;
        Exit;
      end;
end;

procedure TFArea.UpdateLanguage;
begin
  LArea2.Caption := Lang.Items[38];  // Latitude
  LArea3.Caption := Lang.Items[39];  // Longitude
  LArea4.Caption := Lang.Items[40];  // Altitude
  LArea6.Caption := Lang.Items[41];  // TZ

  LArea1.Caption := Lang.Items[59];
  BtnSelectCity.Caption := Lang.Items[72];
  LArea5.Caption := Lang.Items[73];
  LAddDhuhur.Caption := Lang.Items[74];
  LAddMaghrib.Caption := Lang.Items[75];
  // v3.06
  LAddShubuh.Caption := Lang.Items[218];
  LAddAsar.Caption := Lang.Items[219];
  LAddIsya.Caption := Lang.Items[220];

  RB1.Caption := Lang.Items[76];
  RB2.Caption := Lang.Items[77];
  RB3.Caption := Lang.Items[78];
  RB4.Caption := Lang.Items[79];
  RB5.Caption := Lang.Items[80];
  RB6.Caption := Lang.Items[81];

  BtnSaveArea.Caption := Lang.Items[69];
end;

procedure TFArea.KOLFrame1Destroy(Sender: PObj);
begin
  if not AppletTerminated then
  FArea := nil;
end;

procedure TFArea.BtnSaveAreaMouseLeave(Sender: PObj);
begin
  TKOLBitBtn(Sender).Font.FontStyle := []
end;

procedure TFArea.BtnSaveAreaMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  TKOLBitBtn(Sender).Font.FontStyle := [fsBold]
end;

procedure TFArea.BtnSelectCityClick(Sender: PObj);
begin
  if FCities =  nil then
  begin
    NewFCities(FCities,Applet);
    FCities.Form.ShowModal;
    FCities.Form.Free;
  end;
end;

end.









