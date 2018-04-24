SELECT * FROM db_test.group4data_trial_4;

select CarBrand_Ultimate, count(*), round(avg(AverageSpeed), 2), round(avg(AverageDistance), 2)
FROM db_test.group4data_trial_4
group by CarBrand_Ultimate ;

truncate group4data_trial_4 ;

select count(*)
from db_test.group4data_trial_4 
where TotalKM2017 between 3000 and 4000 ;

select count(*)
from db_test.group4data_trial_3 
where TotalKM2017 > 81000 ;

select (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 71000 and 72000 ), 
	   (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 72000 and 73000 ) ,
	   (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 73000 and 74000 ),
	   (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 74000 and 75000 ),
        (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 75000 and 76000 ),
        (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 76000 and 77000 ),
        (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 77000 and 78000 ),
        (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 78000 and 79000 ),
        (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 79000 and 80000 ),
        (select count(*)
		from db_test.group4data_trial_4 
		where TotalKM2017 between 80000 and 81000 ) ;
       
       
       
select RegisteredCarCategory, count(*)
FROM db_test.group4data_trial_4
group by RegisteredCarCategory ;

select CarBrand_Ultimate, count(*)
FROM db_test.group4data_trial_4
group by CarBrand_Ultimate ;

select count(*) FROM db_test.group4data_trial_4 ;