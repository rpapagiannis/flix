module ReviewsHelper
  def average_stars(movie)
    movie.average_stars.zero? ? content_tag(:strong, "No Reviews") : "⭐️" * movie.average_stars.round
  end
end
