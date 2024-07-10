class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.integer :member_id
      t.boolean :permanent
      t.boolean :communication
      t.string :permanent_zip
      t.string :communication_zip

      t.timestamps
    end
    add_index :addresses, :member_id
  end
end
