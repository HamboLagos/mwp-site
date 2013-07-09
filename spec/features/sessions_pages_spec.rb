require 'spec_helper'
include SessionPagesUtilities

describe "Sessions" do

  subject { page }

  describe "/signin page" do
    before { visit signin_path }

    it { should show_signin_page }

    describe "with invalid information" do

      it "should alert the user of the error(s)" do
        invalid_sign_in
        page.should have_selector("div#error_explanation")
      end

      describe "after visiting another page" do
        before { invalid_sign_in }

        it "should remove the error messages" do
          click_link "Cal Poly Men's Water Polo"
          page.should_not have_selector("div#error_explanation")
        end
      end
    end
  end
end
