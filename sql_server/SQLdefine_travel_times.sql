select MDSequenceNum
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum like '%e_0' escape 'e' ;

select *
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum like '%e_0' escape 'e' 
and LPRNumber1 is NOT NULL ;

select *
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum = '01F3460SA20171115T223091393029' 
or MDSequenceNum = '01F3460SA20171115T223091393029_0' ;

/* records having LPRNumber1

	03F1710SA20171115T000054410178_0
	01F0750NA20171115T0000104178867_0
	01F3686SA20171115T0000129006437_0
	03F0136SA20171115T000067554649_0
	03F1395SA20171115T075250475790_0
	01F0928NA20171115T0752120927520_0
	...more

*/


/* records having no LPRNumber1 or LPRNumber2 

**LPRNumber1 = NULL
	01F3460SA20171115T223091393029_0
	01F0005SA20171115T235937787492_0
	03F2129SA20171115T235994974209_0
	01F0467SA20171115T2354136729125_0
	03F0559NA20171115T2353103188338_0
	01F0928SA20171115T2353121689171_0
	01F0155NA20171115T235399276333_0
	01F0467SA20171115T2352136729089_0
	01H0447SA20171115T235275481667_0
	03F0846NA20171115T235064956271_0
	01F0339SA20171115T23476160758_0
	...more
*/


select *
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum in (	select MDSequenceNum
							from [athena_practice].[dbo].[GantryData_20171115]
							where MDSequenceNum like '%e_0' escape 'e' 
						) ;

-- trying to read string content from file

Select dbo.ufsReadfileAsString ('C:\Users\Administrator\Documents\code\data\gantry_data','MyFileName')

--session end--

-- try & error --

select quotename('01F0339SA20171115T23476160758\_0','\_') ;

-- SELECT trim( '_0' FROM  '01F0339SA20171115T23476160758_0') AS Result ; <wrong>

SELECT x = SUBSTRING('01F0339SA20171115T23476160758_0', -1, 10);  

select STRING_SPLIT('01F0339SA20171115T23476160758_0', '_') ;

SELECT value FROM STRING_SPLIT('01F0339SA20171115T23476160758_0', '_');

select *  FROM [athena_practice].[dbo].[GantryData_20171115];
-- session end --

-- EXAMPLE for sth --

DECLARE @String varchar(100) = 'String1,String2,String3'
-- To change ',' to any other delimeter, just change ',' to your desired one
DECLARE @Delimiter CHAR = ','    

SELECT LTRIM(RTRIM(Split.a.value('.', 'VARCHAR(100)'))) 'Value' 
FROM  
(     
     SELECT CAST ('<M>' + REPLACE(@String, @Delimiter, '</M><M>') + '</M>' AS XML) AS Data            
) AS A 
CROSS APPLY Data.nodes ('/M') AS Split(a)

--session end --

select left('01F0339SA20171115T23476160758_0',CHARINDEX('_','01F0339SA20171115T23476160758_0')-1) ;

--start

declare @md_table  table
(
   md_num nvarchar(100)
)

declare @md_num nvarchar(100)

select @md_num = MDSequenceNum
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum like '%e_0' escape 'e' ;


select left( @md_num ,CHARINDEX('_', @md_num )-1) as MDSequenceNum ;


declare @md_table  table
(
   md_num nvarchar(100)
)
SELECT 
    MDSequenceNum
INTO 
    @md_table 
FROM 
    [athena_practice].[dbo].[GantryData_20171115]
WHERE 
    MDSequenceNum like '%e_0' escape 'e' ;
