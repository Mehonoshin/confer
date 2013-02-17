require "spec_helper"

feature "Conference static pages" do
  let(:user) { FactoryGirl.create(:admin_user) }
  let(:conference) { FactoryGirl.create(:conference, user_id: user.id) }

  before do
    conference.approve!
    sign_in user
    visit "#{project_url(conference.domain)}/pages"
    click_button I18n.t('projects.pages.add')
  end

  scenario "should add and display static page" do
    within "#new_page" do
      fill_in I18n.t('projects.pages.title'), with: "Custom title"
      fill_in I18n.t('projects.pages.body'), with: "Custom body"
      fill_in I18n.t('projects.pages.permalink'), with: "page1"
      check I18n.t('projects.pages.display_in_menu')
    end

    click_button I18n.t('projects.pages.submit')
    visit "#{project_url(conference.domain)}/page1"

    page.should have_content("Custom body")
    page.should have_content("Custom title")
    page.find("ul.nav").should have_link("Custom title")
  end

  scenario "should not display in menu, if feature isn't switched on" do
    within "#new_page" do
      fill_in I18n.t('projects.pages.title'), with: "Custom title"
      fill_in I18n.t('projects.pages.body'), with: "Custom body"
      fill_in I18n.t('projects.pages.permalink'), with: "page1"
    end

    click_button I18n.t('projects.pages.submit')
    visit "#{project_url(conference.domain)}/page1"

    page.should have_content("Custom body")
    page.should have_content("Custom title")
    page.find("ul.nav").should_not have_link("Custom title")
  end
end

