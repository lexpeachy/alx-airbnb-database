a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT
    b.booking_id,
    b.booking_date,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone
FROM
    bookings b
INNER JOIN
    users u ON b.user_id = u.user_id
ORDER BY
    b.booking_date DESC;

A query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

SELECT
    p.property_id,
    p.property_name,
    p.property_type,
    r.review_id,
    r.rating,
    r.comment,
    r.review_date
FROM
    properties p
LEFT JOIN
    reviews r ON p.property_id = r.property_id
ORDER BY
    p.property_name, r.review_date DESC;

a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    b.status
FROM
    users u
FULL OUTER JOIN
    bookings b ON u.user_id = b.user_id
ORDER BY
    COALESCE(u.last_name, 'No User'), b.booking_date DESC;
