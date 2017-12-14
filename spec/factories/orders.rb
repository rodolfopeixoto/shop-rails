FactoryBot.define do
  factory :order do
    sequence(:description) { |number| "Pedido número: #{number}" }
    customer
  end
end
