{ KOL MCK } // Do not remove this line!

procedure NewFDialog( var Result: PFDialog; AParent: PControl );
begin

  {$IFDEF KOLCLASSES}
  Result := PFDialog.Create;
  {$ELSE OBJECTS}
  New( Result, Create );
  {$ENDIF KOL CLASSES/OBJECTS}
  Result.Form := NewForm( AParent, 'Shollu3' ).SetPosition( 394, 330 );
  Result.Form.Add2AutoFree( Result );
    Result.Form.HasBorder := False;
    Result.Form.SetClientSize( 310, 168);
    Result.Form.StayOnTop := True;
    Result.Form.Font.FontHeight := 14;
    Result.Form.Font.FontName := 'Arial';
    Result.Form.Border := 0;
      Result.Form.OnClose := Result.KOLForm1Close;
      Result.Form.OnKeyUp := Result.KOLForm1KeyUp;
      Result.Form.OnShow := Result.KOLForm1Show;
      Result.Form.OnPaint := Result.KOLForm1Paint;
      Result.Form.OnDestroy := Result.KOLForm1Destroy;

    Result.TimerAutoClose := NewTimer( 1000 );
  Result.Form.Add2AutoFree( Result.TimerAutoClose );
      Result.TimerAutoClose.OnTimer := Result.TimerAutoCloseTimer;

    Result.TimerBlend := NewTimer( 50 );
  Result.Form.Add2AutoFree( Result.TimerBlend );
      Result.TimerBlend.OnTimer := Result.TimerBlendTimer;

    Result.TimerEffect := NewMMTimer( 10 );
  Result.Form.Add2AutoFree( Result.TimerEffect );
      Result.TimerEffect.OnTimer := Result.TimerEffectTimer;
    Result.LblCaption := NewLabel( Result.Form, 'Information' ).SetPosition( 72, 48 ).SetSize( 225, 57 ).MakeWordWrap.SetBorder( 2);
    Result.LblCaption.Transparent := True;
    Result.LblCaption.Color := TColor(clBtnFace);
    Result.LInfo := NewLabel( Result.Form, 'Info' ).SetPosition( 14, 82 ).AutoSize( TRUE ).SetBorder( 2);
    Result.LInfo.Font.FontStyle := [ fsBold ];
    Result.LInfo.Visible := False;
    Result.LInfo.Transparent := True;
    Result.PanelTop := NewPanel( Result.Form, esNone ).SetAlign ( caTop ).SetSize( 0, 29 ).SetBorder( 0);
      Result.LTitle := NewLabel( Result.PanelTop, 'Shollu v3.00' ).SetPosition( 11, 7 ).AutoSize( TRUE ).SetBorder( 2);
    Result.LTitle.Font.FontStyle := [ fsBold ];
      Result.LTitle.Transparent := True;
      Result.ImgIcon := NewImageShow( Result.PanelTop, Form1.ImageList16, 7 ).SetPosition( 288, 7 ).SetSize( 16, 16 ).SetBorder( 2);
      Result.ImgIcon.CurIndex := 7; {SetupFirst}
    Result.PBIcon := NewPaintBox( Result.Form ).SetPosition( 20, 48 ).SetSize( 33, 33 ).SetBorder( 0);
    Result.PBIcon.Transparent := True;
    Result.GPBottom := NewGradientPanel( Result.Form, clBlue, clNavy ).SetPosition( 2, 112 ).SetSize( 305, 64 ).SetBorder( 2);
    Result.GPBottom.HasBorder := FALSE;
    Result.GPBottom.TabStop := FALSE;
      Result.LblCR := NewLabel( Result.GPBottom, 'Shollu v3.00 copyrights ©2006 by Ebta Setiawan' ).SetPosition( 50, 46 ).AutoSize( TRUE );
    Result.LblCR.Font.FontHeight := 12;
      Result.Btn1 := NewBitBtn( Result.GPBottom, 'OK', [  ], glyphLeft, 0, 0 ).SetPosition( 80, 16 ).SetSize( 73, 25 );
    Result.Btn1.Font.FontStyle := [ fsBold ];
      Result.Btn1.Transparent := True;
      Result.Btn2 := NewBitBtn( Result.GPBottom, 'Cancel', [  ], glyphLeft, 0, 0 ).SetPosition( 168, 16 ).SetSize( 73, 25 );
    Result.Btn2.Font.FontStyle := [ fsBold ];
      Result.Btn2.Transparent := True;
    Result.TimerAutoClose.Enabled := True;
      Result.ImgIcon.OnMouseDown := Result.ImgIconMouseDown;
      Result.ImgIcon.OnMouseMove := Result.ImgIconMouseMove;
      Result.ImgIcon.OnMouseUp := Result.ImgIconMouseUp;
      Result.ImgIcon.OnMouseLeave := Result.ImgIconMouseLeave;
      Result.LTitle.OnMouseDown := Result.PanelTopMouseDown;
      Result.PBIcon.OnPaint := Result.PBIconPaint;
      Result.Btn1.OnClick := Result.Btn1Click;
      Result.Btn1.OnKeyUp := Result.Btn1KeyUp;
      Result.PanelTop.OnMouseDown := Result.PanelTopMouseDown;
      Result.PanelTop.OnPaint := Result.PanelTopPaint;
      Result.Btn2.OnClick := Result.Btn2Click;
      Result.Btn2.OnKeyUp := Result.Btn2KeyUp;
    Result.Form.CenterOnParent;
    Result.KOLForm1FormCreate( Result );

end;

