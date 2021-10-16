class AddTimeColToMission < ActiveRecord::Migration[6.1]
  def change
    add_column :missions, :start_time, :datetime, null: false
    add_column :missions, :end_time, :datetime, null: false
  end
end
