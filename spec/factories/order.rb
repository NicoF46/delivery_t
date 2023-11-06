FactoryBot.define do
  factory :order do
    association :product
    customer_name { Faker::Name.name }
    address { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }
    shipping_method { Faker::Lorem.word }
    status { 'processing' }
  end
end
