require 'spec_helper'
include SeasonPagesUtilities

describe "Season pages" do
  let(:admin) { FactoryGirl.create(:admin) } #auth checks in authorization_pages spec

  subject { page }

  describe "#new/#create" do
    before do
      valid_sign_in admin
      visit new_season_path
    end

    it { should show_new_season_page }

    describe "with valid information" do

      it "should create a new season" do
        expect { valid_create_new_season }.to change(Season, :count).by(1)
      end
    end

    describe "with invalid information" do
      before { valid_create_new_season } #season.year must be unique

      it "should not create a new season" do
        expect { valid_create_new_season }.not_to change(Season, :count)
      end

      it "should tell the user about the error" do
        valid_create_new_season
        page.should have_selector('div#error_explanation')
        page.should have_content('Year has already been taken')
      end
    end
  end
end
