require 'rails_helper'

RSpec.describe 'Delete post', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user:) }

  before do
    login_as(user)
    visit(posts_path)
  end

  context('from root page') do
    before do
      dropdown_button = find("//button[@name='post_#{post.id}_controls']")
      dropdown_button.click
    end

    it('deletes a post') do
      click_on('delete')

      expect(page).to have_content('Post was successfully deleted.')
      expect(page).not_to have_content(post.title)
    end
  end

  context('from edit page') do
    before do
      visit(posts_path)

      find("//a[@href='/posts/#{post.id}']").click
      expect(page).to have_content(post.title)

      click_on('edit')
      expect(page).to have_content("Edit post #{post.title}")
    end

    it('deletes a post') do
      click_on('Delete')

      expect(page).to have_content('Post was successfully deleted.')
      expect(page).not_to have_content(post.title)
    end
  end
end
