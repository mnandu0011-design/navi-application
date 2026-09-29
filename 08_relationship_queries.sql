-- ============================================================
-- NAVI - ROUTEMAP DATABASE PROJECT
-- 08_RELATIONSHIP_QUERIES.SQL
-- ============================================================
-- Purpose:
-- To demonstrate relationships between tables using
-- PRIMARY KEY, FOREIGN KEY and JOIN operations.
-- ============================================================


-- ============================================================
-- 1. USERS AND VEHICLES
-- Relationship:
-- users.user_id = vehicles.user_id
-- ============================================================

SELECT
    users.user_id,
    users.full_name,
    users.email,
    vehicles.vehicle_id,
    vehicles.vehicle_type,
    vehicles.vehicle_number,
    vehicles.fuel_type
FROM users
INNER JOIN vehicles
ON users.user_id = vehicles.user_id;


-- ============================================================
-- 2. USERS WITH THEIR VEHICLE DETAILS
-- ============================================================

SELECT
    u.full_name,
    u.city,
    v.vehicle_type,
    v.vehicle_number,
    v.fuel_type
FROM users u
JOIN vehicles v
ON u.user_id = v.user_id
ORDER BY u.full_name;


-- ============================================================
-- 3. USERS AND ROUTE HISTORY
-- Relationship:
-- users.user_id = route_history.user_id
-- ============================================================

SELECT
    u.user_id,
    u.full_name,
    u.email,
    rh.history_id,
    rh.route_id,
    rh.travel_status,
    rh.searched_at
FROM users u
JOIN route_history rh
ON u.user_id = rh.user_id
ORDER BY u.user_id;


-- ============================================================
-- 4. ROUTES AND ROUTE HISTORY
-- Relationship:
-- routes.route_id = route_history.route_id
-- ============================================================

SELECT
    r.route_id,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    r.toll_cost,
    rh.history_id,
    rh.user_id,
    rh.travel_status
FROM routes r
JOIN route_history rh
ON r.route_id = rh.route_id
ORDER BY r.route_id;


-- ============================================================
-- 5. ROUTES WITH START LOCATION
-- Relationship:
-- routes.start_location_id = locations.location_id
-- ============================================================

SELECT
    r.route_id,
    l.location_name AS start_location,
    l.city,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    r.toll_cost
FROM routes r
JOIN locations l
ON r.start_location_id = l.location_id
ORDER BY r.route_id;


-- ============================================================
-- 6. ROUTES WITH DESTINATION LOCATION
-- Relationship:
-- routes.destination_location_id = locations.location_id
-- ============================================================

SELECT
    r.route_id,
    l.location_name AS destination_location,
    l.city,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    r.toll_cost
FROM routes r
JOIN locations l
ON r.destination_location_id = l.location_id
ORDER BY r.route_id;


-- ============================================================
-- 7. COMPLETE ROUTE INFORMATION
-- START LOCATION + DESTINATION LOCATION
-- ============================================================

SELECT
    r.route_id,
    start_loc.location_name AS start_location,
    start_loc.city AS start_city,
    dest_loc.location_name AS destination_location,
    dest_loc.city AS destination_city,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    r.toll_cost
FROM routes r
JOIN locations start_loc
ON r.start_location_id = start_loc.location_id
JOIN locations dest_loc
ON r.destination_location_id = dest_loc.location_id
ORDER BY r.route_id;


-- ============================================================
-- 8. USERS WITH ROUTES THEY SEARCHED
-- ============================================================

SELECT
    u.user_id,
    u.full_name,
    r.route_id,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    rh.travel_status
FROM users u
JOIN route_history rh
ON u.user_id = rh.user_id
JOIN routes r
ON rh.route_id = r.route_id
ORDER BY u.user_id;


-- ============================================================
-- 9. USERS + ROUTE + START + DESTINATION
-- ============================================================

SELECT
    u.full_name,
    start_loc.location_name AS start_location,
    dest_loc.location_name AS destination,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    r.toll_cost,
    rh.travel_status
FROM users u
JOIN route_history rh
ON u.user_id = rh.user_id
JOIN routes r
ON rh.route_id = r.route_id
JOIN locations start_loc
ON r.start_location_id = start_loc.location_id
JOIN locations dest_loc
ON r.destination_location_id = dest_loc.location_id
ORDER BY u.full_name;


-- ============================================================
-- 10. USERS WITH VEHICLES AND ROUTE HISTORY
-- ============================================================

SELECT
    u.full_name,
    u.city,
    v.vehicle_type,
    v.vehicle_number,
    r.route_id,
    r.distance_km,
    rh.travel_status
FROM users u
JOIN vehicles v
ON u.user_id = v.user_id
JOIN route_history rh
ON u.user_id = rh.user_id
JOIN routes r
ON rh.route_id = r.route_id
ORDER BY u.full_name;


-- ============================================================
-- 11. ROUTE DETAILS WITH BOTH LOCATION CITIES
-- ============================================================

SELECT
    r.route_id,
    start_loc.city AS start_city,
    dest_loc.city AS destination_city,
    r.distance_km,
    r.route_type,
    r.toll_cost
FROM routes r
JOIN locations start_loc
ON r.start_location_id = start_loc.location_id
JOIN locations dest_loc
ON r.destination_location_id = dest_loc.location_id;


-- ============================================================
-- 12. USERS WHO SEARCHED ROUTES WITH TOLL
-- ============================================================

SELECT
    u.full_name,
    r.route_id,
    r.toll_cost,
    r.distance_km,
    rh.travel_status
FROM users u
JOIN route_history rh
ON u.user_id = rh.user_id
JOIN routes r
ON rh.route_id = r.route_id
WHERE r.toll_cost > 0
ORDER BY r.toll_cost DESC;


-- ============================================================
-- 13. USERS WHO USED ELECTRIC VEHICLES
-- ============================================================

SELECT
    u.full_name,
    u.city,
    v.vehicle_type,
    v.vehicle_number,
    v.fuel_type
FROM users u
JOIN vehicles v
ON u.user_id = v.user_id
WHERE v.fuel_type = 'Electric'
ORDER BY u.full_name;


-- ============================================================
-- 14. USERS AND COMPLETED ROUTES
-- ============================================================

SELECT
    u.full_name,
    r.route_id,
    r.distance_km,
    r.route_type,
    rh.travel_status
FROM users u
JOIN route_history rh
ON u.user_id = rh.user_id
JOIN routes r
ON rh.route_id = r.route_id
WHERE rh.travel_status = 'Completed'
ORDER BY u.full_name;


-- ============================================================
-- 15. USERS AND CANCELLED ROUTES
-- ============================================================

SELECT
    u.full_name,
    u.email,
    r.route_id,
    r.distance_km,
    r.route_type,
    rh.travel_status
FROM users u
JOIN route_history rh
ON u.user_id = rh.user_id
JOIN routes r
ON rh.route_id = r.route_id
WHERE rh.travel_status = 'Cancelled';


-- ============================================================
-- 16. ROUTES BETWEEN DIFFERENT CITIES
-- ============================================================

SELECT
    r.route_id,
    start_loc.location_name AS start_location,
    start_loc.city AS start_city,
    dest_loc.location_name AS destination_location,
    dest_loc.city AS destination_city,
    r.distance_km,
    r.route_type
FROM routes r
JOIN locations start_loc
ON r.start_location_id = start_loc.location_id
JOIN locations dest_loc
ON r.destination_location_id = dest_loc.location_id
WHERE start_loc.city <> dest_loc.city
ORDER BY r.distance_km DESC;


-- ============================================================
-- 17. USERS AND THEIR ROUTE SEARCH COUNT
-- ============================================================

SELECT
    u.user_id,
    u.full_name,
    COUNT(rh.history_id) AS total_route_searches
FROM users u
LEFT JOIN route_history rh
ON u.user_id = rh.user_id
GROUP BY u.user_id, u.full_name
ORDER BY total_route_searches DESC;


-- ============================================================
-- 18. NUMBER OF VEHICLES OWNED BY EACH USER
-- ============================================================

SELECT
    u.user_id,
    u.full_name,
    COUNT(v.vehicle_id) AS total_vehicles
FROM users u
LEFT JOIN vehicles v
ON u.user_id = v.user_id
GROUP BY u.user_id, u.full_name
ORDER BY total_vehicles DESC;


-- ============================================================
-- 19. ROUTE SEARCHES BY TRAVEL STATUS
-- ============================================================

SELECT
    rh.travel_status,
    COUNT(rh.history_id) AS total_searches
FROM route_history rh
GROUP BY rh.travel_status
ORDER BY total_searches DESC;


-- ============================================================
-- 20. USERS WITH NO VEHICLES
-- ============================================================

SELECT
    u.user_id,
    u.full_name,
    u.email,
    u.city
FROM users u
LEFT JOIN vehicles v
ON u.user_id = v.user_id
WHERE v.vehicle_id IS NULL;


-- ============================================================
-- 21. USERS WITH NO ROUTE HISTORY
-- ============================================================

SELECT
    u.user_id,
    u.full_name,
    u.email,
    u.city
FROM users u
LEFT JOIN route_history rh
ON u.user_id = rh.user_id
WHERE rh.history_id IS NULL;


-- ============================================================
-- 22. MOST SEARCHED ROUTES
-- ============================================================

SELECT
    r.route_id,
    start_loc.location_name AS start_location,
    dest_loc.location_name AS destination,
    COUNT(rh.history_id) AS search_count
FROM routes r
JOIN locations start_loc
ON r.start_location_id = start_loc.location_id
JOIN locations dest_loc
ON r.destination_location_id = dest_loc.location_id
LEFT JOIN route_history rh
ON r.route_id = rh.route_id
GROUP BY
    r.route_id,
    start_loc.location_name,
    dest_loc.location_name
ORDER BY search_count DESC;


-- ============================================================
-- 23. USER ROUTE HISTORY WITH FULL LOCATION DETAILS
-- ============================================================

SELECT
    u.full_name,
    start_loc.location_name AS start_location,
    start_loc.city AS start_city,
    dest_loc.location_name AS destination,
    dest_loc.city AS destination_city,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    rh.travel_status,
    rh.searched_at
FROM users u
JOIN route_history rh
ON u.user_id = rh.user_id
JOIN routes r
ON rh.route_id = r.route_id
JOIN locations start_loc
ON r.start_location_id = start_loc.location_id
JOIN locations dest_loc
ON r.destination_location_id = dest_loc.location_id
ORDER BY rh.searched_at DESC;


-- ============================================================
-- 24. VEHICLE USERS AND THEIR SEARCHED ROUTES
-- ============================================================

SELECT
    u.full_name,
    v.vehicle_type,
    v.fuel_type,
    r.route_id,
    r.distance_km,
    r.route_type
FROM users u
JOIN vehicles v
ON u.user_id = v.user_id
JOIN route_history rh
ON u.user_id = rh.user_id
JOIN routes r
ON rh.route_id = r.route_id
ORDER BY u.full_name;


-- ============================================================
-- 25. COMPLETE NAVI DATABASE RELATIONSHIP QUERY
-- USERS + VEHICLES + HISTORY + ROUTES + LOCATIONS
-- ============================================================

SELECT
    u.user_id,
    u.full_name,
    u.city AS user_city,
    v.vehicle_type,
    v.vehicle_number,
    v.fuel_type,
    rh.history_id,
    rh.travel_status,
    rh.searched_at,
    r.route_id,
    start_loc.location_name AS start_location,
    start_loc.city AS start_city,
    dest_loc.location_name AS destination,
    dest_loc.city AS destination_city,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    r.toll_cost
FROM users u
LEFT JOIN vehicles v
ON u.user_id = v.user_id
LEFT JOIN route_history rh
ON u.user_id = rh.user_id
LEFT JOIN routes r
ON rh.route_id = r.route_id
LEFT JOIN locations start_loc
ON r.start_location_id = start_loc.location_id
LEFT JOIN locations dest_loc
ON r.destination_location_id = dest_loc.location_id
ORDER BY u.user_id;


-- ============================================================
-- END OF 08_RELATIONSHIP_QUERIES.SQL
-- ============================================================

How to explain in viva: "users → vehicles", "users → route_history", "route_history → routes", and "routes → locations" are connected using foreign keys. The JOIN queries combine related information from these tables.