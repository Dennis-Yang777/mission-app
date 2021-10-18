class AddPriorityColToMission < ActiveRecord::Migration[6.1]
  def change
    add_column :missions, :priority, :integer
    add_column :missions, :priority_state, :integer
  end
end
