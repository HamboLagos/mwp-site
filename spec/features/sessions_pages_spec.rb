require 'spec_helper'
include SessionPagesUtilities

describe "Sessions" do

  subject { page }

  describe "/signin page" do
    before { visit signin_path }

    it { should show_signin_page }

    describe "with invalid information" do
      before { invalid_sign_in }

      it "should stay on the same page" do
        page.should show_signin_page
      end

      it "should alert the user of the error(s)" do
        page.should have_selector("div#error_explanation")
      end

      describe "after visiting another page" do

        it "should remove the error messages" do
          click_link "Cal Poly Men's Water Polo"
          page.should_not have_selector("div#error_explanation")
        end
      end
    end

    describe "with valid information" do
      let(:athlete) { FactoryGirl.create(:athlete) }
      before { valid_sign_in athlete }

      it "should redirect to the athlete roster page" do
        page.should show_roster_page
      end

      it "should change the links on the navbar" do
        page.should have_link("Edit Profile", href: edit_athlete_path(athlete))
        page.should have_link("Sign Out", href: signout_path)
      end

      describe "followed by signout" do
        before { click_link 'Sign Out' }

        it "should sign the user out" do
          page.should_not have_link("Edit Profile", href: '#')
          page.should_not have_link("Sign Out", href: signout_path)
        end
      end
    end
  end
end
