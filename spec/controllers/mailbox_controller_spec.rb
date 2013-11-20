require 'spec_helper'

describe MailboxController do

  describe "GET 'inbox'" do
    it "returns http success" do
      get 'inbox'
      response.should be_success
    end
  end

  describe "GET 'sentbox'" do
    it "returns http success" do
      get 'sentbox'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'trash'" do
    it "returns http success" do
      get 'trash'
      response.should be_success
    end
  end

end
