unit uDatasnap;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Data.SqlExpr;

type
  TdmDatasnap = class(TDataModule)
    SQLCon_DS: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    DSTests: TClientDataSet;
    DSTestsCount: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDatasnap: TdmDatasnap;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
