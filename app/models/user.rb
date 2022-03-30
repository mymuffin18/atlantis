class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_one_attached :profile_pic

  has_many :locations, dependent: :destroy

  has_many :disaster_reports, dependent: :destroy

  after_commit :add_default_profile_pic, on: %i[create update]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  acts_as_voter

  def profile_pic_url
    url_for(profile_pic)
  end

  def add_default_profile_pic
    profile_pic.attach(io: File.open('app/assets/images/default-profile.jpg'), filename: 'default-profile.jpg', content_type: 'image/jpg') unless profile_pic.attached?
  end
end
