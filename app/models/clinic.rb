class Clinic < ActiveRecord::Base

	has_many :consultations

	def self.in_town user_location
   		where("lower(town) = ?", "%#{user_location}".downcase)
  	end

	private

    def lower string
      return string.downcase
    end
end
