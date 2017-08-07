unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.TabControl, System.Rtti,
  FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, FMX.StdCtrls, IPPeerClient, REST.Response.Adapter, REST.Client,
  Data.Bind.ObjectScope, FMX.Edit;

type
  TForm19 = class(TForm)
    FDConnection1: TFDConnection;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    DataSource1: TDataSource;
    Grid1: TGrid;
    BindingsList1: TBindingsList;
    btnAdd100Rows: TButton;
    Grid2: TGrid;
    TabItem4: TTabItem;
    btnDataLoadfromNodejs: TButton;
    Button1: TButton;
    btnLoadFromDatasnap: TButton;
    Grid3: TGrid;
    FDQuery1: TFDQuery;
    Button2: TButton;
    DataSource2: TDataSource;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    edtSkip: TEdit;
    edtCount: TEdit;
    Label1: TLabel;
    procedure btnAdd100RowsClick(Sender: TObject);
    procedure btnDataLoadfromNodejsClick(Sender: TObject);
    procedure btnLoadFromDatasnapClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    function Gettime(aDateTime: TDatetime): string;
  public
    { Public declarations }
  end;

var
  Form19: TForm19;

implementation
uses uNodejs, uDatasnap;

{$R *.fmx}

procedure TForm19.btnAdd100RowsClick(Sender: TObject);
var
  i: integer;
begin
//  FDTable1.DisableControls;
//
//  for i := 1 to 10000 do
//  begin
//    FDTable1.Append;
//    FDTable1.FieldByName('Title').AsString := 'Test Row '+ FormatDateTime('YYYY-MM-DD hh:mm:ss.zzz', now);
//    FDTable1.FieldByName('Picture').AsString := 'choi82.jpg';
//    FDTable1.FieldByName('Thumbnail').AsString := 'girl.jpg';
//    FDTable1.FieldByName('CreatedDateTime').AsString := FormatDateTime('YYYY-MM-DD hh:mm:ss.zzz', now);
//    FDTable1.Post;
//  end;
//
//  FDTable1.EnableControls;
end;

procedure TForm19.btnDataLoadfromNodejsClick(Sender: TObject);
var
  aStartTime, aEndTime, aDurTime: string;
  tStartTime, tEndTime, tDurTime: TDateTime;
  i: integer;
begin
  tStartTime := now;

  dmNodejs.reqList.Execute;


  tEndTime := now;
  tDurTime := tEndTime - tStartTime;

  aStartTime := GetTime(tStartTime);
  aEndTime := GetTime(tEndTime);
  aDurTime := GetTime(tDurTime);

  showmessage('시작시간: ' + aSTartTime + #13#10 +
              '종료시간: ' + aEndTime + #13#10 +
              '소요시간: ' + aDurTime);

end;

procedure TForm19.btnLoadFromDatasnapClick(Sender: TObject);
var
  aStartTime, aEndTime, aDurTime: string;
  tStartTime, tEndTime, tDurTime: TDateTime;

  i: integer;
begin
  dmDatasnap.SQLCon_DS.Connected := False;
  dmDatasnap.DSTestsCount.Close;
  dmDatasnap.DSTests.Close;
  tStartTime := now;

  try
    dmDatasnap.SQLCon_DS.Connected := True;
    dmDatasnap.DSTests.ParamByName('skip').Value := edtSkip.text.ToInteger;
    dmDatasnap.DSTests.ParamByName('count').Value := edtCount.text.ToInteger;

    dmDatasnap.DSTests.Open;

    dmDatasnap.DSTestsCount.Open;
    label1.Text := 'record count = ' + dmDatasnap.DSTestsCount.FieldByName('cnt').AsString + '  / maxno = ' + dmDatasnap.DSTestsCount.FieldByName('maxno').Asstring;
//    dmDatasnap.DSTests.Refresh;
  except
    showmessage('a');
  end;

  if dmDatasnap.SQLCon_DS.Connected then
    dmDatasnap.SQLCon_DS.Connected := False;

  tEndTime := now;
  tDurTime := tEndTime - tStartTime;

  aStartTime := GetTime(tStartTime);
  aEndTime := GetTime(tEndTime);
  aDurTime := GetTime(tDurTime);

  showmessage('시작시간: ' + aSTartTime + #13#10 +
              '종료시간: ' + aEndTime + #13#10 +
              '소요시간: ' + aDurTime);
end;

procedure TForm19.Button2Click(Sender: TObject);
begin
  FDQuery1.close;

  FDQuery1.Open;
end;

function TForm19.Gettime(aDateTime: TDatetime): string;
var
  aHour, aMinute, aSecond, aMSecond: WORD;
begin
  result := FormatDateTime('HH:NN:SS ZZZ', aDateTime);
//  DecodeTime(aDataTime, aHour, aMinute, aSecond, aMSecond);
//  result := aHour.ToString + ':' + aMinute.ToString + ':'
end;

end.
