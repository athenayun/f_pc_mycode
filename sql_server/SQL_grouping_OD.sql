select *
FROM [athena_practice].[dbo].[GantryData_20171115]
where LPRNumber1 in (	select LPRNumber1
						FROM [athena_practice].[dbo].[GantryData_20171115]
						group by
						)