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



unit controller.foto;

interface

uses
  Horse,
  Soap.EncdDecd,
  System.Classes,
  System.JSON,
  System.SysUtils,
  VCL.Graphics,
  interfaces.foto,
  model.foto;

procedure Registry;

implementation

function BitmapFromBase64(const base64: string): TBitmap;
var
  Input: TStringStream;
  Output: TBytesStream;
begin
  Input := TStringStream.Create(base64, TEncoding.ASCII);
  try
    Output := TBytesStream.Create;
    try
      Soap.EncdDecd.DecodeStream(Input, Output);
      Output.Position := 0;
      Result := TBitmap.Create;
      try
        Result.LoadFromStream(Output);
      except
        Result.Free;
        raise;
      end;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

procedure InsertFoto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Ffoto : ifoto;
  erro, foto64 : string;
  body  : TJsonValue;
begin
  // Conexao com o banco...
  try
    Ffoto := Tfoto.New;
  except
    res.Send('{ "Erro": "Erro ao conectar com o banco" }').Status(500);
    exit;
  end;

  try
    body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

    foto64 := body.GetValue<string>('foto','');

    Ffoto
        .nome(body.GetValue<string>('nome',''))
        .foto(BitmapFromBase64(foto64))
      .Insert(erro);

    body.Free;
    if erro <> '' then
      raise Exception.Create(erro)
    else
      res.Send('{ salvo com sucesso }').Status(200);
  except on E : Exception do
    begin
      res.Send('{ "erro": "'+E.Message+'" }').Status(400);
      Exit;
    end;
  end;
end;

procedure Registry;
begin
    THorse.Group.Prefix('v1')
      .Post('/foto', InsertFoto);
end;

end.
