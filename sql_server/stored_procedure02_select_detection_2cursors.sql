SET NOCOUNT ON;

DECLARE @MDSequenceNum varchar(100),
		@LPRNumber1 nvarchar(100),
		@LPRNumber2 nvarchar(100),
		@AVEID varchar(19),
		@DetectionTime datetime2,
		@LaneSystemID varchar(10),
		@LaneNr numeric,
		@Violation numeric,
		@Category numeric,
		@SpeedIndication numeric,
		@TransactionTime datetime2,
		@TagArriveTime datetime2,
		@TagDepartTime datetime2,
		@TransactionResult varchar(30),
		@ReaderSN varchar(16),
		@AuditRecord varchar(20),
		@EPCID varchar(50),
		@VehicleDeviceCategory varchar(2),
		@ETagRSSIValue numeric,
		@RFKeysetVersion varchar(20),
		@Repeat_ varchar(10),
		@TID varchar(30),
		@UserData2 varchar(20),
		@UserData3 varchar(20),
		@PictureTime datetime2,
		@KeepImageList varchar(5),
		@MAC varchar(50),
		@eTagLPRNumber nvarchar(100),
		@StChargeFlag char(1),
		@DecompositionFlag char(1),
		@DeviceCategory varchar(5),
		@DeviceStatus char(5),
		@DeviceStatusCode char(5),
		@Sender char(5),
		@CheckCode varchar(40),
		@DeviceServiceStatus char(5),
		@DeviceVCID varchar(5),
		@DeviceIdentity char(5),
		@FreewayNo char(5),
		@FreewayType char(5),
		@FreewayKM numeric,
		@FreewayDirection char(5),
		@ImageRegetReturned char(5),
		@OfflineTrans char(5),
		@OcrSendFlag char(5),
		@ViolationOrgn numeric,
		@TransactionTimeOrgn datetime2,
		@ProcessedTime datetime2,
		@CreateId varchar(30),
		@CreateDttm datetime2,
		@ModifyId varchar(30),
		@ModifyDttm datetime2 ;

--  the Table Variable replaces #Temp2 in the original query
DECLARE @Output TABLE (
					MDSequenceNum varchar(100),
					LPRNumber1 nvarchar(100),
					LPRNumber2 nvarchar(100),
					AVEID varchar(19),
					DetectionTime datetime2,
					LaneSystemID varchar(10),
					LaneNr numeric,
					Violation numeric,
					Category numeric,
					SpeedIndication numeric,
					TransactionTime datetime2,
					TagArriveTime datetime2,
					TagDepartTime datetime2,
					TransactionResult varchar(30),
					ReaderSN varchar(16),
					AuditRecord varchar(20),
					EPCID varchar(50),
					VehicleDeviceCategory varchar(2),
					ETagRSSIValue numeric,
					RFKeysetVersion varchar(20),
					Repeat_ varchar(10),
					TID varchar(30),
					UserData2 varchar(20),
					UserData3 varchar(20),
					PictureTime datetime2,
					KeepImageList varchar(5),
					MAC varchar(50),
					eTagLPRNumber nvarchar(100),
					StChargeFlag char(1),
					DecompositionFlag char(1),
					DeviceCategory varchar(5),
					DeviceStatus char(5),
					DeviceStatusCode char(5),
					Sender char(5),
					CheckCode varchar(40),
					DeviceServiceStatus char(5),
					DeviceVCID varchar(5),
					DeviceIdentity char(5),
					FreewayNo char(5),
					FreewayType char(5),
					FreewayKM numeric,
					FreewayDirection char(5),
					ImageRegetReturned char(5),
					OfflineTrans char(5),
					OcrSendFlag char(5),
					ViolationOrgn numeric,
					TransactionTimeOrgn datetime2,
					ProcessedTime datetime2,
					CreateId varchar(30),
					CreateDttm datetime2,
					ModifyId varchar(30),
					ModifyDttm datetime2
					) ;

declare @i varchar(100)

declare cursor_1 cursor for	(	select MDSequenceNum 
								from [athena_practice].[dbo].[GantryData_20171115] 
								where MDSequenceNum like '%e_0' escape 'e' )


open cursor_1
fetch next from cursor_1 into @i
while @@FETCH_STATUS = 0
begin
	
	DECLARE cursor_2 CURSOR STATIC LOCAL READ_ONLY FORWARD_ONLY
	FOR (	select *
			from [athena_practice].[dbo].[GantryData_20171115]
			where MDSequenceNum = left( @i ,CHARINDEX('_', @i )-1));
	OPEN cursor_2
	FETCH NEXT FROM cursor_2
	INTO  @MDSequenceNum, @LPRNumber1, @LPRNumber2, @AVEID, @DetectionTime, @LaneSystemID, @LaneNr, @Violation, @Category, @SpeedIndication,
		@TransactionTime, @TagArriveTime, @TagDepartTime, @TransactionResult, @ReaderSN, @AuditRecord, @EPCID, @VehicleDeviceCategory,
		@ETagRSSIValue, @RFKeysetVersion, @Repeat_, @TID, @UserData2, @UserData3, @PictureTime, @KeepImageList, @MAC, @eTagLPRNumber,
		@StChargeFlag, @DecompositionFlag, @DeviceCategory, @DeviceStatus, @DeviceStatusCode, @Sender, @CheckCode, @DeviceServiceStatus,
		@DeviceVCID, @DeviceIdentity, @FreewayNo, @FreewayType, @FreewayKM, @FreewayDirection, @ImageRegetReturned, @OfflineTrans,
		@OcrSendFlag, @ViolationOrgn, @TransactionTimeOrgn, @ProcessedTime, @CreateId, @CreateDttm, @ModifyId, @ModifyDttm ;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO @Output (MDSequenceNum, LPRNumber1, LPRNumber2, AVEID, DetectionTime, LaneSystemID, LaneNr, Violation, Category, SpeedIndication,
		TransactionTime, TagArriveTime, TagDepartTime, TransactionResult, ReaderSN, AuditRecord, EPCID, VehicleDeviceCategory,
		ETagRSSIValue, RFKeysetVersion, Repeat_, TID, UserData2, UserData3, PictureTime, KeepImageList, MAC, eTagLPRNumber,
		StChargeFlag, DecompositionFlag, DeviceCategory, DeviceStatus, DeviceStatusCode, Sender, CheckCode, DeviceServiceStatus,
		DeviceVCID, DeviceIdentity, FreewayNo, FreewayType, FreewayKM, FreewayDirection, ImageRegetReturned, OfflineTrans,
		OcrSendFlag, ViolationOrgn, TransactionTimeOrgn, ProcessedTime, CreateId, CreateDttm, ModifyId, ModifyDttm)

		VALUES (@MDSequenceNum, @LPRNumber1, @LPRNumber2, @AVEID, @DetectionTime, @LaneSystemID, @LaneNr, @Violation, @Category, @SpeedIndication,
		@TransactionTime, @TagArriveTime, @TagDepartTime, @TransactionResult, @ReaderSN, @AuditRecord, @EPCID, @VehicleDeviceCategory,
		@ETagRSSIValue, @RFKeysetVersion, @Repeat_, @TID, @UserData2, @UserData3, @PictureTime, @KeepImageList, @MAC, @eTagLPRNumber,
		@StChargeFlag, @DecompositionFlag, @DeviceCategory, @DeviceStatus, @DeviceStatusCode, @Sender, @CheckCode, @DeviceServiceStatus,
		@DeviceVCID, @DeviceIdentity, @FreewayNo, @FreewayType, @FreewayKM, @FreewayDirection, @ImageRegetReturned, @OfflineTrans,
		@OcrSendFlag, @ViolationOrgn, @TransactionTimeOrgn, @ProcessedTime, @CreateId, @CreateDttm, @ModifyId, @ModifyDttm);
	
		FETCH NEXT FROM cursor_2
		INTO  @MDSequenceNum, @LPRNumber1, @LPRNumber2, @AVEID, @DetectionTime, @LaneSystemID, @LaneNr, @Violation, @Category, @SpeedIndication,
		@TransactionTime, @TagArriveTime, @TagDepartTime, @TransactionResult, @ReaderSN, @AuditRecord, @EPCID, @VehicleDeviceCategory,
		@ETagRSSIValue, @RFKeysetVersion, @Repeat_, @TID, @UserData2, @UserData3, @PictureTime, @KeepImageList, @MAC, @eTagLPRNumber,
		@StChargeFlag, @DecompositionFlag, @DeviceCategory, @DeviceStatus, @DeviceStatusCode, @Sender, @CheckCode, @DeviceServiceStatus,
		@DeviceVCID, @DeviceIdentity, @FreewayNo, @FreewayType, @FreewayKM, @FreewayDirection, @ImageRegetReturned, @OfflineTrans,
		@OcrSendFlag, @ViolationOrgn, @TransactionTimeOrgn, @ProcessedTime, @CreateId, @CreateDttm, @ModifyId, @ModifyDttm ;
	END
	CLOSE cursor_2
	DEALLOCATE cursor_2
	
	fetch next from cursor_1 into @i
end
close cursor_1
deallocate cursor_1

SELECT MDSequenceNum, LPRNumber1, LPRNumber2, AVEID, DetectionTime, LaneSystemID, LaneNr, Violation, Category, SpeedIndication,
		TransactionTime, TagArriveTime, TagDepartTime, TransactionResult, ReaderSN, AuditRecord, EPCID, VehicleDeviceCategory,
		ETagRSSIValue, RFKeysetVersion, Repeat_, TID, UserData2, UserData3, PictureTime, KeepImageList, MAC, eTagLPRNumber,
		StChargeFlag, DecompositionFlag, DeviceCategory, DeviceStatus, DeviceStatusCode, Sender, CheckCode, DeviceServiceStatus,
		DeviceVCID, DeviceIdentity, FreewayNo, FreewayType, FreewayKM, FreewayDirection, ImageRegetReturned, OfflineTrans,
		OcrSendFlag, ViolationOrgn, TransactionTimeOrgn, ProcessedTime, CreateId, CreateDttm, ModifyId, ModifyDttm
FROM   @Output;

select * 
into [athena_practice].[dbo].[GantryData_20171115_Z] 
from @Output





