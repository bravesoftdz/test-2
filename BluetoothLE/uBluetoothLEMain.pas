unit uBluetoothLEMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Bluetooth, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Bluetooth.Components;

type
  TForm22 = class(TForm)
    BluetoothLE: TBluetoothLE;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form22: TForm22;

implementation

{$R *.fmx}

procedure TForm22.Button1Click(Sender: TObject);
begin
  showMessage(BluetoothLE.DiscoveredDevices.count.ToString);
end;

procedure TForm22.FormShow(Sender: TObject);
begin
  BluetoothLE.Enabled := True;
end;

end.
