require 'spec_helper'

describe "Application Pages" do

  before { visit root_path }

  subject { page }

  describe "navbar" do

    it "should have the right links" do
      page.should have_link("Cal Poly Men's Water Polo", href: root_path)
      page.should have_link("Schedule", href: '#')
      page.should have_link("Roster", href: '#')
      page.should have_link("Administrativa", href: signin_path)
    end
  end
end
