USE GYMDB;
GO

DECLARE @MembershipSubscriptionID INT = 1;

IF (
    SELECT SessionsLeft 
    FROM MembershipSubscription 
    WHERE MembershipSubscriptionID = @MembershipSubscriptionID
) > 0
BEGIN
    INSERT INTO MemberAttendance (CheckInTime, CheckOutTime, AttendanceDate, MembershipSubscriptionID)
    VALUES (CAST(GETDATE() AS TIME), NULL, CAST(GETDATE() AS DATE), @MembershipSubscriptionID);

    UPDATE MembershipSubscription
    SET SessionsLeft = SessionsLeft - 1
    WHERE MembershipSubscriptionID = @MembershipSubscriptionID;

    PRINT 'Attendance recorded. Session deducted.';
END
ELSE
BEGIN
    UPDATE MembershipSubscription
    SET SubscriptionStatus = 'Expired'
    WHERE MembershipSubscriptionID = @MembershipSubscriptionID;

    PRINT 'No sessions left. Subscription has been marked as Expired.';
END