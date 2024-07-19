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



unit unt.interfaces.arquivo;

interface

type
  iArquivo = interface
    function id (Value : Integer) : iArquivo; overload;
    function id : Integer; overload;

    function nome (Value : String) : iArquivo; overload;
    function nome : String; overload;

    function arquivo (Value : string) : iArquivo; overload;
    function arquivo : string; overload;

    function Insert : iArquivo; overload;
    function Select : String; overload;
    function Delete : iArquivo; overload;

    function &End : iArquivo;

  end;

implementation

end.
