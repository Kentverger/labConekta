require 'rails_helper'

RSpec.describe "Tokenize Card", :type => :request do
  describe "Post #create" do
    it "Successfully" do
      customer = FactoryGirl.create :customer

      post v1_cards_actions_tokenize_path,
           params: card_params(name: "Luis Carlos",
                               number: 4242424242424242,
                               cvv: 123,
                               experiation_month: 12,
                               experiation_year: 2019,
                               customer_id: customer.id)
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:success)
      expect(json_response["name"]).to eq("Luis Carlos")
      expect(RedisClient.get(json_response["customer_id"]).nil?).to eq(false)
    end

    it "Fails if name is not set" do
      customer = FactoryGirl.create :customer

      post v1_cards_actions_tokenize_path,
           params: card_params(name: "",
                               number: 4242424242424242,
                               cvv: 123,
                               experiation_month: 12,
                               experiation_year: 2019,
                               customer_id: customer.id)
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:error)
      expect(json_response["errors"]).to include("Name can't be blank")
    end

    it "Fails if number is not set" do
      customer = FactoryGirl.create :customer

      post v1_cards_actions_tokenize_path,
           params: card_params(name: "Luis Carlos",
                               number: nil,
                               cvv: 123,
                               experiation_month: 12,
                               experiation_year: 2019,
                               customer_id: customer.id)
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:error)
      expect(json_response["errors"]).to include("Number can't be blank")
    end

    it "Fails if cvv is not set" do
      customer = FactoryGirl.create :customer

      post v1_cards_actions_tokenize_path,
           params: card_params(name: "Luis Carlos",
                               number: 4242424242424242,
                               cvv: nil,
                               experiation_month: 12,
                               experiation_year: 2019,
                               customer_id: customer.id)
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:error)
      expect(json_response["errors"]).to include("Cvv can't be blank")
    end

    it "Fails if experiation month is not set" do
      customer = FactoryGirl.create :customer

      post v1_cards_actions_tokenize_path,
           params: card_params(name: "Luis Carlos",
                               number: 4242424242424242,
                               cvv: 123,
                               experiation_month: nil,
                               experiation_year: 2019,
                               customer_id: customer.id)
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:error)
      expect(json_response["errors"]).to include("Experiation month can't be blank")
    end

    it "Fails if experiation year is not set" do
      customer = FactoryGirl.create :customer

      post v1_cards_actions_tokenize_path,
           params: card_params(name: "Luis Carlos",
                               number: 4242424242424242,
                               cvv: 123,
                               experiation_month: 12,
                               experiation_year: nil,
                               customer_id: customer.id)
      json_response = JSON.parse response.body

      expect(response).to have_http_status(:error)
      expect(json_response["errors"]).to include("Experiation year can't be blank")
    end
  end

  def card_params(name: "", number: nil, cvv: nil, experiation_month: nil,
                  experiation_year: nil, customer_id: nil)
    {
      name: name,
      number: number,
      cvv: cvv,
      experiation_month: experiation_month,
      experiation_year: experiation_year,
      customer_id: customer_id
    }
  end
end
