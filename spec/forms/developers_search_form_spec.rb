require 'rails_helper'
RSpec.describe DevelopersSearchForm do
  describe '#search' do
    before do
      language_code_en = create :language, code: 'en'
      create :developer,
             email: 'mrtest@gmail.com',
             programming_languages: [create(:programming_language, name: 'PHP')],
             languages: [language_code_en]
      create :developer,
             email: 'tuan.dao@tech.reapra.sg',
             programming_languages: [create(:programming_language, name: 'Ruby')],
             languages: [language_code_en]
    end

    context 'with no params' do
      it 'shows empty lít' do
        form = DevelopersSearchForm.new
        expect(form.search.size).to eq(0)
      end
    end

    context 'with programming_language' do
      it 'shows developer with programming language ' do
        form = DevelopersSearchForm.new(prog_lang: 'PHP')
        expect(form.search.size).to eq(1)
      end

      it 'shows no data' do
        form = DevelopersSearchForm.new(prog_lang: 'Java')
        expect(form.search.size).to eq(0)
      end
    end

    context 'with developer email' do
      it 'shows developer with email' do
        form = DevelopersSearchForm.new(email: 'mrtest@gmail.com')
        expect(form.search.size).to eq(1)
      end

      it 'shows no data' do
        form = DevelopersSearchForm.new(email: '123@gmail.com')
        expect(form.search.size).to eq(0)
      end
    end

    context 'with language' do
      it 'shows developers use english' do
        form = DevelopersSearchForm.new(language_code: 'en')
        expect(form.search.size).to eq(2)
      end

      it 'shows no data' do
        form = DevelopersSearchForm.new(language_code: 'cn')
        expect(form.search.size).to eq(0)
      end
    end

    context 'with language and programming language' do
      it 'shows Ruby developers use english' do
        form = DevelopersSearchForm.new(prog_lang: 'Ruby', language_code: 'en')
        expect(form.search.size).to eq(1)
      end

      it 'shows no data' do
        form = DevelopersSearchForm.new(prog_lang: 'Ruby', language_code: 'cn')
        expect(form.search.size).to eq(0)
      end
    end
  end
end
