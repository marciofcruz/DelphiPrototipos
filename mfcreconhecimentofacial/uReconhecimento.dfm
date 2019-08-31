object frmReconhecimento: TfrmReconhecimento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registro de Reconhecimento'
  ClientHeight = 378
  ClientWidth = 365
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
    Width = 365
    Height = 378
    Align = alClient
    BevelOuter = bvNone
    Color = clSkyBlue
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    ParentBackground = False
    TabOrder = 0
    object pnlBottom: TPanel
      Left = 3
      Top = 334
      Width = 359
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object pnlBotoes: TPanel
        Left = 84
        Top = 0
        Width = 275
        Height = 41
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object SpeedButton2: TSpeedButton
          Left = 175
          Top = 8
          Width = 81
          Height = 29
          Action = actFechar
        end
      end
    end
    object Panel1: TPanel
      Left = 3
      Top = 3
      Width = 359
      Height = 331
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 11
        Top = 0
        Width = 335
        Height = 114
        Caption = 'Informa'#231#245'es'
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 19
          Width = 96
          Height = 13
          Caption = 'Faces Cadastradas:'
        end
        object lblQtdeFacesCadastradas: TLabel
          Left = 128
          Top = 19
          Width = 96
          Height = 13
          Caption = 'Faces Cadastradas:'
        end
        object lbl1: TLabel
          Left = 16
          Top = 39
          Width = 66
          Height = 13
          Caption = 'Identificados:'
        end
        object lblIdentificados: TLabel
          Left = 128
          Top = 39
          Width = 96
          Height = 13
          Caption = 'Faces Cadastradas:'
        end
        object lbl2: TLabel
          Left = 16
          Top = 55
          Width = 86
          Height = 13
          Caption = 'N'#227'o identificados:'
        end
        object lblNaoIdentificados: TLabel
          Left = 128
          Top = 55
          Width = 96
          Height = 13
          Caption = 'Faces Cadastradas:'
        end
        object lbl3: TLabel
          Left = 16
          Top = 72
          Width = 55
          Height = 13
          Caption = 'Acertos %:'
        end
        object lblPorcentagemAcertos: TLabel
          Left = 128
          Top = 72
          Width = 96
          Height = 13
          Caption = 'Faces Cadastradas:'
        end
        object lblUltimoReconhecido: TLabel
          Left = 128
          Top = 88
          Width = 96
          Height = 13
          Caption = 'Faces Cadastradas:'
        end
        object Label3: TLabel
          Left = 16
          Top = 88
          Width = 97
          Height = 13
          Caption = 'Ultimo Reconhecido:'
        end
      end
      object GroupBox2: TGroupBox
        Left = 11
        Top = 120
        Width = 335
        Height = 201
        Caption = 'C'#226'mera'
        TabOrder = 1
        object imgSaidaCamera: TImage
          Left = 2
          Top = 15
          Width = 331
          Height = 184
          Align = alClient
          Stretch = True
          ExplicitLeft = 1
          ExplicitTop = 9
          ExplicitWidth = 358
          ExplicitHeight = 187
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 224
    Top = 208
    object actFechar: TAction
      Caption = 'Fechar'
      OnExecute = actFecharExecute
    end
  end
  object dsFotos: TDataSource
    Left = 156
    Top = 166
  end
  object ImageList1: TImageList
    Height = 90
    Width = 90
    Left = 99
    Top = 204
  end
end
