object DMConfiguracao: TDMConfiguracao
  OldCreateOrder = False
  Height = 150
  Width = 437
  object qryConfiguracao: TFDQuery
    Connection = DMPrincipal.FDConn
    SQL.Strings = (
      'select * from configuracao where rownum = 1')
    Left = 40
    Top = 24
    object qryConfiguracaoCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 14
    end
    object qryConfiguracaoINSCRICAOESTADUAL: TStringField
      FieldName = 'INSCRICAOESTADUAL'
      Origin = 'INSCRICAOESTADUAL'
    end
    object qryConfiguracaoRAZAOSOCIAL: TStringField
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Size = 150
    end
    object qryConfiguracaoNOMEFANTASIA: TStringField
      FieldName = 'NOMEFANTASIA'
      Origin = 'NOMEFANTASIA'
      Size = 150
    end
    object qryConfiguracaoDD: TStringField
      FieldName = 'DD'
      Origin = 'DD'
      Size = 2
    end
    object qryConfiguracaoFONE: TStringField
      FieldName = 'FONE'
      Origin = 'FONE'
      Size = 9
    end
    object qryConfiguracaoCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 8
    end
    object qryConfiguracaoNUMERO: TFMTBCDField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Precision = 38
      Size = 0
    end
    object qryConfiguracaoLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Size = 150
    end
    object qryConfiguracaoBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 50
    end
    object qryConfiguracaoCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 150
    end
    object qryConfiguracaoCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 50
    end
    object qryConfiguracaoUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
    object qryConfiguracaoIDCIDADE: TFMTBCDField
      FieldName = 'IDCIDADE'
      Origin = 'IDCIDADE'
      Precision = 38
      Size = 0
    end
    object qryConfiguracaoNUMEROSERIE: TStringField
      FieldName = 'NUMEROSERIE'
      Origin = 'NUMEROSERIE'
      Size = 100
    end
    object qryConfiguracaoSENHACERTIFICADO: TStringField
      FieldName = 'SENHACERTIFICADO'
      Origin = 'SENHACERTIFICADO'
      Size = 10
    end
    object qryConfiguracaoULTIMONSU_NFE: TStringField
      FieldName = 'ULTIMONSU_NFE'
      Origin = 'ULTIMONSU_NFE'
    end
    object qryConfiguracaoULTIMONSU_CTE: TStringField
      FieldName = 'ULTIMONSU_CTE'
      Origin = 'ULTIMONSU_CTE'
    end
  end
end
