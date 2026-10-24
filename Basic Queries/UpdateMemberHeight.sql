USE GYMDB;
GO

DECLARE @MemberID INT = 1;
DECLARE @NewHeight DECIMAL(5,2) = 170.50;

UPDATE GymMember
SET Height = @NewHeight
WHERE MemberID = @MemberID;