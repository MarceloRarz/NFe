unit uFrmCTe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  ACBrBase, ACBrDFe, ACBrCTe, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage, Vcl.Menus, pcnConversao;

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
    tbsConsultarCTE: TTabSheet;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    btnPesquisarCTE: TSpeedButton;
    edtChaveCTE: TEdit;
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
    GroupBox1: TGroupBox;
    Image2: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Image3: TImage;
    Image4: TImage;
    Label4: TLabel;
    lblNSU: TLabel;
    btnDistribuicaoDFE: TBitBtn;
    edtNSU: TEdit;
    dbgConsultaCTE: TDBGrid;
    mtbConsultaCTEcnpj: TStringField;
    mtbConsultaCTEnsu: TStringField;
    mtbConsultaCTEserie: TStringField;
    mtbConsultaCTEnumero: TStringField;
    mtbConsultaCTErazao_social: TStringField;
    mtbConsultaCTeIE: TStringField;
    mtbConsultaCTEdata_download: TDateTimeField;
    Panel1: TPanel;
    Image6: TImage;
    lblTotalNotas: TLabel;
    btnFechar2: TBitBtn;
    dbgListarCTe: TDBGrid;
    pnlToolBarButton: TPanel;
    Image5: TImage;
    btnFechar: TBitBtn;
    btnDownloadXML: TBitBtn;
    SaveDialog1: TSaveDialog;
    Label5: TLabel;
    Label14: TLabel;
    mtbConsultaCTEprotocolo: TStringField;
    Image9: TImage;
    Label8: TLabel;
    Label9: TLabel;
    Image10: TImage;
    Image11: TImage;
    Label10: TLabel;
    procedure btnPesquisarCTEClick(Sender: TObject);
    procedure btnListarCTeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgListarCTeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaCTEDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ACBrCTe1StatusChange(Sender: TObject);
    procedure btnDistribuicaoDFEClick(Sender: TObject);
    procedure btnFechar2Click(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnDownloadXMLClick(Sender: TObject);
  private
    { Private declarations }
    gNSUConsulta: string;

    function ConsultaNotasDestinadas(pNSU: string):Boolean;
    procedure SetDataSetmtbConsulta(pChave, pNSU, pCNPJ, pStatusNota, pTipoNfe,
      pSerie, pNumero, pRazaoSocial, pIEst, pDataConsulta, pDataEmissao: string);
    procedure LerConfiguracao;
    procedure AtualizarContadorGrid;
    procedure DownloadXML;
    function  ValidarConfiguracoes: Boolean;
  public
    { Public declarations }
  end;

var
  frmCTe: TfrmCTe;

implementation

{$R *.dfm}

uses uDMCTe, uDMConfiguracao, System.IniFiles, ACBrDFeSSL,
  blcksock, pcteConversaoCTe, ufrmStatus, uAguarde, uFuncoesGeral, uConstantes;

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

procedure TfrmCTe.AtualizarContadorGrid;
begin
  if mtbConsultaCTe.RecordCount > 0 then
  begin
   mtbConsultaCTe.First;
   dbgConsultaCTe.SetFocus;
   lblTotalNotas.Visible := True;
   lblTotalNotas.Caption := 'Total de Registros: ' + mtbConsultaCTe.RecordCount.ToString;
  end
  else
  begin
    lblTotalNotas.Visible := False;
  end;
end;

procedure TfrmCTe.btnDistribuicaoDFEClick(Sender: TObject);
begin
  try
    DMConfiguracao.qryConfiguracao.Close;
    DMConfiguracao.qryConfiguracao.Open;

    if edtNSU.Text <> EmptyStr then
      gNSUConsulta := FormatFloat('0000000000000000',string(edtNSU.Text).ToInteger);

    mtbConsultaCTE.DisableControls;

    frmAguarde := TfrmAguarde.Create(Self);
    frmAguarde.Show;

    while not ConsultaNotasDestinadas(gNSUConsulta) do
    begin
    end;

   DMConfiguracao.SetUltimoNSU_CTE(gNSUConsulta);

   mtbConsultaCTe.EnableControls;
   AtualizarContadorGrid;
   frmAguarde.Close;

  finally
    FreeAndNil(frmAguarde);
    gNSUConsulta := EmptyStr;
  end;
end;

procedure TfrmCTe.btnDownloadXMLClick(Sender: TObject);
begin
  DownloadXML;
end;

procedure TfrmCTe.btnFechar2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCTe.btnFecharClick(Sender: TObject);
begin
  Close;
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

function TfrmCTe.ConsultaNotasDestinadas(pNSU: string): Boolean;
var
  UF,
  CNPJ,
  Chave,
  StatusNota,
  sChave,
  sDataEmissao,
  sCNPJ,
  sRazaoSocial,
  sNumero,
  sSerie,
  sIEst,
  sNSU,
  sTipoNFe,
  SituacaoOperacao,
  DataConsulta,
  protocolo,
  sValor: string;
  Valor:Double;
  I: Integer;
begin
  Chave := dspesquisarCTe.DataSet.FieldByName('chave').AsString;
  CNPJ  := DMConfiguracao.qryConfiguracaoCNPJ.AsString;
  UF    := DMConfiguracao.qryConfiguracaoUF.AsString;

  try
    ACBrCTe1.DistribuicaoDFePorUltNSU(GetCodigoEstado(UF),CNPJ,pNSU);

    if ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 138 then
    begin

      for I := 0 to Pred(ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count) do
      begin
        sSerie       := '';
        sNumero      := '';
        sCNPJ        := '';
        sRazaoSocial := '';
        sIEst        := '';
        sNSU         := '';
        sDataEmissao := '';
        sTipoNFe     := '';
        Valor        := 0;
        StatusNota   := '';

        if ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].XML <> '' then
        begin
          with ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i] do
          begin
            case schema of
                schresCTe:   begin
                               with resCTe do
                               begin
                                 if chCTe <> '' then
                                 begin
                                   sChave :=  chCTe;
                                   sCNPJ        := CNPJCPF;
                                   sRazaoSocial := UTF8ToString(xNome);
                                   sIEst        := IE;
                                   sValor       := CurrToStr(vNF);
                                  // SituacaoOperacao := 'MO';
                                   sNSU         := NSU;
                                   protocolo    := nProt;
                                   sDataEmissao := DateTimeToStr(dhEmi);
                                 end;
                               end;
                             end;

               schprocCte: begin
                               with resCTe do
                               begin
                                 if chCTe <> '' then
                                 begin
                                   sChave :=  chCTe;
                                   sCNPJ        := CNPJCPF;
                                   sRazaoSocial := UTF8ToString(xNome);
                                   sIEst        := IE;
                                   sValor       := CurrToStr(vNF);
                               //   SituacaoOperacao := 'MO';
                                   sNSU         := NSU;
                                   protocolo    := nProt;
                                   sDataEmissao := DateTimeToStr(dhEmi);
                                 end;
                               end;
                             end;

                schprocEventoCTe:begin
                                   with procEvento do
                                   begin
                                     if chCTe <> '' then
                                     begin
                                       sChave       := chCTe;
                                       sDataEmissao := DateTimeToStr(dhEvento);
                                       sCNPJ        := detevento.emit.CNPJ;
                                       sRazaoSocial := UTF8ToString(detevento.emit.xNome);
                                       sIEst        := detevento.emit.IE;
                                     end;
                                   end;
                                  end;
            end;

          end;
        end;

        sSerie       := Copy(sChave, 23, 3);
        sNumero      := Copy(sChave, 26, 9);

        sNSU := ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].NSU;

        case ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].procEvento.tpEvento of
         teCCE:             StatusNota := 'E';
         teCancelamento:    StatusNota := 'C';
         teMDFeAutorizado2: StatusNota := 'D';
        end;

        DataConsulta := DateTimeToStr(now);

        DMCTe.SalvarDistribuicaoDFE(sChave, sNSU, sCNPJ, StatusNota, sTipoNfe, sSerie,
                                    sNumero, sRazaoSocial, sIEst, DataConsulta , sDataEmissao);

        SetDataSetmtbConsulta(sChave, sNSU, sCNPJ, StatusNota, sTipoNfe, sSerie,
                              sNumero, sRazaoSocial, sIEst, DataConsulta , sDataEmissao);

      end;
    end;
    gNSUConsulta := sNSU;
  except
    {Gravar o Último NSU em caso de erro}
    Result := True;
    gNSUConsulta := sNSU;
  end;

  Result := True; /// gNSUConsulta = sNSU;
  gNSUConsulta := sNSU;
  edtNSU.Text := gNSUConsulta;
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

procedure TfrmCTe.DownloadXML;
var
  Chave, CNPJ, UF, NSU: string;
  i: integer;
  v: Boolean;
  XMLDocument1: TMemoryStream;
  ArqXML: TStream;
begin

  if dspesquisarCTe.DataSet.FieldByName('nsu').AsString.IsEmpty then
  begin
    Application.MessageBox(PWideChar('Não foi possível realizar o download! NSU não informado.'), GESTOR_NFE, MB_OK + MB_ICONWARNING);
    Exit;
  end;

  try
    DMConfiguracao.qryConfiguracao.Close;
    DMConfiguracao.qryConfiguracao.Open;

    Chave := dspesquisarCTe.DataSet.FieldByName('chave').AsString;
    CNPJ  := DMConfiguracao.qryConfiguracaoCNPJ.AsString;
    UF    := DMConfiguracao.qryConfiguracaoUF.AsString;
    NSU   := dspesquisarCTe.DataSet.FieldByName('nsu').AsString;

  except
    on e:exception do
    begin
      Application.MessageBox(PWideChar('Não foi possível enviar o evento de operação ao Sefaz' + #13 +
        'Motivo: ' + e.Message), GESTOR_NFE, MB_OK + MB_ICONWARNING);
      Exit;
    end;
  end;

  {DownLoad XML da NFe}
  try
    ACBrCTe1.DistribuicaoDFePorNSU(GetCodigoEstado(UF),CNPJ , NSU);
    with ACBrCTe1.WebServices.DistribuicaoDFe.retDistDFeInt do
    begin
      if cStat = 138 then
      begin
        for i := 0 to docZip.Count - 1 do
        begin

          if docZip.Items[0].schema in [schprocCTe,schresCTe,schprocEventoCTe] then //verifica se o arquivo é o XML da NFe (-nfe.xml)
          begin
            XML := docZip.Items[0].XML;

            ArqXML := TStringStream.Create(XML);
            XMLDocument1 := TMemoryStream.Create;
            XMLDocument1.LoadFromStream(ArqXML);
            XMLDocument1.Position := 0;

            SaveDialog1.FileName := Chave + '.xml';
            if SaveDialog1.Execute then
            begin
              XMLDocument1.SaveToFile(SaveDialog1.FileName);
              Application.MessageBox('Aquivo salvo com sucesso!', GESTOR_NFE, MB_OK + MB_ICONINFORMATION);
            end;
          end;
        end;
      end;
    end;

  except
    on e:exception do
    Application.MessageBox(PWideChar('Não foi possível realizar o download do XML' + #13 +
      'Motivo: ' + e.Message), GESTOR_NFE, MB_OK + MB_ICONWARNING);
  end;
end;

procedure TfrmCTe.FormCreate(Sender: TObject);
begin
  DMCTe := TDMCTe.Create(Self);
  DMConfiguracao := TDMConfiguracao.Create(Self);

  DMConfiguracao.qryConfiguracao.open;
  edtNSU.Text := DMConfiguracao.qryConfiguracaoULTIMONSU_CTE.AsString;

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
  VersaoDF: Integer;
begin
  IniFile := ExtractFilePath( Application.ExeName ) + 'configACBR.ini';
  Ini := TIniFile.Create( IniFile );

  try
    FormaEmissao := Ini.ReadInteger( 'Geral','FormaEmissao',0) ;
    VersaoDF     := Ini.ReadInteger( 'Geral','VersaoDF',0) ;
    Estado       := Ini.ReadString( 'WebService','UF','') ;
  finally
     Ini.Free ;
  end;

  with DMConfiguracao do
  begin
    qryConfiguracao.Close;
    qryConfiguracao.Open;

    Senha := qryConfiguracaoSENHACERTIFICADO.AsString;
    NumCertificado := qryConfiguracaoNUMEROSERIE.AsString;
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
     Salvar                := True;
     ModeloDF              := moCTe;
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
     SepararPorCNPJ     := False;
     SepararPorModelo   := False;
     PathSalvar         := ExtractFilePath(Application.ExeName) + 'Logs\CTe';
     PathSchemas        := ExtractFilePath(Application.ExeName) + 'Schemas\CTe\';
   end;
end;

procedure TfrmCTe.SetDataSetmtbConsulta(pChave, pNSU, pCNPJ, pStatusNota,
  pTipoNfe, pSerie, pNumero, pRazaoSocial, pIEst, pDataConsulta,
  pDataEmissao: string);
var
  TipoCTe: String;
begin
  case mtbConsultaCTe.State of
    dsInactive: begin
                  mtbConsultaCTe.Open;
                  mtbConsultaCTe.Append;
                end;

    dsBrowse:   begin
                  if mtbConsultaCTe.Locate('chave; nsu', VarArrayOf([pChave,pNSU]),[]) then
                    mtbConsultaCTe.Edit
                else
                  mtbConsultaCTe.Append;
                end;
    end;

//  if UpperCase(pTipoNfe) = 'E' then
//    TipoCTe := 'Entrada'
//  else
//    TipoCTe := 'Saída';

  mtbConsultaCTeChave.AsString        := pChave;
  mtbConsultaCTeSituacao.AsString     := pStatusNota;
//  mtbConsultaCTeTipoNFE.AsString      := TipoNFE; {Entrada - Saída};
  mtbConsultaCTecnpj.AsString         := pCNPJ;
  mtbConsultaCTeIE.AsString           := pIEst;
  mtbConsultaCTeNSU.AsString          := pNSU;
  mtbConsultaCTeserie.AsString        := pSerie;
  mtbConsultaCTenumero.AsString       := pNumero;
  mtbConsultaCTerazao_social.AsString := pRazaoSocial;
  mtbConsultaCTeDataEmissao.AsString  := pDataEmissao;
  mtbConsultaCTeDataConsulta.AsString := pDataConsulta;
  mtbConsultaCTe.Post;
end;

function TfrmCTe.ValidarConfiguracoes: Boolean;
begin
  Result := True;

  if DMConfiguracao.qryConfiguracaoCNPJ.AsString.IsEmpty then
  begin
    Application.MessageBox(PWideChar('CNPJ não informado!' + #13 +
      'Para informar o CNPJ é necessário ir em Configurações -> Empresa -> Aba Empresa' ),
      GESTOR_NFE, MB_OK + MB_ICONWARNING);
    Result := False;
  end;

  if DMConfiguracao.qryConfiguracaoUF.AsString.IsEmpty then
  begin
    Application.MessageBox(PWideChar('UF não informada!' + #13 +
      'Para informar a UF é necessário ir em Configurações -> Empresa -> Aba Empresa' ),
      GESTOR_NFE, MB_OK + MB_ICONWARNING);
    Result := False;
  end;
end;

end.
