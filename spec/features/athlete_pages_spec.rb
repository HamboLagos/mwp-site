require 'spec_helper'

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
        page.should have_selector("div.error")
      end
    end

    describe "with valid information" do
      it "should create a new user" do
        fill_in 'First name',       with: athlete.first
        fill_in 'Last name',        with: athlete.last
        fill_in 'email',            with: athlete.email
        # choose 'First' # year in school
        fill_in 'Password',         with: athlete.password
        fill_in 'Confirm Password', with: athlete.password

        expect { click_link "Join" }.to change(Athlete, :count).by(1)
      end
    end
  end
end
