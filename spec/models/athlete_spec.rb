require 'spec_helper'

describe Athlete do
  let(:athlete) { FactoryGirl.build(:athlete) }

  subject { athlete }

  it { should be_valid }

  describe "Basic Functionalities" do
    it { should respond_to(:first) }
    it { should respond_to(:last) }
    it { should respond_to(:year) }
    it { should respond_to(:email) }
    it { should respond_to(:posts) }
    it { should respond_to(:name) }
    it { should respond_to(:authenticate) }
  end

  describe "validations" do
    describe "with missing first name" do
      before { athlete.first = " " }
      it { should_not be_valid }
    end

    describe "with missing last name" do
      before { athlete.last = " " }
      it { should_not be_valid }
    end

    describe "with missing year" do
      before { athlete.year = nil }
      it { should_not be_valid }
    end

    describe "with missing email" do
      before { athlete.email = " " }
      it { should_not be_valid }
    end

    describe "password validations" do
      describe "with missing password" do
        let(:joe) { FactoryGirl.build(:athlete, password: "") }

        specify { joe.should_not be_valid }
      end

      describe "with mismatched password_confirmation" do
        before { athlete.password_confirmation = "mismatch" }
        it { should_not be_valid }
      end
    end

    describe "#authenticate validations" do
      before { athlete.save }

      describe "with correct password" do
        let(:found_athlete) do
          Athlete.find_by_email(athlete.email).authenticate(athlete.password)
        end

        specify { found_athlete.should == athlete }
      end

      describe "with incorrect password" do
        let(:found_athlete) do
          Athlete.find_by_email(athlete.email).authenticate("mismatch")
        end

        specify { found_athlete.should == false }
      end
    end

    describe "#name validations" do
      before do
        athlete.name = "Samuel Jackson"
      end

      it "should update the first and last name appropriately" do
        athlete.first.should == "Samuel"
        athlete.last.should == "Jackson"
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

      specify "should return a list of the athlete's posts" do
        posts.each do |post|
          athlete.posts.should include(post)
        end
      end
    end
  end
end
