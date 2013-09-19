require 'spec_helper'
include TournamentPagesUtilities
include SessionPagesUtilities

describe "Tournament pages" do
  let(:admin) { FactoryGirl.create(:admin) } #auth checks in authorization_pages spec

  subject { page }

  describe "#new/#create" do
    before do
      valid_sign_in admin
      visit new_tournament_path
    end

    it { should show_new_tournament_page }

    describe "with valid information" do
      let(:tournament_data) { FactoryGirl.build(:tournament, season: Season.current_season) }


      it "should create a new tournament" do
        expect { valid_create_tournament(tournament_data) }.to change(Tournament, :count).by(1)
      end
    end

    describe "with invalid information" do

      it "should not create a new tournament" do
        expect { invalid_create_tournament }.not_to change(Tournament, :count)
      end

      it "should tell the user about the error" do
        invalid_create_tournament
        page.should have_selector('div#error_explanation')
        # page.should have_content("Season can't be blank")
        page.should have_content("Location can't be blank")
      end
    end
  end
end