class Location < ApplicationRecord
    validates :member_id, presence: true, uniqueness: true
end
