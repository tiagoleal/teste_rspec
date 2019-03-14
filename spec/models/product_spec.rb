#/spec/models/product_spec.rb
require 'rails_helper'

RSpec.describe Product, type: :model do

  it 'is valid with description, price and category' do
    product = create(:product)
    expect(product).to be_valid #valida se todos os campos estão preenchidos
  end

  # it 'is valid without description' do
  #   #somente criamos na memoria pois nao pode utilizar o create pq da erro no model e nem roda o rspec
  #   product = build(:product, description:nil) 
  #   product.valid?
  #   expect(product.errors[:description]).to include("can't be blank")
  # end

  # it 'is valid without price' do
  #   #somente criamos na memoria pois nao pode utilizar o create pq da erro no model e nem roda o rspec
  #   product = build(:product, price:nil) 
  #   product.valid?
  #   expect(product.errors[:price]).to include("can't be blank")
  # end

  # it 'is valid without category' do
  #   #somente criamos na memoria pois nao pode utilizar o create pq da erro no model e nem roda o rspec
  #   product = build(:product, category:nil) 
  #   product.valid?
  #   expect(product.errors[:category]).to include("can't be blank")
  # end
  #ou
  #otimizado utilizando should matches(não precisa testar o expect)
  # pode utilizar should nao esta em desuso
  context 'Validates' do 
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:category) }
  end

  context 'Associations' do 
    #testa o relacionamento
    it { should belong_to(:category) }
  end

  context 'Instance Methods' do 
    it '#full_descrition' do
      product = create(:product)
      expect(product.full_description).to eq("#{product.description} - #{product.price}")
    end
  end

end
