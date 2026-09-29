```sql
-- ============================================
-- NAVI / ROUTEMAP DATABASE
-- FILE: 02_sample_data.sql
-- SAMPLE DATA: 145+ RECORDS
-- ============================================


-- ============================================
-- 1. USERS TABLE
-- 30 RECORDS
-- ============================================

INSERT INTO users
(full_name, email, phone, city)
VALUES
('Arjun Kumar', 'arjun.kumar@gmail.com', '9876543210', 'Chennai'),
('Priya Sharma', 'priya.sharma@gmail.com', '9876543211', 'Bengaluru'),
('Rahul Reddy', 'rahul.reddy@gmail.com', '9876543212', 'Hyderabad'),
('Sneha Rao', 'sneha.rao@gmail.com', '9876543213', 'Coimbatore'),
('Karthik Raj', 'karthik.raj@gmail.com', '9876543214', 'Madurai'),
('Ananya Singh', 'ananya.singh@gmail.com', '9876543215', 'Chennai'),
('Vijay Kumar', 'vijay.kumar@gmail.com', '9876543216', 'Bengaluru'),
('Divya Nair', 'divya.nair@gmail.com', '9876543217', 'Hyderabad'),
('Rohit Verma', 'rohit.verma@gmail.com', '9876543218', 'Coimbatore'),
('Pooja Reddy', 'pooja.reddy@gmail.com', '9876543219', 'Madurai'),
('Sanjay Kumar', 'sanjay.kumar@gmail.com', '9876543220', 'Chennai'),
('Keerthi Rao', 'keerthi.rao@gmail.com', '9876543221', 'Bengaluru'),
('Aditya Sharma', 'aditya.sharma@gmail.com', '9876543222', 'Hyderabad'),
('Lakshmi Devi', 'lakshmi.devi@gmail.com', '9876543223', 'Coimbatore'),
('Manoj Kumar', 'manoj.kumar@gmail.com', '9876543224', 'Madurai'),
('Harsha Vardhan', 'harsha.vardhan@gmail.com', '9876543225', 'Chennai'),
('Nikhil Reddy', 'nikhil.reddy@gmail.com', '9876543226', 'Bengaluru'),
('Swathi Priya', 'swathi.priya@gmail.com', '9876543227', 'Hyderabad'),
('Varun Teja', 'varun.teja@gmail.com', '9876543228', 'Coimbatore'),
('Meghana Rao', 'meghana.rao@gmail.com', '9876543229', 'Madurai'),
('Sai Krishna', 'sai.krishna@gmail.com', '9876543230', 'Chennai'),
('Deepika Sharma', 'deepika.sharma@gmail.com', '9876543231', 'Bengaluru'),
('Rakesh Reddy', 'rakesh.reddy@gmail.com', '9876543232', 'Hyderabad'),
('Naveen Kumar', 'naveen.kumar@gmail.com', '9876543233', 'Coimbatore'),
('Aishwarya Singh', 'aishwarya.singh@gmail.com', '9876543234', 'Madurai'),
('Mohan Raj', 'mohan.raj@gmail.com', '9876543235', 'Chennai'),
('Sowmya Reddy', 'sowmya.reddy@gmail.com', '9876543236', 'Bengaluru'),
('Tarun Kumar', 'tarun.kumar@gmail.com', '9876543237', 'Hyderabad'),
('Bhavya Nair', 'bhavya.nair@gmail.com', '9876543238', 'Coimbatore'),
('Vamsi Krishna', 'vamsi.krishna@gmail.com', '9876543239', 'Madurai');


-- ============================================
-- 2. LOCATIONS TABLE
-- 30 RECORDS
-- ============================================

INSERT INTO locations
(location_name, city, latitude, longitude)
VALUES
('Chennai Central', 'Chennai', 13.0827000, 80.2707000),
('T Nagar', 'Chennai', 13.0418000, 80.2341000),
('Anna Nagar', 'Chennai', 13.0850000, 80.2101000),
('Velachery', 'Chennai', 12.9815000, 80.2180000),
('Tambaram', 'Chennai', 12.9249000, 80.1000000),
('Chennai Airport', 'Chennai', 12.9941000, 80.1709000),
('OMR', 'Chennai', 12.9121000, 80.2279000),
('Marina Beach', 'Chennai', 13.0500000, 80.2824000),
('Guindy', 'Chennai', 13.0067000, 80.2206000),
('Adyar', 'Chennai', 13.0064000, 80.2574000),

('Bengaluru Central', 'Bengaluru', 12.9716000, 77.5946000),
('Whitefield', 'Bengaluru', 12.9698000, 77.7500000),
('Electronic City', 'Bengaluru', 12.8452000, 77.6602000),
('Indiranagar', 'Bengaluru', 12.9784000, 77.6408000),
('Yeshwanthpur', 'Bengaluru', 13.0280000, 77.5540000),

('Hyderabad Central', 'Hyderabad', 17.3850000, 78.4867000),
('Gachibowli', 'Hyderabad', 17.4401000, 78.3489000),
('Hitech City', 'Hyderabad', 17.4435000, 78.3772000),
('Secunderabad', 'Hyderabad', 17.4399000, 78.4983000),
('Charminar', 'Hyderabad', 17.3616000, 78.4747000),

('Coimbatore Central', 'Coimbatore', 11.0168000, 76.9558000),
('Gandhipuram', 'Coimbatore', 11.0168000, 76.9674000),
('RS Puram', 'Coimbatore', 11.0066000, 76.9500000),
('Singanallur', 'Coimbatore', 10.9980000, 77.0320000),
('Peelamedu', 'Coimbatore', 11.0300000, 77.0280000),

('Madurai Central', 'Madurai', 9.9252000, 78.1198000),
('Anna Nagar Madurai', 'Madurai', 9.9400000, 78.1300000),
('Mattuthavani', 'Madurai', 9.9560000, 78.1740000),
('KK Nagar Madurai', 'Madurai', 9.9290000, 78.1350000);


-- ============================================
-- 3. VEHICLES TABLE
-- 25 RECORDS
-- ============================================

INSERT INTO vehicles
(user_id, vehicle_type, vehicle_number, fuel_type)
VALUES
(1, 'Car', 'TN01AB1001', 'Petrol'),
(2, 'Bike', 'KA01CD1002', 'Petrol'),
(3, 'Car', 'TS01EF1003', 'Diesel'),
(4, 'Scooter', 'TN38GH1004', 'Petrol'),
(5, 'Bike', 'TN58IJ1005', 'Electric'),
(6, 'Car', 'TN02KL1006', 'Petrol'),
(7, 'Bike', 'KA02MN1007', 'Electric'),
(8, 'Car', 'TS02OP1008', 'Petrol'),
(9, 'Scooter', 'TN39QR1009', 'Petrol'),
(10, 'Car', 'TN59ST1010', 'Diesel'),
(11, 'Bike', 'TN03UV1011', 'Petrol'),
(12, 'Car', 'KA03WX1012', 'Electric'),
(13, 'Bike', 'TS03YZ1013', 'Petrol'),
(14, 'Scooter', 'TN40AB1014', 'Electric'),
(15, 'Car', 'TN60CD1015', 'Petrol'),
(16, 'Bike', 'TN04EF1016', 'Petrol'),
(17, 'Car', 'KA04GH1017', 'Diesel'),
(18, 'Scooter', 'TS04IJ1018', 'Electric'),
(19, 'Bike', 'TN41KL1019', 'Petrol'),
(20, 'Car', 'TN61MN1020', 'Petrol'),
(21, 'Bike', 'TN05OP1021', 'Electric'),
(22, 'Car', 'KA05QR1022', 'Petrol'),
(23, 'Scooter', 'TS05ST1023', 'Petrol'),
(24, 'Bike', 'TN42UV1024', 'Electric'),
(25, 'Car', 'TN62WX1025', 'Diesel');


-- ============================================
-- 4. ROUTES TABLE
-- 30 RECORDS
-- ============================================

INSERT INTO routes
(start_location_id, destination_location_id,
 distance_km, estimated_time_minutes,
 route_type, toll_cost)
VALUES
(1, 2, 5.80, 20, 'Shortest', 0.00),
(1, 3, 7.20, 25, 'Fastest', 0.00),
(1, 4, 12.50, 35, 'Balanced', 20.00),
(1, 5, 28.50, 55, 'Fastest', 80.00),
(2, 6, 8.40, 25, 'Shortest', 0.00),
(2, 7, 22.30, 50, 'Fastest', 60.00),
(3, 8, 9.70, 30, 'Balanced', 0.00),
(4, 9, 6.20, 18, 'Shortest', 0.00),
(5, 10, 14.80, 35, 'Fastest', 30.00),
(6, 1, 10.50, 28, 'Balanced', 0.00),

(11, 12, 18.50, 40, 'Fastest', 45.00),
(11, 13, 21.70, 48, 'Balanced', 55.00),
(11, 14, 6.80, 20, 'Shortest', 0.00),
(11, 15, 9.50, 25, 'Fastest', 0.00),
(12, 13, 25.30, 55, 'Fastest', 70.00),

(16, 17, 8.20, 22, 'Shortest', 0.00),
(16, 18, 14.60, 35, 'Balanced', 20.00),
(16, 19, 7.50, 20, 'Fastest', 0.00),
(16, 20, 11.30, 30, 'Shortest', 0.00),
(17, 18, 10.40, 28, 'Fastest', 15.00),

(21, 22, 2.80, 10, 'Shortest', 0.00),
(21, 23, 6.50, 18, 'Fastest', 0.00),
(21, 24, 8.70, 22, 'Balanced', 10.00),
(21, 25, 5.40, 15, 'Shortest', 0.00),
(22, 23, 4.20, 12, 'Fastest', 0.00),

(26, 27, 3.50, 12, 'Shortest', 0.00),
(26, 28, 7.80, 20, 'Fastest', 0.00),
(26, 29, 4.60, 15, 'Balanced', 0.00),
(27, 28, 6.30, 18, 'Fastest', 0.00),
(28, 29, 5.90, 17, 'Shortest', 0.00);


-- ============================================
-- 5. ROUTE HISTORY TABLE
-- 30 RECORDS
-- ============================================

INSERT INTO route_history
(user_id, route_id, searched_at, travel_status)
VALUES
(1, 1, '2026-09-01 08:15:00', 'Completed'),
(2, 2, '2026-09-01 09:20:00', 'Searched'),
(3, 3, '2026-09-02 10:30:00', 'Completed'),
(4, 4, '2026-09-02 11:45:00', 'Cancelled'),
(5, 5, '2026-09-03 07:50:00', 'Completed'),
(6, 6, '2026-09-03 09:10:00', 'Searched'),
(7, 7, '2026-09-04 10:00:00', 'Completed'),
(8, 8, '2026-09-04 12:15:00', 'Completed'),
(9, 9, '2026-09-05 08:45:00', 'Cancelled'),
(10, 10, '2026-09-05 18:30:00', 'Completed'),
(11, 11, '2026-09-06 09:00:00', 'Searched'),
(12, 12, '2026-09-06 10:20:00', 'Completed'),
(13, 13, '2026-09-07 11:30:00', 'Completed'),
(14, 14, '2026-09-07 13:15:00', 'Cancelled'),
(15, 15, '2026-09-08 14:00:00', 'Completed'),
(16, 16, '2026-09-08 08:30:00', 'Searched'),
(17, 17, '2026-09-09 09:45:00', 'Completed'),
(18, 18, '2026-09-09 12:00:00', 'Completed'),
(19, 19, '2026-09-10 17:30:00', 'Cancelled'),
(20, 20, '2026-09-10 18:15:00', 'Completed'),
(21, 21, '2026-09-11 07:30:00', 'Completed'),
(22, 22, '2026-09-11 08:45:00', 'Searched'),
(23, 23, '2026-09-12 10:15:00', 'Completed'),
(24, 24, '2026-09-12 11:30:00', 'Completed'),
(25, 25, '2026-09-13 12:45:00', 'Cancelled'),
(26, 26, '2026-09-14 09:20:00', 'Completed'),
(27, 27, '2026-09-14 10:40:00', 'Searched'),
(28, 28, '2026-09-15 13:10:00', 'Completed'),
(29, 29, '2026-09-15 17:00:00', 'Completed'),
(30, 30, '2026-09-16 18:20:00', 'Cancelled');


-- ============================================
-- END OF SAMPLE DATA
-- ============================================

-- CHECK RECORD COUNTS
SELECT 'Users' AS table_name, COUNT(*) AS total_records
FROM users

UNION ALL

SELECT 'Locations', COUNT(*)
FROM locations

UNION ALL

SELECT 'Vehicles', COUNT(*)
FROM vehicles

UNION ALL

SELECT 'Routes', COUNT(*)
FROM routes

UNION ALL

SELECT 'Route History', COUNT(*)
FROM route_history;
```
