unit uFrmNFe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, ACBrBase, ACBrDFe, ACBrNFe, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList, Vcl.ImgList,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.ExtCtrls, Vcl.Mask, Vcl.Menus,
  Vcl.Imaging.pngimage, pcnConversao;

type
  TfrmNFe = class(TForm)

    ImageList1: TImageList;
    ACBrNFe1: TACBrNFe;
    dsConsulta: TDataSource;
    mtbConsulta: TFDMemTable;
    mtbConsultaChave: TStringField;
    mtbConsultaDataConsulta: TDateTimeField;
    mtbConsultaDataEmissao: TDateTimeField;
    dsPesquisar: TDataSource;
    mtbConsultaSituacao: TStringField;
    ImageList2: TImageList;
    pgNFE: TPageControl;
    tbsListarNFE: TTabSheet;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    btnPesquisaNfe: TSpeedButton;
    edtPesquisaChave: TEdit;
    GroupBox5: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    edtEmissaoFim: TMaskEdit;
    edtEmissaoIni: TMaskEdit;
    GroupBox6: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    edtConsultaIni: TMaskEdit;
    edtConsultaFim: TMaskEdit;
    rgSituacao: TRadioGroup;
    dbgListarNFe: TDBGrid;
    tbsConsultarNFE: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnPesquisar: TSpeedButton;
    edtChave: TEdit;
    GroupBox3: TGroupBox;
    Image9: TImage;
    Label8: TLabel;
    Label33: TLabel;
    Image19: TImage;
    Image1: TImage;
    Label2: TLabel;
    dbgConsulta: TDBGrid;
    pmDownLoadNFe: TPopupMenu;
    miManifestacaoOperacao: TMenuItem;
    miCienciaOperacao: TMenuItem;
    SaveDialog1: TSaveDialog;
    GroupBox2: TGroupBox;
    Image2: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Image3: TImage;
    Image4: TImage;
    Label11: TLabel;
    pnlToolBarButton: TPanel;
    Image5: TImage;
    btnFechar: TBitBtn;
    btnDownloadXML: TBitBtn;
    btnManifestarNFe: TBitBtn;
    Panel1: TPanel;
    Image6: TImage;
    btnFechar2: TBitBtn;
    btnDistribuicaoDFE: TBitBtn;
    mtbConsultacnpj: TStringField;
    mtbConsultaIE: TStringField;
    mtbConsultaNSU: TStringField;
    mtbConsultaserie: TStringField;
    mtbConsultanumero: TStringField;
    mtbConsultarazao_social: TStringField;
    mtbConsultaTipoNFE: TStringField;
    mtbConsultaValor: TFMTBCDField;
    edtNSU: TEdit;
    lblNSU: TLabel;
    lblTotalNotas: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;

    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgListarNFeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnPesquisaNfeClick(Sender: TObject);
    procedure pgNFEChange(Sender: TObject);
    procedure ACBrNFe1StatusChange(Sender: TObject);
    procedure btnDownloadXMLClick(Sender: TObject);
    procedure miCienciaOperacaoClick(Sender: TObject);
    procedure miManifestacaoOperacaoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure dsPesquisarDataChange(Sender: TObject; Field: TField);
    procedure btnManifestarNFeClick(Sender: TObject);
    procedure btnDistribuicaoDFEClick(Sender: TObject);

  private
    { Private declarations }
    gNSUConsulta: string;

    procedure LerConfiguracao ;
    procedure ConsultarNFe;
    procedure AguardeAcbr;
    procedure DownloadXML(pTipoOperacao: TpcnTpEvento);
    function  ValidarConfiguracoes:Boolean;
    procedure ManifestarNota(pTipoOperacao: TpcnTpEvento);
    procedure SetDataSetmtbConsulta(pChave, pNSU, pCNPJ, pStatusNota, pTipoNfe,
      pSerie, pNumero, pRazaoSocial, pIEst, pDataConsulta, pDataEmissao: string);
    function ConsultaNotasDestinadas(pNSU: string):Boolean;
    procedure AtualizarContadorGrid;
  public
    { Public declarations }
  end;

var
  frmNFe: TfrmNFe;

implementation

uses
  System.IniFiles, ACBrDFeSSL, pcnConversaoNFe, blcksock,
  uDMConfiguracao, uDMNFe, ufrmStatus, uConstantes,
  uFuncoesGeral, uAguarde;

{$R *.dfm}

{ TfrmNFe }

procedure TfrmNFe.ACBrNFe1StatusChange(Sender: TObject);
begin
  AguardeAcbr;
end;

procedure TfrmNFe.AguardeAcbr;
begin
  case ACBrNFe1.Status of
    stIdle :
    begin
      if ( frmStatus <> nil ) then
        frmStatus.Hide;
    end;
    stNFeStatusServico :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Verificando Status do servico...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeRecepcao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando dados da NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeRetRecepcao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Recebendo dados da NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeConsulta :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeCancelamento :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando cancelamento de NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeInutilizacao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeRecibo :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeCadastro :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando Cadastro...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeEmail :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando Email...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeCCe :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando Carta de Correção...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeEvento :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando Evento...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
  end;
  Application.ProcessMessages;
end;

procedure TfrmNFe.AtualizarContadorGrid;
begin
  if mtbConsulta.RecordCount > 0 then
  begin
   mtbConsulta.First;
   dbgConsulta.SetFocus;
   lblTotalNotas.Visible := True;
   lblTotalNotas.Caption := 'Total de Registros: ' + mtbConsulta.RecordCount.ToString;
  end
  else
  begin
    lblTotalNotas.Visible := False;
  end;
end;

procedure TfrmNFe.btnDistribuicaoDFEClick(Sender: TObject);
begin
  try
    DMConfiguracao.qryConfiguracao.Open;

    if edtNSU.Text <> EmptyStr then
      gNSUConsulta := FormatFloat('0000000000000000',string(edtNSU.Text).ToInteger);

    mtbConsulta.DisableControls;

    frmAguarde := TfrmAguarde.Create(Self);
    frmAguarde.Show;

    while not ConsultaNotasDestinadas(gNSUConsulta) do
    begin
    end;

   DMConfiguracao.SetUltimoNSU_NFE(gNSUConsulta);

   mtbConsulta.EnableControls;
   AtualizarContadorGrid;
   frmAguarde.Close;

  finally
    FreeAndNil(frmAguarde);
    gNSUConsulta := EmptyStr;
  end;
end;

procedure TfrmNFe.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmNFe.btnManifestarNFeClick(Sender: TObject);
begin
  ManifestarNota(teManifDestCiencia);
  DMNFe.AtualizarSituacaoOperacao(dsPesquisar.DataSet.FieldByName('Chave').AsString,'MO');

  btnPesquisaNfe.Click;
end;

procedure TfrmNFe.btnDownloadXMLClick(Sender: TObject);
var
  P1, P2: TPoint;
begin
  P1.X := btnDownloadXML.Left;
  P1.Y := pnlToolBarButton.Top + 60;
  P2 := ClientToScreen(P1);
  pmDownLoadNFe.PopUp(P2.X, P2.Y);

end;

procedure TfrmNFe.btnPesquisaNfeClick(Sender: TObject);
var
  Situacao,
  dataConsultaIni,
  dataConsultaFim,
  dataEmissaoIni,
  DataEmissaoFim: string;
begin
  if (edtConsultaIni.Text <> '  /  /    ') and (edtConsultaFim.Text <> '  /  /    ') then
  begin
    dataConsultaIni := edtConsultaIni.Text;
    dataConsultaFim := edtConsultaFim.Text;;
  end;

  if (edtEmissaoIni.Text <> '  /  /    ') and (edtEmissaoFim.Text <> '  /  /    ') then
  begin
    dataEmissaoIni := edtEmissaoIni.Text;
    dataEmissaoFim := edtEmissaoFIM.Text;;
  end;

  case rgSituacao.ItemIndex of
    0: Situacao := 'E';
    1: Situacao := 'C';
    2: Situacao := 'D';
  end;

  with DMNFe do
  begin
    PesquisarNFE(edtPesquisaChave.Text, Situacao, dataConsultaIni, dataConsultaFim, dataEmissaoIni, DataEmissaoFim);
  end;

end;

procedure TfrmNFe.btnPesquisarClick(Sender: TObject);
var
  CodigoStatus: string;
begin
  if Trim(edtChave.Text)= EmptyStr then
  begin
    Application.MessageBox('Chave da NFe não informada','Atenção',MB_OK + MB_ICONWARNING);
    exit;
  end;

  ACBrNFe1.NotasFiscais.Clear;
  ACBrNFe1.WebServices.Consulta.NFeChave := edtChave.Text;
  ACBrNFe1.WebServices.Consulta.Executar;

  {Verifica se retornou algum status}
  if ACBrNFe1.WebServices.Consulta.protNFe.cStat <> 0 then
  begin
    mtbConsulta.Open;
    mtbConsulta.Append;
  end
  else
  begin
    Application.MessageBox(PWideChar('Não foi possível realizar a consulta "WebService não retornou resultado".'
                             + #13 + 'Tente Novamente!'),'Atenção',MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;

  if ACBrNFe1.WebServices.Consulta.protNFe.cStat = 100 then
  begin
    mtbConsultaSituacao.AsString := 'E';
  end
  else if ACBrNFe1.WebServices.Consulta.protNFe.cStat = 110 then
  begin
    mtbConsultaSituacao.AsString := 'D';
  end
  else if ACBrNFe1.WebServices.Consulta.protNFe.cStat = 101 then
  begin
    mtbConsultaSituacao.AsString := 'C';
  end
  else
  begin
    mtbConsultaSituacao.AsString := 'N';
  end;

  mtbConsultaChave.AsString          := edtChave.Text;
  mtbConsultaDataConsulta.AsDateTime := Now;
  CodigoStatus                       := ACBrNFe1.WebServices.Consulta.protNFe.cStat.ToString;
  mtbConsultaDataEmissao.AsDateTime  := ACBrNFe1.WebServices.Consulta.protNFe.dhRecbto;

  mtbConsulta.Post;

  DMNFe.SalvarConsultaNfe(mtbConsultaChave.AsString,  mtbConsultaSituacao.AsString, CodigoStatus, mtbConsultaDataConsulta.AsString, mtbConsultaDataEmissao.AsString);

  edtChave.Clear;

  AtualizarContadorGrid;
end;

procedure TfrmNFe.miCienciaOperacaoClick(Sender: TObject);
begin
  DownloadXML(teManifDestCiencia);

  if dsPesquisar.DataSet.FieldByName('data_download').AsDatetime = 0 then
    DMNFe.AtualizarSituacaoOperacao(dsPesquisar.DataSet.FieldByName('Chave').AsString,'CO',Now)
  else
    DMNFe.AtualizarSituacaoOperacao(dsPesquisar.DataSet.FieldByName('Chave').AsString,'CO');

  btnPesquisaNfe.Click;
end;

procedure TfrmNFe.miManifestacaoOperacaoClick(Sender: TObject);
begin
  DownloadXML(teManifDestConfirmacao);

  if dsPesquisar.DataSet.FieldByName('data_download').AsDatetime = 0 then
    DMNFe.AtualizarSituacaoOperacao(dsPesquisar.DataSet.FieldByName('Chave').AsString,'MO',now)
  else
    DMNFe.AtualizarSituacaoOperacao(dsPesquisar.DataSet.FieldByName('Chave').AsString,'MO');

  btnPesquisaNfe.Click;
end;

function TfrmNFe.ConsultaNotasDestinadas(pNSU: string):Boolean;
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
  sValor: string;
  Valor:Double;
  I: Integer;
begin
  Chave := dspesquisar.DataSet.FieldByName('chave').AsString;
  CNPJ  := DMConfiguracao.qryConfiguracaoCNPJ.AsString;
  UF    := DMConfiguracao.qryConfiguracaoUF.AsString;

  try
    ACBrNFe1.DistribuicaoDFePorUltNSU(GetCodigoEstado(UF),CNPJ,pNSU);

    if ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 138 then
    begin

      for I := 0 to Pred(ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count) do
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

        if ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].XML <> '' then
        begin
          with ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i] do
          begin
            case schema of
                schresNFe:   begin
                               with resNFe do
                               begin
                                 if chNFe <> '' then
                                 begin
                                   sChave :=  chNFe;
                                   sCNPJ        := CNPJCPF;
                                   sRazaoSocial := UTF8ToString(xNome);
                                   sIEst        := IE;
                                   sValor       := CurrToStr(vNF);
                                   SituacaoOperacao := 'MO';
                                   sNSU         := NSU;
                                   sDataEmissao := DateTimeToStr(dhEmi);
                                 end;
                               end;
                             end;

               schresEvento: begin
                               with resEvento do
                               begin
                                 if chNFe <> '' then
                                 begin
                                   sChave       := chNFe;
                                   sCNPJ        := CNPJCPF;
                                   sDataEmissao := DateTimeToStr(dhEvento);
                                   SituacaoOperacao := 'CO';
                                 end;
                               end;
                             end;

                schprocNFe:  begin
                               //
                             end;

                schprocEventoNFe:begin
                                   with procEvento do
                                   begin
                                     if chNFe <> '' then
                                     begin
                                       sChave       := chNFe;
                                       sCNPJ        := CNPJ;
                                       sDataEmissao := DateTimeToStr(dhEvento);
                                       SituacaoOperacao := 'CO';
                                     end;
                                   end;
                                  end;
            end;

          end;
        end;

        sSerie       := Copy(sChave, 23, 3);
        sNumero      := Copy(sChave, 26, 9);

        case ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFE.tpNF of
         tnEntrada: sTipoNFe := 'E';
         tnSaida:   sTipoNFe := 'S';
        end;

        sNSU         := ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].NSU;

        case ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resNFE.cSitNFe of
         snAutorizado: StatusNota := 'E';
         snDenegado:   StatusNota := 'D';
         snCancelado:  StatusNota := 'C';
        end;

        DataConsulta := DateTimeToStr(now);

        DMNFe.SalvarDistribuicaoDFE(sChave, sNSU, sCNPJ, StatusNota, sTipoNfe, sSerie,
                                    sNumero, sRazaoSocial, sIEst, DataConsulta , sDataEmissao, SituacaoOperacao);

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

procedure TfrmNFe.ConsultarNFe;
var
  CodigoStatus: string;
begin
  ACBrNFe1.NotasFiscais.Clear;
  ACBrNFe1.WebServices.Consulta.NFeChave := edtChave.Text;
  ACBrNFe1.WebServices.Consulta.Executar;

  {Verifica se retornou algum status}
  if ACBrNFe1.WebServices.Consulta.protNFe.cStat <> 0 then
  begin
    mtbConsulta.Open;
    mtbConsulta.Append;
  end
  else
  begin
    Application.MessageBox(PWideChar('Não foi possível realizar a consulta "WebService não retornou resultado".'
                             + #13 + 'Tente Novamente!'),'Atenção',MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;

  if ACBrNFe1.WebServices.Consulta.protNFe.cStat = 100 then
  begin
    mtbConsultaSituacao.AsString := 'E';
  end
  else if ACBrNFe1.WebServices.Consulta.protNFe.cStat = 110 then
  begin
    mtbConsultaSituacao.AsString := 'D';
  end
  else if ACBrNFe1.WebServices.Consulta.protNFe.cStat = 101 then
  begin
    mtbConsultaSituacao.AsString := 'C';
  end
  else
  begin
    mtbConsultaSituacao.AsString := 'N';
  end;

  mtbConsultaChave.AsString          := edtChave.Text;
  mtbConsultaDataConsulta.AsDateTime := Now;
  CodigoStatus                       := ACBrNFe1.WebServices.Consulta.protNFe.cStat.ToString;
  mtbConsultaDataEmissao.AsDateTime  := ACBrNFe1.WebServices.Consulta.protNFe.dhRecbto;

  mtbConsulta.Post;

  DMNFe.SalvarConsultaNfe(mtbConsultaChave.AsString, mtbConsultaSituacao.AsString, CodigoStatus, mtbConsultaDataConsulta.AsString, mtbConsultaDataEmissao.AsString);

  edtChave.Clear;
end;

procedure TfrmNFe.dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'Icone' then
  begin
    dbgConsulta.Canvas.FillRect(Rect);
    if mtbConsultaSituacao.AsString = 'E' then
    begin
      ImageList1.Draw(dbgConsulta.Canvas,Rect.Left+3,Rect.Top+1,0);
    end
    else if mtbConsultaSituacao.AsString = 'C' then
    begin
      ImageList1.Draw(dbgConsulta.Canvas,Rect.Left+3,Rect.Top+1,2);
    end
    else if mtbConsultaSituacao.AsString = 'D' then
    begin
      ImageList1.Draw(dbgConsulta.Canvas,Rect.Left+3,Rect.Top+1,1);
    end;
  end;
end;

procedure TfrmNFe.dbgListarNFeDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  dbgListarNFe.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'Icone' then
  begin
    dbgListarNFe.Canvas.FillRect(Rect);

    if DMNFe.qryPesquisarNFeSITUACAO.AsString = 'E' then
    begin
      ImageList1.Draw(dbgListarNFe.Canvas,Rect.Left+3,Rect.Top+1,0);
    end
    else if DMNFe.qryPesquisarNFeSITUACAO.AsString = 'C' then
    begin
      ImageList1.Draw(dbgListarNFe.Canvas,Rect.Left+3,Rect.Top+1,2);
    end
    else if DMNFe.qryPesquisarNFeSITUACAO.AsString = 'D' then
    begin
      ImageList1.Draw(dbgListarNFe.Canvas,Rect.Left+3,Rect.Top+1,1);
    end;
  end;
end;

procedure TfrmNFe.DownloadXML(pTipoOperacao: TpcnTpEvento);
var
  Chave, CNPJ, UF: string;
  i: integer;
  v: Boolean;
  XMLDocument1: TMemoryStream;
  ArqXML: TStream;
begin

  try
    ManifestarNota(pTipoOperacao);

    Chave := dspesquisar.DataSet.FieldByName('chave').AsString;
    CNPJ  := DMConfiguracao.qryConfiguracaoCNPJ.AsString;
    UF    := DMConfiguracao.qryConfiguracaoUF.AsString;

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
    ACBrNFe1.DistribuicaoDFePorChaveNFe(GetCodigoEstado(UF),CNPJ ,Chave);
    with ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt do
    begin
      if cStat = 138 then
      begin
        for i := 0 to docZip.Count - 1 do
        begin

          if docZip.Items[0].schema in [schprocNFe,schresNFe] then //verifica se o arquivo é o XML da NFe (-nfe.xml)
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

procedure TfrmNFe.dsPesquisarDataChange(Sender: TObject; Field: TField);
begin
  btnDownloadXML.Enabled   := not dsPesquisar.DataSet.IsEmpty;
  btnManifestarNFe.Enabled := not (dsPesquisar.DataSet.IsEmpty) and
                                  (dsPesquisar.DataSet.FieldByName('situacao_operacao').AsString = 'CO');

  miCienciaOperacao.Enabled := dsPesquisar.DataSet.FieldByName('situacao_operacao').AsString <> 'MO';
end;
procedure TfrmNFe.FormCreate(Sender: TObject);
begin
  DMConfiguracao := TDMConfiguracao.Create(nil);

  DMConfiguracao.qryConfiguracao.open;
  edtNSU.Text := DMConfiguracao.qryConfiguracaoULTIMONSU_NFE.AsString;

  DMNFe := TDMNFe.Create(Self);

  TStringField(mtbConsultacnpj).EditMask := '';

  LerConfiguracao;
end;

procedure TfrmNFe.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DMConfiguracao);
  FreeAndNil(DMNFe);
end;

procedure TfrmNFe.FormShow(Sender: TObject);
begin
  if edtChave.CanFocus then
    edtChave.SetFocus;
end;

procedure TfrmNFe.LerConfiguracao;
Var
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

  with DMConfiguracao do
  begin
    qryConfiguracao.Open;
    qryConfiguracao.Refresh;

    Senha := qryConfiguracaoSENHACERTIFICADO.AsString;
    NumCertificado := qryConfiguracaoNUMEROSERIE.AsString;
  end;

  {Notas Fiscal eletrônica}
  ACBrNFe1.Configuracoes.Certificados.Senha       := Senha;
  ACBrNFe1.Configuracoes.Certificados.NumeroSerie := NumCertificado;
  ACBrNFe1.SSL.DescarregarCertificado;

  with ACBrNFe1.Configuracoes.Geral do
   begin
     SSLLib                := TSSLLib(3);
     SSLCryptLib           := TSSLCryptLib(2);
     SSLHttpLib            := TSSLHttpLib(4);
     SSLXmlSignLib         := TSSLXmlSignLib(3);

     AtualizarXMLCancelado := True;
     ExibirErroSchema      := True;
     RetirarAcentos        := True;
     FormatoAlerta         := 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.';
     FormaEmissao          := TpcnTipoEmissao(FormaEmissao);
     ModeloDF              := TpcnModeloDF(ModeloDF);
     VersaoDF              := TpcnVersaoDF(VersaoDF);
     Salvar                := True;
   end;

  with ACBrNFe1.Configuracoes.WebServices do
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

   ACBrNFe1.SSL.SSLType := TSSLType(0);

  with ACBrNFe1.Configuracoes.Arquivos do
   begin
     Salvar             := False;
     SepararPorMes      := False;
     AdicionarLiteral   := False;
     EmissaoPathNFe     := False;
     SalvarEvento       := False;
     SepararPorCNPJ     := False;
     SepararPorModelo   := False;
     PathSalvar         := ExtractFilePath(Application.ExeName) + 'Logs\NFe';
     PathSchemas        := ExtractFilePath(Application.ExeName) + 'Schemas\Nfe\';
   end;
end;

procedure TfrmNFe.ManifestarNota(pTipoOperacao: TpcnTpEvento);
var
  idLote, Chave, CNPJ, UF: string;
begin
  {Envia o Evento ao Sefaz de Ciência da operação ou manifestação da operação}
  ACBrNFe1.EventoNFe.Evento.Clear;
  idLote := '1';

  DMConfiguracao.qryConfiguracao.close;
  DMConfiguracao.qryConfiguracao.Open;

  if not ValidarConfiguracoes then
    Exit;

  Chave := dspesquisar.DataSet.FieldByName('chave').AsString;
  CNPJ  := DMConfiguracao.qryConfiguracaoCNPJ.AsString;
  UF    := DMConfiguracao.qryConfiguracaoUF.AsString;

  with ACBrNFe1.EventoNFe.Evento.Add do
   begin
     InfEvento.cOrgao   := 91;
     infEvento.chNFe    := Chave;
     infEvento.CNPJ     := CNPJ;
     infEvento.dhEvento := now;
     {teManifDestCiencia - teManifDestConfirmacao}
     infEvento.tpEvento := pTipoOperacao;
   end;

  ACBrNFe1.EnviarEvento(StrToInt(IDLote));
end;

procedure TfrmNFe.pgNFEChange(Sender: TObject);
begin
  case pgNFE.ActivePageIndex of
    0: begin
          if edtChave.CanFocus then
            edtChave.SetFocus;
       end;

    1: begin
         if edtPesquisaChave.CanFocus then
           edtPesquisaChave.SetFocus;

           DMConfiguracao.qryConfiguracao.close;
           DMConfiguracao.qryConfiguracao.open;

           edtNSU.Text := DMConfiguracao.qryConfiguracaoULTIMONSU_NFE.AsString;
       end;
  end;

end;

procedure TfrmNFe.SetDataSetmtbConsulta(pChave, pNSU, pCNPJ, pStatusNota, pTipoNfe,
  pSerie, pNumero, pRazaoSocial, pIEst, pDataConsulta, pDataEmissao: string);
var
  TipoNFE: String;
begin
  case mtbConsulta.State of
    dsInactive: begin
                  mtbConsulta.Open;
                  mtbConsulta.Append;
                end;

    dsBrowse:   begin
                  if mtbConsulta.Locate('chave; nsu', VarArrayOf([pChave,pNSU]),[]) then
                    mtbConsulta.Edit
                else
                  mtbConsulta.Append;
                end;
    end;

  if UpperCase(pTipoNfe) = 'E' then
    TipoNFE := 'Entrada'
  else
    TipoNFE := 'Saída';

  mtbConsultaChave.AsString        := pChave;
  mtbConsultaSituacao.AsString     := pStatusNota;
  mtbConsultaTipoNFE.AsString      := TipoNFE; {Entrada - Saída};
  mtbConsultacnpj.AsString         := pCNPJ;
  mtbConsultaIE.AsString           := pIEst;
  mtbConsultaNSU.AsString          := pNSU;
  mtbConsultaserie.AsString        := pSerie;
  mtbConsultanumero.AsString       := pNumero;
  mtbConsultarazao_social.AsString := pRazaoSocial;
  mtbConsultaDataEmissao.AsString  := pDataEmissao;
  mtbConsultaDataConsulta.AsString := pDataConsulta;
  mtbConsulta.Post;
end;


function TfrmNFe.ValidarConfiguracoes: Boolean;
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

