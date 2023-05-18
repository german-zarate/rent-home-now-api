require 'swagger_helper'

RSpec.describe 'api/v1/properties', type: :request do
  path '/api/v1/properties' do
    get('list properties') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Properties'
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

    post('create property') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Properties'
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

  path '/api/v1/properties/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show property') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Properties'
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

  path '/api/v1/properties/{id}' do
    patch('update property') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Properties'
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
  path '/api/v1/properties/{id}' do
    put('update property') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Properties'
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

  path '/api/v1/properties/{id}' do
    delete('delete property') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Properties'
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
