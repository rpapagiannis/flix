class MoviesController < ApplicationController
  def index
    @movies = [ "Interstellar", "Tenet", "The Dark Knight", "The Prestige" ]
  end
end
