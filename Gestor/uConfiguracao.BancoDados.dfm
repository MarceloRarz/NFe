object frmConfiguracaoBancoDados: TfrmConfiguracaoBancoDados
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o -> Banco de Dados'
  ClientHeight = 227
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 252
    Height = 221
    Align = alClient
    Caption = '  Configura'#231#245'es do banco de dados  '
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 29
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
    end
    object Label2: TLabel
      Left = 15
      Top = 74
      Width = 30
      Height = 13
      Caption = 'Senha'
    end
    object Label3: TLabel
      Left = 15
      Top = 119
      Width = 43
      Height = 13
      Caption = 'Conex'#227'o'
    end
    object edtUsuario: TEdit
      Left = 15
      Top = 45
      Width = 185
      Height = 21
      HideSelection = False
      TabOrder = 0
      TextHint = 'usu'#225'rio'
    end
    object edtSenha: TEdit
      Left = 15
      Top = 89
      Width = 185
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
      TextHint = 'senha'
    end
    object edtConexao: TEdit
      Left = 15
      Top = 135
      Width = 185
      Height = 21
      HideSelection = False
      TabOrder = 2
      TextHint = 'conex'#227'o'
    end
    object btnAtivar: TBitBtn
      Left = 9
      Top = 176
      Width = 75
      Height = 25
      Caption = 'Ativar'
      TabOrder = 3
      OnClick = btnAtivarClick
    end
    object btnSalvarBanco: TBitBtn
      Left = 90
      Top = 176
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 4
      OnClick = btnSalvarBancoClick
    end
    object btnFechar: TBitBtn
      Left = 171
      Top = 176
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 5
      OnClick = btnFecharClick
    end
  end
end
