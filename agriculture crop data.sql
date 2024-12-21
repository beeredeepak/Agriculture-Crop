-- Scenario: Agricultural data

/* creating a data for an agricultural company to analyze vast amounts of data, including:

Crop Data: Crop type, planting date, harvesting date, yield, quality metrics, etc.
Weather Data: Temperature, humidity, rainfall, wind speed, etc.
Soil Data: pH levels, nutrient content, moisture levels, etc.
Fertilizer Data: Type, quantity, application date, cost, etc.
Pesticide Data: Type, quantity, application date, cost*/



CREATE TABLE Crops (
    CropID INT PRIMARY KEY,
    CropName VARCHAR(50),
    ParentCropID INT,
    PlantingDate DATE,
    HarvestingDate DATE,
    Yield DECIMAL(10,2),
    QualityRating INT
);

CREATE TABLE WeatherData (
    Date DATE PRIMARY KEY,
    Temperature DECIMAL(5,2),
    Humidity DECIMAL(5,2),
    Rainfall DECIMAL(5,2),
    WindSpeed DECIMAL(5,2)
);

CREATE TABLE SoilData (
    FieldID INT PRIMARY KEY,
    pHLevel DECIMAL(5,2),
    NutrientContent VARCHAR(100),
    MoistureLevel DECIMAL(5,2)
);

CREATE TABLE Fertilizer (
    FertilizerID INT PRIMARY KEY,
    FertilizerName VARCHAR(50),
    NitrogenContent DECIMAL(5,2),
    PhosphorusContent DECIMAL(5,2),
    PotassiumContent DECIMAL(5,2),
    Cost DECIMAL(10,2)
);

CREATE TABLE Pesticide (
    PesticideID INT PRIMARY KEY,
    PesticideName VARCHAR(50),
    TargetPest VARCHAR(50),
    ApplicationMethod VARCHAR(50),
    Cost DECIMAL(10,2)
);

CREATE TABLE CropFertilizerPesticide (
    CropID INT,
    FertilizerID INT,
    PesticideID INT,
    ApplicationDate DATE,
    Quantity DECIMAL(10,2),
    PRIMARY KEY (CropID, FertilizerID, PesticideID),
    FOREIGN KEY (CropID) REFERENCES Crops(CropID),
    FOREIGN KEY (FertilizerID) REFERENCES Fertilizer(FertilizerID),
    FOREIGN KEY (PesticideID) REFERENCES Pesticide(PesticideID)
);

CREATE TABLE SoilSample (
    SampleID INT PRIMARY KEY,
    FieldID INT,
    SamplingDate DATE,
    pHLevel DECIMAL(5,2),
    NutrientContent VARCHAR(100),
    MoistureLevel DECIMAL(5,2),
    FOREIGN KEY (FieldID) REFERENCES SoilData(FieldID)
);

CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY,
    EquipmentType VARCHAR(50),
    PurchaseDate DATE,
    MaintenanceCost DECIMAL(10,2)
);

CREATE TABLE Labor (
    LaborID INT PRIMARY KEY,
    LaborType VARCHAR(50),
    HourlyRate DECIMAL(10,2)
);

CREATE TABLE Field (
    FieldID INT PRIMARY KEY,
    FieldName VARCHAR(50),
    Size DECIMAL(10,2), -- in acres or hectares
    Location VARCHAR(100),
    SoilType VARCHAR(50)
);

CREATE TABLE Irrigation (
    IrrigationID INT PRIMARY KEY,
    FieldID INT,
    IrrigationDate DATE,
    WaterVolume DECIMAL(10,2), -- in cubic meters or gallons
    IrrigationMethod VARCHAR(50),
    FOREIGN KEY (FieldID) REFERENCES Field(FieldID)
);

CREATE TABLE EquipmentUsage (
    UsageID INT PRIMARY KEY,
    EquipmentID INT,
    FieldID INT,
    StartDate DATE,
    EndDate DATE,
    HoursUsed DECIMAL(10,2),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID),
    FOREIGN KEY (FieldID) REFERENCES Field(FieldID)
);

CREATE TABLE LaborUsage (
    UsageID INT PRIMARY KEY,
    FieldID INT,
    LaborID INT,
    StartDate DATE,
    EndDate DATE,
    HoursWorked DECIMAL(10,2),
    HourlyRate INT,
    FOREIGN KEY (FieldID) REFERENCES Field(FieldID),
    FOREIGN KEY (LaborID) REFERENCES Labor(LaborID)
);

CREATE TABLE DiseasePest (
    DiseasePestID INT PRIMARY KEY,
    DiseasePestName VARCHAR(50),
    Description TEXT
);

CREATE TABLE CropDiseasePest (
    CropID INT,
    DiseasePestID INT,
    PRIMARY KEY (CropID, DiseasePestID),
    FOREIGN KEY (CropID) REFERENCES Crops(CropID),
    FOREIGN KEY (DiseasePestID) REFERENCES DiseasePest(DiseasePestID)
);

INSERT INTO Crops (CropID, CropName, ParentCropID, PlantingDate, HarvestingDate, Yield, QualityRating)
VALUES
  (1, 'Wheat', 11, '2023-09-15', '2024-04-15', 5000, 8),
  (2, 'Rice', 12, '2023-05-10', '2023-11-10', 4000, 9),
  (3, 'Corn', 13, '2023-04-01', '2023-09-01', 3500, 7);

INSERT INTO WeatherData (Date, Temperature, Humidity, Rainfall, WindSpeed)
VALUES
  ('2023-09-15', 25.5, 60, 10, 5),
  ('2023-09-16', 27.0, 65, 15, 7),
  ('2023-09-17', 28.5, 70, 0, 3);

INSERT INTO SoilData (FieldID, pHLevel, NutrientContent, MoistureLevel)
VALUES
  (1, 6.5, 'N-P-K 10-10-10', 20),
  (2, 7.0, 'N-P-K 15-15-15', 25),
  (3, 6.8, 'Organic Compost', 18);

INSERT INTO Fertilizer (FertilizerID, FertilizerName, NitrogenContent, PhosphorusContent, PotassiumContent, Cost)
VALUES
  (1, 'Urea', 46, 0, 0, 10),
  (2, 'DAP', 18, 46, 0, 15),
  (3, 'MOP', 0, 0, 60, 12);

INSERT INTO Pesticide (PesticideID, PesticideName, TargetPest, ApplicationMethod, Cost)
VALUES
  (1, 'Malathion', 'Aphids', 'Spray', 5),
  (2, 'Carbaryl', 'Caterpillars', 'Dust', 8),
  (3, 'Pyrethrin', 'Flies', 'Spray', 7);

INSERT INTO CropFertilizerPesticide (CropID, FertilizerID, PesticideID, ApplicationDate, Quantity)
VALUES
  (1, 1, 1, '2023-10-01', 10),
  (2, 2, 2, '2023-06-15', 8),
  (3, 3, 3, '2023-05-01', 12);

INSERT INTO SoilSample (SampleID, FieldID, SamplingDate, pHLevel, NutrientContent, MoistureLevel)
VALUES
  (1, 1, '2023-10-15', 6.5, 'N-P-K 10-10-10', 20),
  (2, 2, '2023-11-01', 7.0, 'N-P-K 15-15-15', 25),
  (3, 3, '2023-09-20', 6.8, 'Organic Compost', 18);

INSERT INTO Equipment (EquipmentID, EquipmentType, PurchaseDate, MaintenanceCost)
VALUES
  (101, 'Tractor', '2020-01-01', 500),
  (102, 'Harvester', '2021-03-15', 600),
  (103, 'Plough', '2019-12-25', 400);

INSERT INTO Labor (LaborID, LaborType, HourlyRate)
VALUES
  (201, 'Skilled Labor', 20),
  (202, 'Unskilled Labor', 15),
  (203, 'Supervisor', 25);

INSERT INTO Field (FieldID, FieldName, Size, Location, SoilType)
VALUES
  (1, 'North Field', 10, 'North Side of Farm', 'Clay Loam'),
  (2, 'South Field', 8, 'South Side of Farm', 'Sandy Loam'),
  (3, 'East Field', 12, 'East Side of Farm', 'Silt Loam');

INSERT INTO Irrigation (IrrigationID, FieldID, IrrigationDate, WaterVolume, IrrigationMethod)
VALUES
  (1, 1, '2023-10-15', 1000, 'Drip Irrigation'),
  (2, 2, '2023-11-01', 800, 'Sprinkler Irrigation'),
  (3, 3, '2023-09-20', 1200, 'Flood Irrigation');

INSERT INTO EquipmentUsage (UsageID, EquipmentID, FieldID, StartDate, EndDate, HoursUsed)
VALUES
  (1, 101, 1, '2023-10-10', '2023-10-12', 10),
  (2, 102, 2, '2023-11-05', '2023-11-07', 8),
  (3, 103, 3, '2023-09-18', '2023-09-20', 12);

INSERT INTO LaborUsage (UsageID, FieldID, LaborID, StartDate, EndDate, HoursWorked, HourlyRate)
VALUES
  (1, 1, 201, '2023-10-10', '2023-10-12', 20, 50),
  (2, 2, 202, '2023-11-05', '2023-11-07', 16, 66),
  (3, 3, 203, '2023-09-18', '2023-09-20', 24, 88);

INSERT INTO DiseasePest (DiseasePestID, DiseasePestName, Description)
VALUES
  (1, 'Rust', 'Fungal disease affecting wheat'),
  (2, 'Blight', 'Bacterial disease affecting rice'),
  (3, 'Corn Borer', 'Insect pest affecting corn');

INSERT INTO CropDiseasePest (CropID, DiseasePestID)
VALUES
  (1, 1),
  (2, 2),
  (3, 3);



-- Yield Analysis:

SELECT CropName, AVG(Yield) AS AverageYield
FROM Crops
GROUP BY CropName
ORDER BY AverageYield DESC;

-- Weather Impact on Yield:

SELECT c.CropName, AVG(c.Yield), AVG(w.Temperature), AVG(w.Rainfall)
FROM Crops c
JOIN WeatherData w ON c.PlantingDate = w.Date
GROUP BY c.CropName;

-- Soil Nutrient Impact on Crop Quality:

SELECT s.NutrientContent, AVG(c.QualityRating) AS AverageQuality
FROM SoilData s
JOIN Crops c ON s.FieldID = c.FieldID
GROUP BY s.NutrientContent;

-- Predictive Analytics (Using Window Functions):

SELECT CropName, PlantingDate, Yield,
        AVG(Yield) OVER (PARTITION BY CropName ORDER BY PlantingDate ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MovingAverageYield
FROM Crops;

-- Cost-Benefit Analysis:

SELECT c.CropName, SUM(f.Cost) AS FertilizerCost, SUM(p.Cost) AS PesticideCost, c.Yield, c.Yield * c.PricePerUnit - SUM(f.Cost) - SUM(p.Cost) AS Profit
FROM Crops c
JOIN Fertilizer f ON c.CropID = f.CropID
JOIN Pesticide p ON c.CropID = p.CropID
GROUP BY c.CropName;

-- Yield Analysis with Time Series:

SELECT 
    c.CropName, 
    w.Date, 
    c.Yield, 
    AVG(c.Yield) OVER (PARTITION BY c.CropName ORDER BY w.Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeAverageYield
FROM Crops c
JOIN WeatherData w ON c.PlantingDate = w.Date
ORDER BY c.CropName, w.Date;

--  Identifying Optimal Fertilizer and Pesticide Combinations:

SELECT 
    c.CropName, 
    f.FertilizerName, 
    p.PesticideName, 
    AVG(c.Yield) AS AverageYield
FROM Crops c
JOIN CropFertilizerPesticide cfp ON c.CropID = cfp.CropID
JOIN Fertilizer f ON cfp.FertilizerID = f.FertilizerID
JOIN Pesticide p ON cfp.PesticideID = p.PesticideID
GROUP BY c.CropName, f.FertilizerName, p.PesticideName
ORDER BY AverageYield DESC;

-- Analyzing the Impact of Irrigation on Yield:

SELECT 
    c.CropName, 
    AVG(c.Yield), 
    AVG(i.WaterVolume) AS AverageWaterVolume
FROM Crops c
JOIN Field f ON c.FieldID = f.FieldID
JOIN Irrigation i ON f.FieldID = i.FieldID
GROUP BY c.CropName;

--  Predicting Disease Outbreaks:

WITH DiseaseOutbreaks AS (
    SELECT 
        d.DiseasePestName, 
        COUNT(*) AS OutbreakCount
    FROM CropDiseasePest cdp
    JOIN DiseasePest d ON cdp.DiseasePestID = d.DiseasePestID
    GROUP BY d.DiseasePestName
)
SELECT 
    c.CropName, 
    d.DiseasePestName, 
    d.OutbreakCount
FROM Crops c
JOIN CropDiseasePest cdp ON c.CropID = cdp.CropID
JOIN DiseasePest d ON cdp.DiseasePestID = d.DiseasePestID
JOIN DiseaseOutbreaks do ON d.DiseasePestName = do.DiseasePestName
ORDER BY d.OutbreakCount DESC;

--  Optimizing Labor Allocation:

SELECT 
    l.LaborType, 
    SUM(lu.HoursWorked) AS TotalHours,
    AVG(c.Yield) AS AverageYield
FROM Labor l
JOIN LaborUsage lu ON l.LaborID = lu.LaborID
JOIN Field f ON lu.FieldID = f.FieldID
JOIN Crops c ON f.FieldID = c.FieldID
GROUP BY l.LaborType;

-- Analyzing Crop Yield Trends Over Time

WITH CropYieldTrends AS (
    SELECT
        c.CropName,
        w.Date,
        c.Yield,
        f.FertilizerName,
        w.Temperature,
        w.Rainfall
    FROM Crops c
    JOIN WeatherData w ON c.PlantingDate = w.Date
    JOIN CropFertilizerPesticide cfp ON c.CropID = cfp.CropID
    JOIN Fertilizer f ON cfp.FertilizerID = f.FertilizerID
)

SELECT 
    CropName,
    AVG(Yield) AS AverageYield,
    MIN(Temperature) AS MinTemp,
    MAX(Rainfall) AS MaxRainfall
FROM CropYieldTrends
GROUP BY CropName;

-- Ranking crops based on yield, identifying top-performing fertilizers 

SELECT 
    c.CropName, 
    f.FertilizerName, 
    AVG(c.Yield) AS AverageYield,
    RANK() OVER (PARTITION BY c.CropName ORDER BY AVG(c.Yield) DESC) AS YieldRank
FROM Crops c
JOIN CropFertilizerPesticide cfp ON c.CropID = cfp.CropID
JOIN Fertilizer f ON cfp.FertilizerID = f.FertilizerID
GROUP BY c.CropName, f.FertilizerName;

--  unique sequential number to each row within a partition

SELECT 
    c.CropName, 
    w.Date, 
    c.Yield,
    ROW_NUMBER() OVER (PARTITION BY c.CropName ORDER BY w.Date) AS RowNum
FROM Crops c
JOIN WeatherData w ON c.PlantingDate = w.Date;

SELECT 
    c.CropName, 
    w.Date, 
    c.Yield,
    LAG(c.Yield) OVER (PARTITION BY c.CropName ORDER BY w.Date) AS PreviousYield
FROM Crops c
JOIN WeatherData w ON c.PlantingDate = w.Date;

-- recursive query to traverse the hierarchy

WITH RECURSIVE CropHierarchy AS (
    SELECT 
        CropID, 
        CropName, 
        ParentCropID, 
        1 AS Level
    FROM Crops
    WHERE ParentCropID IS NULL
    
    UNION ALL
    
    SELECT 
        c.CropID, 
        c.CropName, 
        c.ParentCropID, 
        ch.Level + 1 AS Level
    FROM Crops c
    JOIN CropHierarchy ch ON c.ParentCropID = ch.CropID
)
SELECT * FROM CropHierarchy;

-- Ranking Crops Based on Yield

SELECT
    CropName,
    Yield,
    RANK() OVER (ORDER BY Yield DESC) AS YieldRank
FROM Crops;

--  Calculating Cumulative Yield Over Time

SELECT
    CropName,
    Date,
    Yield,
    SUM(Yield) OVER (PARTITION BY CropName ORDER BY Date) AS CumulativeYield
FROM Crops c
JOIN WeatherData w ON c.PlantingDate = w.Date;

--  Identifying Outliers in Soil Data

SELECT 
    FieldID, 
    pHLevel, 
    PERCENT_RANK() OVER (ORDER BY pHLevel) AS pHLevelPercentile
FROM SoilData;

--  Analyzing Equipment Usage

SELECT 
    EquipmentID, 
    SUM(HoursUsed) OVER (PARTITION BY EquipmentID) AS TotalHoursUsed
FROM EquipmentUsage;

-- Tracking Labor Costs

SELECT 
    LaborID, 
    SUM(HoursWorked * HourlyRate) OVER (PARTITION BY LaborID) AS TotalLaborCost
FROM LaborUsage
JOIN Labor ON LaborUsage.LaborID = Labor.LaborID;



-- Predicting Crop Yield

-- Data Preparation:

SELECT 
    c.CropName, 
    w.Temperature, 
    w.Rainfall, 
    s.pHLevel, 
    f.FertilizerName, 
    c.Yield
FROM Crops c
JOIN WeatherData w ON c.PlantingDate = w.Date
JOIN SoilData s ON c.FieldID = s.FieldID
JOIN CropFertilizerPesticide cfp ON c.CropID = cfp.CropID
JOIN Fertilizer f ON cfp.FertilizerID = f.FertilizerID;

-- Exporting Data to CSV
