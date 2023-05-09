require 'rails_helper'
require 'faker'

RSpec.describe Api::V1::UsersController, type: :controller do
  before do
    User.delete_all
    @admin = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'password',
                          role: 'admin', password_confirmation: 'password', avatar: Faker::LoremFlickr.image)
    @user1 = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'password',
                          password_confirmation: 'password', avatar: Faker::LoremFlickr.image)
    @user2 = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'password',
                          password_confirmation: 'password', avatar: Faker::LoremFlickr.image)
  end

  describe 'GET index' do
    context 'when admin is signed in' do
      before do
        sign_in(@admin)
        get :index
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all users' do
        expect(assigns(:users)).to match_array([@admin, @user1, @user2])
      end
    end

    context 'when user is signed in' do
      before do
        sign_in(@user1)
        get :index
      end

      it 'returns a forbidden response' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Unauthorize access denied!')
      end
    end

    context 'when user is not signed in' do
      before do
        get :index
      end

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Invalid token!')
      end
    end
  end

  describe 'GET #show' do
    context 'when admin is signed in and user exist' do
      before do
        sign_in(@admin)
        get :show, params: { id: @user1.id }
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user data' do
        expect(assigns(:user)).to eq(@user1)
      end
    end

    context 'when admin is signed in and user not exist' do
      before do
        sign_in(@admin)
        get :show, params: { id: 'invalid_id' }
      end

      it 'returns a not found response' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('No user with id invalid_id')
      end
    end

    context 'when user is signed in and access self data' do
      before do
        sign_in(@user1)
        get :show, params: { id: @user1.id }
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user data' do
        expect(assigns(:user)).to eq(@user1)
      end
    end

    context 'when user is signed in and access another user data' do
      before do
        sign_in(@user1)
        get :show, params: { id: @user2.id }
      end

      it 'returns forbidden response' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Unauthorize access denied!')
      end
    end

    context 'when user is not signed in' do
      before do
        get :show, params: { id: @user1.id }
      end

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Invalid token!')
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:user_params) do
        { name: Faker::Name.name, email: Faker::Internet.email, password: 'password',
          password_confirmation: 'password', avatar: Faker::LoremFlickr.image }
      end

      it 'creates a new user' do
        expect do
          post :create, params: { user: user_params }
        end.to change(User, :count).by(1)
      end

      it 'returns status 201 created' do
        post :create, params: { user: user_params }

        expect(response).to have_http_status(:created)
      end

      it 'returns the created user as JSON' do
        post :create, params: { user: user_params }

        expect(JSON.parse(response.body)).to eq(User.last.as_json(except: :password_digest))
      end
    end

    context 'with invalid parameters' do
      let(:user_params) do
        { name: '', email: 'john@example.com', password: 'password', password_confirmation: 'password',
          avatar: Faker::LoremFlickr.image }
      end

      it 'does not create a new user' do
        expect do
          post :create, params: { user: user_params }
        end.to_not change(User, :count)
      end

      it 'returns status 422 unprocessable entity' do
        post :create, params: { user: user_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the error messages as JSON' do
        post :create, params: { user: user_params }

        expect(JSON.parse(response.body)).to eq({ 'name' => ["Name can't be blank"] })
      end
    end
  end

  describe 'PUT #update' do
    let(:valid_params) do
      {
        user: {
          name: 'New Name',
          password: 'password'
        }
      }
    end

    context 'when admin is signed in and update self' do
      before do
        sign_in(@admin)
        put :update, params: { id: @admin.id }.merge(valid_params)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the admin' do
        @admin.reload

        expect(@admin.name).to eq 'New Name'
      end
    end

    context 'when admin is signed in and update user' do
      before do
        sign_in(@admin)
        put :update, params: { id: @user1.id }.merge(valid_params)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the user' do
        @user1.reload

        expect(@user1.name).to eq 'New Name'
      end
    end

    context 'when admin is signed in and user not exist' do
      before do
        sign_in(@admin)
        get :show, params: { id: 'invalid_id' }.merge(valid_params)
      end

      it 'returns a not found response' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('No user with id invalid_id')
      end
    end

    context 'when user is signed in and update self data' do
      before do
        sign_in @user1
        put :update, params: { id: @user1.id }.merge(valid_params)
      end

      context 'with valid parameters' do
        it 'returns a success response' do
          expect(response).to have_http_status(:ok)
        end

        it 'updates the user' do
          @user1.reload

          expect(@user1.name).to eq 'New Name'
        end
      end
    end

    context 'when user is signed in and try to update another user data' do
      before do
        sign_in @user1
        put :update, params: { id: @user2.id }.merge(valid_params)
      end

      it 'not updates the user' do
        @user2.reload

        expect(@user2.name).to eq @user2.name
      end

      it 'returns a forbidden response' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Unauthorize access denied!')
      end
    end

    context 'when user is not signed in' do
      before do
        put :update, params: { id: @user1.id }.merge(valid_params)
      end

      context 'with valid parameters' do
        it 'not updates the user' do
          @user1.reload

          expect(@user1.name).not_to eq 'New Name'
        end

        it 'returns a unauthorized response' do
          expect(response).to have_http_status(:unauthorized)
        end
        it 'returns an error message' do
          expect(JSON.parse(response.body)['error']).to eq('Invalid token!')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when admin is signed in and destroy self' do
      before do
        sign_in(@admin)
      end

      it 'deletes the admin' do
        expect { delete :destroy, params: { id: @admin.id } }.to change(User, :count).by(-1)
      end

      it 'returns a no content response' do
        delete :destroy, params: { id: @admin.id }

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when admin is signed in and destroy a user' do
      before do
        sign_in(@admin)
      end

      it 'deletes the user' do
        expect { delete :destroy, params: { id: @user1.id } }.to change(User, :count).by(-1)
      end

      it 'returns a no content response' do
        delete :destroy, params: { id: @user1.id }

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when admin is signed in and user not exist' do
      before do
        sign_in(@admin)
        delete :destroy, params: { id: 'invalid_id' }
      end

      it 'returns a not found response' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('No user with id invalid_id')
      end
    end

    context 'when user is signed in and destroy self' do
      before { sign_in @user1 }

      it 'destroy the user' do
        expect { delete :destroy, params: { id: @user1.id } }.to change(User, :count).by(-1)
      end

      it 'returns a no content response' do
        delete :destroy, params: { id: @user1.id }

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when user is signed in and try to destroy another user' do
      before do
        sign_in @user1
        delete :destroy, params: { id: @user2.id }
      end

      it 'not destroy the user' do
        @user2.reload

        expect(@user2.name).to eq @user2.name
      end

      it 'returns a forbidden response' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Unauthorize access denied!')
      end
    end

    context 'when user is not signed in' do
      before do
        delete :destroy, params: { id: @user1.id }
      end

      it 'not destroy the user' do
        @user1.reload

        expect(@user1.name).to eq @user1.name
      end

      it 'returns a unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Invalid token!')
      end
    end
  end
end
