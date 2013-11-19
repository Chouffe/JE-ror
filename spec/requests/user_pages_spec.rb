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
      let(:submit) { "Enregister" }
      before do
        visit new_user_registration_path
        fill_in "Email", with: "user@example.com"
        fill_in "Mot de passe", with: "topsecret"
        fill_in "Confirmation du mot de passe", with: "topsecret"
        fill_in "Prénom", with: "test"
        fill_in "Nom", with: "michel"
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
      let(:submit) { "Se connecter" }
      let(:user) { FactoryGirl.create(:user) }
      before do
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Mot de passe", with: user.password
        click_button submit
      end
      it { should have_title("Accueil") }
    end
  end

  # describe "Edit User Page" do
  #   before do
  #     @request.env["devise.mapping"] = Devise.mappings[:user]
  #     user = FactoryGirl.create(:user)
  #     user.confirm!
  #     sign_in user
  #     visit edit_user_registration_path
  #     fill_in "Prénom", with: "Jesus"
  #     click_button submit
  #   end
  #   it { should have_content("updated") } 
  # end
end
