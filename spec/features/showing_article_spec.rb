require "rails_helper"

RSpec.feature "Showing Article" do

  before do
    @john = User.create(email: "John@example.com", password: "password")
    @fred = User.create(email: "Fred@example.com", password: "password")
    @article = Article.create(title: "The first article", body: "Body of the first article", user: @john)
  end

  scenario "A non-signed-in user does not see edit or delete links" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_content("Edit Article")
    expect(page).not_to have_content("Delete Article")
  end

  scenario "A signed in user who is not the article owner does not see the edit or delete links" do
    #fred is not the user for article
    login_as(@fred)

    visit "/"

    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_content("Edit Article")
    expect(page).not_to have_content("Delete Article")
  end

  scenario "A signed in owner sees both links" do
    #John is set as the user for article
    login_as(@john)

    visit "/"

    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
  end

  scenario "display body of selected article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
end
