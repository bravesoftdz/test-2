unit uThread;

interface

uses
  System.Classes, FMX.Graphics;

type
  TLoadImageThread = class(TThread)
    FDir: string;
    FName: string;
    FBitmap: TBitmap;
  protected
    procedure Execute; override;
  public
    constructor Create(Directory, PictureName: string; Bitmap: TBitmap);
  end;

implementation
uses uListBoxMain;
{ TLoadImageThread }

constructor TLoadImageThread.Create(Directory, PictureName: string;
  Bitmap: TBitmap);
begin
  inherited Create(true);

  FDir := Directory;
  FName := PictureName;
  FBitmap := Bitmap;
end;

procedure TLoadImageThread.Execute;
begin
  inherited;

  synchronize(procedure begin FBitmap.Assign(frmListBoxMain.Image1.Bitmap) end);
end;

end.
