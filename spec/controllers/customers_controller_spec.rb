require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  describe "As a Guest" do
    context '#index' do
      it "responds successfully" do
        get :index
        expect(response).to be_success
      end
    
      it "responds a 200" do
        get :index
        expect(response).to have_http_status "200"
      end
    end
  
    it "responds a 302 response (not authorized)" do
      customer = create(:customer)
      get :show, params: { id: customer.id }
      expect(response).to have_http_status "302"
    end
  end

  describe 'As Logged Member' do

    before do
      @member = create(:member)
      @customer = create(:customer)
      sign_in @member
    end

    it "with valid attributes" do
      customer_params = attributes_for(:customer )
      expect {
        post :create, params: { customer: customer_params }
      }.to change(Customer, :count).by(1)
    end

    it "#show" do
      get :show, params: { id: @customer.id }
      expect(response).to have_http_status 200
    end

    it 'render a show template' do
      get :show, params: { id: @customer.id }
      expect(response).to render_template(:show)
    end

  end

end
