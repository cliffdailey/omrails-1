class ChangeLikesPinIdDatatypeToInteger < ActiveRecord::Migration
  def self.up
   connection.execute(%q{
    alter table likes
    alter column pin_id
    type integer using cast(pin_id as integer)
  })
  end
 
  def self.down
    
  end
end
