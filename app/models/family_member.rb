class FamilyMember < ApplicationRecord
    validates :name, :presence=>true
    validates :mobile, :presence=>true
end
