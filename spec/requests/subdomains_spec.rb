require 'spec_helper'

feature "subdomains" do
  subject { FactoryGirl.create(:conference) }

  scenario "should open conference website" do
    visit(project_url(subject.domain))
    page.should have_content(subject.domain)
  end

  scenario "should open service site" do
    visit("/")
    page.should have_content("vsuconf.ru")
  end

end
