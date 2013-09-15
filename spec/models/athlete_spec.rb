require 'spec_helper'

describe Athlete do
  let(:athlete) { FactoryGirl.build(:athlete) }

  subject { athlete }

  it { should be_valid }

  describe "Basic Functionalities" do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email) }
    it { should respond_to(:posts) }
    it { should respond_to(:name) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:year_in_school) }
    it { should respond_to(:phone_number) }
    it { should respond_to(:admin?) }
    it { should respond_to(:seasons) }
    it { should respond_to(:team_rosters) }
    it { should respond_to(:tournaments) }
    it { should respond_to(:travel_rosters) }
  end

  describe "validations" do
    describe "with missing first name" do
      before { athlete.first_name = " " }
      it { should_not be_valid }
    end

    describe "with missing last name" do
      before { athlete.last_name = " " }
      it { should_not be_valid }
    end

    describe "with missing email" do
      before { athlete.email = " " }
      it { should_not be_valid }
    end

    describe "with missing year in school" do
      before { athlete.year_in_school = nil }
      it { should_not be_valid }
    end

    describe "with missing phone number" do
      before { athlete.phone_number = " " }
      it { should_not be_valid }
    end

    describe "password validations" do
      describe "with missing password" do
        # password digested on build, need a new athlete which has never had
        # a matching password and confirmation
        let(:missing_password) { FactoryGirl.build(:athlete, password: "") }

        specify { missing_password.should_not be_valid }
      end

      describe "with missing password_confirmation" do
        before { athlete.password_confirmation = " " }

        it { should_not be_valid }
      end

      describe "with mismatched password_confirmation" do
        before { athlete.password_confirmation = "mismatch" }
        it { should_not be_valid }
      end
    end

    describe "#authenticate validations" do
      let(:saved_athlete) { FactoryGirl.create(:athlete) }

      describe "with correct password" do
        let(:found_athlete) do
          Athlete.find(saved_athlete.id).authenticate(saved_athlete.password)
        end

        specify { found_athlete.should == saved_athlete }
      end

      describe "with incorrect password" do
        let(:found_athlete) do
          Athlete.find(saved_athlete.id).authenticate("mismatch")
        end

        specify { found_athlete.should == false }
      end
    end

    describe "#name validations" do
      before { athlete.name = "Samuel Jackson" }

      it "should update the first and last name appropriately" do
        athlete.first_name.should == "Samuel"
        athlete.last_name.should == "Jackson"
      end

      specify "#name should return the name of the athlete" do
        athlete.name.should == "Samuel Jackson"
      end

      describe "#name?" do
        it "should return true if given the correct name" do
          athlete.name?("Samuel Jackson").should be_true
        end

        it "should return false if given the incorrect name" do
          athlete.name?("Hillary Clinton").should be_false
        end
      end
    end

    describe "email is unique" do
      let(:unique_athlete) { FactoryGirl.build(:athlete, email: "ex@example.com")}
      let(:duplicate_athlete) { FactoryGirl.build(:athlete, email: "ex@example.com", first_name:
                                                  "Danny", last_name: "Trejo") }
      before { unique_athlete.save }

      it "should invalidate an athlete with a duplicate email" do
        duplicate_athlete.should_not be_valid
      end

      it "should raise an error when an non-unique email is saved to the db" do
        duplicate_athlete.save.should == false
      end
    end

    describe "when capital letters are present in email" do
      let(:uppercase_email) { FactoryGirl.build(:athlete, email: "SoMeCaPiTaLs@Example.CoM") }
      before { uppercase_email.save }

      it "should downcase! email when saving to the db" do
        Athlete.find_by(email: uppercase_email.email).should == uppercase_email
      end
    end

    describe "remember token validations" do
      let(:new_athlete) { FactoryGirl.build(:athlete) }

      it "should not have a remember token before being saved" do
        new_athlete.remember_token.should be_blank
      end

      it "should have a remember token after being saved to the db" do
        new_athlete.save!
        new_athlete.remember_token.should_not be_blank
      end
    end
  end

  describe "Posts" do

    it "should have no posts by default" do
      athlete.posts.should be_empty
    end

    describe "#posts" do
      let!(:post1) { FactoryGirl.create(:post, author: athlete) }
      let!(:post2) { FactoryGirl.create(:post, author: athlete) }
      let!(:post3) { FactoryGirl.create(:post, author: athlete) }
      let(:posts) { [post1, post2, post3] }

      specify "Athlete#posts should return a list of the athlete's posts" do
        posts.each do |post|
          athlete.posts.should include(post)
        end
      end
    end
  end

  describe "seasons and team_rosters" do
    it "should have no seasons by default" do
      athlete.seasons.should be_empty
    end

    it "should have no team_rosters by default" do
      athlete.team_rosters.should be_empty
    end

    describe "after creating some seasons and team rosters" do
      let!(:season2013) { FactoryGirl.create(:season, year: 2013) }
      let!(:season2014) { FactoryGirl.create(:season, year: 2014) }
      let!(:season2015) { FactoryGirl.create(:season, year: 2015) }
      let!(:seasons) { [season2013, season2014, season2015] }
      let!(:team_roster1) { FactoryGirl.create(:team_roster, season: season2013, athlete: athlete) }
      let!(:team_roster2) { FactoryGirl.create(:team_roster, season: season2014, athlete: athlete) }
      let!(:team_roster3) { FactoryGirl.create(:team_roster, season: season2015, athlete: athlete) }
      let!(:team_rosters) { [team_roster1, team_roster2, team_roster3] }

      specify "athlete#seasons should return a list of the athlete's seasons" do
        seasons.each do |season|
          athlete.seasons.should include(season)
        end
      end

      specify "athlete#team_rosters should return a list of the athlete's team_rosters" do
        team_rosters.each do |roster|
          athlete.team_rosters.should include(roster)
        end
      end
    end
  end

  describe "tournaments and travel_rosters" do
    it "should have no tournaments by default" do
      athlete.tournaments.should be_empty
    end

    it "should have no travel_rosters by default" do
      athlete.travel_rosters.should be_empty
    end

    describe "after creating some tournaments and travel rosters" do
      let!(:tournament1) { FactoryGirl.create(:tournament) }
      let!(:tournament2) { FactoryGirl.create(:tournament) }
      let!(:tournament3) { FactoryGirl.create(:tournament) }
      let!(:tournaments) { [tournament1, tournament2, tournament3] }
      let!(:travel_roster1) { FactoryGirl.create(:travel_roster, tournament: tournament1,
                                                 athlete: athlete) }
      let!(:travel_roster2) { FactoryGirl.create(:travel_roster, tournament: tournament2,
                                                 athlete: athlete) }
      let!(:travel_roster3) { FactoryGirl.create(:travel_roster, tournament: tournament3,
                                                 athlete: athlete) }
      let!(:travel_rosters) { [travel_roster1, travel_roster2, travel_roster3] }

      specify "athlete#tournaments should return a list of the athlete's tournaments" do
        tournaments.each do |tournament|
          athlete.tournaments.should include(tournament)
        end
      end

      specify "athlete#travel_rosters should return a list of the athlete's travel_rosters" do
        travel_rosters.each do |roster|
          athlete.travel_rosters.should include(roster)
        end
      end
    end
  end
end
