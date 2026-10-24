USE GYMDB;
GO

SELECT m.FirstName + ' ' + m.LastName AS MemberName,
	   mp.MembershipPlanName,
	   ms.SessionsLeft,
	   ms.SubscriptionStatus
FROM GymMember m
JOIN MembershipSubscription ms ON m.MemberID = ms.MemberID
JOIN MembershipPlan mp ON ms.MembershipPlanID = mp.MembershipPlanID
WHERE ms.SubscriptionStatus = 'Active';