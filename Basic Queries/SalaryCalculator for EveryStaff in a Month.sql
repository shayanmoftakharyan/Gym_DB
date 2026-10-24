USE GYMDB;
GO

SELECT 
    s.StaffID,
    s.FirstName,
    s.LastName,
    s.HourlyRate,
    MONTH(sa.DateofAttendance)                              AS MonthofWork,
    YEAR(sa.DateofAttendance)                               AS YearofWork,
    SUM(DATEDIFF(MINUTE, sa.CheckInTime, sa.CheckOutTime)) / 60.0 AS TotalHoursWorked,
    SUM(DATEDIFF(MINUTE, sa.CheckInTime, sa.CheckOutTime)) / 60.0 * s.HourlyRate AS MonthlySalary
FROM Staff s
JOIN StaffAttendance sa ON s.StaffID = sa.StaffID
WHERE sa.CheckOutTime IS NOT NULL AND MONTH(sa.DateofAttendance) = '6' AND YEAR(sa.DateofAttendance) = '2020'
GROUP BY s.StaffID, s.FirstName, s.LastName, s.HourlyRate, MONTH(sa.DateofAttendance), YEAR(sa.DateofAttendance)
ORDER BY YEAR(sa.DateofAttendance), MONTH(sa.DateofAttendance), s.LastName;