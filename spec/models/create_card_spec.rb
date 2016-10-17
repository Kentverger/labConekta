require 'rails_helper'

RSpec.describe CreateCard, type: :model do
  context :validations do
    it "validate the month" do
      create_card = CreateCard.new experiation_month: 13, experiation_year: 2019

      expect(create_card.valid?).to eq(false)
      expect(create_card.errors.full_messages).to include("Month is invalid")
    end

    it "validate the year" do
      create_card = CreateCard.new experiation_month: 13, experiation_year: 2011

      expect(create_card.valid?).to eq(false)
      expect(create_card.errors.full_messages).to include("Year is the past")
    end
  end

  describe "#last_four" do
    it "return the last 4 digits from a card" do
      create_card = CreateCard.new number: 5555555555554444

      expect(create_card.last_four).to eq("4444")
    end
  end

  describe "#bin" do
    it "return the bin from a card" do
      create_card = CreateCard.new number: 5555555555554444

      expect(create_card.bin).to eq("555555")
    end
  end

  describe "#brand" do
    it "returns MC if the card es master card" do
      create_card = CreateCard.new number: 5555555555554444

      expect(create_card.brand).to eq("MC")
    end

    it "returns VISA if the card es visa" do
      create_card = CreateCard.new number: 4012888888881881

      expect(create_card.brand).to eq("VISA")
    end

    it "returns AMEX if the card is american express" do
      create_card = CreateCard.new number: 378282246310005

      expect(create_card.brand).to eq("AMEX")
    end
  end
end
