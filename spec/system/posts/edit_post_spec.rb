require 'rails_helper'

RSpec.describe 'Edit post', type: :system, js: true do
  let!(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
  end

  context('draft post') do
    let!(:post) { FactoryBot.create(:post, user:) }

    before do
      visit(dashboard_posts_path)
    end

    it do
      dropdown_button = find("button[id='post_#{post.id}_controls']")
      dropdown_button.click

      expect(page).to have_selector("#post_#{post.id}_menu")

      within("#post_#{post.id}_menu") do
        click_on('Edit')
      end

      fill_in('Title', with: 'Updated title')
      trix_editor = find_trix_editor("post_content")

      content = 'This is the updated content of my post' * 20
      trix_editor.click.set(content)

      expect(page).to have_content('Saved')

      find("button[id='preview-post']").click

      expect(page).to have_content('Preview post')
      expect(page).to have_content('Updated title')
      expect(page).to have_content(content)
    end
  end

  context('published post') do
    let!(:post) { FactoryBot.create(:post, user:, state: :published) }

    before do
      visit(dashboard_posts_path)
    end

    it do
      find("button[id='published-posts']").click

      click_on(post.title)

      fill_in('Title', with: 'Updated title')
      trix_editor = find_trix_editor("post_content")

      content = 'This is the updated content of my post' * 20
      trix_editor.click.set(content)

      click_on('Update post')

      within('dialog') do
        find("button[value='confirm']").click
      end

      find("button[id='preview-post']").click

      expect(page).to have_content('Preview post')
      expect(page).to have_content('Updated title')
      expect(page).to have_content(content)
    end
  end
end
