-- ============================================
-- NAVI / ROUTEMAP DATABASE
-- FILE: 07_aggregate_queries.sql
-- PURPOSE: AGGREGATE FUNCTIONS
-- ============================================


-- ============================================
-- 1. COUNT()
-- ============================================

-- Count total users
SELECT COUNT(*) AS total_users
FROM users;


-- Count total locations
SELECT COUNT(*) AS total_locations
FROM locations;


-- Count total vehicles
SELECT COUNT(*) AS total_vehicles
FROM vehicles;


-- Count total routes
SELECT COUNT(*) AS total_routes
FROM routes;


-- Count total route history records
SELECT COUNT(*) AS total_route_history
FROM route_history;


-- ============================================
-- 2. COUNT() WITH WHERE
-- ============================================

-- Count users from Chennai
SELECT COUNT(*) AS chennai_users
FROM users
WHERE city = 'Chennai';


-- Count users from Bengaluru
SELECT COUNT(*) AS bengaluru_users
FROM users
WHERE city = 'Bengaluru';


-- Count completed trips
SELECT COUNT(*) AS completed_trips
FROM route_history
WHERE travel_status = 'Completed';


-- Count cancelled trips
SELECT COUNT(*) AS cancelled_trips
FROM route_history
WHERE travel_status = 'Cancelled';


-- Count searched trips
SELECT COUNT(*) AS searched_trips
FROM route_history
WHERE travel_status = 'Searched';


-- ============================================
-- 3. COUNT() WITH GROUP BY
-- ============================================

-- Number of users in each city
SELECT
    city,
    COUNT(*) AS total_users
FROM users
GROUP BY city
ORDER BY total_users DESC;


-- Number of vehicles by type
SELECT
    vehicle_type,
    COUNT(*) AS total_vehicles
FROM vehicles
GROUP BY vehicle_type
ORDER BY total_vehicles DESC;


-- Number of vehicles by fuel type
SELECT
    fuel_type,
    COUNT(*) AS total_vehicles
FROM vehicles
GROUP BY fuel_type
ORDER BY total_vehicles DESC;


-- Number of routes by route type
SELECT
    route_type,
    COUNT(*) AS total_routes
FROM routes
GROUP BY route_type
ORDER BY total_routes DESC;


-- Number of trips by status
SELECT
    travel_status,
    COUNT(*) AS total_trips
FROM route_history
GROUP BY travel_status
ORDER BY total_trips DESC;


-- ============================================
-- 4. SUM()
-- ============================================

-- Total distance of all routes
SELECT
    SUM(distance_km) AS total_distance_km
FROM routes;


-- Total toll cost
SELECT
    SUM(toll_cost) AS total_toll_cost
FROM routes;


-- Total estimated travel time
SELECT
    SUM(estimated_time_minutes) AS total_travel_time_minutes
FROM routes;


-- ============================================
-- 5. SUM() WITH GROUP BY
-- ============================================

-- Total distance by route type
SELECT
    route_type,
    SUM(distance_km) AS total_distance_km
FROM routes
GROUP BY route_type;


-- Total toll cost by route type
SELECT
    route_type,
    SUM(toll_cost) AS total_toll_cost
FROM routes
GROUP BY route_type;


-- Total travel time by route type
SELECT
    route_type,
    SUM(estimated_time_minutes) AS total_travel_time
FROM routes
GROUP BY route_type;


-- ============================================
-- 6. AVG()
-- ============================================

-- Average route distance
SELECT
    AVG(distance_km) AS average_distance_km
FROM routes;


-- Average estimated travel time
SELECT
    AVG(estimated_time_minutes) AS average_travel_time_minutes
FROM routes;


-- Average toll cost
SELECT
    AVG(toll_cost) AS average_toll_cost
FROM routes;


-- ============================================
-- 7. AVG() WITH GROUP BY
-- ============================================

-- Average distance by route type
SELECT
    route_type,
    AVG(distance_km) AS average_distance_km
FROM routes
GROUP BY route_type;


-- Average travel time by route type
SELECT
    route_type,
    AVG(estimated_time_minutes) AS average_travel_time
FROM routes
GROUP BY route_type;


-- Average toll cost by route type
SELECT
    route_type,
    AVG(toll_cost) AS average_toll_cost
FROM routes
GROUP BY route_type;


-- ============================================
-- 8. MIN()
-- ============================================

-- Find shortest route
SELECT
    MIN(distance_km) AS shortest_distance_km
FROM routes;


-- Find minimum travel time
SELECT
    MIN(estimated_time_minutes) AS minimum_travel_time
FROM routes;


-- Find minimum toll cost
SELECT
    MIN(toll_cost) AS minimum_toll
FROM routes;


-- ============================================
-- 9. MIN() WITH ROUTE INFORMATION
-- ============================================

SELECT
    route_id,
    distance_km,
    estimated_time_minutes,
    route_type
FROM routes
WHERE distance_km = (
    SELECT MIN(distance_km)
    FROM routes
);


-- ============================================
-- 10. MAX()
-- ============================================

-- Find longest route
SELECT
    MAX(distance_km) AS longest_distance_km
FROM routes;


-- Find maximum travel time
SELECT
    MAX(estimated_time_minutes) AS maximum_travel_time
FROM routes;


-- Find maximum toll cost
SELECT
    MAX(toll_cost) AS maximum_toll
FROM routes;


-- ============================================
-- 11. MAX() WITH ROUTE INFORMATION
-- ============================================

SELECT
    route_id,
    distance_km,
    estimated_time_minutes,
    route_type
FROM routes
WHERE distance_km = (
    SELECT MAX(distance_km)
    FROM routes
);


-- ============================================
-- 12. MINIMUM TOLL ROUTE
-- ============================================

SELECT
    route_id,
    distance_km,
    toll_cost,
    route_type
FROM routes
WHERE toll_cost = (
    SELECT MIN(toll_cost)
    FROM routes
);


-- ============================================
-- 13. MAXIMUM TOLL ROUTE
-- ============================================

SELECT
    route_id,
    distance_km,
    toll_cost,
    route_type
FROM routes
WHERE toll_cost = (
    SELECT MAX(toll_cost)
    FROM routes
);


-- ============================================
-- 14. SHORTEST ROUTE WITH FULL DETAILS
-- ============================================

SELECT
    r.route_id,
    l1.location_name AS start_location,
    l2.location_name AS destination,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    r.toll_cost
FROM routes r
JOIN locations l1
ON r.start_location_id = l1.location_id
JOIN locations l2
ON r.destination_location_id = l2.location_id
WHERE r.distance_km = (
    SELECT MIN(distance_km)
    FROM routes
);


-- ============================================
-- 15. LONGEST ROUTE WITH FULL DETAILS
-- ============================================

SELECT
    r.route_id,
    l1.location_name AS start_location,
    l2.location_name AS destination,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    r.toll_cost
FROM routes r
JOIN locations l1
ON r.start_location_id = l1.location_id
JOIN locations l2
ON r.destination_location_id = l2.location_id
WHERE r.distance_km = (
    SELECT MAX(distance_km)
    FROM routes
);


-- ============================================
-- 16. COMPLETE ROUTE STATISTICS
-- ============================================

SELECT
    COUNT(*) AS total_routes,
    SUM(distance_km) AS total_distance_km,
    AVG(distance_km) AS average_distance_km,
    MIN(distance_km) AS shortest_route_km,
    MAX(distance_km) AS longest_route_km
FROM routes;


-- ============================================
-- 17. COMPLETE TRAVEL TIME STATISTICS
-- ============================================

SELECT
    COUNT(*) AS total_routes,
    SUM(estimated_time_minutes) AS total_time_minutes,
    AVG(estimated_time_minutes) AS average_time_minutes,
    MIN(estimated_time_minutes) AS minimum_time_minutes,
    MAX(estimated_time_minutes) AS maximum_time_minutes
FROM routes;


-- ============================================
-- 18. COMPLETE TOLL STATISTICS
-- ============================================

SELECT
    COUNT(*) AS total_routes,
    SUM(toll_cost) AS total_toll,
    AVG(toll_cost) AS average_toll,
    MIN(toll_cost) AS minimum_toll,
    MAX(toll_cost) AS maximum_toll
FROM routes;


-- ============================================
-- 19. ROUTE STATISTICS BY ROUTE TYPE
-- ============================================

SELECT
    route_type,
    COUNT(*) AS total_routes,
    SUM(distance_km) AS total_distance_km,
    AVG(distance_km) AS average_distance_km,
    MIN(distance_km) AS shortest_route_km,
    MAX(distance_km) AS longest_route_km
FROM routes
GROUP BY route_type
ORDER BY route_type;


-- ============================================
-- 20. ROUTE TIME STATISTICS BY ROUTE TYPE
-- ============================================

SELECT
    route_type,
    COUNT(*) AS total_routes,
    SUM(estimated_time_minutes) AS total_time_minutes,
    AVG(estimated_time_minutes) AS average_time_minutes,
    MIN(estimated_time_minutes) AS minimum_time_minutes,
    MAX(estimated_time_minutes) AS maximum_time_minutes
FROM routes
GROUP BY route_type
ORDER BY route_type;


-- ============================================
-- 21. TOLL STATISTICS BY ROUTE TYPE
-- ============================================

SELECT
    route_type,
    COUNT(*) AS total_routes,
    SUM(toll_cost) AS total_toll,
    AVG(toll_cost) AS average_toll,
    MIN(toll_cost) AS minimum_toll,
    MAX(toll_cost) AS maximum_toll
FROM routes
GROUP BY route_type
ORDER BY route_type;


-- ============================================
-- 22. USER COUNT BY CITY
-- ============================================

SELECT
    city,
    COUNT(*) AS number_of_users
FROM users
GROUP BY city
ORDER BY number_of_users DESC;


-- ============================================
-- 23. LOCATION COUNT BY CITY
-- ============================================

SELECT
    city,
    COUNT(*) AS number_of_locations
FROM locations
GROUP BY city
ORDER BY number_of_locations DESC;


-- ============================================
-- 24. VEHICLE COUNT BY TYPE
-- ============================================

SELECT
    vehicle_type,
    COUNT(*) AS number_of_vehicles
FROM vehicles
GROUP BY vehicle_type
ORDER BY number_of_vehicles DESC;


-- ============================================
-- 25. VEHICLE COUNT BY FUEL TYPE
-- ============================================

SELECT
    fuel_type,
    COUNT(*) AS number_of_vehicles
FROM vehicles
GROUP BY fuel_type
ORDER BY number_of_vehicles DESC;


-- ============================================
-- 26. TRIP STATUS STATISTICS
-- ============================================

SELECT
    travel_status,
    COUNT(*) AS total_trips
FROM route_history
GROUP BY travel_status
ORDER BY total_trips DESC;


-- ============================================
-- 27. COMPLETED TRIP COUNT
-- ============================================

SELECT
    COUNT(*) AS completed_trips
FROM route_history
WHERE travel_status = 'Completed';


-- ============================================
-- 28. CANCELLED TRIP COUNT
-- ============================================

SELECT
    COUNT(*) AS cancelled_trips
FROM route_history
WHERE travel_status = 'Cancelled';


-- ============================================
-- 29. SEARCHED TRIP COUNT
-- ============================================

SELECT
    COUNT(*) AS searched_trips
FROM route_history
WHERE travel_status = 'Searched';


-- ============================================
-- 30. ROUTES WITH ABOVE AVERAGE DISTANCE
-- ============================================

SELECT
    route_id,
    distance_km,
    estimated_time_minutes,
    route_type
FROM routes
WHERE distance_km > (
    SELECT AVG(distance_km)
    FROM routes
)
ORDER BY distance_km DESC;


-- ============================================
-- 31. ROUTES WITH BELOW AVERAGE DISTANCE
-- ============================================

SELECT
    route_id,
    distance_km,
    estimated_time_minutes,
    route_type
FROM routes
WHERE distance_km < (
    SELECT AVG(distance_km)
    FROM routes
)
ORDER BY distance_km ASC;


-- ============================================
-- 32. ROUTES WITH ABOVE AVERAGE TOLL
-- ============================================

SELECT
    route_id,
    distance_km,
    toll_cost,
    route_type
FROM routes
WHERE toll_cost > (
    SELECT AVG(toll_cost)
    FROM routes
)
ORDER BY toll_cost DESC;


-- ============================================
-- 33. ROUTES WITH BELOW AVERAGE TOLL
-- ============================================

SELECT
    route_id,
    distance_km,
    toll_cost,
    route_type
FROM routes
WHERE toll_cost < (
    SELECT AVG(toll_cost)
    FROM routes
)
ORDER BY toll_cost ASC;


-- ============================================
-- 34. ROUTE COUNT BY DISTANCE CATEGORY
-- ============================================

SELECT
    CASE
        WHEN distance_km < 10 THEN 'Short'
        WHEN distance_km BETWEEN 10 AND 25 THEN 'Medium'
        ELSE 'Long'
    END AS distance_category,
    COUNT(*) AS total_routes
FROM routes
GROUP BY
    CASE
        WHEN distance_km < 10 THEN 'Short'
        WHEN distance_km BETWEEN 10 AND 25 THEN 'Medium'
        ELSE 'Long'
    END;


-- ============================================
-- 35. ROUTE COUNT BY TRAVEL TIME CATEGORY
-- ============================================

SELECT
    CASE
        WHEN estimated_time_minutes <= 20 THEN 'Quick'
        WHEN estimated_time_minutes <= 45 THEN 'Moderate'
        ELSE 'Long'
    END AS time_category,
    COUNT(*) AS total_routes
FROM routes
GROUP BY
    CASE
        WHEN estimated_time_minutes <= 20 THEN 'Quick'
        WHEN estimated_time_minutes <= 45 THEN 'Moderate'
        ELSE 'Long'
    END;


-- ============================================
-- END OF AGGREGATE QUERIES
-- ============================================