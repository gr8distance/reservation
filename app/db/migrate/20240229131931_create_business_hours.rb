class CreateBusinessHours < ActiveRecord::Migration[7.1]
  def change
    create_table :business_hours do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps

      t.index [:start_at, :end_at], unique: true
    end
  end
end
