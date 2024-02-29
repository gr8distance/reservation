class CreateHolidays < ActiveRecord::Migration[7.1]
  def change
    create_table :holidays do |t|
      t.date :date, null: false

      t.timestamps

      t.index :date, unique: true
    end
  end
end
