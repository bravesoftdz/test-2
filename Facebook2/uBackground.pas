unit uBackground;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TfrmBackground = class(TForm)
    recBackground: TRectangle;
    Panel1: TPanel;
    lblCaption: TLabel;
    AniIndicator1: TAniIndicator;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetText(sText: string);
  end;

var
  frmBackground: TfrmBackground;

implementation

{$R *.fmx}

procedure TfrmBackground.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AniIndicator1.Enabled := False;
end;

procedure TfrmBackground.FormShow(Sender: TObject);
begin
  AniIndicator1.Enabled := True;
end;

procedure TfrmBackground.SetText(sText: string);
begin
  lblCaption.Text := sText;
end;

end.
