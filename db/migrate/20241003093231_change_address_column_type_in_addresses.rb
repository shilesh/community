class ChangeAddressColumnTypeInAddresses < ActiveRecord::Migration[7.1]
  def change
    change_column :addresses, :permanent, :string
    change_column :addresses, :communication, :string
  end
end
