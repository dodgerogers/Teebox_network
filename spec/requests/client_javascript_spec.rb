require "spec_helper"
include UsersHelper
include AnswerHelper
include QuestionHelper

describe "javascript testing", js: true do
  describe "GET /activities/notifications in navbar" do
    it "displays 1 notification" do
      visit root_path
      sign_in_user
      click_link "notifications"
      within('#notifications-area') do
        page.should have_content "Loading notifications"
      end
      page.should have_content "Notifications"
      page.has_css?('ul#notifications-area')
      page.has_css?('#notification', count: 1)
    end
  end

  describe "GET points breakdown" do
    it "displays points" do
      visit root_path
      sign_in_user
      find('#user-profile-tour').click_link("200")
      within(".span6") do
        page.should have_content "Points Breakdown"
      end
      within("#points-breakdown") do
        page.has_css?("table")
        page.should have_content "No points yet. Go get stuck in."
      end
    end
  end

  describe "teebox tour" do
    it "starts on click" do
      visit root_path
      within("#footer") do
        click_link "welcome-start-tour"
      end
      page.has_css?('.popover')
    end
  end
end