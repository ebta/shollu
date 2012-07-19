{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit UCities;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror,  Classes, Controls, mckControls, mckObjs, Graphics,  mckCtrls {$IFEND (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFCitiesclass.inc} {$ELSE OBJECTS} PFCities = ^TFCities; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFCities.inc}{$ELSE} TFCities = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFCities = class(TForm)
  {$IFEND KOL_MCK}
    KOLForm1: TKOLForm;
    TopPanel: TKOLPanel;
    MainPanel: TKOLPanel;
    Panel3: TKOLPanel;
    ListBox1: TKOLListBox;
    Splitter1: TKOLSplitter;
    LV1: TKOLListView;
    PanelInfo: TKOLPanel;
    Button2: TKOLButton;
    LTitle: TKOLLabel;
    CBPlace: TKOLComboBox;
    ImgIcon: TKOLImageShow;
    LblLoad: TKOLLabel;
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure TopPanelPaint(Sender: PControl; DC: HDC);
    procedure TopPanelMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure KOLForm1Paint(Sender: PControl; DC: HDC);
    procedure ListBox1Click(Sender: PObj);
    procedure Button2Click(Sender: PObj);
    procedure KOLForm1Show(Sender: PObj);
    procedure KOLForm1Close(Sender: PObj; var Accept: Boolean);
    procedure KOLForm1Destroy(Sender: PObj);
    procedure CBPlaceChange(Sender: PObj);
    procedure ImgIconMouseUp(Sender: PControl; var Mouse: TMouseEventData);
    procedure ImgIconMouseDown(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure ImgIconMouseLeave(Sender: PObj);
    procedure ImgIconMouseMove(Sender: PControl;
      var Mouse: TMouseEventData);
    procedure LV1ColumnClick(Sender: PControl; Idx: Integer);
    procedure ListBox1KeyDown(Sender: PControl; var Key: Integer;
      Shift: Cardinal);
    procedure ListBox1SelChange(Sender: PObj);
  private
    { Private declarations }
    AdmIdx : array of Integer;
    H  : HFILE;
    MouseDown : Boolean;
    procedure LoadFirst(const FileName: string);
    procedure LoadAdmName(indexAdm1: Word);
  public
    { Public declarations }
  end;

var
  FCities {$IFDEF KOL_MCK} : PFCities {$ELSE} : TFCities {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFCities( var Result: PFCities; AParent: PControl );
{$ENDIF}

implementation

uses Unit1, UArea, Shollu;

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I UCities_1.inc}
{$ENDIF}

procedure TFCities.KOLForm1FormCreate(Sender: PObj);
var
  R1 : HRGN;
  F : PDirList;
  i : Integer;
begin
  R1 := CreateRoundRectRgn(0,0,Form.Width+1,form.Height+14,13,13);
  try
    SetWindowRgn(form.Handle,R1,True);
  finally
    DeleteObject(R1);
  end;

  MainPanel.Left := 3;
  MainPanel.Top  := TopPanel.Height ;
  MainPanel.Width  := Form.Width - 6;
  MainPanel.Height := Form.Height - TopPanel.Height - 3;
  Panel3.Color := cForm;
  ListBox1.Color := cForm;
  LV1.LVBkColor := cForm;
  LV1.LVTextBkColor := cForm;
  PanelInfo.Color := cBorder2;
  PanelInfo.Font.Color := cTitleFont;
  LTitle.Font.Color := cTitleFont;

  if cForm = clGray then
  begin
    LV1.LVTextColor := clWhite;
    ListBox1.Font.Color := clWhite;
  end;

  F := NewDirList(SholluDir+'Placenames','*.spn',FILE_ATTRIBUTE_NORMAL);
  if F.Count > 0 then
  begin
    CBPlace.Clear;
    for i:=0 to F.Count-1 do
      CBPlace.Add(ExtractFileNameWOext(F.Names[i]));
    CBPlace.CurIndex := -1;
//    CBPlace.CurIndex  := CBPlace.IndexOf('Indonesia');
//    LoadFirst(SholluDir+'placenames\indonesia.spn');
  end;
  F.Free;
end;

procedure TFCities.TopPanelPaint(Sender: PControl; DC: HDC);
begin
  Form1.PaintTop(TopPanel);
end;

procedure TFCities.TopPanelMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  ReleaseCapture;
  SendMessage(Form.Handle,WM_SYSCOMMAND,$F012,0);
end;

procedure TFCities.KOLForm1Paint(Sender: PControl; DC: HDC);
begin
  Form1.PaintForm(Form);
end;

procedure TFCities.LoadFirst(const FileName : string);
var
  P  : PChar;
  Lat,Long : Single;
  w  : Cardinal;
  B1,B2 : Byte;
  T : string;
  i,iAdm,x : Integer;
  AdmCnt : word;
begin
  if not FileExists(FileName) then Exit;
  x := 0;
  P := PChar(FileName);
  H := CreateFile(P,GENERIC_READ,
                  FILE_SHARE_READ,
                  nil,
                  OPEN_EXISTING	,
                  FILE_ATTRIBUTE_NORMAL or FILE_FLAG_RANDOM_ACCESS or
                  SECURITY_ANONYMOUS,0);
  if H <> 0 then
  begin
    LV1.Clear;
    LV1.Visible := False;
    ListBox1.Clear;
    { Read my header 2 bytes}
    ReadFile(H,B1,1,w,nil);
    ReadFile(H,B2,1,w,nil);
    GetMem(P,255);

    if B1 <> $EB then Exit;
    if B2 <> $00 then Exit;

    ReadFile(H,P^,12,w,nil); { Must "Shollu v3.xx" }

    { Adm1 Count }
    ReadFile(H,AdmCnt,2,w,nil);
    if AdmCnt  < 1 then Exit;
    SetLength(AdmIdx,AdmCnt);

    ReadFile(H,B1,1,w,nil);  // $FA.. ?
    iAdm := 0;
    while B1 = $FA do
      begin
        { Read Province Counts }
        ReadFile(H,B2,1,w,nil);
        ZeroMemory(P,255);
        if B2 > 0 then
          begin
            if iAdm = 0 then AdmIdx[0] := B2;
            ReadFile(H,P^,B2,w,nil);
            ListBox1.Add(string(P));
          end;
        ZeroMemory(P,255);
        i := SetFilePointer(H,0,nil,FILE_CURRENT);
        AdmIdx[iAdm] := i;
        Inc(iAdm);

        ReadFile(H,B1,1,w,nil);
        while B1 <> $FA do
          begin
            if iAdm < 2 then
              begin
                ReadFile(H,P^,B1,w,nil);
                T := string(P);
                ZeroMemory(P,255);
                i := LV1.LVItemAdd(T);
                x := i ;
                ReadFile(H,Lat,4,w,nil);
                LV1.LVItems[i,1] := Copy(Double2Str(Lat),0,8);
                ReadFile(H,Long,4,w,nil);
                LV1.LVItems[i,2] := Copy(Double2Str(Long),0,8);
                if x mod 10 = 0 then
                  begin
                    Applet.ProcessMessage;
                    PanelInfo.Caption := Int2Str(x);
                  end;
              end
            else
              begin
                SetFilePointer(H,B1+8,nil,FILE_CURRENT);
              end;
            ReadFile(H,B1,1,w,nil);
            if w = 0 then Break;
          end;
        end;
      FreeMem(P,255);
  end;
  LV1.Visible := True;
  PanelInfo.Caption := ' '+Lang.Items[163]+' : '+ Int2Str(x+1);
  Form.StayOnTop := True;
end;

procedure TFCities.LoadAdmName(indexAdm1: Word);
var
  P  : PChar;
  B1 : Byte;
  w  : dword;
  i  : Integer;
  Lat,long : Single;
begin
  if H <> 0 then
    begin
      LV1.Clear;
      LV1.Visible := false;
      SetFilePointer(H,Admidx[indexAdm1],nil,FILE_BEGIN);
      ReadFile(H,B1,1,w,nil);
      GetMem(P,127);
      i :=0;
      while B1 > $00 do
        begin
          if B1 = $FA then Break;
          ZeroMemory(P,127);
          ReadFile(H,P^,B1,w,nil);
          i := LV1.LVItemAdd(string(P));

          ReadFile(H,Lat,4,w,nil);
          LV1.LVItems[i,1] := Copy(Double2Str(Lat),0,7);
          ReadFile(H,Long,4,w,nil);
          LV1.LVItems[i,2] := Copy(Double2Str(Long),0,7);
          ReadFile(H,B1,1,w,nil);
          if i mod 10 = 0 then
          begin
            Applet.ProcessMessage;
            PanelInfo.Caption := Int2Str(i);
          end;
          if w = 0 then Break;
        end;
     FreeMem(P,255);
     LV1.Visible := true;
     PanelInfo.Caption := ' '+Lang.Items[163]+' : '+ Int2Str(i+1);
   end;
end;

procedure TFCities.ListBox1Click(Sender: PObj);
begin
  LoadAdmName(ListBox1.curindex);
end;

procedure TFCities.Button2Click(Sender: PObj);
begin
  if LV1.Count < 1 then Exit;
  if LV1.LVItems[LV1.CurIndex,0] = '' then Exit;
  FArea.EBArea.Text := LV1.LVItems[LV1.CurIndex,0];
  FArea.EBLat.Text  := LV1.LVItems[LV1.CurIndex,1];
  FArea.EBlong.Text := LV1.LVItems[LV1.CurIndex,2];
  FArea.BtnSaveAreaClick(Sender);
  Form.Close;
end;

procedure TFCities.KOLForm1Show(Sender: PObj);
begin
  Form.Color := cForm;
  LblLoad.Caption := Lang.Items[82];
  Button2.Caption := Lang.Items[83];
//  Button3.Caption := Lang.Items[84];
  LV1.LVColText[0] := Lang.Items[85];
  LV1.LVColText[1] := Lang.Items[86];
  LV1.LVColText[2] := Lang.Items[87];
  CBPlace.Left := LblLoad.Left + LblLoad.Width + 10;

end;

procedure TFCities.KOLForm1Close(Sender: PObj; var Accept: Boolean);
begin
  CloseHandle(H);
  AdmIdx := nil;
  Form.Free;
end;

procedure TFCities.KOLForm1Destroy(Sender: PObj);
begin
  FCities := nil;
end;

procedure TFCities.CBPlaceChange(Sender: PObj);
begin
  LoadFirst(SholluDir+'Placenames\'+CBPlace.Text+'.spn');
end;

procedure TFCities.ImgIconMouseUp(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  Form.Close;
end;

procedure TFCities.ImgIconMouseDown(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  MouseDown := True;
  ImgIcon.CurIndex := 8;
end;

procedure TFCities.ImgIconMouseLeave(Sender: PObj);
begin
  ImgIcon.CurIndex := 7;
end;

procedure TFCities.ImgIconMouseMove(Sender: PControl;
  var Mouse: TMouseEventData);
begin
  if MouseDown then
  ImgIcon.CurIndex := 8;
end;

procedure TFCities.LV1ColumnClick(Sender: PControl; Idx: Integer);
begin
  if LvoSortAscending in LV1.LVOptions then
    LV1.LVOptions := LV1.LVOptions - [LvoSortAscending] + [LvoSortDescending]
  else
    LV1.LVOptions := LV1.LVOptions + [LvoSortAscending];
  LV1.LVSortColumn(Idx);
end;

procedure TFCities.ListBox1KeyDown(Sender: PControl; var Key: Integer;
  Shift: Cardinal);
begin
  // v3.05
  if key = 13 then
    LoadAdmName(ListBox1.curindex);
end;

procedure TFCities.ListBox1SelChange(Sender: PObj);
begin
  // v3.05
  LoadAdmName(ListBox1.curindex);
end;

end.






