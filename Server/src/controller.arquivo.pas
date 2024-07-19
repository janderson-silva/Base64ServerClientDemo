{*******************************************************************************}
{                                                                               }
{ Projeto: ExemploUploadArquivoHorse - HorseAndRESTRequest4Delphi               }
{                                                                               }
{*******************************************************************************}
{                                                                               }
{ Desenvolvido por JANDERSON APARECIDO DA SILVA                                 }
{ Email: janderson_rm@hotmail.com                                               }
{                                                                               }
{*******************************************************************************}



unit controller.arquivo;

interface

uses
  Horse,
  Data.DB,
  DataSet.Serialize,
  FireDAC.Comp.Client,
  Soap.EncdDecd,
  System.Classes,
  System.JSON,
  System.SysUtils,
  VCL.Graphics,
  interfaces.arquivo,
  model.arquivo;

procedure Registry;

implementation

procedure InsertArquivo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Farquivo : iArquivo;
  erro : string;
  body  : TJsonValue;
begin
  // Conexao com o banco...
  try
    Farquivo := TArquivo.New;
  except
    res.Send('{ "Erro": "Erro ao conectar com o banco" }').Status(500);
    exit;
  end;

  try
    body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;
    Farquivo
        .nome(body.GetValue<string>('nome',''))
        .arquivo(body.GetValue<string>('arquivo',''))
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

procedure SelectArquivo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Farquivo : iArquivo;
  qry : TFDQuery;
  erro : string;
  ArrayArquivo : TJSONArray;
begin
  // Conexao com o banco...
  try
    Farquivo := TArquivo.New;
  except
    res.Send('{ "Erro": "Erro ao conectar com o banco" }').Status(500);
    exit;
  end;

  try
    try
      qry := Farquivo
                .Select(erro);

      if erro <> '' then
        raise Exception.Create(erro)
      else
      begin
        if qry.RecordCount > 0 then
        begin
          ArrayArquivo := qry.ToJSONArray();
          res.Send<TJSONArray>(ArrayArquivo).Status(200);
        end
        else
        begin
          res.Send('{ "Erro": "Nenhum cadastro de pessoa_anexo encontrado" }').Status(404);
        end;
      end;
    except on E : Exception do
      begin
        res.Send('{ "erro": "'+E.Message+'" }').Status(400);
        Exit;
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure DeleteArquivo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Farquivo : iArquivo;
  erro : string;
begin
  // Conexao com o banco...
  try
    Farquivo := TArquivo.New;
  except
    res.Send('{ "Erro": "Erro ao conectar com o banco" }').Status(500);
    exit;
  end;

  try
    Farquivo
        .id(Req.Params['id'].ToInteger)
      .Delete(erro);

    if erro <> '' then
      raise Exception.Create(erro)
    else
      res.Send('{ deletado com sucesso }').Status(200);
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
      .Post('/arquivo', InsertArquivo)
      .Get('/arquivo', SelecTArquivo)
      .Delete('/arquivo/:id', DeleteArquivo);
end;

end.
