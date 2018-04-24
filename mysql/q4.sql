SELECT * FROM db_test.group4data_trial_6;

describe db_test.group4data_trial_6;

select count(*) FROM db_test.group4data_trial_6;

select CarBrand_Ultimate, count(*)
FROM db_test.group4data_trial_5
group by CarBrand_Ultimate ;

select *
FROM db_test.group4data_trial_5
where TotalKM2017 = '-' ;

describe brand_mazda;


SELECT * FROM db_test.group4data_trial_complete_wthym;

select (2018- CarProduced_Year )
FROM db_test.group4data_trial_complete_wthym ;

select count(*) FROM db_test.group4data_trial_complete_wthym ;

select NightPassingRatio, count(*)
FROM db_test.group4data_trial_complete_wthym
group by NightPassingRatio ;

select RegisteredCarCategory, round(avg(DayPassingRatio), 2), round(avg(NightPassingRatio), 2)
FROM db_test.group4data_trial_complete_wthym
group by RegisteredCarCategory ;

select CarProduced_Month, count(*)
FROM db_test.group4data_trial_complete_wthym
group by CarProduced_Month ;
