class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_one_attached :profile_pic

  after_commit :add_default_profile_pic, on: [:create, :update]



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  def add_default_profile_pic
    unless profile_pic.attached?
      self.profile_pic.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-profile.jpg')), filename: 'default-profile.jpg', content_type: 'image/jpg')
    end
  end
end
