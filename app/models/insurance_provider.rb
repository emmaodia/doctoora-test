class InsuranceProvider < ActiveRecord::Base
	has_many :transactions
end
