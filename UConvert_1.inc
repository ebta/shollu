{ KOL MCK } // Do not remove this line!

procedure NewFConvert( var Result: PFConvert; AParent: PControl );
begin

  {$IFDEF KOLCLASSES}
  Result := PFConvert.Create;
  {$ELSE OBJECTS}
  New( Result, Create );
  {$ENDIF KOL CLASSES/OBJECTS}
  Result.Form := NewForm( AParent, 'FConvert' ).SetPosition( 394, 273 );
  Result.Form.Add2AutoFree( Result );
    Result.Form.HasBorder := False;
    Result.Form.SetClientSize( 318, 194);
    Result.Form.StayOnTop := True;
    Result.Form.Font.FontHeight := 14;
    Result.Form.Font.FontName := 'Arial';
    Result.Form.Border := 0;
      Result.Form.OnShow := Result.KOLForm1Show;
      Result.Form.OnPaint := Result.KOLForm1Paint;
      Result.Form.OnDestroy := Result.KOLForm1Destroy;
    Result.TopPanel := NewPanel( Result.Form, esNone ).SetAlign ( caTop ).SetSize( 0, 29 ).SetBorder( 2);
      Result.LTitle := NewLabel( Result.TopPanel, 'Konversi' ).SetPosition( 8, 8 ).AutoSize( TRUE );
    Result.LTitle.Font.FontStyle := [ fsBold ];
    Result.LTitle.Font.FontHeight := 16;
      Result.LTitle.Transparent := True;
      Result.ImgIcon := NewImageShow( Result.TopPanel, Form1.ImageList16, 7 ).SetPosition( 294, 7 ).SetSize( 16, 16 );
      Result.ImgIcon.CurIndex := 7; {SetupFirst}
    Result.Button1 := NewButton( Result.Form, 'Button1' ).SetPosition( 48, 152 ).SetBorder( 2);
    Result.GPMain := NewGradientPanel( Result.Form, clWhite, $FF8080 ).SetPosition( 0, 32 ).SetSize( 321, 161 ).SetBorder( 2);
    Result.GPMain.TabStop := FALSE;
    Result.GPMain.HasBorder := TRUE;
      Result.LDiff := NewLabel( Result.GPMain, 'Hijriyah Correction' ).SetPosition( 112, 85 ).SetSize( 120, 15 );
    Result.LDiff.TextAlign := KOL.taRight;
      Result.LDiff.Transparent := True;
      Result.BtnClose := NewButton( Result.GPMain, 'Close' ).SetPosition( 216, 120 ).SetSize( 73, 0 );
      Result.BtnClose.Style := Result.BtnClose.Style or BS_FLAT;
      Result.BtnToday := NewButton( Result.GPMain, 'Today' ).SetPosition( 136, 120 ).SetSize( 73, 0 );
      Result.BtnToday.Style := Result.BtnToday.Style or BS_FLAT;
      Result.CBDateH := NewComboBox( Result.GPMain, [ coReadOnly, coNoIntegralHeight ] ).SetPosition( 152, 48 ).SetSize( 57, 0 );
    Result.CBDateH.Color := TColor(clWindow);
      Result.CBdateM := NewComboBox( Result.GPMain, [ coReadOnly, coNoIntegralHeight ] ).SetPosition( 152, 16 ).SetSize( 57, 0 );
    Result.CBdateM.Color := TColor(clWindow);
      Result.CBMonthH := NewComboBox( Result.GPMain, [ coReadOnly, coNoIntegralHeight ] ).SetPosition( 24, 48 ).SetSize( 121, 0 );
    Result.CBMonthH.Color := TColor(clWindow);
      Result.CBMonthM := NewComboBox( Result.GPMain, [ coReadOnly, coNoIntegralHeight ] ).SetPosition( 24, 16 ).SetSize( 121, 0 );
    Result.CBMonthM.Color := TColor(clWindow);
      Result.CBYearH := NewComboBox( Result.GPMain, [ coNoIntegralHeight ] ).SetPosition( 216, 48 ).SetSize( 81, 0 );
    Result.CBYearH.Color := TColor(clWindow);
      Result.CBYearM := NewComboBox( Result.GPMain, [ coNoIntegralHeight ] ).SetPosition( 216, 16 ).SetSize( 81, 0 );
    Result.CBYearM.Color := TColor(clWindow);
      Result.EBDay := NewEditBox( Result.GPMain, [  ] ).SetPosition( 24, 80 ).SetSize( 81, 0 );
      Result.EBDay.Enabled := False;
      Result.cbDiff := NewComboBox( Result.GPMain, [ coReadOnly, coNoIntegralHeight ] ).SetPosition( 240, 80 ).SetSize( 57, 0 );
    Result.cbDiff.Color := TColor(clWindow);
      Result.cbDiff.Items[ 0 ] := '-2';
      Result.cbDiff.Items[ 1 ] := '-1';
      Result.cbDiff.Items[ 2 ] := '0';
      Result.cbDiff.Items[ 3 ] := '1';
      Result.cbDiff.Items[ 4 ] := '2';
      Result.cbDiff.CurIndex := 2;
      Result.ImgIcon.OnMouseDown := Result.ImgIconMouseDown;
      Result.ImgIcon.OnMouseMove := Result.ImgIconMouseMove;
      Result.ImgIcon.OnMouseUp := Result.ImgIconMouseUp;
      Result.ImgIcon.OnMouseLeave := Result.ImgIconMouseLeave;
      Result.CBdateM.OnChange := Result.CBdateMChange;
      Result.CBMonthM.OnChange := Result.CBMonthMChange;
      Result.CBYearM.OnChange := Result.CBdateMChange;
      Result.CBDateH.OnChange := Result.CBDateHChange;
      Result.TopPanel.OnMouseDown := Result.TopPanelMouseDown;
      Result.TopPanel.OnPaint := Result.TopPanelPaint;
      Result.CBYearH.OnChange := Result.CBDateHChange;
      Result.BtnClose.OnClick := Result.BtnCloseClick;
      Result.BtnToday.OnClick := Result.BtnTodayClick;
    Result.EBDay.Color := TColor(clWindow);
      Result.cbDiff.OnChange := Result.cbDiffChange;
      Result.CBMonthH.OnChange := Result.CBDateHChange;
    Result.Form.CenterOnParent;
    Result.KOLForm1FormCreate( Result );

end;

