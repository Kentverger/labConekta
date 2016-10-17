class V1::CustomersController < ApplicationController
  def create
    customer = Customer.new customer_params

    if customer.save
      render json: customer, status: 200
    else
      render json: {
        errors: customer.errors.full_messages
      }, status: 500
    end
  end

  def customer_params
    params.permit(:name, :address, :phone)
  end
end
