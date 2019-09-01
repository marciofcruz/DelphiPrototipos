object frmMenu: TfrmMenu
  Left = 190
  Top = 149
  Caption = 'Compila e testa chamada de execut'#225'veis do Delphi 32'
  ClientHeight = 546
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grbTesteCompilacao: TGroupBox
    Left = 0
    Top = 211
    Width = 800
    Height = 335
    Align = alClient
    Caption = 'Teste / Compi'
    TabOrder = 1
    object Barra: TProgressBar
      Left = 2
      Top = 15
      Width = 796
      Height = 16
      Align = alTop
      TabOrder = 0
    end
    object sttLog: TStatusBar
      Left = 2
      Top = 314
      Width = 796
      Height = 19
      Panels = <
        item
          Width = 100
        end
        item
          Width = 100
        end
        item
          Width = 100
        end
        item
          Width = 200
        end
        item
          Alignment = taRightJustify
          Width = 50
        end>
    end
    object pagina: TPageControl
      Left = 2
      Top = 31
      Width = 796
      Height = 283
      ActivePage = tabLog
      Align = alClient
      TabOrder = 2
      object tabLog: TTabSheet
        Caption = 'Log'
        object memLog: TMemo
          Left = 0
          Top = 0
          Width = 788
          Height = 255
          Align = alClient
          Color = clBlack
          Font.Charset = ANSI_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Lines.Strings = (
            'memLog')
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Execu'#231#227'o DOS'
        ImageIndex = 1
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object memDOS: TMemo
          Left = 0
          Top = 0
          Width = 788
          Height = 260
          Align = alClient
          Color = clBlack
          Font.Charset = ANSI_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
      end
    end
  end
  object panListaArquivos: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 211
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object panTopo: TPanel
      Left = 0
      Top = 0
      Width = 800
      Height = 191
      Align = alClient
      Caption = 'panTopo'
      TabOrder = 0
      object Panel1: TPanel
        Left = 706
        Top = 1
        Width = 93
        Height = 189
        Align = alRight
        TabOrder = 1
        object btnSelecionar: TBitBtn
          Left = 4
          Top = 16
          Width = 86
          Height = 25
          Caption = '&Selecionar'
          Default = True
          TabOrder = 0
          OnClick = btnSelecionarClick
          Glyph.Data = {
            5A010000424D5A01000000000000760000002800000012000000130000000100
            040000000000E400000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            888888000000888888888888888888000000800000000000000888000000800B
            FBFBFBFBFB08880000008070BFBFBFBFBFB08800000080B0FBFBFBFBFBF08800
            00008070BFBFBFBFBFB08800000080B77BFBFBFBFBFB78000000807B7FBFBFBF
            BFBF7800000080B777777777777778000000807B7B7EEEE77B78880000008000
            B7B0EEE77778880000008888000EEEE7888888000000888880EEE0E788888800
            000088880EEE08778888880000008880EEE0888788888800000088880E088888
            888888000000888880888888888888000000888888888888888888000000}
        end
        object btnCompilarTestar: TBitBtn
          Left = 4
          Top = 44
          Width = 86
          Height = 25
          Caption = 'C&ompilar'
          TabOrder = 1
          OnClick = btnCompilarTestarClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333000003333333333F77777FFF333333009999900
            3333333777777777FF33330998FFF899033333777333F3777FF33099FFFCFFF9
            903337773337333777F3309FFFFFFFCF9033377333F3337377FF098FF0FFFFFF
            890377F3373F3333377F09FFFF0FFFFFF90377F3F373FFFFF77F09FCFFF90000
            F90377F733377777377F09FFFFFFFFFFF90377F333333333377F098FFFFFFFFF
            890377FF3F33333F3773309FCFFFFFCF9033377F7333F37377F33099FFFCFFF9
            90333777FF37F3377733330998FCF899033333777FF7FF777333333009999900
            3333333777777777333333333000003333333333377777333333}
          NumGlyphs = 2
        end
        object bttnFechar: TBitBtn
          Left = 4
          Top = 72
          Width = 86
          Height = 25
          Caption = '&Fechar'
          TabOrder = 2
          OnClick = bttnFecharClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
            03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
            0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
            0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
            0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
            0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
            0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
            0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
            0333337F777FFFFF7F3333000000000003333377777777777333}
          NumGlyphs = 2
        end
        object Button1: TButton
          Left = 4
          Top = 108
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 3
          Visible = False
          OnClick = Button1Click
        end
      end
      object ckbListaArquivos: TCheckListBox
        Left = 1
        Top = 1
        Width = 705
        Height = 189
        Align = alClient
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
      end
    end
    object panBottom: TPanel
      Left = 0
      Top = 191
      Width = 800
      Height = 20
      Align = alBottom
      TabOrder = 1
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 198
        Height = 18
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object btnChecarTodos: TButton
          Left = 2
          Top = 0
          Width = 97
          Height = 19
          Caption = 'Checar todos'
          TabOrder = 0
          TabStop = False
          OnClick = btnChecarTodosClick
        end
        object btnNaoChecarTodos: TButton
          Left = 100
          Top = -1
          Width = 97
          Height = 19
          Caption = 'N'#227'o Checar todos'
          TabOrder = 1
          TabStop = False
          OnClick = btnNaoChecarTodosClick
        end
      end
      object StatusBar1: TStatusBar
        Left = 199
        Top = 1
        Width = 600
        Height = 18
        Align = alClient
        Panels = <
          item
            Width = 50
          end>
      end
    end
  end
end
