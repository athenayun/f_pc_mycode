SELECT * FROM db_test.group4data_trial_1;

SELECT * FROM db_test.group4data_trial_1
order by '車輛出廠年月';

describe db_test.group4data_trial_1;



use db_test ;


alter table group4data_trial_1
change 車輛廠牌 CarBrand text;


alter table group4data_trial_1
change 監理車種 RegisteredCarCategory int(11);


alter table group4data_trial_1
change 車輛出廠年月 CarFactorized_YM int(11);

alter table group4data_trial_1
change 車主性別 OwnerGender text;

alter table group4data_trial_1
change 車籍縣市 CarCounty text;

alter table group4data_trial_1
change column '總里程-2017' TotalKM2017 double;

alter table group4data_trial_1
change 通行天數-2017 TotalDay2017	 int(11);

alter table group4data_trial_1
change 平均通行距離 AverageDistance	int(11);

alter table group4data_trial_1
change 出帳次數 DelayedPayBillTimes	int(11);
alter table group4data_trial_1
change 平日通行百分比 	WeekdayRatio	int(11);
alter table group4data_trial_1
change 假日通行百分比 	WeekendRatio	int(11);

alter table group4data_trial_1
change 北區通行比例 	NorthRatio text;

alter table group4data_trial_1
change 中區通行比例 MidRatio text;

alter table group4data_trial_1
change 南區通行比例		SouthRatio text;

alter table group4data_trial_1
change 白天通行比例 		DayPassingRatio text;

alter table group4data_trial_1
change 夜間通行比例 	NightPassingRatio text;
-- 		AverageSpeed	OverSpeedRatio	>350KM	ACL_days
