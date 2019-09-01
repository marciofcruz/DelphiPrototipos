object frmsorteio: Tfrmsorteio
  Left = 230
  Top = 209
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmsorteio'
  ClientHeight = 159
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 128
    Top = 128
    Width = 75
    Height = 25
    Caption = '&Selecionar'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 331
    Height = 117
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object rdgprimeiro: TRadioGroup
      Left = 0
      Top = 0
      Width = 165
      Height = 117
      Align = alLeft
      Caption = 'Primeiro colocado'
      TabOrder = 0
    end
    object rdgsegundo: TRadioGroup
      Left = 165
      Top = 0
      Width = 165
      Height = 117
      Align = alLeft
      Caption = 'Segundo colocado'
      TabOrder = 1
    end
  end
end
