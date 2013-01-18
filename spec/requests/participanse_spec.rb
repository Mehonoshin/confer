require 'spec_helper'

feature "participanse in conferences" do
  let(:user) { FactoryGirl.create(:user) }

  scenario "should be possible only once" do
    FactoryGirl.create(:conference, user_id: user.id, state: "approved")
    sign_in(user)
    visit("/conferences")
    click_button(I18n.t('conference.join'))
    click_button(I18n.t('projects.participant.form.take_part'))
    visit("/conferences")
    page.should have_content(I18n.t('conference.you_already_participate'))
  end

  scenario "should open service site" do
    visit("/")
    page.should have_content("vsuconf.ru")
  end

end

