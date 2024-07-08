class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.integer :member_id
      t.string :type
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
