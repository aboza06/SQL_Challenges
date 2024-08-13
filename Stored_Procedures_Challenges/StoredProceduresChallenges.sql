USE SAMPLEDB
GO

-- Challenge 1: Create a stored procedure to retrieve the quantity on hand for a specific product at a specific warehouse.
CREATE PROCEDURE oes.getQuantityOnHand
(
	@product_id INT,
	@warehouse_id INT
)
AS

BEGIN

-- How much quantity on hand is there for product_id X at warehouse_id Y?
SELECT 
	quantity_on_hand
FROM oes.inventories
WHERE product_id = @product_id 
AND warehouse_id = @warehouse_id;

END

GO

-- Execute the procedure to find out how many units are on hand for product id 4 at warehouse id 2.
EXEC oes.getQuantityOnHand @product_id=4, @warehouse_id=2;
GO

-- Challenge 2: Create a stored procedure to retrieve current (non-discontinued) products based on product name and a maximum list price.
CREATE PROCEDURE oes.getCurrentProducts
(
    @product_name VARCHAR(100),
	@max_list_price DECIMAL(19,2)
)
AS

BEGIN

SELECT
    product_id,
	product_name,
	list_price
FROM oes.products
WHERE discontinued = 0
AND product_name LIKE '%' + @product_name + '%'
AND list_price <= @max_list_price;

END

GO

-- Execute the procedure to select current products that contain the word 'Drone' and have a maximum price of $700.
EXEC oes.getCurrentProducts @product_name = 'Drone', @max_list_price = 700;

GO

-- Challenge 3: Create a stored procedure to transfer funds between two bank accounts, updating balances and recording the transaction.
CREATE PROCEDURE oes.transferFunds
(
	@withdraw_account_id INT,
	@deposit_account_id INT, 
	@transfer_amount DECIMAL(30,2)
) 
AS

SET NOCOUNT ON;

SET XACT_ABORT ON;

BEGIN

BEGIN TRANSACTION;

-- Withdraw (debit) transfer amount from the first bank account:
UPDATE oes.bank_accounts
SET balance = balance - @transfer_amount
WHERE account_id = @withdraw_account_id;

-- Deposit (credit) transfer amount into the second bank account:
UPDATE oes.bank_accounts
SET balance = balance + @transfer_amount
WHERE account_id = @deposit_account_id;

-- Insert the transaction details into the oes.bank_transactions table:
INSERT INTO oes.bank_transactions (from_account_id, to_account_id, amount)
VALUES (@withdraw_account_id, @deposit_account_id, @transfer_amount);

COMMIT TRANSACTION;

END

GO

-- Verify the account balances before the transfer.
SELECT *
FROM oes.bank_accounts;

GO

-- Execute the procedure to transfer $100 from account id 1 (Anna) to account id 2 (Bob).
EXEC oes.transferFunds @withdraw_account_id=1, @deposit_account_id=2, @transfer_amount=100;
GO

-- Verify the account balances after the transfer.
SELECT *
FROM oes.bank_accounts;

GO
