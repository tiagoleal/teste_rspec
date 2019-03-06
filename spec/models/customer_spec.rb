#/spec/models/customer_spec.rb
require 'rails_helper'

RSpec.describe Customer, type: :model do
  it '#Full_name Customer' do
    customer = create(:customer)
    expect(customer.full_name).to start_with("Sr. ")
  end

  it '#Full_name - sobrescrevendo atributos' do
    customer = create(:user, name: "Tiago Leal") #atende por customer(:customer) ou user(:user)
    customer1 = create(:user, name: "Tiago Leal") #atende por customer(:customer) ou user(:user)
    expect(customer.full_name).to eq("Sr. Tiago Leal")
    puts customer.email
    puts customer1.email

  end

  it 'Herança' do
    customer = create(:customer_vip) #(:customer_vip) herança
    expect(customer.vip).to eq(true)
  end

  it 'Usando o attributes_for' do
    #retorna os atributos do customer em hash para utilizar em json
    attrs = attributes_for(:customer) 
    attrs1 = attributes_for(:customer_vip) 
    attrs2 = attributes_for(:customer_default) 
    puts attrs
    puts attrs1
    puts attrs2

    customer = Customer.create(attrs)
    expect(customer.full_name).to start_with("Sr. ")
  end

  it 'Atributo Transitório' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Cliente Masculino Vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to eq(true)
  end
  
  it 'Cliente Masculino' do
    customer = create(:customer_male)
    expect(customer.gender).to eq('M')
  end

  it 'Cliente Feminino' do
    customer = create(:customer_female)
    expect(customer.gender).to eq('F')
  end

  it 'Cliente Feminino default' do
    customer = create(:customer_female_default)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to eq(false)
  end
  

  #mudou algum atributo
  it { expect{ create(:customer) }.to change{Customer.all.size}.by(1) }
end

