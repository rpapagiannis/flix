class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17]
  before_save :set_slug

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  validates :title, presence: true, uniqueness: true
  validates :duration, :released_on, presence: true
  validates :description, length: { minimum: 30 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  # validates :image_file_name, format: { with: /\A\w+\.(jpg|png)\z/i, message: "must be a JPG or PNG image" }
  validates :rating, inclusion: { in: RATINGS }

  scope :released, -> { where(released_on: ..Time.now).order(released_on: :desc) }
  scope :upcoming, -> { where(released_on: Time.now..).order(:released_on) }
  scope :recent, ->(max = 5) { released.limit(max) }
  scope :flops, -> { released.where(total_gross: ..225_000_000).order(:total_gross) }
  scope :hits, -> { released.where(total_gross: 225_000_000...).order(total_gross: :desc) }

  def flop?
    (total_gross.blank? || total_gross < 225_000_000) && (reviews.count < 50 || reviews.average(:stars) < 4)
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (self.average_stars / 5.0) * 100
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = title.parameterize
  end
end
