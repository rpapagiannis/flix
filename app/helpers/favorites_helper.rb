module FavoritesHelper
  def fav_or_unfav_button(movie, favorite)
    if @favorite.blank?
      button_to "❤️ Fave", movie_favorites_path(movie)
    else
       button_to "Unfave", movie_favorite_path(movie, favorite), method: :delete
    end
  end
end
