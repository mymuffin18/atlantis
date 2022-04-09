class AddDateOfSuspensionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :dateOfSuspension, :date
  end
end
