USE GYMDB;
GO

SELECT 
    MemberID,
    FirstName,
    LastName,
    DateOfBirth,
    DATEDIFF(YEAR, DateOfBirth, GETDATE()) AS Age
FROM GymMember;

--P.S. this query can also be used for calculating the age of staff members.