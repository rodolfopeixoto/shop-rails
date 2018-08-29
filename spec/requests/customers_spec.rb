require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do

   it 'JSON Schema' do
     get '/customers/1.json'
     expect(response).to match_response_schema("customer")
   end

    it "works! (now write some real specs)" do
      get customers_path
      expect(response).to have_http_status(200)
    end
    it "index - JSON" do
      get '/customers.json'
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        [
          id: /\d/,
          name: (be_kind_of String),
          email: (be_kind_of String),
        ]
      )
    end
    it "show - JSON" do
      get '/customers/1.json'
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
          id: /\d/,
          name: (be_kind_of String),
          email: (be_kind_of String),
      )
    end


    it "show -  RSPEC PURE JSON" do
      get '/customers/1.json'
      response_body = JSON.parse(response.body)
      expect(response_body.fetch("id")).to eq(1)
      expect(response_body.fetch("name")).to be_kind_of(String)
      expect(response_body.fetch("email")).to be_kind_of(String)
    end


    it 'create - JSON' do
      member = create(:member)
      login_as(member, scope: :member)
      
      headers = { "ACCEPT" => "application/json" }
      
      customers_params = attributes_for(:customer)

      post '/customers', params: { customer: customers_params }, headers: headers
      expect(response.body).to include_json(
        id: /\d/, # Caso tenha alinhado ficaria  customers_params[:address][:street]
        name: customers_params[:name], # retorna nil
        email: customers_params.fetch(:email), # retorna o error
      )
    end



    it 'update - JSON' do
      member = create(:member)
      login_as(member, scope: :member)
      
      headers = { "ACCEPT" => "application/json" }

      customers = Customer.first
      customers.name += " - ATUALIZADO"

      patch "/customers/#{customers.id}.json", params: { customer: customers.attributes }, headers: headers
     
      expect(response.body).to include_json(
        id: /\d/, # Caso tenha alinhado ficaria  customers_params[:address][:street]
        name: customers.name, # retorna nil
        email: customers.email, # retorna o error
      )
    end



    it 'delete - JSON' do
      member = create(:member)
      login_as(member, scope: :member)
      
      headers = { "ACCEPT" => "application/json" }

      customers = Customer.first

      expect{ delete "/customers/#{customers.id}.json", headers: headers }.to change(Customer, :count).by(-1)
      expect(response).to have_http_status(204)
    end


  end
end
