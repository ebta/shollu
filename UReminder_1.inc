{ KOL MCK } // Do not remove this line!
type TImageList_ = object(TImageList) end;
const Sizeof_TFTask = Sizeof(TFTask);
type TControl_ = object( TControl ) end;
type TObj_ = object( TObj ) end;
type _TObj_ = object( _TObj ) end;

{$IFDEF Pcode}
procedure NewFTask( var Result: PFTask; AParent: PControl );
{$IFDEF Psource}
 PROC(2)
 Load4 ####@@formvmt L(0)
 TObj.Create<2> RESULT
 SetSELF
 DUP C2 Store
 LoadAnsiStr 'FTask' #0
 C4 
 NewForm<2> RESULT
 DUP C3 AddByte_Store #TFTask.Form
 L(204) L(230) C2 TControl.SetPosition<3> L(349) L(670) C2 TControl.SetClientSize<3>
 LoadSELF C1 
 TControl.Add2AutoFree<2>
 IFDEF(USE_NAMES)
 LoadAnsiStr 'FTask' #0
 C2 TObj.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetStayOnTop<2>
 DUP TControl_.GetFont<1> RESULT
 L(14)
 L(4)
 C2 TGraphTool.SetInt<3>
 LoadAnsiStr 'Arial' #0
 C2 TGraphTool.SetFontName<2>
 DelAnsiStr
 DEL // Font
 LoadSELF Load4 ####TFTask.KOLForm1Close
 C2 TControl_.SetOnClose<1>
 LoadAnsiStr 'Name' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(208) L(16) C2 TControl.SetPosition<3> L(1) C1 TControl.AutoSize<2>
 DUP LoadSELF AddWord_Store ##TFTask.Label1
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label1' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label1
 LoadAnsiStr 'Type' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(240) L(16) C2 TControl.SetPosition<3> L(1) C1 TControl.AutoSize<2>
 DUP LoadSELF AddWord_Store ##TFTask.Label2
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label2' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label2
 LoadAnsiStr 'Frequently' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(272) L(16) C2 TControl.SetPosition<3> L(1) C1 TControl.AutoSize<2>
 DUP LoadSELF AddWord_Store ##TFTask.Label3
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label3' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label3
 LoadAnsiStr 'Date / Time' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(296) L(16) C2 TControl.SetPosition<3> L(1) C1 TControl.AutoSize<2>
 DUP LoadSELF AddWord_Store ##TFTask.Label4
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label4' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label4
 LoadAnsiStr 'Message' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(320) L(16) C2 TControl.SetPosition<3> L(1) C1 TControl.AutoSize<2>
 DUP LoadSELF AddWord_Store ##TFTask.Label5
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label5' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label5
 LoadAnsiStr 'Linfo' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(168) L(13) C2 TControl.SetPosition<3> L(17) L(0) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TFTask.Linfo
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Linfo' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Linfo
 L(0)
 L(0)
 L(0)
 L(591872)
 L(3)
 C5
 NewListView<3>
 RESULT
L(8) L(76) C2 TControl.SetPosition<3> L(153) L(581) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TFTask.LV
 IFDEF(USE_NAMES)
 LoadAnsiStr 'LV' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 DEL //LV
 L(0) 
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewEditBox<2>
 RESULT
L(200) L(96) C2 TControl.SetPosition<3> L(0) L(185) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TFTask.EName
 IFDEF(USE_NAMES)
 LoadAnsiStr 'EName' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 DEL //EName
 L(17)
 C1
 NewComboBox<2>
 RESULT
L(226) L(96) C2 TControl.SetPosition<3> L(0) L(185) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TFTask.CBType
 IFDEF(USE_NAMES)
 LoadAnsiStr 'CBType' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 LoadAnsiStr 'Information' #0 L(0) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'Warning' #0 L(1) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'Question' #0 L(2) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'Error' #0 L(3) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'Hibernate' #0 L(4) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'Shutdown' #0 L(5) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'Command (Run Application)' #0 L(6) C3 TControl_.SetItems<3> DelAnsiStr
 L(0) C1 TControl_.SetCurIndex<2>
 DEL //CBType
 L(0)
 C1
 NewDateTimePicker<2>
 RESULT
L(278) L(96) C2 TControl.SetPosition<3> L(0) L(185) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TFTask.Time1
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Time1' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Time1
 L(16)
 C1
 NewComboBox<2>
 RESULT
L(252) L(96) C2 TControl.SetPosition<3> L(0) L(185) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TFTask.CBFreq
 IFDEF(USE_NAMES)
 LoadAnsiStr 'CBFreq' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 LoadAnsiStr 'Daily' #0 L(0) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'Weekly' #0 L(1) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'Monthly' #0 L(2) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'One Time only' #0 L(3) C3 TControl_.SetItems<3> DelAnsiStr
 LoadAnsiStr 'When My Computer Start' #0 L(4) C3 TControl_.SetItems<3> DelAnsiStr
 L(0) C1 TControl_.SetCurIndex<2>
 DEL //CBFreq
 LoadAnsiStr '<< First' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(168) L(96) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn1
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn1' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn1
 LoadAnsiStr '< Prior' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(168) L(168) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn2
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn2' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn2
 LoadAnsiStr 'Next >' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(168) L(240) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn3
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn3' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn3
 LoadAnsiStr 'Last >>' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(168) L(312) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn4
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn4' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn4
 LoadAnsiStr 'Clear' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(8) L(10) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn5
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn5' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn5
 LoadAnsiStr 'Add New' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(32) L(10) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn6
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn6' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn6
 LoadAnsiStr 'Insert' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(56) L(10) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn7
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn7' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn7
 LoadAnsiStr 'Post' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(80) L(10) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn8
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn8' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn8
 LoadAnsiStr 'Delete' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(104) L(10) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn9
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn9' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn9
 LoadAnsiStr 'Save' #0 C2R
 L(0) 
 L(0)
 L(0)
 L(0) R2C
 LoadSELF AddWord_LoadRef ##TFTask.Form
 NewBitBtn<3>
 RESULT
L(128) L(10) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TFTask.BitBtn10
 IFDEF(USE_NAMES)
 LoadAnsiStr 'BitBtn10' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L(1) C1 TControl_.SetFlat<2>
 L(1) C1 AddWord_Store ##TControl_.fTextShiftX
 L(1) C1 AddWord_Store ##TControl_.fTextShiftY
 DEL //BitBtn10
 LoadSELF AddWord_LoadRef ##TFTask.LV
 LoadSELF Load4 ####TFTask.LVMouseDown
 C2 TControl_.SetOnMouseDown<1>
 DEL //LV
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn1
 Load4 ####TFTask.BitBtn1Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn1
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn2
 Load4 ####TFTask.BitBtn2Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn2
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn3
 Load4 ####TFTask.BitBtn3Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn3
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn4
 Load4 ####TFTask.BitBtn4Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn4
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn5
 Load4 ####TFTask.BitBtn5Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn5
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn6
 Load4 ####TFTask.BitBtn6Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn6
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn7
 Load4 ####TFTask.BitBtn7Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn7
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn8
 Load4 ####TFTask.BitBtn8Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn8
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn9
 Load4 ####TFTask.BitBtn9Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn9
 LoadSELF AddWord_LoadRef ##TFTask.BitBtn10
 Load4 ####TFTask.BitBtn10Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //BitBtn10
 DUP TControl.CenterOnParent<1>
 LoadSELF DUP TFTask.KOLForm1FormCreate<2>
 DEL DelAnsiStr DEL(3) EXIT
           ####Sizeof_TFTask
           ####0
@@formvmt: ####_TObj_.Init
           ####TObj.Destroy
 ENDP
{$ENDIF Psource}
{$ELSE OldCode}
procedure NewFTask( var Result: PFTask; AParent: PControl );
begin

  {$IFDEF KOLCLASSES}
  Result := PFTask.Create;
  {$ELSE OBJECTS}
  New( Result, Create );
  {$ENDIF KOL CLASSES/OBJECTS}
  Result.Form := NewForm( AParent, 'FTask' ).SetPosition( 230, 204 ){No MainMenu!}.SetClientSize( 670, 349 );
  Result.Form.Add2AutoFree( Result );
   {$IFDEF USE_NAMES}
    Result.Form.Name := 'FTask';
   {$ENDIF}
    Result.Form.StayOnTop := True;
    Result.Form.Font.FontHeight := 14;
    Result.Form.Font.FontName := 'Arial';
      Result.Form.OnClose := Result.KOLForm1Close;
    // Result.Label1.TabOrder = -1
    Result.Label1 := NewLabel( Result.Form, 'Name' ).SetPosition( 16, 208 ).AutoSize( TRUE );
   {$IFDEF USE_NAMES}
    Result.Label1.Name := 'Label1';
   {$ENDIF}
    // Result.Label2.TabOrder = -1
    Result.Label2 := NewLabel( Result.Form, 'Type' ).SetPosition( 16, 240 ).AutoSize( TRUE );
   {$IFDEF USE_NAMES}
    Result.Label2.Name := 'Label2';
   {$ENDIF}
    // Result.Label3.TabOrder = -1
    Result.Label3 := NewLabel( Result.Form, 'Frequently' ).SetPosition( 16, 272 ).AutoSize( TRUE );
   {$IFDEF USE_NAMES}
    Result.Label3.Name := 'Label3';
   {$ENDIF}
    // Result.Label4.TabOrder = -1
    Result.Label4 := NewLabel( Result.Form, 'Date / Time' ).SetPosition( 16, 296 ).AutoSize( TRUE );
   {$IFDEF USE_NAMES}
    Result.Label4.Name := 'Label4';
   {$ENDIF}
    // Result.Label5.TabOrder = -1
    Result.Label5 := NewLabel( Result.Form, 'Message' ).SetPosition( 16, 320 ).AutoSize( TRUE );
   {$IFDEF USE_NAMES}
    Result.Label5.Name := 'Label5';
   {$ENDIF}
    // Result.Linfo.TabOrder = -1
    Result.Linfo := NewLabel( Result.Form, 'Linfo' ).SetPosition( 13, 168 ).SetSize( 0, 17 );
   {$IFDEF USE_NAMES}
    Result.Linfo.Name := 'Linfo';
   {$ENDIF}
    // Result.LV.TabOrder = 0
    Result.LV := NewListView( Result.Form, lvsDetail, [ lvoGridLines, lvoRowSelect, lvoFlatsb ], nil, nil, nil ).SetPosition( 76, 8 ).SetSize( 581, 153 );
   {$IFDEF USE_NAMES}
    Result.LV.Name := 'LV';
   {$ENDIF}
    Result.LV.Color := clWindow;
    // Result.EName.TabOrder = 1
    Result.EName := NewEditBox( Result.Form, [  ] ).SetPosition( 96, 200 ).SetSize( 185, 0 );
   {$IFDEF USE_NAMES}
    Result.EName.Name := 'EName';
   {$ENDIF}
    // Result.CBType.TabOrder = 2
    Result.CBType := NewComboBox( Result.Form, [ coReadOnly, coNoIntegralHeight ] ).SetPosition( 96, 226 ).SetSize( 185, 0 );
   {$IFDEF USE_NAMES}
    Result.CBType.Name := 'CBType';
   {$ENDIF}
    Result.CBType.Color := clWindow;
    Result.CBType.Items[ 0 ] := 'Information';
    Result.CBType.Items[ 1 ] := 'Warning';
    Result.CBType.Items[ 2 ] := 'Question';
    Result.CBType.Items[ 3 ] := 'Error';
    Result.CBType.Items[ 4 ] := 'Hibernate';
    Result.CBType.Items[ 5 ] := 'Shutdown';
    Result.CBType.Items[ 6 ] := 'Command (Run Application)';
    Result.CBType.CurIndex := 0;
    // Result.Time1.TabOrder = 3
    Result.Time1 := NewDateTimePicker( Result.Form, [] ).SetPosition( 96, 278 ).SetSize( 185, 0 );
   {$IFDEF USE_NAMES}
    Result.Time1.Name := 'Time1';
   {$ENDIF}
    // Result.CBFreq.TabOrder = 4
    Result.CBFreq := NewComboBox( Result.Form, [ coNoIntegralHeight ] ).SetPosition( 96, 252 ).SetSize( 185, 0 );
   {$IFDEF USE_NAMES}
    Result.CBFreq.Name := 'CBFreq';
   {$ENDIF}
    Result.CBFreq.Color := clWindow;
    Result.CBFreq.Items[ 0 ] := 'Daily';
    Result.CBFreq.Items[ 1 ] := 'Weekly';
    Result.CBFreq.Items[ 2 ] := 'Monthly';
    Result.CBFreq.Items[ 3 ] := 'One Time only';
    Result.CBFreq.Items[ 4 ] := 'When My Computer Start';
    Result.CBFreq.CurIndex := 0;
    // Result.BitBtn1.TabOrder = 6
    Result.BitBtn1 := NewBitBtn( Result.Form, '<< First', [  ], glyphLeft, 0, 0 ).SetPosition( 96, 168 );
   {$IFDEF USE_NAMES}
    Result.BitBtn1.Name := 'BitBtn1';
   {$ENDIF}
    Result.BitBtn1.Flat := TRUE;
    Result.BitBtn1.TextShiftX := 1;
    Result.BitBtn1.TextShiftY := 1;
    // Result.BitBtn2.TabOrder = 7
    Result.BitBtn2 := NewBitBtn( Result.Form, '< Prior', [  ], glyphLeft, 0, 0 ).SetPosition( 168, 168 );
   {$IFDEF USE_NAMES}
    Result.BitBtn2.Name := 'BitBtn2';
   {$ENDIF}
    Result.BitBtn2.Flat := TRUE;
    Result.BitBtn2.TextShiftX := 1;
    Result.BitBtn2.TextShiftY := 1;
    // Result.BitBtn3.TabOrder = 8
    Result.BitBtn3 := NewBitBtn( Result.Form, 'Next >', [  ], glyphLeft, 0, 0 ).SetPosition( 240, 168 );
   {$IFDEF USE_NAMES}
    Result.BitBtn3.Name := 'BitBtn3';
   {$ENDIF}
    Result.BitBtn3.Flat := TRUE;
    Result.BitBtn3.TextShiftX := 1;
    Result.BitBtn3.TextShiftY := 1;
    // Result.BitBtn4.TabOrder = 9
    Result.BitBtn4 := NewBitBtn( Result.Form, 'Last >>', [  ], glyphLeft, 0, 0 ).SetPosition( 312, 168 );
   {$IFDEF USE_NAMES}
    Result.BitBtn4.Name := 'BitBtn4';
   {$ENDIF}
    Result.BitBtn4.Flat := TRUE;
    Result.BitBtn4.TextShiftX := 1;
    Result.BitBtn4.TextShiftY := 1;
    // Result.BitBtn5.TabOrder = 10
    Result.BitBtn5 := NewBitBtn( Result.Form, 'Clear', [  ], glyphLeft, 0, 0 ).SetPosition( 10, 8 );
   {$IFDEF USE_NAMES}
    Result.BitBtn5.Name := 'BitBtn5';
   {$ENDIF}
    Result.BitBtn5.Flat := TRUE;
    Result.BitBtn5.TextShiftX := 1;
    Result.BitBtn5.TextShiftY := 1;
    // Result.BitBtn6.TabOrder = 11
    Result.BitBtn6 := NewBitBtn( Result.Form, 'Add New', [  ], glyphLeft, 0, 0 ).SetPosition( 10, 32 );
   {$IFDEF USE_NAMES}
    Result.BitBtn6.Name := 'BitBtn6';
   {$ENDIF}
    Result.BitBtn6.Flat := TRUE;
    Result.BitBtn6.TextShiftX := 1;
    Result.BitBtn6.TextShiftY := 1;
    // Result.BitBtn7.TabOrder = 12
    Result.BitBtn7 := NewBitBtn( Result.Form, 'Insert', [  ], glyphLeft, 0, 0 ).SetPosition( 10, 56 );
   {$IFDEF USE_NAMES}
    Result.BitBtn7.Name := 'BitBtn7';
   {$ENDIF}
    Result.BitBtn7.Flat := TRUE;
    Result.BitBtn7.TextShiftX := 1;
    Result.BitBtn7.TextShiftY := 1;
    // Result.BitBtn8.TabOrder = 13
    Result.BitBtn8 := NewBitBtn( Result.Form, 'Post', [  ], glyphLeft, 0, 0 ).SetPosition( 10, 80 );
   {$IFDEF USE_NAMES}
    Result.BitBtn8.Name := 'BitBtn8';
   {$ENDIF}
    Result.BitBtn8.Flat := TRUE;
    Result.BitBtn8.TextShiftX := 1;
    Result.BitBtn8.TextShiftY := 1;
    // Result.BitBtn9.TabOrder = 14
    Result.BitBtn9 := NewBitBtn( Result.Form, 'Delete', [  ], glyphLeft, 0, 0 ).SetPosition( 10, 104 );
   {$IFDEF USE_NAMES}
    Result.BitBtn9.Name := 'BitBtn9';
   {$ENDIF}
    Result.BitBtn9.Flat := TRUE;
    Result.BitBtn9.TextShiftX := 1;
    Result.BitBtn9.TextShiftY := 1;
    // Result.BitBtn10.TabOrder = 15
    Result.BitBtn10 := NewBitBtn( Result.Form, 'Save', [  ], glyphLeft, 0, 0 ).SetPosition( 10, 128 );
   {$IFDEF USE_NAMES}
    Result.BitBtn10.Name := 'BitBtn10';
   {$ENDIF}
    Result.BitBtn10.Flat := TRUE;
    Result.BitBtn10.TextShiftX := 1;
    Result.BitBtn10.TextShiftY := 1;
      Result.LV.OnMouseDown := Result.LVMouseDown;
    Result.EName.Color := clWindow;
      Result.BitBtn1.OnClick := Result.BitBtn1Click;
      Result.BitBtn2.OnClick := Result.BitBtn2Click;
      Result.BitBtn3.OnClick := Result.BitBtn3Click;
      Result.BitBtn4.OnClick := Result.BitBtn4Click;
      Result.BitBtn5.OnClick := Result.BitBtn5Click;
      Result.BitBtn6.OnClick := Result.BitBtn6Click;
      Result.BitBtn7.OnClick := Result.BitBtn7Click;
      Result.BitBtn8.OnClick := Result.BitBtn8Click;
      Result.BitBtn9.OnClick := Result.BitBtn9Click;
      Result.BitBtn10.OnClick := Result.BitBtn10Click;
    Result.Form.CenterOnParent;
    Result.KOLForm1FormCreate( Result );

end;
{$ENDIF OldCode}

