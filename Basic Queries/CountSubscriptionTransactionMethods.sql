USE GYMDB;
GO

SELECT PaymentMethod, COUNT(*) AS TransactionCount
FROM ServiceTransaction
GROUP BY PaymentMethod;