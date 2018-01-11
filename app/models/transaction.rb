class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor
  belongs_to :insurance_provider
end
