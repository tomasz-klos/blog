require 'rails_helper'

RSpec.describe('Create draft post', type: :system, js: true) do
  let!(:user) { FactoryBot.create(:user) }

  before do
    login_as(user, scope: :user)
    visit(dashboard_posts_path)
  end

  it('creates a draft post') do
    click_on('Write post')

    fill_in('Title', with: 'My first draft post')

    expect(page).to have_field('Title', with: 'My first draft post')
    expect(page).to have_content('Draft')
    expect(page).to have_current_path(edit_dashboard_post_path(Post.last))
  end
end
