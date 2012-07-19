{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit UBar;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls,
  mckControls, mckObjs, Graphics,  mckCtrls {$IFEND (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mirror;
{$ENDIF}

{type
  PHack = ^THack;
  THack = object(TControl)end;      }

type
  TBarPosition = (BpTop,BpCenter,BpBottom);
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFBarclass.inc} {$ELSE OBJECTS} PFBar = ^TFBar; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFBar.inc}{$ELSE} TFBar = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFBar = class(TForm)
  {$IFEND KOL_MCK}
    KOLForm1: TKOLForm;
    PanelTop: TKOLPanel;
    TimerText: TKOLTimer;
    LText: TKOLLabel;
    PopupBar: TKOLPopupMenu;
    TimerShow: TKOLTimer;
    LText2: TKOLLabel;
    procedure TimerTextTimer(Sender: PObj);
    procedure PopupBarN1Menu(Sender: PMenu; Item: Integer);
    procedure KOLForm1Show(Sender: PObj);
    procedure TimerShowTimer(Sender: PObj);
    procedure PanelTopPaint(Sender: PControl; DC: HDC);
    procedure KOLForm1Close(Sender: PObj; var Accept: Boolean);
    procedure KOLForm1FormCreate(Sender: PObj);
    function KOLForm1Message(var Msg: TMsg; var Rslt: Integer): Boolean;
  private
    { Private declarations }
    waktu,speed : Integer;
    Tampil : Boolean;
    Posisi : TBarPosition;
    Preg : HKEY;
    //v3.05
    x1,x2 : Integer;
    H  : HRGN;
   //  procedure ReCreateWindow(aControl : PControl);
  public
    { Public declarations }
    procedure ReadRegistry;
  end;

var
  FBar {$IFDEF KOL_MCK} : PFBar {$ELSE} : TFBar {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFBar( var Result: PFBar; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, Shollu;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UBar_1.inc}
{$ENDIF}
                      

// Get Taksbar Rect
function GetTaskBarSize: TRect;
var
  wnd: HWND;
begin
  wnd := FindWindow('Shell_TrayWnd', nil);
  if wnd > 0 then
    GetWindowRect(wnd, Result)
  else
    Result := MakeRect(0, 0, 0, 0);
end;

procedure TFBar.TimerTextTimer(Sender: PObj);
begin
  Inc(waktu);
  if waktu >= (50*1000 / speed)  then  { 50 detik - 20 is timer interval-}
  begin
    Tampil := False;
  end;
  
  LText.Left := LText.Left  - 1;
  if LText.Left <= -(LText.Width) then
    if LText2.Left > Form.Width - LText2.Width then
      LText.Left := Ltext2.Width + Ltext2.Left+20
    else
      LText.Left := form.Width;// Ltext2.Left + Ltext.Width +20;

  LText2.Left := LText2.Left  - 1;
  if LText2.Left <= -(LText2.Width) then
    if LText.Left > Form.Width - LText.Width then
      LText2.Left :=  Ltext.Width + Ltext.Left+ 20
    else
      LText2.Left :=  Form.Width;
end;

procedure TFBar.PopupBarN1Menu(Sender: PMenu; Item: Integer);
begin
  Tampil := False;
  TimerShow.Enabled := true;
end;

procedure TFBar.KOLForm1Show(Sender: PObj);
//var
//  Alpha : Byte;
begin
  waktu :=0;
  PopupBar.Items[0].Caption := Lang.Items[84];
  TimerShow.Interval := 40;

//  LText2.Caption := '['+ Form1.Area+'] '+ Form1.LTglM.Caption +' / ' +
//                    Form1.LTglH.Caption+' [Shollu '+versi+']';
  PanelTop.Color := cBorder1;
  LText.Font.Color := cTitleFont;
  LText2.Font.Color := cTitleFont;
  LText.Left := Form.Width;
  LText2.Left := (Form.Width - Ltext2.Width) div 2;
  Tampil := True;
  TimerShow.Enabled := True;

  // 3.07
//  Alpha := RegKeyGetDw(Preg,'BarAlpha');
//  Form.AlphaBlend := Alpha;
end;

procedure TFBar.TimerShowTimer(Sender: PObj);
  procedure HideForm;
  begin
    form.Hide;
    TimerText.Enabled := false;
    TimerShow.Enabled := false;
  end;

  Procedure ReadReg;
  var
    i : integer;
  begin
    i := RegKeyGetDw(Preg,'BarWidth');
    if (i>100) or (i<10) then i:=100;
    Form.Width := Round(ScreenWidth * i div 100 );
    Form.Left := (ScreenWidth - form.Width) div 2;
  end;
begin
  if (Posisi = BpCenter)  or (Posisi = BPBottom) then
  begin
    if Posisi = BpBottom then
      begin
        if form.Top < (ScreenHeight-60) then
        begin
          readReg;
          form.Top := ScreenHeight-48;
        end
      end
    else
    if posisi = BpCenter then
      if  form.top <> (ScreenHeight div 2 - Form.Height div 2) then
      begin
        readReg;
        form.top := ScreenHeight div 2 - Form.Height div 2;
      end;

    if Tampil then
      if x2-x1 < Form.Height then
        begin
          x1 := x1 -1;
          x2 := x2 +1;
          H := CreateRectRgn(Form.left,x1,form.Width,x2);
          SetWindowRgn(Form.Handle,H,True);
        end
      else
      begin
        TimerText.Enabled := True;
      end
    else // if Closed
      begin
        if x2 <= x1 then HideForm;
        x1 := x1 + 1;
        x2 := x2 - 1;
        H := CreateRectRgn(Form.left,x1,form.Width,x2);
        SetWindowRgn(Form.Handle,H,True);
      end
  end
  
  else
  if Posisi = BpTop then
  begin
    if Tampil then
      begin
        if Form.Top > 1 then
          Form.Top := -21
        else
         if Form.Top < 0 then
           Form.Top := Form.Top + 1
         else
         begin
           TimerText.Enabled := True;
         end;
      end
    else
      begin
        if Form.Top > -PanelTop.Height then
          Form.Top := Form.Top -1;
        if Form.Top = -PanelTop.Height then
        begin
          Form.Top := - panelTop.Height;
          HideForm;
        end;
     end;
  end;
end;

procedure TFBar.PanelTopPaint(Sender: PControl; DC: HDC);
begin
  PanelTop.Canvas.Brush.Color := cBorder1;
  PanelTop.Canvas.Rectangle(0,-1,Sender.Width,sender.Height);
end;

procedure TFBar.KOLForm1Close(Sender: PObj; var Accept: Boolean);
begin
  DeleteObject(H);
  RegKeyClose(Preg);
end;

procedure TFBar.KOLForm1FormCreate(Sender: PObj);
begin
  Preg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  Form.top := 0;
  ReadRegistry;
  speed := 20;
  ShowWindow(FBar.Form.Handle,SW_SHOWNA);// or SW_SHOWNOACTIVATE);
  Form.Caption := 'Shollu '+ VERSI;
end;

procedure TFBar.ReadRegistry;
var
  i:Integer;
  R :TRect;
begin
  i := RegKeyGetDw(Preg,'BarWidth');
  if (i>100) or (i<10) then i:=100;
  Form.Height := 21;
  Form.Width := Round(ScreenWidth * i div 100 );
  Form.Left := (ScreenWidth - form.Width) div 2;

  i := RegKeyGetDw(Preg,'BarMotion');
  if (i > 4) or (i < 0) then i:=2;
  case i of
    0 : TimerText.Interval := 10;
    1 : TimerText.Interval := 20;
    2 : TimerText.Interval := 30;
    3 : TimerText.Interval := 40;
    4 : TimerText.Interval := 50;
  end;
  speed := Timertext.Interval;

  i := RegKeyGetDw(Preg,'BarPosition');
  if (i<0) or (i>2) then i:=0;
  case i of
  0 : begin    // Top
        Posisi := BpTop;
        Form.Top := -21;
        H := CreateRectRgn(0,0,form.Width,form.Height);
        SetWindowRgn(Form.Handle,H,True);
      end;

  1,2 : begin // Center
          x1 := 10;
          x2 := 10;
          H := CreateRectRgn(0,0,0,0);
          SetWindowRgn(Form.Handle,H,True);

          if i = 1 then
          begin
            Posisi := BpCenter;
            Form.Top := ScreenHeight div 2 - Form.Height div 2;
          end
          else
          begin
            R := GetTaskBarSize;
            Posisi := BpBottom;
            Form.Top := ScreenHeight - (R.bottom-R.Top+18);
           end;
      end;
  end;
end;

function TFBar.KOLForm1Message(var Msg: TMsg;
  var Rslt: Integer): Boolean;
begin
   Result := false;
{   case msg.message of
     WM_ACTIVATEAPP:
       begin
{       hwdPrev := GetWindow(Applet.handle,GW_HWNDPREV);
         hwdPrev := GetNextWindow(Applet.handle, GW_HWNDNEXT);
         ShowWindow(hwdPrev,SW_MAXIMIZE); }
 {       keybd_event( VK_MENU, MapVirtualkey( VK_MENU, 0 ), 0, 0);
         keybd_event( VK_TAB, MapVirtualKey( VK_TAB,0), 0, 0);
         keybd_event( VK_TAB, MapVirtualKey( VK_TAB,0), KEYEVENTF_KEYUP, 0);
         keybd_event( VK_MENU, MapVirtualkey( VK_MENU, 0 ), KEYEVENTF_KEYUP,0);
 //   end;
  end;     }
end;

end.






