-- statement block start with BEGIN end with END

-- this is some try and error code for selecting the MDSequenceNum with error
declare @md_num nvarchar(100)

select @md_num = MDSequenceNum
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum like '%e_0' escape 'e' ;


select left( @md_num ,CHARINDEX('_', @md_num )-1) as MDSequenceNum ;


--out print the test result

declare cursor_name cursor for	(	select MDSequenceNum 
									from [athena_practice].[dbo].[GantryData_20171115] 
									where MDSequenceNum like '%e_0' escape 'e' )
declare @i varchar(100)
open cursor_name
fetch next from cursor_name into @i
while @@FETCH_STATUS = 0
begin
	print left( @i ,CHARINDEX('_', @i )-1) 
	fetch next from cursor_name into @i
end
close cursor_name
deallocate cursor_name

-- NOTICE : the outcome are detected_error MDSequenceNum
--wow! the result above looks perfectly well hahaha

--try using this procedure to select detected_error data 

declare cursor_name cursor for	(	select MDSequenceNum 
									from [athena_practice].[dbo].[GantryData_20171115] 
									where MDSequenceNum like '%e_0' escape 'e' )
declare @i varchar(100)
open cursor_name
fetch next from cursor_name into @i
while @@FETCH_STATUS = 0
begin
	
	(select *
	from [athena_practice].[dbo].[GantryData_20171115]
	where MDSequenceNum = left( @i ,CHARINDEX('_', @i )-1) )
	
	--print left( @i ,CHARINDEX('_', @i )-1) 
	fetch next from cursor_name into @i
end
close cursor_name
deallocate cursor_name

-- well, it's working, but not so efficient with one row at a time (using fetch and cursor )
--let's try using batch result for cursor <sp_cursor_list>

-- try using sp_cursor_list 

USE athena_practice;  
GO  
-- Declare and open a keyset-driven cursor.  
DECLARE test CURSOR KEYSET FOR  
select MDSequenceNum 
from [athena_practice].[dbo].[GantryData_20171115] 
where MDSequenceNum like '%e_0' escape 'e';  
OPEN test;  

-- Declare a cursor variable to hold the cursor output variable  
-- from sp_cursor_list.  
DECLARE @Result CURSOR;  

-- Execute sp_cursor_list into the cursor variable.  
EXEC master.dbo.sp_cursor_list @cursor_return = @Result OUTPUT,  
      @cursor_scope = 2;  
	  -- @cursor_scope : 1=local variable ; 2=global variable
-- Fetch all the rows from the sp_cursor_list output cursor.  
FETCH NEXT from @Result;  
WHILE (@@FETCH_STATUS <> -1)  
BEGIN  
   
   --print @Result
   FETCH NEXT from @Result;  
END  

-- Close and deallocate the cursor from sp_cursor_list.  
CLOSE @Result;  
DEALLOCATE @Result;  
GO  

-- Close and deallocate the original cursor.  
CLOSE test;  
DEALLOCATE test;  
GO  


--EXAMPLE FOR SET-BASED

declare cur cursor for
select X from XXX

declare @x int
open cur
fetch next from cur into @x

while @@FETCH_STATUS = 0
BEGIN
    exec A @x

    fetch next from cur into @x
END

--END SESSION--


-- try using cursor as a variable for return a batch of result set ?

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



-- the CURSOR replaces #Temp in the original query
DECLARE crs CURSOR STATIC LOCAL READ_ONLY FORWARD_ONLY
FOR (	select MDSequenceNum 
		from [athena_practice].[dbo].[GantryData_20171115] 
		where MDSequenceNum like '%e_0' escape 'e');

OPEN crs;

FETCH NEXT
FROM  crs
INTO  @Id, @Name, @Type;

WHILE (@@FETCH_STATUS = 0)
BEGIN
    INSERT INTO @Output (Id, Name, [Type])
    VALUES (@Id, @Name, @Type);

    -- do some processing..

    FETCH NEXT -- replaces the DELETE and re-SELECT in the original query
    FROM  crs
    INTO  @Id, @Name, @Type;
END;

CLOSE crs;
DEALLOCATE crs;

SELECT Id, Name, [Type]
FROM   @Output;


/*
declare
@MDSequenceNum varchar(100),
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
@Repeat varchar(10),
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
@ModifyDttm datetime2

*/


  use athena_practice;
  exec sp_help GantryData_20171115;
  GO