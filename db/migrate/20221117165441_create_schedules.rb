class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.date :date
      t.string :name
      t.references :driver, null: true, foreign_key: { to_table: :users }
      t.boolean :complete

      t.timestamps
    end
  end
end
