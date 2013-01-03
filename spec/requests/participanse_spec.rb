require 'spec_helper'
require 'capybara_helper'

feature "participanse in conferences" do
  subject { FactoryGirl.create(:conference, user_id: user.id, state: "approved") }
  let(:user) { FactoryGirl.create(:user) }
  before(:each) { subject }

  scenario "should be possible only once", js: true do
    sign_in(user)
    visit("/conferences")
    click_button(I18n.t('conference.join'))
    visit("/conferences")
    page.driver.render('file.png')
    page.should_not have_content(I18n.t('conference.join'))
  end

  scenario "should open service site" do
    visit("/")
    page.should have_content("vsuconf.ru")
  end

end

