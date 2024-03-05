object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Enviar Arquivo'
  ClientHeight = 438
  ClientWidth = 1064
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 438
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Panel3: TPanel
      Left = 0
      Top = 397
      Width = 500
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 250
      object btnEnviar: TButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 100
        Height = 35
        Align = alLeft
        Caption = 'Enviar Arquivo'
        TabOrder = 0
        OnClick = btnEnviarClick
      end
    end
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 500
      Height = 397
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object Panel4: TPanel
    Left = 564
    Top = 0
    Width = 500
    Height = 438
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 428
    object Panel6: TPanel
      Left = 0
      Top = 397
      Width = 500
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 250
      object btnReceber: TButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 100
        Height = 35
        Align = alLeft
        Caption = 'Receber Arquivo'
        TabOrder = 0
        OnClick = btnReceberClick
      end
    end
    object Memo2: TMemo
      Left = 0
      Top = 0
      Width = 500
      Height = 397
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 414
    Top = 48
  end
end
