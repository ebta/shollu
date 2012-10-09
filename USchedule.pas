{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit USchedule;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror,  Classes,
 Controls, mckControls, mckObjs, Graphics,
 mckCtrls {$IFEND (place your units here->)},Shollu,ShellAPI;
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  TSaveExt = (tTsv,tHtml,tCsv,tRtf);

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFScheduleclass.inc} {$ELSE OBJECTS} PFSchedule = ^TFSchedule; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFSchedule.inc}{$ELSE} TFSchedule = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFSchedule = class(TForm)
  {$IFEND KOL_MCK}
    KOLFrame1: TKOLFrame;
    LTgl1: TKOLLabel;
    Date1: TKOLDateTimePicker;
    LTitleSchedule: TKOLLabel;
    LTgl2: TKOLLabel;
    Date2: TKOLDateTimePicker;
    BtnSave: TKOLBitBtn;
    GPmain: TKOLGradientPanel;
    LblBack: TKOLLabel;
    BtnColor: TKOLBitBtn;
    GBSave: TKOLGroupBox;
    RBhtml: TKOLRadioBox;
    RBtsv: TKOLRadioBox;
    RBcsv: TKOLRadioBox;
    GBTime: TKOLGroupBox;
    RBFmt1: TKOLRadioBox;
    RBFmt2: TKOLRadioBox;
    BtnTextColor: TKOLBitBtn;
    procedure KOLFrame1Show(Sender: PObj);
    procedure BtnSaveClick(Sender: PObj);
    procedure BuatJadwalNew(Timeformat : String; namaFile : string);
    procedure BtnColorClick(Sender: PObj);
    procedure KOLFrame1Destroy(Sender: PObj);
    procedure BtnSaveMouseLeave(Sender: PObj);
    procedure BtnSaveMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
  private
    { Private declarations }
    Col : TColor;
    procedure UpdateLanguage;
    procedure UpdateSkin;
  public
    { Public declarations }
  end;

var
  FSchedule {$IFDEF KOL_MCK} : PFSchedule {$ELSE} : TFSchedule {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFSchedule( var Result: PFSchedule; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, UColConv;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I USchedule_1.inc}
{$ENDIF}

procedure TFSchedule.UpdateSkin;
begin
  if IndexColor > 20 then
    GPmain.Color2 := cForm
  else
    GPmain.Color2 := cGPMain1Col1;
    
  Form.Color := cForm;
  GPmain.Color1 := cForm;
  Col := BtnColor.Color;
  GBSave.Color := cForm;
  GBTime.Color := cForm;

  RBFmt1.Color := cForm;
  RBFmt2.Color := cForm;

  RBhtml.Color := cForm;
  RBtsv.Color := cForm;
  RBcsv.Color := cForm;
end;

procedure TFSchedule.KOLFrame1Show(Sender: PObj);
begin
  UpdateLanguage;
  UpdateSkin;
  GBTime.TextAlign := taCenter;
  GBSave.TextAlign := taCenter;
end;

procedure TFSchedule.UpdateLanguage;
begin
  LTitleSchedule.Caption := lang.Items[107];
  LTgl1.Caption := lang.Items[108];
  LTgl2.Caption := lang.Items[109];
  GBTime.Caption :=lang.Items[110];
  GBSave.Caption := lang.Items[111];
  RBhtml.Caption := lang.Items[112];
  RBtsv.Caption := lang.Items[113];
  RBcsv.Caption := lang.Items[114];
  LblBack.Caption := Lang.Items[115];
  BtnSave.Caption := Lang.Items[116];
  
  BtnColor.Caption := Lang.Items[203];

  if (LblBack.Left + LblBack.Width) < Date1.Left then
    BtnColor.Left := Date1.Left
  else
    BtnColor.Left := LblBack.Left + LblBack.Width + 5;
end;

procedure TFSchedule.BtnSaveClick(Sender: PObj);
var
  OSD : POpenSaveDialog;
begin
  if (Date2.Date - Date1.Date) < 0 then
  begin
     Form1.ShowMessage(false,'Invalid date range, please check again'+#13#10+
      'error : Date 1 > Date 2',itError);
     Exit;
  end;
  OSD := NewOpenSaveDialog(lang.Items[107],'',[]);
  OSD.OpenDialog := False;
  OSD.WndOwner := Form.Handle;
  if RBhtml.Checked then
    OSD.Filter := 'HTML File (*.html)|*.html'
  else if RBtsv.Checked then
    OSD.Filter := 'Tab Separated Value  (*.tsv)|*.tsv'
  else if RBcsv.Checked then
    OSD.Filter := 'Comma Separated Value  (*.csv)|*.csv';

  if OSD.Execute then
  begin
  //  Applet.ProcessMessage;
    BtnSave.Enabled := False;
    if RBFmt1.Checked then
      BuatJadwalNew(TIME_FMT_2,OSD.Filename)
    else if RBFmt2.Checked then
      BuatJadwalNew(TIME_FMT_3,OSD.Filename);
    //ShellExecute(0,'open',PChar(Osd.Filename),'','',SW_SHOW);
    BtnSave.Enabled := True;
  end;
  OSD.Free;
end;

function Col2Web(Col : TColor) : string;
var
  Rgb_ :TColorRef;
begin
  Rgb_ := Color2RGB(col);
  Result := '#'+ Int2Hex(GetRValue(Rgb_),2)+Int2Hex( GetGValue(Rgb_),2)+
            Int2Hex( GetBValue(Rgb_),2);
end;

function InvertColor(color: TColor): TColor;
var
  rgb_: TColorRef;

  function Inv(b: Byte): Byte;
  begin
    if b > 128 then
      result := 0
    else
      result := 255;
  end;
begin
  rgb_ := Color2Rgb(color);
  rgb_ := RGB( Inv(GetRValue(rgb_)), Inv(GetGValue(rgb_)), Inv(GetBValue(rgb_)));
  Result := rgb_;
end;

procedure TFSchedule.BtnColorClick(Sender: PObj);
var
  ColDlg : PColorDialog;
begin
  ColDlg := NewColorDialog(ccoShortOpen);
  ColDlg.OwnerWindow := form.Handle;
  if ColDlg.Execute then
  begin
    Col := ColDlg.Color;
    TKOLBitBtn(Sender).Color := ColDlg.Color;
    TKOLBitBtn(Sender).Font.Color := InvertColor(ColDlg.Color);
  end;
  ColDlg.Free;
end;

procedure TFSchedule.KOLFrame1Destroy(Sender: PObj);
begin
  if not AppletTerminated then
  FSchedule := nil;
end;

procedure TFSchedule.BtnSaveMouseLeave(Sender: PObj);
begin
  TKOLBitBtn(Sender).Font.FontStyle := []
end;

procedure TFSchedule.BtnSaveMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  TKOLBitBtn(Sender).Font.FontStyle := [fsBold]
end;

procedure TFSchedule.BuatJadwalNew(Timeformat, namaFile: string);
const
   TR_TEMPLATE = '<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>';
   CR = #13#10;
var
   header,tabel,tr,footer,hasil,tbltmp,trtmp,info,mahzab,title,Newln : KOLString;
   Thn1,bln1,tgl1,Thn2,bln2,tgl2,blnNext,blnTmp,BlnH1,BlnH2 : Word;
   i,j,jmlHari : Integer;
   MDate : TDateTime;
   Hdate : TDate;
   sBlnH : string;
   Tipe : TsaveExt;
   Sep  : Char;
   tSh  : TSholatString;

   procedure CreateHtmlTable();
   begin
      tbltmp := tabel;
      blnTmp := blnNext - 1;
      if blnTmp = 0 then blnTmp := 12;
      StrReplace(tbltmp,'{BLN_M}',NmBulanM[blnTmp]+' '+ Int2Str(Thn1));
      StrReplace(tbltmp,'{BLN_H}',sBlnH+' '+Int2Str(Thn2)+' H');
      StrReplace(tbltmp,'{TBL_HEAD}',Format(TR_TEMPLATE,['Msh','Hjr',Lang.Items[1],Lang.Items[2],Lang.Items[3],Lang.Items[4],Lang.Items[5],Lang.Items[6]]));
      StrReplace(tbltmp,'{TBL_ROWS}',tr);
      hasil := hasil + tbltmp;
   end;

   procedure CreateTextTable();
   begin
      blnTmp := blnNext - 1;
      if blnTmp = 0 then blnTmp := 12;
      hasil := hasil + CR + CR +NmBulanM[blnTmp]+' '+ Int2Str(Thn1)+Sep+Sep+
             sBlnH+' '+Int2Str(Thn2)+' H'+CR+
             Lang.Items[184]+Sep+Lang.Items[185]+Sep+Lang.Items[1]+Sep+Lang.Items[2]+
             Sep+Lang.Items[3]+Sep+Lang.Items[4]+Sep+Lang.Items[5]+Sep+Lang.Items[6]+
             CR+tr;
   end;  
begin
   Sep := ',';
   if RBhtml.Checked then Tipe := tHtml
   else if RBtsv.Checked then begin Tipe := tTsv; Sep := #9; end
   else {if RBcsv.Checked then} begin Tipe := tCSv; Sep := ','; end;

   DecodeDate(Date1.DateTime,Thn1,bln1,tgl1);
   DecodeDate(Date2.DateTime,Thn2,bln2,tgl2);
   if Form1.Syafii then mahzab := 'Mazhab Syafii' else mahzab := 'Mazhab Hanafi';
   title := lang.Items[169]+' '+Form1.Area;

   case Tipe of
   tHtml :
      begin
         hasil := StrLoadFromFile( GetStartDir + 'jadwal.tpl');

         i := Pos('<!--header-->',hasil);
         header := Copy(hasil,0,i-1);
         i := i + 13;
         j := Pos('<!--jadwal-->',hasil);
         tabel  := Copy(hasil,i,j-i);
         i := j + 13;
         footer := Copy(hasil,i,MaxInt);

         StrReplace(header,'{VERSI}',Versi);
         while StrReplace(header,'{COLMAIN}',Col2Web(btnColor.Color)) do begin end;
         while StrReplace(header,'{COLTEXT}',Col2Web(btnTextColor.Color)) do begin end;
         while StrReplace(header,'{TITLE}',title) do begin end;
         StrReplace(header,'{PERIODE}', Int2str(tgl1)+' '+NmBulanM[Bln1]+' '+Int2Str(Thn1)+
                 ' - '+Int2str(tgl2)+' '+NmBulanM[Bln2]+' '+Int2Str(Thn2));
         hasil := header;
      end;

   tTsv,tCsv :
      begin
         hasil := title+CR+ Int2str(tgl1)+' '+NmBulanM[Bln1]+' '+Int2Str(Thn1)+
              ' - '+Int2str(tgl2)+' '+NmBulanM[Bln2]+' '+Int2Str(Thn2)+CR;
      end;  
   end;

   BlnH1 := 0;
   blnNext := bln1+1;
   if blnNext > 12 then blnNext := 1;

   jmlHari := Integer(Trunc((Date2.DateTime - Date1.DateTime)));
   tr  := '';
   for i:= 0 to jmlHari do
   begin
      MDate := Date1.DateTime + i ;
      DecodeDate(MDate,Thn2,bln2,tgl1);
      HDate := ConvertDate(False,Thn2,bln2,tgl1);  // Hijriyah
      DecodeDate(MDate,Thn1,Bln1,tgl1);
      Thn2 := Hdate.Year;
      bln2 := Hdate.Month;
      tgl2 := Hdate.Day;
      tSh := TSholat2Str(GetPrayerTime(MDate,Form1.Altitude,Form1.TZ,Form1.Gd,Form1.Gn,
             Str2Double(Form1.Latitude),Str2Double(Form1.Longitude),Form1.syafii),Timeformat);

      if BlnH1 = 0 then
      begin
         BlnH1 := Bln2;
         sBlnH := NmBulanH[BlnH1];
         if Tgl2 = 1 then sBlnH := NmBulanH[Bln2-1] + ' - '+NmBulanH[Bln2];
      end;

      if BlnH1 <> Bln2 then
      begin
         BlnH2 := bln2;
         sBlnH := NmBulanH[BlnH1] + ' - '+NmBulanH[BlnH2];
      end;

      if Tipe = tHtml then
      begin
         trtmp := Format(TR_TEMPLATE,[Int2Str(tgl1),Int2Str(tgl2), tSh.tShubuh, tSh.tTerbit,
            tSh.tDhuhur, tSh.tAsar, tSh.tMaghrib,tSh.tIsya]);

         if DayOfWeek(MDate) = 5 then
            StrReplace(trtmp,'<tr>','<tr class="friday">')
         else
         if DayOfWeek(MDate) = 7 then
            StrReplace(trtmp,'<tr>','<tr class="week">')
         else
         if i mod 2 = 0 then
            StrReplace(trtmp,'<tr>','<tr class="even">');
         StrReplace(trtmp,'<tr','<tr id="'+ Date2StrFmt('yyyyMd',MDate) +'"');
      end else
      begin
        trtmp := Int2Str(tgl1)+ sep + Int2Str(tgl2) + Sep + tSh.tShubuh + Sep + tSh.tTerbit + Sep +
            tSh.tDhuhur + Sep + tSh.tAsar + Sep + tSh.tMaghrib + Sep + tSh.tIsya + CR;
      end;  


      // Cek Jika Bulan Berikutnya
      if bln1 = blnNext then
         begin
            if blnNext = 1 then
            begin
                blnNext := 13;
                Thn1 := Thn1 -1;
            end;

            if Tipe = tHtml then
                CreateHtmlTable
            else
               CreateTextTable;

            tr := trtmp;
            blnNext := bln1+1;
            if blnNext > 12 then blnNext := 1;
            BlnH1 := 0;
         end
      else
         tr := tr + trtmp;
   end;

   if Tipe = tHtml then Newln := '<br />'
   else NewLn := CR;
   
   info := ' '+lang.Items[38]+' = '+ Lat2DMS(Str2Double(Form1.Latitude)) +NewLn+
           ' '+lang.Items[39]+' = '+ Long2DMS(Str2Double(Form1.Longitude)) +NewLn+
           ' '+lang.Items[40]+' = '+ Int2Str(Form1.Altitude)+' m'+NewLn+
           ' '+lang.Items[170]+' = '+ Double2Str(Form1.Gd)+'°'+ NewLn+
           ' '+lang.Items[171]+' = '+ Double2Str(Form1.Gn)+'°'+ NewLn+
           ' '+lang.Items[172]+' =  '+ Double2Str(Form1.TZ) + NewLn +
           ' '+lang.Items[173]+' '+ mahzab+NewLn+
           ' '+lang.Items[174]+' = '+lang.Items[75+ Form1.methods]+NewLn+NewLn+' Created with Shollu '+versi+CR;

   if Tipe = tHtml then
      begin
         CreateHtmlTable;
         StrReplace(info,'Shollu','<a href="http://ebsoft.web.id/download/shollu/" target="_blank">Shollu</a>');
         StrReplace(footer,'{INFO}',info);
         // Replace 2 kali
         while StrReplace(footer,'°','&deg;') do
         begin
           //
         end;

         hasil := hasil + footer;
      end
   else
   begin
      CreateTextTable;
      hasil := hasil + CR + 'Keterangan' + CR+ info;
   end;
   StrSaveToFile(namaFile, hasil);
end;

end.






