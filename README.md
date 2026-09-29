🗺️ Navi – RouteMap Database Project

A Supabase PostgreSQL database project for a navigation and route-planning application called Navi – RouteMap.

The project demonstrates database design, sample data, CRUD operations, aggregate functions, and relationships between tables using SQL.

📌 Project Overview

Navi – RouteMap manages:

- 👤 Users
- 📍 Locations
- 🚗 Vehicles
- 🛣️ Routes
- 🕒 Route History

🗃️ Database Tables

Table| Description
"users"| Stores user information
"locations"| Stores location details
"vehicles"| Stores user vehicle information
"routes"| Stores route details
"route_history"| Stores users' route search history

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

⚙️ SQL Operations Covered

CRUD Operations

- "INSERT" – Create records
- "SELECT" – Read records
- "UPDATE" – Modify records
- "DELETE" – Remove records

Aggregate Functions

COUNT()
SUM()
AVG()
MIN()
MAX()

SQL Concepts

- Primary Keys
- Foreign Keys
- INNER JOIN
- LEFT JOIN
- WHERE
- ORDER BY
- GROUP BY
- BETWEEN
- IN
- Aggregate Functions

🚀 How to Run

1. Create a project in Supabase.
2. Open the SQL Editor.
3. Run the SQL files in the following order:

01_database_schema.sql
02_sample_data.sql
03_insert_queries.sql
04_select_queries.sql
05_update_queries.sql
06_delete_queries.sql
07_aggregate_queries.sql
08_relationship_queries.sql

4. Open Table Editor in Supabase.
5. Check the created tables and query results.

🎯 Project Objectives

- Understand relational database design.
- Create and manage tables using SQL.
- Implement Primary Key and Foreign Key relationships.
- Perform CRUD operations.
- Use aggregate functions for data analysis.
- Retrieve related data using JOIN queries.
- Gain practical experience with Supabase PostgreSQL.

🛠️ Technologies Used

- SQL
- PostgreSQL
- Supabase
- GitHub

👨‍💻 Author

M. Shiva Nandheswara Reddy

B.Tech Student – Sai University

📚 Academic Project

This project was created as part of a Database / SQL practical assignment to demonstrate database design and SQL operations using a real-world navigation application.

---

⭐ Navi – RouteMap | Database Management Project