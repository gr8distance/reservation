class CreateReservableTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :reservable_times do |t|
      t.integer :minute, null: false

      t.timestamps
    end
  end
end
