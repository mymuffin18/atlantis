class CreateDisasterReports < ActiveRecord::Migration[6.1]
  def change
    create_table :disaster_reports do |t|
      t.float :latitude
      t.float :longitude
      t.datetime :date_occured
      t.references :disaster, null: false, foreign_key: true
      t.string :disaster_level
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.string :approved_by
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
