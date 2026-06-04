-- SOURCE DATABASE: DonationManagementSystem
CREATE DATABASE DonationManagementSystem;
USE DonationManagementSystem;

-- Creating a donor table to store donor information
CREATE TABLE Donor (
    DonorID INT IDENTITY(1,1) PRIMARY KEY,  --Auto-generated ID for each donor i.e incrementing by 1
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    DonorAddress VARCHAR(200),
    RegistrationDate DATE DEFAULT GETDATE());

-- Beneficiary Table
CREATE TABLE Beneficiary (
    BeneficiaryID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    BeneficiaryAddress VARCHAR(200),
    Description VARCHAR(500),
    RequiredCategory VARCHAR(50),
    RegistrationDate DATE DEFAULT GETDATE());

-- Donation Table
CREATE TABLE Donation (
    DonationID INT IDENTITY(1,1) PRIMARY KEY,
    DonorID INT FOREIGN KEY REFERENCES Donor(DonorID),
    Amount DECIMAL(12,2) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    DonationDate DATE NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pending',
    IsAllocated BIT DEFAULT 0);

-- RequestSupport Table
CREATE TABLE RequestSupport (
    RequestID INT IDENTITY(1,1) PRIMARY KEY,
    BeneficiaryID INT FOREIGN KEY REFERENCES Beneficiary(BeneficiaryID),
    RequiredCategory VARCHAR(50) NOT NULL,
    Description VARCHAR(500),
    RequestDate DATE DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Pending');

-- Funds Allocation Table
CREATE TABLE FundsAllocation (
    AllocationID INT IDENTITY(1,1) PRIMARY KEY,
    DonationID INT FOREIGN KEY REFERENCES Donation(DonationID),
    BeneficiaryID INT FOREIGN KEY REFERENCES Beneficiary(BeneficiaryID),
    Amount DECIMAL(12,2) NOT NULL,
    AllocationDate DATE DEFAULT GETDATE(),
    AssignedBy VARCHAR(100));

-- inserting the records in donor table
INSERT INTO Donor (FullName, Email, Phone, DonorAddress, RegistrationDate) VALUES
('Ahmed Khan', 'ahmed.khan@gmail.com', '03001234567', 'Islamabad', '2024-01-15'),
('Fatima Ali', 'fatima.ali@yahoo.com', '03111234568', 'Rawalpindi', '2024-01-20'),
('Bilal Hussain', 'bilal.h@hotmail.com', '03221234569', 'Lahore', '2024-02-10'),
('Sara Ahmed', 'sara.ahmed@gmail.com', '03331234570', 'Karachi', '2024-02-15'),
('Omar Farooq', 'omar.farooq@gmail.com', '03441234571', 'Peshawar', '2024-03-01'),
('Zara Malik', 'zara.malik@yahoo.com', '03051234572', 'Islamabad', '2024-03-10'),
('Hassan Raza', 'hassan.raza@gmail.com', '03161234573', 'Multan', '2024-03-15'),
('Ayesha Naeem', 'ayesha.n@hotmail.com', '03271234574', 'Quetta', '2024-04-01'),
('Usman Chaudhry', 'usman.c@gmail.com', '03381234575', 'Lahore', '2024-04-10'),
('Nadia Tariq', 'nadia.tariq@gmail.com', '03491234576', 'Karachi', '2024-04-15');

-- inserting the records in beneficiary table
INSERT INTO Beneficiary (FullName, Email, Phone, BeneficiaryAddress, Description, RequiredCategory, RegistrationDate) VALUES
('Maryam Bibi', 'maryam.b@gmail.com', '03009876541', 'Jhang', 'Flood victim, lost home', 'Shelter', '2024-02-01'),
('Abdul Rehman', 'abdul.r@yahoo.com', '03119876542', 'Sukkur', 'Medical emergency', 'Medical', '2024-02-05'),
('Khadija Akram', 'khadija.a@gmail.com', '03229876543', 'Dera Ghazi Khan', 'Orphan child needs education', 'Education', '2024-02-10'),
('Muhammad Usman', 'usman.m@hotmail.com', '03339876544', 'Thatta', 'Flood affected family', 'Food', '2024-03-01'),
('Amina Shah', 'amina.shah@gmail.com', '03449876545', 'Swat', 'Winter clothing needed', 'Clothes', '2024-03-05'),
('Zain Ali', 'zain.ali@yahoo.com', '03059876546', 'Bahawalpur', 'Medical treatment for father', 'Medical', '2024-03-10'),
('Saima Yasin', 'saima.y@gmail.com', '03169876547', 'Larkana', 'No food for 3 days', 'Food', '2024-04-01'),
('Rizwan Ahmed', 'rizwan.a@hotmail.com', '03279876548', 'Muzaffargarh', 'House damaged by rain', 'Shelter', '2024-04-05'),
('Nimra Tariq', 'nimra.t@gmail.com', '03389876549', 'Kashmir', 'Earthquake relief', 'Shelter', '2024-04-10'),
('Shahzad Malik', 'shahzad.m@yahoo.com', '03499876550', 'Gilgit', 'No winter clothes', 'Clothes', '2024-05-01');

-- inserting the records in donation table
INSERT INTO Donation (DonorID, Amount, Category, DonationDate, Status, IsAllocated) VALUES
(1, 5000, 'Food', '2024-01-15', 'Approved', 1),
(1, 2000, 'Clothes', '2024-02-10', 'Approved', 1),
(2, 10000, 'Medical', '2024-01-20', 'Approved', 1),
(2, 3000, 'Education', '2024-03-05', 'Pending', 0),
(3, 15000, 'Shelter', '2024-02-01', 'Approved', 1),
(3, 2000, 'Food', '2024-03-10', 'Approved', 0),
(4, 8000, 'Medical', '2024-01-25', 'Approved', 1),
(5, 12000, 'Cash Assistance', '2024-02-15', 'Approved', 1),
(5, 4000, 'Utilities', '2024-03-20', 'Pending', 0),
(6, 7000, 'Education', '2024-03-01', 'Approved', 1);

-- inserting the records in RequestSupport table
INSERT INTO RequestSupport (BeneficiaryID, RequiredCategory, Description, RequestDate, Status) VALUES
(1, 'Food', 'I have no food for 3 days', '2024-02-01', 'Approved'),
(1, 'Utilities', 'Electricity bill overdue for 2 months', '2024-03-18', 'Pending'),
(2, 'Cash Assistance', 'Need money for daily expenses', '2024-03-20', 'Approved'),
(1, 'Medical', 'My child needs medical treatment', '2024-02-15', 'Approved'),
(2, 'Shelter', 'My house was damaged in flood', '2024-01-10', 'Approved'),
(2, 'Clothes', 'Need winter clothes for children', '2024-01-20', 'Pending'),
(3, 'Education', 'Cannot pay school fees', '2024-02-05', 'Approved'),
(3, 'Medical', 'Need surgery', '2024-02-25', 'Pending'),
(4, 'Food', 'No job, family has nothing to eat', '2024-03-01', 'Approved'),
(5, 'Shelter', 'House collapsed due to rain', '2024-02-10', 'Approved');

-- inserting the records in FundsAllocation table
INSERT INTO FundsAllocation (DonationID, BeneficiaryID, Amount, AllocationDate, AssignedBy) VALUES
(1, 1, 5000, '2024-02-01', 'System Admin'),
(1, 2, 3000, '2024-02-05', 'System Admin'),
(2, 1, 2000, '2024-02-10', 'System Admin'),
(2, 3, 4000, '2024-02-12', 'System Admin'),
(3, 2, 8000, '2024-02-15', 'System Admin'),
(3, 4, 6000, '2024-02-18', 'System Admin'),
(4, 1, 10000, '2024-02-20', 'System Admin'),
(4, 5, 7000, '2024-02-22', 'System Admin'),
(5, 2, 3000, '2024-02-25', 'System Admin'),
(5, 3, 4500, '2024-02-28', 'System Admin');

                                               -- DATA MART 1: Donation Amount Mart
--1.1: Create Dimension Tables for DataMart 1

-- Dimension Table1: Donor 
DROP TABLE IF EXISTS DM1_DimDonor; -- drop the table if its already existing
GO
CREATE TABLE DM1_DimDonor(
    Donor_SK INT IDENTITY(1,1) PRIMARY KEY, -- id will generate automatically
    DonorID INT,  
    FullName VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50));
GO

-- Dimension Table2: Time 
DROP TABLE IF EXISTS DM1_DimTime;
GO
CREATE TABLE DM1_DimTime(
    Time_SK INT IDENTITY(1,1) PRIMARY KEY,  
    Date DATE,
    Year INT,
    Month INT,
    MonthName VARCHAR(20));
GO

-- Dimension Table3: Category 
DROP TABLE IF EXISTS DM1_DimCategory; -- if table already exists then drop it
GO
CREATE TABLE DM1_DimCategory(
    Category_SK INT IDENTITY(1,1) PRIMARY KEY,  
    CategoryName VARCHAR(50),
    CategoryType VARCHAR(20));
GO

-- Dimension Table4: Status 
DROP TABLE IF EXISTS DM1_DimStatus;
GO
CREATE TABLE DM1_DimStatus(
    Status_SK INT IDENTITY(1,1) PRIMARY KEY, 
    StatusName VARCHAR(20));
GO

--1.2: Inserting data into Dimension Tables for DataMart 1

-- inserting in DM1_DimDonor
INSERT INTO DM1_DimDonor(DonorID, FullName, Email, City)
SELECT DonorID, FullName, Email,
    CASE  --since we want City not complete donor address
        WHEN DonorAddress LIKE '%Islamabad%' THEN 'Islamabad'
        WHEN DonorAddress LIKE '%Lahore%' THEN 'Lahore'
        WHEN DonorAddress LIKE '%Karachi%' THEN 'Karachi'
        ELSE 'Other'
    END
FROM dbo.Donor;
GO

-- inserting in DM1_DimTime
INSERT INTO DM1_DimTime(Date, Year, Month, MonthName)
SELECT DISTINCT DonationDate, YEAR(DonationDate), MONTH(DonationDate), DATENAME(MONTH, DonationDate)
FROM dbo.Donation;
GO

-- inserting in DM1_DimCategory
INSERT INTO DM1_DimCategory(CategoryName, CategoryType) VALUES
('Food', 'Consumable'), ('Clothes', 'Goods'), ('Medical', 'Service'),
('Education', 'Service'), ('Shelter', 'Infrastructure'), ('Utilities', 'Service'),
('Cash Assistance', 'Financial'), ('Other', 'General');
GO

-- inserting in DM1_DimStatus
INSERT INTO DM1_DimStatus(StatusName) VALUES ('Approved'), ('Pending'), ('Rejected');
GO

--1.3: Creating Fact Table for DataMart 1

DROP TABLE IF EXISTS DM1_FactDonation;
GO
CREATE TABLE DM1_FactDonation(
    Donor_SK INT FOREIGN KEY REFERENCES DM1_DimDonor(Donor_SK), -- link Donor_SK with DM1_DimDonor table
    Time_SK INT FOREIGN KEY REFERENCES DM1_DimTime(Time_SK),
    Category_SK INT FOREIGN KEY REFERENCES DM1_DimCategory(Category_SK),
    Status_SK INT FOREIGN KEY REFERENCES DM1_DimStatus(Status_SK),
    Fact_DonationAmount DECIMAL(12,2));
GO

--1.4: inserting data in Fact Table for DataMart1
INSERT INTO DM1_FactDonation(Donor_SK, Time_SK, Category_SK, Status_SK, Fact_DonationAmount)
SELECT d.Donor_SK,t.Time_SK,c.Category_SK,s.Status_SK,dn.Amount
FROM dbo.Donation dn
JOIN DM1_DimDonor d ON dn.DonorID=d.DonorID
JOIN DM1_DimTime t ON dn.DonationDate=t.Date
JOIN DM1_DimCategory c ON dn.Category=c.CategoryName
JOIN DM1_DimStatus s ON dn.Status=s.StatusName;
GO

--1.5: Query Data Mart 1
SELECT d.FullName AS DonorName,t.Year, t.MonthName,c.CategoryName,s.StatusName,f.Fact_DonationAmount
FROM DM1_FactDonation f
JOIN DM1_DimDonor d ON f.Donor_SK = d.Donor_SK
JOIN DM1_DimTime t ON f.Time_SK = t.Time_SK
JOIN DM1_DimCategory c ON f.Category_SK = c.Category_SK
JOIN DM1_DimStatus s ON f.Status_SK = s.Status_SK;
GO

                                              -- DATA MART 2: Funds Allocation Mart
 --2.1: Creating Dimension Tables for DataMart 2

-- Dimension Table1: Beneficiary
DROP TABLE IF EXISTS DM2_DimBeneficiary;
GO
CREATE TABLE DM2_DimBeneficiary(
    Beneficiary_SK INT IDENTITY(1,1) PRIMARY KEY,
    BeneficiaryID INT,
    FullName VARCHAR(100),
    City VARCHAR(50),
    RequiredCategory VARCHAR(50));
GO

-- Dimension Table2: Donor
DROP TABLE IF EXISTS DM2_DimDonor;
GO
CREATE TABLE DM2_DimDonor(
    Donor_SK INT IDENTITY(1,1) PRIMARY KEY,
    DonorID INT,
    FullName VARCHAR(100));
GO

-- Dimension Table3: Time
DROP TABLE IF EXISTS DM2_DimTime;
GO
CREATE TABLE DM2_DimTime(
    Time_SK INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE,
    Year INT,
    MonthName VARCHAR(20));
GO

-- Dimension Table4: Admin
DROP TABLE IF EXISTS DM2_DimAdmin;
GO
CREATE TABLE DM2_DimAdmin(
    Admin_SK INT IDENTITY(1,1) PRIMARY KEY,
    AdminName VARCHAR(100));
GO

--2.2: Insert data in Dimension Tables for DataMart 2
-- inserting data in DM2_DimBeneficiary
INSERT INTO DM2_DimBeneficiary(BeneficiaryID, FullName, City, RequiredCategory)
SELECT BeneficiaryID, FullName, 
    CASE 
        WHEN BeneficiaryAddress LIKE '%Islamabad%' THEN 'Islamabad'
        ELSE 'Other'
    END,
    RequiredCategory
FROM dbo.Beneficiary;
GO

-- inserting data in DM2_DimDonor
INSERT INTO DM2_DimDonor(DonorID, FullName)
SELECT DISTINCT DonorID, FullName
FROM dbo.Donor;
GO

-- inserting data in DM2_DimTime
INSERT INTO DM2_DimTime(Date, Year, MonthName)
SELECT DISTINCT AllocationDate, YEAR(AllocationDate), DATENAME(MONTH, AllocationDate)
FROM dbo.FundsAllocation;
GO

-- inserting data in DM2_DimAdmin
INSERT INTO DM2_DimAdmin(AdminName) VALUES ('System Admin');
GO

--2.3: Creating Fact Table for DataMart 2
DROP TABLE IF EXISTS DM2_FactAllocation;
GO
CREATE TABLE DM2_FactAllocation(
    Donor_SK INT FOREIGN KEY REFERENCES DM2_DimDonor(Donor_SK),
    Beneficiary_SK INT FOREIGN KEY REFERENCES DM2_DimBeneficiary(Beneficiary_SK),
    Time_SK INT FOREIGN KEY REFERENCES DM2_DimTime(Time_SK),
    Admin_SK INT FOREIGN KEY REFERENCES DM2_DimAdmin(Admin_SK),
    Fact_AllocatedAmount DECIMAL(12,2));
GO

--2.4: Inserting data in Fact Table for DataMart 2
INSERT INTO DM2_FactAllocation(Donor_SK, Beneficiary_SK, Time_SK, Admin_SK, Fact_AllocatedAmount)
SELECT d.Donor_SK,b.Beneficiary_SK,t.Time_SK,1 AS Admin_SK,fa.Amount
FROM dbo.FundsAllocation fa
JOIN dbo.Donation dn 
    ON fa.DonationID=dn.DonationID
JOIN DM2_DimDonor d 
    ON dn.DonorID=d.DonorID
JOIN DM2_DimBeneficiary b 
    ON fa.BeneficiaryID=b.BeneficiaryID
JOIN DM2_DimTime t 
    ON CAST(fa.AllocationDate AS DATE)= t.Date;

--2.5: Query Data Mart 2
SELECT d.FullName AS DonorName,b.FullName AS BeneficiaryName,t.Year, t.MonthName,f.Fact_AllocatedAmount
FROM DM2_FactAllocation f
JOIN DM2_DimDonor d ON f.Donor_SK = d.Donor_SK
JOIN DM2_DimBeneficiary b ON f.Beneficiary_SK = b.Beneficiary_SK
JOIN DM2_DimTime t ON f.Time_SK= t.Time_SK;
GO

                                        --DATA MART 3: Donor Contribution Mart

-- Dimension Table1: Donor
DROP TABLE IF EXISTS DM3_DimDonor;
GO
CREATE TABLE DM3_DimDonor(
    Donor_SK INT IDENTITY(1,1) PRIMARY KEY,
    DonorID INT,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    DonorType NVARCHAR(20));
GO

-- Dimension Table2: Time
DROP TABLE IF EXISTS DM3_DimTime;
GO
CREATE TABLE DM3_DimTime(
    Time_SK INT IDENTITY(1,1) PRIMARY KEY,
    Year INT);
GO

-- inserting data in Donor Table
INSERT INTO DM3_DimDonor(DonorID, FullName, Email, DonorType)
SELECT DonorID, FullName, Email,
    CASE WHEN RegistrationDate < '2024-06-01' THEN 'Regular' ELSE 'New' END
FROM dbo.Donor;
GO

-- inserting data in Time dimension table
INSERT INTO DM3_DimTime(Year) VALUES (2024);
GO

-- Fact Table
DROP TABLE IF EXISTS DM3_FactDonorContribution;
GO
CREATE TABLE DM3_FactDonorContribution(
    Donor_SK INT FOREIGN KEY REFERENCES DM3_DimDonor(Donor_SK),
    Time_SK INT FOREIGN KEY REFERENCES DM3_DimTime(Time_SK),
    Fact_TotalDonation DECIMAL(12,2));
GO

-- inserting data in Fact Table
INSERT INTO DM3_FactDonorContribution(Donor_SK, Time_SK, Fact_TotalDonation)
SELECT d.Donor_SK,t.Time_SK,SUM(dn.Amount)
FROM dbo.Donation dn
JOIN DM3_DimDonor d 
    ON dn.DonorID=d.DonorID
JOIN DM3_DimTime t 
    ON t.Year=YEAR(dn.DonationDate)
GROUP BY d.Donor_SK, t.Time_SK;

-- Query
SELECT d.FullName, d.DonorType, f.Fact_TotalDonation
FROM DM3_FactDonorContribution f
JOIN DM3_DimDonor d ON f.Donor_SK=d.Donor_SK;
GO

                                                 --DATA MART 4: Request Analysis Mart

-- Dimension Table1: Beneficiary
DROP TABLE IF EXISTS DM4_DimBeneficiary;
GO
CREATE TABLE DM4_DimBeneficiary(
    Beneficiary_SK INT IDENTITY(1,1) PRIMARY KEY,
    BeneficiaryID INT,
    FullName VARCHAR(100));
GO

-- Dimension Table2: Category
DROP TABLE IF EXISTS DM4_DimCategory;
GO
CREATE TABLE DM4_DimCategory(
    Category_SK INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50));
GO

-- Dimension Table3: Status
DROP TABLE IF EXISTS DM4_DimStatus;
GO
CREATE TABLE DM4_DimStatus(
    Status_SK INT IDENTITY(1,1) PRIMARY KEY,
    StatusName VARCHAR(20));
GO

-- Dimension Table4: Time
DROP TABLE IF EXISTS DM4_DimTime;
GO
CREATE TABLE DM4_DimTime(
    Time_SK INT IDENTITY(1,1) PRIMARY KEY,
    Year INT);
GO

-- inserting data in dimension tables
INSERT INTO DM4_DimBeneficiary(BeneficiaryID, FullName)
SELECT BeneficiaryID, FullName FROM dbo.Beneficiary;
GO

INSERT INTO DM4_DimCategory(CategoryName) VALUES ('Food'),('Medical'),('Education'),('Shelter'),('Clothes'),('Utilities'),('Cash Assistance');
GO

INSERT INTO DM4_DimStatus(StatusName) VALUES ('Approved'),('Pending');
GO

INSERT INTO DM4_DimTime(Year) VALUES (2024);
GO

-- Fact Table
DROP TABLE IF EXISTS DM4_FactRequest;
GO
CREATE TABLE DM4_FactRequest(
    Beneficiary_SK INT FOREIGN KEY REFERENCES DM4_DimBeneficiary(Beneficiary_SK),
    Category_SK INT FOREIGN KEY REFERENCES DM4_DimCategory(Category_SK),
    Status_SK INT FOREIGN KEY REFERENCES DM4_DimStatus(Status_SK),
    Time_SK INT FOREIGN KEY REFERENCES DM4_DimTime(Time_SK),
    Fact_RequestCount INT);
GO

-- inserting data in Fact table
INSERT INTO DM4_FactRequest(Beneficiary_SK, Category_SK, Status_SK, Time_SK, Fact_RequestCount)
SELECT b.Beneficiary_SK,c.Category_SK,s.Status_SK,t.Time_SK,COUNT(rs.RequestID)
FROM dbo.RequestSupport rs
JOIN DM4_DimBeneficiary b 
    ON rs.BeneficiaryID=b.BeneficiaryID
JOIN DM4_DimCategory c 
    ON rs.RequiredCategory=c.CategoryName
JOIN DM4_DimStatus s 
    ON rs.Status= s.StatusName
JOIN DM4_DimTime t 
    ON t.Year= YEAR(rs.RequestDate)
GROUP BY b.Beneficiary_SK, c.Category_SK, s.Status_SK, t.Time_SK;

-- Query
SELECT b.FullName, c.CategoryName, s.StatusName, f.Fact_RequestCount
FROM DM4_FactRequest f
JOIN DM4_DimBeneficiary b ON f.Beneficiary_SK= b.Beneficiary_SK
JOIN DM4_DimCategory c ON f.Category_SK= c.Category_SK
JOIN DM4_DimStatus s ON f.Status_SK= s.Status_SK;  --Join status dimension table to get request status (Approved/Pending)
GO

                                   --DATA MART 5: Category Performance Mart

-- Dimension Table1: Category
DROP TABLE IF EXISTS DM5_DimCategory;
GO
CREATE TABLE DM5_DimCategory(
    Category_SK INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50),
    CategoryType VARCHAR(20));
GO

-- Dimension Table2: Time
DROP TABLE IF EXISTS DM5_DimTime;
GO
CREATE TABLE DM5_DimTime(
    Time_SK INT IDENTITY(1,1) PRIMARY KEY,
    Year INT,
    Month INT,
    MonthName VARCHAR(20));
GO

-- inserting data in Category
INSERT INTO DM5_DimCategory(CategoryName, CategoryType) VALUES
('Food', 'Consumable'), ('Clothes', 'Goods'), ('Medical', 'Service'),
('Education', 'Service'), ('Shelter', 'Infrastructure'), ('Utilities', 'Service'),
('Cash Assistance', 'Financial');
GO


INSERT INTO DM5_DimTime(Year, Month, MonthName)
SELECT DISTINCT YEAR(DonationDate), MONTH(DonationDate), DATENAME(MONTH, DonationDate)
FROM dbo.Donation;
GO

-- Fact Table
DROP TABLE IF EXISTS DM5_FactCategoryPerformance;
GO
CREATE TABLE DM5_FactCategoryPerformance(
    Category_SK INT FOREIGN KEY REFERENCES DM5_DimCategory(Category_SK),
    Time_SK INT FOREIGN KEY REFERENCES DM5_DimTime(Time_SK),
    Fact_TotalDonationAmount DECIMAL(12,2));
GO

-- inserting data in Fact Table
INSERT INTO DM5_FactCategoryPerformance(Category_SK, Time_SK, Fact_TotalDonationAmount)
SELECT c.Category_SK,t.Time_SK,SUM(dn.Amount)
FROM dbo.Donation dn
JOIN DM5_DimCategory c 
    ON dn.Category= c.CategoryName
JOIN DM5_DimTime t 
    ON t.Year= YEAR(dn.DonationDate)
    AND t.Month= MONTH(dn.DonationDate)
GROUP BY c.Category_SK, t.Time_SK; -- Grouping data by category and time for calculating total donations

-- Query
SELECT c.CategoryName, t.Year, t.MonthName, f.Fact_TotalDonationAmount
FROM DM5_FactCategoryPerformance f
JOIN DM5_DimCategory c ON f.Category_SK= c.Category_SK --Category dimension table is joined with the fact table using Category_SK to retrieve category details.
JOIN DM5_DimTime t ON f.Time_SK= t.Time_SK
ORDER BY c.CategoryName, t.Year, t.Month;  -- Sort results by category name then year and then month
GO

