class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.integer :amount

      t.timestamps
    end
  end
end
