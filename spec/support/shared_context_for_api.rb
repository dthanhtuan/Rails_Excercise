require 'rails_helper'
require "spec_helper"
require 'json'

RSpec.shared_context 'api' do
  shared_examples 'http_status_code_200' do
    it 'returns 200' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  shared_examples 'http_status_code_200_with_json' do
    it 'returns 200 with JSON' do
      expect(response).to be_success
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json) == response_data
    end
  end

  shared_examples 'http_status_code_404' do
    it 'returns 404' do
      expect(response).to_not be_success
      expect(response.status).to eq(404)
    end
  end

  shared_examples 'http_status_code_500' do
    it 'returns 500' do
      expect(response).to_not be_success
      expect(response.status).to eq(500)
    end
  end
end
