require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "must be created with a password and password_confirmation fields" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "jsmith@gmail.com", password: "pass", password_confirmation: "pass")
      expect(@user.errors.full_messages).to match []
    end

    it "password field must be filled out" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "jsmith@gmail.com", password: "pass", password_confirmation: "")
      expect(@user.errors.full_messages).to match ["Password confirmation doesn't match Password"]
    end

    it "password_confirmation field must be filled out" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "jsmith@gmail.com", password: nil, password_confirmation: "pass")
      expect(@user.errors.full_messages).to match ["Password can't be blank", "Password is too short (minimum is 3 characters)"]
    end

    it "the password and password_confirmation fields must match" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "jsmith@gmail.com", password: "pass", password_confirmation: "pas")
      expect(@user.errors.full_messages).to match ["Password confirmation doesn't match Password"]
    end

    it "email field must be filled" do
      @user = User.create(first_name: "John", last_name: "Smith", password: "pass", password_confirmation: "pass")
      expect(@user.errors.full_messages).to match ["Email can't be blank"]
    end

    it "emails must be unique" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "example@example.com", password: "pass", password_confirmation: "pass")
      @user2 = User.create(first_name: "John", last_name: "Smith", email: "example@example.com", password: "pass", password_confirmation: "pass")
      expect(@user2.errors.full_messages).to match ["Email has already been taken"]
    end

    it "emails must be unique - property is not case sensitive" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "example@example.com", password: "pass", password_confirmation: "pass")
      @user2 = User.create(first_name: "John", last_name: "Smith", email: "eXAMple@EXAmple.cOM", password: "pass", password_confirmation: "pass")
      expect(@user2.errors.full_messages).to match ["Email has already been taken"]
    end

    it "first name must be entered" do
      @user = User.create(first_name: "", last_name: "Smith", email: "jsmith@gmail.com", password: "pass", password_confirmation: "pass")
      expect(@user.errors.full_messages).to match ["First name can't be blank"]
    end
    it "last name must be entered" do
      @user = User.create(first_name: "John", last_name: "", email: "jsmith@gmail.com", password: "pass", password_confirmation: "pass")
      expect(@user.errors.full_messages).to match ["Last name can't be blank"]
    end
  end

  describe "Passwords" do
    it "must meet the minimum length (3 characters) when user account is being created" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "jsmith@gmail.com", password: "pa", password_confirmation: "pa")
      expect(@user.errors.full_messages).to match ["Password is too short (minimum is 3 characters)"]
    end
  end

  describe ".authenticate_with_credentials" do
    it "username and password must match to log in successfully" do
      @user = User.create(first_name: "Kelly", last_name: "Smith", email: "ksmith@gmail.com", password: "kel", password_confirmation: "kel")
      expect(User.authenticate_with_credentials('ksmith@gmail.com', 'kellll')).to be_nil
      expect(User.authenticate_with_credentials('ksmith@gmail.com', 'kel')).to match @user
    end
  end

end
