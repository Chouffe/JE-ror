require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "signup page" do
    before { visit new_user_registration_path }

    describe "Content" do
      it { should have_title("Inscription") }
      it { should have_content("Inscription") }
    end

    describe "Should create a user" do
      let(:submit) { "Sign up" }
      before do
        visit new_user_registration_path
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "topsecret"
        fill_in "Password confirmation", with: "topsecret"
      end
      it "Should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "signin page" do
    before { visit new_user_session_path }
    describe "Content" do
      it { should have_title("Connexion") }
      it { should have_content("Connexion") }
    end
    describe "User signin" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      it { should have_content("Lorem Ipsum") }
    end
  end
end
