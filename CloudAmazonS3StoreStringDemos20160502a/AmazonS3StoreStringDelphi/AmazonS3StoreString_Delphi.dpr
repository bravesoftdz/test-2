program AmazonS3StoreString_Delphi;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFormS3StoreString in 'uFormS3StoreString.pas' {FormS3StoreString};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormS3StoreString, FormS3StoreString);
  Application.Run;
end.
