class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.string :city_name
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
