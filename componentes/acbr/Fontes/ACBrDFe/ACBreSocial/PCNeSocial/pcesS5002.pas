{******************************************************************************}
{ Projeto: Componente ACBreSocial                                              }
{  Biblioteca multiplataforma de componentes Delphi para envio dos eventos do  }
{ eSocial - http://www.esocial.gov.br/                                         }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 27/10/2015: Jean Carlo Cantu, Tiago Ravache
|*  - Doa��o do componente para o Projeto ACBr
|* 29/02/2016: Guilherme Costa
|*  - Alterado os atributos que n�o estavam de acordo com o leiaute/xsd
******************************************************************************}
{$I ACBr.inc}

unit pcesS5002;

interface

uses
  SysUtils, Classes,
  pcnConversao, pcnLeitor,
  pcesCommon, pcesConversaoeSocial;

type
  TS5002 = class;
  TInfoDep = class;

  TInfoIrrfCollection = class;
  TInfoIrrfCollectionItem = class;
  TbaseIrrfCollection = class;
  TbaseIrrfCollectionItem = class;
  TirrfCollection = class;
  TirrfCollectionItem = class;
  TidePgtoExt = class;


//  TInfoCp = class;
//  TIdeEstabLotCollection = class;
//  TIdeEstabLotCollectionItem = class;
//  TInfoCategIncidCollection = class;
//  TInfoCategIncidCollectionItem = class;
//  TInfoBaseCSCollection = class;
//  TInfoBaseCSCollectionItem = class;
//  TCalcTercCollection = class;
//  TCalcTercCollectionItem = class;

  TEvtIrrfBenef = class;

  TS5002 = class(TInterfacedObject, IEventoeSocial)
  private
    FTipoEvento: TTipoEvento;
    FEvtirrfBenef: TEvtirrfBenef;

    function GetXml : string;
    procedure SetXml(const Value: string);
    function GetTipoEvento : TTipoEvento;
    procedure SetEvtirrfBenef(const Value: TEvtirrfBenef);

  public
    constructor Create;
    destructor Destroy; override;

  published
    property Xml: String read GetXml write SetXml;
    property TipoEvento: TTipoEvento read GetTipoEvento;
    property EvtirrfBenef: TEvtirrfBenef read FEvtirrfBenef write setEvtirrfBenef;

  end;

  TInfoDep = class(TPersistent)
  private
    FvrDedDep: Double;
  public
    property vrDedDep: Double read FvrDedDep write FvrDedDep;
  end;

  TInfoIrrfCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfoIrrfCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfoIrrfCollectionItem);
  public
    constructor Create; reintroduce;
    function Add: TInfoIrrfCollectionItem;
    property Items[Index: Integer]: TInfoIrrfCollectionItem read GetItem write SetItem;
  end;

  TInfoIrrfCollectionItem = class(TCollectionItem)
  private
    FCodCateg: integer;
    FindResBr: String;
    FbaseIrrf: TbaseIrrfCollection;
    Firrf: TirrfCollection;
    FidePgtoExt: TidePgtoExt;
  public
    constructor Create(AOwner: TEvtIrrfBenef); reintroduce;
    destructor Destroy; override;

    property CodCateg: integer read FCodCateg write FCodCateg;
    property indResBr: String read FindResBr write FindResBr;
    property baseIrrf: TbaseIrrfCollection read FbaseIrrf write FbaseIrrf;
    property irrf: TirrfCollection read Firrf write Firrf;
    property idePgtoExt: TidePgtoExt read FidePgtoExt write FidePgtoExt;
  end;

  TbaseIrrfCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TbaseIrrfCollectionItem;
    procedure SetItem(Index: Integer; Value: TbaseIrrfCollectionItem);
  public
    constructor Create(AOwner: TInfoIrrfCollectionItem);
    function Add: TbaseIrrfCollectionItem;
    property Items[Index: Integer]: TbaseIrrfCollectionItem read GetItem write SetItem;
  end;

  TbaseIrrfCollectionItem = class(TCollectionItem)
  private
    Fvalor: Double;
    FtpValor: Integer;
  public
    property tpValor: Integer read FtpValor write FtpValor;
    property valor: Double read Fvalor write Fvalor;
  end;

  TirrfCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TirrfCollectionItem;
    procedure SetItem(Index: Integer; Value: TirrfCollectionItem);
  public
    constructor Create(AOwner: TInfoIrrfCollectionItem);
    function Add: TirrfCollectionItem;
    property Items[Index: Integer]: TirrfCollectionItem read GetItem write SetItem;
  end;

  TirrfCollectionItem = class(TCollectionItem)
  private
    FtpCR: string;
    FvrIrrfDesc: Double;
  public
    property tpCR: string read FtpCR write FtpCR;
    property vrIrrfDesc: Double read FvrIrrfDesc write FvrIrrfDesc;
  end;

  TidePgtoExt = class(TPersistent)
  private
    FidePais: TidePais;
    FendExt: TendExt;
  public
    constructor Create(AOwner: TInfoIrrfCollectionItem);
    destructor Destroy; override;

    property idePais: TidePais read FidePais write FidePais;
    property endExt: TendExt read FendExt write FendExt;
  end;

  TEvtIrrfBenef = class(TPersistent)
  private
    FLeitor: TLeitor;
    FId: String;
    FXML: String;

    FIdeEvento: TIdeEvento5;
    FIdeEmpregador: TIdeEmpregador;
    FIdeTrabalhador: TIdeTrabalhador3;
    FInfoDep: TInfoDep;
    FInfoIrrf: TInfoIrrfCollection;
  public
    constructor Create;
    destructor  Destroy; override;

    function LerXML: boolean;

    property IdeEvento: TIdeEvento5 read FIdeEvento write FIdeEvento;
    property IdeEmpregador: TIdeEmpregador read FIdeEmpregador write FIdeEmpregador;
    property IdeTrabalhador: TIdeTrabalhador3 read FIdeTrabalhador write FIdeTrabalhador;
    property InfoDep: TInfoDep read FInfoDep write FInfoDep;
    property InfoIrrf: TInfoIrrfCollection read FInfoIrrf write FInfoIrrf;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property Id: String      read FId     write FId;
    property XML: String     read FXML    write FXML;
  end;

implementation

{ TS5002 }

constructor TS5002.Create;
begin
  FTipoEvento := teS5002;
  FEvtIrrfBenef := TEvtIrrfBenef.Create;
end;

destructor TS5002.Destroy;
begin
  FEvtIrrfBenef.Free;

  inherited;
end;

function TS5002.GetXml : string;
begin
  Result := FEvtIrrfBenef.XML;
end;

procedure TS5002.SetXml(const Value: string);
begin
  if Value = FEvtIrrfBenef.XML then Exit;

  FEvtIrrfBenef.XML := Value;
  FEvtIrrfBenef.Leitor.Arquivo := Value;
  FEvtIrrfBenef.LerXML;

end;

function TS5002.GetTipoEvento : TTipoEvento;
begin
  Result := FTipoEvento;
end;

procedure TS5002.SetEvtIrrfBenef(const Value: TEvtIrrfBenef);
begin
  FEvtIrrfBenef.Assign(Value);
end;

{ TEvtIrrfBenef }

constructor TEvtIrrfBenef.Create;
begin
  FLeitor := TLeitor.Create;

  FIdeEvento := TIdeEvento5.Create;
  FIdeEmpregador := TIdeEmpregador.Create;
  FIdeTrabalhador := TIdeTrabalhador3.Create;
  FInfoDep := TInfoDep.Create;
  FInfoIrrf := TInfoIrrfCollection.Create;
end;

destructor TEvtIrrfBenef.Destroy;
begin
  FLeitor.Free;

  FIdeEvento.Free;
  FIdeEmpregador.Free;
  FIdeTrabalhador.Free;
  FInfoDep.Free;
  FInfoIrrf.Free;

  inherited;
end;

{ TInfoIrrfCollection }

function TInfoIrrfCollection.Add: TInfoIrrfCollectionItem;
begin
  Result := TInfoIrrfCollectionItem(inherited Add);
end;

constructor TInfoIrrfCollection.Create;
begin
  inherited create(TInfoIrrfCollectionItem);
end;

function TInfoIrrfCollection.GetItem(
  Index: Integer): TInfoIrrfCollectionItem;
begin
  Result := TInfoIrrfCollectionItem(inherited GetItem(Index));
end;

procedure TInfoIrrfCollection.SetItem(Index: Integer;
  Value: TInfoIrrfCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TInfoIrrfCollectionItem }

constructor TInfoIrrfCollectionItem.Create(AOwner: TEvtIrrfBenef);
begin
  FbaseIrrf := TbaseIrrfCollection.Create(Self);
  Firrf := TirrfCollection.Create(Self);
  FidePgtoExt := TidePgtoExt.Create(Self);
end;

destructor TInfoIrrfCollectionItem.Destroy;
begin
  FbaseIrrf.Free;
  Firrf.Free;
  FidePgtoExt.Free;

  inherited;
end;

{ TbaseIrrfCollection }

function TbaseIrrfCollection.Add: TbaseIrrfCollectionItem;
begin
  Result := TbaseIrrfCollectionItem(inherited Add);
end;

constructor TbaseIrrfCollection.Create(AOwner: TInfoIrrfCollectionItem);
begin
  inherited create(TbaseIrrfCollectionItem);
end;

function TbaseIrrfCollection.GetItem(
  Index: Integer): TbaseIrrfCollectionItem;
begin
  Result := TbaseIrrfCollectionItem(inherited GetItem(Index));
end;

procedure TbaseIrrfCollection.SetItem(Index: Integer;
  Value: TbaseIrrfCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TirrfCollection }

function TirrfCollection.Add: TirrfCollectionItem;
begin
  Result := TirrfCollectionItem(inherited Add);
end;

constructor TirrfCollection.Create(AOwner: TInfoIrrfCollectionItem);
begin
  inherited create(TirrfCollectionItem);
end;

function TirrfCollection.GetItem(Index: Integer): TirrfCollectionItem;
begin
  Result := TirrfCollectionItem(inherited GetItem(Index));
end;

procedure TirrfCollection.SetItem(Index: Integer;
  Value: TirrfCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TidePgtoExt }

constructor TidePgtoExt.Create(AOwner: TInfoIrrfCollectionItem);
begin
  FidePais := TidePais.Create;
  FendExt := TendExt.Create;
end;

destructor TidePgtoExt.Destroy;
begin
  FidePais.Free;
  FendExt.Free;

  inherited;
end;

function TEvtIrrfBenef.LerXML: boolean;
var
  ok: Boolean;
  i, j: Integer;
begin
  Result := False;
  try
    XML := Leitor.Arquivo;

    if leitor.rExtrai(1, 'evtIrrfBenef') <> '' then
    begin
      FId := Leitor.rAtributo('Id=');

      if leitor.rExtrai(2, 'ideEvento') <> '' then
      begin
        IdeEvento.nrRecArqBase := leitor.rCampo(tcStr, 'nrRecArqBase');
        IdeEvento.IndApuracao  := eSStrToIndApuracao(ok, leitor.rCampo(tcStr, 'IndApuracao'));
        IdeEvento.perApur      := leitor.rCampo(tcStr, 'perApur');
      end;

      if leitor.rExtrai(2, 'ideEmpregador') <> '' then
      begin
        IdeEmpregador.TpInsc := eSStrToTpInscricao(ok, leitor.rCampo(tcStr, 'tpInsc'));
        IdeEmpregador.NrInsc := leitor.rCampo(tcStr, 'nrInsc');
      end;

      if leitor.rExtrai(2, 'ideTrabalhador') <> '' then
        IdeTrabalhador.cpfTrab := leitor.rCampo(tcStr, 'cpfTrab');

      if leitor.rExtrai(2, 'infoDep') <> '' then
        infoDep.vrDedDep := leitor.rCampo(tcDe2, 'vrDedDep');

      i := 0;
      while Leitor.rExtrai(2, 'infoIrrf', '', i + 1) <> '' do
      begin
        InfoIrrf.Add;
        InfoIrrf.Items[i].CodCateg := leitor.rCampo(tcInt, 'codCateg');
        InfoIrrf.Items[i].indResBr := leitor.rCampo(tcStr, 'indResBr');

        j := 0;
        while Leitor.rExtrai(3, 'baseIrrf', '', j + 1) <> '' do
        begin
          InfoIrrf.Items[i].baseIrrf.Add;
          InfoIrrf.Items[i].baseIrrf.Items[j].tpValor := leitor.rCampo(tcInt, 'tpValor');
          InfoIrrf.Items[i].baseIrrf.Items[j].valor   := leitor.rCampo(tcDe2, 'valor');
          inc(j);
        end;

        j := 0;
        while Leitor.rExtrai(3, 'irrf', '', j + 1) <> '' do
        begin
          InfoIrrf.Items[i].irrf.Add;
          InfoIrrf.Items[i].irrf.Items[j].tpCR       := leitor.rCampo(tcStr, 'tpCR');
          InfoIrrf.Items[i].irrf.Items[j].vrIrrfDesc := leitor.rCampo(tcDe2, 'vrIrrfDesc');
          inc(j);
        end;

        if leitor.rExtrai(3, 'idePgtoExt') <> '' then
        begin
          if leitor.rExtrai(4, 'idePais') <> '' then
          begin
            InfoIrrf.Items[i].idePgtoExt.idePais.codPais  := leitor.rCampo(tcStr, 'codPais');
            InfoIrrf.Items[i].idePgtoExt.idePais.indNIF   := eSStrToIndNIF(ok, leitor.rCampo(tcStr, 'indNIF'));
            InfoIrrf.Items[i].idePgtoExt.idePais.nifBenef := leitor.rCampo(tcStr, 'nifBenef');
          end;

          if leitor.rExtrai(4, 'endExt') <> '' then
          begin
            InfoIrrf.Items[i].idePgtoExt.endExt.dscLograd := leitor.rCampo(tcStr, 'dscLograd');
            InfoIrrf.Items[i].idePgtoExt.endExt.nrLograd  := leitor.rCampo(tcStr, 'nrLograd');
            InfoIrrf.Items[i].idePgtoExt.endExt.complem   := leitor.rCampo(tcStr, 'complem');
            InfoIrrf.Items[i].idePgtoExt.endExt.bairro    := leitor.rCampo(tcStr, 'bairro');
            InfoIrrf.Items[i].idePgtoExt.endExt.nmCid     := leitor.rCampo(tcStr, 'nmCid');
            InfoIrrf.Items[i].idePgtoExt.endExt.codPostal := leitor.rCampo(tcStr, 'codPostal');
          end;
        end;

        inc(i);
      end;

      Result := True;
    end;
  except
    Result := False;
  end;
end;

end.
