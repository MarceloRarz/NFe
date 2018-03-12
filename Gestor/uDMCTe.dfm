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
  end
end
