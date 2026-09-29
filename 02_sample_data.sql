INSERT INTO users (full_name, email, phone, city)
SELECT
    'User ' || gs,
    'user' || gs || '@gmail.com',
    '90000000' || LPAD(gs::TEXT, 2, '0'),
    CASE
        WHEN gs % 5 = 0 THEN 'Chennai'
        WHEN gs % 5 = 1 THEN 'Bengaluru'
        WHEN gs % 5 = 2 THEN 'Hyderabad'
        WHEN gs % 5 = 3 THEN 'Coimbatore'
        ELSE 'Madurai'
    END
FROM generate_series(1,30) AS gs;
INSERT INTO locations
(location_name, city, latitude, longitude)
VALUES
('Chennai Central','Chennai',13.0827,80.2707),
('T Nagar','Chennai',13.0418,80.2341),
('Anna Nagar','Chennai',13.0850,80.2101),
('Velachery','Chennai',12.9815,80.2180),
('Tambaram','Chennai',12.9249,80.1000),
('Bengaluru Central','Bengaluru',12.9716,77.5946),
('Whitefield','Bengaluru',12.9698,77.7500),
('Electronic City','Bengaluru',12.8452,77.6602),
('Indiranagar','Bengaluru',12.9784,77.6408),
('Yeshwanthpur','Bengaluru',13.0280,77.5540),
('Hyderabad Central','Hyderabad',17.3850,78.4867),
('Gachibowli','Hyderabad',17.4401,78.3489),
('Hitech City','Hyderabad',17.4435,78.3772),
('Secunderabad','Hyderabad',17.4399,78.4983),
('Charminar','Hyderabad',17.3616,78.4747),
('Coimbatore Central','Coimbatore',11.0168,76.9558),
('Gandhipuram','Coimbatore',11.0168,76.9674),
('RS Puram','Coimbatore',11.0066,76.9500),
('Singanallur','Coimbatore',10.9980,77.0320),
('Peelamedu','Coimbatore',11.0300,77.0280),
('Madurai Central','Madurai',9.9252,78.1198),
('Anna Nagar Madurai','Madurai',9.9400,78.1300),
('Mattuthavani','Madurai',9.9560,78.1740),
('Thiruppalai','Madurai',9.9630,78.1200),
('KK Nagar Madurai','Madurai',9.9290,78.1350),
('Airport Road','Chennai',12.9941,80.1709),
('OMR','Chennai',12.9121,80.2279),
('Marina Beach','Chennai',13.0500,80.2824),
('Guindy','Chennai',13.0067,80.2206),
('Adyar','Chennai',13.0064,80.2574);
