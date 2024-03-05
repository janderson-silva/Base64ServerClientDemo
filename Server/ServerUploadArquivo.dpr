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



program ServerUploadArquivo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  controller.arquivo in 'src\controller.arquivo.pas',
  model.arquivo in 'src\model.arquivo.pas',
  interfaces.arquivo in 'src\interfaces.arquivo.pas',
  model.connection in 'src\model.connection.pas';

begin
  THorse.Use(Jhonson());
  controller.arquivo.Registry;
  THorse.Listen(9000);
end.
