USE GYMDB;
GO

SELECT ClassName, NumberofParticipants, Capacity,
	   (NumberofParticipants * 100 / Capacity) AS OccupancyRate
FROM Class
ORDER BY OccupancyRate DESC;