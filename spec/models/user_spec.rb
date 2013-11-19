require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  subject { @user }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should be_valid }

  describe "with empty first name" do
    before { @user.first_name = " " }
    it { should_not be_valid }
  end
  describe "with too long first name" do
    before { @user.first_name = "a" * 101 }
    it { should_not be_valid }
  end
  describe "with empty last name" do
    before { @user.last_name = " " }
    it { should_not be_valid }
  end
  describe "with too long last name" do
    before { @user.last_name = "a" * 101 }
    it { should_not be_valid }
  end

  describe "save with valid information" do
    before { @user.save }
    it { should be_valid }
  end

end
