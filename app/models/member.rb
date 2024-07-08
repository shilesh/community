class Member < ApplicationRecord
        validates :name, :presence=>true
        validates :mobile, :presence=>true, :uniqueness=>true
end
