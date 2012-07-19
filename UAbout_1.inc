{ KOL MCK } // Do not remove this line!

procedure NewFAbout( var Result: PFAbout; AParent: PControl );
begin

  {$IFDEF KOLCLASSES}
  Result := PFAbout.Create;
  {$ELSE OBJECTS}
  New( Result, Create );
  {$ENDIF KOL CLASSES/OBJECTS}
  Result.Form := NewPanel( AParent, esNone ).MarkPanelAsForm.SetAlign( caClient).SetSize( 435, 375 );
  Result.Form.DF.FormAddress := @ Result.Form;
  Result.Form.DF.FormObj := Result;
    Result.Form.SetClientSize( 419, 337 );
    Result.Form.Font.FontHeight := 14;
    Result.Form.Font.FontName := 'Arial';
      Result.Form.OnShow := Result.KOLFrame1Show;
      Result.Form.OnDestroy := Result.KOLFrame1Destroy;
    Result.L1 := NewLabel( Result.Form, 'copyright' ).SetPosition( 12, 26 ).AutoSize( TRUE );
    Result.L1.Transparent := True;
    Result.LTitle := NewLabel( Result.Form, 'Shollu v..' ).SetPosition( 11, 9 ).AutoSize( TRUE );
    Result.LTitle.Font.FontStyle := [ fsBold ];
    Result.LTitle.Font.FontHeight := 19;
    Result.LTitle.Transparent := True;
    Result.GPMain := NewGradientPanel( Result.Form, clWhite, clWhite ).SetAlign ( caBottom ).SetSize( 0, 58 );
    Result.GPMain.HasBorder := FALSE;
    Result.GPMain.TabStop := FALSE;
      Result.LMail := NewLabel( Result.GPMain, 'mail' ).SetPosition( 12, 8 ).AutoSize( TRUE );
      Result.LMail.Cursor := LoadCursor( 0, IDC_HAND );
      Result.LMail.Transparent := True;
      Result.LWeb := NewLabel( Result.GPMain, 'www..' ).SetPosition( 12, 24 ).AutoSize( TRUE );
      Result.LWeb.Cursor := LoadCursor( 0, IDC_HAND );
      Result.LWeb.Transparent := True;
    Result.BtnHelp := NewButton( Result.Form, 'Help File' ).SetPosition( 13, 256 ).SetSize( 100, 0 );
    Result.BtnHelp.Style := Result.BtnHelp.Style or BS_FLAT;
    Result.Button1 := NewButton( Result.Form, 'Indonesia' ).SetPosition( 261, 256 ).SetSize( 73, 0 );
    Result.Button1.Style := Result.Button1.Style or BS_FLAT;
    Result.Button2 := NewButton( Result.Form, 'English' ).SetPosition( 333, 256 ).SetSize( 73, 0 );
    Result.Button2.Style := Result.Button2.Style or BS_FLAT;
    Result.Memo1 := NewEditBox( Result.Form, [ eoMultiline, eoNoHScroll, eoReadonly ] ).SetPosition( 12, 44 ).SetSize( 397, 205 );
      Result.LMail.OnClick := Result.LMailClick;
      Result.LMail.OnMouseMove := Result.LMailMouseMove;
      Result.LMail.OnMouseLeave := Result.LMailMouseLeave;
      Result.LWeb.OnClick := Result.LWebClick;
      Result.LWeb.OnMouseMove := Result.LWebMouseMove;
      Result.LWeb.OnMouseLeave := Result.LWebMouseLeave;
      Result.Button1.OnClick := Result.Button1Click;
    Result.Memo1.Color := TColor(clWindow);
    {$IFDEF OVERRIDE_SCROLLBARS}
    OverrideScrollbars( Result.Memo1);
    {$ENDIF OVERRIDE_SCROLLBARS}
      Result.BtnHelp.OnClick := Result.BtnHelpClick;
      Result.Button2.OnClick := Result.Button2Click;
    Result.KOLFrame1FormCreate( Result );
    Result.Form.CreateWindow;

end;

