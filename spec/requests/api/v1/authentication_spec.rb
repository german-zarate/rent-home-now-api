require 'swagger_helper'
require 'faker'

RSpec.describe 'api/v1/authentication', type: :request do
  path '/api/v1/auth/sign_in' do
    post('sign_in authentication') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Users'
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

  path '/api/v1/auth/me' do
    get('current_user authentication') do
      tags 'Users'

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
end
