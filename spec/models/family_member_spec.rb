require 'rails_helper'

RSpec.describe FamilyMember, :type => :model do

    it "name must be present to be valid" do
        fm1 = FamilyMember.new(name:'abc', mobile:'1243792373', blood_group:'A+')
        expect(fm1).to be_valid
    end 

    it "name must be present to be valid" do
        fm1 = FamilyMember.new(name:nil, mobile:'1243792373', blood_group:'A')
        expect(fm1).to_not be_valid
    end 


    it "mobile must be present to be valid" do
        fm1 = FamilyMember.new(name:'abc', mobile:'1243792373', blood_group:'A+')
        expect(fm1).to be_valid
    end 

    it "mobile must be present to be valid" do
        fm1 = FamilyMember.new(name:'abc', mobile:nil, blood_group:'A+')
        expect(fm1).to_not be_valid
    end 


    it "blood_group must be present to be valid" do
        fm1 = FamilyMember.new(name:'abc', mobile:'1243792373', blood_group:'A+')
        expect(fm1).to be_valid
    end 

    it "blood_group did not to be present to be valid" do
        fm1 = FamilyMember.new(name:'abc', mobile:'1243792373', blood_group:nil)
        expect(fm1).to_not be_valid
    end 

end 