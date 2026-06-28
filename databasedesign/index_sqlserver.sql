-- =============================================================
-- Franchise Restaurant Database
-- MWC3 2026 - Database Design Competition
-- Indexes - Microsoft SQL Server (T-SQL)
-- =============================================================

-- -------------------------------------------------------------
-- INDEX: email
-- Frequently looked up by store to find all emails for a location
-- -------------------------------------------------------------
CREATE INDEX idx_email_store_id ON email(store_id);

-- -------------------------------------------------------------
-- INDEX: phone
-- Frequently looked up by store to find all phone numbers for a location
-- -------------------------------------------------------------
CREATE INDEX idx_phone_store_id ON phone(store_id);

-- -------------------------------------------------------------
-- INDEX: employee
-- Looked up by last name when searching for an employee
-- is_active filtered frequently to get only current employees
-- -------------------------------------------------------------
CREATE INDEX idx_employee_last_name ON employee(last_name);
CREATE INDEX idx_employee_is_active ON employee(is_active);

-- -------------------------------------------------------------
-- INDEX: employee_store
-- Looked up by store to find all employees at a location
-- Looked up by employee to find all stores they work at
-- is_active filtered frequently to get only current assignments
-- -------------------------------------------------------------
CREATE INDEX idx_empstore_store_id    ON employee_store(store_id);
CREATE INDEX idx_empstore_employee_id ON employee_store(employee_id);
CREATE INDEX idx_empstore_is_active   ON employee_store(is_active);

-- -------------------------------------------------------------
-- INDEX: store
-- is_active filtered frequently to get only open stores
-- city and state looked up when searching stores by location
-- -------------------------------------------------------------
CREATE INDEX idx_store_is_active ON store(is_active);
CREATE INDEX idx_store_city      ON store(city);
CREATE INDEX idx_store_state     ON store(state);

-- -------------------------------------------------------------
-- INDEX: storemenu
-- Looked up by store to find all menus assigned to a location
-- Looked up by menu to find all stores carrying it
-- -------------------------------------------------------------
CREATE INDEX idx_storemenu_store_id ON storemenu(store_id);
CREATE INDEX idx_storemenu_menu_id  ON storemenu(menu_id);

-- -------------------------------------------------------------
-- INDEX: menuitem
-- Looked up by menu to find all items on a menu
-- Looked up by recipe to find which menu items use a recipe
-- -------------------------------------------------------------
CREATE INDEX idx_menuitem_menu_id   ON menuitem(menu_id);
CREATE INDEX idx_menuitem_recipe_id ON menuitem(recipe_id);

-- -------------------------------------------------------------
-- INDEX: recipeingredients
-- Looked up by recipe to find all ingredients needed
-- Looked up by product to find all recipes using a product
-- -------------------------------------------------------------
CREATE INDEX idx_recipeingr_recipe_id  ON recipeingredients(recipe_id);
CREATE INDEX idx_recipeingr_product_id ON recipeingredients(product_id);

-- -------------------------------------------------------------
-- INDEX: inventory
-- Looked up by store to check what a location currently has
-- Looked up by product to find which stores carry it
-- -------------------------------------------------------------
CREATE INDEX idx_inventory_store_id   ON inventory(store_id);
CREATE INDEX idx_inventory_product_id ON inventory(product_id);