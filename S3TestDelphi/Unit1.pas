unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI;

type
  TForm19 = class(TForm)
    AmazonConnectionInfo1: TAmazonConnectionInfo;
    Edit1: TEdit;
    btnUpload: TButton;
    btnDownload: TButton;
    procedure btnUploadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form19: TForm19;

implementation

{$R *.fmx}

const
  BUCKET_NAME = 'cookplay-test';
  OBJ_NAME = 'testobj1';

procedure TForm19.btnUploadClick(Sender: TObject);
var
  s3: TAmazonStorageService;
  strstr: TStringStream;
begin
  s3 := TAmazonStorageService.Create(AmazonConnectionInfo1);
  strstr := TStringStream.Create(Edit1.Text);
  try
    if s3.UploadObject(BUCKET_NAME, OBJ_NAME, strstr.bytes) then
      ShowMessage('Uploaded OK')
    else
      ShowMessage('Upload ERROR');
  finally
    strstr.Free;
    s3.Free;
  end;
end;

end.
