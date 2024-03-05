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



unit model.foto;

interface

uses
  Horse,
  Data.DB,
  FireDAC.Comp.Client,
  System.SysUtils,
  VCL.Graphics,
  interfaces.foto,
  model.connection;

type
  TFoto = class(TInterfacedObject, iFoto)
    private
      Fid : Integer;
      Fnome : string;
      Ffoto : TBitmap   {oid};
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFoto;

      function id (Value : Integer) : iFoto; overload;
      function id : Integer; overload;

      function nome (Value : String) : iFoto; overload;
      function nome : String; overload;

      function foto (Value : TBitmap   {oid}) : iFoto; overload;
      function foto : TBitmap   {oid}; overload;

      function Insert(out erro : String) : iFoto; overload;

      function &End : iFoto;

  end;

implementation

{ TFoto }

constructor TFoto.Create;
begin
  model.connection.Connect;
end;

destructor TFoto.Destroy;
begin
  model.connection.Disconect;
end;

class function TFoto.New: iFoto;
begin
  Result := Self.Create;
end;

function TFoto.&End: iFoto;
begin
  Result := Self;
end;

function TFoto.Insert(out erro: String): iFoto;
var
  qry : TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Model.Connection.FConnection;
    qry.Active := False;
    qry.sql.Clear;
    qry.sql.Add('insert into foto(');
    qry.SQL.Add('    nome,');
    qry.SQL.Add('    foto');
    qry.SQL.Add(') values (');
    qry.SQL.Add('    :nome,');
    qry.SQL.Add('    :foto');
    qry.SQL.Add(')');
    qry.ParamByName('nome').Value := Fnome;
    qry.ParamByName('foto').Assign(Ffoto);
    qry.ExecSQL;
    qry.Free;
    erro := '';
  except on ex:exception do
    begin
      erro := 'Erro ao inserir Foto: ' + ex.Message;
    end;
  end;
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

function TFoto.foto (Value : TBitmap   {oid}) : iFoto;
begin
  Result := Self;
  Ffoto := Value;
end;

function TFoto.foto : TBitmap   {oid};
begin
  Result := Ffoto;
end;

end.
