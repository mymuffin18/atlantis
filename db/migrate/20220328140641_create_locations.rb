class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.float :longitude
      t.float :latitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
