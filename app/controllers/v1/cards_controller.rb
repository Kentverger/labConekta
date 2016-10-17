class V1::CardsController < ApplicationController
  def create
    createCard = CreateCard.new card_params

    if createCard.save
      render json: createCard.card, status: 200
    else
      render json: {
        errors: createCard.errors.full_messages
      }, status: 500
    end
  end

  private

  def card_params
    params.permit(:name, :number, :cvv, :experiation_month, :experiation_year,
                   :customer_id)
  end
end
