
use athena_practice;
GO

-- ============================================================================================================
-- Author : Athena Yun
-- Create date : 2018/05/18
-- Description : return travel times for a car "FinalLPRNumber" as input in ordered (by "TrasactionTime" )
-- ============================================================================================================




create function athena_practice.func_test
(	@FinalLPRNumber nvarchar(100),
	@LaneSystemID varchar(10), 
	@TransactionTime datetime2
)
returns table
as
return
(
	select *
	from ##tmp_31_test_table
	where FinalLPRNumber = @FinalLPRNumber
	and cast(TransactionTime as datetime) between  DATEADD(HOUR, -1, cast(@TransactionTime as datetime)) and DATEADD(HOUR, 1, cast(@TransactionTime as datetime)) 
	and right(LaneSystemID, 1) = right(@LaneSystemID, 1)
)
GO


declare @FinalLPRNumber nvarchar(100),	@LaneSystemID varchar(10),  @TransactionTime datetime2

set @FinalLPRNumber = '0x00000594DD5009ACC8835D36687BDD71F826F365'
set @LaneSystemID = 'S'
set @TransactionTime = '2017-11-15 13:09:04.223'

select DATEADD(HOUR, -1, cast(@TransactionTime as datetime)), DATEADD(HOUR, 1, cast(@TransactionTime as datetime)) 

select *
from ##tmp_31_test_table
where FinalLPRNumber = @FinalLPRNumber
and cast(TransactionTime as datetime) between  DATEADD(HOUR, -1, cast(@TransactionTime as datetime)) and DATEADD(HOUR, 1, cast(@TransactionTime as datetime)) 
and right(LaneSystemID, 1) = right(@LaneSystemID, 1)

select TOP 1 DATEPART(YEAR,TransactionTime)
from [athena_practice].[dbo].[GantryData_20171115] 

exec sp_help master.##tmp_31_test_table;