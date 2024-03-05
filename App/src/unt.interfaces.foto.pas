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



unit unt.interfaces.foto;

interface

type
  iFoto = interface
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

end.
