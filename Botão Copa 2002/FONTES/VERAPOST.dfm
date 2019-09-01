object frmveraposta: Tfrmveraposta
  Left = 152
  Top = 109
  ActiveControl = dcGridAposta
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Outras apostas'
  ClientHeight = 293
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnacessar: TButton
    Left = 122
    Top = 264
    Width = 75
    Height = 25
    Caption = '&Ver aposta'
    Default = True
    TabOrder = 1
    OnClick = btnacessarClick
  end
  object btnfechar: TButton
    Left = 214
    Top = 264
    Width = 75
    Height = 25
    Caption = '&Fechar'
    TabOrder = 2
    OnClick = btnfecharClick
  end
  object dcGridAposta: TDBGrid
    Left = 0
    Top = 0
    Width = 410
    Height = 257
    Align = alTop
    DataSource = dsgeral
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object dtsgeral: TQuery
    Left = 256
    Top = 28
  end
  object dsgeral: TDataSource
    DataSet = dtsgeral
    Left = 304
    Top = 28
  end
end
