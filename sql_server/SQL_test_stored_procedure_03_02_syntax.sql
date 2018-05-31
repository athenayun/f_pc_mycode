-- try writing one using CASE...WHEN...THEN...

select Top 1006 ROW_NUMBER() OVER(ORDER BY GLog.FinalLPRNumber, GData.TransactionTime ) as row_id
				,GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.SpeedIndication, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
--into ##tmp2_row1006_travel_table
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.DecompositionFlag = 'O'
order by GLog.FinalLPRNumber, GData.TransactionTime 

-- if the statement above can work, then use the SELECT statement to compare the previous row instead of using cursor


-- write into #temp table
select Top 1006 ROW_NUMBER() OVER(ORDER BY GLog.FinalLPRNumber, GData.TransactionTime ) as row_id
				,GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.SpeedIndication, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
into ##tmp_1006_test_table
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.DecompositionFlag = 'O'
order by GLog.FinalLPRNumber, GData.TransactionTime 


select previous_rec.MDSequenceNum, previous_rec.FinalLPRNumber, previous_rec.TransactionTime, previous_rec.LaneSystemID, current_rec.LaneSystemID as next_g
from (select * from ##tmp_1006_test_table) as current_rec
	inner join (select * from ##tmp_1006_test_table) as previous_rec
	on current_rec.row_id = previous_rec.row_id + 1
where current_rec.FinalLPRNumber = previous_rec.FinalLPRNumber
and right(current_rec.LaneSystemID, 1) = right(previous_rec.LaneSystemID, 1)


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

declare @row_id_p int,
		@MDSequenceNum_p varchar(100), 
		@LPRNumber1_p nvarchar(100), 
		@FinalLPRNumber_p nvarchar(100), 
		@TransactionTime_p datetime2, 
		@LaneSystemID_p varchar(10), 
		@Violation_p numeric, 
		@Category_p numeric, 
		@SpeedIndication_p numeric,
		@EPCID_p varchar(50), 
		@eTagLPRNumber_p nvarchar(100),
		@OutCome_p varchar(5) ;

DECLARE @tmp_Output TABLE ( row_id int,
							MDSequenceNum varchar(100), 
							LPRNumber1 nvarchar(100), 
							FinalLPRNumber nvarchar(100), 
							TransactionTime datetime2, 
							LaneSystemID varchar(10), 
							Violation numeric, 
							Category numeric, 
							SpeedIndication numeric,
							EPCID varchar(50), 
							eTagLPRNumber nvarchar(100),
							OutCome varchar(5)  )
select *
from (select * from ##tmp_1006_test_table) as current_rec
	inner join (select * from ##tmp_1006_test_table) as previous_rec
	on current_rec.row_id = previous_rec.row_id + 1
where current_rec.row_id = @row_id
and current_rec.MDSequenceNum = @MDSequenceNum
and current_rec.LPRNumber1 = @LPRNumber1
and current_rec.FinalLPRNumber = @FinalLPRNumber
and current_rec.TransactionTime = @TransactionTime
and current_rec.LaneSystemID = @LaneSystemID
and current_rec.Violation = @Violation
and current_rec.Category = @Category
and current_rec.SpeedIndication = @SpeedIndication
and current_rec.EPCID = @EPCID
and current_rec.eTagLPRNumber = @eTagLPRNumber
and current_rec.OutCome = @OutCome

and previous_rec.row_id = @row_id_p
and previous_rec.MDSequenceNum = @MDSequenceNum_p
and previous_rec.LPRNumber1 = @LPRNumber1_p
and previous_rec.FinalLPRNumber = @FinalLPRNumber_p
and previous_rec.TransactionTime = @TransactionTime_p
and previous_rec.LaneSystemID = @LaneSystemID_p
and previous_rec.Violation = @Violation_p
and previous_rec.Category = @Category_p
and previous_rec.SpeedIndication = @SpeedIndication_p
and previous_rec.EPCID = @EPCID_p
and previous_rec.eTagLPRNumber = @eTagLPRNumber_p
and previous_rec.OutCome = @OutCome_p

if 
begin

insert into @tmp_Output(row_id,MDSequenceNum ,LPRNumber1 , FinalLPRNumber , TransactionTime , LaneSystemID , Violation , 
						Category , SpeedIndication , EPCID , eTagLPRNumber, OutCome )
values (@row_id, @MDSequenceNum ,@LPRNumber1 , @FinalLPRNumber , @TransactionTime , @LaneSystemID , @Violation , 
		@Category , @SpeedIndication , @EPCID , @eTagLPRNumber, @OutCome)
end



-- SAMPLE for self join
SELECT * 
FROM (SELECT ID, field1 
FROM Table1) AS current_Record 
INNER JOIN (SELECT ID, Field1 
FROM Table1) AS Previous_Record ON current_Record.ID = Previous_Record.ID + 1 