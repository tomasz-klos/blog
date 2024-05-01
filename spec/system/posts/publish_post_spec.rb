require 'rails_helper'

RSpec.describe('Publish post', type: :system, js: true) do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user:) }

  before do
    login_as(user)
    visit(dashboard_posts_path)
  end

  context('from dashboard posts page') do
    it('publishes post') do
      dropdown_button = find("button[id='post_#{post.id}_controls']")
      dropdown_button.click

      expect(page).to have_selector("#post_#{post.id}_menu")

      within("#post_#{post.id}_menu") do
        click_on('Publish')
      end

      expect(page).to have_content('Are you sure you want to publish this post?')

      within('dialog') do
        find("button[value='confirm']").click
      end

      expect(page).to have_content('Post was successfully published.')

      published_posts_button = find("button[id='published-posts']")
      published_posts_button.click

      expect(page).to have_content(post.title)
    end
  end

  context('from edit page') do
    it('publishes post') do
      click_on(post.title)

      expect(page).to have_content('Edit post')

      click_on('Publish post')

      expect(page).to have_content('Are you sure you want to publish this post?')

      within('dialog') do
        find("button[value='confirm']").click
      end

      expect(page).to have_content('Post was successfully published.')
    end
  end

  context('with invalid data') do
    before do
      post.update(state: :published)
      post_with_same_title = FactoryBot.build(:post, user:, title: post.title)
      post_with_same_title.save(validate: false)

      visit(edit_dashboard_post_path(post_with_same_title))
    end

    it('title has been taken') do
      click_on('Publish post')

      expect(page).to have_content('Are you sure you want to publish this post?')

      within('dialog') do
        find("button[value='confirm']").click
      end

      expect(page).to have_content('Post could not be published, because: Title has already been taken')
    end
  end
end
