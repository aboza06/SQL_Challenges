USE SAMPLEDB
GO

-- First Challenge -- 

SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM hcm.employees e JOIN hcm.departments d
ON e.department_id = d.department_id


-- Second Challenge --

SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM hcm.employees e LEFT JOIN hcm.departments d
ON e.department_id = d.department_id


-- Third Challenge --
SELECT 
    d.department_name,
    COUNT(*) AS number_of_employees
FROM hcm.employees e LEFT JOIN hcm.departments d
ON e.department_id = d.department_id
GROUP BY d.department_name;