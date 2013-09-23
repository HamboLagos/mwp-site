require 'spec_helper'
include AthletePagesUtilities
include SessionPagesUtilities
include PostPagesUtilities

describe "Authorization specs" do

  subject { page }

  describe "Post Pages" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:athlete) { FactoryGirl.create(:athlete) }
    let(:posts) { [] }

    before do
      valid_sign_in admin
      3.times do
        posts << FactoryGirl.create(:post, athlete: admin)
      end
      visit root_path
    end

    describe "as admin " do

      it "should have the right admin links" do
        page.should show_posts_page
        posts.each do |post|
          page.should have_link('Edit This Post', href: edit_athlete_post_path(post.athlete, post))
          page.should have_link('Delete This Post',
                                href: athlete_post_path(post.athlete, post))
        end
        page.should have_link('New Post', href: new_athlete_post_path(admin))
      end
    end

    describe "as non-admin" do
      before do
        valid_sign_in athlete
        3.times do
          posts << FactoryGirl.create(:post, athlete: admin)
        end
        visit root_path
      end

      it "should have the right admin links" do
        page.should show_posts_page
        posts.each do |post|
          page.should_not have_link('Edit This Post',
                                    href: edit_athlete_post_path(post.athlete, post))
          page.should_not have_link('Delete This Post',
                                    href: athlete_post_path(post.athlete, post))
        end
        page.should_not have_link('New Post', href: new_athlete_post_path(admin))
      end
    end
  end

  describe "Athlete pages" do

    describe "editing profile authorizations" do
      let!(:athlete) { FactoryGirl.create(:athlete, first_name: 'Hillary', last_name: 'Clinton') }
      let!(:admin) { FactoryGirl.create(:admin, first_name: 'Samuel', last_name: 'Jackson') }
      let!(:other) { FactoryGirl.create(:athlete) }

      before do
        athlete.seasons << Season.current_season
        admin.seasons << Season.current_season
        other.seasons << Season.current_season
      end

      describe "editing own profile" do
        before { visit edit_athlete_path(athlete) }

        describe "without signing in" do

          it "should be prohibited" do
            page.should show_posts_page
          end

          it "should tell the user they must sign in" do
            page.should have_selector('div.alert')
            page.should have_content('You must sign in first')
          end
        end
      end

      describe "editing another athlete's profile" do
        before do
          valid_sign_in athlete
          visit edit_athlete_path(other)
        end

        it "should be prohibited" do
          page.should show_posts_page
        end

        it "should tell the user why" do
          page.should have_selector('div.alert')
          page.should have_content('You are not authorized to perform this action')
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
        page.should have_content('You must be a site admin to access this')
      end
    end
  end

  describe "Tournament pages" do
    let!(:athlete) { FactoryGirl.create(:athlete) }

    describe "visiting tournament#new" do
      before do
        valid_sign_in athlete
        visit new_tournament_path
      end

      it "should be prohibited to a non-admin" do
        page.should show_posts_page
        page.should have_selector('div.alert')
        page.should have_content('You must be a site admin to access this')
      end
    end
  end
end
