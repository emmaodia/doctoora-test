class Consultation < ActiveRecord::Base
	belongs_to :user
	belongs_to :doctor

	has_many :patient_reviews
	has_many :prescriptions

	def start_time
        self.date #this is for the simple_calendar, refer to documentation: https://github.com/excid3/simple_calendar
    end

    SPECIALIZATIONS = ["Clinical", "Non-Clinical", "Care Team"]
end