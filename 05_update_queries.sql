-- ============================================
-- NAVI / ROUTEMAP DATABASE
-- FILE: 05_update_queries.sql
-- PURPOSE: UPDATE OPERATIONS
-- ============================================


-- ============================================
-- 1. UPDATE USER CITY
-- ============================================

UPDATE users
SET city = 'Chengalpattu'
WHERE user_id = 1;


-- ============================================
-- 2. UPDATE USER PHONE NUMBER
-- ============================================

UPDATE users
SET phone = '9000011111'
WHERE user_id = 2;


-- ============================================
-- 3. UPDATE USER EMAIL
-- ============================================

UPDATE users
SET email = 'updated.arjun@gmail.com'
WHERE user_id = 3;


-- ============================================
-- 4. UPDATE USER NAME
-- ============================================

UPDATE users
SET full_name = 'Arjun Kumar Updated'
WHERE user_id = 4;


-- ============================================
-- 5. UPDATE LOCATION CITY
-- ============================================

UPDATE locations
SET city = 'Chengalpattu'
WHERE location_id = 30;


-- ============================================
-- 6. UPDATE LOCATION NAME
-- ============================================

UPDATE locations
SET location_name = 'Chennai Airport Terminal'
WHERE location_id = 6;


-- ============================================
-- 7. UPDATE LOCATION COORDINATES
-- ============================================

UPDATE locations
SET
    latitude = 12.9950000,
    longitude = 80.1715000
WHERE location_id = 6;


-- ============================================
-- 8. UPDATE VEHICLE TYPE
-- ============================================

UPDATE vehicles
SET vehicle_type = 'SUV'
WHERE vehicle_id = 1;


-- ============================================
-- 9. UPDATE VEHICLE FUEL TYPE
-- ============================================

UPDATE vehicles
SET fuel_type = 'Electric'
WHERE vehicle_id = 2;


-- ============================================
-- 10. UPDATE VEHICLE NUMBER
-- ============================================

UPDATE vehicles
SET vehicle_number = 'TN01ZZ9999'
WHERE vehicle_id = 3;


-- ============================================
-- 11. UPDATE ROUTE DISTANCE
-- ============================================

UPDATE routes
SET distance_km = 30.50
WHERE route_id = 1;


-- ============================================
-- 12. UPDATE ESTIMATED TRAVEL TIME
-- ============================================

UPDATE routes
SET estimated_time_minutes = 60
WHERE route_id = 2;


-- ============================================
-- 13. UPDATE ROUTE TYPE
-- ============================================

UPDATE routes
SET route_type = 'Fastest'
WHERE route_id = 3;


-- ============================================
-- 14. UPDATE TOLL COST
-- ============================================

UPDATE routes
SET toll_cost = 100.00
WHERE route_id = 4;


-- ============================================
-- 15. UPDATE MULTIPLE ROUTE VALUES
-- ============================================

UPDATE routes
SET
    distance_km = 35.75,
    estimated_time_minutes = 70,
    toll_cost = 120.00
WHERE route_id = 5;


-- ============================================
-- 16. UPDATE ROUTES WITH ZERO TOLL
-- ============================================

UPDATE routes
SET toll_cost = 10.00
WHERE route_id = 8
AND toll_cost = 0;


-- ============================================
-- 17. UPDATE ROUTE HISTORY STATUS
-- ============================================

UPDATE route_history
SET travel_status = 'Completed'
WHERE history_id = 2;


-- ============================================
-- 18. UPDATE ROUTE HISTORY TO CANCELLED
-- ============================================

UPDATE route_history
SET travel_status = 'Cancelled'
WHERE history_id = 4;


-- ============================================
-- 19. UPDATE ROUTE HISTORY DATE
-- ============================================

UPDATE route_history
SET searched_at = CURRENT_TIMESTAMP
WHERE history_id = 5;


-- ============================================
-- 20. UPDATE MULTIPLE ROUTE HISTORY VALUES
-- ============================================

UPDATE route_history
SET
    travel_status = 'Completed',
    searched_at = CURRENT_TIMESTAMP
WHERE history_id = 6;


-- ============================================
-- 21. UPDATE ALL USERS FROM A CITY
-- ============================================

UPDATE users
SET city = 'Chennai'
WHERE city = 'Madurai';


-- ============================================
-- 22. UPDATE ELECTRIC VEHICLES
-- ============================================

UPDATE vehicles
SET fuel_type = 'Electric'
WHERE vehicle_type = 'Scooter'
AND fuel_type = 'Petrol';


-- ============================================
-- 23. UPDATE LONG ROUTES
-- ============================================

UPDATE routes
SET route_type = 'Fastest'
WHERE distance_km > 25;


-- ============================================
-- 24. UPDATE HIGH TOLL ROUTES
-- ============================================

UPDATE routes
SET route_type = 'Balanced'
WHERE toll_cost > 80;


-- ============================================
-- 25. UPDATE LONG TRAVEL ROUTES
-- ============================================

UPDATE routes
SET estimated_time_minutes =
    estimated_time_minutes + 10
WHERE distance_km > 20;


-- ============================================
-- 26. VERIFY USER UPDATES
-- ============================================

SELECT *
FROM users
WHERE user_id IN (1, 2, 3, 4);


-- ============================================
-- 27. VERIFY LOCATION UPDATES
-- ============================================

SELECT *
FROM locations
WHERE location_id IN (6, 30);


-- ============================================
-- 28. VERIFY VEHICLE UPDATES
-- ============================================

SELECT *
FROM vehicles
WHERE vehicle_id IN (1, 2, 3);


-- ============================================
-- 29. VERIFY ROUTE UPDATES
-- ============================================

SELECT *
FROM routes
WHERE route_id IN (1, 2, 3, 4, 5);


-- ============================================
-- 30. VERIFY ROUTE HISTORY UPDATES
-- ============================================

SELECT *
FROM route_history
WHERE history_id IN (2, 4, 5, 6);


-- ============================================
-- END OF UPDATE QUERIES
-- ============================================