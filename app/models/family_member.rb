class FamilyMember < ApplicationRecord
    validates :name, :presence=>true,  format: { with: /[0-9a-zA-Z_]{3}/,
    message: 'must contain at least three charactors' }

    validates :mobile, :presence=>true, format: { with: /\A[0-9]{10}\z/,
    message: 'should be valid number' }

    validates :blood_group, format: { with: /[a-zA-Z].*(?=.*[+-]){2}/,
    message: 'should be valid' }
end
