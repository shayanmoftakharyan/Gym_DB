USE GYMDB;
GO

SELECT 
    StaffID,
    FirstName,
    LastName,
    DateOfHire,
    CAST(DATEDIFF(YEAR, DateOfHire, GETDATE()) AS VARCHAR) + ' years and ' +
    CAST(DATEDIFF(MONTH, DateOfHire, GETDATE()) % 12 AS VARCHAR) + ' months'
    AS DurationofEmployment
FROM Staff;