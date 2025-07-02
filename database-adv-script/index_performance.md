Users Table
user_id (primary key, joins)

email (WHERE clauses for authentication)

last_name (search/sorting)

Bookings Table
booking_id (primary key)

user_id (joins to users)

property_id (joins to properties)

booking_date (filtering and sorting)

status (filtering)

Properties Table
property_id (primary key, joins)

location (searching/filtering)

price_range (filtering)

property_type (filtering)

SQL CREATE INDEX commands to create appropriate indexes for those columns and save them on database_index.sql
-- Users table indexes
CREATE INDEX idx_users_user_id ON users(user_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_last_name ON users(last_name);

-- Bookings table indexes
CREATE INDEX idx_bookings_booking_id ON bookings(booking_id);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);
CREATE INDEX idx_bookings_status ON bookings(status);

-- Properties table indexes
CREATE INDEX idx_properties_property_id ON properties(property_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price_range ON properties(price_range);
CREATE INDEX idx_properties_property_type ON properties(property_type);

-- Composite indexes for common query patterns
CREATE INDEX idx_bookings_user_date ON bookings(user_id, booking_date);
CREATE INDEX idx_properties_location_type ON properties(location, property_type);
