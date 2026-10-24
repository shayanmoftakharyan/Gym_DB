USE GYMDB;
SET DATEFORMAT mdy;
GO

insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Basic Plan', 30, 1000000);
insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Basic Plan', 90, 2500000);
insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Basic Plan', 120, 5200000);
insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Basic Plan', 360, 10500000);

insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Silver Plan', 30, 2000000);
insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Silver Plan', 90, 5000000);
insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Silver Plan', 120, 1000000);
insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Silver Plan', 360, 2000000);

insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Gold Plan', 30, 3500000);
insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Gold Plan', 90, 9000000);
insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Gold Plan', 120, 17000000);
insert into MembershipPlan (MembershipPlanName, Duration, Price) values ('Gold Plan', 360, 32000000);