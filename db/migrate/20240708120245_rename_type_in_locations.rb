class RenameTypeInLocations < ActiveRecord::Migration[7.1]
  def change
    rename_column :locations, :type, :location_type
    rename_column :addresses, :type, :address_type

  end
end
