#spec/request/customers_spec.rb
require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do
    it "works! 200 OK" do
      get customers_path
      expect(response).to have_http_status(200)
    end

    it "index - JSON" do
      get "/customers.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json([
        id: /\d/,
        name: (be_kind_of String),
        email: (be_kind_of String)
      ])
    end

    it "show - JSON" do
      get "/customers/1.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        id: /\d/,
        name: (be_kind_of String),
        email: (be_kind_of String)
      )
    end

    #rspec puro com JSON s/gem
    it 'show - Rspec puro + JSON' do
      get "/customers/1.json"
      response_body = JSON.parse(response.body)
      expect(response_body.fetch("id")).to eq(1)
      expect(response_body.fetch("name")).to be_kind_of(String)
      expect(response_body.fetch("email")).to be_kind_of(String)
    end

    it "create - JSON" do
      member = create(:member)
      login_as(member, scope: :member)
      headers = { "ACCEPT" => "application/json" }
      customers_params = attributes_for(:customer)
      p customers_params
      post "/customers", params: { customer: customers_params}, headers: headers 
      expect(response.body).to include_json(
        id: /\d/,
        # name: customers_params[:name],
        # email: customers_params[:email],
        # ou 
        name: customers_params.fetch(:name), #mas indicado que o outro
        email: customers_params.fetch(:email)
      )
    end

    it "update - JSON" do
      member = create(:member)
      login_as(member, scope: :member)
      headers = { "ACCEPT" => "application/json" }
      customers_params = Customer.first
      customers_params.name += " - ATUALIZADO"
      patch "/customers/#{customers_params.id}.json", params: { customer: customers_params.attributes}, headers: headers 
      expect(response.body).to include_json(
        id: /\d/,
        name: customers_params.name,
        email: customers_params.email
      )
    end

    it "destroy - JSON" do
      member = create(:member)
      login_as(member, scope: :member)
      headers = { "ACCEPT" => "application/json" }
      customers_params = Customer.first
      expect{ delete "/customers/#{customers_params.id}.json", headers: headers }.to change(Customer, :count).by(-1) 
      expect(response).to have_http_status(204) #not found
    end

    it 'JSON Schema validator' do
      get "/customers/1.json"
      # p response.body
      
      #padrao de json em support/api/schemas/customer.json
      expect(response).to match_response_schema("customer") 
    end

  end
end