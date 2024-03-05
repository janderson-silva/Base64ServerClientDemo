program AppUploadFoto;

uses
  Vcl.Forms,
  untPrincipal in 'src\untPrincipal.pas' {frmPrincipal},
  unt.interfaces.foto in 'src\unt.interfaces.foto.pas',
  unt.model.foto in 'src\unt.model.foto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
