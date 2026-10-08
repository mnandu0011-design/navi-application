# 🗺️ Navi – RouteMap Database Project

A Supabase PostgreSQL database project for a navigation and route-planning application called Navi – RouteMap.

This project demonstrates database design, sample data, CRUD operations, aggregate functions, and relationships between tables using SQL.

---

📌 Project Overview

Navi – RouteMap manages:

- 👤 Users
- 📍 Locations
- 🚗 Vehicles
- 🛣️ Routes
- 🕒 Route History

---

🗃️ Database Tables

Table| Description
"users"| Stores user information
"locations"| Stores location details
"vehicles"| Stores user vehicle information
"routes"| Stores route details
"route_history"| Stores users' route search history

---

🔗 Database Relationships

Users
  │
  ├── Vehicles
  │
  └── Route History
          │
          └── Routes
                │
                └── Locations

Main Relationships

users.user_id → vehicles.user_id

users.user_id → route_history.user_id

routes.route_id → route_history.route_id

locations.location_id → routes.start_location_id

locations.location_id → routes.destination_location_id

---

📂 Project Files

routemap/
│
├── 01_database_schema.sql
├── 02_sample_data.sql
├── 03_insert_queries.sql
├── 04_select_queries.sql
├── 05_update_queries.sql
├── 06_delete_queries.sql
├── 07_aggregate_queries.sql
├── 08_relationship_queries.sql
└── README.md

---

⚙️ SQL Operations Covered

CRUD Operations

Operation| SQL Command| Purpose
Create| "INSERT"| Create new records
Read| "SELECT"| Retrieve records
Update| "UPDATE"| Modify records
Delete| "DELETE"| Remove records

---

📊 Aggregate Functions

The project uses:

COUNT()
SUM()
AVG()
MIN()
MAX()

---

📚 SQL Concepts Used

- Primary Keys
- Foreign Keys
- "INNER JOIN"
- "LEFT JOIN"
- "WHERE"
- "ORDER BY"
- "GROUP BY"
- "BETWEEN"
- "IN"
- Aggregate Functions
- CRUD Operations
- Relational Database Design

---

🚀 How to Run

Step 1 – Create Supabase Project

Create a PostgreSQL database project in Supabase.

Step 2 – Open SQL Editor

Open the SQL Editor in your Supabase project.

Step 3 – Run SQL Files

Run the files in this order:

01_database_schema.sql
        ↓
02_sample_data.sql
        ↓
03_insert_queries.sql
        ↓
04_select_queries.sql
        ↓
05_update_queries.sql
        ↓
06_delete_queries.sql
        ↓
07_aggregate_queries.sql
        ↓
08_relationship_queries.sql

Step 4 – Check Tables

Open the Table Editor in Supabase and verify the tables and records.

Step 5 – Execute Queries

Run the queries from each SQL file in the Supabase SQL Editor and check the results.

---

🎯 Project Objectives

- Understand relational database design.
- Create and manage tables using SQL.
- Implement Primary Key and Foreign Key relationships.
- Perform CRUD operations.
- Use aggregate functions for data analysis.
- Retrieve related data using JOIN queries.
- Understand relationships between multiple tables.
- Gain practical experience with Supabase PostgreSQL.

---

🛠️ Technologies Used

Technology| Purpose
SQL| Database queries and operations
PostgreSQL| Relational database
Supabase| Database platform
GitHub| Project and SQL file management

---

👨‍💻 Author

M. Shiva Nandheswara Reddy

B.Tech Student – Sai University

---

📚 Academic Project

This project was created as part of a Database / SQL practical assignment to demonstrate database design, CRUD operations, aggregate functions, SQL JOINs, and relationships between tables using Supabase PostgreSQL.

---

⭐ Project

🗺️ Navi – RouteMap

Database Management Project using Supabase PostgreSQL