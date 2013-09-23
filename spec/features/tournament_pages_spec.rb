require 'spec_helper'
include TournamentPagesUtilities
include SessionPagesUtilities

describe "Tournament pages" do
  let(:admin) { FactoryGirl.create(:admin) } #auth checks in authorization_pages spec

  before { valid_sign_in admin }

  subject { page }

  describe "#new/#create" do
    before { visit new_tournament_path }

    it { should show_new_tournament_page }

    describe "with valid information" do
      let(:season) { FactoryGirl.create(:season) }
      let(:tournament_data) { FactoryGirl.build(:tournament_no_associations) }
      let(:athletes) { [
        FactoryGirl.build(:athlete_no_associations, first_name: "Hillary", last_name: "Clinton"),
        FactoryGirl.build(:athlete_no_associations, first_name: "Samuel", last_name: "Jackson"),
        FactoryGirl.build(:athlete_no_associations, first_name: "Danny", last_name: "Trejo")
      ] }

      before do
        tournament_data.season = season
        athletes.each do |athlete|
          athlete.seasons << season
          athlete.save!
        end
        tournament_data.athletes << athletes
      end

      it "should create a new tournament" do
        expect { valid_create_tournament(tournament_data) }.to change(Tournament, :count).by(1)
        page.should show_tournament_page(Tournament.last)
        Tournament.last.athletes.sort { |a,b| a.first_name <=> b.last_name }.should == athletes
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

  describe "#show" do
    let(:tournament) { FactoryGirl.create(:tournament) }
    let(:driver) { FactoryGirl.create(:athlete) }
    let(:passenger) { FactoryGirl.create(:athlete) }

    before do
      tournament.athletes << driver
      tournament.athletes << passenger
      tournament.travel_rosters.find_by(athlete_id: driver).update!(driver: true)
      tournament.travel_rosters.find_by(athlete_id: passenger).update!(driver: false,
                                                                       car: driver.id)
      visit tournament_path(tournament)
    end

    it "should show the show tournament page" do
      page.should show_tournament_page(tournament)
    end
  end

  describe "#index" do
    let(:tournaments)  { [] }
    let!(:season) { FactoryGirl.create(:season) } # need a season for Season.current_season

    before do
      3.times do
        tournament = FactoryGirl.build(:tournament_no_associations)
        tournament.season = Season.current_season
        tournament.save!
        tournaments << tournament
      end
      visit tournaments_path
    end

    it "should show the tournament listings" do
      page.should show_tournaments_page(tournaments)
    end
  end
end
