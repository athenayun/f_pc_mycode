
-- using #temp table ~stored procedure version 2
use athena_practice;
GO

set nocount on ;

select Top 1006 GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.SpeedIndication, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
into ##tmp_1006_travel_table
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.DecompositionFlag = 'O'
order by GLog.FinalLPRNumber, GData.TransactionTime 
--OFFSET 10 ROWS FETCH NEXT 1006 ROWS ONLY ;
-- this return some records whose GLog.OutCome<>0.... 

-- create cursor for using ##tmp table
declare cursor_for_tmp scroll cursor for
select * from ##tmp_1006_travel_table


/*
declare outer_cursor_all scroll cursor for 	
select Top 1006 GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.SpeedIndication, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.DecompositionFlag = 'O'
order by GLog.FinalLPRNumber, GData.TransactionTime 
--OFFSET 10 ROWS FETCH NEXT 1006 ROWS ONLY ;
-- this return some records whose GLog.OutCome<>0.... 			
*/

declare @MDSequenceNum varchar(100), 
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

declare @MDSequenceNum_p varchar(100), 
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



/*
DECLARE @Output TABLE ( MDSequenceNum varchar(100), 
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
*/


open cursor_for_tmp



fetch next from cursor_for_tmp into @MDSequenceNum ,	@LPRNumber1 , @FinalLPRNumber , @TransactionTime , @LaneSystemID , @Violation , 
									@Category , @SpeedIndication , @EPCID , @eTagLPRNumber, @OutCome  ;


while @@FETCH_STATUS = 0
BEGIN
	declare @Output table ( MDSequenceNum varchar(100), 
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
	
	
	fetch prior from cursor_for_tmp into @MDSequenceNum_p ,	@LPRNumber1_p , @FinalLPRNumber_p , @TransactionTime_p , @LaneSystemID_p , @Violation_p , 
										@Category_p , @SpeedIndication_p , @EPCID_p , @eTagLPRNumber_p, @OutCome_p  ;

	if @FinalLPRNumber = @FinalLPRNumber_p
	begin

		if right(@LaneSystemID, 1) = right(@LaneSystemID_p, 1)
		begin
			insert into @Output(MDSequenceNum ,LPRNumber1 , FinalLPRNumber , TransactionTime , LaneSystemID , Violation , 
								Category , SpeedIndication , EPCID , eTagLPRNumber, OutCome )
			values (@MDSequenceNum ,@LPRNumber1 , @FinalLPRNumber , @TransactionTime , @LaneSystemID , @Violation , 
					@Category , @SpeedIndication , @EPCID , @eTagLPRNumber, @OutCome)
	

		end 

		else if right(@LaneSystemID, 1) <> right(@LaneSystemID_p, 1)
		begin
			
			print (concat(@MDSequenceNum,' ,', @TransactionTime,' ,',@FinalLPRNumber,' ,',@LaneSystemID,'\n'
					,@MDSequenceNum_p+', ', @TransactionTime_p,' ,',@FinalLPRNumber_p,' ,',@LaneSystemID_p) )
			
			--print @Output
		
			(select MDSequenceNum ,LPRNumber1 , FinalLPRNumber , TransactionTime , LaneSystemID , Violation , 
					Category , SpeedIndication , EPCID , eTagLPRNumber
			from @Output )
		 
			delete from @Output

		end
	end

	else if @FinalLPRNumber <> @FinalLPRNumber_p
	begin
		delete from @Output
		insert into @Output(MDSequenceNum ,LPRNumber1 , FinalLPRNumber , TransactionTime , LaneSystemID , Violation , 
								Category , SpeedIndication , EPCID , eTagLPRNumber, OutCome )
		values (@MDSequenceNum ,@LPRNumber1 , @FinalLPRNumber , @TransactionTime , @LaneSystemID , @Violation , 
					@Category , @SpeedIndication , @EPCID , @eTagLPRNumber, @OutCome)

	end

	fetch next from cursor_for_tmp into @MDSequenceNum ,	@LPRNumber1 , @FinalLPRNumber , @TransactionTime , @LaneSystemID , @Violation , 
									@Category , @SpeedIndication , @EPCID , @eTagLPRNumber, @OutCome  ;

END
CLOSE cursor_for_tmp
DEALLOCATE cursor_for_tmp