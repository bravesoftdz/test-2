object dmDatasnap: TdmDatasnap
  OldCreateOrder = False
  Height = 312
  Width = 471
  object SQLCon_DS: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=test.cookplay.net'
      'Port=210'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=19.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Left = 38
    Top = 28
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    SQLConnection = SQLCon_DS
    Left = 148
    Top = 28
  end
  object DSTests: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'skip'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'count'
        ParamType = ptUnknown
      end>
    ProviderName = 'DP_Test'
    RemoteServer = DSProviderConnection1
    Left = 252
    Top = 32
  end
  object DSTestsCount: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'skip'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'count'
        ParamType = ptUnknown
      end>
    ProviderName = 'DP_Test_Count'
    RemoteServer = DSProviderConnection1
    Left = 252
    Top = 96
  end
end
