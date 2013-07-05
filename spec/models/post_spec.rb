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
  end
end
