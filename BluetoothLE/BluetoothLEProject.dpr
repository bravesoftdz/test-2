program BluetoothLEProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  uBluetoothLEMain in 'uBluetoothLEMain.pas' {Form22};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm22, Form22);
  Application.Run;
end.
