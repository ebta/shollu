{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit UDropZone;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls, mckControls, mckObjs, Graphics,
  mckCtrls {$IFEND (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFDropZoneclass.inc} {$ELSE OBJECTS} PFDropZone = ^TFDropZone; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFDropZone.inc}{$ELSE} TFDropZone = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFDropZone = class(TForm)
  {$IFEND KOL_MCK}
    KOLForm1: TKOLForm;
    Linfo: TKOLLabel;
    LInfo2: TKOLLabel;
    GPMain: TKOLGradientPanel;
    Popup1: TKOLPopupMenu;
    Timer1: TKOLTimer;
    procedure KOLForm1MouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure KOLForm1Show(Sender: PObj);
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure LinfoResize(Sender: PObj);
    procedure KOLForm1Hide(Sender: PObj);
    procedure KOLForm1Move(Sender: PObj);
    procedure KOLForm1Close(Sender: PObj; var Accept: Boolean);
    procedure Popup1N5Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N1Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N2Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N3Menu(Sender: PMenu; Item: Integer);
    procedure Popup1N7Menu(Sender: PMenu; Item: Integer);
    function KOLForm1Message(var Msg: TMsg; var Rslt: Integer): Boolean;
    procedure KOLForm1Paint(Sender: PControl; DC: HDC);
    procedure Popup1Popup(Sender: PObj);
    procedure Popup1N13Menu(Sender: PMenu; Item: Integer);
    procedure DoFlashWindow;
    procedure Timer1Timer(Sender: PObj);
  private
    { Private declarations }
    Bmp : PBitmap;
    xDc : HDC;
    TransEnable : Boolean;
    PReg : HKEY;
    flashCounter,flashTime : DWORD;
    //procedure SetRegion;
//    procedure PaintWithBackground;
    procedure UpdateState;
  public
    { Public declarations }
    WindowFlashing : Boolean;
    procedure UpdateColor;
    procedure UpdateLanguage;
    procedure FlashWindow;
  end;

var
  FDropZone {$IFDEF KOL_MCK} : PFDropZone {$ELSE} : TFDropZone {$ENDIF} ;
  Docked: Boolean = False;

{$IFDEF KOL_MCK}
procedure NewFDropZone( var Result: PFDropZone; AParent: PControl );
{$ENDIF}

implementation

uses Shollu, Unit1, USettingpas;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UDropZone_1.inc}
{$ENDIF}

procedure TFDropZone.KOLForm1MouseDown(Sender: PControl;
var Mouse: TMouseEventData);
begin
  ReleaseCapture;
  SendMessage(Form.Handle,WM_SYSCOMMAND,$F012,0);
end;

procedure TFDropZone.KOLForm1Show(Sender: PObj);
var
  x,y : Integer;
begin
  if FSetting <> nil then
     FSetting.cbDropZone.Checked := True;
  Form1.Popup1.items[24].Checked := True;

  UpdateColor;
  x := Str2Int(RegKeyGetStr(PReg,'dzX'));
  y := Str2Int(RegKeyGetStr(PReg,'dzY'));

  if (x > -(Form.Width)) and (x < ScreenWidth) then
    if (y > -(Form.Height)) and (y < ScreenHeight) then
    begin
      Form.Left := x;
      Form.top := y;
    end;

  x := RegKeyGetDw(PReg,'dzAlpha');

  if x > 253 then
    Popup1.Items[9].Checked := true
  else
    if x > 10 then
    begin
      Form.AlphaBlend := x;
      case x of
        76 : Popup1.Items[4].Checked := true;
        102 : Popup1.Items[5].Checked := true;
        127 : Popup1.Items[6].Checked := true;
        153 : Popup1.Items[7].Checked := true;
        178 : Popup1.Items[8].Checked := true;
      end;
    end;
end;

procedure TFDropZone.KOLForm1FormCreate(Sender: PObj);
begin
  Form.Top := 5;
  Linfo.Left := 4;
//  LInfo2.Caption := '--------';
//  LInfo2.Caption := '--------';
  Form.Width :=0;
//  Form.Left := ScreenWidth - Form.Width - 280;

  TransEnable := not isWinVer([wv31,wv95,wv98,wvME]); // Windows95/98/Me
  PReg := RegKeyOpenWrite(HKEY_LOCAL_MACHINE,REG_SHOLLU3);

  Popup1.Items[0].Enabled := TransEnable;
  Popup1.Items[0].Checked := Form1.dzTransparent;
  Popup1.Items[1].Checked := Form1.dzSnap;
  Popup1.Items[2].Checked := Form1.dzRemaining;
  Popup1.Items[3].Enabled := TransEnable and not Form1.dzTransparent;
  
  Updatelanguage;
  UpdateState;
  Bmp := NewBitmap(0,0);
  Form.Caption := 'Shollu '+ VERSI;
end;

procedure TFDropZone.LinfoResize(Sender: PObj);
begin
  LInfo2.Left := Linfo.Left + Linfo.Width + 5;
  Form.Width  := Linfo2.Left + Linfo2.Width + 4;// + btnX.Width;
end;

procedure TFDropZone.KOLForm1Hide(Sender: PObj);
begin
  Form1.Popup1.items[24].Checked := False;
  if FSetting <> nil then
    FSetting.cbDropZone.Checked := False;
end;

procedure TFDropZone.UpdateColor;
begin
  Linfo.Font.Color := cMenuFont;
  LInfo2.Font.Color := cMenuFont;
  Form.Color := cGPMainCol2;
  if not Form1.dzTransparent then
  begin
    GPMain.Color1 := cGPMainCol2 ;
    GPMain.Color2 := cGPMain1Col1;
  end;  
end;

procedure TFDropZone.KOLForm1Move(Sender: PObj);
begin
  if TransEnable and Form1.dzTransparent then Form.Invalidate;

  RegKeyOpenWrite(PReg,'dzX');
  RegKeyOpenWrite(PReg,'dzY');
  RegKeySetStr(PReg,'dzX',Int2Str(Form.Left));
  RegKeySetStr(PReg,'dzY',Int2Str(Form.Top));
end;

procedure TFDropZone.KOLForm1Close(Sender: PObj; var Accept: Boolean);
begin
  Bmp.Free;
end;

procedure TFDropZone.Popup1N5Menu(Sender: PMenu; Item: Integer);
begin
  FDropZone.Form.Hide;
end;

procedure TFDropZone.Updatelanguage;
begin
  Popup1.Items[2].Caption := Lang.Items[226];
  Popup1.Items[11].Caption := Lang.Items[84];
end;

procedure TFDropZone.Popup1N1Menu(Sender: PMenu; Item: Integer);
begin
  { Transparent }
  Popup1.Items[0].Checked := not Popup1.Items[0].Checked;
  if Popup1.Items[0].Checked then
    RegKeySetDw(PReg,'dzTransparent',1)
  else
    RegKeySetDw(PReg,'dzTransparent',0);

  Form1.dzTransparent := Popup1.Items[0].Checked;
  Popup1.Items[3].Enabled := TransEnable and not Form1.dzTransparent;

  UpdateState;
  UpdateColor;
end;

procedure TFDropZone.Popup1N2Menu(Sender: PMenu; Item: Integer);
begin
  { Snap }
  Popup1.Items[1].Checked := not Popup1.Items[1].Checked;
  if Popup1.Items[1].Checked then
    RegKeySetDw(PReg,'dzSnap',1)
  else
    RegKeySetDw(PReg,'dzSnap',0);
  Form1.dzSnap := Popup1.Items[1].Checked;
end;

procedure TFDropZone.Popup1N3Menu(Sender: PMenu; Item: Integer);
begin
  { Remaining Time }
  Popup1.Items[2].Checked := not Popup1.Items[2].Checked;
  if Popup1.Items[2].Checked then
    RegKeySetDw(PReg,'dzRemaining',1)
  else
    RegKeySetDw(PReg,'dzRemaining',0);
  Form1.dzRemaining := Popup1.Items[2].Checked;
  if not Form1.dzRemaining then LInfo2.Caption :=''; 
end;

procedure TFDropZone.UpdateState;
begin
  if not Form1.dzTransparent then
    begin
      Form.AlphaBlend := 255;
      GPMain.Visible := True;
      Linfo.Parent := GPMain;
      Linfo2.Parent := GPMain;
      Linfo.Transparent := True;
      Linfo2.Transparent := True;
      Form.Height :=  form.canvas.TextHeight(Linfo.Caption) + 4;
      Linfo.Top  := 2;
      Linfo2.Top := 2;
    end
  else
    begin
      GPMain.Visible := False;
      Linfo.Parent := Form;
      Linfo2.Parent := Form;
      Form.Height :=  form.canvas.TextHeight(Linfo.Caption);
      Linfo.Top  := 0;
      Linfo2.Top := 0;
      Form.AlphaBlend := RegKeyGetDw(PReg,'dzAlpha');
    end;  
end;

procedure TFDropZone.Popup1N7Menu(Sender: PMenu; Item: Integer);
var
  s : string;
  Alpha : Byte;
begin
  if Item < 9 then
  begin
    s := Sender.ItemText[Item];
    StrReplace(s,'%','');
    Alpha :=  (255 * Str2Int(s)) div 100;
  end
  else Alpha := 254;

  Form.AlphaBlend := Alpha;
  RegKeyOpenWrite(PReg,'dzAlpha');
  RegKeySetDw(PReg,'dzAlpha',Alpha);
end;

function TFDropZone.KOLForm1Message(var Msg: TMsg;
  var Rslt: Integer): Boolean;
var
  rWorkArea: TRect;
  StickAt: Word;
begin
    Result := False;
    if Form1.dzSnap and (msg.message = WM_WINDOWPOSCHANGING) then
    begin
      StickAt := 20;
      SystemParametersInfo(SPI_GETWORKAREA, 0, @rWorkArea, 0);
      with PWindowPos(Msg.lParam)^ do
      begin
        if x <= rWorkArea.Left + StickAt then
          begin
            x := rWorkArea.Left;
            Docked := True;
          end;
        if x + cx >= rWorkArea.Right - StickAt then
          begin
            x := rWorkArea.Right - cx;
            Docked := True;
          end;
        if y <= rWorkArea.Top + StickAt then
          begin
            y := rWorkArea.Top;
            Docked := True;
          end;
        if y + cy >= rWorkArea.Bottom - StickAt then
          begin
            y := rWorkArea.Bottom - cy;
            Docked := True;
          end;
        if Docked then
        begin
          with rWorkArea do
          begin
            // no moving out of the screen
            if x < Left then
              x := Left;
            if x + cx > Right then
              x := Right - cx;
            if y < Top then
              y := Top ;
            if y + cy > Bottom then
              y := Bottom - cy;
          end;
        end;
      end;
     Result := true;
     end;

end;

procedure TFDropZone.KOLForm1Paint(Sender: PControl; DC: HDC);
begin
  if TransEnable and Form1.dzTransparent then
  begin
    Bmp.Width := form.Width;
    Bmp.Height := form.Height;
    xDc := GetDC(0);
    BitBlt(bmp.canvas.Handle, 0, 0,form.Width,form.Height,
           xDc,form.Left,form.Top,SRCCOPY);
    Bmp.Draw(Form.canvas.Handle,0,0);
    ReleaseDC(form.Handle,xDc);
  End;
end;

procedure TFDropZone.Popup1Popup(Sender: PObj);
begin
  if Form1.Form.Visible then
    PopUp1.Items[13].Caption := Lang.Items[143]
  else
    PopUp1.Items[13].Caption := Lang.Items[142];
end;

procedure TFDropZone.Popup1N13Menu(Sender: PMenu; Item: Integer);
begin
  if Form1.Form.Visible = False then
    Form1.Form.Show
  else
    Form1.Form.Hide;
end;

procedure TFDropZone.DoFlashWindow;
begin
  if  flashCounter mod 2 = 0 then
  begin
    Linfo.Font.Color := clWhite;
    LInfo2.Font.Color := clWhite;
    Form.Color := clWhite;
    GPMain.Color1 := clRed;
    GPMain.Color2 := clRed;
  end
  else
  begin
    if Popup1.Items[0].Checked then
    begin
      Linfo.Font.Color := clRed;
      LInfo2.Font.Color := clRed;
    end
    else
      UpdateColor;
  end;
end;

procedure TFDropZone.Timer1Timer(Sender: PObj);
begin
  Inc(flashCounter);
  DoFlashWindow;
  if flashCounter = flashTime then  // 120 detik
  begin
    UpdateColor;
    WindowFlashing := False;
    Timer1.Enabled := False;
  end;
end;

procedure TFDropZone.FlashWindow;
begin
   flashTime := RegKeyGetDw(PReg,'FlashTime');
   if flashTime = 0 then
      flashTime := 360   // default 360/2= 180 (3 menit) 
   else
      flashTime := flashTime * 2;
      
   WindowFlashing := True;
   Timer1.Enabled := True;
   flashCounter := 0;
   DoFlashWindow;
end;

end.






