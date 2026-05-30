# =========================
# CLEAN START (optional safety)
# =========================
MaintenanceRecord.destroy_all
Equipment.destroy_all
Category.destroy_all

# =========================
# CATEGORIES (4 required)
# =========================
computing = Category.create!(name: "Computing")
optics     = Category.create!(name: "Optics")
networking = Category.create!(name: "Networking")
electronics = Category.create!(name: "Electronics")

# =========================
# EQUIPMENT (8 required)
# =========================
e1 = Equipment.create!(
  name: "Dell Laptop",
  serial_number: "LAP-001",
  status: "available",
  category: computing
)

e2 = Equipment.create!(
  name: "HP Desktop",
  serial_number: "LAP-002",
  status: "in_use",
  category: computing
)

e3 = Equipment.create!(
  name: "Microscope X1",
  serial_number: "MIC-001",
  status: "maintenance",
  category: optics
)

e4 = Equipment.create!(
  name: "Telescope T1",
  serial_number: "OPT-002",
  status: "available",
  category: optics
)

e5 = Equipment.create!(
  name: "Router Cisco",
  serial_number: "NET-001",
  status: "in_use",
  category: networking
)

e6 = Equipment.create!(
  name: "Switch TP-Link",
  serial_number: "NET-002",
  status: "available",
  category: networking
)

e7 = Equipment.create!(
  name: "Oscilloscope",
  serial_number: "ELE-001",
  status: "maintenance",
  category: electronics
)

e8 = Equipment.create!(
  name: "Multimeter",
  serial_number: "ELE-002",
  status: "available",
  category: electronics
)

# =========================
# MAINTENANCE RECORDS (5 required)
# =========================
MaintenanceRecord.create!(
  description: "Installed updates and cleaned system",
  performed_at: 2.days.ago,
  equipment: e1
)

MaintenanceRecord.create!(
  description: "Replaced faulty hardware",
  performed_at: 5.days.ago,
  equipment: e3
)

MaintenanceRecord.create!(
  description: "Network configuration check",
  performed_at: 1.week.ago,
  equipment: e5
)

MaintenanceRecord.create!(
  description: "Calibration and testing",
  performed_at: 3.days.ago,
  equipment: e7
)

MaintenanceRecord.create!(
  description: "General inspection and cleaning",
  performed_at: 10.days.ago,
  equipment: e2
)

puts "Seeded successfully!"
