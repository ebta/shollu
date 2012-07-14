{ ==========================================================
  Unit Names : Shollu.pas
               ©2005-2010,2012 by Ebta Setiawan
  Salah satu Unit Utama program shollu
  Shollu merupakan program pengingat sholat
  ========================================================== }
unit Shollu;

interface

uses Windows,KOL,Messages { proc makerounded };
type
  tIconType = (itNone,itError,itWarn,itInfo,itQuestion);
  tTaskType = (ttNone,ttinfo,ttError,ttWarn,ttQuestion,ttCommand,ttShutdown,
               ttHibernate,ttMovingText,ttMultimedia);
  tFreq = (tfNone,tfDaily,tfWeekly,tfMonthly,tfOnce,tfStart);

  { Scheduled task }
  TTask = record
    Nama  : string;
    Tipe  : tTaskType;
    Freq  : tFreq;
    Jam   : TDateTime;
    JamInStr : string;
    Hari  : Word ; { senin, selasa, ...}
    Tgl   : Word; { 0..31 }
    Bulan : Word; { Jan, Feb, ... }
    Pesan : string;
  end;

  TDate = record
    Day   : Byte;
    Month : Byte;
    Year  : integer;
  end;
  
  { timeSholat }
  TSholat = record
    tMaghrib,
    tIsya,
    tShubuh,
    tTerbit,
    tDhuhur,
    tAsar      : TDateTime;
  End;

  { timeSholat in String HH:mm:ss }
  TSholatString = record
    tMaghrib,
    tIsya,
    tShubuh,
    tTerbit,
    tDhuhur,
    tAsar      : string;
  End;

  { variable global }
var
  { Skin }
  cBorder1,cBorder2,cGPMain1Col1,cGPMainCol2,
  cMenuFont,cMainFont,cTitleFont,cForm,cTitleBar : TColor;
  tNow : tSholat;
  Message2Button : Boolean = False;
  MessageResultOK : Boolean = False;
  IndexColor : Byte;
  TIMEFORMAT : string = 'HH:mm:ss';
  TaskToday : array of TTask;
  TaskTodayCount : Integer = -1;
  SholluDir : String;
  Lang : PStrList;
  NmBulanM : array[0..12] of string;
  NmBulanH : array[0..12] of string;
  // v3.06
  Pembulatan : Shortint = 0;
  Add_Dhuhur,Add_Maghrib,Add_Shubuh,Add_Asar,Add_Isya : Integer;
  HijriyahDiff : ShortInt =0;
const
  Versi = 'v3.09b';
  SATU_MENIT  = 1.0/1440;
  TIME_FMT_2 = 'HH:mm';
  TIME_FMT_3 = 'HH:mm:ss';
  MAX_EFFECT = 7;
  REG_SHOLLU3 = 'Software\Shollu3';
  REG_RUN = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';
      
  { Perhitungan Waktu Sholat }
  UNIV_ISLAM_SCIENCE_KARACHI = 1;
  ISLAMIC_SOCIETY_NORTH_AMERICA =2;
  WORLD_ISLAMIC_LEAGUE =3;
  UNIV_UMUL_QURA =4;
  EGYPT_GENERAL_ORG_SURVEY =5;

procedure MinimizeAll;
Procedure ShutdownPC;
function StrIsInt(Val : string): Boolean;
Function ConvertDate(HijriToMasehi : Boolean; const y,m,d : Word ) : TDate;
function GetPrayerTime(tgl : TDateTime; Ketinggian :Integer; TimeZone,Gd,Gn,
         Lintang,Bujur : Single;  Syafii : Boolean=true) : tSholat;
procedure MakeRounded(Control: PControl);
Function IsSuspendMode(): Boolean;
Function SetSuspendMode(): Boolean;
function Tan(X: Extended): Extended;
function TSholat2Str(waktu: TSholat) : TSholatString;

implementation

{ ---------------------------- HIBERNATE FUNCTION ----------------------------- }
Const
  DLL = 'POWRPROF.DLL';
Type
  TSuspendMode = Function(Const Hibernate: LongInt; Const ForceCritical: LongInt; Const DisableWakeEvents: LongInt): LongInt; StdCall;
  TIsPwrHibernate = Function: LongInt; StdCall;

{ Function for hibernate windows - need administrator right-}
Function SetSuspendMode(): Boolean;
Var
  hDLL : THandle;
  _Function: TSuspendMode;
  Ret : LongInt;
Begin
 // Result := False;
  hDLL := LoadLibrary(DLL);
  If hDll <> 0 Then Begin
    @_Function := GetProcAddress(hDLL, 'SetSuspendState');
    If @_Function <> Nil Then Ret := _Function(1, 0, 0);
    FreeLibrary(hDLL);
  End;
  Result := (ret = -1);
End;

{ Cek is user have administrator access right
  True mean hibernate is allowed }
  
Function IsSuspendMode(): Boolean;
Var
  hDLL : THandle;
  _Function: TIsPwrHibernate;
  Ret : LongInt;
Begin
  Result := True;
  hDLL := LoadLibrary(DLL);
  If hDll <> 0 Then Begin
    @_Function := GetProcAddress(hDLL, 'IsPwrHibernateAllowed');
    If @_Function <> Nil Then
    Ret := _Function();
    FreeLibrary(hDLL);
  End;
  If Ret = 0 Then  Result := False;
End;

{ -------------------------- EN OF HIBERNATE --------------------------------- }

{ This math functions Grabed From KOLmath.pas }

procedure MinimizeAll;
begin
  { [Window key] + 'M' minimizes all windows, [Win][Shift] + 'M' restores them }
  keybd_event( VK_LWIN, MapvirtualKey( VK_LWIN, 0), 0, 0 );
  keybd_event( Ord('M'), MapvirtualKey( Ord('M'), 0), 0, 0 );
  keybd_event( Ord('M'), MapvirtualKey( Ord('M'), 0), KEYEVENTF_KEYUP, 0 );
  keybd_event( VK_LWIN, MapvirtualKey( VK_LWIN, 0), KEYEVENTF_KEYUP, 0 );
end;

function Ceil(X: Extended): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) > 0 then
    Inc(Result);
end;

function Floor(X: Extended): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) < 0 then
    Dec(Result);
end;

function ArcTan2(Y, X: Extended): Extended;
asm
  FLD     Y
  FLD     X
  FPATAN
  FWAIT
end;

function ArcCos(X: Extended): Extended;
begin
  Result := ArcTan2(Sqrt(1 - X*X), X);
end;

function Tan(X: Extended): Extended;
{  Tan := Sin(X) / Cos(X) }
asm
  FLD    X
  FPTAN
  FSTP   ST(0)      { FPTAN pushes 1.0 after result }
  FWAIT
end;
{ ---------------------------------------------------- }

procedure MakeRounded(Control: PControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control^ do
  begin
    R := ClientRect;
    rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
    Perform(EM_GETRECT, 0, lParam(@r));
    InflateRect(r, - 5, - 5);
    Perform(EM_SETRECTNP, 0, lParam(@r));
    SetWindowRgn(Handle, rgn, True);
    Invalidate;
  end;
end;

function StrIsInt(Val : string): Boolean;
var
  x : Integer;
Begin
  x := Str2Int(Val);
  if x <> 0 then Result := True
  else
    if Val='0' then result := True
      else
        Result := False;
end;

{ Fungsi Shutdown windows 9x, Me, 2000 dan Xp }
Procedure ShutdownPC;
  Procedure ShutdownXp;
  var
    hToken: THandle;
    tkp, tkp_prev: TTokenPrivileges;
    dwRetLen :DWORD;
  begin
    OpenProcessToken(GetCurrentProcess(),
                   TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
                   hToken);

    if not LookupPrivilegeValue(PChar(''),
    'SeShutdownPrivilege',tkp.Privileges[0].Luid)
       then
           Exit;

    tkp_prev:=tkp;
    tkp.PrivilegeCount:=1;
    tkp.Privileges[0].Attributes:=SE_PRIVILEGE_ENABLED;
    AdjustTokenPrivileges(hToken, FALSE, tkp, sizeof(tkp), tkp_prev,
    dwRetLen);

    if not LookupPrivilegeValue(PChar(''),
                                'SeRemoteShutdownPrivilege',
                                tkp.Privileges[0].Luid)
      then
          Exit;

    tkp.PrivilegeCount:=1;
    tkp.Privileges[0].Attributes:=SE_PRIVILEGE_ENABLED;
    AdjustTokenPrivileges(hToken, FALSE, tkp, sizeof(tkp), tkp_prev,
    dwRetLen);

    ExitWindowsEx(EWX_FORCE OR EWX_POWEROFF ,0);
  end;

  //FUNGSI UTAMA
  Begin
    if isWinVer([wv31,wv95,wv98,wvME]) then // Windows95/98/Me
       ExitWindowsEx(EWX_SHUTDOWN OR EWX_FORCE OR EWX_POWEROFF,0)
    else ShutdownXp;
end;

function Sign(x : Double) : Integer;
begin
  if x >= 0.0 then result := 1
  else result :=-1;
end;

Function IntPart(FloatNum : real) : integer;
Begin
  if FloatNum < -0.0000001 then
    Result := ceil(FloatNum-0.0000001)
  else
    Result := Floor(FloatNum + 0.0000001);
End;

function precPart(FloatNum : Real) : Real;
begin
  Result := FloatNum - IntPart(FloatNum);
end;

{ Function HtoM(Tgl : TdateTime) : TdateTime;
  Algoritma diperoleh dari internet tanpa sumber }

Function ConvertDate(HijriToMasehi : Boolean; const y,m,d : Word ) : TDate;
var
  jd,L,N,i,J,K :integer;
  Rm,Rd,Ry : integer; //result
  Tgl : TDateTime;
  y2,m2,d2 : Word;
begin
  EncodeDate(y,m,d,Tgl);
  DecodeDate(Tgl,y2,m2,d2);
  d2 := d2 + HijriyahDiff;
  if HijriToMasehi then
  Begin
    jd := intPart((11*y2+3)/30)+354*y2+30*m2-intPart((m2-1)/2)+d2+1948440-385;
  //  Ehari.Text := HariKe(jd mod 7);
    if (jd> 2299160 ) then
      Begin
        L := jd+68569;
        N := intPart((4*L)/146097);
        L := L-intPart((146097*N+3)/4);
        i := intPart((4000*(L+1))/1461001);
        L := L-intPart((1461*i)/4)+31;
        J := intPart((80*L)/2447);
        Rd:= L-intPart((2447*j)/80);
        L := intPart(J/11);
        Rm:= J+2-12*L;
        Ry:= 100*(N-49)+i+L;
      End
      else
      Begin
        J := jd+1402;
        K := intPart((j-1)/1461);
        L := J-1461*k;
        N := intPart((L-1)/365)-intPart(L/1461);
        i := L-365*N+30;
        J := intPart((80*i)/2447);
        Rd:= i-intPart((2447*J)/80);
        i := intPart(J/11);
        Rm:= J+2-12*i;
        Ry:= 4*K+N+i-4716;
      End;
      Result.Day := Rd;
      Result.Month := Rm;
      Result.Year := Ry;
  end
  else
    Begin
      if ((y2>1582) OR((y2=1582) AND (m2>10))OR((y2=1582) AND (m2=10) AND (d2>14))) then
                     jd := intPart((1461*(y2+4800+intPart((m2-14)/12)))/4)+
               intPart((367*(m2-2-12*(intPart((m2-14)/12))))/12)-
                     intPart((3*(intPart((y2+4900+intPart((m2-14)/12))/100)))/4)+d2-32075
            else
                     jd := 367*y2-intPart((7*(y2+5001+intPart((m2-9)/7)))/4)+
               intPart((275*m2)/9)+d2+1729777;

    //  Ehari.Text := HariKe(jd mod 7);
      L := jd-1948440+10632;
      N := intPart((L-1)/10631);
      L := L-10631*n+354;
      J := (intPart((10985-L)/5316))*(intPart((50*L)/17719))+
           (intPart(L/5670))*(intPart((43*l)/15238));
      L := L-(intPart((30-j)/15))*(intPart((17719*j)/50))-
           (intPart(j/16))*(intPart((15238*j)/43))+29;
      Rm := intPart((24*L)/709);
      Rd := l-intPart((709*Rm)/24);
      Ry := 30*n+j-30;
    {  if (Rm > 12) or (Rm < 1) or
        (Rd<1) or (Rd>30) then
          begin
            MsgOK('Error on Tgl='+Int2Str(Rd)+' and Bln='+Int2Str(rm)+
                  ' Thn= '+Int2str(Rm)+#13#10+
                  'Tgl='+Int2Str(d)+' and Month='+Int2Str(m)+
                  ' Thn= '+Int2str(y));
            exit;
          end;           }
      Result.Day := Rd;
      Result.Month := Rm;
      Result.Year := Ry;
    End;
end;

function To_HMS(x : Single) : TDateTime;
var
  h,m,s,sOrg : Integer;
  hms : string;
begin
  h := Floor(x);
  m := Floor((x-h)*60);
  s := Floor((((x-h)*60)-floor((x-h)*60))*60);
  sOrg := s;

  if TIMEFORMAT = TIME_FMT_2 then s := 0;

  hms := Int2Str(h)+':'+Int2Str(m)+':'+Int2Str(s);
  //result := Str2DateTimeFmt(TIME_FMT_3,hms);
  // require KOL 3.17
  result := Str2TimeFmt(TIME_FMT_3,hms);

  if TIMEFORMAT = TIME_FMT_2 then
    case Pembulatan of
      0 : Result := Result; // Pembulatan kebawah, detik dihilangkan
      1 : Result := Result + SATU_MENIT; // Pembulatan keatas
      2 : if sOrg >= 30 then Result := Result + SATU_MENIT; // jika detik >= 30
    end;
end;

{ Fungsi Utama menghitung Waktu Sholat, parameter yang diperlukan adalah tgl (TDateTime), ketinggian(meter), 
  TimeZone, Gd, Gn ( lihat manual), Garis Lintang, Garis Bujur dan madzhab yang digunakan }
function GetPrayerTime(tgl : TDateTime; Ketinggian :Integer; TimeZone,Gd,Gn,
         Lintang,Bujur : Single;  Syafii : Boolean=true) : tSholat;
  Function DayOfYear : Word;
  var
    day,m,y : word;
    jan1 : TDateTime;
  Begin
    DecodeDate(tgl,y,m,day);
    EncodeDate(y,1,1,jan1);
    Result := Trunc(tgl-jan1);
  End;
var
  { L = garis Bujur. B = Garis Lintang
    R = Referensi Garis Bujur
    TZ = TimeZone
  }

  TZ,Bt,D,T,R,L,B,U,Vd,Vn,W,H : Single;
  Sh : Integer;
  Z : TDateTime;
Begin
  if Syafii then Sh:=1 else Sh:=2;
  B := Lintang; L := Bujur; TZ := TimeZone;
  H := Ketinggian;

  Bt := (2*Pi*DayOfYear)/365;
  { D = Solar Declination (Degeree)}
  D  := (180/Pi) * (0.006918-(0.399912*cos(Bt))+(0.070257*sin(Bt))-
        (0.006758*cos(2*Bt))+(0.000907*sin(2*Bt))-
        (0.002697*cos(3*Bt))+(0.001480*sin(3*Bt)));

  { T = Equation of Time (Minutes) }
  T  := 229.18*(0.000075+
        (0.001868*cos(Bt))-(0.032077*sin(Bt))-
        (0.014615*cos(2*Bt))-(0.040849*sin(2*Bt)));

  r := 15*TZ;
  { Waktu Dhuhur }
  Z := 12+((R-L)/15)-(T/60);

  U :=  (180/(15*Pi))*
        ArcCos((Sin((-0.8333-0.0347*sign(H)*sqrt(Abs(H)))*Pi/180)-
        Sin(D*Pi/180)*Sin(B*Pi/180))/
        (Cos(D*Pi/180)*Cos(B*Pi/180)));

  Vd := (180/(15*Pi))*
        ArcCos((-Sin(Gd*Pi/180)-Sin(D*Pi/180)*Sin(B*Pi/180))/
        (Cos(D*Pi/180)*Cos(B*Pi/180)));

  Vn := (180/(15*Pi))*
        ArcCos((-Sin(Gn*Pi/180)-Sin(D*Pi/180)*Sin(B*Pi/180))/
        (Cos(D*Pi/180)*Cos(B*Pi/180)));

  W  := (180/(15*Pi))*
        ArcCos((Sin(ArcTan2((1/(Sh+Tan(Abs(B-D)*Pi/180))),1))-
        Sin(D*Pi/180)*Sin(B*Pi/180))/
        (Cos(D*Pi/180)*Cos(B*Pi/180)));

  Result.tShubuh := To_HMS(Z-Vd)+ Add_Shubuh*SATU_MENIT;
  Result.tTerbit := To_HMS(Z-U);
  Result.tDhuhur := To_HMS(Z)+ Add_Dhuhur*SATU_MENIT;
  Result.tAsar   := To_HMS(Z+W)+ Add_Asar*SATU_MENIT;
  Result.tMaghrib :=To_HMS(Z+U)+ Add_Maghrib *SATU_MENIT;
  Result.tIsya := To_HMS(Z+Vn)+ Add_Isya *SATU_MENIT;
End;

function TSholat2Str(waktu: TSholat) : TSholatString;
begin
	result.tShubuh 	:= Time2StrFmt(TIME_FMT_3,waktu.tShubuh);
	result.tDhuhur 	:= Time2StrFmt(TIME_FMT_3,waktu.tDhuhur);
	result.tAsar	  := Time2StrFmt(TIME_FMT_3,waktu.tAsar);
	result.tMaghrib	:= Time2StrFmt(TIME_FMT_3,waktu.tMaghrib);
	result.tIsya		:= Time2StrFmt(TIME_FMT_3,waktu.tIsya);
end;
end.
