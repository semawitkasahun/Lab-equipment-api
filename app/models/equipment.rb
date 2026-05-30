class Equipment < ApplicationRecord
  belongs_to :category
  has_many :maintenance_records, dependent: :destroy

  STATUSES = %w[available in_use maintenance].freeze

  validates :name, presence: true
  validates :serial_number, presence: true, uniqueness: true
  validates :status,
            presence: true,
            inclusion: { in: STATUSES }

  validate :valid_serial_number
  validate :valid_equipment_name

  private

  def valid_serial_number
    return if serial_number.blank?

    unless serial_number.match?(/\A[A-Z]{3}-\d{3}\z/)
      errors.add(:serial_number, "must follow format XXX-NNN")
    end
  end

  def valid_equipment_name
    return if name.blank?

    if name.length < 3
      errors.add(:name, "must be at least 3 characters")
    end

    unless name.match?(/[A-Za-z]/)
      errors.add(:name, "must contain at least one letter")
    end
  end
end