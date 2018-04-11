require 'rails_helper'
require 'spec_helper'
require 'support/shared_context_for_api.rb'

describe 'Api::V1::DevelopersController', type: :request do
  include_context 'api'

  describe 'GET /api/v1/developers' do
    context 'without params' do
      it_behaves_like 'http_status_code_200_with_json'
      let(:expected_response) do
        {
          data: Developer.all.map do |developer|
            {
              id: developer.id.to_s,
              type: 'developers',
              attributes: {
                email: developer.email
              },
              relationships: {
                  languages: {
                    data: developer.languages.map do |language|
                      {
                        id: language.id.to_s,
                        type: 'languages'
                      }
                    end
                  },
                  "programming-languages": {
                    data: developer.programming_languages.map do |programming_language|
                      {
                        id: programming_language.id.to_s,
                        type: 'programming-languages'
                      }
                    end
                  }
              }
            }
          end
        }
      end

      before do
        create :developer,
               email: Faker::Internet.unique.email,
               programming_languages: [create(:programming_language, name: Faker::ProgrammingLanguage.name)],
               languages: [create(:language, code: 'en')]
        create :developer,
               email: Faker::Internet.unique.email,
               programming_languages: [create(:programming_language, name: Faker::ProgrammingLanguage.name)],
               languages: [create(:language, code: 'fr')]
        get '/api/v1/developers'
      end
    end
  end

  describe 'GET /api/v1/developers/:id' do
    context 'when the developer exists' do
      it_behaves_like 'http_status_code_200_with_json'
      let(:expected_response) do
        {
          data: {
            id: @developer.id.to_s,
            type: 'developers',
            attributes: {
              email: @developer.email
            },
            relationships: {
              languages: {
                data: @developer.languages.map do |language|
                  {
                    id: language.id.to_s,
                    type: 'languages'
                  }
                end
              },
              "programming-languages": {
                data: @developer.programming_languages.map do |programming_language|
                  {
                    id: programming_language.id.to_s,
                    type: 'programming-languages'
                  }
                end
              }
            }
          }
        }
      end
    end

    before do
      @developer = create :developer,
                          email: Faker::Internet.unique.email,
                          programming_languages: [create(:programming_language, name: Faker::ProgrammingLanguage.name)],
                          languages: [create(:language, code: 'en')]
      get "/api/v1/developers/#{@developer.id}"
    end
  end
  context 'when the developer does not exist' do
    before do
      get '/api/v1/developers/non_existing_developer_id'
    end
    it_behaves_like 'http_status_code_404'
  end
end
