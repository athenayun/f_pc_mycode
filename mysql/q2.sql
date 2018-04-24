SELECT * FROM db_test.group4data_trial_3;

select count(*)
FROM db_test.group4data_trial_3
where DelayedPayBillTimes =0 ;

select distinct DelayedPayBillTimes
FROM db_test.group4data_trial_3 
order by DelayedPayBillTimes;

select DelayedPayBillTimes, count(*)
FROM db_test.group4data_trial_3 
group by DelayedPayBillTimes;

create table cluster_1_0 like group4data_trial_6 ;

select OwnerGender, count(*)
from db_test.group4data_trial_3 
group by OwnerGender ;

select  CarFactorized_YM, count(*)
FROM db_test.group4data_trial_3 
group by CarFactorized_YM
order by CarFactorized_YM ;

select RegisteredCarCategory, avg(DayPassingRatio), avg(NightPassingRatio), avg(NorthRatio), avg(MidRatio), avg(SouthRatio), round(avg(OverSpeedRatio), 3), round(avg(TotalKM2017), 2)
from db_test.group4data_trial_3 
group by RegisteredCarCategory ;

select OverSpeedRatio, count(*)
from db_test.group4data_trial_3 
group by OverSpeedRatio ;

select TotalKM2017, max(TotalKM2017), min(TotalKM2017), avg(TotalKM2017)
from db_test.group4data_trial_3 
order by TotalKM2017 ;

select count(*)
from db_test.group4data_trial_3 
where TotalKM2017 between 8000 and 10000 ;

select count(*)
from db_test.group4data_trial_3 
where TotalKM2017 > 80000 ;
