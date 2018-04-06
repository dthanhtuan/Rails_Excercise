require 'spec_helper'

describe 'Performance testing' do
  context '10 requests at the same time and 10 times in a row' do
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
