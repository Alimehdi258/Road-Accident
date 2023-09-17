--ROAD ACCIDENT REPORT SQL QUERIES

--CY Casualties
SELECT SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR(accident_date)='2022'
 

--CY Accidents
SELECT COUNT(distinct accident_index) AS CY_Accidents
FROM road_accident
WHERE YEAR(accident_date)='2022'
 

--Fatal Casualties
SELECT SUM(number_of_casualties) AS CY_Fatal_casualties
FROM road_accident
WHERE accident_severity='Fatal'
 

--Serious Casualties
SELECT SUM(number_of_casualties) AS CY_Serious_casualties
FROM road_accident
WHERE accident_severity='Serious'

 

--Slight Casualties
SELECT SUM(number_of_casualties) AS CY_Slight_casualties
FROM road_accident
WHERE accident_severity='Slight'
 



--Percentage of Fatal accidents
SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100/
(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM road_accident ) AS percentage_fatal
FROM road_accident
WHERE accident_severity ='Fatal'
 

--Percentage of Serious accidents
SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100/
(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM road_accident ) AS percentage_fatal
FROM road_accident
WHERE accident_severity ='Serious'
 

--Percentage of Serious accidents
SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100/
(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM road_accident ) AS percentage_fatal
FROM road_accident
WHERE accident_severity ='Slight'
 

--Casualties by Vehicle Type
SELECT 
	CASE
		WHEN vehicle_type in ('Agricultural vehicle') THEN 'Agricultural'
		WHEN vehicle_type in ('Car', 'Taxi/Private hire car') THEN 'Cars'
		WHEN vehicle_type in ('Motorcycle 125cc and under', 'Motorcycle 50cc and under' ,
			'Motorcycle over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle') THEN 'Bike'
		WHEN vehicle_type in ('Bus or coach (17 or more pass seats)',
			'Minibus (8 - 16 passenger seats)') THEN 'Bus'
		WHEN vehicle_type in ('Van / Goods 3.5 tonnes mgw or under',
			'Goods over 3.5t. and under 7.5t', 'Goods 7.5 tonnes mgw and over') THEN 'Van'
		ELSE 'Other'
	END AS vehicle_group,
	SUM(number_of_casualties) AS CY_Casualties
FROM dbo.road_accident
--WHERE YEAR(accident_date)='2022'
GROUP BY
	CASE
		WHEN vehicle_type in ('Agricultural vehicle') THEN 'Agricultural'
		WHEN vehicle_type in ('Car', 'Taxi/Private hire car') THEN 'Cars'
		WHEN vehicle_type in ('Motorcycle 125cc and under', 'Motorcycle 50cc and under' ,
			'Motorcycle over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle') THEN 'Bike'
		WHEN vehicle_type in ('Bus or coach (17 or more pass seats)',
			'Minibus (8 - 16 passenger seats)') THEN 'Bus'
		WHEN vehicle_type in ('Van / Goods 3.5 tonnes mgw or under',
			'Goods over 3.5t. and under 7.5t', 'Goods 7.5 tonnes mgw and over') THEN 'Van'
		ELSE 'Other'
	END
 

--CY Casualties Monthly Trend
SELECT DATENAME(MONTH, accident_date) AS Month_Name
		,SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR(accident_date)='2022'
GROUP BY DATENAME(MONTH, accident_date)
 

--CY Casualties by Road Type
SELECT road_type, SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR(accident_date)='2022'
GROUP BY road_type
 

--CY Casualties by Urban/Rural
SELECT urban_or_rural_area,
		CAST(SUM(number_of_casualties) AS DECIMAL(10,2))*100
		/(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM road_accident
		WHERE YEAR(accident_date)='2022') AS Percentage_of_Casualties
FROM road_accident
WHERE YEAR(accident_date)='2022'
GROUP BY urban_or_rural_area
 

--CY Casualties by Day/Night
SELECT 
	CASE
		WHEN light_conditions IN ('Daylight') THEN 'Day'
		ELSE 'Night'
	END AS Light_Conditions,
	CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2))*100
			/(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM road_accident
			WHERE YEAR(accident_date)='2022') AS DECIMAL(10,2)) AS Percentage_of_Casualties
FROM road_accident
WHERE YEAR(accident_date)='2022'
GROUP BY
	CASE
		WHEN light_conditions in ('Daylight') THEN 'Day'
		ELSE 'Night'
	END
 


--Top 10 Location by Casualties
Select TOP 10 local_authority, SUM(number_of_casualties) AS Total_Casualties

FROM dbo.road_accident
GROUP BY local_authority
ORDER BY Total_Casualties DESC
 
