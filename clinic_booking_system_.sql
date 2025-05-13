-- Clinic Booking System Database
-- This schema manages patients, doctors, appointments, medical records, and specializations

-- Table: Patients
-- Stores patient information
CREATE TABLE Patients (
    patient_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('M', 'F', 'Other') NOT NULL,
    address VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (patient_id),
    UNIQUE KEY email (email),
    UNIQUE KEY phone (phone)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table: Doctors
-- Stores doctor information
CREATE TABLE Doctors (
    doctor_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    license_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (doctor_id),
    UNIQUE KEY email (email),
    UNIQUE KEY phone (phone),
    UNIQUE KEY license_number (license_number)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table: Specializations
-- Stores medical specializations
CREATE TABLE Specializations (
    specialization_id INT NOT NULL AUTO_INCREMENT,
    specialization_name VARCHAR(100) NOT NULL,
    description TEXT,
    PRIMARY KEY (specialization_id),
    UNIQUE KEY specialization_name (specialization_name)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table: Doctor_Specializations (Junction table for M-M relationship)
-- Links doctors to their specializations
CREATE TABLE Doctor_Specializations (
    doctor_id INT NOT NULL,
    specialization_id INT NOT NULL,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table: Appointments
-- Stores appointment details
CREATE TABLE Appointments (
    appointment_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (appointment_id),
    UNIQUE KEY doctor_id (doctor_id, appointment_date),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE RESTRICT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Trigger: Ensure appointment_date is in the future (before insert)
DELIMITER //
CREATE TRIGGER before_appointment_insert
BEFORE INSERT ON Appointments
FOR EACH ROW
BEGIN
    IF NEW.appointment_date <= CURRENT_TIMESTAMP THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment date must be in the future';
    END IF;
END //
DELIMITER ;

-- Trigger: Ensure appointment_date is in the future (before update)
DELIMITER //
CREATE TRIGGER before_appointment_update
BEFORE UPDATE ON Appointments
FOR EACH ROW
BEGIN
    IF NEW.appointment_date <= CURRENT_TIMESTAMP THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment date must be in the future';
    END IF;
END //
DELIMITER ;

-- Table: Medical_Records
-- Stores patient medical history
CREATE TABLE Medical_Records (
    record_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT DEFAULT NULL,
    visit_date DATE NOT NULL,
    diagnosis TEXT NOT NULL,
    treatment TEXT,
    notes TEXT,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (record_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE RESTRICT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE RESTRICT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Sample Data Insertion
-- Insert 5 Patients
INSERT INTO Patients VALUES 
(1, 'John', 'Doe', 'john.doe@email.com', '1234567890', '1985-03-15', 'M', '123 Main St', '2025-05-13 10:35:46'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '0987654321', '1990-07-22', 'F', '456 Oak Ave', '2025-05-13 10:35:46'),
(3, 'Alex', 'Brown', 'alex.brown@email.com', '5551234567', '1978-11-30', 'M', '789 Pine Rd', '2025-05-13 10:35:46'),
(4, 'Emma', 'Wilson', 'emma.wilson@email.com', '4449876543', '1995-02-10', 'F', '321 Elm St', '2025-05-13 10:35:46'),
(5, 'Sam', 'Taylor', 'sam.taylor@email.com', '6665554443', '1982-09-05', 'Other', '654 Birch Ln', '2025-05-13 10:35:46');

-- Insert 5 Doctors
INSERT INTO Doctors VALUES 
(1, 'Michael', 'Lee', 'michael.lee@email.com', '7778889991', 'DOC12345', '2025-05-13 10:37:13'),
(2, 'Sarah', 'Davis', 'sarah.davis@email.com', '2223334445', 'DOC67890', '2025-05-13 10:37:13'),
(3, 'Robert', 'Clark', 'robert.clark@email.com', '1112223334', 'DOC11223', '2025-05-13 10:37:13'),
(4, 'Lisa', 'Adams', 'lisa.adams@email.com', '9998887776', 'DOC44556', '2025-05-13 10:37:13'),
(5, 'David', 'Moore', 'david.moore@email.com', '8887776665', 'DOC78901', '2025-05-13 10:37:13');

-- Insert 5 Specializations
INSERT INTO Specializations VALUES 
(1, 'Cardiology', 'Heart and cardiovascular system'),
(2, 'Neurology', 'Nervous system disorders'),
(3, 'Pediatrics', 'Medical care for children'),
(4, 'Orthopedics', 'Musculoskeletal system'),
(5, 'Dermatology', 'Skin-related conditions');

-- Insert 5 Doctor_Specializations
INSERT INTO Doctor_Specializations VALUES 
(1, 1), -- Michael Lee -> Cardiology
(2, 2), -- Sarah Davis -> Neurology
(3, 3), -- Robert Clark -> Pediatrics
(4, 4), -- Lisa Adams -> Orthopedics
(5, 5); -- David Moore -> Dermatology

-- Insert 5 Appointments
INSERT INTO Appointments VALUES 
(1, 1, 1, '2025-05-14 10:00:00', 'Scheduled', '2025-05-13 10:37:13'),
(2, 2, 2, '2025-05-14 11:00:00', 'Scheduled', '2025-05-13 10:37:13'),
(3, 3, 3, '2025-05-15 09:30:00', 'Scheduled', '2025-05-13 10:37:13'),
(4, 4, 4, '2025-05-15 14:00:00', 'Scheduled', '2025-05-13 10:37:13'),
(5, 5, 5, '2025-05-16 15:00:00', 'Scheduled', '2025-05-13 10:37:13');

-- Insert 5 Medical_Records
INSERT INTO Medical_Records VALUES 
(1, 1, 1, 1, '2025-05-14', 'Hypertension', 'Prescribed ACE inhibitors', 'Monitor blood pressure', '2025-05-13 10:37:13'),
(2, 2, 2, 2, '2025-05-14', 'Migraine', 'Prescribed triptans', 'Follow-up in 2 weeks', '2025-05-13 10:37:13'),
(3, 3, 3, 3, '2025-05-15', 'Flu', 'Rest and hydration', 'Symptoms should resolve in 7 days', '2025-05-13 10:37:13'),
(4, 4, 4, 4, '2025-05-15', 'Sprained ankle', 'RICE method, pain relievers', 'X-ray if no improvement', '2025-05-13 10:37:13'),
(5, 5, 5, 5, '2025-05-16', 'Eczema', 'Topical corticosteroids', 'Avoid irritants', '2025-05-13 10:37:13');