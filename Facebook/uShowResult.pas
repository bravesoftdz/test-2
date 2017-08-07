unit uShowResult;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Layouts;

type
  TfrmShowResult = class(TForm)
    Memo1: TMemo;
    Layout1: TLayout;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShowResult: TfrmShowResult;

implementation

{$R *.fmx}

procedure TfrmShowResult.Button1Click(Sender: TObject);
begin
  close;
end;

end.
