require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject { Admin.new(name: 'Abc', mobile: '1234567892', password_digest: 'password123') }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      puts "#{subject.inspect}"
      subject.name  = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end
  end
end