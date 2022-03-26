class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_one_attached :profile_pic

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
end
