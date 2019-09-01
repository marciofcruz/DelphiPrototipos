object frmCadastroBase: TfrmCadastroBase
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'frmCadastroBase'
  ClientHeight = 405
  ClientWidth = 669
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlOperacoes: TPanel
    Left = 0
    Top = 0
    Width = 669
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 32
      Top = 16
      Width = 75
      Height = 25
      Action = actNovo
      TabOrder = 0
    end
    object Button2: TButton
      Left = 111
      Top = 16
      Width = 75
      Height = 25
      Action = actEditar
      TabOrder = 1
    end
    object Button3: TButton
      Left = 190
      Top = 16
      Width = 75
      Height = 25
      Action = actSalvar
      TabOrder = 2
    end
    object Button4: TButton
      Left = 270
      Top = 16
      Width = 75
      Height = 25
      Action = actCancelar
      TabOrder = 3
    end
    object Button5: TButton
      Left = 349
      Top = 16
      Width = 75
      Height = 25
      Action = actExcluir
      TabOrder = 4
    end
    object btnSincronizar: TButton
      Left = 429
      Top = 16
      Width = 148
      Height = 25
      Action = actSincronizar
      TabOrder = 5
    end
  end
  object pnlPrincipal: TPanel
    Left = 0
    Top = 57
    Width = 669
    Height = 348
    Align = alClient
    BevelOuter = bvNone
    Color = clSkyBlue
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    ParentBackground = False
    TabOrder = 1
    object pagina: TPageControl
      Left = 3
      Top = 3
      Width = 663
      Height = 342
      ActivePage = tabVisualizacao
      Align = alClient
      TabOrder = 0
      object tabVisualizacao: TTabSheet
        Caption = 'tabVisualizacao'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DBGridPrincipal: TDBGrid
          Left = 0
          Top = 0
          Width = 655
          Height = 314
          Align = alClient
          DataSource = dtsMain
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
      object tabManutencao: TTabSheet
        Caption = 'tabManutencao'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object StaticText1: TStaticText
          Left = 48
          Top = 38
          Width = 41
          Height = 17
          Caption = 'C'#243'digo:'
          TabOrder = 0
        end
        object lblcodigo: TStaticText
          Left = 104
          Top = 38
          Width = 41
          Height = 17
          Caption = 'C'#243'digo:'
          TabOrder = 1
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 536
    Top = 65
    object actNovo: TAction
      Caption = 'Novo'
      OnExecute = actNovoExecute
      OnUpdate = actNovoUpdate
    end
    object actEditar: TAction
      Caption = 'Editar'
      OnExecute = actEditarExecute
      OnUpdate = actEditarUpdate
    end
    object actExcluir: TAction
      Caption = 'Excluir'
      OnExecute = actExcluirExecute
      OnUpdate = actExcluirUpdate
    end
    object actSalvar: TAction
      Caption = 'Salvar'
      OnExecute = actSalvarExecute
      OnUpdate = actSalvarUpdate
    end
    object actCancelar: TAction
      Caption = 'Cancelar'
      OnExecute = actCancelarExecute
      OnUpdate = actCancelarUpdate
    end
    object actSincronizar: TAction
      Caption = 'Sincronizar'
      OnExecute = actSincronizarExecute
      OnUpdate = actSincronizarUpdate
    end
  end
  object dtsMain: TDataSource
    AutoEdit = False
    DataSet = FDMain
    Left = 560
    Top = 16
  end
  object FDMain: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 39
    Top = 252
    object FDMainCHAVEINTERNA: TIntegerField
      FieldName = 'CHAVEINTERNA'
    end
    object FDMainEXCLUIDO: TIntegerField
      FieldName = 'EXCLUIDO'
    end
    object FDMainREVISAO: TIntegerField
      FieldName = 'REVISAO'
    end
    object FDMainALTERADO: TIntegerField
      FieldName = 'ALTERADO'
    end
  end
end
