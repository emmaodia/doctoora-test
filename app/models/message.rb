class Message < ActiveRecord::Base
  	belongs_to :conversation
  	belongs_to :messageable, polymorphic: true

	validates_presence_of :body, :conversation_id

end
