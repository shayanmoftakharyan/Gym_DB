DECLARE @MembershipSubscriptionID INT = 1;
DECLARE @ClassID INT = 2;

DECLARE @MembershipPlanID INT = (
    SELECT MembershipPlanID 
    FROM MembershipSubscription 
    WHERE MembershipSubscriptionID = @MembershipSubscriptionID
);

IF NOT EXISTS (
    SELECT * FROM PlanAllowedClasses
    WHERE ClassID = @ClassID
    AND MembershipPlanID = @MembershipPlanID
)
BEGIN
    PRINT 'This class is not included in the member''s plan. Registration failed.';
END

ELSE IF (
    SELECT c.Capacity - c.NumberOfParticipants
    FROM Class c
    WHERE c.ClassID = @ClassID
) <= 0
BEGIN
    PRINT 'Class is full. Registration failed.';
END

ELSE
BEGIN
    INSERT INTO ClassRegistration (RegistrationDate, RegistryStatus, ClassID, MembershipSubscriptionID)
    VALUES (CAST(GETDATE() AS DATE), 'Active', @ClassID, @MembershipSubscriptionID);

    UPDATE Class
    SET NumberOfParticipants = NumberOfParticipants + 1
    WHERE ClassID = @ClassID;

    UPDATE Coach
    SET NumberOfTrainees = NumberOfTrainees + 1
    WHERE StaffID = (
        SELECT StaffID 
        FROM Class 
        WHERE ClassID = @ClassID
    );

    PRINT 'Registration successful.';
END