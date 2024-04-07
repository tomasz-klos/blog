require 'rails_helper'

RSpec.describe 'Create post', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
    visit(new_post_path)
  end

  context('with valid data') do
    it('creates a post') do
      fill_in('Title', with: 'My first post')
      trix_editor = find_trix_editor('post_content_trix_input_post')
      trix_editor.click.set('This is the content of my first post' * 20)

      click_on('Create Post')

      expect(page).to have_content('Post was successfully created.')
    end
  end

  context('with invalid data') do
    it('does not create a post') do
      fill_in('Title', with: '')
      trix_editor = find_trix_editor('post_content_trix_input_post')
      trix_editor.click.set('')

      click_on('Create Post')

      expect(page).to have_content("can't be blank")
      expect(page).to have_content('is too short (minimum is 5 characters)')
      expect(page).to have_content('is too short (minimum is 100 characters)')
    end
  end
end
