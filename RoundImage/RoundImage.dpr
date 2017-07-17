program RoundImage;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form18};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm18, Form18);
  Application.Run;
end.
