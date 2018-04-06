require 'rails_helper'
describe 'Search For Developers With Information' do
  before do
    language_code_en = create :language, code: 'en'
    create :developer, email: 'mrtest@gmail.com', programming_languages: [create(:programming_language, name: 'PHP')], languages: [language_code_en]
    create :developer, email: 'tuan.dao@tech.reapra.sg', programming_languages: [create(:programming_language, name: 'Ruby')], languages: [language_code_en]
  end

  it 'Search with empty params' do
    visit developers_path
    click_on 'Search'
    expect(page).to have_content('No result')
  end

  it 'search with email address' do
    visit developers_path
    fill_in 'developers_search_form_email', with: 'tuan.dao@tech.reapra.sg'
    click_on 'Search'
    expect(page).to have_content('tuan.dao@tech.reapra.sg')
  end

  it 'search with programming language' do
    visit developers_path
    fill_in 'developers_search_form_prog_lang', with: 'Ruby'
    click_on 'Search'
    expect(page).to have_content('tuan.dao@tech.reapra.sg')
  end

  it 'search with language' do
    visit developers_path
    fill_in 'developers_search_form_language_code', with: 'en'
    click_on 'Search'
    expect(page).to have_content('tuan.dao@tech.reapra.sg')
  end

  it 'search with programming language and language' do
    visit developers_path
    fill_in 'developers_search_form_prog_lang', with: 'Ruby'
    fill_in 'developers_search_form_language_code', with: 'en'
    click_on 'Search'
    expect(page).to have_content('tuan.dao@tech.reapra.sg')
  end
end
