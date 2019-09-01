object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Controle de tempo de apresenta'#231#227'o'
  ClientHeight = 256
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 731
    Height = 216
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 729
      Height = 214
      Align = alClient
      Alignment = taCenter
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -48
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 216
    Width = 731
    Height = 40
    Align = alBottom
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 1
    object lblRestante: TLabel
      Left = 636
      Top = 1
      Width = 94
      Height = 38
      Align = alRight
      Caption = 'lblRestante'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 19
    end
    object btnIniciar: TButton
      Left = 16
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Iniciar'
      TabOrder = 0
      OnClick = btnIniciarClick
    end
    object btnPausar: TButton
      Left = 97
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Pausar'
      TabOrder = 1
      OnClick = btnPausarClick
    end
    object btnParar: TButton
      Left = 194
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Parar'
      TabOrder = 2
      OnClick = btnPararClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 900
    OnTimer = Timer1Timer
    Left = 456
    Top = 208
  end
end
