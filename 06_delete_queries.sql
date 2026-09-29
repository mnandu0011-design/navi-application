-- ============================================
-- NAVI / ROUTEMAP DATABASE
-- FILE: 06_delete_queries.sql
-- PURPOSE: DELETE OPERATIONS
-- ============================================


-- ============================================
-- 1. DELETE ONE ROUTE HISTORY RECORD
-- ============================================

DELETE FROM route_history
WHERE history_id = 30;


-- ============================================
-- 2. VERIFY ROUTE HISTORY DELETE
-- ============================================

SELECT *
FROM route_history
WHERE history_id = 30;


-- ============================================
-- 3. DELETE ONE VEHICLE
-- ============================================

DELETE FROM vehicles
WHERE vehicle_id = 25;


-- ============================================
-- 4. VERIFY VEHICLE DELETE
-- ============================================

SELECT *
FROM vehicles
WHERE vehicle_id = 25;


-- ============================================
-- 5. DELETE A ROUTE
-- ============================================
-- First delete related route history
-- because route_history references routes.

DELETE FROM route_history
WHERE route_id = 29;

DELETE FROM routes
WHERE route_id = 29;


-- ============================================
-- 6. VERIFY ROUTE DELETE
-- ============================================

SELECT *
FROM routes
WHERE route_id = 29;


-- ============================================
-- 7. DELETE A USER
-- ============================================
-- Vehicles and route_history belonging to the
-- user will be deleted automatically because
-- ON DELETE CASCADE was used in the schema.

DELETE FROM users
WHERE user_id = 30;


-- ============================================
-- 8. VERIFY USER DELETE
-- ============================================

SELECT *
FROM users
WHERE user_id = 30;


-- ============================================
-- 9. VERIFY RELATED VEHICLE RECORDS
-- ============================================

SELECT *
FROM vehicles
WHERE user_id = 30;


-- ============================================
-- 10. VERIFY RELATED ROUTE HISTORY
-- ============================================

SELECT *
FROM route_history
WHERE user_id = 30;


-- ============================================
-- 11. DELETE A LOCATION
-- ============================================
-- Location 30 may be referenced by a route.
-- First remove the route that uses it.

DELETE FROM route_history
WHERE route_id IN (
    SELECT route_id
    FROM routes
    WHERE start_location_id = 30
       OR destination_location_id = 30
);

DELETE FROM routes
WHERE start_location_id = 30
   OR destination_location_id = 30;

DELETE FROM locations
WHERE location_id = 30;


-- ============================================
-- 12. VERIFY LOCATION DELETE
-- ============================================

SELECT *
FROM locations
WHERE location_id = 30;


-- ============================================
-- 13. DELETE CANCELLED ROUTE HISTORY
-- ============================================

DELETE FROM route_history
WHERE travel_status = 'Cancelled';


-- ============================================
-- 14. VERIFY CANCELLED HISTORY DELETE
-- ============================================

SELECT *
FROM route_history
WHERE travel_status = 'Cancelled';


-- ============================================
-- 15. DELETE ELECTRIC SCOOTERS
-- ============================================
-- Delete vehicles matching both conditions.

DELETE FROM vehicles
WHERE vehicle_type = 'Scooter'
AND fuel_type = 'Electric';


-- ============================================
-- 16. VERIFY ELECTRIC SCOOTER DELETE
-- ============================================

SELECT *
FROM vehicles
WHERE vehicle_type = 'Scooter'
AND fuel_type = 'Electric';


-- ============================================
-- 17. DELETE ROUTES WITH ZERO TOLL
-- ============================================
-- First remove related route history.

DELETE FROM route_history
WHERE route_id IN (
    SELECT route_id
    FROM routes
    WHERE toll_cost = 0
);

DELETE FROM routes
WHERE toll_cost = 0;


-- ============================================
-- 18. VERIFY ZERO-TOLL ROUTE DELETE
-- ============================================

SELECT *
FROM routes
WHERE toll_cost = 0;


-- ============================================
-- 19. DELETE USERS FROM A SPECIFIC CITY
-- ============================================
-- Delete related records first.

DELETE FROM route_history
WHERE user_id IN (
    SELECT user_id
    FROM users
    WHERE city = 'Madurai'
);

DELETE FROM vehicles
WHERE user_id IN (
    SELECT user_id
    FROM users
    WHERE city = 'Madurai'
);

DELETE FROM users
WHERE city = 'Madurai';


-- ============================================
-- 20. VERIFY CITY USER DELETE
-- ============================================

SELECT *
FROM users
WHERE city = 'Madurai';


-- ============================================
-- 21. COUNT REMAINING USERS
-- ============================================

SELECT COUNT(*) AS remaining_users
FROM users;


-- ============================================
-- 22. COUNT REMAINING LOCATIONS
-- ============================================

SELECT COUNT(*) AS remaining_locations
FROM locations;


-- ============================================
-- 23. COUNT REMAINING VEHICLES
-- ============================================

SELECT COUNT(*) AS remaining_vehicles
FROM vehicles;


-- ============================================
-- 24. COUNT REMAINING ROUTES
-- ============================================

SELECT COUNT(*) AS remaining_routes
FROM routes;


-- ============================================
-- 25. COUNT REMAINING ROUTE HISTORY
-- ============================================

SELECT COUNT(*) AS remaining_route_history
FROM route_history;


-- ============================================
-- END OF DELETE QUERIES
-- ============================================