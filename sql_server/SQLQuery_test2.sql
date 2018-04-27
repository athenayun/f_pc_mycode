
/* Table4 : PRO_VEHICLE */

select CONSUMER_ID, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from  [MDPOC].[dbo].[BMS_PRO_VEHICLE]
/* where DEAD_TIME = '3000-01-01 00:00:00.000' */
group by CONSUMER_ID ; 

select count(*)  FROM [MDPOC].[dbo].[BMS_PRO_VEHICLE];

select LPR_Number
from [MDPOC].[dbo].[BMS_PRO_VEHICLE] as V
where V.LPR_Number in  (
		select LPR_Number
		from [MDPOC].[dbo].[BMS_PRO_VEHICLE]
		group by LPR_Number
		having count(*) > 1		) ;


select CONSUMER_ID, count(*), sum(count(*)) over()
from [MDPOC].[dbo].[BMS_PRO_VEHICLE]
group by CONSUMER_ID
having count(*) > 1 ;
		 
select (1215231+3229212+480452+231705+1508717);

select MVDIS_CATEGORY, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from  [MDPOC].[dbo].[BMS_PRO_VEHICLE]
/* where DEAD_TIME = '3000-01-01 00:00:00.000' */
group by MVDIS_CATEGORY ; 

select IDENTITY_ID, IDENTITY_TYPE, code.CODE_NAME, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_PRO_VEHICLE] AS gan
	inner join [MDPOC].[dbo].[BMS_PRO_CODES] AS code
	on  code.CODE_ID = gan.IDENTITY_ID and CODE_TYPE = gan.IDENTITY_TYPE
group by IDENTITY_ID, IDENTITY_TYPE, code.CODE_NAME ;

/* End table4 */