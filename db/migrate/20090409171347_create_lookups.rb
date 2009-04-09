class CreateLookups < ActiveRecord::Migration
  def self.up
    create_table :lookups do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :lookups
  end
end
