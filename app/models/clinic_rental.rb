class ClinicRental < ActiveRecord::Base
  belongs_to :doctor
  # belongs_to :transaction

  has_one :clinic
end
