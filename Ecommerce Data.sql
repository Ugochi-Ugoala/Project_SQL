--DATA CLEANING PROJECT 

---I performed data cleaning on a dataset obtained from Kaggle. 
---During the process, I identified some irrelevant columns, missing values, and inconsistent text cases. 
---Below is an overview of the data cleaning process I carried out. 

---About the DATASET:
---This dataset contains detailed information about chairs listed for sale on eBay, 
---including pricing, item condition, seller ratings, and other relevant attributes. 
---It provides valuable insights for anyone interested in analyzing e-commerce trends, predicting prices, 
---or studying market segmentation in the furniture category.

SELECT *
FROM [Ecommerce].[dbo].[Ecommerca Data chairsonebay];

--Creating a new Table 

CREATE TABLE Ecommerce_Chairs_Data(
	title varchar(100),
	categories varchar(100),
	brand varchar(100),
	type varchar(100),
	sold int,
	available int,
	mpn varchar(100),
	item_location varchar(100),
	ships_to varchar(max),
	price varchar(100)
	)
;

--- Inserting into the new table from the original table 

INSERT INTO [Ecommerce].[dbo].[Ecommerce_Chairs_Data](title, categories, brand, type, sold, available, mpn, item_location, ships_to, price)
SELECT title, categories_0, brand, type, sold, available, mpn, itemLocation, shipsTo, priceWithCurrency FROM [Ecommerce].[dbo].[Ecommerca Data chairsonebay];


--- Checking for Duplicate

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
			PARTITION BY title, categories, brand, type, sold, available, mpn, item_Location, ships_to, price
			ORDER BY price ASC) AS row_number
FROM [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
)
SELECT *
FROM duplicate_cte
WHERE row_number > 1;

--Deleting Duplicate rows

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
			PARTITION BY title, categories, brand, type, sold, available, mpn, item_Location, ships_to, price
			ORDER BY categories ASC) AS row_number
FROM [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
)
DELETE
FROM duplicate_cte
WHERE row_number > 1;


-- Standardizing Data

SELECT DISTINCT title, categories
FROM [Ecommerce].[dbo].[Ecommerce_Chairs_Data]

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET categories = 'Electric Massage Chairs'
WHERE categories LIKE 'Chairs%';

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET categories = 'Furniture Parts'
WHERE categories LIKE 'Sofas%' AND title LIKE '%N2X5' OR title LIKE '%T2Q7';

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET categories = CASE
					WHEN categories LIKE 'Sofas & Armchairs%' THEN 'Sofas, Armchairs & Couches'
					WHEN categories LIKE 'Massagers%' THEN 'Electric Massage Chairs'
					WHEN categories LIKE 'Other Home Organization%' THEN 'Electric Massage Chairs'
					WHEN categories LIKE 'Other Office%' THEN 'Home Office Desks'
					WHEN categories LIKE 'Every Other Thing%' THEN 'Electric Massage Chairs'
					WHEN categories LIKE 'Athletic Shoes%' THEN 'Electric Massage Chairs'
					WHEN categories LIKE 'Other Mobility Equipment%' THEN 'Electric Massage Chairs'
					WHEN categories LIKE 'Seat & Posture Cushions%' THEN 'Electric Massage Chairs'
					WHEN categories LIKE 'Desks & Tables%' THEN 'Home Office Desks'
					WHEN categories LIKE 'Office Furniture%' THEN 'Home Office Desks'
					ELSE NULL
				END
WHERE categories LIKE 'Sofas & Armchairs%' 
				OR categories LIKE 'Massagers%'
				OR categories LIKE 'Other Home Organization%'
				OR categories LIKE 'Other Office%' 
				OR categories LIKE 'Every Other Thing%' 
				OR categories LIKE 'Athletic Shoes%' 
				OR categories LIKE 'Other Mobility Equipment%' 
				OR categories LIKE 'Seat & Posture Cushions%' 
				OR categories LIKE 'Desks & Tables%'
				OR categories LIKE 'Office Furniture%'


UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET brand = UPPER(LEFT(brand, 1) + LOWER(RIGHT(brand, LEN(brand) - 1)))
WHERE brand iS NOT NULL;

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET brand = 'UNKNOWN'
WHERE brand iS NULL;

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET type = CASE 
				WHEN type LIKE 'Massage Chair Recliner%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'Massage Recliner Chair w%'  OR type LIKE 'Chair%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'Recliner Chair%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'recliner chair%' THEN 'Massage Chair Recliner'
				WHEN type LIKE 'Massage Recliner Chair S%' OR type LIKE 'L%' THEN 'Massage Chair Recliner'
				WHEN type LIKE 'Massage Chair Cu%' OR type LIKE 'Remote%' THEN 'Massage Chair Recliner'
				WHEN type LIKE 'H%' OR type LIKE 'Recliner, Folding C%' THEN 'Massage Chair Recliner'
				WHEN type LIKE 'Does not ap%' OR type LIKE 'N%' THEN 'Unknown'
				WHEN type LIKE 'F%' THEN 'Massage Chair Recliner'
				WHEN type LIKE 'S%' OR type LIKE 's%' THEN 'Massage Chair Recliner'
				WHEN type LIKE 'C%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'Power Lift Re%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'Sleeper Cha%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'R%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'O%' THEN 'Massage Office Chair'
				WHEN type LIKE 'm%' OR type LIKE 'E%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'Recliner, Ar%' OR type LIKE 'l%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'A%'  OR type LIKE 'a%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'Power Lift Recli%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'u%'  OR type LIKE 'Recliner Chair, Massag%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'Rocker Reclin%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'Recliner, Reception/Gu%' THEN 'Massage Office Chair'
				WHEN type LIKE 'G%' OR type LIKE 'L%' THEN 'Massage Recliner Chair'
				WHEN type LIKE 'Dining Cha%' THEN 'Massage Recliner Chair'
				ELSE NULL
			END
WHERE type LIKE 'Massage Chair Recliner%' 
				OR type LIKE 'Massage Recliner Chair w%'  OR type LIKE 'Chair%' 
				OR type LIKE 'Recliner Chair%' 
				OR type LIKE 'recliner chair%'
				OR type LIKE 'Massage Recliner Chair S%' OR type LIKE 'L%'
				OR type LIKE 'Massage Chair Cu%' OR type LIKE 'Remote%'
				OR type LIKE 'H%' OR type LIKE 'Recliner, Folding C%' 
				OR type LIKE 'Does not ap%' OR type LIKE 'N%'
				OR type LIKE 'F%'
				OR type LIKE 'S%' OR type LIKE 's%' 
				OR type LIKE 'C%' 
				OR type LIKE 'Power Lift Re%'
				OR type LIKE 'Sleeper Cha%' 
				OR type LIKE 'R%' 
				OR type LIKE 'O%' 
				OR type LIKE 'm%' OR type LIKE 'E%' 
				OR type LIKE 'Recliner, Ar%' OR type LIKE 'l%' 
				OR type LIKE 'A%'  OR type LIKE 'a%' 
				OR type LIKE 'Power Lift Recli%' 
				OR type LIKE 'u%'  OR type LIKE 'Recliner Chair, Massag%' 
				OR type LIKE 'Rocker Reclin%' 
				OR type LIKE 'Recliner, Reception/Gu%'
				OR type LIKE 'G%' OR type LIKE 'L%' 
				OR type LIKE 'Dining Cha%';

--- Removing NULL values

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET sold = 0
WHERE sold iS NULL;

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET available = 0
WHERE available iS NULL;

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET mpn = 'Unknown'
WHERE mpn iS NULL;

SELECT item_location
FROM [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
ORDER BY item_location

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = 'Xingtai China'
WHERE item_location LIKE 'Xingtai%';

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = 'California United State'
WHERE item_location LIKE 'California%';

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = 'Canada, Pennsylvania, United States'
WHERE item_location LIKE 'California%';

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = 'Canada, Pennsylvania, United States'
WHERE item_location LIKE 'CA,P%'

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = 'Canada, United States'
WHERE item_location LIKE 'CA,%'

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = CASE 
						WHEN item_location LIKE 'Dallas, TX, U%' THEN 'Dallas, Texas, United States'
						WHEN item_location LIKE 'GRAND PRAIRIE, TX, U%' THEN 'GRAND PRAIRIE, Texas, United States'
						ELSE NULL
					END
WHERE item_location LIKE 'Dallas, TX, U%' OR item_location LIKE 'GRAND PRAIRIE, TX, U%';


UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = CASE 
						WHEN item_location LIKE 'CA/GA, United Sta%' THEN 'Canada, Georgia, United States'
						WHEN item_location LIKE 'GA, United S%' THEN 'Georgia, United States'
						ELSE NULL
					END
WHERE item_location LIKE 'CA/GA, United Sta%' OR item_location LIKE 'GA, United S%';

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = 'North Brunswick Township, New Jersey, United States'
WHERE item_location LIKE 'North Brunswick Township, NJ, Un%';

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = 'Shenzhen, China'
WHERE item_location LIKE 'SZ, Ch%';

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = 'New York, United States'
WHERE item_location LIKE 'New York, New Yor%';

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = 'Fujian Xiamen, China'
WHERE item_location LIKE 'fujian xiamen, Ch%';


UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = REPLACE(item_location, ',', ', ')
WHERE item_location LIKE '%,%';

SELECT brand
FROM [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
WHERE item_location LIKE 'h%';

-- Converting the column to ProperCase
SELECT 
    CONCAT(
        UPPER(LEFT(item_location, 1)),
        LOWER(SUBSTRING(item_location, 2, LEN(item_location)))
    ) AS propercase_column
FROM [Ecommerce].[dbo].[Ecommerce_Chairs_Data];

--- Creating a Function for ProperCase in the Database

CREATE FUNCTION dbo.ProperCase(@Text AS VARCHAR(8000))
RETURNS VARCHAR(8000)
AS
BEGIN
    DECLARE @Reset BIT;
    DECLARE @Ret VARCHAR(8000);
    DECLARE @i INT;
    DECLARE @c CHAR(1);

    SELECT @Reset = 1, @i = 1, @Ret = '';

    WHILE (@i <= LEN(@Text))
    SELECT @c = SUBSTRING(@Text, @i, 1),
           @Ret = @Ret + CASE WHEN @Reset = 1 THEN UPPER(@c) ELSE LOWER(@c) END,
           @Reset = CASE WHEN @c LIKE '[a-zA-Z]' THEN 0 ELSE 1 END,
           @i = @i + 1
    RETURN @Ret
END

-- Converting Columns to ProperCase Format 

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET item_location = dbo.ProperCase(item_location);

SELECT * FROM [Ecommerce].[dbo].[Ecommerce_Chairs_Data];

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET brand = dbo.ProperCase(brand);

UPDATE [Ecommerce].[dbo].[Ecommerce_Chairs_Data]
SET ships_to = dbo.ProperCase(ships_to);

SELECT *
FROM [Ecommerce].[dbo].[Ecommerce_Chairs_Data];
