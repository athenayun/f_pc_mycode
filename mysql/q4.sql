SELECT * FROM db_test.group4data_trial_6;

describe db_test.group4data_trial_6;

select count(*) FROM db_test.group4data_trial_6;

select CarBrand_Ultimate, count(*)
FROM db_test.group4data_trial_5
group by CarBrand_Ultimate ;

select *
FROM db_test.group4data_trial_5
where TotalKM2017 = '-' ;