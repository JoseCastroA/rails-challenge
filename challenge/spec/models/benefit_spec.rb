require 'rails_helper'

describe Benefit, type: :model do
  describe '.all_months' do
    let(:employee) { create(:employee) }

    let!(:benefits) do
      create_list(:benefit, 10, employee: employee)
    end

    subject { described_class.all_months }

    it { expect(subject.size).to eq 10 }
  end
end
