class AddAttachmentImageToClinics < ActiveRecord::Migration
  def self.up
    change_table :clinics do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :clinics, :image
  end
end
