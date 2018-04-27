-- filter out the specific gantry (Services Area)

select LPRNumber1, LaneSystemID, TransactionTime
from [athena_practice].[dbo].[GantryData_20171115]
where LaneSystemID in ('01F1621N', '01F1572N')
group by LPRNumber1, LaneSystemID, TransactionTime ;


select LPRNumber1, count(*)
from [athena_practice].[dbo].[GantryData_20171115]
where LaneSystemID in ('01F1621N', '01F1572N')
group by LPRNumber1 ;

-- this has problem : 沒有為 'LPR' 的資料行 2 指定任何資料行名稱。
select *
from (	select LPRNumber1, count(*)
		from [athena_practice].[dbo].[GantryData_20171115] AS G
		where G.LaneSystemID in ('01F1621N', '01F1572N')
		group by G.LPRNumber1 ) as LPR
where LPR.LPRNumber1 = '0xCA558E0E667EA7BC778779C75AD155D0A562BCE6' ;

-- this is okay , but not effective
select LPRNumber1, count(*)
		from [athena_practice].[dbo].[GantryData_20171115] AS G
		where G.LaneSystemID in ('01F1621N', '01F1572N')
		group by G.LPRNumber1
		having LPRNumber1 = '0xCA558E0E667EA7BC778779C75AD155D0A562BCE6'


-- this has problem : 當子查詢並未由 EXISTS 導入時，只能在選取清單中指定一個運算式。
select *
from [athena_practice].[dbo].[GantryData_20171115] AS G
where EXISTS (select LPRNumber1, count(*)
					from [athena_practice].[dbo].[GantryData_20171115] AS Gan
					where Gan.LaneSystemID in ('01F1621N', '01F1572N')
					group by Gan.LPRNumber1
					/* having Gan.LPRNumber1 = '0xCA558E0E667EA7BC778779C75AD155D0A562BCE6' */ )
	and G.LPRNumber1 = '0xCA558E0E667EA7BC778779C75AD155D0A562BCE6'
order by TransactionTime

-- editing the statement above, for selecting only one car
select *
from [athena_practice].[dbo].[GantryData_20171115] AS G
where G.LaneSystemID in ('01F1621N', '01F1572N')
		and G.LPRNumber1 = '0x2A0D1EFD55540D8A702FF64A5A33F3A742F3EF7C'
order by TransactionTime

-- selecting only one car
select *
from [athena_practice].[dbo].[GantryData_20171115] AS G
where G.LPRNumber1 = '0x2A0D1EFD55540D8A702FF64A5A33F3A742F3EF7C'
order by TransactionTime

/***
passing times (cars example):
1 : 0xE5C36782D73EF9454783D4DF4810D46C5986DF03 (3)
2 : 0x00030B2F1B8AD75C4D5BB8D8D8D277FF0B4C9C55 (3)
3 : 0x0114EC3DA35C8223F16845708767FCE5B2E7048E (5)
4 : 0x004264A90BE47C532CA69B401E57872BE0C47A72 (3)
5 : 0x08B7173B77298645B7FEC3ED0DE23529C1857096 (5)
	0x2A0D1EFD55540D8A702FF64A5A33F3A742F3EF7C (3)
6 : 
7 :
8 :
9 :

***/


-- try filter out all the possible cars passing the gantry
select *, count(*)
from (	select *
		from [athena_practice].[dbo].[GantryData_20171115] AS Gan
		where Gan.LaneSystemID in ('01F1621N', '01F1572N') ) AS F
group by F.LPRNumber1
order by F.TransactionTime

-- the success query recently 
select LPRNumber1, CATEGORY, count(*) 
from [athena_practice].[dbo].[GantryData_20171115] AS Gan
where Gan.LaneSystemID  in ('01F1621N', '01F1572N')
and Gan.LPRNumber1  in (	select LPRNumber1
							from [athena_practice].[dbo].[GantryData_20171115] AS G
							where G.LaneSystemID in ('01F1621N', '01F1572N')
							group by G.LPRNumber1
							having count(*)>1 )
group by Gan.LPRNumber1, CATEGORY
having count(LPRNumber1) = 5 
order by Gan.LPRNumber1


USE athena_practice;

SELECT LPRNumber1, COUNT(*)
from [athena_practice].[dbo].[GantryData_20171115]
GROUP BY LPRNumber1

