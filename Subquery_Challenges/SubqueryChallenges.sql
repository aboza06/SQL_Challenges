USE SAMPLEDB
GO

-- Challenge 1: Retrieve the product with the lowest list price across all products.
SELECT 
    product_id,
    product_name,
    list_price,
    category_id
FROM oes.products 
WHERE 
    list_price = (
        SELECT 
            MIN(list_price)
        FROM oes.products
    )

-- Challenge 2: Retrieve the product with the lowest list price within each category.
SELECT 
    product_id,
    product_name,
    list_price,
    category_id
FROM oes.products p1
WHERE 
    list_price = (
        SELECT 
            MIN(list_price)
        FROM oes.products p2
        WHERE p2.category_id = p1.category_id
    )

-- Challenge 3: Use a subquery to find the product with the lowest list price in each category using a join.
SELECT 
    p1.product_id,
    p1.product_name,
    p1.list_price,
    p1.category_id
FROM oes.products p1 JOIN 
    (SELECT 
        category_id,
        MIN(list_price) AS min_list_price
    FROM oes.products
    GROUP BY category_id) p2
ON p1.category_id = p2.category_id AND p1.list_price = p2.min_list_price

-- Challenge 4: Use a CTE to find and display products with the lowest list price in each category.
WITH p2
AS (
    SELECT 
        category_id,
        MIN(list_price) AS min_list_price
    FROM oes.products
    GROUP BY category_id
    )
SELECT 
    p1.product_id,
    p1.product_name,
    p1.list_price,
    p1.category_id
FROM oes.products p1 JOIN p2
ON p1.category_id = p2.category_id AND p1.list_price = p2.min_list_price

-- Challenge 5: Extend the CTE solution to include the category name for the products with the lowest list price.
WITH p2
AS (
    SELECT 
        category_id,
        MIN(list_price) AS min_list_price
    FROM oes.products
    GROUP BY category_id
    )
SELECT 
    p1.product_id,
    p1.product_name,
    p1.list_price,
    p1.category_id,
    cat.category_name
FROM oes.products p1 
JOIN p2 ON p1.category_id = p2.category_id AND p1.list_price = p2.min_list_price
LEFT JOIN oes.product_categories cat ON p1.category_id = cat.category_id

-- Challenge 6: Retrieve employees who have not placed any orders, using a subquery with NOT IN.
SELECT 
    employee_id,
    first_name,
    last_name
FROM hcm.employees
WHERE employee_id NOT IN (
    SELECT 
        employee_id
    FROM oes.orders
    WHERE employee_id IS NOT NULL
) 

-- Challenge 7: Retrieve employees who have not placed any orders, using a subquery with NOT EXISTS.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name
FROM hcm.employees e
WHERE NOT EXISTS (
    SELECT 
        1
    FROM oes.orders o
    WHERE o.employee_id = e.employee_id)

-- Challenge 8: Retrieve customers who have purchased a specific product, 'PBX Smart Watch 4'.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM oes.customers c
WHERE c.customer_id IN (
                    SELECT o.customer_id 
                    FROM oes.orders o
                    JOIN oes.order_items oi ON o.order_id = oi.order_id
                    JOIN oes.products p ON oi.product_id = p.product_id
                    WHERE p.product_name = 'PBX Smart Watch 4'
)
