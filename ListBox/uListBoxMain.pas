unit uListBoxMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Fmx.Bind.GenData, FMX.ListBox, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, Data.Bind.Components, Data.Bind.ObjectScope, FMX.Layouts,
  FMX.StdCtrls, FMX.Objects, uThread, Data.Bind.GenData, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors;

type
  TCreateType = (ctInsert, ctAdd);
  TfrmListBoxMain = class(TForm)
    ListBox1: TListBox;
    PrototypeBindSource1: TPrototypeBindSource;
    Memo1: TMemo;
    btnAddListBoxItem: TButton;
    btnClearListboxItems: TButton;
    Image1: TImage;
    BindingsList1: TBindingsList;
    ListBoxItem1: TListBoxItem;
    procedure btnAddListBoxItemClick(Sender: TObject);
    procedure btnClearListboxItemsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItem1Tap(Sender: TObject; const Point: TPointF);
  private
    { Private declarations }
    FRecordCount: integer;
    oThread: TLoadImageThread;
    procedure LoadingPriorData(nPos: integer);
    procedure LoadingNextData(nPos: integer);
    procedure MakingItem(ct: TCreateType; nIndex, nCount: integer);
    procedure MyOnPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  public
    { Public declarations }
  end;

const
  cViewCount = 50;

var
  frmListBoxMain: TfrmListBoxMain;

implementation
{$R *.fmx}

procedure TfrmListBoxMain.btnAddListBoxItemClick(Sender: TObject);
var
  i: integer;
  oItem: TListBoxItem;
  photo: TImage;
  txtnum, txtTag: TText;
begin
  ListBox1.BeginUpdate;
  for i := 1 to 300 do
  begin
    oItem := TListBoxItem.Create(ListBox1);
    oItem.StyleLookup := 'listboxitemnodetail';
    oItem.Selectable := False;
    oItem.Height := 135;

    photo := TImage.Create(oItem);
    photo.Parent := oItem;
    photo.Margins.Left := 5;
    photo.Margins.Top := 5;
    photo.Margins.Bottom := 5;
    photo.Position.X := 0;
    photo.Position.Y := 0;
    photo.Width := Image1.Bitmap.Canvas.Width;
    photo.Height := Image1.Bitmap.Canvas.Height;
    photo.HitTest := false;
    photo.Align := TAlignLayout.Left;
    photo.Tag := 0;
    Photo.OnPaint := MyOnPaint;
//    photo.Bitmap.Assign(Image1.Bitmap);

    txtNum := TText.Create(oItem);
    txtNum.Parent := oItem;
    txtNum.Position.X := 200;
    txtNum.Position.Y := 0;
    txtNum.HitTest := false;
    txtNum.Text := i.ToString;
    txtNum.Name := 'text';

    txtTag := TText.Create(oItem);
    txtTag.Parent := oItem;
    txtTag.Position.X := 200;
    txtTag.Position.Y := 50;
    txtTag.HitTest := False;
    txtTag.Text := '0';
    txtTag.Name := 'tag';

    ListBox1.AddObject(oItem);
  end;
  ListBox1.EndUpdate;
end;

procedure TfrmListBoxMain.btnClearListboxItemsClick(Sender: TObject);
begin
//  ListBox1.Items.Clear;
  ListBox1.Clear;
end;

procedure TfrmListBoxMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListBox1.Items.Clear;
end;

procedure TfrmListBoxMain.FormCreate(Sender: TObject);
begin
  FRecordCount := 99998;
  LoadingNextData(0);
end;

procedure TfrmListBoxMain.ListBoxItem1Tap(Sender: TObject;
  const Point: TPointF);
begin
  showmessage('tab');
end;

procedure TfrmListBoxMain.LoadingNextData(nPos: integer);
var
  i: integer;
  oItem: TListBoxItem;
  photo: TImage;
  txtnum, txtTag: TText;
begin

  if nPos >= FRecordCount then
    Exit;

  ListBox1.BeginUpdate;

  for i := 0 to cViewCount-1 do
  begin
    if (nPos + i) < FRecordCount then
      MakingItem(ctAdd, nPos+i, i);
  end;

//  // Delete Prior Items
//  if ListBox1.Items.Count > cViewCount then
//    for i := 0 to cViewCount-1 do
//      ListBox1.Items.Delete(0);

  ListBox1.EndUpdate;
end;

procedure TfrmListBoxMain.LoadingPriorData(nPos: integer);
var
  i: integer;
begin

  if nPos < 0 then
    Exit;

  ListBox1.BeginUpdate;

  for i := 0 to cViewCount-1 do
  begin
    if (nPos + i) < FRecordCount then
      MakingItem(ctInsert, nPos+i, i);
  end;

  // Delete Last Items
  if ListBox1.Items.Count > (cViewCount * 2 -1) then
    for i := 0 to cViewCount-1 do
      ListBox1.Items.Delete(cViewCount);

  ListBox1.EndUpdate;
end;

procedure TfrmListBoxMain.MakingItem(ct: TCreateType; nIndex, nCount: integer);
var
  oItem: TListBoxItem;
  photo: TImage;
  txtnum, txtTag: TText;
begin
  oItem := TListBoxItem.Create(ListBox1);
  oItem.StyleLookup := 'listboxitemnodetail';
  oItem.Selectable := False;
  oItem.Height := 135;
  oItem.OnPaint := MyOnPaint;

  oItem.Tag := nCount;

  photo := TImage.Create(oItem);
  photo.Parent := oItem;
  photo.Margins.Left := 5;
  photo.Margins.Top := 5;
  photo.Margins.Bottom := 5;
  photo.Position.X := 0;
  photo.Position.Y := 0;
  photo.Width := Image1.Bitmap.Canvas.Width;
  photo.Height := Image1.Bitmap.Canvas.Height;
  photo.HitTest := false;
  photo.Align := TAlignLayout.Left;
  photo.Tag := 0;
  photo.Name := 'image';
//    Photo.OnPaint := MyOnPaint;
//    photo.Bitmap.Assign(Image1.Bitmap);

  txtNum := TText.Create(oItem);
  txtNum.Parent := oItem;
  txtNum.Position.X := 200;
  txtNum.Position.Y := 0;
  txtNum.HitTest := false;
  txtNum.Name := 'num';

  txtNum.Tag := nIndex;

  txtNum.Text := txtNum.Tag.ToString;

  txtTag := TText.Create(oItem);
  txtTag.Parent := oItem;
  txtTag.Position.X := 200;
  txtTag.Position.Y := 50;
  txtTag.HitTest := False;
  txtTag.Text := '0';
  txtTag.Name := 'tag';

  if ct = ctInsert then
    ListBox1.InsertObject(0, oItem)
  else
    ListBox1.AddObject(oItem);
end;

procedure TfrmListBoxMain.MyOnPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  oItem: TListBoxItem;
  oImage: TImage;
  oNum: TText;
  oTag: TText;
begin
  oItem := (Sender as TListBoxItem);
  oImage := oItem.FindComponent('image') as TImage;
  oNum := oItem.FindComponent('num') as TText;
  oTag := oItem.FindComponent('tag') as TText;

  caption := oItem.Tag.ToString + ' / ' + oNum.Tag.ToString;
//  caption := oItem.Tag.ToString + ' / ' + ListBox1.ItemByIndex(ListBox1.Items.Count-1).tag.tostring;

  if (oItem.tag = 0) and (ListBox1.ItemByIndex(0) <> oItem) then
    LoadingPriorData(oItem.Tag - 1)
  else if (oItem.Tag = cViewCount-1) and (ListBox1.ItemByIndex(ListBox1.Items.Count-1) <> oItem) then
    LoadingNextData(oItem.Tag + 1);

  if oImage.tag = 0 then
  begin
    oImage.Tag := oImage.Tag + 1;

    oTag.Text := oTag.Tag.ToString;

//    (Sender as TImage).Tag := 1;
    TThread.Synchronize(nil, procedure begin oImage.Bitmap.Assign(Image1.Bitmap) end);

//    oThread := TLoadImageThread.Create('c:', '', (Sender as TImage).Bitmap);
//    oThread.Start;
//    (Sender as TImage).Bitmap.Assign(Image1.Bitmap);
  end;
end;

end.
