class AddTokenToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :token, :string
  end
end
