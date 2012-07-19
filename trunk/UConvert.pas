{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit UConvert;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls,
  mckControls, mckObjs, Graphics,  mckCtrls {$IFEND (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFConvertclass.inc} {$ELSE OBJECTS} PFConvert = ^TFConvert; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFConvert.inc}{$ELSE} TFConvert = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFConvert = class(TForm)
  {$IFEND KOL_MCK}
    KOLForm1: TKOLForm;
    TopPanel: TKOLPanel;
    ImgIcon: TKOLImageShow;
    GPMain: TKOLGradientPanel;
    CBdateM: TKOLComboBox;
    CBMonthM: TKOLComboBox;
    CBYearM: TKOLComboBox;
    CBDateH: TKOLComboBox;
    CBMonthH: TKOLComboBox;
    CBYearH: TKOLComboBox;
    BtnClose: TKOLButton;
    BtnToday: TKOLButton;
    EBDay: TKOLEditBox;
    LTitle: TKOLLabel;
    cbDiff: TKOLComboBox;
    LDiff: TKOLLabel;
    Button1: TKOLButton;
    procedure TopPanelPaint(Sender: PControl; DC: HDC);
    procedure KOLForm1Paint(Sender: PControl; DC: HDC);
    procedure TopPanelMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure ImgIconMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure ImgIconMouseLeave(Sender: PObj);
    procedure ImgIconMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure ImgIconMouseUp(Sender: PControl; var Mouse: TMouseEventData);
    procedure KOLForm1Show(Sender: PObj);
    procedure BtnCloseClick(Sender: PObj);
    procedure CBdateMChange(Sender: PObj);
    procedure BtnTodayClick(Sender: PObj);
    procedure CBDateHChange(Sender: PObj);
    procedure CBMonthMChange(Sender: PObj);
    procedure KOLForm1Destroy(Sender: PObj);
    procedure cbDiffChange(Sender: PObj);
  private
    { Private declarations }
    MouseDown : Boolean;
    y,m,d : Word;
    dt : TDateTime;
    PReg : HKEY;
    procedure SetToday;
  public
    { Public declarations }
  end;

var
  FConvert {$IFDEF KOL_MCK} : PFConvert {$ELSE} : TFConvert {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFConvert( var Result: PFConvert; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, Shollu;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UConvert_1.inc}
{$ENDIF}
var
  Tgl : TDate;

procedure TFConvert.TopPanelPaint(Sender: PControl; DC: HDC);
begin
  Form1.PaintTop(TopPanel);
end;

procedure TFConvert.KOLForm1Paint(Sender: PControl; DC: HDC);
begin
  Form1.PaintForm(Form);
end;

procedure TFConvert.TopPanelMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  ReleaseCapture;
  SendMessage(Form.Handle,WM_SYSCOMMAND,$F012,0);
end;

procedure TFConvert.KOLForm1FormCreate(Sender: PObj);
var
  R1 : HRGN;
  i : Integer;
begin
  R1 := CreateRoundRectRgn(0,0,Form.Width+1,form.Height+14,13,13);
  try
    SetWindowRgn(form.Handle,R1,True);
  finally
    DeleteObject(R1);
  end;

  LTitle.Font.Color := Form1.LTitle.Font.Color;
  LTitle.Caption := 'Hijriyah <-> Masehi';

  GPMain.HasBorder := False;
  GPMain.Left := 3;
  GPMain.Top  := Toppanel.Top + TopPanel.Height;
  GPMain.Height := Form.Height - TopPanel.Height - 3;
  GPMain.Width  := Form.Width - 6;
  GPMain.Color1 := cForm;
  if IndexColor > 20 then
    GPMain.Color2 := cForm
  else
    GPMain.Color2 := cGPMain1Col1;

  for i:=1 to 31 do CBdateM.Add(Int2Str(i));
  for i:=1 to 30 do CBdateH.Add(Int2Str(i));
  for i:=1 to 12 do
  begin
    CBMonthM.Add(NmBulanM[i]);
    CBMonthH.Add(NmBulanH[i]);
  end;

  for i:=1 to 20 do
  begin
    CBYearM.Add(Int2Str(2000+i));
    CBYearH.Add(Int2Str(1430+i));
  end;
  SetToday;
  BtnToday.Caption := Lang.Items[57];
  BtnClose.Caption := Lang.Items[84];
  Preg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
end;

procedure TFConvert.ImgIconMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  MouseDown := True;
  ImgIcon.CurIndex := 8;
end;

procedure TFConvert.ImgIconMouseLeave(Sender: PObj);
begin
  ImgIcon.CurIndex := 7;
end;

procedure TFConvert.ImgIconMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  if MouseDown then
  imgIcon.CurIndex := 8;
end;

procedure TFConvert.ImgIconMouseUp(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  Form.Close;
end;

procedure TFConvert.KOLForm1Show(Sender: PObj);
begin
  MouseDown := False;
  Form.Color := cForm;
  cbDiff.CurIndex := cbDiff.IndexOf(RegKeyGetStr(PReg,'HijriyahDiff'));
  LDiff.Caption  := Lang.Items[225];
end;

procedure TFConvert.BtnCloseClick(Sender: PObj);
begin
  Form.Close;
end;

procedure SetDate(xDate : TdateTime);
var
  i : Integer;
begin
  i := DayofWeek(xDate);
  if i <> 7 then i:=i+7;
  FConvert.EBDay.Text := Lang.Items[i];
end;

procedure TFConvert.SetToday;
var
  i : Integer;
begin
  DecodeDate(Date,y,m,d);
  CBdateM.Clear;
  for i:=1 to MonthDays[IsLeapYear(y),m] do
  begin
    CBdateM.Add(Int2Str(i));
  end;

  CBdateM.CurIndex := d-1;
  CBMonthM.CurIndex := m-1;
  CBYearM.Text := Int2Str(y);

  Tgl := ConvertDate(False,y,m,d);
  CBDateH.CurIndex := Tgl.Day -1;
  CBMonthH.CurIndex := Tgl.Month -1;
  CBYearH.Text := Int2Str(Tgl.Year);
  SetDate(date);
end;

procedure TFConvert.CBdateMChange(Sender: PObj);
begin
  if Str2Int(CBYearM.Text) > 9999 then exit;
  EncodeDate(Str2Int(CByearM.Text),CBMonthM.CurIndex+1,CBdateM.CurIndex+1,dt);
  { Minimal Date 18 Juni 592 M }
  if dt < Str2DateTimeFmt('dd.MM.yyyy','18.06.592') then
    Exit;
  SetDate(dt);
  Tgl := ConvertDate(False,Str2Int(CByearM.Text),CBMonthM.CurIndex+1,CBdateM.CurIndex+1);

  CBDateH.CurIndex := Tgl.Day -1;
  CBMonthH.CurIndex := Tgl.Month-1;
  CBYearH.Text := Int2Str(Tgl.Year);
end;

procedure TFConvert.BtnTodayClick(Sender: PObj);
begin
  SetToday;
end;

procedure TFConvert.CBDateHChange(Sender: PObj);
begin
  { minimal date 1 Muharram -30 H }
  if Str2Int(CBYearH.Text) < 0 then Exit;  
  EncodeDate(Str2Int(CBYearH.Text),CBMonthH.CurIndex+1,CBdateH.CurIndex+1,dt);
  Tgl := ConvertDate(True,Str2Int(CBYearH.Text),CBMonthH.CurIndex+1,CBdateH.CurIndex+1);
  CBDateM.CurIndex := Tgl.Day-1;
  CBMonthM.CurIndex := Tgl.Month-1;
  CBYearM.Text := Int2Str(Tgl.Year);

  EncodeDate(Tgl.Year,Tgl.Month,Tgl.Day,dt);
  setdate(dt);
end;

procedure TFConvert.CBMonthMChange(Sender: PObj);
var
  old,i : Integer;
begin
  if Str2Int(CBYearH.Text) = 0 then Exit;
  old := Str2Int(CBDateM.Text);
  CBdateM.Clear;
  for i:=1 to MonthDays[IsLeapYear(Str2Int(CByearM.Text)),CBMonthM.CurIndex+1] do
    CBdateM.Add(Int2Str(i));
  CBdateM.CurIndex := old -1;
  CBdateMChange(sender);
end;

procedure TFConvert.KOLForm1Destroy(Sender: PObj);
begin
  FConvert := nil;
end;

procedure TFConvert.cbDiffChange(Sender: PObj);
begin
  HijriyahDiff := Str2Int(cbDiff.Text);
  if PReg <> 0 then
    RegKeySetStr(PReg,'HijriyahDiff',Int2Str(HijriyahDiff));
  Form1.UpdateData;
  CBdateMChange(Sender);
end;

end.




