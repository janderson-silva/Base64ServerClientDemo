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



program ServerUploadFoto;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  controller.foto in 'src\controller.foto.pas',
  model.foto in 'src\model.foto.pas',
  interfaces.foto in 'src\interfaces.foto.pas',
  model.connection in 'src\model.connection.pas';

begin
  THorse.Use(Jhonson());
  controller.foto.Registry;
  THorse.Listen(9000);
end.
