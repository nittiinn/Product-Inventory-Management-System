CREATE DATABASE PRODUCT_DB
USE PRODUCT_DB
CREATE TABLE ProductMaster (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL
);

CREATE TABLE CompanyMaster (
    CompanyID INT PRIMARY KEY IDENTITY(1,1),
    CompanyName NVARCHAR(100) NOT NULL,
    CompanyAddress NVARCHAR(200)
);


CREATE TABLE DailyProduction (
    ProductionID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT FOREIGN KEY REFERENCES ProductMaster(ProductID),
    CompanyID INT FOREIGN KEY REFERENCES CompanyMaster(CompanyID),
    ProductionDate DATE NOT NULL,
    Quantity INT NOT NULL,
    Shift NVARCHAR(50)
);

ALTER PROCEDURE Usp_InsertProductionData
    @ProductName NVARCHAR(100),
    @CompanyName NVARCHAR(100),
    @CompanyAddress NVARCHAR(200),
    @ProductionDate DATE,
    @Quantity VARCHAR(50),
    @Shift NVARCHAR(50)
AS
BEGIN
    DECLARE @ProductID INT, @CompanyID INT;

    -- Insert into ProductMaster
    INSERT INTO ProductMaster (ProductName)
    VALUES (@ProductName);
    SET @ProductID = SCOPE_IDENTITY();

    -- Insert into CompanyMaster
    INSERT INTO CompanyMaster (CompanyName, CompanyAddress)
    VALUES (@CompanyName, @CompanyAddress);
    SET @CompanyID = SCOPE_IDENTITY();

    -- Insert into DailyProduction
    INSERT INTO DailyProduction (ProductID, CompanyID, ProductionDate, Quantity, Shift)
    VALUES (@ProductID, @CompanyID, @ProductionDate, @Quantity, @Shift);
END;


CREATE PROCEDURE Usp_GetProductionData
AS
BEGIN
    SELECT P.ProductName, C.CompanyName, C.CompanyAddress, D.ProductionDate, D.Quantity, D.Shift
    FROM DailyProduction D
    INNER JOIN ProductMaster P ON D.ProductID = P.ProductID
    INNER JOIN CompanyMaster C ON D.CompanyID = C.CompanyID;
END;

SELECT * FROM ProductMaster

CREATE PROCEDURE USP_GetCombinedData
AS
BEGIN
    SELECT 
        pm.ProductName,
        cm.CompanyName,
        cm.CompanyAddress,
        dp.ProductionDate,
        dp.Quantity,
        dp.Shift
    FROM 
        DailyProduction dp
    INNER JOIN 
        ProductMaster pm ON dp.ProductID = pm.ProductID
    INNER JOIN 
        CompanyMaster cm ON dp.CompanyID = cm.CompanyID;
END;

CREATE PROCEDURE GetProductDetailsByName
    @ProductName NVARCHAR(100)
AS
BEGIN
    SELECT 
        P.ProductName, 
        C.CompanyName, 
        C.CompanyAddress, 
        D.ProductionDate, 
        D.Quantity, 
        D.Shift
    FROM DailyProduction D
    INNER JOIN ProductMaster P ON D.ProductID = P.ProductID
    INNER JOIN CompanyMaster C ON D.CompanyID = C.CompanyID
    WHERE P.ProductName = @ProductName;
END
EXEC GetProductDetailsByName @ProductName = 'Soya Bean';

SELECT * FROM CompanyMaster;
SELECT * FROM ProductMaster;
SELECT * FROM DailyProduction;


DELETE FROM CompanyMaster
WHERE CompanyID = 10;

-- Step 2: Delete the product itself
DELETE FROM ProductMaster
WHERE ProductID = 10;


CREATE PROCEDURE GetProductsWithHighQuantity
    @MinQuantity INT
AS
BEGIN
    SELECT 
        P.ProductName, 
        SUM(D.Quantity) AS TotalQuantity
    FROM 
        DailyProduction D
    INNER JOIN 
        ProductMaster P ON D.ProductID = P.ProductID
    GROUP BY 
        P.ProductName
    HAVING 
        SUM(D.Quantity) > @MinQuantity;
END;
