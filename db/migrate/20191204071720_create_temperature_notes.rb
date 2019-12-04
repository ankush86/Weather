class CreateTemperatureNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :temperature_notes do |t|
      t.string :destination
      t.datetime :time
      t.string :temperature
      t.string :note

      t.timestamps
    end
  end
end
