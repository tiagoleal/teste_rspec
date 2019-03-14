#/spec/models/order_spec.rb
require 'rails_helper'

RSpec.describe Order, type: :model do
  
  it 'belongs_to - Tem 1 pedido' do
    order = create(:order)
    expect(order.customer).to be_kind_of(Customer)
  end

  it 'create_list - Tem 3 pedidos' do
    orders = create_list(:order, 3, description: "teste") #sobresqueve o atributo description
    puts orders.inspect
    expect(orders.count).to eq(3)
  end

  it 'has_many' do
    # customer = create(:customer, :with_orders, qtt_orders: 5) #pode passar a qtt_orders senao o padrao e 3
    #ou
    customer = create(:customer_with_orders)
    puts customer.inspect
    puts customer.orders.inspect
    expect(customer.orders.count).to eq(5)
    
  end

end