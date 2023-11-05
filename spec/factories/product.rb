FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 0..100.0, as_string: true) }
    stock { Faker::Number.between(from: 1, to: 100) }
  end
end