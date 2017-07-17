program ListBoxProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  uListBoxMain in 'uListBoxMain.pas' {frmListBoxMain},
  uThread in 'uThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmListBoxMain, frmListBoxMain);
  Application.Run;
end.
