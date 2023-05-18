require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/auth/sign_up' do
    post('create user') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Users'
      parameter name: :user, in: :body, schema: {
        type: :object, properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string, example: 'John Doe' }, email: { type: :string, example: 'johndoe@example.com' },
              avatar: { type: :string, example: 'avatar.png' }, password: { type: :string, example: 'password' },
              password_confirmation: { type: :string, example: 'password' }
            }, required: %w[name email avatar password password_confirmation]
          }
        }
      }
      response(201, 'successful') do
        schema type: :object, properties: {
          id: { type: :integer, example: 1455 }, email: { type: :string, example: 'John Doe' },
          name: { type: :string, example: 'johndoe@example.com' }, role: { type: :string, example: 'user' },
          avatar: { type: :string, format: :uri, example: 'avatar.png' },
          created_at: { type: :string, format: 'date-time', example: '2023-05-18 15:58:21 UTC' },
          updated_at: { type: :string, format: 'date-time', example: '2023-05-18 15:58:21 UTC' }
        }, required: %w[id email name role avatar created_at updated_at]
        user = User.create!(name: Faker::Name.name, email: Faker::Internet.email, avatar: Faker::LoremFlickr.image,
                            password: 'password', password_confirmation: 'password')
        examples 'application/json' => user.attributes.except('password', 'password_digest')
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    get('list users') do
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

  path '/api/v1/users/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Users'
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

  path '/api/v1/users/{id}' do
    patch('update user') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Users'
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

  path '/api/v1/users/{id}' do
    put('update user') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Users'
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

  path '/api/v1/users/{id}' do
    delete('delete user') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Users'
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
