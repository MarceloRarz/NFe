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
  private
    { Private declarations }
  public
    { Public declarations }
  procedure SalvarConsultaCTe(pChave, pSituacao, pStatus, pDataConsulta, pDataEmissao: string);
  procedure PesquisarCTe(pChave, pSituacao, pDTConsultaIni, pDTConsultaFim,
    pDTEmissaoIni, pDTEmissaoFim : string);
  end;

var
  DMCTe: TDMCTe;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

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

end.
