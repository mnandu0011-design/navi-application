CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(100),
    created_at DATE DEFAULT CURRENT_DATE
);

CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    location_name VARCHAR(150) NOT NULL,
    city VARCHAR(100) NOT NULL,
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7)
);

CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    vehicle_type VARCHAR(50),
    vehicle_number VARCHAR(20),
    fuel_type VARCHAR(30)
);

CREATE TABLE routes (
    route_id SERIAL PRIMARY KEY,
    start_location_id INT REFERENCES locations(location_id),
    destination_location_id INT REFERENCES locations(location_id),
    distance_km DECIMAL(8,2),
    estimated_time_minutes INT,
    route_type VARCHAR(30),
    toll_cost DECIMAL(8,2)
);

CREATE TABLE route_history (
    history_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    route_id INT REFERENCES routes(route_id) ON DELETE CASCADE,
    searched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    travel_status VARCHAR(30)
);
