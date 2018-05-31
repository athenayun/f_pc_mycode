CREATE PROCEDURE define_car_travel as

declare outer_cursor_all cursor local fast_forward for (	select GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.SpeedIndication, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
															from [athena_practice].[dbo].[GantryData_20171115] as GData
																inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
																on GLog.MDSequenceNum = GData.MDSequenceNum
															where GLog.OutCome = '0'
															and GData.DecompositionFlag = 'O'
															order by GLog.FinalLPRNumber, GData.TransactionTime, GData.EPCID ;
															-- this return some records whose GLog.OutCome<>0.... 			)
declare @MDSequence varchar(100), 
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

open outer_cursor_all
fetch next from outer_cursor_all into @i
while @@FETCH_STATUS = 0

BEGIN

END 


--testing area

-- i think this statement is the correct one
select GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.DecompositionFlag = 'O'
--and GLog.FinalLPRNumber is null
order by GData.LPRNumber1, GData.TransactionTime, GData.EPCID
-- this return some records whose GLog.OutCome<>0....



select *
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.LPRNumber1 = '0xA94EA1967B84A6AE25D86340C0F4D4B26DC93B27'
order by GData.TransactionTime


	select *
	from [athena_practice].[dbo].[GantryData_20171115] as GData
		inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
		on GLog.MDSequenceNum = GData.MDSequenceNum
	where GLog.OutCome = '0'
	
	order by GData.LPRNumber1, GData.TransactionTime