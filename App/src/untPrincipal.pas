{*******************************************************************************}
{                                                                               }
{ Projeto: ExemploUploadFotoHorse - HorseAndRESTRequest4Delphi                  }
{                                                                               }
{*******************************************************************************}
{                                                                               }
{ Desenvolvido por JANDERSON APARECIDO DA SILVA                                 }
{ Email: janderson_rm@hotmail.com                                               }
{                                                                               }
{*******************************************************************************}



unit untPrincipal;

interface

uses
  Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.NetEncoding,
  unt.interfaces.foto,
  unt.model.foto;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnEnviar: TButton;
    Image1: TImage;
    procedure btnEnviarClick(Sender: TObject);
  private
    function Base64FromBitmap(Bitmap: TBitmap): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

function TfrmPrincipal.Base64FromBitmap(Bitmap: TBitmap): string;
var
  Input: TBytesStream;
  Output: TStringStream;
  Encoding: TBase64Encoding;
begin
  Input := TBytesStream.Create;
  try
    Bitmap.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);

    try
      Encoding := TBase64Encoding.Create(0);
      Encoding.Encode(Input, Output);
      Result := Output.DataString;
    finally
      Encoding.Free;
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

procedure TfrmPrincipal.btnEnviarClick(Sender: TObject);
var
  foto64 : string;
  FFoto : iFoto;
begin
  Image1.Picture.LoadFromFile(GetCurrentDir + '\teste.bmp');
  Image1.Refresh;

  foto64 := Base64FromBitmap(Image1.Picture.Bitmap);
  FFoto := TFoto.New;
  try
    FFoto
        .foto(foto64)
      .Insert;
  finally

  end;
end;

end.
