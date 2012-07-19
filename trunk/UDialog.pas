{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
{$DEFINE USE_GRAPHCTLS}
unit UDialog;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls, mckControls, mckObjs, Graphics,  mckCtrls {$IFEND (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mirror;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFDialogclass.inc} {$ELSE OBJECTS} PFDialog = ^TFDialog; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFDialog.inc}{$ELSE} TFDialog = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFDialog = class(TForm)
  {$IFEND KOL_MCK}
    KOLForm1: TKOLForm;
    PanelTop: TKOLPanel;
    LblCaption: TKOLLabel;
    PBIcon: TKOLPaintBox;
    GPBottom: TKOLGradientPanel;
    Btn1: TKOLBitBtn;
    Btn2: TKOLBitBtn;
    LblCR: TKOLLabel;
    ImgIcon: TKOLImageShow;
    LTitle: TKOLLabel;
    TimerBlend: TKOLTimer;
    TimerEffect: TKOLTimer;
    LInfo: TKOLLabel;
    TimerAutoClose: TKOLTimer;
    procedure PanelTopMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure PanelTopPaint(Sender: PControl; DC: HDC);
    procedure KOLForm1Paint(Sender: PControl; DC: HDC);
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure PBIconPaint(Sender: PControl; DC: HDC);
    procedure Btn1Click(Sender: PObj);
    procedure Btn2Click(Sender: PObj);
    procedure ImgIconMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure KOLForm1Show(Sender: PObj);
    procedure ImgIconMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure ImgIconMouseLeave(Sender: PObj);
    procedure ImgIconMouseUp(Sender: PControl; var Mouse: TMouseEventData);
    procedure KOLForm1Destroy(Sender: PObj);
    procedure KOLForm1KeyUp(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure TimerBlendTimer(Sender: PObj);
    procedure KOLForm1Close(Sender: PObj; var Accept: Boolean);
    procedure TimerEffectTimer(Sender: PObj);
    procedure Btn2KeyUp(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure Btn1KeyUp(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure TimerAutoCloseTimer(Sender: PObj);
  private
    { Private declarations }
    // v3.05
    H1,H2 : HRGN;
    cx,cy,x1,x2,y1,y2,x3,y3    : Integer;
    FinishRgn : Boolean;
    // -----
    BmpIcon : PBitmap;
    MouseDown : Boolean;
    Alpha : Byte;
    Waktu : integer;
    Preg  : HKEY;
    iAutoClose : Integer;
    procedure SetWindowDefault;
  public
    { Public declarations }
  end;

var
  FDialog {$IFDEF KOL_MCK} : PFDialog {$ELSE} : TFDialog {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFDialog( var Result: PFDialog; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, Shollu, UBar;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UDialog_1.inc}
{$ENDIF}

procedure TFDialog.PanelTopMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  ReleaseCapture;
  SendMessage(form.Handle,WM_SYSCOMMAND,$F012,0);
end;

procedure TFDialog.PanelTopPaint(Sender: PControl; DC: HDC);
begin
  Form1.PaintTop(PanelTop);
end;

procedure TFDialog.KOLForm1Paint(Sender: PControl; DC: HDC);
begin
  Form1.PaintForm(Form);
end;

procedure TFDialog.KOLForm1FormCreate(Sender: PObj);
var
  R1 : HRGN;
  sIcon : string;
begin
  PReg := RegKeyOpenRead(HKEY_LOCAL_MACHINE,REG_SHOLLU3);
  if RegKeyGetDw(PReg,'UseAlphaBlend') = 1 then
    form.AlphaBlend := 55;
  
  R1 := CreateRoundRectRgn(0,0,Form.Width+1,form.Height+14,13,13);
  try
    SetWindowRgn(form.Handle,R1,True);
  finally
    DeleteObject(R1);
  end;

  LblCaption.Caption := Form1.DlgCaption;
  LblCaption.WordWrap := True;
  LblCaption.Font.Color := cMainFont;

  LInfo.Font.Color := cMainFont;
 // LInfo.Color2 := cBorder2;
  Btn1.Font.Color := cMainFont;
  Btn2.Font.Color := cMainFont;
  LTitle.Caption := 'Shollu '+versi;
  LTitle.Font.Color := cTitleFont;// cGPMainCol2;

  LblCR.Caption := 'Shollu ' +Versi +' copyright ©2012 by Ebta Setiawan';
  LblCR.Transparent := True;
  LblCR.Font.Color := cBorder2;

  GPBottom.Left :=3;
  GPBottom.Top := Form.Height - GPBottom.Height - 3;
  GPBottom.Width := Form.Width - 6;
  GPBottom.Color1 := cForm;
  if IndexColor > 20 then
    GPBottom.Color2 := cForm
  else
    GPBottom.Color2 := cGPMain1Col1;

{  GPLeft.Color1 := cForm;
  GPLeft.Color2 := cBorder2;   }
  Form.Color := cForm;

  case Form1.Icon of
    itInfo :
      begin
       sIcon := 'information';
       LInfo.Caption := Lang.Items[165];
      end;
    itWarn :
      begin
        sIcon := 'warning';
        LInfo.Caption := Lang.Items[166];
      end;
    itQuestion :
      begin
        sIcon := 'question';
        LInfo.Caption := Lang.Items[167];
      end;
    itError :
      begin
        sIcon := 'error';
        LInfo.Caption := Lang.Items[168];
      end;
  end;
  BmpIcon := NewBitmap(0,0);
  BmpIcon.LoadFromResourceName(HInstance,PChar(sIcon));

  if not Message2Button then
  begin
    Btn2.Visible := False;
    Btn1.Left := (Form.Width-Btn1.Width) div 2;
  end;

  Btn1.Caption := Lang.Items[44];  // OK
  Btn2.Caption := Lang.Items[46];  // Cancel

  iAutoClose := 0;
end;

procedure TFDialog.PBIconPaint(Sender: PControl; DC: HDC);
begin
  if BmpIcon <> nil then
    BmpIcon.Draw(DC,0,0);

end;

procedure TFDialog.Btn1Click(Sender: PObj);
begin
  // Disebabkan Alpha Blend FBar < 255 maka FDialog tidak bisa di close
  if FBar <> nil then FBar.Form.Hide;
  MessageResultOK := True;
  Form.Close;
end;

procedure TFDialog.Btn2Click(Sender: PObj);
begin
  if FBar <> nil then FBar.Form.Hide;
  Form1.EffectNow := false;
  MessageResultOK := False;
  Form.Close;
end;

procedure TFDialog.ImgIconMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  MouseDown := True;
  ImgIcon.CurIndex := 8;
end;

procedure TFDialog.KOLForm1Show(Sender: PObj);
begin
  MouseDown := False;
  if not Form1.EffectNow then
    Form1.DialogEffect := RegKeyGetDw(Preg,'DialogEffect');

  if (Form1.DialogEffect<0) or (Form1.DialogEffect > MAX_EFFECT+1) then
    Form1.DialogEffect := 0;

  if Form1.DialogEffect = 0 then
  begin
    Randomize;
    Form1.DialogEffect := random(MAX_EFFECT)+2;
  end;

  FinishRgn := false;
  cx := form.Width div 2;
  cy := form.Height div 2;
  case Form1.DialogEffect of
    1 : TimerEffect.Enabled := false;
    // From center grow up and bottom
    2 : begin
          y1 := cy ;
          y2 := y1;
          x1 := 0;
          x2 := form.Width;
        end;
    // From Center grow left and right
    3 : begin
          y1 := 0 ;
          y2 := form.Height;
          x1 := cx;
          x2 := x1 ;
        end;
    // Grow from Center
    4,6,7,8 : begin
          y1 := cy;
          y2 := y1 ;
          x1 := cx;
          x2 := x1 ;
        end;
    5 : begin
          x1 := cx;
          y1 := cy;
          x2 := 0;
          y2 := y1;
          x3 := x1;
          y3 := 0;
        end;  
  end;

  if Form1.DialogEffect > 1 then
  begin
    H1 := CreateRectRgn(0,0,1,1);
    SetWindowRgn(form.Handle,H1,True);
    DeleteObject(H1);
    TimerEffect.Enabled := True;
  end;                                 

  if RegKeyGetDw(PReg,'UseAlphaBlend') = 1 then
  begin
    Alpha := 55;
    Waktu := 0;
    TimerBlend.Enabled := True;
  end;
  if Btn2.Visible then Btn2.Focused := True
  else Btn1.Focused := True;
end;

procedure TFDialog.ImgIconMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  if MouseDown then
  ImgIcon.CurIndex := 8;
end;

procedure TFDialog.ImgIconMouseLeave(Sender: PObj);
begin
  ImgIcon.CurIndex := 7;
end;

procedure TFDialog.ImgIconMouseUp(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  MessageResultOK := False;
  Form.Close;
end;

procedure TFDialog.KOLForm1Destroy(Sender: PObj);
begin
  FDialog := nil;
end;

procedure TFDialog.KOLForm1KeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  if key=VK_RETURN then
   if not Message2Button then
      Form.close; 
end;

procedure TFDialog.TimerBlendTimer(Sender: PObj);
begin
  inc(waktu);
  if Alpha < 255 then
    begin
      Alpha := Alpha + 5;
      Form.AlphaBlend := Alpha;
    end;
  if waktu = 1000 then
  begin
    TimerBlend.Enabled := false;
    MessageResultOK := False;
  Form.Close;
  end;
end;

procedure TFDialog.KOLForm1Close(Sender: PObj; var Accept: Boolean);
begin
  RegKeyClose(Preg);
  Form1.EffectNow := False;
end;

procedure TFDialog.SetWindowDefault;
var
  HDef : HRGN;
begin
  HDef := CreateRoundRectRgn(0,0,form.Width+1,form.Height+14,13,13);
  SetWindowRgn(Form.handle,HDef,True);
  TimerEffect.Enabled := false;
  DeleteObject(HDef);
end;

procedure TFDialog.TimerEffectTimer(Sender: PObj);
var
  P1,P2,P3,P4 : array[0..3] of TPoint;
begin
  case Form1.DialogEffect of
  2 : begin
        y1 := y1 - 3;
        y2 := y2 + 3;
        H1 := CreateRectRgn(x1,y1,x2,y2);
        FinishRgn := y2-y1 > form.Height;
      end;
  3 : begin
        x1 := x1 - 3;
        x2 := x2 + 3;
        H1 := CreateRectRgn(x1,y1,x2,y2);
        FinishRgn := x2-x1 > form.Width
      end;
  4,6,7,8 : begin
            FinishRgn := (x2-x1) > (form.Width + 100 );
            x1 := x1 - 3; y1 := y1-2;
            x2 := x2 + 3; y2 := y2+2;
            case Form1.DialogEffect of
              4 : H1 := CreateRectRgn(x1,y1,x2,y2);
              6 : H1 := CreateEllipticRgn(x1,y1,x2,y2);
              7 : begin
                    H1 := CreateRectRgn(0,0,form.Width,form.Height);
                    H2 := CreateEllipticRgn(cx-x1-100,cy-y1-50,
                                            cx+ form.Width-x2+100,
                                            cy+ form.Height-y2+50);
                    CombineRgn(H1,H1,H2,RGN_DIFF);
                    DeleteObject(H2);
                  end;
              8 : begin
                    H1 := CreateEllipticRgn(x1-form.Width-cx,y1-cy,x2-cx,y2+cy);
                    H2 := CreateEllipticRgn(x1+cx,y1-cy,x2+cx+form.Width,y2+cy);
                    CombineRgn(H1,H1,H2,RGN_OR);
                    DeleteObject(H2);
                  end;  
            end;

        end;
  5 : begin
        { x1 and y1 as a center, do not change }
        FinishRgn := (x2>x1) and (x3>form.Width);
        y2 := y2 - 4;
        P1[0] := MakePoint(x1,y1);
        P1[1] := MakePoint(0,y1);
        P3[0] := P1[0];
        P3[1] := MakePoint(form.Width,y1);
        if y2 <= 0 then
          begin
            x2 := x2 + 4;
            P1[2] := MakePoint(0,0);
            P1[3] := MakePoint(x2,0);

            P3[2] := MakePoint(Form.Width,Form.Height);
            P3[3] := MakePoint(x1+x1-x2,form.Height);
          end
        else
          begin
            P1[2] := MakePoint(0,y2);
            P1[3] := P1[2];
            P3[2] := MakePoint(form.Width,y1+y1-y2);
            P3[3] := P3[2];
          end;

        x3 := x3+4;
        P2[0] := P1[0];
        P2[1] := MakePoint(x1,0);
        P4[0] := P1[0];
        P4[1] := MakePoint(x1,form.Height);
        if x3 >= form.Width then
          begin
            y3 := y3+4;
            P2[2] := MakePoint(form.Width,0);
            P2[3] := MakePoint(form.Width,y3);

            P4[2] := MakePoint(0,form.Height);
            P4[3] := MakePoint(0,y1+y1-y3);
          end
        else
          begin
            P2[2] := MakePoint(x3,0);
            P2[3] := P2[2];

            P4[2] := MakePoint(x1+x1-x3,form.Height);
            P4[3] := P4[2];
          end;

        H1 := CreateRectRgn(0,0,0,0);
        H2 := CreatePolygonRgn(P1,4,WINDING);
        CombineRgn(H1,H1,H2,RGN_OR);
        DeleteObject(H2);
        H2 := CreatePolygonRgn(P3,4,WINDING);
        CombineRgn(H1,H1,H2,RGN_OR);
        DeleteObject(H2);
        H2 := CreatePolygonRgn(P2,4,WINDING);
        CombineRgn(H1,H1,H2,RGN_OR);
        DeleteObject(H2);
        H2 := CreatePolygonRgn(P4,4,WINDING);
        CombineRgn(H1,H1,H2,RGN_OR);
        DeleteObject(H2);
      end;
  end;
  
  if FinishRgn then SetWindowDefault
  else
    SetWindowRgn(Form.Handle,H1,True);
  DeleteObject(H1);

  Form.Invalidate;
end;

procedure TFDialog.Btn2KeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  case Key of
   VK_TAB,VK_LEFT,VK_RIGHT : Btn1.Focused := True;
   VK_RETURN : Btn1Click(sender);
  end;
end;

procedure TFDialog.Btn1KeyUp(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  case Key of
   VK_TAB,VK_LEFT,VK_RIGHT : Btn2.Focused := True;
   VK_RETURN : Btn1Click(sender);
  end;
end;

procedure TFDialog.TimerAutoCloseTimer(Sender: PObj);
begin
  Inc(iAutoClose);
  if iAutoClose = 50 then
    Form.Close;
end;

end.





