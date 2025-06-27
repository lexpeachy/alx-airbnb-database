-- seed.sql
-- Sample data for Airbnb-like database

-- Clear existing data (optional, use with caution in production)
TRUNCATE TABLE messages, reviews, payments, bookings, properties, users RESTART IDENTITY CASCADE;

-- Insert sample users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admins
(uuid_generate_v4(), 'Admin', 'System', 'admin@airbnb.com', '$2a$10$xyz123', '+1234567890', 'admin', '2023-01-01 00:00:00'),

-- Hosts
(uuid_generate_v4(), 'Sarah', 'Johnson', 'sarah@example.com', '$2a$10$abc456', '+1555123456', 'host', '2023-01-15 10:30:00'),
(uuid_generate_v4(), 'Michael', 'Chen', 'michael@example.com', '$2a$10$def789', '+1555234567', 'host', '2023-02-01 14:15:00'),

-- Guests
(uuid_generate_v4(), 'David', 'Miller', 'david@example.com', '$2a$10$ghi012', '+1555345678', 'guest', '2023-02-10 09:45:00'),
(uuid_generate_v4(), 'Emma', 'Williams', 'emma@example.com', '$2a$10$jkl345', '+1555456789', 'guest', '2023-02-15 16:20:00');

-- Get user IDs for reference
WITH user_ids AS (
  SELECT 
    user_id,
    CASE 
      WHEN email = 'sarah@example.com' THEN 'sarah'
      WHEN email = 'michael@example.com' THEN 'michael'
      WHEN email = 'david@example.com' THEN 'david'
      WHEN email = 'emma@example.com' THEN 'emma'
    END AS user_ref
  FROM users
  WHERE role IN ('host', 'guest')
)

-- Insert properties
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night, created_at)
SELECT 
  uuid_generate_v4(),
  (SELECT user_id FROM user_ids WHERE user_ref = 'sarah'),
  'Cozy Mountain Cabin',
  'Beautiful 2-bedroom cabin with mountain views and hot tub',
  'Aspen, Colorado, USA',
  175.00,
  '2023-01-20 12:00:00'
FROM user_ids WHERE user_ref = 'sarah'

UNION ALL

SELECT 
  uuid_generate_v4(),
  (SELECT user_id FROM user_ids WHERE user_ref = 'sarah'),
  'Downtown Loft',
  'Modern loft in the heart of the city with rooftop access',
  'Denver, Colorado, USA',
  120.00,
  '2023-01-25 15:30:00'
FROM user_ids WHERE user_ref = 'sarah'

UNION ALL

SELECT 
  uuid_generate_v4(),
  (SELECT user_id FROM user_ids WHERE user_ref = 'michael'),
  'Beachfront Villa',
  'Luxury 3-bedroom villa with private beach access',
  'Miami, Florida, USA',
  300.00,
  '2023-02-05 11:00:00'
FROM user_ids WHERE user_ref = 'michael';

-- Get property IDs for reference
WITH property_ids AS (
  SELECT 
    p.property_id,
    CASE 
      WHEN p.name = 'Cozy Mountain Cabin' THEN 'cabin'
      WHEN p.name = 'Downtown Loft' THEN 'loft'
      WHEN p.name = 'Beachfront Villa' THEN 'villa'
    END AS property_ref
  FROM properties p
  JOIN users u ON p.host_id = u.user_id
)

-- Insert bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, status, created_at)
SELECT
  uuid_generate_v4(),
  (SELECT property_id FROM property_ids WHERE property_ref = 'cabin'),
  (SELECT user_id FROM user_ids WHERE user_ref = 'david'),
  '2023-03-15',
  '2023-03-20',
  'confirmed',
  '2023-02-28 09:15:00'
FROM property_ids WHERE property_ref = 'cabin'

UNION ALL

SELECT
  uuid_generate_v4(),
  (SELECT property_id FROM property_ids WHERE property_ref = 'loft'),
  (SELECT user_id FROM user_ids WHERE user_ref = 'emma'),
  '2023-04-01',
  '2023-04-05',
  'confirmed',
  '2023-03-10 14:30:00'
FROM property_ids WHERE property_ref = 'loft'

UNION ALL

SELECT
  uuid_generate_v4(),
  (SELECT property_id FROM property_ids WHERE property_ref = 'villa'),
  (SELECT user_id FROM user_ids WHERE user_ref = 'david'),
  '2023-05-10',
  '2023-05-17',
  'pending',
  '2023-04-01 10:45:00'
FROM property_ids WHERE property_ref = 'villa';

-- Get booking IDs for reference
WITH booking_ids AS (
  SELECT 
    b.booking_id,
    p.name AS property_name,
    u.email AS guest_email
  FROM bookings b
  JOIN properties p ON b.property_id = p.property_id
  JOIN users u ON b.user_id = u.user_id
)

-- Insert payments
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
SELECT
  uuid_generate_v4(),
  booking_id,
  CASE 
    WHEN property_name = 'Cozy Mountain Cabin' THEN 875.00
    WHEN property_name = 'Downtown Loft' THEN 480.00
    WHEN property_name = 'Beachfront Villa' THEN 2100.00
  END,
  created_at,
  CASE 
    WHEN guest_email = 'david@example.com' THEN 'credit_card'
    WHEN guest_email = 'emma@example.com' THEN 'paypal'
  END
FROM booking_ids
JOIN bookings b ON booking_ids.booking_id = b.booking_id
WHERE b.status = 'confirmed';

-- Insert reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
SELECT
  uuid_generate_v4(),
  (SELECT property_id FROM property_ids WHERE property_ref = 'cabin'),
  (SELECT user_id FROM user_ids WHERE user_ref = 'david'),
  5,
  'Amazing cabin with breathtaking views! The hot tub was perfect after a day of hiking.',
  '2023-03-22 18:00:00'
FROM property_ids WHERE property_ref = 'cabin'

UNION ALL

SELECT
  uuid_generate_v4(),
  (SELECT property_id FROM property_ids WHERE property_ref = 'loft'),
  (SELECT user_id FROM user_ids WHERE user_ref = 'emma'),
  4,
  'Great location and stylish space. The rooftop had amazing city views!',
  '2023-04-06 12:30:00'
FROM property_ids WHERE property_ref = 'loft';

-- Insert messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
SELECT
  uuid_generate_v4(),
  (SELECT user_id FROM user_ids WHERE user_ref = 'david'),
  (SELECT user_id FROM users WHERE email = 'sarah@example.com'),
  'Hi Sarah, is the cabin pet-friendly?',
  '2023-03-01 10:15:00'
FROM user_ids WHERE user_ref = 'david'

UNION ALL

SELECT
  uuid_generate_v4(),
  (SELECT user_id FROM users WHERE email = 'sarah@example.com'),
  (SELECT user_id FROM user_ids WHERE user_ref = 'david'),
  'Hi David! Yes, we allow pets with a small additional fee.',
  '2023-03-01 11:30:00'
FROM user_ids WHERE user_ref = 'david';
