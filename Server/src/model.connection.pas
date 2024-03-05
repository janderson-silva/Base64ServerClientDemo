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



unit model.connection;

interface

uses
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.Intf,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,
  System.Classes,
  System.IniFiles,
  System.JSON,
  System.SysUtils,
  System.Types,
  Winapi.Windows;

 var
    FConnection : TFDConnection;
    FCursor     : TFDGUIxWaitCursor;
    FDriver     : TFDPhysPgDriverLink;

function SetupConnection(FConn: TFDConnection; DriverLink : TFDPhysPgDriverLink; cursor : TFDGUIxWaitCursor): string;
function Connect : TFDConnection;
procedure Disconect;

implementation

function SetupConnection(FConn: TFDConnection; DriverLink : TFDPhysPgDriverLink; cursor : TFDGUIxWaitCursor): string;
var
  ArqIni : string;
  ini : TIniFile;
begin
  try
    try
      ArqIni := GetCurrentDir + '\ServerUploadFoto.ini';

      // Verifica se INI existe...
      if not FileExists(ArqIni) then
      begin
        Result := 'Arquivo INI não encontrado: ' + ArqIni;
        exit;
      end;

      // Instanciar arquivo INI...
      ini := TIniFile.Create(ArqIni);

      DriverLink.VendorLib := GetCurrentDir + '\fbclient.dll';

      // Buscar dados da conexão...
      FConn.Params.Values['DriverID'] := ini.ReadString('Database', 'DriverID', 'FB');
      FConn.Params.Values['Database'] := ini.ReadString('Database', 'Database', GetCurrentDir + '\UPLOADFOTO.FDB');
      FConn.Params.Values['User_name'] := ini.ReadString('Database', 'User_name', 'sysdba');
      FConn.Params.Values['Password'] := ini.ReadString('Database', 'Password', 'masterkey');
      FConn.Params.Values['Port'] := ini.ReadString('Database', 'Port', '3050');
      FConn.Params.Values['Server'] := ini.ReadString('Database', 'Server', 'localhost');

      Result := 'OK';
    except on ex:exception do
      Result := 'Erro ao configurar banco: ' + ex.Message;
    end;
  finally
    if Assigned(ini) then
        ini.DisposeOf;
  end;
end;

function Connect : TFDConnection;
begin
  FConnection := TFDConnection.Create(nil);
  FDriver     := TFDPhysPgDriverLink.Create(nil);
  FCursor     := TFDGUIxWaitCursor.Create(nil);
  SetupConnection(FConnection, FDriver, FCursor);
  FConnection.Connected := True;

  Result := FConnection;
end;

procedure Disconect;
begin
  if Assigned(FConnection) then
  begin
    if FConnection.Connected then
      FConnection.Connected := false;

    FConnection.Free;
  end;
end;

end.
