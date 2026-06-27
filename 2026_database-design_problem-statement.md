# MWC3 2026 — Database Design Problem Statement

> **Note:** This problem statement has been reconstructed from memory. The original document was not retained.

## Background

A regional franchise company operates multiple restaurant locations across different areas. The company needs a centralized database system to manage and track information across all its locations.

## Requirements

The database must support the following:

- **Franchise Locations** — each restaurant location has its own contact details including phone numbers and email addresses
- **Employees** — each location manages its own staff
- **Menus** — a restaurant location can have more than one menu (e.g. breakfast, lunch, dinner, seasonal)
- **Menu Items** — the individual dishes listed on a menu
- **Recipes** — each menu item has a recipe that defines which ingredients are needed and in what quantities
- **Inventory** — ingredients and stock tracked per location

## Constraints

- A restaurant location can have more than one menu
- A menu can have many menu items
- A menu item has a recipe composed of one or more ingredients
- Recipes connect menu items to inventory and ingredients with quantities

## Deliverables

- Entity-Relationship Diagram (ERD) in 3rd Normal Form (3NF)
- SQL script to create the database schema
- SQL script with sample INSERT and UPDATE statements
- Indexes on appropriate columns

## Design Note

The problem was intentionally open-ended. Most design decisions — entity attributes, normalization approach, indexing strategy — were left to the competitor.