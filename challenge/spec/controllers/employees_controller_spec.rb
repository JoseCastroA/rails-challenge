require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let!(:employees) { create_list(:employee, 10) }

  describe 'responses' do
    describe 'GET index' do
      subject { get :index }

      it 'status should be' do
        expect(subject.status).to eq(200)
      end
      it 'renders the index template' do
        expect(subject).to render_template('index')
      end

      it 'assigns @employees' do
        subject
        expect(assigns(:employees)).to eq(Employee.all)
      end
    end

    describe '#report' do
      subject { get :report, format: :csv }

      it 'csv format status should be' do
        expect(subject.status).to eq(200)
      end

      it 'should have CSV headers' do
        expect(subject.header['Content-Type']).to include 'text/csv'
      end

      it 'should have employees data' do
        expect(subject.body).to include('Name,Email,Start date,Total benefits')
        employees.each do |employee|
          expect(subject.body).to include(employee.name, employee.email, employee.start_date)
        end
      end
    end
  end
end
