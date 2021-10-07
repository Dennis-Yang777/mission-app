class ChangeMissionModelColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :missions, :name
    add_column :missions, :title, :string, limit: 50
  end
end
