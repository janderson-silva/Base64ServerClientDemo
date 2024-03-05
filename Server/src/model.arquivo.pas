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



unit model.arquivo;

interface

uses
  Horse,
  Data.DB,
  FireDAC.Comp.Client,
  System.SysUtils,
  interfaces.arquivo,
  model.connection;

type
  TArquivo = class(TInterfacedObject, iArquivo)
    private
      Fid : Integer;
      Fnome : string;
      Farquivo : String;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iArquivo;

      function id (Value : Integer) : iArquivo; overload;
      function id : Integer; overload;

      function nome (Value : String) : iArquivo; overload;
      function nome : String; overload;

      function arquivo (Value : String) : iArquivo; overload;
      function arquivo : String; overload;

      function Insert(out erro : String) : iArquivo; overload;
      function Select(out erro : string) : TFDquery; overload;

      function &End : iArquivo;

  end;

implementation

{ TArquivo }

constructor TArquivo.Create;
begin
  model.connection.Connect;
end;

destructor TArquivo.Destroy;
begin
  model.connection.Disconect;
end;

class function TArquivo.New: iArquivo;
begin
  Result := Self.Create;
end;

function TArquivo.&End: iArquivo;
begin
  Result := Self;
end;

function TArquivo.Insert(out erro: String): iArquivo;
var
  qry : TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Model.Connection.FConnection;
    qry.Active := False;
    qry.sql.Clear;
    qry.sql.Add('insert into arquivo(');
    qry.SQL.Add('    nome,');
    qry.SQL.Add('    arquivo');
    qry.SQL.Add(') values (');
    qry.SQL.Add('    :nome,');
    qry.SQL.Add('    :arquivo');
    qry.SQL.Add(')');
    qry.ParamByName('nome').Value := Fnome;
    qry.ParamByName('arquivo').Value := Farquivo;
    qry.ExecSQL;
    qry.Free;
    erro := '';
  except on ex:exception do
    begin
      erro := 'Erro ao inserir Arquivo: ' + ex.Message;
    end;
  end;
end;

function TArquivo.Select(out erro : string) : TFDquery;
var
  qry : TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Model.Connection.FConnection;
    qry.Active := False;
    qry.sql.Clear;
    qry.sql.Add('select first 1 * from arquivo');
    qry.Active := True;
    erro := '';
    Result := qry;
  except on ex:exception do
    begin
      erro := 'Erro ao consultar Arquivo: ' + ex.Message;
      Result := nil;
    end;
  end;
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
  Farquivo := Value;
end;

function TArquivo.arquivo : string;
begin
  Result := Farquivo;
end;

end.
