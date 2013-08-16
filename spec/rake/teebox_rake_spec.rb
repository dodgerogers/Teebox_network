require 'spec_helper'
require 'rake'
TeeboxNetwork::Application.load_tasks

describe "rank_users" do
  it "should rank the users" do
      Rake::Task['rank_users'].invoke
  end
end

describe "delete_capybara" do
  it "deletes tmp capybara files" do
      Rake::Task['delete_capybara'].invoke
  end
end

describe "delete_capybara" do
  it "deletes tmp capybara files" do
      Rake::Task['generate_report'].invoke
  end
end