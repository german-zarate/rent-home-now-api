require 'swagger_helper'

RSpec.describe 'api/v1/addresses', type: :request do
  path '/api/v1/addresses' do
    post('create address') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Addresses'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/addresses/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    patch('update address') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Addresses'
      response(200, 'successful') do
        let(:id) { '123' }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/addresses/{id}' do
    put('update address') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Addresses'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/addresses/{id}' do
    delete('delete address') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Addresses'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
