-- =============================================================
-- Franchise Restaurant Database
-- MWC3 2026 - Database Design Competition
-- Sample UPDATE Statements - Microsoft SQL Server (T-SQL)
-- =============================================================

-- -------------------------------------------------------------
-- UPDATE: store
-- Deactivate a store that has closed
-- -------------------------------------------------------------
UPDATE store
SET    is_active    = 0,
       closing_date = '2024-06-01'
WHERE  store_id     = 4;

-- Update a store address
UPDATE store
SET    address  = '999 New Main St',
       city     = 'Austin',
       state    = 'TX',
       zip      = '73305'
WHERE  store_id = 1;

-- -------------------------------------------------------------
-- UPDATE: email
-- Correct a store email address
-- -------------------------------------------------------------
UPDATE email
SET    email_address = 'downtown.new@grillfranchise.com'
WHERE  email_id      = 1;

-- -------------------------------------------------------------
-- UPDATE: phone
-- Update a store phone number
-- -------------------------------------------------------------
UPDATE phone
SET    phone_number = '512-100-9999'
WHERE  phone_id     = 1;

-- -------------------------------------------------------------
-- UPDATE: employee
-- Deactivate an employee who has left the company
-- -------------------------------------------------------------
UPDATE employee
SET    is_active         = 0,
       termination_date  = '2024-05-15'
WHERE  employee_id       = 4;

-- Update an employee email address
UPDATE employee
SET    email        = 'jcarter.new@grillfranchise.com'
WHERE  employee_id  = 1;

-- -------------------------------------------------------------
-- UPDATE: employee_store
-- Close out an assignment when an employee leaves a store
-- -------------------------------------------------------------
UPDATE employee_store
SET    is_active  = 0,
       end_date   = '2024-05-15'
WHERE  employee_id = 4
AND    store_id    = 4;

-- -------------------------------------------------------------
-- UPDATE: menu
-- Rename a menu
-- -------------------------------------------------------------
UPDATE menu
SET    menu_name = 'Sunday Brunch Special',
       menu_type = 'Brunch'
WHERE  menu_id   = 4;

-- -------------------------------------------------------------
-- UPDATE: menuitem
-- Update the price of a menu item
-- -------------------------------------------------------------
UPDATE menuitem
SET    price       = 13.99
WHERE  menuitem_id = 1;

-- Update a menu item description
UPDATE menuitem
SET    description  = 'Juicy beef patty with lettuce, tomato, pickles, and our new signature sauce'
WHERE  menuitem_id  = 1;

-- -------------------------------------------------------------
-- UPDATE: recipe
-- Update cooking instructions for a recipe
-- -------------------------------------------------------------
UPDATE recipe
SET    instructions = 'Form patty, season with salt, pepper, and garlic powder, grill 5 minutes each side, assemble with toasted bun and toppings.'
WHERE  recipe_id    = 1;

-- -------------------------------------------------------------
-- UPDATE: recipeingredients
-- Adjust quantity of an ingredient in a recipe
-- -------------------------------------------------------------
UPDATE recipeingredients
SET    quantity             = 0.35
WHERE  recipe_id            = 4
AND    product_id           = 8;

-- -------------------------------------------------------------
-- UPDATE: inventory
-- Update inventory quantity after restocking
-- -------------------------------------------------------------
UPDATE inventory
SET    quantity      = 100.00,
       last_updated  = GETDATE()
WHERE  store_id      = 1
AND    product_id    = 1;

-- Reduce inventory after usage
UPDATE inventory
SET    quantity      = quantity - 5.00,
       last_updated  = GETDATE()
WHERE  store_id      = 1
AND    product_id    = 9;