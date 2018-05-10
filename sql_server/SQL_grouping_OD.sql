select *
FROM [athena_practice].[dbo].[GantryData_20171115]
where LPRNumber1 in (	select LPRNumber1
						FROM [athena_practice].[dbo].[GantryData_20171115]
						group by
						)



SELECT x = SUBSTRING('01F0339SA20171115T23476160758_0', -2, 10);

select left('01F0339SA20171115T23476160758_0',CHARINDEX('_','01F0339SA20171115T23476160758_0')-1)