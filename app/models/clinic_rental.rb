class ClinicRental < ActiveRecord::Base
  belongs_to :clinic
  # belongs_to :transaction

  has_one :clinic
end
