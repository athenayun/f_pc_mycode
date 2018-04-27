
/* Table5 : TAG_ETAG */

select count(*)  FROM [MDPOC].[dbo].[BMS_TAG_ETAG];

select WARRANTY_EXPIRATION_DATE, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from  [MDPOC].[dbo].[BMS_TAG_ETAG]
/* where DEAD_TIME = '3000-01-01 00:00:00.000' */
group by WARRANTY_EXPIRATION_DATE
order by TRFF_ID; 

select WARRANTY_EXPIRATION_DATE, counting = count(*), total = sum(count(*)) over()
from [MDPOC].[dbo].[BMS_TAG_ETAG]
group by WARRANTY_EXPIRATION_DATE
having count(*) > 1 ;

/* End table5 */


/* Table6 : TAG_TRFF */

select count(*)  FROM [MDPOC].[dbo].[BMS_TAG_TRFF];

select TRFF_TIME , counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from  [MDPOC].[dbo].[BMS_TAG_TRFF]
/* where DEAD_TIME = '3000-01-01 00:00:00.000' */
group by TRFF_TIME ;

select TRFF_TIME, counting = count(*), total = sum(count(*)) over()
from [MDPOC].[dbo].[BMS_TAG_TRFF]
group by TRFF_TIME
having count(*) > 1 ;


select trff.MODEL_NO_ID,  model.MODEL_NO_NAME, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[BMS_TAG_TRFF] AS trff
	inner join [MDPOC].[dbo].[BMS_TAG_MODEL_NO] AS model
	on  model.MODEL_NO_ID = trff.MODEL_NO_ID 
group by trff.MODEL_NO_ID,  model.MODEL_NO_NAME 
order by trff.MODEL_NO_ID ;


/* End table6 */