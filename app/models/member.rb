class Member < ApplicationRecord
        has_one :address, :dependent => :destroy
        enum status: { inactive: 0, active: 1 }

        validates :name, :presence=>true, format: { with: /[0-9a-zA-Z_]{3}/,
        message: 'must contain at least three charactors' }

        validates :mobile, format: { with: /\A[0-9]{10}\z/,
        message: 'should be valid number' }, uniqueness: true, allow_blank: true

        validates :blood_group, format: { with: /[a-zA-Z].*(?=.*[+-]){3}/,
        message: 'should be valid'}, allow_blank: true
end
