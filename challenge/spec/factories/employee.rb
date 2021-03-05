FactoryBot.define do
  factory :employee, class: Employee do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    start_date { Faker::Date.between(from: 1.year.ago.to_date, to: Date.today) }
    employee_invite
  end
end
