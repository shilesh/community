require 'rails_helper'

RSpec.describe Location, type: :model do
  subject { Location.new(member_id: 5, lat: 40.7128, lng: -74.0060) }

  describe 'Validations' do
    
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a member_id' do
      subject.member_id = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:member_id]).to include("can't be blank")
    end
  end
end
