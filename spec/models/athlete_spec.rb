require 'spec_helper'

describe Athlete do
  let(:athlete) { FactoryGirl.create(:athlete) }

  subject { athlete }

  it { should be_valid }

  describe "Basic Functionalities" do
    it { should respond_to(:first) }
    it { should respond_to(:last) }
    it { should respond_to(:year) }
    it { should respond_to(:email) }
    it { should respond_to(:posts) }
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
  end

  describe "Posts" do
    # test for array of posts returned by .posts
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
