require 'swagger_helper'

RSpec.describe 'api/v1/reservation_criterias', type: :request do
  path '/api/v1/reservation_criterias' do
    get('list reservation_criteria') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Reservation Criteria'
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

    post('create reservation_criteria') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Reservation Criteria'
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

  path '/api/v1/reservation_criterias/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show reservation_criteria') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Reservation Criteria'
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

  path '/api/v1/reservation_criterias/{id}' do
    patch('update reservation_criteria') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Reservation Criteria'
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

  path '/api/v1/reservation_criterias/{id}' do
    put('update reservation_criteria') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Reservation Criteria'
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

  path '/api/v1/reservation_criterias/{id}' do
    delete('delete reservation_criteria') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Reservation Criteria'
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
