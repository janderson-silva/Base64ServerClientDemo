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



unit interfaces.foto;

interface

uses
  Horse,
  VCL.Graphics;

type
  iFoto = interface
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

end.
