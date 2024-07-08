class Address < ApplicationRecord
    self.inheritance_column = :_type_disabled
end


# generrate new migration
# def change
#     rename_column :users, :first_name, :given_name
#   end
# def change
#     rename_column :table_name, :current_column_name, :new_column_name
# end

