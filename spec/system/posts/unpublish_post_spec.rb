require 'rails_helper'

RSpec.describe('Unpublish post', type: :system, js: true) do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user:, state: :published) }

  before do
    login_as(user)
  end

  context('from dashboard posts page') do
    before do
      visit(dashboard_posts_path)
    end

    it('unpublishes post') do
      published_posts_button = find("button[id='published-posts']")
      published_posts_button.click

      expect(page).to have_content(post.title)

      dropdown_button = find("button[id='post_#{post.id}_controls']")
      dropdown_button.click

      within("#post_#{post.id}_menu") do
        click_on('Unpublish')
      end

      expect(page).to have_content('Are you sure you want to unpublish this post?')

      within('dialog') do
        find("button[value='confirm']").click
      end

      published_posts_button = find("button[id='published-posts']")
      published_posts_button.click

      expect(page).to have_content('Post was successfully unpublished.')
      expect(page).to have_content(post.title)
    end
  end

  context('from edit page') do
    before do
      visit(edit_dashboard_post_path(post))
    end

    it('unpublishes post') do
      expect(page).to have_content('Edit post')

      click_on('Unpublish post')

      expect(page).to have_content('Are you sure you want to unpublish this post?')

      within('dialog') do
        find("button[value='confirm']").click
      end

      expect(page).to have_content('Post was successfully unpublished.')
    end
  end
end
