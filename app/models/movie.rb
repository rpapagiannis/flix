class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17]

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 30 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: { with: /\A\w+\.(jpg|png)\z/i, message: "must be a JPG or PNG image" }
  validates :rating, inclusion: { in: RATINGS }

  def self.released
    where("released_on < ?", Time.now).order(released_on: :desc)
  end

  def flop?
    (total_gross.blank? || total_gross < 225_000_000) && (reviews.count < 50 || reviews.average(:stars) < 4)
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (self.average_stars / 5.0) * 100
  end
end
