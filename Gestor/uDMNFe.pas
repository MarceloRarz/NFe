unit uDMNFe;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDMNFe = class(TDataModule)
    qryNFE: TFDQuery;
    qryNFEID: TFMTBCDField;
    qryNFECHAVE: TStringField;
    qryNFEDATA_EMISSAO: TDateTimeField;
    qryNFEDATA_CONSULTA: TDateTimeField;
    qryNFESITUACAO: TStringField;
    qryNFESTATUS: TFMTBCDField;
    qryPesquisarNFe: TFDQuery;
    qryPesquisarNFeCHAVE: TStringField;
    qryPesquisarNFeDATA_EMISSAO: TDateTimeField;
    qryPesquisarNFeDATA_CONSULTA: TDateTimeField;
    qryPesquisarNFeSITUACAO: TStringField;
    qryPesquisarNFeSTATUS: TFMTBCDField;
    qryPesquisarNFeSITUACAO_OPERACAO: TStringField;
    qryNFESITUACAO_OPERACAO: TStringField;
    qryNFEDATA_DOWNLOAD: TDateTimeField;
    qryPesquisarNFeDATA_DOWNLOAD: TDateTimeField;
    qryPesquisarNFedias_manifestacao: TIntegerField;
    qryNFEDIAS_MANIFESTACAO: TFMTBCDField;
    qryNFENSU: TStringField;
    qryNFECNPJ: TStringField;
    qryNFESERIE: TStringField;
    qryNFENUMERO: TStringField;
    qryNFERAZAO_SOCIAL: TStringField;
    qryNFEINSCRICAO_ESTADUAL: TStringField;
    qryPesquisarNFeID: TFMTBCDField;
    qryPesquisarNFeNSU: TStringField;
    qryPesquisarNFeCNPJ: TStringField;
    qryPesquisarNFeSERIE: TStringField;
    qryPesquisarNFeNUMERO: TStringField;
    qryPesquisarNFeRAZAO_SOCIAL: TStringField;
    qryPesquisarNFeINSCRICAO_ESTADUAL: TStringField;
    qryNFETIPO_NOTA: TStringField;
    qryPesquisarNFeTIPO_NOTA: TStringField;
    procedure qryPesquisarNFeCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SalvarConsultaNfe(pChave, pSituacao, pCodStatus, pDataConsulta, pDataEmissao: string);
    procedure SalvarDistribuicaoDFE(pChave, pNSU, pCNPJ, pStatusNota, pTipoNfe,
      pSerie, pNumero, pRazaoSocial, pIEst, pDataConsulta, pDataEmissao, pSituacaoOperacao: string);
    procedure PesquisarNFE(pChave, pSituacao, pDTConsultaIni, pDTConsultaFim,
      pDTEmissaoIni, pDTEmissaoFim : string);
    function AtualizarSituacaoOperacao(pChave, pSituacaoOperacao: string; pDataDownload: TDateTime): Boolean; overload;
    function AtualizarSituacaoOperacao(pChave, pSituacaoOperacao: string): Boolean; overload;

  end;



var
  DMNFe: TDMNFe;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDMPrincipal, DateUtils;

{$R *.dfm}

{ TDataModule1 }

function TDMNFe.AtualizarSituacaoOperacao(pChave, pSituacaoOperacao: string; pDataDownload: TDateTime): Boolean;
var
  QryNFe: TFDQuery;
  SQL: string;
begin
  try
    QryNFe := TFDQuery.Create(nil);
    QryNFe.Connection := DMPrincipal.FDConn;

    if pDataDownload = 0 then
      QryNFe.ExecSQL('UPDATE NFE SET SITUACAO_OPERACAO = :pSITUACAOOPERACAO WHERE ' +
                     'CHAVE = :pCHAVE',[pSituacaoOperacao, pChave])
    else  
      QryNFe.ExecSQL('UPDATE NFE SET SITUACAO_OPERACAO = :pSITUACAOOPERACAO, data_download = to_date(:pDATADOWNLOAD,''dd/mm/yy'') WHERE ' +
                     'CHAVE = :pCHAVE',[pSituacaoOperacao, pDataDownload , pChave]);
  finally
    FreeAndNil(QryNFe);
  end;  
end;

function TDMNFe.AtualizarSituacaoOperacao(pChave, pSituacaoOperacao: string): Boolean;
begin
  AtualizarSituacaoOperacao(pChave, pSituacaoOperacao,0);
end;

procedure TDMNFe.PesquisarNFE(pChave, pSituacao, pDTConsultaIni, pDTConsultaFim,
  pDTEmissaoIni, pDTEmissaoFim: string);
var
  SQL: string;
begin
  SQL := 'SELECT * FROM NFE WHERE 1 = 1 ';

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

  qryPesquisarNFe.Close;
  qryPesquisarNFe.SQL.Text := SQL;
  qryPesquisarNFe.Open;

  if qryPesquisarNFe.isEmpty then
    raise Exception.Create('Sua consulta não retornou resultados!');
end;

procedure TDMNFe.qryPesquisarNFeCalcFields(DataSet: TDataSet);
var
  DataTemp,
  DataDownload,
  DataConsulta: TDateTime;
  SiatuacaoOperacao: string;
begin
  if DataSet.State = dsCalcFields then
  begin
    SiatuacaoOperacao :=  DataSet.FieldByName('situacao_operacao').AsString;
    DataDownload      :=  DataSet.FieldByName('data_download').AsDateTime;
    if  (SiatuacaoOperacao = 'CO') and (DataDownload > 0) then
    begin
      DataTemp := IncDay(DataDownload, 180);
      DataSet.FieldByName('dias_manifestacao').AsInteger := DaysBetween(now,DataTemp);      
    end;
  end;
end;

procedure TDMNFe.SalvarConsultaNfe(pChave, pSituacao, pCodStatus, pDataConsulta, pDataEmissao: string);
begin
  qryNfe.Open;

  qryNfe.Append;

  qryNfeCHAVE.AsString         := pChave;
  qryNfeDATA_EMISSAO.AsString  := pDataEmissao;
  qryNfeDATA_CONSULTA.AsString := pDataConsulta;
  qryNfeSITUACAO.AsString     := pSituacao;
 // qryNfeSTATUS.AsString        := pStatus;

  qryNfe.Post;
end;

procedure TDMNFe.SalvarDistribuicaoDFE(pChave, pNSU, pCNPJ, pStatusNota, pTipoNfe,
      pSerie, pNumero, pRazaoSocial, pIEst, pDataConsulta, pDataEmissao, pSituacaoOperacao: string);
begin
  qryNfe.Close;
  qryNfe.ParamByName('pchave').AsString := pChave;
  qryNfe.Open;
  qryNfe.Edit;

  qryNfeCHAVE.AsString              := pChave;
  qryNfeDATA_EMISSAO.AsString       := pDataEmissao;
  qryNfeDATA_CONSULTA.AsString      := pDataConsulta;
  qryNFESITUACAO.AsString           := pStatusNota;
  qryNFETIPO_NOTA.AsString          := pTipoNFE; {Entrada - Saída};
  qryNFECNPJ.AsString               := pCNPJ;
  qryNFEINSCRICAO_ESTADUAL.AsString := pIEst;
  qryNFENSU.AsString                := pNSU;
  qryNFESERIE.AsString              := pSerie;
  qryNFENUMERO.AsString             := pNumero;
  qryNFERAZAO_SOCIAL.AsString       := copy(pRazaoSocial,1,150);
  qryNFESITUACAO_OPERACAO.AsString  := pSituacaoOperacao;
  qryNfe.Post;
end;

end.
