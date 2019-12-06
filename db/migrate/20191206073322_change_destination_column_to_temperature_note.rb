class ChangeDestinationColumnToTemperatureNote < ActiveRecord::Migration[6.0]
  def change
    remove_column :temperature_notes, :destination, :string
    add_column :temperature_notes, :destination_id, :integer, references: :destinations
  end
end
