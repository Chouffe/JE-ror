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

    describe "should see no messages" do
      it { should_not have_selector('table') }
      it { should have_content('Aucun message') }
    end
    describe "should see a message sent" do
      before do
        receiver.send_message(sender, bd, sbj)
        visit mailbox_sentbox_path
      end
      it { should have_selector('table') }
      it { should_not have_content('Aucun message') }
      it { should have_content(sbj) }
    end
  end

  describe "Trash" do
    before { visit mailbox_trash_path }
    it { should have_title("Corbeille") }
    it { should have_content("Corbeille") }
    it { should have_content("Boîte de réception") }
    it { should have_content("Envoyés") }
    it { should have_content("Corbeille") }

    describe "should see no messages in the trashbox" do
      it { should_not have_selector('table') }
      it { should have_content('Aucun message supprimé') }
    end
  end

  describe "Show" do

    before { visit mailbox_show_path(1) }
    it { should have_title("Message") }
    it { should have_content("Message") }
    it { should have_content("Boîte de réception") }
    it { should have_content("Envoyés") }
    it { should have_content("Corbeille") }
    it { should_not have_link('untrash') }
    it { should have_link('trash') }
    it { should have_link('reply') }

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

    describe "should be able to trash it" do

      before { click_link('trash') }
      it { should have_selector('div.alert.alert-notice') }
      it { should have_title('Boîte de réception') }
      it { should have_content('Boîte de réception') }

      describe "Should see the message in the trashbox" do
        before { visit mailbox_trash_path }
        it { should have_content(sbj) }

        describe "Should not see the trash link and the reply link" do
          before { visit mailbox_show_path(1) }
          it { should_not have_link('trash') }
          it { should have_link('untrash') }

          describe "it should not have a reply form" do
            it { should_not have_link('reply') }
            it { should_not have_selector('textarea')}
          end
        end
      end

      describe "should see no messages in the inbox" do
        before { visit mailbox_inbox_path }
        it { should_not have_selector('table') }
        it { should have_content('Aucun message') }
      end

    end
  end
end
