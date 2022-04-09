class ChangeWarningToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :warning, :integer, default:0
  end
end
