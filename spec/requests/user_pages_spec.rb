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

  describe "show page" do

    describe "when not signed in" do
      let(:user) { FactoryGirl.create(:user) }
      describe "Valid User" do
        before { visit users_show_path(user) }
        it { should have_content("Connexion") }
      end

      describe "Invalid User" do
        before { visit users_show_path(1) }
        it { should_not have_content(user.full_name) }
        it { should have_content("Connexion") }
      end
    end

    describe "when signed in" do
      describe "as a regular user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:submit) { "Se connecter" }
        before do
          visit new_user_session_path
          fill_in "Email", with: user.email
          fill_in "Mot de passe", with: user.password
          click_button submit
        end
        describe "Valid User" do
          before { visit users_show_path(user) }
          it { should have_selector('h1', text: user.full_name) }
          it { should_not have_selector('div.admin') }
        end

        describe "Invalid User" do
          before { visit users_show_path(100) }
          it { should_not have_selector('h1', text: user.full_name) }
          it { should have_selector('div.alert.alert-notice') }
        end
      end
      describe "as an admin" do
        let(:admin) { FactoryGirl.create(:admin) }
        let(:submit) { "Se connecter" }
        before do
          visit new_user_session_path
          fill_in "Email", with: admin.email
          fill_in "Mot de passe", with: admin.password
          click_button submit
        end
        before { visit users_show_path(admin) }
        it { should have_selector('div.admin') }
      end
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
