DECLARE @MemberID  INT = 1;
DECLARE @LockerID  INT = 3;

IF (
    SELECT MemberID 
    FROM Locker 
    WHERE LockerID = @LockerID
) = @MemberID
BEGIN
    UPDATE LockerHistory
    SET EndTime = CAST(GETDATE() AS TIME)
    WHERE LockerID = @LockerID
    AND MemberID = @MemberID
    AND EndTime IS NULL;

    UPDATE Locker
    SET MemberID = NULL
    WHERE LockerID = @LockerID;

    PRINT 'Locker successfully returned.';
END
ELSE
BEGIN
    PRINT 'This member is not assigned to this locker.';
END