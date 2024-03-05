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



unit unt.model.foto;

interface

uses
  RESTRequest4D,
  System.SysUtils,
  Vcl.Forms,
  Winapi.Windows,
  unt.interfaces.foto;

type
  TFoto = class(TInterfacedObject, iFoto)
    private
      Fid : Integer;
      Fnome : string;
      Ffoto : string;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFoto;

      function id (Value : Integer) : iFoto; overload;
      function id : Integer; overload;

      function nome (Value : String) : iFoto; overload;
      function nome : String; overload;

      function foto (Value : string) : iFoto; overload;
      function foto : string; overload;

      function Insert : iFoto; overload;

      function &End : iFoto;

  end;

implementation

{ TEmpresa_foto }

constructor TFoto.Create;
begin

end;

destructor TFoto.Destroy;
begin

end;

class function TFoto.New: iFoto;
begin
  Result := Self.Create;
end;

function TFoto.&End: iFoto;
begin
  Result := Self;
end;

function TFoto.Insert: iFoto;
var
  Resp : IResponse;
begin
  Resp := TRequest.New.BaseURL('http://localhost:9000/v1/')
              .Resource('foto')
              .Accept('application/json')
              .AddBody('{'+
                       '"nome":"'+nome+'",'+
                       '"foto":"'+foto+'"'+
                       '}')
            .Post;

  if Resp.StatusCode <> 200 then
    raise Exception.Create('Status Code: #' + Resp.StatusCode.ToString + #13+#13 + Resp.Content )
  else
    Application.MessageBox(PChar('Cadastrado com sucesso!'),'Atenção',MB_OK+MB_ICONINFORMATION);
end;

function TFoto.id (Value : Integer) : iFoto;
begin
  Result := Self;
  Fid := Value;
end;

function TFoto.id : Integer;
begin
  Result := Fid;
end;

function TFoto.nome (Value : string) : iFoto;
begin
  Result := Self;
  Fnome := Value;
end;

function TFoto.nome : string;
begin
  Result := Fnome;
end;

function TFoto.foto (Value : string) : iFoto;
begin
  Result := Self;
  Ffoto := Value;
end;

function TFoto.foto : string;
begin
  Result := Ffoto;
end;

end.
