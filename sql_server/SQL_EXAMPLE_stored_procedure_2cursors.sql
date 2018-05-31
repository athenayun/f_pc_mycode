declare @a1 int, @b1 int -- for table fields
declare @a2 int, @b2 int -- for table fields
 
declare c1 cursor for
 select a1,b1 from table1
open c1
fetch next from c1 into @a1, @b1
while @@fetch_status = 0 begin
 
 declare c2 cursor for
  select a2, b2 from table2 where a2=@a1
 open c2
 fetch next from c2 into @a2, @b2
 while @@fetch_status = 0 begin
 
  select 'Table1 (a/b):', @a1, @b1, 'Table2 (a/b):', @a2, @b2
 
  fetch next from c2 into @a2, @b2
 end
 close c2
 deallocate c2
 
 fetch next from c1 into @a1, @b1
end
close c1
deallocate c1