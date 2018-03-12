unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle,
  FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin;

type
  TDMPrincipal = class(TDataModule)
    FDConn: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysOracleDriverLink1: TFDPhysOracleDriverLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PathAplicacao,
    Conexao,
    Senha,
    Usuario: string;
    StatusConexaoPrincipal: Boolean;

    function AtivaConexao(pConexao, pUsuario, pSenha: string): Boolean;
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
uses IniFiles, Vcl.Forms;

procedure TDMPrincipal.DataModuleCreate(Sender: TObject);
var
  ArquivoINI: TIniFile;
begin
  try
    PathAplicacao := ExtractFilePath(Application.ExeName) + '\config.ini';
    ArquivoINI    := TIniFile.Create(PathAplicacao);

    Conexao := ArquivoINI.ReadString('BASEDADOS','Conexao','');
    Senha   := ArquivoINI.ReadString('BASEDADOS','Senha','');
    Usuario := ArquivoINI.ReadString('BASEDADOS','Usuario','');

    if Conexao.IsEmpty or Senha.IsEmpty or Usuario.IsEmpty then
      exit;

    StatusConexaoPrincipal := AtivaConexao(Conexao, Usuario, Senha);
  finally
    FreeAndNil(ArquivoINI);
  end;
end;

function TDMPrincipal.AtivaConexao(pConexao, pUsuario,
  pSenha: string): Boolean;
begin
  FDConn.Connected := False;

  FDConn.Params.Database := pConexao;
  FDConn.Params.UserName := pUsuario;
  FDConn.Params.Password := pSenha;

  try
    FDConn.Connected := True;
    StatusConexaoPrincipal := True;
    Result := FDConn.Connected;
  except
    Result := False;
  end;
end;

end.
