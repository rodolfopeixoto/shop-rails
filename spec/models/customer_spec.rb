require 'rails_helper'

RSpec.describe Customer, type: :model do
  it '#full_name - Override attributes' do
    customer = build(:customer, name: 'Rodolfo Gomes Peixoto')
    expect(customer.full_name).to eq("Sr. Rodolfo Gomes Peixoto")
  end
  it 'Customer default' do
    customer = build(:customer_default)
    expect(customer.vip).to be false
  end
  it 'Customer vip' do
    customer = build(:customer_vip)
    expect(customer.vip).to be true
  end
  it 'Customer ' do
    customer = build(:customer)
    expect(customer.vip).to be nil
  end
  it 'Customer with days_to_pay nil' do
    customer = build(:customer)
    expect(customer.days_to_pay).to be nil
  end

  it { expect{ create(:customer) }.to change{Customer.all.size}.by(1) }
end
