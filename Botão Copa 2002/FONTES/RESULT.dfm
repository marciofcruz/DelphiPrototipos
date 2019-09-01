object frmresultado: Tfrmresultado
  Left = 52
  Top = -7
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Resultados'
  ClientHeight = 533
  ClientWidth = 726
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btngravar: TButton
    Left = 266
    Top = 489
    Width = 75
    Height = 25
    Caption = '&Gravar'
    TabOrder = 3
    OnClick = btngravarClick
  end
  object btnfechar: TButton
    Left = 358
    Top = 489
    Width = 75
    Height = 25
    Caption = '&Fechar'
    TabOrder = 4
    OnClick = btnfecharClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 726
    Height = 149
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object grbA: TGroupBox
      Left = 0
      Top = 0
      Width = 181
      Height = 149
      Align = alLeft
      Caption = 'Grupo A'
      TabOrder = 0
      object lblselecao1_1: TLabel
        Left = 44
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object Label3: TLabel
        Left = 108
        Top = 16
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object lblselecao1_2: TLabel
        Left = 144
        Top = 16
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao2_2: TLabel
        Left = 144
        Top = 37
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object Label7: TLabel
        Left = 108
        Top = 37
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object lblselecao2_1: TLabel
        Left = 44
        Top = 37
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao3_2: TLabel
        Left = 144
        Top = 59
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao3_1: TLabel
        Left = 44
        Top = 59
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object Label15: TLabel
        Left = 108
        Top = 59
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label16: TLabel
        Left = 108
        Top = 81
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label17: TLabel
        Left = 108
        Top = 103
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label18: TLabel
        Left = 108
        Top = 125
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object lblselecao4_1: TLabel
        Left = 44
        Top = 81
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao4_2: TLabel
        Left = 144
        Top = 81
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao5_2: TLabel
        Left = 144
        Top = 103
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao5_1: TLabel
        Left = 44
        Top = 103
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao6_1: TLabel
        Left = 44
        Top = 125
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao6_2: TLabel
        Left = 144
        Top = 125
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object edtplacar4_2: TFPEditFloat
        Left = 114
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 11
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar3_1: TFPEditFloat
        Left = 77
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 7
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar3_2: TFPEditFloat
        Left = 114
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 8
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar2_1: TFPEditFloat
        Left = 77
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 4
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar2_2: TFPEditFloat
        Left = 114
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 5
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar1_2: TFPEditFloat
        Left = 114
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 2
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object ckbencerrado1: TCheckBox
        Left = 4
        Top = 15
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 0
      end
      object ckbencerrado2: TCheckBox
        Left = 4
        Top = 35
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 3
      end
      object ckbencerrado3: TCheckBox
        Left = 4
        Top = 57
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 6
      end
      object ckbencerrado4: TCheckBox
        Left = 4
        Top = 79
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 9
      end
      object ckbencerrado5: TCheckBox
        Left = 4
        Top = 101
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 12
      end
      object ckbencerrado6: TCheckBox
        Left = 4
        Top = 123
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 15
      end
      object edtplacar1_1: TFPEditFloat
        Left = 77
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 1
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar4_1: TFPEditFloat
        Left = 77
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 10
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar5_1: TFPEditFloat
        Left = 77
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 13
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar5_2: TFPEditFloat
        Left = 114
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 14
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar6_1: TFPEditFloat
        Left = 77
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 16
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar6_2: TFPEditFloat
        Left = 114
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 17
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
    end
    object grbB: TGroupBox
      Left = 181
      Top = 0
      Width = 181
      Height = 149
      Align = alLeft
      Caption = 'Grupo B'
      TabOrder = 1
      object lblselecao7_1: TLabel
        Left = 44
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao7_2: TLabel
        Left = 144
        Top = 16
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao8_2: TLabel
        Left = 144
        Top = 37
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao8_1: TLabel
        Left = 44
        Top = 37
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao9_2: TLabel
        Left = 144
        Top = 59
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao9_1: TLabel
        Left = 44
        Top = 59
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao10_1: TLabel
        Left = 44
        Top = 81
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao10_2: TLabel
        Left = 144
        Top = 81
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao11_2: TLabel
        Left = 144
        Top = 103
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao11_1: TLabel
        Left = 44
        Top = 103
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao12_1: TLabel
        Left = 44
        Top = 125
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao12_2: TLabel
        Left = 144
        Top = 125
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object Label1: TLabel
        Left = 108
        Top = 16
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label26: TLabel
        Left = 108
        Top = 37
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label32: TLabel
        Left = 108
        Top = 59
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label33: TLabel
        Left = 108
        Top = 81
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label35: TLabel
        Left = 108
        Top = 103
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label39: TLabel
        Left = 108
        Top = 125
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object ckbencerrado7: TCheckBox
        Left = 4
        Top = 15
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 0
      end
      object ckbencerrado8: TCheckBox
        Left = 4
        Top = 35
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 3
      end
      object ckbencerrado9: TCheckBox
        Left = 4
        Top = 57
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 6
      end
      object ckbencerrado10: TCheckBox
        Left = 4
        Top = 79
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 9
      end
      object ckbencerrado11: TCheckBox
        Left = 4
        Top = 101
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 12
      end
      object ckbencerrado12: TCheckBox
        Left = 4
        Top = 123
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 15
      end
      object edtplacar7_1: TFPEditFloat
        Left = 77
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 1
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar7_2: TFPEditFloat
        Left = 114
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 2
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar8_1: TFPEditFloat
        Left = 77
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 4
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar8_2: TFPEditFloat
        Left = 114
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 5
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar9_1: TFPEditFloat
        Left = 77
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 7
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar10_1: TFPEditFloat
        Left = 77
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 10
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar9_2: TFPEditFloat
        Left = 114
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 8
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar10_2: TFPEditFloat
        Left = 114
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 11
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar11_1: TFPEditFloat
        Left = 77
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 13
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar11_2: TFPEditFloat
        Left = 114
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 14
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar12_1: TFPEditFloat
        Left = 77
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 16
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar12_2: TFPEditFloat
        Left = 114
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 17
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
    end
    object grbC: TGroupBox
      Left = 362
      Top = 0
      Width = 181
      Height = 149
      Align = alLeft
      Caption = 'Grupo C'
      TabOrder = 2
      object lblselecao13_1: TLabel
        Left = 44
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao13_2: TLabel
        Left = 144
        Top = 16
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao14_2: TLabel
        Left = 144
        Top = 37
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao14_1: TLabel
        Left = 44
        Top = 37
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao15_2: TLabel
        Left = 144
        Top = 59
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao15_1: TLabel
        Left = 44
        Top = 59
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao16_1: TLabel
        Left = 44
        Top = 81
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao16_2: TLabel
        Left = 144
        Top = 81
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao17_2: TLabel
        Left = 144
        Top = 103
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao17_1: TLabel
        Left = 44
        Top = 103
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao18_1: TLabel
        Left = 44
        Top = 125
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao18_2: TLabel
        Left = 144
        Top = 125
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object Label2: TLabel
        Left = 108
        Top = 16
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label6: TLabel
        Left = 108
        Top = 37
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label11: TLabel
        Left = 108
        Top = 59
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label12: TLabel
        Left = 108
        Top = 81
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label13: TLabel
        Left = 108
        Top = 103
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label14: TLabel
        Left = 108
        Top = 125
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object ckbencerrado13: TCheckBox
        Left = 4
        Top = 15
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 0
      end
      object ckbencerrado14: TCheckBox
        Left = 4
        Top = 35
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 3
      end
      object ckbencerrado15: TCheckBox
        Left = 4
        Top = 57
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 6
      end
      object ckbencerrado16: TCheckBox
        Left = 4
        Top = 79
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 9
      end
      object ckbencerrado17: TCheckBox
        Left = 4
        Top = 101
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 12
      end
      object ckbencerrado18: TCheckBox
        Left = 4
        Top = 123
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 15
      end
      object edtplacar13_1: TFPEditFloat
        Left = 77
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 1
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar13_2: TFPEditFloat
        Left = 114
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 2
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar14_1: TFPEditFloat
        Left = 77
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 4
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar14_2: TFPEditFloat
        Left = 114
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 5
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar15_1: TFPEditFloat
        Left = 77
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 7
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar16_1: TFPEditFloat
        Left = 77
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 10
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar15_2: TFPEditFloat
        Left = 114
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 8
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar16_2: TFPEditFloat
        Left = 114
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 11
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar17_1: TFPEditFloat
        Left = 77
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 13
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar17_2: TFPEditFloat
        Left = 114
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 14
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar18_1: TFPEditFloat
        Left = 77
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 16
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar18_2: TFPEditFloat
        Left = 114
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 17
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
    end
    object grbD: TGroupBox
      Left = 543
      Top = 0
      Width = 181
      Height = 149
      Align = alLeft
      Caption = 'Grupo D'
      TabOrder = 3
      object lblselecao19_1: TLabel
        Left = 44
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao19_2: TLabel
        Left = 144
        Top = 16
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao20_2: TLabel
        Left = 144
        Top = 37
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao20_1: TLabel
        Left = 44
        Top = 37
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao21_2: TLabel
        Left = 144
        Top = 59
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao21_1: TLabel
        Left = 44
        Top = 59
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao22_1: TLabel
        Left = 44
        Top = 81
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao22_2: TLabel
        Left = 144
        Top = 81
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao23_2: TLabel
        Left = 144
        Top = 103
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao23_1: TLabel
        Left = 44
        Top = 103
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao24_1: TLabel
        Left = 44
        Top = 125
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao24_2: TLabel
        Left = 144
        Top = 125
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object Label4: TLabel
        Left = 108
        Top = 16
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label9: TLabel
        Left = 108
        Top = 37
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label21: TLabel
        Left = 108
        Top = 59
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label22: TLabel
        Left = 108
        Top = 81
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label23: TLabel
        Left = 108
        Top = 103
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label24: TLabel
        Left = 108
        Top = 125
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object ckbencerrado19: TCheckBox
        Left = 4
        Top = 15
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 0
      end
      object ckbencerrado20: TCheckBox
        Left = 4
        Top = 35
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 3
      end
      object ckbencerrado21: TCheckBox
        Left = 4
        Top = 57
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 6
      end
      object ckbencerrado22: TCheckBox
        Left = 4
        Top = 79
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 9
      end
      object ckbencerrado23: TCheckBox
        Left = 4
        Top = 101
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 12
      end
      object ckbencerrado24: TCheckBox
        Left = 4
        Top = 123
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 15
      end
      object edtplacar19_1: TFPEditFloat
        Left = 77
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 1
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar19_2: TFPEditFloat
        Left = 114
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 2
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar20_1: TFPEditFloat
        Left = 77
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 4
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar20_2: TFPEditFloat
        Left = 114
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 5
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar21_1: TFPEditFloat
        Left = 77
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 7
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar22_1: TFPEditFloat
        Left = 77
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 10
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar21_2: TFPEditFloat
        Left = 114
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 8
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar22_2: TFPEditFloat
        Left = 114
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 11
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar23_1: TFPEditFloat
        Left = 77
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 13
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar23_2: TFPEditFloat
        Left = 114
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 14
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar24_1: TFPEditFloat
        Left = 77
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 16
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar24_2: TFPEditFloat
        Left = 114
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 17
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 149
    Width = 726
    Height = 149
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object grbE: TGroupBox
      Left = 0
      Top = 0
      Width = 181
      Height = 149
      Align = alLeft
      Caption = 'Grupo E'
      TabOrder = 0
      object lblselecao30_2: TLabel
        Left = 144
        Top = 125
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao25_1: TLabel
        Left = 44
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao25_2: TLabel
        Left = 144
        Top = 16
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao26_2: TLabel
        Left = 144
        Top = 37
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao26_1: TLabel
        Left = 44
        Top = 37
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao27_2: TLabel
        Left = 144
        Top = 59
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao27_1: TLabel
        Left = 44
        Top = 59
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao28_1: TLabel
        Left = 44
        Top = 81
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao28_2: TLabel
        Left = 144
        Top = 81
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao29_2: TLabel
        Left = 144
        Top = 103
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao29_1: TLabel
        Left = 44
        Top = 103
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao30_1: TLabel
        Left = 44
        Top = 125
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object Label5: TLabel
        Left = 108
        Top = 16
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label19: TLabel
        Left = 108
        Top = 37
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label27: TLabel
        Left = 108
        Top = 59
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label28: TLabel
        Left = 108
        Top = 81
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label29: TLabel
        Left = 108
        Top = 103
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label30: TLabel
        Left = 108
        Top = 125
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object ckbencerrado25: TCheckBox
        Left = 4
        Top = 15
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 0
      end
      object ckbencerrado26: TCheckBox
        Left = 4
        Top = 35
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 3
      end
      object ckbencerrado27: TCheckBox
        Left = 4
        Top = 57
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 6
      end
      object ckbencerrado28: TCheckBox
        Left = 4
        Top = 79
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 9
      end
      object ckbencerrado29: TCheckBox
        Left = 4
        Top = 101
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 12
      end
      object ckbencerrado30: TCheckBox
        Left = 4
        Top = 123
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 15
      end
      object edtplacar25_1: TFPEditFloat
        Left = 77
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 1
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar25_2: TFPEditFloat
        Left = 114
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 2
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar26_1: TFPEditFloat
        Left = 77
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 4
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar26_2: TFPEditFloat
        Left = 114
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 5
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar27_1: TFPEditFloat
        Left = 77
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 7
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar28_1: TFPEditFloat
        Left = 77
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 10
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar27_2: TFPEditFloat
        Left = 114
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 8
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar28_2: TFPEditFloat
        Left = 114
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 11
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar29_1: TFPEditFloat
        Left = 77
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 13
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar29_2: TFPEditFloat
        Left = 114
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 14
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar30_1: TFPEditFloat
        Left = 77
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 16
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar30_2: TFPEditFloat
        Left = 114
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 17
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
    end
    object grbF: TGroupBox
      Left = 181
      Top = 0
      Width = 181
      Height = 149
      Align = alLeft
      Caption = 'Grupo F'
      TabOrder = 1
      object lblselecao31_1: TLabel
        Left = 44
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao31_2: TLabel
        Left = 144
        Top = 16
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao32_2: TLabel
        Left = 144
        Top = 37
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao32_1: TLabel
        Left = 44
        Top = 37
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao33_2: TLabel
        Left = 144
        Top = 59
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao33_1: TLabel
        Left = 44
        Top = 59
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao34_1: TLabel
        Left = 44
        Top = 81
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao34_2: TLabel
        Left = 144
        Top = 81
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao35_2: TLabel
        Left = 144
        Top = 103
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao35_1: TLabel
        Left = 44
        Top = 103
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao36_1: TLabel
        Left = 44
        Top = 125
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao36_2: TLabel
        Left = 144
        Top = 125
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object Label8: TLabel
        Left = 108
        Top = 16
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label25: TLabel
        Left = 108
        Top = 37
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label34: TLabel
        Left = 108
        Top = 59
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label36: TLabel
        Left = 108
        Top = 81
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label37: TLabel
        Left = 108
        Top = 103
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label38: TLabel
        Left = 108
        Top = 125
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object ckbencerrado31: TCheckBox
        Left = 4
        Top = 15
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 0
      end
      object ckbencerrado32: TCheckBox
        Left = 4
        Top = 35
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 3
      end
      object ckbencerrado33: TCheckBox
        Left = 4
        Top = 57
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 6
      end
      object ckbencerrado34: TCheckBox
        Left = 4
        Top = 79
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 9
      end
      object ckbencerrado35: TCheckBox
        Left = 4
        Top = 101
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 12
      end
      object ckbencerrado36: TCheckBox
        Left = 4
        Top = 123
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 15
      end
      object edtplacar31_1: TFPEditFloat
        Left = 77
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 1
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar31_2: TFPEditFloat
        Left = 114
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 2
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar32_1: TFPEditFloat
        Left = 77
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 4
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar32_2: TFPEditFloat
        Left = 114
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 5
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar33_1: TFPEditFloat
        Left = 77
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 7
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar34_1: TFPEditFloat
        Left = 77
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 10
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar33_2: TFPEditFloat
        Left = 114
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 8
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar34_2: TFPEditFloat
        Left = 114
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 11
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar35_1: TFPEditFloat
        Left = 77
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 13
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar35_2: TFPEditFloat
        Left = 114
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 14
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar36_1: TFPEditFloat
        Left = 77
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 16
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar36_2: TFPEditFloat
        Left = 114
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 17
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
    end
    object grbG: TGroupBox
      Left = 362
      Top = 0
      Width = 181
      Height = 149
      Align = alLeft
      Caption = 'Grupo G'
      TabOrder = 2
      object lblselecao37_1: TLabel
        Left = 44
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao37_2: TLabel
        Left = 144
        Top = 16
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao38_2: TLabel
        Left = 144
        Top = 37
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao38_1: TLabel
        Left = 44
        Top = 37
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao39_2: TLabel
        Left = 144
        Top = 59
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao39_1: TLabel
        Left = 44
        Top = 59
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao40_1: TLabel
        Left = 44
        Top = 81
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao40_2: TLabel
        Left = 144
        Top = 81
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao41_2: TLabel
        Left = 144
        Top = 103
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao41_1: TLabel
        Left = 44
        Top = 103
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao42_1: TLabel
        Left = 44
        Top = 125
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao42_2: TLabel
        Left = 144
        Top = 125
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object Label10: TLabel
        Left = 108
        Top = 16
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label31: TLabel
        Left = 108
        Top = 37
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label40: TLabel
        Left = 108
        Top = 59
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label41: TLabel
        Left = 108
        Top = 81
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label42: TLabel
        Left = 108
        Top = 103
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label44: TLabel
        Left = 108
        Top = 125
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object ckbencerrado37: TCheckBox
        Left = 4
        Top = 15
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 0
      end
      object ckbencerrado38: TCheckBox
        Left = 4
        Top = 35
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 3
      end
      object ckbencerrado39: TCheckBox
        Left = 4
        Top = 57
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 6
      end
      object ckbencerrado40: TCheckBox
        Left = 4
        Top = 79
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 9
      end
      object ckbencerrado41: TCheckBox
        Left = 4
        Top = 101
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 12
      end
      object ckbencerrado42: TCheckBox
        Left = 4
        Top = 123
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 15
      end
      object edtplacar37_1: TFPEditFloat
        Left = 77
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 1
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar37_2: TFPEditFloat
        Left = 114
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 2
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar38_1: TFPEditFloat
        Left = 77
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 4
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar38_2: TFPEditFloat
        Left = 114
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 5
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar39_1: TFPEditFloat
        Left = 77
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 7
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar40_1: TFPEditFloat
        Left = 77
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 10
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar39_2: TFPEditFloat
        Left = 114
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 8
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar40_2: TFPEditFloat
        Left = 114
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 11
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar41_1: TFPEditFloat
        Left = 77
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 13
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar41_2: TFPEditFloat
        Left = 114
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 14
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar42_1: TFPEditFloat
        Left = 77
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 16
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar42_2: TFPEditFloat
        Left = 114
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 17
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
    end
    object grbH: TGroupBox
      Left = 543
      Top = 0
      Width = 181
      Height = 149
      Align = alLeft
      Caption = 'Grupo H'
      TabOrder = 3
      object lblselecao43_1: TLabel
        Left = 44
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao43_2: TLabel
        Left = 144
        Top = 16
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao44_2: TLabel
        Left = 144
        Top = 37
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao44_1: TLabel
        Left = 44
        Top = 37
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao45_2: TLabel
        Left = 144
        Top = 59
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao45_1: TLabel
        Left = 44
        Top = 59
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao46_1: TLabel
        Left = 44
        Top = 81
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao46_2: TLabel
        Left = 144
        Top = 81
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao47_2: TLabel
        Left = 144
        Top = 103
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao47_1: TLabel
        Left = 44
        Top = 103
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao48_1: TLabel
        Left = 44
        Top = 125
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao48_2: TLabel
        Left = 144
        Top = 125
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object Label20: TLabel
        Left = 108
        Top = 16
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label43: TLabel
        Left = 108
        Top = 37
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label45: TLabel
        Left = 108
        Top = 59
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label46: TLabel
        Left = 108
        Top = 81
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label47: TLabel
        Left = 108
        Top = 103
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object Label48: TLabel
        Left = 108
        Top = 125
        Width = 5
        Height = 13
        Caption = 'x'
      end
      object ckbencerrado43: TCheckBox
        Left = 4
        Top = 15
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 0
      end
      object ckbencerrado44: TCheckBox
        Left = 4
        Top = 35
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 3
      end
      object ckbencerrado45: TCheckBox
        Left = 4
        Top = 57
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 6
      end
      object ckbencerrado46: TCheckBox
        Left = 4
        Top = 79
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 9
      end
      object ckbencerrado47: TCheckBox
        Left = 4
        Top = 101
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 12
      end
      object ckbencerrado48: TCheckBox
        Left = 4
        Top = 123
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 15
      end
      object edtplacar43_1: TFPEditFloat
        Left = 77
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 1
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar43_2: TFPEditFloat
        Left = 114
        Top = 12
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 2
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar44_1: TFPEditFloat
        Left = 77
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 4
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar44_2: TFPEditFloat
        Left = 114
        Top = 34
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 5
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar45_1: TFPEditFloat
        Left = 77
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 7
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar46_1: TFPEditFloat
        Left = 77
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 10
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar45_2: TFPEditFloat
        Left = 114
        Top = 56
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 8
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar46_2: TFPEditFloat
        Left = 114
        Top = 78
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 11
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar47_1: TFPEditFloat
        Left = 77
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 13
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar47_2: TFPEditFloat
        Left = 114
        Top = 100
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 14
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar48_1: TFPEditFloat
        Left = 77
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 16
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
      object edtplacar48_2: TFPEditFloat
        Left = 114
        Top = 122
        Width = 29
        Height = 21
        MaxLength = 2
        TabOrder = 17
        Text = '0'
        Decimal = 0
        Max = 99
        Alignment = taRightJustify
        ErrorMessage = '[No Text]'
      end
    end
  end
  object panclassificacao: TPanel
    Left = 0
    Top = 298
    Width = 726
    Height = 190
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object grboitavas: TGroupBox
      Left = 0
      Top = 0
      Width = 181
      Height = 190
      Align = alLeft
      Caption = 'Oitavas-de-final'
      TabOrder = 0
      object lblselecao49_1: TLabel
        Left = 44
        Top = 19
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao49_2: TLabel
        Left = 136
        Top = 19
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao50_2: TLabel
        Left = 136
        Top = 40
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao50_1: TLabel
        Left = 44
        Top = 40
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao51_1: TLabel
        Left = 44
        Top = 61
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao51_2: TLabel
        Left = 136
        Top = 61
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao52_1: TLabel
        Left = 44
        Top = 82
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao52_2: TLabel
        Left = 136
        Top = 82
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao53_1: TLabel
        Left = 44
        Top = 103
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao54_1: TLabel
        Left = 44
        Top = 124
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao55_1: TLabel
        Left = 44
        Top = 145
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao56_1: TLabel
        Left = 44
        Top = 166
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'WWW'
      end
      object lblselecao53_2: TLabel
        Left = 136
        Top = 103
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao54_2: TLabel
        Left = 136
        Top = 124
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao55_2: TLabel
        Left = 136
        Top = 145
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object lblselecao56_2: TLabel
        Left = 136
        Top = 166
        Width = 33
        Height = 13
        Caption = 'WWW'
      end
      object ckbencerrado49: TCheckBox
        Left = 4
        Top = 16
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 0
      end
      object ckbencerrado50: TCheckBox
        Left = 4
        Top = 37
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 2
      end
      object ckbencerrado51: TCheckBox
        Left = 4
        Top = 59
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 4
      end
      object ckbencerrado52: TCheckBox
        Left = 4
        Top = 80
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 6
      end
      object ckbencerrado53: TCheckBox
        Left = 4
        Top = 102
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 8
      end
      object ckbencerrado54: TCheckBox
        Left = 4
        Top = 124
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 10
      end
      object ckbencerrado55: TCheckBox
        Left = 4
        Top = 146
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 12
      end
      object ckbencerrado56: TCheckBox
        Left = 4
        Top = 167
        Width = 38
        Height = 17
        Caption = 'Fim'
        TabOrder = 14
      end
      object panplacar49: TPanel
        Left = 88
        Top = 15
        Width = 44
        Height = 19
        BevelOuter = bvNone
        TabOrder = 1
        object Label49: TLabel
          Left = 108
          Top = 4
          Width = 5
          Height = 13
          Caption = 'x'
        end
        object rdgplacar49_2: TRadioButton
          Left = 28
          Top = 3
          Width = 15
          Height = 17
          TabOrder = 0
        end
        object rdgplacar49_1: TRadioButton
          Left = 1
          Top = 3
          Width = 15
          Height = 17
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object panplacar50: TPanel
        Left = 88
        Top = 36
        Width = 48
        Height = 21
        BevelOuter = bvNone
        TabOrder = 3
        object Label50: TLabel
          Left = 108
          Top = 4
          Width = 5
          Height = 13
          Caption = 'x'
        end
        object rdgplacar50_2: TRadioButton
          Left = 28
          Top = 3
          Width = 15
          Height = 17
          TabOrder = 0
        end
        object rdgplacar50_1: TRadioButton
          Left = 1
          Top = 3
          Width = 15
          Height = 17
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object panplacar51: TPanel
        Left = 88
        Top = 56
        Width = 48
        Height = 21
        BevelOuter = bvNone
        TabOrder = 5
        object Label51: TLabel
          Left = 108
          Top = 4
          Width = 5
          Height = 13
          Caption = 'x'
        end
        object rdgplacar51_2: TRadioButton
          Left = 28
          Top = 3
          Width = 15
          Height = 17
          TabOrder = 0
        end
        object rdgplacar51_1: TRadioButton
          Left = 1
          Top = 3
          Width = 15
          Height = 17
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object panplacar52: TPanel
        Left = 88
        Top = 77
        Width = 48
        Height = 21
        BevelOuter = bvNone
        TabOrder = 7
        object Label52: TLabel
          Left = 108
          Top = 4
          Width = 5
          Height = 13
          Caption = 'x'
        end
        object rdgplacar52_2: TRadioButton
          Left = 28
          Top = 3
          Width = 15
          Height = 17
          TabOrder = 0
        end
        object rdgplacar52_1: TRadioButton
          Left = 1
          Top = 3
          Width = 15
          Height = 17
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object panplacar53: TPanel
        Left = 88
        Top = 100
        Width = 48
        Height = 21
        BevelOuter = bvNone
        TabOrder = 9
        object Label53: TLabel
          Left = 108
          Top = 4
          Width = 5
          Height = 13
          Caption = 'x'
        end
        object rdgplacar53_2: TRadioButton
          Left = 28
          Top = 3
          Width = 15
          Height = 17
          TabOrder = 0
        end
        object rdgplacar53_1: TRadioButton
          Left = 1
          Top = 3
          Width = 15
          Height = 17
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object panplacar54: TPanel
        Left = 88
        Top = 121
        Width = 48
        Height = 21
        BevelOuter = bvNone
        TabOrder = 11
        object Label54: TLabel
          Left = 108
          Top = 4
          Width = 5
          Height = 13
          Caption = 'x'
        end
        object rdgplacar54_2: TRadioButton
          Left = 28
          Top = 3
          Width = 15
          Height = 17
          TabOrder = 0
        end
        object rdgplacar54_1: TRadioButton
          Left = 1
          Top = 3
          Width = 15
          Height = 17
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object panplacar55: TPanel
        Left = 88
        Top = 144
        Width = 48
        Height = 21
        BevelOuter = bvNone
        TabOrder = 13
        object Label55: TLabel
          Left = 108
          Top = 4
          Width = 5
          Height = 13
          Caption = 'x'
        end
        object rdgplacar55_2: TRadioButton
          Left = 28
          Top = 3
          Width = 15
          Height = 17
          TabOrder = 0
        end
        object rdgplacar55_1: TRadioButton
          Left = 1
          Top = 3
          Width = 15
          Height = 17
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object panplacar56: TPanel
        Left = 88
        Top = 164
        Width = 48
        Height = 21
        BevelOuter = bvNone
        TabOrder = 15
        object Label57: TLabel
          Left = 108
          Top = 4
          Width = 5
          Height = 13
          Caption = 'x'
        end
        object rdgplacar56_2: TRadioButton
          Left = 28
          Top = 3
          Width = 15
          Height = 17
          TabOrder = 0
        end
        object rdgplacar56_1: TRadioButton
          Left = 1
          Top = 3
          Width = 15
          Height = 17
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
    end
    object Panel3: TPanel
      Left = 181
      Top = 0
      Width = 268
      Height = 190
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object grbquartas: TGroupBox
        Left = 0
        Top = 0
        Width = 268
        Height = 101
        Align = alTop
        Caption = 'Quartas-de-final'
        TabOrder = 0
        object lblselecao57_1: TLabel
          Left = 101
          Top = 15
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'WWW'
        end
        object lblselecao57_2: TLabel
          Left = 189
          Top = 15
          Width = 33
          Height = 13
          Caption = 'WWW'
        end
        object lblselecao58_2: TLabel
          Left = 189
          Top = 35
          Width = 33
          Height = 13
          Caption = 'WWW'
        end
        object lblselecao58_1: TLabel
          Left = 101
          Top = 35
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'WWW'
        end
        object lblselecao59_1: TLabel
          Left = 101
          Top = 56
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'WWW'
        end
        object lblselecao59_2: TLabel
          Left = 189
          Top = 56
          Width = 33
          Height = 13
          Caption = 'WWW'
        end
        object lblselecao60_1: TLabel
          Left = 101
          Top = 77
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'WWW'
        end
        object lblselecao60_2: TLabel
          Left = 189
          Top = 77
          Width = 33
          Height = 13
          Caption = 'WWW'
        end
        object ckbencerrado57: TCheckBox
          Left = 45
          Top = 13
          Width = 39
          Height = 17
          Caption = 'Fim'
          TabOrder = 0
        end
        object ckbencerrado58: TCheckBox
          Left = 45
          Top = 35
          Width = 39
          Height = 17
          Caption = 'Fim'
          TabOrder = 1
        end
        object ckbencerrado59: TCheckBox
          Left = 45
          Top = 57
          Width = 39
          Height = 17
          Caption = 'Fim'
          TabOrder = 2
        end
        object ckbencerrado60: TCheckBox
          Left = 45
          Top = 78
          Width = 39
          Height = 17
          Caption = 'Fim'
          TabOrder = 3
        end
        object panplacar57: TPanel
          Left = 139
          Top = 11
          Width = 44
          Height = 19
          BevelOuter = bvNone
          TabOrder = 4
          object Label56: TLabel
            Left = 108
            Top = 4
            Width = 5
            Height = 13
            Caption = 'x'
          end
          object rdgplacar57_2: TRadioButton
            Left = 28
            Top = 3
            Width = 15
            Height = 17
            TabOrder = 0
          end
          object rdgplacar57_1: TRadioButton
            Left = 1
            Top = 3
            Width = 15
            Height = 17
            Checked = True
            TabOrder = 1
            TabStop = True
          end
        end
        object panplacar58: TPanel
          Left = 139
          Top = 32
          Width = 44
          Height = 19
          BevelOuter = bvNone
          TabOrder = 5
          object Label58: TLabel
            Left = 108
            Top = 4
            Width = 5
            Height = 13
            Caption = 'x'
          end
          object rdgplacar58_2: TRadioButton
            Left = 28
            Top = 3
            Width = 15
            Height = 17
            TabOrder = 0
          end
          object rdgplacar58_1: TRadioButton
            Left = 1
            Top = 3
            Width = 15
            Height = 17
            Checked = True
            TabOrder = 1
            TabStop = True
          end
        end
        object panplacar59: TPanel
          Left = 139
          Top = 52
          Width = 44
          Height = 19
          BevelOuter = bvNone
          TabOrder = 6
          object Label59: TLabel
            Left = 108
            Top = 4
            Width = 5
            Height = 13
            Caption = 'x'
          end
          object rdgplacar59_2: TRadioButton
            Left = 28
            Top = 3
            Width = 15
            Height = 17
            TabOrder = 0
          end
          object rdgplacar59_1: TRadioButton
            Left = 1
            Top = 3
            Width = 15
            Height = 17
            Checked = True
            TabOrder = 1
            TabStop = True
          end
        end
        object panplacar60: TPanel
          Left = 139
          Top = 72
          Width = 44
          Height = 19
          BevelOuter = bvNone
          TabOrder = 7
          object Label60: TLabel
            Left = 108
            Top = 4
            Width = 5
            Height = 13
            Caption = 'x'
          end
          object rdgplacar60_2: TRadioButton
            Left = 28
            Top = 3
            Width = 15
            Height = 17
            TabOrder = 0
          end
          object rdgplacar60_1: TRadioButton
            Left = 1
            Top = 3
            Width = 15
            Height = 17
            Checked = True
            TabOrder = 1
            TabStop = True
          end
        end
      end
      object grbsemifinal: TGroupBox
        Left = 0
        Top = 101
        Width = 268
        Height = 89
        Align = alClient
        Caption = 'Semi-final'
        TabOrder = 1
        object lblselecao61_1: TLabel
          Left = 101
          Top = 19
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'WWW'
        end
        object lblselecao62_1: TLabel
          Left = 101
          Top = 40
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'WWW'
        end
        object lblselecao62_2: TLabel
          Left = 189
          Top = 40
          Width = 33
          Height = 13
          Caption = 'WWW'
        end
        object lblselecao61_2: TLabel
          Left = 189
          Top = 19
          Width = 33
          Height = 13
          Caption = 'WWW'
        end
        object ckbencerrado61: TCheckBox
          Left = 45
          Top = 17
          Width = 40
          Height = 17
          Caption = 'Fim'
          TabOrder = 0
        end
        object ckbencerrado62: TCheckBox
          Left = 45
          Top = 38
          Width = 40
          Height = 17
          Caption = 'Fim'
          TabOrder = 1
        end
        object panplacar61: TPanel
          Left = 139
          Top = 15
          Width = 44
          Height = 19
          BevelOuter = bvNone
          TabOrder = 2
          object Label61: TLabel
            Left = 108
            Top = 4
            Width = 5
            Height = 13
            Caption = 'x'
          end
          object rdgplacar61_2: TRadioButton
            Left = 28
            Top = 3
            Width = 15
            Height = 17
            TabOrder = 0
          end
          object rdgplacar61_1: TRadioButton
            Left = 1
            Top = 3
            Width = 15
            Height = 17
            Checked = True
            TabOrder = 1
            TabStop = True
          end
        end
        object panplacar62: TPanel
          Left = 139
          Top = 35
          Width = 44
          Height = 19
          BevelOuter = bvNone
          TabOrder = 3
          object Label62: TLabel
            Left = 108
            Top = 4
            Width = 5
            Height = 13
            Caption = 'x'
          end
          object rdgplacar62_2: TRadioButton
            Left = 28
            Top = 3
            Width = 15
            Height = 17
            TabOrder = 0
          end
          object rdgplacar62_1: TRadioButton
            Left = 1
            Top = 3
            Width = 15
            Height = 17
            Checked = True
            TabOrder = 1
            TabStop = True
          end
        end
      end
    end
    object Panel4: TPanel
      Left = 449
      Top = 0
      Width = 277
      Height = 190
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object grbterceirolugar: TGroupBox
        Left = 0
        Top = 0
        Width = 277
        Height = 102
        Align = alTop
        Caption = 'Terceiro lugar'
        TabOrder = 0
        Visible = False
        object lblselecao63_1: TLabel
          Left = 64
          Top = 26
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'WWW'
        end
        object lblselecao63_2: TLabel
          Left = 152
          Top = 26
          Width = 33
          Height = 13
          Caption = 'WWW'
        end
        object ckbencerrado63: TCheckBox
          Left = 8
          Top = 23
          Width = 40
          Height = 17
          Caption = 'Fim'
          TabOrder = 0
        end
        object Panel5: TPanel
          Left = 102
          Top = 21
          Width = 44
          Height = 19
          BevelOuter = bvNone
          TabOrder = 1
          object Label64: TLabel
            Left = 108
            Top = 4
            Width = 5
            Height = 13
            Caption = 'x'
          end
          object rdgplacar63_2: TRadioButton
            Left = 28
            Top = 3
            Width = 15
            Height = 17
            TabOrder = 0
          end
          object rdgplacar63_1: TRadioButton
            Left = 1
            Top = 3
            Width = 15
            Height = 17
            Checked = True
            TabOrder = 1
            TabStop = True
          end
        end
      end
      object grbfinal: TGroupBox
        Left = 0
        Top = 102
        Width = 277
        Height = 88
        Align = alClient
        Caption = 'Final'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 1
        object lblselecao64_1: TLabel
          Left = 64
          Top = 26
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'WWW'
        end
        object lblselecao64_2: TLabel
          Left = 152
          Top = 26
          Width = 33
          Height = 13
          Caption = 'WWW'
        end
        object ckbencerrado64: TCheckBox
          Left = 8
          Top = 23
          Width = 40
          Height = 17
          Caption = 'Fim'
          TabOrder = 0
        end
        object Panel6: TPanel
          Left = 102
          Top = 21
          Width = 44
          Height = 19
          BevelOuter = bvNone
          Color = clMoneyGreen
          TabOrder = 1
          object Label66: TLabel
            Left = 108
            Top = 4
            Width = 5
            Height = 13
            Caption = 'x'
          end
          object rdgplacar64_2: TRadioButton
            Left = 28
            Top = 3
            Width = 15
            Height = 17
            TabOrder = 0
          end
          object rdgplacar64_1: TRadioButton
            Left = 1
            Top = 3
            Width = 15
            Height = 17
            Checked = True
            TabOrder = 1
            TabStop = True
          end
        end
      end
    end
  end
  object Barra: TProgressBar
    Left = 0
    Top = 517
    Width = 726
    Height = 16
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 5
  end
  object dtslocalizar8: TQuery
    Left = 20
    Top = 492
  end
  object dtsincluir8: TQuery
    Left = 52
    Top = 492
  end
  object dtsalterar8: TQuery
    Left = 84
    Top = 492
  end
  object dtslerclassificacao8: TQuery
    Left = 115
    Top = 492
  end
  object dtsatualizarSG8: TQuery
    Left = 147
    Top = 492
  end
  object dtsordena8: TQuery
    Left = 179
    Top = 492
  end
  object dtstemsorteio8: TQuery
    Left = 207
    Top = 492
  end
end
