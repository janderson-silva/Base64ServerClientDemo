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
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataSet.Serialize,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmPrincipal = class(TForm)
    Panel3: TPanel;
    pnlListarArquivos: TPanel;
    pnlEnviarArquivo: TPanel;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    OpenDialog1: TOpenDialog;
    pnlConverter: TPanel;
    FDMemTable1id: TIntegerField;
    FDMemTable1nome: TStringField;
    FDMemTable1arquivo: TWideMemoField;
    Panel1: TPanel;
    procedure pnlListarArquivosClick(Sender: TObject);
    procedure pnlEnviarArquivoClick(Sender: TObject);
    procedure pnlConverterClick(Sender: TObject);
  private
    function ConvertFileToBase64(AInFileName: string): String;
    procedure ConvertBase64ToFile(const Base64Text: string; const FileName: string);
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

procedure TfrmPrincipal.ConvertBase64ToFile(const Base64Text: string; const FileName: string);
var
  Bytes: TBytes;
  FileStream: TFileStream;
  Decoder: TBase64Encoding;
begin
  // Inicializa o decodificador Base64
  Decoder := TBase64Encoding.Create;

  try
    // Converte o texto Base64 em bytes
    Bytes := Decoder.DecodeStringToBytes(Base64Text);

    // Cria um FileStream para salvar o arquivo
    FileStream := TFileStream.Create(FileName, fmCreate);
    try
      // Escreve os bytes decodificados no arquivo
      FileStream.WriteBuffer(Bytes[0], Length(Bytes));
    finally
      FileStream.Free;
    end;
  finally
    Decoder.Free;
  end;
end;

procedure TfrmPrincipal.pnlEnviarArquivoClick(Sender: TObject);
var
  FArquivo : iArquivo;
begin
  OpenDialog1.FileName := '';
  if OpenDialog1.Execute then
    if OpenDialog1.FileName <> '' then
    begin
      FArquivo := TArquivo.New;
      try
        FArquivo
            .nome(ExtractFileName(OpenDialog1.FileName))
            .arquivo(ConvertFileToBase64(OpenDialog1.FileName))
          .Insert;
      finally

      end;
    end;
end;

procedure TfrmPrincipal.pnlListarArquivosClick(Sender: TObject);
var
  FArquivo : iArquivo;
begin
  FArquivo := TArquivo.New;
  try
    //carrega o MemTable com os dados do JSON
    FDMemTable1.Close;
    FDMemTable1.LoadFromJSON(FArquivo
                               .Select);
    FDMemTable1.Open;
    FDMemTable1.First;
  except on E : Exception do
    begin
      raise Exception.Create(E.Message);
      Exit;
    end;
  end;
end;

procedure TfrmPrincipal.pnlConverterClick(Sender: TObject);
var
  lPathApp,
  lPathAppSub : string;
  Base64Text: string;
  FileName: string;
begin
  // Exemplo de texto Base64 (substitua pelo seu próprio texto Base64)
  Base64Text := FDMemTable1.FieldByName('arquivo').AsString;

  // caminho das pastas gerais
  lPathApp := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  // caminho da pasta certificado
  lPathAppSub := IncludeTrailingPathDelimiter(lPathApp + 'Arquivo');

  ForceDirectories(lPathAppSub);

  // Caminho e nome do arquivo onde será salvo o conteúdo decodificado
  FileName := lPathAppSub + FDMemTable1.FieldByName('nome').AsString;

  // Chama a função para salvar o arquivo
  ConvertBase64ToFile(Base64Text, FileName);

  ShowMessage('Arquivo salvo com sucesso em: ' + FileName);
end;

end.
