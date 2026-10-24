USE GYMDB;
GO

SELECT s.FirstName + ' ' + s.LastName AS CoachName,
	   c.NumberofTrainees
FROM Coach c
JOIN Staff s ON c.StaffID = s.StaffID
ORDER BY c.NumberOfTrainees DESC;