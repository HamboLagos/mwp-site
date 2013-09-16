class AddPendingApprovalToAthlete < ActiveRecord::Migration
  def change
    add_column :athletes, :pending_approval, :boolean, default: true
  end
end
