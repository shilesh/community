class Admin < ApplicationRecord

    validates :name, presence: true
    validates :mobile, presence: true, uniqueness: true
    validates :password_digest, presence: true
  end
  

