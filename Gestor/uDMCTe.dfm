object DMCTe: TDMCTe
  OldCreateOrder = False
  Height = 212
  Width = 305
  object qryCTE: TFDQuery
    Connection = DMPrincipal.FDConn
    SQL.Strings = (
      'select * from cte where chave = :pchave')
    Left = 24
    Top = 24
    ParamData = <
      item
        Name = 'PCHAVE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object qryCTEID: TFMTBCDField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Precision = 38
      Size = 38
    end
    object qryCTECHAVE: TStringField
      FieldName = 'CHAVE'
      Origin = 'CHAVE'
      Size = 50
    end
    object qryCTEDATA_EMISSAO: TDateTimeField
      FieldName = 'DATA_EMISSAO'
      Origin = 'DATA_EMISSAO'
    end
    object qryCTEDATA_CONSULTA: TDateTimeField
      FieldName = 'DATA_CONSULTA'
      Origin = 'DATA_CONSULTA'
    end
    object qryCTESITUACAO: TStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Size = 1
    end
    object qryCTESTATUS: TFMTBCDField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Precision = 38
      Size = 0
    end
    object qryCTECNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 14
    end
    object qryCTENSU: TStringField
      FieldName = 'NSU'
      Origin = 'NSU'
    end
    object qryCTESERIE: TStringField
      FieldName = 'SERIE'
      Origin = 'SERIE'
    end
    object qryCTENUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 50
    end
    object qryCTERAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Origin = 'RAZAO_SOCIAL'
      Size = 150
    end
    object qryCTEINSCRICAO_ESTADUAL: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Origin = 'INSCRICAO_ESTADUAL'
    end
    object qryCTETIPO_NOTA: TStringField
      FieldName = 'TIPO_NOTA'
      Origin = 'TIPO_NOTA'
      Size = 1
    end
    object qryCTEDATA_DOWNLOAD: TDateTimeField
      FieldName = 'DATA_DOWNLOAD'
      Origin = 'DATA_DOWNLOAD'
    end
  end
  object qryPesquisarCTe: TFDQuery
    Connection = DMPrincipal.FDConn
    SQL.Strings = (
      'select * from cte')
    Left = 24
    Top = 80
    object qryPesquisarCTeCHAVE: TStringField
      FieldName = 'CHAVE'
      Origin = 'CHAVE'
      Size = 50
    end
    object qryPesquisarCTeDATA_EMISSAO: TDateTimeField
      FieldName = 'DATA_EMISSAO'
      Origin = 'DATA_EMISSAO'
    end
    object qryPesquisarCTeDATA_CONSULTA: TDateTimeField
      FieldName = 'DATA_CONSULTA'
      Origin = 'DATA_CONSULTA'
    end
    object qryPesquisarCTeSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Size = 1
    end
    object qryPesquisarCTeSTATUS: TFMTBCDField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Precision = 38
      Size = 0
    end
    object qryPesquisarCTeCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 14
    end
    object qryPesquisarCTeNSU: TStringField
      FieldName = 'NSU'
      Origin = 'NSU'
    end
    object qryPesquisarCTeSERIE: TStringField
      FieldName = 'SERIE'
      Origin = 'SERIE'
    end
    object qryPesquisarCTeNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 50
    end
    object qryPesquisarCTeRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Origin = 'RAZAO_SOCIAL'
      Size = 150
    end
    object qryPesquisarCTeINSCRICAO_ESTADUAL: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Origin = 'INSCRICAO_ESTADUAL'
    end
    object qryPesquisarCTeTIPO_NOTA: TStringField
      FieldName = 'TIPO_NOTA'
      Origin = 'TIPO_NOTA'
      Size = 1
    end
    object qryPesquisarCTeDATA_DOWNLOAD: TDateTimeField
      FieldName = 'DATA_DOWNLOAD'
      Origin = 'DATA_DOWNLOAD'
    end
  end
end
