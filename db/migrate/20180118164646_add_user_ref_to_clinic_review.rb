class AddUserRefToClinicReview < ActiveRecord::Migration
  def change
    add_reference :clinic_reviews, :user, index: true, foreign_key: true
  end
end
