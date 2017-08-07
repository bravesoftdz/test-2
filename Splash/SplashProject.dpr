program SplashProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  uSplashMain in 'uSplashMain.pas' {Form21};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm21, Form21);
  Application.Run;
end.
