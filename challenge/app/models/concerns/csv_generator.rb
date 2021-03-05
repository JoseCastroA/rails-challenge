module CsvGenerator
  extend ActiveSupport::Concern

  class_methods do
    def build_csv
      data = format_data
      CSV.generate do |csv_object|
        csv_object << data[:headers]
        data[:rows].each do |row|
          csv_object << row
        end
      end
    end

    def format_data
      { headers: [], rows: [[]] }
    end
  end
end
