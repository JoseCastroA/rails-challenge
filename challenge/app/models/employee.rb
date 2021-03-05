class Employee < ApplicationRecord
  include ::CsvGenerator

  COLUMN_NAMES = %w[name email start_date total_benefits].freeze

  # Associations
  belongs_to :employee_invite
  has_many :benefits

  def start_date
    read_attribute(:start_date).strftime('%Y/%m/%d')
  end

  def total_benefits
    benefits.sum(:amount).try(:to_i)
  end

  def average_benefit_per_month
    benefits.group(:month).average(:amount)
  end

  class << self
    private

    def format_data
      months = Benefit.all_months
      { headers: headers(months), rows: rows(months) }
    end

    def headers(months)
      COLUMN_NAMES.map { |c| c.gsub('_', ' ').try(:capitalize) } + months.map { |m| m.strftime('%d/%Y') }
    end

    def rows(months)
      rows = []

      all.each do |employee|
        employee_attributes = COLUMN_NAMES.map { |c| employee.try(:send, c) || '' }
        benefits_per_month = employee.average_benefit_per_month

        rows << (employee_attributes + fill_columns_months(months, benefits_per_month))
      end

      rows
    end

    def fill_columns_months(months, benefits_per_month)
      months.map { |month| benefits_per_month[month].try(:to_i) }
    end
  end
end
