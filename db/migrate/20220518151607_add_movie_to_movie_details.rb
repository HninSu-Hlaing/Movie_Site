class AddMovieToMovieDetails < ActiveRecord::Migration[6.1]
  def change
    add_reference :movie_details, :movie, null: false, foreign_key: true
  end
end
