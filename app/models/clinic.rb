class Clinic < ActiveRecord::Base

	has_many :consultations
  belongs_to :clinic_rental

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	def self.in_town user_location
   		where("lower(town) = ?", "%#{user_location}".downcase)
  	end

	private

    def lower string
      return string.downcase
    end
end
