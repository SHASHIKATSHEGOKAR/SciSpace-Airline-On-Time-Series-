USE scispace;

SELECT * FROM scispace.airline;

-- Convert 'Departure_Date' to date format (assuming it's in 'YYYY-MM-DD' format)
UPDATE airline
SET Departure_Date =
    CASE
        WHEN Departure_Date LIKE '%/%/%' THEN STR_TO_DATE(Departure_Date, '%m/%d/%Y')
        WHEN Departure_Date LIKE '%-%-%' THEN STR_TO_DATE(Departure_Date, '%m-%d-%Y')
        -- Add more format checks and conversions as needed
        ELSE NULL  -- Set to NULL for unmatched formats or handle differently
    END;

ALTER TABLE airline
ADD COLUMN Month_Name VARCHAR(20); -- Change the VARCHAR length as needed

UPDATE airline
SET Month_Name = DATE_FORMAT(Departure_Date, '%M');

UPDATE airline
SET Departure_Date = MONTH(Departure_Date);


-- Demographic Trends How has the age distribution of passengers evolved over the years?
    
    SELECT Month_Name AS Month, AVG(Age) AS Avg_Age
FROM airline
GROUP BY Month
ORDER BY Month;

-- Gender Analysis Query to examine gender-based trends in passenger demographics over time:

SELECT Month_Name AS Month, Gender, COUNT(*) AS Gender_Count
FROM airline
GROUP BY Month, Gender
ORDER BY Month;

-- Nationality Insights Query to identify the nationalities with the highest and lowest representation among passengers over time:

SELECT Month_Name AS Month, Nationality, COUNT(*) AS Nationality_Count
FROM airline
GROUP BY Month, Nationality
HAVING Month IS NOT NULL
ORDER BY Month, Nationality_Count DESC;

-- Flight Status Analysis Query to analyze the distribution of flight statuses over the years:

SELECT Month_Name AS Month, Flight_Status, COUNT(*) AS Status_Count
FROM airline
GROUP BY Month, Flight_Status
ORDER BY Month;

-- Pilot Performance Query to identify patterns in flight statuses based on pilot names:

SELECT Pilot_Name, Flight_Status, COUNT(*) AS Status_Count
FROM airline
GROUP BY Pilot_Name, Flight_Status
ORDER BY Pilot_Name, Status_Count DESC;

-- Airport Traffic Query to analyze passenger traffic at different airports over time:

SELECT Month_Name AS Month, Airport_Name, COUNT(*) AS Passenger_Count
FROM airline
GROUP BY Month, Airport_Name
ORDER BY Month, Passenger_Count DESC;

-- Country-wise Analysis Query to identify the most common destination countries over time:

SELECT Month_Name AS Month, Country_Name, COUNT(*) AS Destination_Count
FROM airline
GROUP BY Month, Country_Name
HAVING Month IS NOT NULL
ORDER BY Month, Destination_Count DESC;

-- Continent Analysis Query to analyze the distribution of airports and passengers by continent over time:

SELECT Month_Name AS Month, Airport_Continent, COUNT(DISTINCT Airport_Name) AS Airport_Count, COUNT(*) AS Passenger_Count
FROM airline
GROUP BY Month, Airport_Continent
ORDER BY Month, Passenger_Count DESC;

-- Seasonal Patterns Query to identify seasonal trends in passenger numbers:

SELECT Month_Name AS Month, AVG(Passenger_ID) AS Avg_Passenger_Count
FROM airline
GROUP BY Month
ORDER BY Month;

-- Long-term Trends Query to identify long-term trends in passenger numbers:

SELECT Month_Name AS Month, COUNT(*) AS Passenger_Count
FROM airline
GROUP BY Month
ORDER BY Month;


