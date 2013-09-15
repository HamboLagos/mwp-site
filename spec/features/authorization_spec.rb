require 'spec_helper'
include AthletePagesUtilities
include SessionPagesUtilities
include PostPagesUtilities

describe "Authorization specs" do

  describe "Athlete pages" do

    describe "editing profile authorizations" do
      let!(:athlete) { FactoryGirl.create(:athlete, first_name: 'Hillary', last_name: 'Clinton') }
      let!(:admin) { FactoryGirl.create(:admin, first_name: 'Samuel', last_name: 'Jackson') }
      let!(:other) { FactoryGirl.create(:athlete) }

      describe "editing own profile" do
        before { visit edit_athlete_path(athlete) }

        describe "without signing in" do

          it "should be prohibited" do
            page.should show_posts_page
          end

          it "should tell the user they must sign in" do
            page.should have_selector('div.alert')
            page.should have_content('You must be signed in to edit your profile')
          end
        end
      end

      describe "editing another athlete's profile" do
        before do
          valid_sign_in athlete
          visit edit_athlete_path(other)
        end

        it "should be prohibited" do
          page.should show_roster_page({signed_in: true}, athlete, admin, other)
        end

        it "should tell the user why" do
          page.should have_selector('div.alert')
          page.should have_content('You are only authorized to edit your own profile')
        end
      end

      describe "admin editing another athlete's profile" do
        before do
          valid_sign_in admin
          visit edit_athlete_path(other)
        end

        it "should be allowed" do
          page.should show_edit_athlete_page
        end

        it "should warn the admin what they are about to do" do
          page.should have_selector('div.alert')
          page.should have_content("You are editing another player's profile")
        end
      end
    end
  end

  describe "Season pages" do
    let!(:athlete) { FactoryGirl.create(:athlete) }

    describe "visiting season#new" do
      before do
        valid_sign_in athlete
        visit new_season_path
      end

      it  "should be prohibited to a non-admin" do
        page.should show_posts_page
        page.should have_selector('div.alert')
        page.should have_content('You must have administrative privelages')
      end
    end

  end
end
