-- =============================================================
-- Franchise Restaurant Database
-- MWC3 2026 - Database Design Competition
-- Sample INSERT Statements - Microsoft SQL Server (T-SQL)
-- =============================================================

-- -------------------------------------------------------------
-- INSERT: store
-- -------------------------------------------------------------
INSERT INTO store (store_name, address, city, state, zip, opening_date, closing_date, is_active)
VALUES
    ('Downtown Grill',     '123 Main St',     'Austin',   'TX', '73301', '2018-03-15', NULL, 1),
    ('Westside Grill',     '456 West Ave',    'Austin',   'TX', '73302', '2019-07-01', NULL, 1),
    ('Northpark Grill',    '789 North Blvd',  'Dallas',   'TX', '75201', '2020-11-20', NULL, 1),
    ('Lakewood Grill',     '321 Lake Rd',     'Dallas',   'TX', '75202', '2017-05-10', '2023-01-01', 0);

-- -------------------------------------------------------------
-- INSERT: email
-- -------------------------------------------------------------
INSERT INTO email (store_id, email_address)
VALUES
    (1, 'downtown@grillfranchise.com'),
    (1, 'downtown.support@grillfranchise.com'),
    (2, 'westside@grillfranchise.com'),
    (3, 'northpark@grillfranchise.com'),
    (4, 'lakewood@grillfranchise.com');

-- -------------------------------------------------------------
-- INSERT: phone
-- -------------------------------------------------------------
INSERT INTO phone (store_id, phone_number, phone_type)
VALUES
    (1, '512-100-1001', 'Main'),
    (1, '512-100-1002', 'Fax'),
    (2, '512-200-2001', 'Main'),
    (3, '214-300-3001', 'Main'),
    (4, '214-400-4001', 'Main');

-- -------------------------------------------------------------
-- INSERT: employee
-- -------------------------------------------------------------
INSERT INTO employee (first_name, last_name, email, hire_date, termination_date, is_active)
VALUES
    ('James',   'Carter',   'jcarter@grillfranchise.com',   '2018-03-15', NULL,         1),
    ('Sofia',   'Reyes',    'sreyes@grillfranchise.com',    '2019-06-01', NULL,         1),
    ('Marcus',  'Lee',      'mlee@grillfranchise.com',      '2020-01-10', NULL,         1),
    ('Priya',   'Patel',    'ppatel@grillfranchise.com',    '2017-05-10', '2023-01-01', 0),
    ('Daniel',  'Brooks',   'dbrooks@grillfranchise.com',   '2021-08-15', NULL,         1);

-- -------------------------------------------------------------
-- INSERT: employee_store
-- -------------------------------------------------------------
INSERT INTO employee_store (employee_id, store_id, role, start_date, end_date, is_active)
VALUES
    (1, 1, 'Store Manager',     '2018-03-15', NULL,         1),
    (2, 2, 'Store Manager',     '2019-07-01', NULL,         1),
    (3, 3, 'Store Manager',     '2020-11-20', NULL,         1),
    (4, 4, 'Store Manager',     '2017-05-10', '2023-01-01', 0),
    (5, 1, 'Shift Supervisor',  '2021-08-15', NULL,         1),
    (5, 2, 'Shift Supervisor',  '2022-01-01', NULL,         1);

-- -------------------------------------------------------------
-- INSERT: menu
-- -------------------------------------------------------------
INSERT INTO menu (menu_name, menu_type)
VALUES
    ('Morning Menu',    'Breakfast'),
    ('Afternoon Menu',  'Lunch'),
    ('Evening Menu',    'Dinner'),
    ('Weekend Special', 'Seasonal');

-- -------------------------------------------------------------
-- INSERT: storemenu
-- -------------------------------------------------------------
INSERT INTO storemenu (store_id, menu_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 2),
    (2, 3),
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 4);

-- -------------------------------------------------------------
-- INSERT: recipe
-- -------------------------------------------------------------
INSERT INTO recipe (recipe_name, instructions)
VALUES
    ('Classic Burger Recipe',   'Form patty, season with salt and pepper, grill 4 minutes each side, assemble with bun and toppings.'),
    ('Caesar Salad Recipe',     'Chop romaine, toss with caesar dressing, top with croutons and parmesan.'),
    ('Pancake Stack Recipe',    'Mix batter, pour onto griddle, cook until bubbles form, flip and cook 1 more minute.'),
    ('Grilled Chicken Recipe',  'Marinate chicken, grill 6 minutes each side until internal temp reaches 165F.'),
    ('French Fries Recipe',     'Cut potatoes into strips, fry at 375F for 5 minutes until golden brown, season with salt.');

-- -------------------------------------------------------------
-- INSERT: menuitem
-- -------------------------------------------------------------
INSERT INTO menuitem (menu_id, recipe_id, item_name, price, description)
VALUES
    (2, 1, 'Classic Burger',    12.99, 'Juicy beef patty with lettuce, tomato, and house sauce'),
    (2, 2, 'Caesar Salad',       9.99, 'Crisp romaine with caesar dressing, croutons, and parmesan'),
    (1, 3, 'Pancake Stack',      8.99, 'Three fluffy pancakes served with maple syrup and butter'),
    (3, 4, 'Grilled Chicken',   14.99, 'Herb marinated grilled chicken breast with seasonal vegetables'),
    (3, 5, 'French Fries',       4.99, 'Crispy golden fries seasoned with sea salt'),
    (4, 1, 'Weekend Burger',    15.99, 'Premium version of our classic burger with bacon and avocado');

-- -------------------------------------------------------------
-- INSERT: product
-- -------------------------------------------------------------
INSERT INTO product (product_name, unit)
VALUES
    ('Beef Patty',      'piece'),
    ('Burger Bun',      'piece'),
    ('Romaine Lettuce', 'kg'),
    ('Caesar Dressing', 'liter'),
    ('Croutons',        'kg'),
    ('Parmesan',        'kg'),
    ('Pancake Mix',     'kg'),
    ('Chicken Breast',  'kg'),
    ('Potato',          'kg'),
    ('Cooking Oil',     'liter');

-- -------------------------------------------------------------
-- INSERT: recipeingredients
-- -------------------------------------------------------------
INSERT INTO recipeingredients (recipe_id, product_id, quantity)
VALUES
    -- Classic Burger Recipe
    (1, 1, 1.00),
    (1, 2, 1.00),
    -- Caesar Salad Recipe
    (2, 3, 0.20),
    (2, 4, 0.05),
    (2, 5, 0.05),
    (2, 6, 0.03),
    -- Pancake Stack Recipe
    (3, 7, 0.15),
    -- Grilled Chicken Recipe
    (4, 8, 0.30),
    -- French Fries Recipe
    (5, 9, 0.25),
    (5, 10, 0.10);

-- -------------------------------------------------------------
-- INSERT: inventory
-- -------------------------------------------------------------
INSERT INTO inventory (store_id, product_id, quantity, last_updated)
VALUES
    (1, 1,  50.00, GETDATE()),
    (1, 2,  50.00, GETDATE()),
    (1, 3,  10.00, GETDATE()),
    (1, 4,   5.00, GETDATE()),
    (1, 9,  30.00, GETDATE()),
    (1, 10, 20.00, GETDATE()),
    (2, 1,  40.00, GETDATE()),
    (2, 2,  40.00, GETDATE()),
    (2, 8,  15.00, GETDATE()),
    (3, 1,  60.00, GETDATE()),
    (3, 7,  25.00, GETDATE()),
    (3, 9,  35.00, GETDATE());