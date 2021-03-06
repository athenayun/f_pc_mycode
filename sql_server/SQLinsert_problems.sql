/****** SSMS 中 SelectTopNRows 命令的指令碼  ******/
SELECT TOP 1000 [MDSequenceNum]
      ,[LPRNumber1]
      ,[LPRNumber2]
      ,[AVEID]
      ,[DetectionTime]
      ,[LaneSystemID]
      ,[LaneNr]
      ,[Violation]
      ,[Category]
      ,[SpeedIndication]
      ,[TransactionTime]
      ,[TagArriveTime]
      ,[TagDepartTime]
      ,[TransactionResult]
      ,[ReaderSN]
      ,[AuditRecord]
      ,[EPCID]
      ,[VehicleDeviceCategory]
      ,[ETagRSSIValue]
      ,[RFKeysetVersion]
      ,[Repeat]
      ,[TID]
      ,[UserData2]
      ,[UserData3]
      ,[PictureTime]
      ,[KeepImageList]
      ,[MAC]
      ,[eTagLPRNumber]
      ,[StChargeFlag]
      ,[DecompositionFlag]
      ,[DeviceCategory]
      ,[DeviceStatus]
      ,[DeviceStatusCode]
      ,[Sender]
      ,[CheckCode]
      ,[DeviceServiceStatus]
      ,[DeviceVCID]
      ,[DeviceIdentity]
      ,[FreewayNo]
      ,[FreewayType]
      ,[FreewayKM]
      ,[FreewayDirection]
      ,[ImageRegetReturned]
      ,[OfflineTrans]
      ,[OcrSendFlag]
      ,[ViolationOrgn]
      ,[TransactionTimeOrgn]
      ,[ProcessedTime]
      ,[CreateId]
      ,[CreateDttm]
      ,[ModifyId]
      ,[ModifyDttm]
  FROM [athena_practice].[dbo].[GantryData_20171115]

  select *  from [athena_practice].[dbo].[GantryData_20171115]  ;
  select * from [athena_practice].[dbo].[GantryData_20171115] limit 787131 ;

  select Top 7878131 * from [athena_practice].[dbo].[GantryData_20171115] order by MDSequenceNum ;
  select * from [athena_practice].[dbo].[GantryData_20171115] offset 7878131 fetch next rows 7878132 only ;
  
  SELECT * FROM ( SELECT *, ROW_NUMBER() OVER (ORDER BY MDSequenceNum) as row FROM dbo.GantryData_20171115 ) a WHERE row > 7878131 ;

SELECT *
FROM [athena_practice].[dbo].[GantryData_20171115]
ORDER BY MDSequenceNum
OFFSET 14180634 rows
FETCH NEXT 1575629 ROWS ONLY;
GO




  exec sp_help GantryData_20171115;
  use athena_practice;
  GO

  BCP "select * from [athena_practice].[dbo].[GantryData_20171115] " out "C:\Users\Administrator\Documents\code\data\gantry_data\data01_20171115.csv" -c ;