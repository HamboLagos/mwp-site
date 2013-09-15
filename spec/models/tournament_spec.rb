require 'spec_helper'

describe Tournament do
  let(:tournament) { FactoryGirl.create(:tournament) }

  subject { tournament }

  it { should be_valid }

  describe "basic functionalities" do
    it { should respond_to(:start_date) }
    it { should respond_to(:end_date) }
    it { should respond_to(:season) }
    it { should respond_to(:athletes) }
    it { should respond_to(:travel_rosters) }
  end

  describe "validations" do

    describe "with missing season" do
      before { tournament.season = nil }

      it "should not be valid" do
        tournament.should_not be_valid
      end
    end

    describe "with missing start_date" do
      before { tournament.start_date = nil }

      it "should not be valid" do
        tournament.should_not be_valid
      end
    end

    describe "with missing end date" do
      before { tournament.end_date = nil }

      it "should not be valid" do
        tournament.should_not be_valid
      end
    end

    describe "with non-unique start dates" do
      let!(:tournament_copy) { FactoryGirl.build(:tournament, start_date: tournament.start_date) }

      it "should invalidate the non-unique starting date tournament" do
        tournament.should be_valid
        tournament_copy.should_not be_valid
      end
    end

    describe "with non-unique end dates" do
      let!(:tournament_copy) { FactoryGirl.build(:tournament, end_date: tournament.end_date) }

      it "should invalidate the non-unique starting date tournament" do
        tournament.should be_valid
        tournament_copy.should_not be_valid
      end
    end
  end
end
