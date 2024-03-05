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



unit unt.model.arquivo;

interface

uses
  RESTRequest4D,
  System.SysUtils,
  Vcl.Forms,
  Winapi.Windows,
  unt.interfaces.arquivo;

type
  TArquivo = class(TInterfacedObject, iArquivo)
    private
      Fid : Integer;
      Fnome : string;
      FArquivo : string;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iArquivo;

      function id (Value : Integer) : iArquivo; overload;
      function id : Integer; overload;

      function nome (Value : String) : iArquivo; overload;
      function nome : String; overload;

      function arquivo (Value : string) : iArquivo; overload;
      function arquivo : string; overload;

      function Insert : iArquivo; overload;
      function Select : String; overload;

      function &End : iArquivo;

  end;

implementation

{ TArquivo }

constructor TArquivo.Create;
begin

end;

destructor TArquivo.Destroy;
begin

end;

class function TArquivo.New: iArquivo;
begin
  Result := Self.Create;
end;

function TArquivo.&End: iArquivo;
begin
  Result := Self;
end;

function TArquivo.Insert: iArquivo;
var
  Resp : IResponse;
begin
  Resp := TRequest.New.BaseURL('http://localhost:9000/v1/')
              .Resource('arquivo')
              .Accept('application/json')
              .AddBody('{'+
                       '"nome":"'+nome+'",'+
                       '"arquivo":"'+arquivo+'"'+
                       '}')
            .Post;

  if Resp.StatusCode <> 200 then
    raise Exception.Create('Status Code: #' + Resp.StatusCode.ToString + #13+#13 + Resp.Content )
  else
    Application.MessageBox(PChar('Cadastrado com sucesso!'),'Atenção',MB_OK+MB_ICONINFORMATION);
end;

function TArquivo.Select: String;
var
  Resp : IResponse;
begin
  Resp := TRequest.New.BaseURL('http://localhost:9000/v1/')
              .Resource('arquivo')
              .Accept('application/json')
            .Get;

  if Resp.StatusCode <> 200 then
    raise Exception.Create('Status Code: #' + Resp.StatusCode.ToString + #13+#13 + Resp.Content )
  else
    Result := Resp.Content;
end;

function TArquivo.id (Value : Integer) : iArquivo;
begin
  Result := Self;
  Fid := Value;
end;

function TArquivo.id : Integer;
begin
  Result := Fid;
end;

function TArquivo.nome (Value : string) : iArquivo;
begin
  Result := Self;
  Fnome := Value;
end;

function TArquivo.nome : string;
begin
  Result := Fnome;
end;

function TArquivo.arquivo (Value : string) : iArquivo;
begin
  Result := Self;
  FArquivo := Value;
end;

function TArquivo.arquivo : string;
begin
  Result := FArquivo;
end;

end.
