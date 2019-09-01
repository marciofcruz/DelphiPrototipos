object frmMain: TfrmMain
  Left = 496
  Top = 85
  Caption = ' '
  ClientHeight = 637
  ClientWidth = 858
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBase: TPanel
    Left = 0
    Top = 0
    Width = 858
    Height = 637
    Align = alClient
    BevelOuter = bvNone
    Color = clSkyBlue
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    ParentBackground = False
    TabOrder = 0
    object pnlTop: TPanel
      Left = 3
      Top = 3
      Width = 852
      Height = 110
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 440
        Height = 110
        Align = alClient
        TabOrder = 0
        object edtPorta: TLabeledEdit
          Left = 52
          Top = 13
          Width = 45
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Porta'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 0
          Text = '8080'
          TextHint = '8080'
        end
        object edtUsuario: TLabeledEdit
          Left = 164
          Top = 13
          Width = 84
          Height = 21
          EditLabel.Width = 22
          EditLabel.Height = 13
          EditLabel.Hint = 'O usu'#225'rio '#233' user'
          EditLabel.Caption = 'Host'
          EditLabel.ParentShowHint = False
          EditLabel.ShowHint = True
          LabelPosition = lpLeft
          TabOrder = 1
          Text = 'marcio.cruz'
        end
        object edtSenha: TLabeledEdit
          Left = 316
          Top = 13
          Width = 88
          Height = 21
          Hint = 'A senha '#233' passwd'
          EditLabel.Width = 30
          EditLabel.Height = 13
          EditLabel.Caption = 'Senha'
          LabelPosition = lpLeft
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Text = 'senhasegura'
          TextHint = 'passwd'
        end
        object Button1: TButton
          Left = 32
          Top = 72
          Width = 75
          Height = 25
          Action = actAtivar
          TabOrder = 3
        end
        object Button2: TButton
          Left = 128
          Top = 72
          Width = 75
          Height = 25
          Action = actParar
          Caption = 'Parar'
          TabOrder = 4
        end
        object Button3: TButton
          Left = 232
          Top = 72
          Width = 75
          Height = 25
          Action = actLimparLog
          TabOrder = 5
        end
        object ckbTemAutenticacao: TCheckBox
          Left = 24
          Top = 40
          Width = 161
          Height = 17
          Caption = 'Tem Autentica'#231#227'o'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
      end
      object Panel2: TPanel
        Left = 440
        Top = 0
        Width = 412
        Height = 110
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
    object panMemo: TPanel
      Left = 3
      Top = 113
      Width = 852
      Height = 521
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 3
      Padding.Top = 3
      Padding.Right = 3
      Padding.Bottom = 3
      ParentBackground = False
      TabOrder = 1
      object GroupBox2: TGroupBox
        Left = 3
        Top = 121
        Width = 846
        Height = 145
        Align = alClient
        Caption = 'Requisi'#231#245'es'
        TabOrder = 1
        object memoReq: TMemo
          Left = 2
          Top = 15
          Width = 842
          Height = 128
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 3
        Top = 266
        Width = 846
        Height = 252
        Align = alBottom
        Caption = 'Respostas'
        TabOrder = 2
        object memoResp: TMemo
          Left = 2
          Top = 15
          Width = 842
          Height = 235
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 3
        Width = 846
        Height = 118
        Align = alTop
        Caption = 'Log Aplica'#231#227'o'
        TabOrder = 0
        object logApp: TMemo
          Left = 2
          Top = 15
          Width = 842
          Height = 101
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 371
    Top = 59
    object actAtivar: TAction
      Caption = 'Ativar'
      OnExecute = actAtivarExecute
      OnUpdate = actAtivarUpdate
    end
    object actParar: TAction
      Caption = 'actParar'
      OnExecute = actPararExecute
      OnUpdate = actPararUpdate
    end
    object actLimparLog: TAction
      Caption = 'Limpar Log'
      OnExecute = actLimparLogExecute
      OnUpdate = actLimparLogUpdate
    end
  end
end
