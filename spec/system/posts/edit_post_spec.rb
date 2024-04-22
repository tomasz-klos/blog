require 'rails_helper'

RSpec.describe 'Edit post', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
  end

  context('draft post') do
    before do
      post = FactoryBot.create(:post, user:)

      visit(dashboard_posts_path)

      dropdown_button = find("button[name='post_#{post.id}_controls']")
      dropdown_button.click

      click_on('Edit')
    end

    it do
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
    before do
      post = FactoryBot.create(:post, user:, state: :published)

      visit(dashboard_posts_path)
      find("button[id='published-posts']").click

      click_on(post.title)
    end

    it do
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
