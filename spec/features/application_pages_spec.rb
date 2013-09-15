require 'spec_helper'
include SessionPagesUtilities

describe "Application Pages" do

  before { visit root_path }

  subject { page }

  describe "navbar" do

    it "should have the correct static links" do
      page.should have_link("Cal Poly Men's Water Polo", href: root_path)
      page.should have_link("Schedule", href: '#')
      page.should have_link("Roster", href: roster_path)
      page.should have_link("Administrativa", href: '#')
    end

    describe "when not signed in" do

      it "administrative tab should only have the link to sign in" do
        click_link("Administrativa")
        page.should have_link("Sign In", href: signin_path)
      end
    end

    describe "when signed in" do
      let(:athlete) { FactoryGirl.create(:athlete) }
      before { valid_sign_in athlete }

      specify "administrative tab should show proper links" do
        click_link("Administrativa")
        page.should have_link("Edit Profile", href: edit_athlete_path(athlete))
        page.should have_link("Sign Out", href: signout_path)
      end

      describe "as admin" do
        let(:admin) { FactoryGirl.create(:admin) }
        before { valid_sign_in admin }

        specify "administrative tab should show proper links" do
          click_link("Administrativa")
          page.should have_link("Edit Profile", href: edit_athlete_path(admin))
          page.should have_link("Create New Season", href: new_season_path)
          page.should have_link("Sign Out", href: signout_path)
        end
      end
    end
  end
end
