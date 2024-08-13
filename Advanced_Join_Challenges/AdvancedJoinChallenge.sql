USE SAMPLEDB
GO 

-- Challenge 1: Retrieve each employee's ID, name, and their manager's name.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e2.first_name AS manager_first_name,
    e2.last_name AS manager_last_name
FROM hcm.employees e LEFT JOIN hcm.employees e2 
ON e.manager_id = e2.employee_id

-- Challenge 2: Display product details along with the warehouse they are stored in and the quantity available.
SELECT 
    p.product_id,
    p.product_name,
    w.warehouse_id,
    w.warehouse_name,
    i.quantity_on_hand
FROM oes.products p JOIN oes.inventories i
ON p.product_id = i.product_id
JOIN oes.warehouses w
ON i.warehouse_id = w.warehouse_id 

-- Challenge 3: List employees in Australia, including their department and job title.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name,
    j.job_title,
    e.state_province
FROM hcm.employees e LEFT JOIN hcm.departments d 
ON d.department_id = e.department_id
JOIN hcm.jobs j 
ON e.job_id = j.job_id
JOIN hcm.countries c 
ON e.country_id = c.country_id
WHERE c.country_name = 'Australia';

-- Challenge 4: Show the total quantity ordered for each product by category, sorted by category and product name.
SELECT 
    p.product_name,
    c.category_name,
    SUM(o.quantity) AS quantity_ordered
FROM oes.products p JOIN oes.product_categories c ON p.category_id = c.category_id
JOIN oes.order_items o ON p.product_id = o.product_id
GROUP BY 
    p.product_name,
    c.category_name
ORDER BY
    c.category_name ASC,
    p.product_name ASC;

-- Challenge 5: Include null values in the product category when showing total quantity ordered, setting nulls to 0.
SELECT 
    p.product_name,
    c.category_name,
    COALESCE(SUM(o.quantity),0) AS quantity_ordered
FROM oes.products p LEFT JOIN oes.product_categories c ON p.category_id = c.category_id
JOIN oes.order_items o ON p.product_id = o.product_id
GROUP BY 
    p.product_name,
    c.category_name
ORDER BY 
    c.category_name ASC,
    p.product_name ASC;
