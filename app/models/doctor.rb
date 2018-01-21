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
  has_many :clinic_rentals
  has_many :doctor_reviews

  has_one :wallet, dependent: :destroy

  has_many :prescriptions

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_size :avatar, less_than: 2.megabytes

  def self.search town, specialization, specialty
    if town == '' && specialization == '' && specialty == ''
      self.all
    elsif town == '' && specialization == ''
      where("lower(specialty) = ?", "#{specialty}".downcase)
    elsif town == '' && specialty == ''
      where("lower(specialization) = ?", "#{specialization}".downcase)
    elsif specialty == '' && specialization == ''
      where("lower(town) = ?", "#{town}".downcase)
    elsif town == ''
      where("lower(specialty) = ? and lower(specialization) = ?", "#{specialty}".downcase, "#{specialization}".downcase )
    elsif specialty == ''
      where("lower(town) = ? and lower(specialization) = ?", "#{town}".downcase, "#{specialization}".downcase)
    elsif specialization == ''
      where("lower(specialty) = ? and lower(town) = ?", "#{specialty}".downcase, "#{town}".downcase)
    else
      where("lower(specialization) = ? and lower(town) = ? and lower(specialty) = ?", "#{specialization}".downcase, "#{town}".downcase, "#{specialty}".downcase)
    end
  end

  def self.get_available_professionals_of_type type
    where("specialization = ? AND available = ?", type, true)
  end

  CLINICAL_SPECIALTY_LIST = ["Aesthetic Practitioner", "Cardiologist", "Cardiothoracic Surgery", "Dental", "Dermatology", 
    "General Practitioner", "General Surgery", "Haematology", "Mental Health General Practitioner", "Nephrology", "Neurology", "Neurosurgery",
    "Obstetrics and Gynecology", "Oncology", "Orthopaedic Surgery", "Paediatric Oncology", "Paediatric Surgery",
    "Paediatrics", "Psychiatry", "Renal Surgery", "Respirology", "Urology"]

  NON_CLINICAL_SPECIALTY_LIST = ["Dance Aerobics", "Swimming", "Yoga", "Martial Arts", "Dietetics", "Lifestyle Counseling", "Sex Therapy", "Nursing"]

  private

    def lower string
      return string.downcase
    end

end