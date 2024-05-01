require 'rails_helper'

RSpec.describe('Delete post', type: :system, js: true) do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user:) }

  before do
    login_as(user)
    visit(dashboard_posts_path)
  end

  context('from dashboard posts page') do
    it('deletes post') do
      dropdown_button = find("button[id='post_#{post.id}_controls']")
      dropdown_button.click

      expect(page).to have_selector("#post_#{post.id}_menu")

      within("#post_#{post.id}_menu") do
        click_on('Delete')
      end

      expect(page).to have_content('Are you sure you want to delete this post?')

      within('dialog') do
        find("button[value='confirm']").click
      end

      expect(page).to have_content('Post was successfully deleted.')
      expect(page).not_to have_content(post.title)
    end
  end

  context('from edit page') do
    it('deletes post') do
      click_on(post.title)
      expect(page).to have_content('Edit post')

      click_on('Delete post')

      expect(page).to have_content('Are you sure you want to delete this post?')

      within('dialog') do
        find("button[value='confirm']").click
      end

      expect(page).to have_content('Post was successfully deleted.')
      expect(page).not_to have_content(post.title)
    end
  end
end
