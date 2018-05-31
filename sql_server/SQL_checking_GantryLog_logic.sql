select * 
from [MDPOC].[dbo].[GANTRY_LOG]
where MDSequenceNum = '01F0750NA20171115T0000104178867_0'


SELECT *
INTO    [athena_practice].[dbo].[GantryLog_20171115]

FROM    [MDPOC].[dbo].[GANTRY_LOG] 
WHERE cast(TransactionTime as date) = '2017-11-15';


-- checking MDSequenceNum(_0, origin, _1) in gantry_data relation with gantry_log
select *
FROM    [athena_practice].[dbo].[GantryLog_20171115]
where MDSequenceNum = '01F3561SA20171115T000085497728' 
or MDSequenceNum = '01F3561SA20171115T000085497728_0' 
or MDSequenceNum = '03F1633SA20171115T000055578490_1'
or MDSequenceNum = '03F1633SA20171115T000055578490' ;

/* CARS' MDSequenceNum

01F0061NA20170715T000076943636
01F0061NA20170715T000076943636_1


*/

select *
FROM    [athena_practice].[dbo].[GantryLog_20171115]
where MDSequenceNum = '01F3561SA20171115T000085497728' 
or MDSequenceNum = '01F3561SA20171115T000085497728_0' 
or MDSequenceNum = '01F1123SA20171115T000068205551_1'
or MDSequenceNum = '01F1123SA20171115T000068205551' ;

select count(*) from [athena_practice].[dbo].[GantryLog_20171115]

0x45752859E7D8D76B6E8B7BB0DECD55646B2BDF62
0x45752859E7D8D76B6E8B7BB0DECD55646B2BDF62


select *
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum like '03F1992NA20171115T170555713256%'

select *
from [athena_practice].[dbo].[GantryLog_20171115]
where MDSequenceNum like '03F1992NA20171115T170555713256%'

/* case with no FinalLPRNumber & EPCID

--------------------------------------------------------------
MDSequenceNum = 01F1725NA20171115T1705114597522

GLog.OcrLPRNumber1 :   0xFC9512845C4A1D26A6263D26CD34390D25584FE3
GData.LPRNumber1 :     0xFC9512845C4A1D26A6263D26CD34390D25584FE3

--------------------------------------------------------------
MDSequenceNum = 01F0339SA20171115T17056117669

GLog.OcrLPRNumber1 :   0x9BFF4E03C8C1BDC108BCB1A259E35FEDED2A65D1
GData.LPRNumber1 :     0x9BFF4E03C8C1BDC108BCB1A259E35FEDED2A65D1

--------------------------------------------------------------
MDSequenceNum = 03F1992NA20171115T170555713256

GLog.OcrLPRNumber1 :   0xD2461615AE9FF8865F4DFBC74C526FBFCD052C34
GData.LPRNumber1 :     0xD2461615AE9FF8865F4DFBC74C526FBFCD052C34


*/

--finalLPRNumber
select *
from [athena_practice].[dbo].[GantryData_20171115]
where LPRNumber1 = '0xE8F45A9F1E34F2DCD4A8B53AE3BA3312822E739B'
-- LPRNumber1
select *
from [athena_practice].[dbo].[GantryData_20171115]
where LPRNumber1 = '0x8A9311D78733DFAA2720556BCA122F4A174F5117'





--Gantry
select *
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum = '01F3185NA20171115T194893567566'
--GantryData with MatchedMDSequenceNum
select *
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum = '01F3185NA20171115T194893567597'
-- GantryLog
select *
from [athena_practice].[dbo].[GantryLog_20171115]
where MDSequenceNum = '01F0376NA20171115T1616145347295'
--GantryLog with MatchedMDSequenceNum
select *
from [athena_practice].[dbo].[GantryLog_20171115]
where MDSequenceNum = '01F3185NA20171115T194893567597'


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
	
order by GLog.FinalLPRNumber, GData.TransactionTime

select GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.EPCID, GData.eTagLPRNumber, GLog.OutCome
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GLog.FinalLPRNumber = '0x0001D1F16807E48E6EF3FCADDE57F1681AE81FEC'

select GData.MDSequenceNum, GData.LPRNumber1, GLog.FinalLPRNumber, GData.TransactionTime, GData.LaneSystemID, GData.Violation, GData.Category, GData.EPCID, GData.eTagLPRNumber
from [athena_practice].[dbo].[GantryData_20171115] as GData
	inner join [athena_practice].[dbo].[GantryLog_20171115] as GLog
	on GLog.MDSequenceNum = GData.MDSequenceNum
where GData.LPRNumber1 in (	select gl.FinalLPRNumber
							from [athena_practice].[dbo].[GantryLog_20171115] as gl
							where gl.OutCome = '0'
							)
and GData.DecompositionFlag = 'O'
order by GLog.FinalLPRNumber, GData.TransactionTime


