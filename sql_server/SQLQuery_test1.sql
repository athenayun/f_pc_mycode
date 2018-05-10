select top 1000 LaneSystemID, LaneNr
from [MDPOC].[dbo].[GANTRY_DATA]

select top 1000 *
from [MDPOC].[dbo].[GANTRY_DATA]

select top 1000 LaneSystemID, COUNT(LaneSystemID)
from [MDPOC].[dbo].[GANTRY_DATA]
group by LaneSystemID;

select top 1000 Outcome
from [MDPOC].[dbo].[GANTRY_LOG]

select count(*) from [MDPOC].[dbo].[GANTRY_DATA]

select *
from GANTRY_DATA
where cast(TransactionTime as date) = '2017-11-15' ;


CREATE TABLE [athena_practice].[dbo].[GantryData_20171115]
AS
SELECT  *
FROM    [MDPOC].[dbo].[GANTRY_DATA]
WHERE cast(TransactionTime as date) = '2017-11-15' ;


SELECT *
INTO    [athena_practice].[dbo].[GantryData_20171115]

FROM    [MDPOC].[dbo].[GANTRY_DATA] 
WHERE cast(TransactionTime as date) = '2017-11-15';


SELECT *
INTO    [athena_practice].[dbo].[GantryData_20170715]

FROM    [MDPOC].[dbo].[GANTRY_DATA] 
WHERE cast(TransactionTime as date) = '2017-07-15';


select count(*)  FROM [MDPOC].[dbo].[BMS_PRO_CONSUMER];

/*** match the code types description ***/

select CODE_ID, CODE_TYPE, CODE_NAME 
FROM [MDPOC].[dbo].[BMS_PRO_CODES]
where CODE_TYPE = 1  
and CODE_ID in (1, 11, 3, 31,5);


/*** checking the content in the field ***/

/* Table1 : PRO_CONSUMER */



select ID_TYPE, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_PRO_CONSUMER]
group by ID_TYPE;

select CONSUMER_ID, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_PRO_CONSUMER]
group by CONSUMER_ID;

select count(*)  FROM [MDPOC].[dbo].[BMS_PRO_CONSUMER];

/* End table1 */

/* Table2 : PRO_GANTRY */

exec sp_help BMS_PRO_GANTRY;

select SERVICE_ITEM_ID, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_PRO_GANTRY]
group by SERVICE_ITEM_ID;

select GANTRY_ID, counting = count(*), total = (sum(count(*)) over() ),'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_PRO_GANTRY]
group by GANTRY_ID
having count(*) = 1 ;

select *
from [MDPOC].[dbo].[BMS_PRO_GANTRY]
where GANTRY_ID = '03F3588S' ;

select *
from [MDPOC].[dbo].[BMS_PRO_GANTRY] as G
where G.GANTRY_ID in  (
		select GANTRY_ID
		from [MDPOC].[dbo].[BMS_PRO_GANTRY]
		group by GANTRY_ID
		having count(*) = 1
		) 
and STATUS = 0;

select *
from [MDPOC].[dbo].[BMS_PRO_GANTRY]
where STATUS = 1 ;

select GANTRY_NAME, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_PRO_GANTRY]
group by GANTRY_NAME; 

select GANTRY_NAME, counting = count(*), total = (sum(count(*)) over() ),'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_PRO_GANTRY]
group by GANTRY_NAME
having count(*) > 1 ;

select *
from [MDPOC].[dbo].[BMS_PRO_GANTRY] as G
where G.GANTRY_NAME in  (
		select GANTRY_NAME
		from [MDPOC].[dbo].[BMS_PRO_GANTRY]
		group by GANTRY_NAME
		having count(*) > 1
		) 
and STATUS = 0;


select DEAD_TIME, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from  [MDPOC].[dbo].[BMS_PRO_GANTRY]
/* where DEAD_TIME = '3000-01-01 00:00:00.000' */
group by DEAD_TIME ; 

select  LOCATION, GANTRY_ID, GANTRY_NAME, HIGHWAY_ID, DIRECTION_ID /*, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over()) */
from  [MDPOC].[dbo].[BMS_PRO_GANTRY]
where LOCATION = 0.5 ; 

select LOCATION, GANTRY_ID, GANTRY_NAME, HIGHWAY_ID, DIRECTION_ID
from [MDPOC].[dbo].[BMS_PRO_GANTRY] as G
where G.LOCATION in  (
		select LOCATION
		from [MDPOC].[dbo].[BMS_PRO_GANTRY]
		group by LOCATION
		having count(*) = 2
		) 
group by LOCATION, GANTRY_ID, GANTRY_NAME, HIGHWAY_ID, DIRECTION_ID
order by LOCATION;


/* using INNER JOIN to get the information on each code */

select APPEAL_OFFICE_ID, APPEAL_OFFICE_TYPE, code.CODE_NAME, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_PRO_GANTRY] AS gan
	inner join [MDPOC].[dbo].[BMS_PRO_CODES] AS code
	on  code.CODE_ID = gan.APPEAL_OFFICE_ID and CODE_TYPE = gan.APPEAL_OFFICE_TYPE
group by APPEAL_OFFICE_ID, APPEAL_OFFICE_TYPE, code.CODE_NAME ;



select count(*)  FROM [MDPOC].[dbo].[BMS_PRO_GANTRY];

/* End table2 */

/* Table3 : PRO_GANTRY */

select LPRNumber1, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from  [MDPOC].[dbo].[GANTRY_DATA]
/* where DEAD_TIME = '3000-01-01 00:00:00.000' */
group by LPRNumber1 ; 

/* End table3 */
select CODE_TYPE, COUNT(CODE_TYPE)
from [MDPOC].[dbo].[BMS_PRO_CODES]
group by CODE_TYPE; 

  select OWNER_ID ,  count(OWNER_ID)
  from [MDPOC].[dbo].[BMS_PRO_VEHICLE]
  group by OWNER_ID;

 select count(*) from [MDPOC].[dbo].[BMS_PRO_VEHICLE];

  select count(*) from [MDPOC].[dbo].[GANTRY_DATA]

  select DATA_TYPE from INFORMATION_SCHEMA.COLUMNS IC where TABLE_NAME = 'GANTRY_DATA' and COLUMN_NAME = 'TransactionTime'

  exec sp_help GantryData_20171115;
  use MDPOC;
  GO


select top 1 TransactionTime
from MDPOC.dbo.GANTRY_DATA
order by TransactionTime desc;

select count(*)
from MDPOC.dbo.GANTRY_DATA ;


SELECT @@SERVERNAME;