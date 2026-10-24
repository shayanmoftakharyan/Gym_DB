USE GYMDB;
GO

DECLARE @MemberID INT = 34;
DECLARE @LockerID INT = 12;

IF (
    SELECT MemberID 
    FROM Locker 
    WHERE LockerID = @LockerID
) IS NULL
BEGIN
    UPDATE Locker
    SET MemberID = @MemberID
    WHERE LockerID = @LockerID;

    INSERT INTO LockerHistory (DateofAssignment, StartTime, EndTime, LockerID, MemberID)
    VALUES (CAST(GETDATE() AS DATE), CAST(GETDATE() AS TIME), NULL, @LockerID, @MemberID);

    PRINT 'Locker successfully assigned to member.';
END
ELSE
BEGIN
    PRINT 'Locker is already occupied. Please choose a different locker.';
END