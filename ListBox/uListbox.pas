unit uListbox;

interface

uses FMX.ListBox, FMX.Dialogs, System.Types, FMX.Graphics, System.Classes,
     FMX.Objects;

type
  TMyListBox = class(TListBox)
  private
    FPageSize: integer;
    FMaxRecordCount: integer;

    FOnGetItems: TNotifyEvent;
    FOnDeleteLastItems: TNotifyEvent;
  public
    Bitmap: TBitmap;
    function GetLastIndex: integer;
    function GetLastItem: TListBoxItem;
    function GetTopItemIndex: integer;
    function GetItemsCount: integer;
    function GetViewPortSize: Single;
    function GetLastItemsHeight: Single;
    function GetFirstItemIndex: Single;
    procedure Init(nViewRange, nRecordCount: integer);
    procedure AddItem(AItem: TListBoxItem);
    procedure HideTopItem;
    procedure ClearAllItems;
    procedure OnMyViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
  published
    property PageSize: integer read FPageSize write FPageSize;
    property MaxValue: integer read FMaxRecordCount write FMaxRecordCount;
//    property FirstNo: integer read FTopNo;
    property LastNo: integer read GetLastIndex;
    property OnGetItems: TNotifyEvent read FOnGetItems write FOnGetItems;
    property OnDeleteLastItems: TNotifyEvent read FOnDeleteLastItems write FOnDeleteLastItems;
  end;

const
  cDirectItemHeight = 30;

implementation
{ TMyListBox }

procedure TMyListBox.AddItem(AItem: TListBoxItem);
begin
  self.AddObject(AItem);

  AItem.tag := GetLastIndex + 1;
end;

procedure TMyListBox.ClearAllItems;
begin
  self.BeginUpdate;
  self.ViewportPosition := PointF(0, 0);
  self.Clear;
  self.EndUpdate;

  Init(FPageSize, FMaxRecordCount);
end;

function TMyListBox.GetLastItem: TListBoxItem;
begin
  if GetItemsCount > 0 then
    result := self.ListItems[GetItemsCount-1]
  else
    result := nil;
end;

function TMyListBox.GetLastItemsHeight: Single;
var
  i: integer;
begin
  result := 0;
  if GetItemsCount >= FPageSize then
    for i := 1 to FPageSize do
      result := result + self.ListItems[GetItemsCount - i].Height;
end;

function TMyListBox.GetLastIndex: integer;
begin
//  result := FTopNo + GetItemsCount - 1;
  result := GetItemsCount - 1;
end;

function TMyListBox.GetTopItemIndex: integer;
var
  i: integer;
  Point: TPointF;
begin
  result := 0;

  for i := 1 to GetItemsCount do
  begin
    Point.X := 0;
    Point.Y := self.ViewportPosition.Y - ListItems[i-1].Position.Y;
    if self.ListItems[i-1].PointInObjectLocal(Point.X, Point.Y) then
    begin
      result := i-1;
      break;
    end;
  end;
end;

function TMyListBox.GetViewPortSize: Single;
var
  oItem: TListBoxItem;
begin
  if GetItemsCount <= 0 then
    result := 0
  else
  begin
    oItem := self.ListItems[GetItemsCount-1];
    result := oItem.Position.Y + oItem.Height - 1;
  end;
end;

procedure TMyListBox.HideTopItem;
var
  h: integer;
begin
  h := cDirectItemHeight - Round(self.ViewPortPosition.Y);

  if (h > 0) and (h <= cDirectItemHeight)  then
    self.ViewPortPosition := PointF(0, self.ViewPortPosition.Y + h);
end;

procedure TMyListBox.Init(nViewRange, nRecordCount: integer);
begin
  self.OnViewportPositionChange := OnMyViewportPositionChange;

  FPageSize := nViewRange;
  FMaxRecordCount := nRecordCount;
end;

function TMyListBox.GetFirstItemIndex: Single;
begin
  result := 0;

  if GetItemsCount > 0 then
    result := self.ItemByPoint(10,10).index;
end;

function TMyListBox.GetItemsCount: integer;
begin
  result := self.items.Count;
end;

procedure TMyListBox.OnMyViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin
  if GetItemsCount > 0 then
  begin
    if (NewViewPortPosition.Y = 0) and (NewViewPortPosition.Y <> OldViewPortPosition.Y) then
    begin
      if (GetItemsCount > FPageSize*2) then
      begin
        ClearAllItems;
        if Assigned(FOnGetItems) then
          FOnGetItems(self);
      end;
    end
    else if (NewViewPortPosition.Y + self.Height) > self.ListItems[GetItemsCount-1].Position.Y then
    if (NewViewPortPosition.Y + self.Height) > self.ListItems[GetItemsCount-1].Position.Y then
    begin
      if Assigned(FOnGetItems) then
        FOnGetItems(self);
    end
//    else if (NewViewPortPosition.Y < OldViewPortPosition.Y) and ((GetTopItemIndex + FPageSize) < GetItemsCount)  then
//      self.items.Delete(GetLastIndex);
  end;
end;

end.
