require 'rails_helper'

describe Employee, type: :model do
  let!(:employee) do
    create(:employee) do |employee|
      create(:benefit, month: Date.new(2021, 1, 25), amount: 3000, employee: employee)
      create(:benefit, month: Date.new(2021, 1, 25), amount: 2000, employee: employee)
    end
  end
  let!(:other_employee) do
    create(:employee) do |employee|
      create(:benefit, month: Date.new(2021, 1, 25), amount: 5000, employee: employee)
      create(:benefit, month: Date.new(2021, 2, 25), amount: 2500, employee: employee)
    end
  end

  describe '#total_benefits' do
    it { expect(employee.total_benefits).to eq 5000 }
    it { expect(other_employee.total_benefits).to eq 7500 }
  end

  describe '.build_csv' do
    subject do
      CSV.parse(described_class.build_csv)
    end

    it 'should have employee attributes' do
      expect(subject.count).to eq 3
      expect(subject[0].count).to eq 6
      expect(subject[0]).to include('Name', 'Email', 'Start date', 'Total benefits')
      expect(subject[1]).to include(employee.name, employee.email, employee.start_date, '5000', '2500')
      expect(subject[2]).to include(other_employee.name, other_employee.email, other_employee.start_date, '7500', '5000', '2500')
    end
  end
end
