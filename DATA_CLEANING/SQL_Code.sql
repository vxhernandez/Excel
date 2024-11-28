
/*********************************Staging Table*******************************/

create table working_copy (
BROKERTITLE VARCHAR(255),
TYPE VARCHAR(255),
SALETYPE VARCHAR(255),
   CITY VARCHAR(255),
   ZIP VARCHAR(20),
   LOCALITY VARCHAR(255),
   SUBLOCALITY VARCHAR(255),
   NEIGHBORHOOD VARCHAR(255),
   PRICE DECIMAL(15, 2),
    BEDS DECIMAL(3, 1),
    BATH INT,
    PROPERTYSQFT INT,
    ADDRESS VARCHAR(255),
    LATITUDE DECIMAL(10, 6),
    LONGITUDE DECIMAL(10, 6)
	);

/*********************************Database tables*******************************/

--BROKER TABLE
CREATE TABLE Brokers (
    BrokerID INT PRIMARY KEY IDENTITY,
    BrokerTitle VARCHAR(255)
);

--PROPERTY TABLE
CREATE TABLE PropertyTypes (
    TypeID INT PRIMARY KEY IDENTITY,
    Type VARCHAR(255)
);

--LOCATIONS
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY IDENTITY,
    City VARCHAR(255),
    ZipCode VARCHAR(20),
    Locality VARCHAR(255),
    SubLocality VARCHAR(255),
    Neighborhood VARCHAR(255)
);

CREATE TABLE SaleType (
    SaleTypeID INT PRIMARY KEY IDENTITY(1,1),
    SaleTypeName NVARCHAR(50)
);

--PROPERTIES TABLE
CREATE TABLE Properties (
    PropertyID INT PRIMARY KEY IDENTITY,
    BrokerID INT,
    TypeID INT,
    LocationID INT,
	SaleTypeID INT,
    Price DECIMAL(15, 2),
    Beds INT,
    Bath INT,
    PropertySqFt INT,
    Address VARCHAR(255),
    Latitude DECIMAL(10, 6),
    Longitude DECIMAL(10, 6),
    FOREIGN KEY (BrokerID) REFERENCES Brokers(BrokerID),
    FOREIGN KEY (TypeID) REFERENCES PropertyTypes(TypeID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
	FOREIGN KEY (SaleTypeID) REFERENCES SaleType(SaleTypeID)
);


--***************************POPULATE TABLES with data******************************
--BROKER TABLE
INSERT INTO Brokers (BrokerTitle)
SELECT DISTINCT BROKERTITLE
FROM working_copy;

--PROPERTY TYPE
INSERT INTO PropertyTypes(Type)
SELECT DISTINCT TYPE
FROM working_copy;

-- Insert into SaleType
INSERT INTO SaleType (SaleTypeName)
VALUES ('For Sale'), ('Foreclosure'), ('Pending'), ('Contingent'), ('Coming Soon');

--insert into locations
INSERT INTO Locations (City, ZipCode, Locality, SubLocality, Neighborhood)
SELECT City, Zip, Locality, SubLocality, Neighborhood
FROM working_copy;

--insert into Properties
INSERT INTO Properties(BrokerID, TypeID, LocationID, SaleTypeID, price, beds, bath, PropertySqFt, address, Latitude, Longitude)
SELECT BrokerID, TypeID, LocationID, SaleTypeID, price, beds, bath, PropertySqFt, address, Latitude, Longitude
FROM working_copy;


/*********************************Cleaning and Transformation*******************************

Add columns for each ID in the working_copy table and populate them with data 
sourced from the locations, saletype, and related tables.
Repopulate the referenced tables (locations, saletype, etc.) with data 
from the working_copy table, including the associated IDs.
*******************************************************************************************/

UPDATE working_copy
SET locationID = l.locationID
FROM locations l
WHERE working_copy.City = l.City
  AND working_copy.Zip = l.ZipCode
  AND working_copy.Locality = l.Locality
  AND working_copy.SubLocality = l.SubLocality
  AND working_copy.Neighborhood = l.Neighborhood;

UPDATE working_copy
SET saletypeID = l.saletypeID
FROM saletype l
WHERE working_copy.saletype = l.saletypename;

-- Separated property type from the existing TYPE column
-- Added a new column, sale_type, to store the extracted sale type
ALTER TABLE working_copy
ADD sale_type VARCHAR(50);

-- Populated the new sale_type column based on keywords in the TYPE column
UPDATE working_copy
SET sale_type = CASE
    WHEN TYPE LIKE '%for sale%' THEN 'For Sale'
    WHEN TYPE LIKE '%Foreclosure%' THEN 'Foreclosure'
    WHEN TYPE LIKE '%Pending%' THEN 'Pending'
    WHEN TYPE LIKE '%Contingent%' THEN 'Contingent'
    WHEN TYPE LIKE '%Coming Soon%' THEN 'Coming Soon'
    ELSE 'Unknown'
END;

/****************************************additional cleaning and transformation*******************************

Cleaned the TYPE Column for Property Types now properties without propper type are listed as unknown
Improved Clarity: Separating TYPE and SaleType ensures that each column has a single, clear purpose.
Flexibility: Enables analysis of both property types and market activity separately.
Inclusivity: Retains rows with unknown property types by labeling them as "Unknown," ensuring no data is lost prematurely.

****************************************************************************************************************/
UPDATE working_copy
SET TYPE = CASE
    WHEN TYPE LIKE '%House for sale%' THEN 'House'
    WHEN TYPE LIKE '%Condo for sale%' THEN 'Condo'
    WHEN TYPE LIKE '%Townhouse for sale%' THEN 'Townhouse'
    WHEN TYPE LIKE '%Land for sale%' THEN 'Land'
    WHEN TYPE LIKE '%Mobile house for sale%' THEN 'Mobile Home'
    WHEN TYPE LIKE '%Multi-family home for sale%' THEN 'Multi-family Home'
    WHEN TYPE LIKE '%Co-op for sale%' THEN 'Co-op'
    ELSE 'Unknown'
END;

-- Standardized variations of the BROKERTITLE field
UPDATE working_copy
SET BROKERTITLE = CASE
    WHEN BROKERTITLE LIKE '%EXIT HOME KEY REALTY%' THEN 'Exit Home Key Realty'
    ELSE BROKERTITLE
END;

-- Consolidated multiple variations of Century 21 into a single standard name
UPDATE working_copy
SET BROKERTITLE = 'Century 21'
WHERE BROKERTITLE IN (
    'CENTURY 21 KR REALTY',
    'CENTURY 21 METRO STAR',
    'CENTURY 21 ROYAL',
    'CENTURY 21 SAHARA REALTY'
);

-- Standardized variations in the TYPE field and assign meaningful property types
UPDATE working_copy
SET TYPE = CASE
    WHEN TYPE LIKE '%VYLLA HOME%' THEN 'Vylla Home'
    WHEN TYPE LIKE '%UNITED NATIONAL REALTY%' THEN 'United National Realty'
    WHEN TYPE LIKE '%TREE OF LIFE REALTY & MANAGEMENT LLC%' THEN 'Tree Of Life Realty & Management LLC'
    WHEN TYPE LIKE '%TREBACH REALTY INC%' THEN 'Trebach Realty Inc'
    WHEN TYPE LIKE '%TRACEY REAL ESTATE%' THEN 'Top Nest Inc'
    WHEN TYPE LIKE '%TOP NEST INC%' THEN 'Multi-family Home'
    WHEN TYPE LIKE '%THE BOX ADVISORY LLC%' THEN 'The Box Advisory LLC'
    ELSE 'Unknown'
END;

-- Update BROKERTITLE to proper case for consistency
UPDATE working_copy
SET BROKERTITLE = 'Christie''s International Real Estate New York'
WHERE BROKERTITLE = 'CHRISTIE''S INTERNATIONAL REAL ESTATE NEW YORK';

UPDATE working_copy
SET BROKERTITLE = 'Carini Group - Carini Group'
WHERE BROKERTITLE = 'CARINI GROUP - CARINI GROUP';

-- Standardize LOCALITY and SUBLOCALITY fields in the LOCATIONS table
UPDATE locations
SET locality = 'New York City',
    sublocality = CASE
        WHEN neighborhood IN ('Bronx County', 'The Bronx') THEN 'Bronx'
        WHEN neighborhood = 'Kings County' THEN 'Brooklyn'
        WHEN neighborhood = 'New York County' THEN 'Manhattan'
        WHEN neighborhood = 'Queens County' THEN 'Queens'
        WHEN neighborhood = 'Richmond County' THEN 'Staten Island'
        ELSE sublocality -- Preserve existing value for unmatched records
    END;















