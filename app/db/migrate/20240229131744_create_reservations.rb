class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.integer :amount, null: false, default: 1

      t.timestamps

      t.index %i[start_at end_at], unique: true
    end
  end
end
