class V1::CardsController < ApplicationController
  def create
    card = CreateCard.new card_params

    if card.save
      render json: card, status: 200
    else
      render json: {
        errors: card.errors.full_messages
      }, status: 500
    end
  end

  private

  def card_params
    params.permit(:name, :number, :cvv, :experiation_month, :experiation_year,
                   :customer_id)
  end
end
