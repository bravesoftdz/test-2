unit uSistema;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  FMX.Controls.Presentation, FMX.StdCtrls, REST.Client,
  REST.Authenticator.OAuth, REST.Response.Adapter, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TfrmSistema = class(TForm)
    RESTRequest: TRESTRequest;
    RESTClient: TRESTClient;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    OAuth2_Facebook: TOAuth2Authenticator;
    Button1: TButton;
    procedure RESTRequestAfterExecute(Sender: TCustomRESTRequest);
    procedure RESTRequestHTTPProtocolError(Sender: TCustomRESTRequest);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FFechaForm: Boolean;
  public
    { Public declarations }
  end;

var
  frmSistema: TfrmSistema;

implementation
uses
  uFacebookMain, Rest.json, uShowResult, Rest.Utils;
{$R *.fmx}

procedure TfrmSistema.Button1Click(Sender: TObject);
begin
  RESTRequest.ResetToDefaults;
  RESTClient.ResetToDefaults;
  RESTResponse.ResetToDefaults;
  RESTResponseDataSetAdapter.ResetToDefaults;

  RESTClient.BaseURL := 'https://graph.facebook.com/';
  RESTClient.Authenticator := OAuth2_Facebook;
  RESTRequest.Resource := 'me?fields=picture,id,name,birthday,email,gender,friends.limit(10).fields(name)';
  OAuth2_Facebook.AccessToken := frmFacebookMain.FAccessToken;

  RESTRequest.Execute;
end;

procedure TfrmSistema.RESTRequestAfterExecute(Sender: TCustomRESTRequest);
var
  Msg: string;
begin
  try
    Msg := 'URI ' + Sender.GetFullRequestURL + ' Excution time: ' +
      IntToStr(Sender.ExecutionPerformance.TotalExecutionTime) + 'ms' + #13#10 + #13#10;

    if assigned(RESTResponse.JSONValue) then
      Msg := Msg + TJson.Format(RESTResponse.JSONValue)
    else
      Msg := Msg + RESTResponse.Content;

    frmShowResult := TfrmShowResult.Create(self);
    frmShowResult.Memo1.Text := Msg;
    frmShowResult.ShowModal(
      procedure (ModalResult: TModalResult)
      begin
        frmShowResult.DisposeOf;
      end
    );

  except
    on E: Exception do
      Showmessage(E.Message);
  end;
end;

procedure TfrmSistema.RESTRequestHTTPProtocolError(Sender: TCustomRESTRequest);
begin
  try
    frmShowResult := TfrmShowResult.Create(self);
    frmShowResult.Memo1.Text := '';
    frmShowResult.Memo1.Lines.Add(Sender.Response.StatusText);
    frmShowResult.Memo1.Lines.Add(Sender.Response.content);
    frmShowResult.ShowModal(
      procedure (ModalResult: TModalResult)
      begin
        frmShowResult.DisposeOf;
      end
    );


  except
    on E: Exception do
      Showmessage(E.Message);
  end;
end;

end.
