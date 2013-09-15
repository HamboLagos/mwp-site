require 'spec_helper'

describe TeamRoster do
  let(:team_roster) { FactoryGirl.create(:team_roster) }

  subject { team_roster }

  it { should be_valid }

  describe "Basic functionalitities" do
    it { should respond_to(:athlete) }
    it { should respond_to(:season) }
  end
end
