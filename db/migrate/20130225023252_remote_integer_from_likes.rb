class RemoteIntegerFromLikes < ActiveRecord::Migration
  def change
  	remove_column :likes, :integer
  end
end
