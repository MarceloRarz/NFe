program GestorNFe;





uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDMPrincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uPadrao in 'uPadrao.pas' {frmPadrao},
  uConfiguracao.Empresa in 'uConfiguracao.Empresa.pas' {frmConfiguracaoEmpresa},
  uDMConfiguracao in 'uDMConfiguracao.pas' {DMConfiguracao: TDataModule},
  uConstantes in 'uConstantes.pas',
  ufrmStatus in 'ufrmStatus.pas' {frmStatus},
  uConfiguracao.BancoDados in 'uConfiguracao.BancoDados.pas' {frmConfiguracaoBancoDados},
  uDMNFe in 'uDMNFe.pas' {DMNFe: TDataModule},
  uFrmCTe in 'uFrmCTe.pas' {frmCTe},
  uDMCTe in 'uDMCTe.pas' {DMCTe: TDataModule},
  uFrmNFe in 'uFrmNFe.pas' {frmNFe},
  uFuncoesGeral in 'uFuncoesGeral.pas',
  uAguarde in 'uAguarde.pas' {frmAguarde};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmAguarde, frmAguarde);
  Application.Run;
end.
