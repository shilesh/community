require 'rails_helper'

RSpec.describe Member, :type => :model do

    it "is valid with name" do 
        m1 = Member.new(name: nil, mobile:'1234', blood_group:'A')
        expect(m1).to_not be_valid
    end 

    it "is not valid without a mobile" do
        m2 = Member.new(name:'ss', mobile:nil, blood_group:'A')
        expect(m2).to_not be_valid
    end 

    it "is not valid without a blood_group" do
        m3 = Member.new(name: 'ss', mobile:'1', blood_group:nil)
        expect(m3).to_not be_valid
    end

    context "mobile number should not be same" do
    before {Member.create!(name: 'ss', mobile:'456', blood_group:'A')}

    it {
        m1 = Member.new(name: 'ss', mobile:'456', blood_group:'A')
        expect(m1).to_not be_valid
    }
    end

    context "mobile number should be unique" do
    before {Member.create!(name: 'ss', mobile:'123', blood_group:'A')}
    
    it {
        m2 = Member.new(name: 'ss', mobile:'122333', blood_group:'A')
        expect(m2).to be_valid
    }
    end

end