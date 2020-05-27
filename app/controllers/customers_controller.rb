class CustomersController < ApplicationController
  def index
    customer = Customer.all.as_json(only: [:id, :name, :registered_at,
      :postal_code, :phone, :videos_checked_out_count])
    render json: customer, status: :ok
  end
end


# name, registered_at, address*, city*, state*, postal_code, phone, videos_checked_out_count [* not included in API response]