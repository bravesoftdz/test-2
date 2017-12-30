unit uButtonMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts;

type
  TForm25 = class(TForm)
    Layout1: TLayout;
    Rectangle2: TRectangle;
    txtZ: TText;
    Layout2: TLayout;
    Rectangle3: TRectangle;
    txtA: TText;
    txtB: TText;
    procedure txtAClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form25: TForm25;

implementation

{$R *.fmx}

procedure TForm25.txtAClick(Sender: TObject);
begin
  if (Sender = txtA) then
  begin
    txtZ.Text := txtA.Text;
    Layout1.Position.X := txtA.Position.X;
  end
  else
  begin
    txtZ.Text := txtB.Text;
    Layout1.Position.X := txtB.Position.X;
  end;
end;

end.
