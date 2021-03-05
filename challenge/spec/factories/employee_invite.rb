FactoryBot.define do
  factory :employee_invite, class: EmployeeInvite do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    start_date { Faker::Date.between(from: 1.year.ago.to_date, to: Date.today) }
  end
end
