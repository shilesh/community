require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:member) { Member.create!(name: "John Doe", mobile: "9400988067") }
  subject { Address.new(member_id: member.id, permanent: true, communication:false ,permanent_zip: 'bangalore, sanjaynagar',communication_zip: 'Bangalore') }

  describe 'Validations' do
    
    it 'is valid with valid attributes' do
      subject.member_id = member.id
      expect(subject).to be_valid
    end

    it 'is not valid without a member_id' do
      subject.member_id = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:member_id]).to include("can't be blank")
    end
  end
end



