class AddStateToMission < ActiveRecord::Migration[6.1]
  def change
    add_column :missions, :state, :string
  end
end
