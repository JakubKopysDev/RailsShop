# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :request do
  describe 'GET #index' do
    context 'as a guest' do
      it 'assigns @products' do
        product = FactoryGirl.create :product
        get '/products'
        expect(assigns(:products)).to eq([product])
      end
      it 'renders the :index view' do
        get '/products'
        expect(response).to render_template(:index)
      end
    end
  end
end
