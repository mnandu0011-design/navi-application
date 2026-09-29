```sql
-- ============================================
-- NAVI / ROUTEMAP DATABASE
-- FILE: 03_insert_queries.sql
-- PURPOSE: INSERT OPERATION
-- ============================================


-- ============================================
-- 1. INSERT A NEW USER
-- ============================================

INSERT INTO users
(full_name, email, phone, city)
VALUES
('Shiva Nandheswara', 'shiva.navi@gmail.com', '9876501234', 'Chennai');


-- ============================================
-- 2. INSERT ANOTHER USER
-- ============================================

INSERT INTO users
(full_name, email, phone, city)
VALUES
('Nandhu Reddy', 'nandhu.navi@gmail.com', '9876501235', 'Hyderabad');


-- ============================================
-- 3. INSERT A NEW LOCATION
-- ============================================

INSERT INTO locations
(location_name, city, latitude, longitude)
VALUES
('Chennai Airport', 'Chennai', 12.9941000, 80.1709000);


-- ============================================
-- 4. INSERT ANOTHER LOCATION
-- ============================================

INSERT INTO locations
(location_name, city, latitude, longitude)
VALUES
('Mahabalipuram', 'Chengalpattu', 12.6208000, 80.1945000);


-- ============================================
-- 5. INSERT A NEW VEHICLE
-- ============================================

INSERT INTO vehicles
(user_id, vehicle_type, vehicle_number, fuel_type)
VALUES
(31, 'Car', 'TN10AA1234', 'Petrol');


-- ============================================
-- 6. INSERT ANOTHER VEHICLE
-- ============================================

INSERT INTO vehicles
(user_id, vehicle_type, vehicle_number, fuel_type)
VALUES
(32, 'Bike', 'TS10BB5678', 'Electric');


-- ============================================
-- 7. INSERT A NEW ROUTE
-- ============================================

INSERT INTO routes
(
    start_location_id,
    destination_location_id,
    distance_km,
    estimated_time_minutes,
    route_type,
    toll_cost
)
VALUES
(
    1,
    31,
    25.50,
    50,
    'Fastest',
    75.00
);


-- ============================================
-- 8. INSERT ANOTHER ROUTE
-- ============================================

INSERT INTO routes
(
    start_location_id,
    destination_location_id,
    distance_km,
    estimated_time_minutes,
    route_type,
    toll_cost
)
VALUES
(
    31,
    32,
    55.80,
    90,
    'Balanced',
    120.00
);


-- ============================================
-- 9. INSERT ROUTE HISTORY
-- ============================================

INSERT INTO route_history
(
    user_id,
    route_id,
    searched_at,
    travel_status
)
VALUES
(
    31,
    31,
    CURRENT_TIMESTAMP,
    'Searched'
);


-- ============================================
-- 10. INSERT ANOTHER ROUTE HISTORY
-- ============================================

INSERT INTO route_history
(
    user_id,
    route_id,
    searched_at,
    travel_status
)
VALUES
(
    32,
    32,
    CURRENT_TIMESTAMP,
    'Completed'
);


-- ============================================
-- VERIFY INSERTED USERS
-- ============================================

SELECT *
FROM users
WHERE user_id >= 31;


-- ============================================
-- VERIFY INSERTED LOCATIONS
-- ============================================

SELECT *
FROM locations
WHERE location_id >= 31;


-- ============================================
-- VERIFY INSERTED VEHICLES
-- ============================================

SELECT *
FROM vehicles
WHERE vehicle_id >= 26;


-- ============================================
-- VERIFY INSERTED ROUTES
-- ============================================

SELECT *
FROM routes
WHERE route_id >= 31;


-- ============================================
-- VERIFY INSERTED ROUTE HISTORY
-- ============================================

SELECT *
FROM route_history
WHERE history_id >= 31;
```
