class DoctorReview < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :user
  belongs_to :consultation
end
