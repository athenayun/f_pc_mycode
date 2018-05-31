
-- making join between gantry_data and gantry_log

select  GLog.FinalLPRNumber, GData.EPCID
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GData.DecompositionFlag = 'O'
group by GLog.FinalLPRNumber, GData.EPCID


select GData.MDSequenceNum, GData.LPRNumber1 ,GLog.FinalLPRNumber, GData.EPCID
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GData.DecompositionFlag = 'O'
and GData.LPRNumber1 <> GLog.FinalLPRNumber


-- Result : None
select GData.MDSequenceNum, GData.LPRNumber1 ,GLog.FinalLPRNumber, GData.EPCID
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GData.DecompositionFlag = 'O'
and GData.LPRNumber1 = GLog.FinalLPRNumber
and GLog.FinalLPRNumber is NULL




select GData.MDSequenceNum, GData.LPRNumber1 , GData.LPRNumber2, GLog.OcrLPRNumber1 , GLog.OcrLPRNumber2 ,GLog.FinalLPRNumber, GData.EPCID
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GData.DecompositionFlag = 'O'
and GLog.FinalLPRNumber is NULL
and GData.LPRNumber1 is null
and GData.EPCID is null
and GLog.OcrLPRNumber1 is null



select GData.MDSequenceNum, GData.LPRNumber1 , GData.LPRNumber2, GLog.OcrLPRNumber1 , GLog.OcrLPRNumber2 ,GLog.FinalLPRNumber, GData.EPCID
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GData.DecompositionFlag = 'O'
and GLog.FinalLPRNumber is NULL
and GData.LPRNumber1 is null
and GData.EPCID is null
and GLog.OcrLPRNumber2 = GLog.OcrLPRNumber1
and GData.LPRNumber2 is not null
and GData.LPRNumber2 <> GLog.OcrLPRNumber1

-- there are no data with GLog.OutCome=0 but FinalLPRNumber=NULL
select *
from [athena_practice].[dbo].[GantryLog_20171115]
where OutCome = '0'
and FinalLPRNumber is null ;


--checking MDSequenceNum with no GLog.FinalLPRNumber can be identified by EPCID or not
select GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GData.LPRNumber1 in (	select gl.FinalLPRNumber
							from [athena_practice].[dbo].[GantryLog_20171115] as gl
							where gl.OutCome = '0'
							--and gl.FinalLPRNumber is not null
							)
and GData.DecompositionFlag = 'O'
and GLog.FinalLPRNumber is null
order by GData.LPRNumber1, GData.TransactionTime, GData.EPCID
-- this return some records whose GLog.OutCome<>0....


--MDSequenceNum = 01F0376NA20171115T1616145347295 in above query, which GLog.OutCome=NULL!!!
select *
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum = '01F0376NA20171115T1616145347295'
-- ohh ! this one iss having no GLog.MatchedMDSequenceNum...shit

-- i think this statement is the correct one
select GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.DecompositionFlag = 'O'
--and GLog.FinalLPRNumber is null
order by GLog.FinalLPRNumber, GData.TransactionTime, GData.EPCID
-- this return some records whose GLog.OutCome<>0....


-- just make sure it work...
select Top 1006 GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.SpeedIndication, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
--into ##tmp_1006_travel_table
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.OutCome = '0'
and GData.DecompositionFlag = 'O'
order by GLog.FinalLPRNumber, GData.TransactionTime 


select right('03F0961N', 1)

--using if statement for priority
if [athena_practice].[dbo].[GantryLog_20171115].OutCome is not null
	


select LaneSystemID, COUNT(*)
from [athena_practice].[dbo].[GantryData_20171115]
group by LaneSystemID

select MatchingRule, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [athena_practice].[dbo].[GantryLog_20171115]
group by MatchingRule

select Etag.ETAG_ID,GData.EPCID, Etag.ETAG_STATUS
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [MDPOC].[dbo].[BMS_TAG_ETAG] as Etag
	on Etag.EPC_ID = GData.EPCID



-- just some join SQL previously wrote for example
select trff.MODEL_NO_ID,  model.MODEL_NO_NAME, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_TAG_TRFF] AS trff
	inner join [MDPOC].[dbo].[BMS_TAG_MODEL_NO] AS model
	on  model.MODEL_NO_ID = trff.MODEL_NO_ID 
group by trff.MODEL_NO_ID,  model.MODEL_NO_NAME 
order by trff.MODEL_NO_ID ;

use athena_practice ;
GO
exec sp_help GantryData_20171115;
GO
exec sp_help GantryLog_20171115;
