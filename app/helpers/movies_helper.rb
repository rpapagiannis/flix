module MoviesHelper
  def total_gross(movie)
    movie.flop? ? "Flop" : number_to_currency(movie.total_gross, precision: 0)
  end

  def year_of(movie)
    movie.released_on.year
  end
end
