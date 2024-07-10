class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.integer :member_id
      t.float :lat
      t.float :lng

      t.timestamps
    end
    add_index :locations, :member_id
  end
end
