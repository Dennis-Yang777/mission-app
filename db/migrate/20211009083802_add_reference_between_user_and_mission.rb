class AddReferenceBetweenUserAndMission < ActiveRecord::Migration[6.1]
  def change
    add_reference(:missions, :user, index: true)
  end
end
