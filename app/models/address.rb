class Address < ApplicationRecord
    belongs_to :member
    validates :member_id, presence: true, uniqueness: true
end
