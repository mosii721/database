# Clinic Booking System Database

## Project Description
This project implements a MySQL database for a Clinic Booking System. The database manages patients, doctors, appointments, medical records, and doctor specializations. It includes proper relational structures with primary keys, foreign keys, unique constraints, and triggers to ensure data integrity.

### Features
- **Patients**: Stores patient details like name, email, phone, and date of birth.
- **Doctors**: Stores doctor details including license number.
- **Appointments**: Manages patient-doctor appointments with status and time constraints.
- **Medical Records**: Tracks patient visit history linked to appointments.
- **Specializations**: Handles doctor specializations with a many-to-many relationship.

## How to Run/Setup
1. **Prerequisites**: Install MySQL (e.g., MySQL Community Server 8.0 or later).
2. **Database Setup**:
   - Create a new database: `CREATE DATABASE clinic_booking;`
   - Select the database: `USE clinic_booking;`
   - Import the SQL file: `SOURCE clinic_booking_system.sql;`
3. **Verify**: Run `SHOW TABLES;` to confirm the tables are created.
4. **Test**: Query the tables (e.g., `SELECT * FROM Patients;`) to ensure functionality.

## Sample Data
The `clinic_booking_system.sql` file includes INSERT statements to populate each table with 5 sample rows for testing. The data includes realistic patients, doctors, appointments, and medical records, with future appointment dates.

## Entity Relationship Diagram (ERD)
![ERD](clinic_booking_erd.png)
- **Tables**: Patients, Doctors, Specializations, Doctor_Specializations, Appointments, Medical_Records.
- **Relationships**:
  - Patients ↔ Appointments (1-M)
  - Doctors ↔ Appointments (1-M)
  - Doctors ↔ Specializations (M-M via Doctor_Specializations)
  - Patients ↔ Medical_Records (1-M)
  - Doctors ↔ Medical_Records (1-M)
  - Appointments ↔ Medical_Records (1-1, nullable)

## Repository Structure
- `clinic_booking_system.sql`: SQL file with schema, triggers, and sample data.
- `clinic_booking_erd.png`: ERD image.
- `README.md`: This file with project details.