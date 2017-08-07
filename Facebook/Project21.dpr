program Project21;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFacebookMain in 'uFacebookMain.pas' {Form21};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm21, Form21);
  Application.Run;
end.
