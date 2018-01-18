class PatientReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor
  belongs_to :consultation

  has_many :prescriptions
end
