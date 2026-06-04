CREATE DATABASE DonationManagement;
GO
USE DonationManagement;
GO

--donor table
CREATE TABLE Donor (
    DonorID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    DonorAddress NVARCHAR(255) NOT NULL,
    RegistrationDate DATETIME DEFAULT GETDATE()
);
GO

-- beneficiary table
CREATE TABLE Beneficiary (
    BeneficiaryID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    BeneficiaryAddress NVARCHAR(255) NOT NULL,
    TypeofHelp NVARCHAR(50) NOT NULL,
    BriefDescription NVARCHAR(500) NOT NULL,
    RegistrationDate DATETIME DEFAULT GETDATE()
);
GO
-- donation
CREATE TABLE Donation (
    DonationID INT IDENTITY(1,1) PRIMARY KEY,
    DonorID INT NULL,
    DonationCategory NVARCHAR(100) NOT NULL,
    DonationAmount DECIMAL(18,2) NOT NULL,
    DonationDate DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Donor (FullName, Email, Phone, DonorAddress) VALUES
('Hassan Raza', 'hassan.raza@email.com', '03451234567', 'Karachi, Sindh'),
('Maria Aslam', 'maria.aslam@email.com', '03457654321', 'Lahore, Punjab'),
('Omar Farooq', 'omar.farooq@email.com', '03455555555', 'Islamabad, Capital'),
('Sana Sheikh', 'sana.sheikh@email.com', '03451112222', 'Rawalpindi, Punjab'),
('Danish Khan', 'danish.khan@email.com', '03453334444', 'Multan, Punjab'),
('Beenish Ali', 'beenish.ali@email.com', '03454445555', 'Faisalabad, Punjab'),
('Fahad Ahmed', 'fahad.ahmed@email.com', '03456667777', 'Peshawar, KPK'),
('Laiba Tariq', 'laiba.tariq@email.com', '03458889999', 'Quetta, Balochistan'),
('Talha Naeem', 'talha.naeem@email.com', '03459990000', 'Sialkot, Punjab'),
('Areeba Zafar', 'areeba.zafar@email.com', '03452223333', 'Gujranwala, Punjab');
GO

INSERT INTO Beneficiary (FullName, Email, Phone, BeneficiaryAddress, TypeofHelp, BriefDescription) VALUES
('Zahida Parveen', 'zahida.p@email.com', '03112223344', 'Peshawar, KPK', 'Food', 'Widow with 4 children, needs monthly ration for 6 months'),
('Shahbaz Gill', 'shahbaz.g@email.com', '03114435566', 'Quetta, Balochistan', 'Medical', 'Dengue treatment required for elderly parents'),
('Rabia Anwar', 'rabia.a@email.com', '03116647788', 'Multan, Punjab', 'Education', 'Need books and tuition fees for 3 children'),
('Kamran Ashraf', 'kamran.a@email.com', '03118859900', 'Karachi, Sindh', 'Clothes', 'Summer clothes needed for orphanage children'),
('Sadia Khan', 'sadia.k@email.com', '03110061122', 'Lahore, Punjab', 'Medical', 'Diabetes treatment and medication needed'),
('Waseem Akhtar', 'waseem.a@email.com', '03112273344', 'Rawalpindi, Punjab', 'Money', 'Need financial help for house repair after flood'),
('Hira Naeem', 'hira.n@email.com', '03114485566', 'Faisalabad, Punjab', 'Education', 'Need scholarship for computer science degree'),
('Noman Siddiqui', 'noman.s@email.com', '03116697788', 'Sialkot, Punjab', 'Medical', 'Need hearing aid for deaf child'),
('Sumbul Javed', 'sumbul.j@email.com', '03118809900', 'Islamabad, Capital', 'Food', 'Daily meals for 20 homeless people'),
('Irfan Haider', 'irfan.h@email.com', '03110021122', 'Gujranwala, Punjab', 'Clothes', 'Winter blankets for flood affected families');
GO

INSERT INTO Donation (DonorID, DonationCategory, DonationAmount) VALUES
(1, 'Rebuild Gaza', 15000),
(2, 'Water Filtration', 25000),
(3, 'Sponsor an Orphan', 42000),
(4, 'Rebuild Gaza', 7500),
(5, 'Water Filtration', 12000),
(6, 'Sponsor an Orphan', 18000),
(7, 'Rebuild Gaza', 35000),
(8, 'Water Filtration', 5000),
(9, 'Sponsor an Orphan', 60000),
(10, 'Rebuild Gaza', 10000);
GO

SELECT * FROM Donor;
SELECT * FROM Beneficiary;
SELECT * FROM Donation;
GO

-- NONCLUSTERED INDEX
SELECT* FROM Donor
WHERE FullName='Hassan Raza';
CREATE NONCLUSTERED INDEX IX_Donor_FullName
ON Donor(FullName);
SELECT* FROM Donor
WHERE FullName='Hassan Raza';

--UNIQUE INDEX
SELECT *
FROM Donor
WHERE Phone = '03451234567';
CREATE UNIQUE INDEX UIX_Donor_Phone
ON Donor(Phone);
SELECT *
FROM Donor
WHERE Phone = '03451234567';

--FILTER INDEX
SELECT FullName, Phone, TypeofHelp, BeneficiaryAddress
FROM Beneficiary
WHERE BeneficiaryAddress = 'Lahore, Punjab';
CREATE NONCLUSTERED INDEX IX_Beneficiary_Lahore_FullName
ON Beneficiary(FullName)
WHERE BeneficiaryAddress = 'Lahore, Punjab';
GO
SELECT FullName, Phone, TypeofHelp, BeneficiaryAddress
FROM Beneficiary
WHERE BeneficiaryAddress = 'Lahore, Punjab';

--eClustered Index is automatically created on the Primary Key column by default.


