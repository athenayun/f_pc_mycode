select CONTRACT_ID, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from  [MDPOC].[dbo].[BMS_PRO_VEHICLE]
/* where DEAD_TIME = '3000-01-01 00:00:00.000' */
group by CONTRACT_ID 
having count(*)>1 ; 

select *
from  [MDPOC].[dbo].[BMS_PRO_VEHICLE]
where CONTRACT_ID IS NULL