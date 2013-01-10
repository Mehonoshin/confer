require 'spec_helper'

describe ProjectsHelper do
  describe "project_url" do
    it "should return link to project" do
      helper.project_link("conf").should include("conf.")
    end
  end
end
