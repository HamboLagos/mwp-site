require 'spec_helper'

describe TravelRoster do
  let(:travel_roster) { FactoryGirl.create(:travel_roster) }

  subject { travel_roster }

  it { should be_valid }

  describe "Basic functionalitities" do
    it { should respond_to(:athlete) }
    it { should respond_to(:tournament) }
  end
end
