BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Table_1
	(
	VEHICLE_ID nchar(20) NOT NULL,
	DetectedCarCategory nchar(10) NULL,
	IdentityType nchar(10) NULL,
	CarBrand nchar(20) NULL,
	RegisteredCarCategory nchar(10) NULL,
	CarFactorized_YM nchar(10) NULL,
	OwnerGender nchar(10) NULL,
	CarCounty nchar(10) NULL,
	TotalKM2017 nchar(10) NULL,
	TotalDay2017 nchar(10) NULL,
	AverageDistance nchar(10) NULL,
	DelayedPayBillTimes nchar(10) NULL,
	WeekdayRatio nchar(10) NULL,
	WeekendRatio nchar(10) NULL,
	NorthRatio float(53) NULL,
	MidRatio float(53) NULL,
	SouthRatio float(53) NULL,
	DayPassingRatio float(53) NULL,
	NightPassingRatio float(53) NULL,
	AverageSpeed nchar(10) NULL,
	OverSpeedRatio float(53) NULL,
	bigger350KM nchar(10) NULL,
	ACL_days float(53) NULL,
	CarBrand_Ultimate nchar(20) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Table_1 ADD CONSTRAINT
	PK_Table_1 PRIMARY KEY CLUSTERED 
	(
	VEHICLE_ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Table_1 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
