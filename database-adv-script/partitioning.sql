-- 1. Create the partitioned table structure
CREATE TABLE bookings_partitioned (
    booking_id BIGSERIAL,
    user_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_amount DECIMAL(12,2),
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- 2. Create partitions for different time periods
-- Historical data partitions
CREATE TABLE bookings_2022 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Current year partition with quarterly divisions
CREATE TABLE bookings_q1_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE bookings_q2_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE bookings_q3_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE bookings_q4_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- Future partition with automatic creation (if supported)
CREATE TABLE bookings_future PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO (MAXVALUE);

-- 3. Migrate data from original table
INSERT INTO bookings_partitioned
SELECT * FROM bookings;

-- 4. Create indexes on each partition
CREATE INDEX idx_partitioned_booking_date ON bookings_partitioned (start_date);
CREATE INDEX idx_partitioned_user_id ON bookings_partitioned (user_id);
CREATE INDEX idx_partitioned_property_id ON bookings_partitioned (property_id);

-- 5. Replace original table (after verifying data integrity)
BEGIN;
ALTER TABLE bookings RENAME TO bookings_old;
ALTER TABLE bookings_partitioned RENAME TO bookings;
COMMIT;