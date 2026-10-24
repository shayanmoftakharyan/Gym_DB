USE GYMDB;
GO

SELECT DISTINCT m.FirstName + ' ' + m.LastName AS MemeberName
FROM MemberAttendance ma
JOIN MembershipSubscription ms ON ma.MembershipSubscriptionID = ms.MembershipSubscriptionID
JOIN GymMember m ON ms.MemberID = m.MemberID
WHERE ma.AttendanceDate = '2024-08-23';