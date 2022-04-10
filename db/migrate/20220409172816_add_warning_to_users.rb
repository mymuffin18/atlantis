class AddWarningToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :warning, :integer
  end
end
