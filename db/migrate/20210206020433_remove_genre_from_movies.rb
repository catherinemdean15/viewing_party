class RemoveGenreFromMovies < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :genre
  end
end
