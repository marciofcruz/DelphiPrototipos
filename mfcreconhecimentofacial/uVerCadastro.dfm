object frmVerCadastro: TfrmVerCadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Faces por Entidade'
  ClientHeight = 377
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBase: TPanel
    Left = 0
    Top = 0
    Width = 579
    Height = 377
    Align = alClient
    BevelOuter = bvNone
    Color = clSkyBlue
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    ParentBackground = False
    TabOrder = 0
    object pnlDadosEntidade: TPanel
      Left = 3
      Top = 276
      Width = 573
      Height = 57
      Align = alBottom
      BevelOuter = bvNone
      Padding.Left = 3
      Padding.Top = 3
      Padding.Right = 3
      Padding.Bottom = 3
      ParentBackground = False
      TabOrder = 0
      object GroupBox1: TGroupBox
        Left = 3
        Top = 3
        Width = 567
        Height = 51
        Align = alClient
        Caption = 'Pessoa'
        Color = clBtnFace
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        object DBText1: TDBText
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 557
          Height = 28
          Align = alClient
          Alignment = taCenter
          Color = clWhite
          DataField = 'NOMECOMPLETO'
          DataSource = dsEntidade
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ExplicitLeft = 7
          ExplicitTop = 20
          ExplicitWidth = 563
        end
      end
    end
    object pnlBottom: TPanel
      Left = 3
      Top = 333
      Width = 573
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object pnlBotoes: TPanel
        Left = 298
        Top = 0
        Width = 275
        Height = 41
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object SpeedButton2: TSpeedButton
          Left = 183
          Top = 8
          Width = 81
          Height = 29
          Action = actFechar
        end
      end
    end
    object grbFaceArmazenada: TGroupBox
      Left = 3
      Top = 3
      Width = 573
      Height = 90
      Align = alTop
      Caption = 'Face Armazenada em BASE64'
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 2
      object scrollImagensArmazenadas: TScrollBox
        Left = 2
        Top = 15
        Width = 569
        Height = 73
        VertScrollBar.Smooth = True
        VertScrollBar.Style = ssFlat
        Align = alClient
        Color = clInfoBk
        ParentColor = False
        TabOrder = 0
        StyleElements = [seFont, seClient]
      end
    end
    object GroupBox2: TGroupBox
      Left = 3
      Top = 93
      Width = 573
      Height = 90
      Align = alTop
      Caption = 'Escala Cinza'
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 3
      object scrollImagemEscalaCinza: TScrollBox
        Left = 2
        Top = 15
        Width = 569
        Height = 73
        VertScrollBar.Smooth = True
        VertScrollBar.Style = ssFlat
        Align = alClient
        Color = clInfoBk
        ParentColor = False
        TabOrder = 0
        StyleElements = [seFont, seClient]
      end
    end
    object GroupBox3: TGroupBox
      Left = 3
      Top = 183
      Width = 573
      Height = 90
      Align = alTop
      Caption = 'Escala de Cinza com equaliza'#231#227'o de Histograma'
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 4
      object scrollImagemHistograma: TScrollBox
        Left = 2
        Top = 15
        Width = 569
        Height = 73
        VertScrollBar.Smooth = True
        VertScrollBar.Style = ssFlat
        Align = alClient
        Color = clInfoBk
        ParentColor = False
        TabOrder = 0
        StyleElements = [seFont, seClient]
      end
    end
  end
  object dsEntidade: TDataSource
    AutoEdit = False
    Left = 229
    Top = 296
  end
  object ActionList1: TActionList
    Left = 216
    Top = 368
    object actFechar: TAction
      Caption = 'Fechar'
      OnExecute = actFecharExecute
    end
  end
  object dsFotos: TDataSource
    Left = 28
    Top = 46
  end
  object ImageList1: TImageList
    Height = 90
    Width = 90
    Left = 91
    Top = 364
  end
end
