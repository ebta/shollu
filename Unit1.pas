{ ==========================================================
  Unit Names : Unit1.pas
               ©2005-2010,2012 by Ebta Setiawan
  Salah satu Unit Utama program shollu
  Shollu merupakan program pengingat sholat
  ========================================================== }
{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}

{$DEFINE KOL_MCK}
{$DEFINE USE_GRAPHCTLS}

unit Unit1;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror,
   Classes, Controls, mckControls, mckObjs, Graphics,
   mckCtrls {$IFEND (place your units here->)},
   Shollu,ShellAPI,KOLMediaPlayer;
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TForm1class.inc} {$ELSE OBJECTS} PForm1 = ^TForm1; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TForm1.inc}{$ELSE} TForm1 = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TForm1 = class(TForm)
  {$IFEND KOL_MCK}
    KOLProject1: TKOLProject;
    KOLForm1: TKOLForm;
    TopPanel: TKOLPanel;
    MainPanel: TKOLPanel;
    LeftGP: TKOLGradientPanel;
    TopGP: TKOLGradientPanel;
    LeftPanel: TKOLPanel;
    BtnMainPage: TKOLBitBtn;
    BtnSchedule: TKOLBitBtn;
    BtnAbout: TKOLBitBtn;
    BtnMessage: TKOLBitBtn;
    BtnSetting: TKOLBitBtn;
    BtnTask: TKOLBitBtn;
    ImageList24: TKOLImageList;
    BtnArea: TKOLBitBtn;
    FramePanel: TKOLPanel;
    LTitleInfo: TKOLLabel;
    LTitle: TKOLLabel;
    ImageList16: TKOLImageList;
    KOLApplet1: TKOLApplet;
    Tray: TKOLTrayIcon;
    Popup1: TKOLPopupMenu;
    ImgIcon: TKOLImageShow;
    BtnKonversi: TKOLBitBtn;
    LTitle2: TKOLLabel;
    LE12: TKOLLabel;
    LInfoTgl: TKOLLabel;
    LDesc: TKOLLabel;
    PnlSavedMsg: TKOLPanel;
    Timer1: TKOLTimer;
    PBSaved: TKOLPaintBox;
    Label1: TKOLLabel;
    procedure TopPanelMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure TopPanelPaint(Sender: PControl; DC: HDC);
    procedure KOLForm1Paint(Sender: PControl; DC: HDC);
    procedure BtnAboutClick(Sender: PObj);
    procedure BtnMainPageClick(Sender: PObj);
    procedure BtnSettingClick(Sender: PObj);
    procedure BtnAreaClick(Sender: PObj);
    procedure BtnMessageClick(Sender: PObj);
    procedure BtnScheduleClick(Sender: PObj);
    procedure KOLForm1Close(Sender: PObj; var Accept: Boolean);
    procedure TrayMouse(Sender: PObj; Message: Word);
    procedure Popup1N1Menu(Sender: PMenu; Item: Integer);
    procedure KOLForm1Hide(Sender: PObj);
    procedure KOLForm1Show(Sender: PObj);
    procedure Popup1N4Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N5Menu(Sender: PMenu; Item: Integer);
    procedure ImgIconMouseLeave(Sender: PObj);
    procedure ImgIconMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure ImgIconMouseUp(Sender: PControl; var Mouse: TMouseEventData);
    procedure ImgIconMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure TopPanelMouseUp(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure KOLForm1MouseUp(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure BtnTaskClick(Sender: PObj);
    procedure Popup1N8Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N9Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N10Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N3Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N11Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N12Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N13Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N15Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N16Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N17Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N18Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N20Menu(Sender: PMenu; Item: Integer);
    procedure Popup1Popup(Sender: PObj);
    procedure Popup1N23Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N22Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N24Menu(Sender: PMenu; Item: Integer);
    procedure BtnMainPageMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure BtnMainPageMouseLeave(Sender: PObj);
    procedure BtnKonversiClick(Sender: PObj);
    procedure Popup1N25Menu(Sender: PMenu; Item: Integer);
    function KOLForm1Message(var Msg: TMsg; var Rslt: Integer): Boolean;
    procedure PBSavedPaint(Sender: PControl; DC: HDC);
    procedure Timer1Timer(Sender: PObj);
  private
    { Private declarations }
    UseBmpTop : Boolean;
    clBorder,clBorderIn : TColor;

    { for Adzan }
    MainTimer : PTimer;
    P1 : PMediaPlayer;
    NextUpdate : Cardinal;

    { Counter }
    InfoCount,MainCnt : Cardinal;
    {Icon}
    MouseDown : Boolean;

    // v3.05
    Shollu3_Hwnd : HWND;
    PReg : HKEY;
    Mp : PMediaPlayer; { New Task for multimedia Player }

    // new 3.08
    MpDua : PMediaPlayer ; // Dua after adzan

    pnlSavedCunter :Integer;
    procedure HideAllFrame;
    procedure InitFirst_JustOnce;
    procedure onMainTimer(sender: Pobj);
    procedure PauseAdzan;
    procedure StartAdzan;
    procedure StopAdzan;
    procedure StartDua;
    procedure StopDua;
    procedure onAdzanTiba(info : string);
    procedure LoadDefLanguage;
    procedure RunTask(i: Integer);
    Procedure CloseMultimedia;
    procedure Update_tS(tDay : Integer);
    procedure ShowKonversi;
    function ReplacePesan(input : string) : string;
    procedure UpdateHint(waktu: TSholat);
  public
    { Public declarations }
    BmpTop : PBitmap;  { Agar Fbar Bisa Akses }

    { Dialog Form }
    DlgCaption : string;
    Icon : TIconType;

    { Save in Registry }
    tS : tSholat;
    Area : string;
    AdzanFile : String;
    Syafii : Boolean;
    Gn,Gd,TZ : Single;
    Latitude,Longitude : String;
    Altitude,skin : Integer;

    M1,M2,MAdzan,MMin,MMsg,MShutdown,MTimeShutdown,
    Methods,Minfo,MShutdownAfter : Word;
    MJumat : TDateTime;

    { v3.05 }
    afTimer : Ptimer;
    DialogEffect : integer;
    EffectNow : Boolean;

    { v3.06 }
    DropZone, dzRemaining,dzTransparent,dzSnap  : Boolean;

    procedure PaintTop(Sender: PControl);
    procedure PaintForm(Sender: PControl);
    Procedure LoadBmpTop(index : Integer);
    procedure UpdateSkinColor;
    procedure MakeRounded(Control: PControl);
    procedure UpdateData;
    procedure ReadRegistry;
    procedure UpdateLanguage;
    Procedure LoadLanguage(LanguageName : string);
    function ShowMessage(Button2 : Boolean; const caption : string;
             IconType : TIconType) : Integer;
    Procedure ShowBar;
    procedure LoadtaskToday;
    function ParseText(const Text: string): TTask;
    procedure Hibernate;
    Procedure OpenHelpFile(Caption : string);
    // v3.06
    procedure ShowFormDropZone;
    Procedure UpdateInfoTanggal;
    // 3.07
    procedure SaveSetting(NamaFile : String);
    procedure LoadSetting(NamaFile: string);
    // 3.09
    procedure animeSaved;
  end;

const
  BMP_HEIGHT = 29;
  TASK_FILE = 'Task.dat';
  
var
  Form1 {$IFDEF KOL_MCK} : PForm1 {$ELSE} : TForm1 {$ENDIF} ;

  {$IFDEF KOL_MCK}
procedure NewForm1( var Result: PForm1; AParent: PControl );
{$ENDIF}

implementation

uses UColConv, UMainPage, UAbout, UArea, UMessage, USchedule,
  USettingpas, UDialog, UBar, UTask, UConvert, UDropZone;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I Unit1_1.inc}
{$ENDIF}
{$R Skin.RES}
{$R icon32.RES}
{$R Language.RES}
{$R Win7UAC.RES} 

procedure TForm1.TopPanelMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  ReleaseCapture;
  SendMessage(Form.Handle,WM_SYSCOMMAND,$F012,0);
end;

procedure TForm1.MakeRounded(Control: PControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control^ do
  begin
    R := ClientRect;
    rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 3, 3);
    Perform(EM_GETRECT, 0, lParam(@r));
    InflateRect(r, - 5, - 5);
    Perform(EM_SETRECTNP, 0, lParam(@r));
    SetWindowRgn(Handle, rgn, True);
    Invalidate;
    DeleteObject(Rgn);
  end;
end;

Procedure TForm1.LoadBmpTop(index : Integer);
var
  cRGB : TRGB;
  cHLS : THLS;
  c1,c2 : Tcolor;
  i : Integer;
begin
  IndexColor := index;
  case index of
    0,20 : BmpTop.LoadFromResourceName(HInstance,'AquaBlue_T');
    1,21 : BmpTop.LoadFromResourceName(HInstance,'CoronaH_T');
    2,22 : BmpTop.LoadFromResourceName(HInstance,'Eb5AquaBlue_T');
    3,23 : BmpTop.LoadFromResourceName(HInstance,'Eb5AquaGray_T');
    4,24 : BmpTop.LoadFromResourceName(HInstance,'Eb5AquaRed_T');
    5,25 : BmpTop.LoadFromResourceName(HInstance,'Eb1Pink');
    6,26 : BmpTop.LoadFromResourceName(HInstance,'zYellowX');
    7,27 : BmpTop.LoadFromResourceName(HInstance,'Eb4aquaGreen');
    8,28 : BmpTop.LoadFromResourceName(HInstance,'Eb4aquaNavy');
    9,29 : BmpTop.LoadFromResourceName(HInstance,'Eb4aquaRed');
    10,30: BmpTop.LoadFromResourceName(HInstance,'WinXp_T');
    11,31: BmpTop.LoadFromResourceName(HInstance,'WinXpOlive_T');
    12,32: BmpTop.LoadFromResourceName(HInstance,'WinXpSilver_T');
    13,33: BmpTop.LoadFromResourceName(HInstance,'AquaPink');
    14,34: BmpTop.LoadFromResourceName(HInstance,'zBlueX');
    15,35: BmpTop.LoadFromResourceName(HInstance,'zGrayX');
    16,36: BmpTop.LoadFromResourceName(HInstance,'zBlackGreenX');
    17,37: BmpTop.LoadFromResourceName(HInstance,'WinVista1');
    18,38: BmpTop.LoadFromResourceName(HInstance,'WinVista2');
    19,39: BmpTop.LoadFromResourceName(HInstance,'WinVista3');
    else BmpTop.LoadFromResourceName(HInstance,'zBlueX');
  end;

  case index of
   0..19,22..30,31,33,35 : UseBmpTop := True;
   else
     UseBmpTop := False;
  end;
  
  if not UseBmpTop then
  begin
    c1 := Bmptop.Pixels[0,1];
    c2 := Bmptop.Pixels[0,15];
    for i := 1 to 27 do
      BmpTop.Pixels[0,i] := GetGradientColor2(c1,c2,i/27);
  end;
  clBorder := BmpTop.Pixels[0,0];
  clBorderIn := BmpTop.Pixels[0,27];

  cBorder1 := BmpTop.Pixels[0,BMP_HEIGHT-1];
  cBorder2 := BmpTop.Pixels[0,BMP_HEIGHT-2];

  cRGB := ColorToRGB(cBorder2);
  cHLS := RGBToHLS(cRGB);
  cHLS.L := 240;
  cRGB := HLSToRGB(cHLS);
  cGPMain1Col1 := RGBToCol(cRGB);

  case index of
    0..20 :
    begin
      cHLS.L := 210;
      cRGB := HLSToRGB(cHLS);
      cForm := clWhite;
      cMenuFont  := clNavy;
      cMainFont := clBlack;
      cTitleFont := clWhite;
      cGPMainCol2 := RGBToCol(cRGB);
    end;
    21..38 :
    begin
      cHLS.L := 220;
      cRGB := HLSToRGB(cHLS);
      cForm := RGBToCol(cRGB);
      cMenuFont  := clWhite;
      cMainFont := cBorder1;
      cTitleFont := clWhite;
      cGPMainCol2 := cBorder1;
    end;
    39 :
    begin
      cForm := clGray;
      cMenuFont  := clWhite;
      cMainFont := clWhite;
      cTitleFont := clWhite;
      cGPMainCol2 := cBorder1;
    end;
  end;

  if not UseBmpTop then
  for i := 1 to 27 do
    BmpTop.Pixels[0,i] := GetGradientColor2(cBorder1,cBorder2,i/27);

  { Moving Title Bar Font Color }
  case index of
  3,5,6,8,9,11,12,13,28,29,31,32,33 : cTitleBar := clNavy;
  0,1,2,4,7,10,14..27,30,34..39 : cTitleBar := clWhite;
  end;

end;

procedure TForm1.UpdateSkinColor;
begin
  // Update All Form Control Color Here
  TopGP.Color1 := cGPMainCol2;
  TopGP.Color2 := cForm;
  LeftGP.Color1 := cForm;
  LeftGP.Color2 := cGPMainCol2;
  Form.Color := clWhite;
  LTitle.Font.Color := cTitleFont;//cGPMainCol2;
//  LTitle.Color2 := cGPMain1Col1;

  LTitle2.Font.Color := cMenuFont;
//  LTitle2.Color2 := cBorder2;
  LE12.Font.Color := cMenuFont;
  LDesc.Font.Color := cMenuFont;
  LTitleInfo.Font.Color := cMenuFont;
  LInfoTgl.Font.Color := cBorder1;

  BtnMainPage.Font.Color := cMenuFont;
  BtnSchedule.Font.Color := cMenuFont;
  BtnAbout.Font.Color := cMenuFont;
  BtnMessage.Font.Color := cMenuFont;
  BtnSetting.Font.Color := cMenuFont;
  BtnTask.Font.Color := cMenuFont;
  BtnArea.Font.Color := cMenuFont;
  BtnKonversi.Font.Color := cMenuFont;

//  LTglM.Font.Color := cMenuFont;
//  LTglH.Font.Color := cMenuFont;
//  LHariJam.Font.Color := cMenuFont;

  Form.Color := cForm;
  MainPanel.Color := cForm;
  FramePanel.Color := cForm;

  if FDropZone <> nil then
    FDropZone.UpdateColor;

end;

procedure TForm1.PaintTop(Sender: PControl);
var
  R : TRect;
  A : array[0..23] of TPoint;
begin
  R := TKOLPanel(Sender).ClientRect;

  { Right Round  }
  A[0] := MakePoint(R.Left,R.Bottom);
  A[1] := MakePoint(R.Left,R.Top+5);
  A[2] := MakePoint(R.Left+1,R.Top+5);
  A[3] := MakePoint(R.Left+1,R.Top+4);
  A[4] := MakePoint(R.Left+1,R.Top+3);
  A[5] := MakePoint(R.Left+2,R.Top+3);
  A[6] := MakePoint(R.Left+2,R.Top+2);
  A[7] := MakePoint(R.Left+3,R.Top+2);
  A[8] := MakePoint(R.Left+3,R.Top+1);
  A[9] := MakePoint(R.Left+4,R.Top+1);
  A[10] := MakePoint(R.Left+5,R.Top+1);
  A[11] := MakePoint(R.Left+5,R.Top);

  { RightBottom }
  A[12] := MakePoint(R.Right-6,R.Top);
  A[13] := MakePoint(R.Right-6,R.Top+1);
  A[14] := MakePoint(R.Right-5,R.Top+1);
  A[15] := MakePoint(R.Right-4,R.Top+1);
  A[16] := MakePoint(R.Right-4,R.Top+2);
  A[17] := MakePoint(R.Right-3,R.Top+2);
  A[18] := MakePoint(R.Right-3,R.Top+3);
  A[19] := MakePoint(R.Right-2,R.Top+3);
  A[20] := MakePoint(R.Right-2,R.Top+4);
  A[21] := MakePoint(R.Right-2,R.Top+5);
  A[22] := MakePoint(R.Right-1,R.Top+5);
  A[23] := MakePoint(R.Right-1,R.Bottom);

  BmpTop.StretchDraw(TKOLPanel(Sender).canvas.Handle,R);
  with TKOLPanel(Sender).Canvas^ do
    begin
      Brush.BrushStyle := bsSolid;
      Brush.Color := clBorderIn;
   //   if not UseBmpTop then FillRect(R);// Flat Color
      Pen.Color := clBorder;
      Polyline(A);
      MoveTo(R.Left+4,R.Bottom-1);
      LineTo(R.Right-4,R.Bottom-1);
      Pixels[R.Left+1,R.Bottom-1] := clBorderIn;
      Pixels[R.Left+2,R.Bottom-1] := clBorderIn;
      Pixels[R.Left+3,R.Bottom-1] := clBorderIn;
      Pixels[R.Right-2,R.Bottom-1] := clBorderIn;
      Pixels[R.Right-3,R.Bottom-1] := clBorderIn;
      Pixels[R.Right-4,R.Bottom-1] := clBorderIn;
    end;
end;

Function GetHotKey(HotKey : string) : integer;
var
  i : byte;
  s : string;
begin
  s :=Uppercase(trim(HotKey));
  Result := 123; // F12
  if length(s) = 1 then
  begin
    Result := Ord(s[1]);
  end
  else //  if length(trim(HotKey)) > 1 then
    if HotKey[1] = 'F' then
    begin
      i := Str2Int(copy(HotKey,2,2));
      if i=0 then exit;
      Result := 111 + i;
    end;
end;

procedure TForm1.KOLForm1FormCreate(Sender: PObj);
var
  R1  : HRGN;
  i   : Integer;
  Key : string;
begin
  PReg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  if not justone(Form,'Shollu3 Cöpÿright By éßt@') then
    begin
      Tray.Active := False;
      InitFirst_JustOnce;
      ReadRegistry;

      if PReg <> 0 then
        Shollu3_Hwnd := RegKeyGetDw(Preg,'Hwnd');
      RegKeyClose(PReg);

      if Shollu3_Hwnd <> 0 then
        ShowWindow(Shollu3_Hwnd,SW_Normal);

      Lang.Free;
      BmpTop.Free;
      Applet.Close;
      Exit;
    end;

  if PReg <> 0 then
    RegKeySetDw(Preg,'Hwnd',form.handle);

  LTitle2.Caption := 'Shollu '+versi;
  LTitle.Caption := 'Shollu';

  skin :=0;
  BmpTop := NewBitmap(0,0);
  LoadBmpTop(skin);
  R1 := CreateRoundRectRgn(0,0,Form.Width+1,form.Height+14,13,13);
  try
    SetWindowRgn(form.Handle,R1,True);
  finally
    DeleteObject(R1);
  end;
  TopGP.Top := TopPanel.Height;
  TopGP.Left  := 3;
  TopGP.Width := Form.Width - 5;
  MainPanel.Left := 3;
  MainPanel.Top  := TopPanel.Height + TopGP.Height ;
  MainPanel.Width  := Form.Width - 6;
  MainPanel.Height := Form.Height - TopPanel.Height - TopGP.Height - 3;

  MakeRounded(TopGP);
  InitFirst_JustOnce;
  ReadRegistry;
  LoadBmpTop(skin);
  UpdateSkinColor;
  NewFMainPage(FMainPage,FramePanel);
  UpdateData;
  AppDataDir := GetTaskDirectory;
  Form.Hide;
  AppletHide;
  LoadtaskToday;
  if DropZone then ShowFormDropZone;

  if TaskTodayCount > 0 then
    for i:= 0 to TaskTodayCount do
    begin
      if TaskToday[i].Freq = tfStart then
        RunTask(i);
    end;
  LDesc.Caption := lang.items[47];

  // new 3.08  VK_F12 = 123;
  Key := RegKeyGetStr(PReg,'HotKey');
  // RegisterHotKey(Form.Handle,1001,MOD_CONTROL or MOD_ALT,VK_F12);
  RegisterHotKey(Form.Handle,1001,MOD_CONTROL or MOD_ALT,GetHotKey(Key));
end;

procedure TForm1.TopPanelPaint(Sender: PControl; DC: HDC);
begin
  PaintTop(Sender);
end;

procedure TForm1.PaintForm(Sender: PControl);
var
  R  : TRect;
  A  : array[0..5] of TPoint;
begin
  R := Sender.ClientRect;
  R.Top := R.Top+28;
  with Sender.canvas^ do
    begin
      Pen.Color := clBorder;
      A[0] := MakePoint(R.Left,R.Top);
      A[1] := MakePoint(R.Left,R.Bottom-1);
      A[2] := MakePoint(R.Right-1,R.Bottom-1);
      A[3] := MakePoint(R.Right-1,R.Top);
      A[4].x := 0; A[4].y := 0;
      A[5].x := 0; A[5].y := 0;
      Polyline(A); { Frame outside }

      A[0] := MakePoint(R.Left+3,R.Top+1);
      A[1] := MakePoint(R.Left+2,R.Top+2);
      A[2] := MakePoint(R.Left+2,R.Bottom-3);
      A[3] := MakePoint(R.Right-3,R.Bottom-3);

 { --old v3.03 and bellow
  if isWinVer([wv31,wv95,wv98,wvME]) then // Windows95/98/Me
        begin
          { Ada sedikit sekali perbedaan posisi pixel
          A[4] := MakePoint(R.Right-3,R.Top+1);
          A[5] := MakePoint(R.Right-5,R.Top);
        end
      else                    }
  //      begin
          A[4] := MakePoint(R.Right-3,R.Top+2);
          A[5] := MakePoint(R.Right-5,R.Top+1);
  //      end;
      Polyline(A); { Frame Inside }

      Pen.color := clBorderIn;
      A[0] := MakePoint(R.Left+2,R.Top+1);
      A[1] := MakePoint(R.Left+1,R.Top+2);
      A[2] := MakePoint(R.Left+1,R.Bottom-2);
      A[3] := MakePoint(R.Right-2,R.Bottom-2);
      A[4] := MakePoint(R.Right-2,R.Top+2);
      A[5] := MakePoint(R.Right-4,R.Top);
      Polyline(A); { Frame Between }

      Pixels[R.Left+1,R.Top+1] := clBorderIn;
      Pixels[R.Right-2,R.Top+1] := clBorderIn
    end;
end;

procedure TForm1.KOLForm1Paint(Sender: PControl; DC: HDC);
begin
  PaintForm(Sender);
end;

procedure TForm1.HideAllFrame;
begin
  if FMainPage <> nil then FMainPage.Form.Hide;
  if FSetting <> nil then FSetting.Form.Hide;
  if FArea <> nil then FArea.Form.Hide;
  if FMessage <> nil then FMessage.Form.Hide;
  if FSchedule <> nil then FSchedule.Form.Hide;
  if FAbout <> nil then FAbout.Form.Hide;
end;

procedure TForm1.BtnMainPageClick(Sender: PObj);
begin
  HideAllFrame;
  if FMainPage <> nil then FMainPage.Form.Show
  else NewFMainPage(FMainPage,FramePanel);
  // LTitleInfo.Caption := Lang.Items[48]
  LTitle.Caption := 'Shollu - [' +Lang.Items[48] +']';
end;

procedure TForm1.BtnSettingClick(Sender: PObj);
begin
  HideAllFrame;
  if FSetting <> nil then FSetting.Form.Show
  else NewFSetting(FSetting,FramePanel);
//  LTitleInfo.Caption := Lang.Items[60]
  LTitle.Caption := 'Shollu - [' +Lang.Items[60] +']';
end;

procedure TForm1.BtnAreaClick(Sender: PObj);
begin
  HideAllFrame;
  if FArea <> nil then FArea.Form.Show
  else NewFArea(FArea,FramePanel);
//  LTitleInfo.Caption := Lang.Items[70]
  LTitle.Caption := 'Shollu - [' +Lang.Items[70] +']';
end;

procedure TForm1.BtnMessageClick(Sender: PObj);
begin
  HideAllFrame;
  if FMessage <> nil then FMessage.Form.Show
  else NewFMessage(FMessage,FramePanel);
//  LTitleInfo.Caption := Lang.Items[89]
  LTitle.Caption := 'Shollu - [' +Lang.Items[89] +']';
end;

procedure TForm1.BtnScheduleClick(Sender: PObj);
begin
  HideAllFrame;
  if FSchedule <> nil then FSchedule.Form.Show
  else NewFSchedule(FSchedule,FramePanel);
//  LTitleInfo.Caption := Lang.Items[106];
  LTitle.Caption := 'Shollu - [' +Lang.Items[106] +']';
end;

procedure TForm1.BtnAboutClick(Sender: PObj);
begin
  HideAllFrame;
  if FAbout <> nil then FAbout.Form.Show
  else NewFAbout(FAbout,FramePanel);
//  LTitleInfo.Caption := Lang.Items[131];
  LTitle.Caption := 'Shollu - [' +Lang.Items[131] +']';
end;

procedure TForm1.InitFirst_JustOnce;
var
  n : string;
begin
  SholluDir  := ExtractFilePath(ParamStr(0));
  Lang := NewStrList;

  MainTimer := NewTimer(1000);
  MainTimer.Enabled := True;
  MainTimer.OnTimer := onMainTimer;

  MainCnt :=0;
  InfoCount :=0;
  n := Time2StrFmt(TIME_FMT_3,Now);
  NextUpdate := Integer(Trunc((Str2TimeFmt(TIME_FMT_3,'23:59:59') -
                        Str2TimeFmt(TIME_FMT_3,n)) / (SATU_MENIT/60.0)));
  NextUpdate := NextUpdate + 10; // for safety

  BmpTop := NewBitmap(0,0);
  UseBmpTop := True;
  PnlSavedMsg.Visible := False;
end;

procedure Tform1.onAdzanTiba(info : string);
begin
  if MShutdown = 2 then Hibernate
  else  if MShutdown = 1 then ShutdownPC;
  if MMin = 1 then MinimizeAll;
  FDropZone.Linfo.Caption := Format(Lang.Items[133],[info]);
  FDropZone.Linfo2.caption := '';
  FDropZone.FlashWindow;
  if MAdzan = 1 then StartAdzan;
  if MMsg = 1 then
    begin
      if FBar <> nil then FBar.Form.Show
      else
        begin
          NewFBar(FBar,Applet);
          FBar.Form.Show;
        end;
      FBar.LText.Caption := Format(Lang.Items[133],[info]);
      FBar.LText2.Caption := FBar.LText.Caption;
      ShowMessage(False,FBar.LText.Caption,itInfo);
    end;
end;

Procedure ShowMessageDouble(const caption : string);
begin
  if FBar <> nil then FBar.Form.Show
  else
    begin
      NewFBar(FBar,Applet);
      FBar.Form.Show;
    end;
  FBar.LText.Caption := caption;
  FBar.LText2.Caption := Caption;
  Form1.ShowMessage(False,caption,itInfo);
end;

procedure DefaultHighlight;
begin
   with FMainPage^ do
   begin
      LTm1.Transparent := True;
      LTm3.Transparent := True;
      LTm5.Transparent := True;
      LTm21.Transparent := True;
      UpdateSkin;

      LTm1.Font.Color := LTm01.Font.Color;
      LTm2.Font.Color := LTm01.Font.Color;
      LTm3.Font.Color := LTm01.Font.Color;
      LTm4.Font.Color := LTm01.Font.Color;
      LTm5.Font.Color := LTm01.Font.Color;
      LTm6.Font.Color := LTm01.Font.Color;
      LTm21.Font.Color := LTm01.Font.Color;
      LTm21.Font.FontStyle := [];

      LSh1.Font.Color := LTm01.Font.Color;
      LSh2.Font.Color := LTm01.Font.Color;
      LSh3.Font.Color := LTm01.Font.Color;
      LSh4.Font.Color := LTm01.Font.Color;
      LSh5.Font.Color := LTm01.Font.Color;
      LSh6.Font.Color := LTm01.Font.Color;
   end;
end;

procedure HighlightWaktu(idx : Integer; NewColor : TColor);
var
   needUpdate : Boolean;
   
   procedure _setColor(cmp : PControl);
   begin
      cmp.Transparent := False;
      cmp.Color := NewColor;
      cmp.Font.Color := clWhite;
   end;
begin
   needUpdate := false;
  with FMainPage^ do
    case idx of
    1 : needUpdate := LTm1.Color <> NewColor;
    2 : needUpdate := LTm2.Color <> NewColor;
    3 : needUpdate := LTm3.Color <> NewColor;
    4 : needUpdate := LTm4.Color <> NewColor;
    5 : needUpdate := LTm5.Color <> NewColor;
    6 : needUpdate := LTm6.Color <> NewColor;
    21 : needUpdate := LTm21.Color <> NewColor;
    end;
  if not needUpdate then Exit;

  DefaultHighlight;
  with FMainPage^ do
    case idx of
    1 : _setColor(LTm1);
    2 : _setColor(LTm2);
    3 : _setColor(LTm3);
    4 : _setColor(LTm4);
    5 : _setColor(LTm5);
    6 : _setColor(LTm6);
    21 : begin
            _setColor(LTm21);
            LTm21.Font.FontStyle := [fsBold]
         end;
    end;
end;

procedure TForm1.UpdateHint(waktu : TSholat);
var
  info,remain,sSholat,skr : string;
  wSholatStr : TSholatString;

  procedure InternalUpdateInfo(waktuSholat:TDateTime; idx : Integer);
  begin
    sSholat := Lang.Items[idx];
    info := sSholat +' '+ Time2StrFmt(TIMEFORMAT,waktuSholat);
    { Calculate Remaining minutes }
    Remain := Time2StrFmt(TIME_FMT_3,waktuSholat-Str2TimeFmt(TIME_FMT_3,skr));
    HighlightWaktu(idx,clRed);
  end;

begin
  wSholatStr := TSholat2Str(waktu);
  skr := Time2StrFmt(TIME_FMT_3,Now);

  if skr < wSholatStr.tShubuh then
    InternalUpdateInfo(waktu.tShubuh,1)
  else if skr < wSholatStr.tTerbit then
    InternalUpdateInfo(waktu.tTerbit,2)
  else if skr < wSholatStr.tDhuhur then
    InternalUpdateInfo(waktu.tDhuhur,3)
  else if skr < wSholatStr.tAsar then
    InternalUpdateInfo(waktu.tAsar,4)
  else if skr < wSholatStr.tMaghrib then
    InternalUpdateInfo(waktu.tMaghrib,5)
  else if skr < wSholatStr.tIsya then
    InternalUpdateInfo(waktu.tIsya,6)
  else
  begin
    Remain := Time2StrFmt(TIME_FMT_3,Str2TimeFmt(TIME_FMT_3,'23:59:59')-
              Str2TimeFmt(TIME_FMT_3,skr) + Str2TimeFmt(TIMEFORMAT,FMainPage.LTm21.Caption));// tNow.tShubuh);
    info := Lang.Items[1] +' : '+ FMainPage.LTm21.Caption; //Time2StrFmt(TIMEFORMAT,tNow.tShubuh);
    sSholat := Lang.Items[1];
    HighlightWaktu(21,clRed);
  end;

//  LHariJam.Caption := HariIni + ', '+ Time2StrFmt(TIME_FMT_3,Now);
  if FDropZone.Form.Visible and (not FDropZone.WindowFlashing) then
  begin
    FDropZone.Linfo.Caption := info;
    if dzRemaining then
      FDropZone.Linfo2.Caption := Lang.Items[205]+ ' '+remain
  end;

  info := Area+#13+info+#13+Lang.Items[205]+' '+remain;
  Tray.Tooltip :=info+#13+'Shollu '+versi;

  { Caption Information for FBar }
  if Minfo > 0 then
  if (InfoCount mod (Minfo*60)) = 0 then
  begin
//    if not FBar.Form.Visible then
    if FBar <> nil then FBar.Form.Show
    else  NewFBar(FBar,Applet);
    begin
      with FMainPage^ do
      FBar.LText.Caption := Lang.Items[1]+': '+LTm1.Caption+ ' '+
                            Lang.Items[2]+': '+ LTm2.Caption+' '+
                            Lang.Items[3]+': '+ LTm3.Caption+' '+
                            Lang.Items[4]+': '+ LTm4.Caption+' '+
                            Lang.Items[5]+': '+ LTm5.Caption+' '+
                            Lang.Items[6]+': '+ LTm6.Caption;//+' -'+
      FBar.LText2.Caption := '- '+format(Lang.Items[204],[sSholat,Remain])+' -';
      FBar.Form.Show;
    end;
  end;
end;  

procedure TForm1.onMainTimer(sender: Pobj);
var
  Naow,sShubuh, sDhuhur,sAsar, sMaghrib, sIsya : string;
  i : Integer;
begin
  // MainCnt, InfoCount = Start at application run, increase on this Timer Only
  Inc(MainCnt);
  Inc(InfoCount);
  if MainCnt = NextUpdate then
    begin
      MainCnt := 0;
      NextUpdate := 86400;  // 24 jam
      // Update data is litle time consuming so update only after 00:00
      UpdateData;
      LoadtaskToday;
    end;
		
	{ Convert tSholat to String to get correct comparison }
	sShubuh 	:= Time2StrFmt(TIME_FMT_3,tNow.tShubuh);
	sDhuhur 	:= Time2StrFmt(TIME_FMT_3,tNow.tDhuhur);
	sAsar	  	:= Time2StrFmt(TIME_FMT_3,tNow.tAsar);
	sMaghrib	:= Time2StrFmt(TIME_FMT_3,tNow.tMaghrib);
	sIsya		:= Time2StrFmt(TIME_FMT_3,tNow.tIsya);

  { ---------------------- CEK FOR PRAYER TIMES ------------------------ }
  Naow := Time2StrFmt(TIME_FMT_3,Now);
  
  if sMaghrib = Naow then
    begin
      AdzanFile := RegKeyGetStr(PReg,'AdzanMaghrib');
      onAdzanTiba(Lang.Items[5]);
    end
  else if sIsya = Naow then
    begin
      AdzanFile := RegKeyGetStr(PReg,'AdzanIsya');
      onAdzanTiba(Lang.Items[6])
    end
  else if sShubuh = Naow then
    begin
      AdzanFile := RegKeyGetStr(PReg,'AdzanShubuh');
      onAdzanTiba(Lang.Items[1])
    end
  else if sDhuhur = Naow then
    begin
      AdzanFile := RegKeyGetStr(PReg,'AdzanDhuhur');
      onAdzanTiba(Lang.Items[3])
    end
  else if sAsar = Naow then
    begin
      AdzanFile := RegKeyGetStr(PReg,'AdzanAsar');
      onAdzanTiba(Lang.Items[4])
    end;


  { Hint for tray Icon }
  UpdateHint(tNow);

  { Task Scheduler }
  if TaskTodayCount > 0 then
  for i:=0 to TaskTodayCount do
  begin
    if Naow = TaskToday[i].JamInStr then
      RunTask(i);
  end;

  { Cek For Message 1 }
  if M1 > 0 then
  begin
    Naow := Time2StrFmt(TIME_FMT_3,Now+M1*SATU_MENIT);
    if sShubuh = Naow then
      ShowMessageDouble(Format(Lang.Items[134],[M1,Lang.Items[1]]))
    else
    if sDhuhur = Naow  then
      ShowMessageDouble(Format(Lang.Items[134],[M1,Lang.Items[3]]))
    else
    if sAsar = Naow  then
      ShowMessageDouble(Format(Lang.Items[134],[M1,Lang.Items[4]]))
    else
    if sMaghrib = Naow then
      ShowMessageDouble(Format(Lang.Items[134],[M1,Lang.Items[5]]))
    else
    if sIsya = Naow then
      ShowMessageDouble(Format(Lang.Items[134],[M1,Lang.Items[6]]))
  end;

  { Cek For Shutdown when prayer times coming / arrived }
  if MShutdown = 1 then
  begin
    Naow :=Time2StrFmt(TIME_FMT_3,Now-MTimeShutdown*SATU_MENIT);
    if (sMaghrib = Naow) or (sIsya = Naow) or (sShubuh = Naow) or (sDhuhur = Naow) or (sAsar = Naow) then
      ShutdownPC
  end;

  { Cek For Friday Message }
  if (DayOfWeek(Date) = 5) and (MJumat <> 0) then
  begin
    if Time2StrFmt(TIME_FMT_3,Now) = Time2StrFmt(TIME_FMT_3,MJumat) then
      ShowMessageDouble(lang.Items[135]);
  end;

  { Cek For Message 2 / After Prayer Times }
  if M2 > 0 then
  begin
    Naow := Time2StrFmt(TIME_FMT_3,Now-M2*SATU_MENIT);
    if sShubuh = Naow then
      ShowMessageDouble(Format(lang.Items[136],[M2,Lang.Items[1]]))
    else
    if sDhuhur = Naow  then
      ShowMessageDouble(Format(lang.Items[136],[M2,Lang.Items[3]]))
    else
    if sAsar = Naow  then
      ShowMessageDouble(Format(lang.Items[136],[M2,Lang.Items[4]]))
    else
    if sMaghrib = Naow then
      ShowMessageDouble(Format(lang.Items[136],[M2,Lang.Items[5]]))
    else
    if sIsya = Naow then
      ShowMessageDouble(Format(lang.Items[136],[M2,Lang.Items[6]]))
  end;

  { Cek For Shutdown After }
  if (MShutdownAfter =1) or (MShutdownAfter=2) then
    if MTimeShutdown > 0 then
    begin
      Naow := Time2StrFmt(TIME_FMT_3,Now-MTimeShutdown*SATU_MENIT);
      if (sMaghrib = Naow) or
         (sIsya = Naow) or
         (sShubuh = Naow) or
         (sDhuhur = Naow) or
         (sAsar = Naow) then
        begin
          if MShutdownAfter = 1 then ShutdownPC
          else if MShutdownAfter = 2 then Hibernate;
        end;
    end;

  { Adzan Timer }
  if P1 <> nil then
    if P1.Position >= P1.Length then
      if RegKeyGetDw(Preg,'UseDua') = 1 then
        begin
          if MpDua <> nil then
          begin
            if MpDua.Position >= MpDua.Length then
            begin
              // Stop Dua after adzan
              StopDua;
              StopAdzan;
            end;
          end
          else
            // Start Dua after adzan
            StartDua;
        end
      else
        StopAdzan;

  if Mp <> nil then
    if Mp.position >= Mp.Length then
    begin
      Popup1.Items[20].Visible := False;
      Mp.Pause;
      Mp.Stop;
      Free_And_Nil(Mp);
    end;
end;

procedure TForm1.RunTask(i :Integer);
begin
  case TaskToday[i].Tipe of
    ttinfo     : ShowMessage(False,TaskToday[i].Pesan,itInfo);
    ttError    : ShowMessage(False,TaskToday[i].Pesan,itError);
    ttWarn     : ShowMessage(False,TaskToday[i].Pesan,itWarn);
    ttQuestion : ShowMessage(False,TaskToday[i].Pesan,itQuestion);
    ttCommand  : ShellExecute(0,'open',PChar(TaskToday[i].Pesan),'','',SW_SHOW);
    ttShutdown : ShutdownPC;
    ttHibernate: Hibernate;
    ttMovingText : begin
                     if FBar <> nil then FBar.Form.Show
                     else
                       NewFBar(FBar,Applet);
                     FBar.LText.Caption := TaskToday[i].Pesan;
                     if Length(TaskToday[i].Pesan) < 80 then
                       FBar.LText2.Caption := TaskToday[i].Pesan
                     else
                       FBar.LText2.Caption := '[Shollu '+versi+']';
                   end;
    ttMultimedia : begin
                     if Mp <> nil then
                     begin
                       Mp.Pause;
                       Mp.Stop;
                     end;
               
                     if FileExists(TaskToday[i].Pesan) then
                     begin
                       Popup1.Items[20].Visible := True;
                       Mp := NewMediaPlayer(TaskToday[i].Pesan,Form.Handle);
                       //Mp.LoadFile(TaskToday[i].Pesan);
                       //Mp.SetOutput(CreateMCIOBffer(Mp));
                       Mp.Play(0,-1);
                     end;
                   end;
  end;
end;  

procedure TForm1.Update_tS(tDay : Integer);
begin
  { Yesterday / Kemarin tDay = -1, Sekarang tDay=0 dan Besok tDay =1}
  tS := GetPrayerTime(Date+tDay,Altitude,TZ,Gd,Gn,Str2Double(Latitude),
        Str2Double(Longitude),syafii);
{  tS.tDhuhur := tS.tDhuhur + Add_Dhuhur*SATU_MENIT;
  tS.tMaghrib := tS.tMaghrib + Add_Maghrib*SATU_MENIT;
  //3.06
  tS.tShubuh := tS.tShubuh + Add_Shubuh*SATU_MENIT;
  tS.tAsar := tS.tAsar + Add_Asar*SATU_MENIT;
  tS.tIsya := tS.tIsya + Add_Isya*SATU_MENIT;     }
end;  

procedure TForm1.UpdateData;
begin
  Update_tS(-1);
  with FMainPage^ do
  begin
    LTm01.Caption := Time2StrFmt(TIMEFORMAT,tS.tShubuh);
    LTm02.Caption := Time2StrFmt(TIMEFORMAT,tS.tTerbit);
    LTm03.Caption := Time2StrFmt(TIMEFORMAT,tS.tDhuhur);
    LTm04.Caption := Time2StrFmt(TIMEFORMAT,tS.tAsar);
    LTm05.Caption := Time2StrFmt(TIMEFORMAT,tS.tMaghrib);
    LTm06.Caption := Time2StrFmt(TIMEFORMAT,tS.tIsya);
  end;

  { Tomorrow / Besok }
  Update_tS(1);
  with FMainPage^ do
  begin
    LTm21.Caption := Time2StrFmt(TIMEFORMAT,tS.tShubuh);
    LTm22.Caption := Time2StrFmt(TIMEFORMAT,tS.tTerbit);
    LTm23.Caption := Time2StrFmt(TIMEFORMAT,tS.tDhuhur);
    LTm24.Caption := Time2StrFmt(TIMEFORMAT,tS.tAsar);
    LTm25.Caption := Time2StrFmt(TIMEFORMAT,tS.tMaghrib);
    LTm26.Caption := Time2StrFmt(TIMEFORMAT,tS.tIsya);
  end;

  { Today / Hari ini }
  Update_tS(0);
  tNow := tS;

  with FMainPage^ do
  begin
    LTm1.Caption := Time2StrFmt(TIMEFORMAT,tS.tShubuh);
    LTm2.Caption := Time2StrFmt(TIMEFORMAT,tS.tTerbit);
    LTm3.Caption := Time2StrFmt(TIMEFORMAT,tS.tDhuhur);
    LTm4.Caption :=  Time2StrFmt(TIMEFORMAT,tS.tAsar);
    LTm5.Caption := Time2StrFmt(TIMEFORMAT,tS.tMaghrib);
    LTm6.Caption := Time2StrFmt(TIMEFORMAT,tS.tIsya);
  end;

  FMainPage.LNama.Caption := Lang.Items[59]+' '+Area;

  FMainPage.LLat.Caption := Latitude + ' (' + Lat2DMS(Str2Double(Latitude)) +')';
  FMainPage.LLong.Caption := Longitude + ' (' + Long2DMS(Str2Double(Longitude))+')';
  FMainPage.LAlt.Caption := Int2Str(Altitude)+ ' m';
  if TZ > 0 then FMainPage.LTZ.Caption := '+ '+Double2Str(TZ) else
     FMainPage.LTZ.Caption := '- '+Double2Str(TZ);


  case Methods of
    1 : FMainPage.LOrg.Caption := lang.Items[76];
    2 : FMainPage.LOrg.Caption := lang.Items[77];
    3 : FMainPage.LOrg.Caption := lang.Items[78];
    4 : FMainPage.LOrg.Caption := lang.Items[79];
    5 : FMainPage.LOrg.Caption := lang.Items[80];
    else FMainPage.LOrg.Caption := lang.Items[81];
  end;

  if Syafii then FMainPage.LFiqh.Caption := 'Mazhab Imam Syafii' else
    FMainPage.LFiqh.Caption := 'Mazhab Imam Hanafi';

  UpdateInfoTanggal;
end;

procedure TForm1.ReadRegistry;
begin
  if PReg = 0 then
    PReg := RegKeyOpenRead(HKEY_LOCAL_MACHINE,REG_SHOLLU3);

  if PReg <> 0 then
  begin
    M1 := RegKeyGetDw(PReg,'Message1');
    M2 := RegKeyGetDw(PReg,'Message2');
    MAdzan := RegKeyGetDw(PReg,'MAdzan');
    MMin   := RegKeyGetDw(PReg,'MMinimize');
    MMsg   := RegKeyGetDw(PReg,'MMessage');
    MShutdown := RegKeyGetDw(PReg,'MShutdown');
    MTimeShutdown := RegKeyGetDw(PReg,'MTimeShutdown');
    Minfo := RegKeyGetDw(PReg,'ShowInformation');
    RegKeyGetBinary(Preg,'MJumat',MJumat,8);
    MShutdownAfter := RegKeyGetDw(PReg,'MShutdownAfter');
    Altitude := Str2Int(RegKeyGetStr(Preg,'Altitude'));

//  AdzanFile := RegKeyGetStr(PReg,'Adzan');
    Methods := RegKeyGetDw(PReg,'Methods');
    Syafii := RegKeyGetDw(PReg,'Syafii')=0;
    Form.StayOnTop := RegKeyGetDw(Preg,'AlwaysOnTop') =1;

    Area := RegKeyGetStr(Preg,'Area');
    Latitude := RegKeyGetStr(Preg,'Latitude');
    Longitude := RegKeyGetStr(Preg,'Longitude');
    Gn := Str2Double(RegKeyGetStr(Preg,'Gn'));
    Gd := Str2Double(RegKeyGetStr(Preg,'Gd'));
    TZ := Str2Double(RegKeyGetStr(Preg,'TZ'));
    Add_Dhuhur := Str2Int(RegKeyGetStr(Preg,'Add_Dhuhur'));
    Add_Maghrib := Str2Int(RegKeyGetStr(Preg,'Add_Maghrib'));
    //v3.06
    Add_Shubuh := Str2Int(RegKeyGetStr(Preg,'Add_Shubuh'));
    Add_Asar := Str2Int(RegKeyGetStr(Preg,'Add_Asar'));
    Add_Isya := Str2Int(RegKeyGetStr(Preg,'Add_Isya'));
    Pembulatan := RegKeyGetDw(PReg,'Pembulatan');
    HijriyahDiff := Str2Int(RegKeyGetStr(Preg,'HijriyahDiff'));

    skin := Str2Int(RegKeyGetStr(PReg,'Skin'));
    if RegKeyGetDw(PReg,'TimeFormat') = 0 then
      TIMEFORMAT := TIME_FMT_2
    else TIMEFORMAT := TIME_FMT_3;
    DropZone := RegKeyGetDw(PReg,'ShowDropZone') = 1;
    dzRemaining := RegKeyGetDw(PReg,'dzRemaining')= 1;
    dzTransparent := RegKeyGetDw(PReg,'dzTransparent')= 1;
    dzSnap := RegKeyGetDw(PReg,'dzSnap')= 1;

    { Language }
    LoadLanguage(RegKeyGetStr(PReg,'Language'));
    UpdateLanguage;
  end
  else
  begin
    LoaddefLanguage;
    UpdateLanguage;
  end;
end;

{ ============================== PLAY ADZAN ============================= }

procedure TForm1.StartAdzan;
begin
  if not FileExists(Adzanfile) then
    begin
      ShowMessage(False,Lang.Items[182],itWarn);
      Exit;
    end;

  PopUp1.Items[15].Visible := True;
  if P1 = nil then
    begin
      P1 := NewMediaPlayer(AdzanFile,Form.Handle)  ;
      //P1.LoadFile(AdzanFile);
      //P1.SetOutput(CreateMCIOBffer(P1));
      P1.Play(0,-1);
    end
  else
    P1.Play(0,P1.Length);
end;

procedure TForm1.PauseAdzan;
begin
  if P1 = nil then Exit;
  P1.Pause;
end;

procedure TForm1.StopAdzan;
begin
  if P1 = nil then Exit;
  P1.Stop;
  Free_And_Nil(P1);
  PopUp1.Items[15].Visible := False;
end;

procedure TForm1.StartDua;
begin
  if not FileExists(SholluDir+'Dua.mp3') then
    begin
      ShowMessage(False,'File Dua.mp3 not found',itWarn);
      Exit;
    end;

  PopUp1.Items[15].Visible := True;
  if MpDua = nil then
    begin
      MpDua := NewMediaPlayer(SholluDir+'Dua.mp3',Form.Handle);
      //MpDua.LoadFile(SholluDir+'Dua.mp3');
      //MpDua.SetOutput(CreateMCIOBffer(MpDua));
      MpDua.Play(0,-1);
    end
  else
    MpDua.Play(0,-1);
end;

procedure TForm1.StopDua;
begin
  if MpDua = nil then Exit;
  MpDua.Stop;
  Free_And_Nil(MpDua);
  PopUp1.Items[15].Visible := False;
end;

procedure TForm1.Popup1N16Menu(Sender: PMenu; Item: Integer);
begin
  StopAdzan;
end;

procedure TForm1.Popup1N17Menu(Sender: PMenu; Item: Integer);
begin
  pauseAdzan;
end;

// Play Adzan
procedure TForm1.Popup1N18Menu(Sender: PMenu; Item: Integer);
begin
  if P1 <> nil then
    P1.Play(0,-1);
end;

procedure TForm1.Popup1Popup(Sender: PObj);
begin
  if P1 <> nil then
    if P1.Position >= P1.Length then
       Popup1.Items[15].Visible := False
    else
  else
    Popup1.Items[15].Visible := False;
end;

{ ===================== END OF ADZAN ==============================}

procedure TForm1.KOLForm1Close(Sender: PObj; var Accept: Boolean);
begin
  Accept := false;
  CloseMultimedia;
  Lang.Free;
  TaskToday := nil;
  RegCloseKey(Preg); 
  Accept := True;                                         
end;

procedure TForm1.UpdateLanguage;
begin
  { Button Left }
  LDesc.Caption := Lang.Items[47];
  LTitleInfo.Caption := Lang.Items[48];
  BtnMainPage.Caption := Lang.Items[49];
  BtnSetting.Caption := Lang.Items[50];
  BtnArea.Caption := Lang.Items[51];
  BtnMessage.Caption := Lang.Items[52];
  BtnSchedule.Caption := Lang.Items[53];
  BtnTask.Caption := Lang.Items[54];
  BtnAbout.Caption := Lang.Items[55];
  LeftGP.Invalidate;

  Popup1.Items[0].Caption := lang.Items[142];
  Popup1.Items[2].Caption := lang.Items[144];
  Popup1.Items[3].Caption := lang.Items[145];
  Popup1.Items[4].Caption := lang.Items[146];
  Popup1.Items[6].Caption := lang.Items[147];
  Popup1.Items[7].Caption := lang.Items[148];
  Popup1.Items[8].Caption := lang.Items[149];
  Popup1.Items[9].Caption := lang.Items[150];
  Popup1.Items[11].Caption := lang.Items[151];
  Popup1.Items[12].Caption := lang.Items[152];
  Popup1.Items[13].Caption := lang.Items[153];
  Popup1.Items[15].Caption := lang.Items[154];
  Popup1.Items[16].Caption := lang.Items[155];
  Popup1.Items[17].Caption := lang.Items[156];
  Popup1.Items[18].Caption := lang.Items[157];
  Popup1.Items[19].Caption := lang.Items[158];

  UpdateInfoTanggal;

  if FDropZone <> nil then FDropZone.UpdateLanguage;
end;

Procedure Tform1.LoadDefLanguage;
var
  P : PStream;
begin
  P := NewMemoryStream;
  Resource2Stream(P,HInstance,'English',RT_RCDATA);
  P.position :=0;
  lang.LoadFromStream(P,False);
  P.free
end;

Procedure TForm1.LoadLanguage(LanguageName : string);
var
  T : PStrList;
  i : Integer;
  s : string;
begin
  T := NewStrList;
  s := SholluDir+'languages\'+LanguageName+'.slp';
  if not FileExists(s) then
  begin
    LoadDefLanguage;
    Exit;
  end;

  T.LoadFromFile(S);
  if T.Count < 215 then
  begin
    LoadDefLanguage;
    Exit;
  end;

  Lang.Clear;
  for i:=0 to T.Count-1 do
  begin
    if Pos(';',Trim(T.Items[i]))= 1 then Continue;
    if Trim(T.Items[i]) = '' then Continue;
      Lang.Add(T.Items[i]);
  end;
  T.Free;
  if Lang.Count < 200 then
  begin
    LoadDefLanguage;
    Exit;
  end;

//  Lang.SaveToFile('LanguageName.txt');
  NmBulanH[0] := '';
  NmBulanM[0] := '';
  for i:=1 to 12 do
  begin
    NmBulanH[i] := Lang.Items[25+i];
    NmBulanM[i] := Lang.Items[13+i];
  end;  
end;

function TForm1.ShowMessage(Button2 : Boolean; const Caption: string;
                IconType : TIconType): Integer;
begin
  if FDialog = nil then
  begin
    Message2Button := Button2;
    DlgCaption := caption;
    Icon := IconType;
    NewFDialog(FDialog,Applet);
    // v3.08
    FDialog.Form.ShowModalEx;
    FDialog.Form.Free;
  end;
  Result :=0;
end;

procedure TForm1.TrayMouse(Sender: PObj; Message: Word);
var
  P : TPoint;
begin
  case message of
    WM_RBUTTONDOWN :
      begin
        SetForeGroundWindow(form.Handle);
        GetCursorPos(P);
        Popup1.Popup(P.x,p.y);
      end;
    WM_LBUTTONDBLCLK	:
      begin
        Form.Visible := True;
        BtnMainPageClick(Sender);
      end;
  end;
end;

procedure TForm1.Popup1N1Menu(Sender: PMenu; Item: Integer);
begin
  if Form.Visible = False then
  begin
    Form.Show;
    BtnMainPageClick(Sender);
  end
  else
  begin
    Form.Hide;
  end;
end;

procedure TForm1.KOLForm1Hide(Sender: PObj);
begin
  Popup1.ItemText[0] := Lang.Items[142];
end;

procedure TForm1.KOLForm1Show(Sender: PObj);
begin
  Popup1.ItemText[0] := Lang.Items[143];
  MouseDown := False;
  // v3.05
  if FDialog <> nil then
    FDialog.Form.Close;
end;

procedure TForm1.Popup1N4Menu(Sender: PMenu; Item: Integer);
begin
  ShowMessage(True,Lang.Items[137],itQuestion);
  if MessageResultOK then
    begin
      CloseMultimedia;
      Form.Close;
    end;
end;

procedure TForm1.Popup1N5Menu(Sender: PMenu; Item: Integer);
begin
  ShowMessage(True,Lang.Items[138],itQuestion);
  if MessageResultOK then
    SetSuspendMode;
end;

procedure TForm1.ShowBar;
begin
  NewFBar(FBar,Applet);
  FBar.Form.ShowModalEx;
  FBar.Form.free;
end;

procedure TForm1.ImgIconMouseLeave(Sender: PObj);
begin
  ImgIcon.CurIndex := 5;
end;

procedure TForm1.ImgIconMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  MouseDown := True;
  ImgIcon.CurIndex := 6;
end;

procedure TForm1.ImgIconMouseUp(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  Form.Hide;
{  if FMainPage <> nil then FMainPage.form.free;
  if FAbout <> nil then FAbout.form.free;
  if FArea <> nil then FArea.form.free;
  if FMessage <> nil then FMessage.form.free;
  if FSchedule <> nil then FSchedule.form.free;
  if FSetting <> nil then FSetting.form.free;   }
end;

procedure TForm1.ImgIconMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  if MouseDown then
    ImgIcon.CurIndex := 6;
end;

procedure TForm1.TopPanelMouseUp(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  MouseDown := False;
end;

procedure TForm1.KOLForm1MouseUp(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  MouseDown := False;
end;

{ =========== All About Task Scheduler =========== }
{ tTaskType = ttinfo,ttError,ttWarn,ttQuestion,ttCommand,ttShutdown,
              ttHibernate, ttMovingText,ttMultimedia

  Format = See on the FTask }

// 3.08
function TForm1.ReplacePesan(input : string) : string;
var
  s : string;
begin
  s := input;
  StrReplace(s,'%VERSION',Versi);
  Result :=s;
end;  

function TForm1.ParseText(const Text : string) : TTask;
var
  i,n : Integer;
  p : PChar;
  s : string;
begin
  Result.Tipe := ttNone;
  Result.Freq := tfNone;
  Result.Hari := 0;
  Result.Tgl  := 0;

  s := '';
  n := 0 ;
  p := PChar(Text);
  for i:=1 to Length(Text) do
  begin
    if p^ <> '|' then
      s := s + p^
    else
      begin
        case n of
          0 : { Nama } Result.Nama := s ;
          1 : { Tipe }
              begin
                case Str2Int(s) of
                  1 : Result.tipe := ttinfo;
                  2 : Result.tipe := ttError;
                  3 : Result.tipe := ttWarn;
                  4 : Result.tipe := ttQuestion;
                  5 : Result.tipe := ttCommand;
                  6 : Result.tipe := ttShutdown;
                  7 : Result.tipe := ttHibernate;
                  8 : Result.Tipe := ttMovingText;
                  9 : Result.Tipe := ttMultimedia
                else Result.tipe := ttNone;
                end;
              end;
          2 : { Freq }
              begin
                case Str2Int(s) of
                  1 : Result.Freq := tfDaily;
                  2 : Result.Freq := tfWeekly;
                  3 : Result.Freq := tfMonthly;
                  4 : Result.Freq := tfOnce;
                  5 : Result.Freq := tfStart
                  else Result.Freq := tfNone;
                end;
              end;
          3 : { Jam }
              begin
                Result.Jam := Str2TimeFmt(TIME_FMT_3,s);
                Result.JamInStr := Time2StrFmt(TIME_FMT_3,Result.Jam);
              end;
          4 : { Hari }
              Result.Hari := Str2Int(s);
          5 : { Tgl }
              Result.Tgl := Str2Int(s);
          6 : begin
                { Bulan }
                Result.Bulan := Str2Int(s);
                { Pesan }
                Result.Pesan := Copy(Text,i+1,MAXWORD);
                // 3.08
                Result.Pesan := ReplacePesan(Result.Pesan);
                Break;
              end;
        end;
        Inc(n);
        s :='';
      end;
    inc(p);
  end;
  if (Result.Hari > 7 ) then Result.Hari := 0;
  if (Result.Tgl > 31 ) then Result.Tgl := 0;
  if (Result.Bulan > 12 ) then Result.Bulan := 0;
end;

procedure TForm1.LoadTaskToday;
var
  i : Integer;
  Task1 : TTask;
  y,m,d,w : word;
  Task : PStrList;
begin
  TaskTodayCount := -1;
  if not FileExists(AppDataDir+TASK_FILE) then Exit;
  Task := NewStrList;
  Task.LoadFromFile(AppDataDir+TASK_FILE);
  if Task.Count < 1 then
    begin
      Task.Free;
      Exit;
    end;

  DecodeDateFully(Date,y,m,d,w);
//  w := DayOfWeek(date);
  { w = DayOfWeek : 1..7 1=ahad }
  TaskToday := nil;
  SetLength(TaskToday,Task.count);
  for i:=0 to Task.Count-1 do
  begin
    if Pos(';',Task.Items[i]) > 0 then Continue;
    if Trim(Task.items[i]) = '' then Continue;
    Task1 := ParseText(Task.Items[i]);
    if (Task1.Freq = tfDaily) OR  { Daily }
       ((Task1.Freq = tfWeekly ) and (Task1.Hari= w )) or { Weekly   }
       ((Task1.Freq = tfMonthly) and (Task1.Tgl = d )) or { Monthly  }
       ((Task1.Tgl = d) and (Task1.Bulan = m )) or        { OnlyOnce }
       (Task1.Freq = tfStart) then
    begin
      Inc(TaskTodayCount);
      TaskToday[TaskTodayCount] := Task1;
    end;  
  end;
  Task.Free;
end;

procedure TForm1.BtnTaskClick(Sender: PObj);
begin
  if FTask = nil then
  begin
    NewFTask(FTask,Applet);
    FTask.Form.ShowModal;
    FTask.Form.Free;
  end
end;

procedure TForm1.Popup1N8Menu(Sender: PMenu; Item: Integer);
begin
  BtnTaskClick(Sender);
end;

procedure TForm1.Popup1N9Menu(Sender: PMenu; Item: Integer);
begin
  Form.Show;
  BtnScheduleClick(sender);
end;

procedure TForm1.Popup1N10Menu(Sender: PMenu; Item: Integer);
begin
  Form.Show;
  BtnAboutClick(Sender); 
end;

procedure TForm1.Hibernate;
begin
  if IsSuspendMode then SetSuspendMode
  else
     ShowMessage(False,Lang.Items[139],itInfo);
end;

procedure TForm1.Popup1N3Menu(Sender: PMenu; Item: Integer);
begin
  ShowMessage(True,Lang.Items[140],itQuestion);
  if MessageResultOK then
    ShutdownPC;
end;

procedure TForm1.Popup1N11Menu(Sender: PMenu; Item: Integer);
begin
  OpenHelpFile(PopUp1.ItemText[9]);
end;

procedure TForm1.Popup1N12Menu(Sender: PMenu; Item: Integer);
begin
  Form.Show;
  BtnSettingClick(Sender);
end;

procedure TForm1.Popup1N13Menu(Sender: PMenu; Item: Integer);
begin
  Form.Show;
  BtnAreaClick(sender);
end;

procedure TForm1.Popup1N15Menu(Sender: PMenu; Item: Integer);
begin
  Form.Show;
  BtnMessageClick(Sender);
end;

procedure TForm1.ShowKonversi;
begin
  if FConvert = nil then
  begin
    NewFConvert(FConvert,Applet);
    FConvert.Form.ShowModal;
    FConvert.Form.Free;
  end;
end;  

procedure TForm1.Popup1N20Menu(Sender: PMenu; Item: Integer);
begin
  ShowKonversi;
end;

procedure TForm1.OpenHelpFile(Caption : string);
var
  FName : string;
begin
  if pos('help',Caption) > 0 then
    Fname := 'Shollu3en.chm'
  else
    Fname := 'Shollu3id.chm';

  if FileExists(SholluDir+FName) then
  begin
    ShellExecute(Form.Handle,'Open',PChar(SholluDir+FName),
      '','',SW_SHOWMAXIMIZED);
    form.Hide;
  end
  else
    ShowMessage(False,Lang.Items[141],itError);
end;

procedure TForm1.CloseMultimedia;
begin
  Popup1.items[20].Visible := False;
  if Mp = nil then Exit;
  Mp.Stop;
  Free_And_Nil(Mp);
end;

procedure TForm1.Popup1N23Menu(Sender: PMenu; Item: Integer);
begin
  CloseMultimedia;
end;

procedure TForm1.Popup1N22Menu(Sender: PMenu; Item: Integer);
begin
  if Mp = nil then Exit;
  mp.Pause;
end;

procedure TForm1.Popup1N24Menu(Sender: PMenu; Item: Integer);
begin
  if Mp = nil then Exit;
  mp.Play(0,-1);
end;

procedure TForm1.BtnMainPageMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  TKOLBitBtn(Sender).Font.FontStyle := [fsBold];
  // 3.08
  TKOLBitBtn(Sender).Color := cGPMainCol2;
  TKOLBitBtn(Sender).Transparent := False;
end;

procedure TForm1.BtnMainPageMouseLeave(Sender: PObj);
begin
   TKOLBitBtn(Sender).Font.FontStyle := [];
   TKOLBitBtn(Sender).Transparent := True;    // 3.08
end;

procedure TForm1.BtnKonversiClick(Sender: PObj);
begin
  ShowKonversi;
end;

procedure TForm1.ShowFormDropZone;
begin
  if FDropZone = nil then
    NewFDropZone(FDropZone,Applet);
  FDropZone.Form.Show;
end;

procedure TForm1.Popup1N25Menu(Sender: PMenu; Item: Integer);
begin
  if not Form1.Popup1.items[24].Checked then ShowFormDropZone
  else
    if FDropZone <> nil then
    begin
       FDropZone.Form.Hide;
       if FSetting <> nil then
         FSetting.cbDropZone.Checked := False;
    end;
end;

procedure TForm1.UpdateInfoTanggal;
var
  dM,dH : string;
  h,tg,bl,th : WORD;
  Hij : TDate;
begin
  DecodeDateFully(Date,th,bl,tg,h);
  if h = 7 then h := 0;
//  HariIni := Lang.Items[h+7];
  dM := Int2Str(tg)+' '+ NmBulanM[bl]+' '+ Int2Str(th);
  Hij := ConvertDate(False,th,bl,tg);
  th := Hij.Year;
  bl := Hij.Month;
  tg := Hij.Day;
  dH  := Int2Str(tg)+' '+ NmBulanH[bl]+' '+ Int2Str(th)+' H';
  LInfoTgl.Caption := Lang.Items[h+7] + ', '+ dM+ ' ( '+ dH +' )';
end;

procedure TForm1.SaveSetting(NamaFile: String);
var
  Reg  : HKEY;
  ListNames,ListSaved : PStrList;
  i : Integer;
  s : string;
  D : Double;
begin
  Reg := RegKeyOpenRead(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  if Reg <> 0 then
  begin
    ListNames := NewStrList;
    ListSaved := NewStrList;
    RegKeyGetValueNames(Reg,ListNames);

    for i:=0 to Listnames.Count-1 do
    begin
      s := ListNames.Items[i] + '='; 
      if Trim(ListNames.Items[i]) = '' then Continue;
      case RegKeyGetValueTyp(Reg,ListNames.Items[i]) of
        REG_DWORD :
          s := '1'+#9+s+Int2Str(RegKeyGetDw(Reg,ListNames.Items[i]));
        REG_SZ :
          s := '2'+#9+s+RegKeyGetStr(Reg,ListNames.Items[i]);
        REG_BINARY :
          begin
            RegKeyGetBinary(Reg,ListNames.Items[i],D,8);
            s := '3'+#9+s+Double2Str(D);
          end;
      end;
      ListSaved.Add(s);
    end;

    ListSaved.Sort(False);
    ListSaved.SaveToFile(NamaFile);
    ListNames.Free;
    ListSaved.Free;
  end;  
end;

procedure TForm1.LoadSetting(NamaFile : string);
var
  LSetting : PStrList;
  i,t,n : Integer;
  Reg : HKEY;
  s,name,val : string;
  D : Double;
begin
  LSetting := NewStrList;
  LSetting.LoadFromFile(NamaFile);
  if LSetting.Count < 1 then Exit;

  Reg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  if Reg <> 0 then
  begin
    for i:=0 to LSetting.Count-1 do
    begin
      s := LSetting.Items[i];
      s := TrimLeft(s);
      s := TrimRight(s);
      t := Pos(#9,s);
      n := Pos('=',s);
      name := Copy(s,t+1,n-t-1);
      val  := CopyEnd(s,n+1);
      case s[1] of
        '0' : Continue;
        '1' : RegKeySetDw(Reg,name,Str2Int(val));
        '2' : RegKeySetStr(Reg,name,val);
        '3' : begin
                D := Str2Double(val);
                RegKeySetBinary(Reg,name,D,8);
              end; 
      end;

    end;  
  end;
  RegKeyClose(Reg);
  LSetting.Free;

  Form1.ReadRegistry;
  Form1.UpdateData;
  FSetting.UpdateOnShow;
//  ShowMessage(False,'OK... Finish',itInfo)  
end;

function TForm1.KOLForm1Message(var Msg: TMsg;
  var Rslt: Integer): Boolean;
begin
  Result := False;
  if (Msg.message = WM_HOTKEY) and (Msg.wParam=1001) then
  begin
    if Form.Visible then Form.Hide
    else Form.Show;
  end;
end;

procedure TForm1.PBSavedPaint(Sender: PControl; DC: HDC);
begin
   ImageList24.Draw(8,DC,0,0);
end;

procedure TForm1.Timer1Timer(Sender: PObj);
begin
   Inc(pnlSavedCunter);
   if (pnlSavedCunter < 200) and (PnlSavedMsg.Height < 33) then
      PnlSavedMsg.Height := PnlSavedMsg.Height + 1;

   PnlSavedMsg.Color := GetGradientColor2(clWhite,clYellow, pnlSavedCunter/100 );
   if pnlSavedCunter > 200 then  // 2 detik
   begin
      PnlSavedMsg.Height := PnlSavedMsg.Height - 1;
      if PnlSavedMsg.Height = 0 then
      begin
         Timer1.Enabled := False;
         PnlSavedMsg.Visible := false;
         PnlSavedMsg.SendToBack;
      end;      
   end;
end;

procedure TForm1.animeSaved;
begin
   PnlSavedMsg.Height := 0;
   PnlSavedMsg.BringToFront;
   PnlSavedMsg.Visible := true;
   pnlSavedCunter := 0;
   Timer1.Enabled := True;
end;

end.
