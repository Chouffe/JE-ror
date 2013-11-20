require 'spec_helper'

describe "Mailbox Pages" do
  subject { page }
  let(:receiver) { FactoryGirl.create(:user) }
  let(:sender) { FactoryGirl.create(:user) }
  let(:submit) { "Se connecter" }
  let(:bd) { "My awesome Body" }
  let(:sbj) { "Interesting stuff here" }

  # Sign in the receiver
  before do
    visit new_user_session_path
    fill_in "Email", with: receiver.email
    fill_in "Mot de passe", with: receiver.password
    click_button submit
    # Send message
    sender.send_message(receiver, bd, sbj)
  end

  describe "Notifications navbar" do
    before { visit root_path }
    it { should have_selector("span.badge") }
    it { should have_selector("span.badge", text: '1') }
  end

  describe "Inbox" do
    before { visit mailbox_inbox_path }
    it { should have_title("Boîte de réception") }
    it { should have_content("Boîte de réception") }
    it { should have_content("Boîte de réception") }
    it { should have_content("Envoyés") }
    it { should have_content("Corbeille") }
  end

  describe "Sendbox" do
    before { visit mailbox_sentbox_path }
    it { should have_title("Envoyés") }
    it { should have_content("Envoyés") }
    it { should have_content("Boîte de réception") }
    it { should have_content("Envoyés") }
    it { should have_content("Corbeille") }
  end

  describe "Trash" do
    before { visit mailbox_trash_path }
    it { should have_title("Corbeille") }
    it { should have_content("Corbeille") }
    it { should have_content("Boîte de réception") }
    it { should have_content("Envoyés") }
    it { should have_content("Corbeille") }
  end

  describe "Show" do
    before { visit mailbox_show_path(1) }
    it { should have_title("Message") }
    it { should have_content("Message") }
    it { should have_content("Boîte de réception") }
    it { should have_content("Envoyés") }
    it { should have_content("Corbeille") }

    describe "should see a conversation" do
      it { should have_content(bd) }
      it { should have_content(sbj) }
    end

    describe "should see a reply form" do
      it { should have_selector('form') }
      it { should have_selector('textarea')}
    end

    describe "should read message" do
      before { visit mailbox_inbox_path }
      it { should have_selector("span.badge") }
      it { should have_selector("span.badge", text: '0') }
    end
      
  end
end
