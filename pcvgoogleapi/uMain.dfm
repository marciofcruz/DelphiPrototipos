object Form1: TForm1
  Left = 0
  Top = 0
  Caption = '@Marciofcruz - Teste geocodifica'#231#227'o'
  ClientHeight = 531
  ClientWidth = 947
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
  object pagina: TPageControl
    Left = 0
    Top = 0
    Width = 947
    Height = 512
    ActivePage = tabParametros
    Align = alClient
    TabOrder = 0
    ExplicitTop = -6
    object tabParametros: TTabSheet
      Caption = 'Par'#226'metros'
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 939
        Height = 57
        Align = alTop
        Caption = 'Google'
        TabOrder = 0
        object Label11: TLabel
          Left = 18
          Top = 23
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Google Key:'
        end
        object edtGoogleAPIKey: TEdit
          Left = 82
          Top = 20
          Width = 587
          Height = 21
          TabOrder = 0
        end
      end
      object Proxy: TGroupBox
        Left = 0
        Top = 57
        Width = 939
        Height = 427
        Align = alClient
        Caption = 'Proxy'
        TabOrder = 1
        object Label1: TLabel
          Left = 24
          Top = 40
          Width = 26
          Height = 13
          Alignment = taRightJustify
          Caption = 'Host:'
        end
        object Label2: TLabel
          Left = 10
          Top = 72
          Width = 40
          Height = 13
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio:'
        end
        object Label3: TLabel
          Left = 16
          Top = 104
          Width = 34
          Height = 13
          Alignment = taRightJustify
          Caption = 'Senha:'
        end
        object Label12: TLabel
          Left = 20
          Top = 131
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'Porta:'
        end
        object edtHost: TEdit
          Left = 56
          Top = 37
          Width = 241
          Height = 21
          TabOrder = 0
        end
        object edtUsuario: TEdit
          Left = 56
          Top = 69
          Width = 241
          Height = 21
          TabOrder = 1
        end
        object edtSenha: TEdit
          Left = 56
          Top = 101
          Width = 241
          Height = 21
          TabOrder = 2
        end
        object edtPorta: TEdit
          Left = 56
          Top = 128
          Width = 241
          Height = 21
          TabOrder = 3
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'GeoCode'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 939
        Height = 193
        Align = alTop
        Caption = 'Endere'#231'o Geocodifica'#231#227'o'
        TabOrder = 0
        object Label4: TLabel
          Left = 27
          Top = 40
          Width = 23
          Height = 13
          Alignment = taRightJustify
          Caption = 'Rua:'
        end
        object Label5: TLabel
          Left = 9
          Top = 72
          Width = 41
          Height = 13
          Alignment = taRightJustify
          Caption = 'Numero:'
        end
        object Label6: TLabel
          Left = 18
          Top = 104
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label7: TLabel
          Left = 177
          Top = 72
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'Compl:'
        end
        object Label8: TLabel
          Left = 13
          Top = 136
          Width = 37
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object Label9: TLabel
          Left = 33
          Top = 163
          Width = 17
          Height = 13
          Alignment = taRightJustify
          Caption = 'UF:'
        end
        object Label10: TLabel
          Left = 139
          Top = 163
          Width = 23
          Height = 13
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object edtRua: TEdit
          Left = 56
          Top = 37
          Width = 513
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
        end
        object edtNumero: TEdit
          Left = 56
          Top = 69
          Width = 97
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object edtBairro: TEdit
          Left = 56
          Top = 101
          Width = 249
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object edtComplemento: TEdit
          Left = 216
          Top = 69
          Width = 97
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 3
        end
        object edtCidade: TEdit
          Left = 56
          Top = 133
          Width = 249
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 4
          Text = 'SAO PAULO'
        end
        object edtUF: TEdit
          Left = 56
          Top = 160
          Width = 49
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 5
          Text = 'SP'
        end
        object edtCEP: TEdit
          Left = 168
          Top = 160
          Width = 121
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 6
        end
        object btnGeocodificar: TButton
          Left = 338
          Top = 154
          Width = 75
          Height = 25
          Caption = 'GeoCodificar'
          TabOrder = 7
          OnClick = btnGeocodificarClick
        end
        object Button2: TButton
          Left = 448
          Top = 154
          Width = 145
          Height = 25
          Caption = 'Documenta'#231#227'o'
          TabOrder = 8
          OnClick = Button2Click
        end
        object btnMockar: TButton
          Left = 448
          Top = 99
          Width = 83
          Height = 25
          Hint = 'Simula'#231#227'o dados de est'#225'dios'
          Caption = 'Mockar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = btnMockarClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 193
        Width = 939
        Height = 291
        Align = alClient
        Caption = 'Resultado'
        TabOrder = 1
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 850
          Height = 274
          Align = alClient
          DataSource = dtsCoordenadas
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ORDEM'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TEMPOPROCESSAMENTO'
              Title.Caption = 'Tempo Processamento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LATITUDE'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LONGITUDE'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DISTANCIALINHARETA'
              Title.Caption = 'Linha Reta (KM)'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PLACEID'
              Width = 372
              Visible = True
            end>
        end
        object Panel2: TPanel
          Left = 852
          Top = 15
          Width = 85
          Height = 274
          Align = alRight
          TabOrder = 1
          object GroupBox6: TGroupBox
            Left = 1
            Top = 111
            Width = 83
            Height = 72
            Align = alTop
            Caption = 'Processar'
            TabOrder = 1
            object btnInverso: TSpeedButton
              Left = 5
              Top = 34
              Width = 59
              Height = 22
              Action = actInverso
            end
          end
          object GroupBox7: TGroupBox
            Left = 1
            Top = 1
            Width = 83
            Height = 110
            Align = alTop
            Caption = 'Posi'#231#227'o'
            TabOrder = 0
            object SpeedButton1: TSpeedButton
              Left = 6
              Top = 21
              Width = 59
              Height = 22
              Action = actSubir
            end
            object SpeedButton2: TSpeedButton
              Left = 5
              Top = 49
              Width = 59
              Height = 22
              Action = actDescer
            end
            object SpeedButton3: TSpeedButton
              Left = 6
              Top = 77
              Width = 59
              Height = 22
              Action = actExcluir
            end
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Matriz de Dist'#226'ncia'
      ImageIndex = 2
      object panMatriz: TPanel
        Left = 0
        Top = 185
        Width = 939
        Height = 108
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object panGridMatrizDistancia: TPanel
          Left = 0
          Top = 0
          Width = 863
          Height = 108
          Align = alClient
          TabOrder = 0
          object DBGrid2: TDBGrid
            Left = 1
            Top = 1
            Width = 861
            Height = 106
            Align = alClient
            DataSource = dtsMatrizDistancia
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'TIPO'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'LATITUDE'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'LONGITUDE'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PLACEID'
                Title.Caption = 'Endere'#231'o Completo'
                Visible = True
              end>
          end
        end
        object panOperacaoMatrizDistancia: TPanel
          Left = 863
          Top = 0
          Width = 76
          Height = 108
          Align = alRight
          Padding.Left = 3
          Padding.Top = 3
          Padding.Right = 3
          Padding.Bottom = 3
          TabOrder = 1
          object SpeedButton4: TSpeedButton
            Left = 3
            Top = 24
            Width = 68
            Height = 22
            Action = actTipoNenhum
          end
          object SpeedButton5: TSpeedButton
            Left = 3
            Top = 52
            Width = 68
            Height = 22
            Action = actTipoOrigem
          end
          object SpeedButton6: TSpeedButton
            Left = 3
            Top = 80
            Width = 68
            Height = 22
            Action = actTipoDestino
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 939
        Height = 185
        Align = alTop
        TabOrder = 1
        object GroupBox5: TGroupBox
          Left = 1
          Top = 1
          Width = 937
          Height = 183
          Align = alClient
          Caption = 'Processar'
          TabOrder = 0
          object Label13: TLabel
            Left = 11
            Top = 16
            Width = 30
            Height = 13
            Caption = 'Modo:'
          end
          object btnProcessarMatrizDistancia: TSpeedButton
            Left = 3
            Top = 150
            Width = 113
            Height = 22
            Action = actProcessarMatrizDistancia
          end
          object Label14: TLabel
            Left = 168
            Top = 13
            Width = 49
            Height = 13
            Caption = 'Restri'#231#227'o:'
          end
          object lblTrafegoTrajeto: TLabel
            Left = 339
            Top = 16
            Width = 93
            Height = 13
            Caption = 'Tr'#225'fego no trajeto:'
          end
          object lblPreferenciaTransportePublico: TLabel
            Left = 352
            Top = 77
            Width = 151
            Height = 13
            Caption = 'Prefer'#234'ncia Transporte P'#250'blico:'
          end
          object lblRoteamentoTransportePublico: TLabel
            Left = 499
            Top = 16
            Width = 155
            Height = 13
            Caption = 'Roteamento Transporte P'#250'blico:'
          end
          object cobModoTransporte: TComboBox
            Left = 11
            Top = 32
            Width = 145
            Height = 21
            TabOrder = 0
            OnSelect = cobModoTransporteSelect
            Items.Strings = (
              'Condutor'
              'A p'#233
              'Bicicleta'
              'Transporte P'#250'blico')
          end
          object Button1: TButton
            Left = 142
            Top = 150
            Width = 75
            Height = 25
            Caption = 'Ajuda'
            TabOrder = 1
            OnClick = Button1Click
          end
          object cobOpcaoTrafego: TComboBox
            Left = 339
            Top = 32
            Width = 145
            Height = 21
            TabOrder = 2
            Items.Strings = (
              'Melhor Chute'
              'Pessimista'
              'Otimista')
          end
          object GroupBox4: TGroupBox
            Left = 11
            Top = 59
            Width = 318
            Height = 57
            Caption = 'Hor'#225'rio'
            TabOrder = 3
            object dtHorario: TDateTimePicker
              Left = 170
              Top = 24
              Width = 129
              Height = 21
              Date = 43043.000000000000000000
              Format = 'dd/MM/yyyy HH:mm'
              Time = 0.681164097222790600
              TabOrder = 0
            end
            object cobHorario: TComboBox
              Left = 19
              Top = 24
              Width = 145
              Height = 21
              TabOrder = 1
              Items.Strings = (
                'Partida'
                'Chegada')
            end
          end
          object ckbPreferenciaTransportePublico: TCheckListBox
            Left = 352
            Top = 96
            Width = 569
            Height = 21
            Columns = 5
            ItemHeight = 13
            Items.Strings = (
              #212'nibus'
              'Metr'#244
              'Trem'
              'Bonde'
              'Estradas de Ferro')
            TabOrder = 4
          end
          object cobRoteamentoTransportePublico: TComboBox
            Left = 499
            Top = 32
            Width = 145
            Height = 21
            TabOrder = 5
            Items.Strings = (
              'Menos Caminhada'
              'Menos Baldia'#231#245'es')
          end
          object cobRestricao: TComboBox
            Left = 168
            Top = 32
            Width = 145
            Height = 21
            TabOrder = 6
            OnSelect = cobModoTransporteSelect
            Items.Strings = (
              'Nenhum'
              'Ped'#225'gio'
              'Rodovia'
              'Balsa'
              'Interior')
          end
        end
      end
      object grbResultadoMatriz: TGroupBox
        Left = 0
        Top = 293
        Width = 939
        Height = 191
        Align = alBottom
        Caption = 'Resultado'
        TabOrder = 2
        object memResultado: TMemo
          Left = 2
          Top = 15
          Width = 935
          Height = 174
          Align = alClient
          Lines.Strings = (
            '')
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
  end
  object stbResultado: TStatusBar
    Left = 0
    Top = 512
    Width = 947
    Height = 19
    Panels = <
      item
        Width = 500
      end>
  end
  object dtsCoordenadas: TDataSource
    AutoEdit = False
    DataSet = cdsCoordenadas
    Left = 44
    Top = 409
  end
  object ActionList1: TActionList
    Left = 420
    Top = 273
    object actSubir: TAction
      Category = 'GeoCode'
      Caption = 'Subir'
      OnExecute = actSubirExecute
      OnUpdate = actSubirUpdate
    end
    object actDescer: TAction
      Category = 'GeoCode'
      Caption = 'Descer'
      OnExecute = actDescerExecute
      OnUpdate = actDescerUpdate
    end
    object actExcluir: TAction
      Category = 'GeoCode'
      Caption = 'Excluir'
      OnExecute = actExcluirExecute
      OnUpdate = actExcluirUpdate
    end
    object actTipoOrigem: TAction
      Category = 'MatrizDistancia'
      Caption = 'Origem'
      OnExecute = actTipoOrigemExecute
      OnUpdate = actTipoOrigemUpdate
    end
    object actTipoDestino: TAction
      Category = 'MatrizDistancia'
      Caption = 'Destino'
      OnExecute = actTipoDestinoExecute
      OnUpdate = actTipoDestinoUpdate
    end
    object actTipoNenhum: TAction
      Category = 'MatrizDistancia'
      Caption = 'Nenhum'
      OnExecute = actTipoNenhumExecute
      OnUpdate = actTipoNenhumUpdate
    end
    object actInverso: TAction
      Category = 'GeoCode'
      Caption = 'Inverso'
      OnExecute = actInversoExecute
      OnUpdate = actInversoUpdate
    end
    object actProcessarMatrizDistancia: TAction
      Category = 'MatrizDistancia'
      Caption = 'Processar'
      OnExecute = actProcessarMatrizDistanciaExecute
      OnUpdate = actProcessarMatrizDistanciaUpdate
    end
    object actProcessarGoogleMaps: TAction
      Category = 'Maps'
      Caption = 'Processar'
    end
    object actDefault: TAction
      Category = 'Maps'
      Caption = 'Default'
      OnUpdate = actDefaultUpdate
    end
  end
  object cdsMatrizDistancia: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 140
    Top = 344
    object cdsMatrizDistanciaCHAVE: TIntegerField
      FieldName = 'CHAVE'
    end
    object cdsMatrizDistanciaLATITUDE: TFloatField
      FieldName = 'LATITUDE'
    end
    object cdsMatrizDistanciaPLACEID: TStringField
      FieldName = 'PLACEID'
      Size = 100
    end
    object cdsMatrizDistanciaTIPO: TStringField
      FieldName = 'TIPO'
      Size = 7
    end
    object cdsMatrizDistanciaLONGITUDE: TFloatField
      FieldName = 'LONGITUDE'
    end
  end
  object dtsMatrizDistancia: TDataSource
    AutoEdit = False
    DataSet = cdsMatrizDistancia
    Left = 140
    Top = 393
  end
  object cdsGoogleMaps: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 252
    Top = 344
    object cdsGoogleMapsCHAVE: TIntegerField
      FieldName = 'CHAVE'
    end
    object cdsGoogleMapsLATITUDE: TFloatField
      FieldName = 'LATITUDE'
    end
    object cdsGoogleMapsLONGITUDE: TFloatField
      FieldName = 'LONGITUDE'
    end
    object cdsGoogleMapsTIPO: TStringField
      FieldName = 'TIPO'
      Size = 15
    end
    object cdsGoogleMapsPLACEID: TStringField
      FieldName = 'PLACEID'
      Size = 50
    end
  end
  object dtsGoogleMaps: TDataSource
    AutoEdit = False
    DataSet = cdsGoogleMaps
    Left = 252
    Top = 393
  end
  object cdsCoordenadas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 540
    Top = 281
    object cdsCoordenadasCHAVE: TIntegerField
      FieldName = 'CHAVE'
    end
    object cdsCoordenadasPLACEID: TStringField
      FieldName = 'PLACEID'
      Size = 100
    end
    object cdsCoordenadasLATITUDE: TFloatField
      FieldName = 'LATITUDE'
    end
    object cdsCoordenadasLONGITUDE: TFloatField
      FieldName = 'LONGITUDE'
    end
    object cdsCoordenadasORDEM: TSmallintField
      FieldName = 'ORDEM'
    end
    object cdsCoordenadasDISTANCIALINHARETA: TFloatField
      FieldName = 'DISTANCIALINHARETA'
    end
    object cdsCoordenadasTEMPOPROCESSAMENTO: TIntegerField
      FieldName = 'TEMPOPROCESSAMENTO'
    end
  end
end
