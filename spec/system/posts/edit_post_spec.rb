require 'rails_helper'

RSpec.describe 'Edit post', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user:) }

  before do
    login_as(user)
    visit(posts_path)
  end

  shared_examples('editing a post') do
    it do
      fill_in('Title', with: 'Updated title')
      trix_editor = find_trix_editor("post_content_trix_input_post_#{post.id}")
      trix_editor.click.set('This is the updated content of my post' * 20)

      click_on('Update Post')

      expect(page).to have_content('Post was successfully updated.')
      expect(page).to have_content('Updated title')
    end
  end

  context('from root page') do
    before do
      dropdown_button = find("//button[@name='post_#{post.id}_controls']")
      dropdown_button.click

      click_on('edit')
    end

    it_behaves_like('editing a post')
  end

  context('from show page') do
    before do
      find("//a[@href='/posts/#{post.id}']").click
      expect(page).to have_content(post.title)

      click_on('edit')
      expect(page).to have_content("Edit post #{post.title}")
    end

    it_behaves_like('editing a post')
  end
end
