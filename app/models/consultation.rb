class Consultation < ActiveRecord::Base
	belongs_to :user
	belongs_to :doctor

	def start_time
        self.date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end

    SPECIALIZATIONS = ["Medical", "Fitness", "Nutritional"]
end