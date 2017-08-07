object dmNodejs: TdmNodejs
  OldCreateOrder = False
  Height = 420
  Width = 368
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://localhost:3000'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 80
    Top = 58
  end
  object reqList: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'tests'
    Response = resList
    SynchronizedEvents = False
    Left = 80
    Top = 124
  end
  object resList: TRESTResponse
    ContentType = 'text/html'
    Left = 78
    Top = 190
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = memNodeTable
    FieldDefs = <>
    Response = resList
    Left = 80
    Top = 260
  end
  object memNodeTable: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 80
    Top = 328
  end
end
