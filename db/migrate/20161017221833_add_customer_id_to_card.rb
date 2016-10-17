class AddCustomerIdToCard < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :customer, foreign_key: true
  end
end
