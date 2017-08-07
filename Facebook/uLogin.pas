unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.WebBrowser, FMX.Layouts;

type
  TWebFormRedirectEvent = procedure(const AURL: string; var DoCloseWebView: Boolean) of object;

  TfrmLogin = class(TForm)
    WebBrowser: TWebBrowser;
    Layout1: TLayout;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure WebBrowserShouldStartLoadWithRequest(ASender: TObject;
      const URL: string);
    procedure WebBrowserDidFinishLoad(ASender: TObject);
  private
    { Private declarations }
    FOnBeforeRedirect: TWebFormRedirectEvent;
  public
    { Public declarations }
    property OnBeforeRedirect: TWebFormRedirectEvent read FOnBeforeRedirect write FOnBeforeRedirect;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmLogin.WebBrowserDidFinishLoad(ASender: TObject);
begin
  Label1.Text := WebBrowser.URL;
end;

procedure TfrmLogin.WebBrowserShouldStartLoadWithRequest(ASender: TObject;
  const URL: string);
var
  CloseWebView: boolean;
begin
  Label1.Text := URL;

  if Assigned(FOnBeforeRedirect) then
  begin
    CloseWebView := False;

    FOnBeforeRedirect(url, CloseWebView);

    if CloseWebView then
      ModalResult := mrOK;
  end;
end;

end.
