unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Colors, FMX.Layouts;

type
  TmyUI = record
    StatusBar, NavBar: Integer;
    class function ContentColor: TAlphaColor; static;
  end;

  TForm28 = class(TForm)
    Rectangle1: TRectangle;
    Button1: TButton;
    ColorBox1: TColorBox;
    Button2: TButton;
    ColorPanel1: TColorPanel;
    Label1: TLabel;
    Image1: TImage;
    Layout1: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ColorPanel1Change(Sender: TObject);
  private
    { Private declarations }
    function GetColor(color: TAlphaColor): TAlphaColor;
  public
    { Public declarations }
  end;

var
  Form28: TForm28;
  myUI: TMyUI;

implementation
uses cookplay.StatusBar;
{$R *.fmx}

procedure TForm28.Button1Click(Sender: TObject);
begin
  StatusBarSetColor(Rectangle1.Fill.Color);
end;

procedure TForm28.Button2Click(Sender: TObject);
begin
  showmessage(myUI.StatusBar.ToString + ' / ' + myUI.NavBar.ToString);
end;

procedure TForm28.ColorPanel1Change(Sender: TObject);
var
  oC: TAlphaColor;
begin
  oC := ColorPanel1.Color;
  Label1.Text := TAlphaColorRec(oC).R.ToString + ', ' + TAlphaColorRec(oC).G.ToString + ', ' +TAlphaColorRec(oC).B.ToString;

  Fill.Kind := TBrushKind.Solid; // режи?покраски форм?
  Fill.Color := GetColor(oC);

//  StatusBarSetColor(Fill.Color);
end;

procedure TForm28.FormActivate(Sender: TObject);
begin
//  Fill.Kind := TBrushKind.Solid; // режи?покраски форм?
//  Fill.Color := myUI.ContentColor; // задаем цвет для всей форм?
//{$IFDEF IOS} StatusBarSetColor(Fill.Color); {$ENDIF} // смен?цвет??run-time  для IOS
end;

procedure TForm28.FormCreate(Sender: TObject);
begin
//  StatusBar.Canvas.Brush.Color := clBlue;
end;

procedure TForm28.FormShow(Sender: TObject);
begin
//  FormActivate(nil);
//  StatusBarGetBounds(myUI.StatusBar, myUI.NavBar); // получаем отступ?
//
  Fill.Kind := TBrushKind.Solid;
  Fill.Color := myUI.ContentColor;

  StatusBarSetColor(GetColor(myUI.ContentColor));
//  StatusBarSetColor(Fill.Color);
end;

function TForm28.GetColor(color: TAlphaColor): TAlphaColor;
begin
  TAlphaColorRec(Result).R := TAlphaColorRec(color).R;
  TAlphaColorRec(Result).G := TAlphaColorRec(color).G;
  TAlphaColorRec(Result).B := TAlphaColorRec(color).B;
  TAlphaColorRec(Result).A := 0;
end;

{ TmyUI }

class function TmyUI.ContentColor: TAlphaColor;
begin
  TAlphaColorRec(Result).R := 255;
  TAlphaColorRec(Result).G := 117;
  TAlphaColorRec(Result).B := 0;
  TAlphaColorRec(Result).A := 0;
end;

end.
