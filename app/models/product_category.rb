class ProductCategory < ActiveRecord::Base
	has_many :plans
end
