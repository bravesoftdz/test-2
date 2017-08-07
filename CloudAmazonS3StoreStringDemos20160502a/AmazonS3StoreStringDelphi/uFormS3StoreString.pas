unit uFormS3StoreString;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, IPPeerClient, REST.Backend.ServiceTypes,
  REST.Backend.MetaTypes, System.JSON, FMX.Objects, REST.Backend.ParseProvider,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Backend.BindSource,
  REST.Backend.ServiceComponents, REST.Backend.Providers,
  FMX.Surfaces, FMX.Consts, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  Data.DBXMySQL, Data.SqlExpr;

type
  TFormS3StoreString = class(TForm)
    AmazonConnectionInfo1: TAmazonConnectionInfo;
    Edit1: TEdit;
    btnUpload: TButton;
    btnDownload: TButton;
    Image1: TImage;
    btnUploadImage: TButton;
    btnUploadJPEGImage: TButton;
    Image2: TImage;
    Button1: TButton;
    NetHTTPClient1: TNetHTTPClient;
    btnDeleteObject: TButton;
    NetHTTPClient2: TNetHTTPClient;
    FDConnection1: TFDConnection;
    SQLConnection1: TSQLConnection;
    procedure btnUploadClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnUploadImageClick(Sender: TObject);
    procedure btnUploadJPEGImageClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnDeleteObjectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormS3StoreString: TFormS3StoreString;

implementation

const
//  BUCKET_NAME = 'cookplay-test';
  BUCKET_NAME = 'delphitest1';
  OBJ_NAME = 'testobj1.txt';

{$R *.fmx}

procedure TFormS3StoreString.btnUploadClick(Sender: TObject);
var s3: TAmazonStorageService; strstr: TStringStream;
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

procedure TFormS3StoreString.btnUploadImageClick(Sender: TObject);
var s3: TAmazonStorageService; strstr: TStringStream;
  oStream: TMemoryStream;
  s: TBytes;
begin
  s3 := TAmazonStorageService.Create(AmazonConnectionInfo1);
  strstr := TStringStream.Create(Edit1.Text);
  try
    oStream := TMemoryStream.Create;

    image1.Bitmap.SaveToStream(strstr);

    strstr.LoadFromFile('c:\test1.jpg');

//    oStream.Write(s, oStream.Size);

    if s3.UploadObject(BUCKET_NAME, 'test4.jpg', strstr.bytes, false, nil, nil, TAmazonACLType.amzbaPublicRead, nil) then
      ShowMessage('Uploaded OK')
    else
      ShowMessage('Upload ERROR');
  finally
    strstr.Free;
    s3.Free;
  end;
end;

procedure TFormS3StoreString.btnUploadJPEGImageClick(Sender: TObject);
var s3: TAmazonStorageService; strstr: TStringStream;
  oStream: TMemoryStream;
  s: TBytes;
begin
  image1.Bitmap.SaveToFile('c:\t\test3.jpg');
  exit;

  s3 := TAmazonStorageService.Create(AmazonConnectionInfo1);
  strstr := TStringStream.Create(Edit1.Text);
  try
    oStream := TMemoryStream.Create;

//    TBitmapCodecManager.SaveToStream(strstr, Image1.bitmap, '.jpg');
//    image1.Bitmap.SaveToStream(strstr);
//    oStream.Write(s, oStream.Size);

    if s3.UploadObject(BUCKET_NAME, 'test2.jpg', strstr.bytes) then
      ShowMessage('Uploaded OK')
    else
      ShowMessage('Upload ERROR');
  finally
    strstr.Free;
    s3.Free;
  end;
end;

procedure TFormS3StoreString.Button1Click(Sender: TObject);
var
  imgStream: TMemoryStream;
begin
  ImgStream := TMemoryStream.Create;
  NetHTTPClient1.Get('https://s3.ap-northeast-2.amazonaws.com/delphitest1/test4.jpg', ImgStream);
  image2.Bitmap.LoadFromStream(imgStream);
end;

procedure TFormS3StoreString.FormCreate(Sender: TObject);
begin
  AmazonConnectionInfo1.StorageEndpoint := 's3.ap-northeast-2.amazonaws.com';
end;

procedure TFormS3StoreString.btnDeleteObjectClick(Sender: TObject);
var s3: TAmazonStorageService;
begin
  s3 := TAmazonStorageService.Create(AmazonConnectionInfo1);
  try
    if s3.DeleteObject(BUCKET_NAME, 'test.jpg') then
      ShowMessage('deleted!')
    else
      ShowMessage('Failed to delete object');
  finally
    s3.Free;
  end;
end;

procedure TFormS3StoreString.btnDownloadClick(Sender: TObject);
var s3: TAmazonStorageService; strstr: TStringStream;
begin
  s3 := TAmazonStorageService.Create(AmazonConnectionInfo1);
  strstr := TStringStream.Create();
  try
    if s3.GetObject(BUCKET_NAME, OBJ_NAME, strstr) then
      ShowMessage(strstr.DataString)
    else
      ShowMessage('Failed to get object');
  finally
    strstr.Free;
    s3.Free;
  end;
end;

end.
