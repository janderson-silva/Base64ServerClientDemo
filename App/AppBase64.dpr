program AppBase64;

uses
  Vcl.Forms,
  untPrincipal in 'src\untPrincipal.pas' {frmPrincipal},
  unt.interfaces.arquivo in 'src\unt.interfaces.arquivo.pas',
  unt.model.arquivo in 'src\unt.model.arquivo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
