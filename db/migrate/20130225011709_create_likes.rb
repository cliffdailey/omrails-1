class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.string :pin_id
      t.string :integer

      t.timestamps
    end
  end
end
