require 'rails_helper'

RSpec.describe 'Delete post', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user:) }

  before do
    login_as(user)
    visit(dashboard_posts_path)
  end

  shared_examples('deleting a post') do |delete_button|
    it do
      click_on(delete_button)

      within('dialog') do
        find("button[value='confirm']").click
      end

      expect(page).to have_content('Post was successfully deleted.')
      expect(page).not_to have_content(post.title)
    end
  end

  context('from dashboard posts page') do
    before do
      dropdown_button = find("button[name='post_#{post.id}_controls']")
      dropdown_button.click
    end

    it_behaves_like('deleting a post', 'Delete')
  end

  context('from edit page') do
    before do
      click_on(post.title)
      expect(page).to have_content('Edit post')
    end

    it_behaves_like('deleting a post', 'Delete post')
  end
end
