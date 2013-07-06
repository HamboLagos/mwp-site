require 'spec_helper'

describe Post do

  let(:post) { FactoryGirl.create(:post) }

  subject { post }

  describe "Basic Functionalities" do
    it { should respond_to(:title) }
    it { should respond_to(:content) }
    it { should respond_to(:author) }
  end

  describe "validations" do
    describe "with missing title" do
      before { post.title = " " }
      it { should_not be_valid }
    end

    describe "with missing content" do
      before { post.content = " " }
      it { should_not be_valid }
    end

    describe "with missing author" do
      before { post.author = nil }
      it { should_not be_valid }
    end

    describe "#author validations" do
      let(:author) { FactoryGirl.create(:athlete) }
      before { post.author = author }

      describe "#author should return the author" do
        specify { post.author.should == author }
      end

      describe "#author? should return" do

        specify "true if given the author" do
          post.author?(author).should be_true
        end

        specify "false if given the incorrect author" do
          post.author?(FactoryGirl.create(:athlete)).should be_false
        end
      end
    end
  end
end
