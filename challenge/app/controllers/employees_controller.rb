class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def report
    respond_to do |format|
      format.json { redirect_to root_path }
      format.xml { redirect_to root_path }
      format.csv do
        send_data Employee.build_csv, filename: "#{Time.now.strftime('%Y-%m-%d_%I:%M:%S%p')}_employees_.csv", status: 200
      end
    end
  end
end
