object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 285
  Width = 352
  object FDConn: TFDConnection
    Params.Strings = (
      'User_Name=marcelo'
      'Password=123'
      'Database=XE'
      'DriverID=Ora')
    FetchOptions.AssignedValues = [evUnidirectional, evCursorKind, evAutoFetchAll, evDetailOptimize]
    FetchOptions.CursorKind = ckDefault
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrAppWait
    Left = 48
    Top = 88
  end
  object FDPhysOracleDriverLink1: TFDPhysOracleDriverLink
    Left = 48
    Top = 160
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 200
    Top = 160
  end
end
