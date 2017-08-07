unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, FMX.WebBrowser, REST.utils, FMX.ScrollBox,
  FMX.Memo;

type
  TfrmMain = class(TForm)
    btnFacebook: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure btnFacebookClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowInfo;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses uFacebook;
{$R *.fmx}

procedure TfrmMain.btnFacebookClick(Sender: TObject);
var
  LURL: string;
begin
  try
    // Token 가져오기
    frmFacebook.ShowModal(
      procedure(ModalResult: TModalResult)
      begin
        case ModalResult of
          mrOK: ShowInfo;
          mrAbort: showmessage('Facebook 연결에 실패하였습니다!');
        end;
      end
    );
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmMain.ShowInfo;
begin
  if frmFacebook.oUser.id <> '' then
  begin
    memo1.Lines.Add(frmFacebook.AccessToken);
    memo1.Lines.Add(frmFacebook.oUser.id);
    memo1.Lines.Add(frmFacebook.oUser.name);
    memo1.Lines.Add(frmFacebook.oUser.gender);
    memo1.Lines.Add(frmFacebook.oUser.birthday);
    memo1.Lines.Add(frmFacebook.oUser.email);
    memo1.Lines.Add(frmFacebook.oUser.picture);
  end;
end;

end.
