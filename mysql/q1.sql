use db_test;

SELECT CarBrand FROM db_test.group4data_trial_1
group by CarBrand;

create table CarBrand as 
(	SELECT  CarBrand 
	FROM db_test.group4data_trial_1
	group by CarBrand);
    
SELECT CarCounty, count(*) FROM db_test.group4data_trial_1
group by CarCounty;    

SELECT * FROM db_test.cluster_1_0;
select count(*) FROM db_test.cluster_1_0 ;

-- create new table like

create table data_5000_wth_ages like group4data_trial_complete_wthym ;

describe cluster_1_0 ;

select CarCounty, count(*)
FROM db_test.cluster_1_4
group by CarCounty ;

SELECT * FROM db_test.group4data_trial_complete;


LOAD DATA LOCAL INFILE
'C://Users//Administrator//Documents//code//data//DTP_D4//CarBrand_data//with_ages//NAZJE_ages.csv' INTO TABLE `brand_luxgen`
CHARACTER SET 'utf8'
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

