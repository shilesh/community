class AddUniqueIndexToAddressesMemberId < ActiveRecord::Migration[7.1]
  def change
    # Remove the existing index (if it exists) 
    remove_index :addresses, :member_id if index_exists?(:addresses, :member_id)

    # Add the unique index
    add_index :addresses, :member_id, unique: true
  end
end
