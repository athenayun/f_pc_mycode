select MatchingRule, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[GANTRY_LOG]
group by MatchingRule


select OcrFlag, counting = count(*), 'percentage(%)' =(count(*) * 100.0 / sum(count(*)) over())
from [MDPOC].[dbo].[GANTRY_LOG]
group by OcrFlag