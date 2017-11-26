class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :consultations, dependent: :destroy
  has_many :messages, as: :messageable
  has_many :transactions, dependent: :nullify
  has_many :patient_reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :care_team, dependent: :destroy
  has_one :wallet, dependent: :destroy

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_size :avatar, less_than: 2.megabytes

  serialize :vaccinations

  def vaccinations=(vaccinations)
    vaccinations.reject(&:blank?)
  end
end
