-- Initial inefficient query
-- Optimized query with WHERE clause and conditions
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_amount,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.property_name,
    p.location,
    pay.amount,
    pay.payment_method
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id
INNER JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.check_in_date BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE + INTERVAL '1 year'
    AND b.status = 'confirmed'
    AND p.property_type IN ('apartment', 'villa', 'cottage')
    AND (pay.payment_status IS NULL OR pay.payment_status = 'completed')
ORDER BY 
    b.check_in_date DESC
LIMIT 1000;



EXPLAIN ANALYZE
-- Initial inefficient query
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_amount,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone,
    p.property_id,
    p.property_name,
    p.location,
    p.property_type,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.check_in_date DESC;
