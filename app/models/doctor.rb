class Doctor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :mdcn
  has_attached_file :nysc
  has_attached_file :uni_cert
  has_attached_file :post_nysc
  has_attached_file :id_proof

  validates_attachment_content_type :mdcn, content_type: 'application/pdf'
  validates_attachment_content_type :nysc, content_type: 'application/pdf'
  validates_attachment_content_type :uni_cert, content_type: 'application/pdf'
  validates_attachment_content_type :post_nysc, content_type: 'application/pdf'
  validates_attachment_content_type :id_proof, content_type: 'application/pdf'

  has_many :consultations
  has_many :messages, as: :messageable
  has_many :patient_reviews

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_size :avatar, less_than: 2.megabytes

  def self.search location, specialization
    where("lower(town) LIKE ?", "%#{location}%".downcase)
    where("lower(specialization) LIKE ?", "%#{specialization}".downcase)
  end

  private

    def lower string
      return string.downcase
    end

end