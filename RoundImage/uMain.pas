unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Math,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Styles.Objects,
  FMX.Layouts, FMX.ExtCtrls, FMX.Ani;

type
  TForm18 = class(TForm)
    Button1: TButton;
    Circle1: TCircle;
    RoundRect1: TRoundRect;
    Pie1: TPie;
    CalloutRectangle1: TCalloutRectangle;
    Rectangle1: TRectangle;
    Button2: TButton;
    Image1: TImage;
    Rectangle2: TRectangle;
    procedure Button1Click(Sender: TObject);
    procedure RoundRect1Paint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    oRectangle: TRectangle;
  public
    { Public declarations }
  end;

var
  Form18: TForm18;

implementation

{$R *.fmx}

procedure TForm18.Button1Click(Sender: TObject);
begin
  Circle1.Fill.Bitmap.Bitmap := Image1.Bitmap;
  RoundRect1.Fill.Bitmap.Bitmap := Image1.Bitmap;
  Pie1.Fill.Bitmap.Bitmap := Image1.Bitmap;

  rectangle2.Fill.Bitmap.bitmap := Image1.Bitmap;
end;

procedure TForm18.Button2Click(Sender: TObject);
var
  sorRec, tarRec: TRectF;
  oImage: TImage;
  oBitmap: TBitmap;
begin
  oImage := TImage.Create(self);
  oBitmap := TBitmap.Create;

  oRectangle := TRectangle.Create(self);
  oRectangle.Parent := self;
  oRectangle.Position.X := 100;
  oRectangle.Position.Y := 100;
  oRectangle.Width := 300;
  oRectangle.Height := 200;
  oRectangle.XRadius := 10;
  oRectangle.YRadius := 10;
  oRectangle.Stroke.Kind := TBrushKind.None;
  oRectangle.Fill.Kind := TBrushKind.Bitmap;
  oRectangle.Fill.Bitmap.WrapMode := TWrapMode.TileOriginal;

//  oRectangle.Fill.Bitmap.Bitmap := Image1.Bitmap.CreateThumbnail(Image1.Bitmap.width div 2,Image1.Bitmap.Height div 2);
  oRectangle.Fill.Bitmap.Bitmap.Width := 300;
  oRectangle.Fill.Bitmap.Bitmap.Height := 200;
  oRectangle.Fill.Bitmap.Bitmap.CopyFromBitmap(Image1.Bitmap, Rect(200,200,500,400), 1, 1);
  oRectangle.Fill.Bitmap.Bitmap.SaveToFile('c:\temp\a.jpg');
//  oRectangle.Fill.Bitmap.Bitmap := Image1.Bitmap;




//    oRectangle.Fill.Bitmap.Bitmap.Canvas.BeginScene();
//  oRectangle.Fill.Bitmap.Bitmap.Canvas.DrawBitmap(Image1.Bitmap, RectF(0,0,400,300), RectF(0,0,400,300), 1, false);
//  oRectangle.Fill.Bitmap.Bitmap.Canvas.EndScene();
//
//  oRectangle.Fill.Bitmap.Bitmap.Assign(Image1.Bitmap);

end;

procedure TForm18.RoundRect1Paint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
//  Canvas.DrawRect(ARect, 10, 10, AllCorners, 1, TCornerType.Round);
//  Canvas.FillRect(ARect, 10, 10, AllCorners, 1, TCornerType.Round);
//  Canvas.fil


end;

end.
