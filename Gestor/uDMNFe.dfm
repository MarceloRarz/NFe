object DMNFe: TDMNFe
  OldCreateOrder = False
  Height = 267
  Width = 361
  object qryNFE: TFDQuery
    Connection = DMPrincipal.FDConn
    SQL.Strings = (
      'select * from nfe where chave = :pchave')
    Left = 40
    Top = 16
    ParamData = <
      item
        Name = 'PCHAVE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object qryNFEID: TFMTBCDField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Precision = 38
      Size = 38
    end
    object qryNFECHAVE: TStringField
      FieldName = 'CHAVE'
      Origin = 'CHAVE'
      Size = 50
    end
    object qryNFEDATA_EMISSAO: TDateTimeField
      FieldName = 'DATA_EMISSAO'
      Origin = 'DATA_EMISSAO'
    end
    object qryNFEDATA_CONSULTA: TDateTimeField
      FieldName = 'DATA_CONSULTA'
      Origin = 'DATA_CONSULTA'
    end
    object qryNFESITUACAO: TStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Size = 1
    end
    object qryNFESTATUS: TFMTBCDField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Precision = 38
      Size = 0
    end
    object qryNFESITUACAO_OPERACAO: TStringField
      FieldName = 'SITUACAO_OPERACAO'
      Origin = 'SITUACAO_OPERACAO'
      Size = 2
    end
    object qryNFEDATA_DOWNLOAD: TDateTimeField
      FieldName = 'DATA_DOWNLOAD'
      Origin = 'DATA_DOWNLOAD'
    end
    object qryNFEDIAS_MANIFESTACAO: TFMTBCDField
      FieldName = 'DIAS_MANIFESTACAO'
      Origin = 'DIAS_MANIFESTACAO'
      Precision = 38
      Size = 38
    end
    object qryNFENSU: TStringField
      FieldName = 'NSU'
      Origin = 'NSU'
    end
    object qryNFECNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 14
    end
    object qryNFESERIE: TStringField
      FieldName = 'SERIE'
      Origin = 'SERIE'
    end
    object qryNFENUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 50
    end
    object qryNFERAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Origin = 'RAZAO_SOCIAL'
      Size = 50
    end
    object qryNFEINSCRICAO_ESTADUAL: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Origin = 'INSCRICAO_ESTADUAL'
    end
    object qryNFETIPO_NOTA: TStringField
      FieldName = 'TIPO_NOTA'
      Origin = 'TIPO_NOTA'
      Size = 1
    end
  end
  object qryPesquisarNFe: TFDQuery
    OnCalcFields = qryPesquisarNFeCalcFields
    Connection = DMPrincipal.FDConn
    FetchOptions.AssignedValues = [evMode, evCursorKind]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select * from nfe')
    Left = 40
    Top = 72
    object qryPesquisarNFeCHAVE: TStringField
      FieldName = 'CHAVE'
      Origin = 'CHAVE'
      Size = 50
    end
    object qryPesquisarNFeDATA_EMISSAO: TDateTimeField
      FieldName = 'DATA_EMISSAO'
      Origin = 'DATA_EMISSAO'
    end
    object qryPesquisarNFeDATA_CONSULTA: TDateTimeField
      FieldName = 'DATA_CONSULTA'
      Origin = 'DATA_CONSULTA'
    end
    object qryPesquisarNFeSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Size = 1
    end
    object qryPesquisarNFeSTATUS: TFMTBCDField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Precision = 38
      Size = 0
    end
    object qryPesquisarNFeSITUACAO_OPERACAO: TStringField
      FieldName = 'SITUACAO_OPERACAO'
      Origin = 'SITUACAO_OPERACAO'
      Size = 2
    end
    object qryPesquisarNFeDATA_DOWNLOAD: TDateTimeField
      FieldName = 'DATA_DOWNLOAD'
      Origin = 'DATA_DOWNLOAD'
    end
    object qryPesquisarNFedias_manifestacao: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'dias_manifestacao'
      Calculated = True
    end
    object qryPesquisarNFeID: TFMTBCDField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Precision = 38
      Size = 38
    end
    object qryPesquisarNFeNSU: TStringField
      FieldName = 'NSU'
      Origin = 'NSU'
    end
    object qryPesquisarNFeCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      EditMask = '00\.000\.000\/0000\-00;0;_'
      Size = 14
    end
    object qryPesquisarNFeSERIE: TStringField
      FieldName = 'SERIE'
      Origin = 'SERIE'
    end
    object qryPesquisarNFeNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 50
    end
    object qryPesquisarNFeRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Origin = 'RAZAO_SOCIAL'
      Size = 50
    end
    object qryPesquisarNFeINSCRICAO_ESTADUAL: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Origin = 'INSCRICAO_ESTADUAL'
    end
    object qryPesquisarNFeTIPO_NOTA: TStringField
      FieldName = 'TIPO_NOTA'
      Origin = 'TIPO_NOTA'
      Size = 1
    end
  end
end
