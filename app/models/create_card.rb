class CreateCard
  include ActiveModel::Model

  validates :name, presence: true
  validates :number, presence: true, length: { in: 15..16 }
  validates :cvv, presence: true, length: { in: 3..4 }
  validates :experiation_month, presence: true
  validates :experiation_year, presence: true
  validates :customer_id, presence: true
  validate :valid_card_number
  validate :valid_experiation_year
  validate :valid_experiation_month

  attr_accessor :name, :number, :cvv, :experiation_month, :experiation_year,
                :customer_id

  def save
    if valid?
      @card = Card.new

      @card.name = name
      @card.bin = bin
      @card.last_four = last_four
      @card.brand = brand
      @card.status = "active"
      @card.expiration_month = experiation_month
      @card.expiration_year = experiation_year

      @card.save
    end
  end

  def valid_card_number
    if brand == nil
      errors.add "Number", "is invalid"
    end
  end

  def valid_experiation_year
    if experiation_year.to_i < Time.now.year
      errors.add "Year", "is the past"
    end
  end

  def valid_experiation_month
    if experiation_month.to_i < 1 || experiation_month.to_i > 12
      errors.add "Month", "is invalid"
    end
  end

  def brand
    if !!(number.to_s =~ /^4[0-9]{6,}$/)
      return "VISA"
    elsif !!(number.to_s =~ /^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$/)
      return "MC"
    elsif !!(number.to_s =~ /^3[47][0-9]{5,}$/)
      return "AMEX"
    end

    nil
  end

  def last_four
    number.to_s[-4, 4]
  end

  def bin
    number.to_s[0, 6]
  end
end
