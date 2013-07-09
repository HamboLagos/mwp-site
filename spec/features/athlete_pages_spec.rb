require 'spec_helper'
include AthletePagesUtilities

describe "Athlete Pages" do

  subject { page }

  describe "Sign up (#new and #create)" do
    let(:athlete) { FactoryGirl.build(:athlete) }
    before { visit new_athlete_path }

    it { should show_new_athlete_page }

    describe "with invalid information" do

      it "should not create a new Athlete" do
        expect { click_button "Join" }.not_to change(Athlete, :count)
      end

      it "should alert the user of the error(s)" do
        click_button "Join"
        page.should have_selector("div#error_explanation")
      end
    end

    describe "with valid information" do

      it "should create a new athlete" do
        expect { valid_sign_up(athlete) }.to change(Athlete, :count).by(1)
      end

      it "should welcome the new athlete" do
        valid_sign_up(athlete)
        page.should have_content('Welcome')
        page.should have_content('pending')
        page.should have_content('approval')
      end
    end
  end
end
