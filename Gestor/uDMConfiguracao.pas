unit uDMConfiguracao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient,
  Datasnap.Provider;

type
  TDMConfiguracao = class(TDataModule)
    qryConfiguracao: TFDQuery;
    qryConfiguracaoCNPJ: TStringField;
    qryConfiguracaoINSCRICAOESTADUAL: TStringField;
    qryConfiguracaoRAZAOSOCIAL: TStringField;
    qryConfiguracaoNOMEFANTASIA: TStringField;
    qryConfiguracaoDD: TStringField;
    qryConfiguracaoFONE: TStringField;
    qryConfiguracaoCEP: TStringField;
    qryConfiguracaoNUMERO: TFMTBCDField;
    qryConfiguracaoLOGRADOURO: TStringField;
    qryConfiguracaoBAIRRO: TStringField;
    qryConfiguracaoCOMPLEMENTO: TStringField;
    qryConfiguracaoCIDADE: TStringField;
    qryConfiguracaoUF: TStringField;
    qryConfiguracaoIDCIDADE: TFMTBCDField;
    qryConfiguracaoNUMEROSERIE: TStringField;
    qryConfiguracaoSENHACERTIFICADO: TStringField;
    qryConfiguracaoULTIMONSU_NFE: TStringField;
    qryConfiguracaoULTIMONSU_CTE: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetUltimoNSU_NFE(pNSU: string);
  end;

var
  DMConfiguracao: TDMConfiguracao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDMPrincipal;

{$R *.dfm}

{ TDMConfiguracao }

procedure TDMConfiguracao.SetUltimoNSU_NFE(pNSU: string);
begin
  qryConfiguracao.Edit;
  qryConfiguracaoULTIMONSU_NFE.AsString := pNSU;
  qryConfiguracao.Post;
end;

end.
