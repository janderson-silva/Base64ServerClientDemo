object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Enviar Foto'
  ClientHeight = 261
  ClientWidth = 284
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
    Width = 284
    Height = 220
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Image1: TImage
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 278
      Height = 214
      Align = alClient
      Stretch = True
      ExplicitLeft = 72
      ExplicitTop = 40
      ExplicitWidth = 105
      ExplicitHeight = 105
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 220
    Width = 284
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnEnviar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 100
      Height = 35
      Align = alLeft
      Caption = 'Enviar Foto'
      TabOrder = 0
      OnClick = btnEnviarClick
    end
  end
end
