class ChangeLikesPinIdDatatypeToInteger < ActiveRecord::Migration
  def self.up
    change_table :likes do |t|
      t.change :pin_id, :integer
    end
  end
 
  def self.down
    change_table :likes do |t|
      t.change :pin_id, :string
    end
  end
end
