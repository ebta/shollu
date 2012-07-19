{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit UMainPage;

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
  {$IFDEF KOLCLASSES} {$I TFMainPageclass.inc} {$ELSE OBJECTS} PFMainPage = ^TFMainPage; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFMainPage.inc}{$ELSE} TFMainPage = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFMainPage = class(TForm)
  {$IFEND KOL_MCK}
    KOLFrame1: TKOLFrame;
    LSh1: TKOLLabel;
    LSh2: TKOLLabel;
    LSh3: TKOLLabel;
    LSh4: TKOLLabel;
    LSh5: TKOLLabel;
    LSh6: TKOLLabel;
    LTm1: TKOLLabel;
    LTm2: TKOLLabel;
    LTm3: TKOLLabel;
    LTm4: TKOLLabel;
    LTm5: TKOLLabel;
    LTm6: TKOLLabel;
    LTm01: TKOLLabel;
    LTm02: TKOLLabel;
    LTm03: TKOLLabel;
    LTm04: TKOLLabel;
    LTm05: TKOLLabel;
    LTm06: TKOLLabel;
    LTm21: TKOLLabel;
    LTm22: TKOLLabel;
    LTm23: TKOLLabel;
    LTm24: TKOLLabel;
    LTm25: TKOLLabel;
    LTm26: TKOLLabel;
    LYest: TKOLLabel;
    LToday: TKOLLabel;
    LTom: TKOLLabel;
    GroupBox1: TKOLGroupBox;
    LNama: TKOLLabel;
    Linfo1: TKOLLabel;
    Linfo2: TKOLLabel;
    Linfo3: TKOLLabel;
    Linfo4: TKOLLabel;
    Linfo5: TKOLLabel;
    Linfo6: TKOLLabel;
    LLat: TKOLLabel;
    LLong: TKOLLabel;
    LAlt: TKOLLabel;
    LTZ: TKOLLabel;
    LOrg: TKOLLabel;
    LFiqh: TKOLLabel;
    LQibla: TKOLLabel;
    procedure KOLFrame1FormCreate(Sender: PObj);
    procedure KOLFrame1Show(Sender: PObj);
    procedure KOLFrame1Destroy(Sender: PObj);
    procedure KOLFrame1Hide(Sender: PObj);
    procedure GroupBox1Paint(Sender: PControl; DC: HDC);
  private
    { Private declarations }
    KiblatBmp : PBitmap;
    Angle : Double;
    procedure UpdateLanguage;
  public
    { Public declarations }
    procedure UpdateSkin;
    procedure MakeKiblatBmp;
  end;
const
  MLONG = 39.823333;
  MLAT  = 21.42333;
var
  FMainPage {$IFDEF KOL_MCK} : PFMainPage {$ELSE} : TFMainPage {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFMainPage( var Result: PFMainPage; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, Shollu;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UMainPage_1.inc}
{$ENDIF}

procedure TFMainPage.KOLFrame1FormCreate(Sender: PObj);
begin
  with Form1^ do
  begin
    LTitleInfo.Caption := Lang.Items[14];
    UpdateData;
  end;
end;

procedure TFMainPage.UpdateSkin;
var
  C : TColor;
begin
  if cForm = clGray then
  begin
    C := clMedGray;
  end
  else
     C := cGPMain1Col1;

  LTm02.Color := C;
  LTm04.Color := C;
  LTm06.Color := C;

  LSh2.Color := C;
  LTm2.Color := C;
  LSh4.Color := C;
  LTm4.Color := C;
  LSh6.Color := C;
  LTm6.Color := C;

  LTm22.Color := C;
  LTm24.Color := C;
  LTm26.Color := C;
  GroupBox1.Color := cForm;
  Form.Color := cForm;
end;

procedure TFMainPage.KOLFrame1Show(Sender: PObj);
begin
  UpdateSkin;
  UpdateLanguage;
  MakeKiblatBmp;
end;

procedure TFMainPage.UpdateLanguage;
begin
  LSh1.Caption := Lang.Items[1];
  LSh2.Caption := Lang.Items[2];
  LSh3.Caption := Lang.Items[3];
  LSh4.Caption := Lang.Items[4];
  LSh5.Caption := Lang.Items[5];
  LSh6.Caption := Lang.Items[6];

  LNama.Caption := Lang.Items[59]+' '+Form1.Area;
  Linfo1.Caption := Lang.Items[38];
  Linfo2.Caption := Lang.Items[39];
  Linfo3.Caption := Lang.Items[40];
  Linfo4.Caption := Lang.Items[41];
  // Linfo5.Caption := Lang.Items[42];
  Linfo5.Caption := Lang.items[202] + ' : '+ LOrg.Caption;
  // Linfo6.Caption := Lang.Items[43];
  Linfo6.Caption := Lang.Items[73];

  LYest.Caption := Lang.Items[56];
  LToday.Caption := Lang.Items[57];
  LTom.Caption := Lang.Items[58];

  LQibla.Caption := Lang.Items[206];
end;

procedure TFMainPage.KOLFrame1Destroy(Sender: PObj);
begin
  if not AppletTerminated then
  FMainPage := nil;
end;

function QiblaAngle(lat,Long : Single) : Single;
var
   x1,y1,y2 : Single;
begin
   x1 := sin((-Long+MLONG)*Pi/180);
   y1 := cos(lat*Pi/180) * tan(MLAT*Pi/180);
   y2 := sin(lat*pi/180) * cos((-long+MLONG)*pi/180);
   Result := ArcTan(x1/(y1-y2))*180/pi;
   if Result <0 then Result := 360 + Result;
end;

Procedure TFMainPage.MakeKiblatBmp;
var
  x1,y1 : Integer;
  tmp : single;
  Lon,Lat : double;
const
  x = 50;
  y = 50;
begin
  Lon := Str2Double(Form1.Longitude);
  Lat := Str2Double(Form1.Latitude);
  Angle := QiblaAngle(Lat,Lon);

  { West or East from Mecca, the limit is MLONG-180}
  if (Lon < MLONG) and (Lon > (MLONG-180)) then
    if Angle > 180 then
      Angle := Angle - 180;

  if Angle > 360 then Angle := Angle - 360;

  tmp := Angle;
  KiblatBmp := NewBitmap(100,100);
  With KiblatBmp.Canvas^ do
  begin
    Pen.Color := cBorder1;
    Brush.Color := cForm;
    FillRect(KiblatBmp.BoundsRect);
    Ellipse(0,0,100,100);
    MoveTo(16,50); LineTo(84,50);
    MoveTo(50,16); LineTo(50,84);

//    Brush.BrushStyle := bsClear;
    Font.FontName := 'Arial';
    Font.FontHeight := 12;
    TextOut(47,1,'N');
    TextOut(90,45,'E');
    TextOut(47,87,'S');
    TextOut(3,46,'W');
    Ellipse(48,48,52,52);

    // Draw Line to Kiblat
    Pen.Color := clRed;
    Ellipse(148,148,152,152);
    if tmp < 91 then
        tmp := 90-tmp
    else if tmp < 180 then
        tmp := tmp-90
    else if tmp < 270 then
        tmp := 270-tmp
    else tmp := tmp - 270;
    X1 := round(50*cos(tmp*Pi/180));
    Y1 := round(50*Sin(tmp*Pi/180));

    if Angle < 90 then
      begin
        X1 := X+X1; Y1 :=Y-Y1;
      end
    else if Angle < 180 then
      begin
        X1 := X+X1; Y1 :=Y+Y1;
      end
    else if Angle < 270 then
      begin
        X1 := X-X1; Y1 :=Y+Y1;
      end
    else
      begin
        X1 := X-X1; Y1 :=Y-Y1;
      end;

    { Draw Line red }
    MoveTo(X,Y);
    LineTo(X1,Y1);
    Arc(25,25,75,75,x1,y1,50,25);

    Pen.Color := clBlue;
    if Angle < 90 then
      Arc(20,20,80,80,70,50,x1,y1)
    else if Angle < 180 then
      Arc(20,20,80,80,x1,y1,70,50)
    else if Angle < 270 then
      Arc(20,20,80,80,20,50,x1,y1)
    else
      Arc(20,20,80,80,x1,y1,20,50);
  end;
end;

procedure TFMainPage.KOLFrame1Hide(Sender: PObj);
begin
  KiblatBmp.Free;
end;

procedure TFMainPage.GroupBox1Paint(Sender: PControl; DC: HDC);
var
  a2 : single;
begin
  KiblatBmp.Draw(DC,290,38);
  with GroupBox1.Canvas^ do
  begin
    brush.BrushStyle := bsClear;
    Font.Color := clRed;
    TextOut(LQibla.Left,LQibla.top+20,
            Copy(Double2Str(Angle),0,7)+'º');

    if Angle < 90 then a2 := 90 -Angle
    else if Angle < 180 then a2 := Angle - 90
    else if Angle < 270 then a2 := 270- Angle
    else a2 := Angle - 270;

    Font.Color := clBlue;
    TextOut(LQibla.Left,LQibla.top+38,
            Copy(Double2Str(a2),0,7)+'º');
  end;
end;

end.






