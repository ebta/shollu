{ KOL MCK } // Do not remove this line!

procedure NewFMessage( var Result: PFMessage; AParent: PControl );
begin

  {$IFDEF KOLCLASSES}
  Result := PFMessage.Create;
  {$ELSE OBJECTS}
  New( Result, Create );
  {$ENDIF KOL CLASSES/OBJECTS}
  Result.Form := NewPanel( AParent, esNone ).MarkPanelAsForm.SetAlign( caClient).SetSize( 425, 371 );
  Result.Form.DF.FormAddress := @ Result.Form;
  Result.Form.DF.FormObj := Result;
    Result.Form.SetClientSize( 409, 333 );
    Result.Form.Font.FontHeight := 14;
    Result.Form.Font.FontName := 'arial';
      Result.Form.OnShow := Result.KOLFrame1Show;
      Result.Form.OnDestroy := Result.KOLFrame1Destroy;
    Result.GB3 := NewGroupBox( Result.Form, ' After' ).SetPosition( 8, 161 ).SetSize( 393, 65 );
    Result.GB3.TabStop := FALSE;
    Result.GB3.TextAlign := KOL.taCenter;
    Result.GB3.Transparent := True;
      Result.CB6 := NewCheckBox( Result.GB3, '--' ).SetPosition( 13, 17 ).AutoSize( TRUE );
      Result.CB6.EraseBackground := TRUE;
      Result.CB7 := NewCheckBox( Result.GB3, '--' ).SetPosition( 13, 41 ).AutoSize( TRUE );
      Result.CBHibernateAfter := NewCheckBox( Result.GB3, '--' ).SetPosition( 125, 41 ).AutoSize( TRUE );
      Result.EBMsg2 := NewEditBox( Result.GB3, [ eoNumber ] ).SetPosition( 125, 17 ).SetSize( 33, 20 );
      Result.EBMsg2.Text := '5';
      Result.EBShutdown := NewEditBox( Result.GB3, [ eoNumber ] ).SetPosition( 237, 39 ).SetSize( 33, 20 );
      Result.EBShutdown.Text := '5';
    Result.GB1 := NewGroupBox( Result.Form, 'Before' ).SetPosition( 8, 1 ).SetSize( 393, 49 );
    Result.GB1.TabStop := FALSE;
    Result.GB1.TextAlign := KOL.taCenter;
      Result.CB1 := NewCheckBox( Result.GB1, '----' ).SetPosition( 13, 21 ).AutoSize( TRUE );
      Result.EBMsg1 := NewEditBox( Result.GB1, [ eoNumber ] ).SetPosition( 125, 20 ).SetSize( 33, 20 );
      Result.EBMsg1.Text := '5';
    Result.GPmain := NewGradientPanel( Result.Form, clWhite, clWhite ).SetAlign ( caBottom ).SetSize( 0, 110 );
    Result.GPmain.HasBorder := FALSE;
    Result.GPmain.TabStop := FALSE;
      Result.Lbl4 := NewLabel( Result.GPmain, 'minutes' ).SetPosition( 234, 39 ).AutoSize( TRUE );
      Result.Lbl4.Transparent := True;
      Result.CB8 := NewCheckBox( Result.GPmain, '---' ).SetPosition( 10, 14 ).AutoSize( TRUE );
      Result.CB8.Transparent := True;
      Result.CB9 := NewCheckBox( Result.GPmain, '--' ).SetPosition( 10, 38 ).AutoSize( TRUE );
      Result.CB9.Transparent := True;
      Result.BtnSave := NewBitBtn( Result.GPmain, 'Save', [ bboImageList ], glyphLeft, Form1.ImageList16.Handle, 4 ).SetPosition( 307, 68 ).SetSize( 90, 29 ).LikeSpeedButton.LikeSpeedButton;
      Result.BtnSave.Transparent := True;
      Result.DateJumat := NewDateTimePicker( Result.GPmain, [dtpoTime,dtpoUpDown] ).SetPosition( 186, 13 ).SetSize( 97, 21 );
      Result.DateJumat.DateTimeFormat := 'HH:mm:ss';
      Result.EBInfo := NewEditBox( Result.GPmain, [ eoNumber ] ).SetPosition( 186, 36 ).SetSize( 41, 0 );
    Result.EBInfo.TextAlign := KOL.taCenter;
      Result.EBInfo.Text := '10';
    Result.GBMain := NewGroupBox( Result.Form, 'On' ).SetPosition( 8, 54 ).SetSize( 393, 103 );
    Result.GBMain.TabStop := FALSE;
    Result.GBMain.TextAlign := KOL.taCenter;
      Result.CB2 := NewCheckBox( Result.GBMain, '----' ).SetPosition( 13, 14 ).AutoSize( TRUE );
      Result.CB3 := NewCheckBox( Result.GBMain, '---' ).SetPosition( 13, 35 ).AutoSize( TRUE );
      Result.CB4 := NewCheckBox( Result.GBMain, '--' ).SetPosition( 13, 56 ).AutoSize( TRUE );
      Result.CB5 := NewCheckBox( Result.GBMain, '--' ).SetPosition( 13, 78 ).AutoSize( TRUE );
      Result.CBHibernate := NewCheckBox( Result.GBMain, '--' ).SetPosition( 125, 78 ).AutoSize( TRUE );
    Result.Button1 := NewButton( Result.Form, 'Button1' ).SetPosition( 336, 236 );
      Result.BtnSave.OnClick := Result.BtnSaveClick;
      Result.BtnSave.OnMouseMove := Result.BtnSaveMouseMove;
      Result.BtnSave.OnMouseLeave := Result.BtnSaveMouseLeave;
      Result.CB8.OnClick := Result.CB8Click;
      Result.CB9.OnClick := Result.CB9Click;
    Result.EBInfo.Color := TColor(clWindow);
      Result.CB5.OnClick := Result.CB5Click;
    Result.EBShutdown.Color := TColor(clWindow);
      Result.CBHibernateAfter.OnClick := Result.CBHibernateAfterClick;
      Result.CB7.OnClick := Result.CB7Click;
      Result.CB6.OnClick := Result.CB6Click;
    Result.EBMsg2.Color := TColor(clWindow);
      Result.CB1.OnClick := Result.CB1Click;
    Result.EBMsg1.Color := TColor(clWindow);
      Result.CBHibernate.OnClick := Result.CBHibernateClick;
    Result.Form.CreateWindow;

end;

