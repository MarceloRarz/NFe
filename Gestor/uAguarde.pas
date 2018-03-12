unit uAguarde;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.GIFImg,
  Vcl.ExtCtrls;

type
  TfrmAguarde = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAguarde: TfrmAguarde;

implementation

{$R *.dfm}

procedure TfrmAguarde.FormCreate(Sender: TObject);
begin
  (Image1.Picture.Graphic as TGIFImage).Animate := True;
  (Image1.Picture.Graphic as TGIFImage).Transparent := True;
end;

end.
