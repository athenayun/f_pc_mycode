
--This would tell us how many times the outer cursor has looped already

SELECT execution_count, st.text
FROM sys.dm_exec_query_stats as qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as st
WHERE st.text like '%fetch next from  i_hate_cursor into%'
fetch next from  i_hate_cursor into

FETCH NEXT FROM i_hate_cursor INTO
exec sp_cursor_list ;

/* NOTE

FAST_FORWARD - specifies that cursor will be FORWARD_ONLY and READ_ONLY cursor. 
The FAST_FORWARD cursors produce the least amount of overhead on SQL Server.

Specifies a FORWARD_ONLY, READ_ONLY cursor with performance optimizations enabled. 
FAST_FORWARD cannot be specified if SCROLL or FOR_UPDATE is also specified.

Just keep in mind that FAST_FORWARD is DYNAMIC ... 
FORWARD_ONLY you can use with a STATIC cursor.

It¡¦s pretty obvious that the LOCAL and FAST_FORWARD options on cursors provide a less resource intensive execution. 

*/


--example for performance tuning

BEGIN TRANSACTION

declare @cnt int
declare @test nvarchar(128)
-- variable to hold table name
declare @tableName nvarchar(255)
declare @cmd nvarchar(500) 
-- local means the cursor name is private to this code
-- fast_forward enables some speed optimizations
declare Tests cursor local fast_forward for
 SELECT COLUMN_NAME, TABLE_NAME
   FROM INFORMATION_SCHEMA.COLUMNS 
  WHERE COLUMN_NAME LIKE 'pct%' 
    AND TABLE_NAME LIKE 'TestData%'

open Tests
-- Instead of fetching twice, I rather set up no-exit loop
while 1 = 1
BEGIN
  -- And then fetch
  fetch next from Tests into @test, @tableName
  -- And then, if no row is fetched, exit the loop
  if @@fetch_status <> 0
  begin
     break
  end
  -- Quotename is needed if you ever use special characters
  -- in table/column names. Spaces, reserved words etc.
  -- Other changes add apostrophes at right places.
  set @cmd = N'exec sp_rename ''' 
           + quotename(@tableName) 
           + '.' 
           + quotename(@test) 
           + N''',''' 
           + RIGHT(@test,LEN(@test)-3) 
           + '_Pct''' 
           + N', ''column''' 

  print @cmd

  EXEC sp_executeSQL @cmd
END

close Tests 
deallocate Tests

ROLLBACK TRANSACTION
--COMMIT TRANSACTION


-- If you don't know which procedures in your database are using cursors, you can quickly find out using a query like:
SELECT Object_name(object_id) as [Procedure Name],
       Object_definition(object_id) as [Definition]
FROM   sys.procedures
WHERE  Object_definition(object_id) LIKE '%cursor%'
Order by [Procedure Name]


