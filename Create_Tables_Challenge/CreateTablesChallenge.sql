USE SAMPLEDB
GO 

-- Challenge: Create a table to store park information, including park ID, name, and entry fee.
CREATE TABLE parks1
    (
    park_id INT, 
    park_name VARCHAR(50),
    entry_fee DECIMAL(6,2)
    )   

-- Challenge: Insert data into the parks1 table for Bellmont Park with an entry fee of $5.
INSERT INTO dbo.parks1(park_id, park_name, entry_fee)
    VALUES (1, 'Bellmont Park', 5)

-- Challenge: Insert data into the parks1 table for Redmond Park with an entry fee of $10.
INSERT INTO dbo.parks1(park_id, park_name, entry_fee)
    VALUES (2, 'Redmond Park', 10)

-- Challenge: Insert data into the parks1 table for Highland Mountains Park with an entry fee of $15.
INSERT INTO dbo.parks1(park_id, park_name, entry_fee)
    VALUES (3, 'Highland Mountains Park', 15)
