unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ToolWin,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList;

type
  TfrmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    btnConfiguracoes: TSpeedButton;
    btnNFe: TSpeedButton;
    btnCTe: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Empresa1: TMenuItem;
    BancosdeDados1: TMenuItem;
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure btnCTeClick(Sender: TObject);
    procedure acNFeExecute(Sender: TObject);
    procedure Empresa1Click(Sender: TObject);
    procedure BancosdeDados1Click(Sender: TObject);
    procedure btnNFeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}
//{$R C:\ProjetosTokyo\Gestor\GestorNFe.dres}

uses uConfiguracao.BancoDados, uConfiguracao.Empresa, uFrmCTe, uFrmNFe;

procedure TfrmPrincipal.Empresa1Click(Sender: TObject);
begin
  try
    frmConfiguracaoEmpresa := TfrmConfiguracaoEmpresa.Create(Self);
    frmConfiguracaoEmpresa.ShowModal;
  finally
    FreeAndNil(frmConfiguracaoEmpresa);
  end;
end;

procedure TfrmPrincipal.acNFeExecute(Sender: TObject);
begin
  try
    frmNFe := frmNFe.Create(nil);
    frmNFe.ShowModal;
  finally
    FreeAndNil(frmNFe);
  end;
end;

procedure TfrmPrincipal.BancosdeDados1Click(Sender: TObject);
begin
  try
    frmConfiguracaoBancoDados := TfrmConfiguracaoBancoDados.Create(Self);
    frmConfiguracaoBancoDados.ShowModal;
  finally
    FreeAndNil(frmConfiguracaoBancoDados);
  end;
end;

procedure TfrmPrincipal.btnConfiguracoesClick(Sender: TObject);
var
  P1, P2: TPoint;
begin
  P1.X := btnConfiguracoes.Left;
  P1.Y := btnConfiguracoes.Top + btnConfiguracoes.Height;
  P2 := ClientToScreen(P1);
  PopupMenu1.PopUp(P2.X, P2.Y);
end;

procedure TfrmPrincipal.btnCTeClick(Sender: TObject);
begin
  try
    frmCTe := TfrmCTe.Create(nil);
    frmCTe.ShowModal;
  finally
    FreeAndNil(frmCTe);
  end;
end;

procedure TfrmPrincipal.btnNFeClick(Sender: TObject);
begin
  try
    frmNFe := TfrmNFe.Create(nil);
    frmNFe.ShowModal;
  finally
    FreeAndNil(frmNFe);
  end;

end;

end.
