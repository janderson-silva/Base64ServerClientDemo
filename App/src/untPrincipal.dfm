object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Enviar Arquivo'
  ClientHeight = 361
  ClientWidth = 784
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object pnlListarArquivos: TPanel
      AlignWithMargins = True
      Left = 385
      Top = 3
      Width = 120
      Height = 35
      Cursor = crHandPoint
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Listar Arquivo'
      Color = 5540912
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      StyleElements = []
      OnClick = pnlListarArquivosClick
    end
    object pnlEnviarArquivo: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 120
      Height = 35
      Cursor = crHandPoint
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Enviar Arquivo'
      Color = 5540912
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      StyleElements = []
      OnClick = pnlEnviarArquivoClick
    end
    object pnlConverter: TPanel
      AlignWithMargins = True
      Left = 511
      Top = 3
      Width = 270
      Height = 35
      Cursor = crHandPoint
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Converter Base64 selecionado para File'
      Color = 16744448
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      StyleElements = []
      OnClick = pnlConverterClick
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 91
    Width = 778
    Height = 267
    Align = alClient
    DataSource = DataSource1
    DrawingStyle = gdsClassic
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 44
    Width = 778
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Caption = 
      'Para pegar o texto Base64 completo '#233' importante o tipo do Field ' +
      'do FDMemTable ser WideMemo'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
  end
  object FDMemTable1: TFDMemTable
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
    Left = 376
    Top = 144
    object FDMemTable1id: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 7
      FieldName = 'id'
    end
    object FDMemTable1nome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 45
      FieldName = 'nome'
      Size = 250
    end
    object FDMemTable1arquivo: TWideMemoField
      DisplayLabel = 'Base64'
      FieldName = 'arquivo'
      BlobType = ftWideMemo
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 376
    Top = 216
  end
  object OpenDialog1: TOpenDialog
    Left = 376
    Top = 88
  end
end
