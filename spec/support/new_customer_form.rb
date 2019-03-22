#spec/support/new_customer_form.rb
class NewCustomerForm
  include Capybara::DSL #Capybara
  include FactoryBot::Syntax::Methods #FactoyBot
  include Warden::Test::Helpers #Devise
  include Rails.application.routes.url_helpers #Routes

  def login
    member = create(:member)
    login_as(member, :scope => :member) #faz o login com o scope(permissao de acesso)
    self #retorno pode ser encadeado com outro method
  end

  def visit_page
    #acessa a pagina
    visit(new_customer_path) 
    self
  end

  def fill_in_with(params = {})
    #preenche o form
    fill_in('Name', with: params.fetch(:name, Faker::Name.name)) 
    fill_in('Email', with: params.fetch(:email, Faker::Internet.email)) 
    fill_in('Address', with: params.fetch(:address, Faker::Address.street_address)) 
    self
  end
   
  def submit
    # clicar no botão de submit
    click_button("Create Customer")    
  end

  
end