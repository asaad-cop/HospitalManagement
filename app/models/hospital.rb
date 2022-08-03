class Hospital < ApplicationRecord
    has_many :hospital_treatments, dependent: :destroy
    has_many :treatments, through: :hospital_treatments
    has_many :users, dependent: :nullify

    validates :address, presence: true, uniqueness: true
    validates :name, presence: true, uniqueness: { scope: :city} 
end
