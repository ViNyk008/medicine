#create Patients
patient1 = Patient.create(name: "vivek1", email: "vivek@gmail.com", country_code: "IN", age: 25, phone_number: "1234567890", status: "active")
patient2 = Patient.create(name: "vivek2", email: "vivekVN@gmail.com", country_code: "VN", age: 25, phone_number: "2345678904", status: "active")

# Create doctors
doctor1 = Doctor.create(name: "Dr. NAYAK1", specialization: "Cardiologist", email: "nayak1@gmail.com", phone_number: "3456789013",status: "active")
doctor2 = Doctor.create(name: "Dr. NAYAK2", specialization: "Dermatologist", email: "nayak2@example.com", phone_number: "4567890123",status: "active")

# Create medications
medication1 = Medication.create(name: "Medicine A", description: "Description for Medicine A", serial_id: 1, status: 'active')
medication2 = Medication.create(name: "Medicine B", description: "Description for Medicine B",serial_id: 2, status: 'active')
medication3 = Medication.create(name: "Medicine C", description: "Description for Medicine c",serial_id: 3, status: 'active')


