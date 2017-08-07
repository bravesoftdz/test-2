program MySQLProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form19},
  uNodejs in 'uNodejs.pas' {dmNodejs: TDataModule},
  uDatasnap in 'uDatasnap.pas' {dmDatasnap: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm19, Form19);
  Application.CreateForm(TdmNodejs, dmNodejs);
  Application.CreateForm(TdmDatasnap, dmDatasnap);
  Application.Run;
end.
