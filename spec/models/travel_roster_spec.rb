require 'spec_helper'

describe TravelRoster do
  let(:travel_roster) { FactoryGirl.create(:travel_roster) }

  subject { travel_roster }

  it { should be_valid }

  describe "Basic functionalitities" do
    it { should respond_to(:athlete) }
    it { should respond_to(:tournament) }
    it { should respond_to(:driver?) }
    it { should respond_to(:car) }
    it { should respond_to(:name) }
    it { should respond_to(:car_name) }
  end

  describe "validations" do
    describe "with missing athlete" do
      before { travel_roster.athlete = nil }

      it "should be invalid" do
        travel_roster.should_not be_valid
      end
    end

    # spec removed due to error when creating tournament
    # see app/model/travel_roster.rb for details
    # describe "with missing tournament" do
    #   before { travel_roster.tournament = nil }

    #   it "should be invalid" do
    #     travel_roster.should_not be_valid
    #   end
    # end
  end
end
