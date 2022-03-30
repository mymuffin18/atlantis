class RemoveApprovedFromDisasterReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :disaster_reports, :approved, :boolean
  end
end
