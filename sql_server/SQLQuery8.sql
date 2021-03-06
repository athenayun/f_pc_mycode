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
  FROM [MDPOC].[dbo].[GANTRY_DATA]

/*** probably a wrong statement
  
  select *
  from [MDPOC].[dbo].[GANTRY_DATA] A
  where A.Date = '2017-12-31'
  
  ***/

/* testing for SQL , getting out the date in field type datetime2 */
  SELECT DATEADD(month, 1, '20060830');

  use MDPOC;

  select *
  from GANTRY_DATA
  where cast(TransactionTime as date) = '2017-07-15' ;
