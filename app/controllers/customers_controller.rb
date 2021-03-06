class CustomersController < ApplicationController
  def index
    customers = Customer.order(:name).as_json(only: [
      :id,
      :name,
      :registered_at,
      :postal_code,
      :phone,
      :videos_checked_out_count
    ])
    render json: customers, status: :ok
  end
end
