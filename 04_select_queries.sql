```sql
-- ============================================
-- NAVI / ROUTEMAP DATABASE
-- FILE: 04_select_queries.sql
-- PURPOSE: SELECT OPERATIONS
-- ============================================


-- ============================================
-- 1. DISPLAY ALL USERS
-- ============================================

SELECT *
FROM users;


-- ============================================
-- 2. DISPLAY ALL LOCATIONS
-- ============================================

SELECT *
FROM locations;


-- ============================================
-- 3. DISPLAY ALL VEHICLES
-- ============================================

SELECT *
FROM vehicles;


-- ============================================
-- 4. DISPLAY ALL ROUTES
-- ============================================

SELECT *
FROM routes;


-- ============================================
-- 5. DISPLAY ALL ROUTE HISTORY
-- ============================================

SELECT *
FROM route_history;


-- ============================================
-- 6. SELECT SPECIFIC COLUMNS FROM USERS
-- ============================================

SELECT
    user_id,
    full_name,
    email,
    city
FROM users;


-- ============================================
-- 7. FIND USERS FROM CHENNAI
-- ============================================

SELECT *
FROM users
WHERE city = 'Chennai';


-- ============================================
-- 8. FIND USERS FROM BENGALURU
-- ============================================

SELECT *
FROM users
WHERE city = 'Bengaluru';


-- ============================================
-- 9. FIND USERS FROM HYDERABAD
-- ============================================

SELECT *
FROM users
WHERE city = 'Hyderabad';


-- ============================================
-- 10. FIND USERS WHOSE NAME STARTS WITH 'A'
-- ============================================

SELECT *
FROM users
WHERE full_name LIKE 'A%';


-- ============================================
-- 11. FIND USERS WHOSE NAME CONTAINS 'Kumar'
-- ============================================

SELECT *
FROM users
WHERE full_name LIKE '%Kumar%';


-- ============================================
-- 12. DISPLAY ROUTES GREATER THAN 20 KM
-- ============================================

SELECT *
FROM routes
WHERE distance_km > 20;


-- ============================================
-- 13. DISPLAY ROUTES LESS THAN 10 KM
-- ============================================

SELECT *
FROM routes
WHERE distance_km < 10;


-- ============================================
-- 14. DISPLAY ROUTES BETWEEN 10 AND 30 KM
-- ============================================

SELECT *
FROM routes
WHERE distance_km BETWEEN 10 AND 30;


-- ============================================
-- 15. DISPLAY FASTEST ROUTES
-- ============================================

SELECT *
FROM routes
WHERE route_type = 'Fastest';


-- ============================================
-- 16. DISPLAY SHORTEST ROUTES
-- ============================================

SELECT *
FROM routes
WHERE route_type = 'Shortest';


-- ============================================
-- 17. DISPLAY BALANCED ROUTES
-- ============================================

SELECT *
FROM routes
WHERE route_type = 'Balanced';


-- ============================================
-- 18. DISPLAY ROUTES WITH TOLL COST
-- ============================================

SELECT *
FROM routes
WHERE toll_cost > 0;


-- ============================================
-- 19. DISPLAY FREE ROUTES
-- ============================================

SELECT *
FROM routes
WHERE toll_cost = 0;


-- ============================================
-- 20. SORT ROUTES BY DISTANCE
-- ============================================

SELECT *
FROM routes
ORDER BY distance_km ASC;


-- ============================================
-- 21. SORT ROUTES BY DISTANCE DESCENDING
-- ============================================

SELECT *
FROM routes
ORDER BY distance_km DESC;


-- ============================================
-- 22. SORT USERS ALPHABETICALLY
-- ============================================

SELECT *
FROM users
ORDER BY full_name ASC;


-- ============================================
-- 23. SORT USERS BY CITY
-- ============================================

SELECT *
FROM users
ORDER BY city ASC;


-- ============================================
-- 24. DISPLAY TOP 5 SHORTEST ROUTES
-- ============================================

SELECT *
FROM routes
ORDER BY distance_km ASC
LIMIT 5;


-- ============================================
-- 25. DISPLAY TOP 5 LONGEST ROUTES
-- ============================================

SELECT *
FROM routes
ORDER BY distance_km DESC
LIMIT 5;


-- ============================================
-- 26. DISPLAY FAST ROUTES
-- ============================================

SELECT
    route_id,
    distance_km,
    estimated_time_minutes,
    route_type
FROM routes
WHERE estimated_time_minutes <= 30;


-- ============================================
-- 27. DISPLAY ROUTES WITH TOLL ABOVE 50
-- ============================================

SELECT *
FROM routes
WHERE toll_cost > 50;


-- ============================================
-- 28. DISPLAY PETROL VEHICLES
-- ============================================

SELECT *
FROM vehicles
WHERE fuel_type = 'Petrol';


-- ============================================
-- 29. DISPLAY ELECTRIC VEHICLES
-- ============================================

SELECT *
FROM vehicles
WHERE fuel_type = 'Electric';


-- ============================================
-- 30. DISPLAY CARS
-- ============================================

SELECT *
FROM vehicles
WHERE vehicle_type = 'Car';


-- ============================================
-- 31. DISPLAY BIKES
-- ============================================

SELECT *
FROM vehicles
WHERE vehicle_type = 'Bike';


-- ============================================
-- 32. DISPLAY COMPLETED TRIPS
-- ============================================

SELECT *
FROM route_history
WHERE travel_status = 'Completed';


-- ============================================
-- 33. DISPLAY CANCELLED TRIPS
-- ============================================

SELECT *
FROM route_history
WHERE travel_status = 'Cancelled';


-- ============================================
-- 34. DISPLAY SEARCHED ROUTES
-- ============================================

SELECT *
FROM route_history
WHERE travel_status = 'Searched';


-- ============================================
-- 35. DISPLAY USERS WITH THEIR VEHICLES
-- ============================================

SELECT
    u.user_id,
    u.full_name,
    u.city,
    v.vehicle_type,
    v.vehicle_number,
    v.fuel_type
FROM users u
JOIN vehicles v
ON u.user_id = v.user_id;


-- ============================================
-- 36. DISPLAY ROUTES WITH LOCATION NAMES
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
ON r.destination_location_id = l2.location_id;


-- ============================================
-- 37. DISPLAY ROUTE HISTORY WITH USER NAMES
-- ============================================

SELECT
    rh.history_id,
    u.full_name,
    rh.route_id,
    rh.searched_at,
    rh.travel_status
FROM route_history rh
JOIN users u
ON rh.user_id = u.user_id;


-- ============================================
-- 38. DISPLAY COMPLETE ROUTE HISTORY
-- ============================================

SELECT
    rh.history_id,
    u.full_name,
    l1.location_name AS start_location,
    l2.location_name AS destination,
    r.distance_km,
    r.estimated_time_minutes,
    r.route_type,
    r.toll_cost,
    rh.searched_at,
    rh.travel_status
FROM route_history rh
JOIN users u
ON rh.user_id = u.user_id
JOIN routes r
ON rh.route_id = r.route_id
JOIN locations l1
ON r.start_location_id = l1.location_id
JOIN locations l2
ON r.destination_location_id = l2.location_id;


-- ============================================
-- 39. FIND USERS FROM CHENNAI OR BENGALURU
-- ============================================

SELECT *
FROM users
WHERE city IN ('Chennai', 'Bengaluru');


-- ============================================
-- 40. FIND ROUTES BETWEEN 5 AND 25 KM
-- ============================================

SELECT
    route_id,
    distance_km,
    estimated_time_minutes,
    route_type
FROM routes
WHERE distance_km BETWEEN 5 AND 25;


-- ============================================
-- 41. DISPLAY USERS WITH EMAIL
-- ============================================

SELECT
    full_name,
    email
FROM users
WHERE email IS NOT NULL;


-- ============================================
-- 42. DISPLAY LOCATIONS IN CHENNAI
-- ============================================

SELECT
    location_id,
    location_name,
    city,
    latitude,
    longitude
FROM locations
WHERE city = 'Chennai';


-- ============================================
-- 43. DISPLAY ROUTES TAKING MORE THAN 40 MINUTES
-- ============================================

SELECT
    route_id,
    distance_km,
    estimated_time_minutes,
    route_type
FROM routes
WHERE estimated_time_minutes > 40;


-- ============================================
-- 44. DISPLAY ROUTES TAKING 30 MINUTES OR LESS
-- ============================================

SELECT
    route_id,
    distance_km,
    estimated_time_minutes,
    route_type
FROM routes
WHERE estimated_time_minutes <= 30;


-- ============================================
-- 45. DISPLAY LATEST ROUTE HISTORY
-- ============================================

SELECT *
FROM route_history
ORDER BY searched_at DESC;


-- ============================================
-- END OF SELECT QUERIES
-- ============================================
```
