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
end
