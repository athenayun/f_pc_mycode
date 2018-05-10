create schema db_tdcs ;
use db_tdcs ;

create table m01_all (
						UniqueSequence varchar(50) NOT NULL PRIMARY KEY,
                        Gantry varchar(20) NOT NULL,
                        Lane varchar(10) NOT NULL,
                        Date_Time varchar(50) NOT NULL, 
                        CarType varchar(10) NOT NULL,
                        Direction varchar(10) NOT NULL
                        ) ;
                        
truncate m01_all ;

select count(*) FROM db_tdcs.m01_all_total;

select UniqueSequence, count(*)
FROM db_tdcs.m01_all_total
group by UniqueSequence;

select * 
FROM db_tdcs.m01_all
where UniqueSequence in (	select UniqueSequence
							FROM db_tdcs.m01_all as m1
							group by m1.UniqueSequence)
order by Date_Time;

select *
FROM db_tdcs.m01_all
where UniqueSequence = "0005e5106676716da147ca5f03802d81"
order by Date_Time;
