class Message < ActiveRecord::Base
  	belongs_to :conversation
  	belongs_to :messageable, polymorphic: true

	validates_presence_of :conversation_id

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
