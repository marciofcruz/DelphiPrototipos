object frmCapturaCadastro: TfrmCapturaCadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Faces'
  ClientHeight = 474
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBase: TPanel
    Left = 0
    Top = 0
    Width = 579
    Height = 474
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
      Top = 373
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
      Top = 430
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
        object SpeedButton1: TSpeedButton
          Left = 174
          Top = 6
          Width = 81
          Height = 29
          Action = actGravar
        end
        object SpeedButton2: TSpeedButton
          Left = 87
          Top = 8
          Width = 81
          Height = 29
          Action = actFechar
        end
      end
    end
    object panHeader: TPanel
      Left = 3
      Top = 3
      Width = 573
      Height = 101
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 2
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 573
        Height = 101
        VertScrollBar.Smooth = True
        VertScrollBar.Style = ssFlat
        Align = alClient
        Color = clInfoBk
        ParentColor = False
        TabOrder = 0
        StyleElements = [seFont, seClient]
        ExplicitTop = -6
      end
    end
    object pnlCaptura: TPanel
      Left = 3
      Top = 104
      Width = 573
      Height = 269
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 3
      object imgSaidaCamera: TImage
        Left = 50
        Top = 15
        Width = 640
        Height = 480
        Proportional = True
        Stretch = True
      end
      object stbFacesDetectadas: TStaticText
        Left = 0
        Top = 252
        Width = 102
        Height = 17
        Align = alBottom
        Alignment = taCenter
        Caption = 'stbFacesDetectadas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object dsEntidade: TDataSource
    AutoEdit = False
    DataSet = DMEntidade.cdsEntidade
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
    object actGravar: TAction
      Caption = 'Gravar'
      OnExecute = actGravarExecute
    end
  end
  object dsFotos: TDataSource
    Left = 100
    Top = 14
  end
  object ImageList1: TImageList
    Height = 90
    Width = 90
    Left = 91
    Top = 364
  end
end
