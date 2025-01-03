class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  has_secure_password

  validates :name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: true }
  validates :email, format: { with: /\A\S+@\S+\.\S+\z/ }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 7, allow_blank: true }

  scope :by_name, -> { order(:name) }
  scope :not_admins, -> { by_name.where(admin: false) }
end
