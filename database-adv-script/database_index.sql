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


EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, COUNT(b.booking_id) as booking_count
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY u.user_id
ORDER BY booking_count DESC
LIMIT 10;
