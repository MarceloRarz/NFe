object frConfiguraSerial: TfrConfiguraSerial
  Left = 340
  Top = 158
  ActiveControl = cmbPortaSerial
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Porta Serial'
  ClientHeight = 297
  ClientWidth = 268
  Color = clBtnFace
  Constraints.MinWidth = 180
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    268
    297)
  PixelsPerInch = 96
  TextHeight = 13
  object lBaud: TLabel
    Left = 8
    Top = 47
    Width = 139
    Height = 13
    Caption = '&Baud rate (Bits por Segundo)'
    Color = clBtnFace
    FocusControl = cmbBaudRate
    ParentColor = False
  end
  object lData: TLabel
    Left = 8
    Top = 89
    Width = 119
    Height = 13
    Caption = '&Data Bits (Bits de Dados)'
    Color = clBtnFace
    FocusControl = cmbDataBits
    ParentColor = False
  end
  object lParity: TLabel
    Left = 8
    Top = 131
    Width = 81
    Height = 13
    Caption = '&Parity (Paridade)'
    Color = clBtnFace
    FocusControl = cmbParity
    ParentColor = False
  end
  object lStop: TLabel
    Left = 8
    Top = 173
    Width = 122
    Height = 13
    Caption = '&Stop Bits (Bits de Parada)'
    Color = clBtnFace
    FocusControl = cmbStopBits
    ParentColor = False
  end
  object lHandShaking: TLabel
    Left = 8
    Top = 215
    Width = 157
    Height = 13
    Caption = '&Handshaking (Controle de Fluxo)'
    Color = clBtnFace
    FocusControl = cmbHandShaking
    ParentColor = False
  end
  object lPortaSerial: TLabel
    Left = 8
    Top = 5
    Width = 55
    Height = 13
    Caption = '&Porta Serial'
    Color = clBtnFace
    FocusControl = cmbPortaSerial
    ParentColor = False
  end
  object cmbBaudRate: TComboBox
    Left = 8
    Top = 64
    Width = 161
    Height = 21
    ItemIndex = 6
    TabOrder = 1
    Text = '9600'
    OnChange = cmbBaudRateChange
    Items.Strings = (
      '110'
      '300'
      '600'
      '1200'
      '2400'
      '4800'
      '9600'
      '14400'
      '19200'
      '38400'
      '56000'
      '57600'
      '115200')
  end
  object cmbDataBits: TComboBox
    Left = 8
    Top = 106
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemIndex = 3
    TabOrder = 2
    Text = '8'
    OnChange = cmbDataBitsChange
    Items.Strings = (
      '5'
      '6'
      '7'
      '8')
  end
  object cmbParity: TComboBox
    Left = 8
    Top = 148
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 3
    Text = 'None'
    OnChange = cmbParityChange
    Items.Strings = (
      'None'
      'Odd'
      'Even'
      'Mark'
      'Space')
  end
  object cmbStopBits: TComboBox
    Left = 8
    Top = 190
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 4
    Text = '1'
    OnChange = cmbStopBitsChange
    Items.Strings = (
      '1'
      '1,5'
      '2'
      '')
  end
  object cmbHandShaking: TComboBox
    Left = 8
    Top = 232
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 5
    Text = 'Nenhum'
    OnChange = cmbHandShakingChange
    Items.Strings = (
      'Nenhum'
      'XON/XOFF'
      'RTS/CTS'
      'DTR/DSR')
  end
  object cmbPortaSerial: TComboBox
    Left = 8
    Top = 22
    Width = 161
    Height = 21
    ItemIndex = 0
    TabOrder = 0
    Text = 'COM1'
    OnChange = cmbPortaSerialChange
    Items.Strings = (
      'COM1'
      'COM2'
      'COM3'
      'COM4'
      'COM5'
      'COM6'
      'COM7'
      'COM8'
      '/dev/ttyS0'
      '/dev/ttyS1'
      '/dev/ttyUSB0'
      '/dev/ttyUSB1')
  end
  object btOk: TBitBtn
    Left = 181
    Top = 101
    Width = 75
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'OK'
    Default = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF001808086531000400FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00180839A66B6BEBB539
      925A000800FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF00180031A26339E39C18DB8C52E7AD398E5A000C00FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF001C00219E5229D78C18CF8418D38418
      D78442DF9C318A4A000C00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF001C00
      10924218C77318C36B18C77318C77B18CB7B18CF7B29D78C218642001000FF00
      FFFF00FFFF00FFFF00FF002400108E3918BA6318B66331C37342CB8442D38C4A
      CF8C39CB8429C77B21CB7B108A39001800FF00FFFF00FFFF00FF08712921B65A
      52BE8473CF9C7BD7A542BE7B107D4252CF947BDBAD73D7A56BD39C42CB84108A
      31002000FF00FFFF00FF0030104AB26B9CDBB594DBB542BA73003010FF00FF08
      45215ACF8C9CDFBD94DBB594DBB55ACB8C108A31002800FF00FFFF00FF002008
      52AE7342AA6B001C08FF00FFFF00FFFF00FF0030105ABE84B5E7CEB5E3C6B5E3
      C673CF9C108629002C00FF00FFFF00FF001800001400FF00FFFF00FFFF00FFFF
      00FFFF00FF00200852AE73D6F3DECEEBDEDEEFE794DBAD085D18FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF001400529E63EFFF
      F7DEF7E742965A001000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF000000428E5239864A000000FF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000C
      00000C00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    ModalResult = 1
    TabOrder = 8
  end
  object btCancel: TBitBtn
    Left = 181
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Cancela'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      101073000029FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0004
      3110106BFF00FFFF00FFFF00FF00008C3134F70808CE000031FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF000039080CCE3130EF00007BFF00FF0000630808E7
      4A49F74A4DF70000C6000039FF00FFFF00FFFF00FFFF00FF00004A0004CE5A59
      EF5A59F70808DE00004A0004842120FF3134FF5A59FF4A49EF0004C6000042FF
      00FFFF00FF0000520808CE5A59EF7371FF5255FF3134FF00046B000473181CFF
      2928FF3938FF5255FF4245EF0004C600004A00005A0808CE5255EF6B69FF5251
      FF4241FF3130FF080C52FF00FF08087B181CFF2928FF3134FF4A49FF3134EF00
      00BD0004C64245EF5A59FF4245FF393CFF292CFF080C63FF00FFFF00FFFF00FF
      08086B1818FF292CFF393CFF4A4DFF3130EF3134EF4A49FF3938FF3130FF2124
      F708084AFF00FFFF00FFFF00FFFF00FFFF00FF000452393CEF6361FF6361FF63
      61FF6361FF6361FF5A59FF2928DE000439FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF00048C393CF76361FF6361FF6365FF6365FF3134EF000463FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00005A0000A53130F76B69FF6B
      69FF6B69FF6B69FF2120E700009C000042FF00FFFF00FFFF00FFFF00FFFF00FF
      0000520000A53134F77B79FF7B79FF7B79FF7B79FF7B79FF7375FF2124E70000
      94000039FF00FFFF00FFFF00FF00005200009C4241F78C8AFF8C8AFF8C8AFF31
      30C64A49DE8C8EFF8C8AFF8486FF2928E700008C000039FF00FF00001800009C
      4A49F79C9AFF9C9AFF9C9AFF3134BDFF00FF0000215255E79C9EFF9C9AFF9496
      FF292CE700007BFF00FF0000295255FFADAEFFADAAFFADAAFF393CBDFF00FFFF
      00FFFF00FF0000295A5DE7ADAEFFADAAFFADAAFF3130DEFF00FFFF00FF4245BD
      BDBAFFBDBAFF393CBDFF00FFFF00FFFF00FFFF00FFFF00FF0000296B69E7CECB
      FFA5A6FF21248CFF00FFFF00FFFF00FF393CBD4241C6FF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF0000295A59E7181C7BFF00FFFF00FF}
    ModalResult = 2
    TabOrder = 9
  end
  object chHardFlow: TCheckBox
    Left = 8
    Top = 260
    Width = 71
    Height = 19
    Caption = 'HardFlow'
    TabOrder = 6
    OnClick = chHardFlowClick
  end
  object chSoftFlow: TCheckBox
    Left = 103
    Top = 260
    Width = 66
    Height = 19
    Anchors = [akTop, akRight]
    Caption = 'SoftFlow'
    TabOrder = 7
    OnClick = chSoftFlowClick
  end
  object btPadrao: TBitBtn
    Left = 181
    Top = 171
    Width = 75
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Padr'#227'o'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFCFCFCB7B7BBEBEBEBFF00FFFF00FFFF
      00FFFF00FFFF00FFFBFBFB899C89A7ADA7FDFDFDFF00FFFF00FFFF00FFF9F9F9
      6E7CA31045DE32489CA5A5AAF8F8F8FF00FFFF00FFF6F6F6699564299E101886
      0853804EC0C1C0FF00FFF0F0F05F73A9105DFF1859FF104DFF083CDE455693C8
      C8C9EEEEEE5B985618A60021A60818A20010A600188E097691765E7DB9186DFF
      1869FF216DFF1861FF1861FF1861FF6A75A385AA7D18C30008B20018BA1018B6
      0810B20010BE0033932D3E7DEA297DFF297DFF3986FF4A8AFF4A8EFF317DFF71
      7DAA74AE6B08D70008CB0021C31831CB2942D73931DB293B9F354487E33192FF
      2982FF1061FF2975FF63A2FF6BAEFF6577A879975310DF0810D71010B20810B6
      0031D3215AF3524BAA444E93E24AA2FF3186FF317DFF2975FF2979FF428EFF92
      7163F7930BBD9A0863AA2142D34242DF424ADB4242EF395BA956679CE684BEFF
      94C3FF8CBAFF84BAFF73AAFFA58673FFAE00FFBA08FFB200FFA200C6A22994E3
      7B73FF7B5BB755E0E1E0EDF0FA91B5F380B2F7BDE3FF9CD3FF9D938DFFBE00FF
      C700FFCB10FFC708FFC700FFB600A5D76363C068EDEDEDFF00FFFF00FFFF00FF
      E0E7F885B5FF7796D0B79D6FFFDF00FFD300FFC318FFD329FFE339FFD310899B
      5AF6F6F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC2AB79FFEB08FF
      C708FFAE00FFB608FFD731FFE342BBADA8FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFC7AC7EFFE739FFDB42FFD742FFD742FFDF42DBA03EDAD7
      D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFEFE9E5F6C58AF7
      D97AFFFB9CFFFB94D7AC64DAD8D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFF6E3D3F3C487D8B078E4E3E3FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    ModalResult = 2
    TabOrder = 10
    OnClick = btPadraoClick
  end
end
