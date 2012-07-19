{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit UTask;

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
  {$IFDEF KOLCLASSES} {$I TFTaskclass.inc} {$ELSE OBJECTS} PFTask = ^TFTask; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFTask.inc}{$ELSE} TFTask = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFTask = class(TForm)
  {$IFEND KOL_MCK}
    KOLForm1: TKOLForm;
    TopPanel: TKOLPanel;
    LV: TKOLListView;
    ImgIcon: TKOLImageShow;
    ENama: TKOLEditBox;
    CBType: TKOLComboBox;
    CBFreq: TKOLComboBox;
    DTime: TKOLDateTimePicker;
    Label1: TKOLLabel;
    Label2: TKOLLabel;
    Label3: TKOLLabel;
    Label4: TKOLLabel;
    BtnSave: TKOLButton;
    BtnAdd: TKOLButton;
    BtnCancel: TKOLButton;
    BtnDel: TKOLButton;
    LTitle2: TKOLLabel;
    GPMain: TKOLGradientPanel;
    Label5: TKOLLabel;
    CBDayOfWeek: TKOLComboBox;
    Label6: TKOLLabel;
    CBMonth: TKOLComboBox;
    LMessage: TKOLLabel;
    EMessage: TKOLEditBox;
    CBDate: TKOLComboBox;
    BtnBrowse: TKOLButton;
    BtnClose: TKOLButton;
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure TopPanelPaint(Sender: PControl; DC: HDC);
    procedure TopPanelMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure KOLForm1Paint(Sender: PControl; DC: HDC);
    procedure LVColumnClick(Sender: PControl; Idx: Integer);
    procedure ImgIconMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure ImgIconMouseLeave(Sender: PObj);
    procedure ImgIconMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure ImgIconMouseUp(Sender: PControl; var Mouse: TMouseEventData);
    procedure KOLForm1Show(Sender: PObj);
    procedure CBMonthChange(Sender: PObj);
    procedure LVEnter(Sender: PObj);
    procedure LVKeyUp(Sender: PControl; var Key: Integer; Shift: Cardinal);
    procedure BtnSaveClick(Sender: PObj);
    procedure BtnAddClick(Sender: PObj);
    procedure ENamaChange(Sender: PObj);
    procedure BtnCancelClick(Sender: PObj);
    procedure CBTypeChange(Sender: PObj);
    procedure CBFreqChange(Sender: PObj);
    procedure DTimeChange(Sender: PObj);
    procedure CBDayOfWeekChange(Sender: PObj);
    procedure CBDateChange(Sender: PObj);
    procedure EMessageChange(Sender: PObj);
    procedure BtnCloseClick(Sender: PObj);
    procedure BtnDelClick(Sender: PObj);
    procedure BtnBrowseClick(Sender: PObj);
    procedure ENamaKeyUp(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure CBTypeKeyUp(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure CBFreqKeyUp(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure CBDayOfWeekKeyUp(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure CBMonthKeyUp(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure CBDateKeyUp(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure KOLForm1Destroy(Sender: PObj);
    procedure ENamaKeyDown(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
  private
    MouseDown : Boolean;
    CurRec : Integer;
    procedure LoadTask;
    procedure SaveLV;
    procedure UpdateLanguage;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  CR =#13#10;
  Info =
  '; Task Scheduler Format For Shollu v3.05'+CR+
  '; Format : Nama|Type|Freq|Time|DayOgWeek|Date|Month|Message'+CR+
  '; Type : 1=info 2=Error 3=Warning 4=Question 5=Command 6=Shutdown 7=Hibernate 8=MovingText 9=Multimedia'+CR+
  '; Freq : 1=Daily 2=Weekly 3=Monthly 4=OnlyOnce 5=onStartProgram'+CR+
  '; Time : HH:mm:ss ( Hour:Minutes:Second )'+CR+
  '; DayOfWeek : 1=Ahad(Sunday) 2=Senin(MOnday) ...etc';
  
var
  FTask {$IFDEF KOL_MCK} : PFTask {$ELSE} : TFTask {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFTask( var Result: PFTask; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, Shollu;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UTask_1.inc}
{$ENDIF}

procedure TFTask.LoadTask;
var
   i,n: Integer;
   T1 : TTask;
   SL : PStrList;
begin
   with Form1^ do
   begin
      LV.Clear;

    if not FileExists(AppDataDir+TASK_FILE) then Exit;
    SL := NewStrList;
    SL.LoadFromFile(AppDataDir+TASK_FILE);
    if SL.Count < 1 then Exit;

    for i:=0 to SL.Count-1 do
    begin
      if Pos(';',SL.Items[i]) > 0 then Continue;
      if Trim(SL.items[i]) = '' then Continue;
      T1 := ParseText(SL.Items[i]);
      n := LV.LVItemAdd(T1.Nama);
      case T1.Tipe of
        ttNone      : LV.LVItems[n,1] := CBType.Items[0];
        ttinfo      : LV.LVItems[n,1] := CBType.Items[1];
        ttError     : LV.LVItems[n,1] := CBType.Items[2];
        ttWarn      : LV.LVItems[n,1] := CBType.Items[3];
        ttQuestion  : LV.LVItems[n,1] := CBType.Items[4];
        ttCommand   : LV.LVItems[n,1] := CBType.Items[5];
        ttShutdown  : LV.LVItems[n,1] := CBType.Items[6];
        ttHibernate : LV.LVItems[n,1] := CBType.Items[7];
        ttMovingText: LV.LVItems[n,1] := CBType.Items[8];
        ttMultimedia: LV.LVItems[n,1] := CBType.Items[9];
      end;
      case T1.Freq of
        tfNone      : LV.LVItems[n,2] := CBFreq.Items[0];
        tfDaily     : LV.LVItems[n,2] := CBFreq.Items[1];
        tfWeekly    : LV.LVItems[n,2] := CBFreq.Items[2];
        tfMonthly   : LV.LVItems[n,2] := CBFreq.Items[3];
        tfOnce      : LV.LVItems[n,2] := CBFreq.Items[4];
        tfStart     : LV.LVItems[n,2] := CBFreq.Items[5];
      end;
      if T1.Freq <> tfStart then LV.LVItems[n,3] := Time2StrFmt(TIME_FMT_3,T1.Jam) ;
      if T1.Freq = tfWeekly then LV.LVItems[n,4] := Lang.Items[T1.hari+7];
      if (T1.Freq = tfMonthly) or (T1.Freq = tfOnce) then LV.LVItems[n,5] := Int2Str(T1.Tgl);
      if T1.Bulan < 13 then LV.LVItems[n,6] := NmBulanM[T1.bulan];
      LV.LVItems[n,7] := T1.Pesan;
    end;
    SL.Free;
  end;
end;

procedure TFtask.UpdateLanguage;
begin
  LTitle2.Caption := lang.Items[54];
  Label1.Caption := lang.Items[117];
  Label2.Caption := lang.Items[118];
  Label3.Caption := lang.Items[119];
  Label4.Caption := lang.Items[120];
  Label5.Caption := lang.Items[121];
  Label6.Caption := lang.Items[123] + '- '+lang.Items[122];
  LMessage.Caption := lang.Items[124];

  BtnAdd.Caption := lang.Items[126];
  BtnDel.Caption := lang.Items[127];
  BtnCancel.Caption := lang.Items[128];
  BtnSave.Caption := lang.Items[129];
  BtnClose.Caption := lang.Items[130];

  LV.LVColText[0] := lang.Items[117];
  LV.LVColText[1] := lang.Items[118];
  LV.LVColText[2] := lang.Items[119];
  LV.LVColText[3] := lang.Items[120];
  LV.LVColText[4] := lang.Items[121];
  LV.LVColText[5] := lang.Items[122];
  LV.LVColText[6] := lang.Items[123];
  LV.LVColText[7] := lang.Items[124];
end;

procedure TFTask.KOLForm1FormCreate(Sender: PObj);
var
  R1 : HRGN;
  i : Integer;
begin
  Form.Color := cForm;
  Form.StayOnTop := True;
  LTitle2.Transparent := True;
  LTitle2.Font.Color := cTitleFont;// cGPMainCol2;
//  LTitle2.Color2 := cGPMain1Col1;
  R1 := CreateRoundRectRgn(0,0,Form.Width+1,form.Height+14,13,13);
  try
    SetWindowRgn(form.Handle,R1,True);
  finally
    DeleteObject(R1);
  end;

  for i:=0 to 6 do
    CBDayOfWeek.Add(Lang.Items[i+7]);
  for i:=1 to 12 do
    CBMonth.Add(NmBulanM[i]);
  for i:=1 to 31 do CBDate.Add(Int2Str(i));

  CBType.Clear;
  for i:= 187 to 195 do CBType.Add(Lang.Items[i]);
  CBType.add(Lang.items[217]);

  CBFreq.Clear;
  for i:= 196 to 201 do CBFreq.Add(Lang.Items[i]);
  LoadTask;
  GPMain.Left := 3;
  GPMain.Width := Form.width-6;
  GPMain.Top := Form.Height - GPMain.Height - 3;
  LV.LVTextBkColor := cForm;
  LV.LVBkColor := cForm;
  if cForm = clGray then
  begin
    LV.LVTextColor := clWhite;
  end;
end;

procedure TFTask.TopPanelPaint(Sender: PControl; DC: HDC);
begin
  Form1.PaintTop(TopPanel);
end;

procedure TFTask.TopPanelMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  ReleaseCapture;
  SendMessage(Form.Handle,WM_SYSCOMMAND,$F012,0);
end;

procedure TFTask.KOLForm1Paint(Sender: PControl; DC: HDC);
begin
  Form1.PaintForm(Sender);
end;

procedure TFTask.LVColumnClick(Sender: PControl; Idx: Integer);
begin
  if LvoSortAscending in LV.LVOptions then
    LV.LVOptions := LV.LVOptions - [LvoSortAscending] + [LvoSortDescending]
  else
    LV.LVOptions := LV.LVOptions + [LvoSortAscending];    
  LV.LVSortColumn(Idx);
end;

procedure TFTask.ImgIconMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  MouseDown := True;
  ImgIcon.CurIndex := 8;
end;

procedure TFTask.ImgIconMouseLeave(Sender: PObj);
begin
  ImgIcon.CurIndex := 7;
end;

procedure TFTask.ImgIconMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  if MouseDown then
  ImgIcon.CurIndex := 8;
end;

procedure TFTask.ImgIconMouseUp(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  Form.Close;
end;

procedure TFTask.KOLForm1Show(Sender: PObj);
begin
  MouseDown := False;
  if IndexColor > 20 then
    GPmain.Color2 := cForm
  else
    GPmain.Color2 := cGPMain1Col1;

  GPmain.Color1 := cForm;
  if LV.Count > 0 then LV.LVCurItem := 0;
  UpdateLanguage;

  Randomize;
end;

procedure TFTask.CBMonthChange(Sender: PObj);
var
  y,m,d : Word;
begin
  CBDate.Clear;
  DecodeDate(Date,y,m,d);
  m := CBMonth.CurIndex+1;
  for d:=1 to MonthDays[isLeapYear(y),m] do
    CBDate.Add(Int2Str(d));
  LV.LVItems[LV.LVCurItem,6] := CBMonth.Text;
end;

procedure GetRecords;
begin
  with FTask^ do
  begin
    CurRec := LV.LVCurItem;
    ENama.Text := LV.LVItems[CurRec,0];
    CBType.CurIndex := CBType.IndexOf(LV.LVItems[CurRec,1]);
    CBFreq.CurIndex := CBFreq.IndexOf(LV.LVItems[CurRec,2]);
    DTime.Time := Str2DateTimeFmt(TIME_FMT_3,LV.LVItems[CurRec,3]);
    CBDayOfWeek.CurIndex := CBdayOfWeek.IndexOf(LV.LVItems[CurRec,4]);
    CBMonth.CurIndex := CBMonth.IndexOf(LV.LVItems[CurRec,6]);
    CBDate.CurIndex := CBDate.IndexOf(LV.LVItems[CurRec,5]);
    EMessage.Text := LV.LVItems[CurRec,7];

    BtnBrowse.Visible := CBType.CurIndex = 5;
    if CBType.CurIndex = 5 then
      LMessage.Caption := lang.Items[125]
    else
      LMessage.Caption := lang.Items[124];
    CBDayOfWeek.Enabled := CBFreq.CurIndex = 2;
    CBDate.Enabled := (CBFreq.CurIndex = 3) or (CBFreq.CurIndex = 4);
    CBMonth.Enabled := CBFreq.CurIndex = 4;
  end;
end;

procedure TFTask.LVEnter(Sender: PObj);
begin
  GetRecords;
end;

procedure TFTask.LVKeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  if (Key = VK_UP) or (key = VK_DOWN) or
    (Key=VK_PRIOR) or (KEY = VK_NEXT) then
    GetRecords;
end;

procedure TFtask.SaveLV;
var
  i  : Integer;
  SL : PStrList;
  s  : string;
begin
  SL := NewStrList;
  SL.Add(Info);
  SL.Add('');
  for i:=0 to LV.Count-1 do
  begin
    s := '';
    with LV^ do
    begin
      s := s + LVItems[i,0]+'|';
      s := s + Int2Str(CBType.IndexOf(LVItems[i,1]))+'|';
      s := s + Int2Str(CBFreq.IndexOf(LVItems[i,2]))+'|';
      s := s + LVItems[i,3]+'|';
      s := s + Int2Str(CBdayOfWeek.IndexOf(LVItems[i,4]))+'|';
      s := s + Int2Str(CBDate.IndexOf(LVItems[i,5])+1)+'|';
      s := s + Int2Str(CBMonth.IndexOf(LVItems[i,6])+1)+'|';
      s := s + LVItems[i,7];
      SL.Add(s);
    end;
  end;

  with Form1^ do
  if FileExists(AppDataDir+TASK_FILE) then
  begin
    if not DeleteFile(PChar(AppDataDir+TASK_FILE)) then
      ShowMessage(False,lang.Items[175],itError)
    else
      SL.SaveToFile(AppDataDir+TASK_FILE);
  end;
  SL.Free;
end;

procedure TFTask.BtnSaveClick(Sender: PObj);
begin
  if (Pos(';',Emessage.Text) > 0) or
     (Pos('|',Emessage.Text) > 0) then
  begin
    Form1.ShowMessage(False,lang.Items[176]+#13#10+
        lang.Items[178],itError);
    Exit;
  end;

  if (Pos(';',ENama.Text) > 0) or
     (Pos('|',ENama.Text) > 0) then
  begin
    Form1.ShowMessage(False,lang.Items[177]+#13#10+
        lang.Items[178],itError);
    Exit;
  end;

  if (CBType.CurIndex =5) or (CBType.CurIndex =9) then { Command or Multimedia }
    if not FileExists(EMEssage.Text) then
    begin
      Form1.ShowMessage(False,lang.Items[179],itError);
      Exit;
    end;

  SaveLV;
  Form1.LoadtaskToday;
end;

procedure TFTask.BtnAddClick(Sender: PObj);
var
  i : Integer;
begin
  i := LV.LVItemAdd('New');
  LV.LVCurItem := i;
  CBType.CurIndex := -1;
  CBFreq.CurIndex := -1;
  DTime.Text := '00:00:00';
  CBMonth.CurIndex := -1;
  CBDate.CurIndex := -1;
  EMessage.Text :='';
  ENama.Text :='New';
end;

procedure TFTask.ENamaChange(Sender: PObj);
begin
  LV.LVItems[LV.LVCurItem,0] := Enama.Text;
end;

procedure TFTask.BtnCancelClick(Sender: PObj);
begin
  LoadTask;
end;

procedure TFTask.CBTypeChange(Sender: PObj);
begin
  LV.LVItems[LV.LVCurItem,1] := CBType.Text;
  BtnBrowse.Visible := (CBType.CurIndex = 5) or (CBType.CurIndex = 9);
    if (CBType.CurIndex = 5) or (CBType.CurIndex = 9) then
      LMessage.Caption := lang.Items[125]
    else
      LMessage.Caption := lang.Items[124];
end;

procedure TFTask.CBFreqChange(Sender: PObj);
begin
  LV.LVItems[LV.LVCurItem,2] := CBFreq.Text;

  CBDayOfWeek.Enabled := CBFreq.CurIndex = 2;
  CBDate.Enabled := (CBFreq.CurIndex = 3) or (CBFreq.CurIndex = 4);
  CBMonth.Enabled := CBFreq.CurIndex = 4;
end;

procedure TFTask.DTimeChange(Sender: PObj);
begin
  LV.LVItems[LV.LVCurItem,3] := DTime.Text;
end;

procedure TFTask.CBDayOfWeekChange(Sender: PObj);
begin
  LV.LVItems[LV.LVCurItem,4] := CBDayOfWeek.Text;
end;

procedure TFTask.CBDateChange(Sender: PObj);
begin
  LV.LVItems[LV.LVCurItem,5] := CBDate.Text;
end;

procedure TFTask.EMessageChange(Sender: PObj);
begin
  LV.LVItems[LV.LVCurItem,7] := EMessage.Text;
end;

procedure TFTask.BtnCloseClick(Sender: PObj);
begin
  Form.Close;
end;

procedure TFTask.BtnDelClick(Sender: PObj);
begin
  Form1.ShowMessage(True,lang.Items[180],itQuestion);
  if MessageResultOK then
  begin
    LV.LVDelete(LV.LVCurItem);
    SaveLV;
    LV.Clear;
    LoadTask;
  end;
end;

procedure TFTask.BtnBrowseClick(Sender: PObj);
var
  OSD : POpenSaveDialog;
begin
  OSD := NewOpenSaveDialog('','',[]);
  OSD.WndOwner := Form.Handle;
  if CBType.CurIndex = 5 then
    OSD.Filter := 'All Files (*.*)|*.*'
  else if CBType.CurIndex = 9 then
    osd.Filter := 'Supported Sound Files (*.wav,*.mp3 ) | *.MP3;*.WAV'+
                '|Others Audio Video format (*.mid,*.midi,*.avi,*.rmi,*.mpg,*.wmv,*.asf)| *.MID;*.MIDI;*.AVI;*.RMI;*.MPG;*.WMV;*.ASF'+
                '|All Files (*.*)|*.*';
  if OSD.Execute then
    EMessage.Text := OSD.Filename;
  OSD.Free;
end;

procedure TFTask.ENamaKeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  if (Key = VK_TAB) or (Key=VK_RETURN) then
    CBType.DoSetFocus;
end;

procedure TFTask.CBTypeKeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  if (Key = VK_TAB) or (Key=VK_RETURN) then
    CBFreq.DoSetFocus;
end;

procedure TFTask.CBFreqKeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  if (Key = VK_TAB) or (Key=VK_RETURN) then
    DTime.DoSetFocus;
end;

procedure TFTask.CBDayOfWeekKeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  if (Key = VK_TAB) or (Key=VK_RETURN) then
    CBMonth.DoSetFocus;
end;

procedure TFTask.CBMonthKeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  if (Key = VK_TAB) or (Key=VK_RETURN) then
    CBDate.DoSetFocus;
end;

procedure TFTask.CBDateKeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  if (Key = VK_TAB) or (Key=VK_RETURN) then
    EMessage.DoSetFocus;
end;

procedure TFTask.KOLForm1Destroy(Sender: PObj);
begin
  FTask := nil;
end;

procedure TFTask.ENamaKeyDown(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    Form.GotoControl( VK_TAB );
  end;
end;

end.





