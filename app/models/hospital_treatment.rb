class HospitalTreatment < ApplicationRecord
  belongs_to :hospital
  belongs_to :treatment

  validates :price, presence: true, numericality: { greater_than: 0 }
end
