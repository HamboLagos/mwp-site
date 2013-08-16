require 'spec_helper'
include AthletePagesUtilities

describe "Athlete Pages" do

  subject { page }

  describe "Sign up (#new and #create)" do
    let(:athlete) { FactoryGirl.build(:athlete) }
    before { visit signup_path }

    it { should show_signup_page }

    describe "with invalid information" do

      it "should not create a new Athlete" do
        expect { invalid_sign_up }.not_to change(Athlete, :count)
      end

      it "should alert the user of the error(s)" do
        invalid_sign_up
        page.should have_selector("div#error_explanation")
      end

      describe "after visiting another page" do
        before { invalid_sign_up }

        it "should remove the error messages" do
          click_link "Cal Poly Men's Water Polo"
          page.should_not have_selector('div#error_explanation')
        end
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

      describe "navigating to another page" do
        before { valid_sign_up(athlete) }

        it "should remove the welcome notice" do
          click_link "Cal Poly Men's Water Polo"

          page.should_not have_content('Welcome')
        end
      end
    end
  end

  describe "Editing athlete info (#edit and #update)" do
    let(:athlete) { FactoryGirl.create(:athlete, first_name: "Danny", last_name: "Trejo") }
    before { visit edit_athlete_path(athlete) }

    it { should show_edit_athlete_page(athlete) }

    describe "with invalid information" do
      before { invalid_edit }

      it "should stay on the edit page" do
        page.should show_edit_athlete_page(athlete)
      end

      it "should tell the user about the errors" do
        page.should have_selector("div#error_explanation")
      end
    end

    describe "with valid information" do
      let(:diff_info) { FactoryGirl.build(:athlete, first_name: "Samuel", last_name: "Jackson") }

      specify "Editing the athlete's info should push the changes to the db" do
        edit_athlete_info(diff_info)
        athlete.reload.should == diff_info
      end

      it "should show changes pending approval message" do
        edit_athlete_info(diff_info)
        page.should have_content('changes')
        page.should have_content('pending')
        page.should have_content('approval')
      end

      describe "navitating to another page" do
        before { edit_athlete_info(athlete) }

        it "should remove the pending approval message" do
          click_link "Cal Poly Men's Water Polo"

          page.should_not have_content('pending')
        end
      end
    end
  end
end
