unit uPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient;

type
  TfrmPadrao = class(TForm)
    pnlPersistir: TPanel;
    btnEditar: TBitBtn;
    btnSalvar: TBitBtn;
    btnExcluir: TBitBtn;
    dsPadrao: TDataSource;
    btnFechar: TBitBtn;
    btnInserir: TBitBtn;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPadrao: TfrmPadrao;

implementation

uses
  FireDAC.Comp.Client, uConstantes;

{$R *.dfm}

procedure TfrmPadrao.btnEditarClick(Sender: TObject);
begin
  dsPadrao.DataSet.Edit;

  btnEditar.Enabled := False;

  btnSalvar.Enabled := True;
end;

procedure TfrmPadrao.btnSalvarClick(Sender: TObject);
begin
  try
    dsPadrao.DataSet.Post;

    if dsPadrao.DataSet.ClassType = TFDQuery then
      if TFDQuery(dsPadrao.DataSet).CachedUpdates then
        TFDQuery(dsPadrao.DataSet).ApplyUpdates(0);

    btnSalvar.Enabled := False;
    btnEditar.Enabled := True;
  except
    on e: exception do
    begin
      Application.MessageBox(PWideChar('Não foi possível salvar!' + #13 + 'Motivo: ' + e.Message ),GESTOR_NFE,MB_OK + MB_ICONWARNING);
      btnSalvar.Enabled := False;
    end;
  end;
end;

procedure TfrmPadrao.FormShow(Sender: TObject);
begin
  btnExcluir.Enabled := not dsPadrao.DataSet.IsEmpty;
end;

procedure TfrmPadrao.btnExcluirClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPadrao.btnInserirClick(Sender: TObject);
begin
  dsPadrao.DataSet.Open;
  dsPadrao.DataSet.Append;

  btnSalvar.Enabled := True;
  btnEditar.Enabled := False;
end;

end.
