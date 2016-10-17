require 'rails_helper'

RSpec.describe "Create customer", :type => :request do
  describe "Post #create" do
    it "Successfully" do
      post v1_customers_path,
           params: customer_params(name: "Juan",
                                   address: "Loma Azul",
                                   phone: "4442129998")
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:success)
      expect(json_response["name"]).to eq("Juan")
      expect(json_response["address"]).to eq("Loma Azul")
      expect(json_response["phone"]).to eq("4442129998")
    end

    it "Fails if name is not set" do
      post v1_customers_path,
           params: customer_params(name: "",
                                   address: "Loma Azul",
                                   phone: "4442129998")
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:error)
      expect(json_response["errors"]).to include("Name can't be blank")
    end

    it "Fails if address is not set" do
      post v1_customers_path,
           params: customer_params(name: "Juan",
                                   address: "",
                                   phone: "4442129998")
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:error)
      expect(json_response["errors"]).to include("Address can't be blank")
    end

    it "Fails if phone is not set" do
      post v1_customers_path,
           params: customer_params(name: "Juan",
                                   address: "Loma Azul",
                                   phone: "")
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:error)
      expect(json_response["errors"]).to include("Phone can't be blank")
    end
  end

  def customer_params(name: "", address: "", phone: "")
    {
      name: name,
      address: address,
      phone: phone
    }
  end
end
