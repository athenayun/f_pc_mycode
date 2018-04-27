
/* Table6 : GANTRY_DATA */ 

select LaneSystemID, counting =count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
  from [athena_practice].[dbo].[GantryData_20171115]
  group by LaneSystemID 
  order by LaneSystemID;

select LaneSystemID, counting = count(*), (sum(count(*)) over())/333 AS average
from [athena_practice].[dbo].[GantryData_20171115] AS G
group by LaneSystemID
having count(*) > ANY(select (sum(count(*)) over())/333 
					from [athena_practice].[dbo].[GantryData_20171115]
					group by LaneSystemID) 
order by LaneSystemID;

select LaneSystemID, counting = count(LaneSystemID), (sum(count(*)) over())/333 AS average
from [athena_practice].[dbo].[GantryData_20171115] AS G
where counting > 47316
group by LaneSystemID
/* having count(*) > 47316 */
order by LaneSystemID;


select LaneSystemID, counting /*,  average = SUM(counting) */
from (select LaneSystemID,  count(*) AS counting
		from [athena_practice].[dbo].[GantryData_20171115] AS G
		group by LaneSystemID ) as counts 
group by LaneSystemID, counting
order by LaneSystemID

having G.counting > AVG(counting)


select /*LaneSystemID, 'count' =count(*),*/  average = AVG(counting)
from (select LaneSystemID,  count(*) AS counting
		from [athena_practice].[dbo].[GantryData_20171115] AS G
		group by LaneSystemID ) as counts 

select LaneSystemID,  count(*) AS counting, AVG(counting)
		from [athena_practice].[dbo].[GantryData_20171115] AS G
		group by LaneSystemID
		having counting > AVG(counting)



select ID_NO, counting =count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
  from [MDPOC].[dbo].[BMS_PRO_PROVIDER]
  group by ID_NO
  order by count(*);

  select distinct LaneNr, LaneSystemID, info.HIGHWAY_ID, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over()), sum(count(*)) over()
from [athena_practice].[dbo].[GantryData_20171115] AS gan
	inner join [MDPOC].[dbo].[BMS_PRO_GANTRY] AS info
	on  info.GANTRY_ID = gan.LaneSystemID 
where info.GANTRY_ID in (select distinct info.GANTRY_ID
		from [MDPOC].[dbo].[BMS_PRO_GANTRY] AS info
		where STATUS = 1)
group by LaneNr, LaneSystemID, info.HIGHWAY_ID 
order by LaneSystemID;

select LaneNr, LaneSystemID, count(*), sum(count(*)) over()
from [athena_practice].[dbo].[GantryData_20171115] AS gan
/* where LaneSystemID = '01F0005N' */
group by  LaneNr, LaneSystemID

select *
from [athena_practice].[dbo].[GantryData_20171115] as G
where G.DetectionTime in  (
		select DetectionTime
		from [athena_practice].[dbo].[GantryData_20171115]
		group by DetectionTime
		having count(*) > 1
		) 
		
order by DetectionTime;

select LPRNumber1, AVEID, DetectionTime, LaneSystemID, Violation, TransactionResult, EPCID, eTagLPRNumber, DecompositionFlag
from [athena_practice].[dbo].[GantryData_20171115] as G
where G.DetectionTime = '2017-11-15 23:59:56.843'
		
order by DetectionTime;


	select TransactionTime, count(*)
	from [athena_practice].[dbo].[GantryData_20171115]
	group by TransactionTime
having count(*) > 1	;

  use athena_practice;
  exec sp_help GantryData_20171115;
  select count(*)  FROM [athena_practice].[dbo].[GantryData_20171115];

  /* End Table6 */

  /* Table7 : PRO_PROVIDER */

  select ACC_TYPE_ID, ACC_USAGE_TYPE, code.CODE_NAME, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_ACC_ACCOUNT] AS gan
	inner join [MDPOC].[dbo].[BMS_PRO_CODES] AS code
	on  code.CODE_ID = gan.ACC_USAGE_ID and CODE_TYPE = gan.ACC_USAGE_TYPE
group by ACC_USAGE_ID, ACC_USAGE_TYPE, code.CODE_NAME ;

select VEHICLE_ID, counting =count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
  from [MDPOC].[dbo].[BMS_ACC_ACCOUNT]
  group by VEHICLE_ID
  order by count(*);