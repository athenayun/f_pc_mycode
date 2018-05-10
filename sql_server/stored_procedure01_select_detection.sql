-- statement block start with BEGIN end with END

-- this is some try and error code for selecting the MDSequenceNum with error
declare @md_num nvarchar(100)

select @md_num = MDSequenceNum
from [athena_practice].[dbo].[GantryData_20171115]
where MDSequenceNum like '%e_0' escape 'e' ;


select left( @md_num ,CHARINDEX('_', @md_num )-1) as MDSequenceNum ;


--out print the test result

declare cursor_name cursor for	(	select MDSequenceNum 
									from [athena_practice].[dbo].[GantryData_20171115] 
									where MDSequenceNum like '%e_0' escape 'e' )
declare @i varchar(100)
open cursor_name
fetch next from cursor_name into @i
while @@FETCH_STATUS = 0
begin
	print left( @i ,CHARINDEX('_', @i )-1) 
	fetch next from cursor_name into @i
end
close cursor_name
deallocate cursor_name

-- NOTICE : the outcome are detected_error MDSequenceNum
--wow! the result above looks perfectly well hahaha

--try using this procedure to select detected_error data 

declare cursor_name cursor for	(	select MDSequenceNum 
									from [athena_practice].[dbo].[GantryData_20171115] 
									where MDSequenceNum like '%e_0' escape 'e' )
declare @i varchar(100)
open cursor_name
fetch next from cursor_name into @i
while @@FETCH_STATUS = 0
begin
	
	(select *
	from [athena_practice].[dbo].[GantryData_20171115]
	where MDSequenceNum = left( @i ,CHARINDEX('_', @i )-1) )
	
	--print left( @i ,CHARINDEX('_', @i )-1) 
	fetch next from cursor_name into @i
end
close cursor_name
deallocate cursor_name

-- well, it's working, but not so efficient with one row at a time (using fetch and cursor )
--let's try using batch result for cursor <sp_cursor_list>

-- try using sp_cursor_list 

USE athena_practice;  
GO  
-- Declare and open a keyset-driven cursor.  
DECLARE test CURSOR KEYSET FOR  
select MDSequenceNum 
from [athena_practice].[dbo].[GantryData_20171115] 
where MDSequenceNum like '%e_0' escape 'e';  
OPEN test;  

-- Declare a cursor variable to hold the cursor output variable  
-- from sp_cursor_list.  
DECLARE @Result CURSOR;  

-- Execute sp_cursor_list into the cursor variable.  
EXEC master.dbo.sp_cursor_list @cursor_return = @Result OUTPUT,  
      @cursor_scope = 2;  
	  -- @cursor_scope : 1=local variable ; 2=global variable
-- Fetch all the rows from the sp_cursor_list output cursor.  
FETCH NEXT from @Result;  
WHILE (@@FETCH_STATUS <> -1)  
BEGIN  
   
   --print @Result
   FETCH NEXT from @Result;  
END  

-- Close and deallocate the cursor from sp_cursor_list.  
CLOSE @Result;  
DEALLOCATE @Result;  
GO  

-- Close and deallocate the original cursor.  
CLOSE test;  
DEALLOCATE test;  
GO  


--EXAMPLE FOR SET-BASED

declare cur cursor for
select X from XXX

declare @x int
open cur
fetch next from cur into @x

while @@FETCH_STATUS = 0
BEGIN
    exec A @x

    fetch next from cur into @x
END

--END SESSION--