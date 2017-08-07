program FacebookProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFacebookMain in 'uFacebookMain.pas' {frmFacebookMain},
  uLogin in 'uLogin.pas' {frmLogin},
  uSistema in 'uSistema.pas' {frmSistema},
  uShowResult in 'uShowResult.pas' {frmShowResult};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFacebookMain, frmFacebookMain);
  Application.Run;
end.
