class Prescription < ActiveRecord::Base
	belongs_to :user
	belongs_to :doctor
	belongs_to :consultation
	belongs_to :patient_review
end
