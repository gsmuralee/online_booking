class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true , foreign_key: true
      t.references :table, index: true , foreign_key: true
      t.string :reference_number
      t.datetime :start_time
      t.datetime :end_time
      t.integer  :duration
       
      t.timestamps null: false
    end
  end
end
