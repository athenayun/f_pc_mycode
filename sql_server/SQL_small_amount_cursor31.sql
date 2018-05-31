
-- this #temp table is only for testing query and procedure testing
select Top 31 ROW_NUMBER() OVER(ORDER BY GLog.FinalLPRNumber, GData.TransactionTime ) as row_id
				,GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.SpeedIndication, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
into ##tmp_31_test_table
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.DecompositionFlag = 'O'
order by GLog.FinalLPRNumber, GData.TransactionTime 
-- ================================================
-- in the complete procedure statement, the statement above will be just a statement for insert
-- ================================================
-- start here
use athena_practice;
GO


declare @row_id int,
		@MDSequenceNum varchar(100), 
		@LPRNumber1 nvarchar(100), 
		@FinalLPRNumber nvarchar(100), 
		@TransactionTime datetime2, 
		@LaneSystemID varchar(10), 
		@Violation numeric, 
		@Category numeric, 
		@SpeedIndication numeric,
		@EPCID varchar(50), 
		@eTagLPRNumber nvarchar(100),
		@OutCome varchar(5) ;

declare @row_id_n int,
		@MDSequenceNum_n varchar(100), 
		@LPRNumber1_n nvarchar(100), 
		@FinalLPRNumber_n nvarchar(100), 
		@TransactionTime_n datetime2, 
		@LaneSystemID_n varchar(10), 
		@Violation_n numeric, 
		@Category_n numeric, 
		@SpeedIndication_n numeric,
		@EPCID_n varchar(50), 
		@eTagLPRNumber_n nvarchar(100),
		@OutCome_n varchar(5) ;



declare cursor_no1  cursor local fast_forward for
select	@row_id=next_rec.row_id, @MDSequenceNum=next_rec.MDSequenceNum, @LPRNumber1=next_rec.LPRNumber1, @FinalLPRNumber=next_rec.FinalLPRNumber, @TransactionTime=next_rec.TransactionTime, 
		@LaneSystemID=next_rec.LaneSystemID, @Violation=next_rec.Violation, @Category=next_rec.Category, @SpeedIndication=next_rec.SpeedIndication, @EPCID=EPCID, @eTagLPRNumber=next_rec.eTagLPRNumber,
		@OutCome=next_rec.OutCome,
		@row_id=current_rec.row_id, @MDSequenceNum=current_rec.MDSequenceNum, @LPRNumber1=current_rec.LPRNumber1, @FinalLPRNumber=current_rec.FinalLPRNumber, @TransactionTime=current_rec.TransactionTime, 
		@LaneSystemID=current_rec.LaneSystemID, @Violation=current_rec.Violation, @Category=current_rec.Category, @SpeedIndication=current_rec.SpeedIndication, @EPCID=current_rec.EPCID, @eTagLPRNumber=current_rec.eTagLPRNumber,
		@OutCome=current_rec.OutCome
from (select * from ##tmp_31_test_table) as next_rec
		inner join (select * from ##tmp_31_test_table) as current_rec
		on next_rec.row_id = current_rec.row_id + 1

open cursor_name

fetch next from  cursor_name into @row_id ,@MDSequenceNum , @LPRNumber1 , @FinalLPRNumber , @TransactionTime ,@LaneSystemID , @Violation , @Category , @SpeedIndication ,
		@EPCID , @eTagLPRNumber ,@OutCome ,
		@row_id_n ,@MDSequenceNum_n , @LPRNumber1_n , @FinalLPRNumber_n, @TransactionTime_n , @LaneSystemID_n , @Violation_n , @Category_n , 
		@SpeedIndication_n ,@EPCID_n , @eTagLPRNumber_n ,@OutCome_n 

while @@FETCH_STATUS=0
BEGIN
	if @FinalLPRNumber = @FinalLPRNumber_n
	begin
		
	end

END

--select * from ##tmp_31_test_table
-- testing area

declare @FinalLPRNumber nvarchar(100),	@LaneSystemID varchar(10), @TransactionTime datetime2

set @FinalLPRNumber = '0x000001460839F675BFE9C65121B9E1C6573F69A7'
set @LaneSystemID = 'S'
set @TransactionTime = '2017-11-15 09:07:54.367'

select *
from ##tmp_31_test_table
where FinalLPRNumber = @FinalLPRNumber
and TransactionTime between DATEADD(n, 60, TransactionTime) and DATEDIFF(n, 60, TransactionTime)
and right(LaneSystemID, 1) = right(@LaneSystemID, 1)

exec sp_help ##tmp_31_test_table;