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


  it 'Use the attributes_for' do
    attrs = attributes_for(:customer)
    attrs1 = attributes_for(:customer_vip)
    attrs2 = attributes_for(:customer_default)
    puts attrs
    puts attrs1
    puts attrs2
  end

  it 'Trasient Attribute' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Cliente Masculino Vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to be true
  end 

  it 'Cliente Masculino' do
    customer = create(:customer_male)
    expect(customer.gender).to eq('M')
  end

  it { expect{ create(:customer) }.to change{Customer.all.size}.by(1) }
end
