unit uFrmCTe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  ACBrBase, ACBrDFe, ACBrCTe, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.ImageList, Vcl.ImgList;

type
  TfrmCTe = class(TForm)
    pgCTE: TPageControl;
    tbsListarCTE: TTabSheet;
    GroupBox9: TGroupBox;
    Label18: TLabel;
    btnListarCTe: TSpeedButton;
    edtPesquisaChaveCTe: TEdit;
    GroupBox10: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    edtEmissaoFimCTe: TMaskEdit;
    edtEmissaoIniCTe: TMaskEdit;
    GroupBox11: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    edtConsultaIniCTe: TMaskEdit;
    edtConsultaFimCTe: TMaskEdit;
    rgSituacaoCTe: TRadioGroup;
    dbgListarCTe: TDBGrid;
    tbsConsultarCTE: TTabSheet;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    btnPesquisarCTE: TSpeedButton;
    edtChaveCTE: TEdit;
    dbgConsultaCTE: TDBGrid;
    dsConsultarCTe: TDataSource;
    dsPesquisarCTe: TDataSource;
    mtbConsultaCTE: TFDMemTable;
    mtbConsultaCTEChave: TStringField;
    mtbConsultaCTEDataConsulta: TDateTimeField;
    mtbConsultaCTEDataEmissao: TDateTimeField;
    mtbConsultaCTESituacao: TStringField;
    mtbConsultaCTEStatus: TIntegerField;
    ACBrCTe1: TACBrCTe;
    ImageList1: TImageList;
    ImageList2: TImageList;
    GroupBox3: TGroupBox;
    Image9: TImage;
    Label8: TLabel;
    Label33: TLabel;
    Image19: TImage;
    Image1: TImage;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Image2: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Image3: TImage;
    Image4: TImage;
    Label4: TLabel;
    procedure btnPesquisarCTEClick(Sender: TObject);
    procedure btnListarCTeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgListarCTeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaCTEDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ACBrCTe1StatusChange(Sender: TObject);
  private
    { Private declarations }
    procedure LerConfiguracao;
  public
    { Public declarations }
  end;

var
  frmCTe: TfrmCTe;

implementation

{$R *.dfm}

uses uDMCTe, uDMConfiguracao, System.IniFiles, ACBrDFeSSL, pcnConversao,
  blcksock, pcteConversaoCTe, ufrmStatus;

procedure TfrmCTe.ACBrCTe1StatusChange(Sender: TObject);
begin
 case ACBrCTe1.Status of
  stCTeIdle : begin
               if ( frmStatus <> nil ) then frmStatus.Hide;
              end;
  stCTeStatusServico : begin
                        if ( frmStatus = nil )
                         then frmStatus := TfrmStatus.Create(Application);
                        frmStatus.lblStatus.Caption := 'Verificando Status do servico...';
                        frmStatus.Show;
                        frmStatus.BringToFront;
                       end;
  stCTeRecepcao :
  begin
                   if ( frmStatus = nil )
                    then frmStatus := TfrmStatus.Create(Application);
                   frmStatus.lblStatus.Caption := 'Enviando dados do CTe...';
                   frmStatus.Show;
                   frmStatus.BringToFront;
  end;
  stCTeRetRecepcao : begin
                      if ( frmStatus = nil )
                       then frmStatus := TfrmStatus.Create(Application);
                      frmStatus.lblStatus.Caption := 'Recebendo dados do CTe...';
                      frmStatus.Show;
                      frmStatus.BringToFront;
                     end;
  stCTeConsulta : begin
                   if ( frmStatus = nil )
                    then frmStatus := TfrmStatus.Create(Application);
                   frmStatus.lblStatus.Caption := 'Consultando CTe...';
                   frmStatus.Show;
                   frmStatus.BringToFront;
                  end;
  stCTeCancelamento : begin
                       if ( frmStatus = nil )
                        then frmStatus := TfrmStatus.Create(Application);
                       frmStatus.lblStatus.Caption := 'Enviando cancelamento de CTe...';
                       frmStatus.Show;
                       frmStatus.BringToFront;
                      end;
  stCTeInutilizacao : begin
                       if ( frmStatus = nil )
                        then frmStatus := TfrmStatus.Create(Application);
                       frmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
                       frmStatus.Show;
                       frmStatus.BringToFront;
                      end;
  stCTeRecibo : begin
                 if ( frmStatus = nil )
                  then frmStatus := TfrmStatus.Create(Application);
                 frmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
                 frmStatus.Show;
                 frmStatus.BringToFront;
                end;
  stCTeCadastro : begin
                   if ( frmStatus = nil )
                    then frmStatus := TfrmStatus.Create(Application);
                   frmStatus.lblStatus.Caption := 'Consultando Cadastro...';
                   frmStatus.Show;
                   frmStatus.BringToFront;
                  end;
  {
  stCTeEnvDPEC : begin
                  if ( frmStatus = nil )
                   then frmStatus := TfrmStatus.Create(Application);
                  frmStatus.lblStatus.Caption := 'Enviando DPEC...';
                  frmStatus.Show;
                  frmStatus.BringToFront;
                 end;
  }
  stCTeEmail : begin
                if ( frmStatus = nil )
                 then frmStatus := TfrmStatus.Create(Application);
                frmStatus.lblStatus.Caption := 'Enviando Email...';
                frmStatus.Show;
                frmStatus.BringToFront;
               end;
 end;
 Application.ProcessMessages;
end;

procedure TfrmCTe.btnListarCTeClick(Sender: TObject);
var
  Situacao,
  dataConsultaIni,
  dataConsultaFim,
  dataEmissaoIni,
  DataEmissaoFim: string;
begin
  if (edtConsultaIniCTe.Text <> '  /  /    ') and (edtConsultaFimCTe.Text <> '  /  /    ') then
  begin
    dataConsultaIni := edtConsultaIniCTe.Text;
    dataConsultaFim := edtConsultaFimCTe.Text;;
  end;

  if (edtEmissaoIniCTe.Text <> '  /  /    ') and (edtEmissaoFimCTe.Text <> '  /  /    ') then
  begin
    dataEmissaoIni := edtEmissaoIniCTe.Text;
    dataEmissaoFim := edtEmissaoFIMCTe.Text;;
  end;

  case rgSituacaoCTe.ItemIndex of
    0: Situacao := 'E';
    1: Situacao := 'C';
    2: Situacao := 'D';
  end;

  with DMCTe do
  begin
    PesquisarCTE(edtPesquisaChaveCTe.Text, Situacao, dataConsultaIni, dataConsultaFim, dataEmissaoIni, DataEmissaoFim);
  end;
end;

procedure TfrmCTe.btnPesquisarCTEClick(Sender: TObject);
begin
  if Trim(edtChaveCTE.Text)= EmptyStr then
  begin
    Application.MessageBox('Chave do CTe não informada','Atenção',MB_OK + MB_ICONWARNING);
    exit;
  end;

  ACBrCTe1.Conhecimentos.Clear;
  ACBrCTe1.WebServices.Consulta.CTeChave := edtChaveCTE.Text;
  ACBrCTe1.WebServices.Consulta.Executar;

  {Verifica se retornou algum status}
  if ACBrCTe1.WebServices.Consulta.protCTe.cStat <> 0 then
  begin
    mtbConsultaCTe.Open;
    mtbConsultaCTe.Append;
  end
  else
  begin
    Application.MessageBox(PWideChar('Não foi possível realizar a consulta "WebService não retornou resultado".'
                             + #13 + 'Tente Novamente!'),'Atenção',MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;

  if ACBrCTe1.WebServices.Consulta.protCTe.cStat = 100 then
  begin
    mtbConsultaCTESituacao.AsString := 'E';
  end
  else if ACBrCTe1.WebServices.Consulta.protCTe.cStat = 110 then
  begin
    mtbConsultaCTESituacao.AsString := 'D';
  end
  else if ACBrCTe1.WebServices.Consulta.protCTe.cStat = 101 then
  begin
    mtbConsultaCTeSituacao.AsString := 'C';
  end
  else
  begin
    mtbConsultaCTeSituacao.AsString := 'N';
  end;

  mtbConsultaCTEChave.AsString          := edtChaveCTE.Text;
  mtbConsultaCTEDataConsulta.AsDateTime := Now;
  mtbConsultaCTEStatus.AsInteger        := ACBrCTe1.WebServices.Consulta.protCTe.cStat;
  mtbConsultaCTEDataEmissao.AsDateTime  := ACBrCTe1.WebServices.Consulta.protCTe.dhRecbto;

  mtbConsultaCTe.Post;

  DMCTe.SalvarConsultaCTe(mtbConsultaCTeChave.AsString,  mtbConsultaCTeSituacao.AsString,
                          mtbConsultaCTeStatus.AsString, mtbConsultaCTeDataConsulta.AsString,
                          mtbConsultaCTeDataEmissao.AsString);

  edtChaveCTe.Clear;
end;

procedure TfrmCTe.dbgConsultaCTEDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  dbgConsultaCte.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'Icone' then
  begin
    dbgConsultaCTe.Canvas.FillRect(Rect);
    if mtbConsultaCTeSituacao.AsString = 'E' then
    begin
      ImageList1.Draw(dbgConsultaCTe.Canvas,Rect.Left+3,Rect.Top+1,0);
    end
    else if mtbConsultaCTeSituacao.AsString = 'C' then
    begin
      ImageList1.Draw(dbgConsultaCTe.Canvas,Rect.Left+3,Rect.Top+1,2);
    end
    else if mtbConsultaCTeSituacao.AsString = 'D' then
    begin
      ImageList1.Draw(dbgConsultaCTe.Canvas,Rect.Left+3,Rect.Top+1,1);
    end;
  end;
end;

procedure TfrmCTe.dbgListarCTeDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  dbgListarCTe.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'Icone' then
  begin
    dbgListarCTe.Canvas.FillRect(Rect);

    if DMCTe.qryPesquisarCTeSITUACAO.AsString = 'E' then
    begin
      ImageList1.Draw(dbgListarCTe.Canvas,Rect.Left+3,Rect.Top+1,0);
    end
    else if DMCTe.qryPesquisarCTeSITUACAO.AsString = 'C' then
    begin
      ImageList1.Draw(dbgListarCTe.Canvas,Rect.Left+3,Rect.Top+1,2);
    end
    else if DMCTe.qryPesquisarCTeSITUACAO.AsString = 'D' then
    begin
      ImageList1.Draw(dbgListarCTe.Canvas,Rect.Left+3,Rect.Top+1,1);
    end;
  end;
end;

procedure TfrmCTe.FormCreate(Sender: TObject);
begin
  DMCTe := TDMCTe.Create(Self);

  LerConfiguracao;
end;

procedure TfrmCTe.LerConfiguracao;
var
  IniFile  : String ;
  Ini     : TIniFile ;
  senha,
  Estado,
  NumCertificado: string;
  FormaEmissao,
  ModeloDF,
  VersaoDF: Integer;
begin
  IniFile := ExtractFilePath( Application.ExeName ) + 'configACBR.ini';
  Ini := TIniFile.Create( IniFile );

  try
    FormaEmissao := Ini.ReadInteger( 'Geral','FormaEmissao',0) ;
    ModeloDF     := Ini.ReadInteger( 'Geral','ModeloDF',0) ;
    VersaoDF     := Ini.ReadInteger( 'Geral','VersaoDF',0) ;
    Estado       := Ini.ReadString( 'WebService','UF','') ;
  finally
     Ini.Free ;
  end;

  try
    DMConfiguracao := TDMConfiguracao.Create(Self);

    with DMConfiguracao do
    begin
      qryConfiguracao.Close;
      qryConfiguracao.Open;

      Senha := qryConfiguracaoSENHACERTIFICADO.AsString;
      NumCertificado := qryConfiguracaoNUMEROSERIE.AsString;
    end;
  finally
    FreeAndNil(DMConfiguracao);
  end;

  {Conhecimento de Transportes}
  ACBrCTe1.Configuracoes.Certificados.Senha       := Senha;
  ACBrCTe1.Configuracoes.Certificados.NumeroSerie := NumCertificado;
  ACBrCTe1.SSL.DescarregarCertificado;

  with ACBrCTe1.Configuracoes.Geral do
   begin
     SSLLib                := TSSLLib(3);
     SSLCryptLib           := TSSLCryptLib(2);
     SSLHttpLib            := TSSLHttpLib(4);
     SSLXmlSignLib         := TSSLXmlSignLib(3);

 //    AtualizarXMLCancelado := True;
     ExibirErroSchema      := True;
     RetirarAcentos        := True;
     FormatoAlerta         := 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.';
     FormaEmissao          := TpcnTipoEmissao(FormaEmissao);
//     ModeloDF              := TModeloCTE(ModeloDF);
//     VersaoDF              := TVersaoCTE(VersaoDF);
     Salvar                := True;
   end;

  with ACBrCTe1.Configuracoes.WebServices do
   begin
     UF         := Estado;
     Ambiente   := taProducao;
     Visualizar := False;
     Salvar     := False;
     AjustaAguardaConsultaRet := False;
     AguardarConsultaRet := 0;
     Tentativas          := 5;
     IntervaloTentativas := 1000;
     TimeOut := 5000;
   end;

   ACBrCTe1.SSL.SSLType := TSSLType(0);

  with ACBrCTe1.Configuracoes.Arquivos do
   begin
     Salvar             := False;
     SepararPorMes      := False;
     AdicionarLiteral   := False;
    // EmissaoPathNFe     := False;
   //  SalvarEvento       := False;
     SepararPorCNPJ     := False;
     SepararPorModelo   := False;
     PathSalvar         := ExtractFilePath(Application.ExeName) + 'Logs\CTe';
     PathSchemas        := ExtractFilePath(Application.ExeName) + 'Schemas\CTe\';
   end;
end;

end.
