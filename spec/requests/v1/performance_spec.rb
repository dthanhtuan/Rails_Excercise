require 'spec_helper'
require 'support/shared_context_for_api.rb'

describe 'Performance testing' do
  context '10 requests at the same time and 10 times in a row' do
    let(:response_data) do
      {
        email: @developer.email,
        languages: @developer.languages.to_json,
        progamming_languages: @developer.programming_languages.to_json
      }
    end

    it 'returns 200 with JSON' do
      expect do
        10.times do
          get '/api/v1/developers'
          expect(response).to be_success
          expect(response.status).to eq(200)
        end
      end.to perform_under(0.05).and_sample(10)
    end
  end
end
