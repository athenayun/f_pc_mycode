-- try avoiding using cursor to output cars' travel time

select Top 1006 ROW_NUMBER() OVER(ORDER BY GLog.FinalLPRNumber, GData.TransactionTime ) as row_id
				,GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.SpeedIndication, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
into ##tmp_1006_test_table
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.DecompositionFlag = 'O'
order by GLog.FinalLPRNumber, GData.TransactionTime 



select *
into @query_table
from (select * from ##tmp_1006_test_table) as next_rec
	inner join (select * from ##tmp_1006_test_table) as current_rec
	on next_rec.row_id = current_rec.row_id + 1



select *
from (select * from ##tmp_1006_test_table) as next_rec p
	inner join (select * from ##tmp_1006_test_table) as current_rec
	on next_rec.row_id = current_rec.row_id + 1
where next_rec.row_id = @row_id_n
and next_rec.MDSequenceNum = @MDSequenceNum_n
and next_rec.LPRNumber1 = @LPRNumber1_n
and next_rec.FinalLPRNumber = @FinalLPRNumber_n
and next_rec.TransactionTime = @TransactionTime_n
and next_rec.LaneSystemID = @LaneSystemID_n
and next_rec.Violation = @Violation_n
and next_rec.Category = @Category_n
and next_rec.SpeedIndication = @SpeedIndication_n
and next_rec.EPCID = @EPCID_n
and next_rec.eTagLPRNumber = @eTagLPRNumber_n
and next_rec.OutCome = @OutCome_n

and current_rec.row_id = @row_id
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

declare @query_table table (row_id int,
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
							OutCome varchar(5), 
							
							row_id_p int,
							MDSequenceNum_p varchar(100), 
							LPRNumber1_p nvarchar(100), 
							FinalLPRNumber_p nvarchar(100), 
							TransactionTime_p datetime2, 
							LaneSystemID_p varchar(10), 
							Violation_p numeric, 
							Category_p numeric, 
							SpeedIndication_p numeric,
							EPCID_p varchar(50), 
							eTagLPRNumber_p nvarchar(100),
							OutCome_p varchar(5) 	
							);

-- start here
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




declare i_hate_cursor  cursor local fast_forward for
select *
from (select * from ##tmp_1006_test_table) as next_rec
	inner join (select * from ##tmp_1006_test_table) as current_rec
	on next_rec.row_id = current_rec.row_id + 1

open i_hate_cursor
fetch next from  i_hate_cursor into @row_id ,@MDSequenceNum , @LPRNumber1 , @FinalLPRNumber , @TransactionTime ,@LaneSystemID , @Violation , @Category , @SpeedIndication ,
		@EPCID , @eTagLPRNumber ,@OutCome ,
		@row_id_n ,@MDSequenceNum_n , @LPRNumber1_n , @FinalLPRNumber_n, @TransactionTime_n , @LaneSystemID_n , @Violation_n , @Category_n , 
		@SpeedIndication_n ,@EPCID_n , @eTagLPRNumber_n ,@OutCome_n 

while @@FETCH_STATUS=0
begin	
	if @FinalLPRNumber = @FinalLPRNumber_n
	begin
		if right(@LaneSystemID, 1) = right(@LaneSystemID_n, 1)
			begin
				insert into @tmp_Output(row_id,MDSequenceNum ,LPRNumber1 , FinalLPRNumber , TransactionTime , LaneSystemID , Violation , 
										Category , SpeedIndication , EPCID , eTagLPRNumber, OutCome )
				values (@row_id, @MDSequenceNum ,@LPRNumber1 , @FinalLPRNumber , @TransactionTime , @LaneSystemID , @Violation , 
						@Category , @SpeedIndication , @EPCID , @eTagLPRNumber, @OutCome)
			end
		else if right(@LaneSystemID, 1) <> right(@LaneSystemID_n, 1)
			begin
			
				print (concat(@MDSequenceNum,' ,', @TransactionTime,' ,',@FinalLPRNumber,' ,',@LaneSystemID,'\n'
						,@MDSequenceNum_n+', ', @TransactionTime_n,' ,',@FinalLPRNumber_n,' ,',@LaneSystemID_n) )
			
				--print @Output
		
				(select row_id, MDSequenceNum ,LPRNumber1 , FinalLPRNumber , TransactionTime , LaneSystemID , Violation , 
						Category , SpeedIndication , EPCID , eTagLPRNumber
				from @tmp_Output )
		 
				--delete from @tmp_Output

			end

		else if @FinalLPRNumber <> @FinalLPRNumber_n
			begin
				delete from @tmp_Output
				insert into @tmp_Output(MDSequenceNum ,LPRNumber1 , FinalLPRNumber , TransactionTime , LaneSystemID , Violation , 
										Category , SpeedIndication , EPCID , eTagLPRNumber, OutCome )
				values (@MDSequenceNum ,@LPRNumber1 , @FinalLPRNumber , @TransactionTime , @LaneSystemID , @Violation , 
							@Category , @SpeedIndication , @EPCID , @eTagLPRNumber, @OutCome)
			end


	end

end
CLOSE i_hate_cursor
DEALLOCATE i_hate_cursor