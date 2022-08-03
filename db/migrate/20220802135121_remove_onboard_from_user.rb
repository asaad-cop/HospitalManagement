class RemoveOnboardFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :onboard, :integer
  end
end
