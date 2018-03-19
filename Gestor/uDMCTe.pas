unit uDMCTe;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDMCTe = class(TDataModule)
    qryCTE: TFDQuery;
    qryCTEID: TFMTBCDField;
    qryCTECHAVE: TStringField;
    qryCTEDATA_EMISSAO: TDateTimeField;
    qryCTEDATA_CONSULTA: TDateTimeField;
    qryCTESITUACAO: TStringField;
    qryCTESTATUS: TFMTBCDField;
    qryPesquisarCTe: TFDQuery;
    qryPesquisarCTeCHAVE: TStringField;
    qryPesquisarCTeDATA_EMISSAO: TDateTimeField;
    qryPesquisarCTeDATA_CONSULTA: TDateTimeField;
    qryPesquisarCTeSITUACAO: TStringField;
    qryPesquisarCTeSTATUS: TFMTBCDField;
    qryCTECNPJ: TStringField;
    qryCTENSU: TStringField;
    qryCTESERIE: TStringField;
    qryCTENUMERO: TStringField;
    qryCTERAZAO_SOCIAL: TStringField;
    qryCTEINSCRICAO_ESTADUAL: TStringField;
    qryCTETIPO_NOTA: TStringField;
    qryCTEDATA_DOWNLOAD: TDateTimeField;
    qryPesquisarCTeCNPJ: TStringField;
    qryPesquisarCTeNSU: TStringField;
    qryPesquisarCTeSERIE: TStringField;
    qryPesquisarCTeNUMERO: TStringField;
    qryPesquisarCTeRAZAO_SOCIAL: TStringField;
    qryPesquisarCTeINSCRICAO_ESTADUAL: TStringField;
    qryPesquisarCTeTIPO_NOTA: TStringField;
    qryPesquisarCTeDATA_DOWNLOAD: TDateTimeField;
  private
    { Private declarations }
  public
    { Public declarations }
  procedure SalvarConsultaCTe(pChave, pSituacao, pStatus, pDataConsulta, pDataEmissao: string);
  procedure PesquisarCTe(pChave, pSituacao, pDTConsultaIni, pDTConsultaFim,
    pDTEmissaoIni, pDTEmissaoFim : string);
  procedure SalvarDistribuicaoDFE(pChave, pNSU, pCNPJ, pStatusNota, pTipoNfe,
    pSerie, pNumero, pRazaoSocial, pIEst, pDataConsulta, pDataEmissao: string);
  function AtualizarSituacaoOperacao(pChave, pSituacaoOperacao: string; pDataDownload: TDateTime): Boolean; overload;
  function AtualizarSituacaoOperacao(pChave, pSituacaoOperacao: string): Boolean; overload;
  end;

var
  DMCTe: TDMCTe;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDMPrincipal;

{$R *.dfm}

{ TDataModule1 }

function TDMCTe.AtualizarSituacaoOperacao(pChave, pSituacaoOperacao: string;
  pDataDownload: TDateTime): Boolean;
var
  QryNFe: TFDQuery;
  SQL: string;
begin
  try
    QryNFe := TFDQuery.Create(nil);
    QryNFe.Connection := DMPrincipal.FDConn;

    if pDataDownload = 0 then
      QryNFe.ExecSQL('UPDATE CTE SET SITUACAO_OPERACAO = :pSITUACAOOPERACAO WHERE ' +
                     'CHAVE = :pCHAVE',[pSituacaoOperacao, pChave])
    else
      QryNFe.ExecSQL('UPDATE CTE SET SITUACAO_OPERACAO = :pSITUACAOOPERACAO, data_download = to_date(:pDATADOWNLOAD,''dd/mm/yy'') WHERE ' +
                     'CHAVE = :pCHAVE',[pSituacaoOperacao, pDataDownload , pChave]);
  finally
    FreeAndNil(QryNFe);
  end;
end;

function TDMCTe.AtualizarSituacaoOperacao(pChave,
  pSituacaoOperacao: string): Boolean;
begin
  AtualizarSituacaoOperacao(pChave, pSituacaoOperacao,0);
end;

procedure TDMCTe.PesquisarCTe(pChave, pSituacao, pDTConsultaIni,
  pDTConsultaFim, pDTEmissaoIni, pDTEmissaoFim: string);
var
  SQL: string;
begin
  SQL := 'SELECT * FROM CTE WHERE 1 = 1 ';

  if not pChave.Trim.IsEmpty then
  begin
    SQL := SQL + ' AND CHAVE = ' + pChave.QuotedString;
  end;

  if (pDTEmissaoIni <> EmptyStr) and (pDTEmissaoFim <> EmptyStr) then
  begin
    SQL := SQL + ' AND Trunc(DATA_EMISSAO) BETWEEN To_date(' + pDTEmissaoIni.QuotedString + ',''dd/mm/yyyy'') AND To_date( ' + pDTEmissaoFim.QuotedString + ',''dd/mm/yyyy'')'  ;
  end
  else
  begin
    if (pDTConsultaIni <> EmptyStr) and (pDTConsultaFim <> EmptyStr) then
    begin
      SQL := SQL + ' AND Trunc(DATA_CONSULTA) BETWEEN To_date(' + pDTConsultaIni.QuotedString + ',''dd/mm/yyyy'') AND To_date( ' + pDTConsultaFim.QuotedString + ',''dd/mm/yyyy'')'  ;
    end;
  end;

  if not pSituacao.IsEmpty then
  begin
    SQL := SQL + 'AND SITUACAO = ' + pSituacao.QuotedString;
  end;

  qryPesquisarCTe.Close;
  qryPesquisarCTe.SQL.Text := SQL;
  qryPesquisarCTe.Open;

  if qryPesquisarCTe.isEmpty then
    raise Exception.Create('Sua consulta não retornou resultados!');
end;

procedure TDMCTe.SalvarConsultaCTe(pChave, pSituacao, pStatus,
  pDataConsulta, pDataEmissao: string);
begin
  qryCTe.Open;

  qryCTe.Append;

  qryCTeCHAVE.AsString         := pChave;
  qryCTeDATA_EMISSAO.AsString  := pDataEmissao;
  qryCTeDATA_CONSULTA.AsString := pDataConsulta;
  qryCTeSITUACAO .AsString     := pSituacao;
  qryCTeSTATUS.AsString        := pStatus;

  qryCTe.Post;
end;

procedure TDMCTe.SalvarDistribuicaoDFE(pChave, pNSU, pCNPJ, pStatusNota,
  pTipoNfe, pSerie, pNumero, pRazaoSocial, pIEst, pDataConsulta, pDataEmissao: string);
begin
  qryCTe.Close;
  qryCTe.ParamByName('pchave').AsString := pChave;
  qryCTe.Open;
  qryCTe.Edit;

  qryCTeCHAVE.AsString              := pChave;
  qryCTeDATA_EMISSAO.AsString       := pDataEmissao;
  qryCTeDATA_CONSULTA.AsString      := pDataConsulta;
  qryCTeSITUACAO.AsString           := pStatusNota;
  qryCTeTIPO_NOTA.AsString          := pTipoNFE; {Entrada - Saída};
  qryCTeCNPJ.AsString               := pCNPJ;
  qryCTeINSCRICAO_ESTADUAL.AsString := pIEst;
  qryCTeNSU.AsString                := pNSU;
  qryCTeSERIE.AsString              := pSerie;
  qryCTeNUMERO.AsString             := pNumero;
  qryCTeRAZAO_SOCIAL.AsString       := copy(pRazaoSocial,1,150);
  qryCTe.Post;
end;

end.
