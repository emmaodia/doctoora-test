class Card < ActiveRecord::Base

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  	# validates_attachment_size :image, less_than: 2.megabytes

  	belongs_to :card_category
end
