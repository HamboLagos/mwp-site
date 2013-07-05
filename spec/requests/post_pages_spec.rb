require 'spec_helper'

describe "Post pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should show_home_page }
  end
end
