USE SAMPLEDB
GO

-- First Challenge: Retrieve each employee's ID, name, salary, and their department name using an inner join.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM hcm.employees e JOIN hcm.departments d
ON e.department_id = d.department_id

-- Second Challenge: Retrieve all employees, including those without a department, showing their ID, name, salary, and department name if available.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM hcm.employees e LEFT JOIN hcm.departments d
ON e.department_id = d.department_id

-- Third Challenge: Count the number of employees in each department, including departments with no employees.
SELECT 
    d.department_name,
    COUNT(*) AS number_of_employees
FROM hcm.employees e LEFT JOIN hcm.departments d
ON e.department_id = d.department_id
GROUP BY d.department_name;
