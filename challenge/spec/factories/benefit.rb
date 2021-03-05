FactoryBot.define do
  factory :benefit, class: Benefit do
    month  { Faker::Date.between(from: 1.year.ago.to_date, to: Date.today) }
    amount { Random.rand(100) }
  end
end
