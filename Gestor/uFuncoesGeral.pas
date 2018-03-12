unit uFuncoesGeral;

interface

uses

 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
 Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Vcl.StdCtrls, Vcl.ComCtrls,
 Vcl.Buttons, Vcl.ExtCtrls;

 function GetCodigoEstado(pUF: string):Integer;

implementation

  function GetCodigoEstado(pUF: string):Integer;
  var
    ListaCidades: TStringList;
  begin
    ListaCidades := TStringList.Create;
    ListaCidades.CommaText := 'PE=16';

    Result := StrToInt(ListaCidades.Values[pUF]);
  end;

end.
