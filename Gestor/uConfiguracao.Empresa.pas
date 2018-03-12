unit uConfiguracao.Empresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Mask, Vcl.DBCtrls, Datasnap.DBClient,
  ACBrBase, ACBrDFe, ACBrNFe, Vcl.Imaging.pngimage;

type
  TfrmConfiguracaoEmpresa = class(TForm)
    pgConfiguracao: TPageControl;
    tbEmpresa: TTabSheet;
    tbCertificado: TTabSheet;
    tbWebService: TTabSheet;
    gbInformacoesEmpresa: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    edtCnpj: TDBEdit;
    edtInscricaoEstadual: TDBEdit;
    edtRazaoSocial: TDBEdit;
    edtNomeFantasia: TDBEdit;
    edtCep: TDBEdit;
    edtNumero: TDBEdit;
    edtFone: TDBEdit;
    Label4: TLabel;
    edtDD: TDBEdit;
    edtLogradouro: TDBEdit;
    edtBairro: TDBEdit;
    edtComplemento: TDBEdit;
    edtCidade: TDBEdit;
    edtUF: TDBEdit;
    edtCodCidade: TDBEdit;
    gbWebService: TGroupBox;
    Label43: TLabel;
    cbUF: TComboBox;
    gbCertificado: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    edtNumSerieCertificado: TDBEdit;
    edtSenhaCertificado: TDBEdit;
    OpenDialog1: TOpenDialog;
    Label29: TLabel;
    Label30: TLabel;
    Label32: TLabel;
    cbFormaEmissao: TComboBox;
    cbModeloDF: TComboBox;
    cbVersaoDF: TComboBox;
    btnPesquisarCertificado: TSpeedButton;
    ACBrNFe1: TACBrNFe;
    dsConfiguracao: TDataSource;
    pnlPersistir: TPanel;
    Image1: TImage;
    btnSalvar: TBitBtn;
    btnFechar: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pgConfiguracaoChange(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnPesquisarCertificadoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtivarConfiguracao;
    procedure HabilitaAbasEdicao;
    procedure DesabilitarAbas;
    procedure LoadConfiguracaoAcbr;
    procedure GravarConfiguracaoAcbr;
  public
    { Public declarations }
  end;

var
  frmConfiguracaoEmpresa: TfrmConfiguracaoEmpresa;

implementation

{$R *.dfm}

uses uDMConfiguracao, uDMPrincipal, uConstantes,
  System.IniFiles, ACBrDFeSSL, pcnConversao, pcnConversaoNFe, blcksock,
  System.TypInfo;

procedure TfrmConfiguracaoEmpresa.AtivarConfiguracao;
begin
  {Habilitar as abas se a configuração do banco de dados estiver funcionado}
  tbEmpresa.TabVisible     := DMPrincipal.StatusConexaoPrincipal;
  tbCertificado.TabVisible := DMPrincipal.StatusConexaoPrincipal;
  tbWebService.TabVisible  := DMPrincipal.StatusConexaoPrincipal;
  pnlPersistir.Enabled     := DMPrincipal.StatusConexaoPrincipal;

  if DMPrincipal.StatusConexaoPrincipal then
  begin
    dsConfiguracao.DataSet.Open;

    if dsConfiguracao.DataSet.IsEmpty then
      dsConfiguracao.DataSet.Append
    else
      dsConfiguracao.DataSet.Edit;
  end;
end;

procedure TfrmConfiguracaoEmpresa.btnEditarClick(Sender: TObject);
begin
  inherited;
  HabilitaAbasEdicao;
end;

procedure TfrmConfiguracaoEmpresa.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfiguracaoEmpresa.btnPesquisarCertificadoClick(Sender: TObject);
begin
  inherited;
  edtNumSerieCertificado.Text := ACBrNFe1.SSL.SelecionarCertificado;
end;

procedure TfrmConfiguracaoEmpresa.btnSalvarClick(Sender: TObject);
begin
  try
    dsConfiguracao.DataSet.Post;
  except
    on e: exception do
    begin
      Application.MessageBox(PWideChar('Não foi possível salvar!' + #13 + 'Motivo: ' + e.Message ),GESTOR_NFE,MB_OK + MB_ICONWARNING);
      btnSalvar.Enabled := False;
    end;
  end;

  GravarConfiguracaoAcbr;

  Application.MessageBox('Configurações salvas com sucesso!',GESTOR_NFE,MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmConfiguracaoEmpresa.DesabilitarAbas;
begin
  gbInformacoesEmpresa.Enabled := dsConfiguracao.DataSet.State = dsBrowse;
  gbCertificado.Enabled        := dsConfiguracao.DataSet.State = dsBrowse;
  gbWebService.Enabled         := dsConfiguracao.DataSet.State = dsBrowse;
end;

procedure TfrmConfiguracaoEmpresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(DMConfiguracao);
end;

procedure TfrmConfiguracaoEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  try
    DMConfiguracao :=  TDMConfiguracao.Create(Self);
    AtivarConfiguracao;
    DMConfiguracao.qryConfiguracao.Open;

  except
    Application.MessageBox('Não foi possível acessar as configurações da empresa, favor verificar conexão com o banco de dados','Atenção',MB_OK + MB_ICONWARNING);
    btnFechar.Enabled := True;
    btnSalvar.Enabled := False;
    exit
  end;

  LoadConfiguracaoAcbr
end;

procedure TfrmConfiguracaoEmpresa.GravarConfiguracaoAcbr;
Var
  IniFile : String ;
  Ini     : TIniFile ;
begin
  IniFile := ExtractFilePath( Application.ExeName ) + 'configACBR.ini';
  Ini := TIniFile.Create( IniFile );

  try
    Ini.WriteInteger( 'Geral','FormaEmissao',cbFormaEmissao.ItemIndex) ;
    Ini.WriteInteger( 'Geral','ModeloDF',cbModeloDF.ItemIndex) ;
    Ini.WriteInteger( 'Geral','VersaoDF',cbVersaoDF.ItemIndex) ;
    Ini.WriteString( 'WebService','UF'        ,cbUF.Text) ;
  finally
     Ini.Free ;
  end;

end;

procedure TfrmConfiguracaoEmpresa.HabilitaAbasEdicao;
begin
  gbInformacoesEmpresa.Enabled := dsConfiguracao.DataSet.State in [dsEdit, dsInsert ];
  gbCertificado.Enabled        := dsConfiguracao.DataSet.State in [dsEdit, dsInsert ];
  gbWebService.Enabled         := dsConfiguracao.DataSet.State in [dsEdit, dsInsert ];
end;

procedure TfrmConfiguracaoEmpresa.LoadConfiguracaoAcbr;
var
 I : TpcnTipoEmissao ;
 J : TpcnModeloDF;
 K : TpcnVersaoDF;
 IniFile : String ;
 Ini: TIniFile ;
begin
  cbFormaEmissao.Items.Clear ;
  For I := Low(TpcnTipoEmissao) to High(TpcnTipoEmissao) do
     cbFormaEmissao.Items.Add( GetEnumName(TypeInfo(TpcnTipoEmissao), integer(I) ) ) ;
  cbFormaEmissao.Items[0] := 'teNormal' ;
  cbFormaEmissao.ItemIndex := 0 ;

  cbModeloDF.Items.Clear ;
  For J := Low(TpcnModeloDF) to High(TpcnModeloDF) do
     cbModeloDF.Items.Add( GetEnumName(TypeInfo(TpcnModeloDF), integer(J) ) ) ;
  cbModeloDF.Items[0] := 'moNFe' ;
  cbModeloDF.ItemIndex := 0 ;

  cbVersaoDF.Items.Clear ;
  For K := Low(TpcnVersaoDF) to High(TpcnVersaoDF) do
     cbVersaoDF.Items.Add( GetEnumName(TypeInfo(TpcnVersaoDF), integer(K) ) ) ;
  cbVersaoDF.Items[0] := 've200' ;
  cbVersaoDF.ItemIndex := 0 ;

  IniFile := ExtractFilePath( Application.ExeName ) + 'configACBR.ini';
  Ini := TIniFile.Create( IniFile );

  try
    cbFormaEmissao.ItemIndex := Ini.ReadInteger( 'Geral','FormaEmissao',0) ;
    cbModeloDF.ItemIndex     := Ini.ReadInteger( 'Geral','ModeloDF',0) ;
    cbVersaoDF.ItemIndex     := Ini.ReadInteger( 'Geral','VersaoDF',0) ;
    cbUF.ItemIndex           := cbUF.Items.IndexOf(Ini.ReadString( 'WebService','UF','')) ;
  finally
     Ini.Free ;
  end;
end;

procedure TfrmConfiguracaoEmpresa.pgConfiguracaoChange(Sender: TObject);
begin
  inherited;
  case pgConfiguracao.ActivePageIndex of
    0: if edtCnpj.CanFocus then edtCnpj.SetFocus;                             {Empresa}
    2: if cbUF.CanFocus then cbUF.SetFocus;                                   {WebService}
  end;
end;

end.
