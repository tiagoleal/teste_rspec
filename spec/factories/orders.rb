#/spec/factories/orders.rb
FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedido número - #{n}"}
    # customer #instancia automaticamente a factory customer
    # ou
    association :customer, factory: :customer #especificando a factory
  end
end
