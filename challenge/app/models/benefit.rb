class Benefit < ApplicationRecord
  belongs_to :employee

  def self.all_months
    all.pluck(:month).try(:uniq).try(:sort)
  end
end
