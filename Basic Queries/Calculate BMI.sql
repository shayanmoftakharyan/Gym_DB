USE GYMDB;
GO

SELECT 
    m.MemberID,
    m.FirstName,
    m.LastName,
    bm.MeasuredWeight,
    m.Height,
    ROUND(bm.MeasuredWeight / POWER(m.Height / 100.0, 2), 2) AS BMI,
    CASE 
        WHEN bm.MeasuredWeight / POWER(m.Height / 100.0, 2) < 18.5 THEN 'UnderMeasuredWeight'
        WHEN bm.MeasuredWeight / POWER(m.Height / 100.0, 2) < 25.0 THEN 'Normal'
        WHEN bm.MeasuredWeight / POWER(m.Height / 100.0, 2) < 30.0 THEN 'OverMeasuredWeight'
        ELSE 'Obese'
    END AS BMICategory
FROM GymMember m
JOIN BodyMeasurement bm ON m.MemberID = bm.MemberID
WHERE bm.MeasurementDate = (
    SELECT MAX(MeasurementDate) 
    FROM BodyMeasurement 
    WHERE MemberID = m.MemberID
);