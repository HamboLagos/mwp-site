require 'spec_helper'

describe Season do
  let(:season) { FactoryGirl.create(:season) }

  subject { season }

  it { should be_valid }

  describe "Basic Functionalities" do
    it { should respond_to(:year) }
  end

  describe "validations" do
    describe "year must be unique" do
      let(:season) { FactoryGirl.create(:season, year: 2013) }
      let(:season_copy) { FactoryGirl.build(:season, year: 2013) }

      it "should invalidate the non-unique year" do
        season.should be_valid
        season_copy.should_not be_valid
      end
    end
  end
end
