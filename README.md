Clinic Booking System Database
Project Description
This project implements a MySQL database for a Clinic Booking System, designed to manage patients, doctors, appointments, medical records, and doctor specializations. The database uses proper relational structures, including primary keys, foreign keys, unique constraints, and triggers to ensure data integrity and enforce business rules.
Features

Patients: Stores patient details such as name, email, phone, date of birth, gender, and address.
Doctors: Stores doctor details, including name, email, phone, and unique license number.
Appointments: Manages patient-doctor appointments with status (Scheduled, Completed, Cancelled) and future date enforcement via triggers.
Medical Records: Tracks patient visit history, linked to patients, doctors, and appointments.
Specializations: Handles medical specializations with a many-to-many relationship to doctors via a junction table.

How to Run/Setup

Prerequisites: Install MySQL (e.g., MySQL Community Server 8.0 or later) and MySQL Workbench.
Database Setup:
Create a new database:CREATE DATABASE clinic_booking;


Select the database:USE clinic_booking;


Import the SQL file:SOURCE clinic_booking_system_.sql;




Verify:
Confirm tables are created:SHOW TABLES;


Check triggers:SHOW TRIGGERS;




Test:
Query sample data (e.g., SELECT * FROM Patients;) to verify functionality.
Test triggers by attempting to insert a past appointment:INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES (1, 1, '2025-05-12 10:00:00', 'Scheduled');





Sample Data
The clinic_booking_system_.sql file includes INSERT statements to populate each table with 5 sample rows. The data includes realistic patients, doctors, specializations, appointments (with future dates), medical records, and doctor-specialization mappings, ensuring all relationships are testable.
Entity Relationship Diagram (ERD)

If the ERD image does not display, view it at: dbdiagram.io link (replace with actual link if using dbdiagram.io).

Tables: Patients, Doctors, Specializations, Doctor_Specializations, Appointments, Medical_Records.
Relationships:
Patients ↔ Appointments (1-M): One patient can have many appointments.
Doctors ↔ Appointments (1-M): One doctor can have many appointments.
Doctors ↔ Specializations (M-M via Doctor_Specializations): Doctors can have multiple specializations, and specializations can apply to multiple doctors.
Patients ↔ Medical_Records (1-M): One patient can have many medical records.
Doctors ↔ Medical_Records (1-M): One doctor can create many medical records.
Appointments ↔ Medical_Records (1-1, nullable): A medical record may be linked to one appointment.



Repository Structure

clinic_booking_system_.sql: SQL file containing schema, triggers, and sample data.
clinic_booking_erd.png: Entity Relationship Diagram image.
README.md: This file with project details and instructions.

