SELECT *
FROM candydata;

-- Which candies have the highest win percentage? What do they have in common?

SELECT competitorname AS candy_name, MAX(winepercent) AS win_percentage,
    MAX(
        CASE 
            WHEN chocolate = 1 AND fruity = 1 THEN 'Chocolate & Fruity Flavor'
            WHEN chocolate = 1 AND caramel = 1 THEN 'Chocolate & Caramel Flavor'
            WHEN chocolate = 1 AND peanutalmondy = 1 THEN 'Chocolate & Peanutalmondy Flavor'
            WHEN fruity = 1 AND caramel = 1 THEN 'Fruity & Caramel Flavor'
            WHEN fruity = 1 AND peanutalmondy = 1 THEN 'Fruity & Peanutalmondy Flavor'
            WHEN caramel = 1 AND peanutalmondy = 1 THEN 'Caramel & Peanutalmondy Flavor'
            WHEN chocolate = 1 THEN 'Chocolate Flavor'
            WHEN fruity = 1 THEN 'Fruity Flavor'
            WHEN caramel = 1 THEN 'Caramel Flavor'
            WHEN peanutalmondy = 1 THEN 'Peanutalmondy Flavor'
            ELSE 'No'
        END
    ) AS Flavor,
    MAX(
        CASE 
            WHEN hard = 1 THEN 'Hard'
            WHEN bar = 1 THEN 'Bar'
            WHEN nougat = 1 THEN 'Nougat'
            WHEN crispedricewafer = 1 THEN 'Crispedricewafer'
            WHEN pluribus = 1 THEN 'Pluribus'
            ELSE 'No' 
        END
    ) AS Category
FROM candydata
WHERE chocolate = 1 OR fruity = 1 OR caramel = 1 OR peanutalmondy = 1
GROUP BY candy_name
ORDER BY win_percentage DESC, candy_name ASC
LIMIT 10;


--Are more expensive candies more popular?
SELECT 
    competitorname AS candy_name,
    ROUND(CAST(pricepercent AS NUMERIC), 2) AS price_percentage, 
    ROUND(CAST(winepercent AS NUMERIC), 2) AS win_percentage,
     --- flavor segment
        CASE 
            WHEN chocolate = 1 AND fruity = 1 THEN 'Chocolate & Fruity Flavor'
            WHEN chocolate = 1 AND caramel = 1 THEN 'Chocolate & Caramel Flavor'
            WHEN chocolate = 1 AND peanutalmondy = 1 THEN 'Chocolate & Peanutalmondy Flavor'
            WHEN fruity = 1 AND caramel = 1 THEN 'Fruity & Caramel Flavor'
            WHEN fruity = 1 AND peanutalmondy = 1 THEN 'Fruity & Peanutalmondy Flavor'
            WHEN caramel = 1 AND peanutalmondy = 1 THEN 'Caramel & Peanutalmondy Flavor'
			WHEN chocolate = 1 THEN 'Chocolate Flavor'
            WHEN fruity = 1 THEN 'Fruity Flavor'
            WHEN caramel = 1 THEN 'Caramel Flavor'
            WHEN peanutalmondy = 1 THEN 'Peanutalmondy Flavor'
            ELSE 'No'
        END AS Flavor	
FROM candydata
WHERE chocolate = 1 OR fruity = 1 OR caramel = 1 OR peanutalmondy = 1
GROUP BY 1,2,3,4
ORDER BY price_percentage DESC, candy_name
LIMIT 10; 
-- The  result shows that the most expensive candies are not popular

-- what about sugary candies?

SELECT 
    competitorname AS candy_name,
	ROUND(CAST(sugarpercent AS NUMERIC), 2) AS suagr_percentage,
    ROUND(CAST(pricepercent AS NUMERIC), 2) AS price_percentage, 
    ROUND(CAST(winepercent AS NUMERIC), 2) AS win_percentage,
	--- flavor segment
   CASE 
            WHEN chocolate = 1 AND fruity = 1 THEN 'Chocolate & Fruity Flavor'
            WHEN chocolate = 1 AND caramel = 1 THEN 'Chocolate & Caramel Flavor'
            WHEN chocolate = 1 AND peanutalmondy = 1 THEN 'Chocolate & Peanutalmondy Flavor'
            WHEN fruity = 1 AND caramel = 1 THEN 'Fruity & Caramel Flavor'
            WHEN fruity = 1 AND peanutalmondy = 1 THEN 'Fruity & Peanutalmondy Flavor'
            WHEN caramel = 1 AND peanutalmondy = 1 THEN 'Caramel & Peanutalmondy Flavor'
			WHEN chocolate = 1 THEN 'Chocolate Flavor'
            WHEN fruity = 1 THEN 'Fruity Flavor'
            WHEN caramel = 1 THEN 'Caramel Flavor'
            WHEN peanutalmondy = 1 THEN 'Peanutalmondy Flavor'
            ELSE 'No'
        END AS Flavor	
FROM candydata
WHERE chocolate = 1 OR fruity = 1 OR caramel = 1 OR peanutalmondy = 1
GROUP BY 1,2,3,4,5
ORDER BY win_percentage DESC, candy_name
LIMIT 10;


--Can you segment the candy into specific groups?

SELECT 
	competitorname AS candy_name,
	
	-- based of flavour

    CASE 
         WHEN chocolate = 1 AND fruity = 1 THEN 'Chocolate & Fruity Flavor'
         WHEN chocolate = 1 AND caramel = 1 THEN 'Chocolate & Caramel Flavor'
         WHEN chocolate = 1 AND peanutalmondy = 1 THEN 'Chocolate & Peanutalmondy Flavor'
         WHEN fruity = 1 AND caramel = 1 THEN 'Fruity & Caramel Flavor'
         WHEN fruity = 1 AND peanutalmondy = 1 THEN 'Fruity & Peanutalmondy Flavor'
         WHEN caramel = 1 AND peanutalmondy = 1 THEN 'Caramel & Peanutalmondy Flavor'
		 WHEN chocolate = 1 THEN 'Chocolate Flavor'
         WHEN fruity = 1 THEN 'Fruity Flavor'
         WHEN caramel = 1 THEN 'Caramel Flavor'
         WHEN peanutalmondy = 1 THEN 'Peanutalmondy Flavor'
         ELSE 'No Flavor'
	END AS flavor_segment,
	
	--based on sugar segment
	
	CASE 
		WHEN CAST(sugarpercent AS NUMERIC) < 0.3 THEN 'Low Sugar'
		WHEN CAST(sugarpercent AS NUMERIC) BETWEEN 0.3 AND 0.7 THEN 'Medium Sugar'
		ELSE 'High Sugar'
	END AS sugar_segment,
	
	--based on price segment 
	
	CASE
		WHEN CAST(pricepercent AS NUMERIC) < 0.3 THEN 'Low Price'
		WHEN CAST(pricepercent AS NUMERIC) BETWEEN 0.3 AND 0.7 THEN 'Medium Price'
		ELSE 'High Price'
	END AS price_segment,
	
	-- base of popularity(win_percentage)
	
	CASE 
        WHEN CAST(winepercent AS NUMERIC) < 0.5 THEN 'Low Popularity'
        WHEN CAST(winepercent AS NUMERIC) BETWEEN 0.5 AND 0.8 THEN 'Medium Popularity'
        ELSE 'High Popularity'
    END AS popularity_segment
		
FROM candydata
WHERE chocolate = 1 OR fruity = 1 OR caramel = 1 OR peanutalmondy = 1
ORDER BY popularity_segment DESC, price_segment ASC, sugar_segment ASC, flavor_segment, candy_name;

