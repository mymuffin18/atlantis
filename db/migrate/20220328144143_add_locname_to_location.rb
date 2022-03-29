class AddLocnameToLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :locname, :string
  end
end
