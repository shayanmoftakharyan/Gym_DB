USE GYMDB;
GO

SELECT 
    s.StaffID,
    s.FirstName,
    s.LastName,
    MONTH(sa.DateofAttendance)                              AS MonthofWork,
    YEAR(sa.DateofAttendance)                               AS YearofWork,
    SUM(DATEDIFF(MINUTE, sa.CheckInTime, sa.CheckOutTime)) / 60.0 AS TotalHoursWorked
FROM Staff s
JOIN StaffAttendance sa ON s.StaffID = sa.StaffID
WHERE sa.CheckOutTime IS NOT NULL AND MONTH(sa.DateofAttendance) = '6' AND YEAR(sa.DateofAttendance) = '2020'
GROUP BY s.StaffID, s.FirstName, s.LastName, MONTH(sa.DateofAttendance), YEAR(sa.DateofAttendance)
ORDER BY YEAR(sa.DateofAttendance), MONTH(sa.DateofAttendance), s.LastName;