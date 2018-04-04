require 'rails_helper'
require "spec_helper"
require "support/shared_context_for_api.rb"

describe 'Api::V1::DevelopersController', type: :request do
  include_context 'api'

  describe 'GET /api/v1/developers' do
    context 'without params' do

      let(:response_data) {
        Developer.all.map do |developer|
          {
              email: developer.email,
              languages: developer.languages.to_json,
              progamming_languages: developer.programming_languages.to_json
          }
        end
      }

      before do
        create(:developer, email: 'tuan.dao@tech.reapra.sg')
        create(:developer, email: 'abc@gmail.com')
        get '/api/v1/developers'
      end

      it_behaves_like 'http_status_code_200_with_json'
    end
  end

  describe 'GET /api/v1/developers/:id' do
    context 'when the developer exists' do

      let(:response_data) do
        {
            email: @developer.email,
            languages: @developer.languages.to_json,
            progamming_languages: @developer.programming_languages.to_json
        }
      end

      before do
        @developer = create(:developer, email: 'tuan.dao@reapra.tech.sg')
        get "/api/v1/developers/#{@developer.id}"
      end

      it_behaves_like 'http_status_code_200_with_json'
    end

    context 'when the user does not exist' do
      before do
        get '/api/v1/developers/non_existing_user_id'
      end

      it_behaves_like 'http_status_code_404'
    end

  end
end
