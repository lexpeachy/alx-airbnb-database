# Database Seeding Script

This directory contains SQL scripts to populate the Airbnb-like database with sample data.

## Files

- `seed.sql`: Contains INSERT statements for all tables with realistic sample data
- `README.md`: This documentation file

## Sample Data Overview

### Users
- 1 admin user
- 2 host users (Sarah and Michael)
- 2 guest users (David and Emma)

### Properties
- Cozy Mountain Cabin (Sarah)
- Downtown Loft (Sarah)
- Beachfront Villa (Michael)

### Bookings
- David booked the cabin (confirmed)
- Emma booked the loft (confirmed)
- David requested the villa (pending)

### Payments
- Payments for confirmed bookings
- Different payment methods (credit_card, paypal)

### Reviews
- David reviewed the cabin (5 stars)
- Emma reviewed the loft (4 stars)

### Messages
- Conversation between David and Sarah about pet policy

## Usage

To seed the database:

1. Ensure the database schema has been created first
2. Run: `psql -U username -d dbname -f seed.sql`
3. Or execute in psql console: `\i seed.sql`

## Data Characteristics

- Realistic names, emails, and phone numbers
- Logical property descriptions and locations
- Plausible booking dates and durations
- Appropriate payment amounts based on property prices
- Authentic-looking reviews and messages
