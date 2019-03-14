#spec/controllers/customers_controller_spec.rb
require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  describe 'As a guest' do
    context '#index' do 
      it 'responds successfully' do
        get :index
        # puts response.inspect
        expect(response).to be_successful
      end

      it 'responds a 200 response' do
        get :index
        # puts response.inspect
        expect(response).to have_http_status(200)
      end
    end

    context '#show' do 
      it ' response 302 (not authorized)' do
        customer = create(:customer)
        get :show, params: {id: customer.id }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'As logged Member' do 
    before do 
      @member = create(:member)
      @customer = create(:customer)
    end

    #teste de rota

    it 'Route' do
      is_expected.to route(:get, '/customers').to(action: :index)      
    end
    
    it 'Content-Type' do
      customer_params = attributes_for(:customer)
      sign_in @member
      post :create, format: :json, params: { customer: customer_params }
      # p response
      expect(response.content_type).to eq("application/json")
    end

    #teste se criou o registro mensagem de criado com sucesso
    it 'Flash Notice ' do
      customer_params = attributes_for(:customer)
      sign_in @member
      post :create, params: { customer: customer_params } 
      expect(flash[:notice]).to match(/successfully created/) #regex
    end

    it 'Post with valid attributes' do
      #simulando a validação dos params que vem da view 
      #tras o campo e o valor 
      customer_params = attributes_for(:customer)
      #loga o usuario
      sign_in @member
      expect{
        post :create, params: { customer: customer_params } 
      }.to change(Customer, :count).by(1)  

      # p customer_params print
    end

    it 'Post with invalid attributes' do
      #simulando a validação dos params que vem da view 
      #tras o campo e o valor 
      customer_params = attributes_for(:customer, address:nil)
      #loga o usuario
      sign_in @member
      expect{
        post :create, params: { customer: customer_params } 
      }.not_to change(Customer, :count)

      # p customer_params print
    end

    it '#show' do
      #loga com o membro
      sign_in @member 
      get :show, params: {id: @customer.id }
      expect(response).to have_http_status(200)
    end

    it 'render a :show template' do
      #loga com o membro
      sign_in @member 
      get :show, params: {id: @customer.id }
      expect(response).to render_template(:show)
    end
  end


end
