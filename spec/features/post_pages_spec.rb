require 'spec_helper'

describe "Post pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should show_home_page }

    describe "Announcements" do
      let!(:post1) { FactoryGirl.create(:post, content: "This is post 1") }
      let!(:post2) { FactoryGirl.create(:post, content: "This is post 2") }
      let!(:post3) { FactoryGirl.create(:post, content: "This is post 3") }
      before { visit root_path }

      it "should show all of the announcements" do
        Post.all.each do |post|
          ap post
        end
        expect(page).to have_selector('li.post', text: post1.content)
        expect(page).to have_selector('li.post', text: post2.content)
        expect(page).to have_selector('li.post', text: post3.content)

        expect(page).to have_selector('p.pull-right', text: post1.author.name)
        expect(page).to have_selector('p.pull-right', text: post2.author.name)
        expect(page).to have_selector('p.pull-right', text: post3.author.name)

        expect(page).to have_selector('p.pull-right',
                                      text: time_in_words(post1.created_at))
        expect(page).to have_selector('p.pull-right',
                                      text: time_in_words(post2.created_at))
        expect(page).to have_selector('p.pull-right',
                                      text: time_in_words(post3.created_at))
      end
    end
  end
end
