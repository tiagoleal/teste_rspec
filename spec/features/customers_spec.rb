#spec/features/customers_spec.rb
require 'rails_helper'
require_relative '../support/new_customer_form'

#permite renderizar js
RSpec.feature "Customers", type: :feature, js: true do 
  # let(:new_customer_form) { NewCustomerForm.new }

  it 'Visit index page' do
    visit(customers_path)
    print page.html #imprime a pagina visitada
    # save_and_open_page #salva uma copia da pagina visitada
    # page.save_screenshot('screenshot.png')
    expect(page).to have_current_path(customers_path)
  end

  it 'Ajax' do
    visit(customers_path)
    click_link("Add Message")
    expect(page).to have_content("Yes!")
  end

  it 'Find' do
    visit(customers_path)
    click_link("Add Message")
    expect(find("#my-div").find("h1")).to have_content("Yes!")
  end

  it 'Creates a Customer - page Object Pattern' do
    new_customer_form = NewCustomerForm.new
    # ou deixar global
    # RSpec.feature "Customers", type: :feature, js: true do 
    #   # let(:new_customer_form) { NewCustomerForm.new }
    
    new_customer_form.login.visit_page.fill_in_with(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      address: Faker::Address.street_address,
    ).submit

  end


  it 'Creates a Customer' do
    member = create(:member)
    login_as(member, :scope => :member) #faz o login com o scope(permissao de acesso)
    
    #acessa a pagina
    visit(new_customer_path) 
    
    #preenche o form
    fill_in('Name', with: Faker::Name.name) 
    fill_in('Email', with: Faker::Internet.email) 
    fill_in('Address', with: Faker::Address.street_address) 

    # clicar no botão de submit
    click_button("Create Customer")

    #testa a mensagem de cadastrado com sucesso
    expect(page).to have_content("Customer was successfully created.")

  end

end
