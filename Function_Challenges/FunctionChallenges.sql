USE SAMPLEDB
GO 

-- Challenge 1: Retrieve each employee's ID, first name, last name, and create a concatenated full name using first and last names.
SELECT 
    employee_id,
    first_name,
    last_name,
    CONCAT(first_name + ' ', last_name) AS employee_name
FROM hcm.employees

-- Challenge 2: Retrieve each employee's ID and create a concatenated full name using first, middle, and last names.
SELECT 
    employee_id,
    first_name,
    last_name,
    CONCAT(first_name, ' ' + middle_name, ' ' + last_name) AS employee_name
FROM hcm.employees

-- Challenge 3: Extract and display the genus name from the scientific name of Antarctic bird species.
SELECT 
    LEFT(scientific_name, CHARINDEX(' ', scientific_name) - 1) AS genus_name
FROM bird.antarctic_species

-- Challenge 4: Extract and display the species name from the scientific name of Antarctic bird species.
SELECT 
    SUBSTRING(scientific_name, CHARINDEX(' ', scientific_name) + 1, LEN(scientific_name) - CHARINDEX(' ', scientific_name)) AS scientific_name
FROM bird.antarctic_species

-- Challenge 5: Calculate and display the age of each employee based on their birth date.
SELECT 
    employee_id,
    first_name,
    last_name,
    birth_date,
    DATEDIFF(year, birth_date, CURRENT_TIMESTAMP) AS employee_age
FROM hcm.employees

-- Challenge 6: Calculate and display the estimated shipping date, which is 7 days after the order date, for shipped orders.
SELECT 
    order_id,
    order_date,
    DATEADD(day, 7, order_date) AS estimated_shipping_date
FROM oes.orders
WHERE shipped_date IS NOT NULL

-- Challenge 7: Calculate and display the average shipping time for each company, measured in days between the order date and shipped date.
SELECT
    s.company_name,
    AVG(DATEDIFF(DAY, o.order_date, o.shipped_date)) AS avg_shipping_days
FROM oes.orders o
JOIN oes.shippers s ON o.shipper_id = s.shipper_id
GROUP BY s.company_name
