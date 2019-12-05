require 'rails_helper'

RSpec.describe User, type: :model do
  before (:each) do
    @user = FactoryBot.create(:user)
  end
  it "is creatable using a Factory" do
    expect(@user).to be_valid
  end

  it "is not valid without an email" do
    @user.email = ""
    expect(@user).to_not be_valid
  end

  it "is not valid without a password" do
    @user.password = ""
    expect(@user).not_to be_valid
  end

  it "is not valid without an is student status" do
    @user.is_student = ""
    expect(@user).not_to be_valid
  end

  it "can participate lectures" do
    @user.is_student = true
    lecture1 = FactoryBot.create(:lecture)
    lecture2 = FactoryBot.create(:lecture, lecturer: FactoryBot.build(:user, :lecturer, email: "test4@hpi.de"))
    @user.participating_lectures << lecture1
    @user.participating_lectures << lecture2
  end
end
