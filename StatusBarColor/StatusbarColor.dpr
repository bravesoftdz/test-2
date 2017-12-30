program StatusbarColor;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form28},
  cookplay.StatusBar in 'cookplay.StatusBar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm28, Form28);
  Application.Run;
end.
