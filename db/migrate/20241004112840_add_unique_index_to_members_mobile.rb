class AddUniqueIndexToMembersMobile < ActiveRecord::Migration[7.1]
  def change
    remove_index :members, :mobile if index_exists?(:members, :mobile)
    add_index :members, :mobile, unique: true, where: "mobile IS NOT NULL AND mobile <> ''"
  end
end
