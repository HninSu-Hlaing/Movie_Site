class AddMovieToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :movie, null: false, foreign_key: true
  end
end
