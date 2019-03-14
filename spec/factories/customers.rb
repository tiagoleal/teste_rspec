#/spec/factories/customer.rb
FactoryBot.define do
  factory :customer, aliases: [:user] do #definindo alias
    
    #atributo transitorio
    transient do
      upcased { false }
      qtt_orders { 3 }
    end
    
    name { Faker::Name.name }
    # email { Faker::Internet.email }
    address { Faker::Address.street_address }

    #emails sequencial começando em 10
    sequence(:email, 10) { |n| "meu_email-#{n}@email.com"} 
    #ou
    # sequence(:email, 'a') { |n| "meu_email-#{n}@email.com"} 

    trait :male do
      gender { 'M' }
    end

    trait :female do
      gender { 'F' }
    end

    trait :vip do 
      vip { true }
      days_to_pay { 30 }
    end

    trait :default do 
      vip { false }
      days_to_pay { 15 }
    end

    trait :with_orders do
      qtt_orders { 5 }
      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.qtt_orders, customer: customer)
      end
    end

    factory :customer_with_orders, traits: [:with_orders]
    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]
    factory :customer_vip, traits: [:vip]
    factory :customer_default, traits: [:default]

    factory :customer_male_vip, traits: [:male, :vip]
    factory :customer_female_vip, traits: [:female, :vip]
    factory :customer_male_default, traits: [:male, :default]
    factory :customer_female_default, traits: [:female, :default]
    
    #depois de criar o atributo no banco de dados pega o valor 
    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased #teste se o upcased está true
    end
  end
end

