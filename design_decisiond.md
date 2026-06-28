# Design Decisions & Assumptions

This document outlines the key design decisions, assumptions, and justifications made during the database design process for the MWC3 2026 franchise restaurant database. Since the problem statement was intentionally open-ended, most of these decisions were left to the designer.

---

## 1. Surrogate Keys Over Composite Keys

All tables use a surrogate primary key (e.g. `store_id`, `employee_id`) including bridge tables, rather than using composite keys made up of foreign keys.

**Justification:** Surrogate keys are simpler to reference in foreign key relationships, make joins cleaner, and are more resilient to data changes. If a composite key's components change, all referencing tables break. A surrogate key isolates that risk.

---

## 2. Separate Tables for Email and Phone

Instead of storing email addresses and phone numbers as columns directly on the `store` table, they are stored in separate `email` and `phone` tables with a one-to-many relationship to `store`.

**Justification:** A franchise location realistically has more than one phone number (main line, fax, delivery line) and more than one email address (general, support, management). Storing them inline would either limit the store to one of each or require multiple columns like `phone_1`, `phone_2` which violates 1NF. Separate tables handle unlimited entries cleanly.

---

## 3. Employee to Store is Many-to-Many

The relationship between `employee` and `store` is modeled as many-to-many via the `employee_store` bridge table rather than a simple one-to-many.

**Justification:** In a real franchise context, managers and supervisors often oversee or work across multiple locations. A one-to-many relationship would force an employee to belong to only one store, which is an oversimplification. The `employee_store` table captures the assignment with additional context like `role`, `start_date`, `end_date`, and `is_active` per assignment, not just per employee.

---

## 4. Store to Menu is Many-to-Many

Menus are not owned by a single store. Instead `storemenu` bridges `store` and `menu` in a many-to-many relationship.

**Justification:** In a franchise, the same menu (e.g. a standard lunch menu) is likely shared across multiple locations. Having menus exist independently and be assigned to stores avoids duplicating menu data per location and allows corporate to manage menus centrally and push them to stores.

---

## 5. Menu Item as Bridge Between Menu and Recipe

`menuitem` is modeled as a bridge table between `menu` and `recipe` and carries its own attributes (`item_name`, `price`, `description`).

**Justification:** A recipe (e.g. Classic Burger) can appear on multiple menus (lunch, dinner, weekend special) potentially at different price points or with different display names. Attaching price and description directly to the recipe would not support this. `menuitem` represents the specific appearance of a recipe on a menu, making it a proper associative entity not just a dumb bridge.

---

## 6. Products and Inventory are Separate

A `product` table exists independently from `inventory`. The `inventory` table bridges `store` and `product` and carries `quantity` and `last_updated`.

**Justification:** A product (e.g. Beef Patty) exists as a concept regardless of whether any store currently stocks it. Inventory is store-specific and quantity is an attribute of that store-product relationship, not of the product itself. This separation keeps product data clean and allows inventory to be tracked per location without duplicating product definitions.

---

## 7. Recipe Ingredients as Bridge Between Recipe and Product

`recipeingredients` bridges `recipe` and `product` in a many-to-many relationship and carries a `quantity` attribute.

**Justification:** A recipe uses many products, and a product can be used in many recipes. The `quantity` attribute on the bridge captures how much of each product is needed per recipe, which is critical for inventory management. This also means inventory can theoretically be auto-decremented when a recipe is prepared by referencing `recipeingredients.quantity`.

---

## 8. is_active Flag on Store, Employee, and Employee_Store

Rather than deleting records when a store closes or an employee leaves, an `is_active` flag is used alongside date columns.

**Justification:** Hard deleting records destroys historical data. A closed store still has historical orders, employee records, and inventory data that may be needed for reporting or auditing. `is_active` allows fast boolean filtering for current records while preserving history. This pattern is applied to:
- `store` — paired with `closing_date`
- `employee` — paired with `termination_date`
- `employee_store` — paired with `end_date` per assignment

---

## 9. opening_date and closing_date Instead of created_at for Business Dates

A dedicated `opening_date` and `closing_date` are used on `store` rather than relying on `created_at` to represent when a store opened.

**Justification:** `created_at` represents when the database record was inserted, which may not match when the store actually opened. A store could be added to the system weeks before or after its actual opening date. Separate business date columns make this distinction explicit and avoid data integrity issues.

---

## 10. created_at and updated_at Omitted

Standard audit timestamp columns (`created_at`, `updated_at`) were omitted from all tables in this project.

**Justification:** For a competition deliverable these columns are standard practice in production systems but add noise without adding meaningful design insight for this scope. The design already uses dedicated date columns where business dates matter (`opening_date`, `hire_date`, `start_date` etc.). In a production system `created_at` and `updated_at` would be added to every table for auditing and sync purposes.

---

## 11. DECIMAL for Price and Quantity

`DECIMAL(10,2)` is used for all `price` and `quantity` columns rather than `FLOAT` or `REAL`.

**Justification:** Floating point types are imprecise for monetary values and fractional quantities due to how they are stored in binary. `DECIMAL` is exact and avoids rounding errors, which matters for financial data and recipe measurements.

---

## 12. Inventory Auto-Decrement Not Implemented

The schema supports automatic inventory decrement when a recipe is used but does not implement it via triggers.

**Justification:** The chain `inventory → product → recipeingredients → recipe` provides everything needed to calculate how much inventory should be decremented when a recipe is prepared. However implementing this as a trigger or stored procedure was considered out of scope for this competition deliverable. In a production system this would be handled either by a database trigger on recipe usage or by application layer logic.

---

## 13. Indexes on Foreign Keys and Common Filter Columns

Indexes are created on all foreign key columns and additional columns that are frequently used in filters and lookups.

**Justification:** Foreign key columns are the most commonly joined columns in this schema. Without indexes, every join performs a full table scan. Additional indexes on `is_active`, `last_name`, `city`, and `state` support the most common query patterns such as finding active stores in a city or searching employees by name.