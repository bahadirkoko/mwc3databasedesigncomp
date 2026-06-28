-- =============================================================
-- Franchise Restaurant Database
-- MWC3 2026 - Database Design Competition
-- Microsoft SQL Server (T-SQL)
-- =============================================================

-- -------------------------------------------------------------
-- TABLE: store
-- -------------------------------------------------------------
CREATE TABLE store (
    store_id       INT              NOT NULL IDENTITY(1,1),
    store_name     VARCHAR(100)     NOT NULL,
    address        VARCHAR(255)     NOT NULL,
    city           VARCHAR(100)     NOT NULL,
    state          CHAR(2)          NOT NULL,
    zip            VARCHAR(10)      NOT NULL,
    opening_date   DATE             NOT NULL,
    closing_date   DATE                 NULL,
    is_active      BIT              NOT NULL DEFAULT 1,
    CONSTRAINT pk_store PRIMARY KEY (store_id)
);

-- -------------------------------------------------------------
-- TABLE: email
-- -------------------------------------------------------------
CREATE TABLE email (
    email_id       INT              NOT NULL IDENTITY(1,1),
    store_id       INT              NOT NULL,
    email_address  VARCHAR(255)     NOT NULL,
    CONSTRAINT pk_email PRIMARY KEY (email_id),
    CONSTRAINT fk_email_store FOREIGN KEY (store_id) REFERENCES store(store_id)
);

-- -------------------------------------------------------------
-- TABLE: phone
-- -------------------------------------------------------------
CREATE TABLE phone (
    phone_id       INT              NOT NULL IDENTITY(1,1),
    store_id       INT              NOT NULL,
    phone_number   VARCHAR(20)      NOT NULL,
    phone_type     VARCHAR(50)      NOT NULL,
    CONSTRAINT pk_phone PRIMARY KEY (phone_id),
    CONSTRAINT fk_phone_store FOREIGN KEY (store_id) REFERENCES store(store_id)
);

-- -------------------------------------------------------------
-- TABLE: employee
-- -------------------------------------------------------------
CREATE TABLE employee (
    employee_id        INT              NOT NULL IDENTITY(1,1),
    first_name         VARCHAR(100)     NOT NULL,
    last_name          VARCHAR(100)     NOT NULL,
    email              VARCHAR(255)     NOT NULL,
    hire_date          DATE             NOT NULL,
    termination_date   DATE                 NULL,
    is_active          BIT              NOT NULL DEFAULT 1,
    CONSTRAINT pk_employee PRIMARY KEY (employee_id)
);

-- -------------------------------------------------------------
-- TABLE: employee_store
-- -------------------------------------------------------------
CREATE TABLE employee_store (
    employee_store_id  INT              NOT NULL IDENTITY(1,1),
    employee_id        INT              NOT NULL,
    store_id           INT              NOT NULL,
    role               VARCHAR(100)     NOT NULL,
    start_date         DATE             NOT NULL,
    end_date           DATE                 NULL,
    is_active          BIT              NOT NULL DEFAULT 1,
    CONSTRAINT pk_employee_store PRIMARY KEY (employee_store_id),
    CONSTRAINT fk_empstore_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    CONSTRAINT fk_empstore_store    FOREIGN KEY (store_id)    REFERENCES store(store_id)
);

-- -------------------------------------------------------------
-- TABLE: menu
-- -------------------------------------------------------------
CREATE TABLE menu (
    menu_id     INT              NOT NULL IDENTITY(1,1),
    menu_name   VARCHAR(100)     NOT NULL,
    menu_type   VARCHAR(50)      NOT NULL,
    CONSTRAINT pk_menu PRIMARY KEY (menu_id)
);

-- -------------------------------------------------------------
-- TABLE: storemenu
-- -------------------------------------------------------------
CREATE TABLE storemenu (
    storemenu_id  INT             NOT NULL IDENTITY(1,1),
    store_id      INT             NOT NULL,
    menu_id       INT             NOT NULL,
    CONSTRAINT pk_storemenu PRIMARY KEY (storemenu_id),
    CONSTRAINT fk_storemenu_store FOREIGN KEY (store_id) REFERENCES store(store_id),
    CONSTRAINT fk_storemenu_menu  FOREIGN KEY (menu_id)  REFERENCES menu(menu_id)
);

-- -------------------------------------------------------------
-- TABLE: recipe
-- -------------------------------------------------------------
CREATE TABLE recipe (
    recipe_id      INT              NOT NULL IDENTITY(1,1),
    recipe_name    VARCHAR(100)     NOT NULL,
    instructions   NVARCHAR(MAX)        NULL,
    CONSTRAINT pk_recipe PRIMARY KEY (recipe_id)
);

-- -------------------------------------------------------------
-- TABLE: menuitem
-- -------------------------------------------------------------
CREATE TABLE menuitem (
    menuitem_id   INT              NOT NULL IDENTITY(1,1),
    menu_id       INT              NOT NULL,
    recipe_id     INT              NOT NULL,
    item_name     VARCHAR(100)     NOT NULL,
    price         DECIMAL(10,2)    NOT NULL,
    description   VARCHAR(255)         NULL,
    CONSTRAINT pk_menuitem PRIMARY KEY (menuitem_id),
    CONSTRAINT fk_menuitem_menu   FOREIGN KEY (menu_id)   REFERENCES menu(menu_id),
    CONSTRAINT fk_menuitem_recipe FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id)
);

-- -------------------------------------------------------------
-- TABLE: product
-- -------------------------------------------------------------
CREATE TABLE product (
    product_id     INT              NOT NULL IDENTITY(1,1),
    product_name   VARCHAR(100)     NOT NULL,
    unit           VARCHAR(50)      NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (product_id)
);

-- -------------------------------------------------------------
-- TABLE: recipeingredients
-- -------------------------------------------------------------
CREATE TABLE recipeingredients (
    recipeingredient_id  INT              NOT NULL IDENTITY(1,1),
    recipe_id            INT              NOT NULL,
    product_id           INT              NOT NULL,
    quantity             DECIMAL(10,2)    NOT NULL,
    CONSTRAINT pk_recipeingredients PRIMARY KEY (recipeingredient_id),
    CONSTRAINT fk_recipeingr_recipe  FOREIGN KEY (recipe_id)  REFERENCES recipe(recipe_id),
    CONSTRAINT fk_recipeingr_product FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- -------------------------------------------------------------
-- TABLE: inventory
-- -------------------------------------------------------------
CREATE TABLE inventory (
    inventory_id   INT              NOT NULL IDENTITY(1,1),
    store_id       INT              NOT NULL,
    product_id     INT              NOT NULL,
    quantity       DECIMAL(10,2)    NOT NULL,
    last_updated   DATETIME2        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_inventory PRIMARY KEY (inventory_id),
    CONSTRAINT fk_inventory_store   FOREIGN KEY (store_id)   REFERENCES store(store_id),
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES product(product_id)
);