class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :movie_name
      t.date :date
      t.string :movie_theater
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
