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
