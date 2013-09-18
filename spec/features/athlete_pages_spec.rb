require 'spec_helper'
include AthletePagesUtilities
include SessionPagesUtilities

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

      describe "the default poperties" do
        before { valid_sign_up(athlete) }

        it "should not be admin" do
          athlete.should_not be_admin
        end

        it "should not be approved" do
          athlete.should be_pending_approval
        end
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
    before do
      valid_sign_in athlete
      visit edit_athlete_path(athlete)
    end

    it { should show_edit_athlete_page }

    describe "with invalid info" do
      before { invalid_edit(athlete) }

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

      describe "navigating to another page" do
        before { edit_athlete_info(athlete) }

        it "should remove the pending approval message" do
          click_link "Cal Poly Men's Water Polo"

          page.should_not have_content('pending')
        end
      end
    end

    describe "changing the athlete's password" do
      before { click_link 'Change Password' }

      it { should show_change_password_page }

      describe "with an error in the change password form" do
        before { invalid_password_change }

        it "should stay on the same page" do
          page.should show_change_password_page
        end

        it "should tell the user about the errors" do
          page.should have_selector("div#error_explanation")
        end
      end

      describe "entering valid information into the form" do
        before { valid_password_change(athlete) }

        it "should alert the user of success" do
          page.should have_content('successfully changed your password')
        end

        it "should redirect back to the edit profile page" do
          page.should show_edit_athlete_page(athlete)
        end

        it "should push the changes to the db" do
          new_password = athlete.password.reverse
          athlete.reload.authenticate(new_password).should be_true
        end
      end
    end
  end

  describe "Roster Page (index)" do
    let!(:danny) { FactoryGirl.create(:athlete, first_name: "Danny", last_name: "Trejo") }
    let!(:sammy) { FactoryGirl.create(:athlete, first_name: "Samuel", last_name: "Jackson") }
    let!(:hillary) { FactoryGirl.create(:athlete, first_name: "Hillary", last_name: "Clinton") }


    describe "to a non-signed-in user" do

      before { visit roster_path }

      it "should show basic roster information" do
        page.should show_roster_page(danny, sammy, hillary)
      end

      it "should not show private information" do
        page.should_not have_content(danny.email)
        page.should_not have_content(sammy.email)
        page.should_not have_content(hillary.email)
        page.should_not have_content(danny.phone_number)
        page.should_not have_content(sammy.phone_number)
        page.should_not have_content(hillary.phone_number)
      end
    end

    describe "after signing in" do
      before { valid_sign_in(danny)}

      it "should show both public and private data to fellow athletes" do
        visit roster_path
        page.should show_roster_page({ signed_in: true }, danny, sammy, hillary)
      end
    end
  end
end
