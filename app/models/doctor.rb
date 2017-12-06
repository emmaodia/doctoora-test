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

  has_many :consultations, dependent: :destroy
  has_many :messages, as: :messageable
  has_many :patient_reviews
  has_many :notifications
  has_many :transactions

  has_one :wallet, dependent: :destroy

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_size :avatar, less_than: 2.megabytes

  def self.search location, specialization, specialty
    where("lower(specialization) = ? and lower(town) = ? and lower(specialty) = ?", "#{specialization}".downcase, "#{location}".downcase, "#{specialty}".downcase)
  end

  def self.get_available_professionals_of_type type
    where("specialization = ? AND available = ?", type, true)
  end

  CLINICAL_SPECIALTY_LIST = ["Aesthetic Practitioner", "Cardiologist", "Cardiothoracic Surgery", "Dental", "Dermatology", 
    "General Practitioner", "General Surgery", "Haematology", "Mental Health General Practitioner", "Nephrology", "Neurology", "Neurosurgery",
    "Obstetrics and Gynecology", "Oncology", "Orthopaedic Surgery", "Paediatric Oncology", "Paediatric Surgery",
    "Paediatrics", "Psychiatry", "Renal Surgery", "Respirology", "Urology"]

  NON_CLINICAL_SPECIALTY_LIST = ["Dance Aerobics", "Swimming", "Yoga", "Martial Arts", "Dietetics", "Lifestyle Counseling", "Sex Therapy"]

  private

    def lower string
      return string.downcase
    end

end