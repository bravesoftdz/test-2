program Facebook2;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  uFacebook in 'uFacebook.pas' {frmFacebook},
  uBackground in 'uBackground.pas' {frmBackground};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmFacebook, frmFacebook);
  Application.CreateForm(TfrmBackground, frmBackground);
  Application.Run;
end.
