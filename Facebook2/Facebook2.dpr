program Facebook2;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  uFacebook in 'uFacebook.pas' {frmFacebook};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmFacebook, frmFacebook);
  Application.Run;
end.
