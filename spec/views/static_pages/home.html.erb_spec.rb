require 'spec_helper'

describe "Static Pages" do
end
describe "static_pages/home.html.erb" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }
    it { should have_title("Accueil") }
    it { should have_content("Accueil") }
  end

  describe "Contact Page" do
    before { visit contact_path }
    it { should have_title("Contact") }
    it { should have_content("Contact") }
  end

end
