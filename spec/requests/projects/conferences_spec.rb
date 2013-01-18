require "spec_helper"

feature "managing conference site" do
  let(:user) { FactoryGirl.create(:admin_user) }
  subject { FactoryGirl.create(:conference, user_id: user.id) }
  before { subject.approve! }

  scenario "should apply site modules settings" do
    sign_in user
    visit "#{project_url(subject.domain)}/settings"
    check("checkbox_personal_page")
    click_button I18n.t('conference.form.submit')
    visit "#{project_url(subject.domain)}/"
    page.should have_content(I18n.t('projects.conferences.modules.personal_page'))
  end
end
