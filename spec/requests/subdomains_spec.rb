require 'spec_helper'

feature "subdomains" do
  subject { FactoryGirl.create(:conference) }

  scenario "should open conference website" do
    visit("http://#{subject.domain}.confer.dev:8097")
    page.should have_content(subject.domain)
  end

  scenario "should open service site" do
    visit("/")
    page.should have_content("vsuconf.ru")
  end

end
