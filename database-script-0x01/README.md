# Airbnb Database Schema

This directory contains the SQL schema definition for an Airbnb-like database.

## Files

- `schema.sql`: Contains all CREATE TABLE statements and indexes
- `README.md`: This documentation file

## Schema Overview

### Tables

1. **users** - Stores user accounts (guests, hosts, admins)
2. **properties** - Contains property listings by hosts
3. **bookings** - Tracks reservations made by guests
4. **payments** - Records payment transactions for bookings
5. **reviews** - Stores guest reviews of properties
6. **messages** - Handles messaging between users

### Key Features

- UUID primary keys for all tables
- Proper foreign key relationships with ON DELETE CASCADE
- Data validation constraints (CHECK constraints)
- Appropriate indexes for query optimization
- Timestamps for record creation/modification
- Normalized to 3NF (Third Normal Form)

## Usage

To create the database:

1. Ensure PostgreSQL is installed
2. Run: `psql -U username -d dbname -f schema.sql`
3. Or execute in psql console: `\i schema.sql`

## Index Strategy

Indexes were created on:
- All primary keys (automatic)
- Foreign key columns
- Frequently queried columns (email, dates)
- Columns used in JOIN operations
