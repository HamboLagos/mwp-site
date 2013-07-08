module PostPagesUtilities

  RSpec::Matchers.define :show_posts_page do
    match do |page|
      page.should have_title("CP Men's Water Polo")
      page.should have_selector('h1', text: "Announcements")
    end
  end

end
