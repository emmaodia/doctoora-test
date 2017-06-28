class AddAttachmentMdcnNyscUniCertPostNyscIdProofToDoctors < ActiveRecord::Migration
  def self.up
    change_table :doctors do |t|
      t.attachment :mdcn
      t.attachment :nysc
      t.attachment :uni_cert
      t.attachment :post_nysc
      t.attachment :id_proof
    end
  end

  def self.down
    remove_attachment :doctors, :mdcn
    remove_attachment :doctors, :nysc
    remove_attachment :doctors, :uni_cert
    remove_attachment :doctors, :post_nysc
    remove_attachment :doctors, :id_proof
  end
end
