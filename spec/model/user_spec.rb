require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: "test@example.com", password: "password") }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    #Checks if the User model is invalid without an email.
    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
     
    #Checks if the User model is invalid with a duplicate email.
    it "is not valid with a duplicate email" do
      User.create!(email: "test@example.com", password: "password")
      expect(subject).to_not be_valid
    end

    #Checks if the User model is invalid with an improperly formatted email.
    it "is not valid with an invalid email format" do
      subject.email = "invalid_email"
      expect(subject).to_not be_valid
    end
  end

  describe "Password" do
    it "authenticates with a correct password" do
      subject.save
      expect(subject.authenticate("password")).to be_truthy
    end

    it "does not authenticate with an incorrect password" do
      subject.save
      expect(subject.authenticate("wrong_password")).to be_falsey
    end
  end
end





