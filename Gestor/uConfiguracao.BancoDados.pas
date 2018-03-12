unit uConfiguracao.BancoDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmConfiguracaoBancoDados = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    edtConexao: TEdit;
    btnAtivar: TBitBtn;
    btnSalvarBanco: TBitBtn;
    btnFechar: TBitBtn;
    procedure btnSalvarBancoClick(Sender: TObject);
    procedure btnAtivarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    function TestarConexao: Boolean;
    function ValidarAbaBancoDados: Boolean;
    procedure LerConfiguracaoBancoDados;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracaoBancoDados: TfrmConfiguracaoBancoDados;

implementation

{$R *.dfm}

uses uDMPrincipal, System.IniFiles, uConstantes;

function TfrmConfiguracaoBancoDados.TestarConexao: Boolean;
begin
  if ValidarAbaBancoDados then
    Result := DMPrincipal.AtivaConexao(edtConexao.Text, edtUsuario.Text, edtSenha.Text)
  else
    Result := False;
end;

function TfrmConfiguracaoBancoDados.ValidarAbaBancoDados: Boolean;
begin
  Result := False;

  if edtUsuario.Text = EmptyStr then
  begin
    Application.MessageBox('Usuário do banco de dados não informado.',GESTOR_NFE, MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;

  if edtSenha.Text = EmptyStr then
  begin
    Application.MessageBox('Senha do banco de dados não informada.',GESTOR_NFE, MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;

  if edtConexao.Text = EmptyStr then
  begin
    Application.MessageBox('Conexão do banco de dados não informada.',GESTOR_NFE, MB_OK + MB_ICONEXCLAMATION );
    exit;
  end;

  Result := True;
end;

procedure TfrmConfiguracaoBancoDados.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfiguracaoBancoDados.btnAtivarClick(Sender: TObject);
begin
  if TestarConexao then
  begin
    Application.MessageBox('Conexão ativada com sucesso',GESTOR_NFE,MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Não foi possível conectar ao banco de dados!',GESTOR_NFE,MB_OK + MB_ICONWARNING);
end;

procedure TfrmConfiguracaoBancoDados.btnSalvarBancoClick(Sender: TObject);
var
  ArquivoINI: TIniFile;
begin
  try
    try
      ArquivoINI := TIniFile.Create(DMPrincipal.PathAplicacao);

      ArquivoINI.WriteString('BASEDADOS','Conexao',edtConexao.Text);
      ArquivoINI.WriteString('BASEDADOS','Senha',edtSenha.Text);
      ArquivoINI.WriteString('BASEDADOS','Usuario',edtUsuario.Text);

      DMPrincipal.Usuario := edtUsuario.Text;
      DMPrincipal.Senha   := edtSenha.Text;
      DMPrincipal.Conexao := edtConexao.Text;

      Application.MessageBox('Configuração do banco de dados armazenada com sucesso!',GESTOR_NFE,MB_OK + MB_ICONINFORMATION);
    except
      on e: exception do
        Application.MessageBox(PWideChar('Não foi possível salvar as configurações do banco de dados!' + #13 +
                                         'Motivo: ' + e.Message ),GESTOR_NFE,MB_OK + MB_ICONWARNING);
    end;

  finally
    FreeAndNil(ArquivoINI);
  end;
end;

procedure TfrmConfiguracaoBancoDados.FormCreate(Sender: TObject);
begin
  LerConfiguracaoBancoDados;
end;

procedure TfrmConfiguracaoBancoDados.LerConfiguracaoBancoDados;
begin
  edtUsuario.Text := DMPrincipal.Usuario;
  edtSenha.Text   := DMPrincipal.Senha;
  edtConexao.Text := DMPrincipal.Conexao;
end;

end.
