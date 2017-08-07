unit uFacebookMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit, REST.utils, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP;

type
  TmySimpleClass = class

  end;
  TfrmFacebookMain = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    NetHTTPClient1: TNetHTTPClient;
    IdHTTP1: TIdHTTP;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    procedure Facebook_AccessTokenRedirect(const AURL: string; var DoCloseWebView: boolean);
  public
    { Public declarations }
    FAccessToken: string;
  end;

var
  frmFacebookMain: TfrmFacebookMain;

implementation
uses uLogin, uSistema;
{$R *.fmx}

procedure TfrmFacebookMain.Button1Click(Sender: TObject);
begin
  if (Edit1.Text = 'anderson') and (Edit2.Text = 'admin') then
    ShowMessage('Login authorized')
  else
    ShowMessage('Invalid');
end;

procedure TfrmFacebookMain.Button2Click(Sender: TObject);
var
  LURL: string;
  FormLogin: TfrmLogin;
begin
  try
    FAccessToken := '';

//    LURL := 'https://www.facebook.com/dialog/oauth'
    LURL := 'https://www.facebook.com/v2.10/dialog/oauth'
          + '?client_id=' + URIEncode( '342699346162649' )
          + '&response_type=token'
          + '&scope=' + URIEncode('user_about_me,email,user_birthday,user_friends')
          + '&redirect_uri=' + URIEncode('https://www.facebook.com/connect/login_success.html');

    FormLogin := TfrmLogin.Create(nil);
    FormLogin.OnBeforeRedirect := Facebook_AccessTokenRedirect;
    FormLogin.WebBrowser.Navigate(LURL);
//
    FormLogin.ShowModal(
      procedure(ModelResult: TModalResult)
      begin
        if FAccessToken <> '' then
        begin
          frmSistema := TfrmSistema.Create(nil);
          frmSistema.Show;
        end;
      end
    );
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

end;

procedure TfrmFacebookMain.Button3Click(Sender: TObject);
var
  ImgStream: TStringStream;
begin
  ImgStream := TStringStream.Create;
  NetHTTPClient1.Get('https://s3.ap-northeast-2.amazonaws.com/delphitest1/test4.jpg', ImgStream);

end;

procedure TfrmFacebookMain.Facebook_AccessTokenRedirect(const AURL: string;
  var DoCloseWebView: boolean);
var
  LATPos: integer;
  LToken: string;
begin
  try
    LATPos := Pos('access_token=', AURL);

    if (LATPos > 0) then
    begin
      LToken := copy(AURL, LATPos + 13, Length(AURL));

      if (Pos('&', LToken) > 0) then
        LToken := copy(LToken, 1, Pos('&', LToken) - 1);

      FAccessToken := LToken;
      if (LToken <> '') then
        DoCloseWebView := True;
    end
    else
    begin
      LATPos := Pos('access_denied', AURL);

      if LATPos > 0 then
      begin
        FAccessToken := '';
        DoCloseWebView := True;
      end;
    end;

  except
    on E:Exception do
      ShowMessage(E.Message);

  end;

end;

end.
