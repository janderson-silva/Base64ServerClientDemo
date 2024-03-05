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



unit untPrincipal;

interface

uses
  Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.NetEncoding,
  unt.interfaces.arquivo,
  unt.model.arquivo, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataSet.Serialize;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    btnEnviar: TButton;
    Panel4: TPanel;
    Panel6: TPanel;
    btnReceber: TButton;
    FDMemTable1: TFDMemTable;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure btnEnviarClick(Sender: TObject);
    procedure btnReceberClick(Sender: TObject);
  private
    function ConvertFileToBase64(AInFileName: string): String;
    function ConvertBase64ToFile(Base64, FileName: string): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

function TfrmPrincipal.ConvertFileToBase64(AInFileName: string): String;
var
  inStream    : TStream;
  outStream   : TStream;
  vFile       : String;
  vStringList : TStringList;
begin
  inStream    := TFileStream.Create(AInFileName, fmOpenRead);
  vStringList := TStringList.Create;
  try
    vFile := FormatDateTime('hhmmss',Now);
    outStream := TFileStream.Create(vFile, fmCreate);
    try
      TNetEncoding.Base64.Encode(inStream, outStream);
    finally
      outStream.Free;
    end;

    vStringList.LoadFromFile(vFile);

    Result := vStringList.Text;
  finally
    DeleteFile(Pchar(vFile));
    inStream.Free;
  end;
end;

function TfrmPrincipal.ConvertBase64ToFile(Base64, FileName: string) : String;
var
  inStream    : TStream;
  outStream   : TStream;

  DirFileInStream   : String;
  DirFileOutStream  : String;
  NameFileInStream  : String;
  NameFileOutStream : String;

  vStringList : TStringList;
begin
  vStringList := TStringList.Create;
  try
    //local onde vai salvar os arquivos antes de salvar no banco
    DirFileInStream  := GetCurrentDir + '\temp\input\';
    DirFileOutStream := GetCurrentDir + '\temp\output\';

    //verifica se os diretorios existem, se nao existir, cria
    if not DirectoryExists(DirFileInStream) then
      ForceDirectories(DirFileInStream);

    if not DirectoryExists(DirFileOutStream) then
      ForceDirectories(DirFileOutStream);

    DirFileInStream := DirFileInStream + FormatDateTime('yyyy-mm-dd HH-mm-ss',Now);
    vStringList.Add(Base64);
    vStringList.SaveToFile(DirFileInStream);
    inStream := TFileStream.Create(DirFileInStream, fmOpenRead);

    try
      DirFileOutStream := DirFileOutStream + FormatDateTime('yyyy-mm-dd HH-mm-ss',Now) + ' ' + FileName;
      outStream := TFileStream.Create(DirFileOutStream, fmCreate);
      try
        TNetEncoding.Base64.Decode(inStream, outStream);
        Result := DirFileOutStream;
      finally
        outStream.Free;
      end;
    finally
      inStream.Free;
    end;

  finally
    DeleteFile(PChar(DirFileInStream));
    FreeAndNil(vStringList);
  end;
end;

procedure TfrmPrincipal.btnEnviarClick(Sender: TObject);
var
  FArquivo : iArquivo;
begin
  Memo1.Lines.Clear;
  Memo1.Lines.LoadFromFile(GetCurrentDir + '\ConvertBase64ToFile.txt');

  FArquivo := TArquivo.New;
  try
    FArquivo
        .nome('ConvertBase64ToFile.txt')
        .arquivo(ConvertFileToBase64(GetCurrentDir + '\ConvertBase64ToFile.txt'))
      .Insert;
  finally

  end;
end;

procedure TfrmPrincipal.btnReceberClick(Sender: TObject);
var
  FArquivo : iArquivo;

  diretorioArq: string;
begin
  Memo2.Lines.Clear;
  FArquivo := TArquivo.New;
  try
    //carrega o MemTable com os dados do JSON
    FDMemTable1.Close;
    FDMemTable1.LoadFromJSON(FArquivo
                               .Select);
    FDMemTable1.Open;
    FDMemTable1.First;

    //Converte o arquivo base64
    if not FDMemTable1.IsEmpty then
    begin
      if Trim(FDMemTable1.FieldByName('arquivo').AsString) <> '' then
      begin
        diretorioArq := ConvertBase64ToFile(FDMemTable1.FieldByName('arquivo').AsString,
                                            FDMemTable1.FieldByName('nome').AsString);

        Memo2.Lines.LoadFromFile(diretorioArq);
      end;
    end;
  except on E : Exception do
    begin
      raise Exception.Create(E.Message);
      Exit;
    end;
  end;
end;

end.
