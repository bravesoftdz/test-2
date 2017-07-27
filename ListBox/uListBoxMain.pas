unit uListBoxMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Fmx.Bind.GenData, FMX.ListBox, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, Data.Bind.Components, Data.Bind.ObjectScope, FMX.Layouts,
  FMX.StdCtrls, FMX.Objects, uThread, Data.Bind.GenData, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  FMX.TabControl, uListBox, FMX.Edit, FMX.EditBox, FMX.NumberBox,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Actions, FMX.ActnList, FMX.Gestures, Data.Cloud.CloudAPI,
  Data.Cloud.AmazonAPI;

type
  TCreateType = (ctInsert, ctAdd);
  TfrmListBoxMain = class(TForm)
    PrototypeBindSource1: TPrototypeBindSource;
    Memo1: TMemo;
    Image1: TImage;
    BindingsList1: TBindingsList;
    TabControl1: TTabControl;
    TabItem4: TTabItem;
    btnAddItems: TButton;
    TabItem1: TTabItem;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    Action1: TAction;
    Button1: TButton;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    AmazonConnectionInfo1: TAmazonConnectionInfo;
    btnUpload: TButton;
    btnDownload: TButton;
    Edit1: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnAddItemsClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
  private
    { Private declarations }
    MyListBox: TMyListBox;
    oThread: TLoadImageThread;
    function CreateMyListboxItem: TListBoxItem;
    procedure myOnPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure myGetItems(Sender: TObject);
    procedure myDeleteLastItems(Sender: TObject);
  public
    { Public declarations }
  end;

const
  cViewSize = 20;
  cViewMaxSize = 10000;
  cBUCKET_NAME = 'cookplay-test';
  cOBJ_NAME = 'testobj';


var
  frmListBoxMain: TfrmListBoxMain;

implementation
{$R *.fmx}

procedure TfrmListBoxMain.Action1Execute(Sender: TObject);
begin
  caption := 'up';
end;

procedure TfrmListBoxMain.Button1Click(Sender: TObject);
begin
//  showmessage(myListBox.ListItems[0].Position.y.tostring);
  showmessage(myListBox.GetTopItemIndex.ToString);
//  showmessage(myListbox.ItemIndex.ToString);
//  showmessage(myListbox.ItemByPoint(10, 10).Index.tostring);
//  myListBox.ClearAllItems;
//  btnAddItems.OnClick(btnAddItems);
end;

procedure TfrmListBoxMain.btnAddItemsClick(Sender: TObject);
var
  i: integer;
begin
  myListBox.BeginUpdate;
  for i := 1 to cViewSize do
    if (myListbox.GetItemsCount + i) <= myListBox.MaxValue then
      myListBox.AddItem(CreateMyListboxItem);
  myListbox.EndUpdate;
end;

procedure TfrmListBoxMain.btnUploadClick(Sender: TObject);
var
  s3: TAmazonStorageService;
  strstr: TSTringStream;
begin
  s3 := TAmazonStorageService.Create(AmazonConnectionInfo1);
  strstr := TStringStream.Create(edit1.text);

  try
    if s3.UploadObject(cBUCKET_NAME, cOBJ_NAME, strstr.bytes) then
      ShowMessage('upload OK')
    else
      ShowMessage('Upload Error!');
  finally
    strstr.Free;
    s3.Free;
  end;

end;

procedure TfrmListBoxMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TfrmListBoxMain.FormCreate(Sender: TObject);
begin
  myListBox := TMyListBox.Create(self);
  myListBox.Parent := TabItem4;
  myListBox.Width := 200;
  myListBox.Align := TAlignLayout.Left;
  myListBox.OnGetItems := myGetItems;
  myListbox.OnDeleteLastItems := myDeleteLastItems;
  myListBox.ShowScrollBars := False;

  myListBox.Init(cViewSize, cViewMaxSize);
end;

procedure TfrmListBoxMain.myDeleteLastItems(Sender: TObject);
begin
  showmessage('delete last items');
end;

procedure TfrmListBoxMain.myGetItems(Sender: TObject);
begin
  btnAddItems.OnClick(btnAddItems);
end;

procedure TfrmListBoxMain.myOnPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  oItem: TListboxItem;
  oImage: TImage;
  oNum: TText;
  i: integer;
  direct: integer;

begin
  oItem := (Sender as TListBoxItem);
  oImage := oItem.FindComponent('image') as TImage;
  oNum := oItem.FindComponent('num') as TText;

  if oImage.Tag = 0 then
  begin
    TThread.Synchronize(nil, procedure begin
      oImage.Tag := 1;

      oNum.Text := oItem.tag.ToString;
      oImage.Bitmap.Assign(Image1.Bitmap);
    end);
  end;
end;

function TfrmListBoxMain.CreateMyListboxItem: TListBoxItem;
var
  oItem: TListBoxItem;
  photo: TImage;
  txtnum, txtTag: TText;
begin
  oItem := TListBoxItem.Create(MyListBox);
  oItem.StyleLookup := 'listboxitemnodetail';
  oItem.Selectable := False;
  oItem.Height := 150;
  oItem.OnPaint := myOnPaint;

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

  txtNum := TText.Create(oItem);
  txtNum.Parent := oItem;
  txtNum.Position.X := 100;
  txtNum.Position.Y := 0;
  txtNum.HitTest := false;
  txtNum.Name := 'num';

  txtNum.Text := txtNum.Tag.ToString;

  txtTag := TText.Create(oItem);
  txtTag.Parent := oItem;
  txtTag.Position.X := 100;
  txtTag.Position.Y := 50;
  txtTag.HitTest := False;
  txtTag.Text := '0';
  txtTag.Name := 'tag';

  result := oItem;
end;

end.
