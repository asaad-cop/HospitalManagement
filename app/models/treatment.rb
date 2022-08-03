class Treatment < ApplicationRecord
    has_many :hospital_treatments, dependent: :destroy
    has_many :hospitals, through: :hospital_treatments
    has_many :users, dependent: :nullify

    validates :name, presence: true, uniqueness: true
end
