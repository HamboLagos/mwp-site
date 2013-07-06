require 'spec_helper'

describe "Post pages" do

  subject { page }

  describe "#show (Home Page)" do
    before { visit root_path }

    it { should show_home_page }

    describe "new user sidebar" do

      it "should get the attention of a newcomer" do
        page.should have_content("New Here?")
      end

      it "should have the right links" do
        page.should have_link("Join the Team", href: '#')
        page.should have_link("Contact an Officer", href: '#')
        page.should have_link("View Season Schedule", href: '#')
      end
    end

    describe "Announcements" do
      let!(:post1) { FactoryGirl.create(:post, content: "This is post 1") }
      let!(:post2) { FactoryGirl.create(:post, content: "This is post 2") }
      let!(:post3) { FactoryGirl.create(:post, content: "This is post 3") }
      before { visit root_path }

      it "should show all of the announcements" do
        expect(page).to have_selector('li.content', text: post1.content)
        expect(page).to have_selector('li.content', text: post2.content)
        expect(page).to have_selector('li.content', text: post3.content)

        expect(page).to have_selector('small.meta-data',
                                      text: post1.author.name)
        expect(page).to have_selector('small.meta-data',
                                      text: post2.author.name)
        expect(page).to have_selector('small.meta-data',
                                      text: post3.author.name)

        expect(page).to have_selector('small.meta-data', text:
                                      post1.updated_at.strftime(
                                        "posted: %B %d, %Y %H:%M"))
        expect(page).to have_selector('small.meta-data',
                                      post2.updated_at.strftime(
                                        "posted: %B %d, %Y %H:%M"))
        expect(page).to have_selector('small.meta-data',
                                      post3.updated_at.strftime(
                                        "posted: %B %d, %Y %H:%M"))
      end
    end
  end
end
