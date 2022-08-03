class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :requests
  belongs_to :hospital, optional: true
  belongs_to :treatment, optional: true
  
  enum user_type: { doctor: 0, patient: 1, admin: 2}
  
  scope :onboard, -> { where.not(hospital_id: nil, treatment_id: nil) }
end
